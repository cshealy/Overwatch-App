import UIKit
import Alamofire
import SVProgressHUD
import SDWebImage

class HeroDetailView: UIViewController {
    
    /**
     * Grab URL from last controller
     * Send to function for API data
     * Apply data to UI
     **/
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var winPercentageTitle: UILabel!
    @IBOutlet weak var goldMedalTitle: UILabel!
    @IBOutlet weak var goldMedalNum: UILabel!
    @IBOutlet weak var silverMedalTitle: UILabel!
    @IBOutlet weak var silverMedalNum: UILabel!
    @IBOutlet weak var bronzeMedalTitle: UILabel!
    @IBOutlet weak var bronzeMedalNum: UILabel!
    @IBOutlet weak var winPercentNum: UILabel!
    @IBOutlet weak var heroPortrait: UIImageView!
    @IBOutlet weak var cardsTitle: UILabel!
    @IBOutlet weak var cardsNum: UILabel!
    @IBOutlet weak var dmgDoneTitle: UILabel!
    @IBOutlet weak var dmgDoneNum: UILabel!
    @IBOutlet weak var dmgAvgTitle: UILabel!
    @IBOutlet weak var dmgAvgNum: UILabel!
    @IBOutlet weak var dmgMostinGameTitle: UILabel!
    @IBOutlet weak var dmgMostinGameNum: UILabel!
    @IBOutlet weak var dmgMostinLifeTitle: UILabel!
    @IBOutlet weak var dmgMostinLifeNum: UILabel!
    @IBOutlet weak var deathsTitle: UILabel!
    @IBOutlet weak var deathsNum: UILabel!
    @IBOutlet weak var avgDeathsTitle: UILabel!
    @IBOutlet weak var avgDeathsNum: UILabel!
    @IBOutlet weak var gamesPlayedTitle: UILabel!
    @IBOutlet weak var gamesPlayedNum: UILabel!
    @IBOutlet weak var eliminationsTitle: UILabel!
    @IBOutlet weak var eliminationsNum: UILabel!
    @IBOutlet weak var elimAvgTitle: UILabel!
    @IBOutlet weak var elimAvgNum: UILabel!
    @IBOutlet weak var elimMostGameTitle: UILabel!
    @IBOutlet weak var elimMostGameNum: UILabel!
    @IBOutlet weak var elimMostLifeTitle: UILabel!
    @IBOutlet weak var elimMostLifeNum: UILabel!
    @IBOutlet weak var elimPerLifeTitle: UILabel!
    @IBOutlet weak var elimPerLifeNum: UILabel!
    @IBOutlet weak var finalBlowsTitle: UILabel!
    @IBOutlet weak var finalBlowsNum: UILabel!
    @IBOutlet weak var finalBlowsAvgTitle: UILabel!
    @IBOutlet weak var finalBlowsAvgNum: UILabel!
    @IBOutlet weak var mostFBinGameTitle: UILabel!
    @IBOutlet weak var mostFBinGameNum: UILabel!
    @IBOutlet weak var objKillsTitle: UILabel!
    @IBOutlet weak var objKillsNum: UILabel!
    @IBOutlet weak var objKillsAvgTitle: UILabel!
    @IBOutlet weak var objKillsAvgNum: UILabel!
    @IBOutlet weak var objKillsMostGameTitle: UILabel!
    @IBOutlet weak var objKillsMostGameNum: UILabel!
    @IBOutlet weak var objTimeTitle: UILabel!
    @IBOutlet weak var objTimeNum: UILabel!
    @IBOutlet weak var objTimeAvgTitle: UILabel!
    @IBOutlet weak var objTimeAvgNum: UILabel!
    @IBOutlet weak var objTimeMostGameTitle: UILabel!
    @IBOutlet weak var objTimeMostGameNum: UILabel!
    @IBOutlet weak var soloKillsTitle: UILabel!
    @IBOutlet weak var soloKillsNum: UILabel!
    @IBOutlet weak var soloKillsAvgTitle: UILabel!
    @IBOutlet weak var soloKillsAvgNum: UILabel!
    @IBOutlet weak var soloKillsMostGameTitle: UILabel!
    @IBOutlet weak var soloKillsMostGameNum: UILabel!
    @IBOutlet weak var timeSpentonFireTitle: UILabel!
    @IBOutlet weak var timeSpentonFireNum: UILabel!
    
    
    var heroDetails:Hero = Hero()
    var model:HeroDetailModel = HeroDetailModel()
    
    var URL:String = ""
    
    override func viewDidAppear(animated: Bool) {
        self.title = heroDetails.heroName
        self.navigationItem.backBarButtonItem?.title = "Back"
    }
    
    
    override func viewDidLoad() {
        
        SVProgressHUD.showWithStatus("Loading...")
        
        URL += heroDetails.heroURLName + "/"
        
        self.model.delegate = self
        
        model.getHeroDetails(URL, heroName: heroDetails.heroURLName)
        
    }
    
