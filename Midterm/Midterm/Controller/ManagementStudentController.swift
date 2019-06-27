//
//  ManagementStudentController.swift
//  Midterm
//
//  Created by SonPham on 10/28/18.
//  Copyright © 2018 SonPham. All rights reserved.
//

import UIKit
class ManagementStudentController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    var indexSelectStudent:Int!
    
    @IBOutlet weak var TableStudent: UITableView!
  
    var ListStudent:[Student]=[
        Student(firstName: "Son", lastName: "Pham", classStudent: "IOS", idStudent: "1612565", birthDay: "16/02/1998",gender:"Male",otherInfo:""),
        Student(firstName: "Huy", lastName: "Pham", classStudent:"Android", idStudent:"1612557" ,birthDay: "16/03/1998",gender:"Male",otherInfo:""),
        Student(firstName: "My", lastName: "Huynh", classStudent: "C++", idStudent: "1616964",birthDay: "03/05/1998",gender:"Female",otherInfo:"")
            ]
    override func viewDidLoad() {
        print("koi tao quan li")
        super.viewDidLoad()
        TableStudent.dataSource = self
        TableStudent.delegate = self
        let btnAddStudent = UIBarButtonItem(barButtonSystemItem: .add, target: self, action:#selector(GoToAddStudent))
        let btnEditStudent = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action:#selector(GoToEditStudent))
        self.navigationItem.leftBarButtonItem=btnAddStudent
        self.navigationItem.rightBarButtonItem=btnEditStudent
        // Do any additional setup after loading the view.
    }
    func AddStudent(student:Student){
        ListStudent.append(student)
    }
    func RemoveStudent(student:Student){
        for i in 0...ListStudent.count{
            if student.IdStudent == ListStudent[i].IdStudent{
                ListStudent.remove(at: i)
            }
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if ConstantStudent.isLoadData == true{
            print("add susseful")
            let student:Student = ConstantStudent.studentTemp
            AddStudent(student: student)
            TableStudent.reloadData()
            ConstantStudent.isLoadData=false
        }
        else if ConstantStudent.isChangeData == true{
            ListStudent.remove(at: indexSelectStudent)
            ListStudent.insert(ConstantStudent.studentTemp, at: indexSelectStudent)
            //AddStudent(student: ConstantStudent.studentTemp)
            TableStudent.reloadData()
            ConstantStudent.isChangeData = false
            
        }
        else{
            TableStudent.reloadData()
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationViewController = segue.destination as? ViewDetailStudentController{
            
            
        }
    }
    //true la ko ton tai false la ton tai
    func CheckIdenticalStudent(idStudent:String)->Bool{
        for i in 0...ListStudent.count{
            if idStudent == ListStudent[i].IdStudent{
                return false
            }
        }
        return true
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ListStudent.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CELL") as! TableViewCellStudent
        //cell.SetNameLabelStudent(firstName:mang2[indexPath.row].FirstName,lastName:mang2[indexPath.row].LastName)
        cell.SetInformationStudent(student: ListStudent[indexPath.row])
       
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sb=UIStoryboard(name:"Main",bundle:nil)
        let editStudentScreen=sb.instantiateViewController(withIdentifier: "ID_STORY_VIEW_DETAIL") as! ViewDetailStudentController
        editStudentScreen.student = ListStudent[indexPath.row]
        indexSelectStudent=indexPath.row
        self.navigationController?.pushViewController(editStudentScreen, animated: true)
    }
    @objc func GoToAddStudent(){
        print("add student")
        let sb=UIStoryboard(name:"Main",bundle:nil)
        let addStudentScreen=sb.instantiateViewController(withIdentifier: "ID_STORY_ADD_STUDENT")
        self.navigationController?.pushViewController(addStudentScreen, animated: true)
        
    }
    @objc func GoToEditStudent(){
        print("edit student")
        TableStudent.isEditing = !TableStudent.isEditing
        
//        let notificationStudent = UIAlertController(title: "Notifications", message: "Select Student First !!!", preferredStyle: .alert)
//          notificationStudent.addAction(UIAlertAction(title: "OK", style: .default, handler:nil))
//        self.present(notificationStudent, animated: true, completion: nil)
        
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if(editingStyle == .delete)
        {
            let notificationStudent = UIAlertController(title: "Notifications", message: "Do you want to remove this student", preferredStyle: .alert)

            notificationStudent.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in
                
                self.ListStudent.remove(at: indexPath.row)
                tableView.beginUpdates()
                tableView.deleteRows(at:[indexPath], with: .automatic)
                tableView.endUpdates()
                }))
            notificationStudent.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil ))
            self.present(notificationStudent, animated: true, completion: nil)
        }
    }
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let studentTemp=ListStudent[sourceIndexPath.row]
        tableView.beginUpdates()
        tableView.moveRow(at: sourceIndexPath, to: destinationIndexPath)
        print("move from ", sourceIndexPath.row)
        print("move to ", destinationIndexPath.row)
        ListStudent.remove(at: sourceIndexPath.row)
        ListStudent.insert(studentTemp, at: destinationIndexPath.row)
        
        tableView.endUpdates()
        
        
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
