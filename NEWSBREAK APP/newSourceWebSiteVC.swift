//
//  newSourceWebSiteVC.swift
//  NEWSBREAK APP
//
//  Created by Macbook Air on 2.09.2022.
//

import UIKit
import WebKit

class newSourceWebSiteVC: UIViewController {
    var urlRaw = "https://youtube.com"
    
    @IBOutlet weak var newWV: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL(string: urlRaw)
        let request = URLRequest(url: url!)
        
        newWV.load(request)
        

        // Do any additional setup after loading the view.
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
