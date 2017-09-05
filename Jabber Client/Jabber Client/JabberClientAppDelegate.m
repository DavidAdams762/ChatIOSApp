//
//  JBLoginViewController.m
//  Jabber Client
//
//  Created by ADAMS David on 03/07/2015.
//  Copyright (c) 2015 ADAMS David. All rights reserved.
//

#import "JabberClientAppDelegate.h"

@interface JabberClientAppDelegate()

- (void) setupStream;
- (void) goOnline;
- (void) goOffline;

@end

@implementation JabberClientAppDelegate


@synthesize _chatDelegate, _messageDelegate, xmppStream, window, viewController;


-(void) setupStream {
    xmppStream = [[XMPPStream alloc] init];
    [xmppStream addDelegate:self delegateQueue:dispatch_get_main_queue()];
}

-(void) goOnline {
    XMPPPresence *presence = [XMPPPresence presence];
    [[self xmppStream] sendElement:presence];
}

-(void) goOffline {
    XMPPPresence *presence = [XMPPPresence presenceWithType:@"unavailable"];
    [[self xmppStream] sendElement:presence];
}

-(BOOL) connect {
    
    [self setupStream];
    
    NSString *jabberID = [[NSUserDefaults standardUserDefaults] stringForKey:@"userID"];
    NSString *myPassword = [[NSUserDefaults standardUserDefaults] stringForKey:@"userPassword"];
    NSLog(@"%@",jabberID);
    if(![xmppStream isDisconnected]) {
        NSLog(@"me suis arrete la");
        return YES;
    }
    if (jabberID == nil || myPassword == nil) {
        return NO;
    }
    
    [xmppStream setMyJID:[XMPPJID jidWithString:jabberID]];
    password = myPassword;
    
    NSError *error = nil;
    if (![xmppStream connectWithTimeout:10 error:&error]){
        UIAlertView *alerteView = [[UIAlertView alloc] initWithTitle:@"Error"
                                                             message:[NSString stringWithFormat:@"Can't connect to server %@", [error localizedDescription]]
                                                            delegate:nil
                                                   cancelButtonTitle:@"Ok"
                                                   otherButtonTitles:nil];
        [alerteView show];
        
        return NO;
    }
    return YES;
}

- (void) disconnect {
    [self goOffline];
    [xmppStream disconnect];
}

- (void) applicationWillResignActive:(UIApplication *) application{
    [self disconnect];
}
- (void) applicationDidBecomeActive:(UIApplication *) application{
    [self connect];
}

#pragma mark -
#pragma mark XMPP delegates

- (void)xmppStreamDidConnect:(XMPPStream *)sender {
    isOpen = YES;
    NSError *error = nil;
    [[self xmppStream] authenticateWithPassword:password error:&error];
}

- (void)xmppStreamDidAuthenticate:(XMPPStream *)sender {
    [self goOnline];
}


- (void)xmppStream:(XMPPStream *)sender didReceiveMessage:(XMPPMessage *)message {
    NSString *msg = [[message elementForName:@"body"] stringValue];
    NSString *from = [[message attributeForName:@"from"] stringValue];
    if(msg){
        NSMutableDictionary *m = [[NSMutableDictionary alloc] init];
        [m setObject:msg forKey:@"msg"];
        [m setObject:from forKey:@"sender"];
        
        [_messageDelegate newMessageRecu:m];
    }
}

- (void)xmppStream:(XMPPStream *)sender didReceivePresence:(XMPPPresence *)presence {
    NSString *presenceType = [presence type];
    NSString *myUsername = [[sender myJID] user];
    NSString *presenceFromUser = [[presence from] user];
    
    if (![presenceFromUser isEqualToString:myUsername]) {
        if([presenceType isEqualToString:@"available"]) {
            [_chatDelegate newAmiEnLigne:[NSString stringWithFormat:@"%@@%@", presenceFromUser, @"etna.com"]];
        } else if ([presenceType isEqualToString:@"unavailable"]){
            [_chatDelegate amiHorsLigne:[NSString stringWithFormat:@"%@@%@", presenceFromUser, @"etna.com"]];
        }
    }
    
}
-(void) dealloc {
    [xmppStream removeDelegate:self];
    
    [xmppStream disconnect];
    
}

@end
