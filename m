Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 800F5C43458
	for <webhook@archiver.kernel.org>; Thu,  9 Jul 2026 09:06:04 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.135])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.4941.1783587958971734051
 for <cip-dev@lists.cip-project.org>;
 Thu, 09 Jul 2026 02:06:00 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key2.smx header.b=rJ7z4rXr;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.135, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key2.smx;t=1783587956;x=1784797556;bh=V7lHdKS7SabikX3f7TlC/1c9XQIiAb2TGmiX8
	1zvJHs=;b=rJ7z4rXrlVYRwzhkO+gdTNw5jPk/HPlT1xuOfHn0IjkG52vNlUX58wP8cdb+Wt8GVMt
	vDDcmx+YCpP0aYGIT0pT+zhttTx63hwsnXtPX6hsfkE0D9yH7uePcEvMa0PdAG/+Pl3xm1mOIxm3a
	3ZYsa+EBUBVF819U4yYKzUwWdVdkUchvjrP0R5hlmCsP/H+Yko7+RHDHkH0I4aoEmO64CYAIvq902
	Sr2bC5L4IGaMWXf7Jrb8ocYzX9nHOUcy2ZvesnDGwQkbOLn6vxaoefrmKJzNRNsF9o3S/kxR3rkqC
	QGBrY/RGS0U22eLvA5ZNbWv+XtJ82ykvcJM2R8oPKbIg==;
Received: by mo-csw.securemx.jp (mx-mo-csw1801) id 66995uGD212628; Thu, 9 Jul 2026 18:05:56 +0900
X-Iguazu-Qid: 2yAar7SANgUgUCtXZy
X-Iguazu-QSIG: v=2; s=1; t=1783587956; q=2yAar7SANgUgUCtXZy; m=bZHPcaAqV+JFovCaUEl3ytToByW7jABD2R99yOaCSTA=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4gwpwM6fH7zyPQ; Thu,  9 Jul 2026 18:05:55 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=onOyEx8paV+VF24S3KEWO89F2aXKeyi8+6aErTTC4KNu8crU0CBLI992JMxg+2z6fsqOrIIv02OSpkvBMjtm82p4P7P0Gz5Kjx4ZNLaVaE5TaEqjvbfco28OlfQwIpbG4l3iRveQTRqmnql2Su652EmB8c01difKpVvKvQyC/u+XBIXh6TsE4TTqGw/TD2McRu2D7ObBCLmDDF5Qog2KU7dTEtrLdDjvwlC+RDuXG/T47/tZn2B37YtKIKRpvr6XxS5fmkYlqKIYhjlQWK3EckgkrH404y9UDX/ePz5iICwyhF81QaqkbweV13h+Sixm2/TQxOrZ+oCzv7+qozooaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V7lHdKS7SabikX3f7TlC/1c9XQIiAb2TGmiX81zvJHs=;
 b=Q3D6rup7OMX/4WulErG/Pv3+7SYsaflyYfBp2zyQkJvczUc8BO/Pd7Th+3kNHxdCSQU6XDfcrdPBo2RXuvBR9AZ6zw5nvykGHHLNyVrq52ZacNjJxgOO6sYsbloBGrnJY/vMTn9lz1USMgjH5pH9M/jQMNf7ip3wZBilLMBaKocOlXF1JUtJ2T40wMEXUumnXzeDo2cURv8Meyu7qgPMZKBgPnImwXMHEDu7PAi5+NJKSE+8//zJkGaNyNXinCbLSz/Fbk24rsGZ9VXcAH1ZdnPWAwHZehZmyOUGwji/d8EW3PQ600NjxPxw8Aq+OphlVG83QdJqn5RZL4G5Q1No3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <jan.kiszka@siemens.com>, <cip-dev@lists.cip-project.org>
