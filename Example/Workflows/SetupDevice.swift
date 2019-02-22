//
//  RegisterDevice.swift
//  Example
//
//  Created by aniket ayachit on 04/02/19.
//  Copyright © 2019 aniket ayachit. All rights reserved.
//

import Foundation
import OstSdk

class SetupDevice: WorkflowBase {
    
    override init(userId: String, tokenId: String, mappyUserId: String) {
        super.init(userId: userId, tokenId: tokenId, mappyUserId: mappyUserId)
    }
    
    override func perform() throws {
        OstSdk.setupDevice(userId: userId, tokenId: tokenId, delegate: delegate)
    }
}
