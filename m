Return-Path: <adithya.balakumar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85B98C54E58
	for <webhook@archiver.kernel.org>; Mon, 18 Mar 2024 05:03:02 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.132])
 by mx.groups.io with SMTP id smtpd.web11.36010.1710738172751919245
 for <cip-dev@lists.cip-project.org>;
 Sun, 17 Mar 2024 22:02:53 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.132, mailfrom: adithya.balakumar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1121) id 42I52oM3090506; Mon, 18 Mar 2024 14:02:51 +0900
X-Iguazu-Qid: 2rWg6j0N7jqp1aj7tW
X-Iguazu-QSIG: v=2; s=0; t=1710738170; q=2rWg6j0N7jqp1aj7tW; m=ayyE5OZkqXvuISfI11Z6e+MuH2QOwbIVJEUWAuD0ATw=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1120) id 42I52m2W1683538
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 18 Mar 2024 14:02:49 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QHQW1Aia/GMbz/kvl0HyKMASUH900Z5yxlk0GFczip8l2Ky92noZXQSDgbvyOoWiAWYu9r2Yy5Uo2Esf6g9zhmknLguNi1tYiCm7VeGswXa2L1JDVHKY7Qakm9x4jbGleg8dLAUKbeQ7R78CTzPov3jmBvr+6GI+Mkxs8L0MbiMtlUBLkLPTAI/UZVbz5nWaAMMdKUfVPkRYFWFrihQnBrXfZHBz9p3/SFH95SWKtsuEChOjCu+V12uEzlEEOjEzyYNhQSTJXpFwNCV4OWWRUAk05bveY3SL7ievtDu8dvEUODFOT3hBguQtotU95UuP2XVdYBtEJ8+fdS/16ULtUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MPthRnugzHGOdpdAq1+3+2IS8QLuCYpo26zdusTGI68=;
 b=kIT7gtd58ijMKjzzEdbm1FIJb5wLD6UUtha0NKeNXDgvBfsRo5zzfWgG9vakO4r2UxePJpb+DvPmYNZnWutROMthgrvu2upJTb6r1f/DLLFUPwQFzVZFYH4Q7NYQpNA0D4qdMaq5FRT2OauDxfPtBvdTomiRDU00F7L2E9m5yvAMrfKUgFMeuNtTr1tEceN/3PAAvRb+Th/YljSIUfOKXnxdNTjULLb4O1ipSG4ivJVTlt15s2A1nV/Wv7ACu7+kcbqQtPb4R/IMTnIiDevV7Ue5Odq3oUqItNq0xCeyc6jawTDoWwg3V9lMdTn6ng39BHVvlDIiVp9nxk6ZMVzO8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Adithya.Balakumar@toshiba-tsip.com>
To: <quirin.gylstorff@siemens.com>, <cip-dev@lists.cip-project.org>
CC: <Shivanand.Kunijadar@toshiba-tsip.com>, <Sai.Sathujoda@toshiba-tsip.com>,
        <dinesh.kumar@toshiba-tsip.com>, <kazuhiro3.hayashi@toshiba.co.jp>
Subject: RE: [cip-dev] [isar-cip-core][RFC v1 1/6] conf: Use bookworm
 backports for enabling delta handler in swupdate
Thread-Topic: [cip-dev] [isar-cip-core][RFC v1 1/6] conf: Use bookworm
 backports for enabling delta handler in swupdate
Thread-Index: AQHacUzFkQ5WWwGJXUKEvpOxu4KD9bE253eAgAYYwgA=
Date: Mon, 18 Mar 2024 05:02:45 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYCPR01MB9669ED46F3B0AB77E7B49B65C42D2@TYCPR01MB9669.jpnprd01.prod.outlook.com>
References: <20240307074612.1996609-1-Adithya.Balakumar@toshiba-tsip.com>
 <20240307074612.1996609-2-Adithya.Balakumar@toshiba-tsip.com>
 <7a8e08bb-0d82-49c2-be8c-03ecb9511304@siemens.com>
 <9924d25c-a95b-4c63-ae89-98076ce75c38@siemens.com>
