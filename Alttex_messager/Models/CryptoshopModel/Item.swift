

import Foundation

class ItemShop: NSObject {
    
    
    var author: String!
    var pathToImage: String!
    var nameOfArticle: String!
    var price: String!
    var userID: String!
    var postID: String!
    var profilePhoto : String?
    
    // Attributes that are not used yet
    var numberOfAvilable: Int!
    var likes: Int!
    var peopleWhoLike: [String] = [String]()
    var timeOfCreation : Date!
    //var numberOfPeopleWhoDidRating : Int = 0
    var itemDescription : String!
    


}

extension ItemShop {
    // extraxt date from string
    static func dateFromString(_ dateAsString: String?) -> Date? {
        guard let string = dateAsString else { return nil }
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSSS"
        let val = dateformatter.date(from: string)
        return val
    }
    // extract string from date
    static func dateToString(_ dateIn: Date?) -> String? {
        guard let date = dateIn else { return nil }
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSSS"
        let val = dateformatter.string(from: date)
        return val
    }
}