    /*
     * Update all of the UI with the data that was sent
     * from the HeroDetailModel
     */
    
    func detailsReady(){
        
        heroDetails.goldMedalNum =  model.heroData.goldMedalNum
        heroDetails.silverMedalNum = model.heroData.silverMedalNum
        heroDetails.bronzeMedalNum = model.heroData.bronzeMedalNum
        heroDetails.winPercent = model.heroData.winPercent
        heroDetails.cards = model.heroData.cards
        heroDetails.dmgDone = model.heroData.dmgDone
        heroDetails.dmgDoneMostLife = model.heroData.dmgDoneMostLife
        heroDetails.dmgDoneMostGame = model.heroData.dmgDoneMostGame
        heroDetails.dmgDoneAvg = model.heroData.dmgDoneAvg
        heroDetails.deaths = model.heroData.deaths
        heroDetails.deathsAvg = model.heroData.deathsAvg
        heroDetails.elim = model.heroData.elim
        heroDetails.elimPerLife = model.heroData.elimPerLife
        heroDetails.elimMostLife = model.heroData.elimMostLife
        heroDetails.elimAvg = model.heroData.elimAvg
        heroDetails.elimMostGame = model.heroData.elimMostGame
        heroDetails.finalBlows = model.heroData.finalBlows
        heroDetails.fbMostGame = model.heroData.fbMostGame
        heroDetails.fBAvg = model.heroData.fBAvg
        heroDetails.gamesPlayed = model.heroData.gamesPlayed
        heroDetails.objKills = model.heroData.objKills
        heroDetails.objKillsAvg = model.heroData.objKillsAvg
        heroDetails.objKillsMostGame = model.heroData.objKillsMostGame
        heroDetails.objTime = model.heroData.objTime
        heroDetails.objTimeMostGame = model.heroData.objTimeMostGame
        heroDetails.objTimeAvg = model.heroData.objTimeAvg
        heroDetails.soloKills = model.heroData.soloKills
        heroDetails.soloKillsMostGame = model.heroData.soloKillsMostGame
        heroDetails.soloKillsAvg = model.heroData.soloKillsAvg
        heroDetails.timeSpentOnFire = model.heroData.timeSpentOnFire

        
        
        goldMedalNum.text = heroDetails.goldMedalNum
        silverMedalNum.text = heroDetails.silverMedalNum
        bronzeMedalNum.text = heroDetails.bronzeMedalNum
        winPercentNum.text = heroDetails.winPercent
        cardsNum.text = heroDetails.cards
        dmgDoneNum.text = heroDetails.dmgDone
        dmgAvgNum.text = heroDetails.dmgDoneAvg
        dmgMostinGameNum.text = heroDetails.dmgDoneMostGame
        dmgMostinLifeNum.text = heroDetails.dmgDoneMostLife
        deathsNum.text = heroDetails.deaths
        avgDeathsNum.text = heroDetails.deathsAvg
        gamesPlayedNum.text = heroDetails.gamesPlayed
        eliminationsNum.text = heroDetails.elim
        elimAvgNum.text = heroDetails.elimAvg
        elimMostGameNum.text = heroDetails.elimMostGame
        elimMostLifeNum.text = heroDetails.elimMostLife
        elimPerLifeNum.text = heroDetails.elimPerLife
        finalBlowsNum.text = heroDetails.finalBlows
        finalBlowsAvgNum.text = heroDetails.fBAvg
        mostFBinGameNum.text = heroDetails.fbMostGame
        objKillsNum.text = heroDetails.objKills
        objKillsAvgNum.text = heroDetails.objKillsAvg
        objKillsMostGameNum.text = heroDetails.objKillsMostGame
        objTimeNum.text = heroDetails.objTime
        objTimeAvgNum.text = heroDetails.objTimeAvg
        objTimeMostGameNum.text = heroDetails.objTimeMostGame
        soloKillsNum.text = heroDetails.soloKills
        soloKillsAvgNum.text = heroDetails.soloKillsAvg
        soloKillsMostGameNum.text = heroDetails.soloKillsMostGame
        timeSpentonFireNum.text = heroDetails.timeSpentOnFire
        
        heroPortrait.sd_setImageWithURL(NSURL(string: heroDetails.heroImage))
        
        /*
         * Circular UIImageView
         **/
        self.heroPortrait.layer.cornerRadius = 10.0
        self.heroPortrait.clipsToBounds = true;
        
        /**
         * Border
         **/
        self.heroPortrait.layer.borderWidth = 3.0
        self.heroPortrait.layer.borderColor = UIColor.blackColor().CGColor
        
        SVProgressHUD.dismiss()
        
    }
}