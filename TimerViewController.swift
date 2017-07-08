//
//  TimerViewController.swift
//  IntervalTimer
//
//  Created by Paul Addy on 2017-06-30.
//  Copyright © 2017 Paul Addy. All rights reserved.
//

import UIKit

class TimerViewController: UIViewController {
    
    @IBOutlet weak var startPauseResumeButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var timerNameLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var timerMillisecondsLabel: UILabel!
    
    @IBOutlet weak var weatherTemperatureLabel: UILabel!
    @IBOutlet weak var weatherImageView: UIImageView!
    
    var currentWeather: IntervalTimerCurrentWeather?
    
    var timer = Timer()
    var totalSeconds = 60 //seconds
    var startPauseResume : (Bool, Bool, Bool) = (false, false, false)
    var hoursMinutesSeconds : (Bool, Bool, Bool) = (false, false, false)
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
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    func updateTimer(){
        if totalSeconds < 1 {
            timer.invalidate()
            // send alert and start next interval
        } else {
            totalSeconds -= 1
            timerLabel.text = timeString(time: TimeInterval(totalSeconds))
        }
    }
    func timeString(time: TimeInterval?) -> String? {
        
        guard let totalSecondsLeft = time else {
            return nil
        }
        
        let hours = Int(totalSecondsLeft) / 3600
        let minutes = Int(totalSecondsLeft) / 60 % 60
        let seconds = Int(totalSecondsLeft) % 60
        
        //timerLabel.font = intervalTimeFont(seconds: totalSecondsLeft)
        
        if hours > 0 {
            //            timerLabel.font = intervalTimeFont(seconds: totalSecondsLeft)
            return String(format: "%02i:%02i:%02i", minutes, seconds)
        } else if hours == 0 {
            return String(format: "%02i:%02i", minutes, seconds)
        } else if minutes == 0 {
            return String(format: "%02i", seconds)
        } else {
            return ""
        }
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
        timerLabel.font = intervalTimeFont(seconds: totalSeconds)
        timerNameLabel.font = ViewFont.TimerName
        weatherTemperatureLabel.font = ViewFont.TimerTemperature
        cancelButton.isEnabled = false
    }
    func aesthetics_timerStart(){
        cancelButton.isEnabled = true
        startPauseResumeButton.setImage(UIImage(named: "pause"), for: .normal)
    }
    func aesthetics_timerPause(){
        cancelButton.isEnabled = true
        startPauseResumeButton.setImage(UIImage(named: "resume"), for: .normal)
    }
    func aesthetics_timerResume(){
        cancelButton.isEnabled = true
        startPauseResumeButton.setImage(UIImage(named: "pause"), for: .normal)
    }
    func aesthetics_timerCancel(){
        cancelButton.isEnabled = false
        startPauseResumeButton.setImage(UIImage(named: "start"), for: .normal)
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
        
        
        //TODO: call this when user switches on weather for the first time
        IntervalTimerUser.sharedInstance.firstTimeLocationUsage()
        
        //TODO: call this when user starts a timer
        IntervalTimerUser.sharedInstance.startUpdatingLocationManager()
        
        //delete this when no longer usefull:
        registerNotifications() //will register at first weather use

        
        
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
//MARK: - Weather Notifications
extension TimerViewController{
    func registerNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(TimerViewController.didGetLatitudeLongitude(_:)), name:NSNotification.Name(rawValue: "didGetLattitudeLongitude"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(TimerViewController.didGetCityAndCountryShortName(_:)), name:NSNotification.Name(rawValue: "didGetCityAndCountryShortName"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(TimerViewController.didGetCityId(_:)), name:NSNotification.Name(rawValue: "didGetCityId"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(TimerViewController.didGetCurrentWeather(_:)), name:NSNotification.Name(rawValue: "didGetCurrentWeather"), object: nil)
    }
}
//MARK: weather management
extension TimerViewController{
    func didGetCurrentWeather(_ notification: Notification){

        guard let theTemperature = IntervalTimerUser.sharedInstance.thisCurrentWeather?.thisTemperature else {
            return
        }
        
        guard let theImage = UIImage(named: (IntervalTimerUser.sharedInstance.thisCurrentWeather?.thisIcon)!) else {
            return
        }
        weatherTemperatureLabel.text = theTemperature
        weatherImageView.image = theImage

        
    }
    func didGetCityId(_ notification: Notification){
        
        if IntervalTimerUser.sharedInstance.thisWeatherQuery == (true, false, false) {
            
            guard let theCityId = IntervalTimerUser.sharedInstance.thisCityId else {
                return
            }
            
            let weatherService = IntervalTimerWeatherService(apiKey: OpenWeatherApi.key, providerUrl: OpenWeatherApi.baseUrl)
            if let theCurrentWeather = weatherService?.getWeatherFor(theCityId) {
                print("--------> TimerViewController didGetCityId temperature = \(theCurrentWeather.thisTemperature)")
                
                //if weather is requested for this timer, then set it
                //setWeather(with: theCurrentWeather)

                //TODO: call this when a timer has finished running
                IntervalTimerUser.sharedInstance.stopUpdatingLocationManager()
            }
        }
    }
    func didGetCityAndCountryShortName(_ notification: Notification){
        if IntervalTimerUser.sharedInstance.thisWeatherQuery == (false, true, false) {
            guard let theCityName = IntervalTimerUser.sharedInstance.thisCity else {
                return
            }
            guard let theCountryCode = IntervalTimerUser.sharedInstance.thisIsoCountryCode else {
                return
            }
            
            print("--------> TimerViewController didGetCityAndCountryShortName theCityName= \(theCityName), theCountryCode= \(theCountryCode)")
            let weatherService = IntervalTimerWeatherService(apiKey: OpenWeatherApi.key, providerUrl: OpenWeatherApi.baseUrl)
            if let theCurrentWeather = weatherService?.getWeatherFor(theCityName, in: theCountryCode) {
                print("--------> TimerViewController didGetCityAndCountryShortName temperature = \(theCurrentWeather.thisTemperature)")
                //setWeather(with: theCurrentWeather)
            } else {
                print("--------> TimerViewController didGetCityAndCountryShortName unable to retreive temperature")
                //Try getting the weather using locality name
                IntervalTimerUser.sharedInstance.thisWeatherQuery = (false, false, true)
                NotificationCenter.default.post(name: Notification.Name(rawValue: "didGetLattitudeLongitude"), object: nil)
            }
        }
    }
    func didGetLatitudeLongitude(_ notification: Notification){
        if IntervalTimerUser.sharedInstance.thisWeatherQuery == (false, false, true) {
            guard let theLatitude = IntervalTimerUser.sharedInstance.thisLatitude else {
                return
            }
            guard let theLongitude = IntervalTimerUser.sharedInstance.thisLongitude else {
                return
            }
            
            print("--------> TimerViewController didGetLattitudeLongitude theLatitude= \(theLatitude), theLongitude= \(theLongitude)")
            let weatherService = IntervalTimerWeatherService(apiKey: OpenWeatherApi.key, providerUrl: OpenWeatherApi.baseUrl)
            if let theCurrentWeather = weatherService?.getWeatherAt(latitude: theLatitude, longitude: theLongitude){
                print("--------> TimerViewController didGetLattitudeLongitude temperature = \(theCurrentWeather.thisTemperature)")
                //setWeather(with: theCurrentWeather)
            } else {
                //TODO: if user wanted to have the weather, and we cant get it, then show a no-connection error icon in place of the weather
                print("--------> TimerViewController didGetLattitudeLongitude unable to retreive temperature")
                
            }
        }
    }

    
    
    
    
    
//    func setWeather(){
//        //TODO: will have to receive a notification from core location to advise that location has changed and trigger a weather update
//        
//        //first get location
//        
//        //second get weather
//        
//        
//        //priority 1, do we have the cityid?
//        if let theCityId = IntervalTimerUser.sharedInstance.thisCityId {
//            let weatherService = IntervalTimerWeatherService(apiKey: OpenWeatherApi.key, providerUrl: OpenWeatherApi.baseUrl)
//            if let theCurrentWeather = weatherService?.getWeatherFor(theCityId) {
//                
//                print("--------> TimerViewController setWeather() with theCityId temperature = \(String(describing: theCurrentWeather.thisTemperature))")
//                
//                guard let theTemperature = theCurrentWeather.thisTemperature else {
//                    return
//                }
//                
//                guard let theIcon = theCurrentWeather.thisIcon else {
//                    return
//                }
//                
//                weatherTemperatureLabel.text = theTemperature
//                weatherImageView.image = UIImage(named: theIcon)
//                //TODO: call this when a timer has finished running
//                IntervalTimerUser.sharedInstance.stopUpdatingLocationManager()
//            }
//        }
//        
//        //priority 2
//        if let theCityName = IntervalTimerUser.sharedInstance.thisCity,  let theCountryCode = IntervalTimerUser.sharedInstance.thisIsoCountryCode {
//            
//            let weatherService = IntervalTimerWeatherService(apiKey: OpenWeatherApi.key, providerUrl: OpenWeatherApi.baseUrl)
//            if let theCurrentWeather = weatherService?.getWeatherFor(theCityName, in: theCountryCode) {
//                
//                print("--------> TimerViewController setWeather() with city name and country temperature = \(String(describing: theCurrentWeather.thisTemperature))")
//                
//                guard let theTemperature = theCurrentWeather.thisTemperature else {
//                    return
//                }
//                
//                guard let theIcon = theCurrentWeather.thisIcon else {
//                    return
//                }
//                
//                weatherTemperatureLabel.text = theTemperature
//                weatherImageView.image = UIImage(named: theIcon)
//                //TODO: call this when a timer has finished running
//                IntervalTimerUser.sharedInstance.stopUpdatingLocationManager()
//                
//                
//            }
//            
//        }
//
//        //priority 3
//        if let theLatitude = IntervalTimerUser.sharedInstance.thisLatitude, let theLongitude = IntervalTimerUser.sharedInstance.thisLongitude {
//            let weatherService = IntervalTimerWeatherService(apiKey: OpenWeatherApi.key, providerUrl: OpenWeatherApi.baseUrl)
//            if let theCurrentWeather = weatherService?.getWeatherAt(latitude: theLatitude, longitude: theLongitude){
//                print("--------> TimerViewController setWeather() with city name and country temperature = \(String(describing: theCurrentWeather.thisTemperature))")
//                
//                guard let theTemperature = theCurrentWeather.thisTemperature else {
//                    return
//                }
//                
//                guard let theIcon = theCurrentWeather.thisIcon else {
//                    return
//                }
//                
//                weatherTemperatureLabel.text = theTemperature
//                weatherImageView.image = UIImage(named: theIcon)
//                //TODO: call this when a timer has finished running
//                IntervalTimerUser.sharedInstance.stopUpdatingLocationManager()
//            }
//        }
//    }
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
