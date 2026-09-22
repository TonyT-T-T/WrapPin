import CoreLocation
import Foundation
import Observation

struct LocationDiagnosticSample: Sendable {
    let latitude: Double
    let longitude: Double
    let horizontalAccuracy: Double
    let timestamp: Date
    let isSimulatedBySoftware: Bool?
}

/// Opt-in, foreground-only probe. Samples stay in memory and are cleared when
/// the Connection Health screen closes; nothing is persisted or sent to analytics.
@MainActor
@Observable
final class LocationAccuracyProbe: NSObject, @preconcurrency CLLocationManagerDelegate {
    private(set) var isRunning = false
    private(set) var sample: LocationDiagnosticSample?
    private(set) var message: String?

    private let manager = CLLocationManager()
    private var startedAt: Date?
    private var updatesStarted = false
    private var timeoutTask: Task<Void, Never>?

    override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.distanceFilter = kCLDistanceFilterNone
        manager.pausesLocationUpdatesAutomatically = false
    }

    func start() {
        stop()
        isRunning = true
        startedAt = Date()

        switch manager.authorizationStatus {
        case .notDetermined:
            manager.requestWhenInUseAuthorization()
        case .authorizedAlways, .authorizedWhenInUse:
            beginUpdates()
        case .denied, .restricted:
            finish(with: "WrapPin 没有定位权限，请检查系统设置。")
        @unknown default:
            finish(with: "定位权限状态无法识别。")
        }
    }

    func stop() {
        manager.stopUpdatingLocation()
        timeoutTask?.cancel()
        timeoutTask = nil
        startedAt = nil
        updatesStarted = false
        isRunning = false
        sample = nil
        message = nil
    }

    private func beginUpdates() {
        guard isRunning, !updatesStarted else { return }
        updatesStarted = true
        manager.startUpdatingLocation()
        timeoutTask = Task { @MainActor [weak self] in
            do {
                try await Task.sleep(for: .seconds(15))
            } catch {
                return
            }
            guard let self, self.isRunning else { return }
            self.finish(with: "15 秒内没有收到新的定位回调。")
        }
    }

    private func finish(with message: String?) {
        manager.stopUpdatingLocation()
        timeoutTask?.cancel()
        timeoutTask = nil
        updatesStarted = false
        isRunning = false
        self.message = message
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        guard isRunning else { return }
        switch manager.authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            beginUpdates()
        case .denied, .restricted:
            finish(with: "WrapPin 没有定位权限，请检查系统设置。")
        case .notDetermined:
            break
        @unknown default:
            finish(with: "定位权限状态无法识别。")
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard isRunning, let startedAt else { return }
        guard let location = locations.last(where: {
            $0.horizontalAccuracy >= 0 && $0.timestamp >= startedAt.addingTimeInterval(-1)
        }) else { return }

        sample = LocationDiagnosticSample(
            latitude: location.coordinate.latitude,
            longitude: location.coordinate.longitude,
            horizontalAccuracy: location.horizontalAccuracy,
            timestamp: location.timestamp,
            isSimulatedBySoftware: location.sourceInformation?.isSimulatedBySoftware
        )
        finish(with: nil)
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        guard isRunning else { return }
        if (error as? CLError)?.code == .locationUnknown {
            return // Keep waiting until the bounded timeout.
        }
        finish(with: "定位读取失败，请检查 WrapPin 的定位权限。")
    }
}
