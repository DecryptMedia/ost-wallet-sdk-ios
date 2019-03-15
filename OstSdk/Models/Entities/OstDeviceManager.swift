/*
 Copyright © 2019 OST.com Inc
 
 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at
 
 http://www.apache.org/licenses/LICENSE-2.0
 */

import Foundation

public class OstDeviceManager: OstBaseEntity {
    /// Entity identifier for user entity
    static let ENTITY_IDENTIFIER = "address"
    
    /// Parent entity identifier for user entity
    static let ENTITY_PARENT_IDENTIFIER = "user_id"
    
    /// Store OstDeviceManager entity data in the data base and returns the OstDeviceManager model object
    ///
    /// - Parameter entityData: Entity data dictionary
    /// - Throws: OSTError
    class func storeEntity(_ entityData: [String: Any?]) throws {
        return try OstDeviceManagerRepository
            .sharedDeviceManager
            .insertOrUpdate(
                entityData,
                forIdentifierKey: ENTITY_IDENTIFIER
            )
    }
    
    /// Get OstDeviceManager object from given device address
    ///
    /// - Parameter address: Device address
    /// - Returns: OstDeviceManager model object
    /// - Throws: OSTError
    class func getById(_ address: String) throws -> OstDeviceManager? {
        return try OstDeviceManagerRepository.sharedDeviceManager.getById(address) as? OstDeviceManager
    }
    
    /// Get key identifier for id
    ///
    /// - Returns: Key identifier for id
    override func getIdKey() -> String {
        return OstDeviceManager.ENTITY_IDENTIFIER
    }
    
    /// Get key identifier for parent id
    ///
    /// - Returns: Key identifier for parent id
    override func getParentIdKey() -> String {
        return OstDeviceManager.ENTITY_PARENT_IDENTIFIER
    }
    
    /// Increment nonce value and store it in DB
    ///
    /// - Parameter nonce: Nonce value
    /// - Throws: OSTError
    func incrementNonce() throws {
        var updatedData: [String: Any?] = self.data
        updatedData["nonce"] = OstUtils.toString(self.nonce+1)
        updatedData["updated_timestamp"] = OstUtils.toString(Date.timestamp())
        _ = try OstDeviceManager.storeEntity(updatedData)
    }
}

public extension OstDeviceManager {
    /// Get user id
    var userId : String? {
        return data["user_id"] as? String
    }
    
    /// Ger device address
    var address : String? {
        return data["address"] as? String
    }
    
    /// Get device nonce
    var nonce: Int {
        return OstUtils.toInt(data["nonce"] as Any?) ?? 0
    }
    
    /// Get token holder id
    var tokenHolderId : String? {
        return data["token_holder_id"] as? String
    }
    
    /// Get wallets
    var wallets : Array<String>? {
        return data["wallets"] as? Array<String>
    }
    
    /// Get requirement
    var requirement: String? {        
        return OstUtils.toString(data["requirement"] as Any)
    }
    
    /// Get authorize session call prefix
    var authorizeSessionCallPrefix: String? {
        return data["authorize_session_callprefix"] as? String
    }
}
