//
//  OptionsViewController.swift
//  TestDemoApp
//
//  Created by aniket ayachit on 30/04/19.
//  Copyright © 2019 aniket ayachit. All rights reserved.
//

import UIKit

class OptionsViewController: OstBaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    //MAKR: - Components
    var tableView: UITableView?
    var tableHeaderView: UsersTableViewCell = {
        let view = UsersTableViewCell()

        view.sendButton?.isHidden = true
        view.sendButton?.setTitle("", for: .normal)
//        view.translatesAutoresizingMaskIntoConstraints = false
        view.seperatorLine?.isHidden = true
        view.backgroundColor = UIColor.color(239, 249, 250)
        view.layer.cornerRadius = 6
        view.clipsToBounds = true

        return view
    }()
    
    //MARK: - Variables
    var generalOptions = [OptionVM]()
    var deviceOptions = [OptionVM]()
    
    weak var tabbarController: TabBarViewController?

    //MAKR: - View LC

    override func getNavBarTitle() -> String {
        return "Wallet Settings"
    }
    
    override func getTargetForNavBarBackbutton() -> AnyObject? {
        return nil
    }
    
    override func getSelectorForNavBarBackbutton() -> Selector? {
        return nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        createGeneralOptionsArray()
        createDeviceOptionsArray()
        tableView?.reloadData()
        self.tabbarController?.showTabBar()
    }
    
    @objc override func tappedBackButton() {
        self.dismiss(animated: true, completion: nil)
    }
    
    //MARK: - Create Views
    
    override func addSubviews() {
        setupNavigationBar()
        setupTableHeaderView()
        createTabelView()
    }
    
    func setupTableHeaderView() {
        let userData = ["username": CurrentUserModel.getInstance.userName ?? ""]
        tableHeaderView.userData = userData
        tableHeaderView.balanceLabel?.text =  CurrentUserModel.getInstance.tokenHolderAddress ?? ""
    }
    
    func createTabelView() {
        let loTableView = UITableView(frame: .zero, style: .plain)
        loTableView.delegate = self
        loTableView.dataSource = self
        loTableView.separatorStyle = .none
        loTableView.rowHeight = UITableView.automaticDimension
        loTableView.estimatedRowHeight = 100
        loTableView.translatesAutoresizingMaskIntoConstraints = false
        loTableView.tableHeaderView = tableHeaderView
        loTableView.tableHeaderView?.frame.size = CGSize(width: loTableView.frame.width, height: CGFloat(77))

        tableView = loTableView
        self.view.addSubview(loTableView)
        
        registerCell()
    }
    
    func registerCell() {
        tableView?.register(OptionTableViewCell.self, forCellReuseIdentifier: OptionTableViewCell.cellIdentifier)
    }
    
    //MAKR: - Apply Constraints
    override func addLayoutConstraints() {
        applyTableViewConstraints()
    }
    
    func applyTableViewConstraints() {
        tableView?.topAlignWithParent()
        tableView?.leftAlignWithParent()
        tableView?.rightAlignWithParent()
        tableView?.bottomAlignWithParent()
    }
    
    //MAKR: - Table View Delegate
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return generalOptions.count
        case 1:
            return deviceOptions.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: OptionTableViewCell = tableView.dequeueReusableCell(withIdentifier: OptionTableViewCell.cellIdentifier, for: indexPath) as! OptionTableViewCell
        
        let option: OptionVM
        switch indexPath.section {
        case 0:
             option = generalOptions[indexPath.row]
        case 1:
            option = deviceOptions[indexPath.row]
        default:
            fatalError()
        }
        cell.option = option
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionTitle = UILabel()
        sectionTitle.numberOfLines = 1
        sectionTitle.textColor = UIColor.gray
        sectionTitle.translatesAutoresizingMaskIntoConstraints = false
        sectionTitle.font = UIFont(name: "Lato", size: 13)?.bold()
        switch section {
        case 0:
            sectionTitle.text = "GENERAL"
        case 1:
            sectionTitle.text = "DEVICE"
        default:
             sectionTitle.text = ""
        }
        
        let container = UIView()
        container.backgroundColor = .white
        container.addSubview(sectionTitle)
        
        sectionTitle.topAlignWithParent(multiplier: 1, constant: 20)
        sectionTitle.leftAlignWithParent(multiplier: 1, constant: 20)
        sectionTitle.rightAlignWithParent(multiplier: 1, constant: 20)
        sectionTitle.bottomAlignWithParent()

        return container
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell: OptionTableViewCell = tableView.cellForRow(at: indexPath) as! OptionTableViewCell
        
        let isEnable = cell.option.isEnable
        if isEnable {
            processSelectedOption(cell.option)
        }
    }
    
    func createGeneralOptionsArray() {
        let currentUser = CurrentUserModel.getInstance;
        let userDevice = currentUser.userDevice!;
        
        let optionDetail = OptionVM(type: .details, name: "View Wallet Details", isEnable: true)
        
        var optionSession = OptionVM(type: .createSession, name: "Add Session", isEnable: true)
        if !userDevice.isStatusAuthorized {
            optionSession.isEnable = false
        }
        
        var optionResetPin = OptionVM(type: .resetPin, name: "Reset PIN", isEnable: true)
        if userDevice.isStatusRegistered || userDevice.isStatusRevoked {
            optionResetPin.isEnable = false
        }
        
        var optionMnemonics = OptionVM(type: .viewMnemonics, name: "View Mnemonics", isEnable: true)
        if !userDevice.isStatusAuthorized {
            optionMnemonics.isEnable = false
        }
        
        let userOptions = [optionDetail, optionSession, optionResetPin, optionMnemonics]
        generalOptions = userOptions
    }
    
    func createDeviceOptionsArray() {
        let currentUser = CurrentUserModel.getInstance;
        let userDevice = currentUser.userDevice!;
        
        var authorizeViaQR = OptionVM(type: .authorizeViaQR, name: "Authorize Device via QR", isEnable: true)
        if !userDevice.isStatusAuthorized {
            authorizeViaQR.isEnable = false
        }
        
        var authorizeViaMnemonics = OptionVM(type: .authorizeViaMnemonics, name: "Authorize Device via Mnemonics", isEnable: true)
        if !userDevice.isStatusRegistered {
            authorizeViaMnemonics.isEnable = false
        }
        
        var showDeviceQR = OptionVM(type: .showDeviceQR, name: "Show Device QR", isEnable: true)
        if !userDevice.isStatusRegistered {
            showDeviceQR.isEnable = false
        }
        
        let manageDevices = OptionVM(type: .manageDevices, name: "Manage Devices", isEnable: true)
        
        var transactionViaQR = OptionVM(type: .transactionViaQR, name: "Transaction via QR", isEnable: true)
        if !userDevice.isStatusAuthorized {
            transactionViaQR.isEnable = false
        }
        
        var initialRecovery = OptionVM(type: .initiateDeviceRecovery, name: "Initiate Recovery", isEnable: true)
        if !userDevice.isStatusRegistered {
            initialRecovery.isEnable = false
        }
        
        var abortRecovery = OptionVM(type: .abortRecovery, name: "Abort Recovery", isEnable: true)
        if userDevice.isStatusRevoked {
            abortRecovery.isEnable = false
        }
     
        let dOptions = [authorizeViaQR, authorizeViaMnemonics, showDeviceQR, manageDevices,
                             transactionViaQR, initialRecovery, abortRecovery]
        deviceOptions = dOptions
    }
    
    
    func processSelectedOption(_ option: OptionVM) {
        var destinationSVVC: BaseSettingOptionsSVViewController? = nil
        var destinationVC: BaseSettingOptionsViewController? = nil
        
        if option.type == .details {
            destinationVC = UserDetailsViewController()
        }
        
        else if option.type == .viewMnemonics {
            destinationSVVC = DeviceMnemonicsViewController()
        }
        
        else if option.type == .authorizeViaMnemonics {
            destinationSVVC = AuthorizeDeviceViaMnemonicsViewController()
        }
            
        else if option.type == .showDeviceQR {
            destinationSVVC = ShowQRCodeViewController()
        }
        
        else if option.type == .authorizeViaQR {
            destinationSVVC = QRScannerViewController()
        }
        
        else if option.type == .createSession {
            destinationSVVC = CreateSessionViewController()
        }
        
        else if  option.type  == .manageDevices {
            destinationVC = ManageDeviceViewController()
        }
        
        else if option.type == .initiateDeviceRecovery {
            destinationVC = InitiateDeviceRecoveryViewController()
        }
        
        else if option.type == .resetPin {
            _ = OstSdkInteract.getInstance.resetPin(userId: CurrentUserModel.getInstance.ostUserId!,
                                                    passphrasePrefixDelegate: CurrentUserModel.getInstance,
                                                    presenter: self)
            self.tabbarController?.hideTabBar()
            return
        }
        
        else if option.type == .abortRecovery {
            _ = OstSdkInteract.getInstance.abortDeviceRecovery(userId: CurrentUserModel.getInstance.ostUserId!,
                                                               passphrasePrefixDelegate: CurrentUserModel.getInstance,
                                                               presenter: self)
            self.tabbarController?.hideTabBar()
            return
        }
        
        self.tabbarController?.hideTabBar()
        
        let viewController: OstBaseViewController = destinationSVVC == nil ? destinationVC! : destinationSVVC!
        
        if nil == self.navigationController {
            let navC = UINavigationController(rootViewController: viewController )
            self.present(navC, animated: true, completion: nil)
        }else {
           self.navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
    func openAuthorizeDeviceView() {
        guard let currentDevice = CurrentUserModel.getInstance.userDevice else {return}
        if currentDevice.isStatusRegistered {
            if let currentUser = CurrentUserModel.getInstance.ostUser {
                if currentUser.isStatusActivated {
                    let authorizeDeviceVC = AuthorizeDeviceViewController()
                    authorizeDeviceVC.pushViewControllerOn(self)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        self.tabbarController?.hideTabBar()
                    }
                }
            }
        }
    }
}

