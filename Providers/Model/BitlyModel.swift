//
//  BitlyModel.swift
//  ShortURL
//
//  Created by Ankur on 17/5/21.
//

import Foundation

struct BitlyPostBody: Codable {
    let longURL: String
    
    enum CodingKeys: String, CodingKey {
        case longURL = "long_url"
    }
}


struct BitlyResponseModel: Codable {
    let link: String?
    let id: String?
    let longURL: String?
    
    enum CodingKeys: String, CodingKey {
        case link, id
        case longURL = "long_url"
    }
}

//{
//  "references": { "any" },
//  "link": "string",
//  "id": "string",
//  "long_url": "string",
//  "archived": "boolean",
//  "created_at": "string",
//  "custom_bitlinks": [
//    "string"
//  ],
//  "tags": [
//    "string"
//  ],
//  "deeplinks": [
//    {
//      "guid": "string",
//      "bitlink": "string",
//      "app_uri_path": "string",
//      "install_url": "string",
//      "app_guid": "string",
//      "os": "string",
//      "install_type": "string",
//      "created": "string",
//      "modified": "string",
//      "brand_guid": "string"
//    }
//  ]
//}
