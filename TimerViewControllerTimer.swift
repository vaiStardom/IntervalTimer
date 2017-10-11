//
//  TimerViewControllerTimer.swift
//  IntervalTimer
//
//  Created by Paul Addy on 2017-08-20.
//  Copyright © 2017 Paul Addy. All rights reserved.
//

import Foundation
import UIKit

//MARK: Timer functions
extension TimerViewController{
    func runIntervalTimer(){
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(TimerViewController.updateTime), userInfo: nil, repeats: true)
        startTime = Date.timeIntervalSinceReferenceDate + TimeInterval(ellapsedSeconds)
    }
    
    @objc func updateTime(){
        let currentTime = Date.timeIntervalSinceReferenceDate
        var elapsedTime: TimeInterval = currentTime - startTime
        
        ellapsedSeconds = abs(elapsedTime)
        dblEllapsedTime = Double(elapsedTime)
        
        if elapsedTime >= 0 {

            intervalProgress(progress: intervalProgressViewWidth!)
            
            indexOfIntervalToRun += 1
            
            guard indexOfIntervalToRun < intervalsToRun.count else {
                //timer completed running all its intervals
                timer.invalidate()
                aesthetics_timerCancel() //this shoulds happen at the end of the very last interval
                intervalProgressLabel.text = Litterals.ProgressComplete
                timerProgressLabel.text = Litterals.ProgressComplete
                return
            }
            
            guard let theSeconds = intervalsToRun[indexOfIntervalToRun].thisSeconds else {
                return
            }
            
            print("new interval, intervalTime/ellapsedSeconds = \(theSeconds)")
            ellapsedSeconds = theSeconds //set timer to the next interval
            intervalTime = theSeconds
            dblEllapsedTime = 0.0
            
            startTime = Date.timeIntervalSinceReferenceDate + TimeInterval(ellapsedSeconds)
            aesthetics_manageIntervalProgress(indicator: intervalsToRun[indexOfIntervalToRun].thisIndicator)
            
            configureCollectionView()
            
            //TODO: load next interval into pulse
            
            //delete the loaded interval from the collection view,
            let firstIndexPath = IndexPath(row: 0, section: 0)
            if self.collectionView.cellForItem(at: firstIndexPath) != nil {
                intervalsToRun.remove(at: firstIndexPath.row)
                self.collectionView.deleteItems(at: [firstIndexPath])
            }
        }
        
        let hours = Int(elapsedTime / 3600.0) % 24
        elapsedTime -= (TimeInterval(hours) * 3600.0)
        
        //calculate the minutes in elapsed time.
        let minutes = Int(elapsedTime / 60.0)
        elapsedTime -= (TimeInterval(minutes) * 60)
        
        //calculate the seconds in elapsed time.
        let seconds = Int(elapsedTime)
        elapsedTime -= TimeInterval(seconds)
        
        //find out the fraction of milliseconds to be displayed.
        let fraction = Int(elapsedTime * 100)
        let fraction2 = String(format: "%02d", fraction)
        let fraction3 = Int(fraction2)!
        let strMilleseconds = String(format: "%02i", abs(fraction3))
        
        //add the leading zero for minutes, seconds and millseconds and store them as string constants
        let strHours = String(format: "%02d", abs(hours))
        let strMinutes = String(format: "%02d", abs(minutes))
        let strSeconds = String(format: "%02d", abs(seconds))
        
        aesthetics_timerLabels()
        
        timerHoursLabel.text = "\(strHours):\(strMinutes):\(strSeconds)"
        
        //Minutes labels
        timerMinutesLabel.text = "\(strMinutes):\(strSeconds)"
        timerMillisecondsForMinutesLabel.text = ".\(strMilleseconds)"
        
        //Seconds labels
        timerSecondsLabel.text = "\(strSeconds)"
        timerMillisecondsForSecondsLabel.text = ".\(strMilleseconds)"
        
        let intervalPercentComplete = CGFloat(100.0 - ((abs(dblEllapsedTime) * 100.0) / intervalTime))
        let newProgressWidth = intervalProgressViewWidth! * (intervalPercentComplete / 100)
        intervalProgress(progress: newProgressWidth)
        intervalProgressLabel.text = "\(Int(intervalPercentComplete))%"

        print("dblEllapsedTime % = \(((abs(dblEllapsedTime) * 100.0) / intervalTime)), newProgressWidth = \(newProgressWidth)")
    }
    func intervalProgress(progress: CGFloat) {
        UIView.animate(withDuration: 0.0001, delay: 0.0, options: .curveEaseOut, animations: {
            self.intervalForegroundProgressView.frame.size = CGSize(width: progress, height: self.intervalProgressView.frame.height)
        }, completion: nil)
    }

    func stopTimer(){
        startPauseResume = (true, false, false)
        timer.invalidate()
        aesthetics_timerCancel()
    }
}
