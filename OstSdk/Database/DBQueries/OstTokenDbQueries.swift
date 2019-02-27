//
//  OstTokenDbQueries.swift
//  OstSdk
//
//  Created by aniket ayachit on 02/01/19.
//  Copyright © 2019 aniket ayachit. All rights reserved.
//

import Foundation

class OstTokenDbQueries: OstBaseDbQueries {    
    /// Get activity name for OstToken
    ///
    /// - Returns: Activity name
    override func activityName() -> String{
        return "tokens"
    }
}
