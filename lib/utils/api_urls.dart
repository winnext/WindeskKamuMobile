//aeh preprod
import 'package:shared_preferences/shared_preferences.dart';

const BASE_URL = "https://digipay-test.ardsistem.com.tr/api/";
//----
const updateNotication = "v1/Notification/UpdateNotification";
const addNotification = "v1/Notification/AddNotification";

//const BASE_URL_V2 = "http://windeskmobiletest.ish.yerel";
//const BASE_URL_V2 = "http://windeskmobile.ish.yerel";
const BASE_URL_V2 = "http://windeskmobile.signumtte.com";


//const TOKEN_V1 = "wdishtest!_";
//const TOKEN_V1 = "wdishliveSqAS!_";
const TOKEN_V1 = "wddemo!_";



//const TOKEN_V2 = "ishtest!";
//const TOKEN_V2 = 'ishprod!';
const TOKEN_V2 = 'demo!';


// const ATTACHPATHLIVE =
//      "http://10.32.12.42/windesktest/xreadattach.php?token=${TOKEN_V1}&id=";

// const ATTACHPATHLIVE =
// "http://10.32.12.22/windesk/xreadattach.php?token=${TOKEN_V1}&id=";

const ATTACHPATHLIVE =
"https://demo.signumtte.com/windesk/xreadattach.php?token=${TOKEN_V1}&id=";

const loginUrl = "v1/Auth/Login";

// const base_url_v1 =
//     'http://10.32.12.42/windesktest/app/webroot/integration/WindeskMobile.php?use_rest=1&wsusername=' +
//         'wdmobile' +
//         '&wspassword=' +
//         'wdsgnm1017_' +
//         '&token=';
// const base_url_v1 =
//     'http://10.32.12.22/windesk/app/webroot/integration/WindeskMobile.php?use_rest=1&wsusername=' +
//         'wdmobile' +
//         '&wspassword=' +
//         'wdsgnm1017_' +
//         '&token=';
const base_url_v1 =
    'https://demo.signumtte.com/windesk/app/webroot/integration/WindeskMobile.php?use_rest=1&wsusername=' +
        'wdmobile' +
        '&wspassword=' +
        'wdsgnm1017_' +
        '&token=';
