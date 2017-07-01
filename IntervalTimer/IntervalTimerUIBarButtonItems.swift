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
        
        let imageView = UIImageView(frame:NAVBAR_ADDIMAGE_CGRECT)
        imageView.image = UIImage(named: NAVBAR_ADDIMAGE)
        
        let button = UIButton(frame: NAVBAR_BUTTONS_CGRECT)
        button.addTarget(target, action: selector, for: .touchUpInside)
        
        let view = UIView(frame: DUMMY_CGRECT)
        view.addSubview(imageView)
        view.addSubview(button)
        
        return UIBarButtonItem(customView: view)
    }
    func leftTitle() -> UIBarButtonItem {
        
        let label = UILabel(frame: NAVBAR_LEFTTITLE_LABEL_CGRECT)
        label.text = NAVBAR_LEFTTITLE
        label.font = NAVBAR_LEFTRIGHT_FONT
        label.textColor = IntervalTimerColors.Orange
        
        let view = UIView(frame: DUMMY_CGRECT)
        view.addSubview(label)
        
        return UIBarButtonItem(customView: view)
    }
    func backButton(target: UIViewController, selector: Selector) -> UIBarButtonItem {
        
        let imageView = UIImageView(frame: NAVBAR_BACKIMAGE_CGRECT)
        imageView.image = UIImage(named: NAVBAR_BACKIMAGE)
        
        let button = UIButton(frame: NAVBAR_BUTTONS_CGRECT)
        button.addTarget(target, action: selector, for: .touchUpInside)
        
        let label = UILabel(frame: NAVBAR_BACKTITLE_LABEL_CGRECT)
        label.text = NAVBAR_BACKTITLE
        label.font = NAVBAR_LEFTRIGHT_FONT
        label.textColor = IntervalTimerColors.Orange
        
        let view = UIView(frame: DUMMY_CGRECT)
        view.addSubview(imageView)
        view.addSubview(button)
        view.addSubview(label)
        
        return UIBarButtonItem(customView: view)
    }
    func cancelButton(target: UIViewController, selector: Selector) -> UIBarButtonItem {
        //return customBarCancelButton(frame: NAVBAR_SAVEICON_CGRECT, target: target, selector: selector)
        
        let button = UIButton(frame: NAVBAR_CANCELBUTTONS_CGRECT)
        button.addTarget(target, action: selector, for: .touchUpInside)
        button.transform = CGAffineTransform(translationX: -15, y: 0)
        
        let label = UILabel(frame: NAVBAR_CANCELLABEL_CGRECT)
        label.text = NAVBAR_CANCELTITLE
        label.font = NAVBAR_LEFTRIGHT_FONT
        label.textColor = IntervalTimerColors.Orange
        label.transform = CGAffineTransform(translationX: -15, y: 0)
        
        let view = UIView(frame: DUMMY_CGRECT)
        view.addSubview(button)
        view.addSubview(label)
        
        return UIBarButtonItem(customView: view)
    }
    func editButton(target: UIViewController, selector: Selector) -> UIBarButtonItem {
        //return customBarCancelButton(frame: NAVBAR_SAVEICON_CGRECT, target: target, selector: selector)
        
        let button = UIButton(frame: NAVBAR_CANCELBUTTONS_CGRECT)
        button.addTarget(target, action: selector, for: .touchUpInside)
        button.transform = CGAffineTransform(translationX: -15, y: 0)
        
        let label = UILabel(frame: NAVBAR_EDITLABEL_CGRECT)
        label.text = NAVBAR_EDITTITLE
        label.font = NAVBAR_LEFTRIGHT_FONT
        label.textColor = IntervalTimerColors.Orange
        
        let view = UIView(frame: DUMMY_CGRECT)
        view.addSubview(button)
        view.addSubview(label)
        
        return UIBarButtonItem(customView: view)
    }

    
    func negativeSpace() -> UIBarButtonItem {
        let negativeSpace:UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.fixedSpace, target: nil, action: nil)
        negativeSpace.width = -20.0
        return negativeSpace
    }
    
    //    func customBackButton(target: UIViewController, selector: Selector) -> UIBarButtonItem {
    //        return customBarBackButton(imageNamed:NAVBAR_SAVEICON, frame: NAVBAR_SAVEICON_CGRECT, target: target, selector: selector)
    //    }
    //    func customBarBackButton(imageNamed:String, frame: CGRect, target: UIViewController, selector: Selector) -> UIBarButtonItem {
    //
    //        let imageView = UIImageView(frame:frame)
    //        imageView.image = UIImage(named: imageNamed)
    //
    //        let button = UIButton(frame: NAVBAR_BUTTONS_CGRECT)
    //        button.addTarget(target, action: selector, for: .touchUpInside)
    //
    //        let label = UILabel(frame: NAVBAR_BACKLABEL_CGRECT)
    //        label.text = NAVBAR_BACKLABEL_LITERAL
    //        label.font = HEADER_ACTION_FONT
    //        label.textColor = KazColor.Black
    //
    //        let view = UIView(frame: NAVBAR_BUTTONS_CGRECT)
    //        view.addSubview(imageView)
    //        view.addSubview(button)
    //        view.addSubview(label)
    //
    //        return UIBarButtonItem(customView: view)
    //    }
    //
    //
    //    func customKeyButton(target: UIViewController, selector: Selector) -> UIBarButtonItem {
    //        return customBarKeyButton(imageNamed:NAVBAR_SAVEICON, frame: NAVBAR_SAVEICON_CGRECT, target: target, selector: selector)
    //    }
    //    func customBarKeyButton(imageNamed:String, frame: CGRect, target: UIViewController, selector: Selector) -> UIBarButtonItem {
    //
    //        let imageView = UIImageView(frame:frame)
    //        imageView.image = UIImage(named: imageNamed)
    //
    //        let button = UIButton(frame: NAVBAR_BUTTONS_CGRECT)
    //        button.addTarget(target, action: selector, for: .touchUpInside)
    //
    //        let label = UILabel(frame: NAVBAR_KEYLABEL_CGRECT)
    //        label.text = NAVBAR_KEYLABEL_LITERAL
    //        label.font = HEADER_ACTION_FONT
    //        label.textColor = KazColor.Black
    //
    //        let view = UIView(frame: NAVBAR_BUTTONS_CGRECT)
    //        view.addSubview(imageView)
    //        view.addSubview(button)
    //        view.addSubview(label)
    //
    //        return UIBarButtonItem(customView: view)
    //    }
    //
    //    func customSaveButton(target: UIViewController, selector: Selector) -> UIBarButtonItem {
    //        return customBarSaveButton(imageNamed:NAVBAR_SAVEICON_GREEN, frame: NAVBAR_SAVEICON_CGRECT, target: target, selector: selector)
    //    }
    //    func customBarSaveButton(imageNamed:String, frame: CGRect, target: UIViewController, selector: Selector) -> UIBarButtonItem {
    //
    //        let imageView = UIImageView(frame:frame)
    //        imageView.image = UIImage(named: imageNamed)
    //
    //        let button = UIButton(frame: NAVBAR_BUTTONS_CGRECT)
    //        button.addTarget(target, action: selector, for: .touchUpInside)
    //
    //        let label = UILabel(frame: NAVBAR_KEYLABEL_CGRECT)
    //        label.font = HEADER_ACTION_FONT
    //        label.textColor = KazColor.Green
    //
    //        let rangeOfSave = (NAVBAR_SAVELABEL_LITERAL as NSString).range(of: NAVBAR_SAVELABEL_LITERAL)
    //        let saveAttributedString = NSMutableAttributedString(string: NAVBAR_SAVELABEL_LITERAL, attributes: [NSFontAttributeName:HEADER_ACTION_FONT])
    //        saveAttributedString.addAttribute(NSForegroundColorAttributeName, value: KazColor.Green, range: rangeOfSave)
    //        saveAttributedString.addAttribute(NSStrokeColorAttributeName, value: KazColor.Black, range:  rangeOfSave)
    //        saveAttributedString.addAttribute(NSStrokeWidthAttributeName, value: -3, range: rangeOfSave)
    //        label.attributedText = saveAttributedString
    //
    //        let view = UIView(frame: NAVBAR_BUTTONS_CGRECT)
    //        view.addSubview(imageView)
    //        view.addSubview(button)
    //        view.addSubview(label)
    //
    //        return UIBarButtonItem(customView: view)
    //    }
    //
    //
    //    func customCancelButton(target: UIViewController, selector: Selector) -> UIBarButtonItem {
    //        return customBarCancelButton(frame: NAVBAR_SAVEICON_CGRECT, target: target, selector: selector)
    //    }
    //    func customBarCancelButton(frame: CGRect, target: UIViewController, selector: Selector) -> UIBarButtonItem {
    //
    //        let button = UIButton(frame: NAVBAR_CANCELBUTTONS_CGRECT)
    //        button.addTarget(target, action: selector, for: .touchUpInside)
    //        button.transform = CGAffineTransform(translationX: -15, y: 0)
    //
    //        let label = UILabel(frame: NAVBAR_CANCELLABEL_CGRECT)
    //        label.font = HEADER_ACTION_FONT
    //        label.textColor = KazColor.RedCancelTextLabel
    //        label.transform = CGAffineTransform(translationX: -15, y: 0)
    //
    //        let rangeOfCancel = (UI_ALERT_CANCEL as NSString).range(of: UI_ALERT_CANCEL)
    //        let cancelAttributedString = NSMutableAttributedString(string: UI_ALERT_CANCEL, attributes: [NSFontAttributeName:HEADER_ACTION_FONT])
    //        cancelAttributedString.addAttribute(NSForegroundColorAttributeName, value: KazColor.RedCancelTextLabel, range: rangeOfCancel)
    //        cancelAttributedString.addAttribute(NSStrokeColorAttributeName, value: KazColor.Black, range:  rangeOfCancel)
    //        cancelAttributedString.addAttribute(NSStrokeWidthAttributeName, value: -3, range: rangeOfCancel)
    //        label.attributedText = cancelAttributedString
    //
    //        let view = UIView(frame: NAVBAR_BUTTONS_CGRECT)
    //        view.addSubview(button)
    //        view.addSubview(label)
    //
    //        return UIBarButtonItem(customView: view)
    //    }
    //
    //    func customNumberOfNotesButton(numberOfNotes: String, target: UIViewController) -> UIBarButtonItem {
    //        return customBarNumberOfNotesButton(numberOfNotes: numberOfNotes, frame: NAVBAR_SAVEICON_CGRECT, target: target)
    //    }
    //    func customBarNumberOfNotesButton(numberOfNotes: String, frame: CGRect, target: UIViewController) -> UIBarButtonItem {
    //
    //        let label = UILabel(frame: NAVBAR_NUMBEROFNOTES_CGRECT)
    //        label.text = numberOfNotes
    //        label.textAlignment = .left
    //        label.font = HEADER_ACTION_FONT
    //        label.textColor = KazColor.Black
    //
    //        let view = UIView(frame: NAVBAR_BUTTONS_CGRECT)
    //        view.addSubview(label)
    //
    //        return UIBarButtonItem(customView: view)
    //    }
    //
    //    func customNumberOfKeysButton(numberOfKeys: String, target: UIViewController) -> UIBarButtonItem {
    //        return customBarNumberOfKeysButton(numberOfKeys: numberOfKeys, frame: NAVBAR_SAVEICON_CGRECT, target: target)
    //    }
    //    func customBarNumberOfKeysButton(numberOfKeys: String, frame: CGRect, target: UIViewController) -> UIBarButtonItem {
    //
    //        let label = UILabel(frame: NAVBAR_NUMBEROFNOTES_CGRECT)
    //        label.text = numberOfKeys
    //        label.textAlignment = .left
    //        label.font = HEADER_ACTION_FONT
    //        label.textColor = KazColor.Black
    //
    //        let view = UIView(frame: NAVBAR_BUTTONS_CGRECT)
    //        view.addSubview(label)
    //
    //        return UIBarButtonItem(customView: view)
    //    }
    
}
