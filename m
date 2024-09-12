Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC3CAEEB561
	for <webhook@archiver.kernel.org>; Thu, 12 Sep 2024 08:19:50 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.60])
 by mx.groups.io with SMTP id smtpd.web10.43146.1726129120518589480
 for <cip-dev@lists.cip-project.org>;
 Thu, 12 Sep 2024 01:18:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=ctEQ7OFW;
 spf=pass (domain: siemens.com, ip: 40.107.20.60, mailfrom: felix.moessbauer@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x+6R0tb1GpDC00Q+jbPlmfZpOH5t3b82zFzWns39SKyXr3fSTbExsfZblz+UXR3WEHcU51OAhFTfJpgvUarAqBHgyl+6f/DdYZt3luDehDblGZXiim5jeBXnGYSrqND4wsPLOtdLPg2ukmlwKbdOKnNOWasHociGuK3cbgfrOMLY+ysgjyqsC0eJ11PujzuobIGjgZUacvDLyLzJwDrnV+Uyw5y433tiRBDQXEUwcCuhSEDrHK8xXWsZ0zlHC0PuYdJOV1USr0lIREa/ZQu4q3tZSjAw6AFiH2/EXGfFqB7+92H8iOBkaIEZeMjK0HekW/YvMAL3lYUeoIVnc/HvMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WaEzXSaZ76sc9UbX0M2+tuR83IdaHcvjU9mHNIu5osY=;
 b=cbG4/zMgsE0UkPhWF95MiDwFyOsBVXJjT+Vc4DtkKoo01klz89V/IQ7O5ivr9FSZhDoCy8ns7SLd6EmaaBNxW2Wut6UqCWxt1YyuLRgIUqgmfd42Mm1aytd5OEn9SNp/k3pu4QyKcazsuloNniYdNybb30jsqFoWmvxr6NH+YHqe+OCXUJ3qnwUlqjpyeVUl5baZ93/MnKl9BcoPw/Ngsr1NAyHxWXIbNZhj6tIbxZBAUnBcWGmp3CEdH0gL9d5PIbl8TVUXXfsLeBp9Qn/GziIIlc6HVxcF7o1Lo89MoySrsiLSBgLke63GVPDSqSjkMA92XpZ6XyrvN+MaYgPiLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WaEzXSaZ76sc9UbX0M2+tuR83IdaHcvjU9mHNIu5osY=;
 b=ctEQ7OFWaWg7ILpVWEwB2mhtOcJ3jjLSSgCBDtiv18kXP5BAD8g8cvbefoUgUQR79882tamZcXoqJ/k7AV8pQ34JkyxDnyk2Ectwmw6tNZpntXeTPGitlc8GGjdMo5MfdntBYn7eMhSnJ+b8gZc4T2Nvnjy/pwjl30ElOKr+73y/1subj2DJNtaNjIY5JN599XlLBAhin1R2+UqUpydVXVFinPRbrsV4TnElwSvnllyqjD4xx2xVeabL1jD6FJHWj8hljUNCU68o9UWDHhGew1NlP+vfqTzbpO7jYK+ZTFDWG5dA9JLhE7c2HLVdtC7HlQvaqly6pHoYv6/B9K/z1Q==
Received: from DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:47f::13)
 by DB9PR10MB7195.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:453::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.17; Thu, 12 Sep
 2024 08:18:37 +0000
Received: from DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8198:b4e0:8d12:3dfe]) by DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8198:b4e0:8d12:3dfe%4]) with mapi id 15.20.7939.022; Thu, 12 Sep 2024
 08:18:36 +0000
