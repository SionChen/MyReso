//
//  OrderListViewController.m
//  TaoTaoShopping
//
//  Created by 晓 on 15/12/14.
//  Copyright © 2015年 陈泳晓. All rights reserved.
//

#import "OrderListViewController.h"
#import "OrderListHeaderView.h"
#import "RequetTool.h"
#import <MJRefresh.h>
#import "OrderListCollectionViewCell.h"
#import <UIImageView+AFNetworking.h>
#import "WebViewController.h"

@interface OrderListViewController ()<RequestDelegate,UICollectionViewDataSource,UICollectionViewDelegate>

@end
static NSString * cell_id = @"ORDERLIST_CELL";

@implementation OrderListViewController
{

    //请求类
    RequetTool * _requestTool;
    
    //排序方法
    NSString * _sort;
    
    //数据源
    NSMutableArray * _dataArray;
    
    UICollectionView * _collectionView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _dataArray = [NSMutableArray array];
    
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back1"] style:UIBarButtonItemStylePlain target:self action:@selector(barBackButton)];
    self.navigationItem.leftBarButtonItem.imageInsets = UIEdgeInsetsMake(0, -10, 0, 10);
    
    self.title = self.text;
    //创建搜索头
    OrderListHeaderView * headerView = [[OrderListHeaderView alloc] initWithFrame:CGRectMake(10, 5, WIDTH-20, 30)];
    headerView.block = ^(NSInteger index,BOOL isClick){
        //这里写点击事件
        switch (index) {
            case 0:
                _sort = @"s";
                break;
            case 1:
                _sort = @"d";
                break;
            case 2:
                if (isClick) {
                    _sort = @"p";
                }else
                {
                    _sort =@"pd";
                }
                break;
            default:
                break;
        }
        [self requestData];
        
    };
    [self.view addSubview:headerView];
    
    [self getCollectionView];
    _requestTool = [[RequetTool alloc] init];
    _requestTool.delegate = self;
    _sort = @"s";
    [self requestData];

}

-(void)getCollectionView
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setItemSize:CGSizeMake((WIDTH-15)/2-7, 200)];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    //调行间距
    [flowLayout setMinimumLineSpacing:5];
    //调列间距
    [flowLayout setMinimumInteritemSpacing:5];
    [flowLayout setSectionInset:UIEdgeInsetsMake(5, 10, 0, 10)];
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 38, WIDTH , HEIGHT) collectionViewLayout:flowLayout];
    
    _collectionView.backgroundColor = [UIColor colorWithRed:239/255.0 green: 239/255.0 blue:239/255.0 alpha:1];
    _collectionView.dataSource = self;
    _collectionView.delegate =self;
    _collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        //[self getData];
    }];
    
    [_collectionView registerClass:[OrderListCollectionViewCell class] forCellWithReuseIdentifier:cell_id];
   
    [self.view addSubview:_collectionView];
    
}
#pragma mark UICollectionViewDelegate
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    OrderListCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:cell_id forIndexPath:indexPath];
    if (_dataArray.count>indexPath.row) {
        NSDictionary * dict = [_dataArray objectAtIndex:indexPath.row];
        [cell.imageView setImageWithURL:[NSURL URLWithString:dict[@"pic_path"]] placeholderImage:[UIImage imageNamed:@"upload"]];
        cell.titleLabel.text = dict[@"title"];
        cell.orPriceLabel.text = [NSString stringWithFormat:@"￥%@",dict[@"price_with_rate"]];
        cell.nowPriceLabel.text = [NSString stringWithFormat:@"￥%@",dict[@"price"]];
        cell.discountLabel.text = [NSString stringWithFormat:@"%@折",dict[@"discount"]];
        cell.saleLabel.text = [NSString stringWithFormat:@"已销%@件",dict[@"sold"]];
        
        
    }
    
    
    return cell;
    
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    if (_dataArray.count>0) {
        return _dataArray.count;
    }
    return 20;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (_dataArray.count>indexPath.row) {
        NSDictionary * dict = [_dataArray objectAtIndex:indexPath.row];
        WebViewController * wvc = [[WebViewController alloc] initWithUrlString:[NSString stringWithFormat:@"http://detail.m.tmall.com/item.htm?id=%@&id=%@&sche=fenjiujiu",dict[@"item_id"],dict[@"item_id"]]];
        
        [self.navigationController pushViewController:wvc animated:YES];
    }
}

#pragma mark getData
-(void)requestData
{
    if ([self.cid length]>0) {
        [_requestTool requestWithUrlString:[NSString stringWithFormat:@"http://jkjby.yijia.com/jkjby/view/tmzk_api.php?cid=%@&start=0&sort=%@&price=0,200",self.cid,_sort] andName:@"OrderList"];
    }
    else
    {
        NSString * url =[NSString stringWithFormat:@"http://jkjby.yijia.com/jkjby/view/tmzk_api.php?keyword=%@&start=0&sort=%@&price=0,999999",self.keyWord,_sort];
        [_requestTool requestWithUrlString: [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] andName:@"OrderList"];
    }
    
}

-(void)getDataWithDictionary:(NSDictionary *)dataDict andName:(NSString *)name
{
    [_dataArray removeAllObjects];
    NSArray  * arr = dataDict[@"list"];
    for (NSDictionary * dict in arr) {
        [_dataArray addObject:dict];
    }
    [_collectionView.mj_header endRefreshing];
    [_collectionView reloadData];
    
    NSLog(@"%d",_dataArray.count);
}

-(void)barBackButton
{
    [self.navigationController popViewControllerAnimated:YES];
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
