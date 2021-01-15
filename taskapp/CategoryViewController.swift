//
//  CategoryViewController.swift
//  taskapp
//
//  Created by 辻志保美 on 2021/01/13.
//

import UIKit
import RealmSwift

class CategoryViewController: UIViewController {
    //Outlet接続
    @IBOutlet weak var categoryTextField: UITextField!
    
    let realm = try! Realm()
    var category:Category!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        try! realm.write{
            self.category.categoryName = categoryTextField.text!
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
