//
//  OstMultiSigModel.swift
//  OstSdk
//
//  Created by aniket ayachit on 02/01/19.
//  Copyright © 2019 aniket ayachit. All rights reserved.
//

import Foundation

public protocol OstMultiSigModel: class {
    
    func get(_ id:  String) throws -> OstMultiSig?
    
    func getAll(_ ids:  Array<String>) -> [String: OstMultiSig?]
    
    func save(_ multiSigData: [String : Any], success: ((OstMultiSig?) -> Void)?, failure: ((Error) -> Void)?)
    
    func saveAll(_ multiSigDataArray: Array<[String: Any]>, success: ((Array<OstMultiSig>?, Array<OstMultiSig>?) -> Void)?, failure: ((Error) -> Void)?)
    
    func delete(_ id: String, success: ((Bool)->Void)?)
    
    func deleteAll(_ ids: Array<String>, success: ((Bool) -> Void)?)
}
