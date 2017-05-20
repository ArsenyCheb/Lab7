//
//  ViewController.m
//  Lab7_task1
//
//  Created by Arseny Cheb on 19.05.17.
//  Copyright © 2017 Arseny Cheb. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *Canvas;
@property CGPoint lastPoint;
@property (weak, nonatomic) IBOutlet UISlider *lineWidthSlider;
@property (weak, nonatomic) IBOutlet UIButton *saveBut;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *clearButton;
@property (weak, nonatomic) IBOutlet UILabel *label;
@end
NSDictionary  *colors;
CGFloat red, green, blue, alpha;
CGFloat lineWidth;

@implementation ViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    colors = @{@"0" :/*blue*/ [UIColor colorWithRed: 0.0 green: 0.0 blue: 1.0 alpha: 1.0],
               @"1" : /*green*/[UIColor colorWithRed: 0.0 green: 1.0 blue: 0.0 alpha: 1.0],
               @"2":/*red*/ [UIColor colorWithRed: 1.0 green: 0.0 blue: 0.0 alpha: 1.0],
               @"3" : /*black*/ [UIColor colorWithRed: 0.0 green: 0.0 blue: 0.0 alpha: 1.0],
               @"4" : /*white*/ [UIColor colorWithRed: 1.0 green: 1.0 blue: 1.0 alpha: 1.0],
               @"5" : /*yellow*/ [UIColor colorWithRed: 1.0 green: 1.0 blue: 0.0 alpha: 1.0],
               @"6" : /*orange*/ [UIColor colorWithRed: 1.0 green: 0.5 blue: 0.0 alpha: 1.0],
               @"7" : /*purple*/ [UIColor colorWithRed: 0.5 green: 0.0 blue: 0.5 alpha: 1.0]};
    red = 1.0;
    green = 0.0;
    blue = 0.0;
    alpha = 1.0;
    lineWidth = 5.0;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    [self setLastPoint:[touch locationInView:self.Canvas]];
}
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint currentPoint = [touch locationInView:self.Canvas];
    UIGraphicsBeginImageContext(self.Canvas.frame.size);
    CGRect drawRect = CGRectMake(0.0f, 0.0f, self.Canvas.frame.size.width,
                                 self.Canvas.frame.size.height);
    [[[self Canvas] image] drawInRect:drawRect];
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
    CGContextSetLineWidth(UIGraphicsGetCurrentContext(), lineWidth);
    CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), red, green, blue, alpha);
    
    CGContextBeginPath(UIGraphicsGetCurrentContext());
    CGContextMoveToPoint(UIGraphicsGetCurrentContext(), _lastPoint.x,
                         _lastPoint.y);
    CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), currentPoint.x,
                            currentPoint.y);
    CGContextStrokePath(UIGraphicsGetCurrentContext());
    [[self Canvas] setImage:UIGraphicsGetImageFromCurrentImageContext()];
    UIGraphicsEndImageContext();
    _lastPoint = currentPoint;
}
-(IBAction)selectColorButton:(UIButton *)sender {
    
    NSInteger tag = sender.tag;
    UIColor *color = [colors valueForKey:[@(tag) stringValue]];
    [color getRed:&red green:&green blue:&blue alpha:&alpha];
    
}
- (IBAction)changes:(id)sender {
    lineWidth = roundf([[self lineWidthSlider]value]);
    [[self lineWidthSlider] setValue:lineWidth animated:YES];
    [[self label]setText:[@(lineWidth) stringValue]];
}
NSString *letters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";

-(NSString *) randomStringWithLength: (int) len {
    
    NSMutableString *randomString = [NSMutableString stringWithCapacity: len];
    
    for (int i=0; i<len; i++) {
        [randomString appendFormat: @"%C", [letters characterAtIndex: arc4random_uniform((int)[letters length])]];
    }
    
    return randomString;
}

- (IBAction)saving:(id)sender {
    
    UIGraphicsBeginImageContext(self.Canvas.bounds.size);
    [self.Canvas.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
#if TARGET_IPHONE_SIMULATOR
    
    NSString *path = [NSString stringWithFormat:@"/Users/katsiarynazaitsava/Documents/2term/TP/Lab7/Lab7_task1/img%@.jpg", [ self randomStringWithLength:10]];
    NSData *imageData = UIImageJPEGRepresentation(image, 1.0);
    [imageData writeToFile:path atomically:YES];
    
#else
    
    UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
    
#endif
   
    
    
}
- (IBAction)clearButtonAction:(id)sender {
    self.Canvas.image = nil;
}

@end
