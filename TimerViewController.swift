//
//  TimerViewController.swift
//  IntervalTimer
//
//  Created by Paul Addy on 2017-06-30.
//  Copyright © 2017 Paul Addy. All rights reserved.
//

import UIKit

class TimerViewController: UIViewController {
    
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var cancelImageView: UIImageView!
    @IBOutlet weak var startPauseResumeImageView: UIImageView!
    
    @IBOutlet weak var startPauseResumeButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var timerNameLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var timerMillisecondsLabel: UILabel!
    @IBOutlet weak var weatherTemperatureLabel: UILabel!

    @IBOutlet weak var testLabel: UILabel!

    var totalSeconds = 3602 //seconds
    var startPauseResume : (Bool, Bool, Bool) = (false, false, false)
    var hoursMinutesSeconds : (Bool, Bool, Bool) = (false, false, false)
    var startTime = TimeInterval()
    var timer = Timer()
    
}
//MARK: Actions
extension TimerViewController{
    @IBAction func startPauseResumeTimer(_ sender: Any) {
        if startPauseResume == (true, false, false) { //start the timer
            runTimer()
            aesthetics_timerStart()
            startPauseResume = (false, true, false)
        } else if startPauseResume == (false, true, false) { //pause the timer
            
            aesthetics_timerPause()
            startPauseResume = (false, false, true)
        } else if startPauseResume == (false, false, true) { //resume the timer
            aesthetics_timerResume()
            startPauseResume = (false, true, false)
        }
    }
    @IBAction func cancel(_ sender: UIButton) {
        startPauseResume = (true, false, false)
        timer.invalidate()
        aesthetics_timerCancel()
    }
    func back(){
        _ = navigationController?.popViewController(animated: true)
    }
    func edit(){}
}
//MARK: Helpers
extension TimerViewController{
    
