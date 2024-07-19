Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93B3AC3DA59
	for <webhook@archiver.kernel.org>; Fri, 19 Jul 2024 11:31:34 +0000 (UTC)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (EUR02-VI1-obe.outbound.protection.outlook.com [40.107.241.72])
 by mx.groups.io with SMTP id smtpd.web10.13459.1721372141068150315
 for <cip-dev@lists.cip-project.org>;
 Thu, 18 Jul 2024 23:55:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=vQyC0rED;
 spf=pass (domain: siemens.com, ip: 40.107.241.72, mailfrom: felix.moessbauer@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ADb/Cq7op36l9btfiG/IW81Nwaxld1qzsYHrVEv+5RA4DzelgZgGXWrBEHrDBG943OSsUyDk8ZW03+HMJhDZo80h/qbE/4PUxJnBOisbYXO0KiosG494O+reIFgjSl+ntADyPpaYvvHv6HZstGKeY+zui2yJldKagFsR3eeQSZuyhjI67oMub0JN5LMhoggM2bQSh6e9nbqrmqdSW1RIKITPDzlIERWfeerFnQ+X7bzzJdiLc9JlTeiIT4tv6DvszBmcpGNQtsNkc2SVdz0m8JleRFoYnlUgJuHBupCyDFyOGEugmTuRKBrfRZYJKSHQ7ImX8JEHj+Bo0nlMjQsbFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HB/M9223U17r2PGjkGc4jGejALpSimI2lYUrDZOlRDw=;
 b=rPAO58k8sOP28sbWtO+fi0GlZZB0ZPIKFgLuRiohPdHD4R0T3FBO6vjAOzNFt9aMoAFyKbn2RoYv06JivOZ53mmqlOObh1VBl/9HeORNEVujmMgvJMiHIctZcTuQNNnKmyNsnJvLZ+il8CDvyWe++cUnVASGzD0/oyNhufYtTRhtn/R0DXMU9nQ8YI8g9MwE0+ekvEJnzNOsHY/zxWj9fzJ3H7JJyvmMLOYti3U/a3/CnkFtRWA4TsqRhYIbg459poLMiGE3MQZhILRiQqWoG2TNhXisoseiu3KZ144ta14mCVdWoSuELUy69g8uIVkejV+NGlnFUjpgvEQ1sbxT+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HB/M9223U17r2PGjkGc4jGejALpSimI2lYUrDZOlRDw=;
 b=vQyC0rED+ABv0eyuobcODFXQt0b/aaRuJlzOR/HZSX4Z0srJ9Oj5gVsiopg0jour5grSkkFxAc52lMRbI4hNRc6eQtUcupjSrYz3nNoqUqa37JBEtUax7BflhHnTdHAvCrSU3LXEK/Bv7sS9Xhmrqut8WrxcOSCSS259GM8rrxzWekJD1uIrSxXBfNtfjde3tbSnvGbDtxLj96mK4T78heo+RRF6CBhsh8O+IHSESxdrzaFuS0cNM+5/hHPii+YWCMl17xmwUrOt1qJHYgNPuvSZ/IzAiBNzc6OUA5gcwVG0w61DURPf61wXkCyiDrN2d+WBE+fcSqvzwxcWPn2Fyg==
Received: from DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:47f::13)
 by PAWPR10MB7103.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:2e5::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.14; Fri, 19 Jul
 2024 06:55:37 +0000
Received: from DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8198:b4e0:8d12:3dfe]) by DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8198:b4e0:8d12:3dfe%3]) with mapi id 15.20.7784.016; Fri, 19 Jul 2024
 06:55:36 +0000
From: "MOESSBAUER, Felix" <felix.moessbauer@siemens.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, "Arjunan,
 Srinu" <srinuvasan.a@siemens.com>
CC: "Kiszka, Jan" <jan.kiszka@siemens.com>
Subject: Re: [isar-cip-core] [PATCH] classes/squashfs: exclude boot dir during squshfs image creation
Thread-Topic: [isar-cip-core] [PATCH] classes/squashfs: exclude boot dir
 during squshfs image creation
