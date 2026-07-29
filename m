Return-Path: <felix.moessbauer@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB7FAC54F51
	for <webhook@archiver.kernel.org>; Wed, 29 Jul 2026 11:38:02 +0000 (UTC)
Received: from GVXPR05CU001.outbound.protection.outlook.com (GVXPR05CU001.outbound.protection.outlook.com [52.101.83.34])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.9369.1785325078321634845
 for <cip-dev@lists.cip-project.org>;
 Wed, 29 Jul 2026 04:37:58 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=gB6QtqTN;
 spf=pass (domain: siemens.com, ip: 52.101.83.34, mailfrom: felix.moessbauer@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DfubshPBip84ZpA4dwUicg7605JAo7aRY9f54hmxVj1NEmvhosMW8/TONItN58p/+z6WSqQ6Nt9MSBtV2jpOk50BXA7bmJEq42cXk/kSOjhZWBiTwcLVBu/rVDhwXjPfnzSJbkhb1vEUN5tSULHphouhv3Cp1/JY6/B6rPvPX4EUW6GMWKDyQSI012glD083kXyCxIIkCKHlyNaN+5oGuRzFrthcAtTu9qSibgRqS1+V5HhzpNAkrELN78Lt65COa4l1M5wbaPHK4RZ2b5bO1RL2wHtBbBPoQgqp3fgW9X/hxgaj/mnH4obDgNa+rMQj1c+KlcsI/SwkSCeETDykWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dX5f81Jcr13iSEHkwHFpUF1opxdXB1a88UTkz9InQAY=;
 b=mIIyx8zAUfv4nStC8rw9NJjiKLvVnQFJR6D2cRDu6QM2kXrFao6pOWjHM3AORr+wx8eFWqL1nMTLzlqyGApfGLkCd5KopWdIKDu5I7hT80fVgwCVBBmYuYULNL5IhkIxlXXE4LqnVS+yac2lZNvH38EarBWmM+Gx9VTWTw+ab8E+n7/UBVZpR6nZcEifAL7/Dw3yWwU15bLvDwBMHryoawnunWmm6MFQXN5k9B4x32mZxRriVlqLKHrM0MTiR07DA9rqb4Fkdcz1WWXmFN82RA6v5n1F4h3Ls9KXppqW4YWWMYzh+ereaYQqUOSSTe0OcyrskGX2VePIWuXplTe9Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dX5f81Jcr13iSEHkwHFpUF1opxdXB1a88UTkz9InQAY=;
 b=gB6QtqTN6Nw/Sj5eTyAAuohAfmEeFL01OsDLq70RfI/eN7WxhzalDB8KgegBQ0m88GhH1NL1wDLxJQA5HfPsaKmjLaHg+BY45jL35VOQ/xUIJHHqxyqZnbJsj1C17arSUjCCt4ROL91TQO3k5JI8QjB8m/AiAJCNOQuWQEQdv8WZnPpefvLzQM37cZS1zpeRVtvQCbu7hjujHSsFegufZI++JBZBueSrEsSz+twAQlhGxreBMhTcJ6NbLQbVD1mZi26YMgpnQAnJodkbx8jm+ms+p34iqUuDJjzWPYT08aLZAd1BR27DS3uxGqxnLsolWSu/YQyIMkJxq9PPrpAEcA==
Received: from AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:17e::10)
 by AS2PR10MB7251.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:608::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Wed, 29 Jul
 2026 11:37:53 +0000
Received: from AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c54c:ccd8:ebbf:477c]) by AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c54c:ccd8:ebbf:477c%5]) with mapi id 15.21.0245.012; Wed, 29 Jul 2026
 11:37:53 +0000
From: "MOESSBAUER, Felix" <felix.moessbauer@siemens.com>
To: "Kiszka, Jan" <jan.kiszka@siemens.com>, "Gylstorff, Quirin"
	<quirin.gylstorff@siemens.com>, "cip-dev@lists.cip-project.org"
	<cip-dev@lists.cip-project.org>
