//
//  SaleItemCollectionViewCell.swift
//  Radford Swaps
//
//  Created by Tevin Scott on 9/26/17.
//  Copyright © 2017 Tevin Scott. All rights reserved.
//
import UIKit

///Managers the SaleItemViewCell and its attributes
class FeedCollectionViewCell: UICollectionViewCell {
    

    // MARK: - Attributes
    //cell component references
    @IBOutlet var saleItemImg: UIImageView!
    @IBOutlet var visualEffectView: UIVisualEffectView!
    @IBOutlet var priceLabel: UILabel!

    private var currentCellImageURL:NSURL!
    private var imageDownloadSession: URLSessionDataTask!
    public var saleItem: SaleItem? { didSet { updateUIFromJson()} }
    
    // MARK: - Support Functions
    /**
     updates this cell to the current values of the SaleItem.
    */
    private func updateUI(){
        //places dollarsign in front of sale item price
        if let priceVal: String = saleItem?.price! {
            priceLabel.text = "$\(priceVal)"
        }

        if (saleItem?.imageURL != nil){
            setImageFromURL(imgURL: (saleItem?.imageURL)!)
            
        }
        else {
            saleItemImg.image = (saleItem?.placeholderImage)!
        }
    }
    
    /**
     updates this cell to the current SaleItem's JSON attributes.
     */
    
    private func updateUIFromJson(){
        //places dollarsign in front of sale item price
        if let priceVal: String = saleItem?.price! {
            priceLabel.text = "$\(priceVal)"
        }
        setImageWhenNeeded()
        self.layer.cornerRadius = 8.0
        self.clipsToBounds = true
    }
    
    /**
     This function is used to set the saleitem cell Image efficiently. Swift re-uses cells in collections and tables. Thus, if the new sale item's downloaded image will match a reused cell's image, the download is skipped.
    */
    private func setImageWhenNeeded(){
        // if the current cell URL is nil set it to the saleItem URL
        if(currentCellImageURL == nil && saleItem?.imageURL != nil){
            saleItemImg.image = UIImage(named: "default-placeholder")
            currentCellImageURL = saleItem?.imageURL
            setImageFromURL(imgURL: (saleItem?.imageURL)!)
        }
            // if the current Image URL has been set
        else if(currentCellImageURL != nil){
            //if current cell URL doesnt match the newly set saleItem URL set the default place holder
            if((currentCellImageURL != saleItem?.imageURL)){
                saleItemImg.image = UIImage(named: "default-placeholder")
                currentCellImageURL = saleItem?.imageURL
                setImageFromURL(imgURL: (saleItem?.imageURL)!)
            }
            /* if the URLs' Match it is assumed that the sale item's
             image, if downloaded, will match this recycled cell's image */
        }
            // final case senario the cell is set to a default placeholder image
        else {
            saleItemImg.image = UIImage(named: "default-placeholder")
        }
    } 
    
    /**
     sets this Cells saleItemImg to an image downloaded via URL link. this  function is done asynchronously.
     
     - Parameter imgURL: URL of the image to be downloaded
     */
    private func setImageFromURL(imgURL: NSURL){
        //NEEDS: Try Catch here , if this fails just set the image to the default-placeholder and display a network error message
        if(self.imageDownloadSession != nil){
            self.imageDownloadSession.cancel()
        }
        let task = URLSession.shared.dataTask(with: imgURL as URL, completionHandler: { (data, response, error) -> Void in
            DispatchQueue.main.async(execute: { () -> Void in
                if(data != nil){
                    let image = UIImage(data: data!)
                    self.saleItem?.image = image
                    self.saleItemImg.image = image
                }
            })
            
        })
        task.resume()
        imageDownloadSession = task
    }
    
    /**
     sets this Cells saleItemImg to an image downloaded via URL link. this  function is done asynchronously.
     
     - Parameter imgURL: URL of the image to be downloaded
     */
    private func setImageFromURLString(imgURL: String){
        if(self.imageDownloadSession != nil){
            self.imageDownloadSession.cancel()
        }
        let task = URLSession.shared.dataTask(with: NSURL(string: imgURL)! as URL, completionHandler: { (data, response, error) -> Void in
            DispatchQueue.main.async(execute: { () -> Void in
                let image = UIImage(data: data!)
                self.saleItem?.image = image
                self.saleItemImg.image = image
            })
        })
        task.resume()
        imageDownloadSession = task
    }
}
