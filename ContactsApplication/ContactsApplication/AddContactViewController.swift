//
//  AddContactViewController.swift
//  ContactsApplication
//
//  Created by Praneet Reddy on 01/02/20.
//  Copyright © 2020 PraneethReddy. All rights reserved.
//

import UIKit
import CoreData

class AddContactViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    var titleText = "Add Contact"
    var contact: NSManagedObject? = nil
    var indexPathForContact: IndexPath? = nil
    var imagePickerController : UIImagePickerController!
    
    @IBOutlet weak var imageField: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var companyTextField: UITextField!
    
    @IBOutlet weak var nameErrorLabel: UILabel!
    @IBOutlet weak var phoneNumberErrorLabel: UILabel!
    @IBOutlet weak var emailErrorLabel: UILabel!
    @IBOutlet weak var companyErrorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameErrorLabel.textColor = UIColor.red
        phoneNumberErrorLabel.textColor = UIColor.red
        emailErrorLabel.textColor = UIColor.red
        companyErrorLabel.textColor = UIColor.red
        
        titleLabel.text = titleText
        if let contact = self.contact {
            nameTextField.text = contact.value(forKey: "name") as? String
            phoneNumberTextField.text = contact.value(forKey: "phoneNumber") as? String
            emailTextField.text = contact.value(forKey: "email") as? String
            companyTextField.text = contact.value(forKey: "company") as? String
            loadImageFromDiskWith(fileName: nameTextField.text!+".png")
        }
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        nameTextField.delegate = self
        phoneNumberTextField.delegate = self
        emailTextField.delegate = self
        companyTextField.delegate = self
    }
    
    func textField(_ textFieldToChange: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textFieldToChange == nameTextField {
            let characterSetNotAllowed = CharacterSet.punctuationCharacters
            if let _ = string.rangeOfCharacter(from: characterSetNotAllowed, options: .caseInsensitive) {
                nameErrorLabel.text = "Special Characters not allowed"
                return false
            }
            if nameTextField.text!.prefix(1) == " "{
                nameErrorLabel.text = "Name cannot start with space"
            }
            else{
                nameErrorLabel.text = ""
            }
        } else if textFieldToChange == phoneNumberTextField {
            let invalidFirstDigits = ["0","1","2","3","4","5"]
            let x = phoneNumberTextField.text!.prefix(1)
            let characterSet  = CharacterSet(charactersIn: "+0123456789").inverted
            if let _ = string.rangeOfCharacter(from: characterSet, options: .caseInsensitive) {
                phoneNumberErrorLabel.text = "Only numbers are allowed"
                return false
            }
            if phoneNumberTextField.text!.count > 10{
                phoneNumberErrorLabel.text = "Invalid Number"
            }
            if invalidFirstDigits.contains(String(x)){
                phoneNumberErrorLabel.text = "Number must start with (6,7,8,9)"
            }
            else{
                phoneNumberErrorLabel.text = ""
                return true
            }
        }
        else if textFieldToChange == companyTextField{
            let characterSetNotAllowed = CharacterSet.punctuationCharacters
            if let _ = string.rangeOfCharacter(from: characterSetNotAllowed, options: .caseInsensitive) {
                nameErrorLabel.text = "Special Characters not allowed"
                return false
            }
            if companyTextField.text!.count < 3{
                companyErrorLabel.text = "Length should be more than 3"
            }
            else{
                companyErrorLabel.text = ""
            }
            return true
        }
        return true
    }
    
    @IBAction func selectImage(_ sender: Any) {
        imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .savedPhotosAlbum
        present(imagePickerController, animated: true, completion: nil)
    }
    
    //MARK: - UIImagePickercontroller Delegate

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
       imagePickerController.dismiss(animated: true, completion: nil)
       imageField.image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
    }
    
    func saveImage(imageName: String, image: UIImage) {
     guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        let fileName = imageName
        var fileURL = documentsDirectory.appendingPathComponent(fileName)
        guard let data = image.jpegData(compressionQuality: 1) else { return }
        if FileManager.default.fileExists(atPath: fileURL.path) {
            do {
                try FileManager.default.removeItem(atPath: fileURL.path)
            }catch let removeError {
                print("couldn't remove file at path", removeError)
            }
        }
        do{
            try data.write(to: fileURL)
        }catch {
            fileURL = documentsDirectory.appendingPathComponent(fileName.lowercased())
            do{
                try data.write(to: fileURL)
            }
            catch let error1 {
                print(error1)
            }
        }
    }
    
    func loadImageFromDiskWith(fileName: String){
        let documentDirectory = FileManager.SearchPathDirectory.documentDirectory
        let userDomainMask = FileManager.SearchPathDomainMask.userDomainMask
        let paths = NSSearchPathForDirectoriesInDomains(documentDirectory, userDomainMask, true)
        if let dirPath = paths.first {
            let imageUrl = URL(fileURLWithPath: dirPath).appendingPathComponent(fileName)
            let image = UIImage(contentsOfFile: imageUrl.path)
            if image != nil{
                imageField.image = image
            }
            else{
                let imageUrl = URL(fileURLWithPath: dirPath).appendingPathComponent(fileName.lowercased())
                let image = UIImage(contentsOfFile: imageUrl.path)
                if image != nil{
                    imageField.image = image
                }
            }
        }
        else{
            print(fileName,"doesn't exist")
        }
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    //MARK: - Navigation
    
    @IBAction func saveAndClose(_ sender: Any) {
        if companyTextField.text!.isBlank{
            companyErrorLabel.text = ""
        }
        checkEmail()
        checkNumber()
        if (nameErrorLabel.text == "") && (phoneNumberErrorLabel.text == "") && (emailErrorLabel.text == "") && (companyErrorLabel.text == "") {
            saveImage(imageName: nameTextField.text!+".png", image: imageField.image!)
            performSegue(withIdentifier: "unwindToContactList", sender: self)
        }
    }
    
    @IBAction func close(_ sender: Any) {
        nameTextField.text = nil
        phoneNumberTextField.text = nil
        emailTextField.text = nil
        companyTextField.text = nil
        performSegue(withIdentifier: "unwindToContactList", sender: self)
        
    }
    
    func checkNumber(){
        if nameTextField.text!.prefix(1) != " "{
            nameErrorLabel.text = ""
        }
        if phoneNumberTextField.text!.count == 10{
            phoneNumberErrorLabel.text = ""
        }
        else{
            phoneNumberErrorLabel.text = "Invalid Number"
        }
    }
    
    func checkEmail(){
        if emailTextField.text!.isBlank{
            emailErrorLabel.text = ""
        }
        else if !(emailTextField.text?.isEmail)!{
            emailErrorLabel.text = "Invalid Email"
        }
        else{
            emailErrorLabel.text = ""
        }
    }
}

extension String {
    var isBlank: Bool {
        get {
            let trimmed = trimmingCharacters(in: CharacterSet.whitespaces)
            return trimmed.isEmpty
        }
    }

    //Validate Email

    var isEmail: Bool {
        do {
            let regex = try NSRegularExpression(pattern: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}", options: .caseInsensitive)
            return regex.firstMatch(in: self, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.count)) != nil
        } catch {
            return false
        }
    }

    var isAlphanumeric: Bool {
        return !isEmpty && range(of: "[^a-zA-Z0-9]", options: .regularExpression) == nil
    }
}
