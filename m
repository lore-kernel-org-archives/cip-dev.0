Return-Path: <felix.moessbauer@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A09DCD4F26
	for <webhook@archiver.kernel.org>; Fri, 19 Jun 2026 12:22:00 +0000 (UTC)
Received: from AM0PR02CU008.outbound.protection.outlook.com (AM0PR02CU008.outbound.protection.outlook.com [52.101.72.42])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.41239.1781871715901653425
 for <cip-dev@lists.cip-project.org>;
 Fri, 19 Jun 2026 05:21:56 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=QcSD4DIj;
 spf=pass (domain: siemens.com, ip: 52.101.72.42, mailfrom: felix.moessbauer@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iA2nou9RuhALnNYc3JzdsvEpKXNMbJvwgayNwikJvgBtDKvj3sg6pve4rLkHwHzmPmvzyikQrrvi/nP47bypiVMIGCUP2akM/e4mrMWS9e9RlEw+/219THLYJwjQEz8ISJY2zKGdsO2DI8T3v7p93276gyYse5nT4xLvN1qFIzFv2sVojJGecHGCeWSx3fDkd/xxLzaZtpD433sdNXppotcWwc1MheCoJNSvT0S3aNmrOUcqjiDrkAVl8u8n6G3KgtlEATF2lrIehbjNS5fFgYLAExe7/Z0Cvkyd0qgUnTNano7U4oWXlHtZs6P6mPFrOxQKSur6iW4mhghGdvJBxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0ROyDZnhuaC08PqdYzrspiZjoY8oFhG/uWXC2ZKpYiI=;
 b=jf4+MbzWhnr0231znOdLD+PU0qtjPt+RMH9VyOoAHIYJuWzSgATgZ6d2zTxXJ7YfA21P2X1uwkoGGqbd7f75IYxV7Am9K4Htwi5b2U2yYM9ENMMYiV3kHojXrx8g2srdekRAQ++Iy27K5OzAlIsFbGNJ+my6gp32Rp+9uzbutlAnQCcYm+dA6EUSZ/B09yVmVVZOLsbGdRPc+ef2VSXb0JW4QGn5d1ms2yUXDnJTEpLdwQseZif6SdfaTURLCi+B/5b/6gwXKwQ2uKmJB/q9fdwvumJbUZ27JNwcxU148UxqBYinratHVSRG40pG3HgFqd8hcMqKX6zELTlRtGdSdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0ROyDZnhuaC08PqdYzrspiZjoY8oFhG/uWXC2ZKpYiI=;
 b=QcSD4DIj5Ixh100T+WBBClVhZgrT0z328yTBaPzBDNgIgKUIiYtlxhaCDcoiu+1hmc2ePeztjnNsRt5+1Nj0nP4bszzwhQxnB+ODZLjX3do58TKquy5mYbz40m1GC4gfcezTP01FxYFMA6sXoC0O/4ttW2UUZGV5Xf6LEEuqJilmdzoJFosTqHKY6o8jVkbpDz1Bz2aw77oYlIRepRTopszxi9yznq7nX7h/b1H9+6IbUruhgTTyfCwXu2QpoQvXOOcqsCKqllIOnGsQFLGcTnHjOI1RLDgPH7KBy+xyrW7y8ICes+X4LEuwm2fLtIBwMopv1bRmptOpQwqQmYFceQ==
Received: from AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:17e::10)
 by PA1PR10MB8895.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:442::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.21; Fri, 19 Jun
 2026 12:21:51 +0000
Received: from AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c54c:ccd8:ebbf:477c]) by AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c54c:ccd8:ebbf:477c%5]) with mapi id 15.21.0113.015; Fri, 19 Jun 2026
 12:21:51 +0000
From: "MOESSBAUER, Felix" <felix.moessbauer@siemens.com>
To: "Kiszka, Jan" <jan.kiszka@siemens.com>, "cip-dev@lists.cip-project.org"
	<cip-dev@lists.cip-project.org>
CC: "Storm, Christian" <christian.storm@siemens.com>, "Kowalsky, Clara"
	<clara.kowalsky@siemens.com>, "Gylstorff, Quirin"
	<quirin.gylstorff@siemens.com>
Subject: Re: [isar-cip-core] switch user in swupdate suricatta daemon
Thread-Topic: [isar-cip-core] switch user in swupdate suricatta daemon
Thread-Index: AQHc/+AdPAJGX7YatUWmpUueOJuTsrZFxYKAgAAHJgA=
Date: Fri, 19 Jun 2026 12:21:51 +0000
Message-ID: <fec35a13acac4b94b4806b4c442dd4b8a836a06b.camel@siemens.com>
References: <dc698ef3e64c793fdf42c79d41cf5e8b215ddd91.camel@siemens.com>
	 <c113bc29-5c1f-48af-b781-2909438bd84d@siemens.com>
