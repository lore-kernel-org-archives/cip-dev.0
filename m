Return-Path: <alexander.heinisch@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74C04C02181
	for <webhook@archiver.kernel.org>; Mon, 20 Jan 2025 15:23:04 +0000 (UTC)
Received: from DU2PR03CU002.outbound.protection.outlook.com (DU2PR03CU002.outbound.protection.outlook.com [52.101.66.21])
 by mx.groups.io with SMTP id smtpd.web10.38830.1737386577832632616
 for <cip-dev@lists.cip-project.org>;
 Mon, 20 Jan 2025 07:22:58 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=tcBt3tY3;
 spf=pass (domain: siemens.com, ip: 52.101.66.21, mailfrom: alexander.heinisch@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vy+J0Yt0IhQxSEk5rRMNlZTMWeOoNvLhGrqHD+lQqBBEN8gEDO5DF0klYbD8aOHv/MJFYIMCCnb3DqUQt3IRq4zyQT8LV/QLh29D6/xgxFcMApaFazuizmEgp2zM43QNh/Z+hVXXn8GKF6O2DXjUJpEdEcWvd2kQcJI3pgCD5jHpZOTtB9Z4KyvoFzTobtITEz3QeSxQQ9Tlk+e8810VZc9+/MfmKDXHf75sZj2wq5+15iqf4MJctqkJl4gx+YLflhZyWtCEbEStpkVAwAZwmc/e05LlmiiAKMgt8S56BeOLErdlDwZvYwALbbBGgnZUZuzNt0g9yCd04/65QLbO0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vxWAFK2UTi/0SoLx6oTV3i8DftxnP/LgVCtA+9Dg5rU=;
 b=e8q9kO6ItlOc2PUK/pQaJ+HTfTnZ1hoTxXHMy8QccEqnf3kvlboQNMlqpyasNGPBSmgnqxTMClgLzr4ZIjYxIyTmdLdy4l2stB/IZw6A9k+UMyeEnH3cC3+Vh7GvlM7vfGsHLraY1tTwPrWEQwBHjbwnF7a7VCk/FJtKtau1wNCFRpE4nhGb1ctquTkEw8NFBn/hRpU+uBkHcTnqC0nh9HqVq3VUJL3pKv0x6ZmFc6apkIJWJi5VpC5RTdqn+FsDF0Qw01PU1rM37wOK0YoZwvr1ZvPr5c0TWsqqv0z7nJ6V1msjgmLw4BpSRedEPPoUrcD4SjlQPcb77fwBlAleTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vxWAFK2UTi/0SoLx6oTV3i8DftxnP/LgVCtA+9Dg5rU=;
 b=tcBt3tY3Cq2dwFYhlBM+kg2JJPgSpRMwZ6ZEbmFosgkQCpuJmzIhunzolmtKuB+f/QTRzxlnO3fXcEToztpaz5hurGuKja6+TUOh2ERpNpBziZw8qbmuY6G2rBWtlnaliKPS2oTrJOC21ZVmH8+g2+JKpZhAAZwoNDm3iuDynIQQ6KpfBnbck9qTktGiGocN2rQRwcdzPbzbeiGXIoae21CgBG7uduT+WjDF2cpZ1X8yuF/MAY5hcUCE4KbZI/aSs8k94fLQ99ZMuej1UZy1yR9qZTtu4IqAeD7LZSQJn6br3uQOCNcNlOBoaQFN5jf6Je8gZjtXG7Atf44Q0MQF0Q==
Received: from AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:10c::13)
 by DB9PR10MB5187.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:324::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.14; Mon, 20 Jan
 2025 15:22:54 +0000
Received: from AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3a6d:95dc:3ce2:6da0]) by AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3a6d:95dc:3ce2:6da0%7]) with mapi id 15.20.8377.009; Mon, 20 Jan 2025
 15:22:54 +0000
From: "Heinisch, Alexander" <alexander.heinisch@siemens.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, "Kiszka,
 Jan" <jan.kiszka@siemens.com>
