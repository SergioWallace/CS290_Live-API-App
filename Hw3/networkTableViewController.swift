//
//  networkTableViewController.swift
//  Hw3
//
//  Created by codeplus on 2/25/20.
//  Copyright © 2020 CS290. All rights reserved.
//

import UIKit
import Network

class networkTableViewCell: UITableViewCell {

    @IBOutlet weak var superLabel: UILabel!
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var nameImage: UIImageView!
    
    
    var name: String = ""
    var species: String = ""
    var status: String = ""
    var origin: String = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}


class networkTableViewController: UITableViewController {

    
    struct DBZ: Codable {
        var name: String
        var species: String
        var status: String
        var originPlanet: String
    }
    
    var allTodos: [DBZ] = []
    var backgrounds = [ UIImage(named: "background1"), UIImage(named: "background2"), UIImage(named: "background3"), UIImage(named: "background4"), UIImage(named: "background5")]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        getAllData()
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    

    
    func getAllData() {
        
        // 2. BEGIN NETWORKING code
        //
        let mySession = URLSession(configuration: URLSessionConfiguration.default)

        let url = URL(string: "https://dragon-ball-api.herokuapp.com/api/character/")!

        // 3. MAKE THE HTTPS REQUEST task
        
        let alert1 = UIAlertController(title: "No Internet Connection", message: "iPhone must be connected to internet for app to run", preferredStyle: .alert)
        
        alert1.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        
                let task = mySession.dataTask(with: url) { data, response, error in

                    // ensure there is no error for this HTTP response
                    guard error == nil else {
                        
                        DispatchQueue.main.async {
                           self.present(alert1, animated: true)
                        }
                        
                        return
                    }

                    // ensure there is data returned from this HTTP response
                    guard let jsonData = data else {
                        print("No data")
                        return
                    }
                    
                    print("Got the data from network")
        // 4. DECODE THE RESULTING JSON
        //
                    let decoder = JSONDecoder()

                    do {
                        // decode the JSON into our array of todoItem's
                        self.allTodos = try decoder.decode([DBZ].self, from: jsonData)
                                
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                        
                    } catch {
                        print("JSON Decode error")
                    }
                }

            // actually make the http task run.
            task.resume()
        
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return allTodos.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "networkCell", for: indexPath) as! networkTableViewCell

        // Configure the cell...
        cell.name = allTodos[indexPath.row].name
        cell.species = allTodos[indexPath.row].status
        cell.status = allTodos[indexPath.row].species
        cell.origin = allTodos[indexPath.row].originPlanet
        
        cell.superLabel.text = "Character: " + allTodos[indexPath.row].name
        cell.backgroundImage.image = backgrounds[indexPath.row % 5]
        cell.nameImage.image = UIImage(named: allTodos[indexPath.row].name)
        
        return cell
    }
    
    
    // In a storyboard-based application, you will often want to do a little preparation before     navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destVC = segue.destination as! focusViewController
        let myRow = tableView!.indexPathForSelectedRow
        let myCurrCell = tableView.cellForRow(at: myRow!) as! networkTableViewCell
        
        destVC.nameText = (myCurrCell.name)
        destVC.statusText = (myCurrCell.species)
        destVC.speciesText = (myCurrCell.status)
        destVC.originText = (myCurrCell.origin)
        destVC.nameImage = (myCurrCell.nameImage!.image)!
        destVC.backgroundImage = (myCurrCell.backgroundImage!.image)!
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