In-Reply-To: <c113bc29-5c1f-48af-b781-2909438bd84d@siemens.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.56.2-10 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM7PR10MB3956:EE_|PA1PR10MB8895:EE_
x-ms-office365-filtering-correlation-id: d42316b9-3594-42f3-6d15-08decdfd5799
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|376014|23010399003|1800799024|38070700021|55112099003|4143699003|22082099003|18002099003|11063799006|6133799003|56012099006;
x-microsoft-antispam-message-info: 
 eKqs8XJl/ydeSSic2d1w6GfWFaQ7CrxlLp38OcKtEqRn0n2aI5Bg3n7jt2D4RvgwNTRIyn0V0tF+x+kIBRLQmbr52tR1HHoknNp7Vvu/NqZnELAGNw/4TOpzK+wdFye6Rox9aH/d8zn/cy+NhisddQYpS+So9CwS0lk8WCfcwm13+jvJ52hl1vy7gwZZTJAtkowUJZkZYTMEwIW1cgRLX8RtlEN2+MnF7V27I6fIVVw5zeCvAphVlgEgthOXihDQXe+IevoTKyfYgXSA4em8G7GF8FLHQI/DDQz/VKVsSlxYXymLzLmLQpudhjalJOUt9W4J+bsz1KAEtIKF7PYor1nT4rCH/FSxJOF9JpuwPrtADKJv205zGSmlj2eZ5SesA1CaGQqu+k+qeqo4bDdz9bt9fN9sD9HxJix4I2EtmYtfpBVkY0Umj4pg2mWed9vD4fkylYlCxcgATOz38W7O9deUvcMCB4jY3xQnuszYTd92YXS1xRuKNZBOrKXKyR5Y44OzqWtXJZlMfBpAnPIC2L7c/K9ayCqBSPhXPcyY+hPwFxOOpceBJtVlewFnVxORzNrp0oxQ6YOCwCwdW5vBFzyxURI0SKo99FN4mnAFz0lk3kWfnV/PKRf+43Izh4swu05V9fDN+VGxlkX49H65f7DPnxOFeMVrqTrx5fQSYE8=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(38070700021)(55112099003)(4143699003)(22082099003)(18002099003)(11063799006)(6133799003)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?L1poWWtjL0lNdHNST3NMNFVZZDZCcEtBZzYwbUx5cUxGR2sxWlNYRUpaUjJ5?=
 =?utf-8?B?NkV1UTlXOGM5ME1CL3VmT1Q1TmU0bWFQczI4ZHIxRVd6LzYrMDFNZzdaY0lH?=
 =?utf-8?B?TFhLVWNadUpubmFLcHcvQlJLT2Y2cVRVWEtZcEd1UXIzd3NCUzRJVnIzcVdn?=
 =?utf-8?B?Z3NzNGJWYW9IQ2ZjbkprUm5oWDhGU3NsN296RkVsYXRkSGV5b0ZGNTJnK0pX?=
 =?utf-8?B?Q1ZTVXlkRUdUTzh0NDZsM0tWc3lmTnBhVmpHeUdKVTlZTGNxUkFLMWxTYmNV?=
 =?utf-8?B?MG43S2pJRnM4cExVZS9XR1I4eGU3OFliR0xYVENlaFhYYTZodmlzaCt4MDBL?=
 =?utf-8?B?eC8veURkRFVyMWUyeFN1cThPbUtPa2tmdWZrUzd5cjBiNFE1MEFNelRKSEpv?=
 =?utf-8?B?U3FLeS92Zk0vWW5YZDY2akY2WWh6TmprQzFnOHovYU10bHNhU0FYWDRZdmp5?=
 =?utf-8?B?N0tlZzY4RGZOZGdXWWRMbnZIUXRnazRrVGkxVVo0M2s3Sk5vcmtmZjZiWEZT?=
 =?utf-8?B?Z0IvU0F0Y1d0bklNaCtCL2F1dm1Bb1NSZWQ2cUwzR0ZIU2RUTUV4M2tnRXpt?=
 =?utf-8?B?Y045c0JEaE5XM0tobXc4MmhYc09Nc3dMQkRpOG10dUdiWFdiRjlBcGY0cVF0?=
 =?utf-8?B?Z05EUW1sQW9UYVNXZmVyQVBxMlR3TkJDVmxTWE5nK1lIekhIdVdkbnFjNC8r?=
 =?utf-8?B?Y2lxcGh0NW52ZkFUYStLcElKTjdHN08yektOZ201c1NGOExxQWF2Q3pFcWYy?=
 =?utf-8?B?WVhYYlIwN3BYWHVDcE42WExyajNKQUNlbkVNUUozN2l5T0dNczZidVJuQXY4?=
 =?utf-8?B?OGVlZXg5aGRIWlQvTUtIUEROOGNHc0FaSm9SWU9NclJmVGkvMGI2clhVNkNm?=
 =?utf-8?B?cDRORUZYYys2ODY5c2J0RlBNRVU3L0NPbklsWUlFQnU1NUREZlVmelo1WFpu?=
 =?utf-8?B?eW9uaTkyakRqTzUxSC8yWnAvckQ2TzNxWGppRkF0SVo3MU5jUjNvYTdTYW91?=
 =?utf-8?B?ZVRMQ2ZKcCt3QjErekJjTWlmUWh1OXZreHdHcHVZeTg5WWJ2S2NkYnp5cGdo?=
 =?utf-8?B?aUgrT3lhV0ZLZG5YTjdXYUd3WnUvZDJNdHJHVEEyTkJiZ2NDdFA4UkRPdTB1?=
 =?utf-8?B?MlhjU21qNERocHJTM1ZWWWUwaUhuUkYvK2VyOGowUU85SGViTmh5WFRUeHI5?=
 =?utf-8?B?S0Z1bGdUaVVpbEh3VW93MXdCbFluT210SVEzcFVzbTl5WWp1NzJlSjV2YURY?=
 =?utf-8?B?T3ZsL2VyQVVSWHIzaHpDNExldVV2TmtWTVlKazdVK21RRFlIWmhRKzNhRjQx?=
 =?utf-8?B?SzZZR1BVcjJwMkEyRGpsb1pmVkRNOWVsT1Qwend1WjFKWUQvY2UzaGxzWG1n?=
 =?utf-8?B?S09FNExQemx6b2dFVjZoTkM2UDJaMFhNanBZTlVHUkJra1NEMzZPZ0pUSDQ2?=
 =?utf-8?B?RUh1cTBLUlRhUDlueE9YUXgrT0YvSmwrSVZheWRBOE8wMTRzMmcwOWJ6ZkR0?=
 =?utf-8?B?MUI0VVozQTBEVTVTNVVkamRycW5rS3Y3c3pNNEVCOXNmc2dsU0hKSXRXQXp0?=
 =?utf-8?B?dVpLU0ZKbGpuZWtQWEM0SVpVbXQwTFlzRHd1aGNqT3k3c0hHMUx6WWhVK3RB?=
 =?utf-8?B?ZUd0NHRoQU1yczIzUXpyTUpHQ3BJWUtaeTJnSzRiSzQ3ZWdtcVFERWcxeDJG?=
 =?utf-8?B?UEdZQnZUeEhVZHdaVG5RdDdsNC9NTThySXZNeDduTk9ONlJOcVhtc2J5TUVi?=
 =?utf-8?B?OVJheUVWMk5IY1Mrc3ZWY0UvWERhQzR2amdia3dxSjFKdjhEUysrTEdvbmZi?=
 =?utf-8?B?QkVlZjFJR0Z4eCsreXZtcmV2RzV0NE1ObGhySlFKRC9xQ0ZEdWUzRHRSaTNZ?=
 =?utf-8?B?VDJvejFYbHpVQXB0czZhQnZVWEtGNUF2NUpMUUVvVUFEa2JBQ2N2S2d5Qlp3?=
 =?utf-8?B?SVoyKzlVWDZQcTVwWE02VUdhdFdOc2JUNlh5WXI0VDZzS2UxeXpoMk40ejBS?=
 =?utf-8?B?NzdoU0g0ZXhPaHN4WE04ajNOZE01dnk5Ty8ydGlSWTQwUzBsWEU2UVlUT3pa?=
 =?utf-8?B?UjlhY1U4cVpKcW15RUFJcWxRcm1HYXVKOFpoR2hhMGFva29seHlJNi91L0dN?=
 =?utf-8?B?eGQyZkJhQVROUEg5aEtnaTl6ZkdIQWxSNWpVVHlZcGZTcXkraURPT3pLYnNU?=
 =?utf-8?B?RkgzT05hQ0kyRVVOeHQzU2xXTlJ2YkJtYW8xVFBjTS8weVFQeTBtM2NyV2Y4?=
 =?utf-8?B?ZkkvSUpiT01EYlkzTlVzNERQck96TDMxcEN4dHdDRkRFZzFyT2lTby9mQkpU?=
 =?utf-8?B?aEsxRk1Ta3FvNjlwdC9nMzNGV1BvY2Zsc3NYaEZWTE16VVBCWmlSQT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B388AFD2223CB94D9A166AA3EC45DF46@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: d42316b9-3594-42f3-6d15-08decdfd5799
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2026 12:21:51.2984
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WW96uqMxRxZrXr3fP5ah1H7pQa2VxS7L2kXhd8os05nB162/sKrmVc5mlwR32MXkA/HpC7ZbYCwcsJUTp6A4cvsC2jEAQX8nfSGRS6FCJnU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR10MB8895
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 19 Jun 2026 12:22:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23234

