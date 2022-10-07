//
//  ViewController.swift
//  CatchTheBart
//
//  Created by Fikriye Nur Harmandar on 6.10.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highScoreLabel: UILabel!

    @IBOutlet weak var bart1: UIImageView!
    @IBOutlet weak var bart2: UIImageView!
    @IBOutlet weak var bart3: UIImageView!
    @IBOutlet weak var bart4: UIImageView!
    @IBOutlet weak var bart5: UIImageView!
    @IBOutlet weak var bart6: UIImageView!
    @IBOutlet weak var bart7: UIImageView!
    @IBOutlet weak var bart8: UIImageView!
    @IBOutlet weak var bart9: UIImageView!
    
    var timer = Timer()
    var hideTimer = Timer()
    var counter = 0
    var score = 0
    var highScore = 0
    var bartArray = [UIImageView]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Image View Cliked
        bart1.isUserInteractionEnabled = true
        bart2.isUserInteractionEnabled = true
        bart3.isUserInteractionEnabled = true
        bart4.isUserInteractionEnabled = true
        bart5.isUserInteractionEnabled = true
        bart6.isUserInteractionEnabled = true
        bart7.isUserInteractionEnabled = true
        bart8.isUserInteractionEnabled = true
        bart9.isUserInteractionEnabled = true
        
        let gestureRegocnizer1 = UITapGestureRecognizer(target: self, action: #selector(clickedPic))
        let gestureRegocnizer2 = UITapGestureRecognizer(target: self, action: #selector(clickedPic))
        let gestureRegocnizer3 = UITapGestureRecognizer(target: self, action: #selector(clickedPic))
        let gestureRegocnizer4 = UITapGestureRecognizer(target: self, action: #selector(clickedPic))
        let gestureRegocnizer5 = UITapGestureRecognizer(target: self, action: #selector(clickedPic))
        let gestureRegocnizer6 = UITapGestureRecognizer(target: self, action: #selector(clickedPic))
        let gestureRegocnizer7 = UITapGestureRecognizer(target: self, action: #selector(clickedPic))
        let gestureRegocnizer8 = UITapGestureRecognizer(target: self, action: #selector(clickedPic))
        let gestureRegocnizer9 = UITapGestureRecognizer(target: self, action: #selector(clickedPic))

        bart1.addGestureRecognizer(gestureRegocnizer1)
        bart2.addGestureRecognizer(gestureRegocnizer2)
        bart3.addGestureRecognizer(gestureRegocnizer3)
        bart4.addGestureRecognizer(gestureRegocnizer4)
        bart5.addGestureRecognizer(gestureRegocnizer5)
        bart6.addGestureRecognizer(gestureRegocnizer6)
        bart7.addGestureRecognizer(gestureRegocnizer7)
        bart8.addGestureRecognizer(gestureRegocnizer8)
        bart9.addGestureRecognizer(gestureRegocnizer9)
        
        bartArray = [bart1, bart2, bart3, bart4, bart5, bart6, bart7, bart8, bart9]
        
        //Timer
        counter = 15
        timeLabel.text = String(counter)
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerFunction), userInfo: nil, repeats: true)
        hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.hideBart), userInfo: nil, repeats: true)
        hideBart()
        
        //Highscore Check
        let storedHighScore = UserDefaults.standard.object(forKey: "highscore")
        if storedHighScore == nil {
            highScore = 0
            highScoreLabel.text = "Highscore: \(highScore)"
        }
        else if let newScore = storedHighScore as? Int {
            highScore = newScore
            highScoreLabel.text = "Highscore : \(highScore)"
        }
    }
    
    @objc func hideBart() {
        for bart in bartArray {
            bart.isHidden = true
        }
        
       let random = Int(arc4random_uniform(UInt32(bartArray.count - 1)))
       bartArray[random].isHidden = false
    }
    
    @objc func clickedPic() {
        score += 1
        scoreLabel.text = "Score: \(score)"
    }

    @objc func timerFunction() {
        counter -= 1
        timeLabel.text = "\(counter)"
        
        if counter == 0 {
            timer.invalidate()
            hideTimer.invalidate()
            timeLabel.text = "Time's Over"
            
            for bart in bartArray {
                bart.isHidden = true
            }

            let alert = UIAlertController(title: "Time's Up", message: "Do you want to play again?", preferredStyle: UIAlertController.Style.alert)
            let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
            let replyButton = UIAlertAction(title: "Replay", style: UIAlertAction.Style.default) { UIAlertAction in
                
                self.score = 0
                self.scoreLabel.text = "Score: \(self.score)"
                self.counter = 15
                self.timeLabel.text = String(self.counter)
                
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.timerFunction), userInfo: nil, repeats: true)
                self.hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.hideBart), userInfo: nil, repeats: true)
            }
            
            alert.addAction(okButton)
            alert.addAction(replyButton)
            self.present(alert, animated: true, completion: nil)
            
            if score > highScore {
                highScore = score
                highScoreLabel.text = "Highscore: \(highScore)"
                UserDefaults.standard.set(highScore, forKey: "highscore")
            }
        }
    }
}

