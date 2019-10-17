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
    var shown: Bool
    var image: String
    
    // 1 | Initializer
    init(id: Int?, shown: Bool, image: String) {
        self.id = id
        self.shown = false
        self.image = image
    }
    // 2 | Initializer
    init(shown: Bool, image: String) {
        self.shown = false
        self.image = image
    }
    
    // 3 | Initializer
    init(id: Int) {
        self.id = id
        self.shown = false
        self.image = ""
    }
    
    
    // JSON -> Model
    public init(map: Map) throws {
        self.id = try map.value("id")
        self.shown = try map.value("shown")
        self.image = try map.value("image")
    }
    
    // Model -> JSON
    public func mapping(map: Map) {
        id >>> (map["id"])
        shown >>> map["shown"]
        image >>> map["image"]
    }
}
