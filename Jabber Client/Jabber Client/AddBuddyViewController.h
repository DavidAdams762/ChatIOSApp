//
//  AddBuddyViewController.h
//  Jabber Client
//
//  Created by ADAMS David on 14/07/2015.
//  Copyright (c) 2015 ADAMS David. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMPPFramework.h"
#import "JabberClientAppDelegate.h"

@interface AddBuddyViewController : UIViewController {
    UITextField *textFieldIdFriend;
    UITextField *textRemoveFieldFriend;
}
@property (nonatomic, retain) IBOutlet UITextField *textFieldIdFriend;
@property (nonatomic, retain) IBOutlet UITextField *textRemoveFieldFriend;

- (IBAction) sendInvite;
- (IBAction) closeInvite;

- (IBAction) sendUnsub;
@end