import Foundation

@main
struct SuzhouCorrectionCheck {
    static func main() {
        let selected = LocationTarget(
            name: "苏州中心广场",
            subtitle: "苏州市星港街 167 号",
            latitude: 31.316633,
            longitude: 120.677664
        )
        let corrected = SuzhouCoordinateCorrection.forFixedTarget(selected)
        precondition(abs(corrected.latitude - 31.318719) < 0.000005)
        precondition(abs(corrected.longitude - 120.673397) < 0.000005)

        let outside = LocationTarget(
            name: "海外对照点",
            subtitle: "",
            latitude: 48.8584,
            longitude: 2.2945
        )
        precondition(SuzhouCoordinateCorrection.forFixedTarget(outside) == SimulationCoordinates(outside))

        let nearby = LocationTarget(
            name: "附近地图选点",
            subtitle: "",
            latitude: 31.3170,
            longitude: 120.6780
        )
        precondition(SuzhouCoordinateCorrection.forFixedTarget(nearby) != SimulationCoordinates(nearby))
        print(String(format: "Suzhou fixed target: %.6f, %.6f", corrected.latitude, corrected.longitude))
        print("Outside trial area remains unchanged")
    }
}
