//
//  YIAlertViewController.m
//  YYB_iOSComponent
//
//  Created by Sniper on 2018/12/3.
//  Copyright © 2018 Univease Co., Ltd. All rights reserved.
//

#import "YIAlertViewController.h"
#import "YYBAlertView+Waiting.h"
#import "YYBAlertView+Status.h"
#import "YYBAlertView+Alert.h"
#import "YYBAlertView+DatePicker.h"
#import "YYBAlertView+Storage.h"

@interface YIAlertViewController ()

@end

@implementation YIAlertViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    self.results = @[@"等待视图(2s)",
                     @"提示视图",
                     @"标题 + 详情 + 两个按钮",
                     @"标题 + 一个按钮",
                     @"日期选择器",
                     @"自定义视图"].mutableCopy;
}

- (NSString *)titleForNavigationBar {
    return @"AlertView";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    cell.textLabel.text = [self.results objectAtIndex:indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        [YYBAlertView showWaitingAlertViewWithTimeInterval:2.0f];
    } else if (indexPath.row == 1) {
        [YYBAlertView showAlertViewWithStatus:@"YYB  iOSComponent"];
    } else if (indexPath.row == 2) {
        [YYBAlertView showAlertViewWithTitle:@"新疆第七地质大队联合乌苏市交警大队开展“122”全国交通安全日主题活动" detail:@"活动伊始,乌苏市交警大队袁教官详细讲解了日常交通事故的法规及处理流程、机动车驾驶与使用规定以及如何正确处理违章行为等交通安全知识。并面对面解答我队驾驶员在日常工作中遇到的疑难问题,使得参会人员受益匪浅。" cancelActionTitle:@"取消" confirmActionTitle:@"确定" confirmActionHandler:^{
            [YYBAlertView showAlertViewWithStatus:@"您点击了确定"];
        }];
    } else if (indexPath.row == 3) {
        [YYBAlertView showAlertViewWithTitle:@"最近股市又跌的稀里哗啦的，即使领导说春天不远了，市场也丝毫不领情，继续向下狂奔。" detail:nil cancelActionTitle:nil confirmActionTitle:@"确定" confirmActionHandler:^{
            [YYBAlertView showAlertViewWithStatus:@"您点击了确定"];
        }];
    } else if (indexPath.row == 4) {
        [YYBAlertView showAlertViewWithDatePickerSelectedHandler:^(NSDate * _Nonnull date) {
            
        }];
    } else if (indexPath.row == 5) {
        [YYBAlertView showStorageAlertViewWithMoney:20.0f prestoredMoney:100.0f desc:nil cardId:0 descValueChangedHandler:^(NSString * _Nonnull string) {
            
        } cardChangedHandler:^(NSInteger cardId) {
            
        } storageTapedHandler:^(CGFloat neededPrestoredMoney, CGFloat neededMoney) {
            
        }];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60.0f;
}

@end
