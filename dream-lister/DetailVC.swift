//
//  DetailVC.swift
//  dream-lister
//
//  Created by Yuen Hsi Chang on 1/11/17.
//  Copyright © 2017 Yuen Hsi Chang. All rights reserved.
//

import UIKit
import CoreData

class DetailVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var storePicker: UIPickerView!
    @IBOutlet weak var titleField: CustomTextField!
    @IBOutlet weak var priceField: CustomTextField!
    @IBOutlet weak var detailsField: CustomTextField!
    @IBOutlet weak var thumbImage: UIImageView!
    
    var stores: [Store]!
    var currentItem: Item?
    var imagePicker: UIImagePickerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let topItem = navigationController?.navigationBar.topItem {
            topItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        }
        storePicker.delegate = self
        storePicker.dataSource = self
        getStores()
        
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        if currentItem != nil {
            titleField.text = currentItem!.title
            priceField.text = "\(currentItem!.price)"
            detailsField.text = currentItem!.details
            if let img = currentItem!.toImage?.image as? UIImage {
                thumbImage.image = img
            }
            
            if let name = currentItem!.toStore?.name {
                for (index, store) in stores.enumerated() {
                    if store.name == name {
                        storePicker.selectRow(index, inComponent: 0, animated: true)
                    }
                }
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return stores[row].name
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return stores.count
    }
    
    func getStores() {
        let fetchRequest: NSFetchRequest<Store> = Store.fetchRequest()
        
        do {
            self.stores = try appDelegate.persistentContainer.viewContext.fetch(fetchRequest)
            self.storePicker.reloadAllComponents()
        } catch {
            print(error)
        }
    }
    
    func loadData() {
        let store1 = Store(context: appDelegate.persistentContainer.viewContext)
        store1.name = "Amazon"
        let store2 = Store(context: appDelegate.persistentContainer.viewContext)
        store2.name = "American ego"
        let store3 = Store(context: appDelegate.persistentContainer.viewContext)
        store3.name = "Detroit"
        let store4 = Store(context: appDelegate.persistentContainer.viewContext)
        store4.name = "Mainland China"
        appDelegate.saveContext()
    }
    
    @IBAction func saveBtnPressed(_ sender: Any) {
        
        var item: Item!
        if currentItem != nil {
            item = currentItem
        } else {
            item = Item(context: appDelegate.persistentContainer.viewContext)
        }
        item.created = NSDate()
        item.details = detailsField.text
        item.price = NSString(string: priceField.text!).doubleValue
        item.title = titleField.text
        let store = stores[storePicker.selectedRow(inComponent: 0)]
        item.toStore = store
        item.toImage = Image(context: appDelegate.persistentContainer.viewContext)
        item.toImage!.image = thumbImage.image
        
        appDelegate.saveContext()
        
        let _ = navigationController?.popViewController(animated: true)
    }
    
    @IBAction func imageBtnPressed(_ sender: Any) {
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let img = info[UIImagePickerControllerOriginalImage] as? UIImage {
            thumbImage.image = img
        }
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func deleteBtnPressed(_ sender: Any) {
        
        if currentItem != nil {
            appDelegate.persistentContainer.viewContext.delete(currentItem!)
            appDelegate.saveContext()
            
        }
        let _ = navigationController?.popViewController(animated: true)
    }
}










