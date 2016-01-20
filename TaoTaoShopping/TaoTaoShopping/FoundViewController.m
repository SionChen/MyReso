//
//  FoundViewController.m
//  TaoTaoShopping
//
//  Created by 晓 on 15/12/10.
//  Copyright © 2015年 陈泳晓. All rights reserved.
//

#import "FoundViewController.h"
#import "SpecialListViewController.h"
#import "WebViewController.h"

@interface FoundViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

static NSString * cell_id = @"FOUND_CELL";
@implementation FoundViewController

{
    UITableView * _tableView;
}

-(void)viewWillAppear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"探索新事物";
    [self getTableView];
    
    // Do any additional setup after loading the view.
}


-(void)getTableView
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT-90) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cell_id];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.view addSubview:_tableView];
}
#pragma  mark UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 3;
    }else if (section == 1)
    {
        return 2;
    }
    return 2;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cell_id forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cell_id];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    if (indexPath.section==0) {
        if (indexPath.row ==0) {
            cell.imageView.image = [UIImage imageNamed:@"zt"];
            cell.textLabel.text = @"主题";
        }
        else if (indexPath.row == 1)
        {
            cell.imageView.image = [UIImage imageNamed:@"icon_float_category_search_hover8@2x"];
            cell.textLabel.text = @"生活";
        }else
        {
            cell.imageView.image = [UIImage imageNamed:@"Shopping_Bag_912px_1160277_easyicon.net"];
            cell.textLabel.text = @"超值买";
        }
    }else if (indexPath.section == 1)
    {
        if (indexPath.row == 0) {
            cell.imageView.image = [UIImage imageNamed:@"icon_loading_action18"];
            cell.textLabel.text =@"精打细算";
        }else
        {
            cell.imageView.image = [UIImage imageNamed:@"pinpai_click_HD@2x8"];
            cell.textLabel.text = @"大牌";
        }
    }else
    {
        if (indexPath.row == 0) {
            cell.imageView.image = [UIImage imageNamed:@"zk"];
            cell.textLabel.text = @"风格";
        }else
        {
            cell.imageView.image = [UIImage imageNamed:@"icon_logistics@2x8"];
            cell.textLabel.text = @"随便看看";
        }
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            SpecialListViewController * svc = [[SpecialListViewController alloc] init];
            [self.navigationController pushViewController:svc animated:YES];
        }else if (indexPath.row ==1)
        {
            WebViewController *wvc = [[WebViewController alloc] initWithUrlString:@"http://zhekou.yijia.com/lws/view/yijia_shop.php?app_id=2402388976&sche=fenjiujiu"];
            
            wvc.block(@"生活街");
            [self.navigationController pushViewController:wvc animated:YES];
        }else
        {
            WebViewController *wvc = [[WebViewController alloc] initWithUrlString:@"http://app.api.yijia.com/tb99/iphone/API/app_qipa.php#/-index/1"];
            
            wvc.block(@"超值买手");
            [self.navigationController pushViewController:wvc animated:YES];
        }
        
    }else if (indexPath.section == 1)
    {
        if (indexPath.row == 0) {
            WebViewController *wvc = [[WebViewController alloc] initWithUrlString:@"http://jkjby.yijia.com/jkjby/view/nine_web/index.php?app_id=2402388976&sche=fenjiujiu"];
            
            wvc.block(@"今天很划算");
            [self.navigationController pushViewController:wvc animated:YES];
        }else
        {
            WebViewController *wvc = [[WebViewController alloc] initWithUrlString:@"http://app.api.yijia.com/tb99/iphone/API/app_qipa.php#/-index/1"];
            
            wvc.block(@"品牌团");
            [self.navigationController pushViewController:wvc animated:YES];
        }
    }else
    {
        if (indexPath.row == 0) {
            WebViewController *wvc = [[WebViewController alloc] initWithUrlString:@"http://zhekou.repai.com/lws/wangyu/index.php?control=tianmao&model=get_sec_ten_two_view&id=20195&title=%E7%99%BE%E6%97%A5%E6%96%B0%E5%93%81"];
            
            wvc.block(@"风格");
            [self.navigationController pushViewController:wvc animated:YES];

        }else
        {
            WebViewController *wvc = [[WebViewController alloc] initWithUrlString:@"http://zhekou.repai.com/lws/view/zhe_miaoyiyan.php"];
            
            wvc.block(@"随便看看");
            [self.navigationController pushViewController:wvc animated:YES];
        }
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return 2;
    }
    return 10;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
