//
//  OstAPIChain.swift
//  OstSdk
//
//  Created by aniket ayachit on 14/02/19.
//  Copyright © 2019 aniket ayachit. All rights reserved.
//

import Foundation

class OstAPIChain: OstAPIBase {
    
    let chainApiResourceBase: String
    
    override init(userId: String) {
        self.chainApiResourceBase = "/chains"
        super.init(userId: userId)
    }
    
    func getChain(onSuccess: (([String: Any]) -> Void)?, onFailure: ((OstError) -> Void)?) throws {
        
        let user: OstUser? = try OstUser.getById(self.userId)
        if (user == nil) {
            throw OstError.actionFailed("User is not persent for \(userId). Please crate user first. User OstSdk.setup")
        }
        let token: OstToken = try OstToken.getById(user!.tokenId!)!
        let chainId: String? = token.auxiliaryChainId
        if (chainId == nil || chainId!.isEmpty) {
            throw OstError.actionFailed("Chain id is not persent for \(userId). Please contact OST support.")
        }
        
        resourceURL = chainApiResourceBase + "/" + chainId!
        
        var params: [String: Any] = [:]
        insetAdditionalParamsIfRequired(&params)
        try sign(&params)
        
        get(params: params as [String : AnyObject], onSuccess: { (apiResponse) in
            let resultType = apiResponse!["result_type"] as! String
            if (resultType == "chain") {
                onSuccess?(apiResponse![resultType] as! [String: Any])
            }else {
                onFailure?(OstError.actionFailed("getting salt failed"))
            }
        }) { (failuarObj) in
            onFailure?(OstError.actionFailed("device-manager Sync failed"))
        }
    }
}
