//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    
    //to play sound
    var player: AVAudioPlayer!
    
    //dictionary - key:value - hardness:time
    var eggTimes = ["Soft": 3, "Medium": 4, "Hard": 7]
    
    //variable to set the countdown - this line helps to maintain just one countdown per second.
    var timer = Timer()
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
      
        //title of sender
        let hardness = sender.currentTitle!
        var result = eggTimes[hardness]! //accessing dictionary
       
        //progress bar animation - set to empty progress bar again
        progressBar.progress = 0
        
        //title label -> soft, medium or hard?
        titleLabel.text = hardness
        
        // Function to play sound when the time's over
        func playSound() {
            let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
            player = try! AVAudioPlayer(contentsOf: url!)
            player.play()
            
        }
        
        //hardness countdown
        timer.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { (Timer) in
            if result > 0 {
                print ("\(result) seconds.")
                result -= 1
                //progress bar animation - filling progress bar
                UIView.animate(withDuration: TimeInterval(result)) {
                    self.progressBar.setProgress(1.0, animated: true)}
            } else {
                Timer.invalidate()
                //change the title label itself (viewController)
                self.titleLabel.text = "DONE!"
                playSound() //calling the function
                
            }
        }
    }
    

}
