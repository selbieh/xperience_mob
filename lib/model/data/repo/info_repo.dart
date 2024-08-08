import 'package:flutter/material.dart';
import 'package:xperience/model/data/datasource/info_data_source.dart';
import 'package:xperience/model/models/faq_model.dart';
import 'package:xperience/model/models/pagination_model.dart';
import 'package:xperience/model/models/policy_model.dart';
import 'package:xperience/model/services/api/app_failure.dart';
import 'package:xperience/model/services/api/either.dart';

class InfoRepo extends ChangeNotifier {
  PaginationModel<FaqModel>? faqsPaginated;
  PolicyModel? privacyPolicy;
  PolicyModel? cancellationPolicy;
  PolicyModel? termsOfUse;
  PolicyModel? aboutUs;

  Future<Either<AppFailure, PaginationModel<FaqModel>>> getFaqs() async {
    try {
      var res = await InfoDataSource.getFaqs(
        queryParams: {
          "offset": "0",
          "limit": "200",
        },
      );
      if (res.left != null) {
        return Either(left: res.left);
      } else {
        faqsPaginated = res.right;
        return Either(right: faqsPaginated);
      }
    } catch (e) {
      return Either(left: AppFailure(message: e.toString()));
    }
  }

  Future<Either<AppFailure, PolicyModel>> getPrivacyPolicy() async {
    try {
      var res = await InfoDataSource.getPrivacy(
        queryParams: {"key": "privacy"},
      );
      if (res.left != null) {
        return Either(left: res.left);
      } else {
        privacyPolicy = res.right;
        return Either(right: privacyPolicy);
      }
    } catch (e) {
      return Either(left: AppFailure(message: e.toString()));
    }
  }

  Future<Either<AppFailure, PolicyModel>> getTermsOfUse() async {
    try {
      var res = await InfoDataSource.getPrivacy(
        queryParams: {"key": "terms"},
      );
      if (res.left != null) {
        return Either(left: res.left);
      } else {
        termsOfUse = res.right;
        return Either(right: termsOfUse);
      }
    } catch (e) {
      return Either(left: AppFailure(message: e.toString()));
    }
  }

  Future<Either<AppFailure, PolicyModel>> getAboutUs() async {
    try {
      var res = await InfoDataSource.getPrivacy(
        queryParams: {"key": "about"},
      );
      if (res.left != null) {
        return Either(left: res.left);
      } else {
        aboutUs = res.right;
        return Either(right: aboutUs);
      }
    } catch (e) {
      return Either(left: AppFailure(message: e.toString()));
    }
  }

  Future<Either<AppFailure, PolicyModel>> getCancellationPolicy() async {
    try {
      var res = await InfoDataSource.getPrivacy(
        queryParams: {"key": "cancellation"},
      );
      if (res.left != null) {
        return Either(left: res.left);
      } else {
        cancellationPolicy = res.right;
        return Either(right: cancellationPolicy);
      }
    } catch (e) {
      return Either(left: AppFailure(message: e.toString()));
    }
  }
}
