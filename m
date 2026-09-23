Return-Path: <felix.moessbauer@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0A4CC982FA
	for <webhook@archiver.kernel.org>; Wed, 23 Sep 2026 11:17:28 +0000 (UTC)
Received: from OSPPR02CU001.outbound.protection.outlook.com (OSPPR02CU001.outbound.protection.outlook.com [40.107.159.47])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.4754.1790162246265235793
 for <cip-dev@lists.cip-project.org>;
 Wed, 23 Sep 2026 04:17:26 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=OevYLTF3;
 spf=pass (domain: siemens.com, ip: 40.107.159.47, mailfrom: felix.moessbauer@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wbkz/gMwSD+rkPT10N5vYi61tbix63YHq/n+JRiVpOEWuOQCxwOCbwH0mKHSy9pxTnchtZ6OkRiu9u6G26NSaR6eewOWXN1Lbg9bED7EpgBPoplj4EQNWkfJjT1y19GCLEWr5YnMbajEfpf+sOOhofvHB1eiiAfoBk1zAFzZoHkxkjEasbApP0+KJNbEAx6ORpEcud8hcn52qOFrMzlzdegQbV13pzGNxMlrjLWNWKxoREWSGlnvHHDorOWmfA48Sp2yufuTUmFpe8NdIF87STD42zjiIr8pMUF8fbeGpI/2V2nUxVs+Zl7vA5gmFuF+zyeA9hcV+TxzvF/UD+eCzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uz2IMA7wZ2rBd6XJ6NlgrF5tb8g3YpaHXoJsJrZuC2w=;
 b=SWG6Rt5M4wKGiosU53rZt6Az1fweZ+2XMEhvxSBib3r5aBySg6gIAjwLRTyFIHmy2tjDGzjTfqArn6iE47OVFIyPgqwxhIeitILtXz8Kb4JzRuuF1NU4aC4hJZmksq+GjG4lbZilSgffbm5oGOtKMd0HbC3gkwb2a3TWt0+8l/KFWWTPN0xGPKCawBtKh6UHfQDEd+kxrsOY75nuHLMTIBWjouRvKRIw7k3pasbrMMAXdhEdgvvm9vqCQVz7Wo6sOaiKqW2nU/2ZSJIwEjxsI8sLZRi7RFByhYFsnBej0VHOwTGG0OMSLzBgqD+W6k5mb1D8m+UMmYnNPnxjsxtGBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uz2IMA7wZ2rBd6XJ6NlgrF5tb8g3YpaHXoJsJrZuC2w=;
 b=OevYLTF3eAwODKP0noe4aO+1Edjbhjti8ImoPwkk3O6C8V6NZqNF77vxZfPIUGbgnh5xevbDfjXgPiWGq89Hp8wBs+ygMQuN6jyNh1xF52H0WXPtt91GTdZSHAao3gQieYxCxdS0nJ64xmqllXq64LUWzMUClcxPB3vuBadnz8R7LNMaA7SBDwjPSksOMgU4YgiX9XuMKRPWu0XDLMqVtvozL7vZkoPUi6VMYKJo+QDezFg2sh7VvWD9VC5r5TYiVhvXndRuPYZ7GAb8D3MwEasGMMInJOTf//EhcgF5vETKH8sWdsgSsJvPvJX1jQDDJ7ewkBBCGNram23iq6ziSw==
Received: from AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:17e::10)
 by DB4PR10MB6917.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3ff::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.13; Wed, 23 Sep
 2026 11:17:22 +0000
Received: from AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c54c:ccd8:ebbf:477c]) by AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c54c:ccd8:ebbf:477c%3]) with mapi id 15.21.0451.014; Wed, 23 Sep 2026
 11:17:22 +0000
From: "MOESSBAUER, Felix" <felix.moessbauer@siemens.com>
To: "Kiszka, Jan" <jan.kiszka@siemens.com>, "cip-dev@lists.cip-project.org"
	<cip-dev@lists.cip-project.org>
CC: "Shivanand.Kunijadar@toshiba-tsip.com"
	<Shivanand.Kunijadar@toshiba-tsip.com>, "kazuhiro.hayashi.f74@mail.toshiba"
	<kazuhiro.hayashi.f74@mail.toshiba>, "kumar.dinesh.h95@mail.toshiba"
	<kumar.dinesh.h95@mail.toshiba>
