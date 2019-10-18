import Foundation
import ObjectMapper

public struct Product : ImmutableMappable {
    
    var id: Int?
    var label: String
    var description: String
    var price: Int
    
    // 1 | Initializer
    init(id: Int?, label: String, description: String, price: Int) {
        self.id = id
        self.label = label
        self.description = description
        self.price = price
    }
    // 2 | Initializer
    init(label: String, description: String, price: Int) {
        self.label = label
        self.description = description
        self.price = price
    }
    
    
    // JSON -> Model
    public init(map: Map) throws {
        self.id = try map.value("id")
        self.label = try map.value("label")
        self.description = try map.value("description")
        self.price = try map.value("price")
    }
    
    // Model -> JSON
    public func mapping(map: Map) {
        id >>> (map["id"])
        label >>> map["label"]
        description >>> map["description"]
        price >>> map["price"]
    }
    
}
