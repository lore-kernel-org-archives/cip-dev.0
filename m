Return-Path: <chris.paterson2@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD619CAC5B1
	for <webhook@archiver.kernel.org>; Thu, 25 Sep 2025 15:40:13 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.40])
 by mx.groups.io with SMTP id smtpd.web10.184.1758814807397194899
 for <cip-dev@lists.cip-project.org>;
 Thu, 25 Sep 2025 08:40:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=EQXnKjqr;
 spf=pass (domain: renesas.com, ip: 52.101.125.40, mailfrom: chris.paterson2@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UjMNe1UDf6hrqx7xt2albKdnw7eIvxXuySbh+AVtLoSJ8OFoc0elzt88zqxbUlgLOShQwudY7rJjTJPwNUmIDFbvemS5UTUxF88m85s2xCuA4i4o/HPMJBzfycmaszfG0ryOJzixXSBC613bpW3QLCN8c6nIBIAhLqKY1IHbfFkZ9YLWWu4QNN27Vmy4TAe2MqfyZ24b2InzL50vPs8ZNjWPi3ETduS2OmFx2ZCSqtnXoNuMmIfb+wNFEy0FJNhAN79UkTsEGw52fauHOn4BFQFKwgWGA8xKGJ6JckZwyDViLtvemwVfBhM+xuaOXCCs8xcZ7lrRgN1OHjyDpUxrUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mENaUG/Id0+/3nLiY3d6GGQ/1UIFE90FKnWlP/Nk5xg=;
 b=tGtkwE3WVdg6k3iTSw3JpksYxlkQ4x3fDByf5ai+H/WceC0M6j6pZELrkA9CdH3eIxh1yeZEkAD1R5wncb6S1M6FIPbyKBoz23sCCSJ9h9Eg/W2OrMp3a7FexI2n9AavYwEhhyBesqiBi0NFoZUnfYsA47mHb4AoE0yYgECIPif5yxE7zHcSlum/CSp64bToidrfgbDPIjToASYOnquTgfFiTBxDyWIJiJLs5UI5ynDFJbzc2Eh7DZUxMev88lUWcbOEfb4R80FF5TSCEwgJ0MWN0SS/6IlhpOs+aWA07yzgSYNToKhuL+FPI+CD3L1jV7X/j4R9UxchjYQIeErb+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mENaUG/Id0+/3nLiY3d6GGQ/1UIFE90FKnWlP/Nk5xg=;
 b=EQXnKjqrZW3inhVePdWtog0dg6kNIZBw9iR2p0aqE0aPjf81N57CVLNlS+76pKtuxuTITeIlpAm54w4jgoAg15V/+oJYm8XcKJwlgBJZZ6e1IKq36p8i7TmKOa3teiuk5uKiDyMlodJA6XlnAmimwMLhU8rYTXQtfVuh58WaLVs=
Received: from TYYPR01MB15132.jpnprd01.prod.outlook.com
 (2603:1096:405:1a1::10) by TYCPR01MB9909.jpnprd01.prod.outlook.com
 (2603:1096:400:20f::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.11; Thu, 25 Sep
 2025 15:40:01 +0000
Received: from TYYPR01MB15132.jpnprd01.prod.outlook.com
 ([fe80::3fd9:f47c:79c7:a6c6]) by TYYPR01MB15132.jpnprd01.prod.outlook.com
 ([fe80::3fd9:f47c:79c7:a6c6%2]) with mapi id 15.20.9160.008; Thu, 25 Sep 2025
 15:40:01 +0000
From: Chris Paterson <Chris.Paterson2@renesas.com>
To: Jan Kiszka <jan.kiszka@siemens.com>,
	"Shivanand.Kunijadar@toshiba-tsip.com"
	<Shivanand.Kunijadar@toshiba-tsip.com>, "cip-dev@lists.cip-project.org"
	<cip-dev@lists.cip-project.org>, "dinesh.kumar@toshiba-tsip.com"
	<dinesh.kumar@toshiba-tsip.com>
Subject: RE: [cip-dev] isar-cip-core: on-device tests failing
Thread-Topic: [cip-dev] isar-cip-core: on-device tests failing
Thread-Index: AQHcLVM98gpddy1h2UqyAEVVjkXXF7SjqdSAgAAYrQCAAAOaAIAAQMiAgAACq3A=
Date: Thu, 25 Sep 2025 15:40:01 +0000
Message-ID: 
 <TYYPR01MB15132A5CE730EF7EC863D3B5EB71FA@TYYPR01MB15132.jpnprd01.prod.outlook.com>
References: <53fe043c-eba5-4d8b-826e-5846efce7d57@siemens.com>
 <TY3PR01MB11075F7F38A4345A60D5FF028C71FA@TY3PR01MB11075.jpnprd01.prod.outlook.com>
 <3643259b-7e4d-4e38-9d53-b0e2227f9931@siemens.com>
 <TY3PR01MB11075A9F4E791BBC04C5EE28DC71FA@TY3PR01MB11075.jpnprd01.prod.outlook.com>
 <c8e57ef0-6f4f-481a-9e36-214f44fffb5f@siemens.com>
In-Reply-To: <c8e57ef0-6f4f-481a-9e36-214f44fffb5f@siemens.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYYPR01MB15132:EE_|TYCPR01MB9909:EE_
x-ms-office365-filtering-correlation-id: 62540faa-b179-4311-8afb-08ddfc49ca59
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info: 
 =?utf-8?B?Rmt2U2VhMk5kT2h5M1FIOG1PL3RMVThxQ1piMGxJVUh1TU5oNHYxZnMyRStx?=
 =?utf-8?B?M1VHSUFIaG9UZ0NTL29jTHZhNEtpNHhrSktIZkNqYThhSC9va0hzUU9xTlRC?=
 =?utf-8?B?NFpGZ2IrVENjZjFEYndPNkYyVHpUYkhXNVN1Z3htWHNsVTlsSHVVUnZZV25l?=
 =?utf-8?B?MTZVK240S0tuQzhwWFd0a1ZRVS9oSlZPaVlVZ3lPdUtjSGxoc1F2YnE4dkNX?=
 =?utf-8?B?dGplUmJLOWYrOVRFbmFYZ29qMTVTcngvR0oyeDhYc21mQWlscFhqaFdPajA3?=
 =?utf-8?B?cTdUdnFpOWVScGhDQVRzbjZRdUtPcjVPc1ZTdTdFeWVnN2RESndoRlhlbnhV?=
 =?utf-8?B?WnVxQjZYb0tERmlDTnVyMXVKMmM1T3U2NjJxT1pTM1Y1aEx4N2ZBZGo3L2lm?=
 =?utf-8?B?dEN3T25TcjhFV1A2UVNkVU51Nmd0S2ZLM2J5RWxkUDRBbklsMUVIOTdDU1VU?=
 =?utf-8?B?VHpielV6ZmdzZU16blAxS2o1ZGtSaU9VcXpPZFIxeDFkczAwa0hnYXRWYUFH?=
 =?utf-8?B?QlR1Zjc5MnhPMlBEYUxsbWlmaFVVMGhpYU94RjNJMldXMTZUVGs3aW5MWFBD?=
 =?utf-8?B?Y296aUJSRUViaVdobUdWV2FYRTlOTHFEVFdFd3c0VEw1bTMxOWlGSnFSTC9S?=
 =?utf-8?B?MkE0Z1ZEenlUUEFLRkxGc0xYa2FSaTNpdnJZSjI0UEdsMVlLeERwNittWEdP?=
 =?utf-8?B?SnBBTldpMXZNb3NpTnhXMHlLVTdVcHJscDRoZmpXOHhkRDNNZWNBa2NaMGFO?=
 =?utf-8?B?bTVBUldRQStMSE9TYmxsYVR3RExTTXdSK1Z5dG0xSGtOOE9jQjZtU3B1a0Rl?=
 =?utf-8?B?cEQxUm1KVnZYb2UvWTdOdXV2T29ZaGxGbXlUZ2FEVzhzZFNRdXVFSUhadFJx?=
 =?utf-8?B?T3luRXdpajhJQ1FXa1hEMDVIUmlYTzdSVDA4RFUvNXA3c2VGa05odFhQdEY1?=
 =?utf-8?B?WUF3NEc3ZThpTldINWRrc3c2V0Z5NGhqR0hwNWRxbkJwUFR5dzIzMUVKTEtn?=
 =?utf-8?B?N3RZTWJaT01JWFhUVnphVm04U0ZCMVdvZS90bExHNTVqZ2xVZDFDR0sxRyto?=
 =?utf-8?B?QW8xRXBmekRYRGMvOCtiSW45clNxVy8zRTdVRTlRei9kcW9ickk0RVpWYW5L?=
 =?utf-8?B?WHkwY3pYZkRIaVY3cHByK0NEV2paV01QQVZsOTFmYXN0TTcxamg3VnJkbVM5?=
 =?utf-8?B?TnJwTnQ5THQwY3FqV3ZiZ2w1bVFZeEFNVlhLaTF0ZGV1WG9ySTVBdHBsYjUy?=
 =?utf-8?B?TDhVcjB3cm8xbDB6VXlwN0JQL1VLTXQ5R2Vsa1U4TlpTMFdEOHZCdWdqNUMr?=
 =?utf-8?B?OVM0UTRyWENxVDdoSTNXSDM0ZVlLTEVtMWc0L0VSUlQ0bnNIMHZvdmhDcUI4?=
 =?utf-8?B?c21tUWQzTUlya1JqV3BmbzB4Wm1McWFleWZXRTBMY2F6RVhFZWNoMGhQQ3No?=
 =?utf-8?B?Z0pwT00vNWhFaDBZcFo2YzhiY0dkaWRBbkE2aGVEZXlNZGtxU291Q3dDVjlm?=
 =?utf-8?B?bGxvZlZPbVJRNGpxQ08vUGs1YVZ3V3U1eGd4NDlHQW1VOHdJVENqYTlnRG95?=
 =?utf-8?B?NXJSUTZUTDlWbWltWU1ka0Nxbi9rREVVQlpiN04xUHZPQ0NwQzFIczEzQS9O?=
 =?utf-8?B?YjQ5ZVRUMUxkajJBZzdSNmdKZnZwQWtYMEpKdHpzbFVSNnowcVFZbndJdkpG?=
 =?utf-8?B?RFRicnpBQm8waEtwMzJuVThqZURwNVd1R1NnUkEzSHZRQzlWcVVSUnd6S1Mw?=
 =?utf-8?B?MmxWRkZkMjJPQU9IWjBRbTFwcEt3OGN0SlZRWWxUN3BNZTRsYVNjMTM2Q1Fy?=
 =?utf-8?B?UDl0Mi9ZZ2gxQVUwZEFoN3JyL2ZVN0pXUmZ0aDc4VERMOUhoRGFsbTQ2SmJJ?=
 =?utf-8?B?TjhBeWV4c0I0M0lCMHU1dFFNb2tQcWtHdDlHNzF6OHJWNDc0ZXN5djl6UjBK?=
 =?utf-8?Q?VGtmD1/WOus=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYYPR01MB15132.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?U0wyWHpJYnNlVk1JYU5jUEJJbXRTTHJsWm1PVmg2SnpoWk4zVk5YV21FNERx?=
 =?utf-8?B?Qm1tUjlseThSczlNZU5QaXVpRm11Z0pTaDJpL1k4NURCTU9wUVd3NXRHam1T?=
 =?utf-8?B?ZURVOGYrWWFVeTZwYjZDN2FsSUVScnFnREUxSG5MOFFSUmZSaitwQmYwZFNG?=
 =?utf-8?B?eHJvUXpNd0pDajY5TWU4dDljMmNEWTdyZmJqMkJUQUxKODlNaFpaSGdLOHo2?=
 =?utf-8?B?YXNWcC9Id3FNMnd6VW9TeXRxbm1JajhHWG43L0V1cTB3MWxtbXF4QktlQ0Jj?=
 =?utf-8?B?aVhvTzhTTVplOFhvV0QrSjlVUmZUNHhqRmRTNzVJSkZVVml0dnNVQVc1b09V?=
 =?utf-8?B?WkRkRjR0M3lCYWg5Q3JaTllxelkzZWQwbVdpTXpST21ScVRVTkZDK1IveTY3?=
 =?utf-8?B?V3BWY1d2RjArcWVBVTR4YTlGL043ZWtISXhTVUY1MGFHYlowUndRVTh6OXRE?=
 =?utf-8?B?SWRNMmNsSlo3L3BLb2RyWUtac1U2UmNGQnNGaFNNS0JlMWpGZG1vQmxUUHU1?=
 =?utf-8?B?a2JoSmUvYkhZUW9kbnZBOWN6WnVwYzlWREdtNG43S3JuOGpob3JLczZJRDdL?=
 =?utf-8?B?WndkZ3BreERGR3pZc0pXTU9DeFNvZmJycE5BaXo0WkNwZGhXSXpxY2YrTlpo?=
 =?utf-8?B?aUVkeTY3YXVjSkczOWE1TVJ5dWJ6UklldEgrMGowVHNxcWYvYzVFcmY2VjVB?=
 =?utf-8?B?WTFyQ25SUXZZSTZ6MXhVaWh2RGxnTThWbVo2WFdPYXdjQ1FHUEJrVSs0RjIv?=
 =?utf-8?B?NnN6OW9NRnRyeVNFRFpwZEluQldWTXFnd3BtTHBDUVpVYXJWUHc3dHNhUkVC?=
 =?utf-8?B?YmRQWjA1cThDbVhFZ1Rodm9FaDRFcCtqT2V1Z2NrZHNsVWVTbjg3Y3l4MU5H?=
 =?utf-8?B?UXdRMWJZbmNpazNNRUpzbDdGa1hPUUpQNkVlL040YnlheVJncjlTNzQ0bVV1?=
 =?utf-8?B?MkU2NE83Vk9Pb1JuVW1aeExnR0RIU2N3YW8zbURjeGRReVZZTlhSZUR3MFVp?=
 =?utf-8?B?TG1wVjZLa2RRWnA5VTZHdm4xZVk4MmZGSTRXcHJDbkYwb1grclltblBkQ3RT?=
 =?utf-8?B?NzNldi9oUEI5aVgxMm1RL1FoRWU2RWhxYjZxNXA4M1pOd215eTB6NXRDcUNq?=
 =?utf-8?B?M1dld0xQZ01EMkRZdHdCZERuSW9VQWQ2aEIxdzhjWVZIaVc4TG4zSmppekNh?=
 =?utf-8?B?RjhLeVEyemdOY3FENXc2N1ZhMG5jdUVKbXNXdXhoUVYyQXBYNWdFTTlJdHVM?=
 =?utf-8?B?Vnhtb05hYy81QlREZEZQR2VsaTVrc2phK3JFNEtGTEZpWkdVSUhwbm5wVE9E?=
 =?utf-8?B?OUhGdWhjOFphREtDNmxlU1VpUE9HYnRpVHVodk1kOGlmemJQemhUR3B1OWI1?=
 =?utf-8?B?ZEYrMVFyVk1LRkJyQ3BqQjUxdE9mVFdDcmwrNloyWC9PVFZ1dU92U3dPVldJ?=
 =?utf-8?B?cVJNQTZJYkZsa3BmVTR6UGk0QlljWko1QmZ3MktPbTZzZjU1WmdFR1hia0Fi?=
 =?utf-8?B?MXlYU3pUQ2FCR3lNVkNDNytJQW9iazV6N3ZRWHExTFd4WTdBT3UxcVNuamxF?=
 =?utf-8?B?T0NSVnhDZ1dBQVo4RG1TM1dpMmVFODd0NmlHdGtBV0xnUXNrQkFhZVkxR2Mw?=
 =?utf-8?B?c1BnYnBLSU5ZcUtOcVFSQUNRdThKMDBzb09JTVNFNENaTDN3MWhiR0p5L3hn?=
 =?utf-8?B?OWowajNFS05NTzMwamkrZTRHblNraEt0UlEyRVdwMSthR1ZFdE5OWTd2Uldt?=
 =?utf-8?B?T0wxckI4ZStncUVUUlFPWFYyNlV2SmZQL0gwZU9hbTVlQWxjSW9HUXR3Rksy?=
 =?utf-8?B?YlRwdGx0bGRRTFZIRmcvMSt2TGJBQS9CZnBXLzBONlpoT3RKK0hZTzc5MmFs?=
 =?utf-8?B?YmxWZUEwdld4aHZkdDJud1k0dTJDSkp0UkVvL2R5b2s5ZVI0cDRsS1BJWXJL?=
 =?utf-8?B?c1o4MGxjb1ZKcno4NUYyZTdwN0g1bHRmOTFWWnZMZDZSOTVxRUN3SlFZdGFU?=
 =?utf-8?B?cjZKTmNHeXpnWHI5Q2xKZGhyT0k2dFRPNVpOSGhBY1pLOTV5NzFJQUkzSTJ5?=
 =?utf-8?B?eCtGRzlZa0JKWjg2c2N2Y0lqTlErVENUaXpPM2ZuWjdpRW5jYy9iYllSNVZO?=
 =?utf-8?B?eitoOWFPT3ZObFg3VXZjd096c3NRUHRiWTNndnRJTTJPQW5PTENNZmFYbG95?=
 =?utf-8?B?Smc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYYPR01MB15132.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62540faa-b179-4311-8afb-08ddfc49ca59
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2025 15:40:01.4090
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bfcxScYTXBvmHNtVFlkKsxjyxY4hk/LfNjKNFeqT8OKB4GJ+gVl1lXUTqY6fbXeCVSJVbmVWbe3bi8agrA9DcqJ4MseK9TXiEPibFa5QYAU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB9909
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 25 Sep 2025 15:40:13 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20143

SGVsbG8sDQoNCj4gRnJvbTogSmFuIEtpc3prYSA8amFuLmtpc3prYUBzaWVtZW5zLmNvbT4NCj4g
U2VudDogMjUgU2VwdGVtYmVyIDIwMjUgMTY6MjcNCj4gDQo+IE9uIDI1LjA5LjI1IDEzOjM0LCBT
aGl2YW5hbmQuS3VuaWphZGFyQHRvc2hpYmEtdHNpcC5jb20gd3JvdGU6DQo+ID4gSGkgSmFuLA0K
PiA+DQo+ID4+IEknbSBhbHJlYWR5IHJ1bm5pbmcgYSB0ZXN0IHdpdGgNCj4gPj4gaHR0cHM6Ly9n
aXRsYWIuY29tL2NpcC1wcm9qZWN0L2NpcC1jb3JlL2lzYXItY2lwLWNvcmUvLQ0KPiAvY29tbWl0
L2U0Y2Y3MTcwMTk4M2UzY2IxMmYxOWVmZTljMjE3ZjUwMGI5YjA4NjgNCj4gPg0KPiA+IEFoLCBv
ay4gVGhhbmtzLiBIb3BlIGl0IHNvbHZlcyB0aGUgY3VycmVudCB0aW1lb3V0IGlzc3VlLg0KPiA+
DQo+IA0KPiBOb3QgYWxsIGlzc3VlcyB5ZXQ6IGh0dHBzOi8vbGF2YS5jaXBsYXRmb3JtLm9yZy9z
Y2hlZHVsZXIvam9iLzEzMTA2NjENCj4gDQo+IFdpbGwgcmV0cnkgb25jZSBtb3JlLCBiaXQgaXQg
ZmVlbHMgbGlrZSBvdXIgdGFyZ2V0IGJlY2FtZSAic2xvd2VyIiwNCj4gY291bGQgdGhpcyBiZSB0
aGUgY2FzZT8NCg0KSXMgdGhlcmUgYW55dGhpbmcgd2UgY2FuIGRvIHRvIHJlZHVjZSB0aGUgZW5j
cnlwdGlvbiByZXF1aXJlbWVudD8NCmUuZy4gbWFrZSAvZGV2L3NkYjcgb3IgL2Rldi9zZGI2IHNt
YWxsZXI/DQoNCk9yIGRvIGl0IG91dHNpZGUgb2YgdGhlIHRlc3Qgam9iIHVzaW5nIGEgZmFzdGVy
IG1hY2hpbmU/DQoNClRoZSBjdXJyZW50IHRpbWVvdXQgb2YgMiBob3VycyBpcyB2ZXJ5IGxhcmdl
IGZvciBhIHNpbmdsZSBqb2IuDQoNCktpbmQgcmVnYXJkcywgQ2hyaXMNCg0KPiANCj4gSmFuDQo+
IA0KPiAtLQ0KPiBTaWVtZW5zIEFHLCBGb3VuZGF0aW9uYWwgVGVjaG5vbG9naWVzDQo+IExpbnV4
IEV4cGVydCBDZW50ZXINCg==

