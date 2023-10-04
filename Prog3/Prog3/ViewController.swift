//
//  ViewController.swift
//  Prog3
//
//  Created by NMU Student on 9/28/23.
//

import UIKit

class ViewController: UIViewController {
    var pathTextField:UITextField?
    var pathSubmitButton:UIButton?
    var imageButtons:[UIButton?] = []
    var button:UIButton?
    var sv:UIScrollView?
    var path:String?
    var pictureView:UIImageView?
    var picture:UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sv = UIScrollView()
        sv!.frame = CGRect(x:0,y:0,width:view.frame.size.width, height:view.frame.size.height)
        sv!.contentSize = CGSize(width:view.frame.size.width, height: view.frame.size.height)
        
        //Path Input
        pathTextField = UITextField()
        pathTextField!.backgroundColor = UIColor.lightGray
        pathTextField!.frame = CGRect(x:50,y:50,width: 300,height: 50)
        pathSubmitButton = UIButton()
        pathSubmitButton?.backgroundColor = UIColor.gray
        pathSubmitButton!.setTitle("Submit Path", for:UIControl.State.normal)
        pathSubmitButton!.frame = CGRect(x:50,y:120,width:120,height:50)
        sv!.addSubview(pathTextField!)
        sv!.addSubview(pathSubmitButton!)
        
        //Path Button Action
        pathSubmitButton!.addTarget(self, action: #selector(getPath), for: UIControl.Event.touchUpInside)

        //Image Area
        pictureView = UIImageView()
        pictureView!.frame = CGRect(x:95,y:200,width:view.frame.size.width/2,height:view.frame.size.height/4)
        pictureView?.backgroundColor = UIColor.black
        sv!.addSubview(pictureView!)

        //Attaching scrollview 
        view!.addSubview(sv!)
    }
    
    //Get the file path and generates buttons for file ending ing .jpg
    @IBAction func getPath(){
        path = pathTextField?.text
        let enumerator = FileManager.default.enumerator(atPath:path!)
        let files = enumerator?.allObjects as! [String]
        var counter:CGFloat = 0
        for i in 0..<files.count {
            if(files[i].hasSuffix(".jpg")){
                counter += 1
                button = UIButton()
                button!.backgroundColor = UIColor.orange
                button!.setTitle("\(files[i])", for:UIControl.State.normal)
                button!.frame = CGRect (x:90,y:400+60*counter,width:220,height:50)
                sv!.addSubview(button!)
                button!.addTarget(self, action: #selector(setImage), for: UIControl.Event.touchUpInside)
            }
        }
        print(counter)
        sv!.contentSize = CGSize(width:view.frame.size.width, height:((60*counter) + 500))
    }
    
    //Sets the image to the corresponding image
    @IBAction func setImage(_ sender: UIButton){
        let buttonTitle = sender.title(for: .normal) ?? String()
        let imageURL = URL(fileURLWithPath: path!).appendingPathComponent(buttonTitle)
        picture = UIImage(contentsOfFile: imageURL.path)
        pictureView!.image = picture!
    }
}

