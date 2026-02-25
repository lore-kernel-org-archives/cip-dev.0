Return-Path: <alexander.heinisch@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7299AFD3770
	for <webhook@archiver.kernel.org>; Wed, 25 Feb 2026 15:54:34 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com (AS8PR04CU009.outbound.protection.outlook.com [52.101.70.43])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.48439.1772034869170694378
 for <cip-dev@lists.cip-project.org>;
 Wed, 25 Feb 2026 07:54:29 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=qq1Wpsz3;
 spf=pass (domain: siemens.com, ip: 52.101.70.43, mailfrom: alexander.heinisch@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=skK77FYSlYRYqiXVbiz63wY/bscKOI6VqE1gEASfIzggu/4KNSKWkSnuinFyp6pnEZKtBQa/N9KyIJp2f+bLnUsB0El9exJ9VDgEy/0sPiMB8UcDegUo4W1X/TUQ2ZFZiMIKZ42Vb5ohlDTDO+sjwc6aNq0ah100W1xL6lWtxHzcgk+snn9Dvclzy0Vye+MVf/QmgEoXodWRe4WQr9Zzt84fYUyVgftDJodc9R5zaU4KYr58FuS0aIxA5+BJ6IgKWUn0XHdslirhAZjLmwN8k1eraF2+6Awb9uYip4wfmrYhlFUaQecbvWRS11oV1Msvt2ljhxcUuBiWIqr4hUDAKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lwDLZGZ1pj0iBsWzO7HqzaUsRJ+aWAMAwl5n7D1AMaU=;
 b=SdQ0hjbrolVY79sPk3vcCA5EtfBz7ASc2jx/OYw1g0OScQFe8Y2tnVBlshpd8bMOYZo4G4DObtWIK/VOU8Kf3S/2bqo/awNSyqNDW78x8v9UXQBs882opgwHXxLnQNNbYaeHDKoqWMbNPWRqkCKo6ussRZRjCEExHMZZSztr27+i+jOm0Kf8NqeBCfjajEVqL//pbZ6bTgSdcBqeiitr+wOEY/w7LCGANl7sibVid+EKap9zKHwXEAIqjfeHkkKhvuI2J5ri0DzHaazzduZqFsrL3+Ybds+tlByA3j6dU3o0JdnSqUJyLiHEila8OWicbr+iSBWXT8mxYLFd85USnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lwDLZGZ1pj0iBsWzO7HqzaUsRJ+aWAMAwl5n7D1AMaU=;
 b=qq1Wpsz31+hNB/nvgTB7K7Hd7MerSznLzYLA/fyMXCDeRE62nTt/HkLUk1QdaiCwUpdAU+cBrngm+K2gGL9ktmHBAFs/Ktnl6vxCa94zLOATWPN885mC010YX2uEDFbKRfkd0BTa6/gJjl/0lnH0YWxVDv8MZYL4/3yaIfN44/J2U2xN09QZEp8TSDj5caJ1OIVENvKMvjSu2q8vO++v2G8vGlibdv7YVxhzMggzjyOw5cKFynHU3tdgWaOIbA63S96vOY+B+7Lwvy30plNf3BLnWRefuJFGfkx/rl8OlDD/SuQXsZEF78b/XhMa6PK0JKMVMuxnl9GQ5GqKDTFgGA==
Received: from AS8PR10MB7349.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:617::15)
 by FRWPR10MB9228.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:d10:183::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.11; Wed, 25 Feb
 2026 15:54:25 +0000
Received: from AS8PR10MB7349.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::900a:259b:ae7b:828]) by AS8PR10MB7349.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::900a:259b:ae7b:828%5]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 15:54:25 +0000
From: "Heinisch, Alexander" <alexander.heinisch@siemens.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, "Kiszka,
 Jan" <jan.kiszka@siemens.com>
CC: "Gylstorff, Quirin" <quirin.gylstorff@siemens.com>
Subject: Re: [isar-cip-core][PATCH v3 0/1] swupdate: Enforce signature
 verification
Thread-Topic: [isar-cip-core][PATCH v3 0/1] swupdate: Enforce signature
 verification
