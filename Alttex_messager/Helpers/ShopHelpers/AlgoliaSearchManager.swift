import AlgoliaSearch
import FirebaseAuth
/// A Class Manager for Algolia Search API Functionality
class AlgoliaSearchManager {
    
    
    // MARK: - Attributes
    let query = Query()
    var saleItemIndex: Index!
    var adminSaleIndex: Index!
    var searchId = 0
    var displayedSearchId = -1
    var loadedPage: UInt = 0
    var nbPages: UInt = 0
    var searchActive : Bool = false
    let firebaseHandle = FirebaseManager()
    var refreshControl: UIRefreshControl!
    
    // MARK: - Intializer
    /**
     initializes the Algolia Search Manager to point to the Skill-Trader Index and sets the attributes that will be searched.
     */
    init(){
        let client = Client(appID: "KJBTLKM9VP", apiKey: "336ec5d2a6f528a23c73482a3d657643")
        saleItemIndex = client.index(withName: "Skill-Trader")
        let initialClient = Client(appID: "KJBTLKM9VP", apiKey: "5309d1fc99008e074cf9af0cbcfbe87e")
        adminSaleIndex = initialClient.index(withName: "Skill-Trader")
        query.hitsPerPage = 15
    }
    
    // MARK: - Database Query Functions
    /**
     gets the first 15 indexes listed within the Algolia JSON Database.
     
     - parameter escapingList: returns 15 of the most recent entries in the Algolia database.
     */
//    func getAllItems(escapingList: @escaping ([ItemShop]) -> ()){
//        query.attributesToRetrieve = ["name", "desc", "category"]
//        adminSaleIndex.browse(from: "", completionHandler: { (content, error) -> Void in
//            if error == nil {
//                guard let hits = content!["hits"] as? [[String: AnyObject]] else { return }
//                var tmp = [ItemShop]()
//                for hit in hits {
//                    tmp.append(ItemShop(json: hit))
//                }
//                escapingList(tmp)
//            } else if error != nil{ print(error as Any) }
//        })
//
//    }
    // NEEDS: - refactoring to take user ID
    /**
     gets the first 15 indexes listed by the currently signed in user, from the Algolia JSON Database.
     
     - parameter escapingList: returns 15 of the most recent entries in the Algolia database.
     */
//    func getUserItemsWith(userID: String, escapingList: @escaping ([ItemShop]) -> ()){
//
//        query.attributesToRetrieve = ["userID"]
//        query.query = userID
//        saleItemIndex.search(Query(query: query.query), completionHandler: { (content, error) -> Void in
//            if error == nil {
//                guard let hits = content!["hits"] as? [[String: AnyObject]] else { return }
//                var tmp = [ItemShop]()
//                for hit in hits {
//                    tmp.append(ItemShop(json: hit))
//                }
//                escapingList(tmp)
//            } else if error != nil{ print(error as Any) }
//        })
//
//    }
    /**
     updates a saleItem that is stored in the Algolia JSON Index.
     
     - parameters:
     - modifiedSaleItem: the swift data structure representation of the updated version of the Sale Item to be changed in the Algolia Index.
     - imageChanged:     a boolean answer to weither the current sale item image has been changed by the user in the app.
     - previousURL:      the previous Image URL which will be used to delete the previous image from Firebase Storage.
     */
    func updateItemIndexValues(modifiedSaleItem: ItemShop, imageChanged: Bool){
        var saleItemDictionary: [String: String] = [
            "desc": modifiedSaleItem.description,
            "price": modifiedSaleItem.price,
            "name": modifiedSaleItem.itemDescription
        ]
        if(imageChanged) {
//            self.firebaseHandle.uploadImageToFirebaseStorage(name: modifiedSaleItem.itemDescription!, image: modifiedSaleItem.pathToImage) {
//                (completionURL) -> () in
//                self.firebaseHandle.deleteImageInFireStorage(imageURL: modifiedSaleItem.imageURL.absoluteString!)
//                saleItemDictionary["imageURL"] = completionURL
//                self.adminSaleIndex.partialUpdateObject(saleItemDictionary, withID: modifiedSaleItem.itemID)
//            }
//        } else {
//            adminSaleIndex.partialUpdateObject(saleItemDictionary, withID: modifiedSaleItem.postID)
//        }
    }
    
    /**
     gets the first 15 values matching the search parameter within the Algolia JSON Database.
     
     - parameters:
     - searchString: the string for which the search will be queried by.
     - escapingList: returns 15 of the best matching indices in the Algolia database.
     */
//    func searchDatabase(searchString: String, escapingList: @escaping ([ItemShop]) -> ()){
//        query.attributesToRetrieve = ["name", "desc", "category"]
//        query.query = searchString
//        saleItemIndex.search(Query(query: query.query), completionHandler: { (content, error) -> Void in
//            if error == nil {
//                guard let hits = content!["hits"] as? [[String: AnyObject]] else { return }
//                var tmp = [ItemShop]()
//                for hit in hits {
//                    tmp.append(ItemShop(json: hit))
//                }
//                escapingList(tmp)
//            } else if error != nil{ print(error as Any) }
//        })
//    }
    
    /**
     uploads The given saleItem to the Algolia Index as a Key: value list.
     
     - parameter saleItem: the swift data structure representation of the sale item that will be uploaded.
     */
    func uploadToIndex(saleItem: ItemShop){
//        firebaseHandle.uploadImageToFirebaseStorage(name: saleItem.itemDescription!, image: saleItem.pathToImage!){ (completedURL) -> () in //image upload
//            saleItem.imageURL = NSURL(string: completedURL)
//            let saleItemDictionary : [String : AnyObject] = ["name" : saleItem.name as AnyObject,
//                                                             "price" : saleItem.price as AnyObject,
//                                                             "desc" : saleItem.description as AnyObject,
//                                                             "imageURL" : saleItem.imageURL as AnyObject,
//                                                             "category" : saleItem.category as AnyObject,
//                                                             "userID" : saleItem.creatorUserID as AnyObject,
//                                                             "status": "listed" as AnyObject,
//                                                             "pickupLocation": "none" as AnyObject]
//            self.adminSaleIndex.addObject(saleItemDictionary, withID: "myID", completionHandler: { (content, error) -> Void in
//                if error != nil {
//                    print(error!)
//                }
//                if error == nil {
//                    if let objectID = content!["objectID"] as? String {
//                        print("Object ID: \(objectID)")
//                    }
//                    print("Object IDs: \(content!)")
//                }
//            })
//        }
    }
    
    /**
     Deletes the saleItem Index at a given ID.
     
     - Parameter saleItemToDelete: the handle for a particular sale Item that will be deleted from
     the Algolia index and it's image from the the firebase Storage.
     */
    func deleteAlgoliaSaleItem(saleItemToDelete: ItemShop){
        adminSaleIndex.deleteObject(withID: saleItemToDelete.postID)
     //   firebaseHandle.deleteImageInFireStorage(imageURL: saleItemToDelete.pathToImage.absoluteString!)
        
    }
    
    /**
     Adds Pickup location co-ordinates to the Index of the corresponding Algolia SaleItem.
     
     - Parameter toIndex: A swift data structure representing the corresponding Algolia Sale Item Index.
     */
//    func addPickupRequestLocation(toIndex: ItemShop) {
//        let saleItemDictionary: [String: [String: AnyObject]] =
//            ["pickupLocation"    :  ["long": toIndex.meetup.longitude   as AnyObject,
//                                     "lat" : toIndex.meetup.latitude    as AnyObject],
//             ]
//
//        adminSaleIndex.partialUpdateObject(saleItemDictionary, withID: toIndex.itemID)
//    }
    
    /**
     adds a potential buyer's requested meet up time to this specified sale item index.
     
     - Parameter toIndex: used to find the index of this sale item in the Algolia json database using
     this item's itemID.
     */
//    func addMeetupRequestInfo(toIndex: ItemShop, by: String) {
//        let saleItemDictionary: [String: AnyObject] =
//            ["BuyerRequestedTime"   :  toIndex.requestedPickupDate  as AnyObject,
//             "status"               :"\(by) Requested Meet-up"            as AnyObject,
//             "pickupLocation"    : ["long": toIndex.meetup.longitude   as AnyObject,
//                                    "lat" : toIndex.meetup.latitude    as AnyObject] as AnyObject]
//        adminSaleIndex.partialUpdateObject(saleItemDictionary, withID: toIndex.itemID)
//
//    }
    
    /**
     updates the status of the sale item at this specified index to Confirmed.
     
     - Parameter atIndex: used to find the index of this sale item in the algolia json database using
     this item's itemID.
     */
//    func confirmMeetup(atIndex: ItemShop){
//        let saleItemDictionary: [String: AnyObject] =
//            ["status":"Confirmed" as AnyObject]
//        adminSaleIndex.partialUpdateObject(saleItemDictionary, withID: atIndex.itemID)
//
//    }
//
    /**
     removes this sale item's requested meetup Attributes at it's index in the Algolia json Database.
     
     - Parameter atIndex: used to find the index of this sale item in the algolia json database using
     this item's itemID.
     */
    func clearMeetupRequest(atIndex: ItemShop) {
        let saleItemDictionary: [String: AnyObject] =
            ["status"               :"listed"   as AnyObject,
             "BuyerRequestedTime"   : "0"       as AnyObject,
             "pickupLocation"       : "none"    as AnyObject]
        adminSaleIndex.partialUpdateObject(saleItemDictionary, withID: atIndex.postID)
    }
}

}
