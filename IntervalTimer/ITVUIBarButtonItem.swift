//
//  ITVUIBarButtonItem.swift
//  IntervalTimer
//
//  Created by Paul Addy on 2017-06-25.
//  Copyright © 2017 Paul Addy. All rights reserved.
//
import UIKit

class ITVUIBarButtonItem: UIBarButtonItem {
    func addButton(target: UIViewController, selector: Selector) -> UIBarButtonItem {
        
        let imageView = UIImageView(frame:NavigationBarCgRect.AddImage)
        imageView.image = UIImage(named: NavigationBarImage.Add)
        
        let button = ITVUIButton.createButton(frame: NavigationBarCgRect.Buttons, target: target, selector: selector)
        
        let view = UIView(frame: NavigationBarCgRect.Dummy)
        view.addSubview(imageView)
        view.addSubview(button)
        
        return UIBarButtonItem(customView: view)
    }
    func leftTitle() -> UIBarButtonItem {
        
        let label = ITVUILabel.createLabel(frame: NavigationBarCgRect.LeftLabel, font: NavigationBarFont.LeftRight, text: Litterals.Timers, color: ITVColors.Orange)
        
        let view = UIView(frame: NavigationBarCgRect.Dummy)
        view.addSubview(label)
        
        return UIBarButtonItem(customView: view)
    }
    func backButton(target: UIViewController, selector: Selector) -> UIBarButtonItem {
        
        let imageView = UIImageView(frame: NavigationBarCgRect.BackImage)
        imageView.image = UIImage(named: NavigationBarImage.Back)
        
        let button = ITVUIButton.createButton(frame: NavigationBarCgRect.Buttons, target: target, selector: selector)

        let label = ITVUILabel.createLabel(frame: NavigationBarCgRect.BackLabel, font: NavigationBarFont.LeftRight, text: Litterals.Back, color: ITVColors.Orange)
        
        let view = UIView(frame: NavigationBarCgRect.Dummy)
        view.addSubview(imageView)
        view.addSubview(button)
        view.addSubview(label)
        
        return UIBarButtonItem(customView: view)
    }
    func saveButton(target: UIViewController, selector: Selector) -> UIBarButtonItem {
        
        let imageView = UIImageView(frame: NavigationBarCgRect.BackImage)
        imageView.image = UIImage(named: NavigationBarImage.Back)
        
        let button = ITVUIButton.createButton(frame: NavigationBarCgRect.Buttons, target: target, selector: selector)
        
        let label = ITVUILabel.createLabel(frame: NavigationBarCgRect.BackLabel, font: NavigationBarFont.LeftRight, text: Litterals.Save, color: ITVColors.Orange)
        
        let view = UIView(frame: NavigationBarCgRect.Dummy)
        view.addSubview(imageView)
        view.addSubview(button)
        view.addSubview(label)
        
        return UIBarButtonItem(customView: view)
    }
    func cancelButton(target: UIViewController, selector: Selector) -> UIBarButtonItem {
        
        let button = ITVUIButton.createButton(frame: NavigationBarCgRect.CancelButton, target: target, selector: selector)
        button.transform = CGAffineTransform(translationX: -15, y: 0)
        
        let label = ITVUILabel.createLabel(frame: NavigationBarCgRect.CancelLabel, font: NavigationBarFont.LeftRight, text: Litterals.Cancel, color: ITVColors.Orange)
        label.transform = CGAffineTransform(translationX: -15, y: 0)
        
        let view = UIView(frame: NavigationBarCgRect.Dummy)
        view.addSubview(button)
        view.addSubview(label)
        
        return UIBarButtonItem(customView: view)
    }
    func editButton(target: UIViewController, selector: Selector) -> UIBarButtonItem {
        
        let button = ITVUIButton.createButton(frame: NavigationBarCgRect.CancelButton, target: target, selector: selector)
        button.transform = CGAffineTransform(translationX: -15, y: 0)
        
        let label = ITVUILabel.createLabel(frame: NavigationBarCgRect.EditLabel, font: NavigationBarFont.LeftRight, text: Litterals.Edit, color: ITVColors.Orange)
        
        let view = UIView(frame: NavigationBarCgRect.Dummy)
        view.addSubview(button)
        view.addSubview(label)
        
        return UIBarButtonItem(customView: view)
    }
    func timersEditButton(target: UIViewController, selector: Selector) -> UIBarButtonItem {
        
        let button = ITVUIButton.createButton(frame: NavigationBarCgRect.CancelButton, target: target, selector: selector)
        button.transform = CGAffineTransform(translationX: 0, y: 0)
        
        let label = ITVUILabel.createLabel(frame: NavigationBarCgRect.TimersEditLabel, font: NavigationBarFont.LeftRight, text: Litterals.Edit, color: ITVColors.Orange)
        
        let view = UIView(frame: NavigationBarCgRect.Dummy)
        view.addSubview(button)
        view.addSubview(label)

        button.center = view.center

        return UIBarButtonItem(customView: view)
    }

    func rightNegativeSpace() -> UIBarButtonItem {
        let negativeSpace:UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.fixedSpace, target: nil, action: nil)
        negativeSpace.width = -20.0
        return negativeSpace
    }
    func leftNegativeSpace() -> UIBarButtonItem {
        let negativeSpace:UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.fixedSpace, target: nil, action: nil)
        negativeSpace.width = -5.0
        return negativeSpace
    }
}
