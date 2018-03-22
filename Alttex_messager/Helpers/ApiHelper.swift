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




protocol ServiceApi {
    func getAllItemsFrimFireBaseDataBase(complition : @escaping ([ItemShop]) -> Void)
    //    func putItemInFireBaseDataBase()
    func updateRatingOfItem(postKey : String, rating : Float, numOfPeople : Int)
}


class ItemsServiceApi : ServiceApi{
    
    //MARK: - Properties
    var items = [ItemShop]()
    var ref: DatabaseReference!
    
    
    // get Info from firebase data base
    func getAllItemsFrimFireBaseDataBase(complition : @escaping ([ItemShop]) -> Void){
        print("Inside the getAllItems ...")
        // Fetch list of items from firebase backend
        ref = Database.database().reference()
        
        
        // Access "posts" object in backend if it does not exist
        ref.child("users").child("credentials").observeSingleEvent(of: .value){ (dataSnap : DataSnapshot) in
            print("inside the observerSingleEvent")
            let value = dataSnap.value as? NSDictionary
            for (key, value) in value!{
                print("This is the key \(key)")
                print("This is the value \(value)")
            }
            
            let allAnswer = value?.allValues as? [[String:Any]]
            
            
            guard let allAnswerOfPosts = allAnswer
                else { return }
            
            
            // To prevent duplication item array can be erased here or in viewDidDisappear
            //            items.removeAll()
            
            for answer in allAnswerOfPosts
            {
                //------------------------------------------- To remove current user items from list of items
                //                if let uid = answer["uid"] as? String{
                //                    if uid != Auth.auth().currentUser!.uid{
                //                        // TODO: Create Item object to be added in item array
                //                    }
                //                }
                //-------------------------------------------------------------------------------------------
                
                let item = ItemShop()
                
                
                //item.author = answer["name"] as! String
                item.pathToImage = answer["pathToImage"] as! String
                item.nameOfArticle = answer["nameOfArticle"] as! String
                item.price = answer["price"] as! String
                let StringDate = answer["currentDate"] as! String
                item.timeOfCreation = ItemShop.dateFromString(StringDate)
                item.postID = answer["postID"] as! String
                // item.numberOfPeopleWhoDidRating = answer["numberOfPeopleWhoDidRating"] as! Int
                item.userID = answer["userID"] as! String
                item.itemDescription = answer["itemDescription"] as! String
                //item.profilePhoto = answer["profilePicLink"] as? String
                self.items.append(item)
            }
            complition(self.items)
            
        }
        // To prevent crashing app if we leave current view controller which is under observation
        ref.removeAllObservers()
        
    }
    
    
    
    func getAllItemsFromShopDatabase(complition : @escaping ([ItemShop]) -> Void){
        print("Inside the getAllItems ...")
        // Fetch list of items from firebase backend
        ref = Database.database().reference()
        
        
        // Access "posts" object in backend if it does not exist
        ref.child("posts").observeSingleEvent(of: .value){ (dataSnap : DataSnapshot) in
            print("inside the observerSingleEvent")
            let value = dataSnap.value as? NSDictionary
            //            for (key, value) in value!{
            //                print("This is the key \(key)")
            //                print("This is the value \(value)")
            //            }
            
            let allAnswer = value?.allValues as? [[String:Any]]
            
            
            guard let allAnswerOfPosts = allAnswer
                else { return }
            
            
            // To prevent duplication item array can be erased here or in viewDidDisappear
            //            items.removeAll()
            
            for answer in allAnswerOfPosts
            {
                //------------------------------------------- To remove current user items from list of items
                //                if let uid = answer["uid"] as? String{
                //                    if uid != Auth.auth().currentUser!.uid{
                //                        // TODO: Create Item object to be added in item array
                //                    }
                //                }
                //-------------------------------------------------------------------------------------------
                
                let item = ItemShop()
                // let Shopitem = User()
                
                //item.author = answer["name"] as! String
                item.pathToImage = answer["pathToImage"] as! String
                item.nameOfArticle = answer["nameOfArticle"] as! String
                item.price = answer["price"] as! String
                let StringDate = answer["currentDate"] as! String
                item.timeOfCreation = ItemShop.dateFromString(StringDate)
                item.postID = answer["postID"] as! String
                // item.numberOfPeopleWhoDidRating = answer["numberOfPeopleWhoDidRating"] as! Int
                item.userID = answer["userID"] as! String
                item.itemDescription = answer["itemDescription"] as! String
                //item.profilePhoto = answer["profilePicLink"] as? String
                self.items.append(item)
            }
            complition(self.items)
            
        }
        // To prevent crashing app if we leave current view controller which is under observation
        ref.removeAllObservers()
        
    }
    
    
    func putItemInFireBaseDataBase(uploadImageView : UIImageView,complition : ((StorageMetadata?, Error?) -> Void)?) {
        
    }
    
