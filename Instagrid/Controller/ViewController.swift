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
    
    @IBOutlet weak var fullButtonUp: UIButton!      // tag 0
    @IBOutlet weak var buttonLeftUp: UIButton!      // tag 1
    @IBOutlet weak var buttonRightUp: UIButton!     // tag 2
    @IBOutlet weak var buttonLeftDown: UIButton!    // tag 3
    @IBOutlet weak var buttonRightDown: UIButton!   // tag 4
    @IBOutlet weak var fullButtonDown: UIButton!    // tag 5
    
    @IBOutlet var buttons: [UIButton]!
    
    var imagePicker = UIImagePickerController()
    var currentButtonTag: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        selectedTwo.isHidden = false
        imagePicker.delegate = self
    }
    
    
    @IBAction func bottomButtonTouched(_ sender: UIButton) {
        
        if sender.tag == 10 { // left bottom button touched
            adaptButtons(fullButtonUp: false, fullButtonDown: true, buttonLeftUp: true, buttonRightUp: true, buttonLeftDown: false, buttonRightDown: false, selectedOne: false, selectedTwo: true, selectedThree: true)
        } else if sender.tag == 20 { // middle bottom button touched
            adaptButtons(fullButtonUp: true, fullButtonDown: false, buttonLeftUp: false, buttonRightUp: false, buttonLeftDown: true, buttonRightDown: true, selectedOne: true, selectedTwo: false, selectedThree: true)
        } else if sender.tag == 30 { // right bottom button touched
            adaptButtons(fullButtonUp: true, fullButtonDown: true, buttonLeftUp: false, buttonRightUp: false, buttonLeftDown: false, buttonRightDown: false, selectedOne: true, selectedTwo: true, selectedThree: false)
        }
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
    
    @IBAction func buttonTouch(_ sender: UIButton) {
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
        
        currentButtonTag = sender.tag
        print("boutton tag: \(sender.tag)") // TODO: Remove after implementation working
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let currentButtonTag = currentButtonTag else {
            return
        }
        buttons[currentButtonTag].setImage(nil, for: .normal)
        if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            if  buttons[currentButtonTag].backgroundImage(for: .normal) == nil {
                Images.dictionary.updateValue(image, forKey: image.description)
                buttons[currentButtonTag].setBackgroundImage(image, for: .normal)
            } else {
                if buttons[currentButtonTag].imageView?.description != image.description {
                    if let strongImageView = buttons[currentButtonTag].imageView, let strongImage = strongImageView.image {
                        Images.dictionary.updateValue(image, forKey: image.description)
                        buttons[currentButtonTag].setBackgroundImage(image, for: .normal)
                    }
                }
            }
            imagePicker.dismiss(animated: true, completion: nil)
        }
    }
}
