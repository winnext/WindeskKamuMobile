//aeh preprod
import 'package:shared_preferences/shared_preferences.dart';

const BASE_URL = "https://digipay-test.ardsistem.com.tr/api/";
//----
const updateNotication = "v1/Notification/UpdateNotification";
const addNotification = "v1/Notification/AddNotification";

//const BASE_URL_V2 = "http://windeskmobiletest.ish.yerel";
//const BASE_URL_V2 = "http://windeskmobile.ish.yerel";
//const BASE_URL_V2 = "http://windeskmobile.signumtte.com";
//const BASE_URL_V2 = 'http://windeskmobiletest.tekirdag.yerel';

//ESH PROD
const BASE_URL_V2 = 'http://windeskmobile.eskisehir.yerel';

//const TOKEN_V1 = "wdishtest!_";
//const TOKEN_V1 = "wdishliveSqAS!_";
//const TOKEN_V1 = "wddemo!_";
//const TOKEN_V1 = 'wdmesktest!_';

//ESH PROD
const TOKEN_V1 = 'wdeshprod!_';

//const TOKEN_V2 = "ishtest!";
//const TOKEN_V2 = 'ishprod!';
//const TOKEN_V2 = 'demo!';
//const TOKEN_V2 = 'tkdtest!';

//ESH PROD
const TOKEN_V2 = 'eshprod!';

// const ATTACHPATHLIVE =
//       "http://10.32.12.42/windesktest/xreadattach.php?token=${TOKEN_V1}&id=";
// const ATTACHPATHLIVE =
// "http://10.32.12.22/windesk/xreadattach.php?token=${TOKEN_V1}&id=";

//  const ATTACHPATHLIVE =
//       "http://10.32.12.42/windesktest/xreadattach.php?token=${TOKEN_V1}&id=";
//  const ATTACHPATHLIVE =
//      "http://10.159.11.81/windesktest/xreadattach.php?token=${TOKEN_V1}&id=";

//ESH PROD
const ATTACHPATHLIVE =
"http://10.126.12.141/windesk/xreadattach.php?token=${TOKEN_V1}&id=";

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
// const base_url_v1 =
//     'https://demo.signumtte.com/windesk/app/webroot/integration/WindeskMobile.php?use_rest=1&wsusername=' +
//         'wdmobile' +
//         '&wspassword=' +
//         'wdsgnm1017_' +
//         '&token=';

// const base_url_v1 =
//     'http://10.159.11.81/windesktest/app/webroot/integration/WindeskMobile.php?use_rest=1&wsusername=' +
//         'wdmobile' +
//         '&wspassword=' +
//         'wdsgnm1017_' +
//         '&token=';

//ESH PROD
const base_url_v1 =
    'http://10.126.12.141/windesk/app/webroot/integration/WindeskMobile.php?use_rest=1&wsusername=' +
        'wdmobile' +
        '&wspassword=' +
        'wdsgnm1017_' +
        '&token=';

// aktiviteekle = https://demo.signumtte.com/windesk/app/webroot/integration/WindeskMobile.php?use_rest=1&wsusername=
// wdmobile&wspassword=wdsgnm1017_&token=wddemo!_C82C122E-2B51-4DF2-943B-434C575C10E7&action=getAvailableActivities&issueCode=
// AEH00109987&module=issue

const attachpath = 'http://10.32.12.22/windesk/';
