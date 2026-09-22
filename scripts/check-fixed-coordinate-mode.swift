import Foundation

// Minimal route mode for compiling the persisted recovery model outside Xcode.
enum RouteMode: String, Codable {
    case walking
    case driving
}

@main
struct FixedCoordinateModeCheck {
    static func main() {
        let suzhou = LocationTarget(
            name: "苏州中心广场",
            subtitle: "苏州市星港街 167 号",
            latitude: 31.316633,
            longitude: 120.677664
        )
        let converted = FixedCoordinateTransform.coordinates(for: suzhou, mode: .gcj02)
        precondition(abs(converted.latitude - 31.318719) < 0.000005)
        precondition(abs(converted.longitude - 120.673397) < 0.000005)
        precondition(FixedCoordinateMode.recommended(for: suzhou) == .gcj02)
        precondition(FixedCoordinateTransform.coordinates(for: suzhou, mode: .wgs84) == SimulationCoordinates(suzhou))

        let overseas = LocationTarget(
            name: "海外对照点",
            subtitle: "",
            latitude: 48.8584,
            longitude: 2.2945
        )
        precondition(FixedCoordinateMode.recommended(for: overseas) == .wgs84)
        precondition(FixedCoordinateTransform.coordinates(for: overseas, mode: .wgs84) == SimulationCoordinates(overseas))

        let recovery = SessionRecoveryRecord.fixed(at: suzhou, mode: .gcj02)
        let encoded = try! JSONEncoder().encode(recovery)
        precondition(try! JSONDecoder().decode(SessionRecoveryRecord.self, from: encoded).fixedCoordinateMode == .gcj02)
        var oldPayload = try! JSONSerialization.jsonObject(with: encoded) as! [String: Any]
        oldPayload.removeValue(forKey: "fixedCoordinateMode")
        let oldData = try! JSONSerialization.data(withJSONObject: oldPayload)
        precondition(try! JSONDecoder().decode(SessionRecoveryRecord.self, from: oldData).fixedCoordinateMode == nil)

        print(String(format: "Suzhou GCJ-02 mode: %.6f, %.6f", converted.latitude, converted.longitude))
        print("WGS84 mode preserves numeric coordinates")
        print("Recovery mode round-trips; legacy recovery still decodes")
    }
}
