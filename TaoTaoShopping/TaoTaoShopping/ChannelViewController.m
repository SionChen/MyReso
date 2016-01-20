//
//  ChannelViewController.m
//  TaoTaoShopping
//
//  Created by 晓 on 15/12/10.
//  Copyright © 2015年 陈泳晓. All rights reserved.
//

#import "ChannelViewController.h"
#import <MJRefresh.h>
#import "ChannelCollectionViewCell.h"
#import "RequetTool.h"
#import <UIImageView+AFNetworking.h>
#import "WebViewController.h"
#import "ChannelAddViewController.h"

@interface ChannelViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,RequestDelegate>

@end

static NSString * cell_id = @"CHANEL_CELL";
@implementation ChannelViewController
{
    UICollectionView * _collectionView;
    //数据请求类
    RequetTool * _requestTool;
    
    //主数据源
    NSMutableArray * _homeArray;
    
    //添加的数组
    NSMutableArray * _addArray;
    
}



-(void)viewWillAppear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = NO;
    [self requestData];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"主题分类";
    
    _homeArray = [NSMutableArray array];
    _addArray = [NSMutableArray array];
    [self createCollectionView];
    _requestTool = [[RequetTool alloc] init];
    _requestTool.delegate = self;
}


-(void)requestData
{
    [_requestTool requestWithUrlString:@"http://app.api.yijia.com/tb99/iphone/apphome.php?appid=98a723d3f348b24c85251584250c379e586a851c" andName:@"ChannelList"];
    
}
-(void)getDataWithDictionary:(NSDictionary *)dataDict andName:(NSString *)name
{
    
    [_homeArray removeAllObjects];
    [_addArray removeAllObjects];
    
    NSArray * arr = dataDict[@"home_list"];
    for (NSDictionary * dict in arr) {
        [_homeArray addObject:dict];
    }
    NSArray * arr2 = dataDict[@"add_list"];
    for (NSDictionary * dict in arr2) {
        [_addArray addObject:dict];
    }
    [_collectionView.mj_header endRefreshing];
    [_collectionView reloadData];
}

-(void)createCollectionView
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setItemSize:CGSizeMake((WIDTH-60)/4, 80)];
    
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    //调行间距
    [flowLayout setMinimumLineSpacing:5];
    //调列间距
    [flowLayout setMinimumInteritemSpacing:5];
    [flowLayout setSectionInset:UIEdgeInsetsMake(10, 20, 0, 10)];
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(5, 0, WIDTH-10 , HEIGHT) collectionViewLayout:flowLayout];
    
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.dataSource = self;
    _collectionView.delegate =self;
    _collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self requestData];
    }];
    //[_collectionView registerClass:[HomeCustomHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:header_id];
    
    [_collectionView registerClass:[ChannelCollectionViewCell class] forCellWithReuseIdentifier:cell_id];
    [self.view addSubview:_collectionView];
    
    
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ChannelCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:cell_id forIndexPath:indexPath];
    if (_homeArray.count>indexPath.row) {
        NSDictionary * dict = [_homeArray objectAtIndex:indexPath.row];
        [cell.titleImageView setImageWithURL:[NSURL URLWithString:dict[@"logo_2x"]] placeholderImage:[UIImage imageNamed:@"upload"]];
        cell.titleLabel.text = dict[@"name"];
    }
    
    return cell;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (_homeArray.count>0) {
        return _homeArray.count;
    }
    
    return 7;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row < _homeArray.count-1) {
        NSDictionary * dict = [_homeArray objectAtIndex:indexPath.row];
        WebViewController * wvc = [[WebViewController alloc] initWithUrlString:dict[@"url"]];
        wvc.block(dict[@"name"]);
        [self.navigationController pushViewController:wvc animated:YES];
    }else
    {
        ChannelAddViewController * cav = [[ChannelAddViewController alloc] init];
        cav.addArray = _addArray;
        [self.navigationController pushViewController:cav animated:YES];
    }
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
