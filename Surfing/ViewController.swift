//
//  ViewController.swift
//  Surfing
//
//  Created by Bechir Kefi on 25/10/2023.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UISearchBarDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var filteredData: [(String, String)] = [] // Use a tuple to store the host name and image name
    
//    let Hôtes = ["Joe Hamilton", "Stevie Bagley", "Zoe Sug", "Sam Aderson", "Alex Abbe", "Emiley Jackson", "Jack Tomshon" ]
//    let HImage = ["h1", "h2", "h3", "h4", "h5", "h6", "h7"]
    
    let data = [Hosts(id:1, name: "Joe Hamilton", image: "h1"),Hosts(id:2, name: "Stevie Bagley", image: "h2"),Hosts(id:3, name: "Zoe Sug", image: "h3"),Hosts(id:4, name: "Sam Aderson", image: "h4"),Hosts(id:5, name: "Alex Abbe", image: "h5"),Hosts(id:6, name: "Emiley Jackson", image: "h6"),Hosts(id:7, name: "Jack Tomshon", image: "h7")]
    
    override func viewDidLoad() {
         super.viewDidLoad()
         collectionView.dataSource = self
         searchBar.delegate = self
         
         filteredData = data.map { ($0.name, $0.image) }
     }
     
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         return filteredData.count
     }
     
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cCell", for: indexPath)
         let label = cell.viewWithTag(1) as! UILabel
         let imageView = cell.viewWithTag(2) as! UIImageView
         
         let hostData = filteredData[indexPath.row]
         label.text = hostData.0
         imageView.image = UIImage(named: hostData.1)
         
         return cell
     }
     
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedHost = data[indexPath.row]
        print("Selected Host: \(selectedHost)")
        performSegue(withIdentifier: "mSegue", sender: selectedHost)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "mSegue" {
            if let selectedHost = sender as? Hosts {
                print("Preparing for segue with host: \(selectedHost)")
                let destination = segue.destination as! DetailsViewController
                destination.hosts = selectedHost
            }
        }
    }


     func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
         filteredData = data.filter { $0.name.lowercased().contains(searchText.lowercased()) }
                          .map { ($0.name, $0.image) }
         collectionView.reloadData()
     }
     
     func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
         searchBar.text = ""
         filteredData = data.map { ($0.name, $0.image) }
         collectionView.reloadData()
         searchBar.resignFirstResponder()
     }
    
    @IBAction func barButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "tSegue", sender: self)
    }
    
 }
