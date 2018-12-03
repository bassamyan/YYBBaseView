//
//  ViewController.m
//  YYB_iOSComponent
//
//  Created by Sniper on 2018/12/3.
//  Copyright © 2018 Sniper. All rights reserved.
//

#import "ViewController.h"
#import "YYBRouter.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.isPreferBackNavigationButtonHidden = TRUE;
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    self.results = @[@[@"Push",@"Router"],
                     @[@"Alert",@"AlertView"]].mutableCopy;
}

- (NSString *)titleForNavigationBar {
    return @"YYB  iOSComponent";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    cell.textLabel.text = [[self.results objectAtIndex:indexPath.row] objectAtIndex:1];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *className = [[self.results objectAtIndex:indexPath.row] objectAtIndex:0];
    [YYBRouter openURL:[NSString stringWithFormat:@"yyb://%@",className]];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60.0f;
}

@end
