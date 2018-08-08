//
//  Movie.swift
//
//  Created by Kamil Waszkiewicz on 08/08/2018
//  Copyright (c) . All rights reserved.
//

import ObjectMapper

public struct Movie: Mappable {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let posterPath = "poster_path"
    static let revenue = "revenue"
    static let voteCount = "vote_count"
    static let overview = "overview"
    static let originalTitle = "original_title"
    static let popularity = "popularity"
    static let runtime = "runtime"
    static let id = "id"
    static let originalLanguage = "original_language"
    static let releaseDate = "release_date"
    static let status = "status"
    static let voteAverage = "vote_average"
    static let title = "title"
    static let tagline = "tagline"
    static let homepage = "homepage"
    static let adult = "adult"
  }

  // MARK: Properties
  public var posterPath: String?
  public var revenue: Int?
  public var voteCount: Int?
  public var overview: String?
  public var originalTitle: String?
  public var popularity: Float?
  public var runtime: Int?
  public var id: Int?
  public var originalLanguage: String?
  public var releaseDate: String?
  public var status: String?
  public var voteAverage: Float?
  public var title: String?
  public var tagline: String?
  public var homepage: String?
  public var adult: Bool? = false

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
    posterPath <- map[SerializationKeys.posterPath]
    revenue <- map[SerializationKeys.revenue]
    voteCount <- map[SerializationKeys.voteCount]
    overview <- map[SerializationKeys.overview]
    originalTitle <- map[SerializationKeys.originalTitle]
    popularity <- map[SerializationKeys.popularity]
    runtime <- map[SerializationKeys.runtime]
    id <- map[SerializationKeys.id]
    originalLanguage <- map[SerializationKeys.originalLanguage]
    releaseDate <- map[SerializationKeys.releaseDate]
    status <- map[SerializationKeys.status]
    voteAverage <- map[SerializationKeys.voteAverage]
    title <- map[SerializationKeys.title]
    tagline <- map[SerializationKeys.tagline]
    homepage <- map[SerializationKeys.homepage]
    adult <- map[SerializationKeys.adult]
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = posterPath { dictionary[SerializationKeys.posterPath] = value }
    if let value = revenue { dictionary[SerializationKeys.revenue] = value }
    if let value = voteCount { dictionary[SerializationKeys.voteCount] = value }
    if let value = overview { dictionary[SerializationKeys.overview] = value }
    if let value = originalTitle { dictionary[SerializationKeys.originalTitle] = value }
    if let value = popularity { dictionary[SerializationKeys.popularity] = value }
    if let value = runtime { dictionary[SerializationKeys.runtime] = value }
    if let value = id { dictionary[SerializationKeys.id] = value }
    if let value = originalLanguage { dictionary[SerializationKeys.originalLanguage] = value }
    if let value = releaseDate { dictionary[SerializationKeys.releaseDate] = value }
    if let value = status { dictionary[SerializationKeys.status] = value }
    if let value = voteAverage { dictionary[SerializationKeys.voteAverage] = value }
    if let value = title { dictionary[SerializationKeys.title] = value }
    if let value = tagline { dictionary[SerializationKeys.tagline] = value }
    if let value = homepage { dictionary[SerializationKeys.homepage] = value }
    dictionary[SerializationKeys.adult] = adult
    return dictionary
  }

}
