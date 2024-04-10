Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BC2BCD128A
	for <webhook@archiver.kernel.org>; Wed, 10 Apr 2024 15:06:50 +0000 (UTC)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (EUR04-DB3-obe.outbound.protection.outlook.com [40.107.6.125])
 by mx.groups.io with SMTP id smtpd.web10.2082.1712761250353763068
 for <cip-dev@lists.cip-project.org>;
 Wed, 10 Apr 2024 08:00:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=mLHZEpmW;
 spf=pass (domain: siemens.com, ip: 40.107.6.125, mailfrom: felix.moessbauer@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TDZjOEFrES7OGSRC8g56cqtvmE9f7GG5BU/30XJwdzlG7uuq+fZ4BwXbVXlq+WDaEkONukgNieWssoU/wf7tK+KKwk4JVUC6B5dj1UBPFi6BNYlDfyaZ51A2UKEjKM777uMXrwcYofJLLIY9elXIp/J4+y09ukA2fkHkY2Hivmw4lOfwNOHHdOQvgSHCTiNq645dYf6QnX2IMoyzzzEju1zuGkEpjgyEcqewvwXERxU7FPi+slwiCZ30U/B0BaKnPSSk7+GAxe/Q5xtP5R1lXXw5GsdrWBrLJ8wudTI7rkYyw5qJ9Ca6RG1drfe6dvmXbCDd5MmSZkZoL8uYZ4Jl0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kJqxKDhxANo/ZBt/ZMhZ5KoML/OZi1D5BRVZOORE/ys=;
 b=kqASelCq+P/PflhAezUhYd8b/hrBrgBDReg7FAU8wBfUUOW9JYil7rID6QWacpPfJSz0TWjT+6wZ5m2yACMjigPQcyn9mqA9LOHrrLrcgLMDt2Dpo6ylgQJr3EywoK31TIGBflzyYPRV9UIl1GAMqBa6N+wIQJMp3PpJKXyexr1XdrNM8L06FLdIXGfBQwUlvALjIyG0aiPBZjPSULj/x5b6vsx5kR1RsZ2N5inJfANH+S9u0nPc8nsbkZUYVWcc570nCuywDYD+iIjUqcAUQPJJ57HhRqnmjVcqHUOMBw5iRKNDSGJ5ex+mlAa8O/e38bs9KDPx/CgtmdF8U147vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kJqxKDhxANo/ZBt/ZMhZ5KoML/OZi1D5BRVZOORE/ys=;
 b=mLHZEpmWPshDxN4WgYLZhacYx7k04yJskAvBmftCeDkTBzrqnl6oFjgBEiAQVon8iqUSbMz7tf+Is+sR1lPkyQb25Pt2RLWRc9kUDN+kmuLt1Xi18sMd435b6dA7FSrDk1EeDyLlVX03e5Djv6On8+9XBiMflB1H/6JzmODFg/QbnZ+O3TAhkCxPDq6K/e+bBS6ha1XJm2Ve+u5X/kdWve/tlhYEME959OhQmzEhSC8ox3sg3JIMrBjcOoPw1HqEfzhvjdSxbbfsR3tHhcUPS29gba8vEiBfBfzxUJOx2y5h8SE7hdI9bOvubVK2j/RYFsPhfhCyX2ZQvPeFFpTXtA==
Received: from DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:47f::13)
 by AS2PR10MB7369.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:607::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Wed, 10 Apr
 2024 15:00:47 +0000
Received: from DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::e0b3:537d:ebe2:c0a3]) by DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::e0b3:537d:ebe2:c0a3%5]) with mapi id 15.20.7409.042; Wed, 10 Apr 2024
 15:00:47 +0000
From: "MOESSBAUER, Felix" <felix.moessbauer@siemens.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
CC: "shivanand.kunijadar@toshiba-tsip.com"
	<shivanand.kunijadar@toshiba-tsip.com>, "sai.sathujoda@toshiba-tsip.com"
	<sai.sathujoda@toshiba-tsip.com>, "dinesh.kumar@toshiba-tsip.com"
	<dinesh.kumar@toshiba-tsip.com>, "adithya.balakumar@toshiba-tsip.com"
	<adithya.balakumar@toshiba-tsip.com>, "kazuhiro3.hayashi@toshiba.co.jp"
	<kazuhiro3.hayashi@toshiba.co.jp>, "Kiszka, Jan" <jan.kiszka@siemens.com>,
	"Schmidt, Adriaan" <adriaan.schmidt@siemens.com>