Subject: Re: [cip-dev][isar-cip-core][PATCH v2 5/5] update README.md for
 rootless build
Thread-Topic: [cip-dev][isar-cip-core][PATCH v2 5/5] update README.md for
 rootless build
Thread-Index: AQHdHpLLQF0MeBHR3Ueh4sGdLPqLJLaDDZUAgAAB9ICAABcdgIABOZUA
Date: Wed, 29 Jul 2026 11:37:53 +0000
Message-ID: <ac934863e6483d4dfbcff9a859ee872fc5d20e0d.camel@siemens.com>
References: <20260728131231.117214-1-quirin.gylstorff@siemens.com>
	 <20260728131231.117214-6-quirin.gylstorff@siemens.com>
	 <a4b6fda7-15ee-4351-9714-d700cc171504@siemens.com>
	 <b88cc355-446e-4190-9b82-b74bcd2b747f@siemens.com>
	 <88d3cbf0-eaa7-4ca7-bc7d-5b4b4ec9ce35@siemens.com>
In-Reply-To: <88d3cbf0-eaa7-4ca7-bc7d-5b4b4ec9ce35@siemens.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.56.2-10 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM7PR10MB3956:EE_|AS2PR10MB7251:EE_
x-ms-office365-filtering-correlation-id: 5ebe87bf-e0cf-4ffc-bc33-08deed65d3a6
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|6133799003|55112099003|18002099003|22082099003|38070700021|11063799006|56012099006|4143699003|10067099003;
x-microsoft-antispam-message-info: 
 upKN0wrLtDD3g7y2b4WRYY6quSeRXMA/BRkpKIUrUdHoe+aJsnTibJSBhn6+XChMMQDVUDvatUagFnBoTsrPOpe9rpEYMwlRKaEjYeBPrqpe4AhLChS41mh0MXwKkaYRYrjp+IP949cJhXEViUSYFsd/FNVCkMaVwRKkc0CrF1PokbD3k7ScBuk2cPOTXVxLqRd9cBTc4LsPrtwKzrpKhvvpj4Iqg5UJrAeo+J1zeoK35Nc37SLTkUVrLR4cDlxPc6vsouuIret1IBnLk0j5azGBLZ+lzspzGCp5jSBPDfqTRh+M6bYsof1vYcNK4835BaopMQI5Q7bd7aHRCZVFYnQsHZnH5evLMdZI1fXSpHVCvBn3sixKCkTavYlMOaGxyMbdyFAP4tudG7ULWai90dJWHx7zyaUMWR3IPupz+tm6QSeFwlVqsdgP6q/VZPUAttz8UnLU0chPVdtUkQevzTHAf3cXWzlP5BqmGmN7Zl1yAz+8Iy35z44viiU2I9DfmyrNRVnDRAI2hjtlHEI2BU0tEQlN/zhPMSZTBXVN1eYN+yGJSI9V7SWpyC23q7fj+tPdXgNLEulAKRFh6EbzdnpI4adcaA5Jh1Pvt6i/pUleP/S1dKl0yvFkZo1PAd6aA0J0zM3kfPrwpEtnHI9zs2YZLarw0KkEEQl9rfOmCtiJIi8THdNHT0AS+AtpAjj0bndZVtz4xoTZSlWrh1WjTyzdB4ewJEApbSaoaCczhJA=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(6133799003)(55112099003)(18002099003)(22082099003)(38070700021)(11063799006)(56012099006)(4143699003)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?VVZXUmIvU2h6amgvVFgxMkdqVVI0MGt4clIweXd2dEVtRTBXdjBKWDNnWnR2?=
 =?utf-8?B?NXJieGpTMWVaN2piaHplVy9CKzBJZmIyYUYrMkdZcGZMMEJNc3dKUnVLR0Zn?=
 =?utf-8?B?alYyLzhsakRPTnpaa3BCZUxzdDdldVpEUDErMDVqbFJQVU4wcGVxekFzajRi?=
 =?utf-8?B?VW03OGphOVZuVzM5aHgvRjVPeEJCc2VnV0FoWHJ5SjBCenBrZElnejljSDZW?=
 =?utf-8?B?NEpRS1NGVGpVK1Y4NlBaSHBmaVF0cmRZK21PQ1BKNG01ZXg0TWJkMGVBQzc3?=
 =?utf-8?B?L1JmYm9qK0V1VXduS29idFZHaHZuZTF2YzlaaWl5Rmo4cG9MR2hPOEZGR3ho?=
 =?utf-8?B?TEdlREZxS01Kbm1KNDlMajB0c2ZlNEZjdmdGTDNkTVR3M0VFRURMOUdBSWsv?=
 =?utf-8?B?czdMYzVzbjlKV3VuNmFQS3lIYXpnclRITTROOGg4WUZuR2tVRHI2Q0Vjbmk5?=
 =?utf-8?B?VGVGRFNLUnZPaUFtQWxXenJUSVNqOGhuZ25HTVUyN2Z4blB1Sm55N0pkYS9s?=
 =?utf-8?B?R0RJT1ovQzAveG5IRnFyUkV5YjEvWkFhcU9LY25nYmlPOG1zUnM3Q0YyZUFx?=
 =?utf-8?B?RVZiYURFVityQ1Zpd0o3RjZwU1FabkFNNGZNaWc5cThOeGNyV1FkcmdsWit0?=
 =?utf-8?B?KzRDRng0cHdGSlFqbEtRYyt3S003dGdoOTBDaU1uOUFFNGt3YTlSSlcvcEVS?=
 =?utf-8?B?ZGtyZjVDUXNGc0EweTY5VzhRWGFZMjZ5UGdzY3luS0dZT1cvZmxhWnp5eUtt?=
 =?utf-8?B?bEZ2dGRVQUNHY2J0QUhiSHZDVVBaSlMrc2Fzb0wvOE9PT2ZIbU0zTXFDQUZ0?=
 =?utf-8?B?NmpRQ2RPS1JpSENqdDRpdUlKM01vcHRTY1NpY21rQ1U3bGwxalJ1YzZidWp4?=
 =?utf-8?B?RUtKWHVib2FUdmd3cWk5d1ZOV2VJUXdEVE11ajZqRXA4UjRweDJmUUFQRHBa?=
 =?utf-8?B?R2REYlV3ZG5aVnpDemFDZDAvT3VzU0xDTCs0OXI4WXNBRTVDcGc4SzArQUN4?=
 =?utf-8?B?eFArcUxEQUliTEdUYVFHYk1jSjJFYi84MHh1WWVEYy9IaVprdnF2VVBMSkY1?=
 =?utf-8?B?aDBkVFJsZGVGVjdvUGF3RW91ZU1GR0xEdGphTWxvMktldkprWk42SG1vY0Zv?=
 =?utf-8?B?dVVwTVhCcmlLaWNvUXVOODR0VHBvc2c2ZHhZK0JoczNpYUNZREhSU0ZhNUxo?=
 =?utf-8?B?anc2bXArSnVOMlAvZGxHVTNyM1E3QlVaZUdHM05saE5iZVMyQ3FIZk91dlpw?=
 =?utf-8?B?YldoN0djRWVOOVVXN0pvQnlzTDlzbDNld0VDTXJ0QWxKSlNVYXU4R251M2Vq?=
 =?utf-8?B?NGtNaHNUaXVieWZIM2s4NVhsaHhjZDNaQmR6cXJZZXY2WC9hNFVIN2Y4d25I?=
 =?utf-8?B?ZEVqYnpla1dEUXhqWis3dWlNSkwrNXF2cDEyOUhXRldncjJsWEJNZG1xK0xX?=
 =?utf-8?B?V3dmcG1BSGE4c1dHK2J6VjZZUjFybnFRaDdQN1YxQVh4V0k4TS9HVDBFcnQ2?=
 =?utf-8?B?OTA2MDlTMjhXRFl0ajcwMFJHMlQyVzhMNTB2bkY3YWhQcytkeG1iakNMNnh3?=
 =?utf-8?B?L2Yva3ZNc0NobVdRUFNxdStRNXF6U09FTENqOXI5WlRRRWMrQnV2NlduN3dB?=
 =?utf-8?B?RFphbFFIVS9BSElHQUNUemV1RHQ4NFVjMUZCQWlxeFZMbysxeHNVSnZzQVdN?=
 =?utf-8?B?RVYvNmVOTXdiSmYycEw5NnEvQ24vNCt1ZVY0TC9IbStFMHZNR2FDdHE2VjVi?=
 =?utf-8?B?NllwTW5jaWJzTDBiZERHWW4xSjhPdVlqejlHQ1JmWmZjalR3OXRBYkRIWlRm?=
 =?utf-8?B?UC92K2MxRnVRbFRQUXFOMzBPNUNYVGtNc01ITHk5ZmtsY2R6dXgxWVNjTEZo?=
 =?utf-8?B?ZG1Xa1MrZUtGOWlWN1E5NWtwU01LNzMyOWJTa3grQXRVWEl1QStCVVY1V0hB?=
 =?utf-8?B?MkVaSGYwejRrbHZyRmgrWmRNYzJFNklDTFR4Q1EyanFzUHpEekc4bjRSRE1k?=
 =?utf-8?B?N0ZoMEU0WTNOb1BmeDM0cXBlMWJZdFV5VkJoQjRuZXdORTFmR1R1S08wdFJC?=
 =?utf-8?B?M05rK2Q2dWtpRy9DcmtMS3U2OVhnVitQWklmcU94d0UxckZkVS9RbVJGdnU2?=
 =?utf-8?B?SFovR2NZeU40ZjFPRFUwUkhQanMwL3k3cUNITVF3QWlhdUdZY1pCRmlkSENT?=
 =?utf-8?B?d04wRUxkNWJhMUNQVk5KcXNIQmRIOEtleWZSTmxyYjE0UFpTbjdwTUI3RVpR?=
 =?utf-8?B?a3RHaVVpZ3FaM3VhaG1HTVowdDlvRFgvbnRnQW1JckdXb2dJb0FvQVIzL0pF?=
 =?utf-8?B?dVpBT01nallQbWgrZWs1Q05UWGNYbXZYcTJsTElDMm83bFZyN09mdz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <810E79E0F7AA064582919B3BB4C461DB@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ebe87bf-e0cf-4ffc-bc33-08deed65d3a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2026 11:37:53.1432
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YByE5tPEVOl7P5tN1aklY+u3KHNaFId7IS0l7FJkgyQ6jkLpQbskAM76/MPFOEi7+ywjnQ9QjU+72Yi7jCsX3p7TFdj445I2qSyzTnS0pc0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7251
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 29 Jul 2026 11:38:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23813

