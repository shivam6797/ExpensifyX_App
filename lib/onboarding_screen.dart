import 'package:ExpensifyX_App/app_routes.dart';
import 'package:flutter/material.dart';

class OnboardingScreeen extends StatelessWidget {
  const OnboardingScreeen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/monety_logo.png',
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    "Monety",
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  Positioned(
                    bottom: 65,
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: 400,
                      decoration: BoxDecoration(
                        color: const Color(0xFFf8f9fd),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "Easy way to monitor your expense",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 25,
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "Safe your future by managing your expense right now",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 15,
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.w500,
                              color: Color(0xffabacb3),
                            ),
                          ),
                          const SizedBox(height: 40),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 15.0, top: 5),
                                child: Row(
                                  children: [
                                    buildIndicator(false),
                                    buildIndicator(false),
                                    buildIndicator(true),
                                  ],
                                ),
                              ),
                              Align(
                                alignment: Alignment.bottomRight,
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.pushNamed(context, AppRoutes.ROUTE_LOGIN);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Color(0xffe78bbc),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    padding: const EdgeInsets.all(16),
                                  ),
                                  child: const Icon(Icons.arrow_forward,
                                      color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 2,
                    child: Image.asset(
                      'assets/images/splash_image.png',
                      width: 330,
                      height: 380,
                    ),
                  ),
                  Positioned(
                    top: 50,
                    left: 50,
                    child: Image.asset(
                      'assets/images/coin_dollar.png',
                      width: 60,
                      height: 60,
                    ),
                  ),
                  Positioned(
                    top: 30,
                    right: 80,
                    child: Image.asset(
                      'assets/images/image_arrow.png',
                      width: 70,
                      height: 70,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildIndicator(bool isActive) {
    return Container(
      width: 8,
      height: 8,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        color: isActive ? Color(0xffe4c994) : Colors.grey.shade400,
        shape: BoxShape.circle,
      ),
    );
  }
}
