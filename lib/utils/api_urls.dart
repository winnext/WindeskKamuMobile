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
//const BASE_URL_V2 = 'http://windeskmobile.eskisehir.yerel';

//const TOKEN_V1 = "wdishtest!_";
//const TOKEN_V1 = "wdishliveSqAS!_";
//const TOKEN_V1 = "wddemo!_";
//const TOKEN_V1 = 'wdmesktest!_';

//ESH PROD
//const TOKEN_V1 = 'wdeshprod!_';

//const TOKEN_V2 = "ishtest!";
//const TOKEN_V2 = 'ishprod!';
//const TOKEN_V2 = 'demo!';
//const TOKEN_V2 = 'tkdtest!';

//ESH PROD
//const TOKEN_V2 = 'eshprod!';
//
// const ATTACHPATHLIVE =
//       "http://10.32.12.42/windesktest/xreadattach.php?token=${TOKEN_V1}&id=";
// const ATTACHPATHLIVE =
// "http://10.32.12.22/windesk/xreadattach.php?token=${TOKEN_V1}&id=";

//  const ATTACHPATHLIVE =
//       "http://10.32.12.42/windesktest/xreadattach.php?token=${TOKEN_V1}&id=";
// //  const ATTACHPATHLIVE =
//      "http://10.159.11.81/windesktest/xreadattach.php?token=${TOKEN_V1}&id=";

//ESH PROD
// const ATTACHPATHLIVE =
// "http://10.126.12.141/windesk/xreadattach.php?token=${TOKEN_V1}&id=";

// const base_url_v1 =
//     'http://10.32.12.42/windesktest/app/webroot/integration/WindeskMobile.php?use_rest=1&wsusername=' +
//         'wdmobile' +
//         '&wspassword=' +
//         'wdsgnm1017_' +
//         '&token=';

//ISH PROD
// const BASE_URL_V2 = "http://windeskmobile.ish.yerel";
// const TOKEN_V1 = "wdishliveSqAS!_";
// const TOKEN_V2 = 'ishprod!';
// const ATTACHPATHLIVE =
// "http://10.32.12.22/windesk/xreadattach.php?token=${TOKEN_V1}&id=";
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

//WINMOBİLE
// const BASE_URL_V2 = "http://windeskmobile.signumtte.com";
// const TOKEN_V1 = "wddemo!_";
// const TOKEN_V2 = 'demo!';
//  const ATTACHPATHLIVE =
//       "http://10.32.12.42/windesktest/xreadattach.php?token=${TOKEN_V1}&id=";
// const base_url_v1 =
//     'https://demo.signumtte.com/windesk/app/webroot/integration/WindeskMobile.php?use_rest=1&wsusername=' +
//         'wdmobile' +
//         '&wspassword=' +
//         'wdsgnm1017_' +
//         '&token=';

//TKD PREPROD
//const BASE_URL_V2 = 'http://windeskmobiletest.tekirdag.yerel';
//const TOKEN_V1 = 'wdmesktest!_';
//const TOKEN_V2 = 'tkdtest!';
//  const ATTACHPATHLIVE =
//      "http://10.159.11.81/windesktest/xreadattach.php?token=${TOKEN_V1}&id=";
// const base_url_v1 =
//     'http://10.159.11.81/windesktest/app/webroot/integration/WindeskMobile.php?use_rest=1&wsusername=' +
//         'wdmobile' +
//         '&wspassword=' +
//         'wdsgnm1017_' +
//         '&token=';

// //ESH PROD
// const base_url_v1 =
//     'http://10.126.12.141/windesk/app/webroot/integration/WindeskMobile.php?use_rest=1&wsusername=' +
//         'wdmobile' +
//         '&wspassword=' +
//         'wdsgnm1017_' +
//         '&token=';

//ESH PREPROD
const BASE_URL_V2 = 'http://windeskmobiletest.eskisehir.yerel';
const TOKEN_V1 = 'wdeshtest!_';
const TOKEN_V2 = 'eshtest!';
const ATTACHPATHLIVE =
    "http://10.126.12.21/esh/xreadattach.php?token=${TOKEN_V1}&id=";
const base_url_v1 =
    'http://10.126.12.21/esh/app/webroot/integration/WindeskMobile.php?use_rest=1&wsusername=' +
        'wdmobile' +
        '&wspassword=' +
        'wdsgnm1017_' +
        '&token=';

//BESK PREPROD
// const BASE_URL_V2 = 'http://windeskmobiletest.prebesk.yerel';
// const TOKEN_V1 = 'wdbesktest!_';
// const TOKEN_V2 = 'besktest!';
// const ATTACHPATHLIVE =
// "http://10.198.12.130/besk/xreadattach.php?token=${TOKEN_V1}&id=";
// const base_url_v1 =
//     'http://10.198.12.130/besk/app/webroot/integration/WindeskMobile.php?use_rest=1&wsusername=' +
//         'wdmobile' +
//         '&wspassword=' +
//         'wdsgnm1017_' +
//         '&token=';

//GSH PREPROD
// const BASE_URL_V2 = 'http://wd-mobile-test.gaziantep.yerel';
// const TOKEN_V1 = 'anteptest!_';
// const TOKEN_V2 = 'anteptest!';
// const ATTACHPATHLIVE =
//     "http://geskwdtestapp.gaziantep.yerel/windesk/xreadattach.php?token=${TOKEN_V1}&id=";
// const base_url_v1 =
//     'http://geskwdtestapp.gaziantep.yerel/windesk/app/webroot/integration/WindeskMobile.php?use_rest=1&wsusername=' +
//         'wdmobile' +
//         '&wspassword=' +
//         'wdsgnm1017_' +
//         '&token=';

const loginUrl = "v1/Auth/Login";

// aktiviteekle = https://demo.signumtte.com/windesk/app/webroot/integration/WindeskMobile.php?use_rest=1&wsusername=
// wdmobile&wspassword=wdsgnm1017_&token=wddemo!_C82C122E-2B51-4DF2-943B-434C575C10E7&action=getAvailableActivities&issueCode=
// AEH00109987&module=issue

const attachpath = 'http://10.32.12.22/windesk/';
