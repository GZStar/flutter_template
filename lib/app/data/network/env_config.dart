import '../../common/values/storage_key.dart';
import '../local/store/storage_service.dart';

/// APP中可能存在多个域名请求数据的情况，所以根据参数获取对应域名URL
enum DomainNameType {
  normal,

  /// 常规域名
  version,

  /// 版本升级域名
}

/// 路径中可能存在不同的前缀路径，所以根据参数获取对应前缀路径
enum URLPathType {
  normal,

  /// 常规前缀
  allUrl,

  /// 不使用domainNameType,直接使用path中的全url作为地址。
}

class EnvConfig {
  static final String server =
      StorageService.to.getString(StorageKeys.localEnvironment);

  static const Map<DomainNameType, Map<String, String>> domainNames = {
    DomainNameType.normal: normailDomainName,
    DomainNameType.version: versionDomainName,
  };

  /// APP 默认域名
  static const Map<String, String> normailDomainName = {
    'dev': 'https://dev-xxxx.com/customerapp',
    'test': 'https://test-xxxx.com/customerapp',
    'uat': 'https://uat-xxxx.com/customerapp',
    'prod': 'https://xxxx.com/customerapp',
  };

  /// 版本升级域名
  static const Map<String, String> versionDomainName = {
    'dev': 'https://dev-xxx.xxxx.com.cn',
    'test': 'https://test-xxx.xxxx.com.cn',
    'uat': 'https://uat-xxx.xxxx.com.cn',
    'prod': 'https://xxx.xxxx.com.cn',
  };

  static pathTypeUrlDic(String baseURL) {
    return {URLPathType.normal: baseURL, URLPathType.allUrl: ""};
  }

  static getPathTypeUrlDic(DomainNameType type) {
    Map dn = domainNames[type]!;
    switch (server) {
      case 'uat':
        return pathTypeUrlDic(dn['uat']);
      case 'test':
        return pathTypeUrlDic(dn['test']);
      case 'dev':
        return pathTypeUrlDic(dn['dev']);
      default:
        return pathTypeUrlDic(dn['prod']);
    }
  }
}
