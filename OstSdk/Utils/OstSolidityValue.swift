//
//  OstSolidityValue.swift
//  OstSdk
//
//  Created by aniket ayachit on 23/01/19.
//  Copyright © 2019 aniket ayachit. All rights reserved.
//

import Foundation
import BigInt

class OstSolidityValue {
 
    static func getSolidtyValue(_ string: String, for type: SolidityType) throws -> ABIEncodable {
        let stringType = type.stringValue
        
        if (stringType.starts(with: "uint") || stringType.starts(with: "int")) {
            if let bigInt = BigInt(string) {
                return bigInt
            }
            throw OstError.init("u_sv_gsv_1", .invalidSolidityTypeInt)
            
        } else if (stringType == "address") {
            if let ethAddress = EthereumAddress(hexString: string) {
               return ethAddress
            }
            throw OstError.init("u_sv_gsv_1", .invalidSolidityTypeAddress)
            
        } else if (stringType.starts(with: "bytes")) {
            return Data(hex: string)
            
        } else if (stringType == "string") {
            return string
            
        }
        
        return ""
    }
}
