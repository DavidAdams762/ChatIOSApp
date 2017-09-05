//
//  AddBuddyViewController.m
//  Jabber Client
//
//  Created by ADAMS David on 14/07/2015.
//  Copyright (c) 2015 ADAMS David. All rights reserved.
//

#import "AddBuddyViewController.h"

@implementation AddBuddyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.textFieldIdFriend becomeFirstResponder];
    // Do any additional setup after loading the view, typically from a nib.
}
@synthesize textFieldIdFriend, textRemoveFieldFriend;

- (IBAction)sendInvite{
    if ([self.textFieldIdFriend.text length] > 0){
        NSString * compte = self.textFieldIdFriend.text;
        NSXMLElement *invite = [NSXMLElement elementWithName:@"presence"];
        [invite addAttributeWithName:@"to" stringValue:compte];
        [invite addAttributeWithName:@"type" stringValue:@"subscribe"];
        [self.xmppStream sendElement:invite];
        
        self.textFieldIdFriend.text = @"";
    }
    
}

-(IBAction) sendUnsub{
    if ([self.textRemoveFieldFriend.text length] > 0){
        NSString* compte = self.textRemoveFieldFriend.text;
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Supprimer de la liste des contact ?" message:[NSString stringWithFormat:@"Voulez vous supprimer %@ de la liste de vos contact ?", compte] delegate:self cancelButtonTitle:@"Non" otherButtonTitles:@"Oui", nil];
        [alert show];
    }
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (buttonIndex) {
        case 0:
            break;
        case 1:{
            NSString* compte = self.textRemoveFieldFriend.text;
            NSXMLElement *unsub = [NSXMLElement elementWithName:@"presence"];
            [unsub addAttributeWithName:@"to" stringValue:compte];
            [unsub addAttributeWithName:@"from" stringValue:[[NSUserDefaults standardUserDefaults] stringForKey:@"userID"]];
            [unsub addAttributeWithName:@"type" stringValue:@"unsubscribe"];
            
            [self.xmppStream sendElement:unsub];
            
            self.textRemoveFieldFriend.text = @"";
            break;}
        default:
            break;
    }
}
-(JabberClientAppDelegate*) appDelegate {
    return (JabberClientAppDelegate*) [[UIApplication sharedApplication] delegate];
}

-(XMPPStream *) xmppStream {
    return [[self appDelegate] xmppStream];
}
-(IBAction)closeInvite{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end