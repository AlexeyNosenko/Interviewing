//
//  ManViewController.swift
//  Interviewing
//
//  Created by Алексей on 22.01.2018.
//  Copyright © 2018 Алексей. All rights reserved.
//

import UIKit

class ManViewController: UIViewController {

    @IBOutlet weak var imageViewPhoto: UIImageView!
    
    @IBOutlet weak var textFieldLastname: UITextField!
    
    @IBOutlet weak var textFieldFirstname: UITextField!
    
    @IBOutlet weak var textFieldBirthday: UITextField!
    
    var man: Man?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textFieldLastname.delegate = self
        textFieldFirstname.delegate = self
    }
    
    func updateUI(){
        if let man = man{
            
        }
        roundedImage()
    }
    
    @IBAction func tappedPhoto(_ sender: Any) {
        print("choosePhoto")
        choosePhotoLibrary()
        roundedImage()
    }
   
    func datePicker(showForTextField textField: UITextField){
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.accessibilityIdentifier = textField.placeholder
        textField.inputView = datePicker
        datePicker.addTarget(self, action: #selector(datePickerChangeValue), for: UIControlEvents.valueChanged)
    }
    
    @objc func datePickerChangeValue(sender: UIDatePicker){
        if (sender.accessibilityIdentifier == textFieldBirthday.placeholder){
            textFieldBirthday.text = sender.date.toString()
        }
    }
    
    @IBAction func tappedTextField(_ sender: UITextField) {
        if (sender == textFieldBirthday){
            datePicker(showForTextField: sender)
        }
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

extension ManViewController: UINavigationControllerDelegate{
    
}

extension ManViewController: UIImagePickerControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let img = info[UIImagePickerControllerOriginalImage] as? UIImage{
            imageViewPhoto.image = img
            print("Choosed image = ", img)
        }
        dismiss(animated: true, completion: nil)
    }
    
    func choosePhotoLibrary(){
        print("Choose photo")
        let imagePicker = UIImagePickerController();
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = false
        present(imagePicker, animated: true, completion: nil)
    }
    
    func roundedImage(imageView: UIImageView, rounded: CGFloat){
        imageView.layer.borderWidth = 1.0
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.cornerRadius = imageView.frame.size.height / rounded
        imageView.clipsToBounds = true
    }
    
    func roundedImage(){
        roundedImage(imageView: imageViewPhoto, rounded: 2.0)
    }
}

extension ManViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
