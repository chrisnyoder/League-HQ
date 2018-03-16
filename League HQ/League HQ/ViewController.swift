//
//  ViewController.swift
//  League HQ
//
//  Created by Christian Yoder on 3/3/18.
//  Copyright © 2018 Christian Yoder. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var questionLabel: UILabel!
    @IBOutlet var buttonLabel1: UIButton!
    @IBOutlet var buttonLabel2: UIButton!
    @IBOutlet var buttonLabel3: UIButton!
    @IBOutlet var rightOrWrong: UILabel!
    @IBOutlet var questionSubView: UIView!
    
    struct question {
        let question: String
        let answers: [String]
        let rightAnswer: Int
        let timeBeforeAnswer: Int
    }
    
    var currentQuestion: question?
    var questionIndex = 0
    var answerIsRight: Bool?
    var hasLost: Bool = false
    var numRight = 0
    var viewTimer: Timer!
    var selectionThatWasMade: Int?

    
    var questions: [question] = [
        question(question: "What was the name of the minigun-toting manatee that Riot revealed as an April Fools joke?", answers: ["Steve the Manatee", "Drake the Manatee", "Urf the Manatee"], rightAnswer: 2, timeBeforeAnswer: 10),
        question(question: "Which of these champions has the longest base auto-attack range?", answers: ["Caitlyn", "Ashe", "Varus"], rightAnswer: 0, timeBeforeAnswer: 10),
        question(question: "xPeke famously backdoored SK Gaming’s nexus at IEM Katowice playing which champion?", answers: ["Zed", "Kassadin", "Fiz"], rightAnswer: 1, timeBeforeAnswer: 10),
        question(question: "Which of the following champions is not a member of the legendary Runeterran heavy metal band Pentakill?", answers: ["Kayle", "Karthus", "Zed"], rightAnswer: 2, timeBeforeAnswer: 10),
        question(question: "How many turrets are there in total (both teams) on Summoners Rift ?", answers: ["18", "22", "24"], rightAnswer: 1, timeBeforeAnswer: 10),
        question(question: "Which champion does not refer to 'summoners' in any of her voiceover lines?", answers: ["Syndra", "Lux", "Sona"], rightAnswer: 0, timeBeforeAnswer: 10),
        question(question: "Which LoL Esports star famously helped fans get swole in his 'Get Fit with ____' series?", answers: ["Krepo", "Snoopeh", "Trashy"], rightAnswer: 1, timeBeforeAnswer: 10),
        question(question: "In old League of Legends lore, which champion ran a dating service called 'Fleshling Compatibility Services'?", answers: ["Orianna", "Amumu", "Blitzcrank"], rightAnswer: 2, timeBeforeAnswer: 10),
        question(question: "Which champion is known as 'The Heart of the Tempest?'", answers: ["Janna", "Anivia", "Kennen"], rightAnswer: 2, timeBeforeAnswer: 10),
        question(question: "In what country was the Season One League of Legends World Championships held?", answers: ["Germany", "Sweden", "Poland"], rightAnswer: 1, timeBeforeAnswer: 10)
        // put placeholder questions below
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentQuestion = questions[questionIndex]
        questionSubView.isHidden = true

        viewTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(shouldViewTimer), userInfo: nil, repeats: true)
        
    }
    
    var globalCounterTimer = 0
    let questionTimings = [10, 80, 150, 220, 290]
    
    @objc func shouldViewTimer (){
        globalCounterTimer += 1
        if questionTimings.contains(globalCounterTimer){
            setQuestions()
        }
    }
    
    @IBAction func submitAnswer0(_ sender: Any){
        checkAnswer(idx: 0)
        buttonLabel1.isEnabled = false
        buttonLabel2.isEnabled = false
        buttonLabel3.isEnabled = false
    }
    
    @IBAction func submitAnswer1(_ sender: Any){
        checkAnswer(idx: 1)
        buttonLabel1.isEnabled = false
        buttonLabel2.isEnabled = false
        buttonLabel3.isEnabled = false
    }
    
    @IBAction func submitAnswer2(_ sender: Any){
        checkAnswer(idx: 2)
        buttonLabel1.isEnabled = false
        buttonLabel2.isEnabled = false
        buttonLabel3.isEnabled = false
    }
    
    func setQuestions(){
        counter = 10
        questionSubView.isHidden = false
        answerIsRight = nil
        timerLabel.text = "10"
        rightOrWrong.text! = ""
        countDownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
    
        if questionIndex < questions.count {
            currentQuestion = questions[questionIndex]
        } else {
            questionIndex = 0
            currentQuestion = questions[questionIndex]
            performSegue(withIdentifier: "showResults", sender: nil)
        }
        
        questionLabel.text = currentQuestion!.question
        buttonLabel1.setTitle(currentQuestion!.answers[0], for: .normal)
        buttonLabel2.setTitle(currentQuestion!.answers[1], for: .normal)
        buttonLabel3.setTitle(currentQuestion!.answers[2], for: .normal)
        
        buttonLabel1.isEnabled = true
        buttonLabel2.isEnabled = true
        buttonLabel3.isEnabled = true
    
    }
    
    func checkAnswer(idx: Int){
        selectionThatWasMade = idx
        if(idx == currentQuestion!.rightAnswer){
            answerIsRight = true
            numRight += 1
        }
        else {
            answerIsRight = false
        }
    }
    
    
    /// individual question timer section
    
    @IBOutlet var timerLabel: UILabel!
    
    var countDownTimer: Timer!
    var counter = 10
    
    @objc func timerAction() {
        print(counter)
        if counter > 0 {
            timerLabel.isHidden = false
            counter -= 1
            timerLabel.text = "\(counter)"
        }
        else if counter > -3 && counter <= 0 {
            counter -= 1
            buttonLabel1.isEnabled = false
            buttonLabel2.isEnabled = false
            buttonLabel3.isEnabled = false
        }
        else if counter <= -3 && counter > (-3 - currentQuestion!.timeBeforeAnswer)  {
            counter -= 1
            questionSubView.isHidden = true
        }
        else if counter <= (-3 - currentQuestion!.timeBeforeAnswer) && counter > (-12 - currentQuestion!.timeBeforeAnswer) {
            counter -= 1
            questionSubView.isHidden = false
            
            if currentQuestion!.rightAnswer == 0 {
                buttonLabel1.backgroundColor = UIColor(red: (0.0/255.0), green: (167.0/255.0), blue: (65.0/255.0), alpha: 1.0)
            
            }
            else if currentQuestion!.rightAnswer == 1 {
                buttonLabel2.backgroundColor = UIColor(red: (0.0/255.0), green: (167.0/255.0), blue: (65.0/255.0), alpha: 1.0)
            }
            else {
                buttonLabel3.backgroundColor = UIColor(red: (0.0/255.0), green: (167.0/255.0), blue: (65.0/255.0), alpha: 1.0)
            }
            
            
            if answerIsRight == true {
                print("right answer was selected")
            }
            else if answerIsRight == false {
                print("wrong answer was selected")
                hasLost = true
                if selectionThatWasMade == 0 {
                    buttonLabel1.backgroundColor = UIColor(red: (202.0/255.0), green: (19.0/255.0), blue: (117.0/255.0), alpha: 1.0)
                }
                else if selectionThatWasMade == 1 {
                    buttonLabel2.backgroundColor = UIColor(red: (202.0/255.0), green: (19.0/255.0), blue: (117.0/255.0), alpha: 1.0)
                }
                else if selectionThatWasMade == 2 {
                    buttonLabel3.backgroundColor = UIColor(red: (202.0/255.0), green: (19.0/255.0), blue: (117.0/255.0), alpha: 1.0)
                }
            }
            else {
                print("player ran out of time")
                hasLost = true
            }
        }
        else {
            questionSubView.isHidden = true
            countDownTimer.invalidate()
            questionIndex += 1
            
            buttonLabel1.backgroundColor = UIColor(red: (21.0/255.0), green: (50.0/255.0), blue: (64.0/255.0), alpha: 1.0)
            buttonLabel2.backgroundColor = UIColor(red: (21.0/255.0), green: (50.0/255.0), blue: (64.0/255.0), alpha: 1.0)
            buttonLabel3.backgroundColor = UIColor(red: (21.0/255.0), green: (50.0/255.0), blue: (64.0/255.0), alpha: 1.0)
            
            selectionThatWasMade = nil

        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destVC = segue.destination as! resultsContoller
        destVC.numRight = numRight
        
    }

}
