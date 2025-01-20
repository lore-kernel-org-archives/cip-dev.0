Return-Path: <alexander.heinisch@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62DDEC02181
	for <webhook@archiver.kernel.org>; Mon, 20 Jan 2025 12:51:53 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.61])
 by mx.groups.io with SMTP id smtpd.web10.35851.1737377511083535306
 for <cip-dev@lists.cip-project.org>;
 Mon, 20 Jan 2025 04:51:51 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=FT3Kczdb;
 spf=pass (domain: siemens.com, ip: 40.107.20.61, mailfrom: alexander.heinisch@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CAU49HQ1RFJTr2rIPNbaH8vcpySqugG700FAPGHK/6auentkwLM5okszqo533Mr5jmEna4s6v72MbNmFjQrddysYUbIhO7NcIDGjVttETXFbovT3lxuOxQbjSljP4CXMXgb8j8b2AjnlmU2kY03ESKMYtKNwgzRsEtv0SSf9RAVcloyftcCihdJjAxt+7wQf1Jirvn5j4VfniZChfv7j8ut8Bage4XcOo1y8wulJyTuW6+yTQqvFT/WucfQRlYo45hyhEeHTT7O4u8zADPYN3cysVu9Sv//tfFBiS+7Qy+QQ5RUcUjXF0p3bOZDcLRJg2GBA9oBpn9umeOrwKNu3dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3KO8+omhvAEy8nWNPpCiilkJF9OsfIsFXwDbG6fg0lk=;
 b=rmqqbcdCQ27VgisE0Hv5K0uyYF86qOMWqsPHEP1Q1kEs+UV3Z6lMeSU6rdXd4a/yD7S5qFoYpM10O+JeCbayhbmR5yhO7R5SxkMM+YWDiQl6vewP8GrpN0V0owWUMrmZX+iKV7xzjBg3iWxzusQcItvGc0XbRPHI+l9X5O6CROYbBfvtocZ0mNoaAdT/neZ/+4eWIast91toxlcu2YBT4vnnAkTdVxS3wXEfY+tFCgzVcZ2eIRhcYyTH7pBHksZjtAuB0IZ64hp4g1ATKvSJrSEWfpeoHgYBWk/x20/fZo36gw93lM2s53XA3MhM/930prySUIl7LVKQNE4CD4n3/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3KO8+omhvAEy8nWNPpCiilkJF9OsfIsFXwDbG6fg0lk=;
 b=FT3KczdbjBVIa4DLXTzT0GOSaaEWJjU14l9Oc+SpucqrafxcAU9eeiL71rxZDgnj9PjEqY+N0WMDZq9o49mIpY8DBthmH8St7WAFCsOH+1vTsraJR564/BrhaNT/Efpi4L38SJW//Sb3IEYb1rtJ1Yng/VNSqZtZYLG6KfudrSDUOGoBTv5ldVmF0pOnXyx4OYoc4LkKbyz73Nsk8FyemL6Cjr578eQ8J03E46KcpU9Jkig36+iwhfq0N1L33mCAK8nfXx/fruANclsZnho+7AV2awMgvK41FZ8Hgr4A7nefYCQy+gQAYT4QrTqWCt+ppZw+5J5Rev5nFI0I4tuAcQ==
Received: from AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:10c::13)
 by VI1PR10MB3615.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:139::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.12; Mon, 20 Jan
 2025 12:51:48 +0000
Received: from AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3a6d:95dc:3ce2:6da0]) by AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3a6d:95dc:3ce2:6da0%7]) with mapi id 15.20.8377.009; Mon, 20 Jan 2025
 12:51:47 +0000
From: "Heinisch, Alexander" <alexander.heinisch@siemens.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
CC: "quirin.gylstorff@siemens.com" <quirin.gylstorff@siemens.com>, "Kiszka,
 Jan" <jan.kiszka@siemens.com>
Subject: Re: [isar-cip-core][PATCH] initramfs-crypt-hook: Optimize disk
 encryption in combination with expansion of last partition
Thread-Topic: [isar-cip-core][PATCH] initramfs-crypt-hook: Optimize disk
 encryption in combination with expansion of last partition
