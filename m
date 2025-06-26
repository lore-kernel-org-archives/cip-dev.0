Return-Path: <chris.paterson2@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62FEBC7115B
	for <webhook@archiver.kernel.org>; Thu, 26 Jun 2025 08:25:21 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.26])
 by mx.groups.io with SMTP id smtpd.web10.3567.1750926305781530997
 for <cip-dev@lists.cip-project.org>;
 Thu, 26 Jun 2025 01:25:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=mDn7LH0S;
 spf=pass (domain: renesas.com, ip: 52.101.228.26, mailfrom: chris.paterson2@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ihm1q/rSPi+Vsdi9S92tiWNeDN1iqxoMBl2vQgWObm0ZFTmQjsVJ4cuK7sh7g+XqHoMtznKqSn362Tk2hgvQwTGiqAdporaXwhp3vCDJpV7KRuVv1M2Z8uwoiiCL2zXVo3/Sdwv3UX+9w8cuLGZ12yFHf/OmEi/Hg5ylOdcseMM/6tItGtjXk8ra5rSbv1G0xYborqG2azg9walFGRDUjf9imw0mELone+q+kSr0OQXp1nUy/to8xUX27UKFbyAHuWULXDs4g7105gFNSu7aGrekcPhfig15UinggnLB9kITzPAJLnCtv05l/FB/lPL7CVEJzchycLC5yQVFte1HcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o9MIJsXC9DdxXMhW6Ee+UVuTYC646nzFHrDfJKxNr8c=;
 b=Vyt0AJ8n+EG20kOju4lcK3M5I1nh5cECuort7ihrCOjrjuCTD8XAXzOGoIxI5Jm0/+h7+TDS3Xsy1jiUQNSuXgDeNKkpPGtZ63djFkZmIqpPFDN/wjCwiYqOnw/XsBBe67Ryxzk5USFQsE8jOWqP2xvWTRdmdZnvRU3e4kC6WkK2Xs0ARckqkotY/yhBgWaewW6PyOpX+uCWtMm19vDZWaG2fwBubvBV0pFZTfzAYSI6UmnSnovbibtF98M7/lNiD+Hrwepv/9Rf8S4+v6H1bLxiYgqQHH3kFgc7r3G+x18vwRIRMXVtTNLpnKH2S97CPYgAjIS83j1zWm3uh5kmyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o9MIJsXC9DdxXMhW6Ee+UVuTYC646nzFHrDfJKxNr8c=;
 b=mDn7LH0SWn5zkErQKRMYSN4lPz2GjW1llG/J2+OoPyc+p/Mywcy6Q+VEGQFqJBO78HFOOKuyca5I8rwkGhPUBwdCpewLfYbgss3PaGs8nDZ2q8MXLRSfBqjGBrDQiUPmxl4qSBSjvcdMqpdNx6Haj46iapWWmd1avd2TsIIPKQg=
Received: from TYYPR01MB15132.jpnprd01.prod.outlook.com
 (2603:1096:405:1a1::10) by TY7PR01MB13893.jpnprd01.prod.outlook.com
 (2603:1096:405:1ff::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.27; Thu, 26 Jun
 2025 08:25:00 +0000
Received: from TYYPR01MB15132.jpnprd01.prod.outlook.com
 ([fe80::3fd9:f47c:79c7:a6c6]) by TYYPR01MB15132.jpnprd01.prod.outlook.com
 ([fe80::3fd9:f47c:79c7:a6c6%7]) with mapi id 15.20.8857.026; Thu, 26 Jun 2025
 08:25:00 +0000
From: Chris Paterson <Chris.Paterson2@renesas.com>
To: Quirin Gylstorff <quirin.gylstorff@siemens.com>, Jan Kiszka
	<jan.kiszka@siemens.com>, cip-dev <cip-dev@lists.cip-project.org>
Subject: RE: Siemens LAVA lab down
Thread-Topic: Siemens LAVA lab down
Thread-Index: AQHb5D1eFfjh4oJC70uIQZZTi7d9RLQQtjNQgARmyYCAAAIQMA==
Date: Thu, 26 Jun 2025 08:25:00 +0000
Message-ID: 
 <TYYPR01MB1513207EFA03E9885D495F543B77AA@TYYPR01MB15132.jpnprd01.prod.outlook.com>
References: <b7e641b6-f14b-4e2a-932f-f123a549d39c@siemens.com>
 <TYYPR01MB1513242522DD7987EA384A6B1B779A@TYYPR01MB15132.jpnprd01.prod.outlook.com>
 <6788d273-be4b-4720-8a81-9458f360bfe0@siemens.com>
In-Reply-To: <6788d273-be4b-4720-8a81-9458f360bfe0@siemens.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYYPR01MB15132:EE_|TY7PR01MB13893:EE_
x-ms-office365-filtering-correlation-id: 1aa147fc-f52a-4fd2-260d-08ddb48af13a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?ZjBWNXdoTUdHQU5PMDdJNlNvVm9OUXpRUGF2TkZZV0dmTTErM3JlQUx4clE5?=
 =?utf-8?B?L3hseTVTMitKeTBoOGFLODg4QmFKaWJvd0svcHJlR2JzZjF0R0pFMjRQaXRY?=
 =?utf-8?B?d21DR2UveE8vNkpxYThaNmRiRlFpNUtKVXVGU2R2VkVTZlF5eEpnMjN2dXFj?=
 =?utf-8?B?L3pBQ1dUMjBnS3JtcnVpMjhkTkVsdmxyaGpTSTJOWUxQV2IraHFpWkVQS1Zk?=
 =?utf-8?B?M1ZXOE91b005ZXZZYk9rMS9UbWdtUjNSZml2aThhZ2FoUEpjbjYvY3B3Njdo?=
 =?utf-8?B?eGRlRlZCRmRweVhiayttMGo0VTd4VXp1Z2tBTlk1TUU5NzhQQkdraVVKcjc4?=
 =?utf-8?B?S3hpS0pBM2JObWNFQ05BVGF0TmtpYTRSSjJ3Qm5OUnlCWUx3U2I4d3JkS1hW?=
 =?utf-8?B?dy9MSUV3Q1NIM2hjVnc3ZVJvelNqVkh5bFB1YjkrSHNZWVAvTW1JYXBJWTZ4?=
 =?utf-8?B?SUhjekRGT3hhNWtxbmU0SzlrbU1TK3Vac3gwdDNmdVpmSGpTWU9SaDJ1cUIx?=
 =?utf-8?B?WWIwbkxIeUFiaUN1UTJVTXFPd1ZnRlBjM05IV3pqckZKZzY5WFFTaWZpa3kz?=
 =?utf-8?B?cC9LNG16aEMwaVZGTmczR3h2TUdoNWM1YzJMMDNMSUlRU1BGd2wrRlpWQSty?=
 =?utf-8?B?OGdUZWMyazlDRmgzYkU0WVovMXlBVVlQVitocUtQWXQ3R1JUeHA0VWdQUlhZ?=
 =?utf-8?B?eDh0Si9pdVpCRURsZis3WHg0dzBqZlltcFI3VXlIYWFVS2hHVWJUQ2IraHNC?=
 =?utf-8?B?N0hoYmdCVVZCT2t0djRZcmF0aTNhMVErYlFBeVBPRU5pK0ViV3VaVUdPTUtk?=
 =?utf-8?B?K2VxcUxtOFg1S1U4VGhmOGphWWIybndlWGRzOE90RVpERUY1azY2d29FNnlq?=
 =?utf-8?B?Tmlydlk0Ykd0eFI3UHlrb29WZkt0QlRaZy90YldrcE9BcTIrc3pabDJsNDd3?=
 =?utf-8?B?VVA5Y091QnFnQjNXY2doM1Bjdjd3dEQzcU5Geis2ZCs3ZVVqR1VMNlJxMjR6?=
 =?utf-8?B?cytRWkJUSmdxWjNtdVJoeDZDNnZna2h2eG9iMXp1M1FFWW5VZkpSYktzTjA1?=
 =?utf-8?B?cUQyU2tLVGNNTms0WVhXa3FKdERLYUhNWGF0QjBCbjhSbWQ1NXkvWnpONnV0?=
 =?utf-8?B?bFpMQ0dKbFA3OFhwYjBqalNHYS9RU1hRV3hVZlg1RjBuVDBhQ0ZpNTVwSm9U?=
 =?utf-8?B?ekliYWNyaWxRVjdLLzRhV1JaaUhrZ0kzRzVCTUxER3h5U2hDTHhhM2hkL01u?=
 =?utf-8?B?aWMwWTNsWVhwd082dXVrWHlEd2dTckdSMms2bDJLbGFDN3FpS3owUGNwQmJS?=
 =?utf-8?B?OVhZZjFtSHFtUlp3Y2l1UzV5QlJEYU5xZzZrTyt0Qmt1U2tGS2Zjb3Exc2F6?=
 =?utf-8?B?dC9UeWNMeXBBNFpFdGZ0NGJpcUR6UlBJSDRDa1BZK0IxM2pFQmlrZzNsQUZt?=
 =?utf-8?B?YnpSM2hicjZCN1A4L29CRG0yWmh5KyszWFQ1enFCZ0ZZd3NkdThRMm5ZcWNC?=
 =?utf-8?B?ekg1allXRDAyZ3NLUUIyQ2JRcytMQ0YxVlNoYTVuL1NKR21tMUtzQUlUbG9n?=
 =?utf-8?B?WjgraldPT3VzMTZyeGdEN0J3TmNuRmJDZFhkOTlOb0tBeXJNdTBVelpKZGF1?=
 =?utf-8?B?QU1LZmJCcngxQ1lad0lPZGg5ZkpjdXFkeWNra0R6MkZjRHhSSWNGYWNJcW5M?=
 =?utf-8?B?ZXFtVnlONlc4dWZ6MkhtZFZua1pxT3JPOHlaSFFJYTNBdTJQVHRUY25MRnB6?=
 =?utf-8?B?a01tZjJIdG5sa25kSGtGeDRGN09WL2FSMlBBempVd0g2eGx4QTIxTS9JNGIy?=
 =?utf-8?B?UVhPRkhwZGF5THBncTFmYjhtWUhxcnhXL2NVTmxDd0VRSTJST2JJNUVlRnR0?=
 =?utf-8?B?S3F5UEFDT2JSRVpZM0hFMHEwTURwMWFZQXhaaS80bUtKTEZYNVZ3UFFnYndq?=
 =?utf-8?B?QlY3TDBRSTJ2R0RXenUvQ2xzRCtMQ2h0TEYwTTkzdlphNTF2Z1VSa21xbzBm?=
 =?utf-8?B?NTEvR2pxdDFRPT0=?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYYPR01MB15132.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?VXpZa3hIUzV0akVHdlVpUFdZYkcrM0hLd0dnaCt4VElyeWZKR0c5K1I5SGhB?=
 =?utf-8?B?Mm5qbDV1Uko2Yjhia2lCZVhnYVBlVUpwUHBqRmJ0UERzU2ovVXl2TVZZY1NY?=
 =?utf-8?B?aVFLNjhTeDA0ZFF1Mi9BS3FSelZ5WE9KNXBwNUcvN0dnYTVCVGpidzZTNUlu?=
 =?utf-8?B?WmNPZTFmaHpOM2owRkNMTUtVMEpHc2JFWXV2S0tnZEkrbHB1K0dIUnZGTElm?=
 =?utf-8?B?TXZiNUFzZGhqNXJVQ2JOS1h1bnFkbXNQU0w4OVAzb1ZiaFQ3R0FPUUhCSVFq?=
 =?utf-8?B?VGlybnhydkl2aE1zUFZBbzBxNVZ1aHNpOVB4LzhGSlJ5YXE3aWhkeWM2bkl6?=
 =?utf-8?B?ZEZzcVpOdGc3S2pTY3llYkJPdzYvSUJGeU41d0xtM1FzbVd0bzliTFVyWmQy?=
 =?utf-8?B?V2MyR1BFakFKYXNHVm8rOGJjekdrd2R1OUQ5N3JOSmpZMkszc0t3aDltL3pB?=
 =?utf-8?B?bkxnQy90clZEamNpNEhZR2syNUJ0bUJFbmh1bjdkeTZGTC9FT0EzYkhuOWZN?=
 =?utf-8?B?L1F0Z3RJVzR4OXExZWhhNzE2cWdMSENWMW5ZdC9MWFM1OVkzN1Z6bm43M3RQ?=
 =?utf-8?B?cTNvSG5jaWFqc1hWUkh0VHVXcUlZSEtGSGU5OTc0dDVJbi91a3o3ODJQWjQ5?=
 =?utf-8?B?N243UGZWUXFXRHdXb1NIT1pjWkQ1THVFd2NwMjNHYjhwOXdpcnFybVJOQXBp?=
 =?utf-8?B?OTlhQk9UdzUyUzhVVSs5cGxUd2ZzWitxV1p2ZS9pODhJNlkvSE5DNThDenha?=
 =?utf-8?B?c2ZISEp4eHlMZHhPM2pvZENoL1NBNll0K1p6VytHNXpOYWpnTHh2Y3dNU3Fq?=
 =?utf-8?B?Q1oybDk3VHo0NU9CNlJlTy9UVjl3aUI3c3hmRlprYmRSOFdIdXNoU3BpWlBu?=
 =?utf-8?B?NlgrdUhxZjI3WFZjQjBIZ3pER0RuK2tCeWtVaHZ3U1hzNm0rNVdZNEFyMUh4?=
 =?utf-8?B?ZTM4cVRrQ1NCbU0xTlU3V0J0TDhXWWpPaTVBYnEzVnlnUHBkem1ZaDc0NGQ4?=
 =?utf-8?B?WjVwVmtlak9kaGZ6NUo4bWlnQS9HbHFNMStpSFlnRGtRWTVMajdLTmFXOWJF?=
 =?utf-8?B?dEdRMk9VSndiY20rMmpteUhTK2lLN2IyOUZRN1ViNDFjRnF4Uk1KRlBEQlZ4?=
 =?utf-8?B?OWh0cGtOS3N1UlhtT1dCUXV5TjNzd2JyUUV1bEdUUitwMHhBUk42UW16WjlD?=
 =?utf-8?B?c3d2VzVqUEFGRHFkOW96RFJQVUx2MC9TMEV6cko1c0lWdXdkVTZ0T1Q3UGJ5?=
 =?utf-8?B?MGM1T3ZBQ1lveXJNdFg3LzVYYWZuZW1jNEp1SUZoNGtkYlFzZjFnLzZDNWpO?=
 =?utf-8?B?MXY5L2RRZ0lzUUUyUGtRdTBWdjdxcEpXNlpNL2tPQ0NQMVQvcEF1cU9NMXRm?=
 =?utf-8?B?K2xmbjlSajlUblh1L3lmTE1nYUpRY1JUbk8ydXJsZ1kyY0prRjJBclFGNVF0?=
 =?utf-8?B?R0JYNXF5cGNSQ2xvYzJwWjRoYkljcXNnTkxOeWNzN3JqdkhWMk1XeElGMTVv?=
 =?utf-8?B?MlBjdDVRcFZtQUd4Z0Jud2wzNldMSkZEUHd1NGQraURNVzhJQXJ3WThnQS9K?=
 =?utf-8?B?YkdDcWZhMkZqQm1KMjhhaVBmUDhhSEdvWWUwK0xYNHAycElsK05ZNlh0c0cy?=
 =?utf-8?B?VWdoZFJ2Tm9ONjdMbjd3VVZleGhLM01CZG51cGxJUmprbDA4S1hCSGk5NDdh?=
 =?utf-8?B?cDFCRCtHWDFOeEw0NHBXemtMV1Y0K0duWlQvRzlQVVdpLzUvOVFNb3NnNjBw?=
 =?utf-8?B?MUs3ZlBGblkwd0hZS245WjlMeS9KUUJxTjRLTndHYzFkQmxiMy95WVNVSWJo?=
 =?utf-8?B?eFN2eUpZZ1FiT2FmSC9vdTBScWhBeGZ2V0hpS21RbXkzek5WVVN3NXRWZnF4?=
 =?utf-8?B?NzRncjZtVG1DakdRUWMreDNCRm1XbzZWZHYwNEttc3FUM1dOVFVuTmZMQVV0?=
 =?utf-8?B?c0RNNzEyVTROYmd2YWR1ZmpTQ040eXBkS3kvZDNKQlNTTFE0WTQzaWNhbW10?=
 =?utf-8?B?R01iUHdYUVp2SkZydUsxQUl3M1JaTlZmQldYNndXMllxU3Zmd3Vkb1JlQzdp?=
 =?utf-8?B?WDJDTnhGMUJqa2ZGWVpuazdmWVlibzh6ck9NWlJHczZMR2tUSFFRbXNsMGY2?=
 =?utf-8?B?cWxabUU2OU1CaTdWV1Q2dGRwWElhM0RCejlxbVNmY2F2R0ZXWU4wbXEzZXc4?=
 =?utf-8?B?eFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYYPR01MB15132.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1aa147fc-f52a-4fd2-260d-08ddb48af13a
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2025 08:25:00.1900
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: djJLOL3E6DJKV24UcHN8KWC1jtddrMUFTFTZ6wxVrHCTayjFo4u4Cf0Lf7WgtGAsOv6z6P2ShBr8bFq5oYzthneV/WaE12yOaP4yZT6FgcY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7PR01MB13893
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 26 Jun 2025 08:25:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19237

DQo+IEZyb206IFF1aXJpbiBHeWxzdG9yZmYgPHF1aXJpbi5neWxzdG9yZmZAc2llbWVucy5jb20+
DQo+IFNlbnQ6IDI2IEp1bmUgMjAyNSAwOToxNw0KPiANCj4gVGhlIGxhYiBpcyBydW5uaW5nLg0K
DQpUaGFua3MhDQoNCktpbmQgcmVnYXJkcywgQ2hyaXMNCg0KPiANCj4gUXVpcmluDQo+IA0KPiBP
biA2LzIzLzI1IDE1OjA0LCBDaHJpcyBQYXRlcnNvbiB3cm90ZToNCj4gPiBIaSBKYW4sDQo+ID4N
Cj4gPj4gRnJvbTogSmFuIEtpc3prYSA8amFuLmtpc3prYUBzaWVtZW5zLmNvbT4NCj4gPj4gU2Vu
dDogMjMgSnVuZSAyMDI1IDEzOjUwDQo+ID4+DQo+ID4+IEhpIGFsbCwNCj4gPj4NCj4gPj4gRllJ
OiBPdXIgTEFWQSBsYWIgaXMgY3VycmVudGx5IGRvd24gKGluY2x1ZGluZyB0aGUgb25seSBNQ09N
IE1UREENCj4gPj4gZGV2aWNlKSwgYW5kIG91ciB0ZWFtIGlzIG9uIHJldHJlYXQgLSBwZXJmZWN0
IHRpbWluZyA6KC4gV2Ugd2lsbCBsb29rDQo+ID4+IGludG8gdGhpcyBBU0FQIGJ1dCBsaWtlbHkg
b25seSBsYXRlciB0aGlzIHdlZWsuDQo+ID4NCj4gPiBUaGFua3MgZm9yIGxldHRpbmcgdXMga25v
dy4NCj4gPg0KPiA+IENocmlzDQo+ID4NCj4gPj4NCj4gPj4gSmFuDQo+ID4+DQo+ID4+IC0tDQo+
ID4+IFNpZW1lbnMgQUcsIEZvdW5kYXRpb25hbCBUZWNobm9sb2dpZXMNCj4gPj4gTGludXggRXhw
ZXJ0IENlbnRlcg0KPiA+DQoNCg==

