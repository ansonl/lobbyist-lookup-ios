//
//  AEShowLookupResult.m
//  Lobbyist Lookup
//
//  Created by Anson Liu on 6/16/14.
//  Copyright (c) 2014 Apparent Etch. All rights reserved.
//

#import "AEShowLookupResult.h"

@implementation AEShowLookupResult

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Results" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = backButtonItem;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.resultArray count] + 1;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"Results";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"OrganizationCell";
    
    //iOS 5 does not have dequeReusableCellWithIdentifier:forIndexPath:
    UITableViewCell *cell;
    if ([tableView respondsToSelector:@selector(dequeueReusableCellWithIdentifier:forIndexPath:)]) {
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    }
    else {
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    }
    
    if ([indexPath row] == 0) { //quick result
        cell.accessoryType = UITableViewCellAccessoryNone;
        if ([self.resultArray count] == 0) {//no matches
            //cell.textLabel.textColor = [UIColor greenColor];
            cell.textLabel.text = @"No matches";
        }
        else {//matches found
            cell.textLabel.textColor = [UIColor redColor];
            cell.textLabel.text = @"Possibly ineligle for gifts.";
        }
        cell.detailTextLabel.text = [NSString stringWithFormat:@"At least %lu matches found.",(unsigned long)[self.resultArray count]];
    }
    else { //results listings
        cell.textLabel.text = [[self.resultArray objectAtIndex:[indexPath row] - 1] objectForKey:organizationNameKey];
        if (!cell.textLabel.text) {
            cell.textLabel.text = @"RECORD MISSING";
        }
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ - %@", [[self.resultArray objectAtIndex:[indexPath row] - 1] objectForKey:reportYearKey], [[self.resultArray objectAtIndex:[indexPath row] - 1] objectForKey:clientNameKey]];
    }
    
    return cell;
}

#pragma mark - Table View delegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([indexPath row] == 0) {
        //[self performSegueWithIdentifier:@"ShowExplanation" sender:self.resultArray];
    }
    else {
        [self performSegueWithIdentifier:@"ShowLobbyistList" sender:[self.resultArray objectAtIndex:[indexPath row] - 1]];
    }
}

#pragma mark - Segue method

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"ShowLobbyistList"]) {
        AEShowLobbyistList *showLobbyistList = [segue destinationViewController];
        
        showLobbyistList.result = sender;
    }
}

@end
