Return-Path: <sai.sathujoda@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6920C35274
	for <webhook@archiver.kernel.org>; Thu, 21 Dec 2023 13:00:19 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.131])
 by mx.groups.io with SMTP id smtpd.web11.50193.1703163611874556708
 for <cip-dev@lists.cip-project.org>;
 Thu, 21 Dec 2023 05:00:12 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.131, mailfrom: sai.sathujoda@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 3BLD087B4191392; Thu, 21 Dec 2023 22:00:09 +0900
X-Iguazu-Qid: 2rWgcmDWg50zPtprXt
X-Iguazu-QSIG: v=2; s=0; t=1703163608; q=2rWgcmDWg50zPtprXt; m=1KQZB05Hb7OnpTn6YMPQKy6nHB+Gxk5P4hUPsAzJ/aY=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1121) id 3BLD06iK3527490
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 21 Dec 2023 22:00:07 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XhMirb4rP4r0nnGMIn5hfucHsze3fh0JBe7CkMgb5uMogxSTqmol6HYhlpKA57srUh/ZncwQyb+qrffQy/tlyBj7c2F53fRX0lpKL5xxpHQhFsOAlYSiqyeSGn57IkWDfhTMzwEB34XCLl0gwqcQYXArOlQBd0ER8OH8gpnxuIFrAv5TqzuERH/k+onHqyfntAzCLigamqwthLS7ZM8KiDcdAuvjmhQJq9VFRaZRBr/pRmNpBdgOayzcqz+PubvCIz7f9CCneAmFeeW9IDTPcOJpO1Ex9UeRJr+xh+2Dh2ub0CCHZTLP5Y0Om8O2J9JeV5Ko0iu2LGEG7KBlSXzgdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vjsWkEr33NMagRNv0hz4iYburFFn4cMYXJc7fVyzFx4=;
 b=OJghTDAiEAQOvC7BMw0n6Tbamv1WbDqNOGLzHQsKDKoeiW+R8s0SFPJRTlI6anJ4QxNQiMOFQ2G1XRKELNX5y8HJxYdFpm3nFs4K/eiO7pf26Xgjb9yB03aYIUp3/pwMK8KFJYAECrz/nv6A8OF4qugH+Ev4GCpb4HYOYv/5qfKD08WgtwMwWc4yCJh/1bL9DdjZQJsNdclHVJBO6gNO1RTSBcKvkYYn8zMbDIMFrZVVAaxEIVDIDZ+6bDzBTgbRh1AG5O9XwZ/uFnDNxIQHb0jBstCjUXgZN7zXlzcT3P3rKwYcEiuOUtinDrKjwpzo2u6tYuTUNbxRX7bGVYp9aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Sai.Sathujoda@toshiba-tsip.com>
