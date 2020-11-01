//
//  Story.swift
//  To the Gloom
//
//  Created by Adriano Gatto on 06/04/2020.
//  Copyright © 2020 Adriano Gatto. All rights reserved.
//

import Foundation
import Foundation
import UIKit

class Story : UIViewController{
    
    
    @IBOutlet weak var purple: UIImageView!
    @IBOutlet weak var blue: UIImageView!
    var angle = Float()
    
    override func viewDidLoad() {

        let timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(rotate), userInfo: nil, repeats: true)
    }
    
    @objc func rotate(){

           angle += 0.005
           
           blue.transform = CGAffineTransform(rotationAngle: CGFloat(-angle/1.5))
           
           purple.transform = CGAffineTransform(rotationAngle: CGFloat(angle/1.5))
         
       }
}