T24gVHVlLCAyMDI2LTA3LTI4IGF0IDE4OjU1ICswMjAwLCBKYW4gS2lzemthIHdyb3RlOgo+IE9u
IDI4LjA3LjI2IDE3OjMyLCBRdWlyaW4gR3lsc3RvcmZmIHdyb3RlOgo+ID4gCj4gPiAKPiA+IE9u
IDcvMjgvMjYgNToyNSBQTSwgSmFuIEtpc3prYSB3cm90ZToKPiA+ID4gT24gMjguMDcuMjYgMTU6
MTIsIFF1aXJpbiBHeWxzdG9yZmYgd3JvdGU6Cj4gPiA+ID4gU2lnbmVkLW9mZi1ieTogUXVpcmlu
IEd5bHN0b3JmZiA8cXVpcmluLmd5bHN0b3JmZkBzaWVtZW5zLmNvbT4KPiA+ID4gPiAtLS0KPiA+
ID4gPiDCoCBSRUFETUUubWQgfCA4ICsrKystLS0tCj4gPiA+ID4gwqAgMSBmaWxlIGNoYW5nZWQs
IDQgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkKPiA+ID4gPiAKPiA+ID4gPiBkaWZmIC0t
Z2l0IGEvUkVBRE1FLm1kIGIvUkVBRE1FLm1kCj4gPiA+ID4gaW5kZXggNDM1ZDAzNy4uZGYxNTY0
ZiAxMDA2NDQKPiA+ID4gPiAtLS0gYS9SRUFETUUubWQKPiA+ID4gPiArKysgYi9SRUFETUUubWQK
PiA+ID4gPiBAQCAtMTAsMTAgKzEwLDEwIEBAIGZyb20gc2NyYXRjaC4KPiA+ID4gPiDCoCDCoCAj
IyBCdWlsZGluZyBUYXJnZXQgSW1hZ2VzCj4gPiA+ID4gwqAgLUluc3RhbGwgZG9ja2VyIG9yIHBv
ZG1hbiBhbmQgbWFrZSBzdXJlIHlvdSBoYXZlIHJlcXVpcmVkCj4gPiA+ID4gcGVybWlzc2lvbnMg
dG8gc3RhcnQKPiA+ID4gPiAtcHJpdmlsZWdlZCBjb250YWluZXJzLiBGb3IgZG9ja2VyLCB5b3Ug
bmVlZCB0byBiZSBwYXJ0IG9mIHJlc3BlY3RpdmUKPiA+ID4gPiBkb2NrZXIKPiA+ID4gPiAtZ3Jv
dXAgKGBzdWRvIHVzZXJtb2QgLWFHIGRvY2tlciA8VVNFUj5gKS4gUHJpdmlsZWdlZCBwb2RtYW4g
cmVxdWlyZXMKPiA+ID4gPiBzdWRvCj4gPiA+ID4gLXJpZ2h0cyBmb3IgdGhlIGNhbGxlciAoYDxV
U0VSPiBBTEw9KHJvb3QpIFNFVEVOVjogL3Vzci9iaW4vcG9kbWFuYAo+ID4gPiA+IGluIHN1ZG9l
cnMpLgo+ID4gPiA+ICtJbnN0YWxsIGRvY2tlciBvciBwb2RtYW4uIEZvciBkb2NrZXIsIHlvdSBu
ZWVkIHRvIGJlIHBhcnQgb2YKPiA+ID4gPiByZXNwZWN0aXZlIGRvY2tlcgo+ID4gPiA+ICtncm91
cCAoYHN1ZG8gdXNlcm1vZCAtYUcgZG9ja2VyIDxVU0VSPmApLiBUaGUgYnVpbGQgcmVxdWlyZXMg
RGViaWFuCj4gPiA+ID4gQnVsbHNleWUKPiA+ID4gCj4gPiA+IC4uLmFuZCBkb2NrZXIgd2lsbCBp
bmhlcmVudGx5IHJlbWFpbiBub3QgZnVsbHkgcm9vdGxlc3MgKGR1ZSB0byBpdHMKPiA+ID4gZGFl
bW9uIGNvbmNlcHQpLiBUaGVyZWZvcmUsIHdlIHNob3VsZCBzdHJvbmdseSByZWNvbW1lbmQgcG9k
bWFuIGhlcmUuCj4gPiA+IAo+ID4gPiA+ICsoa2VybmVsIHZlcnNpb24gPj0gNS4xMC4xKSBvciBu
ZXdlciB0byBzdXBwb3J0IHVzZXIgbmFtZXNwYWNlcyBmb3IKPiA+ID4gPiByb290bGVzcyBidWls
ZHMuCj4gPiA+IAo+ID4gPiBXZSBuZWVkIG11Y2ggZnJlc2hlciBzeXN0ZW1zLCBhbHJlYWR5IGtl
cm5lbCB+Ni43IGZvciBiaW5mbXRfbWlzYwo+ID4gPiBuYW1lc3BhY2VzLCBhdCBsZWFzdCB3aGVu
IGNyb3NzLWJ1aWxkaW5nLiBQcmFjdGljYWxseSwgSSBkbyBub3Qgd2FudCB0bwo+ID4gPiBkZWJ1
ZyBBTlkgcm9vdGxlc3MgYnVpbGQgb24gYW55dGhpbmcgb2xkZXIgdGhhbiB0cml4aWUuCj4gPiA+
IAo+ID4gUHJvcG9zYWw6Cj4gPiBgYGAKPiA+IEluc3RhbGwgZG9ja2VyIG9yIHBvZG1hbi4gRm9y
IGRvY2tlciwgeW91IG5lZWQgdG8gYmUgcGFydCBvZiByZXNwZWN0aXZlCj4gPiBkb2NrZXIKPiA+
IGdyb3VwIChgc3VkbyB1c2VybW9kIC1hRyBkb2NrZXIgPFVTRVI+YCkgYXMgaXNhci1jaXAtY29y
ZSB1c2VzIGlzYXItCj4gPiByb290bGVzcyBhbmQgZHVlCj4gPiB0byBpdHMgZGFlbW9uIGNvbmNl
cHQgZG9ja2VyIGNhbm5vdCBiZSBmdWxseSByb290bGVzcyBpdCBpcyByZWNvbW1lbmVkZWQKPiA+
IHRvIHVzZSBwb2RtYW4uIFRoZSBidWlsZCByZXF1aXJlcyBEZWJpYW4gVHJpeGllIChrZXJuZWwg
dmVyc2lvbiA+PSA2LjcpCj4gPiBvciBuZXdlciB0byBzdXBwb3J0IHVzZXIgYW5kIGJpbmZtdCBu
YW1lc3BhY2VzIGZvciByb290bGVzcyBidWlsZHMuCj4gPiBgYGAKPiA+IAo+IAo+IEknbSB1c2lu
ZyBub3cgdGhpczoKPiAKPiBJbnN0YWxsIGRvY2tlciBvciBwb2RtYW4uIEZvciB0cnVlIHVucHJp
dmlsZWdlZCBidWlsZHMsIHBvZG1hbiBpcyByZWNvbW1lbmRlZC4KPiBGb3IgZG9ja2VyLCB5b3Ug
bmVlZCB0byBiZSBwYXJ0IG9mIHJlc3BlY3RpdmUgZG9ja2VyIGdyb3VwCj4gKGBzdWRvIHVzZXJt
b2QgLWFHIGRvY2tlciA8VVNFUj5gKS4gUm9vdGxlc3MgYnVpbGRzIGZ1cnRoZXJtb3JlIHJlcXVp
cmUgYQoKVGhpcyBpcyBkYW5nZXJvdXMsIGFzIGJlaW5nIHBhcnQgb2YgdGhlIGRvY2tlciBncm91
cCBlc3NlbnRpYWxseSBtZWFucwp5b3UncmUgcm9vdCAod2l0aG91dCBwYXNzd29yZCkuIEl0IGFs
c28gaXMgbm90IGFueSBkaWZmZXJlbnQgZnJvbSAic3Vkbwpkb2NrZXIiLiBGb3Igcm9vdGxlc3Mg
ZG9ja2VyLCBwbGVhc2UgcmVmZXIgdG8KaHR0cHM6Ly9kb2NzLmRvY2tlci5jb20vZW5naW5lL3Nl
Y3VyaXR5L3Jvb3RsZXNzLwoKRmVsaXgKCj4gaG9zdCBrZXJuZWwgdmVyc2lvbiA2Ljcgb3IgbmV3
ZXIuCj4gCj4gSmFuCj4gCj4gLS0gCj4gU2llbWVucyBBRywgRm91bmRhdGlvbmFsIFRlY2hub2xv
Z2llcwo+IExpbnV4IEV4cGVydCBDZW50ZXIK

