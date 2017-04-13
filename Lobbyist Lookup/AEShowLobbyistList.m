//
//  AEShowLobbyistList.m
//  Lobbyist Lookup
//
//  Created by Anson Liu on 6/17/14.
//  Copyright (c) 2014 Apparent Etch. All rights reserved.
//

#import "AEShowLobbyistList.h"

@implementation AEShowLobbyistList

NSString* resultInfo[7];
NSString* infoTitle[7];

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    resultInfo[0] = organizationNameKey;
    resultInfo[1] = clientNameKey;
    resultInfo[2] = houseIDKey;
    resultInfo[3] = senateIDKey;
    resultInfo[4] = lobbyistListKey;
    resultInfo[5] = reportYearKey;
    resultInfo[6] = reportTypeKey;
    
    infoTitle[0] = @"Organization";
    infoTitle[1] = @"Client";
    infoTitle[2] = @"House ID";
    infoTitle[3] = @"Senate ID";
    infoTitle[4] = @"Lobbyists";
    infoTitle[5] = @"Report Year";
    infoTitle[6] = @"Report Type";
    

    
    //self.navigationItem.title = [self.result objectForKey:organizationNameKey];
    
    NSMutableDictionary *tmp = [[NSMutableDictionary alloc] initWithDictionary:self.result];
    
    [tmp setValue:[self stripArrayDuplicates:[self.result objectForKey:lobbyistListKey]] forKey:lobbyistListKey];
    
    self.result = tmp;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if ([self.result count] > 7) //bug that popped up in iOS 9, if returned result dict has more elements than the resultInfo dict that we load key names from
        return 7;
        
    
    return [self.result count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section != 4) {
        return 1;
    }
    else {
        return [[self.result objectForKey:resultInfo[section]] count];
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return infoTitle[section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"LobbyistCell";
    
    //iOS 5 does not have dequeReusableCellWithIdentifier:forIndexPath:
    UITableViewCell *cell;
    if ([tableView respondsToSelector:@selector(dequeueReusableCellWithIdentifier:forIndexPath:)]) {
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    }
    else {
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    }

    if ([indexPath section] != 4) {
        cell.textLabel.text = [NSString stringWithFormat:@"%@", [self.result objectForKey:resultInfo[[indexPath section]]]];
        if (!cell.textLabel.text) {
            cell.textLabel.text = @"RECORD MISSING";
        }
        cell.detailTextLabel.text = nil;
    }
    else {
        NSDictionary *lobbyist = [[self.result objectForKey:resultInfo[[indexPath section]]] objectAtIndex:[indexPath row]];
    
        cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", [lobbyist objectForKey:firstNameKey], [lobbyist objectForKey:lastNameKey]];
        cell.detailTextLabel.text = nil;
    }
    
    return cell;
}

#pragma mark - Table View delegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
   
}

#pragma mark - Array Parsing

- (NSArray *)stripArrayDuplicates:(NSArray *)originalArray {
    NSMutableArray *mutableArray = [[NSMutableArray alloc] initWithArray:originalArray];
    NSInteger index = [originalArray count] - 1;
    for (id object in [originalArray reverseObjectEnumerator]) {
        if ([mutableArray indexOfObject:object inRange:NSMakeRange(0, index)] != NSNotFound) {
            [mutableArray removeObjectAtIndex:index];
        }
        index--;
    }
    return (NSArray *)mutableArray;
}

@end
