Return-Path: <ludwig.nussel@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 988D5C021B1
	for <webhook@archiver.kernel.org>; Thu, 20 Feb 2025 13:11:52 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.65.28])
 by mx.groups.io with SMTP id smtpd.web10.48649.1740057111185753661
 for <cip-dev@lists.cip-project.org>;
 Thu, 20 Feb 2025 05:11:51 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=OeG8KSbz;
 spf=pass (domain: siemens.com, ip: 52.101.65.28, mailfrom: ludwig.nussel@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YJaNzN4y7kAwBogHteY0htJbjG4ZU0j6ZMjZmI1DXMINyk8OWeeB+ByTzQOp/LWYoFW5map7A+srr2g17i4rU8WeQilIMu9w8OJGnE28ys5l5mq7CwOrz5o6U8cHNzmH9tWPDWXBU32apvhT6ZlA7woTn8fgL+hkW7XMCHbMIJkE96UOt2jUCHkCDYPwOWUai8JQMOtr1Z0P4GEB2lZUELby3Sty4wvFdXhuydkBJUKKgFRYWA85EWzaPkZPtKdEBR981B32LiX2oZpyZhudeKo/B7sDdZ436V8VSUcGKd7VzSO64zxlYWv8di6/IkzmwUyHSPkuV332pMQL5n76ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DiSl2J1/MJczzn420Pxvj6KBa5nNrk0qVuBbyXveiCY=;
 b=WWaIUSZJL4bpEtjUaptKeiwkdNIoy90XWqYbDQgo/OBTGGrOyNpBDv5o/68ZunEOKefjEwDldpgEw+W8TAFb4L8kZF8NhE4RolGEuABgDg+lWJK/PmQ+lqsZEHJaZFiMSSA0c51tHha83BguKaGHhWot27WmT/x4jwISt7D3ARM370UaOoG6sFZawJ0dysdj81IG+zcFyROM1tKGH6GR/yNV5x4RZ7SaJxp5zx36rL8fTsdhbkhVFKWcQUB2MTwlL+YrcGne/LYusBxDrO+Y56ElZZsn5HMIUW1M4l0+yhDz9Pvy53PgSRo+9iOeONOnZWOtxuNZaTgzN9hvNYlfdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DiSl2J1/MJczzn420Pxvj6KBa5nNrk0qVuBbyXveiCY=;
 b=OeG8KSbzOFI3vZaPzZwQGYNer0SbNeViiwS6aRX7iShUNXwDg/pjCKusGWQnlL98f2Qa7iPWTwoy3zCUq1gyvp53OpQjBH60alaWOM/SciqZj+ktFR2CM6wV1VtWL8bGEEucRMG2UcovT/oMpDM8sgF6uaIdKvkOdYao9oSRwtCwDsPxj+oLqFUJ1a42xspU3z30tuFJFYZjxhpY7yP1eDp4kl9wom4N3OCQ6BXcXT3DD89ABnrMHhOozFVLuFmgh+WPmAJ08+SAZIztspRJzwWPzx+a9JO18cBlsuXvKkYMbitQ0aaFVga03LR7DzS67yTsBt9aZ9ErH2I73h5w9g==
Received: from PAWPR10MB7126.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:2e5::12)
 by PAVPR10MB6887.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:324::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Thu, 20 Feb
 2025 13:11:48 +0000
Received: from PAWPR10MB7126.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9c89:16bf:ce23:7acb]) by PAWPR10MB7126.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9c89:16bf:ce23:7acb%4]) with mapi id 15.20.8466.013; Thu, 20 Feb 2025
 13:11:48 +0000
From: "Nussel, Ludwig" <ludwig.nussel@siemens.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: Re: [cip-dev] [isar-cip-core][PATCH 3/3] Added support for
 rootfs-overlay.
Thread-Topic: [cip-dev] [isar-cip-core][PATCH 3/3] Added support for
 rootfs-overlay.
