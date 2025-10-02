//
//  URLQueryItem.swift
//  OAuth
//
//  Created by Alsey Coleman Miller on 10/1/25.
//

import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

internal extension Sequence where Element == URLQueryItem {
    
    func formURLEncoded() -> Data {
        // https://url.spec.whatwg.org/#concept-urlencoded-serializer
        let output = self.lazy
            .map { ($0.name, $0.value ?? "") }
            .map { ($0.formURLEncoded(), $1.formURLEncoded()) }
            .map { "\($0)=\($1)" }
            .joined(separator: "&")
        return Data(output.utf8)
    }
}
