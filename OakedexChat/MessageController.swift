//
//  MessageController.swift
//  OakedexChat
//
//  Created by Michael Mecham on 3/6/16.
//  Copyright © 2016 MichaelMecham. All rights reserved.
//

import Foundation

class MessageController {
    static let sharedController = MessageController()
    
    // add messages
    // fetch messages
    // observe endpoint for specific thread for new message
    
    static func addMessageToThread(message: Message, thread: Thread, completion: (success: Bool) -> Void) {
        
    }
    
    static func currentMessgesForThread(thread: Thread, completion: (messages: [Message]) -> Void) {
        // fetch messages one time, useful for displaying a static list of messages
    }
    
    static func observeMessageForThread(thread: Thread, updateBlock: (messages: [Message]) -> Void) {
        // should run the update clock each time the data at the thread endpoint is updated
        // useful for create a live view that updates immediately when messges for a thread update
    }
    
    static func endObservingMessageForThread(thread: Thread) {
        // stop observing messages
        //useful for ending an ovservation for a thread that is no longer being displayed
    }
    
    
    
//    var messages: [Message] = []
//    let sender = "mykrobot"
//    
//    static func observeMessagesForIdentifier(identifier: String, completion: (message: [Message]) -> Void) {
//        FirebaseController.observeDataAtEndpoint("users/\(sharedInstance.sender)/messages") { (data) -> Void in
//            if let messageIdentifierDictionary = data as? [String: AnyObject] {
//                var messages: [Message] = []
//                let tunnel = dispatch_group_create()
//                for (messageIdentifier, _) in messageIdentifierDictionary {
//                    dispatch_group_enter(tunnel)
//                    FirebaseController.dataAtEndpoint("messages/\(messageIdentifier)", completion: { (data) -> Void in
//                        if let messageDictionary = data as? [String: AnyObject] {
//                            if let message = Message(json: messageDictionary, identifier: messageIdentifier) {
//                                messages.append(message)
//                            }
//                        }
//                        dispatch_group_leave(tunnel)
//                    })
//                }
//                dispatch_group_notify(tunnel, dispatch_get_main_queue(), { () -> Void in
//                    sharedInstance.messages = messages
//                    NSNotificationCenter.defaultCenter().postNotificationName("messagesChanged", object: self)
//                })
//            }
//        }
//    }
//    
//    static func createMessage(recipient: String, text: String) {
//        var message = Message(sender: sharedInstance.sender, receiver: recipient, text: text)
//        message.save()
//        if let identifier = message.identifier {
//            FirebaseController.base.childByAppendingPath("users/\(sharedInstance.sender)/messages/\(identifier)").setValue(true)
//            FirebaseController.base.childByAppendingPath("users/\(recipient)/messages/\(identifier)").setValue(true)
//        }
//    }
//    
//    static func observeUsers(completion: (keys: [String])->Void) {
//        FirebaseController.observeDataAtEndpoint("users") { (data) -> Void in
//            if let users = data as? [String: AnyObject] {
//                let userKeys = Array(users.keys)
//                completion(keys: userKeys)
//            } else {
//                completion(keys: [])
//            }
//        }
//    }
}
