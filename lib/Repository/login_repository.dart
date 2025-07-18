import '../Service/local/local_login_service.dart';
import '../Service/api/login_service.dart';


class LoginRepository {
  final LoginService _loginService;
  final LocalLoginService _localLoginService;

  LoginRepository(this._loginService, this._localLoginService);

  Future<bool> login(String email, String password) async {
    // API ve local login'i eş zamanlı kontrol et
    final apiResult = await _loginService.login(email, password);
    final localResult = await _localLoginService.login(email, password);

    // En az biri başarılıysa true dön
    return apiResult || localResult;
  }
}