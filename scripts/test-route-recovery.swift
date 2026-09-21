import Foundation

// Compile with the production SessionRecoveryRecord.swift to verify persisted JSON compatibility.
enum RouteMode: String, Codable { case walking, driving }
struct LocationTarget: Codable, Equatable { let name: String }

@main
struct RouteRecoveryCheck {
    static func main() throws {
        let decoder = JSONDecoder()
        let legacy = """
        {"kind":"walkingRoute","lastReportedLocation":{"name":"Start"},"destination":{"name":"End"},"walkingPaceMetresPerSecond":1.4,"startedAt":0,"updatedAt":0}
        """.data(using: .utf8)!
        let oldWalk = try decoder.decode(SessionRecoveryRecord.self, from: legacy)
        precondition(oldWalk.isRoute && oldWalk.routeMode == .walking)
        precondition(oldWalk.savedRouteSpeed == 1.4)

        let driving = SessionRecoveryRecord.route(
            from: LocationTarget(name: "Start"),
            to: LocationTarget(name: "End"),
            mode: .driving,
            speedMetresPerSecond: 100 / 3.6
        )
        let restored = try decoder.decode(
            SessionRecoveryRecord.self,
            from: JSONEncoder().encode(driving)
        )
        precondition(restored.kind == .drivingRoute && restored.routeMode == .driving)
        precondition(abs((restored.savedRouteSpeed ?? 0) * 3.6 - 100) < 0.0001)
        print("Route recovery: legacy walking and new driving records passed")
    }
}
