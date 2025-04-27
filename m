Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 816A4C369D1
	for <webhook@archiver.kernel.org>; Sun, 27 Apr 2025 19:39:51 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.12])
 by mx.groups.io with SMTP id smtpd.web10.32449.1745782781138585361
 for <cip-dev@lists.cip-project.org>;
 Sun, 27 Apr 2025 12:39:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=hwbUaa+A;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.12, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pvY/6S0yB3sqlajXr4W2JeND5oenyv0bOzr5FlgG0ncmQ+oivnrL1gugp5VPUNhn+dx5Dlh69meK5mwz9uhwXnfBZtvZ8poEHZzqHMOmk9ap2gHad0k48hOc3F1jNTNhCvmh+zFz/A17PzAYJyhzhCU9nccPbOm6Qb2zHZoobgqmC+QU5tsxd/89MhbpkEzfoAE02DJJVCDgUCHuI8tXMylztzyS4dCC05iuFWOIpxHcfRedadQGkf63WGIIW9im7MQNVhW2KfgTu3W4SbVfVT5/wrZaB0xLwN36xQIWYdtvt8gDR1ZH24ES+0KxCLqGMT1dK7AjUoAkkbdEkyLNgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OsH/Fr/VRqrl+4kxHVqxtz3mWP29WLWBoN1IbJS9lyQ=;
 b=IrcnoyX2qfWO9TaMFw9lo8LrRoBmYYyyAN6CgA1gXSiw6RY+75ozfUl7Ck2ZxmNXhTKTBe36qFwy65jS0O7nPXLF0rNXFIfdPddrAoCpu3bqOxWUx++yRAECiQ0cIOzvjIyw2pBVYxLJmwYkuhUOcV8VLoLBNAfS2hhVrKWvGYdENwvBdQpQ15WobRl5VAaTZBCja9h5NDMNprLN4pyQrY4672/nEiu/PrJvKKQBMoxs7jWv7tXiQBrr58yJ8iSh/+mN4gMx5kFL7OqD403g3dZAc7TJRsJVJxgxkAQuI5bh/DJ/ZZtFEORfMDGo5YuNYHTo13QZiRwLiT6LQn06oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OsH/Fr/VRqrl+4kxHVqxtz3mWP29WLWBoN1IbJS9lyQ=;
 b=hwbUaa+A+U8NyMlGi6BG+xs73sdUULyGaTrPLnuPaRmNRwH+aY6PhWe46KU84e5aFzc3Juy11AJjUrWY58iVgi3tflSd8rQ148RGXGr/huYTDgTxDZqDg8TtpniIq+bomlEL7XmaM9EgBLdxmvNSummtSCpvfXd5y8vZQfsSu0w=
