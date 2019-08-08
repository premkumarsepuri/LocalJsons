//
//  ViewController.swift
//  LocalJson
//
//  Created by QUADRANT on 4/24/19.
//  Copyright © 2019 QUADRANT. All rights reserved.
//

import UIKit
import RealmSwift


class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{
  
    // dictionary
    var storage = NSDictionary()

    @IBOutlet weak var tableViewOne: UITableView!
    
    // rusing datasourse to get stored data from realm
    var dataSourse :  Results<MealRealm>!
    let realm = try! Realm()
    
    override func viewDidLoad() {
       super.viewDidLoad()
        self.parsingJson()
        
       self.tableViewOne.rowHeight = UITableView.automaticDimension
       self.tableViewOne.estimatedRowHeight = 600
        
        
        
        if let fileUrl = Realm.Configuration.defaultConfiguration.fileURL{
            print("FILE URL IS",fileUrl)
        }
        
        tableViewOne.delegate = self
        tableViewOne.dataSource = self
          reloadTable()
        
        
    }

    func parsingJson()  {
        
        if let path = Bundle.main.path(forResource:"test", ofType: "json") {
            do {
                let jsonData = try NSData(contentsOfFile: path, options: NSData.ReadingOptions.mappedIfSafe)
                do {
                    let jsonResult: NSDictionary = try JSONSerialization.jsonObject(with: jsonData as Data, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
                    if let people : [NSDictionary] = jsonResult["person"] as?  [NSDictionary] {
                     
                
               for i in 0..<people.count
               {
                var storage = people[i] as! NSDictionary
               let age = storage["answer"]!
               // print(age)
            
                let name = storage["question"]!
                
                
                // storing data into realm data base
                let item = MealRealm()
                
                item.question = String(name as! String)
                item.answer = String(age as! String)
            
                
                do{
                    let realm = try Realm()
                    
                    try realm.write({
                        realm.add(item)
                    })
                    
                }catch
                {
                    
                    
                }
                        }
             
                        }
                    
                       tableViewOne.reloadData()

                    }
                } catch {}
            }
        }
    
   
    func reloadTable(){
        do{
            dataSourse = realm.objects(MealRealm.self)
            tableViewOne.reloadData()
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSourse.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        var cellIdentifier = "cell"
        
        guard let cell = tableViewOne.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? TableCell  else {
            fatalError("The dequeued cell is not an instance of MealTableViewCell.")
        }
        let meal = dataSourse[indexPath.row]
        
        cell.nameLBL.text = meal.question
        cell.ageLBL.text = meal.answer
        
        return cell
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    

}// end of the class

