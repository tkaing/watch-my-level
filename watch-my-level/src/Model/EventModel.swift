import Foundation
import ObjectMapper

public struct Event : ImmutableMappable {
    
    var id: Int?
    var title: String;
    var description: String;
    var link: String;
    
    // 1 | Initializer
    init(id: Int?, title: String, description: String, link: String) {
        self.id = id
        self.title = title
        self.description = description
        self.link = link
    }
    // 2 | Initializer
    init(title: String, description: String, link: String) {
        self.title = title
        self.description = description
        self.link = link
    }
    
    
    // JSON -> Model
    public init(map: Map) throws {
        self.id = try map.value("id")
        self.title = try map.value("title")
        self.description = try map.value("description")
        self.link = try map.value("link")
    }
    
    // Model -> JSON
    public func mapping(map: Map) {
        id >>> (map["id"])
        title >>> map["title"]
        description >>> map["description"]
        link >>> map["link"]
    }
    
}
