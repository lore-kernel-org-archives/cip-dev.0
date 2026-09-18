Return-Path: <felix.moessbauer@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3524C982D9
	for <webhook@archiver.kernel.org>; Fri, 18 Sep 2026 10:54:17 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com (AS8PR04CU009.outbound.protection.outlook.com [52.101.70.20])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.8194.1789728847607162044
 for <cip-dev@lists.cip-project.org>;
 Fri, 18 Sep 2026 03:54:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=jNr6p2JR;
 spf=pass (domain: siemens.com, ip: 52.101.70.20, mailfrom: felix.moessbauer@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pxpwj3IQzUjliUFOvFUI4vSLveK++sHH2fpPN22rN7g6LxrHVUisE0cMsE8W63CK0vdCv1+LKl0U9SRE7aQ1yNgY+HiJuaP6y/09oQb59DMVELfjfUjvsGCoJYsLyRwvlO1Eu8jlWi35nwh8x6gasLGkml6MgoHyTktkTGVPyJoG9XcfIspqABMyZPLrC0kIfGQVP2MTh69X5ZnQpQ4ALSC8flpoX7mn0C+iiHrvRI8tpx6808I/S0Br12q4QdbYvsbvH7U5uwdwKwgRlCGNLDhhJ3O5l/ncjEb03WwpGxkp4TuVWdyBELjbY6fanE77X4nsxhpe9Pq73QHIsRRwYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eOgKkRssCfB0ef1yvzvG6eD/1npvJPtzZ/AgkWrqm9A=;
 b=vIQ9HVLZ6eVb3QGOUPU8JNyP4X9sBGA5u8VZBhRNLzD4C6ZIxCGdwbbhezz3MY+NzP9/vhSzNNVzYkeN6WP3KTFZGKJaXRvlwOIK9nnP/0CrHLsFU+vBzUpfi6K5TZTWD5VJem5/R1DRXTs6sC+lpRcVSdIc7VL5HmLaOWlRUtUBSDX9faB5fZaU1oV7QlpoVZN4//gqoNfpDenjTCed3Y0IVRNBwnSiIKcjv1iHj/HXzGw0WZjbBf8K5INBgQUEN4zxJY80lNfPgKmByD9QrkCGY/7MnbESXwUQiMtbsOz8icC+dFeJyKyHF7nUgk1exNUOlnAaKIsmg0YY7WCMPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eOgKkRssCfB0ef1yvzvG6eD/1npvJPtzZ/AgkWrqm9A=;
 b=jNr6p2JRCv78vgPXNsvPd23CMjFlOp64Qlbvvc/wltujqD6uHHUw0gjvBE7fRldP7V5c5DScxz134ujLNJLOgVlSRco4+tkHCP4wGskSSZPVIPzFPuPTPFldVt35jzYGA/4D9t2uuVWmqEAPsQTb/9n2w+qsxvDoaAYSYsrDtjVei20ES96isy3PzL4NpwIh1iE5Lt1PXmJlUGTVqPkznxsz6LCI7waWMOKIg9vFDQtD2lMO7iyUsbawZNL+WOWY1raOLPnsr6Taef1CWS3cvuzqJdnO5Yc19jxugdK/yHS3LFb7XXwoEcDw0sGH5JElkRtCGf4fOCMVIbXqKKYhDQ==
Received: from AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:17e::10)
 by DU4PR10MB8544.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:567::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.12; Fri, 18 Sep
 2026 10:54:03 +0000
Received: from AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c54c:ccd8:ebbf:477c]) by AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c54c:ccd8:ebbf:477c%3]) with mapi id 15.21.0406.014; Fri, 18 Sep 2026
 10:54:03 +0000
From: "MOESSBAUER, Felix" <felix.moessbauer@siemens.com>
To: Kunijadar Shivanand <Shivanand.Kunijadar@toshiba-tsip.com>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, "Kiszka,
 Jan" <jan.kiszka@siemens.com>
CC: "kazuhiro.hayashi.f74@mail.toshiba" <kazuhiro.hayashi.f74@mail.toshiba>,
	"kumar.dinesh.h95@mail.toshiba" <kumar.dinesh.h95@mail.toshiba>
