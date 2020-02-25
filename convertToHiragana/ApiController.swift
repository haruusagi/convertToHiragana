//
//  ApiController.swift
//  convertToHiragana
//
//  Created by harusa on 2020/02/25.
//  Copyright © 2020 はるうさ. All rights reserved.
//

import Foundation

class API {
    let host = "https://labs.goo.ne.jp/api"
    let appID = "e977d742bc8539d2a51f460a59a8cf28734805a548c6dc4cacf4792f63a5881a"
    let requestID = "record003"
    let postMethod = "POST"

    func convertHiragana(convertTextForApi: String, completion:((String?) -> Void)?) {
       let url = "https://labs.goo.ne.jp/api/hiragana"
        let outputType = "hiragana"
        let postData = PostData(app_id: self.appID, request_id: requestID, sentence: convertTextForApi, output_type: outputType)

        self.request(method: "POST", url: url, postData: postData, completion: completion)
    }

    func request(method: String, url: String, postData:PostData,  completion:((String?) -> Void)?) {
        guard let _url = URL(string: url) else { return }
        // URLRequstの設定
        var request = URLRequest(url: _url)
        request.httpMethod = method
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        //POSTするデータをURLRequestに持たせる
        guard let uploadData = try? JSONEncoder().encode(postData) else {
            debugPrint("json生成に失敗しました")
            return
        }
        request.httpBody = uploadData


        //APIへPOSTしてresponseを受け取る
        let task = URLSession.shared.uploadTask(with: request, from: uploadData) {
            data, response, error in
            if let error = error {
                debugPrint ("error: \(error)")
                completion?(nil)
                return
            }
            guard let response = response as? HTTPURLResponse,
                (200...299).contains(response.statusCode) else {
                    debugPrint ("server error")
                    completion?(nil)
                    return
            }
            guard response.statusCode == 200 else {
                debugPrint("サーバエラー ステータスコード: \(response.statusCode)\n")
                completion?(nil)
                return
            }

            guard let data = data, let jsonData = try? JSONDecoder().decode(Rubi.self, from: data) else {
                debugPrint("json変換に失敗しました")
                completion?(nil)
                return
            }
            debugPrint(jsonData.converted)
            completion?(jsonData.converted)

        }
        task.resume()
    }
}
struct Rubi:Codable {
    var request_id: String
    var output_type: String
    var converted: String
}
struct PostData: Codable {
    var app_id:String
    var request_id: String
    var sentence: String
    var output_type: String
}



