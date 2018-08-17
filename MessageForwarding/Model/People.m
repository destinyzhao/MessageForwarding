//
//  People.m
//  MessageForwarding
//
//  Created by Destiny on 2018/8/17.
//  Copyright © 2018年 Destiny. All rights reserved.
//

#import "People.h"
#import <objc/runtime.h>
#import "MsgForwarding.h"

void speak(id self, SEL _cmd){
    NSLog(@"Now I can speak.");
}

@implementation People

id ForwardingTarget_dynamicMethod(id self, SEL _cmd) {
    NSLog(@"没有找到方法:%@",NSStringFromSelector(_cmd));
    return [NSNull null];
}

+ (BOOL)resolveInstanceMethod:(SEL)sel {
    class_addMethod(self.class, sel, (IMP)ForwardingTarget_dynamicMethod, "@@:");
    [super resolveInstanceMethod:sel];
    return YES;
}

- (id)forwardingTargetForSelector:(SEL)aSelector {

    NSString *selStr = NSStringFromSelector(aSelector);

    if ([selStr isEqualToString:@"speak"]) {
         // 这里返回MsgForwarding类对象，让MsgForwarding类去处理speak消息
        return [[MsgForwarding alloc] init];
    }

    return [super forwardingTargetForSelector: aSelector];
}

- (void)forwardInvocation:(NSInvocation *)anInvocation {
  
    SEL selector = [anInvocation selector];
    // 新建需要转发消息的对象
    MsgForwarding *msgForwarding = [[MsgForwarding alloc] init];
    if ([msgForwarding respondsToSelector:selector]) {
        // 唤醒这个方法
        [anInvocation invokeWithTarget:msgForwarding];
    }
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    
    if (aSelector == @selector(speak)) {
        return [NSMethodSignature signatureWithObjCTypes:"V@:@"];
    }
    return [super methodSignatureForSelector:aSelector];
}

- (void)doesNotRecognizeSelector:(SEL)aSelector {
    NSLog(@"doesNotRecognizeSelector: %@", NSStringFromSelector(aSelector));
    [super doesNotRecognizeSelector:aSelector];
}

@end
