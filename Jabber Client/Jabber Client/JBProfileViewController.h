//
//  JBProfileViewController.h
//  Jabber Client
//
//  Created by ADAMS David on 14/07/2015.
//  Copyright (c) 2015 ADAMS David. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMPPFramework.h"
#import "JabberClientAppDelegate.h"
#import "JBLoginViewController.h"

@interface JBProfileViewController : UIViewController {
    
    UITextField *textFieldName;
    UITextField *textFieldPrenom;
    UITextField *textFieldAge;
    IBOutlet UILabel *usernameLabel;
    UIButton *enregistrer;
    NSString *strUsername;
}

@property (nonatomic, retain) IBOutlet UITextField *textFieldName;
@property (nonatomic, retain) IBOutlet UITextField *textFieldAge;
@property (nonatomic, retain) IBOutlet UITextField *textFieldPrenom;
@property(retain) IBOutlet UIButton *enregistrer;

@property (nonatomic, retain) NSString *strUsername;
- (id) initWithUser:(NSString *) userName;

-(IBAction) enregistrementProfile;
-(IBAction) retour;
- (IBAction) seDeconnecter;
@end