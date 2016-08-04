//
//  ThreadController.swift
//  OakedexChat
//
//  Created by Michael Mecham on 3/6/16.
//  Copyright © 2016 MichaelMecham. All rights reserved.
//

import Foundation

class ThreadController {
    
    static func observeThreadsForIdentifier(identifier: String, completion: (thread: [Thread]) -> Void) {
        FirebaseController.observeDataAtEndpoint("users/\(identifier)/threadsKey") { (data) -> Void in
            if let threadIdentifierDictionary = data as? [String:AnyObject] {
                var threads: [Thread] = []
                for (threadIdentifier, _) in threadIdentifierDictionary {
                    FirebaseController.dataAtEndpoint("threads/\(threadIdentifier)", completion: { (data) -> Void in
                        if let threadDictionary = data as? [String:AnyObject] {
                            if let thread = Thread(json: threadDictionary, identifier: threadIdentifier) {
                                threads.append(thread)
                            }
                        }
                        if threads.count == threadIdentifierDictionary.count {
                            completion(thread: threads.sort({$0.0.identifier > $0.1.identifier})) // one value either one of them will work
                        }
                    })
                }
            }
        }
    }
    
    static func fetchMessagesForThreadID(identifier: String, completion: (message: [Message]) -> Void) {
        FirebaseController.observeDataAtEndpoint("messages") { (data) -> Void in
            if let messageIdentifierDictionary = data as? [String:AnyObject] {
                var messages: [Message] = []
                for (messageIDentifier, _) in messageIdentifierDictionary {
                    FirebaseController.dataAtEndpoint("messages/\(messageIDentifier)/threadKey/\(identifier)", completion: { (data) -> Void in
                        if let messageDictionary = data as? [String:AnyObject] {
                            if let message = Message(json: messageDictionary, identifier: messageIDentifier) {
                                messages.append(message)
                            }
                            completion(message: messages)
                        }
                        completion(message: messages)
                    })
                }
            }
        }
    }
    
    static func observeMessageForThreadID(threadID: String, completion: (message: [Message]?) -> Void) {
        FirebaseController.base.childByAppendingPath("messages").queryOrderedByChild("threadKey").observeEventType(.Value, withBlock: { (data) -> Void in
            if let messageDictionary = data.value as? [String:AnyObject] {
                let messages = messageDictionary.flatMap({Message(json: $0.1 as! [String:AnyObject], identifier: $0.0)})
                completion(message: messages.sort({$0.0.identifier! < $0.1.identifier!}))
            } else {
                completion(message: nil)
            }
        })
    }
    
    static func createThread(threadName: String, users: [User], completion: (thread: Thread?) -> Void) {
        var newThread = Thread(threadName: threadName, users: users)
        newThread.save()
        if let threadID = newThread.identifier {
            for var user in users {
                user.threadIDs.append(threadID)
                user.save()
            }
        }
        completion(thread: newThread)
    }
    
    static func createMessage(text: String, sender: User, thread: Thread, completion: (message: Message?) -> Void) {
        guard let senderID = sender.identifier,
            threadID = thread.identifier else {
                completion(message: nil)
                return
        }
        var message = Message(threadIdentifier: threadID, text: text, senderID: senderID)
        message.save()
        completion(message: message)
    }
    
    static func reportThread(thread: Thread) {
        guard let threadID = thread.identifier else { return }
        var report = Report(threadID: threadID)
        report.save()
    }
    
    static func deleteThread(thread: Thread) {
        thread.delete()
    }
    
    static func orderThreads(threads: [Thread]) -> [Thread] {
        return threads.sort({$0.0.identifier > $0.1.identifier})
    }
}

























