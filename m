Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0B82D49207
	for <webhook@archiver.kernel.org>; Fri, 12 Dec 2025 11:51:24 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.134])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.11029.1765540275079670699
 for <cip-dev@lists.cip-project.org>;
 Fri, 12 Dec 2025 03:51:16 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key1.smx header.b=wDYLWw8a;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.134, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:CC:
	Subject:Date:Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version;
	i=nobuhiro.iwamatsu.x90@mail.toshiba;s=key1.smx;t=1765540244;x=1766749844;bh=
	6Juqo/gp/Q/IQXli55NgHFaUnTgpdj1sHeCtCD1Sdk8=;b=wDYLWw8aSRuUwf2RCKr4eJkCEC3SiT
	MszPNBI4YHJPntRO62HTJwDQhboHHC+UYd6rk9PdHTarxKWnrCT+D7h49ewPaS7F0XO+CvJrXKewI
	u44HmqrgqkaIqtr+eIDgkw2NhW+b8RGR2xnaZQT8QBilmY5syst2Hw/azo2KtQgSPXlUxorjh2FqW
	yxv5cFUSQz9dx3+LWDaSjqwLoCUSFyxyPyyglamOUj34eaqrw2p9rPX6rfxgjQt56ArL1Zb7VRk9s
	MkTJXGjMRodMV1nUWcpSwJ74LRtXPWY6ucLdJLb49sk4NIGI22VMqC1m+SMPw/mrSagSyo/OK4/5X
	IaGA==;
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 5BCBohew3286173; Fri, 12 Dec 2025 20:50:43 +0900
X-Iguazu-Qid: 2yAaGFzRaPnQwyTaO8
X-Iguazu-QSIG: v=2; s=0; t=1765540243; q=2yAaGFzRaPnQwyTaO8; m=mmQe37DjYQRjfskIyWIL9nzB2v9qboDam6EuECcBgik=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4dSSSy4CZtz1xnZ; Fri, 12 Dec 2025 20:50:42 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HEpht4TlqVE7gM+iaNjKbKEOj0MpuJMShgQhz9Bxnni6SBPjrhb0gim+NYIgegneKsI/9cSjUVcbR9OoXQNNibEsEosoG00peBsoG9cjv0jbW2HmxyK4HozHWqaaueit13JhKo7mhie3dhUlDqQ6HjvwLduxaZwwfRlvUKoRRRpaWOG+RAnV+AxRnny3XzqLJerf7QBpkgkCQZLoA41B7wnigMDw009wUD4fr4ojriqlKrulAq68Bkz0PVPifTO4WxRgJ7MktBlg6yy4I0tIdK8Z3RoQ5Kon/OwGdlgX52fovntmoyiBF76mdwKk3s4OcTRYD2ehjfG7PbeZkx4XGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mrhxgEkzlDiqY0aUiAR4kDIWN/3/VJeY9TznaHMl9nM=;
 b=fdZNp84yUtM4pkTm91uhkueKmMD/n77M0BbRHcyf4xuea4lQEmPWISoyGC9xjtNpE4f+JL01p7weuH6n3rXXxMPKGbuZHfyszITd2ydFWWNXniwBGDsBeCMBepEXFdMO1MPaxpxVMdP5uBJQG8s55lIKRFXXRjL0UpHgFao4D1yB/dOaEIetf/RtQf5Ubkd1VuwOkRikzPfgpSrXI7/adIErYcMqO2hZqiKgoLU+nvQKG5MV8GPexopCTyjhDG8mZerg9YsSM3016LhK074rGe9FrNyzXQZ13nbgIHsiMYO1qGZu22NbhDIgGE5/7XvbWUvz6ny0sNwjXZJEakoBTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <cip-dev@lists.cip-project.org>
CC: <jan.kiszka@siemens.com>, <pavel@denx.de>, <uli@fpond.eu>,
        <masami.ichikawa@cybertrust.co.jp>, <chris.paterson2@renesas.com>
