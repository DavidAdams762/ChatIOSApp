//
//  ViewController.m
//  Jabber Client
//
//  Created by ADAMS David on 28/06/2015.
//  Copyright (c) 2015 ADAMS David. All rights reserved.
//

#import "BuddyViewController.h"
#import "JBLoginViewController.h"

@interface BuddyViewController ()

@end

@implementation BuddyViewController
@synthesize tabView, offlineTabView;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabView.delegate = self;
    self.tabView.dataSource = self;
    self.offlineTabView.delegate = self;
    self.offlineTabView.dataSource = self;
    onlineBuddies = [[NSMutableArray alloc] init];
    offlineBuddies = [[NSMutableArray alloc] init];
    JabberClientAppDelegate *del = [self appDelegate];
    del._chatDelegate = self;
    // Do any additional setup after loading the view, typically from a nib.
}

- (void) showLogin {
    JBLoginViewController *loginController = [self.storyboard instantiateViewControllerWithIdentifier:@"loginView"];
    [self presentViewController:loginController animated:YES completion:nil];
}
- (void) showProfile {
    JBProfileViewController *profileController = [[self.storyboard instantiateViewControllerWithIdentifier:@"showProfile"] initWithUser:[[NSUserDefaults standardUserDefaults] objectForKey:@"userID"]];
    [self presentViewController:profileController animated:YES completion:nil];
}
-(IBAction) showInvite{
    AddBuddyViewController *inviteController = [self.storyboard instantiateViewControllerWithIdentifier:@"addBuddy"];
    [self presentViewController:inviteController animated:YES completion:nil];
}
- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString* s;
    if(tableView == self.tabView){
        s = (NSString*) [onlineBuddies objectAtIndex:indexPath.row];
    }
    else {
        s = (NSString*) [offlineBuddies objectAtIndex:indexPath.row];
    }
    static NSString* CellIndentifier = @"UserCellIdentifier";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:CellIndentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIndentifier];
    }
    cell.textLabel.text = s;
    if (tableView == self.tabView)
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if(tableView == self.tabView){
        return [onlineBuddies count];
    }
    else {
        return [offlineBuddies count];
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (void) tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(tableView == self.tabView){
    NSString *username = (NSString *) [onlineBuddies objectAtIndex:indexPath.row];
    JBChatViewController *chatController = [[self.storyboard instantiateViewControllerWithIdentifier:@"chatView"] initWithUser:username];
    [self presentViewController:chatController animated:YES completion:nil];
    }
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSString* login = [[NSUserDefaults standardUserDefaults] objectForKey:@"userID"];
    [onlineBuddies removeAllObjects];
    [offlineBuddies removeAllObjects];
    if (login) {
        if ([[self appDelegate] connect]) {
        }
        else {
            [self showLogin];
        }
    } else {
        [self showLogin];
    }
}

- (JabberClientAppDelegate *) appDelegate {
    return (JabberClientAppDelegate *)[[UIApplication sharedApplication] delegate];
}

-(XMPPStream *) xmppStream {
    return [[self appDelegate] xmppStream];
}

-(void) amiHorsLigne:(NSString *)buddyName{
    [onlineBuddies removeObject:buddyName];
    if (![offlineBuddies containsObject:buddyName]) {
        [offlineBuddies addObject:buddyName];
    }
    [self.tabView reloadData];
    [self.offlineTabView reloadData];
}

-(void) newAmiEnLigne:(NSString *)buddyName{
    if (![onlineBuddies containsObject:buddyName])
        [onlineBuddies addObject:buddyName];
    [offlineBuddies removeObject:buddyName];
    [self.tabView reloadData];
    [self.offlineTabView reloadData];
}
- (void) didDisconect {
    
    [onlineBuddies removeAllObjects];
    [offlineBuddies removeAllObjects];
    [self.tabView reloadData];
    [self.offlineTabView reloadData];
    
}

@end
