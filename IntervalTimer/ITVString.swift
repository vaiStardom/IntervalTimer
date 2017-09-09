//
//  ITVString.swift
//  IntervalTimer
//
//  Created by Paul Addy on 2017-09-09.
//  Copyright © 2017 Paul Addy. All rights reserved.
//

import Foundation

extension String{
    func containsOnlyCharactersIn(matchCharacter: String) -> Bool {
        let disallowedCharacterSet = CharacterSet(charactersIn: matchCharacter).inverted
        return self.rangeOfCharacter(from: disallowedCharacterSet) == nil
    }
}

