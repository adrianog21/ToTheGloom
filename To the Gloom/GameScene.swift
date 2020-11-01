//
//  GameScene.swift
//  To the Gloom
//
//  Created by Adriano Gatto on 24/03/2020.
//  Copyright © 2020 Adriano Gatto. All rights reserved.
//

import SpriteKit
import GameplayKit
import AVFoundation
import AudioToolbox

class GameScene: SKScene {
    
    var entities = [GKEntity]()
    var graphs = [String : GKGraph]()
    
    var start:(location:CGPoint, time:TimeInterval)?
    
    let minDistance:CGFloat = 10
    let minSpeed:CGFloat = 1000
    let maxSpeed:CGFloat = 8000
    
    var gvc = GameViewController()
    
    var direction = String()
    
    
    var variation = CGFloat()
    var variation2 = CGFloat()
    var variation3 = CGFloat()
    var variation4 = CGFloat()
    var variation5 = CGFloat()
    var variation6 = CGFloat()
    var variation7 = CGFloat()
    var variation8 = CGFloat()
    var variation9 = CGFloat()
    var variation10 = CGFloat()
    var variation11 = CGFloat()
    var variation12 = CGFloat()
    
    var rotation = Float(0)
    
    var audioPlayer: AVAudioPlayer?
    
    var newAnswer = Answer()
    
    
    private var lastUpdateTime : TimeInterval = 0
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    var square : UIImageView!
    
    override func sceneDidLoad() {

        self.lastUpdateTime = 0
        
        
        // Get label node from scene and store it for use later
//        self.label = self.childNode(withName: "//helloLabel") as? SKLabelNode
        if let label = self.label {
            label.alpha = 0.0
            label.run(SKAction.fadeIn(withDuration: 2.0))
        }
        
        // Create shape node to use during mouse interaction
        let w = (self.size.width + self.size.height) * 0.05
        self.spinnyNode = SKShapeNode.init(rectOf: CGSize.init(width: w, height: w), cornerRadius: w * 0.3)
        
        
        if let spinnyNode = self.spinnyNode {
            spinnyNode.lineWidth = 2.5
            
            spinnyNode.run(SKAction.repeatForever(SKAction.rotate(byAngle: CGFloat(Double.pi), duration: 1)))
            spinnyNode.run(SKAction.sequence([SKAction.wait(forDuration: 0.5),
                                              SKAction.fadeOut(withDuration: 0.5),
                                              SKAction.removeFromParent()]))
        }
        
    }
    
