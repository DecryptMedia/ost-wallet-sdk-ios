/*
 Copyright © 2019 OST.com Inc
 
 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at
 
 http://www.apache.org/licenses/LICENSE-2.0
 */

import Foundation

class TokenRule: ABIHelperBase {
    static let EXECUTE_RULE_CALLPREFIX = "0x59793b00"
    private let ABI_NAME = "TokenRules.abi"
    
    func getDirectTransfersExecutableData(abiMethodName: String, tokenHolderAddresses: [String], amounts: [String]) throws -> String {
        
        let abiObject: ABIObject? = try getABI(ABI_NAME, forMethod: abiMethodName)
        if (abiObject == nil) {
            throw OstError("u_ah_tr_gdted_1", "ABI for \(abiMethodName) is not available.")
        }
        
        var ethereumAddresses : [EthereumAddress] = []
        for tokenHolderAddress in tokenHolderAddresses {
            let address = try EthereumAddress(hex:tokenHolderAddress, eip55: false)
            ethereumAddresses.append(address)
        }
        
        var amountsBigInt: [BigInt] = []
        for amount in amounts {
            amountsBigInt.append(BigInt(amount)!)
        }
        
        let solidityHander = OstSolidityHandler()
        let function = SolidityNonPayableFunction(abiObject: abiObject!, handler: solidityHander)
        let _invocation = function!.invoke(ethereumAddresses, amountsBigInt)
        let ethereumData = _invocation.encodeABI();
        if (ethereumData == nil) {
            throw OstError("u_ah_tr_gdted_2", OstErrorText.abiEncodeFailed)
        }
        
        return ethereumData!.hex()
    }
}
