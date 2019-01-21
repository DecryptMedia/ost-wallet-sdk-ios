//
//  OstMultiSigOperationEntity.swift
//  OstSdk
//
//  Created by aniket ayachit on 10/12/18.
//  Copyright © 2018 aniket ayachit. All rights reserved.
//

import Foundation

public class OstMultiSigOperation: OstBaseEntity {
    static func parse(_ entityData: [String: Any?]) throws -> OstUser? {
        return try OstMultiSigOperationRepository.sharedMultiSigOperation.insertOrUpdate(entityData, forId: OstUser.getEntityIdentifer()) as? OstUser ?? nil
    }
    
    static func getEntityIdentifer() -> String {
        return "id"
    }
    
    override func getId(_ params: [String: Any]) -> String {
        return OstUtils.toString(params[OstMultiSigOperation.getEntityIdentifer()])!
    }
}


public extension OstMultiSigOperation {
    var local_entity_id : String? {
        return data["local_entity_id"] as? String ?? nil
    }
    
    var user_id : String? {
        return data["user_id"] as? String ?? nil
    }
    
    var token_holder_address : String? {
        return data["token_holder_address"] as? String ?? nil
    }
    
    var kind : String? {
        return data["kind"] as? String ?? nil
    }
    
    var encoded_data : String? {
        return data["encoded_data"] as? String ?? nil
    }
    
    var raw_data : [String: Any]? {
        return data["raw_data"] as? [String: Any] ?? nil
    }
    
    var signatures : [String: String]? {
        return data["signatures"] as? [String: String] ?? nil
    }
}
