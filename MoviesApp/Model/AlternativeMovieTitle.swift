//
//  AlternativeMovieTitle.swift
//
//  Created by Kamil Waszkiewicz on 09/08/2018
//  Copyright (c) . All rights reserved.
//

import ObjectMapper

public struct AlternativeMovieTitle: Mappable {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let id = "id"
    static let titles = "titles"
  }

  // MARK: Properties
  public var id: Int?
  public var titles: [AlternativeTitle]?

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
    id <- map[SerializationKeys.id]
    titles <- map[SerializationKeys.titles]
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = id { dictionary[SerializationKeys.id] = value }
    if let value = titles { dictionary[SerializationKeys.titles] = value.map { $0.dictionaryRepresentation() } }
    return dictionary
  }

}
