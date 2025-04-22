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
    
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var titleLabel: UILabel!
    
    let eggTimes = ["Soft": 3, "Medium": 350, "Hard": 600]
    var secondsPassed = 0
    var totalTime = 0
    var timer = Timer()
    var audioPlayer: AVAudioPlayer?
    
    
    @IBAction func hardnessCelected(_ sender: UIButton) {
        
        progressBar.progress = 0
        secondsPassed = 0
        titleLabel.text = "Cooking \(sender.currentTitle ?? "choose a hardness") egg..."
        
        
        timer.invalidate()
        
        let hardness = sender.currentTitle ?? "user did not select"
        
        totalTime = eggTimes[hardness]!
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    @objc func updateTimer() {
        if secondsPassed <= totalTime {
            progressBar.progress = Float(secondsPassed) / Float(totalTime)
            secondsPassed += 1
        } else {
            timer.invalidate()
            titleLabel.text = "Done!"
            playSound()
        }
        
    }
    
    func playSound() {
        guard let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3") else { return }
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.play()
        } catch {
        }
    }
}
