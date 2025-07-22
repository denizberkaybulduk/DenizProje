import '../Service/api/login_service.dart';


class LoginRepository {
  final LoginService _loginService;


  LoginRepository(this._loginService);

  Future<bool> login(String email, String password) async {
    // API ve local login'i eş zamanlı kontrol et
    final apiResult = await _loginService.login(email, password);


    // En az biri başarılıysa true dön
    return apiResult;
  }
}