Return-Path: <akunuri.sahithi@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FA31CD98F2
	for <webhook@archiver.kernel.org>; Thu, 18 Jun 2026 16:44:07 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.134])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.23888.1781801044124501184
 for <cip-dev@lists.cip-project.org>;
 Thu, 18 Jun 2026 09:44:04 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.134, mailfrom: akunuri.sahithi@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 65IGi1q81815494; Fri, 19 Jun 2026 01:44:02 +0900
X-Iguazu-Qid: 2yAbtjHMo704HYOIAD
X-Iguazu-QSIG: v=2; s=0; t=1781801041; q=2yAbtjHMo704HYOIAD; m=9zSH2meF0Q20yXYbvVWo567g6LQM4c1zm1ifmYy2yFg=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4gh64d4qzPz1xnZ; Fri, 19 Jun 2026 01:44:01 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hLwEjN7T8glXWQhJBr1uUb3KkWAhDJXdEHnIz8wAQBuHHWU2n3HCg6mE8fOajDVbIGFe4s5QUivliwoH0mr1QCRUekzO9WwugGgJRf1f6vMXC2HJBAbjiGuiesWv/y2w+dBHvO1aD2TAK1nc0pw8Jjkw1qg7oQY0hN0MC1Oa5lFEQ9UZOAiHRc6asrKsg/6nyXRGl4PkbybMWUx31r/JOQsyOo4vqYwbPf2APD2fVawiyY9TPB+DNeNN2PrCjP49+CJ55I5szn1qw5fWodqsyo+p5trfrlaBLF9OxnE7xQHJL8WX0NopqAji1u/lxMBeEZJiUhPtl/TACRgbiZSc3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Iix+JxGXVTcQ/U3t+N0r4G52zZVXni350csshyq2QmI=;
 b=uvfXe6RGhg1nMrDm8LX9WyA3ns+7IYAI6Ih+8Y+DktVsvpiGh8Eo4Ndxo+s1SdFTgFhyab0QARD3nHtMfm/WhMbFhnDdYLpulWZ9mi8UrEgnI4vnhw9aOULiBiZNPFzyN8knR8CB0PcfL8jmQOilOR8SC0lUHCHH5brpHCgXDacdJpsu4Oa1eFr14PxaT8x+xRKYsm0R8Elx0qXga2IO8AtYvlCQPo9GCIdSr4OqcBXN+QICOLCVwGjrqLxWHZKGrTXmdO5FEqHwPfGjad/KvCcqet6KWdY4VoICIgxvCkgx2rJCyyUcqOE+102r/yNTNXVKSwZTYi6FSaI8bS6YsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <akunuri.sahithi@toshiba-tsip.com>
