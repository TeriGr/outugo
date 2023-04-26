import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import 'package:outugo_flutter_mobile/core/services/api/dio_client.dart';
import 'package:outugo_flutter_mobile/core/services/api/network_exceptions.dart';
import 'package:outugo_flutter_mobile/utils/constants/data_constants/api_constants.dart';
import 'package:outugo_flutter_mobile/utils/enums.dart';
import 'package:outugo_flutter_mobile/utils/functions.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

class ApiClient {
  late DioClient dioClient;
  final Dio dio;
  final Connectivity connectivity;
  Map<String, dynamic> defaultParams = {};

  ApiClient({
    required this.dio,
    required this.connectivity,
  }) {
    dioClient = DioClient(dio, connectivity: connectivity);
  }

  Future<Map<String, dynamic>> request(
      {required RequestType requestType,
      bool requiresAuth = false,
      bool requiresDefaultParams = false,
      String? port,
      required String path,
      Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? data}) async {
    try {
      log("request: $requestType $path");
      log("data: $data");
      log("queryParameters: $queryParameters");
      dioClient.updateBaseUrl(kBaseUrl);
      dioClient.hasHeaders();
      if (requiresAuth) await dioClient.addAuthorizationInterceptor();

      //log('sent payload: $data');
      dynamic response;
      switch (requestType) {
        case RequestType.get:
          response =
              await dioClient.get(path, queryParameters: queryParameters);
          break;
        case RequestType.post:
          response = await dioClient.post(path, data: data);
          break;
        case RequestType.patch:
          response = await dioClient.patch(path, data: data);
          break;
        case RequestType.delete:
          response = await dioClient.delete(path);
          break;
        case RequestType.put:
          response = await dioClient.put(path, data: data);
          break;
        default:
          throw "Request type not found.";
      }

      return (response is String) ? jsonDecode(response) : response;
    } on DioError catch (e) {
      final errorMessage = NetworkExceptions.getErrorMessage(
          NetworkExceptions.getDioException(e));
      log('Api Error: $errorMessage');
      log('Raw Error: ${e.response}');
      String error = "";

      try {
        error = e.response?.data['content'][0]['error'].toString() ?? "";
        if (error.isEmpty) error = e.response?.data['content'][0]['message'];
      } catch (e) {
      } finally {
        log("aaaaaaaaa ${path} ${data} ${e.requestOptions.uri}");
        if (error.isEmpty) error = "could not connect try again";
      }
      toast('error', error);
      return Future.error(
          {'main': NetworkExceptions.getDioException(e), 'message': error});
      //return NetworkExceptions.getDioException(e);
    }
  }

  getCrm(Map<String, dynamic> params) async {
    try {
      dioClient.updateBaseUrl(kMethodCRMURL);
      dioClient.hasHeaders(has: false);
      final response =
          await dioClient.get('MethodAPISelect_XMLV2', queryParameters: params);
      return response;
    } catch (e) {
      log("error $e");
    }
  }

  updateCrm(Map<String, dynamic> params) async {
    try {
      dioClient.updateBaseUrl(kMethodCRMUpdateURL);
      dioClient.hasHeaders(has: false);
      final response =
          await dioClient.get('MethodAPIUpdateV2', queryParameters: params);
      return response;
    } catch (e) {
      log("error $e");
    }
  }

  Future<dynamic> uploadImage(
    String url,
    File file,
    String name,
  ) async {
    var compressedFile = await compressAndGetFile(file);
    var response = await dioClient.postMultipart(url, compressedFile!, name);
    return (response is String) ? jsonDecode(response) : response;
  }

  Future<File?> compressAndGetFile(
    File file,
  ) async {
    var targetPath = await path_provider.getTemporaryDirectory().then((value) {
      return "${value.absolute.path}/temp.jpg";
    });
    var result = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      targetPath,
      quality: 40,
      rotate: 0,
      minHeight: 800,
      minWidth: 800,
    ).catchError((onError) {
      log("error $onError");
    });

    log("result size  ${result?.statSync().size}");
    return result;
  }

  // sends form data for single or multiple files
  Future<Map<String, dynamic>> sendFormData({
    required String fileFieldName,
    required Map<String, dynamic> formPayload,
    required String endPoint,
    String? port,
    File? file,
    List<File>? files,
  }) async {
    try {
      log("request: post $endPoint");
      log("formPayload: $formPayload");
      log("file: ${file?.path}");
      log("path: $endPoint");
      // For multiple files case
      if (files?.isNotEmpty ?? false) {
        List<MultipartFile> multipartFiles = [];
        for (File file in files!) {
          String? mimeType = lookupMimeType(file.path);
          List<String> splitMimeTypes = mimeType?.split('/') ?? [];

          final MultipartFile multipartFile = MultipartFile.fromFileSync(
              file.path,
              contentType: MediaType(splitMimeTypes[0], splitMimeTypes[1]));

          multipartFiles.add(multipartFile);
        }

        formPayload[fileFieldName] = multipartFiles;
      } else if (file?.path.isNotEmpty ?? false) {
        // case for single file form data
        String? mimeType = lookupMimeType(file!.path);
        List<String> splitMimeTypes = mimeType?.split('/') ?? [];

        final MultipartFile multipartFile = MultipartFile.fromFileSync(
            file.path,
            contentType: MediaType(splitMimeTypes[0], splitMimeTypes[1]));
        formPayload[fileFieldName] = multipartFile;
      }

      formPayload.addAll(defaultParams);
      log('form payload here: $formPayload');
      var formData = FormData.fromMap(formPayload);

      final response = await dioClient.post(endPoint, data: formData);
      // Iterable l = json.decode(jsonEncode(response));
      // return List<Files>.from(l.map((model) => Files.fromJson(model)).toList());

      return (response is String) ? jsonDecode(response) : response;
    } on DioError catch (e) {
      final errorMessage = NetworkExceptions.getErrorMessage(
          NetworkExceptions.getDioException(e));
      log('Api Error: $errorMessage');
      log('Raw Error: ${e.response}');
      String error = "";

      try {
        error = e.response?.data['content'][0]['error'].toString() ?? "";
        if (error.isEmpty) error = e.response?.data['content'][0]['message'];
      } catch (e) {
      } finally {
        log("bbbbbbb ${endPoint} ${formPayload} ${error}");
        if (error.isEmpty) error = "could not connect try again";
      }
      toast('error', error);
      return Future.error(
          {'main': NetworkExceptions.getDioException(e), 'message': error});
    }
  }
}
