//
//  JBChatDelegate.h
//  Jabber Client
//
//  Created by ADAMS David on 05/07/2015.
//  Copyright (c) 2015 ADAMS David. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol JBChatDelegate

-(void) newAmiEnLigne:(NSString *) buddyName;
-(void) amiHorsLigne:(NSString *) buddyName;
-(void) didDisconect;

@end