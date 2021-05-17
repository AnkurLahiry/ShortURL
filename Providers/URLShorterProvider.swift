//
//  URLShorterProvider.swift
//  ShortURL
//
//  Created by Ankur on 17/5/21.
//

import Foundation

public enum URLShorterProvider {
    case bitly(_ authorizatioKey: String, longURL: String)
}

extension URLShorterProvider: URLListProtocol {
    var providerURL: URLList? {
        switch self {
        case .bitly:
            return .bitly
        }
    }
}

protocol URLListProtocol {
    var providerURL: URLList? { get }
}

enum URLList: String {
    case bitly = "https://api-ssl.bitly.com/v4/shorten"
}
