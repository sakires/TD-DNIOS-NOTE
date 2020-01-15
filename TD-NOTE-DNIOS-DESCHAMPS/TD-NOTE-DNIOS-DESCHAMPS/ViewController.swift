//
//  ViewController.swift
//  TD-NOTE-DNIOS-DESCHAMPS
//
//  Created by local192 on 06/01/2020.
//  Copyright © 2020 local192. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var TextNoteTitle: UITextField!
    @IBOutlet weak var textNoteDesc: UITextView!
    var editNote:Note?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let note = editNote {
            TextNoteTitle.text = note.title
            textNoteDesc.text = note.desc
        }
    }

    @IBAction func actionNoteSave(_ sender: Any) {
        
        var newNote:Note?
        var isEdit:Bool = false
        
        if let note = editNote {
            newNote = note
            isEdit = true
        }else{
            newNote = Note(context: context)
        }
        
        newNote?.title = TextNoteTitle.text
        newNote?.desc = textNoteDesc.text
        newNote?.date_creation = NSDate() as Date
        ad.saveContext()
        TextNoteTitle.text = ""
        textNoteDesc.text = ""
        if isEdit {
            dismiss(animated: true, completion: nil)
        }
        /*let newNote = Note(context: context)
        newNote.title = TextNoteTitle.text
        newNote.desc =  textNoteDesc.text
        newNote.date_creation =  NSDate() as Date
        
        ad.saveContext()
        TextNoteTitle.text = ""
        textNoteDesc.text = ""*/
    }
    
    @IBAction func buttonActionBackToListNotes(_ sender: Any) {
        let viewControllerListNotesViewController = self.presentingViewController as? ViewControllerListNotesViewController
        dismiss(animated:true, completion:{viewControllerListNotesViewController?.loadNote()})
    }
}

