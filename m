Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9D5ECF64A1
	for <webhook@archiver.kernel.org>; Mon, 30 Sep 2024 02:12:16 +0000 (UTC)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (EUR03-DBA-obe.outbound.protection.outlook.com [40.107.104.45])
 by mx.groups.io with SMTP id smtpd.web11.3751.1726473566231253508
 for <cip-dev@lists.cip-project.org>;
 Mon, 16 Sep 2024 00:59:26 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=ouiRdP/i;
 spf=pass (domain: siemens.com, ip: 40.107.104.45, mailfrom: felix.moessbauer@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UZ3FsTgHSSd3nOLFN/7BtPxM8nLAsyA/LDJk8aq19pXShe6t45OOSBbA7NpFz1/1p4TodrUub/E0FaO8lzYt2R4MJXMSiH0B2clrSeM4EDT07PAyBxIaqeeCkN3cNLxY8sRFX1TY1+py+Jq49zon7nbqwlFJoD74XMBrAvX3coxocld9KUSkaRM0T9HBCpF+9GHaEWxZsg1lr2oPbayD0jtxXWANWkegCJwIB9ogntQYGv5Yh8vuO9gzkTDbyMBkkroiWMdo3pImbJsC4ViO3Igki181cQtHHeyQxszuVRoebJwU96h2IxF6AQMtEIXOTbz5r5WcyQnfJ9UUUfpRqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dZGMjuAmf9OCxtMX82+xus0/D4b/lVu6YY76zUPm/mc=;
 b=sxTSFrTKYXXUujfwOfqjgMYOEECOHBuaO0zx9H0YJH+Tpmc0H6JBAFZg8l91vsbofBAnjDvZpPMTlcvbRuU2c2QN1fyE8qgBPKIdY63oiXTpi1/fAS7XjOOIAzpsJZE98y8oLA4x/hfxZsRlNvUT6pL8ilaNgFFQAnagXstoR+wuMaWSK411QQHqGAm8DoEgrBxjK4F0SPrMJ0o0XbMQ3gW9nvTaqq0XmvtuLdJLDQgitLU7HxOYjU65bd70eIKlZqLEiEbqD03wlSLt97rKf8JT93HMpYZkQ+0J2kQ3nyMfp0h5pA6w9LKwzWOZJkZEJZG9oAgIEAlRdC5tI22p9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dZGMjuAmf9OCxtMX82+xus0/D4b/lVu6YY76zUPm/mc=;
 b=ouiRdP/i1or4011I70CqC7+SzEhMoGI4/3PHIdmr25UiUDdAQH7BboN8beIJMNTUH1HwkrLi2gjfIAsTFlz0n7t8MjmNvmmqjcIDOk4NkRM+LcXVP9hvRRPe80Uy7k/MIIblvb7IK2RPayx2XJZlSjs3rNoDL4hG91nzwfURj+ww1UXm8pb1VdseU96sHkLdV+fvTdIUV1S+6qaTCTaNvRsYpAxLMti7YgyxAjQGCC91JrRiuehuP3UtwpjLA/YdATqfF1hMSBlwU1sauwkcLBk0xHyb8DO/iN3g1wgriGDx70rcqZPm7ZST42Wv6Tqz9tiCs0b8ZhMLkPVejmdAJQ==
Received: from DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:47f::13)
 by AS8PR10MB7562.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:53e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.24; Mon, 16 Sep
 2024 07:59:23 +0000
Received: from DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8198:b4e0:8d12:3dfe]) by DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8198:b4e0:8d12:3dfe%4]) with mapi id 15.20.7962.022; Mon, 16 Sep 2024
 07:59:23 +0000
From: "MOESSBAUER, Felix" <felix.moessbauer@siemens.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"quirin.gylstorff@siemens.com" <quirin.gylstorff@siemens.com>, "Kiszka, Jan"
	<jan.kiszka@siemens.com>
Subject: Re: [cip-dev][isar-cip-core][PATCH v2 0/3] Separate swu signing script from key
Thread-Topic: [cip-dev][isar-cip-core][PATCH v2 0/3] Separate swu signing
 script from key