Thread-Index: AQHcnGgtfJwnSkLB10uKKrE4+vDVlrWTocMAgAADcwA=
Date: Wed, 25 Feb 2026 15:54:25 +0000
Message-ID: <d9a302e61015e26a584885d874d0481ee602ff52.camel@siemens.com>
References: <20260212214003.734787-1-alexander.heinisch@siemens.com>
	 <eca167cb-b110-4979-90ca-2bcef599d35e@siemens.com>
In-Reply-To: <eca167cb-b110-4979-90ca-2bcef599d35e@siemens.com>
Accept-Language: de-AT, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.56.2-0+deb13u1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB7349:EE_|FRWPR10MB9228:EE_
x-ms-office365-filtering-correlation-id: b032ee3f-2845-453e-05e8-08de748626bd
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info: 
 YE0nQYGxM6bamMPT5wW9kw3E0cQ1E+WghAMDIPnTIXUYYCKfPVKok0PY90Kj/ptZC6MDNNsOXXNGtTFx5DuWW0bjvHjV6MYr3+MZ+VSFi78tXHkrby5bSwasOaYL03IBe53idiAlTdm4yIMB4zHypxNzf46z6uXfZ8K7xBE3NY1kQgf3X07iZTKbQrMGsynU416YD7LiZiO9zHvnOcKhHx+j+ruclZ9s7c6AuNI/FcivmsWt9sankl/axpzDuCBCb/U//xjnE4Ygc3D7D5CtrjPehk+5/8y3sOcGxeFEuvz3aKfk0dBSWEK9D1MYLNeII1LEvVRwWLRwDkV5PbGPShR4Y9iBIoTx5fjA+axyJKaa85F0qwD9ttqSu4aDPRuskU+5icW8mG6ECJxZRsyzFxbzbTSIW3ho6a0nN2dlE/WHffdOewEYiuaEb6quIR7nMu6wk2SxXSrGugMMyzOWbzKnQn9iBb3Jcel+hSQepAYpiHV9088fqFheQsF/udEBAxnQEODzEjCi8/91iymdw0UABDdtEUfvYsbkPUHNNIpKbv37wWDtsGS75UuZUGd3DCFJOpgHDizOWThyZbKtHIJdngAnnXtveuRMGaLYjoZwQ1D6jhH7E0hD3p/ZsEQ7uVJo1LY1bgy6THPmga8ipQj7WzklYJXTmqPFb5w7RFKZsP+/JhorgqYx1oNMZKBlaEMb2nBXk7X8bkJAA0/BRk+XI/GLSgVZmN9u9MZDQeA=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR10MB7349.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?Nm9XZFhqNUM3TVoxWk5aRTJuNnNaSkhnNG0rUmU0Uk9tNGl1YXRZOTluUmJT?=
 =?utf-8?B?OW0wUTJoQkVEbXF2UGRkQUdSWjlJeXcwbTQza0loS0lNZ0hsUGlBN0NQbHhW?=
 =?utf-8?B?QmxyUE9JL2gvUXJZcDZsK2V3RXZPMnIxUnk1ZEE1MXd2TXZqN0xKSjRPekor?=
 =?utf-8?B?OWlRS3lCck9id2tPUGNNSG9IbkoyTDI5TmUrT3BNcFVsb2VHMWJWWU82b2pm?=
 =?utf-8?B?V21jSkM5RDdIbDVWbGZId2dBWEpsK0JRSTRnRkZKcU1UM1pPeG1WZXlnbnNY?=
 =?utf-8?B?WU1nK3A0Rkh0SGRELzkyNk1vbm9XeUQ0dWlrM3g3T0tYVlU4eWxKUU1kTWdx?=
 =?utf-8?B?d1FrMHBCdEtmWGJWdy84SlgwRy9LdUtraU1FMVhjVWNjV3ByMnBwQUpzZDNG?=
 =?utf-8?B?SG5ScXYrWFZ6dThzNVAwTjcwaTVWZUdEWXk1VHZuYzQ0V2U4NitCY3JQZ2FI?=
 =?utf-8?B?RGZiS2ZudGM3Mnc0QVF6UUwrRTNLZXlpdm9ySVhXREVWNFd0SjR6QnptVWZF?=
 =?utf-8?B?d085ck9PdXhwaTI3bjI3QnhUWERqSnpWdVMrNG1jZWVCUWFCelBFSTNUU1Yv?=
 =?utf-8?B?Sm9ncEpwNWxweEVLb0VjUjErNjJsN0JBcVBjWmQrNkpxdEhpdksvNzNJanAx?=
 =?utf-8?B?Qld2OWRpblNoQ3F4aUNXdlhpSEhEd25XcWc2Y0xURFRIdmw1UGpXTlVVaVls?=
 =?utf-8?B?bllOc1VGYTJDMDJ2MEJ3ZStSWjZ4cjI0di90YW9jdjZWdEl6Wm1Ub0dYWnBh?=
 =?utf-8?B?endXTkMrYkEwdUFDa2hNcUphaSt3cmFOZVBqVXQ5NEVhWVd1R1lRWDVkdjhG?=
 =?utf-8?B?S0Q5d2ZNVkVJbUloQ1pMZEVHNzd1UmlmaVFGNUdKdXdXS1d4QUNTVGhheXVM?=
 =?utf-8?B?K1owdG5tK0xWTGt6eTBOOFZ4OXFhRXVtWGlvMnhtUS8rNldMZFJPdUlNMjhp?=
 =?utf-8?B?T1BIWWp1dGlvY1NKQ0FaWEJtSXZ3WVo3eEFtbW1kNmJHN2MwdThabHA5VG90?=
 =?utf-8?B?cWEvbW9PbmJSUWZsWE5HWFV2UlBRYVdZeWQzSFJxOWJDT2lyL2xFbTRzYmJ2?=
 =?utf-8?B?eVQycFlYYXprZFoxckVYQ0UwcDg4UG5rOGlMNDB6YXAwdDhDUFhjcUg4UklY?=
 =?utf-8?B?TS9BT2Z5Mm1sVktXUHFxVWorbkFHK1hGQ1REN3pxK3h6RGpqVlBKcENnWE9r?=
 =?utf-8?B?cmVXbWNacTV0SzNCc0xEZHhRVlQrdG9YenMwMTJWRjJmQUcxV2lIRE80TXVu?=
 =?utf-8?B?YWpWVVlHZFJtN1JkK3lmdlFxYjVUa29vRjdBdHp1L0tBVERWMlA4b2lBWXZ1?=
 =?utf-8?B?aUw5cGY2d1NJQnVsbHRCQmxJS1FJN1l0eDZYMjRTY2tna2tWc2tZVU9zQStl?=
 =?utf-8?B?USs2a0o3R3JNSmNSK2dnYk0vdFl1STAvQU0rUnpoR0M3Y0JqbktralAxS0Qw?=
 =?utf-8?B?bngvYk5vV3ZGS3JCT09oUUtoeThaZWttRlNVM2dib3Y4SFNRWHR3YW90anJr?=
 =?utf-8?B?REVjd3hmcVQvOCthenlld0RHQ3lyMVFJUDdXaVE4ZUxoQUxzZ3lGNVFJR0JF?=
 =?utf-8?B?L3M2REpwY2wrWWh3dkpuMlJmelZEdU05aE9JUkVGbXdUK0srV3pwakJpR0FZ?=
 =?utf-8?B?eUJEYnRNRDV5M3VaTHVrbm5qMzFERmhJU3NVQ0R1ZUFDT05Cbi9LTWFxMTFB?=
 =?utf-8?B?aDJ3dGpMVUdId0sveTB5OFd3N1oyZTN6MHEyeWNvVy95NzNFK0UzQ2wzN1Jj?=
 =?utf-8?B?ZnQ2cnplMXo4ZnZpSEloangxWnpxSkJQOVJKWnMrVktPSE1lckhQS2I5V090?=
 =?utf-8?B?T0pFUjNjQWVteXVGcFNXVDljQ25DOE5oNC8yVGdmeXBBb1MzNnNianRRNlhX?=
 =?utf-8?B?bG5uQjI3a0N4TU9zUXVDU0hzYkRhaXhjU1loWnVRTElNb1dMQXI1VkxqRDdz?=
 =?utf-8?B?NTdRY1dBNWVWd0Fib0tSYlhwMEt3MHNKclNhUGthMzhPRzY3ckJLU1lodll3?=
 =?utf-8?B?emMwb0FJQlRJVnRLNW8vUnlKM2RUdURJbUROdTlMRTl3NjY4TmcyV0JMQ2Yx?=
 =?utf-8?B?eURsZ1hNaVY2UlVTNldsSkpTWHpBME5KVEdZYXpqVVBjMEhZU0ptMTdyRkNr?=
 =?utf-8?B?Q2tXZTFHT3VTUTNmKy81aWVmZ25qSkhjejZkcWg3dzVKV01GR3AxbkgxeHVu?=
 =?utf-8?B?dVRYaTVvKzlvaWdldUczQTdCUkJBUXpiVUl4R1RGeWpvbDU4RFI3bE4xdzBE?=
 =?utf-8?B?YVZXM28rMmhIMUYyaW9CMWZwdlErcnQyZzMzRU5BZlpNTFU1aDVzS2tEUjZ6?=
 =?utf-8?B?Vk9Jd0VncHN2aGlBbEVSN3IrV1pBaDlKU3BGMngrVW5FVUZiMTFFaVByTUxH?=
 =?utf-8?Q?FJ/KTapZswLuy5+M=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9CCFF643A52F0947A3DBBE3B4469A7B0@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB7349.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: b032ee3f-2845-453e-05e8-08de748626bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2026 15:54:25.7311
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ck61269WgRw5TOqYjBxithMyLn1nqd/aU/p0D0qxfaf8WoSMR8uXR7EF6woPADTZq7sLq2St7ROBRdknKcia7tAGbNTCWrKLxXd9x1or8Ss=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRWPR10MB9228
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 25 Feb 2026 15:54:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21986

