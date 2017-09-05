//
//  AppDelegate.h
//  Jabber Client
//
//  Created by ADAMS David on 28/06/2015.
//  Copyright (c) 2015 ADAMS David. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMPPFramework.h"
#import "JBChatDelegate.h"
#import "JBMessageDelegate.h"

@class BuddyViewController;
@interface AppDelegate : UIResponder <UIApplicationDelegate> {
    
    UIWindow *window;
    BuddyViewController* viewController;
    
    XMPPStream *xmppStream;
    NSString* password;
    BOOL isOpen;
    __unsafe_unretained NSObject <JBChatDelegate> *_chatDelegate;
    __unsafe_unretained NSObject <JBMessageDelegate> *_messageDelegate;
}

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, retain) IBOutlet BuddyViewController *viewController;

@property (nonatomic, assign) id _chatDelegate;
@property (nonatomic, assign) id _messageDelegate;

@property (nonatomic, readonly) XMPPStream *xmppStream;

- (BOOL) connect;
- (void) disconnect;

@end

