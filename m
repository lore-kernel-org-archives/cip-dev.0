Return-Path: <cedric.hombourger@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC38FCCFA18
	for <webhook@archiver.kernel.org>; Tue, 11 Nov 2025 14:26:18 +0000 (UTC)
Received: from AM0PR83CU005.outbound.protection.outlook.com (AM0PR83CU005.outbound.protection.outlook.com [52.101.69.42])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.18686.1762871172744985412
 for <cip-dev@lists.cip-project.org>;
 Tue, 11 Nov 2025 06:26:13 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=qhrBHOfk;
 spf=pass (domain: siemens.com, ip: 52.101.69.42, mailfrom: cedric.hombourger@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dEa1mfof15mtVqB9rI1z3ms/+TfaK5Zl1hpGeceS44z1G/t8Mc1UBoYX1asERH0QdPQW5F1toH4tA4ZzpiZBSQsS5kSibVincHAH3J0Muei0EPyxPjQGKbWlmb3rirRoMAE+jEKafvheBUb/Ach/3EDVkZl/FA37DLKldzNxDl8nR/POb29OPTlfj9VKHquGouY7HBzBpz88E1YhWUEGjDEnCaQyTc3M08drsmOWoi243/9xHsvck44mfxSRj3Eurh/12VZH/ObHo6D717iPlOdAP2K5TZZiknXAbcqtnEpyeXgrX4J7i+L7AESFZTH2ApmnrnQ5NPiyYSlP+xwnYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NQg+iyRmEqXE1Z9/IXxYj8MF0N4tLmcR7AvV7EIS1OY=;
 b=M28P7Ta84YR5KPUxN0+SuM0cynUJedewYxZOC05PWUx+cjO23M/tUkfsg5JClBnOI7nOU/zaFQDdICk1FbUcDVnASUJDu8WEG2Dpf+RGmVafD4TUIkhYwxpgb6lGtHkSTAq+HLijNxaB4DbimTYQvRyNBnqAfvEIPLwlM27sJBRNw3WnsTw6Antcy/02zB5ocRRTAjNUbwsSk7kGDQ3161477RB69BYA2kQnYaLSUTFus4bvHq117PYrPDb+jGeMe28vEixssMw3hGJNLCPYNj+aNaIJxe7SIY7IiFhaqmai/bUcdyOVDxl+7vPkW3Qwr8il7EgrlcjwLPRXAmXGPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NQg+iyRmEqXE1Z9/IXxYj8MF0N4tLmcR7AvV7EIS1OY=;
 b=qhrBHOfkHQnH5bcZilEqd9pgKXQ3W4FDAro3Gk/WN4GhlXEpzqAg9XQbYWtZWSrfK3Bcq6nSNkpI8EEmnhCCoABOCM+wK58dcYn2GuCAh7Q+39HzyEA3Vjr412pN39vdUM/50KEcPsaFtVNjvtM6TSsjb8Ljt43MIYRO8etkpCxDWqsaxrNnWJp4XTUHWI+AVMcUw0E0TfMmO7YSXLBs0V8EzcQ09MMngtdK6LXOiCxRj3L6FXvsVui65rw9b552Dxp12Fh9JPAcMKduU8ab8vryWsKQfKTXFfyvQOVDB7mTkhBg9bxC91kKeBE06ufAnhBUlZWJrurHJJRK+uDFSA==
Received: from AS8PR10MB7875.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:629::5)
 by AS4PR10MB5799.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:506::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Tue, 11 Nov
 2025 14:26:09 +0000
Received: from AS8PR10MB7875.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b0ad:e93d:d30d:b90]) by AS8PR10MB7875.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b0ad:e93d:d30d:b90%4]) with mapi id 15.20.9298.015; Tue, 11 Nov 2025
 14:26:09 +0000
From: "cedric.hombourger@siemens.com" <cedric.hombourger@siemens.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"quirin.gylstorff@siemens.com" <quirin.gylstorff@siemens.com>, "Kiszka, Jan"
	<jan.kiszka@siemens.com>
