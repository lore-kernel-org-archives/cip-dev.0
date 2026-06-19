Return-Path: <akunuri.sahithi@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70C36CD98E6
	for <webhook@archiver.kernel.org>; Fri, 19 Jun 2026 04:29:48 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.132])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.35769.1781843379367582881
 for <cip-dev@lists.cip-project.org>;
 Thu, 18 Jun 2026 21:29:40 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.132, mailfrom: akunuri.sahithi@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1121) id 65J4Ta4V2090721; Fri, 19 Jun 2026 13:29:37 +0900
X-Iguazu-Qid: 2rWhpSL4OnooME2x6H
X-Iguazu-QSIG: v=2; s=0; t=1781843376; q=2rWhpSL4OnooME2x6H; m=IqUOwnJxIa8FkQ+9ny6y9+JmZj3WTuk1wy1oSL+aU94=
Received: from imx12-a.toshiba.co.jp (unknown [38.106.60.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4ghPkm3gl7z1xnf; Fri, 19 Jun 2026 13:29:36 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WmsxcREECtTlhoxL2ygMojs025htBBWNVbl5LHPW2MoMETEDxUhlaI8PVQDh02/aEHCJScfuoJfphTAUVQC7igvemLlTHP4iijA4SnTsd84yLU1JPGYypRld3zMG8UAvRzQtpQoeEDzQKaDBIOfMunRYngcXaCTSoHTN10uyRYN7wBlyVVYJZlUr2xwWoC1xtVUasO9GESKikliHk3r6dweNrMHr19ZIPsJ9jgJLK0uOBrXF038cSCb0TBAR/SoIUwEvf5jtdNwp8JRs63QSbLX9GYxddgRjXd+F+15YuIf0JWMtFC3SwXp1r+Hk92pUBhAVvt+y3Dt+h0ojGTBjnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rl2ftgMjpvgkTJwLsTPJvfefjmRXjZscGPIwiIfvOIk=;
 b=bXne5TbfZM9fVezeA5y3Lc+/C3Xkm+kUQnEv08RVC2TMgHXMHO5SxxZ3RHDF+YofopoX5U64GuXavGA4kcftAp4fTZo0y9Mx/Gt90Lm+eJBMrzYd+MYlzvBgWXHyLIC8sNIgnXJXeyFOzpxczLVmAyChdwF4d4rb92ylp2NMXUWVON7ElkorGs+sNIwqcK5bcVAMciWHzITaX5il/xbZd4Shmz4V5EcsjWHgIiM7q3q/pJqLPeWKdQavn8WYJ16ADb5zgji3fpXrywxJzk1vJJDPuHDQz2w2dBwlzquahgnlfEdRTvtebH89VuvaXpm1GhJPW5lLTKBDHZ5wy6rzpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <akunuri.sahithi@toshiba-tsip.com>
To: <cip-dev@lists.cip-project.org>
Subject: Re: [cip-dev] Autopkgtest support for passwdqc package
Thread-Topic: [cip-dev] Autopkgtest support for passwdqc package
Thread-Index: AQHc/0GFV9XGb7oCQE2hW9FxIIrPVLZFSV04
Date: Fri, 19 Jun 2026 04:29:31 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYYPR01MB1059265F33AC401875490D349DBE22@TYYPR01MB10592.jpnprd01.prod.outlook.com>
References: <18BA3A9C21E5716A.777602@lists.cip-project.org>
In-Reply-To: <18BA3A9C21E5716A.777602@lists.cip-project.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYYPR01MB10592:EE_|TYVPR01MB11130:EE_
x-ms-office365-filtering-correlation-id: f0b27ce8-75a8-42d5-3bb1-08decdbb5b9c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|56012099006|8096899003|11063799006|38070700021|13003099007|18002099003|22082099003;
x-microsoft-antispam-message-info: 
 1FIG6tbkW1v5UNSZdLSZEbnqfXXjBU7fYrkLeazp7zxgoPFYBfX+Tt0RnLJ0Ccfvb8pcnExc3IWsoeMI5ERyBNKD99+k2Gy5U6QebvZcsrPbRem+gY0R1rfLICEL0/lISSdll4CEJBvHgVFYMnnMu76Aq984RzHYtHjoaAtTSoAiAhtt7qrjfI4WpLnU/s0iF+deuGeAI3ez9HQ9MPkdKodnBvg4x7jQQ65cc24VLAzQV7PZUcBu5xMPbkzj1CH2n6/Evr8oOLSFcr/26H7NVSe0x4nOo0fNbKrKsbY7sYt692C5z4IxniVc8jdr92EoIfvkm6si6GpsM3zmH2vz7JysZ4+P1xyGyEGX+m+SmSEF/8kQnP8QmW4ClSTHzc1d0GOTphBU0IsR0lyjCgMR3/yq1V5M+ME2c7AJlse6UUzbm7iBQA7qCmswFvCS13vST/NGh+MnZrvNBiblVTF2PYFHB749C9RX/RJj81JC0tVuehkhQyyaR7+CKOhJ99cW1w50YkPOx4aNQQkwtSG8Oq53yaxD9YvlNkgakPLoe9iMEa6YMwqxahleOaVSSEzeog+NOSQfXn949rxUlsNVCKTBTTVYzdNf5QCsOsvLexEiU5gLGyrgUOp27L6Zkaa+U23x0BFiYUx5qmXBaJUgVVuJ5xRDwkc/ddBTfoJHX4IRGvH7y47n47IJiktY3+HFTlj5G/WJD58rTPTOxgGU6wPLJFkBOVQE17ZTS4MMFnM=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYYPR01MB10592.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(56012099006)(8096899003)(11063799006)(38070700021)(13003099007)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?UTRua0FRS210aGhmdHJwN3h0ME9YUGoxWGhDNlh6QmQwcmtxcXFYRUVn?=
 =?iso-2022-jp?B?ZVV2NlZpNllkOURETGFlR0kzMFp4WXZhSXdrdVRaMytlU1U1UkcyQ3N4?=
 =?iso-2022-jp?B?cmY2Y0x6SFRRdzJ5MFFhaVVOR1U5Z2tNeC9EMUUwZWVQbC81RnFpSm1s?=
 =?iso-2022-jp?B?Qi9FMWpaRFJCMHpSYUhmUmVBRk1QY1BpY3R5ZnArTThheW1pRU02UFVV?=
 =?iso-2022-jp?B?cUxaMFJSam9uYjJRdUdIdS9FTWtzL0Z1OWRZNTlaTm5UaWpkWXd5K1VW?=
 =?iso-2022-jp?B?WDhyMHZ3SHc3dWl6dVpJV29MUXZ2NHg1OUxXbC9xam9Xb24vU1p2djFU?=
 =?iso-2022-jp?B?LzRxMUhEYVY1T2tuY2ErcWNBQkZEdnBRZUxNV1FON3BHVHZPaXdVcm9P?=
 =?iso-2022-jp?B?ZzdIMXZjU1ZNNTVSdTZtLzA4MVI2VUNYSjFlbnl4ZnFzNm1rMkI4dzlS?=
 =?iso-2022-jp?B?QjNxeDZpQ1pKbklKVGlPaE5EWGhnTXcyL2pqVW9IaFpveGJwSDYrWXFy?=
 =?iso-2022-jp?B?MlFjK1VzSVMyY3Jnait1emFHaDVjaVZMOVcwZXpZRkVCZEd0c0RvT1ps?=
 =?iso-2022-jp?B?Mm9FajhVRCtmanZnSHFneTBOVmYzcDFodzBDM0FTcGg0MmJIVDBVNTIr?=
 =?iso-2022-jp?B?SnJxYzRIR0VlLzVDS0RMSGwvWjhPSThISVNJY0RqaVpMZHM3c1ZRUG9D?=
 =?iso-2022-jp?B?Wll6RDlRS1J5emRET1dDa09uN1F3SG5wR2xSSFVDbVcvaGI1MVQxSytq?=
 =?iso-2022-jp?B?Q1RNcExaODZMcnRXMG9hc0ZUR3psVkdHT3NGdW1ud0J2WmNjek5nNjIw?=
 =?iso-2022-jp?B?dDU5MDh2bUlFMDV1S1orcHVCRldYQWFCKzhEckR2cmgrRm5aNjlKSmZN?=
 =?iso-2022-jp?B?NnA1ZThLUkxZaWdIcHpuQ1l1Vk8xNmZsMDhmK3dZb0s5Q2hlTVlJSHVS?=
 =?iso-2022-jp?B?Z1A0S2pRMUU0TjErSGpqY3VaQkxYRzFJZXNvUW1jeXR5WmZsa2hiV3lJ?=
 =?iso-2022-jp?B?eWl6R0NwK1JnY0ZOd3h0aUVUZHZMc0pjelZJWVp5cklqMUtMbkNGZ3Jy?=
 =?iso-2022-jp?B?WlptRENCNjFEWXNROEdTTEZPaVhwbkU1NXJQZmNxS0MvMGdMSzNJamxY?=
 =?iso-2022-jp?B?YXB6SGhNeVl0RXZTYkk5bHo3ZWJOazdyQytBMGpDeUYraWg3VEV4dmlx?=
 =?iso-2022-jp?B?UkdDQWlRMS9MRFY0ZDQ0MmIrc0NXczhiS3VIZkJqQTJ1Y0RmTE0xZ1pK?=
 =?iso-2022-jp?B?Mzk5ZG14RDNjSE5FbzNOTEpiZjVuaXpZVkJ1c0wzQlpOeStaZ25pZTY0?=
 =?iso-2022-jp?B?MFdwUElJbUpPanpGMjRGMmxHSjg2aUtSLzNzL21PZjk2TnFhYUkvd0Zn?=
 =?iso-2022-jp?B?NmJmQVdGdzdKQlZmbmNGb2RMYjlNdlhDTGFzSHpIa3JEN1A2bG1tVTh4?=
 =?iso-2022-jp?B?RkVaN3FIa1BqRWs2b2lrVzMxZWFweHBGSXd1aWVnUWpZcHc1Tk9xcHJ2?=
 =?iso-2022-jp?B?bllJWUdHYk9ydzNiTWtodUN1QnAyNEM3K1cvSG1vY2tvNFVXQkhWQ2NS?=
 =?iso-2022-jp?B?VzIyMWZEOXZDcXlBdXdEUEtpUTdpUzdSUkM4THU1amI5NVgxMTF3a08x?=
 =?iso-2022-jp?B?QnU1UVpvQ2RtSXptR3dsd3A1ZDVSSkpma2puOXdFVWJvS2ZRTHZwalU2?=
 =?iso-2022-jp?B?czRBeHF3NDVYbWIxZTVYZ3RMdFpTTndEVkRMTzBQeWpmZ1dOanNYb2dz?=
 =?iso-2022-jp?B?ZFFGeGpwN2JtZUpYOWtBa1AyZ3pSWkp4VHkyR1NTaVJwUHJHTmpxc2p6?=
 =?iso-2022-jp?B?NGwzR1lnRERtczR4ODRlOUVUZjR3NkZjSzZCaDNzc1Y5TnorOVVuSlNH?=
 =?iso-2022-jp?B?NVN0VkFiVVBsMzRIQ2JRbTQ1WXU3OGJ2UUU1V0ltUVRXVTRLOHl6RVpv?=
 =?iso-2022-jp?B?VlNGZ0NwOENHbTZkYU9acFg4ZFBVeExidTYrcWdBQmtLYS9EOHRtZ2Zm?=
 =?iso-2022-jp?B?VFFIYzIvbWhxcmNpTzRDZkEzamtwN3dzWWlGTjlsQkkvOUxlU0lhYXFL?=
 =?iso-2022-jp?B?WUUwdHlObkZTaGRXRm0xQTdVWmVvTDJuTGQ1V0g4RThMOE13RmhpT0FQ?=
 =?iso-2022-jp?B?STVqOEZGSm16MDVlbU1aOW02ZTJEMVlDWURDbHM0dGovZEFENlpVKzNU?=
 =?iso-2022-jp?B?NGlSWDZTV29ZK1ZTejAwRFdudGp1R3B1MGNmOTRsdnJPcU9IZVNCeGJY?=
 =?iso-2022-jp?B?azl5MEJ1UHQvUUpHM1FJLytsRUhUb1VzVW1aWUdscnpCZzNyM2VkNGhB?=
 =?iso-2022-jp?B?UWRocnpRTWU1SFl5UlVuTFhjUnQyZFZPYmxCQjMvMTBNdk1BVG5peUxD?=
 =?iso-2022-jp?B?OFNLUFFvK2o5R1l3ZXRleXJIVVlHM0svSU9pbEFJVWZhSlUvT1FuVlNO?=
 =?iso-2022-jp?B?ZVo0WHI4Y1hRc1pVbEZRaWpFWlhuK1oxaVl4NTAwTEZQYjh3TmkvNkVC?=
 =?iso-2022-jp?B?Z0d2Wk45bG41MkxncFpHLzRKUlRIY2grL3JpZjFIK3RzeS8yR3JrSnVW?=
 =?iso-2022-jp?B?eFU4NHJGVT0=?=
Content-Type: multipart/alternative;
	boundary="_000_TYYPR01MB1059265F33AC401875490D349DBE22TYYPR01MB10592jp_"
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
	GnoZigvEYOHS3LwpDkNTQXsbnEd6XrtUG2K1547ZRM1R/47PJbW2StHDrKZCNMml5tLaWwlfU/X5o65faCuWJ/kv/qcMMIBmTDPWBFm067aAm4+4spj4oLO7qessEn+0di+cwP0LOz1g0z4MFwFoK7fKisFcaunuTWgx5RfT1lgzMbPRu2S+bUhxLx5g+kQseRB//TRACIFxKUyhNYjWzm/UhIhbczqaKWKKXH51oAGbYuGmxl2VyTdnwRjP0PrPg4Wz5G3zvLWKWd1dUpXPJRgvfr3A390yUyHySjqouZl5MrCpYaMt7PU3GPlcFk8T4KbSWesSKzAcc+ZvhYgTaQ==
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYYPR01MB10592.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0b27ce8-75a8-42d5-3bb1-08decdbb5b9c
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2026 04:29:31.2562
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DpxvlcOV42lW38IDCuZMn0P+LxZJ7NmkRvGdqpT1ECU8hfrSY619+aWaCPqHMME7QHYdEXR02BnfXPR1kqaWg1N0TYV2rRUt2l7IPz5xvz7XnFDFJsvIuXUTf2hlQSZM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYVPR01MB11130
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 19 Jun 2026 04:29:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23227

--_000_TYYPR01MB1059265F33AC401875490D349DBE22TYYPR01MB10592jp_
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hi All,

Apologies for confusion caused. Please ignore my previous email.
The MR is currently under the package maintainer=1B$B!G=1B(Bs review.

Regards,
Sahithi
________________________________
From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> on beha=
lf of akunuri.sahithi@toshiba-tsip.com <akunuri.sahithi@toshiba-tsip.com>
Sent: Thursday, June 18, 2026 10:13 PM
To: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org>
Subject: [cip-dev] Autopkgtest support for passwdqc package

Hi All,

Please find the autopkgtest related MR link for passwdqc package:
https://salsa.debian.org/pkg-security-team/passwdqc/-/merge_requests/1

Kindly review and provide your feedback as soon as possible.

Regards,
Sahithi


--_000_TYYPR01MB1059265F33AC401875490D349DBE22TYYPR01MB10592jp_
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
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
Hi All,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"line-height: 20px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
Apologies for confusion caused. Please ignore my previous email. </div>
<div class=3D"elementToProof" style=3D"line-height: 20px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 11pt; color: rgb(0, 0, 0);">
The MR is currently under the package maintainer=1B$B!G=1B(Bs review.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
Regards,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
Sahithi</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> cip-dev@lists.cip-pro=
ject.org &lt;cip-dev@lists.cip-project.org&gt; on behalf of akunuri.sahithi=
@toshiba-tsip.com &lt;akunuri.sahithi@toshiba-tsip.com&gt;<br>
<b>Sent:</b> Thursday, June 18, 2026 10:13 PM<br>
<b>To:</b> cip-dev@lists.cip-project.org &lt;cip-dev@lists.cip-project.org&=
gt;<br>
<b>Subject:</b> [cip-dev] Autopkgtest support for passwdqc package</font>
<div>&nbsp;</div>
</div>
<style type=3D"text/css" style=3D"display:none">
<!--
p
	{margin-top:0;
	margin-bottom:0}
-->
</style>
<div dir=3D"ltr">
<div class=3D"x_elementToProof" style=3D"text-align:left; text-indent:0px; =
background-color:rgb(255,255,255); margin:0px; font-family:Aptos,Aptos_Embe=
ddedFont,Aptos_MSFontService,Calibri,Helvetica,sans-serif; font-size:11pt; =
color:black">
Hi All,</div>
<div class=3D"x_elementToProof" style=3D"text-align:left; text-indent:0px; =
background-color:rgb(255,255,255); margin:0px; font-family:Aptos,Aptos_Embe=
ddedFont,Aptos_MSFontService,Calibri,Helvetica,sans-serif; font-size:11pt; =
color:black">
<br>
</div>
<div class=3D"x_elementToProof" style=3D"text-align:left; text-indent:0px; =
background-color:rgb(255,255,255); margin:0px; font-family:Aptos,Aptos_Embe=
ddedFont,Aptos_MSFontService,Calibri,Helvetica,sans-serif; font-size:11pt; =
color:black">
Please find the autopkgtest related MR link for passwdqc package:</div>
<div class=3D"x_elementToProof" style=3D"text-align:left; text-indent:0px; =
background-color:rgb(255,255,255); margin:0px; font-family:Aptos,Aptos_Embe=
ddedFont,Aptos_MSFontService,Calibri,Helvetica,sans-serif; font-size:11pt; =
color:black">
<a href=3D"https://salsa.debian.org/pkg-security-team/passwdqc/-/merge_requ=
ests/1" id=3D"OWA95e9fca4-2cee-9a05-4b39-da898746320c" class=3D"x_OWAAutoLi=
nk" title=3D"https://salsa.debian.org/pkg-security-team/passwdqc/-/merge_re=
quests/1" data-auth=3D"NotApplicable" data-linkindex=3D"0" data-ogsc=3D"" s=
tyle=3D"margin:0px">https://salsa.debian.org/pkg-security-team/passwdqc/-/m=
erge_requests/1</a></div>
<div class=3D"x_elementToProof" style=3D"text-align:left; text-indent:0px; =
background-color:rgb(255,255,255); margin:0px; font-family:Aptos,Aptos_Embe=
ddedFont,Aptos_MSFontService,Calibri,Helvetica,sans-serif; font-size:11pt; =
color:black">
<br>
</div>
<div class=3D"x_elementToProof" style=3D"text-align:left; text-indent:0px; =
background-color:rgb(255,255,255); margin:0px; font-family:Aptos,Aptos_Embe=
ddedFont,Aptos_MSFontService,Calibri,Helvetica,sans-serif; font-size:11pt; =
color:black">
Kindly review and provide your feedback as soon as possible.</div>
<div class=3D"x_elementToProof" style=3D"text-align:left; text-indent:0px; =
background-color:rgb(255,255,255); margin:0px; font-family:Aptos,Aptos_Embe=
ddedFont,Aptos_MSFontService,Calibri,Helvetica,sans-serif; font-size:11pt; =
color:black">
<br>
</div>
<div class=3D"x_elementToProof" style=3D"text-align:left; text-indent:0px; =
background-color:rgb(255,255,255); margin:0px; font-family:Aptos,Aptos_Embe=
ddedFont,Aptos_MSFontService,Calibri,Helvetica,sans-serif; font-size:11pt; =
color:black">
Regards,</div>
<div class=3D"x_elementToProof" style=3D"text-align:left; text-indent:0px; =
background-color:rgb(255,255,255); margin:0px; font-family:Aptos,Aptos_Embe=
ddedFont,Aptos_MSFontService,Calibri,Helvetica,sans-serif; font-size:11pt; =
color:black">
Sahithi</div>
<div class=3D"x_elementToProof" style=3D"font-family:Aptos,Aptos_EmbeddedFo=
nt,Aptos_MSFontService,Calibri,Helvetica,sans-serif; font-size:12pt; color:=
rgb(0,0,0)">
<br>
</div>
</div>
</body>
</html>

--_000_TYYPR01MB1059265F33AC401875490D349DBE22TYYPR01MB10592jp_--


