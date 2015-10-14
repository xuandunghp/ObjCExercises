//
//  LenZoom.m
//  ObjCExample
//
//  Created by Dzung Tran on 10/13/15.
//  Copyright © 2015 Dzung. All rights reserved.
//

#import "LenZoom.h"

@interface LenZoom () <UIGestureRecognizerDelegate>

@property (weak, nonatomic) UIImageView *image;
@property (weak, nonatomic) CAShapeLayer *maskLayer;
@property (weak, nonatomic) CAShapeLayer *circleLayer;

@property (nonatomic) CGPoint circleCenter;
@property (nonatomic) CGFloat circleRadius;

@end

@implementation LenZoom

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self addImage];
    [self addMask];
}

- (void) addImage {
    UIImageView *image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"girl.jpg"]];
    
    [self.view addSubview:image];
    self.image = image;
}

- (void) addMask {
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    self.image.layer.mask = maskLayer;
    self.maskLayer = maskLayer;
    
    CAShapeLayer *circleLayer = [CAShapeLayer layer];
    circleLayer.lineWidth = 3.0;
    circleLayer.fillColor = [[UIColor clearColor] CGColor];
    circleLayer.strokeColor = [[UIColor blackColor] CGColor];
    [self.image.layer addSublayer:circleLayer];
    self.circleLayer = circleLayer;
    
    [self updateCirclePathAtLocation:self.view.center radius:self.view.bounds.size.width * 0.3];
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(onPan:)];
    pan.delegate = self;
    [self.image addGestureRecognizer:pan];
    
    UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(onPinch:)];
    pinch.delegate = self;
    [self.image addGestureRecognizer:pinch];

    self.image.userInteractionEnabled = YES;
    self.image.multipleTouchEnabled = YES;
}

- (void) updateCirclePathAtLocation:(CGPoint)location radius:(CGFloat)radius {
    self.circleCenter = location;
    self.circleRadius = radius;

    int numberOfVertices = 5;
    CGFloat controlPointRadius = radius * 1.8;
    
    NSMutableArray *points = [[NSMutableArray alloc] initWithCapacity:numberOfVertices];
    NSMutableArray *controlPoints = [[NSMutableArray alloc] initWithCapacity:numberOfVertices];
    
    for (int i = 0; i < numberOfVertices; i++) {
        CGFloat angle = M_PI * 2.0 * i / numberOfVertices + M_PI * 0.5;
        CGFloat controlPointAngle = angle + M_PI / numberOfVertices;
        
        [points addObject:[NSValue valueWithCGPoint:CGPointMake(location.x + radius * cos(angle), location.y + radius * sin(angle))]];
        [controlPoints addObject:[NSValue valueWithCGPoint:CGPointMake(location.x + controlPointRadius * cos(controlPointAngle), location.y + controlPointRadius * sin(controlPointAngle))]];
    }
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    [path moveToPoint:[points[0] CGPointValue]];
    for (int i = 0; i < numberOfVertices; i++) {
        [path addQuadCurveToPoint:[points[(i + 1) % numberOfVertices] CGPointValue] controlPoint:[controlPoints[i] CGPointValue]];
    }
    
//    [path addArcWithCenter:location
//                    radius:radius
//                startAngle:0
//                  endAngle:M_PI * 2
//                 clockwise:YES];
    
    self.maskLayer.path = [path CGPath];
    self.circleLayer.path = [path CGPath];
}

- (void) onPan:(UIPanGestureRecognizer *)pan {
    CGPoint translation = [pan translationInView:pan.view];
    static CGPoint oldCenter;
    
    if (pan.state == UIGestureRecognizerStateBegan) {
        oldCenter = self.circleCenter;
    }
    
    CGPoint newCenter = CGPointMake(oldCenter.x + translation.x, oldCenter.y + translation.y);
    [self updateCirclePathAtLocation:newCenter radius:self.circleRadius];
}

- (void) onPinch:(UIPinchGestureRecognizer *)pinch {
    static CGFloat oldRadius;
    CGFloat scale = pinch.scale;
    
    if (pinch.state == UIGestureRecognizerStateBegan) {
        oldRadius = self.circleRadius;
    }
    
    CGFloat newRadius = oldRadius * scale;
    [self updateCirclePathAtLocation:self.circleCenter radius:newRadius];
}

- (BOOL) gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    if ([gestureRecognizer isMemberOfClass:[UIPanGestureRecognizer class]] && [otherGestureRecognizer isMemberOfClass:[UIPinchGestureRecognizer class]]) {
        return true;
    }
    else {
        return false;
    }
}

@end
