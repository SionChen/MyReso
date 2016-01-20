//
//  SpecialListViewController.m
//  TaoTaoShopping
//
//  Created by 晓 on 15/12/15.
//  Copyright © 2015年 陈泳晓. All rights reserved.
//

#import "SpecialListViewController.h"
#import "SpecialListTableViewCell.h"
#import "RequetTool.h"
#import <MJRefresh.h>
#import <UIImageView+AFNetworking.h>
#import "WebViewController.h"


static NSString * cell_id = @"SPECIALLIST_CELL";
@interface SpecialListViewController ()<UITableViewDataSource,UITableViewDelegate,RequestDelegate>

@end

@implementation SpecialListViewController
{
    UITableView * _tableView;
    
    //请求类
    RequetTool * _requestTool;
    
    //数据源
    NSMutableArray * _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back1"] style:UIBarButtonItemStylePlain target:self action:@selector(barBackButton)];
    self.navigationItem.leftBarButtonItem.imageInsets = UIEdgeInsetsMake(0, -10, 0, 10);
    self.navigationItem.title = @"专题";
    
    self.tabBarController.tabBar.hidden = YES;

    
    [self createTableView];
    _dataArray = [NSMutableArray array];
    
    _requestTool = [[RequetTool alloc] init];
    _requestTool.delegate = self;
    [self requestData];
}

-(void)requestData
{
    [_requestTool requestWithUrlString:@"http://app.api.yijia.com/tb99/iphone/zhuanti.php" andName:@"主题街"];
}


-(void)getDataWithDictionary:(NSDictionary *)dataDict andName:(NSString *)name
{
    
    NSArray * arr = (NSArray *)dataDict;
    NSLog(@"Array:%@",arr);
    [_dataArray removeAllObjects];
    for (NSDictionary * dict in arr) {
        [_dataArray addObject:dict];
    }
    [_tableView reloadData];
    [_tableView.mj_header endRefreshing];
}



-(void)barBackButton
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)createTableView
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT-49)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerClass:[SpecialListTableViewCell class] forCellReuseIdentifier:cell_id];
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self requestData];
    }];
    [self.view addSubview:_tableView];
}

#pragma mark UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_dataArray.count>0) {
        return _dataArray.count;
    }
    return 7;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SpecialListTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cell_id forIndexPath:indexPath];
    if (_dataArray.count>indexPath.row) {
        NSDictionary * dict = [_dataArray objectAtIndex:indexPath.row];
        [cell.titelImageView setImageWithURL:[NSURL URLWithString:dict[@"pic_b_url"]] placeholderImage:[UIImage imageNamed:@"upload"]];
        cell.dayLabel.text = [dict[@"showtime"] substringFromIndex:[dict[@"showtime"] length]-2];
        cell.weekLabel.text = [dict[@"addtime"] substringToIndex:3];
        cell.bigTitleLabel.text = dict[@"title"];
        cell.littleTitleLabel.text =dict[@"title"];
        cell.dateLabel.text = [dict[@"addtime"] substringWithRange:NSMakeRange(4, 10)];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_dataArray.count>indexPath.row) {
        WebViewController * wvc = [[WebViewController alloc] initWithUrlString:[_dataArray objectAtIndex:indexPath.row][@"detail_url"]];
        [self.navigationController pushViewController:wvc animated:YES];
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 200;
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