Subject: Re: [isar-cip-core][PATCH] swupdate: generate reproducible source
 tarballs
Thread-Topic: [isar-cip-core][PATCH] swupdate: generate reproducible source
 tarballs
Thread-Index: AQHcUvO5lCacNfRmL0Gvq8hG4i41BbTtgg8AgAAGRYA=
Date: Tue, 11 Nov 2025 14:26:09 +0000
Message-ID: <1efa7ff43e8a5fedb5b4174979507802ee66c651.camel@siemens.com>
References: <20251111101231.143022-1-cedric.hombourger@siemens.com>
	 <62a8ff54-596c-4a18-9b09-be0c7cbe4d6d@siemens.com>
In-Reply-To: <62a8ff54-596c-4a18-9b09-be0c7cbe4d6d@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.52.3-0ubuntu1+intune 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB7875:EE_|AS4PR10MB5799:EE_
x-ms-office365-filtering-correlation-id: 725df8c1-d2fd-421e-f4f4-08de212e41f9
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info: 
 =?utf-8?B?YVpWYzlqWnJ1N0c0eVJiditIc2U2TFFDWHVQakRRRnZjMUdWV0RQNHpmWjNw?=
 =?utf-8?B?ampXOUN4SDBWM3VydzZFdEp6ZHJKaFBseGRGLzJPWml4UnAyMFFSb2hWNTdt?=
 =?utf-8?B?RlhsKzJJaDk3dnE5SFVONEdRQy9CREc0a0hWWmY5eS9HeStlM3ZvZEVyWHZE?=
 =?utf-8?B?dTgwdFEwNWdFdVVURno0VE95L0h5cGRWbldlMjJBRnpETHovVzRWeFRPTVBQ?=
 =?utf-8?B?QTI4czdRdHB1R3Rtd0lMek1yRmlaSFlxNVBqTkJBekxkTWw5UWhsaEVJU1V5?=
 =?utf-8?B?aEJFTG4xelRNaVVCWVpwTVVEWS9yeXVsenNFaGxLTFpFd3FFRDFmN2hYM2Qr?=
 =?utf-8?B?ZG5KZVhhdUhBbkxwaVlWQ1ViWS96UGs5ZkFaa0pLS01yU0JKV2ZkbmZFb05k?=
 =?utf-8?B?UWxBSzVOS3RiSENQQW5zRG1OQVNwalBFNXJienRvZGJoY2paVUpZT0dMRTZx?=
 =?utf-8?B?bUdLRTRpZGpBblFlWXFVREJ5Rnpyb1pKSDd2TnlzVVArRndKY2Q1cjRwR0Zn?=
 =?utf-8?B?NTkxa0N1NzFaNkhhNk9sbnU4L0ovTTd4cHhUNEFqTWtkZjFDNmhtKzJIeTcv?=
 =?utf-8?B?d3V0cVNZZ0h3cm9BVURtV2FxWXpSWW0vcHFXZzlXL3dlWHVOMTJYLzZ5eEtM?=
 =?utf-8?B?d2tFakN0aTVvaTdpazNLdEdRbU9lUXJBUUZ3SDhvSDllL3BzbGU0aW5ZcnE2?=
 =?utf-8?B?YlZpNjIveTFnd3dhQXErcVByalVZaEV5elRkUlZlODJ1VlVhZVF4d3hJK3Zo?=
 =?utf-8?B?cTh1bG02TjBiU0lIVTJ3YXdZdU13T0UrbXJ2cUNOMWh2YThqUU9aQk1xZW1R?=
 =?utf-8?B?VE9sS0w5eWI3MUVIbElndHYyUUZqWjBBN00zVGVUMnk1eVBKK3NGNmpxWTky?=
 =?utf-8?B?QkZyRU43c0RQSjBiSEJlTHd0VFUydWdnc2FlM0FUNXVJanZvQ2hUNGRVMkU3?=
 =?utf-8?B?eHFsTElBTUNLSXBxU2NlYk1QTzJtOHFLRCttZ3Q4VG01bUpjdVI2VGphVzdE?=
 =?utf-8?B?cFBWdjE4VWRvZ09QdVh2djRyWWNnZ3FIMTJNRnNmZlEyNElFTUJLTUNmdjla?=
 =?utf-8?B?NFAxNGF6dUI1cEZNU0VEQ0s3TElrczhCd0RXbStWVzlMYk1icFA3UVYxY0RP?=
 =?utf-8?B?VzRiMFNqQVcyOUptTFp6ZHF3RWNuVjhLb25HS250bnJBbzhneUIzUkduQVJI?=
 =?utf-8?B?clJMY01FR3oxdk5kcWVWdlFtajVOM01LS0NkeEJGU3V5VU1YeEVIVUtuZ0dz?=
 =?utf-8?B?OFZ4NTAvTnRQdkFFN1p5MlNzN1FFK1F6NlRKeElpSTh4Mm9vSVdGd0c2emVk?=
 =?utf-8?B?TVVrbTBhT0pBcERqVXo5RjNUVVErNHp6dWFHVGRHRU90MXJ4MS9NNS9XK2RZ?=
 =?utf-8?B?cUVkWGg0VTU0SnVSNnh0MGt3RVpqOG5qVmRRTUlGMXVJV1R2R09iZ0szS3Yv?=
 =?utf-8?B?aVpkNGdVSTdldjZ3d2l1OHc3ZkU2UDNLZUpOS3BhQ21TUzdlVEFaWURqeDVZ?=
 =?utf-8?B?TUFzMFplZ0FnR3J1cW41bDl6WDNNc1lHbXZnenprSkFmYVM3cXhMUHk2V0tX?=
 =?utf-8?B?QlRVcElrdFVpTjFocFBzLy9Ed1Z1M3Y5TUZWRmNqQnNtc1RmcURVdk9uMDQ5?=
 =?utf-8?B?K3h2YXJlL2RXTGlHd0tLRlZuOUUveVJGNGd0UUF3aHAvSEQzVDdLZnhMS1Fv?=
 =?utf-8?B?WXR4YlcxSS9MSE9aRDl0aXNxKzJlTnRFbllXa0E5ck93aDVmMVFoSjRSL3dm?=
 =?utf-8?B?aklkdkk2VlFsSVdVaUFZRHdNSEl2RGE4dCtlakRDRmNtNTJVOEhONTRqYnY4?=
 =?utf-8?B?bFZVcDNlWS81Wkd6YUhpZmRUODN1L1Nvc2phNG9PMnZZR0tCNG5pRVFOazdx?=
 =?utf-8?B?cjZNalJQS0hSaHBNcU94WnRteUFLVXMzUVlRYUtlSWFtMExmbzU2UDFhMi9w?=
 =?utf-8?B?M1hOaGlaVENsMDRZS09JalRZbVJLQzZmeTUreVRVb3g1VGtmWW5YVko0czM1?=
 =?utf-8?B?SHc3R25oQlZMNnVNQWJ2R2F5SEpDYml6bWlaOTRiSGQ5RW5UbjNiNDdUNlVU?=
 =?utf-8?Q?FShXzJ?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR10MB7875.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?bE8vNVc5aXNyN0pNNnV1RDN4VmdjdVUvaS9IdWo4ekludFFsV1RGeW5QMm4z?=
 =?utf-8?B?aTNTLzJuWC8zVy92SmhMRHhyV1BCdldIVlBUWm9zWmlUTUVZaFUwbmZaTnpS?=
 =?utf-8?B?a2hrUWpzYXI4N002NWxtR1hmQ3ovQTFyNFBSekpiMXlQb2tHQmZmNXdiRmJz?=
 =?utf-8?B?SlBTTnlBanJRWnp3a0ZKT2lVYWxlVkJSVm9VM2I1dmYycm42QTVJVXV6eW1a?=
 =?utf-8?B?SjBkekREZjNmZm5nblROTHFqWURTRDR1dTdLeEorV052MjNGblo4TjF2dkR1?=
 =?utf-8?B?UGxUaEVDbWUzckI5c0twV0kxRThxNHpVdzRueWEzMURES2JpbDZ5QjAycUJr?=
 =?utf-8?B?T0dwTjNqNk5CejRDbzRPV2p0TjRtSTdyNWY4NTF1bWxySEJwMU8zdnFnZnZT?=
 =?utf-8?B?N3ZuYndueGlPaGtCL2VTL0JNNEdCSm5qc0c1bVVpalRzdkw2NnV4YzdBVXJO?=
 =?utf-8?B?WUVqemZSVUJJZlNNeEdHelQrc2hRd2lrYmozZHdlL0N4RS80SVVoZktqcndq?=
 =?utf-8?B?bi9GT1JVN1Rhb0E0WmN6NTJHODJEdjhJVjBnQlcxaDJtdkJRZG1jUnNhWmZQ?=
 =?utf-8?B?dlhISGRPdUlhRHJaWGRJZmc3OHZrR0NjUWZlbTRvZWxTQmtsSkVFeHBkeGdF?=
 =?utf-8?B?SjZDUnlYNEVodUpuWUlpWDVhUGdrYTZXY3VaR2NhWVdNeDcxRUVOWmhhZ2Rv?=
 =?utf-8?B?R05Vd2Ewam93dHpqaXJpVCtJWGx4K1Y4QThGWTFycGkzWVB6RE9tVHV0SkJ6?=
 =?utf-8?B?K2pTVzFQWGZPR2NRNS92Z3YzRzVrTWZoL1pIOTVzQmZYWDZnOEVhVi9wNHcr?=
 =?utf-8?B?UC9kZDlRYyszeDVlZFdJUklDZXF0bS9XeldxS0hwbnBGd0FPSTJ5SnNFTU9G?=
 =?utf-8?B?cGFvWWtaZ00ya21yVHBwWEJPUEZVZHF2MW5URUtycld3NXp0YkYrSWpXUTJy?=
 =?utf-8?B?ZXArZ1BUczN4NmtxRTFnUmdLTXJuemZubko3SVJncVNiU25YRTNDeFc3SGtL?=
 =?utf-8?B?LzR6SklWcEZxcVgxSVlMWGVFOGtZOUhMb0dEMzFqK2lSdlhnL0tPd0w3N3cv?=
 =?utf-8?B?MU9Qa0dNSTJyOVBhV05TbW13eTNVdEU3Nlc3Ui9vaGk0NEh2TEJyOTZSMzky?=
 =?utf-8?B?S3YvNjRhQVdUMWcrUmZHbW5CYUFvSEgrV2RseWhJaEJDSUtCYmt5bFFtUDJT?=
 =?utf-8?B?Tm1oYXFvTEdQWXFiM0Y4Zm0rdEcrVlFBVitEUXpvWGJqblpNaExhc0NXODZY?=
 =?utf-8?B?dmpaOGJNVktxbkt5QXFRUVRIUHMxeWRpWCsyOWNQdjdQTmlFRTRZN0pJVTRj?=
 =?utf-8?B?YnpmR0Q4WW5lQ0UyRWE2U3g0aHBOejZYVnlhZmVPMnFMWlkreXFXMTZER1g3?=
 =?utf-8?B?TzVhcjd3dERyQmRSUGIrS1pINVVOL1NMeDRYdlAzQ2U1WEV4dTJYYmFKRHQx?=
 =?utf-8?B?ZEl0dDVNSUNsU3BJK1Z4MllsQS95YjNsZXdTMFoxZUxJelU1QWliZlhWSHMr?=
 =?utf-8?B?NVBCc2RBbUwwYnNjNTBZMmtzeHh6d2k4RUVyTkp1NXJJQUNKUXkvS1Y0V3cr?=
 =?utf-8?B?WlY3TU5VcmQzbnlLbnZuYzNyZFVMZTlWekYxYlN4RTVQNWoyaEUxZ3d1dFZo?=
 =?utf-8?B?dklSNW9Yc3hCRkdSNFlILzZXVW5lbE42dVgxK0RQd3grYjlJUDQrRXp3RFly?=
 =?utf-8?B?czJKcm9WaXEwVW45Ty85YWcxQ200SzVwczNkVDFwb21tbVlHZEdkUDFZN3BC?=
 =?utf-8?B?L0xEcXZsbEFYaU1UMmptVTk4ZmNZOEU3TWhpdzhBNXBxUTRFcVd5bW9SM2hv?=
 =?utf-8?B?dW9GY1pNQ0xOeitXM1VCckNTZ2sxaVdSN3J2YnA2UHpMK3N6akpZVHBUS1Rr?=
 =?utf-8?B?SG05bUROeU93bU1Dd0pwT09URVpUT1drS2N5d2xWZGp2M3E3MTkwTlJ1M3A2?=
 =?utf-8?B?ZzkyTlVabnRWRVZ2aVJneGxJYUcyTWRweVQ4TTg3UlZ1aStuUzJhT1gxQStZ?=
 =?utf-8?B?WXRYazlaZnViemJ2RVRMek5xL29xaDdLcm5XN3o4VVJ1cHRHNFFRM3pwelFY?=
 =?utf-8?B?K0RLL3pXRmpINHpSNHFyZHNHM1FmWVJtVU9RNkh4L2IvUkhCY2FBT3NEOVJu?=
 =?utf-8?B?Zi9mVzZYWHJzNDBVbVEvbkxYaDhYZXM4QjU4TDJtK3RlZDMyOEkvZGV0eXcv?=
 =?utf-8?Q?6rsUtoMZmgXW15CIzqEYBSg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3D0D3EF75E753A4C82C5ABD75085775A@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB7875.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 725df8c1-d2fd-421e-f4f4-08de212e41f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2025 14:26:09.1947
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ie+9PvIDTvBSsQRX2cO9TNLYOG+y04jDSIatmXxLUWTifRXtKIePv3VKz72xlhX8z8VqBG6n0QE5L+FuSBYJncBAAYx+MXNfOPdn00F4NKQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5799
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 11 Nov 2025 14:26:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20495

