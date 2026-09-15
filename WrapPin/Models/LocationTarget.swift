import CoreLocation

struct LocationTarget: Codable, Hashable, Identifiable, Sendable {
    let name: String
    let subtitle: String
    let latitude: Double
    let longitude: Double

    var id: String {
        "\(latitude.bitPattern)-\(longitude.bitPattern)"
    }

    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }

    var usesGenericMapName: Bool {
        let genericNames: Set<String> = [
            "Dropped Pin",
            "地图选点",
            "Entered Location",
            "坐标位置"
        ]
        return genericNames.contains(name.trimmingCharacters(in: .whitespacesAndNewlines))
    }

    var needsAddressRefresh: Bool {
        let detail = subtitle.trimmingCharacters(in: .whitespacesAndNewlines)
        let unresolvedDetails: Set<String> = [
            "Selected from the map",
            "从地图选择",
            "Entered using coordinates",
            "通过经纬度输入",
            "Finding nearby address…",
            "正在查找附近地址…",
            "Location details unavailable",
            "暂无地点详情"
        ]

        return unresolvedDetails.contains(detail)
            || detail.hasPrefix("Address unavailable · ")
            || detail.hasPrefix("未找到详细地址 · ")
    }
}
