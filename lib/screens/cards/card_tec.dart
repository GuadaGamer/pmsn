import 'package:flutter/material.dart';
import 'package:psmnn/responsive.dart';

class CardTecData {
  final String title;
  final String subtitle;
  final ImageProvider image;
  final Color backgraundColor;
  final Color titleColor;
  final Color subtitleColor;
  final Widget? backgraund;

  const CardTecData({
    required this.title,
    required this.subtitle,
    required this.image,
    required this.backgraundColor,
    required this.titleColor,
    required this.subtitleColor,
    this.backgraund,
  });
}

class CardTec extends StatelessWidget {
  const CardTec({required this.data, super.key});

  final CardTecData data;

  @override
  Widget build(BuildContext context) {
    return Responsive(
      mobile: Stack(
        children: [
          if(data.backgraund != null) data.backgraund!,
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 40,
            ),
            child: Column(
              children: [
                const Spacer(flex: 3,),
                Flexible(
                  flex: 20,
                  child: Image(image: data.image)),
                const Spacer(flex: 1,),
                Text(
                  data.title.toUpperCase(),
                  style: TextStyle(
                    color: data.titleColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                  ),
                ),
                const Spacer(flex: 1,),
                Text(
                  data.subtitle,
                  style: TextStyle(
                    color: data.subtitleColor,
                    fontSize: 15,
                    letterSpacing: 1,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 4,
                )
              ],
            ),
          ),
        ],
      ),
      desktop: Stack(
        children: [
          if (data.backgraund != null) data.backgraund!,
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 260),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Image(image: data.image),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        data.title.toUpperCase(),
                        style: TextStyle(
                            color: data.titleColor,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1),
                            textAlign: TextAlign.center,
                        maxLines: 2,
                      ),
                      const SizedBox(
                        height: 10,
                      ), 
                     
                      Container(
                        height: 200,
                        width: 300,
                        child: Text(
                          data.subtitle,
                          style: TextStyle(
                            color: data.subtitleColor,
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.center,
                          textWidthBasis: TextWidthBasis.longestLine,
                          maxLines: 9,
                        ),
                      ),
                      
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
