//
//  GameOverView.swift
//  To the Gloom
//
//  Created by Adriano Gatto on 27/03/2020.
//  Copyright © 2020 Adriano Gatto. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit
import GameplayKit

class GameOverView: UIViewController {
    
    @IBOutlet weak var scoreImage: UIImageView!
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet weak var levelText: UILabel!
    @IBOutlet weak var text2: UILabel!
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var replayButton: UIButton!
    
    
    var score2 = userData()
    
    @IBOutlet weak var hmmmmmm: UIImageView!
    var angle = CGFloat()
    
    var score = scoreOver()
    
     override func viewDidLoad() {
           print("second VC Loaded")
        
        scoreLabel.text = "\(Int(finalScore2))"
        if finalScore2 == 100 {
            levelText.text = "LEVEL COMPLETE"
            text2.text = "LEVEL COMPLETE"
        }else{
            levelText.text = "Try Again"
            text2.text = "Try Again"
        }
        print("\(Int(score2.getHighScore()))")
        
//        UIView.animate(withDuration: 1.0, animations: {
//            self.scoreImage.transform = CGAffineTransform(rotationAngle: (180.0 * .pi) / 180.0)
//        })
        
        _ = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(rotate), userInfo: nil, repeats: true)
        
       }
    
    
    @objc func rotate(){

        angle += 0.005
        
        backButton.transform = CGAffineTransform(rotationAngle: CGFloat(-angle/1.5))
        
        scoreImage.transform = CGAffineTransform(rotationAngle: CGFloat(angle/1.5))
        hmmmmmm.transform = CGAffineTransform(rotationAngle: CGFloat(-angle/1.5))
        
        replayButton.transform = CGAffineTransform(rotationAngle: CGFloat(angle/1.5))

    }
    
//    @IBAction func back(_ sender: Any) {
//        let VC = self.storyboard?.instantiateViewController(withIdentifier: "Main") as! MainScreen
//        
//        self.navigationController?.present(VC, animated: false, completion: nil)
//    }
//    
//    @IBAction func replay(_ sender: Any) {
//        let VC = self.storyboard?.instantiateViewController(withIdentifier: "GamePlay") as! GameViewController
//        self.navigationController?.present(VC, animated: false, completion: nil)
//    }
//    
  
}
