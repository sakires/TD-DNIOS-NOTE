//
//  ViewControllerListNotesViewController.swift
//  TD-NOTE-DNIOS-DESCHAMPS
//
//  Created by local192 on 06/01/2020.
//  Copyright © 2020 local192. All rights reserved.
//


import UIKit
import CoreData

class ViewControllerListNotesViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {

    var listeNote = [Note]()
    
    @IBOutlet weak var tableViewListNote: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadNote()
        tableViewListNote.delegate = self
        tableViewListNote.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listeNote.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: TableViewCellNotes = tableView.dequeueReusableCell(withIdentifier: "CellNote", for: indexPath) as! TableViewCellNotes
        cell.setNote(note: listeNote[indexPath.row])
        return cell
    }

    func loadNote (){
        let fetchRequest:NSFetchRequest<Note> = Note.fetchRequest()
        do{
            listeNote = try context.fetch(fetchRequest)
            tableViewListNote.reloadData()
            print("liste note : ")
            print(listeNote)
        }catch{
            print("Empty database note")
        }
    }
    

}
