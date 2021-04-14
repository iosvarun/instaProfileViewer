//
//  SKCoreDataManager.swift
//  BeMoneywise
//
//  Created by Sumit Kumar Gupta on 09/03/20.
//  Copyright © 2020 Sumit Kumar Gupta. All rights reserved.
//

import UIKit
import CoreData

class SKCoreDataManager: NSObject {

    // MARK: - Core Data stack

    static var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "DirectMessage")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support

    static func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
            }
        }
    }
}

extension SKCoreDataManager {
    static func getEntity(for name: String) -> NSManagedObject? {
        let context = persistentContainer.viewContext
        guard let entityDescription = NSEntityDescription.entity(forEntityName: name, in: context) else {
            print("Core Data entity name doesn't match.")
            return nil
        }
        let obj = NSManagedObject(entity: entityDescription, insertInto: context)
        return obj
    }
}

// MARK: - CustomMessage Extension
/*
extension CustomMessage {
    
    static func getAllMessage() -> [CustomMessage]? {
        let fetchRequest: NSFetchRequest<CustomMessage> = CustomMessage.fetchRequest()
        do {
            //go get the results
            let messageModel = try SKCoreDataManager.persistentContainer.viewContext.fetch(fetchRequest)
            //I like to check the size of the returned results!
            debugPrint ("getAllMessage CustomMessage messages count = \(messageModel.count)")
            return messageModel
            
        } catch {
            debugPrint("Error with request: \(error)")
            return []
        }
    }
    
    
    static func getMessage(by messageId: Int64) -> CustomMessage? {
        //create a fetch request, telling it about the entity
        print("getMessage CustomMessage messageId = \(messageId)")

        let fetchRequest: NSFetchRequest<CustomMessage> = CustomMessage.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "messageId == %d", messageId)
        do {
            //go get the results
            let notifications = try SKCoreDataManager.persistentContainer.viewContext.fetch(fetchRequest)
            //I like to check the size of the returned results!
            print("getMessage CustomMessage message count = \(notifications.count)")
            return notifications.count > 0 ? notifications[0] : nil

        } catch {
            debugPrint("Error with request: \(error)")
            return nil
        }
    }
    
    
    static func storeMessage(messageId: Int64, messageTxt: String, messageTitle: String) {
        // retrieve the property object with propertyId
        // if property object found then update the data
        // else create new property and save the data getPurchase(transId:transId)
        if let msgObj: CustomMessage = getMessage(by: messageId)  {
            msgObj.messageTitle = messageTitle
            msgObj.messageTxt = messageTxt
            // Update the object whenever required
        }else {
            if let msgObj =  SKCoreDataManager.getEntity(for: "CustomMessage") as? CustomMessage {
                msgObj.messageTitle = messageTitle
                msgObj.messageTxt = messageTxt
                msgObj.messageId = messageId
            }
        }
        
        //save the object
        SKCoreDataManager.saveContext()
    }
    
    static func deleteMessage(messageId: Int64) {
        let context = SKCoreDataManager.persistentContainer.viewContext
        if let toDeletePurchase: CustomMessage = getMessage(by: messageId) {
            context.delete(toDeletePurchase)
        }
        
        //save the object
        SKCoreDataManager.saveContext()
    }
    
}

// MARK: - MessageHistory Extension

extension MessageHistory {
    
    static func getAllMessage() -> [MessageHistory]? {
        let fetchRequest: NSFetchRequest<MessageHistory> = MessageHistory.fetchRequest()
        do {
            //go get the results
            let historyMessageModel = try SKCoreDataManager.persistentContainer.viewContext.fetch(fetchRequest)
            //I like to check the size of the returned results!
            debugPrint ("num of messageId = \(historyMessageModel.count)")
            return historyMessageModel
            
        } catch {
            debugPrint("Error with request: \(error)")
            return []
        }
    }
    
    static func getHistoryMessage(messageId: Int64) -> MessageHistory? {
        //create a fetch request, telling it about the entity
        let fetchRequest: NSFetchRequest<MessageHistory> = MessageHistory.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "messageId == %d", messageId)
        do {
            //go get the results
            let notifications = try SKCoreDataManager.persistentContainer.viewContext.fetch(fetchRequest)
            //I like to check the size of the returned results!
            debugPrint ("get history message count = \(notifications.count)")
            return notifications.count > 0 ? notifications[0] : nil

        } catch {
            debugPrint("Error with request: \(error)")
            return nil
        }
    }
    
    
    
    static func storeHistoryMessage(messageId: Int64, messageType: String, messageTime: String, phoneNumber: String, messageTxt: String, timeStamp: String) {
        // retrieve the property object with propertyId
        // if property object found then update the data
        // else create new property and save the data
        if let msgHistoryObj =  SKCoreDataManager.getEntity(for: "MessageHistory") as? MessageHistory {
            msgHistoryObj.messageId = messageId
            msgHistoryObj.messageType = messageType
            msgHistoryObj.messageTime = messageTime
            msgHistoryObj.phoneNumber = phoneNumber
            msgHistoryObj.messageTxt = messageTxt
            msgHistoryObj.messageTimeStamp = timeStamp
        }
        //save the object
        SKCoreDataManager.saveContext()
    }
    
    static func deleteHistoryMessage(messageId: Int64) {
        let context = SKCoreDataManager.persistentContainer.viewContext
        if let toDeletePurchase: MessageHistory = getHistoryMessage(messageId: messageId) {
            context.delete(toDeletePurchase)
        }
        
        //save the object
        SKCoreDataManager.saveContext()
    }
    
}

 */
