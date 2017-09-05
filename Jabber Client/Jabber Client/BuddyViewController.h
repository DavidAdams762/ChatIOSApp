//
//  ViewController.h
//  Jabber Client
//
//  Created by ADAMS David on 28/06/2015.
//  Copyright (c) 2015 ADAMS David. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JabberClientAppDelegate.h"
#import "JBLoginViewController.h"
#import "JBChatViewController.h"
#import "JBChatDelegate.h"
#import "AddBuddyViewController.h"
#import "JBProfileViewController.h"

@interface BuddyViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, JBChatDelegate> {
    UITableView *tabView;
    UITableView *offlineTabView;
    NSMutableArray *onlineBuddies;
    NSMutableArray *offlineBuddies;
    
}

@property (nonatomic, retain) IBOutlet UITableView *tabView;
@property (nonatomic, retain) IBOutlet UITableView *offlineTabView;

- (IBAction) showProfile;
- (IBAction) showInvite;
@end

