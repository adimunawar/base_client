// ignore_for_file: avoid_print

import 'package:latihan100/controller/base_controller.dart';
import 'package:latihan100/helper/base_client.dart';
import 'package:get/get.dart';

class TestController extends GetxController with BaseController {
  void getData() async {
    showLoading('Fetching data');
    var response = await BaseClient()
        .get('https://jsonplaceholder.typicode.com', '/todos/1')
        .catchError(handleError);
    if (response == null) return;
    hideLoading();
    showSuccessDialog();
  }

  // void postData() async {
  //   var request = {'message': 'CodeX sucks!!!'};
  //   showLoading('Posting data...');
  //   var response = await BaseClient()
  //       .post('https://jsonplaceholder.typicode.com', '/posts', request)
  //       .catchError((error) {
  //     if (error is BadRequestException) {
  //       var apiError = json.decode(error.message!);
  //       DialogHelper.showErroDialog(description: apiError["reason"]);
  //     } else {
  //       handleError(error);
  //     }
  //   });
  //   if (response == null) return;
  //   hideLoading();
  //   print(response);
  // }
}
