//
//  URLRequest.swift
//  OAuth
//
//  Created by Alsey Coleman Miller on 10/1/25.
//

import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif
import HTTP

internal extension URLRequest {
    
    mutating func setFormURLEncoded(_ queryItems: [URLQueryItem]) {
        let data = queryItems.formURLEncoded()
        let contentLength = data.count
        self.httpBody = data
        self.setValue(String(contentLength), forHTTPHeaderField: "Content-Length")
        self.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
    }
}
