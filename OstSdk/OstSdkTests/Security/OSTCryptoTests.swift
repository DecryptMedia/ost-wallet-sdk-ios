//
//  OSTCryptoTests.swift
//  OstSdkTests
//
//  Created by aniket ayachit on 17/12/18.
//  Copyright © 2018 aniket ayachit. All rights reserved.
//

import XCTest
@testable import OstSdk

class OSTCryptoTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSCrypt() {
        let saltData: Data = "salt".data(using: .utf8)!
        let password: String = "Sachin"
        
        let output: String = "22db5466eb082120723a67ebd334ae93796286759e5640b297bd2bd3054cde8a"
        
        do {
            let SCryptOutput: Data = try OSTCryptoImpls().genSCryptKey(salt: saltData, stringToCalculate: password)
            XCTAssertTrue(SCryptOutput.toHexString() == output, "SCrypt output is different")
        }catch let error {
            XCTAssertNil(error, "Error should not occure")
        }
    
    }
    
    func testHKDF() {
        let saltData: Data = "salt".data(using: .utf8)!
        let password: String = "Sachin"
        let saltUInt = Array(saltData)
        
        let hkdfOutputVal: String = "08418ad8001d0d099fba60a574df6a1debeff1668c9d6998efb2a51c7fe3996a"
        
        do {
            let SCryptOutput: Data = try OSTCryptoImpls().genSCryptKey(salt: saltData, stringToCalculate: password)
            
            let SCryptOutputUInt: Array<UInt8> = Array(SCryptOutput)
            let hkdfOutput: [UInt8] = try OSTCryptoImpls().genHKDFKey(salt: saltUInt, data: SCryptOutputUInt)
            
            XCTAssertTrue(hkdfOutput.toHexString() == hkdfOutputVal, "hkdf output is different")
        }catch let error {
            XCTAssertNil(error, "Error should not occure")
        }
    }
    
    func testDigest() {
        let digestOutputVal = "6dfe2e5b192dd048a652f1bca2b115055b98426e104814deaa8b4d74506fcca3"
        let digestOutput = OSTCryptoImpls().genDigest(bytes: Array("Aniket".utf8))
        XCTAssertTrue(digestOutputVal == digestOutput.toHexString() , "digest output is different")
    }
    
//    func testAESEncryption() {
//        do {
//            let val = String(Date.negativeTimestamp())
//
//            let SCryptOutput: Data = try OSTCryptoImpls().genSCryptKey(salt: val.data(using: .utf8)!, stringToCalculate: "a")
//            try OSTSecureStoreImpls(keyAlias: "").storeData(SCryptOutput, forKey: "a")
//
//            let encryptedData: [UInt8] = try OSTCryptoImpls().aesGCMEncrypt(aesKey: Array(SCryptOutput), dataToEncrypt: "Aniket")
//            testAESDecryption(encryptedData: encryptedData)
//        }catch let error {
//
//        }
//    }
    
//    func testAESDecryption(encryptedData: [UInt8]) {
//        do {
//            let val: String = try! OSTSecureStoreImpls(keyAlias: "").getDataFor(key: "a") as! String
//
//            let decryptedData = try OSTCryptoImpls().aesGCMDecryption(aesKey: Array(val.utf8), dataToDecrypt: encryptedData)
//            let decryptedString = String(bytes: decryptedData, encoding: .utf8)
//
//            XCTAssertEqual(decryptedString, "Aniket")
//        }catch let error {
//            XCTAssertNil(error, "Error should not occure")
//        }
//    }
    
    func testGenerateCryptoKeys() {
        let expectedSignedTx = "0x34daffa295320477d88e6b9597f97cd3a852de50fc471a6b39a5525a2b00459d47d43367f48d24ac9f8f986bb0b4e1b349eb7ab9dc028a4f5d0d2f0909acd5611c"
        do {
            let ostCrypto = OSTCryptoImpls()
            let privateKey = try ostCrypto.generateCryptoKeys()
            let txHash = getEIP1077TxHash()
            
            let signedTx = try ostCrypto.signTx(txHash, withPrivatekey: privateKey.privateKey!)
            XCTAssertEqual(expectedSignedTx, signedTx)
        }catch let error {
            XCTAssertNil(error, "error should be nil")
        }
    }
    
    func getEIP1077TxHash() -> String {
        var tx: [String: String] = [:]
        
        tx["from"] = "0x5a85a1E5a749A76dDf378eC2A0a2Ac310ca86Ba8"
        tx["to"] = "0xF281e85a0B992efA5fda4f52b35685dC5Ee67BEa"
        tx["value"] = "1"
        tx["gasPrice"] = "0"
        tx["gas"] = "0"
        tx["data"] = "0xF281e85a0B992efA5fda4f52b35685dC5Ee67BEa"
        tx["nonce"] = "1"
        tx["callPrefix"] = "0x"
        
        do {
            let eip1077TxHash = try EIP1077(transaction: tx).toEIP1077transactionHash()
            return eip1077TxHash
        }catch {
            return ""
        }
       // XCTAssertEqual(eip1077TxHash, "0xc11e96ba445075d92706097a17994b0cc0d991515a40323bf4c0b55cb0eff751")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
