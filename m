Return-Path: <felix.moessbauer@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2F96C982EE
	for <webhook@archiver.kernel.org>; Mon, 21 Sep 2026 07:53:52 +0000 (UTC)
Received: from DUZPR83CU001.outbound.protection.outlook.com (DUZPR83CU001.outbound.protection.outlook.com [52.101.66.64])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.44154.1789977226242071200
 for <cip-dev@lists.cip-project.org>;
 Mon, 21 Sep 2026 00:53:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=EdRVCDg4;
 spf=pass (domain: siemens.com, ip: 52.101.66.64, mailfrom: felix.moessbauer@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kiTelZD1s82G/T8Vvf55E+lJLRbtdQPVZbFykHPk90WezGOZVQ2UfXlMQUHps5pB97gs0m+vnCkQyOxLbPqWdaERjJnBYivFpUozPjyX7JM+X+I5461gWIAvVISMlK1y6GqkO8X2671HEsQk9/f5P0q7jmnpOD/pbLt7rsryieiR6HWjQBo0A5KfTYNmLRLxXdfDPiHR5r12NQWecDeHVlkVpbafZ/kP8V+8LSnm6G/ym3tS9UHSDp+NHquwB7nsdWIKkQFejC5L76JsfAD1fERXCbXY0CsJmG0eEoiJ97db0s2fYRjVvaqcvxwfRfI+IUl6pT1j3WwuF4Zsr//7qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F6LfUktyAetQ/dclyMpurl+LDm03mo2LUJg4bnM5P34=;
 b=e+YJXHc6i7RymBLQbOZtJ7Zee8vvgI9g6vqKhin4AEQRHWuatdxp4j/ZP8G+5EyK3qA/hS3+KwcOCb9H7BrEpUAkf+ndIQpcvM4a9SYnXSygAn61ZYlHxmtgkXbuZYplFeb179GNGBuAe11dJ+Df0rARefisxXwI3z0QKpN4e4yH/tVEr8ABiIucHZsjuYLySXJFfEJVplRC2/2KblzxI8x4AcLkn7qmU4hEgRCJOlRuc5LcKKwcfeVLv0v9u/tVxGQDJ4PvbVeHUypNnbGamXmMANSlKcA6Xs0neSBkz5lFnwnSNEtVa8Ao1lhjo4mrlBAauGRh8/svvejkLJQF/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F6LfUktyAetQ/dclyMpurl+LDm03mo2LUJg4bnM5P34=;
 b=EdRVCDg4e1v0HCQ7s5z+XWOYAVhz7doo42vwkPOGydwPnoWAQXBfpMm3eHU494zThcA61NtUNTBWCu8upxeNKCbpbfj3l04GI2OMynDo81qM7fkUcbPVQGRL7e9lFNjCuRBmN+6D6WiuzLnEWqnSl8At9oVk0E473Auc3nw+gHiQ2QRv66PT9Kl0VoXhCqy6WH4+zIEgqr31ZMEdep8XB+k1JvqhzbOooK7HQ90VfBMgcC2u8CQNX2zdSvkNOuea5VbE02xKKRadH/HNwdWrNj8t9TQbkEeXvh9sXPJFJGDR8QRUepeYvt+clFaz9mmyyfEvSNjoeUdj87zvB/Pgsg==
Received: from AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:17e::10)
 by GV2PR10MB6405.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:bb::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 07:53:41 +0000
Received: from AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c54c:ccd8:ebbf:477c]) by AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c54c:ccd8:ebbf:477c%3]) with mapi id 15.21.0428.015; Mon, 21 Sep 2026
 07:53:41 +0000
From: "MOESSBAUER, Felix" <felix.moessbauer@siemens.com>
To: "Kiszka, Jan" <jan.kiszka@siemens.com>, Kunijadar Shivanand
	<Shivanand.Kunijadar@toshiba-tsip.com>, "cip-dev@lists.cip-project.org"
	<cip-dev@lists.cip-project.org>
