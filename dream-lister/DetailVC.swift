//
//  DetailVC.swift
//  dream-lister
//
//  Created by Yuen Hsi Chang on 1/11/17.
//  Copyright © 2017 Yuen Hsi Chang. All rights reserved.
//

import UIKit
import CoreData

class DetailVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var storePicker: UIPickerView!
    @IBOutlet weak var titleField: CustomTextField!
    @IBOutlet weak var priceField: CustomTextField!
    @IBOutlet weak var detailsField: CustomTextField!
    @IBOutlet weak var thumbImage: UIImageView!
    
    var stores: [Store]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let topItem = navigationController?.navigationBar.topItem {
            topItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        }
        storePicker.delegate = self
        storePicker.dataSource = self
        
//        loadData()
        getStores()
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
        
        let item = Item(context: appDelegate.persistentContainer.viewContext)
        item.created = NSDate()
        item.details = detailsField.text
        item.price = NSString(string: priceField.text!).doubleValue
        item.title = titleField.text
        let store = stores[storePicker.selectedRow(inComponent: 0)]
        item.toStore = store
        
        appDelegate.saveContext()
        
        let _ = navigationController?.popViewController(animated: true)
    }
    
    @IBAction func imageBtnPressed(_ sender: Any) {
    }
}
