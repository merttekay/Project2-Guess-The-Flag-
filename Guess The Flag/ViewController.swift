//
//  ViewController.swift
//  Guess The Flag
//
//  Created by Mert Tekay on 14.04.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var label1: UILabel!
    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    var countries = [String]()
    var correctAnswer = 0
    var score = 0
    var counter = 1
    override func viewDidLoad() {
        super.viewDidLoad()
       countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
        button1.layer.borderWidth = 0.5
        button2.layer.borderWidth = 0.5
        button3.layer.borderWidth = 0.5
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor
        
        
        askQuestion()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
       
    }
    func askQuestion(action:UIAlertAction! = nil){
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        label1.text = "\(counter) -"
        
    title = " \(countries[correctAnswer].uppercased()) - Your score : \(score)"
        
    }
    
    func check(title:String){
        if counter == 10 {
        
            let ac = UIAlertController(title: title, message: "Your Final Score is \(score)", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Play Again", style: .default, handler: playAgain))
           
            present(ac, animated: true)
        }
        else{
            let ac = UIAlertController(title: title, message: "Your  Score is \(score)", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
            counter += 1
            present(ac, animated: true)
         
            
        }
      
        
        
    }
    func playAgain(action: UIAlertAction! = nil){
        
        score = 0
        counter = 1
        askQuestion()
        
        
    }

    @IBAction func buttonTapped(_ sender: UIButton) {
    
        var title:String?
        
        if sender.tag == correctAnswer{
            title = "Correct"
            score += 1
            check(title: title!)
        }
        else{
            title = "Wrong.That’s the flag of \(countries[sender.tag].uppercased())"
            score -= 1
            check(title: title!)
           
        }
    
        
    }
    @objc func shareTapped(){
        let vc = UIActivityViewController(activityItems: ["My score is \(score).Do you wanna Play?"], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
        
    }


}
