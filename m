Return-Path: <felix.moessbauer@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1080AC982DE
	for <webhook@archiver.kernel.org>; Mon, 21 Sep 2026 07:37:22 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com (AS8PR04CU009.outbound.protection.outlook.com [52.101.70.55])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.44135.1789976238657556160
 for <cip-dev@lists.cip-project.org>;
 Mon, 21 Sep 2026 00:37:19 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=vXgBPEGx;
 spf=pass (domain: siemens.com, ip: 52.101.70.55, mailfrom: felix.moessbauer@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xv31a0Be8v5f25wBbt9LkygaUmYXoHb4QnHf1amL8eFN40LqBPAQsRIek0ojgJ/hLJHN6DY8pLzBN3Mp6cnjxsPLtkdM3bCdYrWFi4AE+KmmL2B+u4nzNbm6M0GRpTfoVd/8WWOSqbjfw+mLJP5oBJU6qK850gsk6GcTHR206sgDnC2V6pTQMR2VnlrT/ckmrYk3FyqgXswkahHUCsr7j51TiW9jeKbNlFv2B04D/Ppl0fhjLIdGpaTxLNhSp+MwZ2crQTJZP1M1NH58z9Yzxv9BDLhw1tNPdNNu5zkn1kY7TNTv81JVrDAEHRf70kw9h4lu55PMk+i5f/Vh9XS1gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xrJyROJTxMxmo7Qu+UPxLzjq2zU6r/O1QLkBc6V4f3k=;
 b=LbSpzMrxWr9/609rKyR134H0dRmQr98b9OmwW+ntQ076/uySi+GY7TXHPpEsDNd30BkruIutNx5co/U/HRzjdatK6USCHAzBe4DRgvKF/xBDIPYU4JL5TvLEP7LMLRW7vmWkpfi5znedUcDYRk//+zd1n5n26+WlQHHo5HnI8BZpT76D7Kpu7B6RiMY+brd6jZXKxWJlYqXDrliMhqeCdVHRp0gcUUgQWYTu9SMkp4tWhaPNRUmPX+mQ0m1+rAf4jOXjvNqf7gpzNclzPB1sGRUq4pEfv7pQYYFNr0Vmrp4BVJt4dqALSd03njukBBp6fgav9YMhMCMyCB175A85Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xrJyROJTxMxmo7Qu+UPxLzjq2zU6r/O1QLkBc6V4f3k=;
 b=vXgBPEGxUNV8sGm+2TmcYWbIoXZLmuGq4ngTzM10ko8fa+uU9wHCftlNXod/MjgK3tDEQkZk+cnPWwHj8RCL4ZiZ5dx5NZMHbiUyGzL6WynqkHJAxYZuVW5vgZz+mUVZr81N8ftbeWatzVfRDuXOHJGB01PscdRNV8tCt4rQ5y7vd5sxMfb1UXtGhWLsy+Nxghi1lM4Vxj0fUwzY9ECgb73HtS/kDuw5sE4NdwM9aAt429Q6wvsooCAuCLlcGVRcu1EK8xOobri5dAdWwPsLyQ+M6qb8fRC7XZVE/v4kxUN+PQBjaKc6c/QVzghYX/MPJD0YfzeEGw7o7B2syRqbLg==
Received: from AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:17e::10)
 by DU0PR10MB7052.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:423::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 07:37:13 +0000
Received: from AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c54c:ccd8:ebbf:477c]) by AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c54c:ccd8:ebbf:477c%3]) with mapi id 15.21.0428.015; Mon, 21 Sep 2026
 07:37:13 +0000
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
Thread-Index: AQHdR0zKDblqapHsykqKMBs5AKB3brbUKW+AgAAB+YCAAAWuAIAEUQ6AgAAnTgA=
Date: Mon, 21 Sep 2026 07:37:13 +0000
Message-ID: <1b02da51fde7d2c2e71f33473ce6c933335df8fd.camel@siemens.com>
References: <20260918085031.2464429-1-Shivanand.Kunijadar@toshiba-tsip.com>
	 <88b6f524427c6415422dc6dba589b4cafb4cd439.camel@siemens.com>
	 <868cc7cb-d990-42a9-a759-05f7cfc22e36@siemens.com>
	 <004d186545ac4db6066399ccbc21cfe43a27cd66.camel@siemens.com>
	 <37f91186-518b-400f-a3b1-c61e0207630e@siemens.com>
