//
//  MappingDataObject.swift
//  MoviesApp
//
//  Created by Kamil Waszkiewicz on 07.08.2018.
//  Copyright © 2018 kamil. All rights reserved.
//

import Foundation
import ObjectMapper

protocol MappingDataObjectProtocol {
    func map<T: Mappable>(withData data: Data) -> [T]?
}

struct MappingDataObject: MappingDataObjectProtocol {
    func map<T: Mappable>(withData data: Data) -> [T]? {
        guard let JSONObject = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) else {
            return nil
        }
        if let array = JSONObject as? [[String: Any]] {
            let model = Mapper<T>().mapArray(JSONArray: array)
            return model
        } else if let dict = JSONObject as? [String: Any] {
            if let model = Mapper<T>().map(JSONObject: dict) {
                return [model]
            } else {
                return nil
            }
        } else {
            return []
        }
    }
}
