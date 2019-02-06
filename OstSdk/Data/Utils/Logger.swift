//
//  Log.swift
//  OstSdk
//
//  Created by aniket ayachit on 06/02/19.
//  Copyright © 2019 aniket ayachit. All rights reserved.
//

import Foundation
import Alamofire

class Logger {
    class func log(message: String? = nil, parameterToPrint: Any? = nil, function: String = #function) {
        #if DEBUG
        debugPrint("************************ START *********************************")
        debugPrint("function: \(function)")
        debugPrint("message: \(message ?? "")")
        
        debugPrint(parameterToPrint ?? "")
        debugPrint("************************* END *******************************")
        #endif
    }
}

extension Request {
    public func debugLog() -> Self {
        #if DEBUG
        debugPrint("=======================================")
        debugPrint(self)
        debugPrint("=======================================")
        #endif
        return self
    }
}
