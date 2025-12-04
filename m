Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B835D1F9C9
	for <webhook@archiver.kernel.org>; Thu,  4 Dec 2025 11:40:35 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com (AS8PR04CU009.outbound.protection.outlook.com [52.101.70.13])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.41556.1764848425786337106
 for <cip-dev@lists.cip-project.org>;
 Thu, 04 Dec 2025 03:40:26 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=WhXIRptU;
 spf=pass (domain: siemens.com, ip: 52.101.70.13, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AwiooE8oEE8bZisR+w5iZfqgLBXmYuENVRx819gBvGca4CmXbJ6ApNl3GCIYQxGvykbsRE4ViRpjwGad8TK4ZrnlG6FJrnsSP/fF7GVkmvXWVY9gafhOOPdA2N4MPXLtvh4+DuusCTlFiDeSY1EVvopJe/TGXtwOrN6vowQKtSi6Pjn8fMS0PVFOmO9wGfkRqMIDyBj2qP25ioOsP9RV4XYIWz21eixrtB62VOH5KdH/e8jzd3umIBQuDuOV/v/vDEv9feCjkVN7FkrtTsotuxS+oYYNY3DZsb4BLq73F7w7H/X/iOGnOWTB1CP12YfY4B6k7Qi+GZoqygynTiCW5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sy0+QLfjHUkpk9F1W1ZYH4+lgH7sswLjXdG3E0TTAi0=;
 b=W/UAZYxKmeRuK99S27vyAGGqzrzppvJMa2IJQe0go3RLPl65/XnNMMCUqhrrCUflgw0S7VAR0FqVH/GxmxqjHByGsAbqq86h52+T5UsTQekWC7V0mm7Yt4IPhKv3FooAv57oT9OJuJVcHWf9aA12GUy4dW7zQFOCOGkcVOjrNG76rOygWzpD7P6st5thRcZu+NG7vFntd9y5xMFG/QJMZvEIxyki9vVxfhifRjzlyVTVhcTbRjhD1ECaivw1gIEhXs3dkx8qYSklE69geaYJgnCZJc1n6Iso3Fl1vA2lOalqUDsqg5pYwVzGbSmD7WS8dLOnO2XidHOF1Nv2l0YwoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sy0+QLfjHUkpk9F1W1ZYH4+lgH7sswLjXdG3E0TTAi0=;
 b=WhXIRptUClTS84DzVp/er3UzUG5UGMP+EDLa4B6UVkU63ef/2v/U7DjBAWFPrEYtyQqpT95YQFzdeBsSWIWxIsF2qRrpprvPqc19gfBf8LZvv8pzRmhiop6RuerMP6FCfq8HcIvLvT6FT91umKZXtgAEd5CeGPFb5Lc9goNOFDf9874tSnmYZD9LOSu6G2qGYOXrdsEwYNpUTHs6GUvtaLJQYCHY3BA3LXFiCMrfB+nLRkptD+CwPQ6fdmM9XySy1Sx1NTxe44UMzaLmq/n4DmJg+Ykdysty+FNDcOWFqUwO6vzoUW4xtQAW2BZ7lSXbIkZI7FCnXjeLrMiTW0kdoA==
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS2PR10MB7761.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:644::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Thu, 4 Dec
 2025 11:40:22 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9366.012; Thu, 4 Dec 2025
 11:40:22 +0000
From: "Kiszka, Jan" <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: Re: CIP IRC weekly meeting today on libera.chat
Thread-Topic: CIP IRC weekly meeting today on libera.chat
Thread-Index: AQHcZOlrIlCdB5SpikublDlubEzYH7URW7gG
Date: Thu, 4 Dec 2025 11:40:21 +0000
Message-ID: <25F3F037-6CC8-4417-8942-80356F8B0D9A@siemens.com>
References: <c70812d1-e6ab-4d1a-b55c-b58011fe63ba@siemens.com>
In-Reply-To: <c70812d1-e6ab-4d1a-b55c-b58011fe63ba@siemens.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR10MB6181:EE_|AS2PR10MB7761:EE_
x-ms-office365-filtering-correlation-id: c29ec035-cf24-4224-de56-08de3329e87d
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|376014|10070799003|1800799024|38070700021;
x-microsoft-antispam-message-info: 
 =?utf-8?B?R3Q3cldacWQ1M2RPWGZMenlXMEx0Q1ZrbzBVVlJxU3FZUlVlRUdETDhCejFi?=
 =?utf-8?B?ZWJvUFh3K2s2Z0YwM0tjeVphL3ZscXpmRmpRd2k0UVg5Tml1ckJvVHZKakov?=
 =?utf-8?B?QVh6OU5RaktuWG83amF1L3RSN2swQlNqbXpUU3l0eTdnVFZRRzRWc1R5TEZ1?=
 =?utf-8?B?QURuK3RONXNJc1lGamlYR3hGUCsyU01yWUY3VVFVL2FuSzIrd1QyaW42bG14?=
 =?utf-8?B?N3BUeWRmWkJseXNTTklvcDhlT3NPM1MrakIwWk9XOUJhQ1lkUjg2RjcwUUtH?=
 =?utf-8?B?WmtyQVFBMzc5dkZTQys1b1VMMVpodXJrRjU5YXNibVV4R1hMcGFVYWVLQkdR?=
 =?utf-8?B?VDcrZDdyOTZqQWMwMTZhTm0yb2ZOYWhEcHArWVJFSm0xRFJZUXJ5eVJ6aldZ?=
 =?utf-8?B?cGN1dTBQWm1qS3oydkpqNzNGNm0wM0JONG5GTTVEUDVGb01uUlhjbHVmL1RE?=
 =?utf-8?B?QlpnWlVDREhwU0JPN05iZHp2eWpreXFzVUlJOFg1ZUlIU3JyWTB2YTRqc2I1?=
 =?utf-8?B?SGlFcE5tcktvS2lpMWh1MDFZajVQRllXTTF5WFliWEdaNURkUG9nRjdOejBU?=
 =?utf-8?B?Zy82L1pvd3FRUHBKZmplNG5EeXJCNkhrck1MSG9peVpEREV3T1diZFNJdllL?=
 =?utf-8?B?RDdhRlRGS1l0SDEyc1FWa3kvWDNOMUFhdGRERWxWRERlV25PcnJ5RW92NHRL?=
 =?utf-8?B?Qjk5OEZSNlo5L0RFbkZ3QUQvSm9sNDltRWdUcjA1U0pJYk5uVFhJcGk1WStE?=
 =?utf-8?B?NjhRdWNCYW9lU3NPOGozY3NITnB2YnlWYU42RkwyZ2JlTFpQVVlsUnp6QUpz?=
 =?utf-8?B?aWd1dCtTNEtIYXV5Zms4ZWJPdkN4M0duS2ZvWTZCbnJwZWZwTzZHTEN4bVkr?=
 =?utf-8?B?emgxSSt1MGl1WkVKL2t6SUZKU2ZiOGI4c2o4bG9XTjZMYURDNEpkczdMaE43?=
 =?utf-8?B?TFgzTHlxS3FCUEpMc2E2Kzd6NjREWnorNzVzWEl5UUNzY1l4TWxpRkRRTFAy?=
 =?utf-8?B?bUZKMm04TnNYU1hSQ1RUanNoWDZCZWNQWWEwcWI5V1Q0WTNBTlRHeE4zS091?=
 =?utf-8?B?eWtHb3Q2QjZnTStiOXdPb3U5WnJBZUFuUzZUZm9rL1gzS1QvdHNVaHJORmN5?=
 =?utf-8?B?UVhRZ0g1UG1ManJ5N1dDOGlKQUt2NWFSelZ2VnFadGlYeHloME45dlkwZUNQ?=
 =?utf-8?B?eTMyRmhqaFJraHcwbEQxRlJDVlFlelZzTjJqV01QVXg0QmJrZ3lpdWRzMGdH?=
 =?utf-8?B?RmxtRTZpYVRabTlVT2Y5MHlWMkdYZERMRmtEbTRFV25sdngxZ3ZuQzNzYVlS?=
 =?utf-8?B?ZHkvTnVvV096dldncy95eXdkZGl3aTlXTGE3NFVKR2k0OXB4SndIMFVya0pt?=
 =?utf-8?B?dDlQV2JEUThXN1VQaDBQVVcvN3VLWnRFbFZ4ZjlpRThieFdtdmRHNS9Rc2Fz?=
 =?utf-8?B?c01mT2VENEpxcWtkZGI3UUoxSGVwc0lGVGMrWGsyNjRDYjdFVC96RjdVcWlt?=
 =?utf-8?B?UklYME8xM1dEcGlyaXhlVkJqVkpweTlPcFBMMHRoaWhNTkVYQWlnTDl1Y3RG?=
 =?utf-8?B?bXJLQzl0YWp0Sk9CVkpaZENxN3gvTU5zYXNTMTA5VHg1MFdDUzJYWVNRbWpm?=
 =?utf-8?B?ekRXeEsrWGNqK3ZsS3J5SnhSekYzczVONnJWd2NadTM2c2NUZStUV0l2djM1?=
 =?utf-8?B?citod0ZPSEVXd0w0ZkwvTEVwdzEzZVpmV3VCNU1WZ3pVanFnemplQmlnMjBF?=
 =?utf-8?B?ajIvaWx1cytnTC9GVHpGaTVBZTdOU0prL0lhcnd4NjRtTTJFalhXT2djbng4?=
 =?utf-8?B?R2JqaUlqcmVwYnFTc0wrbnlJeW1sdjR5dy9EVkYxS0FocVZ1RG5SeTQrNklI?=
 =?utf-8?B?NmJoakFPVnpkL1pxUUl2dHZXME1HejFPVUJkL2Y4TDVtc0NvRjFYTDFBb2pi?=
 =?utf-8?B?M21EUGFCdm1MUjlBZHBWL0xsK092TWZqWVFYQlRzODhXMVBmdnVKbmhuR1k4?=
 =?utf-8?B?OHJ6YmlxOEF3PT0=?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(10070799003)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?MXMwUCtRN05xNHRVYzdnUzA3SkJFTXRucXNiZmprZHd5OHovNkJtaXM1MkVk?=
 =?utf-8?B?N3FVMWNrUm42MVR3ZE9ZOWJ4K0pWR2UxK2RqMVZRWWxjak9uMXc5Y3RGRldW?=
 =?utf-8?B?aWpTUmgyalBEQ3hkT2MyY2VvYjVQR3h6OE1HblExTm94UWJGaHN5TVk5cG1l?=
 =?utf-8?B?UVNrTEhzSUZBdHgwWTVkZnJBWitRM08wN0lQQ0JYOHlvekZNcUN0UTRqY3hH?=
 =?utf-8?B?d0g3TFdLVGtyQ0ZGNUdSekl6MWJialhKeXNBZUV5YlRiUnpaeFl1dGNPQ3Vx?=
 =?utf-8?B?a081MkRJakEyZmU0U2RsOS9ESGJTNnpyQmx6TWZ1OTdGS3N2b0thTVR2bjZ0?=
 =?utf-8?B?MWtQMFpBcGljeVFMeDFFSGZVMTdSL3dYWlFTWDM3enZrZjJucVpEb0JpYk1u?=
 =?utf-8?B?SUVJN0dpMkx5c0owZ0F3cXZsMXpEdzUvalorazNmUllXSzNxKzBNZjV1OGx5?=
 =?utf-8?B?N2RxM1VUeFQ0VmprTnJpelI2REZGM0ZCY0ZoUzBSR3I0b2ZhTGpQMCtqd0VK?=
 =?utf-8?B?a2czSHFpSHpPL2xTcVo5QjZIVjNTZ2VNQWEyUmVXODhobXJ5djlPSEovVVZn?=
 =?utf-8?B?SmtDdEN0OXpyV3B0eHBJTUZURlhwWXc2U0hVbkNFUXcrdWdHNTdzZGRtYTc0?=
 =?utf-8?B?djlPV21sRFlhdmFFZys1V1NvMkM5SnBueGhkeWNDTWhsRU9CU0k1TmtSckc4?=
 =?utf-8?B?dklnek45SmVDYmpJd29GcEdvcmdINmN0OElzQzlwRng1dStmbThPUjFXc1Vs?=
 =?utf-8?B?ZmRxMXpYQmR2elBrbVZwWVA1N2V5cEFSVTBJVnZEOHAwSmVhak5uV0JQdTlx?=
 =?utf-8?B?Z09KNnBKSHRRNTQvR0t2OEhVREcvNWtDNnVOSVpaY3MvTk5XelJXMWFxTjZm?=
 =?utf-8?B?VFMzaWh6Y0dVNlZIT1AvRG5odytOaWtWeGpNNnFMbjIxQy9yQlAwU05INVll?=
 =?utf-8?B?Ni9hSjFUNEJBOS9ZdlVpUVJOV0FxR1VQZ1RPSHQ0NXloUVNzMzFOV28wQUpL?=
 =?utf-8?B?NTlPTVJNcmNlSW5JakJKdUx3SURPV0Z3OXdrbWFLeDFXa3VJVjdTN2RQVmox?=
 =?utf-8?B?TFZRazhRWkl3Q1ZWbnZzS1RPekJYZXBvNDlxREQ5TFdIN3pNMUwvVTN5d3VE?=
 =?utf-8?B?TlBZSE00L0Y5bTFHVitRc0Rtelo4Q3BiSmQwVDVhLzBHdkhiWXBuS0F4djNW?=
 =?utf-8?B?N0lRbVkvOXlueWsyYU9KVU52L0Iwbkp1bzhMSEk5UC9wdkI0Z1NHV015eTFs?=
 =?utf-8?B?b3dqVUNpTVVvN3ZZTXBvNHVib3JzUFl4ZGVQdVl2WGc2QmtFelQ5M2xkMVpS?=
 =?utf-8?B?cU8rNEtsYm4zUUNRd0EyWHRaNm5IaEdQTFZMcGRZdkR5d2ZJTms0MDBoSE1U?=
 =?utf-8?B?OUJHd2lnOWgxMXdFczJpb2pyVUUydkRmd29LVHo3Z0ZJeW04bVVCb1lac0ph?=
 =?utf-8?B?YmI0NmlDejBIZnhLSVVHU242bzNiU3RwZXJzU21CM1RhMmxqb0ROM1M2dFBt?=
 =?utf-8?B?L1U5WDE3dXoyNlkvbkRjMWRRdE52eFpVcFdMU1BER0dyK1FQYlZ5M2FKcEwy?=
 =?utf-8?B?WnVScVY0ZnVHajhGYk5ieXdWNWdseHB2V2txWlducjV3dHRIajdJTWxKaXRw?=
 =?utf-8?B?aDhEUGpGbHE5R3BUbUhVMjFhc2ZFUGxuWDlQbk5JOUpuRWYzSGtzQ1pqZ3dD?=
 =?utf-8?B?SUxnMWI2SEUyaHhkYlNxeVZUbEtaRHJYUEJHWlNxQ0FTbXNaaDQzdWRCamZ0?=
 =?utf-8?B?UHJrazMzeUorcjZtN1ZFQi84cllaYVNXZmdObHBXa2RmUzI1bXJFcDQyV2ZQ?=
 =?utf-8?B?Q1dWWjJtRURUb080ZFJOWmx3WEhTMnIzTDIyWUZqU1dGWU5MZVN2OGVRQ3JN?=
 =?utf-8?B?bXYwZE1GUVk3bmtPb0Z0QXUrUnEwTGovbjkzUSt1YmgxQXkvYlJWUSt2c2t3?=
 =?utf-8?B?UEtxNW1ZNDNpRFcwbWN5aUY3VlY0SVV1Qk5mblB4dHBXMTZQRFhVaWd6RkRt?=
 =?utf-8?B?dVlNUTRHUFNSeGJuK3hTTzdLUHFhSDJFZC9mdy9nWnBIL2tXcE4xbEZEaE03?=
 =?utf-8?B?Sk1mN0FXRDZtM1N1VFBBcVlnZHphQmgvTVdqZ3lLUUxRSHo4TGh0TnJXQmNB?=
 =?utf-8?B?amJDUG1QZTh1bXdDVE9FNkxoWnZJdHRvcXliRnppdWV2T3RmQ1Z2MlBDUllV?=
 =?utf-8?Q?Tox4ma/lDin6TeZGtjurtFs01UByLsUsTTihFpuvWHMM?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: c29ec035-cf24-4224-de56-08de3329e87d
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2025 11:40:21.9814
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KOSchTwu3bkkL8UkdOo/lkkydlTxsZ5yvC71P9ghH/nAToRUuuRXEfkiOrmlHHXPkiHZdknHFFa/T+ZeKifCaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7761
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 04 Dec 2025 11:40:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20846

T2ssIGl0IGhhcHBlbmVkIHdoYXQgSSB3YXMgYWZyYWlkIG9mOiBzY2hlZHVsZSBzaGlmdHMsIGFu
ZCBJIHdpbGwgbm90IGJlIGFibGUgdG8gYmUgd2l0aCB5b3Ugb24gdGltZS4gUGxlYXNlIHN0YXJ0
IHdpdGhvdXQgbWUuDQoNCkphbg0KDQo+IEFtIDA0LjEyLjIwMjUgdW0gMDc6NDQgc2NocmllYiBL
aXN6a2EsIEphbiAoRlQgUlBEIENFRCkgPGphbi5raXN6a2FAc2llbWVucy5jb20+Og0KPiANCj4g
77u/SGkgYWxsLA0KPiANCj4gS2luZGx5IGJlIHJlbWluZGVkIHRvIGF0dGVuZCB0aGUgd2Vla2x5
IG1lZXRpbmcgdGhyb3VnaCBJUkMgdG8gZGlzY3Vzcw0KPiB0ZWNobmljYWwgdG9waWNzIHdpdGgg
Q0lQIGtlcm5lbCB0b2RheS4gT3VyIGNoYW5uZWwgaXMgdGhlIGZvbGxvd2luZzoNCj4gDQo+ICAg
IGlyYzppcmMubGliZXJhLmNoYXQ6NjY2Ny9jaXANCj4gDQo+IFRoZSBJUkMgbWVldGluZyBpcyBz
Y2hlZHVsZWQgdG8gVVRDIChHTVQpIDEyOjAwOg0KPiANCj4gaHR0cHM6Ly93d3cudGltZWFuZGRh
dGUuY29tL3dvcmxkY2xvY2svbWVldGluZ2RldGFpbHMuaHRtbD95ZWFyPTIwMjUmbW9udGg9MTIm
ZGF5PTQmaG91cj0xMiZtaW49MCZzZWM9MCZwMT0yMjQmcDI9MTc5JnAzPTEzNiZwND0zNyZwNT0y
NDEmcDY9MjQ4DQo+IA0KPiBVU1dlc3QgICAgVVNFYXN0ICAgIFVLICAgICAgICBERSAgICAgICAg
VFcgICAgICAgIEpQDQo+IDA0OjAwICAgICAwNzowMCAgICAgMTI6MDAgICAgIDEzOjAwICAgICAy
MDowMCAgICAgMjE6MDANCj4gDQo+IExhc3QgbWVldGluZyBtaW51dGVzOg0KPiBodHRwczovL2ly
Y2JvdC53bC5saW51eGZvdW5kYXRpb24ub3JnL21lZXRpbmdzL2NpcC8yMDI1LzExL2NpcC4yMDI1
LTExLTI3LTEyLjAxLmxvZy5odG1sDQo+IA0KPiAqIEFjdGlvbiBpdGVtcw0KPiAqIEtlcm5lbCBt
YWludGVuYW5jZSB1cGRhdGVzDQo+ICogS2VybmVsIHJlbGVhc2Ugc3RhdHVzIFsqXQ0KPiAqIEtl
cm5lbCB0ZXN0aW5nDQo+ICogQU9CDQo+ICAtIHRvcGljcyBmb3IgRXh0ZW5kZWQgVFNDIG1lZXRp
bmcgaW4gSmFwYW4NCj4gDQo+IEknbSBoYXZlIHNvbWUgcGFyYWxsZWwgZXZlbnQgYWdhaW4gdG9k
YXksIGFuZCBpZiBpdHMgYWdlbmRhIHNoaWZ0cywgSQ0KPiB3b3VsZCBuZWVkIHNvbWVvbmUgdG8g
cGljayB1cCBhbmQgcnVuIHRoZSBtZWV0aW5nLiBTbywgZG8gbm90IHdhaXQgZm9yDQo+IG1lIGxv
bmdlciB0aGFuIGEgY291cGxlIG9mIG1pbnV0ZXMuDQo+IA0KPiBKYW4NCj4gDQo+IFsqXQ0KPiBE
YXRlIHRoZSBkYXRhIGlzIGNyZWF0ZWQ6IFRodSBEZWMgIDQgMDY6NDA6NTIgQU0gVVRDIDIwMjUN
Cj4gbGludXgtNC40LnktY2lwOiBpbnRlcnZhbCAzMCBkYXkNCj4gIGxhdGVzdCB2ZXJzaW9uIHJl
bGVhc2UgZGF0ZTogVGh1IE5vdiAyNyAxMjo1MjoxMSBBTSBVVEMgMjAyNQ0KPiAgbGltaXQgZGF0
ZTogU2F0IERlYyAyNyAxMjo1MjoxMSBBTSBVVEMgMjAyNQ0KPiAgU3RhdHVzOiBPbiB0cmFjaw0K
PiBsaW51eC00LjQueS1jaXAtcnQ6IGludGVydmFsIDYwIGRheQ0KPiAgbGF0ZXN0IHZlcnNpb24g
cmVsZWFzZSBkYXRlOiBXZWQgTm92ICA1IDEwOjA3OjAwIEFNIFVUQyAyMDI1DQo+ICBsaW1pdCBk
YXRlOiBTdW4gSmFuICA0IDEwOjA3OjAwIEFNIFVUQyAyMDI2DQo+ICBTdGF0dXM6IE9uIHRyYWNr
DQo+IGxpbnV4LTQuMTkueS1jaXA6IGludGVydmFsIDMwIGRheQ0KPiAgbGF0ZXN0IHZlcnNpb24g
cmVsZWFzZSBkYXRlOiBUaHUgTm92IDIwIDEwOjIwOjA4IEFNIFVUQyAyMDI1DQo+ICBsaW1pdCBk
YXRlOiBTYXQgRGVjIDIwIDEwOjIwOjA4IEFNIFVUQyAyMDI1DQo+ICBTdGF0dXM6IE9uIHRyYWNr
DQo+IGxpbnV4LTQuMTkueS1jaXAtcnQ6IGludGVydmFsIDYwIGRheQ0KPiAgbGF0ZXN0IHZlcnNp
b24gcmVsZWFzZSBkYXRlOiBUdWUgU2VwIDIzIDEwOjUzOjA3IEFNIFVUQyAyMDI1DQo+ICBsaW1p
dCBkYXRlOiBTYXQgTm92IDIyIDEwOjUzOjA3IEFNIFVUQyAyMDI1DQo+ICBTdGF0dXM6ICpMYXRl
Kg0KPiBsaW51eC01LjEwLnktY2lwOiBpbnRlcnZhbCAzMCBkYXkNCj4gIGxhdGVzdCB2ZXJzaW9u
IHJlbGVhc2UgZGF0ZTogVGh1IE5vdiAgNiAwOTowMDoyNSBQTSBVVEMgMjAyNQ0KPiAgbGltaXQg
ZGF0ZTogU2F0IERlYyAgNiAwOTowMDoyNSBQTSBVVEMgMjAyNQ0KPiAgU3RhdHVzOiBPbiB0cmFj
aw0KPiBsaW51eC01LjEwLnktY2lwLXJ0OiBpbnRlcnZhbCA2MCBkYXkNCj4gIGxhdGVzdCB2ZXJz
aW9uIHJlbGVhc2UgZGF0ZTogRnJpIE5vdiAgNyAwOTo0NTo1NyBBTSBVVEMgMjAyNQ0KPiAgbGlt
aXQgZGF0ZTogVHVlIEphbiAgNiAwOTo0NTo1NyBBTSBVVEMgMjAyNg0KPiAgU3RhdHVzOiBPbiB0
cmFjaw0KPiBsaW51eC02LjEueS1jaXA6IGludGVydmFsIDMwIGRheQ0KPiAgbGF0ZXN0IHZlcnNp
b24gcmVsZWFzZSBkYXRlOiBXZWQgTm92ICA1IDEyOjMyOjQ1IFBNIFVUQyAyMDI1DQo+ICBsaW1p
dCBkYXRlOiBGcmkgRGVjICA1IDEyOjMyOjQ1IFBNIFVUQyAyMDI1DQo+ICBTdGF0dXM6IE9uIHRy
YWNrDQo+IGxpbnV4LTYuMS55LWNpcC1ydDogaW50ZXJ2YWwgNjAgZGF5DQo+ICBsYXRlc3QgdmVy
c2lvbiByZWxlYXNlIGRhdGU6IFdlZCBOb3YgIDUgMDY6NTA6MTMgUE0gVVRDIDIwMjUNCj4gIGxp
bWl0IGRhdGU6IFN1biBKYW4gIDQgMDY6NTA6MTMgUE0gVVRDIDIwMjYNCj4gIFN0YXR1czogT24g
dHJhY2sNCj4gbGludXgtNi4xMi55LWNpcDogaW50ZXJ2YWwgMTUgZGF5DQo+ICBsYXRlc3QgdmVy
c2lvbiByZWxlYXNlIGRhdGU6IFR1ZSBEZWMgIDIgMDU6Mjk6MTIgQU0gVVRDIDIwMjUNCj4gIGxp
bWl0IGRhdGU6IFdlZCBEZWMgMTcgMDU6Mjk6MTIgQU0gVVRDIDIwMjUNCj4gIFN0YXR1czogT24g
dHJhY2sNCg==