CC: "quirin.gylstorff@siemens.com" <quirin.gylstorff@siemens.com>
Subject: Re: [isar-cip-core][PATCH] initramfs-crypt-hook: Optimize disk
 encryption in combination with expansion of last partition
Thread-Topic: [isar-cip-core][PATCH] initramfs-crypt-hook: Optimize disk
 encryption in combination with expansion of last partition
Thread-Index: AQHbazezIiI7wjl+fkqPTcspEMyCx7MfnawAgAAQqQCAAAUUgIAAERQAgAADaAA=
Date: Mon, 20 Jan 2025 15:22:54 +0000
Message-ID: <376376fde357b10b43deea1dce1bb6bea1b76dcc.camel@siemens.com>
References: <20250120123425.79292-1-alexander.heinisch@siemens.com>
	 <0c27d834d60e2408da0e016254ad260e5dd534e5.camel@siemens.com>
	 <612ec933-6036-4df7-bda2-c07e4989a6c8@siemens.com>
	 <59ebca3ae43ddc47918de2aca962991db517fb43.camel@siemens.com>
	 <89e3feb1-a98f-422c-ace6-5ccd9d8c23f6@siemens.com>
In-Reply-To: <89e3feb1-a98f-422c-ace6-5ccd9d8c23f6@siemens.com>
Accept-Language: de-AT, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu2+intune 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM7PR10MB3320:EE_|DB9PR10MB5187:EE_
x-ms-office365-filtering-correlation-id: 2d8e4349-b9a1-4543-b673-08dd39664fa5
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?dCtUTTh2a2tUZHZaTTViS1pOaHdyQWpvcFpMVG1kSGNIWFM5eEY5OXg5Rkwx?=
 =?utf-8?B?ZGtHVkhxZmQrSlh6MUJ4S3JYa0tjVHA0b1NWVHVpQWpHWkhDSytyOXpsTGNs?=
 =?utf-8?B?L1hueHJON2t1azZCRnNMY3pORC90M1piT0x2d29RM0oyekpnMjVhUGhLZDRh?=
 =?utf-8?B?eFNNRktGcVI1V3lYWlhuVzVvbkVxK25CcnZLbFJpTXBkTFdXdzVxSCtIZE04?=
 =?utf-8?B?bHdDVEJRWEVwK2UvaElBdDVQdy8xQzZMZXJBbEcrTS9RdWNGQ3ZaZVl1ZUtT?=
 =?utf-8?B?T2cwNXZ2Tmk5NVg1T2xha003L3JOZHd6ZUVUNzh5akwxQnE3RVY1a2djbldQ?=
 =?utf-8?B?UUNvOUlMUTdkZDhKY2ZVZ25OZm00N3ZqcGx2SDcvL1FjTGloUzVRZE5LZHlV?=
 =?utf-8?B?SzhmRkxCWVBURDhKdUdYK2dCdkpvY2EzaXU1TE1NWEhudnBRRUg2MUxuOFpO?=
 =?utf-8?B?UHJ5VnlNdlBUR0ZwUmVmdWxHSHhodjFRNFA4NXhCQ002QnR2SkwwajgycjFx?=
 =?utf-8?B?Rkg3RzRYTFF3SlVIeEdJV3haZnJrbTVoYXhZN1ZsU3BwcEFMWkJYZ3Rkb1NG?=
 =?utf-8?B?MTVGZlFlNDZWQks0VlZYS3JvSzR0UFpxWmJmSkk3NnJPNXA2aGJpUWxqTE1B?=
 =?utf-8?B?SStBQzBXSXdvUmcremdLNnBSM0JsZW5tYlVyNFpJSW5rQ1NHZVo3b2JIandJ?=
 =?utf-8?B?bzZINW1WNDd0aFF0SXU4ZEhndUZXOVlIeUhCNDBMWjVsZDdlOXdUREtKRXBr?=
 =?utf-8?B?WGMrLzdHeTFmbjJmc1RpT3BobDRQV05pYXQ2dDZFWW1VRFRMNVlqZ1p5NXpP?=
 =?utf-8?B?Z1hYZ1FsRDNkemlQV3ZNeDRYUllGejZ3WVd2NDAvR0xkN1dqdXhYMk1uUEVh?=
 =?utf-8?B?ekY0SFVQTEZnYkZ1TmFvRzFUbHVtaCtqajFUV2x0M3g2OTBYL1I1azJOSDZ1?=
 =?utf-8?B?Q0pyb1NzRllZVk1XWHZWdEJoK2lvOEdrT0VscktqdlNNYkFjN1B3UEZrZVRw?=
 =?utf-8?B?NTgyUStHZ2hvUHFVb1ZRcGxOdFhVejk4bjNnT29TK0dqODRQQld1Tzg0b3dE?=
 =?utf-8?B?U0crd2JteXpIUWdZVTYrL3lYWlFYQ1dvQk1NWTRvTDc1TDZkVklRSGZaaC9J?=
 =?utf-8?B?MEszS2VpM3V1YkczTEtxcE5Ja1VHU0ZLZGVWNkJmK1RqRlZtVmcwMXZvalE2?=
 =?utf-8?B?czRmZ0RMWStIdEhmaURhUUN4Y1NrbldybTB3Z3RpTmFuWDE1elJqMUE0ZUM2?=
 =?utf-8?B?RnVudnI4TXErWXJRbnVZVjBYbHJ3RzJnT2N3dG5ZQUJ1cDhEYThvMDdsKzg2?=
 =?utf-8?B?UU5RSUtQVmtxNHhVdlRSUWpzUVhWLy9JR0N4VlF5Ly90RE14blo4b3BEYU9H?=
 =?utf-8?B?YWtGdlMrcU4rSUlZTDRLOE1aYUo2RWR3NHhFYTdTc0ZPM0RrT0dwbXFFem0y?=
 =?utf-8?B?Q3ZZK3R1Z3p0N250SGs3ZkkvYWVhU21hREFrTnNBVk54SWxLMFBXSVdPK0w4?=
 =?utf-8?B?SmZ4SEh1TW1yTCtFalQ4WnRPVUoxck05a0YwL0JSbXFIMGJ2OEtwWXZWWENl?=
 =?utf-8?B?WUpPZmlpNERsK1ZiZm5kRkNJSGV0dWxvUnFkQzNsTm9VSEd3c3l1UUpUeCtG?=
 =?utf-8?B?Z0I3S29ycHpuZ2oyY1dVM2UxdlFXNnd5eG9FaVdFVERtOUN3VzFVTFYrelFF?=
 =?utf-8?B?RmY0MnVjUVZ4cElaQmZ4UTFKUTIwdDBPNjJGYlVlekJkeE0wdzczcGwydXVF?=
 =?utf-8?B?YzNXY0dDZEZDb1ppK3hrbFZUS1I5NnpDZU16cWE4OXpZQ25kM0hEM2NsVkM3?=
 =?utf-8?B?V3pQaXc0V0gwaEh2Q2w4a3p4MExEOVgrVDFXNEF5NS9rUHNBOWVOT242Nis2?=
 =?utf-8?B?VDVYMk1MMit4dVN0bmdGb1ZvQ0FqbmNTdW5JY0U2TEJjTk55TjlTS3BVbFQ3?=
 =?utf-8?Q?AuLETxJw6vSdiRY3SVxJ+iMWDMQjgryH?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?Rkg3ZXk0QXlGTEFGcEg4bi96TitlMXkwd1RPOFZLaGJtYUpGczJneStYUUFQ?=
 =?utf-8?B?UTEyUVNQaWdpckMyYzd2em5lckxsOW5wdmUvRm5uS3JWVEl2V1JyK0JrWGZv?=
 =?utf-8?B?VlZzelgwZDZBRER4QU5BaEcvWjZ4cUxlTjZhU2VSMlRCeE9kZGFXUEY3TkpB?=
 =?utf-8?B?Zm5oRk1PejJtU2thWFRPS2g0a1VWMTVrYllsOFNTL0x5MDdLZWdaR2NTdXZY?=
 =?utf-8?B?dzVKd0xsUk1DQmE1dFJtYmJwN2JpRnpKaVRETjhnNXd6eG1lTWJxakVWeEdy?=
 =?utf-8?B?Y1FLdDZTK1pXekhUVS9JVjdXaUJ6ZUxpQWxyR1ViVnpXbDZNNE50cVpoeDlY?=
 =?utf-8?B?T3o5QU1zeEgzTy9PeG9KbzNtdW41czQzQ1FTTVo0OWRhR3hBQkV2Qy9GSEJo?=
 =?utf-8?B?M1VSQk8yMnBxYXd1dGljbllBck5jTHp4ZGkvZjhvV1BiY1Y0WHA4VVN4VTh4?=
 =?utf-8?B?OW5LakY5UitoUnJwZHloeWlGWXRjL0VxNmNrQzd3SFJzYUFkTHdDU0d4VEM5?=
 =?utf-8?B?Mkw5ZWJKNFhqZTlyaDdGMXI0ZkNOaStkWVpOSHVtV2Rpck80T0hLMk9MbjJx?=
 =?utf-8?B?UFZDSnpaMkRaSGJMblRJdVFZSkdGQk81UEdiclgwZEM0QVhoUHI2M2hsUkNZ?=
 =?utf-8?B?TUFVcnNFUnAwQVhTWDZ0N01KRkJxWlBDaW5ubWwvNzRXYitJT20xcDZsQ3pI?=
 =?utf-8?B?U1dtN2ZlckIxaUZ3TWcyR2F3RnZpbXVOb0xxa1l1aVhTaklHNEZaTTMyRUg3?=
 =?utf-8?B?UEdtZzlMbnppSU55WFBET2hQRzZuaXNXRXZLVDlKWkZwVmIwRDhNU1BkZDlN?=
 =?utf-8?B?WWZjOFNNclJUMmdGTWZPVXVJOEFkdWhWZ25IK25hSHlSWE5SNm9ZMVNXVkxv?=
 =?utf-8?B?YTFOSytGY2phMmFGWnhTNW5KYUFHZDhUZEp1TUdtTEhmQUhqUEc2QTIwb0h0?=
 =?utf-8?B?SUpNdWpjMURYd1g5dDJCNFlrVllmQU9MUTJEaVdnM3Z6bVRjY2FHbjI2T2Ux?=
 =?utf-8?B?L284ZWxieUJLSDlxeks1dnhjWUNwNG5LVUFIZ1JvNUU0cHZVODZsNzNxYXFB?=
 =?utf-8?B?R3E3RGFHQ09MZmNvQmtITUpTRzQ3Y3A0aHRLOUhveVkvL0wxQmMwOWJzaTBS?=
 =?utf-8?B?OUZKeHhXZm5mMFVzU3c5dytwQ090aVZocTdRc2RhZk42WWpKK2FxUWtKM3RT?=
 =?utf-8?B?bEl0bHRESFVZTEhxRzlSMEx2NmdvanIzS0tVSFNKZS9VTEZjUHcrU2loTXNy?=
 =?utf-8?B?ZkFmUTFFWE9EU3U0ZDdGL05vSG8vcDZ5ek1hWHpRNFZGc21xcXY1YXBTQWN5?=
 =?utf-8?B?TDFxdjFHa3premRvS1lwK0NGWW5ETW9hSTgyR3pXS01sM3E4RTNzSXpIQkxi?=
 =?utf-8?B?SVNvQzc1OXJ5amN4ZUJ3NHV3WFpiazU1NXFQRFZ5MHB4bHFxZjVWRktzYU1Y?=
 =?utf-8?B?RElGUUFYVzdHMmZBcEJISldsUEhqc05lZ2k1Q0FJL3N0M25RandxeHNtb2RJ?=
 =?utf-8?B?QnNna1MxNFkzZnFwUjY2MG9HNGozbGc1bm4zV29CNU1ONkpSU0F3UFYvTnUy?=
 =?utf-8?B?TnV0Tlg2L3JrenlnYzJGdWgyc0JOWE04dlRWZmw0K3pDYkt4a0VFaktvY3g3?=
 =?utf-8?B?QngvYStIc3lESXFNaEtTajJUSStRRU94SGtHdmowRnRZaW91bWZBRnRRazZy?=
 =?utf-8?B?akU0MXpUUThXRVFRRVd4aEZYd2lZOVE3dlNjVXVYVzNxSG4wN2NnaGdwWll0?=
 =?utf-8?B?MGUvLzZvOWxaaGNqa0lESmVvMUREVEQ3SmQ0UXR0bG1wTi9ieTFNT3lEMlMr?=
 =?utf-8?B?Tlo5R0JGbSt2ZEhkNThuSEg3aW5RVFR3Nmp3RHdPME9MeWxVdG94azcvSndw?=
 =?utf-8?B?YXRmVHVPUm40d2dNcTZsc3FpY1ArOXBOZkNMcEN4ZmNQRWQrVGp1Y0szWm5k?=
 =?utf-8?B?a2Z2cXUxM1Nub2JBNVp6ZEhkelRlUVZ6V05Wc1d3T2FjM0FjK3MxUngxelVt?=
 =?utf-8?B?dXhhRkZDbHplS3FDQjM3byt1OXoxUk1VbWgxSkgxQm82czYydFBINVM3anZp?=
 =?utf-8?B?YjdPbEVRRC9Uc3dwQ3RqbndkQzNqUU16YTgvM3Y2TkdQUFcxdEtYWU4yN2U3?=
 =?utf-8?B?eW9xQzk2T2h0aWtWRTZJV0tWSEMwdzNZYmpCcndaV0YrNHhuT2xqRG9reU9P?=
 =?utf-8?Q?d5FzsIRZ6C1Lr9x4kPoMxvg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FE185663F0070240B10FBFA5C90CD37B@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d8e4349-b9a1-4543-b673-08dd39664fa5
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2025 15:22:54.1973
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fwsSXiWwnHZCgkCz4jC9C2DaXA0v1a96JIfj3hcue82NfikByTzD8Oa/M7F+083BLZJ+9ENL+OkZg45YbwZrnDtvcWuPMqHlzWV6u0uZ750=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5187
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 20 Jan 2025 15:23:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17555