Subject: Proposed changes w.r.t. SOURCE_DATE_EPOCH
Thread-Topic: Proposed changes w.r.t. SOURCE_DATE_EPOCH
Thread-Index: AQHai1fettnCV9o6HEukDKufFrbSbA==
Date: Wed, 10 Apr 2024 15:00:47 +0000
Message-ID: <d3edcd7fc0b61bdbda9941f0bfff1c3e008e7cd1.camel@siemens.com>
Accept-Language: de-DE, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.46.4-2 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR10MB6828:EE_|AS2PR10MB7369:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 zvBMAD73fCSzzY2l8UtF75Uym8vOiie+5pw3gRuaKcVf8VOJ+YZNKqHU+lCvfcCHkkaQPCdn0Y9VAsbl+1SmymOgfPpDUeKzTouz+fY0zqywl/2PHBCTp0t00A/o81mAOzCPNZwAl9WLsyzwJh4c7QbNC+j1u67/wr7wnevvdziNT8xJODrH0STIaVTK6WOUCZFI1CqJsyUqxJ+0yNdeWKsUAA7OCUNC23lsss+Fg9zgepgRNjz+VczjQbHon6v07O44wIpXkM95mXaygojrGYccFuseitHllu+/rTV8qt/3dHjsfvXkM0SCGeSWzdxRNhm6SSfdg7xsQTc5zQrp3bcSdFn/oUraWYbRSU8f76k1crM3HNOgePlSVa/1X5xC3y5XUXIeJ6s5TDicTNyHUxSRVHIQbDuOemOeKSG4TfMVB144zhmehI7ZF+2OxsueevSzZ4yKhj5Bz1FTttItAyrnVJh9GggVEH5X+ME3VXv9oCutBhoElx59rnDVaGjVT1iuOcvTqVXDFAi/y4dQhTfqAddj2LPKP0osNOTw73+K9F/Ui5Rt37Jiw92zUesTfnvD9YjjQoiDDuoieQywX644jOCn3YL8HfZkCZN8tho=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?eUM4TkVkNmpZRjVNcjNLQXc5M2h3YjdvbnpIWXJtalZZZndUUFoyTm1tMnA0?=
 =?utf-8?B?c0FEYXVXOE0wWnVBbCttSThpYStGb3l5SUZjSHNjdm1IWXdBVlA0eE94MG1u?=
 =?utf-8?B?RkVxRTRJTmtPZ1N3RE9qRkphUkVCWHR3bWt4MUNlL3dEdnZ6TUkyMEw1Zmh0?=
 =?utf-8?B?TEZKOGhFelR4aUJ0b0t6ZWh2cGh6T1Q0TEVWU0VoRVR3N3hpb2VjVXg5VWtn?=
 =?utf-8?B?SW8yNDBkdU50c1NzV1h3K0lGQjBGUjZFNW04T0FDZG55RzlqV0VPYmNwdUE2?=
 =?utf-8?B?MktpV2NaWnoyaDJPRExLMGhLN1BxQ3poN2xYNEs4RU1hWUhxbDlWMldvUmtJ?=
 =?utf-8?B?K2hVU2tkbVdiR1EySUFEdVdNajJnRm1pN1A3TWlhYXMyd3lubEp6bGRHWm9L?=
 =?utf-8?B?MHFHWVZCRmJFOUg4aVlXY2ZSZ0JDQ0M2UHhmcWVjdmFzTFE3NU9kZEduYXcx?=
 =?utf-8?B?TU1oZWVySzdQTHBnUjhOSmNFa0puTkR6ZzBKUVdiNlNoTFhkTjI5L3Z5aThX?=
 =?utf-8?B?TFlJN3hmVGJqY1EwcTNvMmprTUZnVHZ1VDNlUnlJM05nZkdSbUt4eXNFV3gv?=
 =?utf-8?B?OVdCOWNpajdFQ2RmOUtJQ0lTRlN1TXVGMmtJQmhYWm9hbnJlcU1sa0orbk1J?=
 =?utf-8?B?WTV4RDJSMWxEVVF5ckp1VW5iQzNsTmpPSHZDdzdVU3Fla1RZUmw0ZTd2bEtI?=
 =?utf-8?B?akYwcTJ4TDRjVExYOGgzVXM2U2xWWDhmVUJSRVFpUXlhTno2aktZSVFIWUtz?=
 =?utf-8?B?YTd5Z1FaZXFhL1RuVmZ4ZWFrVFJ0UHpsUmdZWVE3UXZQVXg1S3dYY01aZG1i?=
 =?utf-8?B?R2FBWENLYUZmYjY5NjdRajg4TVZ6eWpRNVdIQUlhcnkzbkkvZjdGY3F3UEtN?=
 =?utf-8?B?VldoK2lzRGZxQ0tjazhhWkNtYTlQSHAwSjNhd09nRGhwblBsSFY1OWMwNk82?=
 =?utf-8?B?RnQyWUlocnlCZkx6SUhRUjBESyt5eW96bnZFMWJ4ZkNkN1Jqd01sVjVSaldt?=
 =?utf-8?B?WVRabmFtenFOUVpTUU9CakFZbzZvNzA4U3NpcGxDMTMrd3p0aTNxWlJEa01N?=
 =?utf-8?B?RjcrWnJYMlEza2ZSaEdQRjhKdVRyZWhqSmtDdGVmdU1yZHZEUVZGWndmNDhN?=
 =?utf-8?B?dkhMT2JIK05EWGhiekcyK1B4NSt0eHd5RFZBblFLc1Y2ak44Q1AvRWZ4UUFi?=
 =?utf-8?B?Y3oyR1hYc2FsbkkvdmxkTXVCU01VdkR3MVM4a2ZZN3c4THlsSS9KVUhnOWho?=
 =?utf-8?B?WmlVQTBZZVV0SG5Palh6anJheXdnd0FmU0M3cjMyVkxjN2JkODZNSkVVVzRj?=
 =?utf-8?B?S0x2TW5NVnF3Z21sV0o5bGxoMFU1dnF3OVk1ajZYRDdGblM2Z2NkT3QvWTEx?=
 =?utf-8?B?Q1JVUmJDRnhuRzMvZWtkd1R6eVQ3WFNON3czbWo3aTVhVkliaXgrTEJUSExj?=
 =?utf-8?B?Y2FyWFBXWFhUQUFEOEFRV3JqdUJJWWZQYTVoN0pScVcwUDIrZ3FmeGtYSExv?=
 =?utf-8?B?SnpodEJJaUFHYU1wYWFBWGtadjZjbEhiYTk1Z2NwUjNWZWxoNGR2Y2dYWU5h?=
 =?utf-8?B?Ri93TlFPOTdZUTkveklydjVGSEIyK2pRZTE5Mm9OQmxPT3V4L3pHaUZhc3Bx?=
 =?utf-8?B?aktZSXlueUo5VmVLZDV4ZHI1WkxYZEVlMHR2czRadXdhRjV2TTd4Mi9JUmgx?=
 =?utf-8?B?TWlqeVdwc2JjcUo4VzZ5M1lxbitxUVBLcFA3QmdMejV5THpQRHZ6YXNNRFZF?=
 =?utf-8?B?S1JsWHpHaGlueCsrM0VVYloyL2F1WVdnK2J4akgvN1BuT3lXZFFCR0h5emZs?=
 =?utf-8?B?eHB4a2NkdlBybThoaDRCZXJUcjE1aWRxYTFZckowSVViSGZtVldBY2pzNTgy?=
 =?utf-8?B?ZzA5dlRoNDZacFo2UDljSHRQR0tqSjZ3L2RKdHk3aDMxOCtuVnhNUjM2Uk1v?=
 =?utf-8?B?aGxHc3NCMFFKbEZHNTg3SmdVTXQrQ1loQWt2bkhSeWdTRHBqbTlBNzFDNktt?=
 =?utf-8?B?ZzZFY2taQW8vaGtaanBnTTdVWVlabnlURDBJMTFMVFVHRlZQaVVIakVweWdC?=
 =?utf-8?B?aGc2WWRTV0U0V0dXNndNd1FLSzVhQ092WmJXUUUxL1BNRXd2bC94dEtaclRN?=
 =?utf-8?B?UzFpMnZ2S2p2VnFWa3R1Y01nbHFLVU9JeExhS05DMldLbzBqYVN6V0Z1SXEv?=
 =?utf-8?B?bWs1bXdRRy8zYkp3dmRmVVkzaGNWek5wV2NlQlVqZ3c5eEV0UmZjM2NMR2xo?=
 =?utf-8?Q?oU9UoUQTBZ5nwf6T5iBZS4YBMxPdWFdx5xKz8z7IiA=3D?=
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 42d6a317-9f3c-45b4-f2d7-08dc596f0101
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2024 15:00:47.2655
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uGhi/7rIxit0nztwJrPjcl6kSEmq/C/iTmJHYRgXCwqmVa8IkksJEbK31xLnUgVUhG1NPvaWhvNMp/pX1qy7yGJANQhnJzcPzv+gb4QO3FY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7369
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <9F06357D7DB7AE44AF674DBE95046DAD@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 10 Apr 2024 15:06:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15536