    // get all users from database
    func getAllUsers () {
        
    }
    
    
    // update rating and numberOfPeopleWhoDidRating in fireBase database
    func updateRatingOfItem(postKey : String, rating : Float, numOfPeople : Int){
        ref = Database.database().reference()
        self.ref.child("posts/\(postKey)/itemRating").setValue(rating)
        self.ref.child("posts/\(postKey)/numberOfPeopleWhoDidRating").setValue(numOfPeople)
    }
    
    func uploadItem(nameOfArticle : String, price : String, uid : String,image : UIImage, itemDescription: String, completion : @escaping () -> Void) {
        let item = ItemShop()
        // guard
        //            let nameOfArticle = nameOfArticle.text ,
        //            let price = price.text
        
        // else { return }
        let currentDate = Date()
        
        // Start spinner
        //activityIndicator.startAnimating()
        
        
        // Stop handling of touch-related events.
        UIApplication.shared.beginIgnoringInteractionEvents()
        
        
        // Upload the current image to backend database
        
        // 1- Get the current user uid
        let uid = Auth.auth().currentUser!.uid
        
        // 2- Create a reference to backend database
        let ref = Database.database().reference()
        let storage = Storage.storage().reference(forURL: "gs://mychat-9deba.appspot.com")
        
        // 3- Create a database child (posts) with Auto increment ID: database/posts/key for each post
        let key = ref.child("posts").childByAutoId().key
        
        // 4- Locate image object in backend DB: storage/posts/uid/key.jpg
        let imageRef = storage.child("posts").child(uid).child("\(key).jpg")
        
        // 5- Convert image format to data format with compresstion rate 0.1
        let data = UIImageJPEGRepresentation(image, 0.8)
        
        // 6- Upload image to backend storage
        let uploadTask = imageRef.putData(data!, metadata: nil) { (metadata, error) in
            if error != nil {
                print(error!.localizedDescription)
                
                // 7- If there is an error  stop spinner and rsume the handling of touch events
                // activityIndicator.stopAnimating()
                UIApplication.shared.endIgnoringInteractionEvents()
                return
            }
            
            //            Database.database().reference().child("users").child((user?.uid)!).child("credentials").updateChildValues(values, withCompletionBlock: { (errr, _) in
            //                if errr == nil {
            //                    let userInfo = ["email" : email, "password" : password]
            //                    UserDefaults.standard.set(userInfo, forKey: "userInformation")
            //                    completion(true)
            //                }
            
            
            // 8- Get the uploaded picture URL
            imageRef.downloadURL(completion: { (url, error) in
                
                // 9- If url to uploaded image exist, create item object
                if let url = url {
                    item.userID = uid
                    item.pathToImage = url.absoluteString
                    item.likes = 0
                    // item.author = Auth.auth().currentUser!.displayName!
                    item.postID = key
                    item.nameOfArticle = nameOfArticle
                    item.itemDescription = itemDescription
                    item.price = price
                    
                    let photoUrl = Auth.auth().currentUser?.photoURL?.absoluteString ?? ""
                    // 10- Make dictionary of "posts" object attributes and corresponding key
                    let feed =
                        [
                            "userID" : item.userID,
                            "pathToImage" : item.pathToImage ,
                            "likes" : item.likes,
                            //"name" : item.author,
                            "postID" : item.postID,
                            "nameOfArticle" : item.nameOfArticle,
                            "price" : String(item.price),
                            "currentDate" : ItemShop.dateToString(currentDate)!,
                            "itemRating" : 0 ,
                            "numberOfPeopleWhoDidRating" : 0,
                            "itemDescription" : item.itemDescription ?? "",
                            "profilePicLink" : photoUrl
                            ] as [String : Any]
                    
                    let postFeed = ["\(item.postID)" : feed]
                    
                    // 11- Reference to Firebase DB: write data (postFeed) to backend as "posts" object child with key and feed dictionary
                    // This method will add our new post to backend DB
                    ref.child("posts").updateChildValues(postFeed)
                    // 12-  Stop activityIndicator or spinner
                    // activityIndicator.stopAnimating()
                    
                    // 13- Rsume the handling of touch events
                    UIApplication.shared.endIgnoringInteractionEvents()
                    
                    // 14- Dismisses the view controller that was presented modally by the view controller.
                    // self.dismiss(animated: true, completion: nil)
                    completion()
                    
                    //
                }
            })
        }
        uploadTask.resume()
    }
    
    
}


