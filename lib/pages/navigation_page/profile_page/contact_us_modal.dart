import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:dinde_market/utility/utilities.dart';  // Assuming Utilities class exists in your project.

class ContactUsModal {
  static void showImageModal({
    required BuildContext context,
  }) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            color: Colors.white,
          ),
          height: Utilities.setWidgetHeightByPercentage(context, 40),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: const Text(
                  'Visit Our Partners',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildImageLink(
                    context,
                    'https://w7.pngwing.com/pngs/704/270/png-transparent-social-media-instagram-login-graphy-ig-instagram-icon-rectangle-magenta-mobile-phones-thumbnail.png', // Image URL
                    'https://www.instagram.com/omks_video/?hl=en', // Website URL
                  ),
                  _buildImageLink(
                    context,
                    'https://upload.wikimedia.org/wikipedia/commons/thumb/8/82/Telegram_logo.svg/2048px-Telegram_logo.svg.png',
                    'https://wa.me/+79652202547',
                  ),
                  _buildImageLink(
                    context,
                    'https://static.vecteezy.com/system/resources/previews/023/986/562/original/telegram-logo-telegram-logo-transparent-telegram-icon-transparent-free-free-png.png',
                    'https://t.me/atabek_dev',
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  static Widget _buildImageLink(
      BuildContext context, String imageUrl, String websiteUrl) {
    return GestureDetector(
      onTap: () => _launchURL(websiteUrl),
      child: Image.network(
        imageUrl,
        width: Utilities.setWidgetWidthByPercentage(context, 20),  // Adjust width as needed
        height: Utilities.setWidgetHeightByPercentage(context, 15),  // Adjust height as needed
        fit: BoxFit.contain,
      ),
    );
  }

  static void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
