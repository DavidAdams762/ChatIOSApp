//
//  JBLoginViewController.h
//  Jabber Client
//
//  Created by ADAMS David on 03/07/2015.
//  Copyright (c) 2015 ADAMS David. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BuddyViewController.h"
@interface JBLoginViewController : UIViewController {
    UITextField *loginField;
    UITextField *passwordField;
}

@property (nonatomic, retain) IBOutlet UITextField *loginField;
@property (nonatomic, retain) IBOutlet UITextField *passwordField;

- (IBAction) login;
- (IBAction) hideLogin;

@end
