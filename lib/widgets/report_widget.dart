import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:wien_tech_admin/models/media_model.dart';
import 'package:wien_tech_admin/models/post_model.dart';

import 'package:wien_tech_admin/models/reports_model.dart';
import 'package:wien_tech_admin/models/user_model.dart';
import 'package:wien_tech_admin/pages/reports_detail_page.dart';
import 'package:wien_tech_admin/pages/user_detail_page.dart';

class ReportWidget extends StatelessWidget {
  final Report report;
  const ReportWidget({super.key, required this.report});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (ctx) => ReportDetailPage(report: report)),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 240, 240, 240),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              Column(
                children: [
                  _userInfo(context: context, user: report.reporterUser),
                  Icon(Icons.keyboard_arrow_down),
                  _userInfo(context: context, user: report.reportedUser),
                  if (report.reportTargetType == 'post')
                    report.post != null
                        ? _postReport(post: report.post!)
                        : Text('Bu post silinmiş'),
                  if (report.reportTargetType == 'user')
                    Text('Profil Şikayeti, bu profili incele'),
                  if (report.reportTargetType == 'conversation')
                    _conversationReport(
                      message: report.message,
                      mediaList: report.mediaList!,
                    ),

                  _reportTypes(
                    context: context,
                    reportType: report.reportType,
                    repostTargetType: report.reportTargetType,
                    colorOne: const Color.fromARGB(255, 225, 37, 99),
                    colorTwo: const Color.fromARGB(255, 45, 106, 220),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _userInfo({required BuildContext context, required User user}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => UserDetailPage(user: user)),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              spacing: 10,
              children: [
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(shape: BoxShape.circle),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(80),
                    child: CachedNetworkImage(
                      fit: BoxFit.cover,
                      placeholder: (c, _) => const SizedBox(),
                      cacheKey: user.profilePhotoKey,
                      imageUrl: user.profilePhotoUrl,
                      errorWidget: (context, url, error) =>
                          Icon(Icons.broken_image, color: Colors.grey),
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      user.userName,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(user.id),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _postReport({required Post post}) {
    return Container(
      height: 300,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      child: Image.network(post.mediaList[0].cdnUrl, fit: BoxFit.cover),
    );
  }

  Widget _conversationReport({
    required List<EvidenceMediaModel> mediaList,
    required String message,
  }) {
    return Container(
      height: 300,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      child: Image.network(mediaList[0].cdnUrl, fit: BoxFit.cover),
    );
  }

  Widget _reportTypes({
    required String repostTargetType,
    required String reportType,
    required BuildContext context,
    required Color colorOne,
    required Color colorTwo,
  }) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Wrap(
        spacing: 5,
        alignment: WrapAlignment.end,
        children: [
          Chip(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            backgroundColor: colorOne,
            label: Text(
              repostTargetType,
              style: TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Chip(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            backgroundColor: colorTwo,
            label: Text(
              reportType,
              style: TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
