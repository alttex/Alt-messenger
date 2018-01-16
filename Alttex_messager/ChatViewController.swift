//
//  ChatViewController.swift
//  Alttex_messager
//
//  Created by Vlad Kovryzhenko on 1/16/18.
//  Copyright © 2018 Vlad Kovryzhenko. All rights reserved.
//

import Foundation
import UIKit
import JSQMessagesViewController

struct User {
    let id: String
    let name: String
    let avatar: UIImage?
}


class ContactsScreenViewController: JSQMessagesViewController {
    
    @IBAction func cancelBtn(_ sender: Any) {
    navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
        
    }
    
    let user1 = User(id: "1", name: "Steve", avatar: #imageLiteral(resourceName: "avatar"))
    let user2 = User(id: "2", name: "Tim", avatar: #imageLiteral(resourceName: "avatar"))
    
    
    var currentUser: User {
        return user1
    }
    
    // all messages of users1, users2
    var messages = [JSQMessage]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // tell JSQMessagesViewController
        // who is the current user
        self.senderId = currentUser.id
        self.senderDisplayName = currentUser.name
        self.inputToolbar.contentView.backgroundColor = .black
        self.collectionView.backgroundColor = .black
        self.collectionView.typingIndicatorMessageBubbleColor = .green
        
        
        
        self.messages = getMessages()
    }
    
}

// MARK: - ContactsScreenViewControllerInput
extension ContactsScreenViewController {
    
    
    override func didPressSend(_ button: UIButton!, withMessageText text: String!, senderId: String!, senderDisplayName: String!, date: Date!) {
        let message = JSQMessage(senderId: senderId, displayName: senderDisplayName, text: text)
        
        messages.append(message!)
        
        finishSendingMessage()
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, attributedTextForMessageBubbleTopLabelAt indexPath: IndexPath!) -> NSAttributedString! {
        let message = messages[indexPath.row]
        let messageUsername = message.senderDisplayName
        
        return NSAttributedString(string: messageUsername!)
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, layout collectionViewLayout: JSQMessagesCollectionViewFlowLayout!, heightForMessageBubbleTopLabelAt indexPath: IndexPath!) -> CGFloat {
        return 15
    }
    
    
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, avatarImageDataForItemAt indexPath: IndexPath!) -> JSQMessageAvatarImageDataSource! {
        return nil
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageBubbleImageDataForItemAt indexPath: IndexPath!) -> JSQMessageBubbleImageDataSource! {
        let bubbleFactory = JSQMessagesBubbleImageFactory()
        
        let message = messages[indexPath.row]
        
        if currentUser.id == message.senderId {
            return bubbleFactory?.outgoingMessagesBubbleImage(with: .green)
        } else {
            return bubbleFactory?.incomingMessagesBubbleImage(with: .blue)
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages.count
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageDataForItemAt indexPath: IndexPath!) -> JSQMessageData! {
        return messages[indexPath.row]
    }
    
    
    

    
    func getMessages() -> [JSQMessage] {
        var messages = [JSQMessage]()
        
        let message1 = JSQMessage(senderId: "1", displayName: "Steve", text: "Hey bro, how are you?")
        let message2 = JSQMessage(senderId: "2", displayName: "Tim", text: "Fine thanks, and you?")
        let message3 = JSQMessage(senderId: "1", displayName: "Steve", text: "How about our project, pal?")
        messages.append(message1!)
        messages.append(message2!)
        messages.append(message3!)
        return messages
    }
    
    
    
}
