//
//  QuizViewController.swift
//  FBtest
//
//  Created by Himauli Patel on 2018-07-27.
//  Copyright © 2018 robin. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import Alamofire
import SwiftyJSON

class QuizViewController: UIViewController {

    var dbConnect:DatabaseReference!
    var handle: DatabaseHandle?
    var handle2: DatabaseHandle?
    var alertController: UIAlertController!
    
    var label = ""
    var message = "in "
    var countdownTimer: Timer!
    var totalTime = 10
    
   // var optionSelected = ""
   // var timeTaken = ""
    var counter = 19
    var ans = ""
    
    var answers = [NSString]()
    var timeTaken :[Int] = []
    var optionSelected = [Any]()
    
    var email:String = ""
    var accessCode:String = ""
    
    var firstAlert:UIAlertController!
    
    @IBOutlet weak var lblTimer: UILabel!
    @IBOutlet weak var lblQuestions: UILabel!
    
    private static var questionData: String!
    
    private static var store: Array<String> = Array()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        


        self.dbConnect = Database.database().reference()
        
        handle = dbConnect?.child("Quiz").child("quizId").child(accessCode).child("hasGameStarted").observe(.value, with: { (snapshot) in
        
            print(snapshot)
            let checker:Bool!
            checker = snapshot.value as! Bool
            
             print("AFTER TRANSACTION")
            print(checker)
            
            if( checker ){
                
                if( !self.firstAlert.isBeingDismissed ){
                   self.firstAlert.dismiss(animated: true, completion: nil)
                }
                
                self.lblQuestions.text = String(self.counter)
                self.startTimer()
                
            }else{
             
                self.firstAlert = UIAlertController(title: "Wait", message: "Please wait while all the users logIn to system.", preferredStyle: UIAlertControllerStyle.alert)
                self.present(self.firstAlert, animated: true, completion: nil)
                
                
            }
            

        })
        
      
  
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // options click event
    @IBAction func optionApressed(_ sender: UIButton) {
       
        // get the clicked one
        if (sender.tag == 0) {
            //print("Option A selected")
            ans = "A"
        }
        if (sender.tag == 1) {
            //print("Option B selected")
            ans = "B"
        }
        else if(sender.tag == 2) {
            //print("Option C selected")
            ans = "C"
        }
        else if(sender.tag == 3) {
            //print("Option D selected")
            ans = "D"
        }
        print(ans)
        
        print(totalTime)
        print("---")
        // append the array of time taken for options clicked
        timeTaken.append(totalTime)
        print(timeTaken)
        
        var totalTimeTaken:Int!
        totalTimeTaken = 10-totalTime;
        
        print("***")
        var optionChoosen = [NSString:NSString]()
        optionChoosen["option_choosen"] = NSString(string: ans)
        optionChoosen["time_taken_in_second"] = NSString(string:String(totalTimeTaken))
        
       // print(optionChoosen)
        
        // append in final array
        optionSelected.append(optionChoosen)
        print(optionSelected)
        
        // email and accessCode
        var result = [NSString:Any]()
        result["UserName"] = NSString(string: email)
        result["Access Code"] = NSString(string: accessCode)
        
        print(result)
        
        showAlert()
        countDownString()
        print(countdownTimer)
        
        // insert into firebase
        
        let e = ["option_choosen":optionSelected] as [String : Any]
        result["Answers"] = optionSelected
        
    self.dbConnect.child("Quiz").child("quizId").child(accessCode).child("Questions").child( String( self.counter ) ).child("Users").child(email).setValue(result)
        
    }
    
    // function to start the timer
    func startTimer() {
        
        countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
    }
    
    // function to update the time
    func updateTime()
    {
        let t = "\(timeFormatted(totalTime))"
        lblTimer.text = t
        //print(t)
        
        // run the timer for 10 seconds
        if (totalTime > 0) {
            self.totalTime -= 1
            print(totalTime)
            
        }
        else {
            
            // dismiss the alert after 10 seconds
            dismiss(animated: true, completion: nil)
            countdownTimer.invalidate()
            
            // store the answers
            answers.append(ans as NSString)
            print(answers)
            
            // run the counter for 20 times
            if (counter > 0)
            {
                self.totalTime = 10
                self.counter -= 1
                print("===Round Start===")
                // change the label
                lblQuestions.text = String(counter)
                startTimer()
                
            }
            else
            {
                dismiss(animated: true, completion: nil)
                countdownTimer.invalidate()
                
                // Game over alert
                let alert = UIAlertController(title: "Game Over", message: "Time out", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Your score will be presented on the main system.", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    // function to format the time
    func timeFormatted(_ totalSeconds: Int) -> String {
        let seconds: Int = totalSeconds % 60
        let minutes: Int = (totalSeconds / 60)
        //     let hours: Int = totalSeconds / 3600
        return String(format: "%02d:%02d", minutes, seconds)
    }


    // alert after evert question
    func showAlert(){
        let alertController = UIAlertController(title: "Wait for ", message:countDownString(), preferredStyle: .alert)

        present(alertController, animated: true){
//            self.countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.updateTime), userInfo: nil, repeats: true)
            
        }
    }

    // function to print the remaining seconds -> terminal and alert
    func countDownString() -> String {

        print("\(totalTime) seconds")
        return "\(totalTime) seconds"
    }
    

}
