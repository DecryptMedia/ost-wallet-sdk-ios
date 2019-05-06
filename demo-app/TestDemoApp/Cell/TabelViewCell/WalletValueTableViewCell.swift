//
//  DAWalletValueTableViewCell.swift
//  DemoApp
//
//  Created by aniket ayachit on 23/04/19.
//  Copyright © 2019 aniket ayachit. All rights reserved.
//

import UIKit

class WalletValueTableViewCell: BaseTableViewCell {
    
    static var cellIdentifier: String {
        return String(describing: WalletValueTableViewCell.self)
    }
    //MAKR: - Components
    var walletBackground: UIView?
    var valueContainer: UIView?
    var btValueLabel: UILabel?
    var usdValueLabel: UILabel?
    
    //MARK: - Variables
    let maxDuration = TimeInterval(exactly: 1)!
    var displayLink: CADisplayLink?
    
    override func setVariables() {
        displayLink = CADisplayLink(target: self, selector: #selector(counter))
    }
    
    
    //MARK: - Create Views
    override func createViews() {
        createWalletValueContainer()
        createValueContainer()
        crateBtValueLabel()
        crateUSDValueLabel()
    }
    
    func createWalletValueContainer() {
        let container = UIView()
        container.backgroundColor = UIColor.color(154, 204, 215)
        container.layer.cornerRadius = 15.0
        
        self.walletBackground = container
        self.addSubview(container)
    }
    
    func createValueContainer() {
        let container = UIView()
        container.backgroundColor = .clear
        
        self.valueContainer = container
        self.addSubview(container)
    }
    
    func crateBtValueLabel() {
        let btLabel = UILabel()
        btLabel.font = OstFontProvider().get(size: 32).bold()
        btLabel.textColor = UIColor.white
        btLabel.text = "SPOO 90.00"
        self.btValueLabel = btLabel
        self.valueContainer?.addSubview(btLabel)
    }
    
    func crateUSDValueLabel() {
        let usdLabel = UILabel()
        usdLabel.font = OstFontProvider().get(size: 16)
        usdLabel.textColor = UIColor.white
        usdLabel.text = "~ $9.00"
        self.usdValueLabel = usdLabel
        self.valueContainer?.addSubview(usdLabel)
    }
    
    //MARK: - Apply Constraints
    
    override func applyConstraints() {
        applyWalletContainerConstraints()
        applyValueContainerConstraints()
        applyBtValueLabelConstraint()
        applyUSDValueLabelConstraint()
    }
    
    func applyWalletContainerConstraints() {
        guard let parent = self.walletBackground?.superview else {return}
        self.walletBackground?.translatesAutoresizingMaskIntoConstraints = false
        self.walletBackground?.topAnchor.constraint(equalTo: parent.topAnchor, constant: 22.0).isActive = true
        self.walletBackground?.leftAnchor.constraint(equalTo: parent.leftAnchor, constant: 22.0).isActive = true
        self.walletBackground?.rightAnchor.constraint(equalTo: parent.rightAnchor, constant: -22.0).isActive = true
        self.walletBackground?.bottomAnchor.constraint(equalTo: parent.bottomAnchor, constant: -22.0).isActive = true
    }
    
    func applyValueContainerConstraints() {
        guard let parent = self.valueContainer?.superview else {return}
        self.valueContainer?.translatesAutoresizingMaskIntoConstraints = false
        self.valueContainer?.centerYAnchor.constraint(equalTo: parent.centerYAnchor).isActive = true
        self.valueContainer?.centerXAnchor.constraint(equalTo: parent.centerXAnchor).isActive = true
        self.valueContainer?.bottomAnchor.constraint(equalTo: self.usdValueLabel!.bottomAnchor).isActive = true
    }
    
    func applyBtValueLabelConstraint() {
        guard let parent = self.btValueLabel?.superview else {return}
        self.btValueLabel?.translatesAutoresizingMaskIntoConstraints = false
        self.btValueLabel?.topAnchor.constraint(equalTo: parent.topAnchor).isActive = true
        self.btValueLabel?.centerXAnchor.constraint(equalTo: parent.centerXAnchor).isActive = true
    }
    
    func applyUSDValueLabelConstraint() {
        guard let parent = self.usdValueLabel?.superview else {return}
        self.usdValueLabel?.translatesAutoresizingMaskIntoConstraints = false
        self.usdValueLabel?.topAnchor.constraint(equalTo: self.btValueLabel!.bottomAnchor, constant: 10.0).isActive = true
        self.usdValueLabel?.centerXAnchor.constraint(equalTo: parent.centerXAnchor).isActive = true
    }
    
    override func endDisplay() {
        animate()
    }
    
    //MARK: - Animation
    var startTime: Date?
    var startValue = Double(exactly: 0)!
    var endValue = Double(exactly: 100)!
    var diff: Double?
    
    func animate() {
        diff = endValue - startValue
        startTime = Date()
        displayLink?.add(to: .current, forMode: .default)
    }
    
    @objc func counter() {
        let elapsedTime = Date().timeIntervalSince(startTime!)
        if elapsedTime > maxDuration {
            displayLink?.invalidate()
            displayLink = nil
            let finalVal = String(format: "%.2f", endValue)
            self.btValueLabel?.text = "SPOO \(finalVal)"
            return
        }
        let percent = elapsedTime/maxDuration
        let value = startValue + (percent * diff!)
        let finalVal = String(format: "%.2f", value)
        self.btValueLabel?.text = "SPOO \(finalVal)"
    }
}
