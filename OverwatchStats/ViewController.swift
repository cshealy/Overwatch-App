      import UIKit
      import Alamofire
      import SVProgressHUD
      
      /**
       * Form to get the user's region, platform, and psn/xbl/BattleTag
       **/
      
      
      class ViewController: UIViewController, UITextFieldDelegate, GeneralStatsModelDelegate {
        
        @IBOutlet weak var backgroundImage: UIImageView!
        @IBOutlet weak var tagTextField: UITextField!
        @IBOutlet weak var regionSelector: UISegmentedControl!
        @IBOutlet weak var platformSelector: UISegmentedControl!
        
        var currentPlayer:Player = Player()
        var model:GeneralStatsModel = GeneralStatsModel()
        
        override func viewWillAppear(animated: Bool) {
            self.navigationController?.navigationBar.hidden = true
        }
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            SVProgressHUD.setDefaultStyle(SVProgressHUDStyle.Dark)
            
            currentPlayer.region = "us" // default segment selected for regionSelector
            currentPlayer.platform = "pc" // default segment selected for platformSelector
            
            self.tagTextField.delegate = self
            
            /**
             * Looks for single or multiple taps outside of the on screen keyboard and closes when recognized
             **/
            let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.dismissKeyboard))
            view.addGestureRecognizer(tap)
        }
        
        
        /**
         * Function called when tap is recognized
         **/
        func dismissKeyboard() {
            view.endEditing(true) //closes keyboard
        }
        
        /**
         * When the user presses the Go/Return button from the keyboard they will
         * be sent to the next scene where they can view all of the stats
         * for the username they input
         **/
        func textFieldShouldReturn(textField: UITextField) -> Bool {
            
            dismissKeyboard()
            
            SVProgressHUD.showWithStatus("Loading...")
            
            currentPlayer.name = tagTextField.text! //What the user typed within the textfield
            
            //textField.resignFirstResponder()
            
            if(currentPlayer.platform == "xbl" || currentPlayer.platform == "psn"){
                currentPlayer.region = "global"
            }
            
            self.model.delegate = self
            
            model.getUserStats(currentPlayer.platform, region: currentPlayer.region , name: currentPlayer.name)
            
            return true
        }
        
        /**
         * Pass the player object from the ViewController on to the UITabBarController
         * Fromt the UITabBarController the [0] index is GeneralStats, HeroStats is [1],
         * & PlayTime is [2]
         **/
        
        override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
            
            let tabBarController = segue.destinationViewController as! UITabBarController
            let svc = tabBarController.viewControllers![0] as! GeneralStats
            svc.player = currentPlayer
            
        }
        
        
        /**
         * Will handle any selection the user makes on the segmented buttons
         * Assigns value to region to be appended to the URL for Alamofire
         * function
         **/
        
        @IBAction func regionSelection(sender: UISegmentedControl) {
            
            switch(sender.selectedSegmentIndex){
                
            case 0:
                currentPlayer.region = "us"
            case 1:
                currentPlayer.region = "eu"
            case 2:
                currentPlayer.region = "kr"
            case 3:
                currentPlayer.region = "kr"
            default:
                currentPlayer.region = "cn"
            }
            print(currentPlayer.region)
        }
        
        
        @IBAction func platformSelection(sender: UISegmentedControl) {
            
            switch(sender.selectedSegmentIndex){
                
            case 0:
                currentPlayer.platform = "pc"
            case 1:
                currentPlayer.platform = "xbl"
            case 2:
                currentPlayer.platform = "psn"
            default:
                print("No current selection")
            }
            print(currentPlayer.platform)
            
        }
        
        func dataReady(){
            
            self.currentPlayer = self.model.player!
            
            self.currentPlayer.urlName = tagTextField.text!
            
            tagTextField.text = nil
            
            SVProgressHUD.dismiss()
            
            if(Int(self.currentPlayer.level) > 0){
                
                /**
                 * Send to prepareForSegue function and then from there to the tab controller
                 **/
                performSegueWithIdentifier("sendToStats", sender: self)
                
            }
                
            else{
                
                //setup an alert to notify the user they have an invalid player
                let alert = UIAlertController(title: "Invalid Player", message:"Please enter a valid player", preferredStyle: .Alert)
                alert.addAction(UIAlertAction(title: "OK", style: .Default) { _ in })
                self.presentViewController(alert, animated: true){}
                
            }
            
        }
        
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
        
      }