    func touchDown(atPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.purple
            n.setScale(0.21)
            self.addChild(n)
        }
    }
    
    fileprivate func visualEffect(_ pos: CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            
            
            n.position = pos
            n.strokeColor = SKColor.black
            n.fillColor = SKColor.init(red: 105/250, green: 63/250, blue: 227/250, alpha: 1)
            n.setScale(0.1)
//            n.position = CGPoint(x: pos.x + variation, y: pos.y + variation2)
            self.addChild(n)
        }
    }
    
     fileprivate func visualEffect2(_ pos: CGPoint) {
            if let n = self.spinnyNode?.copy() as! SKShapeNode? {
                
                
                n.position = pos
                n.strokeColor = SKColor.black
                n.fillColor = SKColor.init(red: 35/250, green: 240/250, blue: 240/250, alpha: 1)
                n.setScale(0.1)
    //            n.position = CGPoint(x: pos.x + variation, y: pos.y + variation2)
                self.addChild(n)
            }
        }
    
    //image created
    func createImage(pos : CGPoint){
            square = UIImageView.init(image: #imageLiteral(resourceName: "square.png"))
               let position = convertPoint(toView: pos)
               square.frame = CGRect(x: position.x - 12, y: position.y - 12, width: 27, height: 27)
            newTimer()
        self.view?.addSubview(square)

               UIView.animate(withDuration: 1, animations: {
                self.square.alpha = 0
               })
    }
    
    fileprivate func playSound() {
        let music = Bundle.main.path(forResource: "feedback.mp3", ofType: nil)
        let url = URL(fileURLWithPath: music!)
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            //            audioPlayer?.play()
            
        } catch {
            print(error)
        }
    }
    
    func touchMoved(toPoint pos : CGPoint) {

        playSound()
        
        createImage(pos: pos)
        
        AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
        print(AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate)))

        print("aaa")
    }
    
    func touchUp(atPoint pos : CGPoint) {
        createImage(pos: pos)
       
    }
    
    func newTimer(){
        //Timer
        _ = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(rotate), userInfo: nil, repeats: true)
    }
    
    
    @objc func rotate(){
        self.square.transform = CGAffineTransform(rotationAngle: CGFloat(rotation))

    }
    
    func getDirection() -> String {
        return direction
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        if let label = self.label {
//            label.run(SKAction.init(named: "Pulse")!, withKey: "fadeInOut")
//
//        }
        
        if let touch = touches.first {
            start = (touch.location(in:self), touch.timestamp)
            print("set")
        }
        
//        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
        
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
//        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
        
        var swiped = false
           if let touch = touches.first, let startTime = self.start?.time,
                   let startLocation = self.start?.location {
               let location = touch.location(in:self)
               let dx = location.x - startLocation.x
               let dy = location.y - startLocation.y
               let distance = sqrt(dx*dx+dy*dy)

//               // Check if the user's finger moved a minimum distance
//               if distance > minDistance {
//                   let deltaTime = CGFloat(touch.timestamp - startTime)
//                   let speed = distance / deltaTime
//
//                   // Check if the speed was consistent with a swipe
//                   if speed >= minSpeed && speed <= maxSpeed {

                       // Determine the direction of the swipe
                       let x = abs(dx/distance) > 0.4 ? Int(sign(Float(dx))) : 0
                       let y = abs(dy/distance) > 0.4 ? Int(sign(Float(dy))) : 0

                       swiped = true
                       switch (x,y) {
//                       case (0,1):
//                           print("swiped up")
//                       case (0,-1):
//                           print("swiped down")
                       case (-1,0):
                           print("swiped leftYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYY")
                           gvc.setDirection(direction: "left")
                        direction = "left"
                           newAnswer.setAnswer(answer2: "left")
                       case (1,0):
                           print("swiped rightXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX")
                           gvc.setDirection(direction: "right")
                        direction = "right"
                           newAnswer.setAnswer(answer2: "right")
//                       case (1,1):
//                           print("swiped diag up-right")
//                       case (-1,-1):
//                           print("swiped diag down-left")
//                       case (-1,1):
//                           print("swiped diag up-left")
//                       case (1,-1):
//                           print("swiped diag down-right")
                       default:
                           swiped = false
                           break
                       }
//                   }
//               }
           }
           start = nil
           if !swiped {
               // Process non-swipes (taps, etc.)
               print("not a swipe")
            print("center")
           }
        
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        rotation += 0.21
        
        variation = CGFloat.random(in: -21...21)
        variation2 = CGFloat.random(in: -21...21)
        variation3 = CGFloat.random(in: -21...21)
        variation4 = CGFloat.random(in: -21...21)
        variation5 = CGFloat.random(in: -21...21)
        variation6 = CGFloat.random(in: -21...21)
        variation7 = CGFloat.random(in: -21...21)
        variation8 = CGFloat.random(in: -21...21)
        variation9 = CGFloat.random(in: -21...21)
        variation10 = CGFloat.random(in: -21...21)
        variation11 = CGFloat.random(in: -21...21)
        variation12 = CGFloat.random(in: -21...21)
        
        // Initialize _lastUpdateTime if it has not already been
        if (self.lastUpdateTime == 0) {
            self.lastUpdateTime = currentTime
        }
        
        // Calculate time since last update
        let dt = currentTime - self.lastUpdateTime
        
        // Update entities
        for entity in self.entities {
            entity.update(deltaTime: dt)
        }
        
        self.lastUpdateTime = currentTime
    }
}
