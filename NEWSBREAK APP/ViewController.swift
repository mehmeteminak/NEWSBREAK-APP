//
//  ViewController.swift
//  NEWSBREAK APP
//
//  Created by Macbook Air on 2.09.2022.
//

import UIKit


extension UIViewController {
    func showAlert(title : String , body : String){
        let alert = UIAlertController(title: title, message: body, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel))
        self.present(alert, animated: true)
        
        
    }
}

class ViewController: UIViewController ,UITableViewDelegate, UITableViewDataSource{
    
    var subject : String = "microsoft"
   
    var newsTitle : [String] = []
    var newsContent : [String] = []
    var newsUrl : [String] = []
    var newsImage : [String] = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsTitle.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = newsTable.dequeueReusableCell(withIdentifier: "neww", for: indexPath) as! newTVC
        
        cell.newTitle.text =  newsTitle[indexPath.row]
        
        
        let data = try! Data(contentsOf: URL(string: self.newsImage[indexPath.row])!)
        cell.newImg.image = UIImage(data: data)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "newContent", sender: indexPath.row)
        
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "newContent" {
            let destVC = segue.destination as! newDetailVC
            destVC.newContent = self.newsContent[sender as! Int]
            destVC.newUrl = self.newsUrl[sender as! Int]
            destVC.newImageUrl = self.newsImage[sender as! Int]
            
            
            
            
        }
    }
    
    func fetchNews(){
        
        let session = URLSession.shared
       
        let task = session.dataTask(with: URL(string: "https://newsapi.org/v2/everything?q=\(self.subject)&language=tr&pageSize=50&apiKey=c6e701ec645e4111bddaf7220874f8be")!) { data, response, error in
                if error != nil {
                    
                }else{
                    do{
                        let news =  try JSONSerialization.jsonObject(with: data!) as! Dictionary<String,Any>
                        let neww = news["articles"] as! [Dictionary<String,Any>]
                        
                        self.newsUrl.removeAll()
                        self.newsContent.removeAll()
                        self.newsImage.removeAll()
                        self.newsTitle.removeAll()
                        
                        for object in neww {
                         
                                self.newsImage.append(object["urlToImage"] as! String)
                                self.newsTitle.append(object["description"] as! String)
                            self.newsContent.append(object["content"] as! String)
                            self.newsUrl.append(object["url"] as! String)
                            
                                
                             
                             
                                
                                
                            
                            
                            
                            
                        }
                        DispatchQueue.main.async {
                            self.newsTable.reloadData()
                            
                        
                            
                        }
                    }catch {
                        print(error.localizedDescription)
                    }
                    
                }
            
            
        }
        task.resume()
        
        
        
    }
    
    @objc func searchAboutSubject(){
        if subjectTF.text != "" {
            self.subject = subjectTF.text!
            fetchNews()
            DispatchQueue.main.async {
                self.newsTable.reloadData()
            }
        }else{
            showAlert(title: "HATA!", body: "Lütfen arama yapmadan önce konuyu belirtin!")
            
            
        }
        
        
    }
    
    @IBOutlet weak var subjectTF: UITextField!
    @IBOutlet weak var newsTable: UITableView!
    
    @objc func closeKeyboard(){
        view.endEditing(true)
        
    }
    @IBOutlet weak var closeView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        navigationController?.navigationBar.topItem?.title = "NEWSBREAK APP"
        let barAppearance = UINavigationBarAppearance()
        barAppearance.titleTextAttributes = [.foregroundColor : UIColor.red]
        navigationController?.navigationBar.standardAppearance = barAppearance
        
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(searchAboutSubject))
        
        
        newsTable.dataSource = self
        newsTable.delegate = self
        
       
        
        closeView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(closeKeyboard)))
        
        
        
        fetchNews()
        
        
        
        
        
    }
    
    
    
    


}