Thread-Index: AQHbgSMrzadd3I9vAESBLNQinFmQ8rNMvtsAgANtrQCAAAMvgA==
Date: Thu, 20 Feb 2025 13:11:48 +0000
Message-ID: <75549b150c5c37710d3bb89ce272372a19ac21e5.camel@siemens.com>
References: <20250217100024.42995-1-alexander.heinisch@siemens.com>
	 <20250217100024.42995-4-alexander.heinisch@siemens.com>
	 <715da9f1-ec6d-4a90-9d32-674d7fea0d86@siemens.com>
	 <AM7PR10MB33207EA44EE03D94AF84B79A86C42@AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM>
In-Reply-To: 
 <AM7PR10MB33207EA44EE03D94AF84B79A86C42@AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAWPR10MB7126:EE_|PAVPR10MB6887:EE_
x-ms-office365-filtering-correlation-id: 138d94ef-9ec4-4b1c-7815-08dd51b021e9
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?NGRMYzNIREJXWmdiMWRPcHVPSWIzU2RJUExjeTEzN2llc1B3ZWVzRnZmbzI2?=
 =?utf-8?B?ZXN0dlljV1N4Qm9YL0hBM1VraG04WlhvK2dXOXlUZUM2MmRnQUd6MVZsT0VD?=
 =?utf-8?B?YU5zeHFqRzJoYXRrbklxRzg3QmQvWFk4aTJJUW12ZWtNZ1hNZlZJa2ZKSzIx?=
 =?utf-8?B?OHV0RmlCZDBKYjJaTHFoSUVEbkwwSTIxRnRsRkQ2TFB3YnVMa3ZWTEE0MXhn?=
 =?utf-8?B?eUtyRzFJQ0RrZGZGK0QxVkVpQkNkWi9kQ1RXU0xicGZkSTRzSVBMWEhjVXFp?=
 =?utf-8?B?OGhHQmdqS0lleGpudFh3V3hpM0tjbno4Z2VnWkRvM0kyNEVrYVB3VHBkYStN?=
 =?utf-8?B?OXVSUWM0YnFMakdobGl4MFVjNUk5Nlk0SDRWSThKZVlYenlJQ3o4cXJmL0p2?=
 =?utf-8?B?dDZKMHN2emxTZlNBOVNkQ0dlZjUzM0J1QVdQSmVxbEZPd0JvVzBYVVRsNmtr?=
 =?utf-8?B?Yi9hK1JFZWFHQTlvREluajZYL0xVS1k4Y3JaOWVKSnVTWDBZeDljVlJNbG1h?=
 =?utf-8?B?NzBYTE5oeVdxUXJSTEM0K0dTUEwyclNpbGRHZ2NISXBlNjJ0OEpLOVhDeGMr?=
 =?utf-8?B?OE9sY0srMnZFNUVwNkJ1ZHlOajVjeDFoQmFHdHB3UFU3YVVtOHNiTEwrUlJL?=
 =?utf-8?B?eks0MVVPSlFGU1hpRFNQTWxmRlhWMnpCV1k3eHlGMEZVWVBLblZaOW1HS2FQ?=
 =?utf-8?B?RUhoL1U1R3VlYlZ3bFpmZ0JJYUN4aE9yb3lYMjRENmhtemVyY29aOE1CNUVR?=
 =?utf-8?B?bC9lRVVycS9BSDJwKytPQU5LSXpEMmZsSkpGaTJkb2U5TTM2Y3FHTFJ2Z2RE?=
 =?utf-8?B?SC92QThkejBOaHo5aUh2TWVwTVdFKysvOWFkRnBScEdiV29mWGJrTkhFSzZI?=
 =?utf-8?B?b0dING9jSU1LdnBIZXFvUmJ0M1BSVm01b0ZGNFZIRFo3a3FPeU5QWTBJa1kr?=
 =?utf-8?B?RDNWRVZreXk3dXdMbUVFeitObkhiQjNhVDZmY0tyNVNOWi96dTNCd2hFeVZJ?=
 =?utf-8?B?aW5SenVOUkdrdWpnbmlESnBMWjFaeG5YRUprRmhybCt0dkhuT3o3U3paMFRi?=
 =?utf-8?B?YllESlNhNmtZbXIwQklkbjgwclVhbEE0b2JVSkFkbFhNWnpzYW44Z0xqQUNu?=
 =?utf-8?B?OEM1dzNmUlkrbEljZ2EveFR3UHZaREYvQkFpS3JMbHErTzk3akhxUjFESDNN?=
 =?utf-8?B?T2VsYzVUNXJva2FCREVOb2RabE5nQW1NRm9FV0JEc3QwbjQrUGM4N3p3UDNY?=
 =?utf-8?B?Yzl6ejBUZHdCN211YU42b3R5Y1F6elFiK1lFRDlMOXBtZmxUbjg0MW9kN1N1?=
 =?utf-8?B?dXVEUnVWN1lwcE95blNHSXFLWEdOZjBpczgrVHpBNmdxaHFpdXBiemFQUzh0?=
 =?utf-8?B?RG5VQjhNZUhBS2d3ZW83d1ZxcmNEVGdwNmdFSVdmTU9zcjBRMUZqZGM2bWti?=
 =?utf-8?B?RDBXdWlkTUdGdUMzVjh1Mlk1NHd5M1dWSXR5ckQ0SUZ4akZjdkU2b1g4RjN5?=
 =?utf-8?B?U3lYL2hCYVZWVWxxck1udXlicGxWTXB0WldWTEtZNUpPb1hVZDBRdDZrUjdI?=
 =?utf-8?B?bkpvQi9hWG5UWnM2L3pIdXM0cUU5bGdEQkV0WXBnNUFWMWk1emJKc3FJTjJl?=
 =?utf-8?B?cktHUUs4NE1QcHBabk9LR0NBaHZid0FsejhvK3NhU2ppRC9PaTFlbjQ5RFpS?=
 =?utf-8?B?WEZRNmF4Z2FrK3p0VUFvVDR0RFl1dUFtbzRUazZOV3MyYmQ0NG84Znd2S01P?=
 =?utf-8?B?RFBlMHlrSUdSMXRBR2NWTml5TE90dmd5SWI1c1doY2tuN1pFaXJ1S1lEUjZ5?=
 =?utf-8?B?UkdpMmFqUEJSeDJlYnc2VlVJTzlML09xSXgwMmhMOUFuOFhDN0w5MW9rWVB5?=
 =?utf-8?Q?nR9ltZfcvMC/Q?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAWPR10MB7126.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?NUwxaXZTelhXYWRHaHhBNW9hVk84QXg0V1BUM0RnK2NEckVvWDFZZ2ZscDV2?=
 =?utf-8?B?Nk96UjNQZWEwVUl2OTg3NFBUNWVrQ0pDZHpvNjNlMDl3QWNPMEJKakoyRG1U?=
 =?utf-8?B?b1J5RWVTSm92UGJMZXJsclE3LzljQXMybUJvM002VXdyOWs5U1BVMmltV2V0?=
 =?utf-8?B?VVpZSGdwVlN3d3psN1BwM21wTmY5dkZvTk56YkYyd3JWOWk2TGFEV1ZLdHkz?=
 =?utf-8?B?VTVSMXpBeVBZcGNhc1JrQjZTMDNVN1U1RkpxRzVOdWdxdFJjRWRPMG83eWxK?=
 =?utf-8?B?d1d6R2c4d1ZlcTgxaFVrMkVZcU8wOXlaYUlFM1huQkRWT1NNUi9jb0dUaXdk?=
 =?utf-8?B?MmUzNDlEdDFBeWVnV29zNXJ2RVVBQkR2Smh0cXBzRFNJNVNIZmljNjliV3dE?=
 =?utf-8?B?QnVLYVBHSFdocjRCUUlCL01peEJJKzBjaFAvUEs0dzhka2xMV3psNXZ1eXN1?=
 =?utf-8?B?M3A2Q0RVWWpSOXU3TlBtK1Ixb3U0a2NzRnVObUlGN3dmRmV1bi85ZjgrbDRM?=
 =?utf-8?B?dnFMYVdlamdMcTNLNUFYYW1BNG50Zmw1YnhpRVNpWDJmRUk5aGNRbUQ5K0Z0?=
 =?utf-8?B?NTdCTStMTUJYdDhJcnhQZjh5NHA1OEhSU0QxNFVtaTNDK3RQVzM2UHVld0dl?=
 =?utf-8?B?Z1pmU0RXOUJ5VS94Rllrc1Jzd2ZMZmE3Qi9ybSt5b0lvcGNEN2RLWFlYbzFL?=
 =?utf-8?B?L3JaVlVNSjVoMEdLOGtCMFd0RThlTktPV2tLL0NheldQTEs2V3NDSWc3Q3Yr?=
 =?utf-8?B?eE5sWjU4d2pHbHlmcC9WWHBncW9tS1BSZnpMQ3VRYjlaRkNmc3RRYldnbTdT?=
 =?utf-8?B?aGhQUmxqZHVQTU9FZ2xrWGtLQWxKNDc1blpET3lKWGlLVTBKTUVkOFFFRk1S?=
 =?utf-8?B?UzA4UTBKeUtoUHAvd1ZQYlpmM2hnQkxLV0VVMTBoUjNsNk1iVHcvdThsZERh?=
 =?utf-8?B?ay9JSjEzTmZJR2dYc0dxZlEveVV0bDJTd0E5Y2pMY3lYcEdsV1MydUNuN2lH?=
 =?utf-8?B?WVd3ZEJGK0ZEQ2xseWlJTzZzYUJFWk1sVE1LdzJUTTlOQ3pRdU11cUloNnhs?=
 =?utf-8?B?aVo2ZnFvNDdZVnRoUU5mNUpsaHJkTEY5TlBFZ0RnMTdZSmlZWkdGa09ydWxK?=
 =?utf-8?B?eDdDY3lyRjRwc0NtVHcyd3N0bFBoV0RSUHQxL2RuRzhWTnhQem1KaXVzZmQv?=
 =?utf-8?B?cWRTalBzT3hZbytFSDZwK3RCYnBRaGJtYmluNkxZQjZ6YWxuei9tanFDK1Y0?=
 =?utf-8?B?bXY3Mk5GWW9aL2RlTGJJUWpGNHlWWjhCV1REK1RCYVNubmgxcDdMRkZhdU80?=
 =?utf-8?B?VTM4OExtUlhDaTVweWk3L2tLM3FnUFVMM2k4UHJEbFVHc1lLcXNXbGFYcjBw?=
 =?utf-8?B?alpMcFV0S01vR29TbGQxK2prTk9YNVN3dWdkeFUvb1pBZlVFMlU3SVhxQlFp?=
 =?utf-8?B?WUlJTDllSlZ6eDVVNFIzMlp5RGlUWEJOUFJTeHhiN0RCSW80Nnc1WXhJMC9S?=
 =?utf-8?B?d09tcXpjdUdaK2Z3WVRSSjJhVHkrRENkTzFqRnphWjRiOXQ5bWwxMjhiQmE5?=
 =?utf-8?B?RXRVUzQ4VWkwVVBvVXBoaC9xcUpad2hSd2pIVExkTTg0NzBqTFRiK20wNGEx?=
 =?utf-8?B?SHRjWTN4N0M3bXc0VHdsSTdkZ1BHZ09rS0lKdDVRYlh0aG12WVNmZlVjWjNL?=
 =?utf-8?B?OCtlclNNa2psSXZRM0VsTnY4U2pFWTRweldDN1lCTksxVkQ1K05rZVdENE05?=
 =?utf-8?B?T05TZXJDUFZ1WE9WMksrS3F5NVg1c1BJZVpyV012S2U2eWhBMUxIa2VyUk5T?=
 =?utf-8?B?cmhIaExFRFFORWF6R29RN0pUNUlkNXYxY2ZobGMraUtWb25EdUVKVFVQajRM?=
 =?utf-8?B?VFB0a3VVZk12OGpxbmJQY2p2QzduWXJlZU9rVGM3bkhiRnRXdWJINXc4UC8r?=
 =?utf-8?B?aHpyazA3cmMxSGx0NFB6NnRWVkxwcHRWTnNOVVZDSUpMYzlnTlJyUThoekk1?=
 =?utf-8?B?RHh0R1NaWjVsaXRTdkc5S0locXNuZmJldWVuZkIybFNsaS91YjNVeURJRU5p?=
 =?utf-8?B?MEIrR1dmV056cEFITGFGU3ZxclRRbm5iaDFEL3l6aUc3c3NLdFg3NmkzMzdJ?=
 =?utf-8?B?WUM1MEVqbXdrNlB0aElHYzF6ZXdnMHVoTGhINC9HYTBnUzJvK2RST1V4Rlla?=
 =?utf-8?B?THc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <086FEE191C3A2B4B960B45A953F7FC0E@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAWPR10MB7126.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 138d94ef-9ec4-4b1c-7815-08dd51b021e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2025 13:11:48.1138
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lO7Xwh2zB4/HqKcyYygd/y4hfJroBesFeIk9LYRTB6xRIER9qRVkYZsZG2nPD2lTg/XSsf/316TwX07svCL/IINd0gSLjzQVTH4bzIjxGCY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB6887
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 20 Feb 2025 13:11:52 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17874