Thread-Index: AQHbazezIiI7wjl+fkqPTcspEMyCx7MfnawA
Date: Mon, 20 Jan 2025 12:51:47 +0000
Message-ID: <0c27d834d60e2408da0e016254ad260e5dd534e5.camel@siemens.com>
References: <20250120123425.79292-1-alexander.heinisch@siemens.com>
In-Reply-To: <20250120123425.79292-1-alexander.heinisch@siemens.com>
Accept-Language: de-AT, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu2+intune 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM7PR10MB3320:EE_|VI1PR10MB3615:EE_
x-ms-office365-filtering-correlation-id: aa5a9262-37df-4939-c38f-08dd39513336
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?QXZ0bS94SVVUNEdkaDlkVnlwOUdoYk43TXAzM2VEaDhOWWo4eitLcTJlUFlo?=
 =?utf-8?B?dVJtaHMvWXZLWExkaUF6M0VnK3Y4TXg3Q3RRU1U5VGRJQUtQWUgwcTVneGRq?=
 =?utf-8?B?S3ZremlVSlJSQ1ZxNDJjSVEzZnJ2b3ZvaktGaDlHb1prczJveTRlTUFFcVNO?=
 =?utf-8?B?THFvZ3pmcVN3SlhmU2lCeC9LUTY2Y0pTa1BiaU14eG9TdG9mdmpzYjRxRWtJ?=
 =?utf-8?B?WUs2VEtSTGM3ZkdUcm5HU1N4c2RQWlFOYzVkcVNvcHRYdDhCMFZBeVRjWGZj?=
 =?utf-8?B?NTFhcnFpWTMrRmlaWGRncFJEam5Kd1RqUW5xWm9WOXlxODJVejV0SHRGa25h?=
 =?utf-8?B?U1VlMDQwYjIvZ1BucCt5dVVKendXM3ErYVBFMUV2M05INk96ODBMZ3JmVDRV?=
 =?utf-8?B?bC9nT0UvN04xNmRIaVBNZi9nSm93MFRQMTN5RVlyZ0puMDkvWFdoZHUwTFJt?=
 =?utf-8?B?RjE1OHVBczNlNjRpYWpBWTJQUHBMbDdpY1NWKyttUmp4K0xYWW5jcXJlKzZl?=
 =?utf-8?B?WDNiYWFxUDVqOGRzOThGMzd3VGxsaEErMVFoc0lUUm82VUpZUnVkM2t1T1Fj?=
 =?utf-8?B?cWIxSVplWFJzRVBNa1ZZcnRmOHRaVkVMNzE1ZGw0WHovQU9wS1plSytEU3BW?=
 =?utf-8?B?bkNzczduV2UwUitsTS92TktSYWdZYURpQ3ZZNU85L2NxYUg2NnlaU0FHTE9k?=
 =?utf-8?B?TnpUNmlIbDdXYWU3d29tcmxGdnZsZkc2elI2KzN6cGhIdE40ekVESjJzL1Nx?=
 =?utf-8?B?Zm9LRkVBODdUNHhJU3UxQVlWcDRSaWVBdVExK3g4ZjhUcUdFeHVSay9vcTZ1?=
 =?utf-8?B?QkNPV0ErRWw4QjJxekdxZ1RWWDFjNjNudFZlb3hEd1NKVkdoa3lpTXl1NkNt?=
 =?utf-8?B?ejAybXBnczNCWVVYdlNkbm9iTkJJY0hVZE5HM0JPaDRjZlllM05vd1BSdXNv?=
 =?utf-8?B?WkczTnRjUlJ6OFB0dDU4MkpnWC9kME5HYm5VOFlvRWEyWXdSaHNFTitqU1Uv?=
 =?utf-8?B?ZFkwbE5raytHY0VUNjYwTEJ4aXdaNWdrL0tOOXhnZS9wYWZNVDI3OGtzMnN3?=
 =?utf-8?B?aGROWVJadytuVy9WRmwwRTNhZEl5SDhjY0N1TUpyNHorNEJjREdzRmVXbW1I?=
 =?utf-8?B?UDlFRFpDUkcvU05CTkV0SHBqMkhsYk45eDhvS1g1a0JsQ3dHVnVadEx0NjhQ?=
 =?utf-8?B?dWFKU0kwVmVDekphNTYyRXFXT2I3K1YwWWtJcjRqOVFUS3JCZUxpMUt0T1Rw?=
 =?utf-8?B?SldQVVdYdmlTWHl3eWlsSk1ZYjVnNmFPWUExc0YwakptTEJLUSsyREFSMFNz?=
 =?utf-8?B?VnVITzhTS3VrMkpDMGFNOEMweENKaGsyQzNCMVh2WnVjaXIvN0o3WnRmZlly?=
 =?utf-8?B?RnNvRzViWFYxbG1uUklPbGFpVUlkQkJITFZZZFJJMlBhSEFpNTBKTVdMcncz?=
 =?utf-8?B?dXJ2eUI2UjJBaDlQZWRHNlVsUzVyNjh3VWpuMkVQNEYxb1FhMmttcEVMZ0NY?=
 =?utf-8?B?L2piNm5LbmNWOGxuNFZ3eEFJUW5sZUR5NFlYNko1b0xXYm95a0lqdE9zYnVu?=
 =?utf-8?B?S1ZGMVd1ZDhvQzByUk8xRXFweG9tVE4xZG81V2d5QnVwWTExNFJUWnhkMTNE?=
 =?utf-8?B?ekVyZlVPalJ0TGZ5MVJOOHRLbnJQQUduUVlHR3NqNDlqWnQ5TjdKRytKL3Br?=
 =?utf-8?B?dFA4WTNHcTlrYlhrY2NlcGg1N2Z3NUQxS3NDbTl2aFRkS0t2cFFRZ3pWM2ZY?=
 =?utf-8?B?T2lOOExCR2V5c04zcTc3WFRCQ0s3ZXE2ZjMwRjJEd2ZXS0pxWUdFTHlZUmJU?=
 =?utf-8?B?RTJWY2RpckpTVENBTzFVQ05zY3krOE0yUVFaUVhmd0s5SWRUYldYQkhmSjhV?=
 =?utf-8?B?a2pGSlRmcGhQbDdteGN3ZVZBd0liVTY4UWZxd3F5aGZjK20wOEp2SFQ5UFB1?=
 =?utf-8?Q?k67AGjyxVA/YfJC1JXZaUVwdwM7btNtn?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?ZFljVGc1L0F1NUxid0xEOFYwaUtMLzQ4aTRZVFkxOEs5WFIzMEJKNldoTGZD?=
 =?utf-8?B?TVRwUkJJbkZ4TXhhSGJ4WTduK3N5anN5OTFsNFNYOHBBcGNZSWhtYmg1MlU4?=
 =?utf-8?B?UW15Zm93eW5vV1FqYWZGYzlpR3MzZlBxTjIycVhnMDZBME9RZEhPS1U0Z0xZ?=
 =?utf-8?B?K3ZSbjRPSHNzSGZYVDF2SWEzY2k2eWkrNXZPdHN4R29tOWNYWHQ5VWg1eVYz?=
 =?utf-8?B?M0VrRnM0Tk9XdG1jTUlsb0luSUl5NkRJZ2tyU2Q1NjJqTC9XSjNkUXU3TDhm?=
 =?utf-8?B?NmNZOExrYkN0QkhreHZKU1NYQVFsZU51T3REY2d4Ym8wTS9FVVFFeG5YRUpm?=
 =?utf-8?B?UVk3eXR6ZVJCRVFLRUNac1U0azR1cCtaQkJ1ZEJQQ1phVndZSm1LVk10ZU00?=
 =?utf-8?B?SFRWVk9mOGZsZXJXNTJhU0gzTS9xaXJLK0xxdlhoV1dIWEtiRHlkSGt4ejFX?=
 =?utf-8?B?SmZJM2E5Q2VJVU9JZlN3b2xhWnlILzU0dWkxT25vVHFadTVyRHRxTDJBT2RX?=
 =?utf-8?B?UFl4NFI0U1FZbW0wOFFCK2FOUTMvNzd1ZWk2aVNmWnd5UlNhaGpkK3JINm1T?=
 =?utf-8?B?eURrSFRIR1p3OWk1UnF0cldyZDV0cjFmYkFBd1RNRzlEaElGQUdrZ2xrT25r?=
 =?utf-8?B?ZkNQQ2wyWkx2ZFJuQnhwZzdYdGFjOHllcGI4d0MySnFaTkRKeE9wREt3RkZy?=
 =?utf-8?B?OFFPQkpJd0lVbmUxbzJ6YzVrUzdaaE9EODNjQXExVWs5NXVKSmlkdDVwNnV0?=
 =?utf-8?B?QUViVnFQNzUrK3JyTUVKVWpUcFJ0WTdVdmphMXFzK214ZDBxLzdpSEt3eDc2?=
 =?utf-8?B?TTU2b21zZFN4SiswTzdZVVRLTXIyV09CR2RUSTFZL0tFUG1iY2U2cHJTcHZ4?=
 =?utf-8?B?YW1RV1BxUDZIVXpjb005TlZiNlJKa25HUXpOS0pzMWo0SzVuZWdod0RFcGMy?=
 =?utf-8?B?MHJrNTMvKzhZaitKanpjenVSek56cXE2RmQyelZPamlZL29UV2NWNldoZnha?=
 =?utf-8?B?cXhBVWIyS0dkcUltR1VDZzl0bnhmc3ZRNFRSNGZxRFp5NEpNZnlFaW1XNkJq?=
 =?utf-8?B?MGllU2N1d3hpODkzNVUxY2lQNnI1TjFCLzdSclVveUlWM2k1VjMxSzlsMlpS?=
 =?utf-8?B?ZUJlcjZ0VnhtNVlnaklKaXVjcytuSWE1YW9PMnpVamZWdzRBVWdranQrR1Y5?=
 =?utf-8?B?c2R0KzNYMllNZWNNQmgwS29zNmxMVnhlOHI0R2JOMXpTQ2RyOWxwQlp5TE95?=
 =?utf-8?B?RkdBTzhCbG9CallScTM1cWtoclU0ZEZxNjB2eC9HT2RTeTlkK1AzcytnUm02?=
 =?utf-8?B?NG91eUFpRmJxcSt5c3FLalhVTkpQQTk0L1lSUjlqb25vcVlzZndhNHF1Uzc4?=
 =?utf-8?B?MGVQaWh1TEFCRlBGTXAwMzRweVVQblVkS3RpZk5qU1JyYXFocmRoRFRkM2VH?=
 =?utf-8?B?ZG55VHAweVBVZ0dxTmFZamFlVDFlb1U0YmtVOVV3MFRFRUcrZk95UFl5WVp0?=
 =?utf-8?B?aXFTOE1PZVJYWS9yREQ2NG1Wd1drekpuMzZwWVBobkhzeWhxaHF5ODMvSURl?=
 =?utf-8?B?WVZpRTVHeGRYajBvRzlESVVmMnQ0SEZSVjhGREkvZU5ES3Jqc3EzaDkzVnZW?=
 =?utf-8?B?UG1qdi9Eejl1MW1JRzE3ZEQ1aFVkSHVhRTdJcFdwRkxKUmQ1MS9NcHRzdUpW?=
 =?utf-8?B?KzNLT2VwYjdyQzV0c3grNktZUzNVSW1tditqYmd0SmQ5NDRRR3JhV0dmcE1O?=
 =?utf-8?B?cjI2VisvenhabEtVZmtnL1FpNnFXQm9KdTAvdHc1RFhHRVFJWkVlWWQzUW1L?=
 =?utf-8?B?VWJHM2QyWHhOcHo2NkFqa29UazV4RS8vMytydGgwcWY0Uzl0U0I1T3B3eng4?=
 =?utf-8?B?YVozV05zbnc2ZXd1Y1dNejZCS2xaZm1WSWFJNnIydkJ4bUU2cVhZai9PaGpq?=
 =?utf-8?B?aWQyM0J0SkRKS1FEOWFicTM2UzJKTm9tWlFmb242ODlveTh6emUvcjJZVUhC?=
 =?utf-8?B?QVBxL2Q3QmdsdDBhNmtQeTd2SkVrMUxFSS9Nck1QemhaMFVVdGRwMXlxZVJn?=
 =?utf-8?B?aSswSzBzbTZSUjhCRGllaUV5Y1FtNEFCRlk2REs2T3RxYS9rZG14MHZsSEpR?=
 =?utf-8?B?d3BVYlVnZktPQ0lZUGNGZm9keStBak0xcTc5N3BLQ2YzdldWSUY3cmRVS0Rm?=
 =?utf-8?Q?4RuN6apayktHYY6iI4N3qF8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F2701E3D8FA59449B7FA3D7397202573@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: aa5a9262-37df-4939-c38f-08dd39513336
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2025 12:51:47.0626
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SnXgQwTkuwCYwFCV5dIIsNBCKamxscf/CVqKmsFfSAExbnys1VVrqBqaTU8o6rVtGQR/Rq3YsoSmByDeoICp4FenDltPq/5ZftFkEgm+5rI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3615
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 20 Jan 2025 12:51:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17550

