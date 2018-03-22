
import UIKit

///Managers the SaleItemViewCell and its attributes
class FeedCollectionViewCell: UICollectionViewCell {
    

    // MARK: - Attributes
    //cell component references
    @IBOutlet var saleItemImg: UIImageView!
    @IBOutlet var visualEffectView: UIVisualEffectView!
    @IBOutlet var priceLabel: UILabel!

    @IBOutlet weak var titleLabel: UILabel!
}
