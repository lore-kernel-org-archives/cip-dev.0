Return-Path: <alexander.heinisch@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC082C021A4
	for <webhook@archiver.kernel.org>; Mon, 24 Feb 2025 13:05:46 +0000 (UTC)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (EUR02-DB5-obe.outbound.protection.outlook.com [40.107.249.78])
 by mx.groups.io with SMTP id smtpd.web11.88763.1740402343174825105
 for <cip-dev@lists.cip-project.org>;
 Mon, 24 Feb 2025 05:05:43 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=Ta+xMirU;
 spf=pass (domain: siemens.com, ip: 40.107.249.78, mailfrom: alexander.heinisch@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qJOTfUmMAxEye8PgE0oKFkOIWvYklWsrzAw7ZYiPeHFbL7WvWHfjR9SM/9WwmLz1J+k2xWXJaDRkvHnOInigORUCXwJgQXCKIGrEA645oXk+naX0ZVDAheDUp6Qflm2bqceKeTPeNWuFJEfw5jea8P5ZVEu9+JPHYFlayfjBXjOxAmQlLDxsoLCZhj63QMYCnJ3saSepE+/6vnhEwi46ci6WRNPfUttZk/4C7/jja9lxBl9UbosS3H588t5T9srR2JSHAdtfYwbTahjs5jb/zP6UlXpgVvSo3zkJufAq4sUtYPqV4yJ2Puf45tz1HnjV3S2pnsX4RnEVI6MvdEy6ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JCI8bOChm+raSoBUMzARjxyiHH+zY6jskJk6bTHvY0A=;
 b=vslWMzdp+Wl17zkckOx8O7RsDgmtObL1i8B3VTvYXfTiC2KEHPdH1bn0SI60CFtkOF7xRLZIa0WI+zEl+DR/3jE67Y/nXUnziE5wmPgGGnRXno3w6CjGNjYurIqrenpLKPQjZBiJeGHLockl3xCN1pNjDXZxtiQSkQciGkeXYNLSqyCCjTdvbJIQ1i8NofE0oUYV28Yt3KKgCr+vbB60LjVJgS9gxjLEEtt1ixx124K1jnQflrF4bm9XiYk72NKWXwtRjjx4SuExVzOzMMqe5+8T4nOcYvYyLW95GXH8bCo1OBtQzwb2YZGWvlEC9Oel/19jc0ZsiegLHEDJNhuswg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JCI8bOChm+raSoBUMzARjxyiHH+zY6jskJk6bTHvY0A=;
 b=Ta+xMirUNsY3kXkJ9eXxvKWmq5k55iXJcr1VDPK/Ib2zp+GIMcrZwb74KXDs2zRngpv9nfIXto0kFuoeeCnhFDF4TZEIMNxOaWMBEYVCi7nfcVKOSXrYMUWj90dR7WPoTHM+AuVExj9ugN9JWOyVp/M6zy9PDgp0DrJ2Iw3p+uEgsdlMVN5yQrtejB/6cyOCyuQ6XvoshzSqeIhyxdm4XGxjbnMjf4MVYDZZCKE0LMDIFbz/6BgrlZd11nCGWi8BZBPHUbI6BLtPFJsAwufciSASMtasyjqj1PA38BXBLNzns2SLM+bhMknHJQZDlTpMpqjGMgk5KML+7+kgUCTwrg==
Received: from AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:10c::13)
 by VI1PR10MB7782.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:1be::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Mon, 24 Feb
 2025 13:05:39 +0000
Received: from AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3a6d:95dc:3ce2:6da0]) by AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3a6d:95dc:3ce2:6da0%4]) with mapi id 15.20.8466.016; Mon, 24 Feb 2025
 13:05:38 +0000
From: "Heinisch, Alexander" <alexander.heinisch@siemens.com>
To: "Kiszka, Jan" <jan.kiszka@siemens.com>, "quirin.gylstorff@siemens.com"
	<quirin.gylstorff@siemens.com>, "cip-dev@lists.cip-project.org"
	<cip-dev@lists.cip-project.org>
