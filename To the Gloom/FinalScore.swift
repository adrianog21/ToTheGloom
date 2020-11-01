//
//  FinalScore.swift
//  To the Gloom
//
//  Created by Adriano Gatto on 27/03/2020.
//  Copyright © 2020 Adriano Gatto. All rights reserved.
//

import Foundation

var finalScore2 = Float()

func setScore2(score : Float)
{
    finalScore2 = score
}

class scoreOver : Any {
    
    var finalScore = Float()

    func setScore(score : Float)
    {
        finalScore = score
        setScore2(score: finalScore * 100)
    }
}

struct userData {
    
    let defaults = UserDefaults.standard
    
    var newScore = Float()
    var bestScore = Float()
    
    mutating func setHighScore(highScore : Float)
    {
        bestScore = defaults.float(forKey: "HighScore")
        
        if(highScore > bestScore){
        defaults.set(highScore, forKey: "HighScore")
            bestScore = defaults.float(forKey: "HighScore")

        print("saved \(highScore)")
        }
    }
    
    mutating func getHighScore() -> Float {
        newScore = defaults.float(forKey: "HighScore")
        print("get \(newScore)")
        return newScore
    }
}