To: <cip-dev@lists.cip-project.org>, <jan.kiszka@siemens.com>
CC: <dinesh.kumar@toshiba-tsip.com>, <kazuhiro3.hayashi@toshiba.co.jp>
Subject: Request to participate in the discussion with LAVA community
Thread-Topic: Request to participate in the discussion with LAVA community
Thread-Index: Ado0C25dewihPtUiRemA2QoUWPPsiA==
Date: Thu, 21 Dec 2023 13:00:03 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OSAPR01MB49455DEC550729FBE98F69B2C295A@OSAPR01MB4945.jpnprd01.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSAPR01MB4945:EE_|OS3PR01MB9944:EE_
x-ms-office365-filtering-correlation-id: ee790e4a-0b36-4f4f-0964-08dc0224bfba
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 C3sg8cf03zYKQKutoBlRUkOKdRkfx3uBo11J25kuX+XMrlovlE8+g9BRQM0BXLpbH1XWbh6WWjGIqMIHS1cBk8A0OcX8Ar8k97EfZq7m2541VLNhjhBqoMRsMXVASRxA2Pks0EiJ8L0EGfzvFORV5FkuaeBPKzEXEL9Bsqric16InQvBCrGj1JEifrIBR1EY3SEoK5jER6xhNGSmwyjJsnwIRpjJRGDqr2Fdp4Aj9NttvZ6Oj/KaZ3Utn11dUopndWyx1PI5D+5CJxJV+f9AkC53kbsXjjdXYk2sAswj2W1k0ICNJkwkhGwqakt5Q7Zw5DT5BPHcVwO8Ip2YDREYnTqYoePUmLxAwdkzm/6Af4rhxZoAaYumasPltvB5VCO82fFevX6wJPx077cdFEmmNbMjfArs3R7q2WwSZXhI8WAykfLIcK6nmBgJJpkSZPpoeBwWL2kpaJY0OBIwbiEjMiJa0HZN5pln6Sw8DzyEpKFzzVci3SDxywM/kykKgCB7sXUAatPwWrmLDNbMQ9JsklDM2bxYpkscs2YORqcPOaLPozEOUeIF9CZoxD5d09uWOBCIY5UNMBWV4nu1MJwbOLamLMvaeu/1y21obn6aNDw=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSAPR01MB4945.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(396003)(366004)(346002)(39860400002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(2906002)(71200400001)(7696005)(6506007)(86362001)(33656002)(85182001)(9686003)(478600001)(38070700009)(83380400001)(26005)(38100700002)(107886003)(122000001)(166002)(41300700001)(5660300002)(966005)(110136005)(66946007)(66556008)(76116006)(52536014)(55016003)(8936002)(8676002)(4326008)(66446008)(66476007)(54906003)(64756008)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?ZEVTRG5CbE43b1IrclhxemtRckZUZW9NK2NETWlIZHpkRnNCQ0psL3JD?=
 =?iso-2022-jp?B?WEE0aFczZWRDWnZ0Qm52M1p3Y2QrNVlpQVdXc2FJZHJOMm40cUMwblNQ?=
 =?iso-2022-jp?B?ZU9NaW5oaEh1Qjh6R1I5S1VaOEN3d2FNeWlTdzE4WUVORU9Md3FuY0Ju?=
 =?iso-2022-jp?B?TjMxSW5sODRRdEJvRzFzd1Q3QUNDUS9sZ1l5TGdsdGFQSGpxT2lqYWVz?=
 =?iso-2022-jp?B?U0lRMlltS3JiTUhIb1ZBMWhGRWd2bEJDV2FTZEo4Zy9CMFRBNlBvcHVk?=
 =?iso-2022-jp?B?eXJDQkpKTVdNWFptdllzaVdJQWFITmVxK2U3Y1p6SWZnaHp0amRQYlZR?=
 =?iso-2022-jp?B?RUlzTHh6NXhhZXlTN2wvNysvK2RaY2F3RHVYZ1IwVHArdDdycnhlbmFS?=
 =?iso-2022-jp?B?TWxQWHpvbEtjVkRJbmZFT2tpa2JnV2Zyd01qQ0lKT21XbWxQN0lVUnVl?=
 =?iso-2022-jp?B?a3ZYaE5IMll2WEI0RCtOaXNkNGZGTjJNMlkzTU1rR3VzTU10MytCQlJU?=
 =?iso-2022-jp?B?QzZnMFk3RHVHV2xhZHdHMzVvMW80WFpvdjBUUnBmR0pQUURnZUpmYjdI?=
 =?iso-2022-jp?B?bWtVWS92eFhMbVJzNHQ0alRJRGxUeEFCZjdIc011cElPdkFibEc1L1hN?=
 =?iso-2022-jp?B?MHUwdzFqcnloQ0ltb2MrQis3M3VKbkl1NjFoQk5SOS80Tnh1dlhOOWE2?=
 =?iso-2022-jp?B?N0VJencrVXFGRUh6ZEU1NFJuWVhwUFpGWGtVcldlT09KaWZEUTFYTlR4?=
 =?iso-2022-jp?B?dW44YXVYWnM5Vm5uY2FxYTNockxTV0dlRDUxM05ZZEVDV2RpTWN5Wkh5?=
 =?iso-2022-jp?B?K2h5VjI5L1ppT1lZNUsyTWJGb2xOd01QSnBubkV5eHlDNXNnL3RpWnpr?=
 =?iso-2022-jp?B?Z0pzVmVLSzdEdVVLVjJiWHZXNjlWb3dXNWhPU0Y5M3p2L1pLRE5kQ1k1?=
 =?iso-2022-jp?B?Q01SWmNnYzhqN1NkU0RxUmxxNFZOOXFteEp6TUd0RU43VEFwb29pMjc4?=
 =?iso-2022-jp?B?UUY1SlJSdm5jQkxHZGhrRlUvMEpWaTRvR2dWNlo4dkh4dVUyMGFPMDFX?=
 =?iso-2022-jp?B?SlUxeFpkb3hWQVFNaFl3VHJIcW92UHd4dEJXOFQxTUFFMDJvbUd3NXhx?=
 =?iso-2022-jp?B?UEJTN3dKK3JGcTJwQ2ZKZ21ocXBmMDN5RlcwKzRHby8wUVAvNXlKNGpG?=
 =?iso-2022-jp?B?NDZSM3FMMnJMRFJiNStNL0VqSG9uUG42SlgxSFhtbzlHWTBYQmtlVG5D?=
 =?iso-2022-jp?B?ZWlUZ01aNXhtRXlzQmZWMnhHLzNNV2VGT0FNM0xIZnVIYmxVZGxFY1RG?=
 =?iso-2022-jp?B?NHlobjNwNTdHb1c1WFQySEpnSmtXekNITzNlSGJFbnB3eDJiNU5NdG5U?=
 =?iso-2022-jp?B?QWs0dmtLNkM3bENQRDJxQVZFZ0g2U3AzTjZ4SmZhV2ZDSVpRYWxVN1ZQ?=
 =?iso-2022-jp?B?dmZtcS9raXVqQ3pLaDIrQWRZSmNXV1RWdlM0eUNCNmZTNGRMWXg3N1ZI?=
 =?iso-2022-jp?B?T0lyalAzUy9XR3ljeUlTYkNObHR0YUFhZUs2YXJ4eTVKK3lXVDdyWkFh?=
 =?iso-2022-jp?B?c0tObC9rbGR0dm5uRjJOUFZzTHM5bmhNRGRiUmtuUTZWRzZZTTFWUStw?=
 =?iso-2022-jp?B?dC9PbitmdFNHL3BDSm9tTE01dnR5NzVJVDJkOGtNaVloWHlyc2hUNnFr?=
 =?iso-2022-jp?B?Y3B2WDdiTXlZY1NCQzZrQk9adDc0RTc1eGVVbmkzVEJ2Z2VOeFVPTXpq?=
 =?iso-2022-jp?B?b0lNUTZLcTdMZDRNSXg3Z3hVSWQ1dmJiYXhWazRWMmRoREZRcEpxYk5G?=
 =?iso-2022-jp?B?QkR4Z3hrdC9FaUpqMFp0Y2hPQzJyalVzLzBZNzNrNzNKTGk2T3d4QjFM?=
 =?iso-2022-jp?B?bCt2OWNOOTNWT3RPa0JFZUpQMlZBMWtHRzhzdzh2NFRFbGhiNTNpOS9W?=
 =?iso-2022-jp?B?b25ES3REcUhBLytjZytaMXZ0VkVJRUVBaWVQZjBBbzZsVWpkWE9TK2dv?=
 =?iso-2022-jp?B?T2tzSjV4UDd4Y1k0OUtSdWJFUUQ2ai81ZzRFVXdSaDVScG5IUDlTWHNU?=
 =?iso-2022-jp?B?dXQ2VGlOK200Rk1OcDZVUHoxbE52TjBlK2tFM09HV1RnZ0JYbFdKVHpN?=
 =?iso-2022-jp?B?THlZS2xUc0hXSldPcU9wUTJCMlEzSTJnN25EbGc4L2owSWZLL2NzT2x0?=
 =?iso-2022-jp?B?aXZXVkJpY2lTT3ZJbXZOZllZSy83dXU2ZWl2L0ZxWlRFVUVvNjRDbktF?=
 =?iso-2022-jp?B?YVBHR2lMR2xQYVAyeUdFZ292WE02Qk9vMW41S24wbzNOVUQwYzFLSlBo?=
 =?iso-2022-jp?B?bXVtV0w2bnA5OTNiWDZvSFJCWCswQS82WUE9PQ==?=
Content-Type: multipart/alternative;
	boundary="_000_OSAPR01MB49455DEC550729FBE98F69B2C295AOSAPR01MB4945jpnp_"
MIME-Version: 1.0
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSAPR01MB4945.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee790e4a-0b36-4f4f-0964-08dc0224bfba
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Dec 2023 13:00:03.8366
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WppIAODpSa33NPPjnK3cN2x48NDZlT066fAaDyBH5+NMi76gcW3XPQHCq6wy5jg7NJ69X19KXmxVl3En/9SeKHwzT+1KoiK3OoGoQtKrcCc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB9944
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 21 Dec 2023 13:00:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14189

--_000_OSAPR01MB49455DEC550729FBE98F69B2C295AOSAPR01MB4945jpnp_
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hello everyone,

Hope you all are doing well.

A ticket is opened in lava-users community to discuss about the following i=
ssue.

We are trying to automate software update testing in LAVA. In that we are u=
nable to test the scenario in which rollback to the previous partition happ=
ens after the reset done by the watchdog.
LAVA is unable to detect reboots done out of it=1B$B!G=1B(Bs control which =
leads to breakage of job definition after the reboot.

Testing the watchdog is an important use case in CIP. So it will be very he=
lpful if CIP members can participate in this discussion with lava community=
 where we are trying to know about their future plan to support this use-ca=
se.

Please use the link mentioned below to join the discussion in topic.
https://lists.lavasoftware.org/archives/list/lava-users@lists.lavasoftware.=
org/thread/CBDPK2OG22BWRNGKYDDKGFK3P7SKXLBK/

If you have not subscribed yet, please use the link below to subscribe to l=
ava-users mailing list
https://lists.lavasoftware.org/mailman3/lists/lava-users.lists.lavasoftware=
.org/

Thanks and Regards,
Sai Ashrith (Toshiba)

--_000_OSAPR01MB49455DEC550729FBE98F69B2C295AOSAPR01MB4945jpnp_
Content-Type: text/html; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-2022-=
jp">
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;
	mso-ligatures:standardcontextual;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri",sans-serif;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:=
break-word">
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Hello everyone,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Hope you all are doing well.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">A ticket is opened in lava-users community to discus=
s about the following issue.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">We are trying to automate software update testing in=
 LAVA. In that we are unable to test the scenario in which rollback to the =
previous partition happens after the reset done by the watchdog.<o:p></o:p>=
</p>
<p class=3D"MsoNormal">LAVA is unable to detect reboots done out of it=1B$B=
!G=1B(Bs control which leads to breakage of job definition after the reboot=
.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Testing the watchdog is an important use case in CIP=
. So it will be very helpful if CIP members can participate in this discuss=
ion with lava community where we are trying to know about their future plan=
 to support this use-case.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Please use the link mentioned below to join the disc=
ussion in topic.<o:p></o:p></p>
<p class=3D"MsoNormal"><a href=3D"https://lists.lavasoftware.org/archives/l=
ist/lava-users@lists.lavasoftware.org/thread/CBDPK2OG22BWRNGKYDDKGFK3P7SKXL=
BK/">https://lists.lavasoftware.org/archives/list/lava-users@lists.lavasoft=
ware.org/thread/CBDPK2OG22BWRNGKYDDKGFK3P7SKXLBK/</a>
<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">If you have not subscribed yet, please use the link =
below to subscribe to lava-users mailing list<o:p></o:p></p>
<p class=3D"MsoNormal"><a href=3D"https://lists.lavasoftware.org/mailman3/l=
ists/lava-users.lists.lavasoftware.org/">https://lists.lavasoftware.org/mai=
lman3/lists/lava-users.lists.lavasoftware.org/</a><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thanks and Regards,<o:p></o:p></p>
<p class=3D"MsoNormal">Sai Ashrith (Toshiba)<o:p></o:p></p>
</div>
</body>
</html>

--_000_OSAPR01MB49455DEC550729FBE98F69B2C295AOSAPR01MB4945jpnp_--


