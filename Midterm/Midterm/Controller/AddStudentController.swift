//
//  AddStudentController.swift
//  Midterm
//
//  Created by SonPham on 10/29/18.
//  Copyright © 2018 SonPham. All rights reserved.
//

import UIKit

class AddStudentController: UIViewController {

    var NewStudent:[Student]!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var txtFirstName: UITextField!
    @IBOutlet weak var txtLastName: UITextField!
    @IBOutlet weak var txtIdStudent: UITextField!
    @IBOutlet weak var txtClassStudent: UITextField!
    @IBOutlet weak var txtOtherInfoStudent: UITextField!
    @IBOutlet weak var scGenderStudent: UISegmentedControl!
    @IBOutlet weak var imgStudent: UIImageView!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    var dateTemp:String!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        let btnSaveStudent = UIBarButtonItem(barButtonSystemItem: .save, target: self, action:#selector(AddStudentToList))
        self.navigationItem.rightBarButtonItem=btnSaveStudent
        // Do any additional setup after loading the view.
        // add button done
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(DoneButton))
        toolbar.setItems([flexibleSpace,doneButton], animated: true)
        txtFirstName.inputAccessoryView = toolbar
        txtLastName.inputAccessoryView = toolbar
        txtIdStudent.inputAccessoryView = toolbar
        txtClassStudent.inputAccessoryView = toolbar
        txtOtherInfoStudent.inputAccessoryView = toolbar
        datePicker.addTarget(self, action: #selector(datePickerValueChanged(_:)), for: .valueChanged)
    }
    @objc func datePickerValueChanged(_ sender: UIDatePicker){
        
        // Create date formatter
        let dateFormatter: DateFormatter = DateFormatter()
        
        // Set date format
        dateFormatter.dateFormat = "dd/MM/yyyy"
        
        // Apply date format
        dateTemp = dateFormatter.string(from: sender.date)
        
        print("Selected value \(dateTemp)")
    }
    
    
    @objc func DoneButton()
    {
        view.endEditing(true)
    }
    @IBAction func scGenderchange(_ sender: UISegmentedControl) {
      let result = scGenderStudent.titleForSegment(at: scGenderStudent.selectedSegmentIndex)
        if result == "Male"{
            imgStudent.image=UIImage(named: "imageStudentMaleDefault")
        }
        else{
            imgStudent.image=UIImage(named: "imageStudentFemaleDefault")
        }
    }
    func CheckInputStudent()->Bool{
        if txtFirstName.text == ""{
            let notificationStudent = UIAlertController(title: "Notifications", message: "First Name is empty !!!", preferredStyle: .alert)
            notificationStudent.addAction(UIAlertAction(title: "OK", style: .default, handler:nil))
            self.present(notificationStudent, animated: true, completion: nil)
            return false
        }
        else if txtLastName.text == ""{
            let notificationStudent = UIAlertController(title: "Notifications", message: "Last Name is empty !!!", preferredStyle: .alert)
            notificationStudent.addAction(UIAlertAction(title: "OK", style: .default, handler:nil))
            self.present(notificationStudent, animated: true, completion: nil)
            return false
        }
        else if txtIdStudent.text == ""{
            let notificationStudent = UIAlertController(title: "Notifications", message: "ID Student is empty !!!", preferredStyle: .alert)
            notificationStudent.addAction(UIAlertAction(title: "OK", style: .default, handler:nil))
            self.present(notificationStudent, animated: true, completion: nil)
            return false
        }
        else if txtClassStudent.text == ""{
            let notificationStudent = UIAlertController(title: "Notifications", message: "Class is empty !!!", preferredStyle: .alert)
            notificationStudent.addAction(UIAlertAction(title: "OK", style: .default, handler:nil))
            self.present(notificationStudent, animated: true, completion: nil)
            return false
        }
        return true
    }
    @objc func AddStudentToList(){
        print("add new student")
        if CheckInputStudent() == true{
            ConstantStudent.isLoadData=true
            ConstantStudent.studentTemp=Student(firstName: txtFirstName.text!, lastName: txtLastName.text!, classStudent: txtClassStudent.text!, idStudent: txtIdStudent.text!, birthDay: dateTemp, gender: scGenderStudent.titleForSegment(at: scGenderStudent.selectedSegmentIndex)!,otherInfo:txtOtherInfoStudent.text!)
            self.navigationController?.popViewController(animated: true)
        }
        

        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @objc func keyboardWillShow(notification: NSNotification) {
        print("keyboardWillShow")
        var userInfo = notification.userInfo!
        var keyboardFrame:CGRect = (userInfo[UIKeyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        keyboardFrame = self.view.convert(keyboardFrame, from: nil)
        
        var contentInset:UIEdgeInsets = self.scrollView.contentInset
        contentInset.bottom = keyboardFrame.size.height + 100
        self.scrollView.contentInset = contentInset
        
    }
    
    @objc func keyboardWillHide(notification: NSNotification){
        print("keyboardWillHide")
        let contentInset:UIEdgeInsets = UIEdgeInsets.zero
        self.scrollView.contentInset = contentInset
    }

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
