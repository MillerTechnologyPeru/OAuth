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
        self.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        // https://url.spec.whatwg.org/#concept-urlencoded-serializer
        let output = queryItems.lazy
            .map { ($0.name, $0.value ?? "") }
            .map { ($0.formURLEncoded(), $1.formURLEncoded()) }
            .map { "\($0)=\($1)" }
            .joined(separator: "&")
        let data = output.data(using: .utf8)
        self.httpBody = data
        if let contentLength = data?.count {
            self.setValue(String(contentLength), forHTTPHeaderField: "Content-Length")
        }
    }
}
