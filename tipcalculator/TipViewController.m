//
//  TipViewController.m
//  tipcalculator
//
//  Created by Debra Do on 2/22/14.
//  Copyright (c) 2014 Debra Do. All rights reserved.
//

#import "TipViewController.h"
#import "SettingsViewController.h"

@interface TipViewController ()

@property (weak, nonatomic) IBOutlet UITextField *billTextField;
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *tipControl;

- (IBAction)onTap:(id)sender;
- (void)updateValues;
- (void)onSettingsButton;

- (void)SelectTipPercentage;

@end

@implementation TipViewController {
    NSInteger tipPercentIndex;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Tip Calculator";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [ [UIBarButtonItem alloc] initWithTitle:@"Settings" style:UIBarButtonItemStylePlain target:self action:@selector(onSettingsButton) ];
}

- (void)SelectTipPercentage
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    tipPercentIndex = [userDefaults integerForKey:@"defaultTipPercentIndex"];
    
    if (tipPercentIndex != self.tipControl.selectedSegmentIndex)
    {
        self.tipControl.selectedSegmentIndex = tipPercentIndex;
        [self updateValues];
    }
}

- (void)didReceiveMemoryWarning2
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onTap:(id)sender {
    // Dismiss the number pad.
    [self.view endEditing:YES];
    [self updateValues];
}

- (void)updateValues{
    float billAmount = [self.billTextField.text floatValue];
    NSArray *tipValues = @[@(0.1), @(0.15), @(0.2)];
    
    float tipAmount = billAmount * [tipValues[self.tipControl.selectedSegmentIndex] floatValue];
    float totalAmount = tipAmount + billAmount;
    
    self.tipLabel.text = [NSString stringWithFormat:@"%.2f", tipAmount];
    self.totalLabel.text = [NSString stringWithFormat:@"%.2f", totalAmount];
}

- (void)onSettingsButton{
    [self.navigationController pushViewController:[ [SettingsViewController alloc] init] animated:YES ];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self SelectTipPercentage];
}

- (BOOL)textFieldShouldClear:(UITextField *)textField
{
    // Zero out the tip amount and total.
    self.billTextField.text = @"";
    [self updateValues];
    return YES;
}
    
@end
