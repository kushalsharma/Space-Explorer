//
//  PhotoData.swift
//  Wallmax
//
//  Created by Kushal Sharma on 18/01/17.
//  Copyright © 2017 Kushal. All rights reserved.
//

import Foundation
import RealmSwift
import Realm

class ApodData: Object {
    dynamic var date: String = ""
    dynamic var explanation: String = ""
    dynamic var hdurl: String = ""
    dynamic var mediaType: String = ""
    dynamic var serviceVersion: String = ""
    dynamic var title: String = ""
    dynamic var url: String = ""
    
    required init(realm: RLMRealm, schema: RLMObjectSchema) {
        super.init(realm: realm, schema: schema)
    }
    
    required init(value: Any, schema: RLMSchema) {
        super.init(value: value, schema: schema)
    }
    
    required init() {
        super.init()
    }
}

enum JsonParsingError: Error {
    case unsupportedTypeError
}

extension String {
    init(jsonValue: Any?) throws {
        guard let string = jsonValue as? String else {
            throw JsonParsingError.unsupportedTypeError
        }
        self = string
    }
}

extension ApodData {
    convenience init(jsonValue: Any?) throws {
        self.init()
        guard let dict = jsonValue as? [String: Any] else {
            throw JsonParsingError.unsupportedTypeError
        }
        self.serviceVersion = try String(jsonValue: dict["service_version"])
        self.title = try String(jsonValue: dict["title"])
        self.explanation = try String(jsonValue: dict["explanation"])
        self.mediaType = try String(jsonValue: dict["media_type"])
        self.url = try String(jsonValue: dict["url"])
        self.date = try String(jsonValue: dict["date"])
        self.hdurl = try String(jsonValue: dict["hdurl"])
    }
}

func parseApodDara(jsonValue: Any?) throws -> ApodData {
    return try ApodData(jsonValue: jsonValue)
}

