import 'package:flutter/material.dart';
import 'login_page.dart'; // Import the login page
import 'home_page.dart';

// GLOBAL: Fade Transition for all route changes
class FadeTransitionBuilder extends PageTransitionsBuilder {
  const FadeTransitionBuilder();

  @override
  Widget buildTransitions<T>(
    PageRoute<T> route,
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return FadeTransition(opacity: animation, child: child);
  }
}

void main() {
  runApp(TravelBookingApp());
}

class TravelBookingApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Travel Booking App',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'Montserrat',
        pageTransitionsTheme: PageTransitionsTheme(
          builders: {
            for (final platform in TargetPlatform.values)
              platform: const FadeTransitionBuilder(),
          },
        ),
      ),
      home: LoginPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> with TickerProviderStateMixin {
  late AnimationController _textAnimationController;
  late AnimationController _planeAnimationController;

  late Animation<Offset> _planePositionAnimation;
  late Animation<double> _planeScaleAnimation;
  late Animation<double> _shadowScaleAnimation;
  late Animation<double> _shadowOpacityAnimation;

  @override
  void initState() {
    super.initState();

    _textAnimationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );

    _planeAnimationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    );

    // Position anim: from left side of the screen to the right side
    _planePositionAnimation = Tween<Offset>(
      begin: Offset(-1.0, 0.0),  // Start from the left side
      end: Offset(1.0, -1.5),    // Move to the right and slightly up
    ).animate(
      CurvedAnimation(
        parent: _planeAnimationController,
        curve: Curves.easeInOutCubic,
      ),
    );

    // Plane slightly scales up during ascending takeoff
    _planeScaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.1,
    ).animate(
      CurvedAnimation(
        parent: _planeAnimationController,
        curve: Curves.easeInOut,
      ),
    );

    // Shadow scales up initially (ground contact), then fades & shrinks as plane lifts off
    _shadowScaleAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.5).chain(CurveTween(curve: Curves.easeIn)), weight: 60),
      TweenSequenceItem(tween: Tween(begin: 1.5, end: 0.3).chain(CurveTween(curve: Curves.easeOut)), weight: 40),
    ]).animate(_planeAnimationController);

    _shadowOpacityAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0.5, end: 0.5), weight: 60),
      TweenSequenceItem(tween: Tween(begin: 0.5, end: 0.0), weight: 40),
    ]).animate(_planeAnimationController);

    _textAnimationController.forward().whenComplete(() {
      _planeAnimationController.forward();
    });

    Future.delayed(Duration(seconds: 5), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    });
  }

  @override
  void dispose() {
    _textAnimationController.dispose();
    _planeAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tealColor = Colors.teal.shade700;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Sky gradient background
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.lightBlue.shade200,
                    Colors.white,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ),

          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Animated airplane with takeoff motion
                SlideTransition(
                  position: _planePositionAnimation,
                  child: ScaleTransition(
                    scale: _planeScaleAnimation,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        // Shadow below plane scaling and fading
                        ScaleTransition(
                          scale: _shadowScaleAnimation,
                          child: FadeTransition(
                            opacity: _shadowOpacityAnimation,
                            child: Container(
                              width: 100,
                              height: 20,
                              decoration: BoxDecoration(
                                color: Colors.black26,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black38,
                                    blurRadius: 10,
                                    spreadRadius: 1,
                                    offset: Offset(0, 0),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),

                        // Airplane image - stable public PNG with transparent bg
                        Image.network(
                          'https://upload.wikimedia.org/wikipedia/commons/thumb/6/69/Airplane_silhouette.svg/120px-Airplane_silhouette.svg.png',
                          width: 100,
                          height: 100,
                          fit: BoxFit.contain,
                          semanticLabel: 'Silhouette of airplane taking off, flying upwards',
                          errorBuilder: (context, error, stackTrace) {
                            return Icon(Icons.flight_takeoff, size: 100, color: tealColor);
                          },
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 26),

                FadeTransition(
                  opacity: _textAnimationController,
                  child: Column(
                    children: [
                      Text(
                        'Welcome to TripJr!',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: tealColor,
                          letterSpacing: 1.1,
                        ),
                      ),
                      SizedBox(height: 18),
                      Text(
                        'Get ready for your next adventure',
                        style: TextStyle(
                          fontSize: 16,
                          color: tealColor.withOpacity(0.7),
                          letterSpacing: 0.8,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}