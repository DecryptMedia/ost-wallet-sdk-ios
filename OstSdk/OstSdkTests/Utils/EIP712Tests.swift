//
//  EIP712Tests.swift
//  OstSdkTests
//
//  Created by aniket ayachit on 21/01/19.
//  Copyright © 2019 aniket ayachit. All rights reserved.
//

import XCTest
@testable import OstSdk

class EIP712Tests: XCTestCase {
    let TypedDataInput: [String: Any] = [
        "types": [
            "EIP712Domain": [
                [ "name": "name", "type": "string" ],
                [ "name": "version", "type": "string" ],
                [ "name": "chainId", "type": "uint256" ],
                [ "name": "verifyingContract", "type": "address" ]
            ],
            "Person": [[ "name": "name", "type": "string" ], [ "name": "wallet", "type": "address" ]],
            "Mail": [[ "name": "from", "type": "Person" ], [ "name": "to", "type": "Person" ], [ "name": "contents", "type": "string" ]]
        ],
        "primaryType": "Mail",
        "domain": [
            "name": "Ether Mail",
            "version": "1",
            "chainId": "1",
            "verifyingContract": "0xCcCCccccCCCCcCCCCCCcCcCccCcCCCcCcccccccC"
        ],
        "message": [
            "from": [
                "name": "Cow",
                "wallet": "0xCD2a3d9F938E13CD947Ec05AbC7FE734Df8DD826"
            ],
            "to": [
                "name": "Bob",
                "wallet": "0xbBbBBBBbbBBBbbbBbbBbbbbBBbBbbbbBbBbbBBbB"
            ],
            "contents": "Hello, Bob!"
        ]
    ];
    
    let expectedDataTypeDependenciesForMail = ["Mail", "Person"]
    let expectedHashedDataForMail = "a0cedeb2dc280ba39b857546d74f5549c3a1d7bdc2dd96bf881f76108e23dac2"
    let expectedEncodedDataTypeMail = "Mail(Person from,Person to,string contents)Person(string name,address wallet)"
    let expectedHashDataForDomail = "f2cee375fa42b42143804025fc449deafd50cc031ca257e0b194a650a912090f"
    let expectedEncodeDataForMessage = "0xa0cedeb2dc280ba39b857546d74f5549c3a1d7bdc2dd96bf881f76108e23dac2fc71e5fa27ff56c350aa531bc129ebdf613b772b6604664f5d8dbe21b85eb0c8cd54f074a4af31b4411ff6a60c9719dbd559c221c8ac3492d9d872b041d703d1b5aadf3154a261abdd9086fc627b61efca26ae5702701d05cd2305f7c52a2fc8"
    let expectedEIP712SignedHash = "0xbe609aee343fb3c4b28e1df9e632fca64fcfaede20f02e86244efddf30957bd2"
    
    var eip712: EIP712? = nil
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        eip712 = EIP712(types: TypedDataInput["types"] as! [String: Any], primaryType: TypedDataInput["primaryType"] as! String, domain: TypedDataInput["domain"] as! [String: String], message: TypedDataInput["message"] as! [String: Any])
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testDataTypeDependenciesForMail() {
        var found: Array<String> = []
        XCTAssertEqual(eip712?.getDataTypeDependencies("Mail", found: &found), expectedDataTypeDependenciesForMail)
    }

    func testEncodeDataTypeForMail() {
        XCTAssertEqual(eip712?.encodeDataType("Mail"), expectedEncodedDataTypeMail)
    }

    func testHashDataTypeForMail() {
        XCTAssertEqual(eip712?.hashDataType("Mail"), expectedHashedDataForMail)
    }
    
    func testHashDataForDomain() throws {
        let dataType = "EIP712Domain"

        let hashDataForDomain = try eip712?.hashData(dataType, data: TypedDataInput["domain"] as! [String: Any])
        print(hashDataForDomain ?? "failed")
        XCTAssertEqual(hashDataForDomain, expectedHashDataForDomail)
    }
    
    func testEncodeDataForMessage() throws {
        let data = TypedDataInput["message"] as! [String : Any]
        let primaryType = TypedDataInput["primaryType"] as! String
        XCTAssertEqual(try eip712?.encodeData(primaryType, data: data), expectedEncodeDataForMessage )
    }

    func testEIP712SignedHash() {
        XCTAssertEqual(try eip712?.getEIP712SignHash(), expectedEIP712SignedHash)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