CC: "kazuhiro.hayashi.f74@mail.toshiba" <kazuhiro.hayashi.f74@mail.toshiba>,
	"kumar.dinesh.h95@mail.toshiba" <kumar.dinesh.h95@mail.toshiba>
Subject: Re: [cip-dev] [isar-cip-core][PATCH] Fix file timestamps are not
 reproducible for EFI certificates
Thread-Topic: [cip-dev] [isar-cip-core][PATCH] Fix file timestamps are not
 reproducible for EFI certificates
Thread-Index: 
 AQHdR0zKDblqapHsykqKMBs5AKB3brbUKW+AgAAB+YCAAAWuAIAEUQ6AgAAnTgCAAANXgIAAAUMA
Date: Mon, 21 Sep 2026 07:53:41 +0000
Message-ID: <639005687857cd59d75b22b7833f47bc68badefb.camel@siemens.com>
References: <20260918085031.2464429-1-Shivanand.Kunijadar@toshiba-tsip.com>
	 <88b6f524427c6415422dc6dba589b4cafb4cd439.camel@siemens.com>
	 <868cc7cb-d990-42a9-a759-05f7cfc22e36@siemens.com>
	 <004d186545ac4db6066399ccbc21cfe43a27cd66.camel@siemens.com>
	 <37f91186-518b-400f-a3b1-c61e0207630e@siemens.com>
	 <1b02da51fde7d2c2e71f33473ce6c933335df8fd.camel@siemens.com>
	 <9ac58ab7-f555-443a-b866-6ee083eeb1fe@siemens.com>