From: "MOESSBAUER, Felix" <felix.moessbauer@siemens.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
CC: "Kiszka, Jan" <jan.kiszka@siemens.com>
Subject: Please enable CONFIG_PID_NS in cip-kernel-config
Thread-Topic: Please enable CONFIG_PID_NS in cip-kernel-config
Thread-Index: AQHbBOxdcFD+QVcV1EesYa0Z2ph9jg==
Date: Thu, 12 Sep 2024 08:18:36 +0000
Message-ID: <d2aba9628d363afe28efc0ffcb6596c4fa0eed33.camel@siemens.com>
Accept-Language: de-DE, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.46.4-2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR10MB6828:EE_|DB9PR10MB7195:EE_
x-ms-office365-filtering-correlation-id: 6f0907fe-fdb2-4718-01fd-08dcd3038030
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?VDVWK21zRzJ5REw2L0w4VVA0d1lXeEIvak1JWHlwbzJHMkVTVDViMC9lTWdX?=
 =?utf-8?B?cG9OL2VJVzZxUnJiNGFKMk5PSlRvZFRSZGZiRkgzRThvYVlmRG9zclFVWjIw?=
 =?utf-8?B?QmR1RU9aTHNyN08rQ2NIS1MwYTI2QnBmQzZqWFZOTFBZU0xXdzNlOW10a3F6?=
 =?utf-8?B?TUJDcmswV1dqMkVvVDRCVEZYdVRKcjBKaEZFbEJwM0I0bFRzR1hDbjFONU85?=
 =?utf-8?B?UFBLVWZtRmdheldtVHFNdC8xZXBOZDBJMzdIUjlXWmt6cUFLcmNNajN2NUxt?=
 =?utf-8?B?MSs0b0xvK29tWVRzL1Y5NzhhcWN0RlZaUlg3MlJxbnBodWRTR09PSUNGcWpQ?=
 =?utf-8?B?eEM2bmpwYzZTbEZDRUdNUjBVU2NMcURjMjNObllQTXRpTitKcnRtRGI5SXlM?=
 =?utf-8?B?L0VjNk9ablZuQ3l0aStaRy9lTnRpbmdEREJEODdiUUV1ZklHRFhhcFdORTBD?=
 =?utf-8?B?cDJ3L3JpRDVmTFBXdC9jdC90SlVvYzV5d3RRcWJtMVlYQkdHcHRRcTRMenNm?=
 =?utf-8?B?L2NCdnNCSmprS1c0RGpHOHRnQlNYNjh5OWFzQ3F3UDYxanp1UVNYQ2VpNEFz?=
 =?utf-8?B?bzN6Z3VKZHhkaGJibmhlYUplQklvUythVy81OE5WbExEVm1QMVdtNHF2cEpi?=
 =?utf-8?B?QlBVdndxTGlPdUlNTXc5QVFlTkpYSkZDbEhpRzdCV2RseHFaSk5rd2tjU05V?=
 =?utf-8?B?Z2tkaUZ1dVhzTEpZYTd6b0UxaFg4d2pMWFM3UHhMUTNIYld1MUtZdXlzZm9u?=
 =?utf-8?B?RkRlbmxHMUxzMkJyL2FUN2hrTHQ5T0FYU1pHSmMwSHFiM0djUWV1YUhWTkxC?=
 =?utf-8?B?U3RsczF0YkcxUFVYZ1BuSDBXTnluNGhlR2JBNTk2bDRCUWxaMkE0NWllYytv?=
 =?utf-8?B?Wm93eUlreWpRVHErT1E1TTA5THhmL0ZEbERReXpDa2RmZVhlODcwWGdzSXBB?=
 =?utf-8?B?d0lzN1QrdTdmcEF5a1dIWUNJL1VUOXhNUUtLMU5WU0Fxd2Y4a0k0NFUyVncw?=
 =?utf-8?B?QUJ2ckVlRDJrc3hiZU1DNHZOS0JnWTZxdzFsSWNIcVVZL3R2MDI1SzVaTExL?=
 =?utf-8?B?elNHd1RRNkg4OXFkL0IweTk0WWdYR3o2L01uQTFkMHh2TlVUU0ptMUhDSDcv?=
 =?utf-8?B?cnduOXhVb2FRYUJaN0piSGRLRE5tSnNVVFRXalI0MTl6ZXh0ajIxbVptUjI0?=
 =?utf-8?B?akRsRjFNOTNzOVlZVVFKbWMzOGFqdG9qNnYwbWllY1dta2kzMU52azl6VlV5?=
 =?utf-8?B?bVpiMzA4VG4yOTJJQkxvY2ZqTWI1bjFEMWx0MTR1cFdDVTdqbW5LeVV4RDV6?=
 =?utf-8?B?K2Q5TFpqeVdWVy9qOVVIV2Q4TmhncUdaUHRGbzIrQ0ZZUGRkOHBhMlRYL3M1?=
 =?utf-8?B?MWNWQWhiTGthdmNFWHJGQjFqdk5iZGtTc3krWkc0Sjd5ZzlOSkxmTWViZlcr?=
 =?utf-8?B?YnozUGN5OUpKa3hTTmNIQmZVT2lncktFaThPTEFmRDN6L3plNjFkdEc0ak16?=
 =?utf-8?B?VHpXU0p1ZWl5MlIrcjA3NjJSejlPQXVMR0grVWgrc3ErazJjbmxOcEQvTUxk?=
 =?utf-8?B?OElIWlZVNVB4bTZNTmNtY0ROd28wbnRjMThGUmozTVlPdHZibTMzMTEwbytL?=
 =?utf-8?B?Si9SN1pGZFA5R1VMR0kwNTlPbkt5UU5BYlJtUGQ4VjVQUTdqaWQ3SmIwN1k0?=
 =?utf-8?B?Y2ZaWWRtbks1UXQ5Qk41Q2RmRy9FQlo5QXhxdTdYeDFRd3hubkJicGZYaDc1?=
 =?utf-8?B?SnRMTVpyRE9KbEpSZmhKWTFQV1BuaEVzeEFtTlVhR054Q05qU0ZFZThkZG00?=
 =?utf-8?B?SHZwOEpRZEtpTjVQdGZWd054ekdxZUxVcnNQRmdVYWdkYURSZEhXVHNJbkVS?=
 =?utf-8?B?dkpjZ2ZLM2RPdzZrMWxwV0JydWVLK2dRUEh2OU9DdDM1M2c9PQ==?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?bkYvN3J0TXBObzRvamJYd2U4ajc5LzNabzB4NU13NnBHYnFMMVBEMVlLbWt5?=
 =?utf-8?B?YmtvVkIwRmUvOXdTNWFpNlhMWGZtL0t4RWY4Sjg0NkVTV29Da2tWS0xPVFI3?=
 =?utf-8?B?azFSOE42ci9XWFBOaDF5WnIvcVBVd2RMYktRbUc5SysrM3NjbGxNNk5IdWZy?=
 =?utf-8?B?UzdYblppcWpRU3ZOWURxbTg3U3BPMFE3QWFENDY0Q0lTRFJaWXdFQ3hFSm5j?=
 =?utf-8?B?ZHp4ZTZ2Qklvd3VTSFVEMlFIL0ZXa09rSnJCZWtuRTgvYksvWGZOQ3U1djE1?=
 =?utf-8?B?UXM4REZnQThpTndSUC81L2lJcmZBSExETUJwc0x1NU1xaU84a2ZRbm0wT0hO?=
 =?utf-8?B?YmpxNCtFdm9nYlZQdmNMVFErNHVDMUpucjNyVTVyOTVYbnB6eHZpR2gxVDZD?=
 =?utf-8?B?QU1ObEVyVVU3dzNldHFjY3BqZG9HdFR2OWNFenh0NTJGWUtEa2p1VEVqRGE4?=
 =?utf-8?B?QWZ6citTbTJTZS9zNGVCRDFXdHNaWk4wYWhod0FScm9BNkROUjFGZ2Y1bkJN?=
 =?utf-8?B?ay9rT2JtbmNla2VSejFPd1pVdnQ0a21yNXovRHk1bmJ0dS82RWttYk9KK2x4?=
 =?utf-8?B?UXpCNTNsbzJFeVFSdC9nbXVDdFZ4eldycitvem1NV3V4NGRUcDFwQStCMlF5?=
 =?utf-8?B?UVFLdTMrUmU5MTdQelNYS2dSWWExT3JCOHAwak4wWGlYdVA0eVJwaDdmRGI5?=
 =?utf-8?B?VFEyWUhua05wOFFhOGFKczZ6ZWhOYUE3OVFuUWpsRkZ0bk5CUGxoUjU2RVM5?=
 =?utf-8?B?aHdhNTlMdG03WS9TTm5CS2xNZy9kSy9qcXNKSWRtaWFFMytmT21WNzhrdHBh?=
 =?utf-8?B?M3VIOXF3RGdiV3YzSllUUlFEUmpXVjMwWXBzc2lLYXE5d0ptWDFwTXE2Sjhr?=
 =?utf-8?B?V1B5NERVUVhJcW9mdFNERUJmVE9URHhtUU4ybFUyTmVYY2VkOHZid2tacWdw?=
 =?utf-8?B?VFpnUXFrdG5PREM4ZjNHZlRKd2NyYzliV01ONFF3N2llWnJFSEsrTmJlcTRq?=
 =?utf-8?B?cjdsZE4vOVBQQThPdURCOEFYb1dIWkJWalFzdFI5M0pieGI0VUxjVmE3cTdP?=
 =?utf-8?B?cXZWaVpuNHZKSU5FRjlsclVRWS81aU5MZDV1RnFvOUoyaDhlQnJmNHF4SkR4?=
 =?utf-8?B?eFg1clFRb2RhQldzM2k2cnk2ZWlUTGRKVFRPNk1nOWtpRUlWd0RXQkljaCtD?=
 =?utf-8?B?MWIxT3dKQk1tbU5mL2drSFYwdWxUaDBHUTdrSlNXSFlnS3BtVGhFRGRybTN5?=
 =?utf-8?B?UUNWQldBTEFabTdqRkNyNWJwbzBabGJXUG9zdGZ0djlLaXphN3lIMGxuRS9h?=
 =?utf-8?B?aHhkSVpQeFJRSHZBQ29Rdk9CbUoyUkNybkM5TkV3cDd3S3ZOdmlqWm1sVS8z?=
 =?utf-8?B?RWZlVVUvSjVjdVNyTzd5RHR0ZUlDTnVzOHZZSDdrekR3U1I3akk5ejVZand3?=
 =?utf-8?B?MVJuSHZaNTRQTVd6b3h6SEFDUzlqN0lhSkhDK3VFL2FoamZPRkhrUlJPSEQ2?=
 =?utf-8?B?MGI3U2RTMG1GSXl0U1ZGdU5wclZZdlZFWW1PL3NVS0p5U0dPNm5YS2xtWHhV?=
 =?utf-8?B?VjUxZU00M0xUZ3l6MnY1RkJNaWd4SDVTMGJNTGN3M2ppNm53R1U0bGphWnY3?=
 =?utf-8?B?TGVUOVRxMHNJbUdCaURTUlppWkYyUVNyUDNpU1pLK1F2cmptb1Vac2VMdWkw?=
 =?utf-8?B?RENiR083STgxaDV6ZjdSN2pLelRMZ2VCUGdNc2lGbzdxNTdBZmp1QUs3aFRG?=
 =?utf-8?B?UDVxS2ozaXg4S2tHak0xV0hFOVlCdzc1N3I0TVpHejEwZUVQaEtsdHM0MFpF?=
 =?utf-8?B?ZHZxdWd3S2d6dDloSFJYV1V3L0NTd25uSjVpZzZIMzdJSXc1ajhwSzFLNEdO?=
 =?utf-8?B?VTI5Vy8vbEpzYWhqSDYrcElyOWhQRi8xb2lkTENwbFZVSU9wWFJhaEhOejhR?=
 =?utf-8?B?MWU5a1lyWVdEd1dHczJaZzRFRlJqNTFld0ExdHhkR2ViZDhmTVR1aXJadlZp?=
 =?utf-8?B?QkJLM1o4Q0dnNlVzRmE1eUNka3RMaU9nOW0ycnY2cHZDaXNSSEN6VlI5a2NY?=
 =?utf-8?B?VFlubU5uNnRtOXgxbkU2RUZ1dnBFY1VBYU1UajdrTDRjK3BrMVF3ejdEdjhE?=
 =?utf-8?B?OWtsc3FDMEo2L1Z6OGlQTFhzWm5hYkdqSkx1OHp6TVdPVHJWZFFWdmRraXBn?=
 =?utf-8?B?KzZBMkhaMTJOMW5oWWZZUkVMdlZoUHIyR095STRhN0pTY2RTRWlibU1PRHVm?=
 =?utf-8?Q?37U8q21SuRhY7w3Y10+3sM9IgvwjoR/CnMCc47DunQ=3D?=
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f0907fe-fdb2-4718-01fd-08dcd3038030
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2024 08:18:36.8439
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /PIHZJAHrxUaWnseP925Arg2QrORzI2hZ6ylQa3gyv7EqfARfJt4Rb4weHdo94s9WAYUuIakNNGbENvRNOj9Tg2lvzHN6LCNBgMWGvEwj68=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB7195
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <9A0DA382ACF80D41AD53287771439650@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 12 Sep 2024 08:19:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16886

SGksDQoNCnJ1bm5pbmcgY29udGFpbmVyIHdvcmtsb2FkcyBpcyBxdWl0ZSBjb21tb24gdGhlc2Ug
ZGF5cy4NClRvIGFsbG93IHJvb3RsZXNzIGNvbnRhaW5lcnMsIHRoZSBDT05GSUdfUElEX05TIG5l
ZWRzIHRvIGJlIGVuYWJsZWQuDQoNCldvdWxkIGl0IGJlIGFjY2VwdGVkIHRvIHNldCBDT05GSUdf
UElEX05TPXkgZm9yIGFsbCBrZXJuZWwgY29uZmlncyBmcm9tDQo+PTYuMSBvbj8NCg0KQmVzdCBy
ZWdhcmRzLA0KRmVsaXggTW9lc3NiYXVlcg0KDQotLSANClNpZW1lbnMgQUcsIFRlY2hub2xvZ3kN
CkxpbnV4IEV4cGVydCBDZW50ZXINCg0KDQo=

