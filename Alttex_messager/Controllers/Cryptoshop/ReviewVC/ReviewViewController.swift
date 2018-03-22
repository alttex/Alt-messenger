

import UIKit
import Firebase

class ReviewViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var reviewEditableTextView: UITextView!
    @IBOutlet weak var submitBtn: UIBarButtonItem!
    
    
    // MARK: - Variables
    var firebaseUser : AuthStateDidChangeListenerHandle!
    var currentItem : ItemShop!
    
    // Write a review in Firebase backend
    @IBAction func submitReview(_ sender: UIBarButtonItem)
    {
        
        let myReview = reviewEditableTextView.text
        
        // 1- Get the current user uid
        let uid = Auth.auth().currentUser!.uid
        
        // 2- Create a reference to backend database
        let ref = Database.database().reference()
        
        // 3- Write a review to backend as a child of review Object
        
        let currentDate = Date()
        ref.child("reviews").childByAutoId().setValue(
            [
                "uid" : uid,
                "displayName" : Auth.auth().currentUser?.displayName,
                "itemPostID" : currentItem.postID,
                "reviewString" : myReview,
                "reviewDate" : ItemShop.dateToString(currentDate)
            ])
        // TODO: Step 4 should be moved to detail page
        // 4- Test query Firebase DB for related reviews
        _ = ref.child("reviews").queryOrdered(byChild: "reviewString") //.queryEqual(toValue: currentItem.postID)
        //print("--------------------  This is saver review query result from Firebase DB: \(String(describing: myQuery))")
        
        ref.child("reviews").observeSingleEvent(of: .value, with: { (snapshot) in
            
            // Get user value
            let value = snapshot.value as? NSDictionary
            
            // All values is array of dictionary
            let allReviews = value?.allValues as! [[String:String]]      //value?.allKeys.description
            print("This is allReviews: \(String(describing: allReviews))")

            for currentReviewDictionary in allReviews {
                
                if currentReviewDictionary["itemPostID"] == self.currentItem.postID{
                    let reviewString = currentReviewDictionary["reviewString"]
                    //print("\n")
                    print(reviewString ?? "No review for this item")
                }
            }
        }) { (error) in
            print(error.localizedDescription)
        }
        
        // Goback to detail page
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func cancelBtn(_ sender: UIButton) {
        //dismiss(animated: true, completion: nil)
    }
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        if text == "\n"  // Recognizes enter key in keyboard
        {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
    // MARK: - DEfault methods ---------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        //print("========================\(currentItem.description)")
        //self.view.backgroundColor = UIColor.rbg(r: 34, g: 34, b: 34)
        print("")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    // ---------------------------------------------------------------
    
    
    override func viewWillAppear(_ animated: Bool) {
        detectCurrentUser()
        disableReviewSubmitBtnForItemOwner()
        
        addBorderToTextView()
        addPlaceHolderToTextView()
    }
    
    func addBorderToTextView(){
        
//        let border = CALayer()
//        let width = CGFloat(10.0)
//        border.borderColor = UIColor.blue.cgColor
//        border.frame = CGRect(x: 0,
//                              y: 0,
//                              width:  reviewEditableTextView.frame.size.width,
//                              height: reviewEditableTextView.frame.size.height)
//
//        border.borderWidth = width
//        reviewEditableTextView.layer.addSublayer(border)
//        reviewEditableTextView.layer.masksToBounds = true
    }
    
    //TODO: Complete adding place holder to TextView
    func addPlaceHolderToTextView(){
        reviewEditableTextView.layer.cornerRadius = 12
        reviewEditableTextView.text = "Please write your review:"
        reviewEditableTextView.resignFirstResponder()
        reviewEditableTextView.textColor = UIColor.lightGray
        reviewEditableTextView.becomeFirstResponder()
        reviewEditableTextView.selectedTextRange = reviewEditableTextView.textRange(from: reviewEditableTextView.beginningOfDocument,
                                                                                    to: reviewEditableTextView.beginningOfDocument)
    }
    
    func detectCurrentUser(){
        //Everytime the view is display we check if a user is signed
        firebaseUser = Auth.auth().addStateDidChangeListener { (auth, user) in
            //If the user is sign in then we hide the sign in option
            if user != nil{
                guard let currentUser = user?.displayName else {
                    print("Current user is nil")
                    return
                }
                print("Current user is\(String(describing: currentUser))")
            }
        }
    }
    
    
    func disableReviewSubmitBtnForItemOwner(){
        
        if String(describing: Auth.auth().currentUser?.uid) == self.currentItem.userID {
            self.submitBtn.isEnabled = false
        }
        
    }
    
    /*
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        // Combine the textView text and the replacement text to
        // create the updated text string
        let currentText = textView.text
        let currentRange =  range as Range
        let updatedText = currentText?.replacingCharacters(in: currentRange, with: text)
        
  
        
        // If updated text view will be empty, add the placeholder
        // and set the cursor to the beginning of the text view
        if updatedText.isEmpty {
            
            textView.text = "Placeholder"
            textView.textColor = UIColor.lightGray
            
            textView.selectedTextRange = textView.textRange(from: textView.beginningOfDocument, to: textView.beginningOfDocument)
            
            return false
        }
        
            // Else if the text view's placeholder is showing and the
            // length of the replacement string is greater than 0, clear
            // the text view and set its color to black to prepare for
            // the user's entry
        else if textView.textColor == UIColor.lightGray && !text.isEmpty {
            textView.text = nil
            textView.textColor = UIColor.black
        }
        
        return true
    }
    */
    
    
    /*
     var key = ref.child("reviews").key
     
     ref.child("reviews").child(key).observeSingleEvent(of: .value, with: { (snapshot) in
     // Get user value
     let value = snapshot.value as? NSDictionary
     let reviewString = value?["reviewString"] as? String ?? ""
     print(reviewString)
     
     // ...
     }) { (error) in
     print(error.localizedDescription)
     }
    */
 
 
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
