import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:wien_tech_admin/config.dart';
import 'package:wien_tech_admin/models/bio_model.dart';
import 'package:wien_tech_admin/models/log_model.dart';
import 'package:wien_tech_admin/models/post_model.dart';
import 'package:wien_tech_admin/models/profile_photo_model.dart';
import 'package:wien_tech_admin/models/reports_model.dart';
import 'package:wien_tech_admin/models/supports_model.dart';
import 'package:wien_tech_admin/models/user_model.dart';

class ApiService {
  static final Dio dio = Dio(
    BaseOptions(
      validateStatus: (status) {
        return status! < 500;
      },
    ),
  );
  static Future<bool> login({
    required String userName,
    required String pass,
  }) async {
    final req = await dio.post(
      'path',
      data: {'user_name': userName, 'password': pass},
    );

    return req.data['status'];
  }

  static Future<UserModel> getUsers({Cursor? cursor}) async {
    try {
      final req = await dio.post('$apiBaseUrl/users/get/for/admin');
      print(req.data);
      return UserModel.fromJson(req.data);
    } catch (e, st) {
      debugPrint(st.toString());
      return UserModel.fromJson({});
    }
  }

  static Future<PostModel> getPosts({Cursor? cursor, String? userId}) async {
    try {
      final req = await dio.post(
        '$apiBaseUrl/post/get/for/admin',
        data: {'user_id': userId, 'cursor': cursor},
      );
      print(req.data);
      return PostModel.fromJson(req.data);
    } catch (e, st) {
      print('hataaaa');
      debugPrint(st.toString());
      return PostModel.fromJson({});
    }
  }

  static Future<ProfilePhotoModel> getProfilePhotos({Cursor? cursor}) async {
    try {
      final req = await dio.post(
        '$apiBaseUrl/get/profile/photos/for/admin',
        data: {'cursor': cursor},
      );
      print(req.data);
      return ProfilePhotoModel.fromJson(req.data);
    } catch (e, st) {
      print('hataaaa');
      debugPrint(st.toString());
      return ProfilePhotoModel.fromJson({});
    }
  }

  static Future<BioModel> getBioList({Cursor? cursor}) async {
    try {
      final req = await dio.post(
        '$apiBaseUrl/get/bios/for/admin',
        data: {'cursor': cursor},
      );
      print(req.data);
      return BioModel.fromJson(req.data);
    } catch (e, st) {
      print('hataaaa');
      debugPrint(st.toString());
      return BioModel.fromJson({});
    }
  }

  static Future<bool> removePost({required String? postId}) async {
    try {
      final req = await dio.post(
        '$apiBaseUrl/post/remove/from/admin',
        data: {'post_id': postId},
      );
      print(req.data);
      return req.data['status'];
    } catch (e, st) {
      debugPrint(st.toString());
      return false;
    }
  }

  static Future<bool> removeProfilePhoto({
    required String? userId,
    required String? mediaKey,
  }) async {
    try {
      final req = await dio.post(
        '$apiBaseUrl/remove/from/admin/profile_photo',
        data: {'user_id': userId, 'mediaKey': mediaKey},
      );
      print(req.data);
      return req.data['status'];
    } catch (e, st) {
      debugPrint(st.toString());
      return false;
    }
  }

  static Future<bool> removeBio({required String? userId}) async {
    try {
      final req = await dio.post(
        '$apiBaseUrl/remove/user/bio/from/admin',
        data: {'user_id': userId},
      );
      print(req.data);
      return req.data['status'];
    } catch (e, st) {
      debugPrint(st.toString());
      return false;
    }
  }

  static Future<LogModel> getUserLogs({required String userId}) async {
    try {
      final req = await dio.post(
        '$apiBaseUrl/logs/get/for/admin',
        data: {'user_id': userId},
      );
      print(req.data);
      return LogModel.fromJson(req.data);
    } catch (e, st) {
      print(e);
      debugPrint(st.toString());
      return LogModel.fromJson({});
    }
  }

  static Future<ReportModel> getReports({Cursor? cursor}) async {
    try {
      final req = await dio.post('$apiBaseUrl/get/reports/for/admin', data: {});
      return ReportModel.fromJson(req.data);
    } catch (e, st) {
      debugPrint(st.toString());
      return ReportModel.fromJson({});
    }
  }

  static Future<SupportModel> getSupports({Cursor? cursor}) async {
    try {
      final req = await dio.post(
        '$apiBaseUrl/get/supports/for/admin',
        data: {},
      );
      return SupportModel.fromJson(req.data);
    } catch (e, st) {
      debugPrint(st.toString());
      return SupportModel.fromJson({});
    }
  }

  static Future<bool> sendReportResponse() async {
    final req = await dio.post('path');

    return req.data['status'];
  }

  static Future<bool> getSupportRequests() async {
    final req = await dio.get('path');

    return req.data['status'];
  }

  static Future<bool> sendSupportRepose() async {
    final req = await dio.post('/path');

    return req.data['status'];
  }

  static Future<bool> blockUser() async {
    final req = await dio.get('path');

    return req.data['status'];
  }

  static Future<bool> deleteUser() async {
    final req = await dio.get('path');

    return req.data['status'];
  }

  static Future<bool> blockTemporaryUser() async {
    final req = await dio.post('path');

    return req.data['status'];
  }
}
