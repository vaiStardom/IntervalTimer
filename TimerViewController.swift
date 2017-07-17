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
    
    //Tittle labels
    @IBOutlet weak var weatherTemperatureLabel: UILabel!
    @IBOutlet weak var timerNameLabel: UILabel!

    //Minutes labels
    @IBOutlet weak var timerMinutesLabel: UILabel!
    @IBOutlet weak var timerMillisecondsForMinutesLabel: UILabel!
    
    //Seconds labels
    @IBOutlet weak var timerSecondsLabel: UILabel!
    @IBOutlet weak var timerMillisecondsForSecondsLabel: UILabel!
    
    @IBOutlet weak var testLabel: UILabel!

    var totalSeconds = 62 //seconds
    var ellapsedSeconds = 0.0
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
        
        aesthetics_seconds()
        
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(TimerViewController.updateTime), userInfo: nil, repeats: true)
        startTime = Date.timeIntervalSinceReferenceDate + TimeInterval(totalSeconds)
    }

    func updateTime(){
        let currentTime = Date.timeIntervalSinceReferenceDate
        var elapsedTime: TimeInterval = currentTime - startTime
        
        ellapsedSeconds = abs(elapsedTime)
        
        if elapsedTime >= 0 {
            timer.invalidate()
            aesthetics_timerCancel()
            //TODO: start next interval
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
        
        //Minutes labels
        timerMinutesLabel.text = "\(strMinutes):\(strSeconds)"
        timerMillisecondsForMinutesLabel.text = "\(strMilleseconds)"

        //Seconds labels
        timerSecondsLabel.text = "\(strSeconds)"
        timerMillisecondsForSecondsLabel.text = ".\(strMilleseconds)"
        
        testLabel.text = "\(strHours):\(strMinutes):\(strSeconds)"
    }
}
//MARK: Aesthetics
extension TimerViewController{
    func aesthetics_timerLabels(){
        if ellapsedSeconds >= 3660.0 {
            aesthetics_hours()
        } else if ellapsedSeconds >= 60.0 {
            aesthetics_minutes()
        } else {
            aesthetics_seconds()
        }
    }
    func aesthetics_initial(){
        aesthetics_setFonts()
        aesthetics_timerCancel()
        aesthetics_timerLabels()
        cancelButton.isEnabled = false
    }
    func aesthetics_minutes(){
        
        //Minutes labels
        timerMinutesLabel.isHidden = false
        timerMillisecondsForMinutesLabel.isHidden = false
        
        //Seconds labels
        timerSecondsLabel.isHidden = true
        timerMillisecondsForSecondsLabel.isHidden = true
    }

    func aesthetics_seconds(){
        //Minutes labels
        timerMinutesLabel.isHidden = true
        timerMillisecondsForMinutesLabel.isHidden = true
        
        //Seconds labels
        timerSecondsLabel.isHidden = false
        timerMillisecondsForSecondsLabel.isHidden = false
    }
    func aesthetics_hours(){
        //Minutes labels
        timerMinutesLabel.isHidden = true
        timerMillisecondsForMinutesLabel.isHidden = true
        
        //Seconds labels
        timerSecondsLabel.isHidden = true
        timerMillisecondsForSecondsLabel.isHidden = true
    }
    func aesthetics_timerStart(){
        cancelButton.isEnabled = true
        startPauseResumeImageView.image = UIImage(named: "pause")
        cancelImageView.image = UIImage(named: "cancel")
        cancelImageView.isOpaque = false
    }
    func aesthetics_timerPause(){
        cancelButton.isEnabled = true
        startPauseResumeImageView.image = UIImage(named: "resume")
        cancelImageView.image = UIImage(named: "cancel")
        cancelImageView.isOpaque = false
    }
    func aesthetics_timerResume(){
        cancelButton.isEnabled = true
        startPauseResumeImageView.image = UIImage(named: "pause")
        cancelImageView.image = UIImage(named: "cancel")
    }
    func aesthetics_timerCancel(){
        cancelButton.isEnabled = false
        startPauseResumeImageView.image = UIImage(named: "start")
        cancelImageView.image = UIImage(named: "cancel-opaque")
        cancelImageView.isOpaque = true
        testLabel.text = "0"
        timerMillisecondsForSecondsLabel.text = "00"
    }
    func aesthetics_setFonts(){
        timerNameLabel.font = ViewFont.TimerName
        weatherTemperatureLabel.font = ViewFont.TimerTemperature

        //Minutes labels
        timerMinutesLabel.font = ViewFont.TimerMinutes
        timerMillisecondsForMinutesLabel.font = ViewFont.TimerMilliseconds
        
        //Seconds labels
        timerSecondsLabel.font = ViewFont.TimerSeconds
        timerMillisecondsForSecondsLabel.font = ViewFont.TimerMilliseconds
    }
}
//MARK: Life-cycle
extension TimerViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavBar()
        startPauseResume = (true, false, false)
        timerNameLabel.text = "Peak 8"
        ellapsedSeconds = Double(totalSeconds)
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
