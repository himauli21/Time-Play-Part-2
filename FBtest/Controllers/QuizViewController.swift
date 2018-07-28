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
    private static var questionData: String!
    
//    let URL = "https://opentdb.com/api.php?amount=20&difficulty=easy&type=multiple"
//
//    let url = "https://opentdb.com/api.php?amount=20&difficulty=easy&type=multiple"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.dbConnect = Database.database().reference()
        
        handle = dbConnect?.child("Quiz").child("quizId").child("4205356299").observe(.value, with: { (snapshot) in
        
        print(snapshot)
            
            print(snapshot)
        
            //QuizViewController.questionData = snapshot
            
        
        })
        
        //getQuestions(url: URL)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func optionApressed(_ sender: UIButton) {
        
        if (sender.tag == 0) {
            print("Option A selected")
        }
        if (sender.tag == 1) {
            print("Option B selected")
        }
        else if(sender.tag == 2) {
            print("Option C selected")
        }
        else if(sender.tag == 3) {
            print("Option D selected")
        }
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
