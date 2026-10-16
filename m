Return-Path: <chris.paterson2@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25D4FCCA462
	for <webhook@archiver.kernel.org>; Fri, 16 Oct 2026 14:03:33 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.0])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.22558.1792159409843523760
 for <cip-dev@lists.cip-project.org>;
 Fri, 16 Oct 2026 07:03:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=Rfmg19jT;
 spf=pass (domain: renesas.com, ip: 52.101.125.0, mailfrom: chris.paterson2@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TFCuBqB0Ec4t9O0LTwUsxhbnP1gDTvKQko4yNfWt+10/QZMQIApPzt4tg4TWYpgPiOXlpGTk8874SwclXr8vrlkGo8Mfw3hRzAexJDcBYGCyqvIxn3lUEOo8JxsmsFMxbeGatvgkambDCIusYtbvUVi/d6N1tBDpzOld8QBnvTNficoyzKZL+I+L0TNsUKE6T+CKGJVCRYAUbRmGJcBCl77QbvVCPCXqnkBstmbZ+xrMftF5veCpGsXiQC72BL+zzVKaYqw+j+eKAXKXvOhKSfWga4830fwMQhQnRO9wjS9eWw0T+cK7+YjoBg6A8XqUNUCMd+YsZKAvUkpNAmSdxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f0NOGg95OS9fKJOzeUOEIAmzmwqcYYw+bFMkiYVXPCM=;
 b=nK3bzEO/fThnYVkx4flUlzSLlKvnfyVWQRINKsWmWvPLQlpDs3Kzkq+xOLSVUVdS/umSM5QZuokJrjPwQYqASraREXYQAjZ18v9+K1xg668IG96LIzQ2nwCOp5whH5rJup1AHFYG3keQBD0IfBe4VO7svVLKBhdwx6a5pLnJXv9t0m4uko8pTa7NWWYcGt3SBo21I/J0TEv+8SDoMD7baF7YGMO+SoXV+8ljUBO1Zcl5/fPNHCaj6r9mhtABywpGtYEGWIZcpfWVI3uFbnWUU6ao6rhD/7e9MHFtGkXBiTuNk+LJGo7orbG6NwWEFlpGlf4yXTu3NIWw+n3dxm2HhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f0NOGg95OS9fKJOzeUOEIAmzmwqcYYw+bFMkiYVXPCM=;
 b=Rfmg19jTlkJF38ZRxx44ZWxx9lAyBcGYKk6yPMRPOPPY3hvN5G3dBLMO8dKRQka/UnDa0QlpWZbVqdnTZme89rYl0CkREp/XD7QXgWk/j9t9K7I2wCni7p3gSPxYoMzXm0vn6VbRxePFjMrEZMGCubJfymd1VQq8Kx+aQYWnU5M=
Received: from OS3PR01MB9738.jpnprd01.prod.outlook.com (2603:1096:604:1ec::10)
 by TYCPR01MB7340.jpnprd01.prod.outlook.com (2603:1096:400:f4::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Fri, 16 Oct
 2026 14:03:24 +0000
Received: from OS3PR01MB9738.jpnprd01.prod.outlook.com
 ([fe80::8bc7:407c:4c32:df71]) by OS3PR01MB9738.jpnprd01.prod.outlook.com
 ([fe80::8bc7:407c:4c32:df71%6]) with mapi id 15.21.0522.013; Fri, 16 Oct 2026
 14:03:24 +0000
From: Chris Paterson <Chris.Paterson2@renesas.com>
To: Pavel Machek <pavel@nabladev.com>, "bot@kernelci.org" <bot@kernelci.org>,
	"kernelci@lists.linux.dev" <kernelci@lists.linux.dev>
CC: "kernelci-results@groups.io" <kernelci-results@groups.io>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: RE: kernel ci results on the mailing lists was Re: [cip-dev] [STATUS]
 cip/linux-6.1.y-cip-rt - 407b1406d2fad2b7ac279f28757bbd06e1d541dd
Thread-Topic: kernel ci results on the mailing lists was Re: [cip-dev]
 [STATUS] cip/linux-6.1.y-cip-rt - 407b1406d2fad2b7ac279f28757bbd06e1d541dd
Thread-Index: AQHdXRZG6RAZKJIDqU+lGFrWX5ie47b/9vSAgAA239A=
Date: Fri, 16 Oct 2026 14:03:23 +0000
Message-ID: 
 <OS3PR01MB9738A7DF7A0BE791C393E9EDB79B2@OS3PR01MB9738.jpnprd01.prod.outlook.com>
References: <179211780515.391248.13476473435623274437@244668f92ec4>
 <atH7baHpQxrGTH_F@duo.ucw.cz>
In-Reply-To: <atH7baHpQxrGTH_F@duo.ucw.cz>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB9738:EE_|TYCPR01MB7340:EE_
x-ms-office365-filtering-correlation-id: 1f0aa630-1e97-4670-fc31-08df2b8e3e42
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|38070700021|56012099006|4143699003|11063799006|261009223027099003|10067099003|18002099003|22082099003|13003099007;
x-microsoft-antispam-message-info: 
 Gz9+lJ++rlSzcJ1AQapAexbity6maUR7TPEtcRvZTcZxCcG5QXUYOeWDQYLz2Wts45MgODGyMbjH9o8hs6OnSNrmWe04DNAaL/btjdKZ24FKpgcKRS0YHug1t7jtiU4TqNOjja1t4VrmJMAktNu2+oHlQqz/0b7FKNRtSv3fPKsYkkt9cFhO1fbEKWo8E5VhDFn5IkRqL61l+3MsFu3jFwykFF6X8YKbvHNhcdEmR3bcM5jBPtJJJp4fhYHHUTrupB+mDnOUu69irQyMAQcRxNNh5P+SjliwjAf6hxOc+5lNr3LRVPaUkKtgIsIWsDVOQA/bA/xJgt5xfV0kkY2cfUujraV1qSGhmWwuUu8za+dRtkICL62/2HftDOMIqaAq6SU/E41hGs299RL6x+LMu2Tjb3nGyZEuEU6hWJFowNXrXuQwpPASxlZzceyS9i6MxAVXAkKiNubgR9zJO9lH6vkEODUOhqxPW+cdaHBlT2n26HswD3qX5b9ca66SlCbzqRXf4J/GBbjR87Mon3yujqef5aGQwEul8VM+ai7pSpykt01w4Jao/fm1MIIftQS6cFhP0B4d7lEOUWMe0jtZvxkiIHRggInbTJJchGaErjVd2zICiO0dKJ+fQZB/trKGK4F/P2MlEUe6+dEJkIPHnKmkoxF1tCJdzmu8PY+2D/w=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB9738.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(38070700021)(56012099006)(4143699003)(11063799006)(261009223027099003)(10067099003)(18002099003)(22082099003)(13003099007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?TmQrenJSMVBXSjB6VzZsd1hLSXBFWXRveGNQSktJYS9PRWNoZ3Rkb0tQQ0tv?=
 =?utf-8?B?YytNMmNaTkxNV3UrQ3dxRWNObnBwRmo3WnlVbVlGeS9QMGxBU251RjFwNVMw?=
 =?utf-8?B?eHFvU3ZVSG4rUGtoV0tmT2xyelUxa1Z1OExyVW1QWUduRjJYZGczZ3ZjTFla?=
 =?utf-8?B?bWdheEpHZkJZRndYTW9sSFlPc1czckI2OEMvYVhSVXYzVzRMRURaVEt0YUsw?=
 =?utf-8?B?V2hBWnAvSUFPLzZpOU1IRWdxMjZnRllhN05PeEV1VUl2UWRZYjV4M0NZTGJz?=
 =?utf-8?B?cG92UEY2WkVFeXoyRW9vTGpCTk15Q0tJYzhHYTFUVUxSMTZ2UW1UaExlbS9V?=
 =?utf-8?B?OWlBbm9PM0xZY3RCdVNkbGxvblRZUEFHa0ErUmo4cnJJaDhQSjJOL0FsWndK?=
 =?utf-8?B?MmEzOTlyU1ZvOFB3U294UGRaWDFDU05TQTJNYmNWZUZwajFodDJxREhON2Jk?=
 =?utf-8?B?RDZkS3RVNUc1YzBXWUJNd0pVSUJGWUVYK3VCSXg2dXZWL2Z4YlhzQkpKTlJY?=
 =?utf-8?B?WEFIYmkrazlkQ0REbGNJZUp3amZrRTNPcXoyZm1vdFNzaEZzU0Y1T2o4blJ3?=
 =?utf-8?B?ZG9LTEMvYU5iUkcrQWR6TTV1cCtKblplNUMrdnFzd0Y2MEd0TXlESnNlRk4w?=
 =?utf-8?B?ekt6N2drTTdxd1N1ZmNsNVUvREdNR294YTA1d1RFSG5qKy9WaXdiTElWY3JG?=
 =?utf-8?B?NHNSbG13RnU3aHh4UzBYSW5sYUVGUm1hU3FBVjNrYnRra0o3SndrUEs3aWRz?=
 =?utf-8?B?c2ZzK3JLZE55NFN1dyszNnZ0bmdJRjh5enhQVDgyUEp5RHhOczVMZkUxV21u?=
 =?utf-8?B?SXQwZk5XTHZHUmprbXh6akxIZFMrUlVlaklRbXhMQWJIZ28va01PaGczODV3?=
 =?utf-8?B?MjFodXg0b1p4aXQ3Mi9QK3RJT2pUZk1OUSsxVEs3cFZqS2pySDIxSUVDYXVw?=
 =?utf-8?B?RWhEcm9BbmEwa0xCQ1l6SFdQRzBFSTltN0VSR1k3dnRJaEQzWXhrZC9jcnBu?=
 =?utf-8?B?YkpWWkVvdjdPOGs3RlhUYTllVGdXOVpBUHFqY3VXZ0VBaUlzVnYyVm9ZM2t2?=
 =?utf-8?B?Y2RrTTBxNmg0QkhHUFFJRGk4YlZOelFGT1FhS2Y4dnhLZEppaUdBVHNUMDRD?=
 =?utf-8?B?TFBQdk5lNUF0TmNhajF0VTEyU01VazhESDVsMlJ4aFpNd1dFWEpFVzdTdGg4?=
 =?utf-8?B?aW5mZnF3a2h5c1pPVHM5T3pmRVRWcjhZYmc1N0FkODVnTXJMNGRXVTR0WUVF?=
 =?utf-8?B?anBqOFh3ZWp5SXN0K3I4MUJTNUtDVk9RUktOdE5rZGx5M0RRMjBOeVhmVVp2?=
 =?utf-8?B?c3d3SHVzOXdxTmhkTFBGRFpXcUZRMGtLVEVCVVV4TVhGNm50MUM1YmpxTnNi?=
 =?utf-8?B?TDZwN3BGNVRLendVRTdpdHFyTUphaXhBL2VQSEdpemRDdzZPT3ZnWDI3c1Vm?=
 =?utf-8?B?WHB2dTVQNmw4QUE1SElYUVFoK3l3RFlKRis2TUFoZEI2eGRyWGxsVE9ILzUv?=
 =?utf-8?B?RCsvbXlLYTVZYyt2blpzdTRDODdnaWpIWUZFYTdmZFJHN3VuZ0lQQUdBbHZz?=
 =?utf-8?B?L1k4TU1DSmNwR2hpU0JIQ0FKNFpaWEtCWjQ1bitVajMydkdqbGY1RVlHR3FV?=
 =?utf-8?B?bkZZekRyL2tSczRIZDJ4ZzhQclB4NWtvQVAyQXdOU0hDa2JRcnpXVVM1VzNK?=
 =?utf-8?B?Q00zR2FhUUQ5K2ZxU2M0dVByWk5QYWw5M3d2V3gvRmQ4RVI0ZjlkcnZGMHEw?=
 =?utf-8?B?Kyt5RnNmSFp4UTFaL1B0RE1keXEyMmFtczNtdUxrbU1FRDNjSGFNUUJ5T0JM?=
 =?utf-8?B?RWdyY1ZFU293ZkJvN2dYMVdMOVdiYThKNmo0dTZtWllXb01Ub3lrUTd2WW1w?=
 =?utf-8?B?L01mYWREbXlmYWdRNU5kaXZDTms5cUIydnRiek9NajliRXFuVlc4NTFmeU5R?=
 =?utf-8?B?bWxSV2VLNkdUb2E1SmV3VytSL3VTSmh1ekl5OVlDSk9nZ1J6bkNqLzVQV1gr?=
 =?utf-8?B?alNQdkpqK3hDQjczNEs2aXJFQ1V1MFBJMkJtTFJiQUNma2ZNaitVVkF2YTZ5?=
 =?utf-8?B?YjlnVG5ZUWd5S1ZXMllSUkN1UlRBSk5EUVVMbWhVaHVERGwxd3MzbmNHNmo5?=
 =?utf-8?B?cHE1akpVeWxKbzhBU0pVMGJxUHRtdjNEMHh4Vzl2b2xTRzU3a25VOHJyN0R3?=
 =?utf-8?B?aFJhR0JKWFcwTVV2czQySUdBZk4yMVhnOU1oa08wU0diMjdXVE9xa2pXN0Rp?=
 =?utf-8?B?QmNrNjcvVGE5WGJZTXN2WExUU3hzVVpwaFZtalJraENUc3RTL2NYdFoxaDZI?=
 =?utf-8?B?UlZYU25TMVZacVVjclhNcmtnME0yZkg3dllGYi8xMTBxVFVBT2F3UT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB9738.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f0aa630-1e97-4670-fc31-08df2b8e3e42
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2026 14:03:23.9792
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +ZroOVXZg2Xa+rixbNv2FG4rCJKtDMZXXG1TapHRQXMPKhp4eFCU+3zlXNDukmLFCzzCfGFZreBMUaBaeNdBGLumedqIBPQK+0PHLoYeeqc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB7340
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 16 Oct 2026 14:03:33 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24480

SGVsbG8gUGF2ZWwsDQoNCj4gRnJvbTogUGF2ZWwgTWFjaGVrIDxwYXZlbEBuYWJsYWRldi5jb20+
DQo+IFNlbnQ6IDE2IE9jdG9iZXIgMjAyNiAxMToyNQ0KPiANCj4gSGkhDQo+IA0KPiBQbGVhc2Ug
ZHJvcCBhdXRvbWF0ZWQgbWFpbHMgZnJvbSB0aGUgbWFpbGluZyBsaXN0cy4gQm90cyBvbiB0aGUg
bGlzdHMNCj4gYXJlIHNpbXBseSBub3Qgb2theSwgaHVtYW5zIGFyZSB0cnlpbmcgdG8gdXNlIHRo
aXMgZm9yIGNvbW11bmljYXRpb24uDQoNCkFzIEkgc2FpZCBJJ2QgZG8geWVzdGVyZGF5LCBJJ3Zl
IGFscmVhZHkgY3JlYXRlZCBhIHB1bGwgcmVxdWVzdCB0byBzdG9wIHRoZSBzdGF0dXMgZW1haWxz
IGNvbWluZyB0byBjaXAtZGV2Lg0KSXQnbGwgYmUgcHJvY2Vzc2VkIHNvb24uDQpBcG9sb2dpZXMg
Zm9yIHRoZSBleHRyYSBlbWFpbHMgaW4gdGhlIG1lYW50aW1lLiBQbGVhc2UgZmVlbCBmcmVlIHRv
IGZpbHRlciB0aGVtIG91dC4NCg0KPiANCj4gUGx1cywNCj4gDQo+ID4gaHR0cHM6Ly9kLmtlcm5l
bGNpLm9yZy9jL2NpcC9saW51eC02LjEueS1jaXAtDQo+IHJ0LzQwN2IxNDA2ZDJmYWQyYjdhYzI3
OWYyODc1N2JiZDA2ZTFkNTQxZGQvDQo+ID4NCj4gPiBnaXR1cmw6IGh0dHBzOi8vZ2l0Lmtlcm5l
bC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L2NpcC9saW51eC0NCj4gY2lwLmdpdA0KPiA+
IGJyYW5jaDogbGludXgtNi4xLnktY2lwLXJ0DQo+ID4gY29tbWl0IGhhc2g6IDQwN2IxNDA2ZDJm
YWQyYjdhYzI3OWYyODc1N2JiZDA2ZTFkNTQxZGQNCj4gPiBvcmlnaW46IG1hZXN0cm8NCj4gPiB0
ZXN0IHN0YXJ0IHRpbWU6IDIwMjYtMTAtMTUgMTE6MDg6MjYuNTI0MDAwKzAwOjAwDQo+IA0KPiBP
a2F5LCBzbyBub3cgd2UgaGF2ZSB0ZXN0IHN0YXJ0IHRpbWUgZG93biB0byBtaWNyb3NlY29uZC4g
VXNlZnVsLCBJDQo+IGd1ZXNzPyBCdXQgd2hhdCB3ZSB3YW50ZWQgdG8ga25vdyBpcyBpZiB0aGUg
dGVzdHMgYXJlIGZpbmlzaGVkLCBhbmQNCj4gdGhpcyBkb2VzIG5vdCB0ZWxsIHVzOg0KDQpJIHRo
aW5rIHRoZSBmYWN0IHRoYXQgdGhlIGVtYWlsIHdhcyBzZW50IG1lYW5zIHRoYXQgdGhlIHRlc3Rp
bmcgd2FzIGZpbmlzaGVkPw0KQ3VycmVudGx5IHRoZSBzYW1lIHN0YXR1cyBpc24ndCBsYWJlbGxl
ZCBpbiB0aGUgZGFzaGJvYXJkOyB0aGUgS2VybmVsQ0kgdGVhbSBhcmUgbG9va2luZyBpbnRvIHRo
aXMuDQoNCj4gDQo+ID4gU2VudCBldmVyeSBkYXkgaWYgdGhlcmUgd2VyZSBjaGFuZ2VzIGluIHRo
ZSBwYXN0IDI0IGhvdXJzLg0KPiA+IExlZ2VuZDog4pyFIFBBU1MgICDinYwgRkFJTCAg4pqg77iP
IElOQ09OQ0xVU0lWRQ0KPiANCj4gPiBCdWlsZHM6CSAgICA2IOKchSAgICAwIOKdjCAgICAwIOKa
oO+4jw0KPiA+IEJvb3RzOiAJICAgIDkg4pyFICAgIDAg4p2MICAgIDAg4pqg77iPDQo+ID4gVGVz
dHM6IAkgICAxOSDinIUgICAgMSDinYwgICAgMyDimqDvuI8NCj4gDQo+IElmIHdlIHdhbnQgdG8g
ZG8gdGVzdGluZyBiZWZvcmUgcmVsZWFzZSwgd2UgbmVlZCB0byBrbm93IGlmIHRoZSB0ZXN0cw0K
PiB3ZXJlIGZpbmlzaGVkLiBXZSBjYW4gdGFrZSBhIGxvb2sgYXQgdGhlIHdlYiBwYWdlLCBubyBu
ZWVkIHRvIHNwYW0gdGhlDQo+IGxpc3QuIChCdXQgaXQgd291bGQgbm90IGJlIGJhZCBpZiAtY2lw
IHBhZ2UgY29udGFpbmVkIHJlc3VsdHMgZnJvbQ0KPiAtY2lwLXJ0LCBzbyB0aGF0IC4uLndlbGws
IHJlc3VsdHMgYXJlIG9uIHNpbmdsZSBwYWdlKS4NCg0KSSdtIGNvbmZ1c2VkLCB0aGUgLWNpcCBs
aW5rIGJlbG93IF9kb2VzXyBzaG93IHRoZSAtY2lwIGFuZCAtY2lwLXJ0IHJlc3VsdHM/DQoNCj4g
DQo+IGh0dHBzOi8vZGFzaGJvYXJkLmtlcm5lbGNpLm9yZy90cmVlP2k9NjAmdHM9LWNpcA0KPiBo
dHRwczovL2Rhc2hib2FyZC5rZXJuZWxjaS5vcmcvdHJlZT9pPTYwJnRzPS1jaXAtcnQNCj4gDQo+
IFtXaGF0IGtpbmQgb2YgdW5pY29kZSB0cmlja2VyeSBpcyB0aGVzZT8gRG8gd2UgaGF2ZSB0byBj
b21tdW5pY2F0ZSBpbg0KPiBwaWN0dXJlcyBub3c/XQ0KPiANCj4gQW55d2F5LCBwcm9wb3NlZCBz
b2x1dGlvbiBpcyB0byBhZGQgYW5vdGhlciBmaWVsZCB0byB0aGUNCj4gaHR0cHM6Ly9kYXNoYm9h
cmQua2VybmVsY2kub3JnL3RyZWU/aT02MCZ0cz0tY2lwLXJ0IHBhZ2UsIHJpZ2h0IG9mDQo+ICJU
ZXN0IHN0YXR1cyIsIGNhbGwgaXQgIkZpbmlzaGVkIiwgYW5kIGl0IHNob3VsZCBzaG93IHRydWUg
d2hlbiB0ZXN0cw0KPiBhcmUgZG9uZSwgYW5kIGZhbHNlIGlmIHRlc3RzIGFyZSBzdGlsbCBydW5u
aW5nLg0KPiANCj4gVGhhdCB3YXkgd2UgY2FuIHBhdXNlIHRoZSByZWxlYXNlIHVudGlsIHRoZSB0
ZXN0cyBhcmUgZG9uZS4NCj4gDQo+IE5vdywNCj4gaHR0cHM6Ly9kYXNoYm9hcmQua2VybmVsY2ku
b3JnL3RyZWUvY2lwL2xpbnV4LTYuMS55LWNpcC0NCj4gcnQvNDA3YjE0MDZkMmZhZDJiN2FjMjc5
ZjI4NzU3YmJkMDZlMWQ1NDFkZD9kZiU3Q3RzJTdDRkFJTD10cnVlJmk9NjAmcD10DQo+IGNvbnRh
aW5zIGZhaWxpbmcgdGVzdC4gSWYgc29tZW9uZSBmYW1pbGlhciB3aXRoIGtlcm5lbGNpIGNvdWxk
IHRlbGwgbWUNCj4gaWYgdGhleSBjb25zaWRlciB0aGlzIHRvIGJlIGtlcm5lbCBmYWlsdXJlLCB0
aGF0IHdvdWxkIGJlIGdyZWF0LiBPbiBhDQo+IHJlbGF0ZWQgbm90ZSwgYWJpbGl0eSB0byBkaXNw
bGF5IGxvZ3Mgd2l0aG91dCBkb3dubG9hZGluZyB0aGVtIHdvdWxkDQo+IGJlIHdlbGNvbWUuDQoN
CldoZW4geW91IGNsaWNrIG9uIHRoZSBmYWlsZWQgdGVzdCBjYXNlIHlvdSBjYW4gY2xpY2sgInZp
ZXcgbG9nIGV4dHJhY3QiIHRvIHNlZSB0aGUgcmVsZXZhbnQgcGFydCBvZiB0aGUgbG9ncyB3aXRo
b3V0IGRvd25sb2FkaW5nIHRoZW0uDQpJbiB0aGlzIGNhc2U6DQoNCisgLi9jeWNsaWNkZWFkbGlu
ZS5zaCAtaSAxMDAwIC1zIDUwMCAtdCAyIC1EIDU0MHMgLUkgMSAtdyBoYWNrYmVuY2ggLXggJycN
ClVzaW5nIGFsbCBDUFVTDQpbICAxNjAuMjA0NDgyXSBzY2hlZDogREwgcmVwbGVuaXNoIGxhZ2dl
ZCB0b28gbXVjaA0KVDogMCAoICA1NzQpIEk6MTAwMCBDOiA1MzU4NzggTWluOiAgIDgwMjUgQWN0
OjQxNTc0NDIgQXZnOjMwNjY3NTMgTWF4OiA0MTU3NDQyDQpUOiAxICggIDU5NykgSToxNTAwIEM6
IDM1NzQ5NSBNaW46ICAgICAgMSBBY3Q6MzgwNjI4NyBBdmc6MjkyNzMxMSBNYXg6IDM4MDY0NjYN
CnQwLW1pbi1sYXRlbmN5IHBhc3MgODAyNSB1cw0KdDAtYXZnLWxhdGVuY3kgcGFzcyAzMDY2NzUz
Ljk5IHVzDQp0MC1tYXgtbGF0ZW5jeSBwYXNzIDQxNTc0NDIgdXMNCnQxLW1pbi1sYXRlbmN5IHBh
c3MgMSB1cw0KdDEtYXZnLWxhdGVuY3kgcGFzcyAyOTI3MzExLjU3IHVzDQp0MS1tYXgtbGF0ZW5j
eSBwYXNzIDM4MDY0NjYgdXMNCmN5Y2xpY2RlYWRsaW5lIHBhc3MNCnQwLW1pbi1sYXRlbmN5IHBh
c3MgODAyNSB1cw0KdDAtYXZnLWxhdGVuY3kgcGFzcyAzMDY2NzUzLjk5IHVzDQp0MC1tYXgtbGF0
ZW5jeSBwYXNzIDQxNTc0NDIgdXMNCnQxLW1pbi1sYXRlbmN5IHBhc3MgMSB1cw0KdDEtYXZnLWxh
dGVuY3kgcGFzcyAyOTI3MzExLjU3IHVzDQp0MS1tYXgtbGF0ZW5jeSBwYXNzIDM4MDY0NjYgdXMN
CmN5Y2xpY2RlYWRsaW5lIHBhc3MNCg0KV2hpY2ggc2hvd3MgdmVyeSBsYXJnZSBsYXRlbmNpZXM7
IGhlbmNlIHRoZSB0ZXN0IHdhcyBtYXJrZWQgYXMgYSBmYWlsdXJlLg0KDQoNCktpbmQgcmVnYXJk
cywgQ2hyaXMNCg0KDQo+IA0KPiBUaGFua3MsDQo+IAkJCQkJCQkJUGF2ZWwNCg==

