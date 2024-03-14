Return-Path: <adithya.balakumar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 292A3C54E5D
	for <webhook@archiver.kernel.org>; Thu, 14 Mar 2024 07:51:34 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.132])
 by mx.groups.io with SMTP id smtpd.web10.7223.1710402685459593189
 for <cip-dev@lists.cip-project.org>;
 Thu, 14 Mar 2024 00:51:26 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.132, mailfrom: adithya.balakumar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1121) id 42E7pNw53890743; Thu, 14 Mar 2024 16:51:23 +0900
X-Iguazu-Qid: 2rWh11C4gSJFclxMPE
X-Iguazu-QSIG: v=2; s=0; t=1710402682; q=2rWh11C4gSJFclxMPE; m=Er9DW9OnOMGP4SMPYrbIoKzFoRpmx6IaOfV0GCLY+EA=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1123) id 42E7pMu2194070
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 14 Mar 2024 16:51:22 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NOGs6pXWzPrReSti11MOFDGebA8V3KPfBKLby8uLFjTz+FGuE8G0PDJZ6sOUlesmmB15mvBYzeul3yuWNatcZBZn411xYlejxA9yFcCqSoijCfWx4sXVIyh4+wpnYEtW6c8iR1n8o+buzc6BvMbUxNmyVepGVwVUJmVTge6A+ORugaion3/EYe9dNpDY+vunI3u74mcseJcdQpLRKpdmgS1g6wfxor6UvDuaGylSej9It6vyChzV3rRxhfYaIlMnqbqQcAXK0CYt0z3/KQons+Th+phmCFllnN1Um6KjHz1ukLeAp1qxleBDc/pUkXbh+DC+itOOGDym5Xwaz0DOgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hBckiYoRdXfYKX7GQd8PcPoW68O7tK7KcBmGZ9jERsU=;
 b=E227wDhgQ7m+ZzS5itMyF24moYoLbMKoC0bvL3kXF4559GYVhZpLBmdNcNcyCcB/fp7NzkFMvV1acsbLbxqIlXm6UsmhRdMkMl/ZYvKjKBmQoL4DrNZpOrtvjIK0akwuuXslwHdvcQjO4RUJ7vTVk53H5XfLXwXrdTmyeCeJsN8CpbigGnq+8tOssT1EQEemg74kTayaDDKswTHgSKRz2Aewz2qgg07HQAKnD7OgPsNtyOCcbJX++VVeWJZ/0VbtsGEUv/BrCFG1GbvqfGimeL0yQwDoz8KrLVlJjWdnM0LFblqzc8nOUYWeS9M0opCK9l52+/4S1h1Mxrtn1k/IWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Adithya.Balakumar@toshiba-tsip.com>
To: <cip-dev@lists.cip-project.org>
CC: <Shivanand.Kunijadar@toshiba-tsip.com>, <Sai.Sathujoda@toshiba-tsip.com>,
        <dinesh.kumar@toshiba-tsip.com>, <kazuhiro3.hayashi@toshiba.co.jp>
Subject: RE: [cip-dev] [isar-cip-core][RFC v1 3/6] swupdate: Enable Delta
 handler in swupdate
Thread-Topic: [cip-dev] [isar-cip-core][RFC v1 3/6] swupdate: Enable Delta
 handler in swupdate
Thread-Index: AQHacUzLHXu68NV9kkSYPvRwgD/moLE21uQAgAAOYwA=
Date: Thu, 14 Mar 2024 07:51:19 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYCPR01MB9669B2260062CD6BA585EF40C4292@TYCPR01MB9669.jpnprd01.prod.outlook.com>
References: <20240307074612.1996609-1-Adithya.Balakumar@toshiba-tsip.com>
 <20240307074612.1996609-4-Adithya.Balakumar@toshiba-tsip.com>
 <97facebf-c2fc-4253-927c-29831dab40ec@siemens.com>
 <c0b04b38-2760-4ef0-ae45-b57dfd7c5b5a@siemens.com>
