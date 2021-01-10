//
//  Task.swift
//  taskapp
//
//  Created by 辻志保美 on 2021/01/03.
//

import RealmSwift

class Task: Object {
    //管理用ID。プライマリーキー
    @objc dynamic var id = 0
    
    //タイトル
    @objc dynamic var title = ""
    
    //カテゴリ
    @objc dynamic var category = ""
    
    //内容
    @objc dynamic var contents = ""
    
    //日時
    @objc dynamic var date = Date()
    
    //idをプリマリキーとして設定
    override static func primaryKey() -> String? {
        return "id"
    }
}
