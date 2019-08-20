/*
 Copyright © 2019 OST.com Inc
 
 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at
 
 http://www.apache.org/licenses/LICENSE-2.0
 */

import Foundation

class OstVerifyAuthorizeDevice: OstBaseViewController {
    
    class func newInstance(device: OstDevice,
                           authorizeCallback: ((OstDevice) -> Void)?,
                           cancelCallback: (() -> Void)?) -> OstVerifyAuthorizeDevice {
        
        let vc = OstVerifyAuthorizeDevice()
        
        vc.authorizeCallback = authorizeCallback
        vc.cancelCallback = cancelCallback
        vc.device = device
        
        return vc
    }
    
    var device: OstDevice? = nil
    var authorizeCallback: ((OstDevice) -> Void)? = nil
    var cancelCallback: (() -> Void)? = nil
    
    //MARK: - Components
    let containerView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = UIColor.color( 255, 255, 255)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let leadLabel: OstH2Label = OstH2Label(text: "Authorize New Device")
    let actionButton: OstB1Button = OstB1Button(title: "Authorize Device")
    let cancelButton: OstB2Button = OstB2Button(title: "Deny Request")
    var deviceAddressView = OstDeviceTableViewCell(frame: .zero)
    
    var containerTopAnchor: NSLayoutConstraint? = nil
    var containerBottomAnchor: NSLayoutConstraint? = nil
    
    //MARK: - View LC
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .clear
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
//        containerTopAnchor?.isActive = false
//        containerBottomAnchor?.isActive = true
        
        deviceAddressView.setDeviceDetails(device?.data, forIndex: 1)
        
        UIView.animate(withDuration: 0.3, animations: {[weak self] in
            self?.view.backgroundColor = UIColor.color(0, 0, 0, 0.5)
//            self?.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    override func configure() {
        super.configure()
        
        actionButton.addTarget(self, action: #selector(actionButtonTapped(_:)), for: .touchUpInside)
        cancelButton.addTarget(self, action: #selector(actionButtonTapped(_:)), for: .touchUpInside)
    }

    //MARK: - Add Subviews
    override func addSubviews() {
        super.addSubviews()
        self.addSubview(containerView)
        
        containerView.addSubview(leadLabel)
        containerView.addSubview(actionButton)
        containerView.addSubview(cancelButton)
        containerView.addSubview(deviceAddressView)
    }
    
    override func addLayoutConstraints() {
        super.addLayoutConstraints()
        
        addContainerViewConstraints()
        addLeadLabelConstraints()
        addDeviceAddressViewConstraints()
        addActionButtonConstraints()
        addCancelButtonConstraints()
    }
    
    func addContainerViewConstraints() {
        containerView.leftAlignWithParent()
        containerView.rightAlignWithParent()
        
//        containerTopAnchor = containerView.topAnchor.constraint(equalTo: containerView.superview!.bottomAnchor)
//        containerTopAnchor?.isActive = true
        
        containerBottomAnchor = containerView.bottomAnchor.constraint(equalTo: containerView.superview!.bottomAnchor)
        containerBottomAnchor?.isActive = true
    }
    func addLeadLabelConstraints() {
        leadLabel.topAlign(toItem: containerView, constant: 25)
        leadLabel.applyBlockElementConstraints(horizontalMargin: 40)
    }
    
    func addDeviceAddressViewConstraints() {
        deviceAddressView.placeBelow(toItem: leadLabel, constant: 25)
        deviceAddressView.leftAlignWithParent()
        deviceAddressView.rightAlignWithParent()
    }
    
    func addActionButtonConstraints() {
        actionButton.applyBlockElementConstraints()
        actionButton.bottomFromTopAlign(toItem: cancelButton, constant: -25)
    }
    
    func addCancelButtonConstraints() {
        cancelButton.applyBlockElementConstraints()
        if #available(iOS 11.0, *) {
            cancelButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -25).isActive = true
        } else {
            cancelButton.bottomAlignWithParent(multiplier: 1, constant: -25)
        }
    }
    
    //MARK: - Action
    @objc func actionButtonTapped(_ sender: Any) {
        
    }
    
    @objc func cancelButtonTapped(_ sender: Any) {
        
    }
    
}
