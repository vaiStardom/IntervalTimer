//
//  IntervalTimerUIApplication.swift
//  IntervalTimer
//
//  Created by Paul Addy on 2017-07-06.
//  Copyright © 2017 Paul Addy. All rights reserved.
//

import UIKit

class IntervalTimerUIApplication: UIApplication {
}
extension UIApplication {
    static func topViewController(base: UIViewController? = UIApplication.shared.delegate?.window??.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return topViewController(base: nav.visibleViewController)
        }
        if let tab = base as? UITabBarController, let selected = tab.selectedViewController {
            return topViewController(base: selected)
        }
        if let presented = base?.presentedViewController {
            return topViewController(base: presented)
        }
        return base
    }
}

