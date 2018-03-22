

import UIKit
import Firebase
import SDWebImage


class DetailViewController: UIViewController , UITableViewDelegate, UITableViewDataSource {
   
    
    
    
    //MARK: Outlets
    @IBOutlet weak var detailImg: UIImageView!
    @IBOutlet weak var priceImg: UILabel!
    @IBOutlet weak var nameOfAuther: UILabel!
    @IBOutlet weak var itemDescription: UITextView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var buyButton: UIButton!
    
   // @IBOutlet weak var numberOfRating: UILabel!
    //    // Review Outlet
   // @IBOutlet weak var itemReview: UITextView!
    @IBOutlet weak var tableView: UITableView!
    @IBAction func writeReviewBtn(_ sender: UIButton) {
 
        let reviewViewController = UIStoryboard(name: "Review", bundle: nil).instantiateViewController(withIdentifier: "Review") as! ReviewViewController
        reviewViewController.currentItem = itemFromMain
        self.show(reviewViewController, sender: self)
        
    }
    
    
    @IBAction func buyBtn(_ sender: UIButton) {
        let VC1 = storyboard?.instantiateViewController(withIdentifier: "Navigation") as! NavVC
                let navController = UINavigationController(rootViewController: VC1) // Creating a navigation controller with VC1 at the root of the navigation stack.
                self.show(navController, sender:true)
    }
    //MARK: Attributes
    var itemFromMain : ItemShop! = nil
    var user : User?
    // ArrayList of Reviews to feed Review TableView
    var itemReviewArray = [Review]()
    var btcAmount = SlideViewController()
    //MARK: Default Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // MARK: Initialize tableViewReviews
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.separatorColor = .none
        scrollView.isScrollEnabled = true
      //scrollView.contentSize = CGSize(width: scrollView.contentSize.width, height: 375)
        // populate labels and image in this page
        detailImg.downloadImage(from: itemFromMain.pathToImage)
        self.priceImg.text = itemFromMain.price
        self.nameOfAuther.text = user?.name
       // self.nameOfRticleDetail.text = itemFromMain.nameOfArticle
        self.navigationItem.title = itemFromMain.nameOfArticle
        // user just can rate other items (not his items)
//        if String((Auth.auth().currentUser?.uid)!) == itemFromMain.userID {
//            giveRatingOutlet.isEnabled = false
//        }
        self.itemDescription.text = itemFromMain.itemDescription
        self.buyButton.layer.cornerRadius = 10
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    //MARK: Custom Methods
    override func viewWillAppear(_ animated: Bool) {
        itemDescription.layer.cornerRadius = 15
        if let id = Auth.auth().currentUser?.uid {
            User.info(forUserID: id, completion: {[weak weakSelf = self] (user) in
                DispatchQueue.main.async {
                    weakSelf?.nameOfAuther.text = user.name
    
                    weakSelf = nil
                }
            })
        }
        //TODO: Update itemReview textView with new review
        connectToDBandQueryItemReviews{() in
            self.itemReviewArray.sort(by: {$1.reviewDate < $0.reviewDate})
            self.tableView.reloadData()
        }
    }
    
    
    // MARK: - Table view data source ------------------------------------------------------------------------------
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("\nItemReviewArray count:",itemReviewArray)
        return itemReviewArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "reviewCell", for: indexPath) as! ReviewTableViewCell
        cell.reviewComment?.text  = self.itemReviewArray[indexPath.row].reviewString
        cell.displayName?.text = self.itemReviewArray[indexPath.row].displayName
        
        
//        let balance = TransactionDataStoreManager.calculateBalance()
//        let balanceInBTC: Double = Double(balance) / 100000000
//        self.topStatusView.changeStatusLabel(text: String(balanceInBTC) + "BTC")
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//         let cell = tableView.dequeueReusableCell(withIdentifier: "reviewCell", for: indexPath) as! ReviewTableViewCell
//        return CGFloat(cell.reviewComment.numberOfLines + 20)
        return 60
    }
    //-----------------------------------------------------------------------------------------------------------------
    
    
    
    // MARK: Query from databse for current item reviews --------------------------------------------------------------
    func connectToDBandQueryItemReviews(updateReviewTableViewWhenDownloadingReviewsIsDoneCompletion : @escaping () -> Void){
        // 1- Get the current user uid
        _ = Auth.auth().currentUser!.uid
        
        // 2- Create a reference to backend database
        let ref = Database.database().reference()
        
        ref.child("reviews").observeSingleEvent(of: .value, with: { (snapshot) in
            
            // Get user value
            let value = snapshot.value as? NSDictionary
            
            // All values is array of dictionary
            guard let allReviews = value?.allValues as? [[String:String]] else {return}
            //print("This is allReviews: \(String(describing: allReviews))")
            
            var allItemReviews = ""
            self.itemReviewArray.removeAll()
            for currentReviewDictionary in allReviews {
                
                if currentReviewDictionary["itemPostID"] == self.itemFromMain.postID{
                    
                    
                    //let displayName = self.user?.name
                    let reviewString = currentReviewDictionary["reviewString"]!
                    let reviewDateString = currentReviewDictionary["reviewDate"]! as String
                    let reviewDate = ItemShop.dateFromString(reviewDateString)!
                    
                    
                    // Create a review object
                    let currentReviewObject = Review(displayName: "User", reviewString: reviewString, reviewDate : reviewDate)
                    
                    // Add review object to review tableView Array
                    self.itemReviewArray.append(currentReviewObject)
                    
                    
                    
                    //print("This is itemReviewArray: \(self.itemReviewArray.description)")
                    // Update review textView ------------------------------------------------------------------------------------
                    allItemReviews = allItemReviews + reviewString + "\n" + "-----------------------------------------------------"
                    //------------------------------------------------------------------------------------------------------------
                    //print("\n ------------ Item reviews in detail page: ")
                    
                    
                }
            }
            updateReviewTableViewWhenDownloadingReviewsIsDoneCompletion()
            print(allItemReviews)
            //self.itemReview.text = allItemReviews
        }) { (error) in
            print(error.localizedDescription)
        }
        ref.removeAllObservers()
    }
    //---------------------------------------------------------------------------------------------------------------------
    
    
    
    
    // MARK: Rating -------------------------------------------------------------------------------------------------------

        
    
    //---------------------------------------------------------------------------------------------------------------------
    
  
        
        // TODO: Need to be updated to go to new storyboard
        
        
        // Pass itemFromMain to review page  ==============================================================================
//
//                if segue.identifier == "Review" {
//        
//                    let vc = segue.destination as! ReviewViewController
//                    vc.currentItem = itemFromMain
//        
//                    let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Review")
//                    self.present(vc, animated: true, completion: nil)
//                }
//    }   //=================================================================================================================
//    
}



