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
        
        
        let email = emailTextView.text!
        let accessCode = accessCodeTextView.text!
       // print(email)
        print(accessCode)
        
        let e = ["email": email, "access code": accessCode]
        //print(e)
        
        //self.dbConnect.child("Quiz").child("quizId").child("players").childByAutoId().setValue(e);
        
//        let q = self.dbConnect.child("Quiz").child("quizId")
//        print(q)
       
        handle = dbConnect?.child("Quiz").child("quizId").child("4205356299").observe(.value, with: { (snapshot) in
            
            print(snapshot)
//            ViewController.questionData = snapshot
        })
    }
    
}

