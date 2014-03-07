//
//  SettingsViewController.m
//  tipcalculator
//
//  Created by Debra Do on 2/22/14.
//  Copyright (c) 2014 Debra Do. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()

- (void)GetUserDefaults;
- (void)SaveUserDefaults;

@end

@implementation SettingsViewController {
    NSArray *tipValues;
    NSInteger tipPercentIndex;
    NSIndexPath *defaultTipPercentIndexPath;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return tipValues.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [ [UITableViewCell alloc] init ];
    cell.textLabel.text = tipValues[indexPath.row];
    
    if (indexPath.row == tipPercentIndex)
    {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        defaultTipPercentIndexPath = indexPath;
    }
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"Tip Amount";
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Remove row highlighting.
    [tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:NO];
    
    UITableViewCell *previousSelectedCell = [tableView cellForRowAtIndexPath:defaultTipPercentIndexPath];
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if (cell.accessoryType == UITableViewCellAccessoryNone)
    {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        
        tipPercentIndex = indexPath.row;
        
        previousSelectedCell.accessoryType = UITableViewCellAccessoryNone;
        
        defaultTipPercentIndexPath = indexPath;
    }
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Settings";
     
    }
    
    return self;
}

- (void)GetUserDefaults
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    tipPercentIndex = [userDefaults integerForKey:@"defaultTipPercentIndex"];
}

- (void)SaveUserDefaults
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    [userDefaults setInteger:tipPercentIndex forKey:@"defaultTipPercentIndex"];
    [userDefaults synchronize];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    tipValues = @[@("10%"), @("15%"), @("20%")];
    
    [self GetUserDefaults];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self SaveUserDefaults];
}

@end
