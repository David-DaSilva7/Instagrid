//
//  ViewController.swift
//  Instagrid
//
//  Created by David Da Silva on 06/04/2021.
//

import UIKit
import Photos

class ViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    @IBOutlet weak var gridContainerView: UIView!
    @IBOutlet weak var viewSwipe: UISwipeGestureRecognizer!
    
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
    
    fileprivate let imagePicker = UIImagePickerController()
    fileprivate var currentButtonTag: Int?
    fileprivate var translation = CGAffineTransform()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        selectedTwo.isHidden = false
        imagePicker.delegate = self
        initSwipeDirection()
    }
    
    // function that allows you to perform the swipe as a priority when changing position
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        DispatchQueue.main.async {
            self.initSwipeDirection()
        }
    }
    
    // Perform the correct swipe according to the layout
    fileprivate func initSwipeDirection() {
        if UIApplication.shared.statusBarOrientation.isPortrait {
            viewSwipe.direction = .up
        } else {
            viewSwipe.direction = .left
        }
    }
    
    // Change the image format according to the button pressed
    @IBAction func bottomButtonTouched(_ sender: UIButton) {
        
        if sender.tag == 10 { // left bottom button touched
            adaptButtons(fullButtonUp: false, fullButtonDown: true, buttonLeftUp: true, buttonRightUp: true, buttonLeftDown: false, buttonRightDown: false, selectedOne: false, selectedTwo: true, selectedThree: true)
        } else if sender.tag == 20 { // middle bottom button touched
            adaptButtons(fullButtonUp: true, fullButtonDown: false, buttonLeftUp: false, buttonRightUp: false, buttonLeftDown: true, buttonRightDown: true, selectedOne: true, selectedTwo: false, selectedThree: true)
        } else if sender.tag == 30 { // right bottom button touched
            adaptButtons(fullButtonUp: true, fullButtonDown: true, buttonLeftUp: false, buttonRightUp: false, buttonLeftDown: false, buttonRightDown: false, selectedOne: true, selectedTwo: true, selectedThree: false)
        }
    }
    
    // adapt the image select according to the button pressed
    fileprivate func adaptButtons(fullButtonUp: Bool,fullButtonDown: Bool,buttonLeftUp: Bool, buttonRightUp: Bool, buttonLeftDown: Bool, buttonRightDown: Bool, selectedOne: Bool, selectedTwo: Bool, selectedThree: Bool) {
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
    
    // action that allows access to the library
    @IBAction func buttonTouch(_ sender: UIButton) {
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
        
        currentButtonTag = sender.tag
    }
    
    // apply selected image on button
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let currentButtonTag = self.currentButtonTag else {
            return
        }
        buttons[currentButtonTag].setImage(nil, for: .normal)
        if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            if  buttons[currentButtonTag].backgroundImage(for: .normal) == nil {
                buttons[currentButtonTag].setBackgroundImage(image, for: .normal)
            } else {
                if buttons[currentButtonTag].imageView?.description != image.description {
                    buttons[currentButtonTag].setBackgroundImage(image, for: .normal)
                }
            }
            imagePicker.dismiss(animated: true, completion: nil)
        }
    }
    
    // action that allows to perform a swipe
    @IBAction func swipe(_ sender: UISwipeGestureRecognizer) {
        swipeGridContainerView()
    }
    
    // function that allows the appropriate translation
    fileprivate func swipeGridContainerView() {
        guard let strongGridContainerView = gridContainerView, let strongStackViewSwipe = viewSwipe else {
            return
        }
        
        if (strongStackViewSwipe.direction == .up) {
            translation = CGAffineTransform(translationX: 0, y: -strongGridContainerView.frame.maxY)
        }
        else if (strongStackViewSwipe.direction == .left) {
            translation = CGAffineTransform(translationX: -strongGridContainerView.frame.maxX, y: 0)
        }
        
        checkIfPhotoLibraryAccessAuthorized()
    }
    
    // give access to the phone to browse the album
    fileprivate func checkIfPhotoLibraryAccessAuthorized() {
        let status = PHPhotoLibrary.authorizationStatus()
        switch status {
        case .authorized, .notDetermined, .restricted:
            presentActivityController()
        default:
            createAlertToGrantAccessToPhotoLibrary()
        }
    }
    
    // create animation when chooses a photo
    fileprivate func presentActivityController() {
        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0, delay: 0, options: [.curveEaseIn], animations: {
            guard let strongGridContainerView = self.gridContainerView else {
                return
            }
            strongGridContainerView.transform = self.translation
        }, completion: { _ in
            let share = self.shareScreenshotOfGridContainer()
            self.present(share, animated: true)
        })
    }
    
    // create an alert if there is no authorization to the library
    fileprivate func createAlertToGrantAccessToPhotoLibrary() {
        let alert = UIAlertController(title: "Instagrid need access to your Photos",
                                      message: "If you want save image to your photo library please allow access in Instagrid app settings.",
                                      preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "Don't Allow",
                                      style: UIAlertAction.Style.cancel,
                                      handler: { [weak self] alert -> Void in
                                        self?.presentActivityController()
                                      }))
        
        alert.addAction(UIAlertAction(title: "Go",
                                      style: UIAlertAction.Style.default,
                                      handler: { alert -> Void in
                                        UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!,
                                                                  options: [:],
                                                                  completionHandler: nil)
                                      }))
        
        present(alert, animated: true, completion: nil)
    }
    
    // share and save image after swipe
    fileprivate func shareScreenshotOfGridContainer() -> UIActivityViewController {
        let sharedImage = [gridContainerView?.screenshot]
        let activityViewController = UIActivityViewController(activityItems: sharedImage as [Any], applicationActivities: nil)
        activityViewController.completionWithItemsHandler = UIActivityViewController.CompletionWithItemsHandler? { [weak self] activityType, completed, returnedItems, activityError in
            
            UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.3, delay: 0, options: [.curveEaseIn], animations: {
                self?.gridContainerView?.transform = CGAffineTransform(translationX: 0, y: 0)
            }, completion: nil)
        }
        return activityViewController
    }
}
