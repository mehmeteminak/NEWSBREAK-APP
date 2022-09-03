//
//  newDetailVC.swift
//  NEWSBREAK APP
//
//  Created by Macbook Air on 2.09.2022.
//

import UIKit

class newDetailVC: UIViewController {
    var newImageUrl : String!
  
    @IBOutlet weak var newContentLbl: UILabel!
    @IBOutlet weak var newImg: UIImageView!
    var newUrl : String = ""
    var newContent : String = ""

    
    @IBOutlet weak var newUrlLabel: UILabel!
    
    
    
    @objc func goToNewSource() {
       
        performSegue(withIdentifier: "newIdentifier", sender: newUrl)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "newIdentifier" {
            let destVC = segue.destination as! newSourceWebSiteVC
            destVC.urlRaw = sender as! String
            
            
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        newContentLbl.text = self.newContent
        newUrlLabel.text = newUrl
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(goToNewSource))
        newUrlLabel.isUserInteractionEnabled = true
        newUrlLabel.addGestureRecognizer(gesture)
        let data = try!  Data(contentsOf: URL(string: self.newImageUrl)!)
        newImg.image = UIImage(data: data)
        
        
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
