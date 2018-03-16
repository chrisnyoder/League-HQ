//
//  resultsContoller.swift
//  League HQ
//
//  Created by Christian Yoder on 3/10/18.
//  Copyright © 2018 Christian Yoder. All rights reserved.
//

import UIKit

class resultsContoller: UIViewController {

    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var lblResults: UILabel!

    var numRight: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lblResults.text = "You got \(numRight!) out of 12 questions correct"
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
