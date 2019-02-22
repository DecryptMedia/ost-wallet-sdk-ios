/*
 Copyright 2018-present the Material Components for iOS authors. All Rights Reserved.

 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at

 http://www.apache.org/licenses/LICENSE-2.0

 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
 */

import UIKit
import OstSdk
import MaterialComponents

class WalletViewController: UIViewController {
  
  public enum ViewMode {
    case SETUP_WALLET
    case ADD_DEVICE
    case NEW_SESSION
    case QR_CODE
    case MENU
  }
  
  var isLoginMode:Bool = true;
  //Default View Mode.
  public var viewMode = ViewMode.SETUP_WALLET;
  
  let setupWalletView: SetupWalletView = {
    let scrollView = SetupWalletView()
    scrollView.translatesAutoresizingMaskIntoConstraints = false;
    scrollView.backgroundColor = .white
    scrollView.layoutMargins = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    return scrollView
  }()


  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    //Setup text field controllers
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    view.tintColor = .black
    setupWalletView.backgroundColor = .white

    view.addSubview(setupWalletView)

    NSLayoutConstraint.activate(
      NSLayoutConstraint.constraints(withVisualFormat: "V:|[scrollView]|",
                                     options: [],
                                     metrics: nil,
                                     views: ["scrollView" : setupWalletView])
    )
    NSLayoutConstraint.activate(
      NSLayoutConstraint.constraints(withVisualFormat: "H:|[scrollView]|",
                                     options: [],
                                     metrics: nil,
                                     views: ["scrollView" : setupWalletView])
    )
    
    let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapTouch))
    setupWalletView.addGestureRecognizer(tapGestureRecognizer)
    setupWalletView.walletViewController = self;
  }

  // MARK: - Gesture Handling
  
  @objc func didTapTouch(sender: UIGestureRecognizer) {
    view.endEditing(true)
  }


}



