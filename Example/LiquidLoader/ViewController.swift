//
//  ViewController.swift
//  LiquidLoader
//
//  Created by Takuma Yoshida on 08/24/2015.
//  Copyright (c) 2015 Takuma Yoshida. All rights reserved.
//

import UIKit
import LiquidLoader

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.view.backgroundColor = UIColor(red: 9 / 255.0, green: 21 / 255.0, blue: 37 / 255.0, alpha: 1.0)
        
        let lineColor = UIColor(red: 77 / 255.0, green: 255 / 255.0, blue: 182 / 255.0, alpha: 1.0)
        let growColor = UIColor.redColor()

        let lineFrame = CGRect(x: self.view.frame.width * 0.5 - 100, y: 100, width: 200, height: 100)
        let lineLoader = LiquidLoader(frame: lineFrame, effect: .GrowLine(lineColor,7,10.0, growColor))
        
        let circleFrame = CGRect(x: self.view.frame.width * 0.5 - 100, y: 200, width: 200, height: 200)
        let circleColor = UIColor(red: 77 / 255.0, green: 182 / 255.0, blue: 255 / 255.0, alpha: 1.0)
        let circleLoader = LiquidLoader(frame: circleFrame, effect: .GrowCircle(circleColor,10,1.0, growColor))

        let circleMatColor = UIColor(red: 255 / 255.0, green: 188 / 255.0, blue: 188 / 255.0, alpha: 1.0)
        let circleMatFrame = CGRect(x: self.view.frame.width * 0.5 - 25, y: 450, width: 50, height: 50)
        let circleMat = LiquidLoader(frame: circleMatFrame, effect: .Circle(circleMatColor,8,5.0, growColor))
    
        let lineMatColor = UIColor(red: 255 / 255.0, green: 255 / 255.0, blue: 188 / 255.0, alpha: 1.0)
        let lineMatFrame = CGRect(x: self.view.frame.width * 0.5 - 25, y: 500, width: 50, height: 50)
        let lineMat = LiquidLoader(frame: lineMatFrame, effect: .Line(lineMatColor,4,1.0, growColor))
    
        view.addSubview(lineLoader)
        view.addSubview(circleLoader)
        view.addSubview(circleMat)
        view.addSubview(lineMat)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