T24gTW9uLCAyMDI1LTAxLTIwIGF0IDEzOjM0ICswMTAwLCBhbGV4YW5kZXIuaGVpbmlzY2hAc2ll
bWVucy5jb20Kd3JvdGU6Cj4gRnJvbTogQWxleGFuZGVyIEhlaW5pc2NoIDxhbGV4YW5kZXIuaGVp
bmlzY2hAc2llbWVucy5jb20+Cj4gCj4gSW4gdGhlIGN1cnJlbnQgaW1wbGVtZW50YXRpb24gKHNp
bmNlOiAyODQxNzVjMykgZGlzayBleHBhbnNpb24gbG9naWMKPiBpcyBkb25lIGJlZm9yZSB0aGUg
YWN0dWFsIGRpc2sgZW5jcnlwdGlvbi4KPiAKPiBUaGlzIHJlc3VsdHMgaW4gcmVlbmNyeXB0aW5n
IHRoZSBmdWxsIGV4cGFuZGVkIHNpemUgb2YgdGhlIGRpc2ssCj4gaW5zdGVhZAo+IG9mIG9ubHkg
cmVlbmNyeXB0aW5nIHRoZSBzZWN0aW9ucyBjb250YWluaW5nIHRoZSBhY3R1YWwgZGF0YS4gVGhp
cwo+IHJlc3VsdHMKPiBpbiBhIGRyYXN0aWMgaW5jcmVhc2Ugb2YgdGltZSAoYXBwcm94IDIweCBv
biBvdXIgc3lzdGVtcyApIG5lZWRlZCBmb3IKPiByZWVuY3J5cHRpb24hCj4gCj4gU2luY2UgcmVs
ZXZhbnQgZGlzayBjb250ZW50cyBhcmUgb25seSBhdmFpbGFibGUgaW4gdGhlIHNlY3Rpb25zIG9m
Cj4gdGhlIGRpc2sKPiBhdmFpbGFibGUgYmVmb3JlIHRoZSBleHBhbnNpb24sIGl0IGlzIHN1ZmZp
Y2llbnQgdG8gcmVlbmNyeXB0IHRoZW0KPiBvbmx5Lgo+IAo+IFRoaXMgcGF0Y2ggY2hhbmdlcyBv
cmRlciBvZiBlbmNyeXB0aW9uIGFuZCBkaXNrIGV4cGFuc2lvbiByZXN1bHRpbmcKPiBpbgo+IGZh
c3RlciBlbmNyeXB0aW9uIChzaW5jZSBvbmx5IHRoZSBuZWNlc3NhcnkgcGFydHMgYXJlIGVuY3J5
cHRlZCkuCj4gVGhlIHJlc2l6ZSBvcGVyYXRpb24gZG9lcyBub3QgcmVlbmNyeXB0IHRoZSBhZGRl
ZCBkaXNrIHBhcnRzIGJ1dCBqdXN0Cj4gZXh0ZW5kcyB0aGUgTFVLUyBjb250YWluZXIgKGNyeXB0
c2V0dXAgcmVzaXplKSB0byByZWZsZWN0IHRoZSBtYXhpbXVtCj4gYXZhaWxhYmxlIGRpc2sgc3Bh
Y2UuCgpUaGUgdGhpbmcgSSBhbSBub3Qgc3VyZSBhYm91dCB0aGlzIHBhdGNoIGlzLCBpZiBleGVj
dXRpbmcgdGhlIGRpc2sKZXhwYW5zaW9uIGhlcmUgaXMgcmVhbGx5IHRoZSB3YXkgdG8gZ28sIG9y
IGlmIHdlIHNoYWxsIGp1c3QgcmV1c2UgdGhlCmV4cGFuZC1vbi1maXJzdC1ib290IGZyb20gaXNh
ciAoaW5jbC4gZml4ZXMgcHJvcG9zZWQgZWFybGllciAtIFsxXSk/CgoKWzFdOmh0dHBzOi8vZ2l0
aHViLmNvbS9pbGJlcnMvaXNhci9jb21taXQvOGIzMGE0Zjg2Y2IzZWEzMzY5YmZmMzg4NDE0MTg3
MmMzYTdkOTk3OQoKQlIgQWxleGFuZGVyCgo+IAo+IFNpZ25lZC1vZmYtYnk6IEFsZXhhbmRlciBI
ZWluaXNjaCA8YWxleGFuZGVyLmhlaW5pc2NoQHNpZW1lbnMuY29tPgo+IC0tLQo+IMKgLi4uL2Zp
bGVzL2xvY2FsLXRvcC1jb21wbGV0ZcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
fCAzNwo+ICsrKysrKysrKysrKysrKysrLS0KPiDCoDEgZmlsZSBjaGFuZ2VkLCAzMyBpbnNlcnRp
b25zKCspLCA0IGRlbGV0aW9ucygtKQo+IAo+IGRpZmYgLS1naXQgYS9yZWNpcGVzLWluaXRyYW1m
cy9pbml0cmFtZnMtY3J5cHQtaG9vay9maWxlcy9sb2NhbC10b3AtCj4gY29tcGxldGUgYi9yZWNp
cGVzLWluaXRyYW1mcy9pbml0cmFtZnMtY3J5cHQtaG9vay9maWxlcy9sb2NhbC10b3AtCj4gY29t
cGxldGUKPiBpbmRleCA4YWRjNGU1Li5jNDEzNWMzIDEwMDY0NAo+IC0tLSBhL3JlY2lwZXMtaW5p
dHJhbWZzL2luaXRyYW1mcy1jcnlwdC1ob29rL2ZpbGVzL2xvY2FsLXRvcC1jb21wbGV0ZQo+ICsr
KyBiL3JlY2lwZXMtaW5pdHJhbWZzL2luaXRyYW1mcy1jcnlwdC1ob29rL2ZpbGVzL2xvY2FsLXRv
cC1jb21wbGV0ZQo+IEBAIC0xNTMsNiArMTUzLDM1IEBAIGV4cGFuZF9wYXJ0aXRpb24oKSB7Cj4g
wqDCoMKgwqDCoMKgwqDCoCMgSW5mb3JtIHRoZSBrZXJuZWwgYWJvdXQgdGhlIHBhcnRpdGlvbmlu
ZyBjaGFuZ2UKPiDCoMKgwqDCoMKgwqDCoMKgcGFydHggLXUgIiR7bGFzdF9wYXJ0fSIKPiDCoAo+
ICvCoMKgwqDCoMKgwqDCoGxhc3RfcGFydF9kZXZpY2VfbmFtZT0ke2xhc3RfcGFydCNcL2Rldi99
Cj4gKwo+ICvCoMKgwqDCoMKgwqDCoG1vdW50X3BvaW50PSQobWt0ZW1wIC1kIC1wICIiICIkKGJh
c2VuYW1lICIkMCIpLlhYWFhYWFhYWFgiKQo+ICsKPiArwqDCoMKgwqDCoMKgwqBtYXBwaW5nX25h
bWU9JChjYXQKPiAvc3lzL2NsYXNzL2Jsb2NrLyIkbGFzdF9wYXJ0X2RldmljZV9uYW1lIi9ob2xk
ZXJzLyovZG0vbmFtZSkKPiArwqDCoMKgwqDCoMKgwqBjcnlwdHNldHVwIHJlc2l6ZSAiJG1hcHBp
bmdfbmFtZSIKPiArwqDCoMKgwqDCoMKgwqBtb3VudCAvZGV2L21hcHBlci8iJG1hcHBpbmdfbmFt
ZSIgIiR7bW91bnRfcG9pbnR9Igo+ICvCoMKgwqDCoMKgwqDCoGZzX3R5cGU9JChmaW5kbW50IC1m
bm8gRlNUWVBFICIke21vdW50X3BvaW50fSIgKQo+ICvCoMKgwqDCoMKgwqDCoGxhc3RfcGFydD0v
ZGV2L21hcHBlci8iJG1hcHBpbmdfbmFtZSIKPiArCj4gK8KgwqDCoMKgwqDCoMKgY2FzZSAke2Zz
X3R5cGV9IGluCj4gK8KgwqDCoMKgwqDCoMKgZXh0KikKPiArCj4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCMgRG8gbm90IGZhaWwgcmVzaXplMmZzIGlmIG5vIG10YWIgZW50cnkgaXMg
Zm91bmQsCj4gZS5nLiwKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIyB3aGVuIHVz
aW5nIHN5c3RlbWQgbW91bnQgdW5pdHMuCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oGV4cG9ydCBFWFQyRlNfTk9fTVRBQl9PSz0xCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoHJlc2l6ZTJmcyAiJHtsYXN0X3BhcnR9Igo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqA7Owo+ICvCoMKgwqDCoMKgwqDCoGJ0cmZzKQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqBidHJmcyBmaWxlc3lzdGVtIHJlc2l6ZSBtYXggIiR7bW91bnRfcG9pbnR9Igo+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqA7Owo+ICvCoMKgwqDCoMKgwqDCoCopCj4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGxvZ193YXJuaW5nX21zZyAiVW5yZWNvZ25pemVk
IGZpbGVzeXN0ZW0gdHlwZQo+ICR7ZnNfdHlwZX0gLSBubyByZXNpemUgcGVyZm9ybWVkIgo+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqA7Owo+ICvCoMKgwqDCoMKgwqDCoGVzYWMKPiAr
Cj4gK8KgwqDCoMKgwqDCoMKgdW1vdW50ICIke21vdW50X3BvaW50fSIKPiArwqDCoMKgwqDCoMKg
wqBybWRpciAiJHttb3VudF9wb2ludH0iCj4gKwo+IMKgwqDCoMKgwqDCoMKgwqBsb2dfZW5kX21z
Zwo+IMKgfQo+IMKgCj4gQEAgLTIxNSwxMCArMjQ0LDYgQEAgZm9yIHBhcnRpdGlvbl9zZXQgaW4g
JHBhcnRpdGlvbl9zZXRzOyBkbwo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZWNo
byAiUk9PVD0kZGVjcnlwdGVkX3BhcnQiID4vY29uZi9wYXJhbS5jb25mCj4gwqDCoMKgwqDCoMKg
wqDCoGZpCj4gwqAKPiAtwqDCoMKgwqDCoMKgwqBpZiBbICIkcGFydGl0aW9uX2V4cGFuZCIgPSAi
ZXhwYW5kIiBdOyB0aGVuCj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGV4cGFuZF9w
YXJ0aXRpb24gJHBhcnRfZGV2aWNlCj4gLcKgwqDCoMKgwqDCoMKgZmkKPiAtCj4gwqDCoMKgwqDC
oMKgwqDCoGlmIC91c3Ivc2Jpbi9jcnlwdHNldHVwIGx1a3NEdW1wIC0tYmF0Y2gtbW9kZSAiJHBh
cnRfZGV2aWNlIgo+IFwKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqB8IGdyZXAgLXEgImx1a3MyIjsgdGhlbgo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgb3Blbl90cG0yX3BhcnRpdGlvbiAiJHBhcnRfZGV2aWNlIgo+ICIkY3J5cHRfbW91
bnRfbmFtZSIgIiR0cG1fZGV2aWNlIgo+IEBAIC0yNTksNiArMjg0LDEwIEBAIGZvciBwYXJ0aXRp
b25fc2V0IGluICRwYXJ0aXRpb25fc2V0czsgZG8KPiDCoMKgwqDCoMKgwqDCoMKgZXNhYwo+IMKg
Cj4gwqDCoMKgwqDCoMKgwqDCoGZpbmFsaXplX3RwbTJfZW5jcnlwdGlvbiAiJHBhcnRfZGV2aWNl
Igo+ICsKPiArwqDCoMKgwqDCoMKgwqBpZiBbICIkcGFydGl0aW9uX2V4cGFuZCIgPSAiZXhwYW5k
IiBdOyB0aGVuCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGV4cGFuZF9wYXJ0aXRp
b24gJHBhcnRfZGV2aWNlCj4gK8KgwqDCoMKgwqDCoMKgZmkKPiDCoGRvbmUKPiDCoAo+IMKgaWYg
WyAtbiAiJHdhdGNoZG9nX3BpZCIgXTsgdGhlbgoK