T24gTW9uLCAyMDI1LTAxLTIwIGF0IDE2OjEwICswMTAwLCBKYW4gS2lzemthIHdyb3RlOg0KPiBP
biAyMC4wMS4yNSAxNTowOSwgSGVpbmlzY2gsIEFsZXhhbmRlciAoRlQgUlBEIENFRCBTRVMtQVQp
IHdyb3RlOg0KPiA+IE9uIE1vbiwgMjAyNS0wMS0yMCBhdCAxNDo1MSArMDEwMCwgSmFuIEtpc3pr
YSB3cm90ZToNCj4gPiA+IE9uIDIwLjAxLjI1IDEzOjUxLCBIZWluaXNjaCwgQWxleGFuZGVyIChG
VCBSUEQgQ0VEIFNFUy1BVCkgd3JvdGU6DQo+ID4gPiA+IE9uIE1vbiwgMjAyNS0wMS0yMCBhdCAx
MzozNCArMDEwMCwNCj4gPiA+ID4gYWxleGFuZGVyLmhlaW5pc2NoQHNpZW1lbnMuY29tDQo+ID4g
PiA+IHdyb3RlOg0KPiA+ID4gPiA+IEZyb206IEFsZXhhbmRlciBIZWluaXNjaCA8YWxleGFuZGVy
LmhlaW5pc2NoQHNpZW1lbnMuY29tPg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gSW4gdGhlIGN1cnJl
bnQgaW1wbGVtZW50YXRpb24gKHNpbmNlOiAyODQxNzVjMykgZGlzaw0KPiA+ID4gPiA+IGV4cGFu
c2lvbg0KPiA+ID4gPiA+IGxvZ2ljDQo+ID4gPiA+ID4gaXMgZG9uZSBiZWZvcmUgdGhlIGFjdHVh
bCBkaXNrIGVuY3J5cHRpb24uDQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBUaGlzIHJlc3VsdHMgaW4g
cmVlbmNyeXB0aW5nIHRoZSBmdWxsIGV4cGFuZGVkIHNpemUgb2YgdGhlDQo+ID4gPiA+ID4gZGlz
aywNCj4gPiA+ID4gPiBpbnN0ZWFkDQo+ID4gPiA+ID4gb2Ygb25seSByZWVuY3J5cHRpbmcgdGhl
IHNlY3Rpb25zIGNvbnRhaW5pbmcgdGhlIGFjdHVhbCBkYXRhLg0KPiA+ID4gPiA+IFRoaXMNCj4g
PiA+ID4gPiByZXN1bHRzDQo+ID4gPiA+ID4gaW4gYSBkcmFzdGljIGluY3JlYXNlIG9mIHRpbWUg
KGFwcHJveCAyMHggb24gb3VyIHN5c3RlbXMgKQ0KPiA+ID4gPiA+IG5lZWRlZA0KPiA+ID4gPiA+
IGZvcg0KPiA+ID4gPiA+IHJlZW5jcnlwdGlvbiENCj4gPiA+ID4gPg0KPiA+ID4gPiA+IFNpbmNl
IHJlbGV2YW50IGRpc2sgY29udGVudHMgYXJlIG9ubHkgYXZhaWxhYmxlIGluIHRoZQ0KPiA+ID4g
PiA+IHNlY3Rpb25zDQo+ID4gPiA+ID4gb2YNCj4gPiA+ID4gPiB0aGUgZGlzaw0KPiA+ID4gPiA+
IGF2YWlsYWJsZSBiZWZvcmUgdGhlIGV4cGFuc2lvbiwgaXQgaXMgc3VmZmljaWVudCB0byByZWVu
Y3J5cHQNCj4gPiA+ID4gPiB0aGVtDQo+ID4gPiA+ID4gb25seS4NCj4gPiA+ID4gPg0KPiA+ID4g
PiA+IFRoaXMgcGF0Y2ggY2hhbmdlcyBvcmRlciBvZiBlbmNyeXB0aW9uIGFuZCBkaXNrIGV4cGFu
c2lvbg0KPiA+ID4gPiA+IHJlc3VsdGluZw0KPiA+ID4gPiA+IGluDQo+ID4gPiA+ID4gZmFzdGVy
IGVuY3J5cHRpb24gKHNpbmNlIG9ubHkgdGhlIG5lY2Vzc2FyeSBwYXJ0cyBhcmUNCj4gPiA+ID4g
PiBlbmNyeXB0ZWQpLg0KPiA+ID4gPiA+IFRoZSByZXNpemUgb3BlcmF0aW9uIGRvZXMgbm90IHJl
ZW5jcnlwdCB0aGUgYWRkZWQgZGlzayBwYXJ0cw0KPiA+ID4gPiA+IGJ1dA0KPiA+ID4gPiA+IGp1
c3QNCj4gPiA+ID4gPiBleHRlbmRzIHRoZSBMVUtTIGNvbnRhaW5lciAoY3J5cHRzZXR1cCByZXNp
emUpIHRvIHJlZmxlY3QgdGhlDQo+ID4gPiA+ID4gbWF4aW11bQ0KPiA+ID4gPiA+IGF2YWlsYWJs
ZSBkaXNrIHNwYWNlLg0KPiA+ID4gPg0KPiA+ID4gPiBUaGUgdGhpbmcgSSBhbSBub3Qgc3VyZSBh
Ym91dCB0aGlzIHBhdGNoIGlzLCBpZiBleGVjdXRpbmcgdGhlDQo+ID4gPiA+IGRpc2sNCj4gPiA+
ID4gZXhwYW5zaW9uIGhlcmUgaXMgcmVhbGx5IHRoZSB3YXkgdG8gZ28sIG9yIGlmIHdlIHNoYWxs
IGp1c3QNCj4gPiA+ID4gcmV1c2UNCj4gPiA+ID4gdGhlDQo+ID4gPiA+IGV4cGFuZC1vbi1maXJz
dC1ib290IGZyb20gaXNhciAoaW5jbC4gZml4ZXMgcHJvcG9zZWQgZWFybGllciAtDQo+ID4gPiA+
IFsxXSk/DQo+ID4gPiA+DQo+ID4gPg0KPiA+ID4gSWYgeW91IGZpbmQgYSBnb29kIHdheSB0byBm
YWN0b3Igb3V0IHRoZSBjb21tb24gY29kZSBhbiByZXVzZQ0KPiA+ID4gdGhhdA0KPiA+ID4gaW5z
aWRlIHRoZSBpbml0cmFtZnMsIEknbSBvcGVuIGZvciBwYXRjaGVzLiBIb3dldmVyLCBhcyB3ZQ0K
PiA+ID4gZGlzY3Vzc2VkDQo+ID4gPiBvbg0KPiA+ID4gdGhlIGlzYXIgbGlzdCBhcyB3ZWxsLCB1
c2luZyB0aGUgc3lzdGVtZCBzZXJ2aWNlIGxhdGVyIG9uIHdpbGwgbm8NCj4gPiA+IGxvbmdlcg0K
PiA+ID4gd29yayBvbmNlIHdlIHByb3Blcmx5IGhpZGUgdGhlIGtleXMgd2hlbiBpbml0cmFtZnMg
ZW5kcy4NCj4gPiA+DQo+ID4NCj4gPiBUcnVlIQ0KPiA+DQo+ID4gUmVmYWN0b3JpbmcgdGhhdCBw
YXJ0IG91dCwgcHJvYmFibHkgaW50cm9kdWNlcyBtb3JlIGJvaWxlcnBsYXRlLA0KPiA+IHRoYW4N
Cj4gPiB0aGUgYWN0dWFsIHJlZmFjdG9yaW5nIHdpbGwgc2F2ZS4gQW55aG93LCBvbmNlIHRoZSBu
ZXcgc2VhbGluZyBpcw0KPiA+IGluDQo+ID4gcGxhY2UgdGhlIHN5c3RlbWQgc2VydmljZSBzdXBw
b3J0IGZvciBjcnlwdCBoYXMgdG8gYmUNCj4gPiByZWNvbnNpZGVyZWQvZHJvcHBlZCBhbnl3YXlz
Lg0KPg0KPiBUaGF0IHdhcyBhbHJlYWR5IGRvbmU6DQo+DQoNClNvbWVob3cgbWFuYWdlZCB0byBu
b3Qgbm90aWNlIHRoZSByZXZlcnQsIHVudGlsIG5vdy4gU28sIHBsZWFzZSBqdXN0DQppZ25vcmUg
dGhlIGNvbW1lbnRzIDotKQ0KDQo+IGh0dHBzOi8vZ2l0aHViLmNvbS9pbGJlcnMvaXNhci9jb21t
aXQvMDA0Zjk5MzUxMDJmODFiMThhNTRmYzljMDk0MGQyM2I4NGJlNDExYQ0KPg0KPiBUaGUgaXNh
ciBzZXJ2aWNlIGlzIGZvciB1bmVuY3J5cHRlZCBwYXJ0aXRpb25zIG9ubHksIHRoaXMgb25lIGhl
cmUgaXMNCj4gZm9yIGZ1bGx5IGludGVncmF0ZWQgZW5jcnlwdGVkIG9uZXMuDQoNCjotKQ0KPg0K
DQo+IEphbg0KPg0KDQo=

