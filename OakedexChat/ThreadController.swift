//
//  ThreadController.swift
//  OakedexChat
//
//  Created by Michael Mecham on 3/6/16.
//  Copyright © 2016 MichaelMecham. All rights reserved.
//

import Foundation

class ThreadController {
    
    static private var threads: [Thread] = []
    
    static func observeThreadsForIdentifier(identifier: String, completion: (threads: [Thread]) -> Void) {
        FirebaseController.observeDataAtEndpoint("users/\(identifier)/threadsKey") { (data) -> Void in
            guard let threadIdentifierDictionary = data as? [String:AnyObject] else { completion(threads: []); return }
            processThreadIDs(threadIdentifierDictionary, completion: { (threads) in
                completion(threads: threads)
            })
        }
    }
    
    static private func processThreadIDs(threadIdentifierDictionary: [String:AnyObject], completion: (threads: [Thread]) -> Void) {
        for (threadIdentifier, _) in threadIdentifierDictionary {
            FirebaseController.dataAtEndpoint("threads/\(threadIdentifier)", completion: { (data) -> Void in
                guard let threadDictionary = data as? [String:AnyObject],
                    thread = Thread(json: threadDictionary, identifier: threadIdentifier) else { completion(threads: []); return }
                self.threads.append(thread)
                if self.threads.count == threadIdentifierDictionary.count { // checking the count so that it only reloads the tableView once
                    completion(threads: threads.sort({$0.0.identifier > $0.1.identifier})) // one value either one of them will work
                }
            })
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
}

























