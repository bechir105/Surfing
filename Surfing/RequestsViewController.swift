//
//  RequestsViewController.swift
//  Surfing
//
//  Created by Bechir Kefi on 25/10/2023.
//

import UIKit
import CoreData

class RequestsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    var hosts: [Host] = []
    
    
    func fetchHosts() {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Host> = Host.fetchRequest()

        do {
            hosts = try context.fetch(fetchRequest)
            tableView.reloadData()
        } catch {
            print("Error fetching hosts: \(error)")
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hosts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "hCell", for: indexPath)
        let host = hosts[indexPath.row]
        
        let label = cell.viewWithTag(1) as! UILabel
        let label1 = cell.viewWithTag(2) as! UILabel
        let imageView = cell.viewWithTag(3) as! UIImageView
        
        label.text = host.name
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        if let date = host.date {
            label1.text = dateFormatter.string(from: date)
        } else {
            label1.text = "N/A"
        }
        
        imageView.image = UIImage(named: host.image!)

        return cell
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {

            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            context.delete(hosts[indexPath.row])
            hosts.remove(at: indexPath.row)
            
            do {
                try context.save()
            } catch {
                print("Error deleting request: \(error)")
            }
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }


    @IBAction func clearAllTapped(_ sender: Any) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let fetchRequest: NSFetchRequest<Host> = Host.fetchRequest()
        do {
            let allHosts = try context.fetch(fetchRequest)
            for host in allHosts {
                context.delete(host)
            }
            try context.save()
        } catch {
            print("Error clearing all requests: \(error)")
        }
        
        hosts.removeAll()
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        fetchHosts()


    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
