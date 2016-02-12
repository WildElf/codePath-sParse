//
//  LoginViewController.swift
//  sParse
//
//  Created by Eric Zim & Eric Chu on 2/11/16.
//  Copyright © 2016 EE. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {
	
	@IBOutlet weak var emailField: UITextField!
	@IBOutlet weak var passwordField: UITextField!
	
	var emailAddr: String? = "steviejobs@swift.org"
	var password: String? = "securepassword"
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// Do any additional setup after loading the view.
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	@IBAction func onEditEmail(sender: AnyObject) {
		emailAddr = emailField.text
	}

	@IBAction func onEditPassword(sender: AnyObject) {
		password = passwordField.text
	}
	
	
	@IBAction func signUp(sender: AnyObject) {

		let user = PFUser()
		user.username = "jobber"
		user.password = password
		user.email = emailAddr
		// other fields can be set just like with PFObject
		user["phone"] = "415-392-0202"
		
		user.signUpInBackgroundWithBlock {
			(succeeded: Bool, error: NSError?) -> Void in
			if let error = error {
				let errorString = error.userInfo["error"] as? NSString
				// Show the errorString somewhere and let the user try again.
			} else {
				// Hooray! Let them use the app now.
				let chatControl = ChatViewController()
				
				self.presentViewController(chatControl as UIViewController, animated: true, completion: { () -> Void in
					print("successful signup")
				})
			}
		}
	}
	
	
	@IBAction func loginButt(sender: AnyObject) {
		
		PFUser.logInWithUsernameInBackground("jobber", password: "securepassword") {
			(user: PFUser?, error: NSError?) -> Void in
			if user != nil {
				print("user: \(user?.username)")
				
				let chatControl = ChatViewController()
				
				self.saveUser(user!)
				
				self.performSegueWithIdentifier("joe", sender: self)
				
/*				self.presentViewController(chatControl as UIViewController, animated: true, completion: { () -> Void in
					print("successful login")
				})
				// Do stuff after successful login.
*/			} else {
				print("error: \(error)")
				// The login failed. Check error to see why.
					print("broken login")
			}
		}
	}
	
	func saveUser (user: PFUser) {
		let userDeets = PFObject(className:"UserDeets")
		userDeets["username"] = user.username! as String
		userDeets["email"] = emailAddr
		userDeets.saveInBackgroundWithBlock {
			(success: Bool, error: NSError?) -> Void in
			if (success) {
				// The object has been saved.
			} else {
				// There was a problem, check error.description
			}
		}

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
