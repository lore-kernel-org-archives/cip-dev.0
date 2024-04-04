Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4E83CD129C
	for <webhook@archiver.kernel.org>; Thu,  4 Apr 2024 11:42:13 +0000 (UTC)
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (EUR01-DB5-obe.outbound.protection.outlook.com [40.107.15.120])
 by mx.groups.io with SMTP id smtpd.web11.35241.1712228885957551654
 for <cip-dev@lists.cip-project.org>;
 Thu, 04 Apr 2024 04:08:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=rJ4LRnvf;
 spf=pass (domain: siemens.com, ip: 40.107.15.120, mailfrom: felix.moessbauer@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kzLGC3lpdZDONh6DJvK5fj6zNf3ocGEj701D2Gnj7LPfUWzORWgpi+VkXwx7DChhMkPrtk3leirL+yoP+jxGxBhb1gaIk0Woa+wwp+3f/8hs4ZyDx1OCn7B7ErH868XjWOSMOolPsQkRN4j30SNUhIoBjxdI7/HuXPmK/EUaFdqppo0DVYB7irM1Vu/Eo3FHigwUnEP5qVF8x9QITyRS2tYseYIcBqFHJhIwMJREw0OJvJ9gLKReN6PE46AjRRhSVubq6sm+wDjVNuc8xlLthWKaXjiefV2SIkUKqEpAhnAiQ6TjSLNu5BwhK9lsIZZKhP0Tg+77YJB9qeKM6JXS6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2mvqr6/k3HlRGMP8+nCmXTKq+/7y1qbgNI6y5P47HhA=;
 b=j6LfdNOGVp9rKNv4oGm7pfbel6RhXsKFpnHLrABFzrsFunVvcv8SW+5Tb2i78J3j5LhU3DwnH0yCI/1PH/DzNGvGUtw2A1rP4Qba2Zrli4GrYUe/CMMyFoVlb7ktMjGbsEipi6h8Da5VfKA7nv5UMFm8xfS0kyk/O8MJ5lMB8ErLAwCnV+xq6f+80bIGaYQ4aTKMqPGwX4I5WXEMPrJmFqi6KhrQZwHWFAmfPjjYTfBjcnlhXX1UDDpUTVUAFsXjNzuQaMzkxVejkyu3g9OBWMqWNrumJvh725WsR01oFD+b9MpOQhCqmYtEWI5egCGP9V/sUZQS1kOKjnc1X4wnWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2mvqr6/k3HlRGMP8+nCmXTKq+/7y1qbgNI6y5P47HhA=;
 b=rJ4LRnvf7ecHydPuJmGQe+BRxD3oxnCFhM+muKf9skJBwjgP9Wa7c4L/mY/H4TTiDU5CIR+FYC7HdnixSwy5/rBwa6ZPUns+typy5n3jEtPBefTAWBWn3cyUGaGEuLI21GRhCPoqbrr6BCLC9XNCWRoKDXhB4aojDBrmXHlthVxXQ2gNWZG45sWekdndS4QZ6KgO1cw6XbP6nsVwgVNHOBueLxR8QiyHXMuuSzzsfkaEn2CwS/Rb03q9eVGN8db7JBxTSLtdj03Uynm5BKQElc+td8xdvwzOTB46VRGDaTFib8OUrz065IDT+UVVwV2szJJeWdYgApXmTngNcap1sA==
Received: from DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:47f::13)
 by PA2PR10MB8909.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:425::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Thu, 4 Apr
 2024 11:08:02 +0000
Received: from DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::e0b3:537d:ebe2:c0a3]) by DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::e0b3:537d:ebe2:c0a3%5]) with mapi id 15.20.7409.042; Thu, 4 Apr 2024
 11:08:02 +0000
From: "MOESSBAUER, Felix" <felix.moessbauer@siemens.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"quirin.gylstorff@siemens.com" <quirin.gylstorff@siemens.com>, "Kiszka, Jan"
	<jan.kiszka@siemens.com>, "dinesh.kumar@toshiba-tsip.com"
	<dinesh.kumar@toshiba-tsip.com>, "venkata.pyla@toshiba-tsip.com"
	<venkata.pyla@toshiba-tsip.com>, "kazuhiro3.hayashi@toshiba.co.jp"
	<kazuhiro3.hayashi@toshiba.co.jp>
Subject: Re: [cip-dev][isar-cip-core][RFC v2 9/9] kas/opt/reproducible.yml: Move SOURCE_DATE_EPOCH to layer.conf
Thread-Topic: [cip-dev][isar-cip-core][RFC v2 9/9] kas/opt/reproducible.yml:
 Move SOURCE_DATE_EPOCH to layer.conf
