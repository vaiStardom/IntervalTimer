//
//  IntervalTimerUIBarButtonItems.swift
//  IntervalTimer
//
//  Created by Paul Addy on 2017-06-25.
//  Copyright © 2017 Paul Addy. All rights reserved.
//

import UIKit

//TODO: Refactor this whole file.
class IntervalTimerUIBarButtonItem: UIBarButtonItem {
    func addButton(target: UIViewController, selector: Selector) -> UIBarButtonItem {
        
        let imageView = UIImageView(frame:NavigationBarCgRect.AddImage)
        imageView.image = UIImage(named: NavigationBarImage.Add)
        
        let button = UIButton(frame: NavigationBarCgRect.Buttons)
        button.addTarget(target, action: selector, for: .touchUpInside)
        
        let view = UIView(frame: NavigationBarCgRect.Dummy)
        view.addSubview(imageView)
        view.addSubview(button)
        
        return UIBarButtonItem(customView: view)
    }
    func leftTitle() -> UIBarButtonItem {
        
        let label = UILabel(frame: NavigationBarCgRect.LeftLabel)
        label.text = NavigationBarLitterals.BackToTimers
        label.font = NavigationBarFont.LeftRight
        label.textColor = IntervalTimerColors.Orange
        
        let view = UIView(frame: NavigationBarCgRect.Dummy)
        view.addSubview(label)
        
        return UIBarButtonItem(customView: view)
    }
    func backButton(target: UIViewController, selector: Selector) -> UIBarButtonItem {
        
        let imageView = UIImageView(frame: NavigationBarCgRect.BackImage)
        imageView.image = UIImage(named: NavigationBarImage.Back)
        
        let button = UIButton(frame: NavigationBarCgRect.Buttons)
        button.addTarget(target, action: selector, for: .touchUpInside)
        
        let label = UILabel(frame: NavigationBarCgRect.BackLabel)
        label.text = NavigationBarLitterals.Back
        label.font = NavigationBarFont.LeftRight
        label.textColor = IntervalTimerColors.Orange
        
        let view = UIView(frame: NavigationBarCgRect.Dummy)
        view.addSubview(imageView)
        view.addSubview(button)
        view.addSubview(label)
        
        return UIBarButtonItem(customView: view)
    }
    func cancelButton(target: UIViewController, selector: Selector) -> UIBarButtonItem {
        //return customBarCancelButton(frame: NAVBAR_SAVEICON_CGRECT, target: target, selector: selector)
        
        let button = UIButton(frame: NavigationBarCgRect.CancelButton)
        button.addTarget(target, action: selector, for: .touchUpInside)
        button.transform = CGAffineTransform(translationX: -15, y: 0)
        
        let label = UILabel(frame: NavigationBarCgRect.CancelLabel)
        label.text = NavigationBarLitterals.Cancel
        label.font = NavigationBarFont.LeftRight
        label.textColor = IntervalTimerColors.Orange
        label.transform = CGAffineTransform(translationX: -15, y: 0)
        
        let view = UIView(frame: NavigationBarCgRect.Dummy)
        view.addSubview(button)
        view.addSubview(label)
        
        return UIBarButtonItem(customView: view)
    }
    func editButton(target: UIViewController, selector: Selector) -> UIBarButtonItem {
        //return customBarCancelButton(frame: NAVBAR_SAVEICON_CGRECT, target: target, selector: selector)
        
        let button = UIButton(frame: NavigationBarCgRect.CancelButton)
        button.addTarget(target, action: selector, for: .touchUpInside)
        button.transform = CGAffineTransform(translationX: -15, y: 0)
        
        let label = UILabel(frame: NavigationBarCgRect.EditLabel)
        label.text = NavigationBarLitterals.Edit
        label.font = NavigationBarFont.LeftRight
        label.textColor = IntervalTimerColors.Orange
        
        let view = UIView(frame: NavigationBarCgRect.Dummy)
        view.addSubview(button)
        view.addSubview(label)
        
        return UIBarButtonItem(customView: view)
    }

    
    func negativeSpace() -> UIBarButtonItem {
        let negativeSpace:UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.fixedSpace, target: nil, action: nil)
        negativeSpace.width = -20.0
        return negativeSpace
    }
}