To: <cip-dev@lists.cip-project.org>
Subject: [cip-dev] Autopkgtest support for passwdqc package
Thread-Topic: [cip-dev] Autopkgtest support for passwdqc package
Thread-Index: AQHc/0GFV9XGb7oCQE2hW9FxIIrPVA==
Date: Thu, 18 Jun 2026 16:43:46 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYYPR01MB105921EFCE76034EB9A0FA6A5DBE32@TYYPR01MB10592.jpnprd01.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYYPR01MB10592:EE_|TY4PR01MB14336:EE_
x-ms-office365-filtering-correlation-id: d6c826ba-20ae-4d46-0c29-08decd58c472
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|376014|23010399003|1800799024|8096899003|56012099006|11063799006|13003099007|38070700021|18002099003;
x-microsoft-antispam-message-info: 
 Tk5uzKJUst4xLy6Es8sJYCmVYF0vhY9obg/td4xSJ1AOFAEpXb8xLww1fz/FXSA4HDO/vNniLabucLNph6g/oL2yv4bJNcPeGl7HSUxIzOWxFO8s9Sz92l+oZaHz2rDxdHwrLSYpqN78Vr979cOFmJeSbXgveecxUBXLE01fyJiIZSZqPGCkHw7uAFMz1RJOjuygq1uB7bZknpaKWfPfZ4p04oElQQCmRRqOCZUXW/UR5gSOsGJEaXPTSymW/COVumOjt7pCcmUbgmJ1mUXxR6o8rorwdcR4EsGkMzUaPYM4WRDu30ytPGrOQqcJr0UAoMSN8yfEx8j5XAPAG4f+7lXE2r8G6mXkD130t9arJ2uW1Scr51dHj8yqtNBV9AlhO6pbMHeUYHXWZdgCuE3BVeWfZDMWyGeE26r4bc64++zpFLlTgyhhFVNWZ8cCBG0fUN5Is7ol7WT4Yw1Joc1SOU6CvXtI7NcsKsfQWsJz25VNbHGMIx/h4/LpJdMnD7qgTbrXirkGoI4XQe6LzvBVw2vPFYjpVj65jZ9Ri2avLOYRwye26tretdOWodVtbk/XiSfGMuTpTbXxnn5TDTTTqnLqKajKJQy3lnt20h2D8/oREkUNfDwUtQZjn9KU2wH96Poz7Ct5wLi51O9ir87o0kZVWt7gaR5yC044n82DNQm7boiAUdWx9UMWT66QJ4mZY4Nb3WESNsbCi+pJowIA+NtupX4zyyttpYh8awrEHhcf3UznVU/shO+Ug8IvpHhV
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYYPR01MB10592.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(8096899003)(56012099006)(11063799006)(13003099007)(38070700021)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?VUh0N1ExT05ibHZISnFxaTQyaFlkWWlGeG5DQTVpRlBmdXk2QnQrWVdo?=
 =?iso-2022-jp?B?TGRQMTM0di94SnVuKzR0dnlrVE1FdldrRFRWL1JRSHhtSmlPWWpORURV?=
 =?iso-2022-jp?B?cHpZMTRWc0wyelJWZGpxRDhKU3IvOVZxdXY5LzFnNnFvS2g4NS9TWEJo?=
 =?iso-2022-jp?B?SEZRWmlmL3RmWC9pS0ErdXpPajNLcjh2Ui81WDB6Z0ZwV3lqeWM1eDJC?=
 =?iso-2022-jp?B?cVFuTzFkbyt2MGFWVWpNTk1EVE5yNFkraUdvRklHQ3BTR25OYTZneUR6?=
 =?iso-2022-jp?B?SHp1SlF1UTY3NTFqaW1YQWU5K1FoNDhrKzdieDZPTUVubkl6WXpkWmx1?=
 =?iso-2022-jp?B?S1p6WWZqaFNnNVBDa0NvTzBkYVMrN1kzWGZScUNpM3Fyc1hIeDExTzZF?=
 =?iso-2022-jp?B?bWlrK2ZORXpJOVZUbGZsZDhnVmFPNmxBUGU4Ti9YbTVjNUdOTUN0Qitx?=
 =?iso-2022-jp?B?NERacjIrNGcxSmN2NlVsdlZ4MEJMRTF3WnIvamRsZDgzM1p4c1Z6NTFK?=
 =?iso-2022-jp?B?dHh1RlFCVGJVWHppVElwS25DbHFHUTVlNDVYcDZjNk91MUxXSmEyTkE2?=
 =?iso-2022-jp?B?U21ERkxnck5QNW9zaXRVMlBSTGw1LzBSSEQwdk52R3MyU0QrckMyUlpC?=
 =?iso-2022-jp?B?akNnemduaURYbk1hdmpFTThlZ1pJTU5uUVBzekFWWlJuaXZCK05mcm5E?=
 =?iso-2022-jp?B?SDJiSlJzU2h1WEYvd3d3OWpXOE9wdFMrLzJGc2JHNmtBbXc3YUJGSXF4?=
 =?iso-2022-jp?B?ZXdoM2todmlUWWV6VFRGbG9VL0MvTVpTMmdSbjcxcGI3RENJbFBrWmxW?=
 =?iso-2022-jp?B?dkZlUzVDL3VUazJwZTRZTk42NjZPQnA5OHFkWXM1a3pZbS9RVEFZN3Jx?=
 =?iso-2022-jp?B?UmNTam1RWGVReVh2SUlBWU43QUJUK1R5UlNKbU54UE5nd3ZIV0Y1dnJS?=
 =?iso-2022-jp?B?bWpTWjdlUm1ic2J0V3A1ZnNxY2I5dzV1SEdkcDFuWHMvS2RGM2xueTUr?=
 =?iso-2022-jp?B?WVBzSHpVRDNFL1k0ZXd3RkozT1NDUnJUVHord3FHQ0tSU080WXhnbHVY?=
 =?iso-2022-jp?B?MHFJblJxRnNnaVdod1AxQU9sc3BGZWJnVjJ6WjB0cWh3bVYrRWMvc0RK?=
 =?iso-2022-jp?B?NFgrdUVabXR1S1VKTXlyWEd1OGJGTnpLTXlGYk85dzBxbUE5Ym0zZjZM?=
 =?iso-2022-jp?B?cURqNDVHb25hVzIxN1g3aG45bE13R0JPQ2gvVUJlNENRekUxbjdEOHUz?=
 =?iso-2022-jp?B?RWo2WUxEQkxUQXFzeEtTbVdCRWdON0lLRGc2aUwzcDdFa0dNRHVsWmx5?=
 =?iso-2022-jp?B?SkNCbmIyQVAxNFpZY2pXN3AvUTJtVUxyZFFQb21pS0lvU3J3VDZ3aEVq?=
 =?iso-2022-jp?B?dk1kNDhHalVmbmZkL3RYbzJ2aDMxZjc1MzAwOXM5WUJRK016VDI2Snhz?=
 =?iso-2022-jp?B?RjRabTRJaVh2OFE1c2JKRTFoWU1rbDgyM2pJRndHOVJucTBBZTlaemNt?=
 =?iso-2022-jp?B?VlB3eHNmWmhHRlQ5L1JhbGF1RHdtZWZ1QjV4NWQ5Z3BTNzdQamQvTFlL?=
 =?iso-2022-jp?B?YWxtRmtIOXg1djEwOVVGWWsvVWE1Q3NlVysxYm1aMW5obVFiZ0RWREZY?=
 =?iso-2022-jp?B?ZlJlM3ZwSmxiR3pDcEVjUW1lNkR4VDFSaXJ3MDg0SmJyeTI3YUhpMzIr?=
 =?iso-2022-jp?B?Y0QyRnRoY1YzRDdpWmh5OG1ZZ0Y0bjdFQXFNYnYzajdwcTJFL1R0K3VC?=
 =?iso-2022-jp?B?U1pQRHFVNE1oWGVSVUdzZkh6M3JLZFBORGFHWG1VZ28xT3BrVW95N284?=
 =?iso-2022-jp?B?eGxHd1ovT09CM25Vc1ZzSFFyT3RPNUo4QktaK0RiK0czNjV4OGlzZE9B?=
 =?iso-2022-jp?B?UzduUUN1VXQ2SHpiMy9MbzJnT1AzVlFnK29kbjJBUTl2My92YmEvVXl6?=
 =?iso-2022-jp?B?bTJneDlsVGVTaTIyS0VEd1pWQWRJL0lzdHpyV1pXMkFBQWExT01veTYr?=
 =?iso-2022-jp?B?VTBIMWNuUTBGY1daY3dwNklzS0VrSmYzRUpSRlUyQjhyQ2o1QkNsa2Z4?=
 =?iso-2022-jp?B?c08xVFgxWjZuNW5mMmhxQlNHeFRNVFRuNGJCWWM1Ukt3ZExwZEdvOElB?=
 =?iso-2022-jp?B?VTRZZ29xb3FEZmlHYXR0aGZtNFVoVEFCZXUyT21FTmdYc1NwR1pLM1BU?=
 =?iso-2022-jp?B?NXB2eFlLOTFIdGlJNVFsMVVoY2xyVk1ZQjBhdGZaWUxDWnhHbjUwZkl6?=
 =?iso-2022-jp?B?elFTVHBudzJLZEx1eTNmTzJ6aVFBUVJRZS9mZDJJOStkc0w5TnFaeTk5?=
 =?iso-2022-jp?B?eXVINHhJY2VsU0hXTER2Zkp0REZrVXppMjBRMmFIMzFRUk9Wc2t2OEln?=
 =?iso-2022-jp?B?U2xYVWorZnVzRWVSL1VrTmxKRFBZWm02bnVXb3k2cG1kZkZINHhKZnln?=
 =?iso-2022-jp?B?cmVFbHd3cVpsUHgzcTZxeEZBRWNhMWJIa1MvSTVOOFFoUHB5RDc4ejky?=
 =?iso-2022-jp?B?SFpGbzF4RHNWczh3U2RGYk96Y3dFRGVla24zY00rQ2ZNT1pKMEhqYVZk?=
 =?iso-2022-jp?B?L3JCMkVlRT0=?=
