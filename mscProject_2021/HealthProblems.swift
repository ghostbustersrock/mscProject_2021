//
//  HealthProblems.swift
//  mscProject_2021
//
//  Created by Luca Santarelli on 30/05/21.
//

import UIKit

class HealthProblems: UIViewController {

    let usefulFunctions = UsefulFunctions()
    
    func displayDefinition(displayTitle: String, msg: String) {
        let defAction = UIAlertController(title: displayTitle, message: msg, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Ok", style: .cancel) {
            alertAction in
        }
        
        defAction.addAction(okAction)
        self.present(defAction, animated: true, completion: nil)
    }
    
    @IBAction func completeList(_ sender: Any) {
        usefulFunctions.openSite(siteName: "https://www.mind.org.uk/information-support/types-of-mental-health-problems/")
    }
    
    @IBAction func anger(_ sender: Any) {
        displayDefinition(displayTitle: "Anger", msg: "A strong feeling of annoyance, displesure or hostility.")
    }
    
    @IBAction func anxietyPanic(_ sender: Any) {
        displayDefinition(displayTitle: "Anxiety and panic attacks", msg: "Anxiety is felt when we are worried or afraid about things about to happen or we think could happen. Panic attacks are an exaggeration response of our body to danger, stress or excitement.")
    }
    
    
    @IBAction func bipolar(_ sender: Any) {
        displayDefinition(displayTitle: "Bipolar disorder", msg: "A mental health problem  affecting your mood, which consists in feeling different mood states in a distressing and impactful way.")
    }
    
    @IBAction func depression(_ sender: Any) {
        displayDefinition(displayTitle: "Depression", msg: "This is a low mood state lasting for long times and affecting your everyday life. Its mildest form doesn't stop you from leading your normal life, however, it makes everything harder to do. In more severe cases it can be life-threatening, possibly making you feel suicidal.")
    }
    
    @IBAction func ddDisorder(_ sender: Any) {
        displayDefinition(displayTitle: "Dissociation and dissociative disorders", msg: "Dossociation is a feeling of being disconnected from yourself and the world surrounding you. It may seem as if you're detached from your body. Dissociative disorders is when dissociation is experienced regularly and can severely impact your life.")
    }
    
    @IBAction func drugs(_ sender: Any) {
        displayDefinition(displayTitle: "Drugs - recreational drugs and alcohol", msg: "Recreational drugs used to give pleasurable experience, help feel better, to see what it feels like, etc. Drugs and alcohol have a kind of effect on your mental health, affecting how you feel and see things, your mood and behaviour.")
    }
    
    
    @IBAction func eatingIssue(_ sender: Any) {
        displayDefinition(displayTitle: "Eating problems", msg: "An eating problem is any relationship a person finds difficult with food. Many people will think to be over or underweight, possibly developing a range of psychological disorders characterized by abnormal or disturbed eating habits.")
    }
    
    @IBAction func hearingVoices(_ sender: Any) {
        displayDefinition(displayTitle: "Hearing voices", msg: "When you hear a voice when no-one is present with you, or which others with you cannot hear. Some people don't mind their voices or simply find them irritating or distracting, while others find them frightening or intrusive. It's a common misconception to think that hearing voices is related to having a mental health problem. However, lots of people hear voices and many of them are not mentally unwell. It’s a relatively common human experience.")
    }
    
    @IBAction func loneliness(_ sender: Any) {
        displayDefinition(displayTitle: "Loneliness", msg: "Loneliness is the feeling when a person's need to have social contact and relationship isn't met. People can choose to be alone and live happily with not much human contact, while others may find this a negative experience. Not feeling understood or cared by people (or family) can lead to feeling lonely.")
    }
    
    @IBAction func ocDisorder(_ sender: Any) {
        displayDefinition(displayTitle: "Obsessive compulsive disorder", msg: "When a person feels forced to perform certain stereotyped actions repeatedly to alleviate persistent fears or intrusive thoughts, typically resulting in severe disruption of daily life.")
    }
    
    @IBAction func panicAttacks(_ sender: Any) {
        displayDefinition(displayTitle: "Panic attacks", msg: "Panic attacks are an exaggeration response of our body to danger, stress or excitement.")
    }
    
    @IBAction func paranoia(_ sender: Any) {
        displayDefinition(displayTitle: "Paranoia", msg: "The thought and feeling of being threatened in some way, although there's no or little evidence, of it. Paranoid thoughts can also be described as delusions or exaggerated suspicions againts you.")
    }
    
    @IBAction func personalityDisorder(_ sender: Any) {
        displayDefinition(displayTitle: "Personality disorders", msg: "The experience of finding it significantly difficult in how you relate yourself with others and having problems coping with it on a day to day basis.")
    }
    
    @IBAction func phobias(_ sender: Any) {
        displayDefinition(displayTitle: "Phobias", msg: "This is an anxiety disorder of extreme fear or anxiety, triggered by either a particular situation or object.")
    }
    
    @IBAction func ptsd(_ sender: Any) {
        displayDefinition(displayTitle: "Post-traumatic stress disorder (PTSD)", msg: "A mental health problem which can be developed after a traumatic experience.")
    }
    
    @IBAction func schizophrenia(_ sender: Any) {
        displayDefinition(displayTitle: "Schizophrenia", msg: "A complicated long term mental health problem involving a breakdown in the relation between thought, emotion, and behaviour, leading to faulty perception, inappropriate actions and feelings, withdrawal from reality and personal relationships into fantasy and delusion.")
    }
    
    @IBAction func selfHarm(_ sender: Any) {
        displayDefinition(displayTitle: "Self-harm", msg: "It is a way to deal with very difficult feelings, painful memories or overwhelming situations and experiences.")
    }
    
    @IBAction func sleepProblems(_ sender: Any) {
        displayDefinition(displayTitle: "Sleeping problems", msg: "Sleep and mental health have a close relationship. The presence of mental health problmes can affect how well you sleep. Poor sleep can have a negative impact on mental health.")
    }
    
    @IBAction func stress(_ sender: Any) {
        displayDefinition(displayTitle: "Stress", msg: "This is a state of mental or emotional strain or tension resulting from adverse or demanding circumstances.")
    }
    
    @IBAction func suicidalFeelings(_ sender: Any) {
        displayDefinition(displayTitle: "Suicidal feelings", msg: "These consists in having abstract thoughts about ending your life or feeling that people are better of without you. It can also mean thinking about suicidal methods or making plans to take your own life. Feeling suicidal can lead to being scared or confused, as well as overwhelmed, by these feelings.")
    }
    
    @IBAction func trauma(_ sender: Any) {
        displayDefinition(displayTitle: "Trauma", msg: "This is when a person goes through very stressful, frightening or distressing events. Traumatic events can occur at any age and can cause long lasting harm. Each person has a different reaction to trauma, meaning effects can be noticed either quickly or after a long time.")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}



class SelfCare: UIViewController {
    
    let usefulFunctions = UsefulFunctions()
    
    @IBAction func linkt_to_site(_ sender: Any) {
        usefulFunctions.openSite(siteName: "https://www.mind.org.uk/information-support/types-of-mental-health-problems/mental-health-problems-introduction/self-care/")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Put any launch code here.
    }
}


class Treatments: UIViewController {
    
    let usefulFunctions = UsefulFunctions()
    
    @IBAction func treatment_link(_ sender: Any) {
        usefulFunctions.openSite(siteName: "https://www.mind.org.uk/information-support/types-of-mental-health-problems/mental-health-problems-introduction/treatment-options/")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Put any launch code here.
    }
}
