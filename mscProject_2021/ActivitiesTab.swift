//
//  ActivitiesTab.swift
//  mscProject_2021
//
//  Created by Luca Santarelli on 11/07/21.
//

import UIKit

class ActivitiesTab: UIViewController {
    
    var imageAc:UIImage?
    var nameAc:String?
    var descriptionAc:String?
    
//    @IBOutlet var activitiesButton: [UIButton]!
    
    @IBOutlet var activitiesButton: [UIButton]!
    
    
    
    
    @IBAction func walkingFunc(_ sender: Any) {
        let nameActivity = activitiesButton[0].currentTitle!
        let imageActivity = UIImage(named: "walking_ill")!
        let descriptionActivity = "Walking can be helpful to distract yourself from something happening. Go outside, have a walk for 30 minutes or more and try to relax as much as possible. Even if you are studying or working and are feeling stressed, stand up and walk around your workplace for a bit. Even a couple of minutes of walking can help improve your emotional wellbeing."
        toDisplayActivityInfo(image: imageActivity, name: nameActivity, description: descriptionActivity)
    }
    
    @IBAction func runningFunc(_ sender: Any) {
        let nameActivity = activitiesButton[1].currentTitle!
        let imageActivity = UIImage(named: "running_ill")!
        let descriptionActivity = "Running can be very helpful to release anxiety and stress. It makes you concentrate only on the running and at the end of it you will feel refreshed. Even 30 minutes of it can help you distract on things that are worrying you. Something I personally do is when feeling angry I try to run as fast as I can to leave all the anger behind me and only stop when I feel I cannot take it anymore and I feel light from the pain and sore of my thoughts. A little scream at the end of it can help to!"
        toDisplayActivityInfo(image: imageActivity, name: nameActivity, description: descriptionActivity)
    }
    
    @IBAction func newSportFunc(_ sender: Any) {
        let nameActivity = activitiesButton[2].currentTitle!
        let imageActivity = UIImage(named: "new_sport_ill")!
        let descriptionActivity = "When feeling bored, unhappy or disatisfied with what you are doing during the day trying new things like a new sport can very much help. It can help you discover happy emotions you thought you did not have, otherwise it will not make you feel anything, but that does not mean you have to stop there, you can keep trying on finding new sports or activities to do and see which one fits you best."
        toDisplayActivityInfo(image: imageActivity, name: nameActivity, description: descriptionActivity)
    }
    
    @IBAction func yogaFunc(_ sender: Any) {
        let nameActivity = activitiesButton[3].currentTitle!
        let imageActivity = UIImage(named: "yoga_ill")!
        let descriptionActivity = "Practicing yoga has many benefits, starting from phsycial ones like body strength. However, yoga has been proved to be a very good physical activity to help improve sleep, relaxation, body energy and emotional wellbeing. Managing stress and promoting self care are other factors yoga helps improve. Yoga can be done anywhere, at home, in a park and all you need is a computer and YouTube. Otherwise classes are also available to take which can be more beneficial."
        toDisplayActivityInfo(image: imageActivity, name: nameActivity, description: descriptionActivity)
    }
    
    @IBAction func meditationFunc(_ sender: Any) {
        let nameActivity = activitiesButton[4].currentTitle!
        let imageActivity = UIImage(named: "meditation_ill")!
        let descriptionActivity = "Meditation with its breathing and mind exercises can be very useful to reduce anxiety and stress and improve your mental health. It does not require too long, even 15 to 30 minutes every day can show great improvements. It can also be done anywhere, from the comfort of your house to a park, surrounded by nature."
        toDisplayActivityInfo(image: imageActivity, name: nameActivity, description: descriptionActivity)
    }
    
    @IBAction func dancingFunc(_ sender: Any) {
        let nameActivity = activitiesButton[5].currentTitle!
        let imageActivity = UIImage(named: "dancing_ill")!
        let descriptionActivity = "Just like running or sports, dancing can be very beneficial in terms of release negative energy from your body. It also helps you keep your mind off of things because it has you solely concentrate on your body's movements coordination. You do not have to specifically take private dance classes, you can also easily put music on, with or without headphones, and start dancing to the music however you wish to do. I personally thing it is a great way to let go of yourself and enjoy everything of it, whether you are or are not so good at it."
        toDisplayActivityInfo(image: imageActivity, name: nameActivity, description: descriptionActivity)
    }
    