    func runTimer(){
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(TimerViewController.updateTime), userInfo: nil, repeats: true)
        startTime = Date.timeIntervalSinceReferenceDate + TimeInterval(totalSeconds)
    }

    func updateTime(){
        let currentTime = Date.timeIntervalSinceReferenceDate
        var elapsedTime: TimeInterval = currentTime - startTime
        
        if elapsedTime >= 0 {
            timer.invalidate()
            aesthetics_timerCancel()
            //TODO: send alert and start next interval
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
        let strFraction4 = String(format: "%02i", abs(fraction3))
        
        //add the leading zero for minutes, seconds and millseconds and store them as string constants
        let strHours = String(format: "%02d", abs(hours))
        let strMinutes = String(format: "%02d", abs(minutes))
        let strSeconds = String(format: "%02d", abs(seconds))
        
        //concatenate minutes, seconds and milliseconds assign assign to labels
        timerMillisecondsLabel.text = "\(strFraction4)"
        testLabel.text = "\(strHours):\(strMinutes):\(strSeconds)"
    }

    func intervalTimeFont(seconds: Int) -> UIFont? {
        if seconds >= 3600 {
            hoursMinutesSeconds = (true, false, false)
            return ViewFont.TimerHours
        } else if seconds < 3600 && seconds > 60 {
            hoursMinutesSeconds = (false, true, false)
            return ViewFont.TimerMinutes
        } else {
            hoursMinutesSeconds = (false, false, true)
            return ViewFont.TimerSeconds
        }
    }
}
//MARK: Aesthetics
extension TimerViewController{
    func aesthetics_initial(){
        //timerLabel.font = intervalTimeFont(seconds: totalSeconds)
        timerNameLabel.font = ViewFont.TimerName
        weatherTemperatureLabel.font = ViewFont.TimerTemperature
        cancelButton.isEnabled = false
    }
    func aesthetics_timerStart(){
        cancelButton.isEnabled = true
        startPauseResumeImageView.image = UIImage(named: "pause")
        //startPauseResumeButton.setImage(UIImage(named: "pause"), for: .normal)
    }
    func aesthetics_timerPause(){
        cancelButton.isEnabled = true
        startPauseResumeImageView.image = UIImage(named: "resume")
        //startPauseResumeButton.setImage(UIImage(named: "resume"), for: .normal)
    }
    func aesthetics_timerResume(){
        cancelButton.isEnabled = true
        startPauseResumeImageView.image = UIImage(named: "pause")
        //startPauseResumeButton.setImage(UIImage(named: "pause"), for: .normal)
    }
    func aesthetics_timerCancel(){
        cancelButton.isEnabled = false
        startPauseResumeImageView.image = UIImage(named: "start")
        //startPauseResumeButton.setImage(UIImage(named: "start"), for: .normal)
        testLabel.text = "0"
        timerMillisecondsLabel.text = "00"
    }
}
//MARK: Life-cycle
extension TimerViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavBar()
        startPauseResume = (true, false, false)
        timerNameLabel.text = "Peak 8"
        aesthetics_initial()
        
        testLabel.font = SystemFont.RegularMonospaced17
        
        //TODO: If timer is set to show weather {..do all the below...}
        //TODO: call this when user switches on weather for the first time
        IntervalTimerUser.sharedInstance.firstTimeLocationUsage()

        //Only register if user wants weather for this timer
        registerNotifications() //will register at first weather use
        
        if IntervalTimerUser.sharedInstance.thisShouldUpdateWeather! {
            //TODO: call this when user starts a timer
            IntervalTimerUser.sharedInstance.startUpdatingLocationManager()
            
            print("--------> TimerViewController viewDidLoad() attempting to set weather")
            IntervalTimerCurrentWeather.getWeatherByPriority()
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
//MARK: - Notifications
extension TimerViewController{
    func registerNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(TimerViewController.didGetLatitudeLongitude(_:)), name:NSNotification.Name(rawValue: "didGetLattitudeLongitude"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(TimerViewController.didGetCityAndCountryShortName(_:)), name:NSNotification.Name(rawValue: "didGetCityAndCountryShortName"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(TimerViewController.didGetCityId(_:)), name:NSNotification.Name(rawValue: "didGetCityId"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(TimerViewController.didGetCurrentWeather(_:)), name:NSNotification.Name(rawValue: "didGetCurrentWeather"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(TimerViewController.canAttemptWeatherUpdate(_:)), name:NSNotification.Name(rawValue: "canAttemptWeatherUpdate"), object: nil)
    }
}
//MARK: - Weather Management
extension TimerViewController{
    func canAttemptWeatherUpdate(_ notification: Notification){
        print("--------> TimerViewController canAttemptWeatherUpdate notification received")
        IntervalTimerCurrentWeather.getWeatherByPriority()
    }
    func didGetCurrentWeather(_ notification: Notification){

        guard let theTemperature = IntervalTimerUser.sharedInstance.thisCurrentWeather?.thisTemperature else {
            return
        }
        
        guard let theImage = UIImage(named: (IntervalTimerUser.sharedInstance.thisCurrentWeather?.thisIcon)!) else {
            return
        }
        weatherTemperatureLabel.text = theTemperature
        weatherImageView.image = theImage
        
        //Weather updated, no need to update location until 3 hrs have passed or user has moved 1KM
        IntervalTimerUser.sharedInstance.thisShouldUpdateWeather = false
        IntervalTimerUser.sharedInstance.stopUpdatingLocationManager()
    }
    func didGetCityId(_ notification: Notification){
        IntervalTimerCurrentWeather.getWeatherByCityId()
    }
    func didGetCityAndCountryShortName(_ notification: Notification){
        IntervalTimerCurrentWeather.getWeatherByLocationName()
    }
    func didGetLatitudeLongitude(_ notification: Notification){
        IntervalTimerCurrentWeather.getWeatherByCoordinates()
    }
}
//MARK: - Navigation Bar Management
extension TimerViewController {
    func configureNavBar(){
        self.navigationItem.hidesBackButton = true
        
        let backButton = IntervalTimerUIBarButtonItem().backButton(target: self, selector: #selector(TimerViewController.back))
        self.navigationItem.leftBarButtonItems = [backButton]
        
        let negativeSpace = IntervalTimerUIBarButtonItem().negativeSpace()
        let editButton = IntervalTimerUIBarButtonItem().editButton(target: self, selector: #selector(TimerViewController.edit))
        self.navigationItem.rightBarButtonItems = [negativeSpace, editButton]
    }
}
