//
//  EditViewController.swift
//  Anandu sem 2 final project
//
//  Created by Nandu on 2021-09-30.
//

import UIKit
import Photos
import CoreData

class EditViewController: UIViewController {
    
    var selectedPin:Location? = nil
    var selectedIndex:Int!
    var callback:(()->())?
    var datasource:DataSource?
    
    @IBOutlet weak var name: UITextField!
    
    @IBOutlet weak var birthdaySelector: UIDatePicker!
    @IBOutlet weak var genderPicker: UIPickerView!
    var genders:[String] = ["Male","Female","Others"]
    
    @IBAction func AddImageButton(_ sender: Any) {
        takePhotoWithCamera()
    }
    var image:UIImage? = nil
    
    @IBOutlet weak var selectedImagePreview: UIImageView!
    
    @IBOutlet weak var countryBtn: UIButton!
    
    @IBOutlet weak var lattitudeText: UITextField!
    
    @IBOutlet weak var longitudeText: UITextField!
    
    @IBOutlet weak var deleteBtnView: UIButton!
    @IBAction func deleteBtn(_ sender: Any) {
        let res = datasource?.delete(location: selectedPin!, index: selectedIndex)
        if(res!){
            print("Deleted sucess")
            callback?()
            dismiss(animated: true, completion: nil)
            navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction func saveBtn(_ sender: Any) {
        
        if(name.text?.isEmpty ?? true || lattitudeText.text?.isEmpty ?? true || longitudeText.text?.isEmpty ?? true){
            print("Fill all fields")
            return
            
        }
        if(countryBtn.titleLabel?.text == "Select Country"){
            print("Country not selected")
            return
        }
        
        
        if selectedPin != nil{
            selectedPin?.birthday = birthdaySelector.date
            selectedPin?.country = countryBtn.titleLabel?.text
            selectedPin?.gender = genders[genderPicker.selectedRow(inComponent: 0)]
            selectedPin?.lattitude = Double(lattitudeText.text!) ?? 0
            selectedPin?.longitude = Double(longitudeText.text!) ?? 0
            selectedPin?.name = name.text
            selectedPin?.image = image?.jpegData(compressionQuality: 1) as Data?
            
            let res = datasource?.update(location: selectedPin!, index: selectedIndex)
            if(res!){
                callback?()
                dismiss(animated: true, completion: nil)
                navigationController?.popViewController(animated: true)
            } else {
                print("Error saving data in EditViewController save btn")
            }
        } else {
            let res = datasource?.saveLocations(
                    name: name.text!,
                    birthday: birthdaySelector.date,
                    country: (countryBtn.titleLabel?.text)!,
                    gender: genders[genderPicker.selectedRow(inComponent: 0)],
                    latti: Double(lattitudeText.text!) ?? 0,
                    longi: Double(longitudeText.text!) ?? 0,
                image: (image?.jpegData(compressionQuality: 1) as Data?)! )
            
            if(res!){
                callback?()
                dismiss(animated: true, completion: nil)
                navigationController?.popViewController(animated: true)
            } else {
                print("Error saving data in EditViewController save btn")
            }
        }
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        genderPicker.delegate = self
        genderPicker.dataSource = self
        self.hideKeyboardWhenTappedAround()
        if let selectedLocation = selectedPin{
            name.text = selectedLocation.name
            birthdaySelector.date = selectedLocation.birthday!
            genderPicker.selectRow(genders.firstIndex(of: selectedLocation.gender!)!, inComponent: 0, animated: true)
            countryBtn.setTitle(selectedLocation.country, for: .normal)
            if let img = selectedLocation.image{
                selectedImagePreview.image = UIImage(data: img)
            }
            lattitudeText.text = String(selectedLocation.lattitude)
            longitudeText.text = String(selectedLocation.longitude)
            deleteBtnView.isHidden = false
        } else{
            deleteBtnView.isHidden = true
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "selectCountry"){
            let dest = segue.destination as! CountryListViewController
            dest.callback = countrySelectedCallback
        }
    }
    
    func countrySelectedCallback(country:String){
        countryBtn.setTitle(country, for: .normal)
        print("Country selected is \(country)")
    }
}


extension EditViewController: UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
    func takePhotoWithCamera(){
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        imagePicker.allowsEditing = false
        
        /*
         // Get the current authorization state.
         let status = PHPhotoLibrary.authorizationStatus()
         
         if (status == PHAuthorizationStatus.authorized) {
         print(" Access has been granted.")
         } else if (status == PHAuthorizationStatus.denied) {
         print(" Access has been denied.")
         } else if (status == PHAuthorizationStatus.notDetermined) {
         // Access has not been determined.
         PHPhotoLibrary.requestAuthorization({ (newStatus) in
         if (newStatus == PHAuthorizationStatus.authorized) {
         print(" Access has been granted.")
         } else {
         print(" Access has been denied.")
         }
         })
         }
         
         else if (status == PHAuthorizationStatus.restricted) {
         print(" Restricted access - normally won't happen.")
         }*/
        
        present(imagePicker, animated: true)
        
        //Hack to set image as random
        image = UIImage(named: "city\(Int.random(in: 1...4))")
        selectedImagePreview.image = image
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            image = pickedImage
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
}

extension EditViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return genders.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return genders[row]
    }
}

extension EditViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(EditViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
