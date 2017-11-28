//
//  ComposeViewController.swift
//  CalendarToDo
//
//  Created by Jiaying Wang on 11/25/17.
//  Copyright © 2017 Jiaying Wang. All rights reserved.
//

import UIKit
import CoreData

class ComposeViewController: UIViewController
{
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    lazy var entry = Entry(context: context)
    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var doneBarButtonItem: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Do any additional setup after loading the view
        self.title = "Journal"
        self.textView.becomeFirstResponder()
        self.navigationItem.rightBarButtonItem = self.doneBarButtonItem
        
        if entry.bodyText != nil {
            //there's an entry passed into this class. We can edit
            self.textView.text = entry.value(forKey: "bodyText") as? String
        } else {
            self.textView.text = ""
        }
        
    }
    
    @IBAction func doneDidClick(_ sender: UIBarButtonItem) {
        if entry.bodyText != nil {
            self.updateEntry()
        } else {
            if textView.text != ""{
                self.createNewEntry()
            }
        }
        
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    func createNewEntry(){
        let entryEntity = NSEntityDescription.entity(forEntityName: "Entry", in: context)!
        let entryObject = NSManagedObject(entity: entryEntity, insertInto: context)
        entryObject.setValue(self.textView.text, forKey: "bodyText")
        entryObject.setValue(Date(), forKey: "createdAt")
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
    }
    
    func updateEntry(){
        
    }
    
}
