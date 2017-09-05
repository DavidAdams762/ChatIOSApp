//
//  JBLoginViewController.m
//  Jabber Client
//
//  Created by ADAMS David on 03/07/2015.
//  Copyright (c) 2015 ADAMS David. All rights reserved.
//

#import "JBChatViewController.h"

@implementation JBChatViewController


@synthesize messageField, chatWithUser, tView, profile;

- (void) newMessageRecu: (NSDictionary *) messageContent {
    //NSString *m = [messageContent objectForKey:@"msg"];
    [messages addObject:messageContent];
    
    NSError *error = nil;
    NSStringEncoding encoding;
    NSString *conversation = [NSString stringWithContentsOfFile:[NSString stringWithFormat:@"%@/history/%@-With-%@.txt",NSHomeDirectory(),[[NSUserDefaults standardUserDefaults] stringForKey:@"userID"], chatWithUser] usedEncoding:&encoding error:&error];
    if (error){
        NSLog(@"ERROR with file: %@", error);
    }
    conversation = [conversation stringByAppendingString:[NSString stringWithFormat:@"%@;sepAratOr;%@;nEwLinE;", [messageContent objectForKey:@"msg"], [messageContent objectForKey:@"sender"]]];
    [conversation writeToFile:[NSString stringWithFormat:@"%@/history/%@-With-%@.txt",NSHomeDirectory(),[[NSUserDefaults standardUserDefaults] stringForKey:@"userID"], chatWithUser]  atomically:YES encoding:NSUnicodeStringEncoding error:&error];

//    NSFileHandle *fileHandle = [NSFileHandle fileHandleForReadingAtPath:[NSString stringWithFormat:@"/Users/adamsdavid/piscine/iOsApp/history/%@-With-%@.txt",[[NSUserDefaults standardUserDefaults] stringForKey:@"userID"], chatWithUser]];
//    [fileHandle seekToEndOfFile];
//    [fileHandle writeData:[[NSString stringWithFormat:@"%@;%@\n", [messageContent objectForKey:@"msg"], [messageContent objectForKey:@"sender"]] dataUsingEncoding:NSUTF8StringEncoding]];
//    [fileHandle closeFile];

    [self.tView reloadData];
    
    NSIndexPath *topIndexPath = [NSIndexPath indexPathForRow:messages.count-1 inSection:0];
    [self.tView scrollToRowAtIndexPath:topIndexPath atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
}


- (void) viewDidLoad {
    
    [super viewDidLoad];
    self.tView.delegate = self;
    self.tView.dataSource = self;
    JabberClientAppDelegate *del = [self appDelegate];
    del._messageDelegate = self;
    [self.profile setTitle:@"Profile" forState:UIControlStateNormal];
    [self.messageField becomeFirstResponder];
    [self.tView reloadData];
}

- (IBAction)closeChat {
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(IBAction)showProfile{
    JBProfileViewController *profileController = [[self.storyboard instantiateViewControllerWithIdentifier:@"showProfile"] initWithUser:chatWithUser];
    [self presentViewController:profileController animated:YES completion:nil];
    
}

-(IBAction)deleteHistory{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Supprimer l'historique ?" message:@"Voulez vous supprimer definitivement l'historique pour cette conversation" delegate:self cancelButtonTitle:@"Non" otherButtonTitles:@"Oui", nil];
    [alert show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSFileManager *fileManager;
    fileManager = [NSFileManager defaultManager];
    switch (buttonIndex) {
        case 0:
            break;
        case 1:
            if([fileManager fileExistsAtPath:[NSString stringWithFormat:@"%@/history/%@-With-%@.txt",NSHomeDirectory(),[[NSUserDefaults standardUserDefaults] stringForKey:@"userID"], chatWithUser]] == YES ){
                if ([fileManager removeItemAtPath:[NSString stringWithFormat:@"%@/history/%@-With-%@.txt",NSHomeDirectory(),[[NSUserDefaults standardUserDefaults] stringForKey:@"userID"], chatWithUser] error:NULL]) {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Suppression historique" message:@"Contenu supprimé" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
                    [alert show];
                    [messages removeAllObjects];
                    [self.tView reloadData];
                }
            }
            break;
        default:
            break;
    }
}

- (IBAction)sendMessage {
    NSString *messageStr = self.messageField.text;
    
    if ([messageStr length] > 0) {
        
        NSXMLElement *body = [NSXMLElement elementWithName:@"body"];
        [body setStringValue:messageStr];
        
        NSXMLElement *message = [NSXMLElement elementWithName:@"message"];
        [message addAttributeWithName:@"type" stringValue:@"chat"];
        [message addAttributeWithName:@"to" stringValue:chatWithUser];
        [message addChild:body];
        
        [self.xmppStream sendElement:message];
        
        self.messageField.text = @"";
        //NSString *m = [NSString stringWithFormat:@"%@:%@", messageStr, @"you"];
        
        NSMutableDictionary *s = [[NSMutableDictionary alloc] init];
        [s setObject:messageStr forKey:@"msg"];
        [s setObject:@"you" forKey:@"sender"];
        
        //Historique de conversation
        NSError *error = nil;
        NSStringEncoding encoding;
        NSString *conversation = [NSString stringWithContentsOfFile:[NSString stringWithFormat:@"%@/history/%@-With-%@.txt",NSHomeDirectory(),[[NSUserDefaults standardUserDefaults] stringForKey:@"userID"], chatWithUser] usedEncoding:&encoding error:&error];
        if (error){
            NSLog(@"ERROR with file: %@", error);
        }
        conversation = [conversation stringByAppendingString:[NSString stringWithFormat:@"%@;sepAratOr;you;nEwLinE;", messageStr]];
        [conversation writeToFile:[NSString stringWithFormat:@"%@/history/%@-With-%@.txt",NSHomeDirectory(),[[NSUserDefaults standardUserDefaults] stringForKey:@"userID"], chatWithUser]  atomically:YES encoding:NSUnicodeStringEncoding error:&error];
        
        [messages addObject:s];
        [self.tView reloadData];

    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *s = (NSDictionary* ) [messages objectAtIndex:indexPath.row];
    static NSString *CellIdentifier = @"MessageCellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    cell.textLabel.text = [s objectForKey:@"msg"];
    cell.detailTextLabel.text = [s objectForKey:@"sender"];
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.userInteractionEnabled = NO;
    
    return cell;
}

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section {
    return [messages count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView*) tableView{
    return 1;
}

-(JabberClientAppDelegate*) appDelegate {
    return (JabberClientAppDelegate*) [[UIApplication sharedApplication] delegate];
}

-(XMPPStream *) xmppStream {
    return [[self appDelegate] xmppStream];
}
-(id) initWithUser:(NSString *)userName {
    //if(self = [super init]){
    messages = [[NSMutableArray alloc] init];
    NSFileManager *fileManager;
    fileManager = [NSFileManager defaultManager];
    if(![fileManager fileExistsAtPath:[NSString stringWithFormat:@"%@/history",NSHomeDirectory()]]){
        NSURL *newDir = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/history",NSHomeDirectory()]];
        [fileManager createDirectoryAtURL: newDir withIntermediateDirectories:YES attributes: nil error:nil];
    }
    if([fileManager fileExistsAtPath:[NSString stringWithFormat:@"%@/history/%@-With-%@.txt",NSHomeDirectory(),[[NSUserDefaults standardUserDefaults] stringForKey:@"userID"], userName]] == YES ){
        NSError *error = nil;
        NSStringEncoding encoding;
        NSString *conversation = [NSString stringWithContentsOfFile:[NSString stringWithFormat:@"%@/history/%@-With-%@.txt",NSHomeDirectory(),[[NSUserDefaults standardUserDefaults] stringForKey:@"userID"], userName] usedEncoding:&encoding error:&error];
        if (error){
            NSLog(@"ERROR with file: %@", error);
        }
        NSArray * lignes = [conversation componentsSeparatedByString:@";nEwLinE;"];
        NSArray *messageCourant;
        NSMutableDictionary *s;
        for (NSString *item in lignes) {
            messageCourant = [item componentsSeparatedByString:@";sepAratOr;"];
            if(![item isEqual: @""]){
                s = [[NSMutableDictionary alloc] init];
                [s setObject:messageCourant[0] forKey:@"msg"];
                [s setObject:messageCourant[1] forKey:@"sender"];
                [messages addObject:s];
            }
        }
    }
    else {
        [fileManager createFileAtPath:[NSString stringWithFormat:@"%@/history/%@-With-%@.txt",NSHomeDirectory(),[[NSUserDefaults standardUserDefaults] stringForKey:@"userID"], userName] contents:nil attributes:nil];
    }
    chatWithUser = userName;
    //}
    
    return self;
}
@end