struct Event: Codable {
    var title: String
    var catchCopy: String
    var eventUrl: String
    var startedAt: String
    
    enum CodingKeys: String, CodingKey {
        case title
        case catchCopy = "catch"
        case eventUrl = "event_url"
        case startedAt = "started_at"
    }
}

struct Response: Codable {
    var events: [Event]
}

