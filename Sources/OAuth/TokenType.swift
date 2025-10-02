//
//  TokenType.swift
//  OAuth
//
//  Created by Alsey Coleman Miller on 10/1/25.
//

/// Token Type
public enum TokenType: String, Codable, CaseIterable, Sendable {
    
    case bearer = "Bearer"
    case mac = "MAC"
    case pop = "PoP"
}
