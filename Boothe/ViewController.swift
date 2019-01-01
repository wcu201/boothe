//
//  ViewController.swift
//  Boothe
//
//  Created by William  Uchegbu on 9/29/18.
//  Copyright © 2018 William  Uchegbu. All rights reserved.
//

import UIKit
import Photos
import UserNotifications

class ViewController: UIViewController {

    @IBOutlet weak var openCameraBTN: UIButton!
    @IBOutlet weak var photo: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        openCameraBTN.addTarget(self, action: #selector(self.picturePressed), for: .allTouchEvents)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func openCamera(_ sender: Any) {
        
    }
    
    @objc func picturePressed(){
        print("Picture Pressed")
        let alert = UIAlertController(title: "Update Image", message: "Do you want to open camera", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let approve = UIAlertAction(title: "Yes", style: .default, handler: {action in
            
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                var imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.sourceType = .camera;
                imagePicker.allowsEditing = false
                self.present(imagePicker, animated: true, completion: nil)
            }
            /*
            let picker = UIImagePickerController()
            picker.delegate = self
            picker.allowsEditing = true
            
            self.present(picker, animated: true, completion: nil)
 */
        })
        
        alert.addAction(cancel)
        alert.addAction(approve)
        present(alert, animated: true, completion: nil)
    }
    

}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate
{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        print("Did finish picking. Info = " + "\(info)")
        var selectedImage: UIImage?
        if let croppedImage = info[UIImagePickerControllerEditedImage] as? UIImage {
            selectedImage = croppedImage
        }
        
        photo.image = selectedImage
        self.dismiss(animated: true, completion: nil)
    }
    
    
        //present(alert, animated: true, completion: nil)
        
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
    


