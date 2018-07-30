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
    var timeTaken = ""
    var counter = 20
    
    @IBOutlet weak var lblTimer: UILabel!
    @IBOutlet weak var lblQuestions: UILabel!
    
    private static var questionData: String!
    
    private static var store: Array<String> = Array()
    
//    let URL = "https://opentdb.com/api.php?amount=20&difficulty=easy&type=multiple"
//
//    let url = "https://opentdb.com/api.php?amount=20&difficulty=easy&type=multiple"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.dbConnect = Database.database().reference()
        
        handle = dbConnect?.child("Quiz").child("quizId").child("4205356299").child("Questions").child("results").child("0").child("correct_answer").observe(.value, with: { (snapshot) in
        
        //print(snapshot)
            
           let ans = snapshot
            print(ans)

            //QuizViewController.questionData = snapshot

        })
        lblQuestions.text = String(counter)
        startTimer()
        
//        if (counter == 20)
//        {
//            print(counter)
//        }
//          else
//            {
//                lblQuestions.text = String(counter)
//
//                print(counter)
//                startTimer()
//                let count = counter + 1
//                //print(count)
//            }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func optionApressed(_ sender: UIButton) {
       
        var ans = ""

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
       
        showAlert()
        countDownString()
        print(countdownTimer)
        
        
        let e = ["option selected":ans, "time taken":totalTime] as [String : Any]
        self.dbConnect.child("Quiz").child("quizId").child("Access Code").child("3993760988").child("Participants").child("Himauli").setValue(e)
        
    }
    
    func startTimer() {
        
        countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
    }
    
    func updateTime() {
        let t = "\(timeFormatted(totalTime))"
        lblTimer.text = t
        //print(t)
        if (totalTime > 0) {
            self.totalTime -= 1
            print(totalTime)
    
        }
            
        else {
            dismiss(animated: true, completion: nil)
            countdownTimer.invalidate()
//            startTimer()
        }
    }
    
    func timeFormatted(_ totalSeconds: Int) -> String {
        let seconds: Int = totalSeconds % 60
        let minutes: Int = (totalSeconds / 60)
        //     let hours: Int = totalSeconds / 3600
        return String(format: "%02d:%02d", minutes, seconds)
    }


    func showAlert(){
        let alertController = UIAlertController(title: "Wait for ", message:countDownString(), preferredStyle: .alert)

        present(alertController, animated: true){
//            self.countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.updateTime), userInfo: nil, repeats: true)
            
        }
    }

    func countDownString() -> String {

        print("\(totalTime) seconds")
        return "\(totalTime) seconds"
    }
    
    
 
    /*
    func getQuestions(url:String) {
        
        // Build the URL:
        
        
        let url = "https://opentdb.com/api.php?amount=20&difficulty=easy&type=multiple"
        
        print(url)
        
        print("Patel")
        Alamofire.request(url, method: .get, parameters: nil).responseJSON {
            (response) in
            if response.result.isSuccess {
                
                if let dataFromServer = response.data {
                    do {
                        let json = try JSON(data: dataFromServer)
                        // TODO: Parse the json response
                        
                        //print(json)
                        let que = json["results"].arrayValue
                        //let date = orders[0]["created_at"].stringValue
                        //let questions = que[0]["question"].stringValue
                        
                       // print(questions)
                        
                        for item in que{
                            
                            
                            let questions = item["question"].stringValue
                            print("=====")
                            print(questions)
                            
//                            let isDate = item["created_at"].stringValue
//                            let orderId = String(describing: item["id"].doubleValue)
//                            let email = item["contact_email"].stringValue
//                            let province = item["shipping_address"]["province"].stringValue
                            
                        }
                    }
                    catch {
                        print("error")
                    }
                }
                else {
                    print("Error when getting JSON from the response")
                }
            }
            else {
                
                // 6. You got an error while trying to connect to the API
                print("Error while fetching data from URL")
            }
        }
    }
    
    */
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
   

}
