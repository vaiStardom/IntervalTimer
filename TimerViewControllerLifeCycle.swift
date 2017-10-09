//
//  TimerViewControllerLifeCycle.swift
//  IntervalTimer
//
//  Created by Paul Addy on 2017-08-24.
//  Copyright © 2017 Paul Addy. All rights reserved.
//

import Foundation
import UIKit

//MARK: Life-cycle
extension TimerViewController{
    
    override func viewDidAppear(_ animated: Bool) {
        configureCollectionView()
        collectionView.reloadData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        timerProgressViewWidth = timerProgressView.bounds.width
        intervalProgressViewWidth = intervalProgressView.bounds.width

        registerNotifications() //will register at first weather use
        loadTimer()
        loadWeather()
        
    }
    
//    override func viewDidLayoutSubviews() {
//        timerProgressInitialLayer(withColor: ITVColors.Orange.withAlphaComponent(0.15).cgColor)
//        aesthetics_manageIntervalProgress(indicator: intervalsToRun[indexOfIntervalToRun].thisIndicator)
////        registerNotifications() //will register at first weather use
////        loadTimer()
////        loadWeather()
//    }

    override func viewWillAppear(_ animated: Bool) {
        timerProgressInitialLayer(withColor: ITVColors.Orange.withAlphaComponent(0.15).cgColor)
        aesthetics_manageIntervalProgress(indicator: intervalsToRun[indexOfIntervalToRun].thisIndicator)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
