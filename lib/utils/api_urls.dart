//aeh preprod
import 'package:shared_preferences/shared_preferences.dart';

const BASE_URL = "https://digipay-test.ardsistem.com.tr/api/";
//----
const updateNotication = "v1/Notification/UpdateNotification";
const addNotification = "v1/Notification/AddNotification";

const getIssueList = "http://windeskmobiletest.ish.yerel/list/";

//const BASE_URL_V2 = "http://windeskmobiletest.ish.yerel";
const BASE_URL_V2 = "http://windeskmobile.ish.yerel";


//SharedPreferences prefs = SharedPreferences.getInstance();

//String deviceToken = prefs.getString('deviceId').toString();

//const TOKEN_V1 = "wdishtest!_";
const TOKEN_V1 = "wdishliveSqAS!_bd41c5e22e8cde6b";

//const TOKEN_V2 = "ishtest!";
const TOKEN_V2 = 'ishprod!';

//const ATTACHPATHLIVE =
//"http://10.32.12.22/windesk/xreadattach.php?token=${TOKEN_V1}&id=";
const ATTACHPATHLIVE =
  "http://10.32.12.22/windesk/xreadattach.php?token=${TOKEN_V1}&id=";

const getIssueDetail = "http://windeskmobiletest.ish.yerel/issue";

const loginUrl = "v1/Auth/Login";

const base_url_v1 =
    'http://10.32.12.22/windesk/app/webroot/integration/WindeskMobile.php?use_rest=1&wsusername=' +
        'wdmobile' +
        '&wspassword=' +
        'wdsgnm1017_' +
        '&token=';

//const TOKEN_V2 = 'ishprod!';


const attachpath = 'http://10.32.12.22/windesk/';