Subject: Re: [isar-cip-core][PATCH v2.2 2/2] Fix file timestamps are not
 reproducible for EFI certificates
Thread-Topic: [isar-cip-core][PATCH v2.2 2/2] Fix file timestamps are not
 reproducible for EFI certificates
Thread-Index: AQHdSqG5qQUWcSmo0ECdF+ur9MFV5rba4xEAgAEh34A=
Date: Wed, 23 Sep 2026 11:17:22 +0000
Message-ID: <801bf2c8dd502092cd0f9f3fd477325d8c552213.camel@siemens.com>
References: <20260922145022.167894-1-felix.moessbauer@siemens.com>
	 <20260922145022.167894-2-felix.moessbauer@siemens.com>
	 <0a6317c3-cf7f-4ba8-824f-b6e806f79d70@siemens.com>
In-Reply-To: <0a6317c3-cf7f-4ba8-824f-b6e806f79d70@siemens.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.56.2-10 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM7PR10MB3956:EE_|DB4PR10MB6917:EE_
x-ms-office365-filtering-correlation-id: a00c1813-635d-4093-0389-08df19643cff
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|10067099003|56012099006|6133799003|11063799006|4143699003|22082099003|18002099003|55112099003|38070700021;
x-microsoft-antispam-message-info: 
 SOs+/Ymv9dw57HBxjpoGnwUxLWQIoz20rNX19iGCmPywNkKYw+TLygDB/HOcbP3Mg8uho5Lo06Fa3UWLu6SXKH6+wkcxtnawIcIsXzOMz+WL5/vID6LE7EGzQdtJ1PdoeKvAdV0npXdv2oPVN+8rrRcHz0laNfpqwW3XDU2RJktmdXnTbBjEnvDfRKG77NqsFSfrSoiLEsTcg17ZvC2d7hhIFhjHbcO7BTK4jc7/f3wFV7IPcGJXkFqioD+7EDoCAZPksa/thYsQbLRvdI+zcwSGB4ytimtV55e3N+yWrU0dyCpKyFRQlACb83mJAyAnQSPlEP8gJxodI+3j7hXvqqfSo98W5/fSjQzz7JWRxPaTQNlxcEU7mvOGgjKXo1NDK5s75y4HzcS8yEuZbeX6mnTIgyBNcwZxsBEDTTNY1Mc5bTyakkb65OSvqf/RvsNcYEldsrRIN483fISMIJgQJDsTCF9v5T3P8K/UV8yZ3IkHQe3qCVr8hZoRCnzDWo6UckrTHiPbidYWxxOxA9IGpF5xYHhP/l42Ohyim+bzwHh7poh0IUJOwdO4Vxd2aC+IIbZse+NcS2oqc3Kycdmdj5G2awCvr7vx2PMPOXJke+/RKAKwZgOoUUq+ecnu0W+7S4mCv+MfpjGhx+/KE6bVHAfnKGb/8wWAKXU1EYqvaIY=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(10067099003)(56012099006)(6133799003)(11063799006)(4143699003)(22082099003)(18002099003)(55112099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?aXM1QnFxSDZLNTZVSllxY2dnTTV0NmVXRnBHYmQ4TS92REFXQy9sWXZHMDhm?=
 =?utf-8?B?RWQvbG03OTVMMjBOcjZVaTdneXRCSUZtM3FaZDV1Q1JUSFNNaHZNRW43RGsy?=
 =?utf-8?B?a3o0U2VNeUFMTElwd0p1SVdoVk9Vd0FsTWVTOHNNRHdPWEJPVVdwbVBDTHA2?=
 =?utf-8?B?UUNLVmQ2WWhxNFdtK1NVYWtublhvb1lva3JTc3pCa0VJYThjNnJhRk41bXFp?=
 =?utf-8?B?UjhjaG4vVElxMWxCc2V5RGhwMEwwejBBS1FMWVRYMUVBcXlCaE5ndHhqQzFz?=
 =?utf-8?B?L3ZVTDUxS1hlTFJ6aGhrbkgyQWNRYWhFYXVseE9YL1RJaE5aVk9QNGRKWUVj?=
 =?utf-8?B?MlZvbGVBZWtPZTFpdlcydnM3Wkh2YVBIRXJ6YjVyb3Nzb2d4R2VnZVNFVEFO?=
 =?utf-8?B?ZjJzUU55NjU2eUtoRXdZbHBmVG1DeGxIUkFTUTRmbXVKdjM1MlBOS3o4MGdR?=
 =?utf-8?B?dTJLbUF3YStWUFVWSEx3bUdhSlIzSUp5b0U3T3BZTTNhVWpweFkzdmxZSWFn?=
 =?utf-8?B?TzBEWThGUGhLOW5UWjh0VExJb1Q0MTh4UDB0bG40TkV4eXNGdThUSjNySnFR?=
 =?utf-8?B?b05lSXlENlVmQ3dkTTl5R3Z0VEdsT2lPdWpFTURvYVlRTmJpV2VmY1doUVpW?=
 =?utf-8?B?UXo4SlBEOVhiWElNSEVqdXlPeGxQYVpsclh0QW5wNUZ4Mzh5K0VMUjdoaXgw?=
 =?utf-8?B?RzliRG1nRTRDclcrQ1IrZGZldldnU3dCaFcxZkhyUlpIUmJmQTdLUEpzVlFj?=
 =?utf-8?B?NEJKcjV6RTloSGd5Qm5CNWNmSUdhbm50SkQ0a01iWVRhOG1zdnJSUVRYOTc3?=
 =?utf-8?B?T3Z0RWRTdUJIZTBsSjJqNlhQZ0V6RjFNTyttQjdKZ1lsOEdRVHl6SjJTNlky?=
 =?utf-8?B?NkNzalc4RDQ1YWJkTkN2L25HdXlUV1p4VUVqLzNXUmMwNlQwYytxSENSL0g1?=
 =?utf-8?B?d2Rjc05RWG5TMmFmNXlrVW8wSC9PSTVuejMvYTgyOU9YUXA5N2o5cGdDQnoy?=
 =?utf-8?B?Nm5yalVaNGoxUDZCZVJUWU5UcVVTK1lRNTJaUkJBQzI0QnNJN0JjNUp5WU9i?=
 =?utf-8?B?NnIzbTJBdlpvMkJjekk1OGwwc3Z4NmlwZ2ptaWZvcXJjbTg3b2hTa2tMcXcw?=
 =?utf-8?B?NnNoUk94bmljbmtOSUt0T3czREN2WWJ3Vm4wcEx1Rm5SZ0Rzb0lWUG10Z0Vy?=
 =?utf-8?B?b1h1T05Wc0JDb0hjc2szdUFqWHN6TmltZ2MrZEV4M3d2Qmd3M252MmlMZGds?=
 =?utf-8?B?MlhLcUV4aVhaVU10N2dSenRPem1lUGl0UXdHb21CWVkvWHJCU1ArOFBOS0Jn?=
 =?utf-8?B?ZTdPOUtiTDFIT3VxU1NEL0h2clorKytJaTRGUW1KeGNwSGJ3a1BDanE3RFR0?=
 =?utf-8?B?WGkwNlg3Zjh6ZWJsbzNQODBJaDhzYUl5MytCOEZHblZrMVFjZ010citCSk9O?=
 =?utf-8?B?am5FbEVYRVpVdGdqVlorckJ5WSs3Y2tSdjVHeWo5TS9IRTB6MzMzSUxlRlV0?=
 =?utf-8?B?aEVzR0ZUMXlnbnBaSlNKSjRqbDE3WVVzZDNRd1k5MitIc3NDL01KSnViaERK?=
 =?utf-8?B?UjE2bEd4YTdBMmx4Z3FhTy9KWkZzb3hndnVWRyttVzIwb2JkckJBZGZhZHRP?=
 =?utf-8?B?UkIycGgzcEI3SGFKZ053eTFjZEcxWFBDMHdGaElGT2R2ektldndCQXo4R25O?=
 =?utf-8?B?V3Q3SCtXR2hTdksxc1d4VGRGdlhxSFdCK01vYzNQbzhad1ZrYkxXWU56RVB3?=
 =?utf-8?B?cFozSHpkZWxweHU0OEZrcENSd2FvVjFKK29QbkVvR05Pb0lkVWJIa2NIVVAz?=
 =?utf-8?B?WW81RzFXUmEwNWtFcjNoK1JEbjNCSy9OTHE5WmMxU1B0eU5hN3hEdHJnSkRr?=
 =?utf-8?B?aFNJM2d4dlZlalhzT29HV3kzekFVcDhYZFp1ellyUmcvMlJTL3pPMy9BZHpW?=
 =?utf-8?B?MXFoVytJdFNSY3IzeFZXSWovc2hnT0hnVDh5czBxdk5LT2E4Yy9OWitWb1ZL?=
 =?utf-8?B?UGV4alBlVVp6c3lZNlhqYUIvMjR1RzJTMUV3enkzYUFzNXkralZwNllFbWJ0?=
 =?utf-8?B?bk9QeGZOUEtSYis3eUxva3JxcDQ0Um1MTHdTU2djVm5QcVo5Zzd2NDZOV01i?=
 =?utf-8?B?dEhnajlZUXBVS3l5c1hSL0FqdVF5N0ZOY3lwelczQWNyWU9INXVMOTFzd1NI?=
 =?utf-8?B?djN3RWQ2S1lNY2lLY2JQODFSb1dhaTU0UjRtZmFRRlBPSitsb01Obm9USlpS?=
 =?utf-8?B?ZkhmZ0ZHeUlHMldvNG1zNlgweHhQOFl5WFFVQ05FRVE0TzhJYzZXWWt1Y3Zx?=
 =?utf-8?B?Y1FXZFBLWXR2Z2hKZmVvcVNjaEZIRWNoUVJ4Q0Y4TmNEekVoOW0vQT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <11F637386EAAFD4CA5C7699D7E4293D5@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: a00c1813-635d-4093-0389-08df19643cff
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2026 11:17:22.0286
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pLW/FQwtDR7gqF6bYGXKSJ7dh87Sk/vNInkItOik+3meM67d6lJ5vglObE7w3M4KuFURkSPfQ3i7WH9jKbkkWncyHbqsUNgKx0rW67mTLU8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR10MB6917
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 23 Sep 2026 11:17:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24273

T24gVHVlLCAyMDI2LTA5LTIyIGF0IDE5OjU5ICswMjAwLCBKYW4gS2lzemthIHdyb3RlOgo+IE9u
IDIyLjA5LjI2IDE2OjUwLCBGZWxpeCBNb2Vzc2JhdWVyIHdyb3RlOgo+ID4gRnJvbTogU2hpdmFu
YW5kIEt1bmlqYWRhciA8U2hpdmFuYW5kLkt1bmlqYWRhckB0b3NoaWJhLXRzaXAuY29tPgo+ID4g
Cj4gPiBDbG9zZXMgaHR0cHM6Ly9naXRsYWIuY29tL2NpcC1wcm9qZWN0L2NpcC1jb3JlL2lzYXIt
Y2lwLWNvcmUvLS93b3JrX2l0ZW1zLzE2Mgo+ID4gCj4gPiBbRmVsaXg6IGxldCBkY2ggdGltZXN0
YW1wIGRlcGVuZCBvbiBTREUsIHBpbiB0aW1lem9uZSB0byBVVEMgd2hlbgo+ID4gc2lnbmluZywg
cGFzcyB0aW1lc3RhbXAgaW4gY29ycmVjdCBmb3JtYXQgdG8gc2lnbi1lZmktc2lnLWxpc3RdCj4g
PiAKPiA+IFNpZ25lZC1vZmYtYnk6IFNoaXZhbmFuZCBLdW5pamFkYXIgPFNoaXZhbmFuZC5LdW5p
amFkYXJAdG9zaGliYS10c2lwLmNvbT4KPiA+IFNpZ25lZC1vZmYtYnk6IEZlbGl4IE1vZXNzYmF1
ZXIgPGZlbGl4Lm1vZXNzYmF1ZXJAc2llbWVucy5jb20+Cj4gPiAtLS0KPiA+ICAuLi4vc2VjdXJl
LWJvb3QtZWZpLWNlcnRzL3NpbmdsZS1rZXktdG8tZWZpLWNlcnRzXzAuMS5iYiAgICAgICAgfCAy
ICsrCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKQo+ID4gCj4gPiBkaWZmIC0t
Z2l0IGEvcmVjaXBlcy1kZXZ0b29scy9zZWN1cmUtYm9vdC1lZmktY2VydHMvc2luZ2xlLWtleS10
by1lZmktY2VydHNfMC4xLmJiIGIvcmVjaXBlcy1kZXZ0b29scy9zZWN1cmUtYm9vdC1lZmktY2Vy
dHMvc2luZ2xlLWtleS10by1lZmktY2VydHNfMC4xLmJiCj4gPiBpbmRleCBiMTRkNmNjLi5kZmIw
ZmY5IDEwMDY0NAo+ID4gLS0tIGEvcmVjaXBlcy1kZXZ0b29scy9zZWN1cmUtYm9vdC1lZmktY2Vy
dHMvc2luZ2xlLWtleS10by1lZmktY2VydHNfMC4xLmJiCj4gPiArKysgYi9yZWNpcGVzLWRldnRv
b2xzL3NlY3VyZS1ib290LWVmaS1jZXJ0cy9zaW5nbGUta2V5LXRvLWVmaS1jZXJ0c18wLjEuYmIK
PiA+IEBAIC0yOCw2ICsyOCw4IEBAIFNFQ1VSRV9CT09UX1RJTUVTVEFNUCA9ICIke0B0aW1lLnN0
cmZ0aW1lKCclWS0lbS0lZCAlSDolTTolUycsIHRpbWUuZ210aW1lKGludChkCj4gPiAgCj4gPiAg
RFBLR19BUkNIID0gImFsbCIKPiA+ICAKPiA+ICtpbmhlcml0IHNlY3VyZS1ib290LXRpbWVzdGFt
cAo+ID4gKwo+ID4gIGRvX3ByZXBhcmVfYnVpbGQoKSB7Cj4gPiAgICAgIGJibm90ZSAiVXNlIHRp
bWVzdGFtcCAke1NFQ1VSRV9CT09UX1RJTUVTVEFNUH0gVVRDIGZvciBzaWduaW5nIEVGSSBjZXJ0
aWZpY2F0ZXMiCj4gPiAgICAgIGRlYl9kZWJpYW5pemUKPiAKPiBOb3cgd2Ugd2lsbCBoYXZlIHRo
ZSBub3RlIGlzc3VlZCB0d2ljZSwgbm8/wqAKPiAKClllcywgYnV0IGFzIHRoaXMgbWVzc2FnZSBp
cyBwcm92aWRlZCBieSB0aGUgY2xhc3MsIHRoZSBhY3R1YWwgdmFsdWVzCmNvdWxkIGJlIGRpZmZl
cmVudCAoaW4gY2FzZSBhIHJlY2lwZSBleHBsaWNpdGx5IHNldHMgdGhlIFNERSkuIEFueXdheXMs
CkknbGwganVzdCBkcm9wIHRoZSBtZXNzYWdlLgoKPiBBbHNvLCBTRUNVUkVfQk9PVF9USU1FU1RB
TVAKPiBpcyBjYWxjdWxhdGVkIHJlZHVuZGFudGx5LgoKWWVzLCBzYW1lIGFyZ3VtZW50IGFuZCBp
dCBpcyBjaGVhcC4gSSdsbCBrZWVwIGl0LgoKPiAKPiBQbGVhc2Ugc3VibWl0IGEgdjMgc2VyaWVz
IHdoaWNoIGFjdHVhbGx5IHJlcGxhY2VzIHRoZSBwYXRjaCBJIGFscmVhZHkKPiBtZXJnZWQuCgpP
ay4KCkZlbGl4Cgo+IAo+IEphbgo+IAo+IC0tIAo+IFNpZW1lbnMgQUcsIEZvdW5kYXRpb25hbCBU
ZWNobm9sb2dpZXMKPiBMaW51eCBFeHBlcnQgQ2VudGVyCg==

