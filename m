Return-Path: <chris.paterson2@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65CF4ECE582
	for <webhook@archiver.kernel.org>; Tue, 10 Sep 2024 08:13:11 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.37])
 by mx.groups.io with SMTP id smtpd.web11.17742.1725955983257281537
 for <cip-dev@lists.cip-project.org>;
 Tue, 10 Sep 2024 01:13:03 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=gLM5TZ+B;
 spf=pass (domain: renesas.com, ip: 52.101.229.37, mailfrom: chris.paterson2@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DsQz1COsNiWqffAFITPfF4Nr7NVNVS2WgIYpunP73A+kndfEMD5msSh9g6ZGH5qQ7dq6oV0+5zRqLyJPj15NCWhU48Q4voXOXZsJwnxyPT/18H9sgGWFYokUmckydgjCG46b/f6d3h3Gxqo0CX1aJTYYsqzNiesO4SHpnyo+k0PUTZpMu+f3cnvn3KFaEMKwTV9QamRrQE8OB53rEBznWPB9kovygtAfgUcTRex6DIctWHU40z3kAECriJnjEaB9mE4v9k0upVV3iXHfemeuLr1d9ccG2AR/mTp6WOIJ7dLgjWoOU+1P61aZjG8G1TG6mBQLXX4K+3btLfESI9YfDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4PpVWk/MhePbDgEqxLe56aD90TJdyS5rqkgM80RGWSw=;
 b=sn6FXeH52Vap4OiWZtHKOOaEzO5TKX78YFb6JwnfnWyDV97t8j9VFs+626BVhN9CDjwX/I/8ogiaSWEqoQNonZU1jOG8EeilfcPSiCKnOhqBVsLt8aMhQaFj2B2UjO7O/06tdCe4KLhhqzkPp7sANnFOrl/nCfAgZ91VgBfl/PHJFjCzkVgI3d2w28LDImII43coilJqC+CGrA4D/v2X2AvTx0ZYhw/+sbXdc5H0o/hDuEhI4+bF8UWa3MfRtMdxJSosLSjERgUD1/5HiwUECpuCCGxEeBMiAaTggHiFmRr8MnYLGXbalixDvKdHHrqBnNSbqclVLEuwYWCVUVuagw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4PpVWk/MhePbDgEqxLe56aD90TJdyS5rqkgM80RGWSw=;
 b=gLM5TZ+BmTo1yWB8T4XoGTNjpVeCAbuMS4x0lubd69SZs90EBxMAYEVRCWy6OwHFXKj2Gf56jh8m3xjpiGo55GE0Vl4T5KsRxXaYgjh91xeh/Znsb5wZpbw8tlWr0CdL5bo8L5Q3yoTV0FbnsDT2OzeIhaYwRlhgn9HlDTRRb6o=
Received: from TYYPR01MB12402.jpnprd01.prod.outlook.com (2603:1096:405:f7::12)
 by OS3PR01MB9334.jpnprd01.prod.outlook.com (2603:1096:604:1ce::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24; Tue, 10 Sep
 2024 08:12:58 +0000
Received: from TYYPR01MB12402.jpnprd01.prod.outlook.com
 ([fe80::64e8:dbea:c288:5e87]) by TYYPR01MB12402.jpnprd01.prod.outlook.com
 ([fe80::64e8:dbea:c288:5e87%3]) with mapi id 15.20.7939.022; Tue, 10 Sep 2024
 08:12:58 +0000
From: Chris Paterson <Chris.Paterson2@renesas.com>
To: Gylstorff Quirin <quirin.gylstorff@siemens.com>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"jan.kiszka@siemens.com" <jan.kiszka@siemens.com>
CC: "kazuhiro3.hayashi@toshiba.co.jp" <kazuhiro3.hayashi@toshiba.co.jp>,
	"dinesh.kumar@toshiba-tsip.com" <dinesh.kumar@toshiba-tsip.com>
Subject: RE: [cip-dev] QEMU reset issues in CIP LAVA worker
Thread-Topic: [cip-dev] QEMU reset issues in CIP LAVA worker
Thread-Index: AdsCr4TnY+//JphYSB26Q1N8R60kZwApm4AAAADDwJA=
Date: Tue, 10 Sep 2024 08:12:58 +0000
Message-ID: 
 <TYYPR01MB12402090C6FA11A9574C6D267B79A2@TYYPR01MB12402.jpnprd01.prod.outlook.com>
References: 
 <OS3PR01MB61031B36A1BE2249B2F4CA2FC2992@OS3PR01MB6103.jpnprd01.prod.outlook.com>
 <84bf903a-bfaf-4570-af77-b424dd82e9f6@siemens.com>
In-Reply-To: <84bf903a-bfaf-4570-af77-b424dd82e9f6@siemens.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYYPR01MB12402:EE_|OS3PR01MB9334:EE_
x-ms-office365-filtering-correlation-id: e13defb8-0f46-4c65-56c1-08dcd17061ca
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|1800799024|366016|4022899009|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?ZmZiNkdHOHNpRS9mSkh5R1pXUktHQy90UW5TZ3g2dzl2Mm45dXE4QXBjM3JJ?=
 =?utf-8?B?cTZQUG9BcVZBNU1ZcjR2Sk5kTE1RK1h5eTdIVHR1bElkOUJNYklUb3J6cTRE?=
 =?utf-8?B?a2ZOZUJya2FzWEZOY1JFdG9tUzl1TThsTWtVeEtVWFlOTHRvYlhMVlhGVzVK?=
 =?utf-8?B?aXdhT0taZXVNZiswWnN4ZXUvK01SV2FqRmFlVzRDZnJmVi9oNXpsWmttQ1VK?=
 =?utf-8?B?emppaWJzc2RGSVpteVdzbzR6NU5nMENHY0I1RG44dHRDYm13SnUwR1RNamU3?=
 =?utf-8?B?N1lTTnVVTGRGaE92SWVBYTBnQ29yRVlXS0V4dERqeDZjVUFJVm1MM29kUU5P?=
 =?utf-8?B?SEhndENjYUJBdG5meWROenNVUS9manhLM3JqY05ReG83a0RNUFJrZTIxdEQ5?=
 =?utf-8?B?T2JYUHBTTE5PTUZrbGszd3ZLWjZER3hIaE12eUNwSUI3SGxSYUl6ZVVxUzd3?=
 =?utf-8?B?MVl6aUdKQjNSa2dXL2d1YnRreElJRkZQWWRlUEs5dFQ1VnVHbDdmQVpZZUJi?=
 =?utf-8?B?TGZURWhubWpJc2NyOWphUmRSSDk3WWJJZUNMb2xXS0x3ZXl2N1ZQdVVSazUv?=
 =?utf-8?B?T0VySVN1T3Ura052ckpuei9QQjBXMkJ4aHNISUVhbVd1QW5LZmt2QTFoNGFK?=
 =?utf-8?B?bEhBWmN4ZkgxZFdLRFd0NHFoNWVKQU1UR0o2VXdKYytGMWZVR1VPZlltUm9h?=
 =?utf-8?B?alNLZW11V0VIS1VMNVg3Q25UZ2IzVU9JTURJeDRpZGRWT1J5UU54VlNhaklo?=
 =?utf-8?B?aXBISjc5NjREcUwyMkhlMHVOV29UcUtYUVVGNU03QXhQU3JFS0Q3SHRTb0Fr?=
 =?utf-8?B?VzY0TGFzN1p2VU5vY3NBVGtzK3ppLzQxUnd2VUJVa0s5V1QvSmY1V005Wmxr?=
 =?utf-8?B?MDFyenc5c2cxOVZ6TFdUemVVdm4xY3k5V1JkbUpBa3pxcGRKaEFZNVJ2Uk10?=
 =?utf-8?B?VlZock1oSTk3RGhjaGxweTZ3NnczRThvMk5wSmptbmtLdktnY3pkWE5ZcFpi?=
 =?utf-8?B?RmZhRWZlT1g0K3BORkY3NDB4RTFLaDQwU2FNVVFjQXBGTVhyeEEvNGhhbm1y?=
 =?utf-8?B?bUZNTFJNZHRvcVZaUkppbnRsMGxmbXhvcU9SSlRIQ1dsRUk3eWRjR2JnVUxy?=
 =?utf-8?B?NFp3RVBqU09hdWg3dTF1bkFVeXhVcnlIYzVia1hMaGlwU2trVFBpdFptczA4?=
 =?utf-8?B?NFBNbE0wVXZ3QWpyUlVpaEJJeVgvZVBEbmZEdnZQNUYzN3FKczBvRXlQNlJF?=
 =?utf-8?B?eExvZFVUQzZzejYzY0JWUGVoUkVtNVJKVEpYcm5qMXV5aDBmZlBvbVdDeHpF?=
 =?utf-8?B?Tmp0NVdHVGNNczdwUmdoZHUxYU95V3AwUExzQiszRkdiR2t6cG44QitEZTVH?=
 =?utf-8?B?bnpWZi8zNnlOd2lrMlpiTFlGNE1MMEV6bXVCY0QzeFlnYlNPc1NlcFRXSnRq?=
 =?utf-8?B?OFFQRjhJQWN1SkszUE5vdDJEQmRmS3YxeHVuVHExUTNHVERaOUNPOUhndDBm?=
 =?utf-8?B?VGdDa2sxUm0zVEFXM1RSSGFzRjJpT0NJWUh3R1JaakxOcHZLbCtVL1pJek9h?=
 =?utf-8?B?RjVVOEtYWnRyZlFuamxrVlYxUmZqYS8xeWxwSUc0R1BmZ0l3MDJ6VlJNRFM1?=
 =?utf-8?B?bi91SGExREdrdHlYL3BTU1IyVHRFZUVkYmllakU2RDlVdUJ2TTFod0R2Vnpt?=
 =?utf-8?B?VEF5enFBS01mSXI5Y1ZMTTlRL1Fjb0JCMUJzdHRZSDN5akwxcWJpYndPTGVE?=
 =?utf-8?B?RTRTMDZrSUxuZkJwRHZrcC82Z0lCS25jQlJ4SEtZNTRpUDlhcTBLU3MrNTVq?=
 =?utf-8?B?MGZrNGVPZmpmZENaK2ZaZz09?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYYPR01MB12402.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(4022899009)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?L0J6Q0wrT082bmlpT0lVd3F1RlBwT2k1QWk3WWxXWURFTk9hUE5Cblh2OGIx?=
 =?utf-8?B?SFBFUk5RMW1MZDZDbXdyYUZMWHlnQzRJcVNHNVZwSVVOU3dXeElkM0I4emcy?=
 =?utf-8?B?bm1PbDh0VC93d1VyVnFGRmFMMk8rUGZXUkNjRUxPTFlKb1J2MjdQWGxTNExv?=
 =?utf-8?B?L2lzUktZOC9NTDY0U0ZpOFBYR1IyeVMwVWRkY3l6TC83YWRDdTRyV2gxaVpV?=
 =?utf-8?B?R2ZjWC9YTWVreWJOWGx6YzEya2s5S0NJczVnd1U5RGJDTElJci9rTkhmQnM2?=
 =?utf-8?B?QmJQRlA1UEFPTzhTQUFhaG9kOEhKeDB0TGJEWlhXZWo4bVNscEYvcjhpM0tR?=
 =?utf-8?B?NUFOUUNzM1kvNEVaYVNBeXc1RDduaFQ1NFNyVk9nSUhGUGNTSzVmSkZHZTlz?=
 =?utf-8?B?a29lem5XYWh5OEw1S3hPNDhHSUFWdnlLNVVMZVVQWnprN28vSDRsa3RrN3o3?=
 =?utf-8?B?eVlRd2JRSmVpSGVSc08wNUVBNWhGbGtRY0docCtYdVNTMlU5RjBPeHErM1Q2?=
 =?utf-8?B?dWIrbURQZ1FHd1NuR0h3bTY4YmFpVStnQ1VwVHZiUFJGQUcyc2Z0ZUhiTkQz?=
 =?utf-8?B?NDhiUHlVKzM1eVZrTVFILzEzaWg3VmJrWDdNcW43WmlDYk14QWNJWDV1dnBG?=
 =?utf-8?B?dVBrL2huL3ZsN1hIT25XRnIvc3dOQXN5RCtqSmphd0VoZ3ZnMnRWeXd6WVRB?=
 =?utf-8?B?TTMzK1MrQ2txWjhnMm1xTFEzWElLNUorTEVObDh2M1AwUTFzWWo5VjZuYnBQ?=
 =?utf-8?B?SzdUOWh1UEV1c0lwNVBEb1RkL2d6UEtFR2xqNkpzb3UvdW1EdUp5Umc4V3FP?=
 =?utf-8?B?Vlp3VUVJb1N6UWxvYSt3MTkwYUIrVXI0SFpoaVY5d3phOVU0Sk41TTc3ZnYx?=
 =?utf-8?B?MEN5SUhXSFgyMVRwdE4wUkt4MjBNekNhTUFuVDBiWElGQzVidElJRnoxQmgx?=
 =?utf-8?B?TFpiQmRXdTRqT056OWsvMlQxNm13Z3JXRElBckpBcDFyL2RCMjZBL2F1VHBh?=
 =?utf-8?B?cFJiQWxyOUUzZ0QxT04yRXR1V3lQbXVXYjVxMFk3bmZtRXhWR0tTeWxGMlQ1?=
 =?utf-8?B?dzlqSC9Uek5CdXpUNVVjRUxlY0FlZzBONmZZUzNzN3M0WDdYSWs3Skc4d1lv?=
 =?utf-8?B?R3BQbFlrMHJJR3BXYTdmdlRza0lHclVpZ1U2UHkzU2pRNmltRTVYYVFEZ3VJ?=
 =?utf-8?B?M0xRbFFWMlBza3dES1VqelZNdDFjUjQzV2pXbWFvaCtRZXM1WHhxRlJobjJX?=
 =?utf-8?B?RmdhVko1eEhab0xnYWNZTmtFOU85bFBWeHdZMmpSR2RZc2JSNmZYVXZqdnhk?=
 =?utf-8?B?QjNrRlk2UVN1eW9NbkQ2UXVUUVBydGVlU09VaEk4eitmdkpxY2J4ODVpdzRM?=
 =?utf-8?B?NWJic3NiWjJFQkRWcHNaNjVHYTBZUjRhNVR2NEplOVVJUmFIaGFsUmJEaE83?=
 =?utf-8?B?K3ordXYzaTdneEdDV3RqZy8yZTJseFMydHM3OWVBc0hVWVJYYU8wNGJ4UzZw?=
 =?utf-8?B?UmxsMDdVZFcrUVlmRWMwcDRRVVlic1VKcWdCb21wVmpoMWNIQTllbzl3cGZK?=
 =?utf-8?B?Q21ISm5KYkNsdFg1TGw0Q0o4ditGa3JKTHJvTXl5aUVJK3psdHJEUkU4S0Jk?=
 =?utf-8?B?MVFYV3BRYXEyamJsQ3dTOHF4WkYxQTAxY0hHRTRiUGovVUZmdTEyL2d6UUFn?=
 =?utf-8?B?aHVHcnRYeHhHaGtDbGVwRlpjZXQvVGFGb3I2a3VDQ0kwalVITjRWcW5lbFcr?=
 =?utf-8?B?K0dDeDRmT2pTM3N4ei9hZU9FbG10MUh4YXlCdEFCSUtTSXNSRlVsdUNHMzF3?=
 =?utf-8?B?c0ZyMmxvZ2RrRWpuUGFBQzNLaStCbVBvaVQxdUg4MFlFa05FRU1PU3lldFds?=
 =?utf-8?B?U2R5alJ2Z1hYYXdxVE9Kc3NnclkrQk0ybGN3VndPdWNYdzBRQXBlejdYTWZv?=
 =?utf-8?B?NTZrem10SjQvclpGT0x4QjUvYzFNeWtaaDB2clJia0RNa3dScXZnU0hHNU9Y?=
 =?utf-8?B?TlBEL1V4TmZSNnR5M0h2Q0w0TERraktmL1BGeUtCVFBPYmhSY3ZlbDhNcVE2?=
 =?utf-8?B?dVVSYzE0ZWVrVENBbGtvYmh1K0lNSm1KeVNNcHdCRUZmVTFWN0NSSzhROXJO?=
 =?utf-8?B?MGc4MEg1QXEzYjdLWTRXVi9RYk9tMGtZNjNWMlVjT01NeDhNOVBXMGxQZEpX?=
 =?utf-8?B?b2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYYPR01MB12402.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e13defb8-0f46-4c65-56c1-08dcd17061ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2024 08:12:58.6805
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RpDieOf1U2lGQkCgSb8mm+pLkEpk/V9SIT2w6HYwR8AUVUgzOTRrt5UGjndzoVacNIXuEfYd1C0TPNgNgicSj1lI+jH1BnMr4J0TYNZWTyQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB9334
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 10 Sep 2024 08:13:11 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16877

SGVsbG8sDQoNCj4gRnJvbTogR3lsc3RvcmZmIFF1aXJpbiA8cXVpcmluLmd5bHN0b3JmZkBzaWVt
ZW5zLmNvbT4NCj4gU2VudDogVHVlc2RheSwgU2VwdGVtYmVyIDEwLCAyMDI0IDg6NDkgQU0NCj4g
DQo+IEhlbGxvLA0KPiANCj4gDQo+IE9uIDkvOS8yNCAyOjAyIFBNLCBzYWkuc2F0aHVqb2RhIHZp
YSBsaXN0cy5jaXAtcHJvamVjdC5vcmcgd3JvdGU6DQo+ID4gSGVsbG8gSmFuIGFuZCBDaHJpcywN
Cj4gPg0KPiA+IEkgaGF2ZSB0YWtlbiBhIGxpc3Qgb2YgYWxsIHRoZSBmYWlsZWQgam9icyBpbiBM
QVZBIGFmdGVyIGVuYWJsaW5nIHNlY3VyZQ0KPiA+IGJvb3QsIHNvZnR3YXJlIHVwZGF0ZSBhbmQg
SUVDIHRlc3RpbmcgaW4gaXNhci1jaXAtY29yZS4gVGhlIGluY29uc2lzdGVudA0KPiA+IHJlc2V0
IGlzc3VlcyBkdXJpbmcgYm9vdCBhbmQgZ2V0dGluZyBzdHVjayBkdXJpbmcgZW5jcnlwdGlvbiBv
ZiAvaG9tZQ0KPiA+IGFuZCAvdmFyIGFyZSBmb3VuZCBvbmx5IGluICpsYWItY2lwLXNpZW1lbnMt
bXVjKi4NCj4gPg0KPiA+IEN1cnJlbnRseSBJIGhhdmUgbm8gaWRlYSB3aGF0IHRoZSBwcm9ibGVt
IGluIHRoYXQgd29ya2VyIG1pZ2h0IGJlLiBJDQo+ID4gdGhpbmsgdW50aWwgd2Uga25vdyB0aGUg
cmVhc29uIGZvciB0aGlzIGJlaGF2aW9yIGluIGxhYi1jaXAtc2llbWVucy1tdWMsDQo+ID4gbWF5
YmUgd2UgY2FuIHJlbW92ZSDigJhzd3RwbS1qb2Jz4oCZIHRhZyBmcm9tIFFFTVUgZGV2aWNlIGlu
IHRoYXQgd29ya2VyIHRvDQo+ID4gYXZvaWQgZmFpbHVyZXMgZm9yIG5vdyBhbmQgcGFyYWxsZWxs
eSBkZWJ1ZyB0aGUgcHJvYmxlbS4NCj4gDQo+IA0KPiANCj4gSSBoYXZlIHRlc3RlZCBvbiBvdXIg
cnVubmVyIHRoZSBsYXRlc3QgcWVtdSBpbWFnZSBhbmQgdGhlIHN3dXBkYXRlDQo+IHNjZW5hcmlv
LiBBcyBvdXIgaW5mcmFzdHJ1Y3R1cmUgZG9lcyBub3Qgc3VwcG9ydCBpbnRlcm5ldCBhY2Nlc3Mg
ZnJvbSBhDQo+IERldmljZS11bmRlci10ZXN0IGkgd291bGQgcmVjb21tZW5kIHRoYXQgd2UgZG9u
J3QgZXhlY3V0ZSBzd3RwbS1qb2JzIG9uDQo+IGxhYi1jaXAtc2llbWVucy1tdWMgZm9yIHRoZSB0
aW1lIGJlaW5nLg0KDQpJJ3ZlIG5vdyByZW1vdmVkIHRoZSBzd3RwbS1qb2JzIHRhZyBmcm9tIHRo
ZSBxZW11LWNpcC1zaWVtZW5zLW11YyBkZXZpY2UuDQoNCj4gDQo+ID4NCj4gPiBOb3RlOiBUaGUg
ZmFpbHVyZXMgaW4gb3RoZXIgd29ya2VycyBwcm92aWRlZCBpbiB0aGUgYXR0YWNoZWQgc2hlZXQg
YXJlDQo+ID4ga25vd24gZXJyb3JzLg0KPiANCj4gSSBhbHNvIGNoZWNrZWQgdG8gZXJyb3JzLCB3
ZSBoYXZlIG11bHRpcGxlIHNvdXJjZSBvZiBlcnJvcnMuDQoNClRoYW5rIHlvdSBmb3IgdGFraW5n
IHRoZSB0aW1lIHRvIHRha2UgYSBsb29rLg0KDQpLaW5kIHJlZ2FyZHMsIENocmlzDQoNCj4gDQo+
IGUuZy4gaHR0cHM6Ly9sYXZhLmNpcGxhdGZvcm0ub3JnL3NjaGVkdWxlci9qb2IvMTE4MTk1MiBo
YXMgdGhlIGVycm9yOg0KPiANCj4gYGBgDQo+IFJlc2l6aW5nIHRoZSBmaWxlc3lzdGVtIG9uIC9k
ZXYvdmRhNiB0byAzMzI1OTUgKDRrKSBibG9ja3MuDQo+IFRoZSBmaWxlc3lzdGVtIG9uIC9kZXYv
dmRhNiBpcyBub3cgMzMyNTk1ICg0aykgYmxvY2tzIGxvbmcuDQo+IGxvZ2luLWFjdGlvbiB0aW1l
ZCBvdXQgYWZ0ZXIgMTQzOCBzZWNvbmRzDQo+IGBgYA0KPiANCj4gYW5kDQo+IGh0dHBzOi8vbGF2
YS5jaXBsYXRmb3JtLm9yZy9zY2hlZHVsZXIvam9iLzExODE5NDQNCj4gYGBgDQo+IE1pQi9zWzJL
UHJvZ3Jlc3M6ICA2My4zJSwgRVRBIDA0bTM2cywgIDgzMiBNaUIgd3JpdHRlbiwgc3BlZWQgICAx
LjgNCj4gTWlCL3NbMktQcm9ncmVzczogIDY0LjUlLCBFVEEgMDRtNDFzLCAgODQ4IE1pQiB3cml0
dGVuLCBzcGVlZCAgIDEuNw0KPiBNaUIvc1syS1Byb2dyZXNzOiAgNjUuNyUsIEVUQSAwNG0zMnMs
ICA4NjQgTWlCIHdyaXR0ZW4sIHNwZWVkICAgMS43DQo+IE1pQi9zWzJLUHJvZ3Jlc3M6ICA2Ni45
JSwgRVRBIDA0bTI2cywgIDg4MCBNaUIgd3JpdHRlbiwgc3BlZWQgICAxLjcNCj4gTWlCL3NbMktQ
cm9ncmVzczogIDY4LjElLCBFVEEgMDRtMjJzLCAgODk2IE1pQiB3cml0dGVuLCBzcGVlZCAgIDEu
Nw0KPiBNaUIvc1syS1Byb2dyZXNzOiAgNjkuMyUsIEVUQSAwNG0xOXMsICA5MTIgTWlCIHdyaXR0
ZW4sIHNwZWVkICAgMS42DQo+IE1pQi9zWyAgNjA5LjM3NDc4Nl0gd2F0Y2hkb2c6IHdhdGNoZG9n
MDogd2F0Y2hkb2cgZGlkIG5vdCBzdG9wIQ0KPiBbMktQcm9ncmVzczogIDcwLjYlLCBFVEEgMDRt
MTVzLCAgOTI4IE1pQiB3cml0dGVuLCBzcGVlZCAgIDEuNg0KPiBNaUIvc1syS1Byb2dyZXNzOiAg
NzEuOCUsIEVUQSAwNG0xMHMsICA5NDQgTWlCIHdyaXR0ZW4sIHNwZWVkICAgMS41DQo+IE1pQi9z
WzJKWzAxOzAxSFs9M2hbMkpbMDE7MDFIWzJKWzAxOzAxSFs9M2hbMkpbMDE7MDFIWzJKWzAxOzAx
SFs9M2hbMkpbMDE7DQo+IDAxSEJkc0R4ZToNCj4gbG9hZGluZyBCb290MDAwMSBcIlVFRkkgUUVN
VSBIQVJERElTSyBRTTAwMDExIFwiIGZyb20NCj4gUGNpUm9vdCgweDApL1BjaSgweDFGLDB4Mikv
U2F0YSgweDUsMHhGRkZGLDB4MCkNCj4gQmRzRHhlOiBzdGFydGluZyBCb290MDAwMSBcIlVFRkkg
UUVNVSBIQVJERElTSyBRTTAwMDExIFwiIGZyb20NCj4gUGNpUm9vdCgweDApL1BjaSgweDFGLDB4
MikvU2F0YSgweDUsMHhGRkZGLDB4MCkNCj4gWzJKWzAxOzAxSFswbVszNm1bNDBtRUZJIEJvb3Qg
R3VhcmQgdjAuMTYNCj4gWzBtWzM3bVs0MG1Cb290IG1lZGl1bTogUGNpUm9vdCgwKS9QY2koMHgx
RiwweDIpL1NhdGEoMHg1LDB4RkZGRiwweDApDQo+IEZvdW5kIDMgaGFuZGxlcyBmb3IgZmlsZSBJ
Tw0KPiBWb2x1bWUgMDogKE9uIGJvb3QgbWVkaXVtKQ0KPiBQY2lSb290KDApL1BjaSgweDFGLDB4
MikvU2F0YSgweDUsMHhGRkZGLDB4MCkvSEQoMSxHUFQsRDEzNjBGNzYtQjA5QS00QkNDLQ0KPiBC
OTIzLTgxOTUwODhDQkUwMiksDQo+IExBQkVMPWVmaSwgQ0xBQkVMPShudWxsKQ0KPiBWb2x1bWUg
MTogKE9uIGJvb3QgbWVkaXVtKQ0KPiBQY2lSb290KDApL1BjaSgweDFGLDB4MikvU2F0YSgweDUs
MHhGRkZGLDB4MCkvSEQoMixHUFQsRjg3MDI1OEItNzA2Ri00QTY2LQ0KPiA4RDU4LUI1QTc1Q0U2
MUI4QiksDQo+IExBQkVMPUJPT1QwLCBDTEFCRUw9Qk9PVDANCj4gVm9sdW1lIDI6IChPbiBib290
IG1lZGl1bSkNCj4gUGNpUm9vdCgwKS9QY2koMHgxRiwweDIpL1NhdGEoMHg1LDB4RkZGRiwweDAp
L0hEKDMsR1BULDZFNDFGMkE3LUUzRUItNDAzRi0NCj4gODYzNy1CMTExRTQ0ODJFRTkpLA0KPiBM
QUJFTD1CT09UMSwgQ0xBQkVMPUJPT1QxDQo+IExvYWRpbmcgY29uZmlndXJhdGlvbi4uDQo+IGBg
YA0KPiANCj4gDQo+IFF1aXJpbg0KPiANCj4gPg0KPiA+IFRoYW5rcyBhbmQgcmVnYXJkcywNCj4g
Pg0KPiA+IFNhaSBBc2hyaXRoIFNhdGh1am9kYSAoVCBTIEkgUCkNCj4gPg0KPiA+DQo+ID4NCj4g
PiAtPS09LT0tPS09LT0tPS09LT0tPS09LQ0KPiA+IExpbmtzOiBZb3UgcmVjZWl2ZSBhbGwgbWVz
c2FnZXMgc2VudCB0byB0aGlzIGdyb3VwLg0KPiA+IFZpZXcvUmVwbHkgT25saW5lICgjMTY4NzUp
OiBodHRwczovL2xpc3RzLmNpcC1wcm9qZWN0Lm9yZy9nL2NpcC0NCj4gZGV2L21lc3NhZ2UvMTY4
NzUNCj4gPiBNdXRlIFRoaXMgVG9waWM6IGh0dHBzOi8vbGlzdHMuY2lwLXByb2plY3Qub3JnL210
LzEwODM1MjYwNy8xNzUzNjQwDQo+ID4gR3JvdXAgT3duZXI6IGNpcC1kZXYrb3duZXJAbGlzdHMu
Y2lwLXByb2plY3Qub3JnDQo+ID4gVW5zdWJzY3JpYmU6IGh0dHBzOi8vbGlzdHMuY2lwLXByb2pl
Y3Qub3JnL2cvY2lwLQ0KPiBkZXYvbGVhdmUvODEyOTEyMS8xNzUzNjQwLzE0MDUyNjkzMjYveHl6
enkgW3F1aXJpbi5neWxzdG9yZmZAc2llbWVucy5jb21dDQo+ID4gLT0tPS09LT0tPS09LT0tPS09
LT0tPS0NCj4gPg0K

