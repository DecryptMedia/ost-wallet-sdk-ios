//
//  OstResetPinPollingService.swift
//  OstSdk
//
//  Created by Deepesh Kumar Nath on 01/03/19.
//  Copyright © 2019 aniket ayachit. All rights reserved.
//

import Foundation

class OstResetPinPollingService: OstBasePollingService {
    
    let successCallback: ((OstRecoveryOwnerEntity) -> Void)?
    let recoveryOwnerAddress: String

    init(
        userId: String,
        recoveryOwnerAddress: String,
        workflowTransactionCount: Int,
        successCallback: ((OstRecoveryOwnerEntity) -> Void)?,
        failureCallback: ((OstError) -> Void)?) {
        
        self.recoveryOwnerAddress = recoveryOwnerAddress
        self.successCallback = successCallback
        
        super.init(
            userId: userId,
            workflowTransactionCount: workflowTransactionCount,
            failureCallback: failureCallback
        )
    }
    
    override func onSuccessProcess(entity: OstBaseEntity) {
        let recoveryOwnerEntity: OstRecoveryOwnerEntity = entity as! OstRecoveryOwnerEntity
        if (recoveryOwnerEntity.isStatusAuthorized) {
            Logger.log(message: "[\(Date.timestamp())]: Recovery owner entity with address: \(recoveryOwnerEntity.address!) and is authorized.", parameterToPrint: recoveryOwnerEntity.data)
            self.successCallback?(recoveryOwnerEntity)
        } else if (recoveryOwnerEntity.isStatusAuthorizing) {
            Logger.log(message: "[\(Date.timestamp())]: Recovery owner entity with address: \(recoveryOwnerEntity.address!) and is authorizing.", parameterToPrint: recoveryOwnerEntity.data)
            self.getEntityAfterDelay()
        } else {
            self.failureCallback?(OstError("w_s_rpps_1", OstErrorText.transactionFailed))
        }
    }
    
    override func fetchEntity() throws {
        try OstAPIResetPin(userId: self.userId)
            .getRecoverOwner(
                recoveryOwnerAddress: self.recoveryOwnerAddress,
                onSuccess: self.onSuccess,
                onFailure: self.onFailure)
    }
}