Subject: [ANNOUNCE] Release v5.10.247-cip67
Thread-Topic: [ANNOUNCE] Release v5.10.247-cip67
Thread-Index: AdxrXXUByE/k8YzJQTaQvY/rw/mftg==
Date: Fri, 12 Dec 2025 11:50:39 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB1481840F1A2FB399A17BF53BCCDAEA@TY7PR01MB14818.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|TYRPR01MB12788:EE_
x-ms-office365-filtering-correlation-id: 530d7b8e-b465-4594-dd9c-08de3974abd9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?bFRYbjFIdVpWY2IxNGNSbDdNM01NOGJ6a2JaQTZHVm5xL3I0WkRqWjNt?=
 =?iso-2022-jp?B?N2phN1g5WVR4NE9KWDcwT3FpZ0R3ei9OanRSTXhJUGV5TzI2bXNSdGVm?=
 =?iso-2022-jp?B?TnoxdGw3MWptU1hzQzYvMThWaG0weVpqcDNTREZ5clAyM3pFVWRidlE1?=
 =?iso-2022-jp?B?MnJuaDBuWmliWHRBcmpzZmhVOE9qMEQyQTlFa2taUXQwTmNMY1dqMm9y?=
 =?iso-2022-jp?B?dlJsbFFNSlBQUHp2MVZKLytYaGdaQXN0NzhCeGIvbE1mMHo3K21kTUM3?=
 =?iso-2022-jp?B?Y2tIcXhuN0s1S3hBM1dVTk1COHp6d3lXU01IeXhvMFVubFZMeGp2am5w?=
 =?iso-2022-jp?B?WVREN1BteTBtdWhyVUpCckExWWRmMVhXQmVIOUhHSE9wQjJTeGMxaE84?=
 =?iso-2022-jp?B?MUY4T2t3Y0hKMFBNUHRLL2hQYzE1UXF5cGtVa29RT21UcWFSTm5HME0v?=
 =?iso-2022-jp?B?UnB3N1dDMFoyU1pmZTcveHJKYlVzdWFIYTNCeXNrWEJBUlBDazI2cVBq?=
 =?iso-2022-jp?B?VzlSSzlnTnoxVGRjRFdwSCtQbFZGbkozaW5EaEJxQTlCbjZJL0pFV0lx?=
 =?iso-2022-jp?B?bG1EQ1Q2QzRUNnZ5Y1o5WnlWRFBIOHQ5WGZJMUxIWldFZmtkMG83QmVn?=
 =?iso-2022-jp?B?aVl4d3hEaXB2U2haRURUTHJlK2N1N1NHNjdaeHR5S2pHWFBWUHV5SHhQ?=
 =?iso-2022-jp?B?djdaazBoY01PTE1wenBVZEF2OVZaRklOejRNcXNzVzg2TE1Bbkt5enla?=
 =?iso-2022-jp?B?WXZHTno3S2xaRThEU0RqWE83bEtOZllyNEtad05lMHNBcG9ldS9UeWZt?=
 =?iso-2022-jp?B?enNKaVFUaklhNU9KMTg5MWpXSVYyaG16c3p3UlBqR3huWEdNUVBQN1Nk?=
 =?iso-2022-jp?B?alZOY2NwZWNyWDFaZjhjKzFkNURLZkNRV0VQbUFoeGN5eFl4VDNWM1U3?=
 =?iso-2022-jp?B?K1ZsaExwYUE4VUxiMHVaUlFIeTQ4ZHVKNjVFMk9lYTdiT1A1QTlGNHF1?=
 =?iso-2022-jp?B?R3Rhd1RmbEY4MUkyM3I1UGdGbWRKUjA0dHlod0xtVFFWbjl5ZnZFU3Zl?=
 =?iso-2022-jp?B?ZXE1SExHRjU5U3VqZUR5QXRtYlFxdkFVUitXY2ZhNUpEbUIwVjdHWjI2?=
 =?iso-2022-jp?B?ODRzRExBOXFkWExxSjBpWWhpcUdCRkZ4WXE3Z2I4VlBRbkVSNWFoSW9R?=
 =?iso-2022-jp?B?ODlpTGZXbTBMTUcwV01iOEx3SGtsOUV2S1NqMHhmd1B5eGhXUEdnL1RV?=
 =?iso-2022-jp?B?aGVRRTBkd3NMYVg0K0xBNGMrU1FzV1lXSXNkalY0QXRlMENYZFV2cDR3?=
 =?iso-2022-jp?B?NkNzdWMzRUJERjdheElTZERFTDhHRStyemZ6MUVwaEZDc2ViOEhGUWhO?=
 =?iso-2022-jp?B?MW9yZDlzR2pHeHV4U2YzaC9jcUJjdEg2YmJlUUltZHN0RkJJNk5CTmFx?=
 =?iso-2022-jp?B?akl3SUI3bTRLMnYycFdkK3MzYWRsVXc3VWtKWWVQOWZHcVNrcmorUFN3?=
 =?iso-2022-jp?B?YU93Q2ZtOGQ1OWdIb2VXc0tyQlFxMHVTN3c0WjN1QUhzSCtITnM0MUxR?=
 =?iso-2022-jp?B?TENQZFJxU1NpZmoxdlN6VlBHMWRnQW0yVDhBdVhmUzdhaFhXVHh6WERG?=
 =?iso-2022-jp?B?K1pvV2RaQXJIZzVONmJCdzFGT3EwVk83U1dvdjFlTVBUWVBnV284V3Q5?=
 =?iso-2022-jp?B?QWhsTXVzaEhvbFJHUWM4RUhRTlRXc3JkbXROaThXYzRtdUN2OGR2UXdp?=
 =?iso-2022-jp?B?blJXUzd6YWVhL3VMRlp0ZGpHZ0JUY2ZiWk00VkYyc0xPaDFHR3F2bVM4?=
 =?iso-2022-jp?B?OEQzV3loUGR6R3ZQWk5ZUUF3OEM5ZHZkN3MrbkRMaFFESTZ3c1RtZlRL?=
 =?iso-2022-jp?B?KytXZjdqZGtIM0FPYU9YS0NXMXFRTTEwOXFDQXFOVlZja1dPNVFrYTRa?=
 =?iso-2022-jp?B?SUkwQTNJQzY4NlJuVjB6UStsUTRSRGdCT2d0T0tCaUl5NFptWndiMFFk?=
 =?iso-2022-jp?B?d1JmcUowUnQ5WVgwTXdNUGtnelc3N1AyZlR2NDBLRThrNFB1UE9nWjVK?=
 =?iso-2022-jp?B?eHFmRGlsbDdpWE52amZ3eVN2dmJEeFhiSFgxWVYraThRS0MxeFpHS1ZG?=
 =?iso-2022-jp?B?VjdQUHlqT21WOSt4N21SOW5BS285Sy9pU282a2tYUWoyYXpXcWtYclh2?=
 =?iso-2022-jp?B?c09QS3prZkFnbVhTOXF4Zy9xenJGTXcr?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?RkE4WC9OeVhDVUF4LzFMR1FqZ0FHRElxdnFSVlRmNTcreGFqdk1NdnZr?=
 =?iso-2022-jp?B?blBPWjR2TTM4K2FGWHg4YzUxajZBMU12WUJoQ3l0ZW1yaXh4RHF4VjRH?=
 =?iso-2022-jp?B?VndhQVdRQzFGMWpxTFVPbzJkSnBXYzlTYUhvejBzMkwwTzBSMGlHeW00?=
 =?iso-2022-jp?B?QXhZS2laNVNTNHJLdGp1Y05rcGt1VXM2ZHQ3ZXhpck5yZHJOV1g0amNh?=
 =?iso-2022-jp?B?L3FGRHlQQ3RmQVRuNzMvTE5OcGFQMlkvNTFXNVd4UXo0QmxIQ3R2N3dz?=
 =?iso-2022-jp?B?UkM4QzBsMDVHamVFRlluNDZJcllNV1pRUGhiSWptRDBjcnBlTlgrTDdE?=
 =?iso-2022-jp?B?SkFTaWpic0VZRGsrU2lvQ1RRTW1wOElqYmhKblEveVo5QXZGMW5GWGpP?=
 =?iso-2022-jp?B?dDJVSWlHWFlNOEVNeEJJT3VhWlhjOFpNQUI3MkROOEdnQmVxQnJVa2p4?=
 =?iso-2022-jp?B?dktoNXpHeGhHZ3hYVmhDUXRhdVVRUkN3cEFKWndNWS9taW53bGgzOGtC?=
 =?iso-2022-jp?B?c0YyZnhwRXdLeFJPV1Y4RFozKzlFV0hsVDNad0Vpb2lidCsrbEhTdTJ1?=
 =?iso-2022-jp?B?cFRXN0xOeTVoUVdpQ2lZdkNTUVZUVGMxOUFuZmZla0xSOUt2ZjVHSmNx?=
 =?iso-2022-jp?B?eDloc0laVjRWRndLTTR6eWc3SEd1eERVRUpWZE85RVF4cXJWaTVOOHBk?=
 =?iso-2022-jp?B?YVhlQUVhbVNZNTgxVXBaUG1XOFIwMDNBNlRtSTdzWjBHZ05qVlNLYXMx?=
 =?iso-2022-jp?B?eTZIYlRyVHZIcWN4Um9WSUttSjRKRG4yOHQ4TDBvWmYzeWZwb21QRURS?=
 =?iso-2022-jp?B?TkpEREN3OE1idktEUzJmSEpRQ2dhZkRnNVVHdHJvdmYyRkhCa3Q4bEJy?=
 =?iso-2022-jp?B?ZGpaUFdGcDFwTjdJN0RWMnJ4WFFYVXQrbWZxd2VtTEJpeFlmRzQ4THNa?=
 =?iso-2022-jp?B?U1hpWWhjQ2ZWQ0QzVG41OWpkWW1ZT3RPNWExWHRQcXk2VlJiQlB4MHJ6?=
 =?iso-2022-jp?B?TW5nT0laaG1OdEloRDJkN0pCMm9ybjlWOHZaS2FHbEFJY3FhS0tmNVJF?=
 =?iso-2022-jp?B?NThKL0VQNDhpeUVFVjhzZ1RCN3JiUEpnSERNZzhJNmlZYUcwNHMwTkl6?=
 =?iso-2022-jp?B?L0JaRkRaOE9TWHl3OEJEYjBZVHZOay9QRHFqaVpkcjJWUEIzbVdvV29q?=
 =?iso-2022-jp?B?Y05tLzQvWmJ1aXpkWkVHU3M3SDZOQ1NTQjE4cStVc3VERkd2R0RHR1B6?=
 =?iso-2022-jp?B?cVUrYXdOME5NdUVxTExQdEpsSHVDdlFMUlZCUnVNUzUzd1A3OExWWndn?=
 =?iso-2022-jp?B?VzQ4MnJGTitGVUhJakFXS2hGVGRKVm5sQlVPMkRqejdTK2FSMjNTOXE0?=
 =?iso-2022-jp?B?Z1diVysybXhrMlN2K05TWHJaQUtOTUZIRlI3NzFKMXBCNGhZRWFzRnJ3?=
 =?iso-2022-jp?B?RUJjKzRELysxYXBEbnEyRkFQTHNCMDN3ZEhkNll3NjR2QlBqMEQvRFBH?=
 =?iso-2022-jp?B?Vldab2hlYkNoU3oxNVVTOUR1cTliT2lCKzNvWWhJZWNFZDNDSDBCYTZh?=
 =?iso-2022-jp?B?dkZESlI5d2RpVzVkU0pxVXk3UGlLSDNac0hWN3YwOHRJK2dONDBPVk9Q?=
 =?iso-2022-jp?B?elZOQU14ZWUxOVg1ZHpQbEZxUFY3Z3NGdDNFNVkwWm1UT1JkdDJzTEVM?=
 =?iso-2022-jp?B?UW9ZL2l2cGswUHNOcEFrK05peFBJR0k2VTBVSlYyNyt2NHlteDdoSThW?=
 =?iso-2022-jp?B?c0g1dUZMdGhUR0dvdDlPeFJWZVQwWkloaytmVWY4b2R5MFVZeXR1OVo2?=
 =?iso-2022-jp?B?UHFUNmV6eCs4UUhvdmcvV0w4RmtKVWR0aDM5aHhScEoweCtkNmhCUmxj?=
 =?iso-2022-jp?B?ZVV2UnNRTnJ3cU1wY2VZaENYYS9uS29NODk5Z3hUcW1NNmtFQ3VRL1Fv?=
 =?iso-2022-jp?B?WVNlMmdTb3YxdjFjeVJRUWwxRnVIMDhlNiswNW1IbkhiQzhZU2t1bTJz?=
 =?iso-2022-jp?B?Y1dobVZRRWxyN2x4Tm5ESXMyc1BNb2NRSGkvbUs2clhYMU9lWVN3Rjlo?=
 =?iso-2022-jp?B?dXN1VGFXOTFjSURTRGNPc0R0T1RqTUVSQ2xVSGMyQnd1dyswVDN1cm5o?=
 =?iso-2022-jp?B?MklRWGJ2aHYybGNyak1rV0NSRk9LSGZCUkRLMitDSGcxQ1ArL0x4QXpT?=
 =?iso-2022-jp?B?YTBtZStoOWJCNVkxNlJvclZGTWNaMDlOejdtRUoyQzJGVFBDRFo5elg5?=
 =?iso-2022-jp?B?Q0REOWN0VjRqY2RWZ3p5SEt0MG5HczZibmpjSnIxNjBVcENuUzh5SzE4?=
 =?iso-2022-jp?B?M2FWNldpUy9uM0JlMVI5VlkxeDV4QU4zMEE9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 530d7b8e-b465-4594-dd9c-08de3974abd9
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2025 11:50:39.5170
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j7HpUVgIcZetnVLh64b3rKcwnk5GXh2qnEB8YofeHLXZhYEgUN/FYLUgo9LKHdShzodb5TvO8oDOzPqCGOAJQpTv5W/TgcvW49LzULgS+90xtMON0rA3eGrvXbmMv+2/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB12788
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 12 Dec 2025 11:51:24 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20981

