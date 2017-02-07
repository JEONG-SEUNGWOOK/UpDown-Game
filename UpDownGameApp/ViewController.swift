//
//  ViewController.swift
//  UpDownGameApp
//
//  Created by Seungwook Jeong on 2017. 1. 25..
//  Copyright © 2017년 boostcamp. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var progressCounter: UILabel!
    @IBOutlet weak var inputLabel: UILabel!
    @IBOutlet weak var inputAnswerField: UITextField!
    @IBOutlet weak var okButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var logTableView: UITableView!
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var game = UpDownGame.init(max: 10)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        segmentControl.selectedSegmentIndex = 0
        
        game.setMax(10)
        game.setLimitCount(5)
        setCountProgressBar(0, game.getLimitCount())
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return appDelegate.getLogCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewReuseIdentifier", for: indexPath)
        cell.textLabel?.text = appDelegate.getLogData(indexPath.row)
        return cell
    }
    
    func allocateMax(max : UInt32){
        game = UpDownGame.init(max: max)
    }
    
    func setCountProgressBar(_ value : Int, _ max : Int){
        progressBar.setProgress(Float(value)/Float(max), animated: true)
        progressCounter.text = "\(value) / \(max)"
    }
    
    func alertMessage(_ title: String, _ message: String){
        let alert = UIAlertController(title: title, message:message, preferredStyle: .alert)
        
        
        alert.addAction(UIAlertAction.init(title: "확인", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func didWin(_ win : Bool){
        
        let alert = UIAlertController(title: "결과", message: win ? "Win!" : "Game Over! Result : \(game.getAnswer())", preferredStyle: .alert)
        
        
        alert.addAction(UIAlertAction.init(title: "확인", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

    @IBAction func selectSegment(_ sender: UISegmentedControl) {
        switch segmentControl.selectedSegmentIndex {
        case 0:
            inputLabel.text = "1~10 사이의 값을 입력해주세요"
            game.setMax(10)
            game.setLimitCount(5)
            allocateMax(max: game.getMax())
            setCountProgressBar(0, game.getLimitCount())
            
        case 1:
            inputLabel.text = "1~50 사이의 값을 입력해주세요"
            game.setMax(50)
            game.setLimitCount(10)
            allocateMax(max: game.getMax())
            setCountProgressBar(0, game.getLimitCount())
            
        case 2:
            inputLabel.text = "1~100 사이의 값을 입력해주세요"
            game.setMax(100)
            game.setLimitCount(20)
            allocateMax(max: game.getMax())
            setCountProgressBar(0, game.getLimitCount())
            
        default:
            alertMessage("Error!", "잘못된 입력입니다")
        }
    }
    
    @IBAction func touchOkButton(_ sender: Any) {
        var answer : Int? = nil
        
        if let input = inputAnswerField.text{
            answer = Int(input)
            
        } else {
            alertMessage("Error!", "잘못된 입력입니다")
        }
        
        var response : Int?
        if let ans = answer {
            response = game.isIt(ans)
            let count = game.getCount()
            
            if UpDownGame.right == response {
                didWin(true)
                appDelegate.appendLog("횟수 : \(game.getCount()) / \(game.getLimitCount()) 정답 : \(game.getAnswer()) Game Correnct")
                
                setCountProgressBar(0, game.getLimitCount())
                
                game = UpDownGame.init(max: game.getMax())
            }
            else if UpDownGame.over == response {
                didWin(false)
                appDelegate.appendLog("횟수 : \(game.getCount()) / \(game.getLimitCount()) 정답 : \(game.getAnswer()) Game Over")
                
                setCountProgressBar(0, game.getLimitCount())
                
                game = UpDownGame.init(max: game.getMax())
            }
            else if UpDownGame.down == response {
                inputLabel.text = "DOWN"
                setCountProgressBar(count, game.getLimitCount())
                appDelegate.appendLog("횟수 : \(game.getCount()) / \(game.getLimitCount()) DOWN")
                
            }
            else {
                inputLabel.text = "UP"
                setCountProgressBar(count, game.getLimitCount())
                appDelegate.appendLog("횟수 : \(game.getCount()) / \(game.getLimitCount()) UP")
                
                
            }
            self.inputAnswerField.text = ""
            self.logTableView.reloadData()
        }
    }
    
    
    @IBAction func touchResetButton(_ sender: Any) {
        game.reset()
        setCountProgressBar(0, game.getLimitCount())
    }
    
}

