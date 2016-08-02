import UIKit
import Alamofire
import SVProgressHUD
import SDWebImage

/**
 * Setup the table using the array of heroes which
 * we got from the HeroStatsModel.
 **/

class QuickHeroStats:UIViewController, UITableViewDelegate, UITableViewDataSource, HeroStatsModelDelegate
{
    
    @IBOutlet weak var heroSelector: UITableView!
    
    var URL:String = "https://api.lootbox.eu/"
    
    var player:Player?
    
    var selectedHero:Hero = Hero()
    
    var model:HeroStatsModel = HeroStatsModel()
    
    var qpTableData = [Hero]()
    
    override func viewDidAppear(animated: Bool) {
        self.tabBarController?.title = "Quick-Play"
    }
    
    override func viewDidLoad() {
        
        self.heroSelector.delegate = self
        self.heroSelector.dataSource = self
        
        self.navigationController?.navigationBar.hidden = false
        
        SVProgressHUD.showWithStatus("Loading...")
        
        self.player?.playMode = "quick-play"
        
        self.model.delegate = self
        
        model.getHeroes((player?.platform)!, region: (player?.region)!, name: (player?.urlName)!, mode: ("quick-play"))
        
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        self.URL = "https://api.lootbox.eu/"
        
        switch(selectedHero.heroName){ //conform to API
            
        case "Torbjörn":
            selectedHero.heroURLName = "Torbjoern"
            break;
        case "Lúcio":
            selectedHero.heroURLName = "Lucio"
            break;
        case "Soldier: 76":
            selectedHero.heroURLName = "Soldier76"
            break;
        case "D.Va":
            selectedHero.heroURLName = "DVa"
            break;
            
        default:
            selectedHero.heroURLName = selectedHero.heroName
            break;
        }
        
        appendURL()
        
        //Get a reference to the destination view controller
        let detailViewController = segue.destinationViewController as! HeroDetailView
        
        detailViewController.heroDetails = selectedHero
        
        //Set the URL
        detailViewController.URL = self.URL
        
        self.tabBarController?.title = "Back" //So that the back button on the nav bar says Back
    }
    
    
    func appendURL (){
        URL+=((player?.platform)! + "/" + (player?.region)! + "/" + (player?.urlName)! + "/" + "quick-play" + "/" + "hero" + "/")
    }
    
    
    func heroStatsReady() {
        
        self.qpTableData = model.pickerData
        
        heroSelector.reloadData()
        
        SVProgressHUD.dismiss()
    }
    
    /**
     * Amount of rows within the table
     **/
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return qpTableData.count
    }
    
    /**
     * Update cell interface with data provided from the Hero array
     **/
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = heroSelector.dequeueReusableCellWithIdentifier("HeroCell")!
        
        let imageView = cell.viewWithTag(1) as! UIImageView
        
        /*
         * Circular UIImageView
         **/
        imageView.layer.cornerRadius = 10.0
        imageView.clipsToBounds = true;
        
        /**
         * Border UIImageView
         **/
        imageView.layer.borderWidth = 3.0
        imageView.layer.borderColor = UIColor.blackColor().CGColor
        
        imageView.sd_setImageWithURL(NSURL(string: qpTableData[indexPath.row].heroImage))
        
        let nameLabel = cell.viewWithTag(2) as! UILabel
        
        nameLabel.text = qpTableData[indexPath.row].heroName
        
        let time = cell.viewWithTag(4) as! UILabel
        
        time.text = qpTableData[indexPath.row].heroPlayTime
        
        return cell
    }
    
    /*
     * Function called when user selecte a cell
     */
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        self.selectedHero = qpTableData[indexPath.row]
        
        //deselect row
        self.heroSelector.deselectRowAtIndexPath(indexPath, animated: true)
        
        //Segue
        self.performSegueWithIdentifier("HeroDetails", sender: self)
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        //Height of the hero portraits
        return 132
    }
}
