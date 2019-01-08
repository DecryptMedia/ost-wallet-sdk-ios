//
//  OSTMultiSigWalletEntity.swift
//  OstSdk
//
//  Created by aniket ayachit on 10/12/18.
//  Copyright © 2018 aniket ayachit. All rights reserved.
//

import Foundation

public class OSTMultiSigWallet: OSTBaseEntity {
    init(jsonData: [String: Any])throws {
        super.init()
        let (isValidJSON, errorString): (Bool, String?) = validJSON(jsonData)
        if !isValidJSON{
            throw EntityErrors.validationError("Invalid JSON passed. error:\(errorString!)")
        }
        setJsonValues(jsonData)
    }
}

public extension OSTMultiSigWallet {
    var local_entity_id : String? {
        return data["local_entity_id"] as? String ?? nil
    }
    
    var address : String? {
        return data["address"] as? String ?? nil
    }
    
    var multi_sig_id : String? {
        return data["multi_sig_id"] as? String ?? nil
    }
    
    var status : String? {
        return data["status"] as? String ?? nil
    }
    
    var user_id : String? {
        return data["user_id"] as? String ?? nil
    }
}
