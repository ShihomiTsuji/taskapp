//
//  InputViewController.swift
//  taskapp
//
//  Created by 辻志保美 on 2021/01/02.
//

import UIKit
import RealmSwift
import UserNotifications

class InputViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate{
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var categoryTextField: UITextField!
    @IBOutlet weak var contentsTextView: UITextView!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var categoryPickerView: UIPickerView!
    
    
    let realm = try! Realm()
    var task: Task!
    var category: Category!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //pickerViewのデリゲート
        categoryPickerView.delegate = self
        categoryPickerView.dataSource = self
        
        //背景をタップ時dismisskeyboardメソッドを呼び出し
        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action:#selector(dismissKeyboard))
        self.view.addGestureRecognizer(tapGesture)
        
        titleTextField.text = task.title
        contentsTextView.text = task.contents
        datePicker.date = task.date
//pickerViewに変更
        categoryTextField.text = category.categoryName
        contentsTextView.layer.borderColor = UIColor.black.cgColor
    }

    override func viewWillDisappear(_ animated: Bool) {
        try! realm.write {
            self.task.title = self.titleTextField.text!
            self.task.contents = self.contentsTextView.text!
            self.task.date = self.datePicker.date
//以下の行要修正
            self.task.category_id = self.categoryTextField.text!
            self.realm.add(self.task, update: .modified)
        }
        
        setNotification(task: task)
        super.viewWillDisappear(animated)
    }
    
    func setNotification(task: Task) {
        let content = UNMutableNotificationContent()
        //中身なしの場合は（xx）なしを表示
        if task.title == "" {
            content.title = "(タイトルなし)"
        } else {
            content.title = task.title
        }
        if task.contents == "" {
            content.body = "(コンテンツなし)"
        } else {
            content.body = task.contents
        }
        content.sound = UNNotificationSound.default
        
        //ローカル通知が発動するトリガー（日付マッチ）を作成
        let calendar = Calendar.current
        let dateComponents = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: task.date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        
        //identifier, contents, triggerからローカル通知を作成(identifierが同じだとローカル通知を上書き保存)
        let request = UNNotificationRequest(identifier: String(task.id), content: content, trigger: trigger)
        
        //ローカル通知を登録
        let center = UNUserNotificationCenter.current()
        center.add(request) { (error) in
            print(error ?? "ローカル通知登録　OK") // error が nil ならローカル通知の登録に成功したと表示します。errorが存在すればerrorを表示します。
        }
        
        // 未通知のローカル通知一覧をログ出力
                center.getPendingNotificationRequests { (requests: [UNNotificationRequest]) in
                    for request in requests {
                        print("/---------------")
                        print(request)
                        print("---------------/")
                    }
                }
    }
    
    @objc func dismissKeyboard(){
        //キーボードを閉じる
        view.endEditing(true)
    }
    
    //カテゴリーのリスト
    var categoryArray = try! Realm().objects(Category.self).sorted(byKeyPath: "category_id", ascending: true)
    
    //categoryPickerViewの列数
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    //categoryPickerViewの行数、リストの数
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categoryArray.count
    }
    
    //categoryPickerViewの最初の表示
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return categoryArray???
    }
    
    //UIPickerViewのRowが選択された時の挙動
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        <#code#>
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