In-Reply-To: <37f91186-518b-400f-a3b1-c61e0207630e@siemens.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.56.2-10 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM7PR10MB3956:EE_|DU0PR10MB7052:EE_
x-ms-office365-filtering-correlation-id: 35c3f561-aac1-4111-a337-08df17b32737
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|38070700021|6133799003|10067099003|56012099006|11063799006|4143699003|18002099003|22082099003|55112099003;
x-microsoft-antispam-message-info: 
 OnXZti3dXiGAt54iYqIiHey0+wAU2vdODkLnYxalYjceURaDXCWMwxEPL7htkLLTyUmkFqZsOgCfggCzO8r+2JuKszvKVFk/hP9oJMX0tQjZy35+PwA+XMF3vv6KBmccv3f5KK6ec0CEIWY2pvtI2y5O9WW1oaTKnQHpB3yKkL6zIcO4oiQFqxBq/OKW9KN4xX5kjndl5N5mKs1qPZjnJa5js4GNytP72c8sJKjtiCC1hHCIDa3OqWxvs43l19k1OdwNk9dFde60sak2kHlYiB4TMLkrPkHce2FPrZVjWblWsMGkRsMwxWdNp/4EGlR7jysJBiQSPf/J8PEClAsyziLiEHuRCCXpsODfjPc+DNGMMDfphoLQepGA5FXDHC6SiZ2oKoCSQgDTUB4/00bYF/SRfYVR9FKfAAYJkqf0IC1tDx2QqUhZ5jKK/VDF/uwzVFpI4SinLy0b+o6PjYAjET4ODsFNDPe4Kej1tTXb/t0E1e2Rs3PUMjZBgatjMGCFwrm/kKF13NjjjGyiNvfGoPgw7E3/G/xTa8G4Ssd834MtoFA5nnq6rIWrmDzAcV1caWrFSwijMyiuC6/TRwOkYGZvyyBKJ2pEOQgSUbJlvabHZPDSogNQa+jPnj4rWxKkcpSG77Qy2T7SaXUTB3DtTqlEEUb/t+V5bivS753bea0=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(38070700021)(6133799003)(10067099003)(56012099006)(11063799006)(4143699003)(18002099003)(22082099003)(55112099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?L1A2M2tRaFN1VG9sWHN1T0hLZE9VUVNQZzRCNTRQSWR3RTdLODc0djFiWnpz?=
 =?utf-8?B?MFRQQXl1QXExdmxYNGM0Sml5dllCVXA4VW5BZVZvc0VxMjBzT1FScFVkcTJJ?=
 =?utf-8?B?NjN4K3JzVXlZYlFqY3luaXpzazdYVGlmbEd4T0FaTzhacTkwMldpUWhHOVBK?=
 =?utf-8?B?WDhBQlJuN0lqSmM3YTdJNHN4U3FocWlHakpNNitBK0xMMnhoTjZyMmttOUJ6?=
 =?utf-8?B?MkJYQ0FjdzNIZk9ITi9JR0xvYTVzOEJwejh4TTJJVTZOYWsxN1dvcnlhV1p5?=
 =?utf-8?B?NHdGcWhIZWxxbzBHNjhvT2MyVm1DaU9LUFMvck1MbldoSTZaa1MwdkFjcE1u?=
 =?utf-8?B?Um9CZExiWUlYRnl0STdmbWVDWER0T254cEcvRExOVjNHbCtCS1E0cEFwcFI1?=
 =?utf-8?B?T2x2ZHpYOFg1K3JYQVZGNlhUdkkraDNDSlZhWHc4bk5tWDh5dG9qRU54RjBh?=
 =?utf-8?B?R1E5MkdCbmtkOUpCZ3BXZ0cwaENIOXd6VVNZdk5zcTVicVRHWHhBL3ZQZ3ZN?=
 =?utf-8?B?cExLODAwUUpPQy9TNlcwSXJmWlZ5RW9vR21tcmQ2TTFndkdrSFRPYmZGUkxY?=
 =?utf-8?B?K2V6MnRybFBQVm0xQ09jbUI3aDVZR0xDR1BsOXlKbWxXMDRlUnM1a01NV1FF?=
 =?utf-8?B?dFlBbGRDb1VsbWwrNzdMNDFFMm9hdm4wT1R4VmQ3alBkNUhKeDZpRDEyQUFG?=
 =?utf-8?B?MnRyajFxc2ZXTDhjN09iTHNKMHl1Zk9MYlROYjF0YmRPT2ZudnZmbzlIc1VE?=
 =?utf-8?B?ckU5OE1wRXFTSFFNbUtVUXd6R2RESVZkZTJLYkdrR2VOUHNBSjdvVUlMNGRy?=
 =?utf-8?B?a3hoTFlTQm5XVGdZR2ZLMy9pdFI1WWNTSDlJelVmK0VyblpMWWhtd3E2cm9X?=
 =?utf-8?B?VUdyaFlSVnR5UW1ZRWwzdE9jd2pQRFZ1SllVUGZNdFZ4ckRDajJzOHlVQ0pL?=
 =?utf-8?B?dFlITTU4OWJKcWZXS3dFVGZOMUlCZTZQMkZaVGRRUEtKcjJMY1lBcTl3WFdo?=
 =?utf-8?B?S3pZa1gzNTBpbVVuMU4yVHVlMVROZHNPaFA5VWVLQ01oNzVsR09Oa1cvU0RR?=
 =?utf-8?B?TWRQdDBBM1JKcEt1bVNvV2NpcXNUWnd3R2ZhMEZlMDAzaG1Gbys2S0l4cld0?=
 =?utf-8?B?a1RLYXF0N2FKSCtIa0EyQ3lzOEdKMDMvem5YTzdDWEJaS2oyWmlsTG8vR2xJ?=
 =?utf-8?B?cy9GVE5EY0RBdVphNU9vUTY4VHIwR3QxMGhUVHlNZmp6KzQzWURoSVJ2ajNp?=
 =?utf-8?B?NnlwczllN3YvZlVieUpaZFFpVXJ0TndOeitaRTJBSzl3ckhjNEhJU1BCNkVZ?=
 =?utf-8?B?QUhxRm5mSWdTemR0ZGc5d2Y4QmdnZHNubFFlRFplQitES3dndURYVnhzVHZz?=
 =?utf-8?B?OGhkbzRDbm1hVlEyOGxCdVdPYzZEdHAxTllzcUh5M3BmSlBDcitwT0Fsbk1S?=
 =?utf-8?B?bkpXUFFZWlQ2aFNSTHl1LzhRSTJKQW5qZ0F2QzdWODRJcWVqeEpJQk1LcUJB?=
 =?utf-8?B?RUV1RXFuWEgyWUV3akNRSnFlUDNkSlg5YkFvNkExRnRROWJPZllBTWMwL2tZ?=
 =?utf-8?B?cnVFaW9RdlgyWFgwWVk5NklLZHN4M0JkTWR0OXg1TnhvZGJpdG5qT25aNFQx?=
 =?utf-8?B?WXIwRXJGT3JwV01hbHZBY2hQRzcwOWJlNEZxVWNpUGE1MWd6L2p6Wm5IeXVS?=
 =?utf-8?B?TEhZOWZ4SEV1ZnB3VCtMZUQ3clVkSDB4ZU9LdzhMajA3elNYNEFWcWhQYTBv?=
 =?utf-8?B?aElkNXZqNENpWEExZ2tqc0EwWk9LVGFoVUJ6L01XWHdiczg5djJXQVFuVnR4?=
 =?utf-8?B?amI0TXhWWk1PbHpCenYyVzJyNGc0Y2U5SjF3K0d2Yi84WWEwZ3UxSlAzZU85?=
 =?utf-8?B?VUVvR1o3aDhTUkdrV3NVTGRSSXplazh3b3NyQnZjZWZpOXhpTG1nYWROaFdJ?=
 =?utf-8?B?UEdZSHNCWXFmSnlaSkdzYlM0dHliSEZBOEJCM3o1aG8wZi95enBkZEh4R0JL?=
 =?utf-8?B?ekhrbm1sdElsL2NMSG0xNGFCczQxT1FscGJKM0RydzZ2YlNVSXp1akRxUS9P?=
 =?utf-8?B?cFZXWkFqZStZVFMraG5hK21KNjROVGhnTFZLeGRKcXExZm1YbThzb2Rnd09h?=
 =?utf-8?B?NUY5VVdRWEpjZXFCVVVmN1E0V3FOdDhJVHlwak1saTBNcytMNVVNUStobU5x?=
 =?utf-8?B?N0dhUFBGcTQrakVzNVV6K1dRQ2xwdzIzajVtMmRieGdvVVI5OG1KRDVVaWlV?=
 =?utf-8?B?TUE5WU45YzhSL1lHQ2dqRGl0ZnhpamNSMnFhc2Q5WklmSXNTRzByTytPU000?=
 =?utf-8?B?ODVpUkIzaHJjcUVBTG9UK1VDZ0d4c2YxREQxRmNlNEplNDliVjEzQT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4894B7F3F0CD8445A7106F4D50B7AA8F@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 35c3f561-aac1-4111-a337-08df17b32737
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2026 07:37:13.3885
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zPJ7wknRxJ8o7/uJFKgLCavO2wl9ci/E9804axRDz7czOgA2mRpuc7Ge9eSaBF4F9VHb5L/ZV+EFNvfVeqSL9sivseiZacmtef0gxKK+Vr0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7052
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 21 Sep 2026 07:37:22 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24250

T24gTW9uLCAyMDI2LTA5LTIxIGF0IDA3OjE2ICswMjAwLCBKYW4gS2lzemthIHdyb3RlOgo+IE9u
IDE4LjA5LjI2IDEzOjIxLCBNb2Vzc2JhdWVyLCBGZWxpeCAoRlQgUlBEIENFRCBPRVMtREUpIHdy
b3RlOgo+ID4gT24gRnJpLCAyMDI2LTA5LTE4IGF0IDEzOjAxICswMjAwLCBKYW4gS2lzemthIHdy
b3RlOgo+ID4gPiBPbiAxOC4wOS4yNiAxMjo1NCwgTW9lc3NiYXVlciwgRmVsaXggKEZUIFJQRCBD
RUQgT0VTLURFKSB3cm90ZToKPiA+ID4gPiBPbiBGcmksIDIwMjYtMDktMTggYXQgMTQ6MjAgKzA1
MzAsIEt1bmlqYWRhciBTaGl2YW5hbmQgd3JvdGU6Cj4gPiA+ID4gPiBGcm9tOiBTaGl2YW5hbmQg
S3VuaWphZGFyIDxTaGl2YW5hbmQuS3VuaWphZGFyQHRvc2hpYmEtdHNpcC5jb20+Cj4gPiA+ID4g
PiAKPiA+ID4gPiA+IENsb3NlcyBodHRwczovL2dpdGxhYi5jb20vY2lwLXByb2plY3QvY2lwLWNv
cmUvaXNhci1jaXAtY29yZS8tL3dvcmtfaXRlbXMvMTYyCj4gPiA+ID4gPiAKPiA+ID4gPiA+IFNp
Z25lZC1vZmYtYnk6IFNoaXZhbmFuZCBLdW5pamFkYXIgPFNoaXZhbmFuZC5LdW5pamFkYXJAdG9z
aGliYS10c2lwLmNvbT4KPiA+ID4gPiA+IC0tLQo+ID4gPiA+ID4gIC4uLi9zZWN1cmUtYm9vdC1l
ZmktY2VydHMvc2luZ2xlLWtleS10by1lZmktY2VydHNfMC4xLmJiICB8IDggKysrKysrKy0KPiA+
ID4gPiA+ICAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCj4g
PiA+ID4gPiAKPiA+ID4gPiA+IGRpZmYgLS1naXQgYS9yZWNpcGVzLWRldnRvb2xzL3NlY3VyZS1i
b290LWVmaS1jZXJ0cy9zaW5nbGUta2V5LXRvLWVmaS1jZXJ0c18wLjEuYmIgYi9yZWNpcGVzLWRl
dnRvb2xzL3NlY3VyZS1ib290LWVmaS1jZXJ0cy9zaW5nbGUta2V5LXRvLWVmaS1jZXJ0c18wLjEu
YmIKPiA+ID4gPiA+IGluZGV4IDI2M2Y3OTQuLjZhNTM1N2QgMTAwNjQ0Cj4gPiA+ID4gPiAtLS0g
YS9yZWNpcGVzLWRldnRvb2xzL3NlY3VyZS1ib290LWVmaS1jZXJ0cy9zaW5nbGUta2V5LXRvLWVm
aS1jZXJ0c18wLjEuYmIKPiA+ID4gPiA+ICsrKyBiL3JlY2lwZXMtZGV2dG9vbHMvc2VjdXJlLWJv
b3QtZWZpLWNlcnRzL3NpbmdsZS1rZXktdG8tZWZpLWNlcnRzXzAuMS5iYgo+ID4gPiA+ID4gQEAg
LTI0LDYgKzI0LDEyIEBAIERQS0dfQVJDSCA9ICJhbGwiCj4gPiA+ID4gPiAgCj4gPiA+ID4gPiAg
ZG9fcHJlcGFyZV9idWlsZCgpIHsKPiA+ID4gPiA+ICAgICAgZGViX2RlYmlhbml6ZQo+ID4gPiA+
ID4gKyAgICBpZiBbIC1uICIke1NPVVJDRV9EQVRFX0VQT0NIfSIgXTsgdGhlbgo+ID4gPiA+IAo+
ID4gPiA+IEdvb2QgY2F0Y2ghIFRoYW5rcyBmb3IgZGVidWdnaW5nIHRoaXMuIFBsZWFzZSBqdXN0
IHVzZQo+ID4gPiA+IERFQklBTl9DSEFOR0VMT0dfVElNRVNUQU1QIGluc3RlYWQgb2YgdGhlIFNE
RS4gVGhpcyB2YXJpYWJsZSBpcyBhbHdheXMKPiA+ID4gPiBhdmFpbGFibGUgYW5kIGFsaWducyB0
aGUgdGltZXN0YW1wIG9mIFNCIHBhcnRzIHdpdGggdGhlIG9uZSBmcm9tIHRoZQo+ID4gPiA+IGNo
YW5nZWxvZy4KPiA+ID4gPiAKPiA+ID4gCj4gPiA+IEFuZCBzaW1wbGVyIGNvZGUgLSBldmVuIGJl
dHRlci4KPiA+ID4gCj4gPiA+IFRoYW5rcyBmb3IgZGVidWdnaW5nIG15IGJ1ZyEgOikKPiA+IAo+
ID4gV2hpbGUgdGhpbmtpbmcgYWJvdXQgaXQsIEknbSB3b25kZXJpbmcgaWYgdGhlIHRpbWVzdGFt
cCBhY3R1YWxseSBoYXMKPiA+IHNlY3VyaXR5IHJlbGV2YW5jZSAoZS5nLiBmb3IgY2hlY2tpbmcg
dGhlIGZyZXNobmVzcyBvZiB0aGUgREIpLiBJIGtub3cKPiA+IHRoYXQgdGltZXN0YW1wcyBpbiBn
ZW5lcmFsIGFyZSBwb2ludGxlc3MgaW4gdGhpcyBjb250ZXh0LCBidXQgSSdtCj4gPiB3b25kZXJp
bmcgd2h5IGl0IGNhbiBiZSBzZXQgaW4gdGhlIGZpcnN0IHBsYWNlLgo+ID4gCj4gPiBUaGUgREVC
SUFOX0NIQU5HRUxPR19USU1FU1RBTVAgdXN1YWxseSBpcyBzZXQgdG8gMWggYWZ0ZXIgdW5peCBl
cG9jaAo+ID4gKGZvciB0ZWNobmljYWwgcmVhc29ucyAwIGNhbm5vdCBiZSB1c2VkIGFzIHRoaXMg
aXMgIm1hZ2ljIikuCj4gPiAKPiA+IElmIHdlIG5lZWQgYSBwcm9wZXIgdGltZXN0YW1wIGhlcmUs
IHdlIHNob3VsZCBwcm92aWRlIGEgd2F5IHRvIHNldCB0aGUKPiA+IERFQklBTl9DSEFOR0VMT0df
VElNRVNUQU1QIGp1c3QgZm9yIHRoYXQgcGFja2FnZSAoZS5nLiBieSBpbnRyb2R1Y2luZyBhCj4g
PiB2YXJpYWJsZSkuCj4gPiAKPiA+IEJ1dCBzdGlsbCwgdGhlIGNvZGUgc2hvdWxkIHVzZSBERUJJ
QU5fQ0hBTkdFTE9HX1RJTUVTVEFNUCB0byBhbGlnbiB0aGUKPiA+IGNoYW5nZWxvZyB0aW1lc3Rh
bXAgd2l0aCB0aGUgU0Igb25lLgo+ID4gCj4gCj4gVGhpcyBoYXMgc2VjdXJpdHkgaW1wbGljYXRp
b24gYmVjYXVzZSB0aGUgdGltZXN0YW1waW5nIG9mIHRoZSBzaWduYXR1cmUKPiBtYXkgYmUgY29t
cGFyZWQgdG8gdGhlIHJldm9jYXRpb24gdGltZSBpbiBjYXNlIHRoZSBzaWduZXIncyBjZXJ0IGlz
Cj4gcmV2b2tlZC4gU2lnbmF0dXJlcyB0aGF0IGhhcHBlbmVkIGJlZm9yZSB0aGUgcmV2b2NhdGlv
biB0aW1lIHdpbGwgdGhlbgo+IHN0aWxsIGJlIGFjY2VwdGVkLCB0aG9zZSBhZnRlcndhcmRzIHdv
bid0LiBUaGVyZWZvcmUsIHRoaXMgdGltZXN0YW1wIG1heQo+IGhhdmUgdG8gcmVmbGVjdCB0aGUg
YWN0dWFsIHNpZ25hdHVyZSB0aW1lLiBBbmQgdGhpcyBpcyBvYnZpb3VzbHkKPiBjb21wbGljYXRp
bmcgcmVwcm9kdWNpYmlsaXR5LgoKVGhpcyBpcyBub3QganVzdCBjb21wbGljYXRpbmcgcmVwcm9k
dWNpYmlsaXR5LCBidXQgaXMgaW4gZ2VuZXJhbApwcm9ibGVtYXRpYzoKClRoZSBwYWNrYWdlcyB3
ZSBnZW5lcmF0ZSBtdXN0IGF0IGxlYXN0IGJlICJsb2dpY2FsbHkgcmVwcm9kdWNpYmxlIiBpLmUu
CnRoZSBiZWhhdmlvciBtdXN0IG5vdCBjaGFuZ2UgYWNyb3NzIGJ1aWxkcyAtIHdoaWNoIGl0IGNs
ZWFybHkgZG9lcyBpbgp0aGlzIGNhc2UuIE90aGVyd2lzZSB0aGlzIHBhY2thZ2UgbXVzdCBiZSBl
eGNsdWRlZCBmcm9tIHNzdGF0ZSBjYWNoaW5nLAp3aGljaCBhbHNvIG1lYW5zIGFsbCBkb3duc3Ry
ZWFtIHRhc2tzIGNhbm5vdCBiZSBjYWNoZWQgKHVudGlsIHdlIGhhdmUKaGFzaCBlcXVpdmFsZW5j
ZSBzdXBwb3J0LCB3aGljaCB0aGVuIHBhcnRpYWxseSBoZWFscyB0aGlzKS4KCj4gCj4gSSB3b3Vs
ZCB2b3RlIGZvciBtYWtpbmcgdGhpcyBwYWNrYWdlIChhbmQgcG9zc2libHkgc2ltaWxhciBvbmVz
KQo+IHJlcHJvZHVjaWJsZSB0byBiZWNvbWUgYW4gb3B0LWluIGZlYXR1cmUgdGhhdCB3ZSBlbmFi
bGUgb25seSBmb3IgdGhlCj4gcmVsYXRlZCB0ZXN0LiBPciBvbmx5IGZvciBzbmFrZW9pbCBrZXlz
LiBNYXliZSB0aGUgbGF0dGVyIGlzIHNpbXBsZXN0LgoKTm8uIFBsZWFzZSBqdXN0IGFkZCB2YXJp
YWJsZXMgd2hpY2ggY2FuIGJlIHNldCBmcm9tIGxvY2FsLmNvbmYgdG8gcGluCnRoZSBERUJJQU5f
Q0hBTkdFTE9HX1RJTUVTVEFNUCBvZiBleGFjdGx5IHRoZXNlIHBhY2thZ2VzIHRvIGEgdXNlcgpj
aG9zZW4gdGltZXN0YW1wLiBVcGRhdGVzIG9mIHRoZSB0aW1lc3RhbXAgbXVzdCBiZSBleHBsaWNp
dC4gVGhpcwptZWFucywgd2UgYXJlIHN0aWxsIDEwMCUgcmVwcm9kdWNpYmxlIGFuZCBwZXJmZWN0
bHkgY2FjaGFibGUgdW50aWwgdGhpcwp2YWx1ZSBpcyBleHBsaWNpdGx5IGNoYW5nZWQgYnkgdGhl
IHVzZXIuCgpUaGlzIG9mIGNvdXJzZSBhbHNvIG5lZWRzIHRvIGJlIGRvY3VtZW50ZWQuCgpGZWxp
eAoKPiAKPiBKYW4KPiAKPiAtLSAKPiBTaWVtZW5zIEFHLCBGb3VuZGF0aW9uYWwgVGVjaG5vbG9n
aWVzCj4gTGludXggRXhwZXJ0IENlbnRlcgo=

