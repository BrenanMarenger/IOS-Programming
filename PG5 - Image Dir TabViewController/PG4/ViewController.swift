//
//  ViewController.swift
//  PG4
//
//  Created by NMU Student on 11/8/23.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet var pathTextField:UITextField?
    @IBOutlet var pathSubmitButton:UIButton?
    @IBOutlet var tv:UITableView?
    var imageNames:[String]? = []
    var path:String?
    var svc:SecondViewController?
    var imageCounter = 0
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return imageNames!.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "image", for: indexPath)
        cell.textLabel!.text = imageNames?[imageCounter]
        imageCounter = imageCounter + 1
        return cell
    }

    func numberOfSections (in tableView:UITableView)->Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let imageURL = URL(fileURLWithPath: path!).appendingPathComponent(imageNames![indexPath.row])
        print("selected cell \(indexPath.row)")
        svc!.image!.image = UIImage (contentsOfFile:imageURL.path)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tv!.register(UITableViewCell.self,forCellReuseIdentifier: "image")
        pathTextField?.text = "/Users/student/Desktop/images"
        
        svc = (tabBarController!.viewControllers![1] as! SecondViewController)
        _ = svc!.view
        
        pathSubmitButton?.addTarget(self, action: #selector(getPath), for: UIControl.Event.touchUpInside)
    }

    
    @IBAction func getPath(){
        imageNames = []
        imageCounter = 0
        path = pathTextField?.text
        let enumerator = FileManager.default.enumerator(atPath:path!)
        let files = enumerator?.allObjects as! [String]
        var counter:CGFloat = 0
        for i in 0..<files.count {
            if(files[i].hasSuffix(".jpg")){
                counter += 1
                imageNames?.append(files[i])
                print(files[i])
            }
        }
        tv?.reloadData()
    }
}

