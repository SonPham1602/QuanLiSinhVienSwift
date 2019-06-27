//
//  TableViewCellStudent.swift
//  Midterm
//
//  Created by SonPham on 10/29/18.
//  Copyright © 2018 SonPham. All rights reserved.
//

import UIKit

class TableViewCellStudent: UITableViewCell {

    @IBOutlet weak var ImageStudent: UIImageView!
    @IBOutlet weak var NameStudent: UILabel!
    @IBOutlet weak var BirthdayStudent: UILabel!
    @IBOutlet weak var ClassStudent: UILabel!
    @IBOutlet weak var OtherInfoStudent: UILabel!
    @IBOutlet weak var IdStudent: UILabel!
    func SetInformationStudent(student:Student){
        let result:String=student.FirstName+" "+student.LastName
        NameStudent.text=result
        BirthdayStudent.text="Birthday: " + student.DateOfBirth
        ClassStudent.text = "Class: "+student.ClassStudent
        IdStudent.text="ID: "+student.IdStudent
        if(student.Gender=="Male"){
            ImageStudent.image=UIImage(named: "imageStudentMaleDefault")
        }
        else{
              ImageStudent.image=UIImage(named: "imageStudentFemaleDefault")
        }
        
    }
    func SetNameLabelStudent(firstName:String,lastName:String){
        let result:String=firstName+" "+lastName
        NameStudent.text=result
    }
    func SetClassLabelStudent(classStudent:String){
        ClassStudent.text=classStudent
    }
    func SetOtherInfoLabelStudent(infoStudent:String){
      
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