Subject: RE: [isar-cip-core][PATCH 3/3] Added support for rootfs-overlay.
Thread-Topic: [isar-cip-core][PATCH 3/3] Added support for rootfs-overlay.
Thread-Index: 
 AQHbgSMESHIqBRSQG0SRnFi2OXsmKrNMvtsAgANtKxCABkE2AIAABX/QgAABSQCAAAM7sA==
Date: Mon, 24 Feb 2025 13:05:38 +0000
Message-ID: 
 <AM7PR10MB3320B985BADE550E321C57CB86C02@AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM>
References: <20250217100024.42995-1-alexander.heinisch@siemens.com>
 <20250217100024.42995-4-alexander.heinisch@siemens.com>
 <715da9f1-ec6d-4a90-9d32-674d7fea0d86@siemens.com>
 <AM7PR10MB33207EA44EE03D94AF84B79A86C42@AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM>
 <c4af6328-d4b6-4bfa-ba32-0d66b2abb1e6@siemens.com>
 <AM7PR10MB332040EB4740B51F543A8D3586C02@AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM>
 <3455372e-70c8-4524-9d99-116d991c5221@siemens.com>
In-Reply-To: <3455372e-70c8-4524-9d99-116d991c5221@siemens.com>
Accept-Language: de-AT, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ActionId=2fb53f8a-7c5b-4f6b-bc51-d6358c9a9643;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=0;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=true;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Standard;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Name=restricted;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2025-02-24T13:05:21Z;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM7PR10MB3320:EE_|VI1PR10MB7782:EE_
x-ms-office365-filtering-correlation-id: 6fcee93e-fa38-451a-8387-08dd54d3ef7d
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?eTErWW9ZMFNCREc5M1FwQ1laKy8xQ24yVUlCTXpBZys4dzRTNWdQOUFlS05T?=
 =?utf-8?B?QmhpVGpJT3lPZkVQaUxnQzFqbmdjVGFuY0ZVM0ZQZ3hhQU44VnBRcllsQ0Vv?=
 =?utf-8?B?bVdEYkZzUkNmbjM3QS8wNUdaL0ZlbHIyRDhNckFuS1NnM0ltckFUM2J3YXJV?=
 =?utf-8?B?S2dyK21rcU54bE5EczB4R3k5TlE1anJpQ1BGZHFhZGUwME5tczVjWFdKWG9a?=
 =?utf-8?B?MHJ4UmV6R0diZFY0WmRJQlg1TFgwVHdtekYvT2JtMmNaN2I0SFVRV1RYTE1j?=
 =?utf-8?B?Z3RjT3hXbjVDQ0lpQkx0ZFEvT0NHejY5ZmRac3lLMEZONXdDT1N5OGJINERG?=
 =?utf-8?B?Yk1tYmo5dkNoYkduL2tNVllsdWtraXEvUW9oTHFGYzlCWEpMWFJsNllnbHVL?=
 =?utf-8?B?SUJ2ZHV0Ty9UdXMwM0RoV1Z1V1dKR1E3MkhmV0ZzclNrelMyWncwaFVlN2tU?=
 =?utf-8?B?Y2hua2VvTFdScXBPQkpIbnJxZmRab0N5ejNzbFpya3NxRzlYU3h5Y0k2dlBp?=
 =?utf-8?B?aTVxOTdjS2ZmMHlYUzV6QnJOZUp1c01IOWQvcXFhd0pWRnFMRnpLbTBPUVNw?=
 =?utf-8?B?dHp2SVVkUnVlMG5JSDFzVURJWmNodm51aTBXVlV4ZlFLQTZDUW9xRG5QYjYw?=
 =?utf-8?B?dlE2bG9vdFFuSGowakhGZW4wN2krNVpIVFhjZm03WCs2RVFrZ24yUi8yMzVV?=
 =?utf-8?B?VnFla3ZJZ1VxWHRsVUF6WkZheXVzOWx3K2dyU3dtQTUxRDVOSHZqOUliOUFH?=
 =?utf-8?B?bE5yYjhHMTNMTTBLT0xzcmIrQytGZVdDTTY2L1pBTXRSNkdVWldOdVF2ZlVm?=
 =?utf-8?B?UGRVTzVKMm5JcU5La1JjVkVQM0FKZzQrMC9WL0VZb24xL1hid01kcHVnZzNm?=
 =?utf-8?B?aWQ1N2JvOVhpNll0Q28xVldMMjlOVGkwMDNSZk9qSXpYSHM1dkJXNmhtWGhX?=
 =?utf-8?B?NVptUEFibERrdjZDMHQwZlgweDBpQTkrK1lDTXplVktWTk5sNzVmL0hFTGdM?=
 =?utf-8?B?Y3A5a3MwQ2ZtSTZ3RyswS1FWcUlMaFhhV01zdlVQMEFqZXNTNi85SWFPakhZ?=
 =?utf-8?B?WWg0cU9oZXNTdlRWQjAyblFpNFZ6Tmwvc1ZmYW5nNkRma2I1a01kMWdSWERK?=
 =?utf-8?B?b0VJZTc5SjhSaHRpSkp0d0doSzlYQ3NTNjFTMDgyZXVVNU4rc01lRE1TVGNY?=
 =?utf-8?B?QmVTeFhhbFRIcEFZMVFGQVd4bmFVZlRQb245YThWTTJQTHZuK0ZZNlc5MThS?=
 =?utf-8?B?WHlQT1QzRU95TnFrSmNTdnVKLytsak1QZnlXUzZFTzlFdC93V2FvQUZSSXlp?=
 =?utf-8?B?Skx0VUVlR09TNEhnQ3ZZU2hLRE5GU0tHUklXc0NCZXphVnpDdk9WSjVSMkZY?=
 =?utf-8?B?RE1STFUrdU05ZXZTTU9zT2dYcFc4TzFUR0JUQThKZUtpSGs1a0hiNnBKeTB2?=
 =?utf-8?B?TTA4YkJidExzTk1JQzBBeHB1bHh1bWF5blJQVmxMUThSNHRNRVY3eHFEbFRn?=
 =?utf-8?B?M05VeFJQdlN0eHc3SUJyZ3BGamJsT0U1cllDVnRlS1dxNzZIaU1OVWlUQnUz?=
 =?utf-8?B?b083Z0l2dk5EMEZ1YkJUMktJM3NzTlAxTnA2azlqZmNMVlREZmtwSndhbUht?=
 =?utf-8?B?UVhJSCtoSVdhNFUzZWJGM0N5Z2FmcXVMUGN1c2ZjeXFQb2c1T3kvaHZZdVV4?=
 =?utf-8?B?Ukphb0VveWhPVGpueEFNR3NoTzJURnhveVhDdWNzdEptU3JiTlRESmtSTGRJ?=
 =?utf-8?B?cURudG1jSGF1QVFydXZkS1lqcWUrd0R3Wmx2VFlQdnYwYitXelNxVHFPUkgv?=
 =?utf-8?B?RlhPUisyYzBKWDQ3dHNJaWVFWU1KdVFmQmF0SnJCR2xMeG9LQU1pemUrVGJm?=
 =?utf-8?B?UGN6Um5xcVJvdDgrYWxvWUdPSm9jVXJSN0h6L0N0QmQ2TEVGeitsSGdIYitP?=
 =?utf-8?Q?aHaf6NjhrUr1dJEsUC4ugf0j1EU4gZ2k?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?NzBSRUZYbHVWRlh6MnhCdnBqY0s5VGYyRUoxU1JOemlRQjJVQVhTQ1hTMkt2?=
 =?utf-8?B?RmlLS1Z3clJPc3R2S0VUSllYOHArZFoxWGVHWHJnVkpKSElKQm9VVFJ5TXZ4?=
 =?utf-8?B?WldweHIyaDlOMk8rWjZSUUJweXBieTFVa3p1ZnpyUHdISU9hc1pLUGNuajAy?=
 =?utf-8?B?WExvcGtLcVVDMG54SHNjQitVQklTLytPYm85VzkwNTltOWczLzdqck9nVU5E?=
 =?utf-8?B?dmVRQm9Qd0dGK09oVUJFNGVMWXRXdHlsTGRRK1B5ajlXNk1QUElnUTlFNXVD?=
 =?utf-8?B?ZER2NFFmRnUxMGoyMjhzRWQ2dWtUVnFzcUh6L1dwb3JxaUs0WnhjN21jYzd3?=
 =?utf-8?B?UUQ4T0pVYzJKa216Um1aSTNkQkUxMW5qcERpeE5mdWVxN1BrUXM3alpNSldE?=
 =?utf-8?B?S3RKVXA2QmF6dUZHWkZHSWpzT0dRVlN4eEpHUE1EQzYwUDVTUVBrQlRxRDFC?=
 =?utf-8?B?WTZHcTB6djE4U1p6dmovRTQ5V3drRmJtaElHRjBZb3ZNcXNyQUtTeXFDQW9U?=
 =?utf-8?B?V1hFUEdjbUpEd0VGcmVGaFhkeXZTMkxmTUlGZlkxWXZQK3RkMXdFRjQzcURx?=
 =?utf-8?B?ME1NenRPcW5QYUwwYnp2UzVpUm9Db2Q1V3dxNVlZQW5FNHhnei9GNStjNmg2?=
 =?utf-8?B?QUNHNEtJNkFaZmNNKzdvbktXMmZ4OUQrT3U1aGN6QXcxN3k0M2tJN2JaMDYw?=
 =?utf-8?B?RllaaU9kTHRxaFBNM1ZQTjl6Rnl5VjhTWWhvemcvcmMvKyt5NmZYU0VvSkJY?=
 =?utf-8?B?V3Via1I0MlJncTlKKzZjYjVtTmtjM25TWG5odUFPR3gzbTBDOUhMWFB6QjFM?=
 =?utf-8?B?bXhoUVo1dGVTTm13L2ZVQjN6SVpzbGc3aWRpTUtzQzZrNHpRQkdYZFZnMGp3?=
 =?utf-8?B?Q3dUMFMwUEdhZzBROGdRd3ptYUxHWTRnTmtKcXg1Zk1QbE40UW00dzV4VGFE?=
 =?utf-8?B?R1dJV3FNanh4WnJtaFI3bk1iZHZBeXN2OHRZZ09UL3F5TTRTN0ZYMytRTFpm?=
 =?utf-8?B?Rkg5T01iYkRWVTFNR1kxTm1mdmhGcTBob2d4RXp3Q2dSWCt2WVVuQUxLdDBq?=
 =?utf-8?B?M3dKM0k0SFpRVXFqZVRzRDY3aVNHZlk4bFh0RVRscUExTmhrYXJxY3J5NTlO?=
 =?utf-8?B?dHdZZEVidlE3Ky9tN1lkUU0yQjI5TG9wQThUajZEbHJkYStnQ0JEeE9mbnhv?=
 =?utf-8?B?QldaUlI1Ky9DNUNwOVdBMWFsM3I0c3lVWjFRZXpJYlcxVC9taEhFRHNHWERY?=
 =?utf-8?B?MklVTGE1UVl6VngweFVscDRUT1loVnVVQjNES0IzQ0F3QmxvWjF1bEV5OWpF?=
 =?utf-8?B?WEhoTUx5SnUxMnVNVzdEQlQwSFpzcGRCMU9ZbTdhWDh2SWxLOWUwU0E0dHpj?=
 =?utf-8?B?Qnl5NVVzdk8xZXVjV0FwQ1I3Tjc5ZnllTFdKaUk3cHVWRHZIa2N1ZWdVMStx?=
 =?utf-8?B?ckU2RUhnUjdsTlFsejhKb1B4bm5oTHFhb3VoMHk1c1RuNWFaV1EvWVM0MUFZ?=
 =?utf-8?B?VjhDSEo3SUtHbDl0akh1SU14Y3MxenpYVzd2dTM4eCtLWlI1ZEo4b0RFRnEy?=
 =?utf-8?B?Z1ZqZXY3WVhmejBkNXFUMXFGY1BSL1ltY0NkK3NDY2NlZ3lhR252MW9BYWls?=
 =?utf-8?B?TWpVRU5JcFp3dWNhampkK0ptRUxMYWNDaTZxRk1wU2xhR25tMDNVTkNiOHRP?=
 =?utf-8?B?V0VWUDBPa0xBL0RVQ0ZxV1NKS3dLdWxqWStiUDNRQjRiREdYR3VaRkd4MkhH?=
 =?utf-8?B?Sy94d3Jpc3g3R2ZvYVdWY1FVZHA5cndGV0RuRW9qcGg2dDRKRGV2Ly91eHFn?=
 =?utf-8?B?Ym1DbzhNNDNxSHkwcWJhTStCWWMvQ1lSSy9Xa0RBOEs1c3ZzSWh6WXV1UVN0?=
 =?utf-8?B?VndFcDJJNGNLQ0hSSk5HZHlmTVhKRmxKRmUvMkdkVHl3QzZBVm0rK2RBWDg2?=
 =?utf-8?B?c2szL1UwdDNCU1Z4MXNkOXU5YWJTdHVScTI4L21OR0RsUm1nQ2w4aCtIWDdW?=
 =?utf-8?B?Rml4ZHo1eE9UZmpWUkFwNzlFNS85Wkh2S1dLdW9HUlAyY3pwMlIwaGVrMjF3?=
 =?utf-8?B?VVVPS09GNjJrTS9UUEIxQ3VsM2dkWjNsS0w5Q3AzbzZEMFJwTER3ZUU5cU5m?=
 =?utf-8?B?OTlpcm9aNEJ3Nk1kVC9QMklEYXY4M0NoclNCK3RvSU02UUZXS2p1VGFWS1dN?=
 =?utf-8?B?bFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fcee93e-fa38-451a-8387-08dd54d3ef7d
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2025 13:05:38.8790
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KFXfRwAQSgL00rZpZKt/nSMTSqNZ4Bdln3RaNypJVDdHB1AvNuFppgRgvwBKXGyolU5e6HY/lMKQa0YPj0OJzGWHlbOJjHXrdb3BHF0yHPg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB7782
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 24 Feb 2025 13:05:46 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17897

