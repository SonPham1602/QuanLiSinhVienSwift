//
//  ViewDetailStudentController.swift
//  Midterm
//
//  Created by SonPham on 10/28/18.
//  Copyright © 2018 SonPham. All rights reserved.
//

import UIKit
class ViewDetailStudentController: UIViewController{
    var student:Student!
    var dateTemp:String = ""
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var txtFirstName: UITextField!
    @IBOutlet weak var txtLastName: UITextField!
    @IBOutlet weak var txtIdStudent: UITextField!
    @IBOutlet weak var txtClassStudent: UITextField!
    @IBOutlet weak var imageStudent: UIImageView!
    @IBOutlet weak var txtOtherInfoStudent: UITextField!
    @IBOutlet weak var scGenderStudent: UISegmentedControl!
    
    @IBAction func ChangeGender(_ sender: UISegmentedControl) {
        let result = scGenderStudent.titleForSegment(at: scGenderStudent.selectedSegmentIndex)
        if result == "Male"{
            imageStudent.image=UIImage(named: "imageStudentMaleDefault")
        }
        else{
            imageStudent.image=UIImage(named: "imageStudentFemaleDefault")
        }
    }
    
    @objc func datePickerValueChanged(_ sender: UIDatePicker){
        
        // Create date formatter
        //        let dateFormatter = DateFormatter()
        //
        //        // Set date format
        //        dateFormatter.dateFormat = "dd/MM/yyyy"
        //
        //        // Apply date format
        //        dateTemp = dateFormatter.string(from: sender.date)
        //
        //        print("Selected value \(dateTemp)")
    }
    override func viewDidLoad() {
        
        super.viewDidLoad()
          print("koi tao view hoc sinh")
        txtFirstName.text=student.FirstName
        txtLastName.text=student.LastName
        txtIdStudent.text=student.IdStudent
        txtClassStudent.text=student.ClassStudent
        txtOtherInfoStudent.text=student.OtherInfo
       
        dateTemp = student.DateOfBirth
        
        print(dateTemp)
        if(student.Gender == "Male")
        {
            scGenderStudent.selectedSegmentIndex=0
            imageStudent.image = UIImage(named: "imageStudentMaleDefault")
        }
        else{
            
            scGenderStudent.selectedSegmentIndex=1
            imageStudent.image = UIImage(named: "imageStudentFemaleDefault")
        }
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        let btnSaveStudent = UIBarButtonItem(barButtonSystemItem: .save, target: self, action:#selector(AddStudentToList))
        self.navigationItem.rightBarButtonItem=btnSaveStudent
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapView(gesture:)))
        view.addGestureRecognizer(tapGesture)
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
        SetDatePickerInit(string: student.DateOfBirth)
       
        //datePicker.addTarget(self, action: #selector(datePickerValueChanged(_:)), for: .valueChanged)
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    @IBAction func ChangeDate(_ sender: UIDatePicker) {
      //   Create date formatter
                let dateFormatter = DateFormatter()
        
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
    
   @objc func didTapView(gesture :UITapGestureRecognizer)
    {
        view.endEditing(true)
    }
    func SetDatePickerInit(string:String){
       
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat =  "dd/MM/yyyy"
        
        let date = dateFormatter.date(from: string)
        
        datePicker.date = date!
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
        if CheckInputStudent() == true{
            
            ConstantStudent.isChangeData=true
            ConstantStudent.studentTemp=Student(firstName: txtFirstName.text!, lastName: txtLastName.text!, classStudent: txtClassStudent.text!, idStudent: txtIdStudent.text!, birthDay: dateTemp, gender: scGenderStudent.titleForSegment(at: scGenderStudent.selectedSegmentIndex)!,otherInfo:txtOtherInfoStudent.text!)
            self.navigationController?.popViewController(animated: true)
           
        }
        
        
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
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

