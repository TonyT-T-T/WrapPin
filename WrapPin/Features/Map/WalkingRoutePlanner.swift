import CoreLocation
import MapKit
import Observation

enum RouteMode: String, Codable, CaseIterable, Identifiable {
    case walking
    case driving

    var id: Self { self }
    var transportType: MKDirectionsTransportType {
        self == .walking ? .walking : .automobile
    }
    var title: String {
        self == .walking ? String(localized: "Walking route") : String(localized: "Driving route")
    }
    var symbol: String { self == .walking ? "figure.walk" : "car.fill" }
}

@MainActor
@Observable
final class WalkingRoutePlanner {
    private(set) var route: MKRoute?
    private(set) var destination: LocationTarget?
    private(set) var mode: RouteMode = .walking
    private(set) var isLoading = false
    private(set) var errorMessage: String?

    @ObservationIgnored
    private var directions: MKDirections?

    func preview(
        to target: LocationTarget,
        from source: LocationTarget? = nil,
        mode: RouteMode = .walking
    ) async -> MKRoute? {
        directions?.cancel()
        route = nil
        destination = target
        self.mode = mode
        errorMessage = nil
        isLoading = true

        let request = MKDirections.Request()
        if let source {
            request.source = MKMapItem(
                location: CLLocation(latitude: source.latitude, longitude: source.longitude),
                address: nil
            )
        } else {
            request.source = .forCurrentLocation()
        }
        request.destination = MKMapItem(
            location: CLLocation(latitude: target.latitude, longitude: target.longitude),
            address: nil
        )
        request.transportType = mode.transportType
        request.requestsAlternateRoutes = false

        let calculation = MKDirections(request: request)
        directions = calculation

        defer {
            if directions === calculation {
                directions = nil
                isLoading = false
            }
        }

        do {
            let response = try await calculation.calculate()
            guard directions === calculation else { return nil }
            guard let preferredRoute = response.routes.first else {
                errorMessage = mode == .walking
                    ? String(localized: "No walking route was found for this destination.")
                    : String(localized: "No driving route was found for this destination.")
                return nil
            }

            route = preferredRoute
            return preferredRoute
        } catch is CancellationError {
            return nil
        } catch {
            guard directions === calculation else { return nil }
            errorMessage = mode == .walking
                ? String(localized: "Walking directions are unavailable. Check Location access and your internet connection, then try again.")
                : String(localized: "Driving directions are unavailable. Check Location access and your internet connection, then try again.")
            return nil
        }
    }

    func clear() {
        directions?.cancel()
        directions = nil
        route = nil
        destination = nil
        mode = .walking
        isLoading = false
        errorMessage = nil
    }

    func retargetExistingRoute(to target: LocationTarget) {
        guard route != nil else { return }
        destination = target
        errorMessage = nil
    }
}
