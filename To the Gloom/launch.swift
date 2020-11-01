//
//  launch.swift
//  To the Gloom
//
//  Created by Adriano Gatto on 30/03/2020.
//  Copyright © 2020 Adriano Gatto. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

class launch: UIViewController{
    
    @IBOutlet weak var logoText: UIView!
    
    var audioPlayer: AVAudioPlayer?
    
    var count = 0
    
    var xPos = [810, 785, 760, 735, 710, 685, 660, 635, 610]
    var yPos = [20, 45, 70, 95, 120, 145, 170, 195, 220]
    
    var test = [CGRect(x: 810, y: 20, width: 27, height: 27), CGRect(x: 760, y: 20, width: 27, height: 27), CGRect(x: 785, y: 45, width: 27, height: 27), CGRect(x: 810, y: 70, width: 27, height: 27), CGRect(x: 710, y: 20, width: 27, height: 27), CGRect(x: 735, y: 45, width: 27, height: 27), CGRect(x: 760, y: 70, width: 27, height: 27), CGRect(x: 785, y: 95, width: 27, height: 27), CGRect(x: 810, y: 120, width: 27, height: 27), CGRect(x: 660, y: 20, width: 27, height: 27), CGRect(x: 685, y: 45, width: 27, height: 27), CGRect(x: 710, y: 70, width: 27, height: 27), CGRect(x: 735, y: 95, width: 27, height: 27), CGRect(x: 760, y: 120, width: 27, height: 27), CGRect(x: 785, y: 145, width: 27, height: 27), CGRect(x: 810, y: 170, width: 27, height: 27), CGRect(x: 610, y: 20, width: 27, height: 27), CGRect(x: 635, y: 45, width: 27, height: 27), CGRect(x: 660, y: 70, width: 27, height: 27), CGRect(x: 685, y: 95, width: 27, height: 27), CGRect(x: 710, y: 120, width: 27, height: 27), CGRect(x: 735, y: 145, width: 27, height: 27), CGRect(x: 760, y: 170, width: 27, height: 27), CGRect(x: 785, y: 195, width: 27, height: 27), CGRect(x: 810, y: 220, width: 27, height: 27)]
    
    var test2 = [CGRect(x: 20, y: 360, width: 27, height: 27), CGRect(x: 70, y: 360, width: 27, height: 27), CGRect(x: 45, y: 335, width: 27, height: 27), CGRect(x: 20, y: 310, width: 27, height: 27), CGRect(x: 120, y: 360, width: 27, height: 27), CGRect(x: 95, y: 335, width: 27, height: 27), CGRect(x: 70, y: 310, width: 27, height: 27), CGRect(x: 45, y: 285, width: 27, height: 27), CGRect(x: 20, y: 260, width: 27, height: 27), CGRect(x: 170, y: 360, width: 27, height: 27), CGRect(x: 145, y: 335, width: 27, height: 27), CGRect(x: 120, y: 310, width: 27, height: 27), CGRect(x: 95, y: 285, width: 27, height: 27), CGRect(x: 70, y: 260, width: 27, height: 27), CGRect(x: 45, y: 235, width: 27, height: 27), CGRect(x: 20, y: 210, width: 27, height: 27), CGRect(x: 220, y: 360, width: 27, height: 27), CGRect(x: 195, y: 335, width: 27, height: 27), CGRect(x: 170, y: 310, width: 27, height: 27), CGRect(x: 145, y: 285, width: 27, height: 27), CGRect(x: 120, y: 260, width: 27, height: 27), CGRect(x: 95, y: 235, width: 27, height: 27), CGRect(x: 70, y: 210, width: 27, height: 27), CGRect(x: 45, y: 185, width: 27, height: 27), CGRect(x: 20, y: 160, width: 27, height: 27)]
    
    
    var timer1 = Timer()
    
    var instructions = Bool()
    

    
    override func viewDidLoad() {
        super .viewDidLoad()
        
//        isAppAlreadyLaunchedOnce()
        instructions = isAppAlreadyLaunchedOnce()
        
        _ = Timer.scheduledTimer(timeInterval: 0.25, target: self, selector: #selector(play), userInfo: nil, repeats: false)
        
        timer1 = Timer.scheduledTimer(timeInterval: 0.075, target: self, selector: #selector(newImage1), userInfo: nil, repeats: true)
        
        _ = Timer.scheduledTimer(timeInterval: 2.5, target: self, selector: #selector(logo), userInfo: nil, repeats: false)
        
        logoText.alpha = 0
        
    }
    
    @objc func newImage1(){
       
//            let timer = Timer.scheduledTimer(timeInterval: 0.25, target: self, selector: #selector(nextPos), userInfo: nil, repeats: false)
        if count < test.count {
        let image = UIImageView(image: #imageLiteral(resourceName: "square.png"))
            let image2 = UIImageView(image: #imageLiteral(resourceName: "square.png"))
               image.frame = test[count]
            image2.frame = test2[count]
            image.alpha = 0
            image2.alpha = 0
            UIView.animate(withDuration: 1.21, animations: {
                image.alpha = 1
                image2.alpha = 1
            })
            self.view.addSubview(image2)
               self.view.addSubview(image)
            count += 1
            
        } else {
            timer1.invalidate()
        }
        }
    
    @objc func play(){
        let music = Bundle.main.path(forResource: "Freeze.mp3", ofType: nil)
        let url = URL(fileURLWithPath: music!)
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.play()

        } catch {
            print(error)
        }
    }
    
    @objc func logo(){
        _ = Timer.scheduledTimer(timeInterval: 2.5, target: self, selector: #selector(nextView), userInfo: nil, repeats: false)
        UIView.animate(withDuration: 1.5, animations: {
            self.logoText.alpha = 1
        })
    }
    
    @objc func nextView(){
        
        if instructions == false{
            print("first time")
            let VC = self.storyboard?.instantiateViewController(withIdentifier: "Instructions") as! UINavigationController
            //            self.navigationController?.pushViewController(VC, animated: false)
                        self.navigationController?.present(VC, animated: false, completion: nil)
        }else if instructions == true{
            print("not first")
            let VC = self.storyboard?.instantiateViewController(withIdentifier: "Main") as! UINavigationController
                          //            self.navigationController?.pushViewController(VC, animated: false)
                                      self.navigationController?.present(VC, animated: false, completion: nil)
        }
       
        
        
    }
    
    func isAppAlreadyLaunchedOnce()->Bool{
        let defaults = UserDefaults.standard

        if let isAppAlreadyLaunchedOnce = defaults.string(forKey: "isAppAlreadyLaunchedOnce"){
            print("App already launched : \(isAppAlreadyLaunchedOnce)")
            return true
        }else{
            defaults.set(true, forKey: "isAppAlreadyLaunchedOnce")
            print("App launched first time")
            return false
        }
    }
        
}
