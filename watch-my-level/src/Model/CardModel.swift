//
//  CardModel.swift
//  watch-my-level
//
//  Created by DéjàLu on 17/10/2019.
//  Copyright © 2019 wml. All rights reserved.
//

import Foundation
import ObjectMapper

public struct Card: ImmutableMappable, Equatable {
    
    var id: Int?
    var url: String
    
    // 1 | Initializer
    init(id: Int?, url: String) {
        self.id = id
        self.url = url
    }
    // 2 | Initializer
    init(url: String) {
        self.url = url
    }
    // 3 | Initializer
    init(id: Int) {
        self.id = id
        self.url = ""
    }
    
    
    // JSON -> Model
    public init(map: Map) throws {
        self.id = try map.value("id")
        self.url = try map.value("url")
    }
    
    // Model -> JSON
    public func mapping(map: Map) {
        id >>> (map["id"])
        url >>> map["url"]
    }
}