class OptionTableHeaderView: UIView {
    
    //MARK: - Components
    var circularView: UIView?
    var initialLetter: UILabel?
    var stackView: UIStackView?
    var titleLabel: UILabel?
    var tokenHolderAddressLabel: UILabel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createViews()
        applyConstraints()
        self.clipsToBounds = true
        setData()
    }
    
    init() {
        super.init(frame: .zero)
        createViews()
        applyConstraints()
        self.clipsToBounds = true
        setData()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        createViews()
        applyConstraints()
        self.clipsToBounds = true
        setData()
    }
    
    func createViews() {
        createcirCularView()
        createNameLabel()
        createTokenHolderLabel()
        createStackView()
        
        self.backgroundColor = UIColor.color(251, 251, 251, 0.92)
    }
    func createcirCularView() {
        let circularView = UIView()
        circularView.backgroundColor = UIColor.color(244, 244, 244)
        circularView.layer.cornerRadius = 25
        
        let letter = UILabel()
        letter.textColor = UIColor.color(155, 155, 155)
        letter.numberOfLines = 1
        letter.font = UIFont(name: "Lato", size: 20)?.bold()
        
        self.initialLetter = letter
        circularView.addSubview(letter)
        
        self.circularView = circularView
        self.addSubview(circularView)
    }
    
    func createNameLabel() {
        let nameLabel = UILabel()
        nameLabel.numberOfLines = 0
        nameLabel.textAlignment = .left
        nameLabel.textColor = UIColor.black
        nameLabel.text = "11111"
        nameLabel.font = UIFont(name: "Lato", size: 17)
        self.titleLabel = nameLabel
    }
    
    func createTokenHolderLabel() {
        let loBalanaceLabel = UILabel()
        loBalanaceLabel.numberOfLines = 0
        loBalanaceLabel.textAlignment = .left
        loBalanaceLabel.textColor = UIColor.darkGray
        loBalanaceLabel.text = "11111"
        loBalanaceLabel.font = UIFont(name: "Lato", size: 14)
        self.tokenHolderAddressLabel = loBalanaceLabel
    }
    
    func createStackView() {
        let loStackView = UIStackView(arrangedSubviews: [self.titleLabel!, self.tokenHolderAddressLabel!])
        loStackView.axis = .vertical
        loStackView.distribution = .fillProportionally
        loStackView.alignment = .lastBaseline
        
        self.stackView = loStackView
        self.addSubview(loStackView)
    }
    
    func applyConstraints() {
        applyCircularViewConstraints()
        applyInitialLetterConstraints()
        applyStackViewConstraints()
    }
    
    func applyCircularViewConstraints() {
        self.circularView?.translatesAutoresizingMaskIntoConstraints = false
        self.circularView?.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 12).isActive = true
        self.circularView?.widthAnchor.constraint(equalToConstant: 50).isActive = true
        self.circularView?.heightAnchor.constraint(equalTo: (self.circularView?.widthAnchor)!).isActive = true
        self.circularView?.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
    
    func applyInitialLetterConstraints() {
        self.initialLetter?.translatesAutoresizingMaskIntoConstraints = false
        self.initialLetter?.centerYAnchor.constraint(equalTo: self.circularView!.centerYAnchor).isActive = true
        self.initialLetter?.centerXAnchor.constraint(equalTo: self.circularView!.centerXAnchor).isActive = true
    }
    
    func applyStackViewConstraints() {
        self.stackView?.translatesAutoresizingMaskIntoConstraints = false
        self.stackView?.leftAnchor.constraint(equalTo: self.circularView!.rightAnchor, constant: 8.0).isActive = true
        self.stackView?.rightAnchor.constraint(equalTo: stackView!.superview!.rightAnchor).isActive = true
        self.stackView?.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        self.stackView?.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    func setData(title: String = "", subtitle: String = "") {
//        let currentUserName = CurrentUser.getInstance().userName
//        let userTokenHolder = (CurrentUser.getInstance().currentUserData)?["token_holder_address"] as? String

        self.titleLabel?.text = title
        self.tokenHolderAddressLabel?.text = subtitle
        let fistLetter = title.character(at: 0)
        self.initialLetter?.text = (fistLetter == nil) ? "" : "\(fistLetter!)".uppercased()
    }
}