T24gVHVlLCAyMDI1LTExLTExIGF0IDE1OjAzICswMTAwLCBKYW4gS2lzemthIHdyb3RlOg0KPiBP
biAxMS4xMS4yNSAxMToxMiwgQ2VkcmljIEhvbWJvdXJnZXIgd3JvdGU6DQo+ID4gQXBwbHkgYWRk
aXRpb25hbCBvcHRpb25zIHRvIHRoZSB0YXIgY29tbWFuZCB1c2VkIHRvIGdlbmVyYXRlDQo+ID4g
cmVwcm9kdWNpYmxlIHNvdXJjZSB0YXJiYWxsczogKDEpIHVzZSBudW1lcmljIGFuZCBudWxsIFtH
VV1JRHMsDQo+ID4gLWNsYW1wLW10aW1lIGZvciBmaWxlIG1vZGlmaWNhdGlvbiB0aW1lcyB0byBu
ZXZlciBiZSBsYXRlciB0aGFuDQo+ID4gU09VUkNFX0RBVEVfRVBPQ0ggKHByZXNlcnZpbmcgbXRp
bWVzIGZvciBmaWxlcyBub3QgbW9kaWZpZWQgYnkNCj4gPiB0aGUgcmVjaXBlKSBhbmQgLS1zb3J0
PW5hbWUgZm9yIGNvbnNpc3RlbnQgb3JkZXJpbmcgd2l0aGluIHRoZQ0KPiA+IGFyY2hpdmUuDQo+
ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogQ2VkcmljIEhvbWJvdXJnZXIgPGNlZHJpYy5ob21ib3Vy
Z2VyQHNpZW1lbnMuY29tPg0KPiA+IC0tLQ0KPiA+IMKgcmVjaXBlcy1jb3JlL3N3dXBkYXRlL3N3
dXBkYXRlXzIwMjIuMTIrZHNmZy00LWNpcC5iYiB8IDYgKysrKystDQo+ID4gwqByZWNpcGVzLWNv
cmUvc3d1cGRhdGUvc3d1cGRhdGVfMjAyMy4xMi5iYsKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfCA2
ICsrKysrLQ0KPiA+IMKgMiBmaWxlcyBjaGFuZ2VkLCAxMCBpbnNlcnRpb25zKCspLCAyIGRlbGV0
aW9ucygtKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9yZWNpcGVzLWNvcmUvc3d1cGRhdGUvc3d1
cGRhdGVfMjAyMi4xMitkc2ZnLTQtY2lwLmJiDQo+ID4gYi9yZWNpcGVzLWNvcmUvc3d1cGRhdGUv
c3d1cGRhdGVfMjAyMi4xMitkc2ZnLTQtY2lwLmJiDQo+ID4gaW5kZXggZmNjY2MyYy4uYjViZWNh
YSAxMDA2NDQNCj4gPiAtLS0gYS9yZWNpcGVzLWNvcmUvc3d1cGRhdGUvc3d1cGRhdGVfMjAyMi4x
Mitkc2ZnLTQtY2lwLmJiDQo+ID4gKysrIGIvcmVjaXBlcy1jb3JlL3N3dXBkYXRlL3N3dXBkYXRl
XzIwMjIuMTIrZHNmZy00LWNpcC5iYg0KPiA+IEBAIC0zNyw1ICszNyw5IEBAIENIQU5HRUxPR19W
ID89ICIke1BWfS0ke1NSQ1JFVn0iDQo+ID4gwqBkb19wcmVwYXJlX2J1aWxkKCkgew0KPiA+IMKg
wqDCoMKgIGRlYl9hZGRfY2hhbmdlbG9nDQo+ID4gwqDCoMKgwqAgY2QgJHtXT1JLRElSfQ0KPiA+
IC3CoMKgwqAgdGFyIGNKZiAke1BOfV8ke1BWfS5vcmlnLnRhci54eiAtLWV4Y2x1ZGU9LmdpdCAt
LQ0KPiA+IGV4Y2x1ZGU9ZGViaWFuICR7UH0NCj4gPiArwqDCoMKgIHRhciBjSmYgJHtQTn1fJHtQ
Vn0ub3JpZy50YXIueHogXA0KPiA+ICvCoMKgwqDCoMKgwqDCoCAtLWV4Y2x1ZGU9LmdpdCAtLWV4
Y2x1ZGU9ZGViaWFuICR7UH0NCj4gPiArwqDCoMKgwqDCoMKgwqAgLS1tdGltZT1AJHtTT1VSQ0Vf
REFURV9FUE9DSH0gLS1jbGFtcC1tdGltZSBcDQo+ID4gK8KgwqDCoMKgwqDCoMKgIC0tb3duZXI9
MCAtLWdyb3VwPTAgLS1udW1lcmljLW93bmVyIFwNCj4gPiArwqDCoMKgwqDCoMKgwqAgLS1zb3J0
PW5hbWUgJHtQfQ0KPiA+IMKgfQ0KPiA+IGRpZmYgLS1naXQgYS9yZWNpcGVzLWNvcmUvc3d1cGRh
dGUvc3d1cGRhdGVfMjAyMy4xMi5iYiBiL3JlY2lwZXMtDQo+ID4gY29yZS9zd3VwZGF0ZS9zd3Vw
ZGF0ZV8yMDIzLjEyLmJiDQo+ID4gaW5kZXggY2MwMWE5OC4uNTBkZjIxNSAxMDA2NDQNCj4gPiAt
LS0gYS9yZWNpcGVzLWNvcmUvc3d1cGRhdGUvc3d1cGRhdGVfMjAyMy4xMi5iYg0KPiA+ICsrKyBi
L3JlY2lwZXMtY29yZS9zd3VwZGF0ZS9zd3VwZGF0ZV8yMDIzLjEyLmJiDQo+ID4gQEAgLTUwLDUg
KzUwLDkgQEAgQ0hBTkdFTE9HX1YgPz0gIiR7UFZ9K2NpcC0ke1NSQ1JFVn0iDQo+ID4gwqBkb19w
cmVwYXJlX2J1aWxkKCkgew0KPiA+IMKgwqDCoMKgIGRlYl9hZGRfY2hhbmdlbG9nDQo+ID4gwqDC
oMKgwqAgY2QgJHtXT1JLRElSfQ0KPiA+IC3CoMKgwqAgdGFyIGNKZiAke1BOfV8ke1BWfStjaXAu
b3JpZy50YXIueHogLS1leGNsdWRlPS5naXQgLS0NCj4gPiBleGNsdWRlPWRlYmlhbiAke1B9DQo+
ID4gK8KgwqDCoCB0YXIgY0pmICR7UE59XyR7UFZ9K2NpcC5vcmlnLnRhci54eiBcDQo+ID4gK8Kg
wqDCoMKgwqDCoMKgIC0tZXhjbHVkZT0uZ2l0IC0tZXhjbHVkZT1kZWJpYW4gXA0KPiA+ICvCoMKg
wqDCoMKgwqDCoCAtLW10aW1lPUAke1NPVVJDRV9EQVRFX0VQT0NIfSAtLWNsYW1wLW10aW1lIFwN
Cj4gPiArwqDCoMKgwqDCoMKgwqAgLS1vd25lcj0wIC0tZ3JvdXA9MCAtLW51bWVyaWMtb3duZXIg
XA0KPiA+ICvCoMKgwqDCoMKgwqDCoCAtLXNvcnQ9bmFtZSAke1B9DQo+ID4gwqB9DQo+IA0KPiBT
ZWVtcyB0aGlzIHBhdHRlcm4gaXMgbGltaXRlZCB0byB0aG9zZSBvbGRlciBzd3VwZGF0ZSBwYWNr
YWdlcywgYXQNCj4gbGVhc3QNCj4gaW4gaXNhci1jaXAtY29yZS4gSW4gaXNhciwgdGhlcmUgbWln
aHQgYmUgb25lIHNpbWlsYXIgY2FzZQ0KPiAobGlidWJvb3RlbnYpDQo+IC0gYW5kIGNvdXBsZSBv
ZiB0aGVtIGFyb3VuZCB2bSBpbWFnZSBnZW5lcmF0aW9uLg0KPiANCj4gQmFjayB0byBwYWNrYWdl
IGN1c3RvbWl6YXRpb246IElzIHRoaXMgd2F5IG9mIGdlbmVyYXRpbmcgdGhlIG9yaWcNCj4gdGFy
YmFsbCB0aGUgYmVzdCBhcHByb2FjaCBoZXJlPyBJZiBzbywgYW5kIGdpdmVuIHRoZSBsb25nZXIg
bGlzdCBvZg0KPiBvcHRpb25zLCBzaG91bGRuJ3QgaXNhciBwcm92aWRlIHNvbWUgInJlcHJvZHVj
aWJsZV90YXIiIGhlbHBlciB0aGF0DQo+IGFkZHMNCj4gd2hhdCBpcyBuZWVkZWQ/DQoNCmdvb2Qg
aWRlYS4gY291bGQgZGVmaW5pdGVseSBwcm9wb3NlIHNvbWV0aGluZyBhbmQgZGVtb25zdHJhdGUg
aXRzIHVzZQ0Kd2l0aCBsaWJ1Ym9vdGVudi4NCg0Kd291bGQgeW91IGFwcGx5IHRoaXMgcGF0Y2gg
YW5kIHRha2UgdGhlIHJld29yayBvbmNlIHRoZSBpc2FyIGhlbHBlciBpcw0KcHJvcG9zZWQgJiBh
Y2NlcHRlZD8gZWl0aGVyIHdheSBpcyBmaW5lIC0gdGhpcyBpcyBzaW1wbHkgdG8gdW5kZXJzdGFu
ZA0Kd2hhdCBteSBuZXh0IHN0ZXBzIHNob3VsZCBiZQ0KDQo+IA0KPiBKYW4NCj4gDQoNCi0tIA0K
Q2VkcmljIEhvbWJvdXJnZXINClNpZW1lbnMgQUcNCnd3dy5zaWVtZW5zLmNvbQ0K

