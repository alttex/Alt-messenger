//
//  ApiHelper.swift
//  Alttex safe
//
//  Created by Vitaliy Chorpita on 17.03.18.
//  Copyright © 2018 Vlad Kovryzhenko. All rights reserved.
//
import Foundation
import UIKit
import Firebase
import FirebaseDatabase
import FirebaseStorage
import GoogleSignIn

/// An Interace for accessing the FireBase Database
class FirebaseManager {
    
    // MARK: - Attributes
    internal let rootRef = Database.database().reference()
    internal var saleRef: DatabaseReference!
    internal var shopRef: DatabaseReference!
    internal var userRef: DatabaseReference!
    internal var databaseHandle: DatabaseHandle!
    internal var itemKeyDictionary = [String: Int]()
    internal var hashIndex = 0;
   
    
    // MARK: - Initializer
    init(){
        
        userRef = rootRef.child("users")
    }
    
    // MARK: - Sale Item Functionality
    
    /**
     Adds new items to the class variable listOfItems and removes sales items that are no longer in the database
     
    - parameters:
        - completion: On completion the escaping value [SaleItem] is instatiated from the FireBase list of Sale Items.
     */


    /**
     Uploads a SaleItem Object's values to Firebase's Webservice..
     Firebase Storage for the item image.
     Firebase Database for item name, price, description, category and, a URL reference to the image in Firebase Storage.
     
     - parameters:
        - saleItem: the SaleItem Object for which will be Uploaded to the Firebase Webservice
     */

    /**
     Updates the current user's saleitem and stores it within the firebase database
     
     - Parameters:
        - saleItem:        a reference to the saleItem that is to be updated within the database
        - imageChanged:    specifies if the saleItem image needs to also be updated in firebase storage should this value be true
        - previousURL:      the saleItems old image URL will be used to delete the old image from firebase storage
     */

    
    /**
     Updates a current user account should the user decide to user their One time username Change
     
     - parameter userAccountInfo: a reference to the userAccountInfo that represents the modified information of a users account info
     */
    func updateUserAccountInfo(userAccountInfo: UserAccountInfo){
        let query = userRef.queryOrderedByKey().queryEqual(toValue: userAccountInfo.userID)
        query.observe(.childAdded, with: { (snapshot) in
            snapshot.ref.updateChildValues(["chosenUsername" : userAccountInfo.chosenUsername,
                                            "nameChangeUsed" : String(userAccountInfo.oneTimeNameChangeUsed)])
        })
    }

 
    
    // MARK: - Firebase Helper Functions
    /**
     removes the image from Firebase Storage from the given imageURL
     
     - Parameter imageURL: URL of the image that will be deleted from Firebase Storage
     */
    func deleteImageInFireStorage (imageURL: String) {
        let imageRef = Storage.storage().reference(forURL: imageURL)
        imageRef.delete{(error) in }
    }
    
    
    /**
     this function is to ONLY assist uploadSaleItemToAll
     uploads a SaleItems Object's values ONLY to Firebase Database.
     
     - Parameter saleItem: the item for which the value of will be uploaded
     */
  
    /**
     Uploads The current image stored in the given saleItem object to Firebase Storage and returns the URL reference.
     
     - parameters:
        - name: the name of the saleItem for which the image will be saved as
        - image: a reference to the saleItem for which the containing image will be uploaded
        - completionURL: URL that references the image in firebase storage
     
     */
    func uploadImageToFirebaseStorage(name: String,image: UIImage, completionURL: @escaping (String) -> ()){
        let fileStorage = Storage.storage().reference().child("\(String(describing: name)).png")
        // NEEDS: TEST - may cause insertion conflicts if two items have the same name
        if let imageToUpload = UIImagePNGRepresentation(image) {
            fileStorage.putData(imageToUpload, metadata: nil, completion: {
                (metadata, error) in
                if(error != nil){
                    return
                }
                completionURL((metadata?.downloadURL()?.absoluteString)!)
            })
        }
    }
    
    /**
     Returns the index of the saleItem that has been deleted from the firebase database
     
     - Parameter snapshot: a snapshot of the data that has been removed from the firebase database
     
     - returns: the index location in listOfItems of the saleItem that has been deleted from the database
     */


}