Pk9uIDI0LjAyLjI1IDEzOjQ5LCBIZWluaXNjaCwgQWxleGFuZGVyIChGVCBSUEQgQ0VEIFNFUy1B
VCkgd3JvdGU6DQo+Pj4gT24gMi8yMC8yNSAxNDowMCwgSGVpbmlzY2gsIEFsZXhhbmRlciAoRlQg
UlBEIENFRCBTRVMtQVQpIHdyb3RlOg0KPj4+Pj4gT24gMi8xNy8yNSAxMTowMCwgYWxleGFuZGVy
LmhlaW5pc2NoQHNpZW1lbnMuY29tIHdyb3RlOg0KPj4+Pj4+IEZyb206IEFsZXhhbmRlciBIZWlu
aXNjaCA8YWxleGFuZGVyLmhlaW5pc2NoQHNpZW1lbnMuY29tPg0KPj4+Pj4+DQo+Pj4+Pj4gSW4g
YWRkaXRpb24gdG8gdGhlIG92ZXJsYXlzIGZvciBlLmcuIC9ldGMgd2Ugbm93IHN1cHBvcnQgDQo+
Pj4+Pj4gcGVyc2lzdGVudCBvdmVybGF5cyBmb3Igcm9vdGZzIGFzIHdlbGwuDQo+Pj4+Pj4gVG8g
ZW5hYmxlIHRoaXMgYmVoYXZpb3VyIHlvdSBjYW4gZWl0aGVyIHNldCBJTklUUkFNRlNfT1ZFUkxB
WV9QQVRIUyA9ICIvIg0KPj4+Pj4+IG9yIGV4dGVuZCB5b3VyIGV4aXN0aW5nIGNvbmZpZyBJTklU
UkFNRlNfT1ZFUkxBWV9QQVRIUyA9ICIvIC9ldGMiDQo+Pj4+Pj4NCj4+Pj4+DQo+Pj4+PiBJIHdv
dWxkIGxpa2UgdG8gYXZvaWQgdGhhdCBhbnRpIHBhdHRlcm4gb2YgY3JlYXRpbmcgYW4gb3Zlcmxh
eSBvdmVyIHRoZSBjb21wbGV0ZSByb290ZnMuIFdoYXQgYXJlIHRoZSBkZWJ1ZyBjYXNlIHlvdSBu
ZWVkIGEgZnVsbCBvdmVybGF5Pw0KPj4+Pj4NCj4+Pj4gVG8gYmUgdmVyeSBjbGVhcjogVGhpcyBp
cyBub3QgbWVhbnQgZm9yIGRlYnVnZ2luZyBpbiB0aGUgZmllbGQhIE5ldmVyLCBldmVyLg0KPj4+
Pg0KPj4+PiBUaGUgaW50ZW50aW9uIG9mIGhhdmluZyBhIHJvb3Qtb3ZlcmxheSBmb3IgdXMgd2Fz
IHRvIGhhdmUgYW4gZWFzeSANCj4+Pj4gd2F5IHRvIGRldmVsb3AgYW5kIGV4dGVuZCByZWNpcGVz
IGJhc2VkIG9uIG91ciBleGlzdGluZyBpbWFnZXMuIFRoYXQgDQo+Pj4+IG1lYW5zLCB3ZSB3YW50
ZWQgdG8gaGF2ZSB0aGUgcG9zc2liaWxpdHkgdG8gaW5zdGFsbCBwYWNrYWdlcyB3aXRoIA0KPj4+
PiBhcHQsIG9yIGNvcHkgYWRkaXRpb25hbCBiaW5hcmllcywgc2VydmljZXMsIGNvbmZpZ3Mgb24g
dGhlIGRldmljZSANCj4+Pj4gd2l0aG91dCBoYXZpbmcgdG8gcmVidWlsZCBvdXIgaW1hZ2UgYWxs
IHRoZSB0aW1lLCBzdGlsbCBtYWludGFpbmluZyANCj4+Pj4gdG8gaGF2ZSBhIHdvcmtpbmcgZW52
aXJvbm1lbnQgYXMgY2xvc2UgYXMgcG9zc2libGUgdG8gdGhlIHByb2R1Y3Rpb24gaW1hZ2UuDQo+
Pj4+IFRoYXQgZW5hYmxlcyB1cyB0byBkZXZlbG9wIGZlYXR1cmVzIGluIGEgZGViaWFuIG5hdGl2
ZSBlbnZpcm9ubWVudCwgDQo+Pj4+IHN0aWxsIGJlaW5nIGNsb3NlIHRvIHRoZSBmZWF0dXJlcyBw
cmVzZW50IGluIHRoZSBmaW5hbCB0YXJnZXQgaW1hZ2UuDQo+Pj4+IEFmdGVyIGJlaW5nIGNvbmZp
ZGVudCwgdGhlIHN0ZXBzIGRvbmUgYW5kIGNoYW5nZXMgcmVmbGVjdGVkIG9uIHRoZSANCj4+Pj4g
b3ZlcmxheSBjYW4gYmUgdHJhbnNmZXJyZWQgZmFpcmx5IGVhc3kgdG8gYSByZWNpcGUgYW5kIGVu
ZCB1cCBpbiBhIHByb2R1Y3Rpb24gaW1hZ2UgKGltYWdlIHdpdGhvdXQgdGhlIG92ZXJsYXkpLg0K
Pj4+DQo+Pj4gT2ssIHRoaXMgc3RpbGwgZG9lcyBub3QgZXhwbGFpbiB3aHkNCj4+PiBPdmVybGF5
aW5nIGAvdXNyYCBzaG91bGQgYmUgZW5vdWdoIGZvciB0aGVzZSB1c2UgY2FzZXMgPw0KPj4gDQo+
PiBJIGV4cGxhaW5lZCB0aGF0IGluIHRoZSB0aHJlYWQgd2l0aCBMdWR3aWc6IA0KPj4gIg0KPj4g
UHJvYmFibHkgdGhhdCdzIHRoZSBjYXNlIGZvciBtb3N0IHBhcnRpdGlvbmluZ3MuIFN0aWxsIGhh
dmluZyBhIA0KPj4gY29tcGxldGUgcm9vdCBvdmVybGF5IGlzIG1vcmUgZ2VuZXJpYyBpbW8uDQo+
PiBCdXQgSSBhbSBvcGVuIGZvciB0aGF0IQ0KPj4gIg0KPj4gDQo+Pj4NCj4+PiBBbHNvIHRoaXMg
a2luZCBvZiB0ZXN0aW5nICBlbnN1cmVzIHRoYXQgeW91IHdpbGwgbm90IGZpbmQgaXNzdWVzIHJl
YWxhdGVkIHRvIHJlYWQgb25seSByb290ZnMgaW4geW91ciBwYWNrYWdlcyBkdXJpbmcgZGV2ZWxv
cG1lbnQuDQo+PiANCj4+IFNhbWUgaG9sZHMgdHJ1ZSBmb3Igb3ZlcmxheWluZyAvdXNyLiBPbmNl
IEkgaGF2ZSBmdW5kYW1lbnRhbCBwYXJ0cyBvZiANCj4+IHRoZSBybyBmaWxlc3lzdGVtIG92ZXJs
YXllZCwgaXNzdWVzIG1heSBiZSBoaWRkZW4gZHVyaW5nIHRoYXQgdGltZS4NCj4+IEFueWhvdywg
YXMgc2FpZCwgdGhpcyBpcyBvbmx5IGEgZmVhdHVyZSB3ZSBlbmFibGUgd2hlbiBkZXZlbG9waW5n
IG5ldyByZWNpcGVzLg0KPj4gT25jZSB0aGUgcmVjaXBlIGlzIGRvbmUgd2UgcmVidWlsZCBhbiBp
bWFnZSB3aXRob3V0IHJvb3Qtb3ZlcmxheSBhbmQgDQo+PiB0ZXN0aW5nIGlzIGRvbmUgd2l0aG91
dCBzdWNoIG92ZXJsYXkhDQo+PiANCj4+IFRMRFI6IEkgYW0gYWxzbyBmaW5lIHdpdGggb3Zlcmxh
eWluZyBqdXN0IC91c3IgdG8gc2ltcGxpZnkgdGhlIHNldHVwLg0KPj4gVGhlIGluaXRpYWwgaWRl
YSB3YXMgdG8gaGF2ZSBhIGdlbmVyaWMgc29sdXRpb24gZm9yIGEgZnVsbCBvdmVybGF5IA0KPj4g
aW5jbHVkaW5nIGN1c3RvbSBkb3duc3RyZWFtIHBhcnRpdGlvbmluZ3MgLyBtb3VudHBvaW50cyBm
b3IgZXh0ZXJuYWwgc3RvcmFnZS4NCj4+IA0KPj4gQnV0IEkgaGF2ZSB0byBhZG1pdCwgaXQgYnJp
bmdzIGFkZGl0aW9uYWwgY29tcGxleGl0eSBhbmQgaWYgd2UgZGVjaWRlIA0KPj4gYWdhaW5zdCBz
dWNoIGdlbmVyaWMgYXBwcm9hY2ggSSBhbSBhbHNvIGZpbmUgd2l0aCB0aGF0IQ0KPj4gDQo+DQo+
U2hvdWxkIHdlIHNpbXBseSByZXZlcnQgcGF0Y2ggMSB1bnRpbCBpdCBpcyBjbGVhciBpZiB3ZSBz
dGlsbCBuZWVkIGl0IChpbiBhIGRpZmZlcmVudCBmb3JtIHRoZW4pPw0KDQpZZXMhIChzcnkgZm9y
IHRoYXQsIC4uLikNCg0KQnV0IG5vIG1hdHRlciBpZiB3ZSBrZWVwIHRoZSByb290LW92ZXJsYXkg
b3Igbm90LCB3ZSBzaG91bGQgZmluZA0KY2xhcml0eSBvbiB0aGF0IGlzc3VlLg0KDQpCUiBBbGV4
YW5kZXINCg0KPg0KPkphbg0KPg0KPi0tDQo+U2llbWVucyBBRywgRm91bmRhdGlvbmFsIFRlY2hu
b2xvZ2llcw0KPkxpbnV4IEV4cGVydCBDZW50ZXINCj4NCg==

