//
//  DetailViewController.swift
//  Project1
//
//  Created by Rahat on 25/04/24.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var lbl: UILabel!
    
    var data:Product!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        lbl.text = data.body
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
