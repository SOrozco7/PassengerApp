//
//  ProfileViewController.swift
//  PassengerApp
//
//  Created by Comonfort on 4/15/18.
//  Copyright © 2018 Comonfort. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    //Outlets for the switches
    @IBOutlet weak var notificationsSwitch: UISwitch!
    @IBOutlet weak var vibrationSwitch: UISwitch!
    @IBOutlet weak var soundSwitch: UISwitch!
    @IBOutlet weak var notificationAnticipationMinutes: UILabel!
    @IBOutlet weak var NotificationAnticipationMinutesStepper: UIStepper!
    
    /**
    *   Function that toggles the value of the notifications
    *   switch and updates the value in the UserDefaults.
    */
    @IBAction func toggleNotifications(_ sender: UISwitch) {
        
        let notificationsCurrValue = sender.isOn
        UserConfiguration.setConfiguration(key: UserConfiguration.NOTIFICATIONS_USER_DEFAULTS_KEY, value: notificationsCurrValue)
    }
    
    /**
     *  Function that toggles the value of the vibration
     *  switch and updates the value in the UserDefaults.
     */
    @IBAction func toggleVibration(_ sender: UISwitch) {
        
        let vibrationCurrValue = sender.isOn
        UserConfiguration.setConfiguration(key: UserConfiguration.VIBRATION_USER_DEFAULTS_KEY, value: vibrationCurrValue)
    }
    
    /**
     *  Function that toggles the value of the sound
     *  switch and updates the value in the UserDefaults.
     */
    @IBAction func toggleSound(_ sender: UISwitch) {
        
        let soundCurrValue = sender.isOn
        UserConfiguration.setConfiguration(key: UserConfiguration.SOUND_USER_DEFAULTS_KEY, value: soundCurrValue)
    }

    @IBAction func editNotificationAnticipationMinutes(_ sender: UIStepper) {
        
        //Get the new value from the stepper
        let newNotificationAnticipationMinutes = Int(sender.value).description
        //Assign the new value to the label
        notificationAnticipationMinutes.text = newNotificationAnticipationMinutes
        //Save the new value in the UserDefaults
        UserConfiguration.setConfiguration(key: UserConfiguration.NOTIFICATION_ANTICIPATION_MINUTES_KEY, value: newNotificationAnticipationMinutes)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // Do any additional setup after loading the view.
        
        //Initialize the config variables
        initializeConfigVariable(configVariableKey: UserConfiguration.NOTIFICATIONS_USER_DEFAULTS_KEY, value: UserConfiguration.DEFAULT_SWITCH_VALUE) //Boolean
        initializeConfigVariable(configVariableKey: UserConfiguration.VIBRATION_USER_DEFAULTS_KEY, value: UserConfiguration.DEFAULT_SWITCH_VALUE) //Boolean
        initializeConfigVariable(configVariableKey: UserConfiguration.SOUND_USER_DEFAULTS_KEY, value: UserConfiguration.DEFAULT_SWITCH_VALUE) //Boolean
        initializeConfigVariable(configVariableKey: UserConfiguration.NOTIFICATION_ANTICIPATION_MINUTES_KEY, value: (UserConfiguration.DEFAULT_NOTIFICATION_ANTICIPATION_MINUTES_MIN_VALUE + UserConfiguration.DEFAULT_NOTIFICATION_ANTICIPATION_MINUTES_MAX_VALUE)/2) //Int
        
        print(UserDefaults.standard.integer(forKey: UserConfiguration.NOTIFICATION_ANTICIPATION_MINUTES_KEY))
        
        //Set the switches into their correct values according to the config variables
        notificationsSwitch.setOn(UserConfiguration.getConfiguration(key: UserConfiguration.NOTIFICATIONS_USER_DEFAULTS_KEY) as! Bool, animated: false)
        vibrationSwitch.setOn(UserConfiguration.getConfiguration(key: UserConfiguration.VIBRATION_USER_DEFAULTS_KEY) as! Bool, animated: false)
        soundSwitch.setOn(UserConfiguration.getConfiguration(key: UserConfiguration.SOUND_USER_DEFAULTS_KEY) as! Bool, animated: false)
        
        //Set the stepper to its correct value according to the config variable
        NotificationAnticipationMinutesStepper.value = Double(UserConfiguration.getConfiguration(key: UserConfiguration.NOTIFICATION_ANTICIPATION_MINUTES_KEY) as! Int)
    
        //Set the stepper configuration
        NotificationAnticipationMinutesStepper.wraps = true
        NotificationAnticipationMinutesStepper.autorepeat = true
        NotificationAnticipationMinutesStepper.minimumValue = Double(UserConfiguration.DEFAULT_NOTIFICATION_ANTICIPATION_MINUTES_MIN_VALUE)
        NotificationAnticipationMinutesStepper.maximumValue = Double(UserConfiguration.DEFAULT_NOTIFICATION_ANTICIPATION_MINUTES_MAX_VALUE)
    }
    
    /**
     *  Function to initialize the config variables
     *
     *  @param configVariableKey a string corresponding to the key of the
     *  configuration variable
     *  @param value the value to be set for that key
     */
    func initializeConfigVariable(configVariableKey: String, value: Any) -> Void {
        
        //If the key does not exist yet
        if(!isKeyPresentInUserDefaults(key: configVariableKey)) {
            
            //Set it to the given value
            UserConfiguration.setConfiguration(key: configVariableKey, value: value)
        }
    }
    
    /**
     *  Function to determine whether a given key is present in the
     *  UserDefaults
     *
     *  @param key the name of the key whose existence in the UserDefaults
     *  is to be checked
     *  @returns True if the key exists in the UserDefaults. Else, false
     */
    func isKeyPresentInUserDefaults(key: String) -> Bool {
        
        return UserDefaults.standard.object(forKey: key) != nil
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
