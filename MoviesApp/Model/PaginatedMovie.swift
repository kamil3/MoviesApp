//
//  PaginatedMovie.swift
//
//  Created by Kamil Waszkiewicz on 08/08/2018
//  Copyright (c) . All rights reserved.
//

import ObjectMapper

public struct PaginatedMovie: Mappable {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let totalResults = "total_results"
    static let page = "page"
    static let results = "results"
    static let totalPages = "total_pages"
  }

  // MARK: Properties
  public var totalResults: Int?
  public var page: Int?
  public var results: [Movie]?
  public var totalPages: Int?

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
    totalResults <- map[SerializationKeys.totalResults]
    page <- map[SerializationKeys.page]
    results <- map[SerializationKeys.results]
    totalPages <- map[SerializationKeys.totalPages]
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = totalResults { dictionary[SerializationKeys.totalResults] = value }
    if let value = page { dictionary[SerializationKeys.page] = value }
    if let value = results { dictionary[SerializationKeys.results] = value.map { $0.dictionaryRepresentation() } }
    if let value = totalPages { dictionary[SerializationKeys.totalPages] = value }
    return dictionary
  }

}
