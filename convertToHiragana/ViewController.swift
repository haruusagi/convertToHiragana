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