Received: from OSZPR01MB7019.jpnprd01.prod.outlook.com (2603:1096:604:13c::8)
 by TY1PR01MB10848.jpnprd01.prod.outlook.com (2603:1096:400:324::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.31; Sun, 27 Apr
 2025 19:39:31 +0000
Received: from OSZPR01MB7019.jpnprd01.prod.outlook.com
 ([fe80::8a27:ee0d:d7a4:9d10]) by OSZPR01MB7019.jpnprd01.prod.outlook.com
 ([fe80::8a27:ee0d:d7a4:9d10%7]) with mapi id 15.20.8678.028; Sun, 27 Apr 2025
 19:39:31 +0000
From: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: "nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>,
	"pavel@denx.de" <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>, "cip-dev@lists.cip-project.org"
	<cip-dev@lists.cip-project.org>
Subject: RE: [cip-dev] [PATCH 4.4.y-cip] ARM: shmobile: smp: Enforce
 shmobile_smp_* alignment
Thread-Topic: [cip-dev] [PATCH 4.4.y-cip] ARM: shmobile: smp: Enforce
 shmobile_smp_* alignment
Thread-Index: AQHbpUgQJ4XZlFPttEOjVvE3iV3PDLOmMT4QgAFA6XCAEJsfkA==
Date: Sun, 27 Apr 2025 19:39:31 +0000
Message-ID: 
 <OSZPR01MB7019C7990FA3543B1F69A6CFAA862@OSZPR01MB7019.jpnprd01.prod.outlook.com>
References: <1833151A32081021.4816@lists.cip-project.org>
 <TYYPR01MB7024C8C39B7B1226B7924447AABD2@TYYPR01MB7024.jpnprd01.prod.outlook.com>
 <TY7PR01MB14818A6DBF8C7D899210ED72592BC2@TY7PR01MB14818.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <TY7PR01MB14818A6DBF8C7D899210ED72592BC2@TY7PR01MB14818.jpnprd01.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB7019:EE_|TY1PR01MB10848:EE_
x-ms-office365-filtering-correlation-id: de2d5f37-372f-4ebf-edeb-08dd85c33b39
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|1800799024|366016|7053199007|38070700018;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?cTdQbk16QmtwblUxdVhXVkpTc29IYkZYNExXWlBTbTFrVGdyTWxsTTE1?=
 =?iso-2022-jp?B?aHYyNzRsaXI1NnI2Rjg3UjVLWm1vcUQ2Sm5zQ2o5WTdoRGh1aUJwVkNx?=
 =?iso-2022-jp?B?SlI4NDZLUFdZUWZ0TkpRdWNwTGVGWjlVYzdNNWowb2lYYlhMOU10Um1w?=
 =?iso-2022-jp?B?S0JaQWo5dER2cFNSS3MyNGdNM3NFTmZXY2lETll0cXNRZmxiZXdOanMx?=
 =?iso-2022-jp?B?M0pzRTFkdWx3S21UeU45dFJ2MVhCeTJONDlZYTJpdVQzMW45WFJhMXJH?=
 =?iso-2022-jp?B?Vi9FQXRrUkh4TytLTzQrUFVmV1B3NlBvOTlMckVmY3lZdEZ2bXpvVVd4?=
 =?iso-2022-jp?B?eWxrYVc4OURqN3k5M1gzbm40UE9Dbnp5YUFNb29Xb3ZaYXNNZXhEdkZU?=
 =?iso-2022-jp?B?d1lTa0t0RU5STGxKc1ZVY3FFVWppejU0bVVXN3VicjczYUxoTGlIT3ZE?=
 =?iso-2022-jp?B?TktaakYxQlRGYUNLR0s0NWtGVXhHWFVQV0EyeW5Id2lEekRGazVhQTVR?=
 =?iso-2022-jp?B?OUM0MEEydTlmVkVNNG5EbmhCQW9wdFdqdmJEaW1KNUxOTzgrbVFQMmQ2?=
 =?iso-2022-jp?B?a2ZNY1FmQkxZU0NhNlVGaGtmWkVvaGE3dUNRWnNVVzNJMWlSeFc4RlBY?=
 =?iso-2022-jp?B?U2FJK0J5ZW5SdnRCS2ZxSzkrOVRXaXYzcHlIWkFPWWR4NUYzOWFKYUZJ?=
 =?iso-2022-jp?B?M2QvUUhJK3VnK1FiSXdzQlM1ODQ0RnozQU0zMmNtYjIwS2FreVJaYXI2?=
 =?iso-2022-jp?B?ZlRwKzBMcktNV29vcTUwdU1rRHJtd1dRSVU0dmU0Q0RKUExYMXhja0U0?=
 =?iso-2022-jp?B?ZlNJTi9CSzZQemJnNXJGcUZYNHpPdlhkdnVTREQzL2gvaVNVRThJL1hs?=
 =?iso-2022-jp?B?UnY5cU5ieUZ6ZXB6cW9Ccy8rSVc2YnU2dFowb3NkV0pRMlloNmxwL2xy?=
 =?iso-2022-jp?B?U1lMS0RuUVBUZWQvU2NLZlgxY3NaSWdnWEhOSjU5b3dDc3hwWGNES3lh?=
 =?iso-2022-jp?B?aVp6UmlQejJxUFhPNE5zcVZCUU93OTF3eWhDRTV0VmxsZmRKNlVCWHM4?=
 =?iso-2022-jp?B?OW8wUklEOGtiMFh6WVE2NE1Ob0p3MHoxZHk1YmRrcm5GY0dtTm8vUEcr?=
 =?iso-2022-jp?B?WUFDbWtzME1zSUFHV0NiU0dWSEZ3Sy9XSzgvbDF6aWQrdGRpaGpnRGZW?=
 =?iso-2022-jp?B?UFF0dGduYUJLbW9saVVDWFpveTR3bW94ZkE3MWdtcGh0L3BkeERBRWNi?=
 =?iso-2022-jp?B?cGMrZUZ6Nm01eVQyaDJ1YVE4RzVpNDU2R2xNbEtJaHhPbEN5aElZL1Rl?=
 =?iso-2022-jp?B?RVFtZTZSVExhTUV5QjlFNnM2bnArMEZ6S29HRW9wQkZSNk0xMDZvdU5s?=
 =?iso-2022-jp?B?ejJaTkcrM08vZDlNaGhSYXdhUmRQK3VvM1gzNkpVd0pIbzBXbXlmQjZm?=
 =?iso-2022-jp?B?dEIrN3ZxRTFaczF2QjMxMTJjZ1lERkI5SFFWSHN0d1ZXR090VlRHS2tw?=
 =?iso-2022-jp?B?eU9mS3ZrV2V5Y0VER2JiYjVwOGV4Y0M2MmtDT2F4NlUxZXVOUHlBQTJU?=
 =?iso-2022-jp?B?NEJkK3kyUmphMWNLRmVzejVZaVo5ZDlkeTBEdWhGc29DWkZLMVJYQUZY?=
 =?iso-2022-jp?B?NWZRKzhZUENOREFRUXdHd2oyVzdzSktjVVpaQUtpYlJGNjBCQ0tYU2tx?=
 =?iso-2022-jp?B?ZWI2Ylg1ZTdidnI2bnhySlJFd3JYSGFPNlBPblYwdXUxWkthaFVlbm5u?=
 =?iso-2022-jp?B?V2RxTUllTXdhZFFQbDNQSjZPLzJ5Tm13NHJZRmorS2VPV09aV2NzQjZn?=
 =?iso-2022-jp?B?M2dySXBDQ3g4ZEQvUVNmbW9iRWlHWTBiRUpsUXVtZUZGRW9hTkliQ1ow?=
 =?iso-2022-jp?B?dG1pbmo4SEhNQzVQU3FYTTdFUnRPbm9wUjhoS3VnZTU3eGd0Zkt6bENp?=
 =?iso-2022-jp?B?VHJ5WUhjdGdHYUtyUWMzaDRMZjJzSlBLcmllSWJZMzVid2U4MVJEN2dC?=
 =?iso-2022-jp?B?RTl3dHpBSU02Wi9UN0F0L3RWWWRkYTVlckJFS0tIeFZFSDV2dHlCYlV5?=
 =?iso-2022-jp?B?RGVjTXUrMEE2dFIraTh3OHdGTDU5ZmZLT2RiR3pYU2VXdjVycmVXTlBw?=
 =?iso-2022-jp?B?QzhONDAyRHZiMTM4eGw3bEtadjZIVVFBak5UdVBvZWdlOTl2T1c2MUpE?=
 =?iso-2022-jp?B?diswPQ==?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB7019.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?T0dNSVdnTjJPcU1FRWxNaDkyMkZ2R2QvTkFzU2IvRU4wS3dZK1NNVEh4?=
 =?iso-2022-jp?B?UUVIVDdueURtZXIxRE1kNWNXUVdjK1htZE5SVTFVSnU4OWgwc3ZzWUYw?=
 =?iso-2022-jp?B?UDUxck5ISzBuNXd4QnVmYTFoVUh0VjFGRW5LSzEzUmNjYnM0enI3M2Nn?=
 =?iso-2022-jp?B?MzRlazhQNWdTS0VDZ09DdTk1RFBRTEVQekEwNS9vRXNScnhKUm5GVUVK?=
 =?iso-2022-jp?B?SWNseVpObnNqSXhzdEd5bDFkNWFKRHRldzdrSm03L3ZFMzliWWptZ1V5?=
 =?iso-2022-jp?B?Y1J1eUVzdW9jcVIvck1ScTdyY0s0TitCbkF0a0ZHQ0RyQ0ZrRmxZSXND?=
 =?iso-2022-jp?B?N0dwb3F0SFNZZ3lvMXhQVDZpckNpVXhtV05XcDNhcDBKVnQrSnFvcGtI?=
 =?iso-2022-jp?B?Vmg4Q0E3am1tWXc3c0VEUEo4VjBNV0FGdzAxamUrcEpCWEVVaXBySkpX?=
 =?iso-2022-jp?B?MFF6QUpUb0dLMTBCOURMREl4YUI3c0xDaWx3SDdOWE9jdUdCSVRVaWt2?=
 =?iso-2022-jp?B?TFZia0pMQ2UrVFJ6NlVmRy9KQ2hNZ3Nyc2lqVE9XUFZscFhoSjAyQ1R5?=
 =?iso-2022-jp?B?Qy9hM3d1dFVhZWhBVnFJdkhRTklhdHRNVHlSKy9kYzB1aTdQcHp2akFj?=
 =?iso-2022-jp?B?dlVrY0lXY0doQXZBOXNuYTgzaFN1UktIa1N3YjNncEl6WXZtb3A3UGNh?=
 =?iso-2022-jp?B?SWtYYnppNjNpUUkvUUJMQ0lqZ3BEY0V3VlM1U0VjNVRPM3JNUDh5U005?=
 =?iso-2022-jp?B?ZWwvNGIvSkt2NEFsbzE3aGQybEI4bkpHWGNkYVpwVzQ1NkUvd29QZWpT?=
 =?iso-2022-jp?B?YlR2d09NNElvOGtDUnlYeHlGa0NJTUJtU1VWcFU3cHUrTDUvSXEvNEVS?=
 =?iso-2022-jp?B?UE1sYVovR2RTQUg4MlNjREJUN0xoai9WMityWTdjWS9DRy9vNS9rUE5x?=
 =?iso-2022-jp?B?YmkvdkRLR3hLd1krYmgrdDl3a0xDQ1hhM1E4R3RZS0JSU3NnNUN5bnE3?=
 =?iso-2022-jp?B?UWQwRnk1eXZWMXZpQUtGS213d25hdU9YYjVJS0ZOOTduZUlwZXA0elQ1?=
 =?iso-2022-jp?B?TEdLLzhlTTJoaGM0ZUdwdC9zWVFLU0RqK2RLc21jbloxWjIwOC9QK1cr?=
 =?iso-2022-jp?B?R21MTkRJOEVVaU1EdTZ1YThZS2tlK3JnT1UzUEdHMkVLczlVSERJZVE0?=
 =?iso-2022-jp?B?T3VWaEpVbnB1Q1NBN3JTd0hnNWRWNEcwSmlKVk00cXoyaTd6SUFzRVB3?=
 =?iso-2022-jp?B?NUhYd2NSWmhRcHBSRVZ6Tk5mNjRrb3pscnFMRHluMWcycWhDZUZsL29X?=
 =?iso-2022-jp?B?YnB0THFGYXV5bUlyTmZPOVJBUllYejcyWFdEWDd0V3NuaEZFK2hYRzV3?=
 =?iso-2022-jp?B?RHZoNUF3a0FyMDBKVU1iU1RmNEhQQWk4MTNVenMrdEtNdGM2WGJDM09m?=
 =?iso-2022-jp?B?Q0pHTXpRQWVqWUw0OXAxUVFDd1hydU1qZU5iVXZhVldLWm42UUVnUUIz?=
 =?iso-2022-jp?B?bEtWVVVmVk80U1dPckZNemIzMXhJOXdaaEhQTTFmd0dyT3ZkTHgxbGpE?=
 =?iso-2022-jp?B?ZWJON1AyMHQ3S3NhVENYNUlJdUFIODFRWjlJMWNmTy8xWjNTL3dSaUJ5?=
 =?iso-2022-jp?B?cTJPOXVRL2JwbnpZSno0UW9hb1pHd0xkaDdKeHQ2aDlIV0NJYWdqSWJK?=
 =?iso-2022-jp?B?T25waEttSm1FMWpBeUkzZTZaVndOMUNmNzl2Y3Y5ZGJTNXIzenV4WjB4?=
 =?iso-2022-jp?B?YS9RVEUwblpkWlFMZzk4SHRBb3J3Ymw2UFR6eFdZSW1IQUxBeU15bXlx?=
 =?iso-2022-jp?B?emZHNkF2cktjRFVSZDRmNmVHeUYydmY5T2JzUjk4SU1XclhKZ0J2Vk02?=
 =?iso-2022-jp?B?bHhvUjdKU0JWWUhVbUhlRXhTQnR5UmZqNGFaL1Z6MUNNOW5pa3RudUNt?=
 =?iso-2022-jp?B?Z2dNTEU1RmhGc2Rhei9uTXY4ZUR0K1ptK0FYOVBKYkIrSE1BSmJDWjY4?=
 =?iso-2022-jp?B?Z053Wjlua2VhRFFEMmhLNlNXMDV1N3hGSnpib20yMlprdytOUjIrUWhU?=
 =?iso-2022-jp?B?UjNjbjJlR29GYnlOOVdncWlHMU90TncxcWJ2M1hwbnFuVlYwU0piUXB2?=
 =?iso-2022-jp?B?emdQM0MwL2VVbm1STTRKQmNjcmJhWmRjdTJFL2Q5Zld5RVlKMmtZYlZY?=
 =?iso-2022-jp?B?enAyaXA2MlloY1RFdnhQOGxyTzJGWStzMUhKUjZ0WW91TlJhQTVwaERr?=
 =?iso-2022-jp?B?TGRwcGs1NnY3VkY5aW9CNStldnl4ZFhNZ2gzMzJ4NHVJSGsxUjB3NW11?=
 =?iso-2022-jp?B?Rlh6WlZCNTl6T0pSRkIrWnFpUXpkaFRCWTRVRXJDYTE3VHlmR2JDbWNZ?=
 =?iso-2022-jp?B?a2l2RnM9?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB7019.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de2d5f37-372f-4ebf-edeb-08dd85c33b39
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2025 19:39:31.4796
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6G/Zr/o4YUUBq2q23ynRolHSBdeD7nKCLpZvT1QA1q9R7GHWNdX/ohUr8GeGhp7ZMyE2XJoIYuc6QxOX84CFQNX1vAkR3JJ10cwsxxBL1sSAJ7LqHA0c7D60mJxkBEDu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB10848
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 27 Apr 2025 19:39:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18668

Hi Iwamatsu-san,

> -----Original Message-----
> From: nobuhiro1.iwamatsu@toshiba.co.jp <nobuhiro1.iwamatsu@toshiba.co.jp>
> Sent: 17 April 2025 07:05
> To: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>;
> pavel@denx.de
> Cc: Biju Das <biju.das.jz@bp.renesas.com>; cip-dev@lists.cip-project.org
> Subject: RE: [cip-dev] [PATCH 4.4.y-cip] ARM: shmobile: smp: Enforce
> shmobile_smp_* alignment
>=20
> Hi Prabhakar,
>=20
> Sorry for review is too late.
>=20
> > -----Original Message-----
> > From: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > Sent: Wednesday, April 16, 2025 7:56 PM
> > To: iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B?.MN=1B(B =1B$B""#D#I#T#C!{#C=
#P#T=1B(B)
> > <nobuhiro1.iwamatsu@toshiba.co.jp>; Pavel Machek <pavel@denx.de>
> > Cc: Biju Das <biju.das.jz@bp.renesas.com>; Prabhakar Mahadev Lad
> > <prabhakar.mahadev-lad.rj@bp.renesas.com>;
> > cip-dev@lists.cip-project.org
> > Subject: RE: [cip-dev] [PATCH 4.4.y-cip] ARM: shmobile: smp: Enforce
> > shmobile_smp_* alignment
> >
> > Hi All,
> >
> > > From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org>
> > > On Behalf Of Lad Prabhakar via lists.cip-project.org
> > > Sent: 04 April 2025 10:58
> > > To: cip-dev@lists.cip-project.org; Nobuhiro Iwamatsu
> > > <nobuhiro1.iwamatsu@toshiba.co.jp>; Pavel Machek <pavel@denx.de>
> > > Cc: Biju Das <biju.das.jz@bp.renesas.com>
> > > Subject: [cip-dev] [PATCH 4.4.y-cip] ARM: shmobile: smp: Enforce
> > > shmobile_smp_* alignment
> > >
> > > From: Geert Uytterhoeven <geert+renesas@glider.be>
> > >
> > > commit 379c590113ce46f605439d4887996c60ab8820cc upstream.
> > >
> > > When the addresses of the shmobile_smp_mpidr, shmobile_smp_fn, and
> > > shmobile_smp_arg variables are not multiples of 4 bytes, secondary
> > > CPU bring-up fails:
> > >
> > >     smp: Bringing up secondary CPUs ...
> > >     CPU1: failed to come online
> > >     CPU2: failed to come online
> > >     CPU3: failed to come online
> > >     smp: Brought up 1 node, 1 CPU
> > >
> > > Fix this by adding the missing alignment directive.
> > >
> > > Fixes: 4e960f52fce16a3b ("ARM: shmobile: Move shmobile_smp_{mpidr,
> > > fn, arg}[] from .text to .bss")
> > > Closes: https://lore.kernel.org/r/CAMuHMdU=3DQR-JLgEHKWpsr6SbaZRc-
> > > Hz9r91JfpP8c3n2G-OjqA@mail.gmail.com
> > > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > > Tested-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > Link:
> > >
> > https://lore.kernel.org/c499234d559a0d95ad9472883e46077311051cd8.17416
> > > 1220
> > > 8.git.geert+renesas@glider.be
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Lad Prabhakar
> > <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > ---
> > > Hi All,
> > >
> > > Note:
> > > - This issue has been replicated on 4.4-cip with older compilers and
> > > CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE enabled.
> > > - The offending commit 4e960f52fce16a3b is not present in v4.4
> > > release so this patch wont be backported into 4.4-cip by stable
> > > hence just sending this for 4.4-cip only. Please note this patch has
> > > been cherry-picked v6.14 release.
> > >
> > Gentle ping for review.
> >
>=20
> LGTM.
>=20
> Reviewed-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
>=20
Thank you for the review. This patch is missing in 4.4-cip.

Cheers,
Prabhakar

