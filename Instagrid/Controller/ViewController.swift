//
//  ViewController.swift
//  Instagrid
//
//  Created by David Da Silva on 06/04/2021.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    @IBOutlet weak var selectedOne: UIImageView!
    
    @IBOutlet weak var selectedTwo: UIImageView!
    
    @IBOutlet weak var selectedThree: UIImageView!
    
    @IBOutlet weak var fullButtonUp: UIButton!
    
    @IBOutlet weak var fullButtonDown: UIButton!
    
    @IBOutlet weak var buttonLeftUp: UIButton!
    
    @IBOutlet weak var buttonRightUp: UIButton!
    
    @IBOutlet weak var buttonLeftDown: UIButton!
    
    @IBOutlet weak var buttonRightDown: UIButton!
    
    var imagePicker = UIImagePickerController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        selectedTwo.isHidden = false
        imagePicker.delegate = self
    }
    
    @IBAction func leftButton(_ sender: Any) {
        
        adaptButtons(fullButtonUp: false, fullButtonDown: true, buttonLeftUp: true, buttonRightUp: true, buttonLeftDown: false, buttonRightDown: false, selectedOne: false, selectedTwo: true, selectedThree: true)
    }
    
    @IBAction func middleButton(_ sender: Any) {
        
        adaptButtons(fullButtonUp: true, fullButtonDown: false, buttonLeftUp: false, buttonRightUp: false, buttonLeftDown: true, buttonRightDown: true, selectedOne: true, selectedTwo: false, selectedThree: true)
    }
    
    @IBAction func rightButton(_ sender: Any) {
        
        adaptButtons(fullButtonUp: true, fullButtonDown: true, buttonLeftUp: false, buttonRightUp: false, buttonLeftDown: false, buttonRightDown: false, selectedOne: true, selectedTwo: true, selectedThree: false)
    }
    
    func adaptButtons(fullButtonUp: Bool,fullButtonDown: Bool,buttonLeftUp: Bool, buttonRightUp: Bool, buttonLeftDown: Bool, buttonRightDown: Bool, selectedOne: Bool, selectedTwo: Bool, selectedThree: Bool) {
        self.fullButtonUp.isHidden = fullButtonUp
        self.fullButtonDown.isHidden = fullButtonDown
        self.buttonLeftUp.isHidden = buttonLeftUp
        self.buttonRightUp.isHidden = buttonRightUp
        self.buttonLeftDown.isHidden = buttonLeftDown
        self.buttonRightDown.isHidden = buttonRightDown
        self.selectedOne.isHidden = selectedOne
        self.selectedTwo.isHidden = selectedTwo
        self.selectedThree.isHidden = selectedThree
    }
    
    @IBOutlet var buttons: [UIButton]!
    
    @IBAction func buttonTouch(_ sender: UIButton) {
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
        if sender.tag == 0 {
            
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        buttons?.setImage(nil, for: .normal)
        if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            if  buttons?.backgroundImage(for: .normal) == nil {
                Images.dictionary.updateValue(image, forKey: image.description)
                buttons?.setBackgroundImage(image, for: .normal)
            } else {
                if buttons?.imageView?.description != image.description {
                    if let strongImageView = buttons?.imageView, let strongImage = strongImageView.image {
                        Images.dictionary.updateValue(image, forKey: image.description)
                        buttons?.setBackgroundImage(image, for: .normal)
                    }
                }
            }
            imagePicker.dismiss(animated: true, completion: nil)
        }
    }
}