    @IBAction func singingFunc(_ sender: Any) {
        let nameActivity = activitiesButton[6].currentTitle!
        let imageActivity = UIImage(named: "singing_ill")!
        let descriptionActivity = "Signing, like shouting, can have its benefits of releasing anger or tension within you. Putting music on and signing as loud as you can to the lyrics will make you realise sometimes how light it can make you feel. It can have all the negative within you be kicked out simply by signing along to a song, making you feel relaxed but also happy at the end for the great performance and relief you just had."
        toDisplayActivityInfo(image: imageActivity, name: nameActivity, description: descriptionActivity)
    }
    
    @IBAction func musicFunc(_ sender: Any) {
        let nameActivity = activitiesButton[7].currentTitle!
        let imageActivity = UIImage(named: "music_ill")!
        let descriptionActivity = "Listening to music is a great way to embrace your emotions. Whether the music is joyful or sad it can help improve or reduce those emotions as you are embracing what you are feeling. It is good to let your feelings out and use music as a mediator for it."
        toDisplayActivityInfo(image: imageActivity, name: nameActivity, description: descriptionActivity)
    }
    
    @IBAction func journalFunc(_ sender: Any) {
        let nameActivity = activitiesButton[8].currentTitle!
        let imageActivity = UIImage(named: "journal_ill")!
        let descriptionActivity = "Journal writing can consist of any type of writing. For example, you can write about good or bad things that happened to you during the day, what you did, what you saw, or more completely write about your whole day and outlining moments that made you feel a special way. It is a great way to release yourself from negative emotions if for example explicit release, like shouting, dancing or more, is not your thing. You can see it as an analogy of the negative emotions flowing away from your body, through the pen and on to the words you wrote, keeping them safe and away from you."
        toDisplayActivityInfo(image: imageActivity, name: nameActivity, description: descriptionActivity)
    }
    
    @IBAction func aloneTimeFunc(_ sender: Any) {
        let nameActivity = activitiesButton[9].currentTitle!
        let imageActivity = UIImage(named: "alone_ill")!
        let descriptionActivity = "An advice counsellors and therapists propose is to be at one with your emotions. When you feel happy feel and be happy, when you are sad act sadly. Even better is to be alone with yourself while doing it, because it will leave you reasoning with your thoughts about things that are going through your head. You might want to talk about this later with someone but it can be very beneficial at first to understand and reason with yourself what you are going through. Spending time with yourself can help you understand new things about yourself you did not know before. It is a great way to get to know you better."
        toDisplayActivityInfo(image: imageActivity, name: nameActivity, description: descriptionActivity)
    }
    
    
    //MARK: WRITE ABOUT PET THERAPY
    @IBAction func petTherapyFunc(_ sender: Any) {
        let nameActivity = activitiesButton[10].currentTitle!
        let imageActivity = UIImage(named: "pet_therapy_ill")!
        let descriptionActivity = "WRITE ABOUT PET THERAPYYYYY"
        toDisplayActivityInfo(image: imageActivity, name: nameActivity, description: descriptionActivity)
    }
    
    
    func toDisplayActivityInfo(image: UIImage, name: String, description: String) {
        imageAc = image
        nameAc = name
        descriptionAc = description
        self.performSegue(withIdentifier: "displayActivity", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "displayActivity" {
            let receiverVC = segue.destination as! ActivityDisplayInfo
            receiverVC.activityImage = imageAc
            receiverVC.activityName = nameAc
            receiverVC.activityDescription = descriptionAc
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}


class ActivityDisplayInfo: UIViewController {
    
    var activityImage:UIImage?
    var activityName:String?
    var activityDescription:String?
    
    @IBOutlet var imageActivity: UIImageView!
    @IBOutlet var nameActivity: UILabel!
    @IBOutlet var descriptionActivity: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageActivity.image = activityImage
        nameActivity.text = activityName
        descriptionActivity.text = activityDescription
    }
}
