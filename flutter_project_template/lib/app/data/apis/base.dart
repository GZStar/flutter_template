import '../network/env_config.dart';
import 'package:dio/dio.dart';

class RequestTargetModel {
  String path;
  Method method;
  dynamic params;
  int successCode = 1;
  DomainNameType domainNameType;
  URLPathType pathType;
  FormData? file;

  RequestTargetModel({
    required this.path,
    this.method = Method.get,
    this.params,
    this.successCode = 1,
    this.domainNameType = DomainNameType.normal,
    this.pathType = URLPathType.normal,
  });
}

enum Method { get, post, put, patch, delete, head }

/// 使用：MethodValues[Method.post]
// ignore: constant_identifier_names
const MethodValues = {
  Method.get: 'GET',
  Method.post: 'POST',
  Method.delete: 'DELETE',
  Method.put: 'PUT',
  Method.patch: 'PATCH',
  Method.head: 'HEAD',
};
