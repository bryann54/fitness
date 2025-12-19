// widgets/intro_content_data.dart
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fitness/features/auth/data/models/intro_screen_model.dart';

class IntroContentData {
  // SET 1: "Transform Your Body" - Core value proposition
  static final List<IntroScreenContent> introContent = [
    IntroScreenContent(
      // Changed from bullseye to locationDot (suggests a destination)
      icon: FontAwesomeIcons.locationDot,
      title: 'Smart Goal Setting',
      description:
          'Define your fitness destination with intelligent goal tracking. Whether building muscle, losing weight, or improving endurance, we\'ll chart your path.',
    ),
    IntroScreenContent(
      // Changed from calendar to repeat (suggests adaptation/cycling)
      icon: FontAwesomeIcons.repeat,
      title: 'Adaptive Training Plans',
      description:
          'Your schedule shapes your workouts. Intelligent planning adapts to your availability, energy levels, and recovery needs for sustainable progress.',
    ),
    IntroScreenContent(
      // Changed from chartLine to trophy (suggests achievement/tracking)
      icon: FontAwesomeIcons.trophy,
      title: 'Measure What Matters',
      description:
          'Track strength gains, body composition, and performance metrics. Watch your transformation unfold through powerful analytics and insights.',
    ),
    IntroScreenContent(
      // Changed from bolt to fire (suggests streaks/momentum)
      icon: FontAwesomeIcons.fire,
      title: 'Stay Motivated Daily',
      description:
          'Build unstoppable momentum with streak tracking, achievement badges, and personalized encouragement that keeps you coming back.',
    ),
  ];

  // SET 2: "Master Your Workouts" - Training execution focus
  static final List<IntroScreenContent> workoutExecutionContent = [
    IntroScreenContent(
      // Changed from play to video (clearer for demonstration)
      icon: FontAwesomeIcons.video,
      title: 'HD Exercise Library',
      description:
          'Access 500+ exercises with professional video demonstrations. Master perfect form through multiple angles and slow-motion breakdowns.',
    ),
    IntroScreenContent(
      // Changed from clipboardList to listCheck (structured completion)
      icon: FontAwesomeIcons.listCheck,
      title: 'Structured Sessions',
      description:
          'Every rep, set, and rest period precisely timed. Stay in the zone with workout flows designed by certified strength coaches.',
    ),
    IntroScreenContent(
      // Changed from weightHanging to arrowUpWideShort (suggests increase)
      icon: FontAwesomeIcons.arrowUpWideShort,
      title: 'Progressive Overload',
      description:
          'Automatically increase intensity as you adapt. Smart weight recommendations ensure continuous muscle growth and strength gains.',
    ),
    IntroScreenContent(
      // Changed from clockRotateLeft to bookOpen (journal/record)
      icon: FontAwesomeIcons.bookOpen,
      title: 'Workout History',
      description:
          'Review every session with detailed logs. Replay past workouts to maintain consistency or push for new personal records.',
    ),
  ];

  // SET 3: "Complete Fitness Ecosystem" - Holistic health approach
  static final List<IntroScreenContent> lifestyleContent = [
    IntroScreenContent(
      // Changed from appleWhole to utensils (general food/nutrition)
      icon: FontAwesomeIcons.utensils,
      title: 'Nutrition Intelligence',
      description:
          'Macro tracking meets meal planning. Get personalized nutrition targets and recipes that fuel your training and recovery.',
    ),
    IntroScreenContent(
      // Changed from moon to bed (sleep/recovery)
      icon: FontAwesomeIcons.bed,
      title: 'Recovery Tracking',
      description:
          'Monitor sleep quality, soreness levels, and stress indicators. Optimize rest days to come back stronger and prevent burnout.',
    ),
    IntroScreenContent(
      // Changed from peopleGroup to usersLine (community/lineup)
      icon: FontAwesomeIcons.usersLine,
      title: 'Social Accountability',
      description:
          'Share workouts, join challenges, and train with friends. Transform fitness into a shared journey that multiplies motivation.',
    ),
    IntroScreenContent(
      // Changed from crown to medal (competition/reward)
      icon: FontAwesomeIcons.medal,
      title: 'Leaderboards & Challenges',
      description:
          'Compete in monthly fitness challenges, climb leaderboards, and earn exclusive rewards. Turn competition into personal growth.',
    ),
  ];