T24gVGh1LCAyMDI1LTAyLTIwIGF0IDEzOjAwICswMDAwLCBIZWluaXNjaCwgQWxleGFuZGVyIHZp
YSBsaXN0cy5jaXAtDQpwcm9qZWN0Lm9yZyB3cm90ZToNCj4gPiBPbiAyLzE3LzI1IDExOjAwLCBh
bGV4YW5kZXIuaGVpbmlzY2hAc2llbWVucy5jb20gd3JvdGU6DQo+ID4gPiBGcm9tOiBBbGV4YW5k
ZXIgSGVpbmlzY2ggPGFsZXhhbmRlci5oZWluaXNjaEBzaWVtZW5zLmNvbT4NCj4gPiA+IA0KPiA+
ID4gSW4gYWRkaXRpb24gdG8gdGhlIG92ZXJsYXlzIGZvciBlLmcuIC9ldGMgd2Ugbm93IHN1cHBv
cnQNCj4gPiA+IHBlcnNpc3RlbnQgDQo+ID4gPiBvdmVybGF5cyBmb3Igcm9vdGZzIGFzIHdlbGwu
DQo+ID4gPiBUbyBlbmFibGUgdGhpcyBiZWhhdmlvdXIgeW91IGNhbiBlaXRoZXIgc2V0DQo+ID4g
PiBJTklUUkFNRlNfT1ZFUkxBWV9QQVRIUyA9ICIvIg0KPiA+ID4gb3IgZXh0ZW5kIHlvdXIgZXhp
c3RpbmcgY29uZmlnIElOSVRSQU1GU19PVkVSTEFZX1BBVEhTID0gIi8gL2V0YyINCj4gPiA+IA0K
PiA+IA0KPiA+IEkgd291bGQgbGlrZSB0byBhdm9pZCB0aGF0IGFudGkgcGF0dGVybiBvZiBjcmVh
dGluZyBhbiBvdmVybGF5IG92ZXINCj4gPiB0aGUgY29tcGxldGUgcm9vdGZzLiBXaGF0IGFyZSB0
aGUgZGVidWcgY2FzZSB5b3UgbmVlZCBhIGZ1bGwNCj4gPiBvdmVybGF5Pw0KPiA+IA0KPiBUbyBi
ZSB2ZXJ5IGNsZWFyOiBUaGlzIGlzIG5vdCBtZWFudCBmb3IgZGVidWdnaW5nIGluIHRoZSBmaWVs
ZCENCj4gTmV2ZXIsIGV2ZXIuDQo+IA0KPiBUaGUgaW50ZW50aW9uIG9mIGhhdmluZyBhIHJvb3Qt
b3ZlcmxheSBmb3IgdXMgd2FzIHRvIGhhdmUgYW4gZWFzeSB3YXkNCj4gdG8gZGV2ZWxvcCBhbmQg
ZXh0ZW5kIHJlY2lwZXMgYmFzZWQgb24gb3VyIGV4aXN0aW5nIGltYWdlcy4gVGhhdA0KPiBtZWFu
cywNCj4gd2Ugd2FudGVkIHRvIGhhdmUgdGhlIHBvc3NpYmlsaXR5IHRvIGluc3RhbGwgcGFja2Fn
ZXMgd2l0aCBhcHQsIG9yDQo+IGNvcHkgDQo+IGFkZGl0aW9uYWwgYmluYXJpZXMsIHNlcnZpY2Vz
LCBjb25maWdzIG9uIHRoZSBkZXZpY2Ugd2l0aG91dCBoYXZpbmcNCj4gdG8gDQo+IHJlYnVpbGQg
b3VyIGltYWdlIGFsbCB0aGUgdGltZSwgc3RpbGwgbWFpbnRhaW5pbmcgdG8gaGF2ZSBhIHdvcmtp
bmcNCj4gZW52aXJvbm1lbnQNCj4gYXMgY2xvc2UgYXMgcG9zc2libGUgdG8gdGhlIHByb2R1Y3Rp
b24gaW1hZ2UuIA0KPiBUaGF0IGVuYWJsZXMgdXMgdG8gZGV2ZWxvcCBmZWF0dXJlcyBpbiBhIGRl
YmlhbiBuYXRpdmUgZW52aXJvbm1lbnQsDQo+IHN0aWxsIGJlaW5nDQo+IGNsb3NlIHRvIHRoZSBm
ZWF0dXJlcyBwcmVzZW50IGluIHRoZSBmaW5hbCB0YXJnZXQgaW1hZ2UuIA0KPiBBZnRlciBiZWlu
ZyBjb25maWRlbnQsIHRoZSBzdGVwcyBkb25lIGFuZCBjaGFuZ2VzIHJlZmxlY3RlZCBvbiB0aGUN
Cj4gb3ZlcmxheSBjYW4gDQo+IGJlIHRyYW5zZmVycmVkIGZhaXJseSBlYXN5IHRvIGEgcmVjaXBl
IGFuZCBlbmQgdXAgaW4gYSBwcm9kdWN0aW9uDQo+IGltYWdlIChpbWFnZSB3aXRob3V0IHRoZSBv
dmVybGF5KS4NCg0KRm9yIHRoYXQgaXQgc2hvdWxkIHN0aWxsIGJlIHN1ZmZpY2llbnQgdG8gb3Zl
cmxheSAvdXNyIG9ubHkgYXMgdGhhdCBvbmUNCmhvbGRzIHRoZSByZWFkLW9ubHkgT1MgcGFydHMg
Zm9yIGFueSBoYWxmd2F5IG1vZGVybiBPUyB0aGF0IGhhcw0KdXNybWVyZ2UuIC9ldGMgYWxyZWFk
eSBoYXMgYSBzZXBhcmF0ZSBvdmVybGF5Lg0KDQpXaGF0IHdlIGNhbWUgdXAgd2l0aCBpcyB0byB0
cmlnZ2VyIHRoZSAvdXNyIG92ZXJsYXkgYmFzZWQgb24gcHJlc2VuY2UNCm9mIGEgZmlsZSBpbiAv
ZXRjLiBUaGUgYmFja2luZyBzdG9yZSBkaXIgaW4gL3ZhciBpcyB0aGVuIHZlcnNpb25lZA0KYmFz
ZWQgb24gdGhlIHJldmlzaW9uL3NuYXBzaG90IG9mIHRoZSBPUyBpbiAvdXNyIChlZyBCVUlMRF9J
RCBpbiBvcy0NCnJlbGVhc2UpLiBUaGF0IHdheSB0aGUgb3ZlcmxheSBpcyBvbmx5IHVzZWQgZm9y
IGEgZ2l2ZW4gYnVpbGQgb2YgdGhlDQpPUy4gQSBuZXcgYnVpbGQgb2YgdGhlIGltYWdlIGNhbiB0
aGVuIGJlIGRlcGxveWVkIHdpdGhvdXQgb2xkIG92ZXJsYXlzDQppbnRlcmZlcmluZy4NCg0KSUlS
QyByZWNlbnRseSBzeXN0ZW1kLXN5c2V4dCBhbHNvIGdhaW5lZCBzb21lIG9wdGlvbnMgdG8gcHJv
dmlkZSBydw0Kb3ZlcmxheXMuIFRoYXQgbWlnaHQgYmUgdGhlIHdheSBnb2luZyBmb3J3YXJkLg0K
DQoNCmN1DQpMdWR3aWcNCg0KLS0gDQoob18gTHVkd2lnIE51c3NlbA0KLy9cIFNpZW1lbnMgQUcg
LyBTSSBFIFImRCBJT1QNClZfL18gd3d3LnNpZW1lbnMuY29tDQoNCg0KDQoNCg0KDQo=

