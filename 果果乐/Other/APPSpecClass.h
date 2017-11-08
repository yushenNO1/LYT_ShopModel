//整理App内文字大小,字体规格
#define FontSize(size)              [UIFont systemFontOfSize:size * kScreenHeight]

#define FontSize_16                 [UIFont systemFontOfSize:16 * kScreenHeight]

#define FontSize_14                 [UIFont systemFontOfSize:14 * kScreenHeight]

//控件摆放位置适配
#define WDH_CGRectMake(x,y,width,height)        CGRectMake((x) * kScreenWidth1, (y) * kScreenHeight1, (width) * kScreenWidth1, (height) * kScreenHeight1)
//控件摆放位置适配
#define WDH_CGRectMake1(x,y,width,height)        CGRectMake((x) * kScreenWidth2, (y) * kScreenHeight2, (width) * kScreenWidth2, (height) * kScreenHeight2)

//整理线上线下文档

//正式上线的信息
//#define GGL                 @"http://ggl.caiyun156.com"
//测试
//#define GGL                  @"http://192.168.0.133:8080"

//果果乐商城
#define GGLSC                @"http://shop.caiyun156.com/b2c"

#define GGL                  @"http://192.168.0.133:8080"
//#define GGL                  @"http://47.52.94.255"