Subject: Re: [cip-dev] [isar-cip-core][PATCH] Fix file timestamps are not
 reproducible for EFI certificates
Thread-Topic: [cip-dev] [isar-cip-core][PATCH] Fix file timestamps are not
 reproducible for EFI certificates
Thread-Index: AQHdR0zKDblqapHsykqKMBs5AKB3brbUKW+A
Date: Fri, 18 Sep 2026 10:54:03 +0000
Message-ID: <88b6f524427c6415422dc6dba589b4cafb4cd439.camel@siemens.com>
References: <20260918085031.2464429-1-Shivanand.Kunijadar@toshiba-tsip.com>
In-Reply-To: <20260918085031.2464429-1-Shivanand.Kunijadar@toshiba-tsip.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.56.2-10 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM7PR10MB3956:EE_|DU4PR10MB8544:EE_
x-ms-office365-filtering-correlation-id: 0c59a925-b764-45a3-bfc6-08df1573272e
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|38070700021|56012099006|11063799006|10067099003|55112099003|6133799003|22082099003|18002099003|3023799007;
x-microsoft-antispam-message-info: 
 WCKz2rCu0MLdzjOYbG+EO8OevDOLLoCYdxa0kYAcVA4PZhWjnbdkYGJE58ShTthMB2JlXwXgvDygC9/AK8gU7w2cRlSTqpS44p1zrfkGDJn8V1JqqjBrCsF6lWCoCLXIlUb0JZu3py0N/xQAk/xSh7mpVNvnjBcN+JoJRkq5uaHuskJ1kUDuS+i8eTlR2B4AAdudblsOv7KqzNQFKTI0Qvh3ZvGLZ8/yVm37foqa4N00Cf4xvaEzTdJiZYaXUTnAKAirCxypFnwsND1dauJMNQcJYc3wvJgtGWda+GzytABdAKtJQPXSAO0BTS78FKmRXpShdYRQ5/s/3wjOeIh90jH2DJ5ezIYN1TM7xSb1pNcvuo3vRPZQ2XyNFEBHIYYgQjsL5RiSGyoDcqPU80l33E82xzF6XSYPsSOrzHwkqwl9SKPxzvHw3Who/xeOAerYr8YcQoZtpPVfqww7N4vB/Iw8FR3VfOkWfGgCgVGut6kGknh+jWdDxYBiD4lUn84ll4INEaD1c32gVab3/sNlsIiiLFEjBZLw/oyx+mVik1Teu8PqZ/Je+0rw5+JYoeSuYMUn3Zov3RhV2usiWghNN9ZIFDxNmR6rJ2R/9TYTnkf4biSaBFUkEDqowu9ZjoRqb75/Q28QF884YFBG+Sts48P53lvB7XHeaghGvETle4Z9CNR9cfxop9L64d0YC6cL3RQzATvhekxqAfT8D1RE19rjDpyqVfaipeg7yG1IUW4=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(38070700021)(56012099006)(11063799006)(10067099003)(55112099003)(6133799003)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?emIrVUNocS9jL2MzdWFBZTVidHgwamJib29Jb1FuWlg1WEJJZVFJOHhJK2x5?=
 =?utf-8?B?WFNHb25KK3lCR013bVRXek00bzlld25WQ0hlSUVZM3RBcnhFT1p2L1dadXpn?=
 =?utf-8?B?QldPQTVoSnZiaDkzZFpiQVJTSjdmb0thK3gxc0E0NWFqa1h3TzNRdHM0akto?=
 =?utf-8?B?UWZqdXFSOW5rOHVjK1E1THFJUnQxMEIyUFF6UUlkOStaRWp2R05PNDhXVFhs?=
 =?utf-8?B?N0Z0Q1FiQnpKMXpDcEI2OXcvczNFS0Q1M2RFYWdreDRKZkFjYnVpalIzRmRh?=
 =?utf-8?B?eHh4ZFVvek5QV0Y5VlRLRyt3Q1dOT2RKb2NaNW5pQzA3TXNPcDUwc1Ztc2Z5?=
 =?utf-8?B?UmJ0aXRXNkFZeHc3UXViRlNxU3VlM2M3dVZxMFhrQWloN2c2ZkFjZkZSZEJr?=
 =?utf-8?B?M2pnNTJPenJHeWpPTTUvSzZ6eVlmQnJMK0UrVUhpamFxME5LbERvR1BJTVBz?=
 =?utf-8?B?dTRBODRNZXVhVWFQTzkyYVQ5MDFnaUdpYi80Zi9RU1NYZVB4U1hud2NWLzhi?=
 =?utf-8?B?NVp6ZSt5eGhNQUZvQXRiUkVoTXBnYlVOczlackFxc3pBRFVmdW1nZjMzWDZZ?=
 =?utf-8?B?SEdwUHBoWk1LTUdNdDFCc1BqbTVsWERJSmZqQTZTZkpBRHQ5MDgvSXg5NnpO?=
 =?utf-8?B?ZHFZZm5IU2hWczBXUWM1VUpGSEpINUFhMnpJVnJsWWFIOVVFdER6Y1o4WUZS?=
 =?utf-8?B?YnkzanYrWXVjcWlrTGJvRExiR2hSTDFPY21qclFVZU93UjhtTkFzdU0rUWxS?=
 =?utf-8?B?KzJydy9BenlGc0l5L3dpbmg3cjVwVC81d2tndjQxR0toaFBraEZmanFtRXlu?=
 =?utf-8?B?RUxoaG84WGFSdWtBNTROSk5RdXBVaERrTTUweWM5b1h3K2xMaTRWS0JjREV3?=
 =?utf-8?B?YUdmZ0tDR1NxRGlLcE9wK2piZWZ6VFdUVUxZaktvVjZOeTVxelg2bFJHQ01I?=
 =?utf-8?B?Vi9TckFQU3RUZGFQbUV1dlk2aDN4Z2JRVXU0NUN0T09rcUZablgwNm5uUWVx?=
 =?utf-8?B?WVhXd1lseWt4dFpHek5uY0tvbk1HdFJ2dDkwNDRreVRPUXlsaFF0NDFkZ0k1?=
 =?utf-8?B?VlhhWi9nU1NIemhjS3NFRlhSRVFJWTBMSUdLd216WUNuSExQOFhBMjFGSlY4?=
 =?utf-8?B?ZmduSHRnc25Nd0xERzZZS0QzVVFoVkorY3hZQjRsQitpM1JIVEFiRm9kV0RT?=
 =?utf-8?B?cDlQdGhyRVlEOWU1NWxCZzRrSCtBT3VZYW42WmVwVjhzL05tNmxacjdoaU93?=
 =?utf-8?B?UHZQR0F5eHg5T05vK25kWFRCTGZ1eDBCSEJDR3h6RCsxVjhOWnlWR2MreGI1?=
 =?utf-8?B?dDcvOTUxNWI4bGtkYlQ3NkJQTmFkWFBZbitidVg2ajc2S2VHdEM2aHQ3TTVn?=
 =?utf-8?B?bEFXRzBWdUZEaUsxckVGOFVRQnl3YTZISnZsVjZQRHpVbDBrRmFFNU13VzAx?=
 =?utf-8?B?eXZOOUtyaFFJMGdQOXN0cWlrbmlESktrTjVjYjJBWnpwS21OS0xPUlBzZG1C?=
 =?utf-8?B?VmVWKzFnT1Erd0VKYXNDVUxiS1kvbXAwcy9TWkk3aEgwbk9MaTROaFNwUWxI?=
 =?utf-8?B?Q2hRTUdDM0tKUFVsL3hnaGJ2QkRDaGtwbHV2K1RVc0hDR0dnSWRhQjg1ODNQ?=
 =?utf-8?B?bFZjUGJ6elBEVzB1bFE1Y1k5MlExVWg2cm1ZZyt4anEwbXh6SCsxdXdzNkJ5?=
 =?utf-8?B?dFlxditTa3JYSllwSks5ZGRkTGJ2Q1RUUThXeFNYa2draWFGWG1GMlgvNWJm?=
 =?utf-8?B?clRraU4yazFmTURwcit3MVZTTWkyOFYvYmw5QnZCUjBEU2pON0hNcmR4WSts?=
 =?utf-8?B?WVRjVW9RZnZ3UGFKR3o0TzRBd1NRdmhGNjhCdmxJYyswRlpYUmtoZEdKRHhl?=
 =?utf-8?B?VnJsZEpUTUQrbmsxVlFocXpoZzE5UjNRZ3YrcFhqOXJCOXlFRXpLbVJHSjFp?=
 =?utf-8?B?anBWYkJSSlJKaHQrOWFXWXhkdllaNDNNNi9SZWRWaXIxbnY0S0VNUncvZVht?=
 =?utf-8?B?ZWxlQmRQSnVxaWFNNi9qR3R3S2xqK3JScE1DTTlYUVRFMjNaSmxJVWlOQWtX?=
 =?utf-8?B?OGdOcExDV1hMTUtCMjNTV1NYdC9hcFVyWmc5YWRUcGYxWG1ybjU1Z3J5Z01C?=
 =?utf-8?B?K2JUTC96a3E3OG1NS2ozSmdtRFpMZm9iK3FxMmJSVllJQzZHMGJaUXlVcHZN?=
 =?utf-8?B?MFJBS1FQcHhlNWUzVFEwdUxsVENEZVM5bWpCTHhTYUJLeWlvczA3VGRrdnpY?=
 =?utf-8?B?QnZ5dHFYcmZudEY2a3RrN3VaWitIaXFadm81ZERHZGN5NGI1dU1wbEJLckQw?=
 =?utf-8?B?cG1nWEppTFlNSXRuVThIcml2MFQzMElVbi91N3dMRktud0ozalMwQT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <52C7ED0933EAAD40A5D318DADC15A963@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c59a925-b764-45a3-bfc6-08df1573272e
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2026 10:54:03.2352
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5166iVd/HOgP1zxPXqFg7DDbIwdldgyhuKC1T+oUzJskwKo6O898zK3WwF1x5Gw1DLPGLpH61jS25Jxr8lyBEnixHor6VeXw6BNnNlnfn20=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR10MB8544
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 18 Sep 2026 10:54:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24241