Hi all,

CIP kernel team has released Linux kernel v5.10.247-cip67.
The linux-5.10.y-cip tree has been updated base version from v5.10.246 to v=
5.10.247.
This release includes ASoC and mmc fixes for Renesas ARM64 SoCs.

Information about this release is as follows:

  v5.10.247-cip67:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-5.10.y-cip
    commit hash:
      a39d4c75952517f473d99710cc33aeb781524fc4
    fixed CVEs:
      CVE-2025-40271: fs/proc: fix uaf in proc_readdir_de()
      CVE-2025-21887: ovl: fix UAF in ovl_dentry_update_reval by moving dpu=
t() in ovl_link_up
      CVE-2025-40282: Bluetooth: 6lowpan: reset link-local header on ipv6 r=
ecv path
      CVE-2025-40277: drm/vmwgfx: Validate command header size against SVGA=
_CMD_MAX_DATASIZE
      CVE-2025-40321: wifi: brcmfmac: fix crash while sending Action Frames=
 in standalone AP Mode
      CVE-2025-40254: net: openvswitch: remove never-working support for se=
tting nsh fields
      CVE-2025-40040: mm/ksm: fix flag-dropping behavior in ksm_madvise
      CVE-2025-40281: sctp: prevent possible shift-out-of-bounds in sctp_tr=
