//
//  TimerViewControllerWarnings.swift
//  IntervalTimer
//
//  Created by Paul Addy on 2017-09-05.
//  Copyright © 2017 Paul Addy. All rights reserved.
//

import Foundation
import UIKit

//MARK: - Warnings
extension TimerViewController {
    
    func showWarning(type: UserWarning?){
        
        guard let theUserWarning = type else {
            fatalError("Please provide a UserWarning type.")
        }
        
        switch theUserWarning {
        case UserWarning.AirPlaneModeEnabled:
            showWarningDisableAirPlaneMode()
        case UserWarning.LocationManagerDidFail:
            showWarningLocationManagerDidFail()
        case UserWarning.LocationServicesDisabled:
            showWarningAllowLocationServices()
        case UserWarning.NoInternet:
            showWarningConnectToInternet()
        }
    }
    
    func showWarningLocationManagerDidFail(){
        let warnView: ITVWarningLocationManagerDidFailView = UIView.fromNib()
        warnView.frame = self.view.bounds
        warnView.setupDefault()
        warnView.dismissWarningButton.addTarget(self, action: #selector(TimerViewController.dismissWarning), for: .touchUpInside)
        
        self.view.addSubview(warnView)
        
        UIView.animate(withDuration: 0.4) {
            self.navigationController?.isNavigationBarHidden = true
            warnView.visualEffectsView.effect = UIBlurEffect(style: .light)
            warnView.informationView.alpha = 1.0
            warnView.informationView.transform =  CGAffineTransform.identity
        }
    }
    
    
    func showWarningDisableAirPlaneMode(){
        let warnView: ITVWarningDisableAirPlaneModeView = UIView.fromNib()
        warnView.frame = self.view.bounds
        warnView.setupDefault()
        warnView.dismissWarningButton.addTarget(self, action: #selector(TimerViewController.dismissWarning), for: .touchUpInside)
        
        self.view.addSubview(warnView)
        
        UIView.animate(withDuration: 0.4) {
            self.navigationController?.isNavigationBarHidden = true
            warnView.visualEffectsView.effect = UIBlurEffect(style: .light)
            warnView.informationView.alpha = 1.0
            warnView.informationView.transform =  CGAffineTransform.identity
        }
    }
    func showWarningAllowLocationServices(){
        let warnView: ITVWarningAllowLocationServicesView = UIView.fromNib()
        warnView.frame = self.view.bounds
        warnView.setupDefault()
        warnView.dismissWarningButton.addTarget(self, action: #selector(TimerViewController.dismissWarning), for: .touchUpInside)
        
        self.view.addSubview(warnView)
        
        UIView.animate(withDuration: 0.4) {
            self.navigationController?.isNavigationBarHidden = true
            warnView.visualEffectsView.effect = UIBlurEffect(style: .light)
            warnView.informationView.alpha = 1.0
            warnView.informationView.transform =  CGAffineTransform.identity
        }
    }
    
    func showWarningConnectToInternet(){
        let warnView: ITVWarningConnectToInternetView = UIView.fromNib()
        warnView.frame = self.view.bounds
        warnView.setupDefault()
        warnView.dismissWarningButton.addTarget(self, action: #selector(TimerViewController.dismissWarning), for: .touchUpInside)
        
        self.view.addSubview(warnView)
        
        UIView.animate(withDuration: 0.4) {
            self.navigationController?.isNavigationBarHidden = true
            warnView.visualEffectsView.effect = UIBlurEffect(style: .light)
            warnView.informationView.alpha = 1.0
            warnView.informationView.transform =  CGAffineTransform.identity
        }
    }
    
    func dismissWarning() {
        if let warnView = self.view.viewWithTag(1) {
            UIView.animate(withDuration: 0.3, animations: {
                self.navigationController?.isNavigationBarHidden = false
                warnView.alpha = 0.0
            }) {(success: Bool) in
                warnView.removeFromSuperview()
            }
        }
    }
}