T24gRnJpLCAyMDI2LTA5LTE4IGF0IDE0OjIwICswNTMwLCBLdW5pamFkYXIgU2hpdmFuYW5kIHdy
b3RlOgo+IEZyb206IFNoaXZhbmFuZCBLdW5pamFkYXIgPFNoaXZhbmFuZC5LdW5pamFkYXJAdG9z
aGliYS10c2lwLmNvbT4KPiAKPiBDbG9zZXMgaHR0cHM6Ly9naXRsYWIuY29tL2NpcC1wcm9qZWN0
L2NpcC1jb3JlL2lzYXItY2lwLWNvcmUvLS93b3JrX2l0ZW1zLzE2Mgo+IAo+IFNpZ25lZC1vZmYt
Ynk6IFNoaXZhbmFuZCBLdW5pamFkYXIgPFNoaXZhbmFuZC5LdW5pamFkYXJAdG9zaGliYS10c2lw
LmNvbT4KPiAtLS0KPiAgLi4uL3NlY3VyZS1ib290LWVmaS1jZXJ0cy9zaW5nbGUta2V5LXRvLWVm
aS1jZXJ0c18wLjEuYmIgIHwgOCArKysrKysrLQo+ICAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRp
b25zKCspLCAxIGRlbGV0aW9uKC0pCj4gCj4gZGlmZiAtLWdpdCBhL3JlY2lwZXMtZGV2dG9vbHMv
c2VjdXJlLWJvb3QtZWZpLWNlcnRzL3NpbmdsZS1rZXktdG8tZWZpLWNlcnRzXzAuMS5iYiBiL3Jl
Y2lwZXMtZGV2dG9vbHMvc2VjdXJlLWJvb3QtZWZpLWNlcnRzL3NpbmdsZS1rZXktdG8tZWZpLWNl
cnRzXzAuMS5iYgo+IGluZGV4IDI2M2Y3OTQuLjZhNTM1N2QgMTAwNjQ0Cj4gLS0tIGEvcmVjaXBl
cy1kZXZ0b29scy9zZWN1cmUtYm9vdC1lZmktY2VydHMvc2luZ2xlLWtleS10by1lZmktY2VydHNf
MC4xLmJiCj4gKysrIGIvcmVjaXBlcy1kZXZ0b29scy9zZWN1cmUtYm9vdC1lZmktY2VydHMvc2lu
Z2xlLWtleS10by1lZmktY2VydHNfMC4xLmJiCj4gQEAgLTI0LDYgKzI0LDEyIEBAIERQS0dfQVJD
SCA9ICJhbGwiCj4gIAo+ICBkb19wcmVwYXJlX2J1aWxkKCkgewo+ICAgICAgZGViX2RlYmlhbml6
ZQo+ICsgICAgaWYgWyAtbiAiJHtTT1VSQ0VfREFURV9FUE9DSH0iIF07IHRoZW4KCkdvb2QgY2F0
Y2ghIFRoYW5rcyBmb3IgZGVidWdnaW5nIHRoaXMuIFBsZWFzZSBqdXN0IHVzZQpERUJJQU5fQ0hB
TkdFTE9HX1RJTUVTVEFNUCBpbnN0ZWFkIG9mIHRoZSBTREUuIFRoaXMgdmFyaWFibGUgaXMgYWx3
YXlzCmF2YWlsYWJsZSBhbmQgYWxpZ25zIHRoZSB0aW1lc3RhbXAgb2YgU0IgcGFydHMgd2l0aCB0
aGUgb25lIGZyb20gdGhlCmNoYW5nZWxvZy4KCkZlbGl4Cgo+ICsgICAgICAgIHRpbWVzdGFtcD0i
JChUWj1VVEMgZGF0ZSAtZCBAJHtTT1VSQ0VfREFURV9FUE9DSH0gJyslWS0lbS0lZCAlSDolTTol
UycpIgo+ICsgICAgICAgIHRpbWVzdGFtcF9vcHQ9Ii10IFwiJHRpbWVzdGFtcFwiIgo+ICsgICAg
ZWxzZQo+ICsgICAgICAgIHRpbWVzdGFtcF9vcHQ9IiIKPiArICAgIGZpCj4gIAo+ICAgICAgY2F0
IDw8RU9GID4gJHtTfS9kZWJpYW4vJHtCUE59Lmluc3RhbGwKPiAgZGIuYXV0aCB1c3Ivc2hhcmUv
c2VjdXJlLWJvb3QtZWZpLWNlcnRzCj4gQEAgLTM1LDcgKzQxLDcgQEAgRU9GCj4gIAo+ICBvdmVy
cmlkZV9kaF9hdXRvX2J1aWxkOgo+ICAJY2VydC10by1lZmktc2lnLWxpc3QgL3Vzci9zaGFyZS9z
ZWN1cmUtYm9vdC1zZWNyZXRzL3NlY3VyZS1ib290LnBlbSBQSy5lc2wKPiAtCXNpZ24tZWZpLXNp
Zy1saXN0IC1rIC91c3Ivc2hhcmUvc2VjdXJlLWJvb3Qtc2VjcmV0cy9zZWN1cmUtYm9vdC5rZXkg
XAo+ICsJc2lnbi1lZmktc2lnLWxpc3QgJHt0aW1lc3RhbXBfb3B0fSAtayAvdXNyL3NoYXJlL3Nl
Y3VyZS1ib290LXNlY3JldHMvc2VjdXJlLWJvb3Qua2V5IFwKPiAgCSAgICAtYyAvdXNyL3NoYXJl
L3NlY3VyZS1ib290LXNlY3JldHMvc2VjdXJlLWJvb3QucGVtIFBLIFBLLmVzbCBQSy5hdXRoCj4g
IAljcCBQSy5hdXRoIEtFSy5hdXRoCj4gIAljcCBQSy5hdXRoIGRiLmF1dGgKPiAtLSAKPiAyLjM5
LjUK

