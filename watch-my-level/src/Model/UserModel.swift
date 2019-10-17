import Foundation
import ObjectMapper

public struct User: ImmutableMappable {
    
    var id: Int?
    var username: String
    var password: String
    
    // 1 | Initializer
    init(id: Int?, username: String, password: String) {
        self.id = id
        self.username = username
        self.password = password
    }
    // 2 | Initializer
    init(username: String, password: String) {
        self.username = username
        self.password = password
    }
    
    
    // JSON -> Model
    public init(map: Map) throws {
        self.id = try map.value("id")
        self.username = try map.value("username")
        self.password = try map.value("password")
    }
    
    // Model -> JSON
    public func mapping(map: Map) {
        id >>> (map["id"])
        username >>> map["username"]
        password >>> map["password"]
    }
    
}
