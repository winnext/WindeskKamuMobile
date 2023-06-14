//aeh preprod
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

const BASE_URL = "https://digipay-test.ardsistem.com.tr/api/";
//----
const updateNotication = "v1/Notification/UpdateNotification";
const addNotification = "v1/Notification/AddNotification";

//ISH PROD
// const PPP_PROJECT = "ish"
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
// const PPP_PROJECT = "winmobile";
// const BASE_URL_V2 = "http://windeskmobile.signumtte.com";
// const TOKEN_V1 = "wddemo!_";
// const TOKEN_V2 = 'demo!';
// const ATTACHPATHLIVE =
//     "http://10.32.12.42/windesktest/xreadattach.php?token=${TOKEN_V1}&id=";
// const base_url_v1 =
//     'https://demo.signumtte.com/windesk/app/webroot/integration/WindeskMobile.php?use_rest=1&wsusername=' +
//         'wdmobile' +
//         '&wspassword=' +
//         'wdsgnm1017_' +
//         '&token=';

//TKD PREPROD
// const PPP_PROJECT = "tkd"
// const BASE_URL_V2 = 'http://windeskmobiletest.tekirdag.yerel';
// const TOKEN_V1 = 'wdmesktest!_';
// const TOKEN_V2 = 'tkdtest!';
//   const ATTACHPATHLIVE =
//       "http://10.159.11.81/windesktest/xreadattach.php?token=${TOKEN_V1}&id=";
//  const base_url_v1 =
//     'http://10.159.11.81/windesktest/app/webroot/integration/WindeskMobile.php?use_rest=1&wsusername=' +
//         'wdmobile' +
//         '&wspassword=' +
//         'wdsgnm1017_' +
//         '&token=';

// //ESH PROD
// const PPP_PROJECT = "esh";
// const BASE_URL_V2 = 'http://windeskmobile.eskisehir.yerel';
// const TOKEN_V1 = 'wdeshprod!_';
// const TOKEN_V2 = 'eshprod!';
// const ATTACHPATHLIVE =
//     "http://10.126.12.141/windesk/xreadattach.php?token=${TOKEN_V1}&id=";
// const base_url_v1 =
//     'http://10.32.12.22/windesk/app/webroot/integration/WindeskMobile.php?use_rest=1&wsusername=' +
//         'wdmobile' +
//         '&wspassword=' +
//         'wdsgnm1017_' +
//         '&token=';

//ESH PREPROD
const PPP_PROJECT = "esh";
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
// const PPP_PROJECT = "besk"
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
// const PPP_PROJECT = "antep";
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

//GSH PROD
// const PPP_PROJECT = "antep";
// const BASE_URL_V2 = 'http://wd-mobile-prod.gaziantep.yerel';
// const TOKEN_V1 = 'antep!_';
// const TOKEN_V2 = 'antep!';
// const ATTACHPATHLIVE =
//     "http://mym.gaziantep.yerel/windesk/xreadattach.php?token=${TOKEN_V1}&id=";
// const base_url_v1 =
//     'http://mym.gaziantep.yerel/windesk/app/webroot/integration/WindeskMobile.php?use_rest=1&wsusername=' +
//         'wdmobile' +
//         '&wspassword=' +
//         'wdsgnm1017_' +
//         '&token=';

const loginUrl = "v1/Auth/Login";
const attachpath = 'http://10.32.12.22/windesk/';
