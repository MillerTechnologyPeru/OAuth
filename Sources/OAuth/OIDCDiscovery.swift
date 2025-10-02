//
//  OIDCDiscovery.swift
//  OAuth
//
//  Created by Alsey Coleman Miller on 10/1/25.
//

import Foundation

/// OpenID Connect (OIDC) Discovery Document
///
/// It describes all the endpoints, supported features, and capabilities of the identity provider.
public struct OIDCDiscovery: Codable {
    
    public let issuer: String
    
    public let authorizationEndpoint: URL
    
    public let tokenEndpoint: URL
    
    public let deviceAuthorizationEndpoint: URL?
    
    public let userinfoEndpoint: URL?
    
    public let mfaChallengeEndpoint: URL?
    
    public let jwksUri: URL
    
    public let registrationEndpoint: URL?
    
    public let revocationEndpoint: URL?
    
    public let scopesSupported: [String]
    
    public let responseTypesSupported: [String]
    
    public let codeChallengeMethodsSupported: [String]
    
    public let responseModesSupported: [String]
    
    public let subjectTypesSupported: [String]
    
    public let tokenEndpointAuthMethodsSupported: [String]
    
    public let tokenEndpointAuthSigningAlgValuesSupported: [String]
    
    public let claimsSupported: [String]
    
    public let requestUriParameterSupported: Bool?
    
    public let requestParameterSupported: Bool?
    
    public let idTokenSigningAlgValuesSupported: [String]
    
    public let backchannelLogoutSupported: Bool?
    
    public let backchannelLogoutSessionSupported: Bool?
    
    public let backchannelAuthenticationEndpoint: URL?
    
    public let backchannelTokenDeliveryModesSupported: [String]?
    
    public let globalTokenRevocationEndpoint: URL?
    
    public let globalTokenRevocationEndpointAuthMethodsSupported: [String]?

    enum CodingKeys: String, CodingKey {
        case issuer
        case authorizationEndpoint = "authorization_endpoint"
        case tokenEndpoint = "token_endpoint"
        case deviceAuthorizationEndpoint = "device_authorization_endpoint"
        case userinfoEndpoint = "userinfo_endpoint"
        case mfaChallengeEndpoint = "mfa_challenge_endpoint"
        case jwksUri = "jwks_uri"
        case registrationEndpoint = "registration_endpoint"
        case revocationEndpoint = "revocation_endpoint"
        case scopesSupported = "scopes_supported"
        case responseTypesSupported = "response_types_supported"
        case codeChallengeMethodsSupported = "code_challenge_methods_supported"
        case responseModesSupported = "response_modes_supported"
        case subjectTypesSupported = "subject_types_supported"
        case tokenEndpointAuthMethodsSupported = "token_endpoint_auth_methods_supported"
        case tokenEndpointAuthSigningAlgValuesSupported = "token_endpoint_auth_signing_alg_values_supported"
        case claimsSupported = "claims_supported"
        case requestUriParameterSupported = "request_uri_parameter_supported"
        case requestParameterSupported = "request_parameter_supported"
        case idTokenSigningAlgValuesSupported = "id_token_signing_alg_values_supported"
        case backchannelLogoutSupported = "backchannel_logout_supported"
        case backchannelLogoutSessionSupported = "backchannel_logout_session_supported"
        case backchannelAuthenticationEndpoint = "backchannel_authentication_endpoint"
        case backchannelTokenDeliveryModesSupported = "backchannel_token_delivery_modes_supported"
        case globalTokenRevocationEndpoint = "global_token_revocation_endpoint"
        case globalTokenRevocationEndpointAuthMethodsSupported = "global_token_revocation_endpoint_auth_methods_supported"
    }
}
