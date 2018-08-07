//
//  RequestError.swift
//  MoviesApp
//
//  Created by Kamil Waszkiewicz on 07.08.2018.
//  Copyright © 2018 kamil. All rights reserved.
//

import Foundation
import Localize_Swift

enum RequestError: Error {
    // No Internet connection.
    case NotConnectedToInternet(description: String)
    // Incorrect data returned.
    case IncorrectDataReturned
    // Incorrect model mapping.
    case IncorrectModelMapping
    // Resource not found.
    case ResourceNotFound
    // Unauthorized.
    case Unauthorized
    // Unknown server error.
    case UnknownServerResponse
    // Not supported error.
    case Unsupported(description: String)
    
    internal init(code: Int, description: String) {
        switch code {
        case 401:
            self = .Unauthorized
        case 404:
            self = .ResourceNotFound
        case 500:
            self = .UnknownServerResponse
        case NSURLErrorNotConnectedToInternet:
            self = .NotConnectedToInternet(description: description)
        default:
            self = .Unsupported(description: description)
        }
    }
}

extension RequestError: LocalizedError {
    public var errorDescription: String? {
        let text: String
        switch self {
        case .UnknownServerResponse:
            text = "error.unknown".localized()
        case .NotConnectedToInternet(let description):
            text = description
        case .IncorrectDataReturned:
            text = "error.incorrect.data".localized()
        case .IncorrectModelMapping:
            text = "error.incorrect.mapping".localized()
        case .ResourceNotFound:
            text = "error.resource.not.found".localized()
        case .Unauthorized:
            text = "error.unauthorized".localized()
        case .Unsupported(let description):
            text = description
        }
        return text
    }
}
