Return-Path: <chris.paterson2@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AAC5C7115B
	for <webhook@archiver.kernel.org>; Mon, 23 Jun 2025 13:05:00 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.3])
 by mx.groups.io with SMTP id smtpd.web10.19145.1750683898216367927
 for <cip-dev@lists.cip-project.org>;
 Mon, 23 Jun 2025 06:04:59 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=VOa7oclS;
 spf=pass (domain: renesas.com, ip: 52.101.229.3, mailfrom: chris.paterson2@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yW592t0fnIlo1euzxOfm+WiC/ALViWzT4vOYUVIlw0WbDEZrTsH9RQXVAEmv3QcRbIMmC7rLvC5DmlL25zyR/6RtlN70wFH0miOSDgzOm+m6IEqpXqZ9RrBy3wYS3/8R8BmTsg4clds4ozW4CNdj6+zsOrPVTygEqpwFqQHB2KJ5e4fqGp69qkvVdmlYgqGo5f9UwcFoSr2GW0oMuzSzy/ythHWgQuLuokt7CTq9iRkqFApxHfUf7A53U5cVtRiiVKq+tLDTS0UNmCO+b9AvViMVMbUSae4e/iQquJF8EXvoVy0xXGPGMyqSS7OaLi6NZUhS1p8BZHmKqksAE0lWfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A/f8B/m00tMJ8SKk1IpC0BwC6sllOqe7Y30aza7/JGc=;
 b=X0sY8K+jwwdqpDSqnhy/ij/OwPov8g8a5h6Xw9Geaf6IlWi0G9g3Loth292Eb2Z/ltxolv+gNpwDaGkErltjEcoNFmgXuP8KRKXobbxVXkRx6/wprDUYfJ31Vtg1rFQx8ybcvUTGlmIxUFhwQhbXmpQ7szy9h33nGhT3mrbTHgM0f4Jgv5Y+RW/h8sktltUZwmASmvu0PUKSyJhi1i6gWsD9+bk/Z0PSkyz8+q7DiEBbtv3m9onVW68rU/TbEtof4Bm8oTB0ZnvzHNbnO+xpQNJGKICSsqGcKPs+KvYCMxnamluOjz2Z7aIggkkFhl4wDw1JmpziU43hzZQODSnOdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A/f8B/m00tMJ8SKk1IpC0BwC6sllOqe7Y30aza7/JGc=;
 b=VOa7oclSxDNODux7eoQyhnOP5nDQkaK/pswnk/yI9t2POI95Jq/Nf0khaOu4XmlXWJcgq66wkx87n/LkipeVnzjfMPNUKpUIgng1J+d8WScWIGVK6Gex1nFpx2Q6+D+bHVbuG0Et+RDbMqFGsFVAK0qIOYITiGTm90LLqPrG8Ig=
Received: from TYYPR01MB15132.jpnprd01.prod.outlook.com
 (2603:1096:405:1a1::10) by OSCPR01MB16213.jpnprd01.prod.outlook.com
 (2603:1096:604:3ea::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.27; Mon, 23 Jun
 2025 13:04:53 +0000
Received: from TYYPR01MB15132.jpnprd01.prod.outlook.com
 ([fe80::3fd9:f47c:79c7:a6c6]) by TYYPR01MB15132.jpnprd01.prod.outlook.com
 ([fe80::3fd9:f47c:79c7:a6c6%7]) with mapi id 15.20.8857.026; Mon, 23 Jun 2025
 13:04:49 +0000
From: Chris Paterson <Chris.Paterson2@renesas.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, cip-dev
	<cip-dev@lists.cip-project.org>
CC: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Subject: RE: Siemens LAVA lab down
Thread-Topic: Siemens LAVA lab down
Thread-Index: AQHb5D1eFfjh4oJC70uIQZZTi7d9RLQQtjNQ
Date: Mon, 23 Jun 2025 13:04:49 +0000
Message-ID: 
 <TYYPR01MB1513242522DD7987EA384A6B1B779A@TYYPR01MB15132.jpnprd01.prod.outlook.com>
References: <b7e641b6-f14b-4e2a-932f-f123a549d39c@siemens.com>
In-Reply-To: <b7e641b6-f14b-4e2a-932f-f123a549d39c@siemens.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYYPR01MB15132:EE_|OSCPR01MB16213:EE_
x-ms-office365-filtering-correlation-id: 98a97731-7df5-4192-3abe-08ddb25688f3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?TjVjeFMrKzhtbjFVdXVOMk1lK1lFLy9FZjFUVmlOVEdHUEtPL0ZzMW5lYWdS?=
 =?utf-8?B?Mk5pbk9rQVVSTXBGdVRqQnBwWE91bTl3YUJpdG1WM2JtcXJhbTZTSDhVNm5D?=
 =?utf-8?B?bTNvQklLYnNpRFRwbTh3L1Q3UzhZeER0YzArUTYyc2MzV1BFRmpVeUxHMDIv?=
 =?utf-8?B?MnhBS090TEp2cHhqckVscXN3TUVkQ2M5Yk1TSXpoV1BoUDk1djc0SmxleGVW?=
 =?utf-8?B?VDA5VTlhZDlIeTZoNXhjTkFLMGFEbTlFdXBEK3Z6Ymt3RllweGxNYUd4MUlt?=
 =?utf-8?B?MXFZbUs2cFI4UFNjdEp0UEpVb0pqOFpPM1A0WHAxUFEyRHNYaDNmTklHWFNu?=
 =?utf-8?B?L1EwTnlnc2FaR0RuLzY5cmErY0p0SVc4M1dpUFA0WkRYcHZ6eWplazdyTEdU?=
 =?utf-8?B?MWdrNHJ3NUxteVNCS0ZGWms0akhPV1JRUHYyWkpjZVArTjhOT3NSWENsS0Fx?=
 =?utf-8?B?SjJFTEJwR2pXTU5rcmozTUpIWGRnT1FMMDJHQlltMEcwNUdZTHpwcmg0TlVv?=
 =?utf-8?B?STlOOHVuNEx3MXBYckZqQ1J6azVrSzVBZ21mTjB4WURrRlArMTRBaGlOQjB6?=
 =?utf-8?B?UmJUUE8ySDZrTEZ1a040K3I5dktLRlBHa1RhT2Vwb0RiVUxUblg5RGt0MXJW?=
 =?utf-8?B?bC9HNzRCZ0k3NytGOHNoaU5DL1VpSTdiUi9ZREg3NGpiQzNid1Y0MHIwcENh?=
 =?utf-8?B?ampHalIwaUtaM3BYRFhYR0F2QVNxdFlpUy9JMjhLWEdGMlI5V3JENTRXYXd0?=
 =?utf-8?B?UnJOYU1vTHdLU2dDOHVCYlVtNndaZUZLcW53Q2NCMDU2SHMzbDdrR1l6b01D?=
 =?utf-8?B?L2h2NG9rRGVJNjNleUxmdmcrLytiR2kxcWhoVjRZSWdOQkljUzdqbWsyaEhk?=
 =?utf-8?B?ZlZYeUhHQmVvNzFXQVBlNzNlbUwvbGdpaVlQeEFUSklDd3JBQklISmtZeTFy?=
 =?utf-8?B?ZHY2OGhFNVpjMFNKRUFlakcrczBpUENBY0FuRDhRUFNDdnNRRGhOOTNHc3Bp?=
 =?utf-8?B?Y1Rvclg5cmVIdUJ3c0REM0tiYmFGSndvd2pBNzhVbzFFYXhVdlFLUzNhckJS?=
 =?utf-8?B?bXdFMHRubmVLOXpEUTlPSEJUbGlWSGpwQU4vWUc5cXBsVEpXMnc5ekdZWDdC?=
 =?utf-8?B?bmlWakRKVGVQMVBkcHJyakExSndnTWpOS1cvQmhlVSttMnVRTWswVDhOelIx?=
 =?utf-8?B?alNpR2pYRGNJMXR3MWhxSXMxTU13VVV2UnJ0U3pFemY4U3NpcDhZeXJ0WWw5?=
 =?utf-8?B?VWRNQ1VZM1FrVm55NjZ4ZW1zUXhxNE5xLzdhb0lSdTgyRGVHL3o2NjRndkxi?=
 =?utf-8?B?UU5RQnJZUTNCSWpGUlJ3NFZ4cnlMemZleGxoOGd1bCtXQnIyQVNtN1hxNVpq?=
 =?utf-8?B?T3I4Y05KRDVrNlVnTzZLRzRwWktLbjVBbmVsQUZNNWhDVnZkOVhEVnF0TDNH?=
 =?utf-8?B?RWNPSXdiZzBYc1pQK2JlNGlWYTh1Rm5oOUFTcnhWR2pKVWRWWHY5em5YRGdv?=
 =?utf-8?B?cHJrdWdZTjFpdlJoZXpPalM5U0pOUHhVdURtRXFzUGZZb05BMUg1R3VUbE9D?=
 =?utf-8?B?YUlIV1ZYZEhlRVd6T0xURjdPNERUb0hWanJYc2NmdmkrNERHUGZlNGcrb3hr?=
 =?utf-8?B?d2g1V3cwVHRQZldQRkt5b1huZzVkMklRejQ0dUdRVWtzWWNhOTF0b2FjdTg5?=
 =?utf-8?B?eFMyYlJYTGp2dEVDZy9EV3lYMmNCV1I4OE0yZE9ha1JLOG5kOGRjTndRUjQ2?=
 =?utf-8?B?aUxOU0REZ1JHNzRGYkFlZm5sZEpQSHcxMkRVY0RQZnI1SWhVd3dyTW92SnBQ?=
 =?utf-8?B?cnY0TkJvcWVDL1UvdHFWcjdwaGV0eEFsbUFqakpJNjNtSXpVTitNWGhEWkFH?=
 =?utf-8?B?Mld2YWttbTRYQUhaM0dDN3lnVVVNdHpLVXMzQ3Q2VXFhSEwrRGIzNFdlb2x2?=
 =?utf-8?B?dXdFZnU0MTA2R2VoaFduWlF2M1daTnFtWkZ6V3JDbS9GTEtSRTZ5L2dGNWQ5?=
 =?utf-8?Q?xAL0Rt3Mi7otHxEcdfikU7X6FldVSE=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYYPR01MB15132.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?S2MvR1BGVzNxWTM1emJhNm1XS05hdm5PdENXbUpKYjBjRWtaSk5mYUZsK1Rv?=
 =?utf-8?B?K29pdXYyaVNvbTlRM3ZYMks0dGR3RmdMekVNYU5BaStlNndQNk5IT1prN1Y5?=
 =?utf-8?B?V05EbDBscytlVXQ4UmRHcnJtYVJaMDBTTU1VKzJGK3hjdVdEWkNxZzlBK25O?=
 =?utf-8?B?M3RQWVA3VmFrTDRZM2NVVnhEb0k1TlphVnFXV1lQUHEzT1E4b21QSnFHTkRW?=
 =?utf-8?B?TWVFZ3VZc04vUFN5TEkveHZsaUNjQmJ3UFloM0tBWVpPdFdsWjR5R2NndWhx?=
 =?utf-8?B?cGF3eVkrV1VpbjJweUo5OW9qamNydkFGVWk4MHc3V0gxa3licWlwVUd4NTY4?=
 =?utf-8?B?NzBuaEdWNGpIV3ZHRGNjNkFmZXFWSVAxUzYxYkV3dUhEVDVOWlBjUSt1Mi96?=
 =?utf-8?B?aWllVGhYcGFMZVl1ZlMxc08wNjc5ckwrazYwOGxlbGEvOTd2QmtzcFllWFd0?=
 =?utf-8?B?Wk16cEdDY1pYVlluck9xb1Q1RG9LSnFpK0kxVnZmRDVpZUdPT3h5a21GQ0ow?=
 =?utf-8?B?YUVlVmVmTFM5bUJIeDVtcHdLWTRRSVpFaTUzNGk2cGtqS2FGRnRwMnNyNE1u?=
 =?utf-8?B?aGF4enFyNDR6N3lCRDRPZnRxR1hpN1R0aUwrTlQzc0hadXo3M1ljRmh3d2Rx?=
 =?utf-8?B?ZjRsWTBTcTlOR0NFKzlXeDkwdldJY3RCMEdZUzdMRFIrZ1ZUYVJxellMbEQv?=
 =?utf-8?B?WVhoSjZlVkh4aWNUNm1jSzFuNytQaWtBcDA0QWdNd2pTUWdqZ0o2UG1PUGV1?=
 =?utf-8?B?bFlkWkZLSGU0bjJ1SHExNWo4NTBjcFNMbHpQQWZOSUhyN3BnMk9WWWpKdE1K?=
 =?utf-8?B?aUhPRDBWU1ZnWHJpNkpFaDJMUGJrZkkwdkpWRGZSd3RmWk9naUVIL0l4Ykgz?=
 =?utf-8?B?YVV0RVdNSVV2Yk8wazN1am1TREhnN3kwYkdvN0FLblhNNnBQNmNkZ2hzTjRo?=
 =?utf-8?B?bUl1SGFTcUdrdzhId0U4SjNJTHQyM0hubUZTYTdRTlJ0c29ZemlMQno3SEtk?=
 =?utf-8?B?Z05sSHU1VkNwMjhrbmZPTTMyZTJCUkhzY0F3ZlozTlFmMnk3NGdXZXRGclBP?=
 =?utf-8?B?NS9sNEtIWTIzWjl0bkw0dUdodXQvUlBUUFlaMktTeGF1U1BIeDRWT0p5Qzg2?=
 =?utf-8?B?dUFzaSt1bkwweGJ6Y2xUZVV0MFdCRWFHMS9ybzNjdi9TZHVJNFBEbWh0a1Jo?=
 =?utf-8?B?UDBDcXN4Qnh2bkVvWUUxUno5eE9OWllWelJJRXEzSjBKSEh5cFJ2bG1UcGQ3?=
 =?utf-8?B?Ni96ek9COTBlZWpWTXBscmswT1ZmbGprOHkwb1FxbDZkTGF4MjFXMzZMOTl5?=
 =?utf-8?B?MVVNdnpRMmQ2a1Q5Sm9BajBlQlpadFZEa1RLNU0relN1UHl6a0dzZVUxT28z?=
 =?utf-8?B?dzZHbTNUNkVsRThCb0RxV1VHSElWVUtZcVVKL0Q0SXFIajZ1WG9wY0tuTzdY?=
 =?utf-8?B?bUQ1NXYrb0hzbVF2Q2NOelZLVDZPV2hhR2tUcTJBRGRRWFA5clVxaEtZYnJ0?=
 =?utf-8?B?aHJ3QzhidjhISHpzTTFudmR3dzZ4T1hWR2VPei9tT2lFbjZNeTRCM1dmQkdj?=
 =?utf-8?B?LzdhbDE0RE9vQmtnRVJHTjN0VjcyZzlOckxQaEhDNzRyV2RoTGJoeVhzc0Zp?=
 =?utf-8?B?QXVSLzNMcDRKNGM2WWdHb3hHdHpBZHVPbkNGQkxQYTJUZDBGZUgzWVM3WlF3?=
 =?utf-8?B?Q1BhZVJtbnNGREhNK2Fxc0g4S2hieWxrYjNNQ21pbEhtRzlhZVpQYkpWR2Q1?=
 =?utf-8?B?ZU9nMFhUUUJRMitBWHowc3loQnYwVzExRis0ZlR6cE1qb2NqV3RrT1orS3hv?=
 =?utf-8?B?T1BRQXFPV3FyOWVBTU16R2lqRjU5K09ZdjJRWWkrTHdhU2d5VjQya3YrTk5U?=
 =?utf-8?B?OUc2VmdTZnpPMzR0ZzJzc2Rvd0dTT0tCTnJFMGJXVzhkVzVIckdIRFVHOFZ3?=
 =?utf-8?B?Q3U5dU9CVVBUdHpFWnZ0ZUlFemU4cFRjbXY2RGVDVVZtM3BtNzRoQVRlVnNi?=
 =?utf-8?B?YkR5SVJWVjkvdFNtQkJrY1pNWldIUEhxRVJmTjA1N3k0N3JvbVFmS0xYVWo1?=
 =?utf-8?B?TzhObHFEUmo4TkxtSGVnMWdCWFE4QkQ2cG5NNTZDWlBoQXRIb3pYN3hBK01l?=
 =?utf-8?B?TDM5ZHE3UHFZSlZpb0lFTFptczJFSUtsblo3MkhaVnYrbFVMVkl1dFdmaXl6?=
 =?utf-8?B?RlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYYPR01MB15132.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98a97731-7df5-4192-3abe-08ddb25688f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2025 13:04:49.0446
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r/3DVQUJd2jnZo9kuNXNk6s2LrMFWwoEtwzEO01i5AVPRI+gMqi5+zhQKuEm7IAcYV9EDj8rvRwSEv/UmKemXPQgv8cifjZcmezgEVlgUKQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB16213
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 23 Jun 2025 13:05:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19185

SGkgSmFuLA0KDQo+IEZyb206IEphbiBLaXN6a2EgPGphbi5raXN6a2FAc2llbWVucy5jb20+DQo+
IFNlbnQ6IDIzIEp1bmUgMjAyNSAxMzo1MA0KPiANCj4gSGkgYWxsLA0KPiANCj4gRllJOiBPdXIg
TEFWQSBsYWIgaXMgY3VycmVudGx5IGRvd24gKGluY2x1ZGluZyB0aGUgb25seSBNQ09NIE1UREEN
Cj4gZGV2aWNlKSwgYW5kIG91ciB0ZWFtIGlzIG9uIHJldHJlYXQgLSBwZXJmZWN0IHRpbWluZyA6
KC4gV2Ugd2lsbCBsb29rDQo+IGludG8gdGhpcyBBU0FQIGJ1dCBsaWtlbHkgb25seSBsYXRlciB0
aGlzIHdlZWsuDQoNClRoYW5rcyBmb3IgbGV0dGluZyB1cyBrbm93Lg0KDQpDaHJpcw0KDQo+IA0K
PiBKYW4NCj4gDQo+IC0tDQo+IFNpZW1lbnMgQUcsIEZvdW5kYXRpb25hbCBUZWNobm9sb2dpZXMN
Cj4gTGludXggRXhwZXJ0IENlbnRlcg0KDQo=

