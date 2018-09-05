//
//  ViewController.swift
//  StopWatch
//
//  Created by Dwayne Lewis on 7/28/18.
//  Copyright © 2018 Dwayne Lewis. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // add following properties
    
    var counter = 0.0
    var timer = Timer()
    var isPlaying = false

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var pauseButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        timeLabel.text = String(counter)
        pauseButton.isEnabled = false
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func startTimer(_ sender: Any) {
        
        if(isPlaying){
            
            return
        }
        
        startButton.isEnabled = false
        
        pauseButton.isEnabled = true
        
        
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(UpdateTimer), userInfo: nil, repeats: true)
        
         isPlaying = true
        
        
        
        
        
    }
    
    @IBAction func pauseTimer(_ sender: Any) {
        
        startButton.isEnabled = true
        pauseButton.isEnabled = false
        
        timer.invalidate()
        
        isPlaying = false
        
        
    }
    
    @IBAction func resetTimer(_ sender: Any) {
        startButton.isEnabled = true
        pauseButton.isEnabled = false
        
        timer.invalidate()
        isPlaying = false
        counter = 0.0
        timeLabel.text = String(counter)
        
        
    }
    
    
    @objc func UpdateTimer() {
        
        counter = counter + 0.1
        
        timeLabel.text = String(format: "%.1f", counter)
    }
    
}