Content-Type: multipart/alternative;
	boundary="_000_TYYPR01MB105921EFCE76034EB9A0FA6A5DBE32TYYPR01MB10592jp_"
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
	oSlunYIU6EojAfmkGRhtGvgTM78LKCL7TlEDGd3PAYw+LW+75Sw0geFEaTwXc2hxL876KBgH/syxfAjfKmG+4uuaIr4q7kuqh/UcpK4zLLGIlMvYEABtoJO6Iy9e4DoeWHVqcZpBqeYuubI/bKBAmxLQzFQL+tZBFerHllZA2Tn8ODnLoaB0hWJ/nQFBvyZzqKrYmVoS/G+mqlAxQZqvH0BSPdyTgjFS0xoaxKbcBHc74K5mjeydlLHhr5GXNPX6PfbQmjrdVLmVV95POuJST36y91M+YUAf+Oqh3+c+9RwDflC40e9Lu1EpTz18ikJ/pfUUv4Q/koaNPt1iXqY80A==
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYYPR01MB10592.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6c826ba-20ae-4d46-0c29-08decd58c472
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2026 16:43:46.9186
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r7FbmAeYh6naAfKe/H1gxt58VISJVqzbmfn3lV2u5T3uMBoMAGhXyLE9CoL8qYhHZzNZDobe2yVdys2sR06oPFGFKcluWYnqyfb2vgRYK6tbEprKXvwoN3xexgr9fin2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB14336
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 18 Jun 2026 16:44:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23226

