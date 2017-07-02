//
//  IntervalTimerWeatherCurrent.swift
//  IntervalTimer
//
//  Created by Paul Addy on 2017-07-02.
//  Copyright © 2017 Paul Addy. All rights reserved.
//

import Foundation

class IntervalTimerWeatherCurrent {}




//First, attempt to get weather for the city ID of user if possible using city.list.json
//api.openweathermap.org/data/2.5/weather?id=1635882&APPID=448af267f0d35a22b6e00178e163deb3
//http://api.openweathermap.org/data/2.5/weather?id=1635882&APPID=448af267f0d35a22b6e00178e163deb3
//{
//    "id": 1635882,
//    "name": "Mataram",
//    "country": "ID",
//    "coord": {
//        "lon": 116.116669,
//        "lat": -8.58333
//    }
//},

//Second attempt to get weather for the city and country (ISO 3166) of user if possible
//api.openweathermap.org/data/2.5/weather?q=Mataram,id&APPID=448af267f0d35a22b6e00178e163deb3
//http://api.openweathermap.org/data/2.5/weather?q=Mataram,id&APPID=448af267f0d35a22b6e00178e163deb3
//Mataram,id (ISO 3166)

//Third, attempt to get weather for user using coordinates
//api.openweathermap.org/data/2.5/weather?lat=-8.549790&lon=116.072037&APPID=448af267f0d35a22b6e00178e163deb3
//http://api.openweathermap.org/data/2.5/weather?lat=-8.549790&lon=116.072037&APPID=448af267f0d35a22b6e00178e163deb3
//-8.549790, 116.072037

//Using city ID
//http://api.openweathermap.org/data/2.5/weather?id=1635882&APPID=448af267f0d35a22b6e00178e163deb3
//{
//    "coord": {
//        "lon": 116.12,
//        "lat": -8.58
//    },
//    "weather": [{
//    "id": 800,
//    "main": "Clear",
//    "description": "clear sky",
//    "icon": "01d"
//    }],
//    "base": "stations",
//    "main": {
//        "temp": 304.15,
//        "pressure": 1012,
//        "humidity": 52,
//        "temp_min": 304.15,
//        "temp_max": 304.15
//    },
//    "visibility": 10000,
//    "wind": {
//        "speed": 2.1,
//        "deg": 140
//    },
//    "clouds": {
//        "all": 0
//    },
//    "dt": 1498968000,
//    "sys": {
//        "type": 1,
//        "id": 8001,
//        "message": 0.0179,
//        "country": "ID",
//        "sunrise": 1498948235,
//        "sunset": 1498990118
//    },
//    "id": 1635882,
//    "name": "Mataram",
//    "cod": 200
//}

//Using city name
//http://api.openweathermap.org/data/2.5/weather?q=Mataram,id&APPID=448af267f0d35a22b6e00178e163deb3
//{
//    "coord": {
//        "lon": 116.12,
//        "lat": -8.58
//    },
//    "weather": [{
//    "id": 800,
//    "main": "Clear",
//    "description": "clear sky",
//    "icon": "01d"
//    }],
//    "base": "stations",
//    "main": {
//        "temp": 304.15,
//        "pressure": 1012,
//        "humidity": 52,
//        "temp_min": 304.15,
//        "temp_max": 304.15
//    },
//    "visibility": 10000,
//    "wind": {
//        "speed": 2.1,
//        "deg": 140
//    },
//    "clouds": {
//        "all": 0
//    },
//    "dt": 1498968000,
//    "sys": {
//        "type": 1,
//        "id": 8001,
//        "message": 0.0154,
//        "country": "ID",
//        "sunrise": 1498948235,
//        "sunset": 1498990117
//    },
//    "id": 1635882,
//    "name": "Mataram",
//    "cod": 200
//}


//Using coordinates
//{
//    "coord": {
//        "lon": 116.07,
//        "lat": -8.55
//    },
//    "weather": [{
//    "id": 800,
//    "main": "Clear",
//    "description": "clear sky",
//    "icon": "01d"
//    }],
//    "base": "stations",
//    "main": {
//        "temp": 304.15,
//        "pressure": 1012,
//        "humidity": 52,
//        "temp_min": 304.15,
//        "temp_max": 304.15
//    },
//    "visibility": 10000,
//    "wind": {
//        "speed": 2.1,
//        "deg": 140
//    },
//    "clouds": {
//        "all": 0
//    },
//    "dt": 1498968000,
//    "sys": {
//        "type": 1,
//        "id": 8001,
//        "message": 0.0154,
//        "country": "ID",
//        "sunrise": 1498948244,
//        "sunset": 1498990133
//    },
//    "id": 7545578,
//    "name": "Jempongwareng",
//    "cod": 200
//}
