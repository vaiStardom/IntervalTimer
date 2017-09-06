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
    
    convenience init(type: UserWarning?) {
        self.init(frame: UIScreen.main.bounds)

        guard let theUserWarning = type else {
            fatalError("Please provide a UserWarning type.")
        }

        initialize(with: theUserWarning)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initialize(with warningType: UserWarning){
        dialogView.clipsToBounds = true
       
        visualEffectsView.frame = frame
        visualEffectsView.effect = UIBlurEffect(style: .dark)
        backgroundView.addSubview(visualEffectsView)
        backgroundView.frame = frame
        backgroundView.center = center
        backgroundView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTappedOnBackgroundView)))
        addSubview(backgroundView)
        
        dialogView = warningView(with: warningType)
        dialogView.layer.cornerRadius = 5
        dialogView.center = center
        addSubview(dialogView)

        dialogView.translatesAutoresizingMaskIntoConstraints = true
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[view]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["view":dialogView]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[view]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["view":dialogView]))

    }
    func warningView(with warningType: UserWarning) -> UIView {
        switch warningType {
        case UserWarning.AirPlaneModeEnabled:
            let warningView: ITVWarningDisableAirPlaneModeView = UIView.fromNib()
            return warningView

        case UserWarning.LocationManagerDidFail:
            let warningView: ITVWarningLocationManagerDidFailView = UIView.fromNib()
            return warningView

        case UserWarning.LocationServicesDisabled:
            let warningView: ITVWarningAllowLocationServicesView = UIView.fromNib()
            return warningView

        case UserWarning.NoInternet:
            let warningView: ITVWarningConnectToInternetView = UIView.fromNib()
            return warningView

        }
    }
    func didTappedOnBackgroundView(){
        dismiss(animated: true)
    }
}