Thread-Index: AQHa2aioKXb0zr5MgUi7Vrzt7lIxZw==
Date: Fri, 19 Jul 2024 06:55:36 +0000
Message-ID: <284ef2098da5aaeff02a565c4316fff854add437.camel@siemens.com>
References: <20240718105718.11562-1-srinuvasan.a@siemens.com>
In-Reply-To: <20240718105718.11562-1-srinuvasan.a@siemens.com>
Accept-Language: de-DE, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.46.4 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR10MB6828:EE_|PAWPR10MB7103:EE_
x-ms-office365-filtering-correlation-id: ff32d786-5acc-40aa-56f3-08dca7bfcb33
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?SDdPcWhNeFcvRTJjRmplLzF0Zmx3RWF4RWNBeXlkM2tmcWxzcUk3aVdVa2ZZ?=
 =?utf-8?B?NWt1c2FtVnRZZ0ptM01VWDd2OVpQTjUzR0FSRjV2N3Zwd0xBTlBNMSttd1Fa?=
 =?utf-8?B?a0QzN25ZSThma3Z4WlB5SHhSWU94cHdZMXBTNDFxMkJFOUNhVmhyZExqRjFF?=
 =?utf-8?B?QmFsbWNEZ1BZeGdDdUFQUERVRUNoaE80OWNmS1pMaDZxZnR4VkZ4c1ZWNE9k?=
 =?utf-8?B?K3dZNndjaFRwUnhPVHgyWWhGbFhrNnpHaW5YUGVMU05XWlREeHVVei9uUXpr?=
 =?utf-8?B?N0hXWEhtQnp5c2tsSmtjTW40ZzNRSkxUSWljOC9pZUVJM0JBTVIyN1lnTXly?=
 =?utf-8?B?Uk9TQWxIM3c1eHpTc0xaMWhmRHg1dHBTTkdaVUdzNC9iWkJwRC91NFUwbmdo?=
 =?utf-8?B?RkVjTm8vaDBZWHJzZFZraHd1YldzaFhJaURxeEdPRmZENXFDM1g3Q3Y5N0pq?=
 =?utf-8?B?QXhXVEJWOWJ6SFZRSjdrUXFLN2tPUnhwZW5ycUs0QTkrc3dvUDA5NWtzTFMw?=
 =?utf-8?B?WGhxbVRrSE5EUXdZTjljVzR2cjJ6ck40eEJ4cTJrQXk1RXVWU09IOGh3UmdZ?=
 =?utf-8?B?c0VsdjZkK3VhRjVVUEJLSEhmRk1LNmpuSVVGOHJZWk1hR25NZTNXT1BuZHNM?=
 =?utf-8?B?cHlBOFV6ZlVTaGl1SGZaWEZETEh2eis0a1BlYVBMRGJ2UHM0VDV5OTc4UWs4?=
 =?utf-8?B?NzBRblpCYlpVeUxsTmQyeUkrNDhtaU5PSEo0TCtBd3JkY000RWlJcE5lMXJR?=
 =?utf-8?B?RjJqZHFIYnVMU3ZTN3R1RTYrQlFFeE5GZG54Yi8wSXBuZC9aRkxDdER2bG03?=
 =?utf-8?B?a2tTNUxjOEpRdEFWenk0WWJGV3VBYkZRNDYrMURqeVlFVTkwS0xINThOL2w3?=
 =?utf-8?B?VmlpODI2QnJtM05kNFV6bEJqS1ZGY3VSTHV2eGdWM2k0RlE4MFZ2MXlWaG13?=
 =?utf-8?B?cVpPcGxycnBxb0ZWMzhvL0p2cnR4azExRGdWU1NSeTMzcndJN2g2YlhrbEpX?=
 =?utf-8?B?ODFVb2xOR0RFa2E2UDBnSkg1QW9uVGN3aGpVNzJuTzBpeTRqc3NJd0xXYkt2?=
 =?utf-8?B?eGQ0VG8zSURBYjVua0lRTWMzYVJVUllTSVA3RU1XdjRuZjdIOXZMajQ2UGUz?=
 =?utf-8?B?R2RUYVBwOWpRcE5KS3lBVGMzTysyYW1xSkxuaEVPTFZwRHB4eGszdFFQd1gz?=
 =?utf-8?B?aWlVSjhGaUdyMGRCR3dZdFdlYWZKRGlQMWxMOUMwdktlbXlHaEZhSERMb0hj?=
 =?utf-8?B?OG8rdVVPcDRZWGNEOGU1cmVlYzFtZGROTk92M2JlMkFlbXRLTllxQkNYaHFF?=
 =?utf-8?B?KzYwUlpRRWRkbHVkS01Na0d3UGlma25WZVhLaHJGZ3pqNmNzNTRHTVdDZTEx?=
 =?utf-8?B?QzZacFJ1czkwYlgzM0grQXRvSGFuOW5YZVZUMXJFWTNxMVRKNkpPc2JScGtX?=
 =?utf-8?B?R1pVcEtkR0Vwa3UxMXVCeWVhQXNUUjFVcTJST2VtWUszL2c3aFRWbWUxcnVi?=
 =?utf-8?B?UDRIekFpOGVpZTlWNVdnczFKWVplbHRCbjRxWUptYjhGS0d2VDk4NytTVjNo?=
 =?utf-8?B?MWx2dXJrK2dISHJYRkZlT29UZ2VEeFlCbDl5VGZqbHF5WklUQWhRdlo0eGRx?=
 =?utf-8?B?VkQ2amZ4UnB4a0Z3SjRaeGlJN3FWcW14MDhFd0NRSlA1WVZLdmtxcCs0RTlp?=
 =?utf-8?B?YXV5UEJWRWROWUxDcDdoeTFnYTJWZUdSdW5JWURPR2ZoRkszREMvMG5zK1VI?=
 =?utf-8?B?MndIc2JmVXpXT3hNU3lQZ3RyREhBSGJ1YlN4cHNucnptRzhEREN4aUw2aHFz?=
 =?utf-8?B?OG1xUHk0SzlqSzdoNytsUklQdnoxZjk0akJ3bldpWXdYcHBWeDNYd1BRNlh6?=
 =?utf-8?B?eWlRYVZjelRtN2JkRWJQeVh1S01ya0pMYU1aUHExVVRFaWc9PQ==?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?eEJSZGFERVVHMEk0WXp5Sk9XL3U0V3hNYjM0eEczNGFjb1FnVnNHRHFjSjIw?=
 =?utf-8?B?MkJiMnJRSTRpTjdxSmRoQjBObThBSEcxVmx5eVQxVklrcDlmeFpiZTB1SVJG?=
 =?utf-8?B?TFJHQ2MxSFNZam9xYng0SUgwTXhrbE1zam9KaXd2TnFJTFM4Mm9MUXVlMlBS?=
 =?utf-8?B?WFNId2tJNE50UDg3UlpCT2lkcVJNeGpHa25ScjRBZnluaEhrQXRvQUlZQm9C?=
 =?utf-8?B?UktwZEwrdHdOai9xb3orQlVMdjFVTHhvWDNKR2xQMmJVUDZVdVUvZFg4VTkr?=
 =?utf-8?B?cEh5SWp0U2lrUTdFM3RIajQwSlhISTdoQVRwRFNKWlBSQWFTLzZLKzBNcmc3?=
 =?utf-8?B?cERvcnVuU0tiUkhRQ3ZDTXZ6cjZpWVBmakxPSVFNeDNtTjYrUGVGS3psWVdP?=
 =?utf-8?B?elpyZUpiYURwNnRRVkVQQlEzQ085S0hIUnhxWk1XS3dPM05ub0VEdUZFbkJB?=
 =?utf-8?B?STBEenZqRkYrdzIrOVhvaVQwZHk5RDBQTDVkdTJ6cnZRQjJHWndPQWR2K2M5?=
 =?utf-8?B?TWp5VXdFRlBKei81VXhxeUJ5bDduRkljV2NlR0NZLzI4YW1TWFVBRWJuV2Na?=
 =?utf-8?B?RVk5NHV2aDd5THU3MVNKZDBnSGpJTXkwYS9yNUFOL1Z6a3J1NFMvQzdCbGdn?=
 =?utf-8?B?ZjdBRndNbVhoTW1WdWVFZ0RLQVYxbU83MHh6eDRDelJ5aTVrdkx0OHBhMDJ5?=
 =?utf-8?B?VVhLRnlhSFh3bDZxZzg1YVlwOFFVZEE2c215RElHSENQRmtNT3dZcVg0UTBW?=
 =?utf-8?B?WFEzUldHdVgyR0hWVGhwWWJuK2F5T1VjTG5sSW81NXoyUDFsdGp0WmRaL2JV?=
 =?utf-8?B?RVA4VWpLaTBMWVNldkJwbmEzTUZzVjhyUktxVUNtNi9JZzd1WTBHSUlrcVBh?=
 =?utf-8?B?aDR5Sk53NjYvMnMvOFgzYitOcTRmb0Z4U0NBMVZyUDNKVTRnNnE4d2huaGs5?=
 =?utf-8?B?UjhMTExsVkJGK29abkVvYVdSODB4ekNkaUV6d1RVWTkxZXFORitlL3o0ZUpB?=
 =?utf-8?B?bVlOT3Brc0xrMThoRHZ1bnM5cHoxUjI4UVdNOFhJZGVHd0cxd2JmWVV4UlNT?=
 =?utf-8?B?dnhCam04Z203eEJ4MUVLKzBDdGFrWU9VZUVkOVBRengxOGxydVRNV1pxS2ty?=
 =?utf-8?B?c2FkWkhqdVF2S2hoUjFHYXlERStGdmxNOHI0dEtLOUJOcExYWkFaTEJudXRU?=
 =?utf-8?B?eDhaRmFZNE14SkNnU0t3aDJvVzZoR1R0NnpqZVJEOEpUUFJ6QklncmdSMkVw?=
 =?utf-8?B?anZzMkhmeTZnRHlwLzhxZ05qU0xtcDdGNm5mOGJQOXUzUGZKdXBhZkdlT3Ew?=
 =?utf-8?B?ZHZHdVc4KzYxTmJKeVJDK2lVVjlVeHpFdTJiT2k4MElzYzhWbWR4QVJCeW02?=
 =?utf-8?B?cERhTkRkY0RHZitKdzhOb1dwMFNPblRtN1Z0RUx5amdrNHFJN0xrWmQ2ZnVN?=
 =?utf-8?B?Y3IzYUkrSXl5Lzh0TUpMcHhXcTFsS29SYUJVdlFZazk2aGNEODJZV0dtYVpa?=
 =?utf-8?B?bVVERDhUZ3U1MnhidmNGZ052TUlMZGU2VHAyYkN1U0RTUHdzTGs1bkMvUWdj?=
 =?utf-8?B?ZGk4eXVUMHFqTHpFTUdEbnR1Z2hwbzV1a3VhVUQ0Mkt3Z1JUdk9SeVQvVExj?=
 =?utf-8?B?S2pna3JmbDAxWmJlZ1hHYjJWYkxnVXByanp1Y2J6TE53OHhVdjI1NWx0Mi9O?=
 =?utf-8?B?aTVyeEVuTnBvNGZQVUdvdWZHYnFoVFRCSDJiWE12N21MMXdhZ0JudnhEYUg5?=
 =?utf-8?B?cjh6MHk0T3pIWC82ZXBZRVdvOEx5SkFLZFNiS1U0eWlKaUFwZ2J3bzNVVnZi?=
 =?utf-8?B?RlpNSGRkVHhkbjlWZVR6QjhBb01nMzJteHlLTzRXTU5sa2V4Q2NJejNrUy9o?=
 =?utf-8?B?L25nV0llOWpEMTlVQXVRNUhCOWdaenp5emFNS2ozSEI0dGxLM2NFbGtQRVJl?=
 =?utf-8?B?NnpaYllxaGhRY3R3ZXpKOCtYSlg0S0w1R1pPUWhaVE9zbTh2VjlKN0tnblNN?=
 =?utf-8?B?RDNvY01NbTZ4RjY0TFFlUEdNZisydXJVN3BpL1l3NXUzYkxGZ0V2L2RFV3Qr?=
 =?utf-8?B?N1ppK3c0VTljU1BicGJMK0IzNkt0ei81MjVhMExxSGtRZFNYTjVjcG9jajdW?=
 =?utf-8?B?cEZWNldtSWhVNDJZaHgxREs2WXNSeWFpbm5NeGttN2dYVmxVTyt2YnB3dDZZ?=
 =?utf-8?B?UXMrR3U5V29rclB4aTl1YzNwaGx4ZE5xU2JKVUNZZCtkQlhOT1RVL00yRjRa?=
 =?utf-8?B?ZW1jY2JaZCtkRVowM2I4RGE1WHJnPT0=?=
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: ff32d786-5acc-40aa-56f3-08dca7bfcb33
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2024 06:55:36.9350
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U3mIL+fjbR1qaQ+abu42WctkG45EW9bT8TMw94K28g/sPKjY4BZYVG+bswRLUX8CSDjhxfevz/hIL5fdet4W4snx19omOCUvMPu6o8Skjcs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB7103
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <A3347CA54FE13D489A2D36E457556CC1@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 19 Jul 2024 11:31:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16594