In-Reply-To: <9924d25c-a95b-4c63-ae89-98076ce75c38@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB9669:EE_|OS7PR01MB12033:EE_
x-ms-office365-filtering-correlation-id: d24f63e5-9b44-4408-b8bc-08dc4708a670
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 UAT83YdIHO7PnEbQstpJXAEtFX1iyryTaGtiou6I6WYE8m5nbulpQd9NEC66Luij3bfq/KDN8B2QEkSH8sCf7CF1VLXM0GK1b7ULwVNZkOyys5uM5oT0W0pZP4AQkvKl+CkRODzd5FV++mRyC1tNJpyz+JdAx/RW/N03Pucs9O1NygMVgVX3FQLCpbaQ4k3OODnXNqFUJthbIH1X3cZR++DgzLgpyEsMstl8gpK7zRfBf4Ajwly4hitF7l2RpL/4/DqTx3O0sKeTPzGp5kkMZcNUj+vXfCLQhL3qib0KSwbvQaTk0ymfw5C+pKIe9WlZF3iB7GdLrjOypP//esZXSaYR9ovgNGWQMfXWcUP/Wgm6XNqDmIkxD6ZHgC02WwaiXl5Kptb/blNNnJfNTDAr8MAw6mZVOYy0LuhwJgzYUX8TDbaf4O5AYWszWDayIQNNodOIKJ6VJCCHPiAfOWB7qKP35+ZVA3nx9TtfNPuDGJVDBsSbhAxJUuBKUqyntlAdfR1FO4DoXBxdONG6LAZ1jro4S7MSOXECn3P4hommdopfxluKyD4vpDdPFRe6S9hp+PsdWyWY638WzB9A3W9vXe1Ysw8m5oFkcvSpohIDgMlqZGoy537eVvG660OrY7HlzAwucmOzkqdxMAu6gMAN5Y8wN/YvnyEtyHanymx9tEI=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB9669.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?cU55cDVDSjNBT2FYT2VrT3libW14TEZLc2VVY2NOdUJRajdqajZxSU1sb2l3?=
 =?utf-8?B?cWcxSmw5Q0tIbjROTnRzY3lrOEYzcmdYUGU5QnpuQ2JqT1lGandMU1ltREF4?=
 =?utf-8?B?TGpFTDE4OW1NelgzaEtyMVl1RDBQRTk3WXVaMkhDczNNOUxCdkJoS0VvV3FJ?=
 =?utf-8?B?VGRrUGpqVFNlQ3VmMjhLUXNDWUtaRFlLa2xuR0R1T2J1YXpFVVVvNkZhNm8w?=
 =?utf-8?B?K1JNSUdhQVVHYjA3U0FnVjFad1VtTXFGQ0E0MWNDbzBYdGpOTkl3Z3VaVTkv?=
 =?utf-8?B?bGk2RmF0ZlBEcFJOK0UvT3lxbEM3czdWTnZFUmtzZ0RpTmZPYkNyMUs3OG1o?=
 =?utf-8?B?MXNWdGZqK1p2SWRCTjJidXpDZ1lLOENuVldDakZPY3hHY0NnREJrSFd4enJS?=
 =?utf-8?B?RUdMYXdkQTZHTDRKamczS3k0ODRHeUZRMlBMeEFtMEpKRC9DUEk0clVHWXFK?=
 =?utf-8?B?YXUrK214QnlmdkpFVWY5bWNNNkNIZm00T2dGRUswd0ZUY2xLcTZwdVdaN2sz?=
 =?utf-8?B?enRySUpCSDNac1FmV2VKSGc0YWJwaDZIdVBvTjljc3h5OXl6bzU5TldVdzZY?=
 =?utf-8?B?aHljb0o1ZVVLeXBLL0dxWFRtdWtoWHJob0NFTVdXUk5XZm9IL1g0b3BiQnF0?=
 =?utf-8?B?bzFNRlJiTWwvNjd0Zm5nWnR3M0VSOUt3NVpUdExIaEJSWVZjKzgxYUo2azVQ?=
 =?utf-8?B?d2FzbmNWYWE0aDhVWjRjYVRrSkxmNFFncm5pYlc3NEs2UXBWRU92OTh6ZUwz?=
 =?utf-8?B?cXJ5cGNrZnJHOHdlSTh0QjJSbkhlOE1ESHZIbnJkYUwrdTVqSzM1MFVCR0wy?=
 =?utf-8?B?Z3lSbXhib09oeVo4a3llWFZMNklxMldvcHpFMWdZcHhsMms2UFMrM2o2Ykt4?=
 =?utf-8?B?TDNnbGdkVzdoc0diSDVjTW5iKzBFbUYzUkdhT2V5clZzS0oxRGpIaTJRbE5p?=
 =?utf-8?B?SlUrT1YwaFpTR3ZtR05mRk1nRld5WjFSbW5sc2dnMkVLSi9NUGoxSUdNalNv?=
 =?utf-8?B?ekxsbk5MWEM2dE43b1hTOHlSZis2OXhTMDA3UldRcXZXUjhQL0UvT0pYV1k2?=
 =?utf-8?B?TDQrUmZSRTIyTWMyaTY5eGtVYWJzc24raGI0c1VwQzlsWU5LZWNmQ1NFbHBl?=
 =?utf-8?B?ZEtKTlNMVDY5NFY5VXZnY1U4U2ZjRFFHdURWS3gwWlVWRm5XK3lEWmY3V0d4?=
 =?utf-8?B?cStreVMvckNuUkRsQVh1Z3M1RGs5K2g5bmc1NzU2dlpLR1cyRm9nRFF5ZHB2?=
 =?utf-8?B?SnJMRzIvTStzK1hiVWxUTzM5UTRYb2tJNGpLR2g5LzdRQkdFRm1VTEtMbHFv?=
 =?utf-8?B?UG9qN2hOdXhtUWFmekRndXRMUGIzb0R1MlpGaVlaSXJYOUV4eWwzRG8zNFZj?=
 =?utf-8?B?bDlhUDFKOC9iMTFZSjM0eXhLK2xBNmF0YXVzQmhtaFgxYkFMa0NiVEI1ZFhT?=
 =?utf-8?B?aU5UR1QzVEpXSkFmWENIUEhOSStibndiRWVkSEN4RENORzZXZHZKMTE5elR2?=
 =?utf-8?B?aElheUprbUpjZ1AwYVdINEFaOTk2SFZiZkpxY0sxV3hJeCtIZEJZRFpkL3lV?=
 =?utf-8?B?QXhjVVEwMHZXTkZIV240ODdhZ05EUWFLU1pRVFNTK1FsRTdBYk8xQUVuSk5F?=
 =?utf-8?B?QWJidng3UjNubGFCaWZNK2dkTVJUSmV2TG51YnpBcVZ0WE9rc2FPWXNsdG9i?=
 =?utf-8?B?bnZNallvVUpqclc3VWJIUTRHRGxjSE5kWnJQSFFTZjhhTDBqR0hzVTRCbkVx?=
 =?utf-8?B?ZUNBUy80RWFtenZaQkQvQVA3MExZNUcxQzArNjBXTjJleFZHR2k3ZlVLOUJM?=
 =?utf-8?B?bk1VZzVKZUJXSklPRW9wZkloOFg2RTFNTzI1WjNPZ1B0UnF6a0RQWVlCdWNS?=
 =?utf-8?B?TWV5aDNlWGpCK3E1c3FSeW5FSDEwVTY5VSthNGYyU0w5T2FUOVY5WkVmbGFZ?=
 =?utf-8?B?VXhxWE9GdWNDOTZ4SWc5amF4S1RWTkhhYWM1eGtWUzJvenhMVXF1bjFrbEV5?=
 =?utf-8?B?Qit6NUxyL1JTdmZRTFN5OWxZMmlEb3Bwd1IzTGhOMWFrU05sSUhwdVJ4Szg5?=
 =?utf-8?B?UjYzb094N1I4UTFBTmlPbVBTaC9pZHUzSXhEQm9NLzUwTFpqNmEycWEvaWN3?=
 =?utf-8?B?SW5uTEpOKzdSWGs4dlRZYTJnUTNSVlJ6eWZpYWZKakNMa0h0cEQ0SmNBVjNS?=
 =?utf-8?B?ckE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB9669.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d24f63e5-9b44-4408-b8bc-08dc4708a670
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2024 05:02:45.6905
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sOmgFOQ7jgU7SnfPPMOte2iP1X0ZNvZPMVHZn893mxM33Lhrh3162otRyTMWBrbeUa+l6o/7N2zBam4axUQbgDrL7QMU7zbiZ5L+tsPUXT2ZfyLZQuHdAvhHtKzASF6f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB12033
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 18 Mar 2024 05:03:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15335

DQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBHeWxzdG9yZmYgUXVpcmluIDxx
dWlyaW4uZ3lsc3RvcmZmQHNpZW1lbnMuY29tPiANClNlbnQ6IFRodXJzZGF5LCBNYXJjaCAxNCwg
MjAyNCAxOjI2IFBNDQpUbzogY2lwLWRldkBsaXN0cy5jaXAtcHJvamVjdC5vcmc7IGJhbGFrdW1h
ciBhZGl0aHlhKO+8tO+8s++8qe+8sCBURVVSKSA8QWRpdGh5YS5CYWxha3VtYXJAdG9zaGliYS10
c2lwLmNvbT4NCkNjOiBrdW5pamFkYXIgc2hpdmFuYW5kKO+8tO+8s++8qe+8sCBUTUlFQyBPREcg
UG9ydGluZykgPFNoaXZhbmFuZC5LdW5pamFkYXJAdG9zaGliYS10c2lwLmNvbT47IGFzaHJpdGgg
c2FpKO+8tO+8s++8qe+8sCkgPFNhaS5TYXRodWpvZGFAdG9zaGliYS10c2lwLmNvbT47IGRpbmVz
aCBrdW1hcijvvLTvvLPvvKnvvLAgVE1JRUMgT0RHIFBvcnRpbmcpIDxkaW5lc2gua3VtYXJAdG9z
aGliYS10c2lwLmNvbT47IGhheWFzaGkga2F6dWhpcm8o5p6XIOWSjOWujyDvvKTvvK3vvKUg4peL
77yk77yp77yn4pah77yt77yw77yz4peL77yt77yw77yUKSA8a2F6dWhpcm8zLmhheWFzaGlAdG9z
aGliYS5jby5qcD4NClN1YmplY3Q6IFJlOiBbY2lwLWRldl0gW2lzYXItY2lwLWNvcmVdW1JGQyB2
MSAxLzZdIGNvbmY6IFVzZSBib29rd29ybSBiYWNrcG9ydHMgZm9yIGVuYWJsaW5nIGRlbHRhIGhh
bmRsZXIgaW4gc3d1cGRhdGUNCg0KDQoNCk9uIDMvOC8yNCAxMjozNSBQTSwgSmFuIEtpc3prYSB2
aWEgbGlzdHMuY2lwLXByb2plY3Qub3JnIHdyb3RlOg0KPiBPbiAwNy4wMy4yNCAwODo0NiwgQWRp
dGh5YSBCYWxha3VtYXIgd3JvdGU6DQo+PiBEZWx0YSBoYW5kbGVyIHJlcXVpcmVzIHpjaHVuayA+
IDEuMywgYnV0IHRoZSByZXF1aXJlZCB2ZXJzaW9uIGlzIG9ubHkgDQo+PiBhdmFpbGFibGUgaW4g
Ym9va3dvcm0gYmFja3BvcnRzDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogQWRpdGh5YSBCYWxha3Vt
YXIgPEFkaXRoeWEuQmFsYWt1bWFyQHRvc2hpYmEtdHNpcC5jb20+DQo+PiAtLS0NCj4+ICAgY29u
Zi9kaXN0cm8vY2lwLWNvcmUtYm9va3dvcm0uY29uZiAgICAgICAgICAgICAgICAgICB8ICAzICsr
Kw0KPj4gICBjb25mL2Rpc3Ryby9kZWJpYW4tYm9va3dvcm0tYmFja3BvcnRzLmxpc3QgICAgICAg
ICAgIHwgIDEgKw0KPj4gICAuLi4vcHJlZmVyZW5jZXMuc3d1cGRhdGUtYm9va3dvcm0tYmFja3Bv
cnRzLmNvbmYgICAgIHwgMTIgKysrKysrKysrKysrDQo+PiAgIDMgZmlsZXMgY2hhbmdlZCwgMTYg
aW5zZXJ0aW9ucygrKQ0KPj4gICBjcmVhdGUgbW9kZSAxMDA2NDQgY29uZi9kaXN0cm8vZGViaWFu
LWJvb2t3b3JtLWJhY2twb3J0cy5saXN0DQo+PiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCANCj4+IGNv
bmYvZGlzdHJvL3ByZWZlcmVuY2VzLnN3dXBkYXRlLWJvb2t3b3JtLWJhY2twb3J0cy5jb25mDQo+
Pg0KPj4gZGlmZiAtLWdpdCBhL2NvbmYvZGlzdHJvL2NpcC1jb3JlLWJvb2t3b3JtLmNvbmYgDQo+
PiBiL2NvbmYvZGlzdHJvL2NpcC1jb3JlLWJvb2t3b3JtLmNvbmYNCj4+IGluZGV4IDliY2Y1NTku
LmUwYTRmN2YgMTAwNjQ0DQo+PiAtLS0gYS9jb25mL2Rpc3Ryby9jaXAtY29yZS1ib29rd29ybS5j
b25mDQo+PiArKysgYi9jb25mL2Rpc3Ryby9jaXAtY29yZS1ib29rd29ybS5jb25mDQo+PiBAQCAt
MTIsNiArMTIsOSBAQA0KPj4gICByZXF1aXJlIGNvbmYvZGlzdHJvL2RlYmlhbi1ib29rd29ybS5j
b25mDQo+PiAgIHJlcXVpcmUgY2lwLWNvcmUtY29tbW9uLmluYw0KPj4gICANCj4+ICtESVNUUk9f
QVBUX1NPVVJDRVM6YXBwZW5kOnN3dXBkYXRlID0gIiBjb25mL2Rpc3Ryby9kZWJpYW4tYm9va3dv
cm0tYmFja3BvcnRzLmxpc3QiDQo+PiArRElTVFJPX0FQVF9QUkVGRVJFTkNFUzphcHBlbmQ6c3d1
cGRhdGUgPSAiIGNvbmYvZGlzdHJvL3ByZWZlcmVuY2VzLnN3dXBkYXRlLWJvb2t3b3JtLWJhY2tw
b3J0cy5jb25mIg0KPj4gKw0KPj4gICBQUkVGRVJSRURfVkVSU0lPTl9zd3VwZGF0ZSA/PSAiMjAy
My4wNSUiDQo+PiAgIFBSRUZFUlJFRF9WRVJTSU9OX2xpbnV4LWNpcCA/PSAiNi4xLiUiDQo+PiAg
IFBSRUZFUlJFRF9WRVJTSU9OX2xpbnV4LWNpcC1ydCA/PSAiNi4xLiUiDQo+PiBkaWZmIC0tZ2l0
IGEvY29uZi9kaXN0cm8vZGViaWFuLWJvb2t3b3JtLWJhY2twb3J0cy5saXN0IA0KPj4gYi9jb25m
L2Rpc3Ryby9kZWJpYW4tYm9va3dvcm0tYmFja3BvcnRzLmxpc3QNCj4+IG5ldyBmaWxlIG1vZGUg
MTAwNjQ0DQo+PiBpbmRleCAwMDAwMDAwLi5jNDg3M2I0DQo+PiAtLS0gL2Rldi9udWxsDQo+PiAr
KysgYi9jb25mL2Rpc3Ryby9kZWJpYW4tYm9va3dvcm0tYmFja3BvcnRzLmxpc3QNCj4+IEBAIC0w
LDAgKzEgQEANCj4+ICtkZWIgaHR0cDovL2RlYi5kZWJpYW4ub3JnL2RlYmlhbiBib29rd29ybS1i
YWNrcG9ydHMgbWFpbiBjb250cmliIA0KPj4gK25vbi1mcmVlDQo+PiBkaWZmIC0tZ2l0IGEvY29u
Zi9kaXN0cm8vcHJlZmVyZW5jZXMuc3d1cGRhdGUtYm9va3dvcm0tYmFja3BvcnRzLmNvbmYgDQo+
PiBiL2NvbmYvZGlzdHJvL3ByZWZlcmVuY2VzLnN3dXBkYXRlLWJvb2t3b3JtLWJhY2twb3J0cy5j
b25mDQo+PiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPj4gaW5kZXggMDAwMDAwMC4uYjZlZmZmYw0K
Pj4gLS0tIC9kZXYvbnVsbA0KPj4gKysrIGIvY29uZi9kaXN0cm8vcHJlZmVyZW5jZXMuc3d1cGRh
dGUtYm9va3dvcm0tYmFja3BvcnRzLmNvbmYNCj4+IEBAIC0wLDAgKzEsMTIgQEANCj4+ICtQYWNr
YWdlOiBsaWJ6Y2stZGV2DQo+PiArUGluOiByZWxlYXNlIG49Ym9va3dvcm0tYmFja3BvcnRzDQo+
PiArUGluLVByaW9yaXR5OiA4MDENCj4+ICsNCj4+ICtQYWNrYWdlOiBsaWJ6Y2sxDQo+PiArUGlu
OiByZWxlYXNlIG49Ym9va3dvcm0tYmFja3BvcnRzDQo+PiArUGluLVByaW9yaXR5OiA4MDENCj4+
ICsNCj4+ICtQYWNrYWdlOiB6Y2h1bmsNCj4+ICtQaW46IHJlbGVhc2Ugbj1ib29rd29ybS1iYWNr
cG9ydHMNCj4+ICtQaW4tUHJpb3JpdHk6IDgwMQ0KPj4gKw0KPiANCj4gQmFja3BvcnRzIGFyZSBi
YWQgd2hlbiBpdCBjb21lcyB0byB1c2UgaW4gcHJvZHVjdGlvbiAodGhleSByZWNlaXZlIA0KPiBi
ZXN0LWVmZm9ydCB1cGRhdGVzIG9ubHkpLiBJdCB0aGlzIHRoZSBvbmx5IG9wdGlvbnM/DQo+IA0K
DQpBcyB3ZSBuZWVkIG9ubHkgYmFja3BvcnRzIGZvciB6Y2h1bmsgaSB3b3VsZCBwcm9wb3NlIHRo
YXQgd2Ugc3VwcG9ydCBvbmx5IHJkaWZmIGJhc2VkIGltYWdlIGZvciBkaXN0cm9zIDw9IGJvb2t3
b3JtLiBUaGUgemNodW5rIHN1cHBvcnQgY2FuIGJlIGFjdGl2aWF0ZWQgZm9yIHRyaXhpZSBhbmQg
bGF0ZXIuDQoNClF1aXJpbg0KDQpbQWRpdGh5YSBCYWxha3VtYXJdIA0KSGkgUXVpcmluLA0KDQpT
aW5jZSB3ZSBjdXJyZW50bHkgc3VwcG9ydCBjcmVhdGluZyBzaWQgaW1hZ2VzIGluIGlzYXItY2lw
LWNvcmUsIHdvdWxkIGl0IGJlIG9rIHRvIGVuYWJsZSB6Y2h1bmsgc3VwcG9ydCBvbmx5IGZvciBz
aWQgaW1hZ2VzIGN1cnJlbnRseT8NCg0KUmVnYXJkcywNCkFkaXRoeWENCg0KPiBKYW4NCj4gDQo+
IA0KPiANCj4gLT0tPS09LT0tPS09LT0tPS09LT0tPS0NCj4gTGlua3M6IFlvdSByZWNlaXZlIGFs
bCBtZXNzYWdlcyBzZW50IHRvIHRoaXMgZ3JvdXAuDQo+IFZpZXcvUmVwbHkgT25saW5lICgjMTUy
NjQpOiANCj4gaHR0cHM6Ly9saXN0cy5jaXAtcHJvamVjdC5vcmcvZy9jaXAtZGV2L21lc3NhZ2Uv
MTUyNjQNCj4gTXV0ZSBUaGlzIFRvcGljOiBodHRwczovL2xpc3RzLmNpcC1wcm9qZWN0Lm9yZy9t
dC8xMDQ3ODMzMzYvMTc1MzY0MA0KPiBHcm91cCBPd25lcjogY2lwLWRlditvd25lckBsaXN0cy5j
aXAtcHJvamVjdC5vcmcNCj4gVW5zdWJzY3JpYmU6IA0KPiBodHRwczovL2xpc3RzLmNpcC1wcm9q
ZWN0Lm9yZy9nL2NpcC1kZXYvbGVhdmUvODEyOTEyMS8xNzUzNjQwLzE0MDUyNjkzDQo+IDI2L3h5
enp5IFtxdWlyaW4uZ3lsc3RvcmZmQHNpZW1lbnMuY29tXQ0KPiAtPS09LT0tPS09LT0tPS09LT0t
PS09LQ0KPiANCg==