--_000_TYYPR01MB105921EFCE76034EB9A0FA6A5DBE32TYYPR01MB10592jp_
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hi All,

Please find the autopkgtest related MR link for passwdqc package:
https://salsa.debian.org/pkg-security-team/passwdqc/-/merge_requests/1

Kindly review and provide your feedback as soon as possible.

Regards,
Sahithi


--_000_TYYPR01MB105921EFCE76034EB9A0FA6A5DBE32TYYPR01MB10592jp_
Content-Type: text/html; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-2022-=
jp">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div class=3D"elementToProof" style=3D"text-align: left; text-indent: 0px; =
background-color: rgb(255, 255, 255); margin: 0px; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 11pt; color: black;">
Hi All,</div>
<div class=3D"elementToProof" style=3D"text-align: left; text-indent: 0px; =
background-color: rgb(255, 255, 255); margin: 0px; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 11pt; color: black;">
<br>
</div>
<div class=3D"elementToProof" style=3D"text-align: left; text-indent: 0px; =
background-color: rgb(255, 255, 255); margin: 0px; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 11pt; color: black;">
Please find the autopkgtest related MR link for passwdqc package:</div>
<div class=3D"elementToProof" style=3D"text-align: left; text-indent: 0px; =
background-color: rgb(255, 255, 255); margin: 0px; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 11pt; color: black;">
<a href=3D"https://salsa.debian.org/pkg-security-team/passwdqc/-/merge_requ=
ests/1" id=3D"OWA95e9fca4-2cee-9a05-4b39-da898746320c" class=3D"OWAAutoLink=
" title=3D"https://salsa.debian.org/pkg-security-team/passwdqc/-/merge_requ=
ests/1" data-auth=3D"NotApplicable" data-linkindex=3D"0" data-ogsc=3D"" sty=
le=3D"margin: 0px;">https://salsa.debian.org/pkg-security-team/passwdqc/-/m=
erge_requests/1</a></div>
<div class=3D"elementToProof" style=3D"text-align: left; text-indent: 0px; =
background-color: rgb(255, 255, 255); margin: 0px; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 11pt; color: black;">
<br>
</div>
<div class=3D"elementToProof" style=3D"text-align: left; text-indent: 0px; =
background-color: rgb(255, 255, 255); margin: 0px; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 11pt; color: black;">
Kindly review and provide your feedback as soon as possible.</div>
<div class=3D"elementToProof" style=3D"text-align: left; text-indent: 0px; =
background-color: rgb(255, 255, 255); margin: 0px; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 11pt; color: black;">
<br>
</div>
<div class=3D"elementToProof" style=3D"text-align: left; text-indent: 0px; =
background-color: rgb(255, 255, 255); margin: 0px; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 11pt; color: black;">
Regards,</div>
<div class=3D"elementToProof" style=3D"text-align: left; text-indent: 0px; =
background-color: rgb(255, 255, 255); margin: 0px; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 11pt; color: black;">
Sahithi</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
</body>
</html>

--_000_TYYPR01MB105921EFCE76034EB9A0FA6A5DBE32TYYPR01MB10592jp_--


