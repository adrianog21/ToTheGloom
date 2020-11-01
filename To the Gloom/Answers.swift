//
//  Answers.swift
//  To the Gloom
//
//  Created by Adriano Gatto on 02/04/2020.
//  Copyright © 2020 Adriano Gatto. All rights reserved.
//

import Foundation

var answerMadonna = String()

func cristo(porco : String)
{
    answerMadonna = porco
    print("mannagia cristo \(answerMadonna)")
    
}

class Answer : Any {
    
    var answerZ = String()

    func setAnswer(answer2 : String)
    {
        answerZ = answer2
        print("woooooooooooooooooooooooooooooooooooooooooooo \(answerZ)")
        cristo(porco: answerZ)
    }
    
    func getAnswer() -> String{
        return answerZ
    }
}
