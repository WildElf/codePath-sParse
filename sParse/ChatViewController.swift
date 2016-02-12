//
//  ChatViewController.swift
//  sParse
//
//  Created by Eric Zim on 2/11/16.
//  Copyright © 2016 EE. All rights reserved.
//

import UIKit
import Parse

class ChatViewController: UIViewController {

	@IBOutlet weak var nameLabel: UILabel!
	
    override func viewDidLoad() {
        super.viewDidLoad()
			
			let query = PFQuery(className:"UserDeets")
			query.getObjectInBackgroundWithId("xWMyZEGZ") {
				(userDeets: PFObject?, error: NSError?) -> Void in
				if error == nil && userDeets != nil {
					print(userDeets)
					self.nameLabel.text = userDeets!["username"] as? String
				} else {
					print(error)
				}
			}
			
			
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