SGkgcmVwcm9kdWNpYmxlIGJ1aWxkcyBmb2xrcyENCg0KSSByZWNlbnRseSBoYWQgYSBsb29rIGF0
IHZhcmlvdXMgcmVwcm9kdWNpYmlsaXR5IGlzc3VlcyBpbiBJU0FSIGFuZCBob3cNCnRoaW5ncyBh
cmUgZG9uZSBpbiBZb2N0byAvIE9FLiBUaGUgcHJvcG9zZWQgY2hhbmdlcyBhcmUgZm91bmQgaW4g
WzFdLA0KYnV0IGxldCBtZSBzdW1tYXJpZXMgdGhpbmdzIGhlcmUgYXMgd2VsbDoNCg0KMS4gR2xv
YmFsbHkgc2V0dGluZyBTT1VSQ0VfREFURV9FUE9DSCBtYWtlcyBubyBzZW5zZQ0KMi4gV2UgTVVT
VCBidWlsZCBhZ2FpbnN0IHNuYXBzaG90IG1pcnJvcnMNCjMuIFNPVVJDRV9EQVRFX0VQT0NIIHdp
bGwgYWx3YXlzIGJlIHNldCAodG8gU09NRSB2YWx1ZSkNCjQuIFdlIHNob3VsZCBmb2xsb3cgWW9j
dG9zIGFwcHJvYWNoLCBldmVuIGlmIG5vdCBpZGVhbA0KDQooMSk6IFNldHRpbmcgdGhlIFNERSBn
bG9iYWxseSBoYXMgdGhlIHNpZGUtZWZmZWN0LCB0aGF0IHdlIGNhbm5vdA0KaW50ZXJuYWxseSB1
c2UgaGV1cmlzdGljcyB0byBnZXQgYSBtZWFuaW5nZnVsIHZhbHVlIHBlciBjb21wb25lbnQuIElu
DQp0aGUgZW5kLCB3ZSBkb24ndCB3YW50IHRvIGNoYW5nZSBjb21wb25lbnRzIG9uIGFuIFNERSBj
aGFuZ2UgdGhhdCBhcmUNCm5vdCB1cGRhdGVkLiBJbiBPRSwgdGhpcyBpcyBzb2x2ZWQgYnkgdXNp
bmcgc3RhYmxlIGhldXJpc3RpY3Mgd2l0aCBhDQpmYWxsYmFjayBmb3IgdGhlIFNERS4gVGhlIHVz
ZXIgaXMgb25seSByZXF1ZXN0ZWQgdG8gc2V0IHRoZSBmYWxsYmFjaw0KYW5kIHRoaXMgbmVlZHMg
dG8gYmUgZG9uZSB2aWEgU09VUkNFX0RBVEVfRVBPQ0hfRkFMTEJBQ0suIE5vbmV0aGVsZXNzDQpy
ZWNpcGVzIGNhbiB1c2UgdGhlaXIgb3duIFNERSBvciBldmVuIGEgaGFyZGNvZGVkIG9uZS4NCg0K
KDIpOiBJZiBidWlsZGluZyBhZ2FpbnN0IHRoZSBkZWZhdWx0IGFwdCBtaXJyb3JzIChlLmcuIGRl
Yi5kZWJpYW4ub3JnKSwNCnRoZSBidWlsZCB3aWxsIE5PVCBCRSBSRVBST0RVQ0lCTEUuIEV2ZW4g
aW4gdHdvIHN1YnNlcXVlbnQgcnVucyB0aGVyZQ0KaXMgbm8gZ3VhcmFudGVlIHRvIGdldCBhbiBp
ZGVudGljYWwgc2V0IG9mIHVwc3RyZWFtIHBhY2thZ2VzLiBUaGluZ3MNCmdldCBldmVuIG1vcmUg
c2V2ZXJlIGFzIHRoZSBzc3RhdGUgY2FjaGUgY2Fubm90IHRyYWNrIHVwc3RyZWFtIGNoYW5nZXMN
CmFuZCBieSB0aGF0IG1pZ2h0IHByb3ZpZGUgb3V0ZGF0ZWQgYXB0IHJlcG8gbGlzdHMgd2hlcmVi
eSB0aGUNCmNvcnJlc3BvbmRpbmcgcGFja2FnZXMgYWxyZWFkeSBnb3QgcmVtb3ZlZCAtIGxlYWRp
bmcgdG8gYnVpbGQgZXJyb3JzLg0KSW4gQ0lQLCB3ZSBiZXR0ZXIgbm90IHByb3ZpZGUgYSAicmVw
cm9kdWNpYmxlIiBvcHRpb24gdW50aWwgdGhpcyBpcyBub3QNCnNvbHZlZCAoZS5nLiB3aXRoIHRo
ZSBwcm9wb3NlZCBwYXRjaGVzIGluIElTQVIpLg0KDQooMyk6IFRoZSBwaGlsb3NvcGh5IG9mIGJp
dGJha2UgaXMgdG8gdHJhY2sgYWxsIGNoYW5nZXMuIFdoaWxlIHRoaXMgaXMNCnByYWN0aWNhbGx5
IGltcG9zc2libGUsIHRoZXkgYXQgbGVhc3QgdHJ5IHRoZWlyIGJlc3QuIFRoYXQncyB3aHkgdGhl
eQ0KYWxzbyBkZWNpZGVkIHRvIGFsd2F5cyBzZXQgYSBTREUgKHdpdGggc29tZSBhcmJpdHJhcnks
IGJ1dCBmaXhlZA0KdmFsdWUpLiBUaGlzIGFsc28gbWFrZXMgdGhlIHJlY2lwZXMgYSBsb3QgZWFz
aWVyIGFzIG5vIHR3byBjb2RlIHBhdGgNCmFyZSByZXF1aXJlZCBmb3IgcmVwcm8gYW5kIG5vbi1y
ZXBybyBidWlsZHMuIEZvciBzc3RhdGUgY2FjaGVkDQphcnRpZmFjdHMgd2UgbmVlZCB0byBtYWtl
IHN1cmUsIHRoYXQgdGhlc2UgYXJlIGFsc28gY3JlYXRlZCBhbmQNCmV4dHJhY3RlZCByZWZlcmVu
dGlhbCB0cmFuc3BhcmVudGx5IChlLmcuIGl0IG11c3Qgbm90IG1ha2UgYSBkaWZmZXJlbmNlDQp0
byB1c2UgYW4gYXJ0aWZhY3QgZnJvbSB0aGUgY2FjaGUgaW5zdGVhZCBvZiBleGVjdXRpbmcgdGhl
IHRhc2spLg0KDQooNCk6IEFzIHlvY3RvIGhhcyBhIG11Y2ggYmlnZ2VyIGNvbW11bml0eSwgYSBs
b3Qgb2YgdG9vbGluZyAobGlrZQ0KYml0YmFrZSkgaXMgbW9kZWxlZCBhcm91bmQgdGhlaXIgY29u
Y2VwdHMuIFRoaXMgaW5jbHVkZXMgdGhlIGhhbmRsaW5nDQpvZiB0aGUgU0RFIGFzIHdlbGwuIEZv
ciBzb21lIChhcmJpdHJhcnkgb3IgaGlzdG9yaWM/PykgcmVhc29ucywgdGhleQ0KdXNlIGEgZGlm
ZmVyZW50IHZhcmlhYmxlIHRvIGNvbnRyb2wgdGhlIHRpbWVzdGFtcHMgb2YgdGhlIHJvb3RmcyBm
aWxlcw0KKFJFUFJPRFVDSUJMRV9USU1FU1RBTVBfUk9PVEZTPSkuIFdlIHNob3VsZCBjb25zaWRl
ciBkb2luZyB0aGlzIGFzDQp3ZWxsLg0KDQpbMV0gaHR0cHM6Ly9ncm91cHMuZ29vZ2xlLmNvbS9n
L2lzYXItdXNlcnMvYy9uaktscC1oMDc5ay9tL2FGM0xlOG12QUFBSg0KDQpCZXN0IHJlZ2FyZHMs
DQpGZWxpeA0KDQotLSANClNpZW1lbnMgQUcsIFRlY2hub2xvZ3kNCkxpbnV4IEV4cGVydCBDZW50
ZXINCg0KDQo=

