//
//  APIError.swift
//  QBittorrentClient
//
//  Created by Jack on 2022/05/21.
//

import Foundation

import Foundation

enum APIError: Error, CustomStringConvertible {
    
    case needUpdate
    case badResponse(statusCode: Int)
    case ogError(Error?)
    case parsing(DecodingError?)
    case jsonDecodeError(Error?)
    case unknown
    
    var isUnacceptableError: Bool {
        switch self {
        case .jsonDecodeError(_):
            return false
        default:
            return true
        }
    }
    
    var localizedDescription: String {
        // user feedback
        switch self {
        case .needUpdate, .parsing, .unknown:
            return "Sorry, something went wrong."
        case .badResponse(_):
            return "Sorry, the connection to our server failed."
        case .ogError(let error):
            return error?.localizedDescription ?? "Something went wrong."
        case .jsonDecodeError(let error):
            return error?.localizedDescription ?? "Something went wrong."
        }
    }
    
    var description: String {
        //info for debugging
        switch self {
        case .unknown: return "unknown error"
        case .needUpdate: return "cookies need update"
        case .ogError(let error):
            return error?.localizedDescription ?? "url session error"
        case .parsing(let error):
            return "parsing error \(error?.localizedDescription ?? "")"
        case .badResponse(statusCode: let statusCode):
            return "bad response with status code \(statusCode)"
        case .jsonDecodeError(let error):
            return "json decode error: \(error?.localizedDescription ?? "null")"
        }
    }
}