T24gVGh1LCAyMDI0LTA3LTE4IGF0IDE2OjI3ICswNTMwLCBzcmludXZhc2FuLmFAc2llbWVucy5j
b20gd3JvdGU6DQo+IEZyb206IFNyaW51dmFzYW4gQSA8c3JpbnV2YXNhbi5hQHNpZW1lbnMuY29t
Pg0KPiANCj4gRm9yIGFsbCB0aGUgVUVGSSBiYXNlZCBic3BzIHdlIHVzZWQgYm9vdGxvYWRlciBh
cyBlZmkgYm9vdGd1YXJkLCB0aGlzDQo+IGxpbnV4LmVmaSBjb250YWlucyBuZWNlc3NhcnkgYm9v
dCBmaWxlcyB0byBib290IHRoZSBzeXN0ZW0sIGhlbmNlDQo+IHJlbW92ZQ0KPiB0aGUgYm9vdCBj
b250ZW50IGZyb20gc3F1YXNoIHJvb3QgZmlsZXN5c3RlbS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6
IFNyaW51dmFzYW4gQSA8c3JpbnV2YXNhbi5hQHNpZW1lbnMuY29tPg0KPiAtLS0NCj4gwqBjbGFz
c2VzL3NxdWFzaGZzLmJiY2xhc3MgfCAyICstDQo+IMKgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0
aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvY2xhc3Nlcy9zcXVhc2hm
cy5iYmNsYXNzIGIvY2xhc3Nlcy9zcXVhc2hmcy5iYmNsYXNzDQo+IGluZGV4IGIzOWJlMGMuLmY5
YzdiZjQgMTAwNjQ0DQo+IC0tLSBhL2NsYXNzZXMvc3F1YXNoZnMuYmJjbGFzcw0KPiArKysgYi9j
bGFzc2VzL3NxdWFzaGZzLmJiY2xhc3MNCj4gQEAgLTIyLDcgKzIyLDcgQEAgZGVmIGdldF9mcmVl
X21lbSgpOg0KPiDCoA0KPiDCoElNQUdFUl9JTlNUQUxMOnNxdWFzaGZzICs9ICJzcXVhc2hmcy10
b29scyINCj4gwqANCj4gLVNRVUFTSEZTX0VYQ0xVREVfRElSUyA/PSAiIg0KPiArU1FVQVNIRlNf
RVhDTFVERV9ESVJTID89ICJib290Ig0KDQpIaSwgd2UgYWxzbyBuZWVkIHRvIGV4Y2x1ZGUgL3Zh
ciAoYnV0IG9ubHkgZnJvbSBib29rd29ybSBvbikuDQpCdXQgd2UgbmVlZCB0byBlbnN1cmUgdGhh
dCBvbmx5IGV2ZXJ5dGhpbmcgYmVsb3cgL3ZhciBvciAvYm9vdCBpcw0KcmVtb3ZlZCwgYnV0IG5v
dCB0aGUgbW91bnRwb2ludCBpdHNlbGYuIEluIGNhc2Ugb2Ygd2ljLCB0aGUgc3ludGF4IGlzDQo8
ZGlyPiByZXNwLiA8ZGlyPi8uIEkgaG9wZSB0aGlzIGlzIHN1cHBvcnRlZCBieSBzcXVhc2hmcyBh
cyB3ZWxsLg0KDQpGZWxpeA0KDQo+IMKgU1FVQVNIRlNfQ09OVEVOVCA/PSAiJHtQUF9ST09URlN9
Ig0KPiDCoFNRVUFTSEZTX0NSRUFUSU9OX0FSR1MgPz0gIiINCj4gwqANCg0KLS0gDQpTaWVtZW5z
IEFHLCBUZWNobm9sb2d5DQpMaW51eCBFeHBlcnQgQ2VudGVyDQoNCg0K

