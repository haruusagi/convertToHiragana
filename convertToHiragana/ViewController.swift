//
//  ViewController.swift
//  convertToHiragana
//
//  Created by harusa on 2020/02/22.
//  Copyright © 2020 はるうさ. All rights reserved.
//

import UIKit

class ViewController: UIViewController ,UITextFieldDelegate{

    @IBOutlet weak var convertText: UITextField!
    @IBOutlet weak var convertedText: UILabel!
    @IBOutlet weak var errorText: UILabel!
    
    let api = API()
    
    override func viewDidLoad() {
        super.viewDidLoad()
<<<<<<< HEAD
=======
        convertText.text = ""
        
>>>>>>> ca0a2c762311dbb376cdc9b1033d9bb1078536c9
    }
        @IBAction func convertButton(_ sender: Any) {
        guard let convertTextForApi = convertText.text else {
        return
        }
       //api通信
        self.api.convertHiragana(convertTextForApi: convertTextForApi) { (convertedStr) in
        guard let _convertedStr = convertedStr else {
              //コンバート失敗
              //アラートを出す
              return
          }
          DispatchQueue.main.async {
              self.convertedText.text = _convertedStr
          }
      }

    }
}