In-Reply-To: <c0b04b38-2760-4ef0-ae45-b57dfd7c5b5a@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB9669:EE_|OSZPR01MB8671:EE_
x-ms-office365-filtering-correlation-id: d39f30b5-3683-4603-d8c3-08dc43fb8932
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 AEUJcY3wMbLYREO7Z2snHzqQLVPEDiNBSIXWqM6V8m/z0u7oyaHAV52myBQ+L1U9l3QhhpHv29wNoTS3DtjTtkpURkO3kBpaV6xoojhRN34TeIP+thuYX4goyUgmry5FK/gZ8VQtSZiP7N99xCeF2lxnhsNiP0PICDISk5F/74uuglfsAeKjIV/AZEVBANmIHSfG0uuc9QJ99i6FVly/WQdzxTnZylIHx2a2L4x56/v1pCQRTx3Z3QKgZ00kJ42vzlKdHOTE6G0N80oH0MkNd8YJ2v3L2Pq9WnH6QLzHYjmubq97M5q4ahQok3Aax9s+9qz1w7Sr9pmGFUmK0AJnbHGe69zGp3X7zPQRxQ7zx5ZqSPCuOhJYFlwd6J+R4LmffwZm9sg3Mb5ozFGlzKZLJc3LQGoivCQGVvbbRFUejL+3P6sMZlPly/7S3fVTll5iiStMUSip2C+yxllyYgwFL5gDGo+DQ357r7INqrfLC5a1jVJgsPwaIS8YO+qo0THG1wXvuLHJmEohl4xzDc/9If3qR0E29Ynzqr5Y3dFoaiO3uQChMAa9mh6S0D7r9rCY6zY52KsgujC0T+BGICRqADsj+5JwbSktU5Q0Iigd+I4TZVMI3WrBnyUiirfcPxQ+PXSEHO2uh0BQpKY6S9WKrJyq38rmdh7Y4jlCXPiVbWE=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB9669.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?ZnI2YVVJTFJ0cXhJTGp2WUJJMENEZTZtb005V21mRFRpVjVBVDRLODVSaXpm?=
 =?utf-8?B?bk9uOWdvUERkbEFoOFhwQnZ5L1V1bmRVSXJ6N0lJOVlHZzBWT1kxelJHNkxP?=
 =?utf-8?B?QzRJSmdLVDlEZW1VRVArc3FPNzFEUERydXllMHNmRmxQNGFoQ1dBZjRjU2JD?=
 =?utf-8?B?bXZRRGhBdjZkRnVOeWFYY2hnN2J0L1lnY3NIUXU0MjFIVmRjcWJtYTdhTkVE?=
 =?utf-8?B?cjA2Y0ZNbGdncXNib2FVTStPSFFoTWs2Sk1wYUZOUFFKWnF1cmRrSDhYU1NS?=
 =?utf-8?B?REoxRnRBczBxdTZlQ1lpZjFOa3ZZaFB4OSsvbENPRFJLbjJUbkFibmRLbWhh?=
 =?utf-8?B?ZXA3RTkzZG16TFFoMGFPaUJ0bjBQQkFqZkRYczhmWWNNRzRTYytSaDlQQklX?=
 =?utf-8?B?UCtwYXBXOTNLd1ZHeUdFL0p5NklUajJ1eFh0dDNsQ2JIeWExMzRVZVI5c3Fq?=
 =?utf-8?B?NzRHU3pzYk5Ic29XNE45dFRYby9GN2M0ai9mQTBLYjR4RitJSUQyUHRXbElL?=
 =?utf-8?B?YWxwMTB3NWN3V3ZPK0Q3YTlLWVF1bzhsL1g2MDdWaWNpUmo4eG1xODF0OWZ3?=
 =?utf-8?B?WWRNaWdEd2VKMGJRODUwOXZoRnA1SXBkY09qWXFHSWNSZHkwNHdIZFJMT3c3?=
 =?utf-8?B?ODdPMjhRSmZ5dWJyMy81cVU1Zmd2NGRwOEJLUkF3U3ZUalpuL1l6NHNRTkFt?=
 =?utf-8?B?N0hITFNnVXFNOTNLZlVOZEoxVS92YUlsd0VBRDRRK2MwK1o4ckxsQXZ3bXBM?=
 =?utf-8?B?c01qbFV5SHNuWXE1dFU4bFlKcjBNVnN4ZDJTU1Q5S1YzdXBTb1ZUZzdvajMy?=
 =?utf-8?B?QXNIc0pRcllWUDZoUFFmb1FTTDhuT2VnUENvYmE1Wk90MmFIS29sQjIwZ1BS?=
 =?utf-8?B?QVZOREJ1dGtjMjRJVXYzcmhPc2Y1aDR2akZwWnR1N3M3UkZVTXFsN0cyTXhX?=
 =?utf-8?B?ZlBJKzU4RC9LQnRENnp3VUJFVno3QmVZS01CcUd6UUdRc2VMc3JlZGpCRjh0?=
 =?utf-8?B?c1VKcXhLVVoxY2dTUmowalBVd25aRTB0ZnBQa2J6RUdrUk5XOUhwaTRCZTd2?=
 =?utf-8?B?dGY3dzMrYXVFdHZSQXhRTjVVRG51bFJqc3pJNy9oUmdTb3JmWEkrQys5dk5o?=
 =?utf-8?B?cmFiTjFVQzlBWkdKMnhPNmU4TDVqMzRFWnJ5bTZNSjArK0RhMnJYZGFPVXNi?=
 =?utf-8?B?cEtpNE02SXhZcjZ4TlFKdHYyaWp4NE5kTlpUNXJqbkRaMjNmSWh0RExPZGM1?=
 =?utf-8?B?R0xITHBLU0tkWW5Qc3ZwOXRFUTFjSFdCSDdBa0VjZEVYZ3VSeE0wQ3ZGaHJp?=
 =?utf-8?B?QkQwdFZqYmNnM09GVU1NSFpxU1NBR3FuS2R6M095MWJSbll0ZHNSOTk4K2Ev?=
 =?utf-8?B?bFdxQVdTY0RHL05qay8zRXBWUWRtQWIzOG1mRXR3bExuUXdsaEQ2SWhlTXNv?=
 =?utf-8?B?S1FVcmZNY0xjb042ZGJPOTI2dWFwWTdWTHhhWkJ3NlJkU2IvcTZsR3cvTmpP?=
 =?utf-8?B?a0haZ25zSzFIYnZ5bERhSzk3ek1uNkVFNGZEVmhReGNyZFhYSGswM3BKdWMv?=
 =?utf-8?B?M2Npd21LMUpqYlVFMzYrRVd4R3JjUjY3NWFLYUdud1FiYzRyUXJtbWw5R2Uy?=
 =?utf-8?B?SGF5NzhYZVYvTXNaaXlqbjVnTC83VVNVR0hNQ0xHWlZWTTJrS0hzM2Vnb24z?=
 =?utf-8?B?bWRWN2JlKzVxUnpic1QxTUUrczdjSm5wWEEycXpTdkVaaUpXUERMSWdTMHcx?=
 =?utf-8?B?NFpid29yaTNUOEVBT1JjMlhNVHJSRDVYdEF3aGJ3eithOEJvbittSDl2SFFM?=
 =?utf-8?B?S2JuaktRL2VxVUMrOFZqbXNvSHM4MjlncG1kallJZ2ZFOXBGYjBOOVlJeHpL?=
 =?utf-8?B?Tk5RaGxqeXliSGltUTNEeDVTZ2hqcGpTcTczWnROUHdHTTFsK1ViMkg2eTFO?=
 =?utf-8?B?M0U3ZDZVWG5YOTVZVHYyb2g5eEZxT3NQZlRJMWJZRjNjVFcvY3drQW1LcjFq?=
 =?utf-8?B?d1VrSzBhUDB5Nlpmb21WSlF5T3RVaWxLOTRLSUEyY2l2eVNvV1NNMndiQ20y?=
 =?utf-8?B?RVhNS3ZoZk9EaDFleWk5ekFrQ0h2ZkdFSnVWVHQ3WW5WUFkvQWp5WTRRNmUv?=
 =?utf-8?B?MEtGSWlXRGg5NndEcUtVUkNGT21EQ0tjMWQ1OUR5bmRvanlnS1M0ZXhJVG4r?=
 =?utf-8?B?eUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB9669.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d39f30b5-3683-4603-d8c3-08dc43fb8932
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2024 07:51:19.6977
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g+tlyTF28c9Yp8wvaL4tMqBwCng69XFu7Wc0uJTzhB0mMHhQw8Ld27KQd550FCHQXE66Ybq1Bov7wNbcZEvOaRTTGjXjJ81bcAUC2L9Z2XKoDOaEjp0pAGAwbMlRvnDy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8671
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 14 Mar 2024 07:51:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15300

LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IGNpcC1kZXZAbGlzdHMuY2lwLXByb2pl
Y3Qub3JnIDxjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZz4gT24gQmVoYWxmIE9mIFF1aXJp
biBHeWxzdG9yZmYgdmlhIGxpc3RzLmNpcC1wcm9qZWN0Lm9yZw0KU2VudDogVGh1cnNkYXksIE1h
cmNoIDE0LCAyMDI0IDEyOjI3IFBNDQpUbzogY2lwLWRldkBsaXN0cy5jaXAtcHJvamVjdC5vcmc7
IGJhbGFrdW1hciBhZGl0aHlhKO+8tO+8s++8qe+8sCBURVVSKSA8QWRpdGh5YS5CYWxha3VtYXJA
dG9zaGliYS10c2lwLmNvbT4NCkNjOiBrdW5pamFkYXIgc2hpdmFuYW5kKO+8tO+8s++8qe+8sCBU
TUlFQyBPREcgUG9ydGluZykgPFNoaXZhbmFuZC5LdW5pamFkYXJAdG9zaGliYS10c2lwLmNvbT47
IGFzaHJpdGggc2FpKO+8tO+8s++8qe+8sCkgPFNhaS5TYXRodWpvZGFAdG9zaGliYS10c2lwLmNv
bT47IGRpbmVzaCBrdW1hcijvvLTvvLPvvKnvvLAgVE1JRUMgT0RHIFBvcnRpbmcpIDxkaW5lc2gu
a3VtYXJAdG9zaGliYS10c2lwLmNvbT47IGhheWFzaGkga2F6dWhpcm8o5p6XIOWSjOWujyDvvKTv
vK3vvKUg4peL77yk77yp77yn4pah77yt77yw77yz4peL77yt77yw77yUKSA8a2F6dWhpcm8zLmhh
eWFzaGlAdG9zaGliYS5jby5qcD4NClN1YmplY3Q6IFJlOiBbY2lwLWRldl0gW2lzYXItY2lwLWNv
cmVdW1JGQyB2MSAzLzZdIHN3dXBkYXRlOiBFbmFibGUgRGVsdGEgaGFuZGxlciBpbiBzd3VwZGF0
ZQ0KDQoNCg0KT24gMy84LzI0IDEyOjM2IFBNLCBKYW4gS2lzemthIHZpYSBsaXN0cy5jaXAtcHJv
amVjdC5vcmcgd3JvdGU6DQo+IE9uIDA3LjAzLjI0IDA4OjQ2LCBBZGl0aHlhIEJhbGFrdW1hciB3
cm90ZToNCj4+IEVuYWJsZSBkZWx0YSBoYW5kbGVyIGluIHN3dXBkYXRlIGZvciBib29rd29ybSBh
bmQgZGlzYWJsZSBjcm9zcyANCj4+IGNvbXBpbGUgZm9yIGFybSBhbmQgYXJtNjQgb24gYm9va3dv
cm0gdG8gYXZvaWQgYnVpbGQgaXNzdWVzDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogQWRpdGh5YSBC
YWxha3VtYXIgPEFkaXRoeWEuQmFsYWt1bWFyQHRvc2hpYmEtdHNpcC5jb20+DQo+PiAtLS0NCj4+
ICAgcmVjaXBlcy1jb3JlL3N3dXBkYXRlL3N3dXBkYXRlXzIwMjMuMDUuYmIgfCAzICsrKw0KPj4g
ICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL3Jl
Y2lwZXMtY29yZS9zd3VwZGF0ZS9zd3VwZGF0ZV8yMDIzLjA1LmJiIA0KPj4gYi9yZWNpcGVzLWNv
cmUvc3d1cGRhdGUvc3d1cGRhdGVfMjAyMy4wNS5iYg0KPj4gaW5kZXggZDFmZTFmYS4uN2EyMjk0
NyAxMDA2NDQNCj4+IC0tLSBhL3JlY2lwZXMtY29yZS9zd3VwZGF0ZS9zd3VwZGF0ZV8yMDIzLjA1
LmJiDQo+PiArKysgYi9yZWNpcGVzLWNvcmUvc3d1cGRhdGUvc3d1cGRhdGVfMjAyMy4wNS5iYg0K
Pj4gQEAgLTM2LDEwICszNiwxMyBAQCBTUkNfVVJJOmFwcGVuZDpidWxsc2V5ZSA9ICIgZmlsZTov
LzAwMDQtZC1zd3VwZGF0ZS13d3cuaW5zdGFsbC1GaXgtcGF0aC1mb3ItZGViaQ0KPj4gICBERUJf
QlVJTERfUFJPRklMRVMgKz0gInBrZy5zd3VwZGF0ZS5zdXJpY2F0dGFsdWEiDQo+PiAgICMgYWRk
IHN1cmljYXR0YSB3ZngNCj4+ICAgREVCX0JVSUxEX1BST0ZJTEVTICs9ICJwa2cuc3d1cGRhdGUu
c3VyaWNhdHRhd2Z4Ig0KPj4gKyMgYWRkIGRlbHRhIHVwZGF0ZSBidWlsZCBwcm9maWxlIGZvciBi
b29rd29ybSANCj4+ICtERUJfQlVJTERfUFJPRklMRVM6YXBwZW5kOmJvb2t3b3JtID0gIiBwa2cu
c3d1cGRhdGUuZGVsdGEiDQo+PiAgIA0KPiANCj4gV2hhdCBhYm91dCBzaWQ/DQo+IA0KPj4gICAj
IERpc2FibGUgY3Jvc3MgZm9yIGFybSBhbmQgYXJtNjQgb24gYnVsbHNleWUNCj4+ICAgIyB3aXRo
IGNyb3NzIGNvbXBpbGUgd2UgaGF2ZSBhIHVuc2F0LWRlcGVuZGVuY3kgdG8gZGgtbm9kZWpzIG9u
IGFybS9hcm02NA0KPj4gICBJU0FSX0NST1NTX0NPTVBJTEU6YnVsbHNleWUgPSAiMCINCj4+ICtJ
U0FSX0NST1NTX0NPTVBJTEU6Ym9va3dvcm0gPSAiMCINCj4gDQo+IFRoaXMgaXMgdW5mb3J0dW5h
dGUuIFdoeSB0aGF0Pw0KPiANCg0KSSB0ZXN0ZWQgc3d1cGRhdGUgMjAyMy4wNSBvbiBib29rd29y
bSB3aXRoIGFybWhmIGFuZCBhcm02NCBpdCBjdXJyZW50bHkgbmVlZHMgbm8gYmFja3BvcnRzLg0K
DQpNeSB0d28gY2VudHMgYXJlIHRoaXMgaXMgYW4gaXNzdWUgd2l0aCBiYWNrcG9ydHMuDQoNClF1
aXJpbg0KDQpbQWRpdGh5YSBCYWxha3VtYXJdIA0KSGkgUXVpcmluLA0KDQpUaGlzIHdhcyBiZWNh
dXNlIG9mIGJ1aWxkIGZhaWx1cmVzIG9mIHN3dXBkYXRlIHdpdGggZGVsdGEgaGFuZGxlciBlbmFi
bGVkIGluIGFybTY0L2FybSBhcmNoaXRlY3R1cmVzIGR1ZSB0byBkZXBlbmRlbmN5IG9uIGxpYnpj
ay1kZXYgcGFja2FnZSAoYSBiYWNrcG9ydGVkIHBhY2thZ2UpLg0KSGF2ZSBhbHNvIHJhaXNlZCB0
aGlzIGFzIGFuIGlzc3VlIGluIGlzYXItY2lwLWNvcmU6IGh0dHBzOi8vZ2l0bGFiLmNvbS9jaXAt
cHJvamVjdC9jaXAtY29yZS9pc2FyLWNpcC1jb3JlLy0vaXNzdWVzLzkzDQoNClJlZ2FyZHMsDQpB
ZGl0aHlhDQoNCj4+ICAgDQo+PiAgICMgdXNlIGJhY2twb3J0IGJ1aWxkIHByb2ZpbGUgZm9yIGJ1
bGxzZXllDQo+PiAgIERFQl9CVUlMRF9QUk9GSUxFUzphcHBlbmQ6YnVsbHNleWUgPSAiIHBrZy5z
d3VwZGF0ZS5icG8iDQo+IA0KPiBKYW4NCj4gDQo+IA0KPiANCj4gDQo+IA0K


