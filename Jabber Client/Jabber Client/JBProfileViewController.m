//
//  JBProfileViewController.m
//  Jabber Client
//
//  Created by ADAMS David on 14/07/2015.
//  Copyright (c) 2015 ADAMS David. All rights reserved.
//

#import "JBProfileViewController.h"

@implementation JBProfileViewController

@synthesize textFieldPrenom,textFieldAge,textFieldName, strUsername, enregistrer;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    usernameLabel.text = strUsername;
    if (![strUsername isEqualToString:[[NSUserDefaults standardUserDefaults] stringForKey:@"userID"]]) {
        [self.textFieldName setEnabled:NO];
        [self.textFieldPrenom setEnabled:NO];
        [self.textFieldAge setEnabled:NO];
        [self.enregistrer setHidden:YES];
    }
    NSFileManager *fileManager;
    fileManager = [NSFileManager defaultManager];
    
    if(![fileManager fileExistsAtPath:[NSString stringWithFormat:@"%@/profiles",NSHomeDirectory()]]){
        NSURL *newDir = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/profiles",NSHomeDirectory()]];
        NSError *error = nil;
        [fileManager createDirectoryAtURL: newDir withIntermediateDirectories:YES attributes: nil error:&error];
        if (error) {
            NSLog(@"Something went wrong");
        }
    }
    if([fileManager fileExistsAtPath:[NSString stringWithFormat:@"%@/profiles/%@.txt",NSHomeDirectory(), strUsername]] == YES ){
        NSError *error = nil;
        NSStringEncoding encoding;
        NSString *profile = [NSString stringWithContentsOfFile:[NSString stringWithFormat:@"%@/profiles/%@.txt",NSHomeDirectory(), strUsername] usedEncoding:&encoding error:&error];
        if (error){
            NSLog(@"ERROR with file: %@", error);
        }
        NSArray *infos = [profile componentsSeparatedByString:@"\n"];
        self.textFieldName.text = infos[0];
        self.textFieldPrenom.text = infos[1];
        self.textFieldAge.text = infos[2];
        
    }
}

-(IBAction) enregistrementProfile {
    if (![self.textFieldAge.text  isEqual: @""] && ![self.textFieldName.text  isEqual: @""] && ![self.textFieldPrenom.text  isEqual: @""]){
        NSFileManager *fileManager;
        fileManager = [NSFileManager defaultManager];
        if([fileManager fileExistsAtPath:[NSString stringWithFormat:@"%@/profiles/%@.txt",NSHomeDirectory(), strUsername]] == NO ){
            [fileManager createFileAtPath:[NSString stringWithFormat:@"%@/profiles/%@.txt",NSHomeDirectory(),strUsername] contents:nil attributes:nil];
        }
        NSError *error = nil;
        NSString *profile = [NSString stringWithFormat:@"%@\n%@\n%@", self.textFieldName.text, self.textFieldPrenom.text, self.textFieldAge.text];
        NSLog(@"%@",NSHomeDirectory());
        [profile writeToFile:[NSString stringWithFormat:@"%@/profiles/%@.txt",NSHomeDirectory(), usernameLabel.text]  atomically:YES encoding:NSUnicodeStringEncoding error:&error];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Champs obligatoires" message:@"Veuillez saisir tous les champs" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
        
    }
}
-(IBAction)seDeconnecter{
    [[self appDelegate] disconnect];
    JBLoginViewController *loginController = [self.storyboard instantiateViewControllerWithIdentifier:@"loginView"];
    [self presentViewController:loginController animated:YES completion:nil];
}
-(JabberClientAppDelegate*) appDelegate {
    return (JabberClientAppDelegate*) [[UIApplication sharedApplication] delegate];
}

-(XMPPStream *) xmppStream {
    return [[self appDelegate] xmppStream];
}

-(IBAction) retour {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (id) initWithUser:(NSString *)userName {
    strUsername = userName;
    return self;
}
@end
