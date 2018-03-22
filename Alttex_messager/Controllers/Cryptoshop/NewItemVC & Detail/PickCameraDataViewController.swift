//
//  PickCameraDataViewController.swift
//  Alttex_messager
//
//  Created by Vlad Kovryzhenko on 3/20/18.
//  Copyright © 2018 Vlad Kovryzhenko. All rights reserved.
//

import UIKit
import ImagePicker
import Lightbox
import Firebase





class GalleryImagePickerViewController: UIViewController, ImagePickerDelegate {
  
    

  
    @IBOutlet weak var uploadedImage: UIImageView!
    @IBOutlet weak var nameofArticleField: UITextField!
    @IBOutlet weak var priceField: UITextField!
    @IBOutlet weak var shareButton: UIButton!
    
    @IBOutlet weak var itemDescriptionField: UITextField!
    
    var imageArray : [UIImage] = []
    var index : Int?
    var newImage : UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let newImg = newImage { self.uploadedImage.image = newImg }
        
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if let newImg = newImage { self.uploadedImage.image = newImg }
    }

    @IBAction func dismissVC(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    //button post item
    @IBAction func shareBtn(_ sender: UIButton)
    {
        guard
            let nameOfArticle = nameofArticleField.text ,
            let price = priceField.text,
            let descrip = self.itemDescriptionField.text
            else { return }
        let webSrevice = ItemsServiceApi()
        // upload item
        webSrevice.uploadItem(nameOfArticle: nameOfArticle, price: price, uid: Auth.auth().currentUser!.uid, image: newImage!, itemDescription: descrip) {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func buttonTouched(_ sender: Any) {
        var config = Configuration()
        config.doneButtonTitle = "Finish"
        config.noImagesTitle = "Sorry! There are no images here!"
        config.allowVideoSelection = true

        let imagePicker = ImagePickerController(configuration: config)
        imagePicker.imageLimit = 1
        imagePicker.delegate = self
      
        present(imagePicker, animated: true, completion: nil)
        
    }
    func updateShareButton(articleText: String, priceText: String) {
        
        let enabled = !articleText.isEmpty && !priceText.isEmpty
        shareButton.isEnabled = enabled
    }
    
    
    
    
//
//    //initialisation of image picker preview
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 1
//    }
//
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
////        if imageArray.count == 1{
////            return 1
////        }
////        else {
////            return imageArray.count
////        }
//        return 4
//    }
//
//
//
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? GalleryCollectionViewCell
//        //cell?.imageView.image = imageArray[indexPath.row]
//
//        return cell!
//    }
//
//
//
//    //MARK: collection cell properties
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: (collectionView.frame.width - 9)/3, height: self.view.frame.size.height * 0.15)
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return 0
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 2
//    }
//
//
    
    
    
    // MARK: - ImagePickerDelegate
    
    func cancelButtonDidPress(_ imagePicker: ImagePickerController) {
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    func wrapperDidPress(_ imagePicker: ImagePickerController, images: [UIImage]) {
        guard images.count > 0 else { return }
        
        let lightboxImages = images.map {
            return LightboxImage(image: $0)
        }
        
        let lightbox = LightboxController(images: lightboxImages, startIndex: 0)
        imagePicker.present(lightbox, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == "goToNavigationBar" {

            if let vc = segue.destination as? UploadItemViewController {

                vc.newImage = imageArray[0]
            }
        }
    }
    
    func doneButtonDidPress(_ imagePicker: ImagePickerController, images: [UIImage])  {
       newImage = images[0]
        imagePicker.dismiss(animated: true, completion: nil)
       
    }
}

extension GalleryImagePickerViewController : UITextFieldDelegate{
    
    // We could use this method from UITextFieldDelegate protocol to prevent the user from entering anything but numerical values.
    // Initialize item name and price with an empty string if, the value does not exist to prevent crashing the application
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        let newString = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        if textField == nameofArticleField {
            
            updateShareButton(articleText: newString, priceText: self.priceField.text ?? "")
        }
        else {
            updateShareButton(articleText: self.nameofArticleField.text ?? "", priceText: newString)
        }
        return true
    }
    // Start Editing The Text Field
    func textFieldDidBeginEditing(_ textField: UITextField) {
        moveTextField(textField, moveDistance: -250, up: true, viewController: self)
    }
    
    // Finish Editing The Text Field
    func textFieldDidEndEditing(_ textField: UITextField) {
        moveTextField(textField, moveDistance: -250, up: false, viewController: self)
    }
    
    // Hide the keyboard when the return key pressed
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
}
