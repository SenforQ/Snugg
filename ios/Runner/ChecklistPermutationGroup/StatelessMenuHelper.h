#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface StatelessMenuHelper : NSObject

@property (nonatomic) int channelsLikeLevel;

@property (nonatomic) NSMutableDictionary * playbackUntilCycle;

+ (instancetype) statelessMenuHelperWithDictionary: (NSDictionary *)dict;

- (instancetype) initWithDictionary: (NSDictionary *)dict;

- (NSString *) directlyModelBrightness;

- (NSMutableDictionary *) cubeTempleTint;

- (int) indicatorObserverTransparency;

- (NSMutableSet *) customIconMode;

- (NSMutableArray *) bitrateMethodOrientation;

@end

NS_ASSUME_NONNULL_END
        