  // SET 4: "Movement & Mobility" - Functional fitness and recovery
  static final List<IntroScreenContent> wellnessContent = [
    IntroScreenContent(
      // Changed from yinYang to personHiking (movement/flow)
      icon: FontAwesomeIcons.personHiking,
      title: 'Yoga & Flexibility',
      description:
          'Enhance range of motion with guided yoga flows and dynamic stretching. Improve posture, reduce tension, and find balance.',
    ),
    IntroScreenContent(
      // Changed from heart to personRunning (classic cardio)
      icon: FontAwesomeIcons.personRunning,
      title: 'Cardio Optimization',
      description:
          'Zone-based training for runners, cyclists, and cardio enthusiasts. Build endurance intelligently without overtraining.',
    ),
    IntroScreenContent(
      icon: FontAwesomeIcons.spa,
      title: 'Active Recovery Days',
      description:
          'Low-intensity movement protocols that accelerate healing. Gentle flows, foam rolling guides, and mobility drills keep you moving.',
    ),
    IntroScreenContent(
      icon: FontAwesomeIcons.bandage,
      title: 'Injury Prevention',
      description:
          'Prehab exercises targeting common weak points. Strengthen stabilizers, improve joint health, and train pain-free for life.',
    ),
  ];

  static final List<IntroScreenContent> performanceContent = [
    IntroScreenContent(
      icon: FontAwesomeIcons.robot,
      title: 'AI Training Coach',
      description:
          'Machine learning analyzes your performance patterns, suggesting optimal training splits, deload weeks, and intensity adjustments.',
    ),
    IntroScreenContent(
      icon: FontAwesomeIcons.cameraRetro,
      title: 'Biomechanics Analysis',
      description:
          'Upload form videos for AI-powered technique feedback. Identify movement inefficiencies and unlock hidden strength potential.',
    ),
    IntroScreenContent(
      icon: FontAwesomeIcons.chartColumn,
      title: 'Performance Metrics',
      description:
          'Track velocity-based training, rate of perceived exertion, and volume load. Dive deep into training science for maximum adaptation.',
    ),
    IntroScreenContent(
      icon: FontAwesomeIcons.hourglass,
      title: 'Periodization Plans',
      description:
          'Multi-month training cycles with planned peaks and recovery phases. Train like a professional athlete with scientific programming.',
    ),
  ];

  static List<IntroScreenContent> getContentForType(String contentType) {
    switch (contentType.toLowerCase()) {
      case 'execution':
      case 'training':
      case 'workout':
        return workoutExecutionContent;
      case 'lifestyle':
      case 'community':
      case 'social':
        return lifestyleContent;
      case 'wellness':
      case 'yoga':
      case 'mobility':
      case 'recovery':
        return wellnessContent;
      case 'performance':
      case 'advanced':
      case 'elite':
        return performanceContent;
      default:
        return introContent;
    }
  }

  // Method to get random content for variety
  static List<IntroScreenContent> getRandomContent() {
    final allContentSets = [
      introContent,
      workoutExecutionContent,
      lifestyleContent,
      wellnessContent,
      performanceContent,
    ];
    allContentSets.shuffle();
    return allContentSets.first;
  }

  // Method to get a mixed intro experience (one slide from each set)
  static List<IntroScreenContent> getMixedIntroExperience() {
    return [
      introContent[0], // Smart Goal Setting
      workoutExecutionContent[0], // HD Exercise Library
      lifestyleContent[0], // Nutrition Intelligence
      wellnessContent[0], // Yoga & Flexibility
    ];
  }

  // Method to get beginner-focused content
  static List<IntroScreenContent> getBeginnerContent() {
    return [
      introContent[0], // Smart Goal Setting
      introContent[1], // Adaptive Training Plans
      workoutExecutionContent[0], // HD Exercise Library
      lifestyleContent[2], // Social Accountability
    ];
  }

  // Method to get advanced athlete content
  static List<IntroScreenContent> getAdvancedContent() {
    return [
      performanceContent[0], // AI Training Coach
      workoutExecutionContent[2], // Progressive Overload
      performanceContent[2], // Performance Metrics
      performanceContent[3], // Periodization Plans
    ];
  }
}