T24gRnJpLCAyMDI2LTA2LTE5IGF0IDEzOjU2ICswMjAwLCBKYW4gS2lzemthIHdyb3RlOgo+IE9u
IDE5LjA2LjI2IDEzOjM4LCBNb2Vzc2JhdWVyLCBGZWxpeCAoRlQgUlBEIENFRCBPRVMtREUpIHdy
b3RlOgo+ID4gRGVhciBjaXAtdXNlcnMsCj4gPiAKPiA+IGFzIHBhcnQgb2YgZWZmb3J0cyB0byBw
cm92aWRlIGEgaGFyZGVuZWQgYmFzZSBpbWFnZSwgSSBub3RpY2VkIHRoYXQgdGhlCj4gPiBzd3Vw
ZGF0ZSBzdXJpY2F0dGEgbW9kdWxlIGlzIHJ1bm5pbmcgYXMgcm9vdC4gSGVuY2UsIGNvbW11bmlj
YXRpb24gd2l0aAo+ID4gZXh0ZXJuYWwgcGFydGllcyAobGlrZSB0aGUgYXJ0aWZhY3QgZG93bmxv
YWQpIGFuZCBzdG9yaW5nIG9mIHRoZSAuc3d1Cj4gPiBmaWxlIGFyZSBwZXJmb3JtZWQgYXMgcm9v
dCBhcyB3ZWxsLiBUaGlzIHNpZ25pZmljYW50bHkgaW5jcmVhc2VzIHRoZQo+ID4gYXR0YWNrIHN1
cmZhY2UsIGFuZCBtYWtlcyB1cyB2dWxuZXJhYmxlIHRvIHBhdGggdHJhdmVyc2FsIGJ1Z3MsIGxp
a2UKPiA+IGZpeGVkIGluIFsxXS4KPiA+IAo+ID4gc3d1cGRhdGUgYWxyZWFkeSBzdXBwb3J0cyB0
byBzd2l0Y2ggdGhlIHVzZXIgb2YgdGhlIHN1cmljYXR0YSBkYW1lb24sCj4gPiBob3dldmVyIHRo
aXMgbXVzdCBiZSBkb25lIHZpYSB0aGUgc2luZ2xlIGdsb2JhbCBjb25maWcgZmlsZSAodGhlcmUg
YXJlCj4gPiBubyBDTEkgb3B0aW9ucyk6Cj4gPiAKPiA+IAo+ID4gc3VyaWNhdHRhIDoKPiA+IHsK
PiA+IMKgwqDCoMKgIHVzZXJpZCA9IDY1NTM0O8KgwqAgLyogIm5vYm9keSLCoMKgICovCj4gPiDC
oMKgwqDCoCBncm91cGlkID0gPD8/PjvCoMKgwqAgLyogInN3dXBkYXRlIiAqLwo+ID4gfTsKPiA+
IAo+ID4gV2hpbGUgdGhpcyB3b3JrcywgaXQgaXMgdHJpY2t5IHRvIGltcG9zc2libGUgdG8gaW50
ZWdyYXRlIGluIENJUCwgYXMgd2UKPiA+IGhhdmUgdG8ga25vdyB0aGUgZ2lkIG9mIHRoZSBzd3Vw
ZGF0ZSBncm91cCB1cGZyb250IC0gd2hpY2ggd2UgbmVpdGhlcgo+ID4ga25vdyBmb3IgZXhpc3Rp
bmcgZGVwbG95bWVudHMsIG5vciBkbyB3ZSBzZXQgaXQgaW4gbmV3IG9uZXMuIElmIHRoZQo+ID4g
Z3JvdXAgaXMgY3JlYXRlZCBieSBzeXN0ZW1kIGF0IHNlcnZpY2UgaW52b2NhdGlvbiB0aW1lLCB3
ZSBoYXZlIG5vCj4gPiBjaGFuY2UgdG8ga25vdyBpdCBhdCBhbGwuCj4gPiAKPiA+IFdlIGNvdWxk
IHVzZSBhIGdlbmVyYXRvciB0byBjcmVhdGUgYSBkZXJpdmVkIGNvbmZpZyBmaWxlIHRoYXQgaXMg
cGFzc2VkCj4gPiB0byBzd3VwZGF0ZSwgYnV0IGV2ZW4gdGhhdCB3b3VsZCBub3QgaGVscCBpbiB0
aGUgc3lzdGVtZC1jcmVhdGVzLWdyb3VwCj4gPiBjYXNlLgo+IAo+IFJlZmVyZW5jaW5nIG9ubHkg
YnkgSUQgc2VlbXMgbGlrZSBhbiBTV1VwZGF0ZSB1cHN0cmVhbSBsaW1pdGF0aW9uIHdvcnRoCj4g
cmVzb2x2aW5nIHRoZXJlLgoKV29ya2luZyBvbiBhIHBhdGNoLgoKPiAKPiBCdXQgd2UgY291bGQg
YWxzbyBmaWxsIHRoYXQgSUQgZHVyaW5nIHBvc3RpbnN0LCBlbmZvcmNpbmcgZ3JvdXAgY3JlYXRp
b24KPiBhdCB0aGF0IHBvaW50LgoKVGhpcyB3b3VsZCBvbmx5IHdvcmsgaWYgdGhlIGFzc2lnbm1l
bnQgaXMgc3RhYmxlLiBPdGhlcndpc2Ugd2Ugcmlzawp0aGF0IGEgbG9jYWxseSBjaGFuZ2VkIC9l
dGMvc3d1cGRhdGUuY2ZnIGZyZWV6ZXMgdGhlIGlkIChhcyBjb3BpZWQgaW50bwp0aGUgb3Zlcmxh
eSkgd2hpbGUgdGhlIC9ldGMvZ3JvdXAgZmlsZSBpcyB1cGRhdGVkIHdpdGggYSBuZXcgb25lLiBU
aGF0CmlzIGEgd29yc3QgY2FzZSwgYXMgaXQgYnJlYWtzIGFsbCBmdXR1cmUgdXBkYXRlcy4KClRo
YXQncyB1bmZvcnR1bmF0ZWx5IGEgZ2VuZXJpYyBwYXR0ZXJuIHdlIGluaGVyaXQgZnJvbSBkZWJp
YW4sIGFzIHRoZQpuYW1lIC0+IGlkIGFzc2lnbm1lbnRzIGFyZSBkb25lIGR1cmluZyBwYWNrYWdl
IHBvc3RpbnN0IHdpdGhvdXQgc3RhYmxlCmlkcy4KCkZlbGl4Cgo+IAo+ID4gCj4gPiBIb3cgYXJl
IG90aGVycyBkb2luZyB0aGlzPyBEbyBJIG1pc3Mgc29tZXRoaW5nIGhlcmU/IElmIG5vdCwgSSdt
Cj4gPiBwbGFubmluZyB0byBzZW5kIGEgcGF0Y2ggdG8gc3d1cGRhdGUgdG8gYWxsb3cgcGFzc2lu
ZyB0aGUgaWRzIGVpdGhlcgo+ID4gdmlhIENMSSAod2hlcmUgd2UgY2FuIHVzZSAkKGlkIC1nIHN3
dXBkYXRlKSBkdXJpbmcgaW52b2NhdGlvbiksIG9yIGFkZAo+ID4gYW4gb3B0aW9uIHRvIHRvIGFs
bG93IHNldHRpbmcgdGhlIHVzZXIgLyBncm91cCBieSBuYW1lLgo+ID4gCj4gPiBbMV0gaHR0cHM6
Ly9ncm91cHMuZ29vZ2xlLmNvbS9nL3N3dXBkYXRlL2Mvbk1FQlJLanNvVkUvbS9OZW00b1lZZkJ3
QUoKPiA+IAo+ID4gQmVzdCByZWdhcmRzLAo+ID4gRmVsaXggTW9lc3NiYXVlcgo+ID4gCj4gCj4g
SmFuCj4gCj4gLS0KPiBTaWVtZW5zIEFHLCBGb3VuZGF0aW9uYWwgVGVjaG5vbG9naWVzCj4gTGlu
dXggRXhwZXJ0IENlbnRlcgo=