Thread-Index: AQHbBPuJMjMf5p8ikUu0oN4ZGW7EQbJaErYA
Date: Mon, 16 Sep 2024 07:59:22 +0000
Message-ID: <5834a00637150a19a160c87afe820fc090f3c683.camel@siemens.com>
References: <20240912100710.3183806-1-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20240912100710.3183806-1-Quirin.Gylstorff@siemens.com>
Accept-Language: de-DE, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.46.4-2+intune 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR10MB6828:EE_|AS8PR10MB7562:EE_
x-ms-office365-filtering-correlation-id: 22316c72-d674-4797-3a10-08dcd6257a16
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?UE0rZXhFVkxCSGFrTklSVU51TFp0OCtURXNsVjFlTGpicklSaFFiSUIzaWhH?=
 =?utf-8?B?cjNPNHhKTnpjK1lpbm40OUxyOW1WdkZ0aUZHZEExelRxS2JUZFppanU0MVky?=
 =?utf-8?B?WHNxRG5MelVJaGhqZXN1ZnYyMVZ4SEpRMXlseDQ0RjJSWXFRMHZ1a0hCOXRJ?=
 =?utf-8?B?T1M0ZHZPWFZtVFhXaVd2d01NcmVNdkozdWV4cVhpM1ArUWpCU2N3enpUVFYv?=
 =?utf-8?B?UllVOWxaTnBMWnoyRERNTFdmTkZXbTVKd1BFZitFUUgvcGFqTDloYjh0bGZr?=
 =?utf-8?B?R0NsVDMydFNOWm14dkxtbzM1WWU0NEcyK2xON0Y2ZU5EMmlyRDJmZDk2djcy?=
 =?utf-8?B?T203VmwyRXMxYVI0WnR3alE5bVlCeEZrWWh1OE5pMUxjWVQ1Zmc2djlsUXFh?=
 =?utf-8?B?OHR2K3NXb3Z5WGhDOVFtNG9wRE1VMmw5SXpRYWR1cWsveStNTzNyaXJsTUcz?=
 =?utf-8?B?MnJWSHRWZ2JPTUtvN0Yrdm1wWmZrTTFuZEd1dUtFYitIWjBpMU1ENHpjR2ZY?=
 =?utf-8?B?T2NlUnExR3h4SWpaUmFTSkhQbm56dndNVWd3NThHUUlLVlVzeHBNVUhwT0Vy?=
 =?utf-8?B?R05vNTZRUndudjlyOFZyVHdHay9jcjZJLzFyeWdsbUtQcmdPRi8wRUsrWFpN?=
 =?utf-8?B?MEhoYnFaZ1VUUGJTVkxIMGpxd01JZHFkdHgxaXdDZVNzWXNwU1RTUTlqNVlT?=
 =?utf-8?B?OGNzUGw0YlhVZFYydFRnWDBuUHZTSDBoWmFQUnkyVWtoSVZxdGVrbG1RWFVW?=
 =?utf-8?B?SE1aRksxN1hWNEltTWZWSGlIeXlrTnJvckcxMXBsTnBjL3ErclBHMUNSUDJh?=
 =?utf-8?B?cWo2ZlI5REpzOUtLanBtZ3hhZi9QMFFCUVRuZHJwQmxhWXJTakFpTER4bG9X?=
 =?utf-8?B?d3hnb0NhTWFNNG9HMGVVaDU3QkV4VHhlQWxnNVQ1eDF3L05RN3RwT0l3eGFw?=
 =?utf-8?B?ZHMzZFJsTXB3QmJKT3hCbnFFaGZoOStaZWpXNWUvUDB2NUxzNXNiTGlmUS9u?=
 =?utf-8?B?T3lYZXNyRzZWYTlGK25qeUlscFR0bndqSFk5UlpMOGQrak42ZDRITjlTNkJR?=
 =?utf-8?B?MTBsdDgrMjRWYjJhQ3pXUDdjTElhZ0svaU01TE5talIrSGIxNjAzWnFlMk5M?=
 =?utf-8?B?cTZzWnk2U2F0Ni95alpTK3d0MUtaNTd1MmpxVzl6N3hjaTB6dmhXWUNnVlJl?=
 =?utf-8?B?TEw5cXJNbTBnUlJINiszUVI5eHAzZ1pLSktsOFl5eVNISmMzdjhqWUpCYnFC?=
 =?utf-8?B?T0l3UllEbDRHZFNIbWdLL0N5Q2c3VStvUmtXem5oU3hTZlh1MWQ1a1J2QWZR?=
 =?utf-8?B?YVFNbHp3YnFuWnJkMkZHajVMWHZLdFU2ditRZ1JkVk95aHF6TW9tdk1TL3pJ?=
 =?utf-8?B?enh2Umw4bnV5QVNuOUNiNHhmY1lKTUZndVJac3RHT3pEVWFxbDFDa0pGdDVR?=
 =?utf-8?B?SDJ0NzJnb0htSnFpbzUxMk1YZGNUSlNRT0IvcktqWGdYaFhLMkxIci81d2Vq?=
 =?utf-8?B?MXg0Vkc5K1JBREdPYTFiQ2UwU2JBWnBnbUtQdXRWYkl6ZGZWTEpPYnVWMUcr?=
 =?utf-8?B?VGJNMkdEaGpVNmt1bU1iUEFXMytrOGprYWtxeXFMMEpFcXR4NEJ1UE9uMmZt?=
 =?utf-8?B?MGxHbVc1c1pPcU02bXdmd1BjOVVvUWg0dUtySGpuM2pKMXVjREU1Mlh0THB6?=
 =?utf-8?B?WXJkdFVhUjUzbVdZL0o5eklkZ3JhenU4Y2xnUUovcjd0ZG1GU0RzMEpiTnpP?=
 =?utf-8?B?bVdYUjF0WkdXOUdBRVdHeWJDbjZGWkExemx0bldnK3NOb0pWNjRJWkhUTlVN?=
 =?utf-8?B?b1FUeWRVVnp3bnh5SDBNV1NsRndzako3Mm1OanBtUDZsSHBIVGJEVGk4S296?=
 =?utf-8?B?QVZUSTduaDZwSUVwYzdBZ0NCbXJkN0tvaHhMQlVWQkZObFE9PQ==?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?MVl3M2I0YUhscU5LejV4UUpvL3VwMjdxdnJuUUxqQzJna3VGbEtpN1ZNUHdy?=
 =?utf-8?B?UVc4UzZrQ1dpbDZPRXVUYVVZUnBTb25RU1Z4REZEZm5sMGtoWXZjeVRJc3hE?=
 =?utf-8?B?Y1NxTUxiMFpKTFhJT3pWYmJFaTdOaDlHeWV5RzR3Rll5aG5OODF6bUNKRk1F?=
 =?utf-8?B?eVE5djZhR2JNSWp6NW0zOEdrQmhkaHpOYVlsTVNINDRBUFY0SWhuOG9yYUl4?=
 =?utf-8?B?NTN0bHBaczZ5bWxZVHNNVXdDYi9nZ1JJeDZTZG8vbWRlV1RHVytsVG0vc1Ja?=
 =?utf-8?B?by8wSXlsTkovUmJjK1kzeSsyT1BOQ0ZHdTJxbmF2RWJTSG1BTVhHd0lxYnV6?=
 =?utf-8?B?YU5EdXNSYU1RNkFwNklBNEJVRkxTNDhTT2Q1MWMwaHRObUFIUG5PU3dCWHM5?=
 =?utf-8?B?dEZtb0F5YVBrOVVqd0tlR1RhYW9jWU0xNElHRGMzQitBT3V0NUJ0TXVWRTN5?=
 =?utf-8?B?ZVB1ajAvSHNtUkNSSHA5d2d2SVFnS0hvMWprcFBpVTRRMmVtOFhxbXcvK2FB?=
 =?utf-8?B?NDBnR3V0a2FFMG1kaEczQUY4Y3h3eEw0cENYZ21kSkdHRDF0aktwODlTMjJR?=
 =?utf-8?B?RHJkYVppOUxkRGFQVWd1dzdWYUE4R1R6MkRqeGo5MVdCQnFQSlpOZXlueFZ6?=
 =?utf-8?B?VDN1UkVxendmZWk1Y0pyNmVpUHUwdEN4SEdzRWJHZTc2RGxmRVZCb09WeUVO?=
 =?utf-8?B?NGdMam4wQkl3bURxNUhSVVdxQVZzaGVKY3h1cWpBMElnaDVoN1pYNyt1SnhV?=
 =?utf-8?B?THJ6Q2VQS0xyTmJ0cU8zV29QS3AybldjRm9xVS9wVzl3bEVXdG16eXlXdktE?=
 =?utf-8?B?eWQvRGJLaFdrQnRKNUZENUxReHhObXBQRCt5QUc5dUZVOEE3bDA4ME1xU2xQ?=
 =?utf-8?B?b3NiMVdPNkI1d2xZR3FQcW83bnlVaUZkeWZHQkxBQ0diM1NlOW55OEhTNHkz?=
 =?utf-8?B?em5tZzVCc3VQWTU1dkVIVGRsYUZNS2RKb2pQcDZHTmwrVEN2VUlreXBBQ3pp?=
 =?utf-8?B?Q0kvR29walgyRzMxcnl6ZjZnWWNuOStuS2tsNkRLejduWGJoaEMvbjlCb1Jk?=
 =?utf-8?B?eldoeEVxQXkwZXUxcjhRKzEvTzJxWlk0aGNwN1hJTmVhNzBIM0RiRnNXdmIx?=
 =?utf-8?B?VHhkWjdkQkt1eHV4SEs1QTJudUpyTk1VVitmNTV4OGZ6bFhKcHB6cUFzMDJy?=
 =?utf-8?B?bmdaQjlyVEJFb0lPb0djT0Zwc3FIdHFlYUFPUXUrd2RhdG43VFZGNGpHVDhn?=
 =?utf-8?B?ckxvaW40YXJDc0IxeThzTlVmMFlhQ3hSYmo5SlpoOGhGSnlCTUhUYXdxbnBL?=
 =?utf-8?B?ZkxtR0wrdWkvRjJodHdJZzhqemdRWXFvU0dra1I0YW4ycldxeE1BWHJBU251?=
 =?utf-8?B?L1pLYkVaOXludEJHSFdBbzBvSFV4N2twK2VRYjQrTCtyWTVEb2V1eXNiYWdM?=
 =?utf-8?B?N2ppalVacU96N1pVRktHSXN3cWZ5VXlRS29BMVlUdWVZZ0IydHdsYlp0M3RY?=
 =?utf-8?B?R2ttOEgvT0Vzd29PMzQwTWNmZGY1MS84bzRnSHdYUTJlR3lUVkY3ZFZyUkRI?=
 =?utf-8?B?eXZXelZMUE11K1NSS0hDZEdzYTREK3RDSjdUQUFId25LUDRlNXFIUFRyT29B?=
 =?utf-8?B?d1hPSVFxSEtjek90eEpYVUdSaUsrZDZLU2lrS2tHeDFWaldyNGVSbnd1WjUy?=
 =?utf-8?B?U2FyVTRUd2tSU3BTSE5DcEVxR0hWV0NzODJRU3VTcWZRNnl0VkNNTEhiVXNx?=
 =?utf-8?B?eGxSUjlxVFFqVFV0SFp5Q2xIREdJeVhIdjltclhMWWRRblc4VlcxNy9uTnNG?=
 =?utf-8?B?ajgzNy9iWjNHZjJ0Vzl1eFhCeVUzcDd0MzdvckNScFBEN1Y3d3lPUDJhM2x1?=
 =?utf-8?B?K1RJdTMyeXRacUxQMFUxQzhJWGREemV6MjAwRFJYaVh2dXFaT29qMW5mdmdV?=
 =?utf-8?B?M1BPelBRTG1HUlcwMEFjRngwSFNEd3VTRmhoMVpYU3FEaGw1NExvWmlrSmI4?=
 =?utf-8?B?TUhKaDBDeHFxWThwYjNMdkFlamFFVXJaYU1NSU1tR0pSVlphcXFVU0pZeFBt?=
 =?utf-8?B?RzN5eEVlOVAxOW1ialVYR1lMTWVQcUlYSmtXblFwdU1rQWhvVEZ3UmF3Q0Mx?=
 =?utf-8?B?SXRadUlPdjYwY3g1RmVBaWFZc01uMkw0ekk2Y1VwNjZ6SWN5Y3hxUlowTmpM?=
 =?utf-8?B?OEdjUHFpcTN3aW5GMm9TT0xVUTc1bUsxYjgwMFV3SmE0S01DR3UzRDZLZ2NH?=
 =?utf-8?Q?zJFbSvouXtaAWwqiCsNrbv4KfsqZIEGeMf4VPkOWWE=3D?=
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 22316c72-d674-4797-3a10-08dcd6257a16
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2024 07:59:22.9997
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VOozoB+8CnKKqROJvePVfsU6CLZ0H0TCtKQ41cxE2Dgepkobkw4WG3nsjW2Kd57wTr3NVEYvEHBHgjbOIPxo9FOtT3SSo/SwaGR2zglnIyc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7562
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <9E1B314FDE6C0045BF2E2E95E5A2B26D@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 30 Sep 2024 02:12:16 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16929

