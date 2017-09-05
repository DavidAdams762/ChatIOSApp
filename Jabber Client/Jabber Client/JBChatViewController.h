//
//  JBLoginViewController.h
//  Jabber Client
//
//  Created by ADAMS David on 03/07/2015.
//  Copyright (c) 2015 ADAMS David. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JabberClientAppDelegate.h"
#import "JBProfileViewController.h"

@interface JBChatViewController : UIViewController <UITableViewDelegate, UITableViewDataSource,JBMessageDelegate> {
    UITextField* messageField;
    NSString* chatWithUser;
    UITableView* tView;
    NSMutableArray *messages;
    
    UIButton *profile;
    
}

@property (nonatomic, retain) IBOutlet UITextField *messageField;
@property (nonatomic, retain) NSString *chatWithUser;
@property (nonatomic, retain) IBOutlet UITableView *tView;
@property(retain) IBOutlet UIButton *profile;

- (id) initWithUser:(NSString *) userName;
- (IBAction) sendMessage;
- (IBAction) closeChat;
- (IBAction) deleteHistory;
- (IBAction) showProfile;

@end