Thread-Index: AQHahoBcONonW9AuWUyZLQceq9hhDw==
Date: Thu, 4 Apr 2024 11:08:02 +0000
Message-ID: <b0443434622bb7380151b0df5b9934f83cae58c1.camel@siemens.com>
References: <20231031084943.3105056-1-Quirin.Gylstorff@siemens.com>
	 <20231031084943.3105056-10-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20231031084943.3105056-10-Quirin.Gylstorff@siemens.com>
Accept-Language: de-DE, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.46.4-2 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR10MB6828:EE_|PA2PR10MB8909:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 KufNf4QqLAIsmA3gwTWGuWX5MEFu6RMMrhU0a8X29GHUvnAYlC5oWo1BcwE45zso83fsnUj58C9leX1otZSz7nmJPFsi3O+gZN1Ai/s2YUWcjhP8XsE5QwW92Wau+dGtbSs8Bl7i097JKyQwPtRspqqusT7CpQ6jx7nv+C7mOFGo77tzPcmGGsRey2dBHg7yGk2fBwOA3BSK1xLr9Cg/2hyKnEoJTRHc/N+75fCAUxqGv5QctVctH5yNd2YLlPsrTaibFhws3rPRHVear6pvn+W61BsxKIKNMCI/fRlwlV32utGu9REkWeAZojyz7fyIe4RXuqCC6jp1LLuXYr26jj+/gR1gqCzjn3+i6DKCD5RwqhbintcWf4GhHnAni+FsHvDajerGbBIK+oG79kxB7RsT3G03z0TAVLJrrYGXWQAfXTZW+tgOH+hhpTP8ZcUKKgqqjEKVCRVCKmWOfdGv3/p+qKdyuvUe/GVh2n6HU4A7F9+bMzNanS13DoGu9B5skrrZMxXwZbOFOVBD6uN+tWV0TZ+PCc8IVIjhn1cdOdA7etDOFAaUNMti72l4FcNGjuxIfJoAvfuLKu0p7sNgbuIa3wcnADofoOpsquW/gHQpnSWFGh/6vuv8cmPg6Dj7yJ79csk6GdT44BIn7CkAOGTid6pA9RtEzc9EJm0sZaM=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?NVhVZE5PWjNoS0RQODFXWmk3UktlVjRWVDRRSXdOaWYvMzc4VkNpa2ZmWW4z?=
 =?utf-8?B?Mnd6dGxsazB5ZHNaZFBjVFAyWDMwOWpSenRVSXZqOVFGZGtEUk1aSXhoUG9X?=
 =?utf-8?B?VVNpRVEvS2FwZmlULytVbTRzWW0wZGpwTzlNY2R5a2R1cGVVWm9LZlF1dlJt?=
 =?utf-8?B?dkYrVzBjcUtKak85NnVYeHNIVWdBZVIxc3lqYVpCY1RUT0VzRFZsNnk2UnRh?=
 =?utf-8?B?bmsybWVHeEJlTVNObFNiREREeEg5aThSbHdsSXM5WkxOZEhYMVZJaS9mNzVx?=
 =?utf-8?B?bm1pSW1PUmc2bCtkMTh3bHJ3K2lGNnlzdFdNZHZTRHNleEI1NDA3cHV5cEFR?=
 =?utf-8?B?MVppNFVYVkEwUVNPbWIvV254bFZKbSs4UHIwbkN1WE94ai9DdFVhYlRXcWsz?=
 =?utf-8?B?Rm4zdnhlQW4vUk5IcHRMdTRZRUE3NU51NVNNZmR1L1hqRzdwOWVYOEdSd3ZJ?=
 =?utf-8?B?S2ovMEJBQkJJTDJPbDZ4QXJURjlBSWtic2pXNXV1RlU5MGtSeWYwZFRveUFu?=
 =?utf-8?B?WjE0V29yUzRNNmtWSWFqZ2NySDJwRk4vRU9nSjdJNmxNQTE5bHJMTEhPcFRy?=
 =?utf-8?B?N3l4YTRYN1JQUTZORmNvSXhhVGdqak9PYUNuVjR0TWxKZEx0MGNaa0pRbmJo?=
 =?utf-8?B?dFhYOXJSNVRtYjYzSnZsN3ZFcUhFYjJjY2RuSXJ4YXlpblpSNlBxajRNU3BG?=
 =?utf-8?B?NXZhaVk0Q1hmTUdXdW14KzVMVGo0LzlBaUptU1lRY2thQ2gyRkczdElJOGR4?=
 =?utf-8?B?OGFsVlErQWh1WEZQOXFreGNTZ0FTUWx5eGhKNXR1ZHk4UzVVSWhYOS9heWhY?=
 =?utf-8?B?Nmh2cFpOQTY2Wk1mSUw3bEhDaEFuY0RDcHhQaExrUHNYNi82ZThRbVEzMmo1?=
 =?utf-8?B?OG1JcFBQZUtmRk9LYWdMK0U5d3N1QW1GWVRac1daQkEybzVzZFV1VTVtUkU1?=
 =?utf-8?B?eEZDVUE1UU9nUDNscTVqNThIa0V2bFBSOUVPVVA1TmRrc3V6bHMvdm5md3dQ?=
 =?utf-8?B?aElNS2xoRHgrYU5FakR1UUhiV0Z1T2h4U0J4TnFwdG9HYkEvZlluREhlQXpM?=
 =?utf-8?B?VGRJT3hkZkUyc3l5Wko4c0tIZWZ0dVFaZmRvLzBscFprZUlTOXJORFpkUUJ2?=
 =?utf-8?B?bHlXcVJqeEdRb2RuSzZoUmNVbHAzb3M5V3AvaGJvOU5velJJNFNxcUtmRDJS?=
 =?utf-8?B?NmNNZS96bDhRNDJXaWM3bi9DWG1wczBxZ1owTHdmVWVTTE9ZT0ZsVWZQdGZM?=
 =?utf-8?B?MHpVcnlUTWNNQURERStLWDgxd1R3ejdUV3NQNzFKMmxWN3RONHN5REZpUGI0?=
 =?utf-8?B?THd6T3diUDh6VnY1TkRHV3ptOW5BU1JsUzNUZGk2UHBBMVRUTENPTVBUL2ND?=
 =?utf-8?B?Yk5jenE0YWhBS2VYNDNMTThVbk95NGo3RGJQRVFFTFVjOUZXRVZzNitLNjY1?=
 =?utf-8?B?a21lS1pOMmQ2WWNITkFTSi9jVzhNblpicjJCcGxpcjQzanJIZlZGZ2o5OFpi?=
 =?utf-8?B?NVJhR1NNU2Q4ZGJEQXRrR0E3L2tybkplTE5YYzBnSVNKYUVBZjFCN3FibzVu?=
 =?utf-8?B?K0xCU2ZTeS81K2ZSbjNxWWptRlgzaVhOVGpHTk1Qd1hja2NvU2VydXMydWt1?=
 =?utf-8?B?SVRCbE1aRkRJYUhqalBUL0RMaTMxRlg1UUxPa01NcXFwQkEzcWRsUXU3djYx?=
 =?utf-8?B?TmtUR0JFbU16NXBKbGs4a0lzT0kvWHFNNnkzdERJRjgzUENkYnlraU1rd1dQ?=
 =?utf-8?B?WEtaNzdRdEhhbHdiZ3Z2NDgwTDdQVHZKZEl1Y0FYTFFHeHpDb2tBcHFMVDdJ?=
 =?utf-8?B?S0RxQkNaWVFuRDVaVHpKVWhHQ0htdzYxb2ZhOWZhWURyanJleVgyb3E2amhD?=
 =?utf-8?B?T3o4V3NHODJ5OGNhdUNNeWZGMUlwWHhjaHQ1dnpGbUt5eWJKOTJWUHU2cHJj?=
 =?utf-8?B?QlpJMmlPM3hydWV0QWJIOU4yVC93S29HSU1obThxWXRHZFV6QmZBS0hQbDFZ?=
 =?utf-8?B?TlV3WnVHZ3J2VC9yQjJ6ZU5pK2E0YW5nTk9BOEZuOEQ5cFNoUTJMai9KaFlG?=
 =?utf-8?B?ZndxTEVkUUFmMG5rYXVmdnZvU2FwS016bDMrS3pwOUtzeVNsUnd5SHFqb3Zy?=
 =?utf-8?B?Nk44WUFpUGZ5Y3dIQVkwaS9KUC82SW9hK2VwRnNxSG9id1JaS2QwYUp5aGQv?=
 =?utf-8?B?VkZhcThxMWRXdmVJVG1nNmZCcXNWdDRxenpYd1JiZHp5dkhhSnZwelBHUlBR?=
 =?utf-8?B?K1FUVHZoNGtGSC9HVU92UG5YWVJRPT0=?=
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b643b1a-d81c-4ac9-a416-08dc54977eab
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2024 11:08:02.1220
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x1q8YwJnN4e62aETKYbMDX9Kaba93cZpo/sLwXkjCvdMCO1xhyR0g6XLAxfGzH7VdqPXfHsSnvh/l2+e9eAzNC0FmYnnhfcQh0rzgv1fxBY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR10MB8909
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <FBF6DED78BA989459EDA87AD043675D1@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 04 Apr 2024 11:42:13 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15490