ansport_update_rto
      CVE-2025-40262: Input: imx_sc_key - fix memory corruption on unload
      CVE-2025-38678: netfilter: nf_tables: reject duplicate device on upda=
tes
      CVE-2025-40253: s390/ctcm: Fix double-kfree
      CVE-2025-40083: net/sched: sch_qfq: Fix null-deref in agg_dequeue
      CVE-2025-38120: netfilter: nf_set_pipapo_avx2: fix initial map fill
      CVE-2025-39866: fs: writeback: fix use-after-free in __mark_inode_dir=
ty()
      CVE-2025-40331: sctp: Prevent TOCTOU out-of-bounds write
      CVE-2024-47666: scsi: pm80xx: Set phy->enable_completion only when we=
 wait for it
      CVE-2025-40273: NFSD: free copynotify stateid in nfs4_free_ol_stateid=
()
      CVE-2025-40280: tipc: Fix use-after-free in tipc_mon_reinit_self().
      CVE-2025-40278: net: sched: act_ife: initialize struct tc_ife to fix =
KMSAN kernel-infoleak
      CVE-2025-40317: regmap: slimbus: fix bus_context pointer in regmap in=
it calls
      CVE-2025-40261: nvme: nvme-fc: Ensure ->ioerr_work is cancelled in nv=