In-Reply-To: <9ac58ab7-f555-443a-b866-6ee083eeb1fe@siemens.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.56.2-10 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM7PR10MB3956:EE_|GV2PR10MB6405:EE_
x-ms-office365-filtering-correlation-id: e47ebc07-76ff-4f1e-6a65-08df17b57415
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|38070700021|6133799003|10067099003|56012099006|11063799006|4143699003|18002099003|22082099003|55112099003;
x-microsoft-antispam-message-info: 
 R64v1qqyhlYZhZCegtOCnYnE/FDYTyO2gBzZHqZ4SiLELNSmGrhxOypdeDK/e/vs/Pzm1AtkPRG8AfE+HJ3ZHw1yI50vcu0aVbVvsCdzjupuXpnO21pFJLJLj+ns06LNYs1hYdmCYXD6yTX+EhegXtniMY/J/ihkIXWjN+lD9sOBID7DA+7baOybjXBUe2GufoXGSXNlWyHYSiY63qtdWKxzf35dKkVkPHzD6aLYaPbeQnlGFSvR7qCI8dxJxsYqH3plvWKFUpEDNyrkMUJu5WxwEaR4nxq4iALRhsxRBCwOm8gLKIbFmRxQ1mB+4OdXvvRRfEVk/GqFFY8lRZaDsaNvfQSFhE8SzuZ3e3na/80DKsiBE7ABTfsdcsdhJQOxxBYn+mcSo4IwzL8SrcZ8C3Y9zVC/goGqlkjJ8jAjLQ+PbNnUrHg0P6aNmm+MZGMFa/KMwtREbMJkJXUXXtUgKETf+dsf5YccMxemDAEqeS9StyreGTDg4V9fNKKCSIuCAm+Zhnfn1WNNVvzj9+8i10wu5+HAzk4OPL1obGbkyzD5qHvUjFEZyxxSHY5vx00Q64LMD650Vr6ZzpqQ+AVBMfUvr1BGU7JUwoHqdQXP0dGF6Sp/dDGhViKJJNerA2odP8cdPfuDjwjDqjpbylrjUJyfHqz4y7usoL2DUWiLlPM=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(38070700021)(6133799003)(10067099003)(56012099006)(11063799006)(4143699003)(18002099003)(22082099003)(55112099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?eks2MXB4UTQyeVpGeit0Q1JNVzA1R1JFRFk0K250eTlrQmdHendiLzBKQjNt?=
 =?utf-8?B?M2poRmp1M3RrNjk0R2pMNFRPdTErbjFDNDZKRHNRZjI2WGMyVVFWdEU5c2ow?=
 =?utf-8?B?SzV6Qkp0K0hqSjFiKy80MHJQYU55Q3MrNEIrdko4WUFxMDhRUDNOU3N5MGZo?=
 =?utf-8?B?bjFMTnZTUW5uMFlqZGdJY2pMRm52MFAwTzZ3dTh2eUNpTDV4QkFlSnFEOHBR?=
 =?utf-8?B?dUZLUGE0Q3IxZ3VXWUl1bXE3Vll3b0JQTVczZXBkb1JLWmp2UWdqS0FyOHRG?=
 =?utf-8?B?NjJqR3BZTnRqekQ3Y3E5Zk5BQ3lOOVh3ZzVmTklWcW44TjdEdDU4MzRsYkRl?=
 =?utf-8?B?ZHZtVk0vM3UwcFZzb0RXTFUwU0dBMk5HZTNWU1Rpa2h2ZWFjNmwzMEdJQ2ZY?=
 =?utf-8?B?UFo1NmlZaWJKTFR4ZzF3TDNsc1hCQVVXSlZMcGNWOWlZVDl5OUxhUmNKTXI5?=
 =?utf-8?B?OUwySlZlUVB6YXhqanBuMmtoOFJuMFJXOTdSc3FVa2pCL0RRZEhEQ0FDdDlE?=
 =?utf-8?B?dUI4ZDFQdjMxNjRaMmo1YUhlaEJwUzB6cFdPRGRzZU4xN0RadUZzWUxCZGJ5?=
 =?utf-8?B?TWpnbVBiRlA4RGo4ak14clI3dXB4NnVZdWhOVXdoVE91NlYxa1RoaUdwL2dH?=
 =?utf-8?B?c3FRcVBTSkJLWWk3TStOQ3J5Y2EzMWZLMFdDVy9WZDBScWx0MHdFSjRNc3Q4?=
 =?utf-8?B?YUdFdzJXbGtxNS80WGlIODIwZGZSMCs3dkRiZHhqcFd5dzBaekNYUTl5cko3?=
 =?utf-8?B?UDlpYUdxVjEvQXNOU1VUZEFTSXIxWTdVMVBMU2VBSEs1MzhuTnFwYm53Q1V4?=
 =?utf-8?B?Q1BuWlVCLzB3Y3hYUTFlTzhSTXE2SVA0VWlBY01ZSlFjYWJHYlIrcndRQkJl?=
 =?utf-8?B?WGlLMUQ4YmxDcXNUYkVrQWprUVUrTmJPQU50Ykoxc0ROUXFQb1FkbEhxQ1dL?=
 =?utf-8?B?WXc2bWZ6UjJneXhmT2sxa3lVcXNlYVB3VzY0NXdLc0s3OWNJTDg1UUIwR2xx?=
 =?utf-8?B?UitiWWRXcGZsWkU1YjdJbWtQOGFKZXVvZVhXVVMwcERyWUExVndRNW42ak5w?=
 =?utf-8?B?U1QyeDhZSS9VNVlMRnczWllkeDdlNjBQaWxydHJqRnNnTm1iVUJNbG52dnVO?=
 =?utf-8?B?c0VPdXRlWXlJQ2F0aVpsVzBQRmNvTmdlSlloOWlrQ3BuZG1pa2NGUk5sSkFP?=
 =?utf-8?B?NkYvTEw4WVd1ZXJMWi9UUy81RTNaaFlxOXh6Y3lpZi9XWDdFZEtsaDErclpP?=
 =?utf-8?B?bnc2enVCeG1wK2JCSGthU1NTTE1QT0RWU3l6bktHdlRjcVhSUWRYbFd5ZkMv?=
 =?utf-8?B?WWlmTkNwVEJVQ1I0SW82cmJpUzA0Sm0rbExTM1BKZXB4dlZvckM5MDlNRzA2?=
 =?utf-8?B?bGRmcEM5UWdDRGs4ZG1zZDVUZ0Npa0dJQlhpaTFGREtYMldpQW1xa1JkcG9p?=
 =?utf-8?B?eFhWNGlQclRJZ29oVnpVUVk4bkwzeXg4dEM1blBKcUFsbmNXcHN5UDRmVDVM?=
 =?utf-8?B?TjRiU1dnNjdwU3pvMFRFeUcxeG9XV08rTFF6SGtrVEZZRUJZckM5WU9NeE9T?=
 =?utf-8?B?ckhUQ0E3dUF2UWhwanJHd2FIbEZ4YlFFZC9yQURUSHhsMDJSZlpYTVczWnNv?=
 =?utf-8?B?VFI1NU1MQmRVRDl5QlQxdUo3RTFwTzBaSmlHSkJtcEpiRnZiQ0tPZ29BQzgx?=
 =?utf-8?B?VUV3TFFqSzhnU2lVaXNUL01WWjM1WWxYVU9qdFdXRlhQdEpWc2tnZ205T3ZS?=
 =?utf-8?B?V3Eybmg5UDVZVUIyL1hPWmxOSWE1UlBkNTdaTktpRm1uK2RTNk1hazQxcHJL?=
 =?utf-8?B?NmJaOWFwSy8yT214WFR3MjhITTYvYkFpazhrWE4zU2dwNUd4L0NNeXJmbGdz?=
 =?utf-8?B?ZGdnRzErMDdGSlVXVkV5ZlpRUTliTFZRRmJzSU1aVG92bWp4aC91c2djUUx1?=
 =?utf-8?B?bW1BWjFkZGdvR2xRM3BKZUw2ZnN4eUZJQmJqQXB4Y3BkVUdpaXkzazhoUGlS?=
 =?utf-8?B?eG5iWmhlc0ZoeE1rVkJFdVMxamtmY3pBS1VqWVVKTU1GRkJoVStSY2QrcTNH?=
 =?utf-8?B?OVd4SUVHbERvRExjTVBDOXpkZUEydytLU3NBeUpwR0tMUHZFb2ZZSmh2OW5h?=
 =?utf-8?B?NzMwdjFTczd1M2d0c2FoUE9iNG5GK2U3ZnpXclVTbnZOWkhwT0Fjbjh6bVBs?=
 =?utf-8?B?cDlHZk5nT1BNc0ZNcTNVYzlSMk9WR0JSTnVHa2llUkZkWXNWNUp5d2hYc1hy?=
 =?utf-8?B?R3pOM0drZWtoTVc3SUZMNTJYMXJlbExGZTFxcm5kTnQ2am9HNkpFclpRYWZJ?=
 =?utf-8?B?dWNNMkdPeURVTVdleXArWklla2UrOVJybG5qb04rYU5rc3dJWVIwUT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <66BA81F88A73C4439842ED0EF3313D56@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: e47ebc07-76ff-4f1e-6a65-08df17b57415
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2026 07:53:41.3181
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E90Sr4CCzZkQwH8I9oBDo99p2SVqAiFqWDkeka8WCdwtSktvg25RDOquv3rsIKSzLiFF7AfhvoY9lluWHj9TNJbHz20O71uTEE6JdUQynZk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB6405
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 21 Sep 2026 07:53:52 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24252

T24gTW9uLCAyMDI2LTA5LTIxIGF0IDA5OjQ5ICswMjAwLCBKYW4gS2lzemthIHdyb3RlOgo+IE9u
IDIxLjA5LjI2IDA5OjM3LCBNb2Vzc2JhdWVyLCBGZWxpeCAoRlQgUlBEIENFRCBPRVMtREUpIHdy
b3RlOgo+ID4gT24gTW9uLCAyMDI2LTA5LTIxIGF0IDA3OjE2ICswMjAwLCBKYW4gS2lzemthIHdy
b3RlOgo+ID4gPiBPbiAxOC4wOS4yNiAxMzoyMSwgTW9lc3NiYXVlciwgRmVsaXggKEZUIFJQRCBD
RUQgT0VTLURFKSB3cm90ZToKPiA+ID4gPiBPbiBGcmksIDIwMjYtMDktMTggYXQgMTM6MDEgKzAy
MDAsIEphbiBLaXN6a2Egd3JvdGU6Cj4gPiA+ID4gPiBPbiAxOC4wOS4yNiAxMjo1NCwgTW9lc3Ni
YXVlciwgRmVsaXggKEZUIFJQRCBDRUQgT0VTLURFKSB3cm90ZToKPiA+ID4gPiA+ID4gT24gRnJp
LCAyMDI2LTA5LTE4IGF0IDE0OjIwICswNTMwLCBLdW5pamFkYXIgU2hpdmFuYW5kIHdyb3RlOgo+
ID4gPiA+ID4gPiA+IEZyb206IFNoaXZhbmFuZCBLdW5pamFkYXIgPFNoaXZhbmFuZC5LdW5pamFk
YXJAdG9zaGliYS10c2lwLmNvbT4KPiA+ID4gPiA+ID4gPiAKPiA+ID4gPiA+ID4gPiBDbG9zZXMg
aHR0cHM6Ly9naXRsYWIuY29tL2NpcC1wcm9qZWN0L2NpcC1jb3JlL2lzYXItY2lwLWNvcmUvLS93
b3JrX2l0ZW1zLzE2Mgo+ID4gPiA+ID4gPiA+IAo+ID4gPiA+ID4gPiA+IFNpZ25lZC1vZmYtYnk6
IFNoaXZhbmFuZCBLdW5pamFkYXIgPFNoaXZhbmFuZC5LdW5pamFkYXJAdG9zaGliYS10c2lwLmNv
bT4KPiA+ID4gPiA+ID4gPiAtLS0KPiA+ID4gPiA+ID4gPiAgLi4uL3NlY3VyZS1ib290LWVmaS1j
ZXJ0cy9zaW5nbGUta2V5LXRvLWVmaS1jZXJ0c18wLjEuYmIgIHwgOCArKysrKysrLQo+ID4gPiA+
ID4gPiA+ICAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCj4g
PiA+ID4gPiA+ID4gCj4gPiA+ID4gPiA+ID4gZGlmZiAtLWdpdCBhL3JlY2lwZXMtZGV2dG9vbHMv
c2VjdXJlLWJvb3QtZWZpLWNlcnRzL3NpbmdsZS1rZXktdG8tZWZpLWNlcnRzXzAuMS5iYiBiL3Jl
Y2lwZXMtZGV2dG9vbHMvc2VjdXJlLWJvb3QtZWZpLWNlcnRzL3NpbmdsZS1rZXktdG8tZWZpLWNl
cnRzXzAuMS5iYgo+ID4gPiA+ID4gPiA+IGluZGV4IDI2M2Y3OTQuLjZhNTM1N2QgMTAwNjQ0Cj4g
PiA+ID4gPiA+ID4gLS0tIGEvcmVjaXBlcy1kZXZ0b29scy9zZWN1cmUtYm9vdC1lZmktY2VydHMv
c2luZ2xlLWtleS10by1lZmktY2VydHNfMC4xLmJiCj4gPiA+ID4gPiA+ID4gKysrIGIvcmVjaXBl
cy1kZXZ0b29scy9zZWN1cmUtYm9vdC1lZmktY2VydHMvc2luZ2xlLWtleS10by1lZmktY2VydHNf
MC4xLmJiCj4gPiA+ID4gPiA+ID4gQEAgLTI0LDYgKzI0LDEyIEBAIERQS0dfQVJDSCA9ICJhbGwi
Cj4gPiA+ID4gPiA+ID4gIAo+ID4gPiA+ID4gPiA+ICBkb19wcmVwYXJlX2J1aWxkKCkgewo+ID4g
PiA+ID4gPiA+ICAgICAgZGViX2RlYmlhbml6ZQo+ID4gPiA+ID4gPiA+ICsgICAgaWYgWyAtbiAi
JHtTT1VSQ0VfREFURV9FUE9DSH0iIF07IHRoZW4KPiA+ID4gPiA+ID4gCj4gPiA+ID4gPiA+IEdv
b2QgY2F0Y2ghIFRoYW5rcyBmb3IgZGVidWdnaW5nIHRoaXMuIFBsZWFzZSBqdXN0IHVzZQo+ID4g
PiA+ID4gPiBERUJJQU5fQ0hBTkdFTE9HX1RJTUVTVEFNUCBpbnN0ZWFkIG9mIHRoZSBTREUuIFRo
aXMgdmFyaWFibGUgaXMgYWx3YXlzCj4gPiA+ID4gPiA+IGF2YWlsYWJsZSBhbmQgYWxpZ25zIHRo
ZSB0aW1lc3RhbXAgb2YgU0IgcGFydHMgd2l0aCB0aGUgb25lIGZyb20gdGhlCj4gPiA+ID4gPiA+
IGNoYW5nZWxvZy4KPiA+ID4gPiA+ID4gCj4gPiA+ID4gPiAKPiA+ID4gPiA+IEFuZCBzaW1wbGVy
IGNvZGUgLSBldmVuIGJldHRlci4KPiA+ID4gPiA+IAo+ID4gPiA+ID4gVGhhbmtzIGZvciBkZWJ1
Z2dpbmcgbXkgYnVnISA6KQo+ID4gPiA+IAo+ID4gPiA+IFdoaWxlIHRoaW5raW5nIGFib3V0IGl0
LCBJJ20gd29uZGVyaW5nIGlmIHRoZSB0aW1lc3RhbXAgYWN0dWFsbHkgaGFzCj4gPiA+ID4gc2Vj
dXJpdHkgcmVsZXZhbmNlIChlLmcuIGZvciBjaGVja2luZyB0aGUgZnJlc2huZXNzIG9mIHRoZSBE
QikuIEkga25vdwo+ID4gPiA+IHRoYXQgdGltZXN0YW1wcyBpbiBnZW5lcmFsIGFyZSBwb2ludGxl
c3MgaW4gdGhpcyBjb250ZXh0LCBidXQgSSdtCj4gPiA+ID4gd29uZGVyaW5nIHdoeSBpdCBjYW4g
YmUgc2V0IGluIHRoZSBmaXJzdCBwbGFjZS4KPiA+ID4gPiAKPiA+ID4gPiBUaGUgREVCSUFOX0NI
QU5HRUxPR19USU1FU1RBTVAgdXN1YWxseSBpcyBzZXQgdG8gMWggYWZ0ZXIgdW5peCBlcG9jaAo+
ID4gPiA+IChmb3IgdGVjaG5pY2FsIHJlYXNvbnMgMCBjYW5ub3QgYmUgdXNlZCBhcyB0aGlzIGlz
ICJtYWdpYyIpLgo+ID4gPiA+IAo+ID4gPiA+IElmIHdlIG5lZWQgYSBwcm9wZXIgdGltZXN0YW1w
IGhlcmUsIHdlIHNob3VsZCBwcm92aWRlIGEgd2F5IHRvIHNldCB0aGUKPiA+ID4gPiBERUJJQU5f
Q0hBTkdFTE9HX1RJTUVTVEFNUCBqdXN0IGZvciB0aGF0IHBhY2thZ2UgKGUuZy4gYnkgaW50cm9k
dWNpbmcgYQo+ID4gPiA+IHZhcmlhYmxlKS4KPiA+ID4gPiAKPiA+ID4gPiBCdXQgc3RpbGwsIHRo
ZSBjb2RlIHNob3VsZCB1c2UgREVCSUFOX0NIQU5HRUxPR19USU1FU1RBTVAgdG8gYWxpZ24gdGhl
Cj4gPiA+ID4gY2hhbmdlbG9nIHRpbWVzdGFtcCB3aXRoIHRoZSBTQiBvbmUuCj4gPiA+ID4gCj4g
PiA+IAo+ID4gPiBUaGlzIGhhcyBzZWN1cml0eSBpbXBsaWNhdGlvbiBiZWNhdXNlIHRoZSB0aW1l
c3RhbXBpbmcgb2YgdGhlIHNpZ25hdHVyZQo+ID4gPiBtYXkgYmUgY29tcGFyZWQgdG8gdGhlIHJl
dm9jYXRpb24gdGltZSBpbiBjYXNlIHRoZSBzaWduZXIncyBjZXJ0IGlzCj4gPiA+IHJldm9rZWQu
IFNpZ25hdHVyZXMgdGhhdCBoYXBwZW5lZCBiZWZvcmUgdGhlIHJldm9jYXRpb24gdGltZSB3aWxs
IHRoZW4KPiA+ID4gc3RpbGwgYmUgYWNjZXB0ZWQsIHRob3NlIGFmdGVyd2FyZHMgd29uJ3QuIFRo
ZXJlZm9yZSwgdGhpcyB0aW1lc3RhbXAgbWF5Cj4gPiA+IGhhdmUgdG8gcmVmbGVjdCB0aGUgYWN0
dWFsIHNpZ25hdHVyZSB0aW1lLiBBbmQgdGhpcyBpcyBvYnZpb3VzbHkKPiA+ID4gY29tcGxpY2F0
aW5nIHJlcHJvZHVjaWJpbGl0eS4KPiA+IAo+ID4gVGhpcyBpcyBub3QganVzdCBjb21wbGljYXRp
bmcgcmVwcm9kdWNpYmlsaXR5LCBidXQgaXMgaW4gZ2VuZXJhbAo+ID4gcHJvYmxlbWF0aWM6Cj4g
PiAKPiA+IFRoZSBwYWNrYWdlcyB3ZSBnZW5lcmF0ZSBtdXN0IGF0IGxlYXN0IGJlICJsb2dpY2Fs
bHkgcmVwcm9kdWNpYmxlIiBpLmUuCj4gPiB0aGUgYmVoYXZpb3IgbXVzdCBub3QgY2hhbmdlIGFj
cm9zcyBidWlsZHMgLSB3aGljaCBpdCBjbGVhcmx5IGRvZXMgaW4KPiA+IHRoaXMgY2FzZS4gT3Ro
ZXJ3aXNlIHRoaXMgcGFja2FnZSBtdXN0IGJlIGV4Y2x1ZGVkIGZyb20gc3N0YXRlIGNhY2hpbmcs
Cj4gPiB3aGljaCBhbHNvIG1lYW5zIGFsbCBkb3duc3RyZWFtIHRhc2tzIGNhbm5vdCBiZSBjYWNo
ZWQgKHVudGlsIHdlIGhhdmUKPiA+IGhhc2ggZXF1aXZhbGVuY2Ugc3VwcG9ydCwgd2hpY2ggdGhl
biBwYXJ0aWFsbHkgaGVhbHMgdGhpcykuCj4gPiAKPiA+ID4gCj4gPiA+IEkgd291bGQgdm90ZSBm
b3IgbWFraW5nIHRoaXMgcGFja2FnZSAoYW5kIHBvc3NpYmx5IHNpbWlsYXIgb25lcykKPiA+ID4g
cmVwcm9kdWNpYmxlIHRvIGJlY29tZSBhbiBvcHQtaW4gZmVhdHVyZSB0aGF0IHdlIGVuYWJsZSBv
bmx5IGZvciB0aGUKPiA+ID4gcmVsYXRlZCB0ZXN0LiBPciBvbmx5IGZvciBzbmFrZW9pbCBrZXlz
LiBNYXliZSB0aGUgbGF0dGVyIGlzIHNpbXBsZXN0Lgo+ID4gCj4gPiBOby4gUGxlYXNlIGp1c3Qg
YWRkIHZhcmlhYmxlcyB3aGljaCBjYW4gYmUgc2V0IGZyb20gbG9jYWwuY29uZiB0byBwaW4KPiA+
IHRoZSBERUJJQU5fQ0hBTkdFTE9HX1RJTUVTVEFNUCBvZiBleGFjdGx5IHRoZXNlIHBhY2thZ2Vz
IHRvIGEgdXNlcgo+ID4gY2hvc2VuIHRpbWVzdGFtcC4gVXBkYXRlcyBvZiB0aGUgdGltZXN0YW1w
IG11c3QgYmUgZXhwbGljaXQuIFRoaXMKPiA+IG1lYW5zLCB3ZSBhcmUgc3RpbGwgMTAwJSByZXBy
b2R1Y2libGUgYW5kIHBlcmZlY3RseSBjYWNoYWJsZSB1bnRpbCB0aGlzCj4gPiB2YWx1ZSBpcyBl
eHBsaWNpdGx5IGNoYW5nZWQgYnkgdGhlIHVzZXIuCj4gPiAKPiA+IFRoaXMgb2YgY291cnNlIGFs
c28gbmVlZHMgdG8gYmUgZG9jdW1lbnRlZC4KPiAKPiBTdXJlLCBidXQgSSBkaXNhZ3JlZSBvbiBo
YXZpbmcgc3VjaCBhIHZhcmlhYmxlIGZvciBwcm9kdWN0aW9uLiBJdCdzIG1vc3QKPiBvZnRlbiB3
cm9uZyBpZiBhIHVzZXIgZXZlciBydW5zIGl0IHdpdGggYSBwaW5uZWQgdGltZXN0YW1wIGZvciBy
ZWFsIGtleS4KPiBTbyBiZXR0ZXIgbm90IGV2ZW4gZXhwb3NlIHdoYXQgd2lsbCBiZSBzZWN1cml0
eS13aXNlIGluY29ycmVjdC4KCkhtbS4uLiBBIHVzZXIgdGhhdCBhZGRzIHNlY3VyZSBib290IHN1
cHBvcnQgdG8gaGlzIGltYWdlIE1VU1Qga25vdyB3aGF0CmhlIGlzIGRvaW5nLiBXZSBjYW4ndCAi
aGlkZSIgYWxsIHRoZSBjb21wbGV4aXR5LgoKV2hhdCBhcmUgdGhlIGFsdGVybmF0aXZlcz8gV2Ug
Y2FuJ3Qgc2FmZWx5IHVzZSBhIGZsb2F0aW5nIHRpbWVzdGFtcC4KVGhpcyBtYWtlcyB0aGluZ3Mg
ZXZlbiBtb3JlIGluY29ycmVjdCBpbiBtb3N0IGNhc2VzLiBBbG9uZyB3aXRoIHRoZQpnbG9iYWwg
dmFyaWFibGUsIHdlIGNvdWxkIGlzc3VlIGEgbm90aWNlIHJlZ2FyZGluZyB0aGUgdXNlZCB0aW1l
c3RhbXAuCgpGZWxpeAoKPiAKPiBKYW4KPiAKPiAtLSAKPiBTaWVtZW5zIEFHLCBGb3VuZGF0aW9u
YWwgVGVjaG5vbG9naWVzCj4gTGludXggRXhwZXJ0IENlbnRlcgo=

