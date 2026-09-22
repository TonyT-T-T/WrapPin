import Foundation

struct SimulationCoordinates: Equatable, Sendable {
    let latitude: Double
    let longitude: Double

    init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }

    init(_ target: LocationTarget) {
        self.init(latitude: target.latitude, longitude: target.longitude)
    }
}

/// A bounded, fixed-location trial around Suzhou Center. Other places and route
/// points retain their existing numeric behavior until their source is measured.
enum SuzhouCoordinateCorrection {
    private static let trialLatitude = 31.316633
    private static let trialLongitude = 120.677664
    private static let trialRadiusInDegrees = 0.05
    private static let semiMajorAxis = 6_378_245.0
    private static let eccentricitySquared = 0.00669342162296594323

    static func forFixedTarget(_ target: LocationTarget) -> SimulationCoordinates {
        let original = SimulationCoordinates(target)
        guard
            abs(target.latitude - trialLatitude) <= trialRadiusInDegrees,
            abs(target.longitude - trialLongitude) <= trialRadiusInDegrees
        else { return original }

        // Solve forward(WGS84) = selected map coordinate. The correction varies
        // by location, so a constant latitude/longitude offset is insufficient.
        var candidate = original
        for _ in 0..<8 {
            let projected = wgs84ToGCJ02(candidate)
            let latitudeError = projected.latitude - original.latitude
            let longitudeError = projected.longitude - original.longitude
            candidate = SimulationCoordinates(
                latitude: candidate.latitude - latitudeError,
                longitude: candidate.longitude - longitudeError
            )
            if max(abs(latitudeError), abs(longitudeError)) < 0.000000001 { break }
        }
        return candidate
    }

    private static func wgs84ToGCJ02(_ coordinate: SimulationCoordinates) -> SimulationCoordinates {
        let x = coordinate.longitude - 105.0
        let y = coordinate.latitude - 35.0
        var latitudeDelta = latitudeTransform(x: x, y: y)
        var longitudeDelta = longitudeTransform(x: x, y: y)
        let radianLatitude = coordinate.latitude / 180.0 * .pi
        let sine = sin(radianLatitude)
        let magic = 1.0 - eccentricitySquared * sine * sine
        let root = sqrt(magic)
        latitudeDelta = latitudeDelta * 180.0 /
            ((semiMajorAxis * (1.0 - eccentricitySquared)) / (magic * root) * .pi)
        longitudeDelta = longitudeDelta * 180.0 /
            (semiMajorAxis / root * cos(radianLatitude) * .pi)
        return SimulationCoordinates(
            latitude: coordinate.latitude + latitudeDelta,
            longitude: coordinate.longitude + longitudeDelta
        )
    }

    private static func latitudeTransform(x: Double, y: Double) -> Double {
        var value = -100.0 + 2.0 * x + 3.0 * y + 0.2 * y * y
            + 0.1 * x * y + 0.2 * sqrt(abs(x))
        value += (20.0 * sin(6.0 * x * .pi) + 20.0 * sin(2.0 * x * .pi)) * 2.0 / 3.0
        value += (20.0 * sin(y * .pi) + 40.0 * sin(y / 3.0 * .pi)) * 2.0 / 3.0
        value += (160.0 * sin(y / 12.0 * .pi) + 320.0 * sin(y * .pi / 30.0)) * 2.0 / 3.0
        return value
    }

    private static func longitudeTransform(x: Double, y: Double) -> Double {
        var value = 300.0 + x + 2.0 * y + 0.1 * x * x
            + 0.1 * x * y + 0.1 * sqrt(abs(x))
        value += (20.0 * sin(6.0 * x * .pi) + 20.0 * sin(2.0 * x * .pi)) * 2.0 / 3.0
        value += (20.0 * sin(x * .pi) + 40.0 * sin(x / 3.0 * .pi)) * 2.0 / 3.0
        value += (150.0 * sin(x / 12.0 * .pi) + 300.0 * sin(x / 30.0 * .pi)) * 2.0 / 3.0
        return value
    }
}
