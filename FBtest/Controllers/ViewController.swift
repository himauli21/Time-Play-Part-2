//
//  ViewController.swift
//  FBtest
//
//  Created by robin on 2018-07-19.
//  Copyright © 2018 robin. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class ViewController: UIViewController {

    var dbConnect:DatabaseReference!
    var handle: DatabaseHandle?
    
    private static var questionData: String!
    
    @IBOutlet weak var emailTextView: UITextField!
    @IBOutlet weak var accessCodeTextView: UITextField!
    
    var email:String = ""
    var accessCode:String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
         self.dbConnect = Database.database().reference()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func nextBtnPressed(_ sender: UIButton) {
        
        print("Next Button Pressed!")
        
        
        self.email = emailTextView.text!
        self.accessCode = accessCodeTextView.text!
        let optionSelected = "A"
        let timeTaken = "3 seconds"
       // print(email)
       // print(accessCode)
        
       
        let e = ["email": email, "option selected":optionSelected, "time taken":timeTaken]
        //print(e)
        
        //self.dbConnect.child("Quiz").child("quizId").child("players").childByAutoId().setValue(e);
       // self.dbConnect.child("Quiz").child("quizId").child("Access Code").child("3993760988").child("Email").setValue(e);
       // self.dbConnect.child("Quiz").child("quizId").child("Access Code").child(String(accessCode)).child("Participants").child(String(email)).setValue(e)
        
//        let q = self.dbConnect.child("Quiz").child("quizId")
//        print(q)
       
        handle = dbConnect?.child("Quiz").child("quizId").child("4205356299").observe(.value, with: { (snapshot) in
            
            print(snapshot)
//            ViewController.questionData = snapshot
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let s = segue.destination as! QuizViewController
        s.email = email
        s.accessCode = accessCode
    }
    
}

