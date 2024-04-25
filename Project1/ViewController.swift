//
//  ViewController.swift
//  Project1
//
//  Created by Rahat on 25/04/24.
//

import UIKit

class ProductTableCell:UITableViewCell {
    @IBOutlet weak var idLbl: UILabel!
    @IBOutlet weak var titleLbl: UILabel!
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func bindData(data:Product){
        idLbl.text = "\(data.id)"
        titleLbl.text = data.title
    }
}

class ViewController: UIViewController {
    
    @IBOutlet weak var tbleView: UITableView!
    
    var productData: [Product]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        initialSetup()
    }
    func initialSetup(){
        APIManager.shared.getProducts { result in
            switch result {
            case .success(let products):
                // Handle products array
                print("Fetched products: \(products)")
                self.productData = products
                
                DispatchQueue.main.async {
                    self.tbleView.reloadData()
                }
            case .failure(let error):
                // Handle error
                print("Error fetching products: \(error)")
            }
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productData?.count ?? 0
    }
    //    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    //        return UITableView.automaticDimension
    //    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tbleView.dequeueReusableCell(withIdentifier: "ProductTableCell", for: indexPath) as! ProductTableCell
        
        cell.bindData(data: productData![indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController
        
        vc?.data = productData![indexPath.row]
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
}
