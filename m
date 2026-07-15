Return-Path: <shivanand.kunijadar.v45@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61B42C44501
	for <webhook@archiver.kernel.org>; Wed, 15 Jul 2026 12:02:43 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.134])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.4526.1784116958320012508
 for <cip-dev@lists.cip-project.org>;
 Wed, 15 Jul 2026 05:02:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=shivanand.kunijadar.v45@mail.toshiba header.s=key2.smx header.b=RxdMobIi;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.134, mailfrom: shivanand.kunijadar.v45@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:
	Subject:Date:Message-ID:Content-Type:MIME-Version;i=
	shivanand.kunijadar.v45@mail.toshiba;s=key2.smx;t=1784116955;x=1785326555;bh=
	KMl+WTszdL/KllusiUwQs5J0+RZaUSmwglzr0XE4eKQ=;b=RxdMobIirMXW0y5CLbIEhUCJFpwFSV
	6LMDAkPzfqf4keTt+5X4WMLOHy5Q9i7nVn9jJEdO0dtSp6y5Ng1rs25ezhPAFyY2XmrozNLXX+rZv
	By4EikTSimJ9sCLEwJyeXxpgdyUh319gsW7+6ZiNOK9M/KqkgOn1c9Ywlq2EXpM1TVQU4jv+Xzryq
	S7sm9dvcfHv2n+FptapLQYCNvHFAcLUEuuXdTLEaGRUURWa2O5wWTE50eoUtY4IYiySNV3Ix/Cjey
	aA9QieLpmlJGCswm5C9eV6ba9MlNcnb1P46zoyEBGxQL3A/3ZXPBtMPOThYcym6JBh5Iud2RK0woB
	pSEw==;
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 66FC2Zq42376589; Wed, 15 Jul 2026 21:02:35 +0900
X-Iguazu-Qid: 2yAbwL37MTPqTgBIZN
X-Iguazu-QSIG: v=2; s=1; t=1784116954; q=2yAbwL37MTPqTgBIZN; m=RG8Kj0MOilQ6R2O7O8cRNtzyLgZ26fQ9bvloUqHmosA=
Received: from imx12-a.toshiba.co.jp (unknown [38.106.60.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4h0ZYQ5gRZz1xnZ; Wed, 15 Jul 2026 21:02:34 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eWI0ni17Nl+33PeKRdZUT4pd+1TYL+koWxNa5vxglTtafWNOdDSSNgKy7bUYx9RRSUUVyH7jbi50dhmyesf1oNIqrosRhmCGnojU2jG6RFfbhBXMcdQs0BTL97Q9yHX/9i+cQuzWuBq7jhYQwSohJKB5oNwNc15BcetzLRrgdkFaYNnuUH2Z41rlwRvugjdmsJwrflKLfXU00Clv5CHEoriZ+OSWvDAgruVt5Rcawk8mBhRMvkRvccksTvYJnrbWiGndvQyQQf12tdo7Fg1k+p9VpAi3cNFZafh1qgCHe3TxOEEqQWRPn25IQFEFzi2scZflcLz1l2mq/aiKaTSrAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=anhfpnBfiduvwc3+/cW7ZNlxjqXVIB3n8FaOwYDtIQ8=;
 b=Ft7Hl8AT/22L7ev4P50nwm9woy8zfNZB4CxzP+cHOGc9pPf7NSRT3qkVkXARA+BAavrxThIr+1cVF4WCMFu2XZ+NhJYAXmQt+B3uZOPiH+P0OUp4e6gYwmkZ0TSvlDAuTG5Fa4myu+LGlFJtFvJhYC6jvhKgpcmWEQeiBSZPQkQj59XrD+rtfyDHtggYBZRSmZfj5IM4hSasmn1UZ3gNetOkP2my2D7UP4LoVt8ft52Oo3t8r6ttgcinubPUWaQ51SainvpOlk0Uyb4riy1Bg1iVbUC9zuyE0ZKIwRAbV2/hTk4YEI9W8xzzY7HAYZduR0s3pne1MdqD4HrHd1XQoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <shivanand.kunijadar.v45@mail.toshiba>
To: <cip-dev@lists.cip-project.org>
Subject: test email for the new mail id
Thread-Topic: test email for the new mail id
Thread-Index: Ad0UUc6Jpdvpv0gDRU2Ihl08ndLCzw==
Date: Wed, 15 Jul 2026 12:02:32 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY3PR01MB11075C76724B4925DCA8CA6E3C5F82@TY3PR01MB11075.jpnprd01.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11075:EE_|TYWPR01MB7450:EE_
x-ms-office365-filtering-correlation-id: fb05bc2f-cda3-4dea-6cc1-08dee268f362
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|10067099003|38070700021|8096899003|11063799006|18002099003|56012099006;
x-microsoft-antispam-message-info: 
 nSdx3hx/Hk0BLMzW6+mpNsUGsO88YftjvHBFTyFaM2XlArvG7/amUKEtO6HHB6D6o0/9Rss13dVzVm+Jmwt1zYHqzGSZbH3OkXJYUDCBTzONeRbfUxMeZKnuG9BXDYLSMYbTftH1EJzIYqzUNnkmIQuSe8VEOY9fhypMXchgMPgGfLNC2V6G1NSdHJowWvvQwcS6YVb8Gm0qCdoSGaWEEGxYUgxLb4GGGrxgAh1Ic2EOTDQFE6QRjhedrP2DTC+/8a1C9ysE2kwenrc3gP5crDLHCgbwif1l1fnl1Bet9HaAED1zizzuaYFOImtvyLPutHTtdshYJm5SxDyaS3/5xDaDC4WtHV2DBAFYaSLodEa6qW4CQVf+0mADCtNXj8WCNwaKrAQn1mnqYrmeOKhcZnot+2jWAqJlukoiDGdRkFkslSF3J2tliOdWrEApe6SLCbd9VTK5eJcYzzFdYTJyIQ==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11075.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(10067099003)(38070700021)(8096899003)(11063799006)(18002099003)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?MktaVmlyT0xMbzN0VVN5R0NuejRGcVMrV2MyVnh6eVNON1cwVC9OSE5T?=
 =?iso-2022-jp?B?RFQrMDE5VkdGYmltRWNFaVczVGRoeFFMdU1FQzhEeHl6b1hObWFEenU5?=
 =?iso-2022-jp?B?bnV2UnAvbEwySWFGU0lPSWRVUTBxNnlBSS83NzVCYnNqSldnc1VFdWZ4?=
 =?iso-2022-jp?B?ZFpRR2lROC9KakpieEo5clJWRWpYc09nMzc4VXdlaW5DYU9uSW45dWJv?=
 =?iso-2022-jp?B?QkptNzNKM0VSZ0hkZGVPNCtWdWFhd2ZUUWV4c0pLK3ppTVRlemlUNGY3?=
 =?iso-2022-jp?B?TEZPZDRrVloxT1lyVVl5TWtkakZKdmVSeTU1NVlydksvYXFVSjlMT1JC?=
 =?iso-2022-jp?B?bWwvR1JjSGZTRkdRUVdiZmNKa2RUY3BUMUZ0L2VnQXpFQjRRZkFBSTEw?=
 =?iso-2022-jp?B?UnR1Nkc2cmo5c3dkYXVZUjZqVlVhMkRCbmFoS3QyaTU1NWZNQXFrTC9P?=
 =?iso-2022-jp?B?YmtLeFFwYms5M0VCTHFrNjhVdzdMUFovd3FTOGNmTjhmZnhJZWFZSVFX?=
 =?iso-2022-jp?B?OVNkSkdNeVIwK1NPWFMrK2phZkYwNWUyK0UyR1cydWozV1poTjBzWWdQ?=
 =?iso-2022-jp?B?NXNNTkNKL28zSmZxWEVJTzZiVXk5R1U4T3pERUk3cDBOa2hLdjNpZkY0?=
 =?iso-2022-jp?B?K2FId3VNU0ZCQzM3VEEvUGN5TXpwMk1SS2g5cVM4MWVCSTJRT21vbXFa?=
 =?iso-2022-jp?B?d3c5cTlQdmpDRnNFMnVrdVlkaHBDQitrelExV1NhMm81Nm9rTGtoeVFs?=
 =?iso-2022-jp?B?VWRqWmxuVDdZblVzYmFuc3lBZ0UzaUJLS004Yjg5YXBZUlNOVWU1UDJn?=
 =?iso-2022-jp?B?VGdPaTR3Qzc5MjBUVFVJSWEvQjlrRG1DK2NIcExhR2xJSjZ2L2xHTENn?=
 =?iso-2022-jp?B?ZU5OU2RneUVlcHl5UVBkZmMvWWZWRE5JU3dYZytiMHpaanZsVmx5eVVn?=
 =?iso-2022-jp?B?TWJzVzJZYVZSK3ZQdHMyRHJyQStEVm4rb3hwVmpNN2ovbG5kS3R4b3U4?=
 =?iso-2022-jp?B?M1RYL1ZLZEkxeXIyQndHOXFobjBwcE85eWFzMzVldDlqaldvaGc0d0pu?=
 =?iso-2022-jp?B?aTVQRkdOSXZCRm45dmszN1h6R01xOG9XUE45Z2RmTHNhdkc5a0poZC9E?=
 =?iso-2022-jp?B?ZmlZNlp4YVVyanByTjV3cVUwd1BTUjV1N3ZOdHdWQmIvZHgxeHZUU0FP?=
 =?iso-2022-jp?B?TC9rSWZBT1NENnAyaXNlalVTSnVWL3Y4cDUyaE1mcnU4YWc0anR4ODAz?=
 =?iso-2022-jp?B?alRGVmh5Z0d2QXJjYm1MVzAxWXA4My93b3J4dk9LckNWYWdQdmVacVoz?=
 =?iso-2022-jp?B?c0VaV1RZVzJjMVlyMTJadEFIeVhlN2lYZ3pXdVR6SytJSGNRcWg1UTh2?=
 =?iso-2022-jp?B?c1JvSW8wN29qYTFrZlpsOTJ4cGgrbTJiUC9Vd0lsUTNpeUlVemRFd0Z6?=
 =?iso-2022-jp?B?VW1hVmhCc1ZDNG01L3U5cGY3WmRmWFZybVA4N3ZHdGloa1hhT3FTa0Zp?=
 =?iso-2022-jp?B?K1I5TlFEVzVHaG5FQWo5dHUzem10bzI2VXg3S0tJd2ptcG5ONktsNDZT?=
 =?iso-2022-jp?B?MHcvcHoralM4dTBRbFZRUmg0RTc1QWFqT0I2NUJocmZMSUw1RTE0VUlw?=
 =?iso-2022-jp?B?SnZ1NFl0U3E4MWF3YmxxY3hjTGFoMVo2ZlZsVFJIazhzZUVQRytBc2lv?=
 =?iso-2022-jp?B?SVZRdkErUHdVV0pSY3pVZDY1SVdUV0VxMzJHQURrS2N3S1B1aDJNRjFa?=
 =?iso-2022-jp?B?WHg1c0dLNjEvME4vMms0ZHBrdkVldUVZd2dPbjNqbE9NVWR1SnZFd3dy?=
 =?iso-2022-jp?B?ckhQdDh2Q1M1K0ZnS0VzN3BnMklJSktzeXJSVDd5M25NRXN2RDJ1SFhr?=
 =?iso-2022-jp?B?OWIrVUZNL3J0MjZkVFhhblI3dlFsVzRGbUFUZ3ZIbUpvaWlzTzBrNzJL?=
 =?iso-2022-jp?B?cFJVYUpRK09DNTBYNm9JWnBmZjgyelBUSThWRk4zV0pjcTkzNVkyZW1s?=
 =?iso-2022-jp?B?cllxclRWdUVSNXQrYjlYbk82ek95ZjF1ZjI3dGkzTFViZllKbWwzbDhM?=
 =?iso-2022-jp?B?a2ZaNlo4VTVmb2ZDK0dmTk8xbXZCVHdSQlo5dFBsTkhISjk0QktWYzFK?=
 =?iso-2022-jp?B?bHFMdWo1WmVXeCtncGdLb0ZxSTkvSVBUZmhCYlRTS3FMUDduNUs2UU4w?=
 =?iso-2022-jp?B?Qm5EUzZ4UTV3dDFFYlArVUw2Nmg3bWYrSktqTktoOHFGeGx0T3R2Q0hl?=
 =?iso-2022-jp?B?VHVmLy85VkVxVHBhRVh4SXBBbGZlWklzZUJvU20yNUh3eUpFYjVCQm9y?=
 =?iso-2022-jp?B?ZTgvRURIY2lPR29LbFVqc2dReEtZVnRyNjN0ZDBXbHBtbzgvcWMzd2E5?=
 =?iso-2022-jp?B?V3lxZy9NUVE3eXc0WExTM0hxNTVWUm42WEloSUpWMmZyNHdGaXcrekVp?=
 =?iso-2022-jp?B?bU1BN2h6bVhTdmx4QVlyQTljY0t1cUlFelN0blJsVHpvZEMzTThWcVps?=
 =?iso-2022-jp?B?d21kOEcrcFhaSTFpLzdmMzMrYnJrRmQvN3ZDRWJzVmg2bkJPU0dIVWN2?=
 =?iso-2022-jp?B?bXZPYWFZT012M3R1SDltdEJsMTRPQ3YyaXZkQw==?=
Content-Type: multipart/alternative;
	boundary="_000_TY3PR01MB11075C76724B4925DCA8CA6E3C5F82TY3PR01MB11075jp_"
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
	f976cK/Jrz35zpcdJsaacAYLHXw0k5STT8YYOVEfwlDpyUsjJyhcu0rW4mr+5S0/iakXff2mNznCJ6QqS5+bHiUONqEZs7sQufDkau/G91c80rbX84xqIm6yK9OJBJecyqouJ5/Xp3mQg4rdRYiudGXeh9/DV3bE5udYwaPviSyUmwmbunxWkqPiDVopKlukziMf55xJO48KbLJ/kM7GqPDDVPfr5LibgvWw2VDr/D44C+ZT3OnquRKbuWnenJGAdV2Y7LKGaprtZ7j3gCxUfAjTI3+CySeiBEBdL6wrkRBgly38nWyRPGwCLQ4kcT7teXifWye1DdDD+8ItRTDKEw==
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11075.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb05bc2f-cda3-4dea-6cc1-08dee268f362
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2026 12:02:32.0787
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FXnmBstgLm8gy9Vv5FIkc0awq8I9JWi6UvWhHXK6ab6FQzP4Ydp1ug0/FIaAuk+Px+zrbZ+YQ7X68urszeld+bCdFggbyFT2qQMFtqbt5qNEkYEU++gFU2cmUfO++jiU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB7450
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 15 Jul 2026 12:02:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23596

--_000_TY3PR01MB11075C76724B4925DCA8CA6E3C5F82TY3PR01MB11075jp_
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable



--_000_TY3PR01MB11075C76724B4925DCA8CA6E3C5F82TY3PR01MB11075jp_
Content-Type: text/html; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

<html>
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
	{font-family:Aptos;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	font-size:11.0pt;
	font-family:"Aptos",sans-serif;
	mso-ligatures:standardcontextual;
	mso-fareast-language:EN-US;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Aptos",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:11.0pt;
	mso-fareast-language:EN-US;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 72.0pt 72.0pt 72.0pt;}
div.WordSection1
	{page:WordSection1;}
--></style>
</head>
<body lang=3D"EN-IN" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:=
break-word">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
</body>
</html>

--_000_TY3PR01MB11075C76724B4925DCA8CA6E3C5F82TY3PR01MB11075jp_--


