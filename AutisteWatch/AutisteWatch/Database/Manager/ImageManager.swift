//
//  ImageManager.swift
//  AutisteWatch
//
//  Created by Marco Loiodice on 31/05/2016.
//  Copyright © 2016 LP-BG-IEM. All rights reserved.
//

import UIKit
import CoreData

class ImageManager: NSObject {
    
    static let sharedInstance = ImageManager()
    
    var appDelegate: AppDelegate{
        return UIApplication.sharedApplication().delegate as! AppDelegate
    }
    
    var managedObjectContext: NSManagedObjectContext{
        return appDelegate.managedObjectContext
    }
    
    func createImage(idImage: NSNumber, nameImage: String, pathImage: String)->Image{
        let entity = NSEntityDescription.entityForName("Image", inManagedObjectContext: managedObjectContext)
        let image = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedObjectContext) as! Image
        image.idImage = idImage
        image.nameImage = nameImage
        image.pathImage = pathImage
        return image
    }
    
    func fetchImageById(idImage: NSNumber) -> Image?{
        let fetchRequest=NSFetchRequest(entityName: "Image")
        let predicate = NSPredicate(format:"idImage like %@" , idImage)
        fetchRequest.predicate = predicate
        do {
            let result = try managedObjectContext.executeFetchRequest(fetchRequest) as! [Image]
            return result[0]
        } catch let error as NSError {
            print("Could not fetch Images : \(error)")
        }
        
        return Image()
        
    }
    
    func fetchImages()->[Image]?{
        let fetchRequest=NSFetchRequest(entityName: "Image")
        do {
            let result = try managedObjectContext.executeFetchRequest(fetchRequest) as! [Image]
            return result
        } catch let error as NSError {
            print("Could not fetch Images : \(error)")
        }
        
        return [Image]()
    }
    
    func deleteImages(images:[Image]){
        for var image:Image in images{
            self.managedObjectContext.deleteObject(image)
        }
        do {
            try self.managedObjectContext.save()
        } catch let error as NSError {
            print("Could not delete Image : \(error)")
        }
    }

}
