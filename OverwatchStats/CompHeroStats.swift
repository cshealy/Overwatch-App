import UIKit
import Alamofire
import SVProgressHUD
import SDWebImage

/*
 * Class is essentially the same as QuickHeroStats
 * but the data is for competitive-play. Upon selected cell
 * the user will be sent to the same HeroDetailView Controller.
 */

class CompHeroStats:UIViewController, UITableViewDelegate, UITableViewDataSource, HeroStatsModelDelegate
{
    
    @IBOutlet weak var heroSelector: UITableView!
    
    var URL:String = "https://api.lootbox.eu/"
    
    var player:Player?
    
    var selectedHero:Hero = Hero()
    
    var model:HeroStatsModel = HeroStatsModel()
    
    var cpTableData = [Hero]()
    
    override func viewDidAppear(animated: Bool) {
        self.tabBarController?.title = "Competitive-Play"
    }
    
    override func viewDidLoad() {
        
        // Connect data:
        self.heroSelector.delegate = self
        self.heroSelector.dataSource = self
        
        self.navigationController?.navigationBar.hidden = false
        
        SVProgressHUD.showWithStatus("Loading...")
        
        self.model.delegate = self
        
        model.getHeroes((player?.platform)!, region: (player?.region)!, name: (player?.urlName)!, mode: ("competitive-play"))
        
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
        
        //appendURL
        appendURL()
        
        //Get a reference to the destination view controller
        let detailViewController = segue.destinationViewController as! HeroDetailView
        
        detailViewController.heroDetails = selectedHero
        
        //Set the URL
        detailViewController.URL = self.URL
        
        self.tabBarController?.title = "Back"
        
        
    }
    
    
    func appendURL (){
        URL+=((player?.platform)! + "/" + (player?.region)! + "/" + (player?.urlName)! + "/" + "competitive-play" + "/" + "hero" + "/")
        print(URL)
    }
    
    
    func heroStatsReady() {
        
        self.cpTableData = model.pickerData
        
        heroSelector.reloadData()
        
        SVProgressHUD.dismiss()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cpTableData.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = heroSelector.dequeueReusableCellWithIdentifier("HeroCell")!
        
        let imageView = cell.viewWithTag(1) as! UIImageView
        
        /*
         * Circular UIImageView
         **/
        imageView.layer.cornerRadius = 10.0
        imageView.clipsToBounds = true;
        
        /**
         * Border
         **/
        imageView.layer.borderWidth = 3.0
        imageView.layer.borderColor = UIColor.blackColor().CGColor
        
        
        
        imageView.sd_setImageWithURL(NSURL(string: cpTableData[indexPath.row].heroImage))
        
        let nameLabel = cell.viewWithTag(2) as! UILabel
        
        nameLabel.text = cpTableData[indexPath.row].heroName
        
        let time = cell.viewWithTag(4) as! UILabel
        
        time.text = cpTableData[indexPath.row].heroPlayTime
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        //Take note of which video the user selected
        self.selectedHero = cpTableData[indexPath.row]
        
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
