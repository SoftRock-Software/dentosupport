abstract class EndPoint {
  static const user = '/user';
  static const sendOtp = '$user/sendOTP';
  static const verifyOtp = '$user/verifyOTP';
  static const signup = '$user/signup';
  static const getMe = '$user/getMe';

  static const clinic = '/clinic';
  static const patient = '/patient';
  static const treatment = '/treatment';
  static const transaction = '/transaction';
  static const medicalHistory = '/medicalHistory';

  static const patientSearch = '/patient/search';
  static const visitorSchedule = '/visitor/schedule';

  static const visitorInfoByDate = '/visitor/info/visiterInfoByDate';
  static const countOfVisitors = '/visitor/info/countOfVisitors';
  static const missedVisitors = '/visitor/info/findNotVisited';
}