T24gV2VkLCAyMDI2LTAyLTI1IGF0IDE2OjQyICswMTAwLCBKYW4gS2lzemthIHdyb3RlOg0KPiBP
biAxMi4wMi4yNiAyMjo0MCwgYWxleGFuZGVyLmhlaW5pc2NoQHNpZW1lbnMuY29twqB3cm90ZToN
Cj4gPiBGcm9tOiBBbGV4YW5kZXIgSGVpbmlzY2ggPGFsZXhhbmRlci5oZWluaXNjaEBzaWVtZW5z
LmNvbT4NCj4gPiANCj4gPiBUaGUgc2VsZiBidWlsdCB2ZXJzaW9ucyBvZiBzd3VwZGF0ZSAodXNl
ZCBieSBkZWZhdWx0IGluIGRpc3Ryb3MgPA0KPiA+IHRyaXhpZSkNCj4gPiBkbyBub3QgZW5mb3Jj
ZSBzaWduYXR1cmUgdmVyaWZpY2F0aW9uLg0KPiA+IA0KPiA+IGBgYA0KPiA+ICQgc3VkbyBzd3Vw
ZGF0ZSAtbiAtdiAtaSBkZW1vLnN3dQ0KPiA+IFtERUJVR10gOiBTV1VQREFURSBydW5uaW5nIDrC
oCBbcmVhZF9zZXR0aW5nc19maWxlXSA6IFJlYWRpbmcgY29uZmlnDQo+ID4gZmlsZSAvZXRjL3N3
dXBkYXRlLmNmZw0KPiA+IFtERUJVR10gOiBTV1VQREFURSBydW5uaW5nIDrCoCBbcmVhZF9tb2R1
bGVfc2V0dGluZ3NdIDogUmVhZGluZw0KPiA+IGNvbmZpZyBzZXR0aW5ncyBmb3IgbW9kdWxlIGds
b2JhbHMNCj4gPiBbVFJBQ0VdIDogU1dVUERBVEUgcnVubmluZyA6wqAgW3N3dXBkYXRlX2Rnc3Rf
aW5pdF0gOiBwdWJsaWMga2V5IC8NCj4gPiBjZXJ0IC91c3Ivc2hhcmUvc3d1cGRhdGUtc2lnbmlu
Zy9zd3VwZGF0ZS1zaWduLmNydCBpZ25vcmVkLCB5b3UNCj4gPiBuZWVkIHRvIHNldCBTSUdBTEcN
Cj4gPiBgYGANCj4gPiANCj4gPiBUaGlzIHBhdGNoIG1vZGlmaWVzIHRoZSBzd3VwZGF0ZSBjb25m
aWd1cmF0aW9uIGZpbGVzIHRvIGVuZm9yY2UNCj4gPiBzaWduYXR1cmUNCj4gPiB2ZXJpZmljYXRp
b24gYnkgZGVmYXVsdCwgd2hpY2ggbWF5IGJyZWFrIGRvd25zdHJlYW1zIHJlbHlpbmcgb24NCj4g
PiB1bnNpZ25lZA0KPiA+IHN3dXBkYXRlIGltYWdlcy4gSG93ZXZlciwgdGhlIGRpdmVyZ2VkIGRl
ZmF1bHQgY29uZmlnIGZvciBzaWduaW5nDQo+ID4gYW5kDQo+ID4gdmVyaWZpY2F0aW9uIG9mIHN3
dSBmaWxlcyBpcyBwcm9iYWJseSBub3QgZGVzaXJlZCBhbnl3YXlzLg0KPiA+IA0KPiA+IC0tLQ0K
PiA+IA0KPiA+IENoYW5nZXMgaW4gVjM6DQo+ID4gwqAtIFJldmVydGVkIGRlZmF1bHQgdmFsdWUg
b2YgU1dVX1NJR05FRCB0byBlbXB0eSBzdHJpbmcgaW4NCj4gPiBzd3VwZGF0ZS5iYmNsYXNzLA0K
PiA+IMKgwqAgd2hpY2ggYWxsb3dzIHRvIGNvbnRyb2wgc2lnbmluZyBiZWhhdmlvdXIgdXNpbmcN
Cj4gPiBDSVBfSU1BR0VfT1BUSU9OUy4NCj4gPiDCoC0gVGhlIGRlcGVuZGVuY3kgb24gc3d1cGRh
dGUtY2VydGlmaWNhdGVzIGluIGNhc2Ugb2Ygc2lnbmluZyBpcw0KPiA+IGVuYWJsZWQNCj4gPiDC
oMKgIGlzIGFsc28gaGFuZGxlZCBpbiBzd3VwZGF0ZS5pbmMgdmlhIENJUF9JTUFHRV9PUFRJT05T
IG9ubHkuDQo+ID4gDQo+ID4gQ2hhbmdlcyBpbiBWMjoNCj4gPiDCoC0gRHJvcHBlZCBwYXRjaCBp
bnRyb2R1Y2luZyBkdXBsaWNhdGUgY29uZmlnIGluDQo+ID4ga2FzL29wdC9zd3VwZGF0ZS55bWwN
Cj4gPiANCj4gPiANCj4gPiBBbGV4YW5kZXIgSGVpbmlzY2ggKDEpOg0KPiA+IMKgIHN3dXBkYXRl
OiBFbmZvcmNlIHNpZ25pbmcgYW5kIHZlcmlmaWNhdGlvbiBmb3Igc3d1cGRhdGUgYnkNCj4gPiBk
ZWZhdWx0Lg0KPiA+IA0KPiA+IMKgY2xhc3Nlcy1yZWNpcGUvc3d1cGRhdGUuYmJjbGFzc8KgwqDC
oCB8IDQgKystLQ0KPiA+IMKgcmVjaXBlcy1jb3JlL3N3dXBkYXRlL3N3dXBkYXRlLmluYyB8IDEg
Kw0KPiA+IMKgMiBmaWxlcyBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0p
DQo+ID4gDQo+ID4gLS0NCj4gPiAyLjQ3LjMNCj4gPiANCj4gDQo+IEp1c3QgdG8gYXZvaWQgZGVh
ZGxvY2tzOiBZb3Ugd2lsbCBldmVudHVhbGx5IHNoYXJlIGEgdjQgb2YgdGhpcywNCj4gcmlnaHQ/
DQo+IA0KLi4uIGluIHRoaXMgc2Vjb25kIDotKQ0KDQpCUiBBbGV4YW5kZXINCj4gSmFuDQoNCi0t
IA0KQWxleGFuZGVyIEhlaW5pc2NoDQpTaWVtZW5zIEFHDQp3d3cuc2llbWVucy5jb20NCg==

