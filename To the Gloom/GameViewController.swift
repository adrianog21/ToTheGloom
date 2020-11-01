//
//  GameViewController.swift
//  To the Gloom
//
//  Created by Adriano Gatto on 24/03/2020.
//  Copyright © 2020 Adriano Gatto. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit
import AVFoundation

class GameViewController: UIViewController {
    
    let sounds = ["right", "left","center", "center","left", "right", "right", "left", "right", "left"]
    let audioSounds = ["BatLeft.mp3", "BatRight.mp3", "HootLeft.mp3", "HootRight.mp3", "GlassLeft.mp3", "GlassRight.mp3", "RockLeft.mp3", "RockRight.mp3", "WaterRight.mp3", "WaterLeft.mp3"]
    var newSound = ""
    
    var audioPlayed = 0
    var timer = Timer()
    var timer2 = Timer()
    
    var answer = Bool()
    var answer2 = false
    
    var swipeDirection = String()
    
    var timeFrame = Double.random(in: 2.5...7)
    var correctAnswer = Int(0)
    var score = scoreOver()
    var highScore = userData()
    var newScore = Float()
    
    var audioPlayer: AVAudioPlayer?
    var audioPlayer2: AVAudioPlayer?

    var number = Int()
    
    var answerDirection = "center"
    
    
    var nextAnswer = Answer()
//    var gameScene = GameScene()


    override func viewDidLoad() {
        super.viewDidLoad()
        
        playSound()
        
        
        self.navigationItem.setHidesBackButton(true, animated: false)
        // Load 'GameScene.sks' as a GKScene. This provides gameplay related content
        // including entities and graphs.
        if let scene = GKScene(fileNamed: "GameScene") {
            
            // Get the SKScene from the loaded GKScene
            if let sceneNode = scene.rootNode as! GameScene? {
                
                // Copy gameplay related content over to the scene
                sceneNode.entities = scene.entities
                sceneNode.graphs = scene.graphs
                
                // Set the scale mode to scale to fit the window
                sceneNode.scaleMode = .aspectFill
                
                // Present the scene
                if let view = self.view as! SKView? {
                    view.presentScene(sceneNode)
                    
                    view.ignoresSiblingOrder = true
                    
                    view.showsFPS = true
                    view.showsNodeCount = true
                }
            }
        }
        
//        GESTURE RECOGNIZER
//        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))
//        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))
//            
//        leftSwipe.direction = .left
//        rightSwipe.direction = .right
//
//        view.addGestureRecognizer(leftSwipe)
//        view.addGestureRecognizer(rightSwipe)
        

                
                
        //        TIMER
        timer = Timer.scheduledTimer(timeInterval: timeFrame, target: self, selector: #selector(playAudio), userInfo: nil, repeats: true)


    }
    
    func playSound() {
    //        let url = Bundle.main.url(forResource: "left", withExtension: "mp3")!
            
                 let music = Bundle.main.path(forResource: "Music.mp3", ofType: nil)
                     let url = URL(fileURLWithPath: music!)
                     do {
                         audioPlayer = try AVAudioPlayer(contentsOf: url)
                         audioPlayer?.play()

                     } catch {
                         print(error)
                     }
    }
    
    
    
    @objc func playAudio()
    {
        audioPlayed += 1
        //cambiare con arrey.count
        if(audioPlayed == sounds.count)
        {
            print("victory")
            timer.invalidate()
            gameOver()
        }
        else{
            print("play audio")
            correctAnswer += 1
        timeFrame = Double.random(in: 3...7)
            number = Int.random(in: 0..<(sounds.count))
        newSound = sounds[number]
            playNewSound(num: number)
        print("aaaaaaaaaa boh mah \(newSound)")
        
        
            timer2 = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(checkAnswer), userInfo: nil, repeats: false)
        
        }
    }
    
    @objc func checkAnswer(){
        
        print(answer2)
        print("new sound is2 \(sounds[number])")
        print("new direction2 is \(swipeDirection)")
        print("asnwer is \(answerMadonna)")
        
        answerDirection = answerMadonna
                
        if (sounds[number] == answerDirection){
            print("correct")
            print(answerDirection)
            answer2 = false
        }
        else if (sounds[number] != answerDirection)
        {
            print("you lose")
            print(answerDirection)

            timer.invalidate()
            gameOver()
        }
        nextAnswer.setAnswer(answer2: "center")
        print(answerDirection)

    }
    
    func playNewSound(num : Int){
        
        let music = Bundle.main.path(forResource: "\(audioSounds[num])", ofType: nil)
        let url = URL(fileURLWithPath: music!)
        do {
            audioPlayer2 = try AVAudioPlayer(contentsOf: url)
            audioPlayer2?.play()

        } catch {
            print(error)
        }
    }
    
    func gameOver(){
        newScore = Float(Float(correctAnswer) / Float(sounds.count))
        score.setScore(score: newScore)
        print("score is \(newScore)")

        audioPlayer?.stop()
        
        highScore.setHighScore(highScore: newScore)
      
                    
                    let VC = self.storyboard?.instantiateViewController(withIdentifier: "GO") as! UINavigationController
        //            self.navigationController?.pushViewController(VC, animated: false)
                    self.navigationController?.present(VC, animated: false, completion: nil)
    }
    
//    func getAnswer(){
//
//        if(sounds[number] == swipeDirection){
//            print("new sound is2 \(sounds[number])")
//            print("new direction2 is \(swipeDirection)")
//            answer2 = true
//            print(answer2)
//        }
//        else if(sounds[number] != swipeDirection) {
//            answer2 = false
//            print("new sound is \(answer2)")
//            print("new direction is \(swipeDirection)")
//        }
//    }
    
    func setDirection(direction : String){
        
        answerDirection = answerMadonna
        print("kkkkkkkkkkkkkkkkkkkkkkkkkkkk\(answerDirection)")

        if (direction == "left") {
                        print("Swipe Left")
                    swipeDirection = "left"
            print("zzzzzzzzz \(sounds[number])")
//                    getAnswer()
                }
        
                if (direction == "right") {
                    print("Swipe Right")
                    swipeDirection = "right"
//                    getAnswer()
                }
    }
    
//    @objc func handleSwipes(_ sender:UISwipeGestureRecognizer) {
//
//        if (sender.direction == .left) {
//                print("Swipe Left")
//            swipeDirection = "left"
//            getAnswer()
//        }
//
//        if (sender.direction == .right) {
//            print("Swipe Right")
//            swipeDirection = "right"
//            getAnswer()
//        }
//    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    
}