T24gVGh1LCAyMDI0LTA5LTEyIGF0IDEyOjA2ICswMjAwLCBRdWlyaW4gR3lsc3RvcmZmIHdyb3Rl
Og0KPiBGcm9tOiBRdWlyaW4gR3lsc3RvcmZmIDxxdWlyaW4uZ3lsc3RvcmZmQHNpZW1lbnMuY29t
Pg0KPiANCj4gU29tZSBkb3duc3RyZWFtIHByb2plY3RzIHVzZSBIYXJkd2FyZSBzZWN1cml0eSBt
b2R1bGUoSFNNKSB0byBzaWduDQo+IHRoZWlyDQo+IHVwZGF0ZXMuIFRvIGF2b2lkIGEgZXJyb3Ig
bWVzc2FnZSBpbiBjYXNlIGEgSFNNIGlzIHVzZWQgdGhlIHVzZXINCj4gbmVlZHMNCj4gb3ZlcnJp
ZGUgdGhlIG1ham9yIHBhcnRzIG9mIHRoZSBzd3VwZGF0ZS1jZXJ0aWZpY2F0ZXMta2V5IHJlY2lw
ZS4gVG8NCj4gcmVkdWNlIHRoZSBpbnRlZ3JhdGlvbiB3b3JrIGluIGEgZG93bnN0cmVhbSBsYXll
cjoNCj4gLSBzZXBlcmF0ZSB0aGUgc2lnbmluZyBzY3JpcHQgZnJvbSB0aGUga2V5cw0KPiAtIG1v
dmUgdGhlIHBhY2thZ2UgaW5zdGFsbGF0aW9uIG9mIHRoIHNjcmlwdHMgb3V0IG9mIHRoZQ0KPiBz
d3VwZGF0ZS5iYmNsYXNzLg0KPiAtIHVwZGF0ZSB0aGUgcmVhZG1lIHRvIHNob3cgdGhpcyBuZXcg
YmVoYXZpb3VyDQo+IA0KPiBDaGFuZ2VzIGluIHYyOg0KPiDCoC0gcmVtb3ZlIFNXVV9TSUdOX1ND
UklQVCB2YXJpYWJsZQ0KPiDCoC0gcmVtb3ZlIHJzYS1zd3Utc2lnbiBzY3JpcHQNCj4gwqAtIGZp
eCB0eXBvcyBpbiBjb21taXQgbWVzc2FnZXMNCj4gwqAtIHJlbmFtZSBzd3Utc2lnbmVyIHRvIHN3
dS1zaWduZXItc25ha2VvaWwNCj4gDQoNClRlc3RlZC1ieTogRmVsaXggTW9lc3NiYXVlciA8ZmVs
aXgubW9lc3NiYXVlckBzaWVtZW5zLmNvbT4NCg0KVGhhbmtzIQ0KDQotLSANClNpZW1lbnMgQUcs
IFRlY2hub2xvZ3kNCkxpbnV4IEV4cGVydCBDZW50ZXINCg0KDQo=

