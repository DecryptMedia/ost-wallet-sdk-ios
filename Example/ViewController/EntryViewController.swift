//
//  EntryViewController.swift
//  Example
//
//  Created by aniket ayachit on 08/02/19.
//  Copyright © 2019 aniket ayachit. All rights reserved.
//

import UIKit
import OstSdk

class EntryViewController: UIViewController {
    
    let signupSegue = "entryToSignupVC"
    let loginSegue = "entryToLoginVC"
    
    let mobileNumberLength = 10

    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var mobileNumberTextField: UITextField!
    @IBOutlet weak var userNameErrorLabel: UILabel!
    @IBOutlet weak var mobileNumberErrorLabel: UILabel!
    @IBOutlet weak var signupButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        userNameTextField.text = "aniket\(Int(Date().timeIntervalSince1970))"
        mobileNumberTextField.text = "\(Int(Date().timeIntervalSince1970))"
        
        signupButton.layer.borderWidth = 1
        signupButton.layer.borderColor = UIColor.gray.cgColor
        signupButton.layer.cornerRadius = 10
        
//        sync()
//        activateUser()
//        sessions()
    }
    
    func activateUser() {
        _ = try! ActivateUser(userId: "f295c39f-522e-4805-a528-00c7cc99f1ae", tokenId: "58", mappyUserId: "5c62a6d35d3f2e6286e95b2a", pin: "123456", password: "dsaifnwaeuifnuwaleinfiweanfofaffwae").perform()
        
         _ = try! ActivateUser(userId: "f295c39f-522e-4805-a528-00c7cc99f1ae", tokenId: "58", mappyUserId: "5c62a6d35d3f2e6286e95b2a", pin: "123456", password: "dsaifnwaeuifnuwaleinfiweanfofaffwae").perform()
    }
    
    func sync() {
        try! SetupDevice(userId: "f295c39f-522e-4805-a528-00c7cc99f1ae", tokenId: "58", mappyUserId: "5c62a6d35d3f2e6286e95b2a").perform()
    }
    
    
    func sessions() {
        for i in 0..<4 {
            var params = ["user_id": "f295c39f-522e-4805-a528-00c7cc99f1ae", //UUID V4
            "address": "0xf295c39f-522e-4805-a528-00c7cc99f1ae\(i)", //Address
            "expiration_height": "12344", //Block Number
            "spending_limit": "1234", //Bignumber Wei
            "nonce":"0", //Integer
            "status": "AUTHORISED", //String
            "updated_timestamp": "12344"]
            do {
                try OstSdk.parse(["session": params, "result_type":"session"])
            }catch let error{
                print(error)
            }
        }
        
        
    }
    
    func canProceed() -> Bool {
        var isCorrectData = true
        if (userNameTextField.text?.isEmpty)! {
            userNameErrorLabel.text = "user name is mandetory."
            isCorrectData = false
        }else {
            userNameErrorLabel.text = ""
        }
        
        if (mobileNumberTextField.text?.isEmpty)! ||
            mobileNumberLength > (mobileNumberTextField.text?.count)! {
            mobileNumberErrorLabel.text = "mobile number should be of 10 digit."
            isCorrectData = false
        }else {
            userNameErrorLabel.text = ""
        }
        return isCorrectData
    }
    
    //MARK: - Button Action
    @IBAction func signupButtonTapped(_ sender: Any) {
        if canProceed() {
            performSegue(withIdentifier: signupSegue, sender: nil)
        }
    }
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        if canProceed() {
            performSegue(withIdentifier: loginSegue, sender: nil)
        }
    }
    
    //MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case signupSegue:
            let signupViewController = segue.destination as! SignupViewController
            signupViewController.mobileNumber = mobileNumberTextField.text!
            signupViewController.username = userNameTextField.text!
        case loginSegue:
            let signupViewController = segue.destination as! LoginViewController
            signupViewController.mobileNumber = mobileNumberTextField.text!
            signupViewController.username = userNameTextField.text!
        default:
            return
        }
    }
    

}
