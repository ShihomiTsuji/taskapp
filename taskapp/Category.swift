//
//  Category.swift
//  taskapp
//
//  Created by 辻志保美 on 2021/01/13.
//

import RealmSwift

class Category: Object {
    //管理用ID。プライマリーキー
    @objc dynamic var category_id = 0
    
    //カテゴリー名
    @objc dynamic var categoryName = ""
        
    //category_idをプリマリキーとして設定
    override static func primaryKey() -> String? {
        return "category_id"
    }
}
