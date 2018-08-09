//
//  AlternativeTitle.swift
//
//  Created by Kamil Waszkiewicz on 09/08/2018
//  Copyright (c) . All rights reserved.
//

import ObjectMapper

public struct AlternativeTitle: Mappable {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let type = "type"
    static let title = "title"
    static let iso31661 = "iso_3166_1"
  }

  // MARK: Properties
  public var type: String?
  public var title: String?
  public var iso31661: String?

  // MARK: ObjectMapper Initializers
  /// Map a JSON object to this class using ObjectMapper.
  ///
  /// - parameter map: A mapping from ObjectMapper.
  public init?(map: Map){

  }

  /// Map a JSON object to this class using ObjectMapper.
  ///
  /// - parameter map: A mapping from ObjectMapper.
  public mutating func mapping(map: Map) {
    type <- map[SerializationKeys.type]
    title <- map[SerializationKeys.title]
    iso31661 <- map[SerializationKeys.iso31661]
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = type { dictionary[SerializationKeys.type] = value }
    if let value = title { dictionary[SerializationKeys.title] = value }
    if let value = iso31661 { dictionary[SerializationKeys.iso31661] = value }
    return dictionary
  }

}
