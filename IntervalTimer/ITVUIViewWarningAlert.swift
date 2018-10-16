//
//  WarningView.swift
//  IntervalTimer
//
//  Created by Paul Addy on 2017-09-05.
//  Copyright © 2017 Paul Addy. All rights reserved.
//

import UIKit

class ITVUIViewWarningAlert: UIView, ITVUserWarningProtocol {
    var backgroundView = UIView()
    var dialogView = UIView()
    var visualEffectsView = UIVisualEffectView()
    var errorMessage: String?
    
    convenience init(type: UserWarning?, with message: String? = nil) {
        self.init(frame: UIScreen.main.bounds)

        guard let theUserWarning = type else {
            fatalError("------> ERROR ITVUIViewWarningAlert Please provide a UserWarning type.")
        }
        
        ITVWarningForUser.sharedInstance.thisUserWarning = theUserWarning
        
        if message != nil, !(message?.isEmpty)! {
            errorMessage = message
        } else {
            errorMessage = nil
        }
        ITVWarningForUser.sharedInstance.thisMessage = errorMessage
        
        initialize(with: theUserWarning)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("------> ERROR ITVUIViewWarningAlert init(coder:) has not been implemented")
    }
    
    func initialize(with warningType: UserWarning){
        dialogView.clipsToBounds = true
       
        visualEffectsView.frame = frame
        visualEffectsView.effect = UIBlurEffect(style: .dark)
        backgroundView.addSubview(visualEffectsView)
        backgroundView.frame = frame
        backgroundView.center = center
        backgroundView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapOnBackgroundView)))
        
        let dismissWarningImageView = UIImageView(image: UIImage(named: Images.CloseUserWarning))
        let dismissWarningImageViewPosition = CGPoint(x: 15, y: frame.height - 35)
        dismissWarningImageView.frame = CGRect(origin: dismissWarningImageViewPosition, size: Sizes.closeWarningImageView)
        backgroundView.addSubview(dismissWarningImageView)
        
        addSubview(backgroundView)
        
        dialogView = warningView(with: warningType)
        dialogView.layer.cornerRadius = 5
        dialogView.center = center
        addSubview(dialogView)

        dialogView.translatesAutoresizingMaskIntoConstraints = true
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[view]-|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: ["view":dialogView]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[view]-|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: ["view":dialogView]))
    }
    func warningView(with warningType: UserWarning) -> UIView {
        
        var message = Litterals.EmptyString
        var attributedString = NSMutableAttributedString()
        
        switch warningType {
        case UserWarning.AirPlaneModeEnabled:
            
            let warningView: ITVWarningDisableAirPlaneModeView = UIView.fromNib()
            
            message = "Please disable Air Plane mode."

            let rangeOfDisable = (message as NSString).range(of: "disable")
            
            attributedString = NSMutableAttributedString(string: message)
            attributedString.addAttribute(NSAttributedString.Key.font, value: ViewFont.WarningBold, range: rangeOfDisable)

            warningView.messageLabel.attributedText = attributedString
            
            return warningView

        case UserWarning.LocationManagerDidFail:
            let warningView: ITVWarningLocationManagerDidFailView = UIView.fromNib()
            warningView.errorMessageTextView.text = errorMessage!
            warningView.errorMessageTextView.layer.borderColor = ITVColors.Orange.cgColor
            warningView.errorMessageTextView.layer.borderWidth = 1.0
            
            message = "Location determination is unavailable at the moment on this device."
            
            let rangeOfLocationDetermination = (message as NSString).range(of: "Location determination")
            
            attributedString = NSMutableAttributedString(string: message)
            attributedString.addAttribute(NSAttributedString.Key.font, value: ViewFont.WarningBold, range: rangeOfLocationDetermination)
            
            warningView.messageLabel.attributedText = attributedString
            
            return warningView

        case UserWarning.LocationServicesDisabled:

            let warningView: ITVWarningAllowLocationServicesView = UIView.fromNib()
            
            message = "Please allow Location Services for Interval Timer."
            
            let rangeOfLocationServices = (message as NSString).range(of: "Location Services")
            
            attributedString = NSMutableAttributedString(string: message)
            attributedString.addAttribute(NSAttributedString.Key.font, value: ViewFont.WarningBold, range: rangeOfLocationServices)
            
            warningView.messageLabel.attributedText = attributedString
            
            return warningView

        case UserWarning.NoInternet:
            let warningView: ITVWarningConnectToInternetView = UIView.fromNib()
            
            message = "Please connect to the Internet."
            
            let rangeOfInternet = (message as NSString).range(of: "Internet")
            
            attributedString = NSMutableAttributedString(string: message)
            attributedString.addAttribute(NSAttributedString.Key.font, value: ViewFont.WarningBold, range: rangeOfInternet)
            
            warningView.messageLabel.attributedText = attributedString

            return warningView
        
        case UserWarning.MissingIntervals:
            let warningView: ITVWarningMissingIntervalsView = UIView.fromNib()
            
            message = "Please add intervals to your timer."
            
            let rangeOfIntervals = (message as NSString).range(of: "intervals")
            
            attributedString = NSMutableAttributedString(string: message)
            attributedString.addAttribute(NSAttributedString.Key.font, value: ViewFont.WarningBold, range: rangeOfIntervals)
            
            warningView.messageLabel.attributedText = attributedString
            warningView.addIntervalsButton.addTarget(self, action: #selector(didTapOnAddInterval), for: .touchUpInside)

            return warningView

        case UserWarning.MissingTimerName:
            let warningView: ITVWarningMissingTimerNameView = UIView.fromNib()
            
            message = "Please name your new timer."
            
            let rangeOfName = (message as NSString).range(of: "name")
            
            attributedString = NSMutableAttributedString(string: message)
            attributedString.addAttribute(NSAttributedString.Key.font, value: ViewFont.WarningBold, range: rangeOfName)
            
            warningView.messageLabel.attributedText = attributedString
            
            return warningView
        }
    }
    @objc func didTapOnBackgroundView(){
        dismiss(animated: true)
    }
    @objc func didTapOnAddInterval(){
        //send notification to segue
        NotificationCenter.default.post(name: Notification.Name(rawValue: Notifications.segueToEditInterval), object: nil)
        dismiss(animated: true)
    }
}
