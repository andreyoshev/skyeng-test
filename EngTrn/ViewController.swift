        //
//  ViewController.swift
//  EngTrn
//
//  Created by Андрей Ошев on 18.04.16.
//  Copyright © 2016 Андрей Ошев. All rights reserved.
//
import UIKit
import Alamofire
import SwiftyJSON

//Перемешать
extension Array {
    mutating func shuffle() {
        if count < 2 { return }
        
        for _ in 0..<count - 1 {
            sortInPlace { (_,_) in arc4random() < arc4random() }
        }
    }
}
//Цвет по RGB
extension UIColor
{
    convenience init(red: Int, green: Int, blue: Int)
    {
        let newRed = CGFloat(red)/255
        let newGreen = CGFloat(green)/255
        let newBlue = CGFloat(blue)/255
        self.init(red: newRed, green: newGreen, blue: newBlue, alpha: 1.0)
    }
}
//Цвет в keypath
extension CALayer {
    var borderUIColor: UIColor {
        set {
            self.borderColor = newValue.CGColor
        }
        get {
            return UIColor(CGColor: self.borderColor!)
        }
    }
}
        
func animationView (interval: Double, button: UIButton) {
    UIView.animateWithDuration(interval, animations: {
        button.alpha = 1
    })
}

var wordsForTranslation: NSMutableDictionary = [:] //Словарь англ. слова по ключу перевода
var shuffleArray: Array<String> = [] //Массив для слов в игре (Сперва весь, потом перемешивается, потом обрезается до 10 шт)
var altArray: Array<String> = [] //Массив для всех альтернатив перевода
        
var userMakeHisChoose = false
var nextWord = 0
class ViewController: UIViewController {
    
    @IBOutlet weak var firstButton: UIButton!
    @IBOutlet weak var secondButton: UIButton!
    @IBOutlet weak var thirdButton: UIButton!
    @IBOutlet weak var fourthButton: UIButton!
    
    @IBAction func firstAnswer(sender: UIButton) {
        if !userMakeHisChoose {
            sender.setTitleColor(UIColor.whiteColor(), forState: .Normal)
            if sender.currentTitle == (wordsForTranslation[self.label.text!] as! String) {
                sender.layer.borderWidth = 0
                sender.backgroundColor = UIColor(red: 173, green: 209, blue: 102)
            } else {
                sender.layer.borderWidth = 0
                sender.backgroundColor = UIColor(red: 255, green: 128, blue: 128)
            }
            userMakeHisChoose = true
            nextWord += 1
        }
    }
    @IBOutlet weak var label: UILabel!
    
    
    @IBOutlet weak var startGame: UIButton!
    @IBAction func loadJSON(sender: UIButton) {
        self.startGame.hidden = true
            userMakeHisChoose = false
            altArray.shuffle()
            self.label.text = shuffleArray[nextWord]
        
        var choicesArray: [UIButton]! {
            get {
                return [firstButton, secondButton, thirdButton, fourthButton]
            }
        }
        
        for item in 0...3 {
            choicesArray[item].layer.borderWidth = 1
            choicesArray[item].backgroundColor = UIColor.whiteColor()
            choicesArray[item].setTitleColor(UIColor.blackColor(), forState: .Normal)
            choicesArray[item].setTitle(altArray[Int(arc4random_uniform(190))], forState: .Normal)
        }
        
        let randomChoice = Int(arc4random_uniform(4))
        let randomChoiceTitle = choicesArray[randomChoice]
        randomChoiceTitle.setTitle(String(wordsForTranslation[self.label.text!]!), forState: .Normal)
        
            UIView.animateWithDuration(0.3, animations: {
                self.firstButton.alpha = 1
                self.label.alpha = 1
            })
            animationView(0.4, button: self.secondButton)
            animationView(0.5, button: self.thirdButton)
            animationView(0.6, button: self.fourthButton)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        request(.GET, "https://dictionary.skyeng.ru/api/v1/wordtasks?meaningIds=211138,226138,177344,196957,224324,89785,79639,173148,136709,158582,92590,135793,68068,64441,46290,128173,51254,55112,222435").responseJSON {
            response in
            
            // JSON Data из URL
            let jsonData = JSON(data: response.data!)
            
            //Делаем словарь: привязываем перевод к слову и наполняем массив англ. слов
            for item in jsonData.array! {
                let text = item["text"].stringValue
                let translation = item["translation"].stringValue
                    for item2 in item["alternatives"].array! {
                        let alternative = item2["translation"].stringValue
                        altArray.append(alternative)
                    }
                shuffleArray.append(text)
                wordsForTranslation.setValue(translation, forKey: text)
            }
            shuffleArray.shuffle()
            shuffleArray.removeLast(9)
        }
    }
}