/*
 This function is used to store a photo inside the storage section
 The params are the image that will be converted to UIImageJPEGRepresentation
 When the url is downloaded we retrive the url from firebase
 */
func upload(media: UIImage, withName: String, completion: @escaping (_ url: URL) -> Void) {
    let storageRef = Storage.storage().reference().child("user").child("\(withName).jpg")
    if let imageToUpload = UIImageJPEGRepresentation(media, 1.0){
        storageRef.putData(imageToUpload, metadata: nil) { (backendData, error) in
            if let error = error{
                print("Error while uploading the media, this is the error \(error)")
            }
            if let storageMetaData = backendData{
                if let url = storageMetaData.downloadURL(){
                    completion(url)
                }
            }
        }
    }
}

func downloadUserProfileBy(url: String, completion: @escaping(_ image: Data) -> Void){
    let storage = Storage.storage()
    
    //notification.userInfo?["pic"] as? UIImage
//    if let id = Auth.auth().currentUser?.uid {
//        User.info(forUserID: id, completion: {[weak weakSelf = self] (user) in
//            DispatchQueue.main.async {
//                weakSelf?.nameLabel.text = user.name
//                weakSelf?.emailLabel.text = user.email
//                weakSelf?.profilePicView.image = user.profilePic
//                weakSelf = nil
//            }
//        })
//    }
    let httpsReference = storage.reference(forURL: url)
    httpsReference.getData(maxSize: 1 * 1024 * 1024) { data, error in
        if let error = error {
            print("Error while downloading the profile picture, this is the error \(error)")
        }
        if let data = data{
            completion(data)
        }
    }
}

func getDataFromUrl(url: URL, completion: @escaping (_ data: Data?, _  response: URLResponse?, _ error: Error?) -> Void) {
    URLSession.shared.dataTask(with: url) {
        (data, response, error) in
        completion(data, response, error)
        }.resume()
}


//Function that take a string containing the url and an escaping closure that get the image data
func downloadImageFrom(_ urlString: String,completion: @escaping (_ data: Data?) -> Void) {
    guard let url = URL(string: urlString) else{return}
    let urlRequest = URLRequest(url: url)
    let task = URLSession.shared.dataTask(with: urlRequest){ (data, response, error) in
        if let error = error {
            print("Error while downloading the image from firebase \(error)")
            return
        }
        completion(data)
    }
    task.resume()
}






public class ApiHelper {
    

static func getCoinValue() -> [String] {
    

    
    var name = [String]()
    var price = [String]()
    var isFinish = false

    let urlString = "https://api.coinmarketcap.com/v1/ticker/?limit=6"
    let requestUrl = URL(string:urlString)
    var request = URLRequest(url:requestUrl!)
    let semaphore = DispatchSemaphore(value: 0)
    
    request.httpMethod = "GET"
    URLSession.shared.dataTask(with: (request), completionHandler: {(data, response, error) -> Void in
        if let data = data {
            if let jsonObj = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? NSArray {
                for actor in jsonObj!{
                    if let actorDict = actor as? NSDictionary {
                        if let id = actorDict.value(forKey: "id") {
                            name.append(id as! String)
                        }
                        if let priceUsd = actorDict.value(forKey: "price_usd") {
                            price.append(priceUsd as! String)
                        }
                    }
                }
                print ("\nData get from API:", price)
            }
        }
        semaphore.signal()
    }).resume()
    
    let signal = semaphore.wait(timeout: DispatchTime.distantFuture)
    
    if signal.hashValue == 0 { // return 0 after DONE url ssesion
        if name.isEmpty == false {
            
            CoreDataHelper.saveTicketCoreData(name: name, price: price)
            isFinish = true
        }
  
    }else {
        if signal.hashValue == 1 { // return 1 after DROP url ssesion
            print("Url is failed (soryy)")
            isFinish = false

            
        }
    }
    print ("is finish: ", isFinish)
    return price
  
}





}
