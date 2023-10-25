//
//  DetailsViewController.swift
//  Surfing
//
//  Created by Bechir Kefi on 25/10/2023.
//

import UIKit
import CoreData

class DetailsViewController: UIViewController {
    
    var hosts: Hosts? = Hosts(id: 1, name: "", image: "")
    @IBOutlet weak var imageHost: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var image2: UIImageView!
    @IBOutlet weak var sendRequestButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let host = hosts {
            imageHost.image = UIImage(named: host.image)
            name.text = host.name
            
            let hostImageMap: [String: String] = [
                "Joe Hamilton": "HJoe Hamilton",
                "Stevie Bagley": "HStevie Bagley",
                "Zoe Sug": "HZoe Sug",
                "Sam Aderson": "HSam Aderson",
                "Alex Abbe": "HAlex Abbe",
                "Emiley Jackson": "HEmiley Jackson",
                "Jack Tomshon": "HJack Tomshon",
            ]
            
            if let imageName = hostImageMap[host.name] {
                image2.image = UIImage(named: imageName)
            } else {
              
            }
            
 
           
        }
    }

    @IBAction func sendRequestTapped(_ sender: Any) {
        if let host = hosts {
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            let newRequest = Host(context: context)
            newRequest.name = host.name
            newRequest.image = host.image

            do {
                try context.save()
                showAlert(title: "Request Sent", message: "Your request has been sent successfully.")
                
                UserDefaults.standard.set(true, forKey: "isButtonEnabled_\(host.id)")
                sendRequestButton.isEnabled = false

            } catch {
                showAlert(title: "Error", message: "Failed to send the request. Please try again.")
            }
        }
    }


    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
