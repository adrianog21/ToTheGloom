//
//  MainScreen.swift
//  To the Gloom
//
//  Created by Adriano Gatto on 30/03/2020.
//  Copyright © 2020 Adriano Gatto. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit
import GameplayKit

class MainScreen: UIViewController{
    
    let defaults = UserDefaults.standard
    var levelScore = userData()
    
    @IBOutlet weak var score: UILabel!
    
    
    override func viewDidLoad() {
           super.viewDidLoad()
    
        let highscore = Int(levelScore.getHighScore() * 100)
        score.text = "\(highscore)"
    self.navigationItem.setHidesBackButton(true, animated: false)
        
    }
}