me_fc_delete_ctrl()
      CVE-2025-40309: Bluetooth: SCO: Fix UAF on sco_conn_free
      CVE-2025-40315: usb: gadget: f_fs: Fix epfile null pointer access aft=
er ep enable.
      CVE-2025-40304: fbdev: Add bounds checking in bit_putcs to fix vmallo=
c-out-of-bounds
      CVE-2024-57947: netfilter: nf_set_pipapo: fix initial map fill
      CVE-2025-40211: ACPI: video: Fix use-after-free in acpi_video_switch_=
brightness()
      CVE-2025-40259: scsi: sg: Do not sleep in atomic context
      CVE-2025-40275: ALSA: usb-audio: Fix NULL pointer dereference in snd_=
usb_mixer_controls_badd
      CVE-2025-40312: jfs: Verify inode mode when loading from disk
      CVE-2025-40322: fbdev: bitblit: bound-check glyph index in bit_putcs*
      CVE-2025-40264: be2net: pass wrb_params in case of OS2BMC
      CVE-2025-40257: mptcp: fix a race in mptcp_pm_del_add_timer()
      CVE-2025-40263: Input: cros_ec_keyb - fix an invalid memory access
      CVE-2025-40248: vsock: Ignore signal/timeout on connect() if already =
established
      CVE-2025-40319: bpf: Sync pending IRQ work before freeing ring buffer
      CVE-2025-40342: nvme-fc: use lock accessing port_state and rport stat=
e
      CVE-2025-40306: orangefs: fix xattr related buffer overflow...
      CVE-2025-40324: NFSD: Fix crash in nfsd4_read_release()
      CVE-2025-40283: Bluetooth: btusb: reorder cleanup in btusb_disconnect=
 to avoid UAF
      CVE-2025-40269: ALSA: usb-audio: Fix potential overflow of PCM transf=
er buffer
      CVE-2025-40308: Bluetooth: bcsp: receive data only if registered
      CVE-2023-24023: Bluetooth BR/EDR devices with Secure Simple Pairing a=
nd Secure Connections ...
      CVE-2025-40258: mptcp: fix race condition in mptcp_schedule_work()
    added commits:
      CIP: Bump version suffix to -cip67 after merge from stable
      ASoC: renesas: rz-ssi: Use proper dma_buffer_pos after resume
      ASoC: da7213: Use component driver suspend/resume
      mmc: renesas_sdhi: Set the SDBUF after reset

Best regards,
    Nobuhiro


