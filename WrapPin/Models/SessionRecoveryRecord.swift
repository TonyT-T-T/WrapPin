import Foundation

struct SessionRecoveryRecord: Codable, Equatable {
    enum Kind: String, Codable {
        case fixedLocation
        case walkingRoute
        case drivingRoute
    }

    var kind: Kind
    var lastReportedLocation: LocationTarget
    var destination: LocationTarget?
    var fixedCoordinateMode: FixedCoordinateMode?
    var walkingPaceMetresPerSecond: Double?
    var routeSpeedMetresPerSecond: Double?
    let startedAt: Date
    var updatedAt: Date

    var isRoute: Bool {
        (kind == .walkingRoute || kind == .drivingRoute) && destination != nil
    }

    var routeMode: RouteMode {
        kind == .drivingRoute ? .driving : .walking
    }

    var savedRouteSpeed: Double? {
        routeSpeedMetresPerSecond ?? walkingPaceMetresPerSecond
    }

    static func fixed(
        at target: LocationTarget,
        mode: FixedCoordinateMode
    ) -> SessionRecoveryRecord {
        SessionRecoveryRecord(
            kind: .fixedLocation,
            lastReportedLocation: target,
            destination: nil,
            fixedCoordinateMode: mode,
            walkingPaceMetresPerSecond: nil,
            routeSpeedMetresPerSecond: nil,
            startedAt: .now,
            updatedAt: .now
        )
    }

    static func route(
        from start: LocationTarget,
        to destination: LocationTarget,
        mode: RouteMode,
        speedMetresPerSecond: Double
    ) -> SessionRecoveryRecord {
        SessionRecoveryRecord(
            kind: mode == .walking ? .walkingRoute : .drivingRoute,
            lastReportedLocation: start,
            destination: destination,
            fixedCoordinateMode: nil,
            walkingPaceMetresPerSecond: nil,
            routeSpeedMetresPerSecond: speedMetresPerSecond,
            startedAt: .now,
            updatedAt: .now
        )
    }
}