T24gVHVlLCAyMDIzLTEwLTMxIGF0IDA5OjM3ICswMTAwLCBRdWlyaW4gR3lsc3RvcmZmIHdyb3Rl
Og0KPiBGcm9tOiBRdWlyaW4gR3lsc3RvcmZmIDxxdWlyaW4uZ3lsc3RvcmZmQHNpZW1lbnMuY29t
Pg0KPiANCj4gVGhpcyBlbnN1cmVzIHRoYXQgYWxsIGltYWdlcyBhcmUgYnVpbGQgcmVwcm9kdWNp
YmxlLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogUXVpcmluIEd5bHN0b3JmZiA8cXVpcmluLmd5bHN0
b3JmZkBzaWVtZW5zLmNvbT4NCj4gLS0tDQo+IMKgY29uZi9sYXllci5jb25mwqDCoMKgwqDCoMKg
wqDCoMKgIHwgMiArKw0KPiDCoGthcy9vcHQvcmVwcm9kdWNpYmxlLnltbCB8IDEgLQ0KPiDCoDIg
ZmlsZXMgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZm
IC0tZ2l0IGEvY29uZi9sYXllci5jb25mIGIvY29uZi9sYXllci5jb25mDQo+IGluZGV4IDJjODg4
YjIuLjgyYjQwODQgMTAwNjQ0DQo+IC0tLSBhL2NvbmYvbGF5ZXIuY29uZg0KPiArKysgYi9jb25m
L2xheWVyLmNvbmYNCj4gQEAgLTI0LDMgKzI0LDUgQEAgTEFZRVJESVJfY2lwLWNvcmUgPSAiJHtM
QVlFUkRJUn0iDQo+IMKgTEFZRVJESVJfY2lwLWNvcmVbdmFyZGVwdmFsdWVdID0gImlzYXItY2lw
LWNvcmUiDQo+IMKgDQo+IMKgSU1BR0VfQ0xBU1NFUyArPSAic3F1YXNoZnMgdmVyaXR5IHN3dXBk
YXRlIg0KPiArDQo+ICtTT1VSQ0VfREFURV9FUE9DSCA6PSAiJHtAYmIucHJvY2Vzcy5ydW4oImdp
dCAtQyAke0xBWUVSRElSX2NpcC1jb3JlfQ0KDQpUaGlzIGNoYW5nZSBuZWVkcyB0byBiZSByZXZl
cnRlZCwgYXMgaXQgaXMgdG9vIGludmFzaXZlLg0KVGhlIGxheWVyLmNvbmYgaXMgcmVhZCBhZnRl
ciB0aGUgbG9jYWwgY29uZi4gQnkgdGhhdCwgdGhlcmUgaXMgbm8gd2F5DQpmb3IgYSBkb3duc3Ry
ZWFtIHVzZXIgdG8gc2V0IGl0IHRvIGEgZGlmZmVyZW50IHZhbHVlLg0KDQpJbiBmYWN0LCBhbGwg
ZG93bnN0cmVhbSBpbWFnZXMgbm93IGhhdmUgYSBTREUgYmFzZWQgb24gdGhlIGNvbW1pdCBkYXRl
DQpvZiBDSVAuDQoNCkBKYW46IHBsZWFzZSByZXZlcnQuDQoNCkZlbGl4DQoNCj4gbG9nIC0xIC0t
cHJldHR5PSVjdCB8IHRyIC1kICdcbiciKVswXX0iDQo+IGRpZmYgLS1naXQgYS9rYXMvb3B0L3Jl
cHJvZHVjaWJsZS55bWwgYi9rYXMvb3B0L3JlcHJvZHVjaWJsZS55bWwNCj4gaW5kZXggNWQ2YTg5
Ni4uYmM3MWYyOCAxMDA2NDQNCj4gLS0tIGEva2FzL29wdC9yZXByb2R1Y2libGUueW1sDQo+ICsr
KyBiL2thcy9vcHQvcmVwcm9kdWNpYmxlLnltbA0KPiBAQCAtMTMsNSArMTMsNCBAQCBoZWFkZXI6
DQo+IMKgDQo+IMKgbG9jYWxfY29uZl9oZWFkZXI6DQo+IMKgwqAgcmVwcm9kdWNpYmxlLWJ1aWxk
czogfA0KPiAtwqDCoMKgIFNPVVJDRV9EQVRFX0VQT0NIIDo9ICIke0BiYi5wcm9jZXNzLnJ1bigi
Z2l0IC1DICR7TEFZRVJESVJfY2lwLQ0KPiBjb3JlfSBsb2cgLTEgLS1wcmV0dHk9JWN0IHwgdHIg
LWQgJ1xuJyIpWzBdfSINCj4gwqDCoMKgwqAgV0lDX0RFUExPWV9QQVJUSVRJT05TID0gIjEiDQoN
Ci0tIA0KU2llbWVucyBBRywgVGVjaG5vbG9neQ0KTGludXggRXhwZXJ0IENlbnRlcg0KDQoNCg==

