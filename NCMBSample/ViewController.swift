//
//  ViewController.swift
//  NCMBSample
//
//  Created by 佐藤未悠 on 2021/04/28.
//

import UIKit
import NCMB

class ViewController: UIViewController {
    
    @IBOutlet var SampleTextField : UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func save(_ sender: Any) {
        let object = NCMBObject(className:"Message")
        object?.setObject(SampleTextField.text, forKey: "text")
        object?.saveInBackground{ (error) in
            if error != nil{
                //エラーが発生したら
                print("error")
            }else {
                //保存に成功した場合
                print("success.navigationBarBackButtonHidden(/*@START_MENU_TOKEN@*/false/*@END_MENU_TOKEN@*/)")
            }
        }
    }
    
    
    @IBAction func loadData(_ sender: Any) {
        let query = NCMBQuery(className: "Message")
        query?.findObjectsInBackground{ (result, error) in
            if error != nil{
                //エラーの場合
                print("error")
            }else {
                //うまく取得できた場合
                let messages = result as! [NCMBObject]
                let text = messages.last?.object(forKey:"text") as! String
                
                self.SampleTextField.text = text
            }
        }
    }
    
    @IBAction func update() {
        let query = NCMBQuery(className: "Message")
        query?.whereKey("text", equalTo:"あいうえお")
        query?.findObjectsInBackground { (result, error) in
            if error != nil{
                print("error")
            }else {
                let messages = result as! [NCMBObject]
                let textobject = messages.first
                textobject?.setObject("こんばんは", forKey: "text")
                textobject?.saveInBackground{ (error) in
                    if error != nil {
                        print("error")
                    }else {
                        print("update success")
                    }
                }
            }
        }
    }
      
    
    //てすとと書いてあるところを削除する→できてない
    @IBAction func delete () {
        let query = NCMBQuery(className: "Message")
        query?.whereKey("text", equalTo: "てすと")
        query?.findObjectsInBackground{ (result, error) in
            if error != nil {
                print(error)
            }else {
                let message = result as! [NCMBObject]
                let textObject = message.first
                textObject?.deleteInBackground{ (error) in
                    if error != nil{
                        print(error)
                    }else {
                        print("Delete succeed")
                    }
                }
            }
        }
    }
    
    

}

