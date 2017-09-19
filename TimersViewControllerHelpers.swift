////
////  TimersViewControllerHelpers.swift
////  IntervalTimer
////
////  Created by Paul Addy on 2017-09-19.
////  Copyright © 2017 Paul Addy. All rights reserved.
////
//
//import Foundation
//import UIKit
//
//extension TimersViewController{
//
//    func addGradientLayer(cell: UITableViewCell) -> CAGradientLayer {
//        gradientLayer.frame = cell.bounds
//        let color1 = UIColor(white: 1.0, alpha: 0.2).cgColor as CGColor
//        let color2 = UIColor(white: 1.0, alpha: 0.1).cgColor as CGColor
//        let color3 = UIColor.clear.cgColor as CGColor
//        let color4 = UIColor(white: 0.0, alpha: 0.1).cgColor as CGColor
//        
//        gradientLayer.colors = [color1, color2, color3, color4]
//        gradientLayer.locations = [0.0, 0.01, 0.95, 1.0]
//        
//        return gradientLayer
////        layer.insertSublayer(gradientLayer, at: 0)
//    
//    }
//    
//    func colorForIndex(index: Int) -> UIColor{
//        let itemCount = (ITVUser.sharedInstance.thisTimers?.count)! - 1
//        let val = (CGFloat(index) / CGFloat(itemCount)) * 0.6
//        return UIColor(red: 1.0, green: val, blue: 0.0, alpha: 1.0)
//    }
//}
