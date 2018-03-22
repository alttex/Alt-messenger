

//import GoogleSignIn
import Firebase
import AlgoliaSearch
import FirebaseDatabase
import SDWebImage
import FirebaseAuth



/// A Class that manages the Feed View and its sub views
class FeedVC : UIViewController,UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UICollectionViewDataSource {
    
    // MARK: - Attributes
    //data structures
    private let coredataManager = CoreDataManager()
    private let firebaseDataManager = FirebaseManager()
    var itemToDetail : ItemShop? = nil
    fileprivate let sectionInsets = UIEdgeInsets(top: 30.0, left: 15.0, bottom: 30.0, right: 15.0)
    fileprivate let itemsPerRow: CGFloat = 2
    // outlet variables
  //  @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var collectionView: UICollectionView!
    //layout variables
    private let numberOfItemsPerRow: CGFloat = 2.0
    private let heightAdjustment: CGFloat = 5.0
    private var extendedCollectionViewHeight: CGFloat!
    //search bar variables
    private var searchActive : Bool = false
    // collection View variables
    private var refreshControl: UIRefreshControl!

    var currentUser: User?
    var ref: DatabaseReference!
    var items = [ItemShop]()

    var resultData : NSData = NSData()
    fileprivate var _refHandle: DatabaseHandle!
    
    internal var collectionViewOriginalLocation: CGFloat!
    internal let standardCellIdentifier = "SaleCell"


    // MARK: - Button Actions
    /**
     Presents the newItemView to user, if they are currently signed into an account.
     */
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        //2
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    //3
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    
    
    // 4
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let shopServiceApi = ItemsServiceApi()
        
        shopServiceApi.getAllItemsFromShopDatabase { (allItems) in
            self.items = allItems
            
            // sort the array based on time of creation
            print("\n getAllItemsFromShopDatabase: ",self.items)
            self.items.sort(by: { $1.timeOfCreation < $0.timeOfCreation
            })
            self.collectionView.reloadData()
        }
        self.collectionView.reloadData()
    }
    
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
 
     func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath){
        itemToDetail = items[indexPath.item]
        performSegue(withIdentifier: "goDetail", sender: self)
    }
            
    
    
    // send the item to DetailViewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goDetail" {
            let detailVC = segue.destination as! DetailViewController
            if let itemDetail = self.itemToDetail {
                detailVC.itemFromMain = itemDetail
                 print ("\n  func prepare   itemDetail:",itemDetail)
            }
        }
    }

 
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  items.count
    }
    
 
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: standardCellIdentifier, for: indexPath) as! FeedCollectionViewCell
        cell.priceLabel.text = items[indexPath.row].price
        cell.titleLabel.text = items[indexPath.row].nameOfArticle
        let imagePthUrl = URL(string: items[indexPath.row].pathToImage)
        cell.saleItemImg.sd_setImage(with: imagePthUrl)
        return cell
    }
    

  
}