Subject: RE: [cip-dev] CIP IRC weekly meeting today on libera.chat
Thread-Topic: [cip-dev] CIP IRC weekly meeting today on libera.chat
Thread-Index: AQHdD2vtbjoTnahI00OsR5ObOkNpH7Zk36uA
Date: Thu, 9 Jul 2026 09:05:51 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB1481891F576C61A0B4220B734CDFE2@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <105b3b23-0aac-4c23-afed-047a556f96a1@siemens.com>
In-Reply-To: <105b3b23-0aac-4c23-afed-047a556f96a1@siemens.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|TY4PR01MB14813:EE_
x-ms-office365-filtering-correlation-id: e5107d1d-420e-4d92-97a8-08dedd994692
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|376014|23010399003|1800799024|38070700021|18002099003|22082099003|56012099006|11063799006;
x-microsoft-antispam-message-info: 
 gAY1ab5elgTkRKdRiUJYn/6PtCkhWfvMpCUGeItbJxAbqTBaO31IFr9qz94Hb2u7L00Adr4Cvis502wmxO40tHGcaYNdRMnEwA17QC3OqdBVBU71SexGaUy9n7Bh/rEaUGIv2yzWxdXnfme7Fod9TmIgEMf/OXYOOrYAnYt40h9vtoiqVCXQUnt4f5bARh+slvMFgZL7njfTMYD2tV00hSny3S+kb37oEnrF7DrPIBu897PEEoHQn3z2QHe7e1eNsVBoGtZnGamHgwpyrBLwyRDtaJjVljhsYW9nWyjLJWDEaKqRfxdk1+rND5R+ArNKOGm6y41q7kuHzpV5N177RxBKSMYdvbQ3ag3c0zUXwaO+Edh0Rvlr6kdgQr3twOmpKojVxysFzAuVv9eeEw0TQu8pTbYnbPBk7sVfULTJakoBC4vA6SYQRFFqf+FGlUqlKA9YoRsv51aLHCVM5BrA6dGQsM+QNCATclZKMRnYL021+4h32ewyL+ooYEu01HWD4pvEmhJr1B/kkF6dN8bikfEqIFq1GFljiS8s1BJROsf+pQf4xBJudghPJc+aUAKReziG2FCq3ypyDH6MaJkY/+XU0boEvHWh3ubOjGcv9up+W53z1poCZ1/tO6g9vxjWIJK4GrdT6ScOrjTMMZ6kw6cVW6d7zP444fWnMIzRWys=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(38070700021)(18002099003)(22082099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?OXd4dW05SWg3Zk5ZcHhnOTBOQWUyMjJFaUpVaXg1L3NWdEoyd09pWkRLVEZl?=
 =?utf-8?B?WHBnSXJGR1pmSGtmZDJSNG9pNEszRUo3VWNCTWZlQ1pGY05pWExWNVpTQ2Ex?=
 =?utf-8?B?YzlOeXVMOHNpdVlXVHJVQWFjMWU4QlNFNk9RSm80aHFZUU9KR2ExNXlVcHM0?=
 =?utf-8?B?R1NUTldndzNkNzljTUNvb1RjMUF4ZzlWMk9rK2J3cEc0VGdxczh3VEVYYnpq?=
 =?utf-8?B?cTdKVWJRZHZFeWdIdGJmaFo0VGRlK1dJV1kxVzR0WjFUL3pEbXRlazdrdktz?=
 =?utf-8?B?UU4wYldySjQrZkl4b2I2MWpaVTZ0Tjc1QVRZZTVvMXZuSDJPY3h4bC9XMlFy?=
 =?utf-8?B?cjUyZkRnMXViNnhGYzJmWTBKV0ZnVkw1dGJRTE5yT1hqVnd2cmp5dGFvOFlG?=
 =?utf-8?B?ZGtkMHBpRlpXQzIxRmJiWTgxSVlibG81ZERwNDhJNXRtUnhoa1UyOGJ4aUJB?=
 =?utf-8?B?RlZnZVplZ09iVUgxQnYzYWJUOGdVNkJUanpwclFmQU9SQ0ZGeGFMcE41OWNl?=
 =?utf-8?B?YVhxM3UzUndaTHdiTk1rVlJwcDJPb085Z0ZZZG5oNTVnWmk0RUJKcndDSHRM?=
 =?utf-8?B?MWZVT21RVTVhWVBxSzNwUk5aU1BBUDBndmMremQ0T3dEaklJcVBHME5CY3NI?=
 =?utf-8?B?cWtlVTJBRm1MUHJzME5IRCtjdDRaWlhOVnpSQU5NOUtFYnFCbWFtbEc0MzVP?=
 =?utf-8?B?NGEvVjdQN3ZQamw3eDhjVDVVMnNGd3N4bExKMUYvOU1MQzdYb09SQlN2aTJH?=
 =?utf-8?B?OExNa3FVSGJuUG5aaDhFS3FGUk83bEdReUhFcHVOZjJmcjJsbU1KL2VNekMy?=
 =?utf-8?B?aGNodjV3dWJYME1KZHlvMlAxWnhxYktwa252NStoTm5WSmljTHJQQzBoVHha?=
 =?utf-8?B?U0VhSGZTZVlGTFZtVFRsS0lrTUVWZzlFTzMvS1ZFVkZVZ1pwOThRYzcrY0Ex?=
 =?utf-8?B?SDNxWGYzUk9hT3krYkhldXlkK1RXUldjTDVyekVyUTNzbU5KOXczR3l3cnNG?=
 =?utf-8?B?QWthanhDaS9JcWVLNVBNYTY0QzNuMENpNGVJQU4wUFdHS2d0QzJxYTloenlN?=
 =?utf-8?B?KzF3TmxvUWFYbG1zWVZvZTdXL1BlblozaDd3QzZraTFSSXZKTmRja0lBSVJX?=
 =?utf-8?B?T2JCNFBtRnI4b1VJRHZ0cEZZcEJjem41MHlRaHRxb2c4dzNRb055WXErRmxR?=
 =?utf-8?B?dHUxOXpjVG5QeFpldHlCbFB5RlE4RGo0SHdaaVdOUWtrOXh4enhTa2pwZUJh?=
 =?utf-8?B?M3RnU2VoRTVaSURXTTZ6bFhQVko3T0pzdWplcEk0Y2tpc1Zvamh2TnE1QktX?=
 =?utf-8?B?MzJFOW4rS3dVeE9KSFhPN1g4OHV5TzFrajcyYXg1bW9uRUVjUk00WExIcTlv?=
 =?utf-8?B?Q0pJenhxVFVha3dnYzBhREpoWUNSUENST1hkcVo4ZldOd0d2eFRsQkZLYTZm?=
 =?utf-8?B?cXQ4bjdVQ3VRRzdSdWxYVHhGOWM1Tjk5dXY3YzlYeGNlRHh5cHdURHp3cWhB?=
 =?utf-8?B?MEhvaVdUcW5ESllQREprYUdFYll4b1dobHdiT2h6Q29zbVpKc3Jha1lOeFA3?=
 =?utf-8?B?ZlUzWjB0cVBuOFU3aU00bWNFUUFoUFREd3lkTk5jVG15NDRJV3NkeWpKZkZ1?=
 =?utf-8?B?U1JjaXVFUGFCSVNGVkxGYzRlSTAyNXk5L1NKS2NYYmV0NWh3YnA1dm9PUHk4?=
 =?utf-8?B?ZWYwTEE5a2FOdFpoQ2JKTUc2Ty9naVFOOU1CVXRhcUJSUVUzbXlkU1RoZ3ZT?=
 =?utf-8?B?cjFVbmN4UHZub25SN00wTThHUzRjMXI3b2FYSmhCa1hjYjRHeTd3S0ttV2hr?=
 =?utf-8?B?cUV0cG9lT0MrNFlYS2Y4eEZMWXdIZWFrZXljTzFZK0d1Tm5DZll6WTdIWC9p?=
 =?utf-8?B?eVpvWEFHS3BBM2l5VWN1ZkZ2cE9hdEZrNk9kamhGVnN6OGxTZUgxWTFTMFVu?=
 =?utf-8?B?YTdiM3Q3U1NOc0VCV3cwV01BeXVNT3R6NGRsZ2c0K2JnRnF5VHh1QzFub0Jx?=
 =?utf-8?B?M0w0YVQwWHZWZTcwaThoUGFNaXdTQmNLcjB5aEpmRUZPM2swVHJmczBlTDMy?=
 =?utf-8?B?MnNwTWFlalJreTR0N25KUS80eEdQME16ODJEOExpVFBUaGk0WU1EM0dsL2tw?=
 =?utf-8?B?QXJxcUdpMkw4QnVpWlBBNVFraWU4UTZjUkFPaThOVnRKVUVzRjk2NEtqWVlV?=
 =?utf-8?B?MmZGMDAvazl4a05RbGJOVnYyQ09aWFZoV2h2eThIOCtrM0s5UzFTbDRqdlRp?=
 =?utf-8?B?bGI2UEVyYmRiczV2emMvMTQ4ZS9YTm9aTWZSSE5EQ3pPQmYrZlZtbS9GQ2VP?=
 =?utf-8?B?TDUzYlpycjhaYzhhOXd0cUtHMlN6QjJ5NmFyekMwMkZ2OFFVSWkxczlUU0pB?=
 =?utf-8?Q?wacRk9+rk/08NY5w=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
	L3qeHFeIOU7/8qDgKtHyZ+ZvT3zC9aMSa23inXcr+TBA2xsghxmbLyXBiR/X6byW9atbyvheWh0U7zqX/BaEFVcPUHgYEW4hk1+xqoKZKYb+4dMJ+MvzRPMC4V4LkIX8pbl225mhVI6yXvQzEKUMBe07T2/8BLczqYxkfBj85ByvuDlXscrw3Ixy6cKbH/RRcHZywNcUc+xa4+pSVj/SsLFctn6XoZ4d7C+6UXLw88Hdzb6T9I6hJHA9dY7M0NWMzeNS21HaiFSKAr6puvUBHIccdd8vjvrKU5/gLRdYxPwRXkDHwznqTPZ2Y4WIl1qVp4Ymi5O8HqDyzyS5YIBfvg==
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5107d1d-420e-4d92-97a8-08dedd994692
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2026 09:05:51.6642
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tNaKlZUtY/dKVuhuKFyF3nJ4S4dqhwk2bqfhyKaOEMsB8bV/eMPotf6h8PmnjvX6/IYZGXlI85sxAyR0ELbvW2FxYEz3XOyhAtIgLF/Um5Vntc8ozrBcjajI0xn/Iuit
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB14813
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 09 Jul 2026 09:06:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23555

SGkgYWxsLA0KDQpJIHdpbGwgYmUgYWJzZW50IGZyb20gdG9kYXkncyBtZWV0aW5nLg0KDQo+IC0t
LS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IGNpcC1kZXZAbGlzdHMuY2lwLXByb2pl
Y3Qub3JnIDxjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZz4gT24NCj4gQmVoYWxmIE9mIEph
biBLaXN6a2EgdmlhIGxpc3RzLmNpcC1wcm9qZWN0Lm9yZw0KPiBTZW50OiBUaHVyc2RheSwgSnVs
eSA5LCAyMDI2IDM6MjYgUE0NCj4gVG86IGNpcC1kZXYgPGNpcC1kZXZAbGlzdHMuY2lwLXByb2pl
Y3Qub3JnPg0KPiBTdWJqZWN0OiBbY2lwLWRldl0gQ0lQIElSQyB3ZWVrbHkgbWVldGluZyB0b2Rh
eSBvbiBsaWJlcmEuY2hhdA0KPiANCj4gSGkgYWxsLA0KPiANCj4gS2luZGx5IGJlIHJlbWluZGVk
IHRvIGF0dGVuZCB0aGUgd2Vla2x5IG1lZXRpbmcgdGhyb3VnaCBJUkMgdG8gZGlzY3Vzcw0KPiB0
ZWNobmljYWwgdG9waWNzIHdpdGggQ0lQIGtlcm5lbCB0b2RheS4gT3VyIGNoYW5uZWwgaXMgdGhl
IGZvbGxvd2luZzoNCj4gDQo+ICAgICBpcmM6aXJjLmxpYmVyYS5jaGF0OjY2OTcvY2lwDQo+IA0K
PiBUaGUgSVJDIG1lZXRpbmcgaXMgc2NoZWR1bGVkIHRvIFVUQyAoR01UKSAxMjowMDoNCj4gDQo+
IGh0dHBzOi8vd3d3LnRpbWVhbmRkYXRlLmNvbS93b3JsZGNsb2NrL21lZXRpbmdkZXRhaWxzLmh0
bWw/eWVhcj0yMDI2Jg0KPiBtb250aD03JmRheT05JmhvdXI9MTImbWluPTAmc2VjPTAmcDE9MjI0
JnAyPTE3OSZwMz0xMzYmcDQ9DQo+IDM3JnA1PTI0MSZwNj0yNDgNCj4gDQo+IFVTV2VzdCAgICBV
U0Vhc3QgICAgVUsgICAgICAgIERFICAgICAgICBUVyAgICAgICAgSlANCj4gMDU6MDAgICAgIDA4
OjAwICAgICAxMzowMCAgICAgMTQ6MDAgICAgIDIwOjAwICAgICAyMTowMA0KPiANCj4gTGFzdCBt
ZWV0aW5nIG1pbnV0ZXM6DQo+IGh0dHBzOi8vaXJjYm90LndsLmxpbnV4Zm91bmRhdGlvbi5vcmcv
bWVldGluZ3MvY2lwLzIwMjYvMDcvY2lwLjIwMjYtMDctMDItDQo+IDEyLjAwLmxvZy5odG1sDQo+
IA0KPiAqIEFjdGlvbiBpdGVtcw0KPiAgICAtIHN0YXJ0IGJsb2dwb3N0IGRyYWZ0IFtpd2FtYXRz
dS1zYW5dDQoNCkknbSBub3QgcmVhZHkuDQoNCj4gKiBLZXJuZWwgbWFpbnRlbmFuY2UgdXBkYXRl
cw0KDQpJIHJldmlld2VkICBJIHJldmlld2VkIDYuMTIuOTMuDQoNCj4gKiBLZXJuZWwgcmVsZWFz
ZSBzdGF0dXMgWypdDQoNCjUuMTAuMjYwLXJ0MTU2IGhhcyBiZWVuIHJlbGVhc2VkLg0KSW4gb3Jk
ZXIgdG8gcmVsZWFzZSBhIENJUC1SVCB0aGF0IGlzIGNvbXBhdGlibGUgd2l0aCB0aGlzLCBJIGNh
biByZWxlYXNlIDUuMTAueS1jaXAuIEkgYW0gY3VycmVudGx5IHByZXBhcmluZyBpdC4NCg0KPiAq
IEtlcm5lbCB0ZXN0aW5nDQo+ICogQU9CDQo+ICAgIC0gc3RhdHVzIHVwZGF0ZSBBSS1iYXNlZCBi
YWNrcG9ydCByZXZpZXcgc2V0dXANCj4gDQo+IEphbg0KDQpCZXN0IHJlZ2FyZHMsDQogIE5vYnVo
aXJvDQoNCj4gDQo+IFsqXQ0KPiBEYXRlIHRoZSBkYXRhIGlzIGNyZWF0ZWQ6IFRodSBKdWwgIDkg
MDY6MjU6MDcgQU0gVVRDIDIwMjYNCj4gbGludXgtNC40LnktY2lwOiBpbnRlcnZhbCAzMCBkYXkN
Cj4gICBsYXRlc3QgdmVyc2lvbiByZWxlYXNlIGRhdGU6IFRodSBKdW4gMTEgMDg6MzQ6MTIgQU0g
VVRDIDIwMjYNCj4gICBsaW1pdCBkYXRlOiBTYXQgSnVsIDExIDA4OjM0OjEyIEFNIFVUQyAyMDI2
DQo+ICAgU3RhdHVzOiBPbiB0cmFjaw0KPiBsaW51eC00LjQueS1jaXAtcnQ6IGludGVydmFsIDYw
IGRheQ0KPiAgIGxhdGVzdCB2ZXJzaW9uIHJlbGVhc2UgZGF0ZTogTW9uIE1heSAyNSAxMTo0MDox
OCBBTSBVVEMgMjAyNg0KPiAgIGxpbWl0IGRhdGU6IEZyaSBKdWwgMjQgMTE6NDA6MTggQU0gVVRD
IDIwMjYNCj4gICBTdGF0dXM6IE9uIHRyYWNrDQo+IGxpbnV4LTQuMTkueS1jaXA6IGludGVydmFs
IDMwIGRheQ0KPiAgIGxhdGVzdCB2ZXJzaW9uIHJlbGVhc2UgZGF0ZTogTW9uIEp1biAyOSAwOToy
MjoyMiBBTSBVVEMgMjAyNg0KPiAgIGxpbWl0IGRhdGU6IFdlZCBKdWwgMjkgMDk6MjI6MjIgQU0g
VVRDIDIwMjYNCj4gICBTdGF0dXM6IE9uIHRyYWNrDQo+IGxpbnV4LTQuMTkueS1jaXAtcnQ6IGlu
dGVydmFsIDYwIGRheQ0KPiAgIGxhdGVzdCB2ZXJzaW9uIHJlbGVhc2UgZGF0ZTogVHVlIE1heSAx
MiAxMTo1NjozNyBBTSBVVEMgMjAyNg0KPiAgIGxpbWl0IGRhdGU6IFNhdCBKdWwgMTEgMTE6NTY6
MzcgQU0gVVRDIDIwMjYNCj4gICBTdGF0dXM6IE9uIHRyYWNrDQo+IGxpbnV4LTUuMTAueS1jaXA6
IGludGVydmFsIDMwIGRheQ0KPiAgIGxhdGVzdCB2ZXJzaW9uIHJlbGVhc2UgZGF0ZTogVHVlIEp1
biAxNiAxMjozODo0MCBQTSBVVEMgMjAyNg0KPiAgIGxpbWl0IGRhdGU6IFRodSBKdWwgMTYgMTI6
Mzg6NDAgUE0gVVRDIDIwMjYNCj4gICBTdGF0dXM6IE9uIHRyYWNrDQo+IGxpbnV4LTUuMTAueS1j
aXAtcnQ6IGludGVydmFsIDYwIGRheQ0KPiAgIGxhdGVzdCB2ZXJzaW9uIHJlbGVhc2UgZGF0ZTog
TW9uIE1heSAgNCAxMDo0OTo1MSBBTSBVVEMgMjAyNg0KPiAgIGxpbWl0IGRhdGU6IEZyaSBKdWwg
IDMgMTA6NDk6NTEgQU0gVVRDIDIwMjYNCj4gICBTdGF0dXM6ICpMYXRlKg0KPiBsaW51eC02LjEu
eS1jaXA6IGludGVydmFsIDMwIGRheQ0KPiAgIGxhdGVzdCB2ZXJzaW9uIHJlbGVhc2UgZGF0ZTog
VHVlIEp1biAxNiAwODoxMTo0NyBBTSBVVEMgMjAyNg0KPiAgIGxpbWl0IGRhdGU6IFRodSBKdWwg
MTYgMDg6MTE6NDcgQU0gVVRDIDIwMjYNCj4gICBTdGF0dXM6IE9uIHRyYWNrDQo+IGxpbnV4LTYu
MS55LWNpcC1ydDogaW50ZXJ2YWwgNjAgZGF5DQo+ICAgbGF0ZXN0IHZlcnNpb24gcmVsZWFzZSBk
YXRlOiBUdWUgSnVuIDE2IDEyOjUxOjU2IFBNIFVUQyAyMDI2DQo+ICAgbGltaXQgZGF0ZTogU2F0
IEF1ZyAxNSAxMjo1MTo1NiBQTSBVVEMgMjAyNg0KPiAgIFN0YXR1czogT24gdHJhY2sNCj4gbGlu
dXgtNi4xMi55LWNpcDogaW50ZXJ2YWwgMTUgZGF5DQo+ICAgbGF0ZXN0IHZlcnNpb24gcmVsZWFz
ZSBkYXRlOiBTdW4gSnVuIDI4IDExOjA2OjA2IFBNIFVUQyAyMDI2DQo+ICAgbGltaXQgZGF0ZTog
TW9uIEp1bCAxMyAxMTowNjowNiBQTSBVVEMgMjAyNg0KPiAgIFN0YXR1czogT24gdHJhY2sNCg==


