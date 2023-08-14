Return-Path: <stefan-koch@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 054F3EB64DD
	for <webhook@archiver.kernel.org>; Mon, 14 Aug 2023 11:25:23 +0000 (UTC)
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (EUR01-DB5-obe.outbound.protection.outlook.com [40.107.15.83])
 by mx.groups.io with SMTP id smtpd.web10.105331.1692012315342756319
 for <cip-dev@lists.cip-project.org>;
 Mon, 14 Aug 2023 04:25:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=akm6b1/6;
 spf=pass (domain: siemens.com, ip: 40.107.15.83, mailfrom: stefan-koch@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UNO8QFPqYSfos8dFRg+15dHkpKBXtLT/HuKRZgzYpesrQCOrTntdCngylJVvWEyApQOSIxQ558riKz3SGhoE2pRWpu17U7VQHzniIyz2s2euRFy+wYHBgdBhgHreipDpT1AsR9XRXAB2xdkMhyduRW7R4D1b46nVo/fd6G9IyQ3B91O5RfIT3MBtA0JnV+TIGbGGTFRgBzVs1j0jk32Yvm0TEKEC4SHL8CTIKs9psJbNYBL4ZQvpJoqUUGUaeBbfORtZfqJSAXbIhwiml8uledCG67IqVFtt2TwRx2wtn3fKsUVx0vqRSu9jkAkN3zWjqoI0LBXUZfsUvn3+gPL8dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xwykilsQev50qU3HK3E/4SPay6PoK+2FK5FZOyaGzz8=;
 b=hWVo20prHFYvsyNqQaUAubxkMLlW9F0zNWjOG9Vaz+SZCh/jiThpm8asi1b2ty/xpbJAUd1WYhiB3A4cOd+iiF9Ing3C71CQpQERiXPETKhrtfj2jP1kJiN4GVW0A/Iu+tWldzW6vGL1s48wj9b9b38Mirj7xg7pOrhoYlzgP8rk4e2ucfq77RZKu7sJ5o3Tm5YfDq1HYSbb+x3TOEGMz8ru/oPQtTHg3WuQy9dMRvdMH8CEyaMtIbGRXC7/9cvEcTGnZRTJ7Cf1ud9ELtRHGgPL5dmuFVB/8feKQfy3T8ACAYUKyq/jGELjs5aXe7pqPCVIZ1wqmef0IMdXhiMryA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xwykilsQev50qU3HK3E/4SPay6PoK+2FK5FZOyaGzz8=;
 b=akm6b1/6SWeYKD7x9UTjx4+rOzHCxg8CaO+iB2JWkDm8uJXhQFzyc+1O0HkJ5qu9SwhDJ3ONJnPMYlJWAYA1PoUjDD7ygodrazwusb9wsZUHWwD+zTjCstsMWYSqH1JTSSVEG/IQhmbojYiaxH7zs4cgC6C0z3wb86DYlyDI0nbjlnt/JfBkBprhPAL0Yo9cPMbp9CXYkVhQhs/OI+7c5yohgEfZclvG6GNGfmNTHGYkYEsztdV2NfZFQUH4G8WJI0xS7YrzcWlDqBJA3EPw2uSWuPON0+qRMVDAf56BPEyCn4TI2a2476+hiAobuPNRLO+DSsHBeewNDTZOTk7GpQ==
Received: from AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:41e::11)
 by AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:550::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.19; Mon, 14 Aug
 2023 11:25:12 +0000
Received: from AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c9da:178c:455b:211e]) by AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c9da:178c:455b:211e%4]) with mapi id 15.20.6678.022; Mon, 14 Aug 2023
 11:25:12 +0000
From: "Koch, Stefan" <stefan-koch@siemens.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"quirin.gylstorff@siemens.com" <quirin.gylstorff@siemens.com>, "Kiszka, Jan"
	<jan.kiszka@siemens.com>
CC: "Sudler, Simon" <simon.sudler@siemens.com>, "Storm, Christian"
	<christian.storm@siemens.com>, "Adler, Michael" <michael.adler@siemens.com>
Subject: Re: [cip-dev] [isar-cip-core][PATCH 3/4] initramfs-crypt-hook: Avoid
 calling of tiny mke2fs from busybox
Thread-Topic: [cip-dev] [isar-cip-core][PATCH 3/4] initramfs-crypt-hook: Avoid
 calling of tiny mke2fs from busybox
Thread-Index: AQHZwWCHFkOweebVN0+CPtd6o803+a/jalIAgAALhwCAAa0MgIAEnlOA
Date: Mon, 14 Aug 2023 11:25:11 +0000
Message-ID: <9443dd8ff4eb0bb72c28c99f62d71c341d6f958a.camel@siemens.com>
References: <20230728143320.3891194-1-stefan-koch@siemens.com>
	 <20230728143320.3891194-4-stefan-koch@siemens.com>
	 <15101ae1-62b7-47fd-808d-501433da81f1@siemens.com>
	 <a49cdd53-e2b9-52c3-ac40-b11264952b28@siemens.com>
	 <e27c652d-f203-483f-bc7b-1b994f3d4e7c@siemens.com>
In-Reply-To: <e27c652d-f203-483f-bc7b-1b994f3d4e7c@siemens.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR10MB4959:EE_|AS2PR10MB6349:EE_
x-ms-office365-filtering-correlation-id: 5c0ed5ff-5507-4e7a-fb91-08db9cb91fd6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 pvLSO3sY8aNIA/QSpRUYkyFnJvKuXSRS2xJvCL/3YhbfaWyTJVncK3H/G64a5yXV7jw/MszIDm9ODbmxNsVwmPJMSpW0Sqd9QBcXvlh3xj6TOrVBa6PHCneB+Sd0LnipEjp8gi+9k5bfZjv1quzBHw1Zy+Cm0tehI2vZJwUNPrBisWRR2jBaP3gAfjQtqEta9EocGxBw8Jw+wOO9h4yUmaMx0icJvdrp+Kz1V7XE0TrAR/o4wRNfCRF6f5dHCzHokL2E8duFT2hCRdA1D8JFgEfIpKbwxlF1s7jiKAm8UVYUpCuqxpvOeSUkvKEt7uTy1bHmKKo8NLWLpec64LMTGNIXjr/7Ztj8675hYusmXlm/JFojqqUbmRj55Nc5bMrFmHBXWrpmpv6DKU4NyeOZ8B7V0JverJqRvgG79u0kHP8nYRcVrcATzHASVaFh8vmgZ0XaglEJ6a+JwDg8VoSiaS5hUiRA8V64NTyV5r4WS3FRQZgjEJYHOrQyIXKLHaG0pXB9d9Vdj9Q5Y5xrZTncSsrLLe2oPLwPgIW6mmV04gI5MLC9qesgCO2DJvBiux6qdqPMi4a0+9AzH2luBoLctqM0vEK++sAQsLPXQD8Xmm1jUIwW4P9w3JVuQFoBTmnzu//KTohyWDJntGOpEeFmuw==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(366004)(376002)(396003)(136003)(346002)(39860400002)(186006)(451199021)(1800799006)(6486002)(6512007)(71200400001)(66946007)(107886003)(66556008)(6506007)(316002)(76116006)(66446008)(64756008)(478600001)(66476007)(53546011)(110136005)(82960400001)(26005)(54906003)(122000001)(38100700002)(4326008)(83380400001)(86362001)(6636002)(91956017)(2616005)(36756003)(38070700005)(2906002)(5660300002)(15974865002)(41300700001)(8676002)(8936002)(18886075002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?eU5pR28vYUNFTjhFT0k2dEgzbWtPVE0vUUNDVm5jRkkyMWNUSmd5NXA0TUJS?=
 =?utf-8?B?Y2tOZWR4dDAyZGxxMjhMYnkyNFI1ZEtnVnp6WXdjNGZZeXhnM2x0b0Z0ZmYr?=
 =?utf-8?B?K3VIVmwzYnhmM1E0OWhSMExXczc3Q2M3R2dxWnRpdEZXNFBLcmtIWG9hLzJy?=
 =?utf-8?B?M3hIZTFBdWNIek1XL292TnQxQXZKMVNjWW5EYlpBejV6WEhIWThTNDVqWjZY?=
 =?utf-8?B?WVc4WS9KQW82QnRNNFk3dzdudDdQVFpORm54Ly94cktlMTVTemNXTEJ5UTc4?=
 =?utf-8?B?OTJxdFlMc0FNSDdmTHRTcmJGak5oZlVKUGFMT20yWGtITmszelNtS0VXQjM0?=
 =?utf-8?B?S1ZJTXJPZjlyRXVCNDFYcG1XeVROQ3F0UnV5dlNpclRabW5jRG5jRGUrWXNG?=
 =?utf-8?B?dUV4RC94aEJsOG1zN3dGVXQ0N1pyNE1rTzZUN3Bib1JHR1Y3dlJGOWxHaU91?=
 =?utf-8?B?dTJpM0w1dkJjNVJYczNzQldJUm9ieHZ4enByK0FBMWpMWW1hYkg1QWZPb01W?=
 =?utf-8?B?Yzk5ZCtvd0MrdmpncXU0dERRR2FhL2liZVBxYWNiaTM2VjJPcXF1aHg5NWxT?=
 =?utf-8?B?UkxiRms4MjZsUlJlK2NPYmVHNFRhZnZMQVBTVDZPQytNcmcydUtNS3Flam9C?=
 =?utf-8?B?TDB3NVcrWmRHNFdVN3gwcFJLMkl3RFRXNE00QW44eVlmbWZ2NkdpQm5lYkFi?=
 =?utf-8?B?Qk1aQjR2bVdKRUxCa1MzL2pnbEZUdWF6NEpmUHRSbzRCNk5IWmVhbTJUck92?=
 =?utf-8?B?WEVaOUV6dXlmK3A2OU1sVTM2TTZET0FZMVFzWUthcjdqZkNRK2c2WmFFRXh0?=
 =?utf-8?B?dEVCOGZZTG5DcXJzZzVNdUFDMTR6cEMvVS9tcnVueUdoYkRTQXQ1WHk5NnQ1?=
 =?utf-8?B?OFBIWGZQSkxoNDVWd0NPd21hU3pNZDNKeVlnTnc1TWt5UXoyQ3BvaVpiK0Ey?=
 =?utf-8?B?blVDVHd4TGJUMStDM2ovMWJDMlNCK2NFSThQWDFlMCtUeFdlaXhHN1k2NXdo?=
 =?utf-8?B?WGl4T3pjVDhkZlRPeE5Ec09BMUM3TlcyUnVHODlZMUhIdkZkNndISzJkd3hN?=
 =?utf-8?B?dW5kWnNNN2JKMXhMYlZ2WWkxVUZOQW5manhubjFzT0hqY3VWSENGdlk4T1hY?=
 =?utf-8?B?SXU1cVliemN1cTQrM1JWdmwxQkZHaFgxZnFVTFR1WDk4L1JpSVZzYWkzOFYv?=
 =?utf-8?B?eFNWcnBlZ09zTWltcDdvb1dxY2N3aloxTFBwOUxDWjgyUUxBMVgyaEs3NExh?=
 =?utf-8?B?bjBNejAyYnNNaHcxRW1ZUjJkd2tDaXpjaHBzOFZjajIrTUIxYThhYldCMlZK?=
 =?utf-8?B?Q0dCeHRQeGRWcGNPNVRKMjRsUG9HVHc0RTd2aW5ScmoxZWtFNDlYY05Nb3RV?=
 =?utf-8?B?SEp2azd0Rkw1WWlXQnNtK1VOTkk4YWd4NG9XN0F0TUVseGpYTjRHWlpBY0p5?=
 =?utf-8?B?dldzUzZnVEE0UzNHL2FFazdEYW83aDhtWW1sMFJ4UEZWK3JXRVVXS3RraUp4?=
 =?utf-8?B?M2R5SGtDSnNIVnowQWI1WHFjaTRyWDRZdWV6L0RoZFpXMWdGdTA0Zi9KbjZZ?=
 =?utf-8?B?bk9FT21FWW9CellpVGhaRHRMYU9Lek1vTVdBaUd6NndWK3pXM0o0Vi9zRjVH?=
 =?utf-8?B?SmlHblRqQXFsTG9JR3EwN2xFeEkyaXRoM1pRRFBPUGFuVTRSOERzUzlabTdY?=
 =?utf-8?B?K0VqUUJ3V1Zqa0c1a2U1anRYdHM2WDMxTnkrRTErcWwzVWpLaDBFbzdaNDQr?=
 =?utf-8?B?eG1Sc05CeVRoZ1dGWFY3K2VJQUdBNVNuenZhMytFSG43TjB6TTA1OFJHZm8x?=
 =?utf-8?B?eUVlWUZDMXRuNk9ERXJxTzljMUFXbU9CbWhEZWxvbUFMU0dTZlFEZGtRMnF5?=
 =?utf-8?B?S3VOSDRjWU4xQjFPRXgzOFdMeHRmMHBLRzg1UURNSUhBOTRNQ3RGKzcrTHBZ?=
 =?utf-8?B?ZVUrVVV5clJRMUJkMjJlQ0FBQ3g1ZWxvVGdYUE5wUW9TdFhPVkpLQWpRVDZT?=
 =?utf-8?B?ZVlFTERvS3hib1RobWU1NE9CaEFPT3FRNlJCL1VZcWRwTW1sWWdxSnNpcC9P?=
 =?utf-8?B?V3VQeFhiQUhmdkVOWTBJb2hyTm9POWJRMDc4NUtvTWFnRDMvY1lFbEZmNVRp?=
 =?utf-8?B?cWM2WXJDMXBpMEwwb0M2NzlwMnhSbWFpRnpGZ3UwMmY3eWZRQUZucmM4eXhJ?=
 =?utf-8?B?WXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5CBE5D28485B0C49824F384AE6EB80C0@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4959.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c0ed5ff-5507-4e7a-fb91-08db9cb91fd6
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2023 11:25:11.9940
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c5ltQy7X6gxGNeWv8cvn8ednxZRAr9IWbJj93rbO0Nu98Lx1h3mCP/oyvpCc2ug7M96u+kL0gA6i7Vg5iXelVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB6349
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 14 Aug 2023 11:25:23 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12639

T24gRnJpLCAyMDIzLTA4LTExIGF0IDE0OjUzICswMjAwLCBKYW4gS2lzemthIHdyb3RlOg0KPiBP
biAxMC4wOC4yMyAxMzoxNywgR3lsc3RvcmZmIFF1aXJpbiB3cm90ZToNCj4gPiANCj4gPiANCj4g
PiBPbiA4LzEwLzIzIDEyOjM2LCBKYW4gS2lzemthIHZpYSBsaXN0cy5jaXAtcHJvamVjdC5vcmcg
d3JvdGU6DQo+ID4gPiBPbiAyOC4wNy4yMyAxNjozMywgS29jaCwgU3RlZmFuIChESSBQQSBEQ1Ag
UiZEIDMpIHdyb3RlOg0KPiA+ID4gPiBUaGUgdGlueSBta2UyZnMgZG9lcyBub3Qgc3VwcG9ydCB0
aGUgdXNlZCAtdCBvcHRpb24uDQo+ID4gPiA+IA0KPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBTdGVm
YW4gS29jaCA8c3RlZmFuLWtvY2hAc2llbWVucy5jb20+DQo+ID4gPiA+IC0tLQ0KPiA+ID4gPiDC
oCAuLi4vaW5pdHJhbWZzLWNyeXB0LQ0KPiA+ID4gPiBob29rL2ZpbGVzL2VuY3J5cHRfcGFydGl0
aW9uLnN5c3RlbWQuc2NyaXB0IHwgMiArLQ0KPiA+ID4gPiDCoCAuLi4vaW5pdHJhbWZzLWNyeXB0
LWhvb2svaW5pdHJhbWZzLWNyeXB0LQ0KPiA+ID4gPiBob29rXzAuMS5iYsKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgfCAyICstDQo+ID4gPiA+IMKgIDIgZmlsZXMgY2hhbmdlZCwgMiBpbnNlcnRpb25z
KCspLCAyIGRlbGV0aW9ucygtKQ0KPiA+ID4gPiANCj4gPiA+ID4gZGlmZiAtLWdpdA0KPiA+ID4g
PiBhL3JlY2lwZXMtaW5pdHJhbWZzL2luaXRyYW1mcy1jcnlwdC0NCj4gPiA+ID4gaG9vay9maWxl
cy9lbmNyeXB0X3BhcnRpdGlvbi5zeXN0ZW1kLnNjcmlwdCBiL3JlY2lwZXMtDQo+ID4gPiA+IGlu
aXRyYW1mcy9pbml0cmFtZnMtY3J5cHQtDQo+ID4gPiA+IGhvb2svZmlsZXMvZW5jcnlwdF9wYXJ0
aXRpb24uc3lzdGVtZC5zY3JpcHQNCj4gPiA+ID4gaW5kZXggYjMyYjJmMi4uNGUwNGQzNyAxMDA2
NDQNCj4gPiA+ID4gLS0tDQo+ID4gPiA+IGEvcmVjaXBlcy1pbml0cmFtZnMvaW5pdHJhbWZzLWNy
eXB0LQ0KPiA+ID4gPiBob29rL2ZpbGVzL2VuY3J5cHRfcGFydGl0aW9uLnN5c3RlbWQuc2NyaXB0
DQo+ID4gPiA+ICsrKw0KPiA+ID4gPiBiL3JlY2lwZXMtaW5pdHJhbWZzL2luaXRyYW1mcy1jcnlw
dC0NCj4gPiA+ID4gaG9vay9maWxlcy9lbmNyeXB0X3BhcnRpdGlvbi5zeXN0ZW1kLnNjcmlwdA0K
PiA+ID4gPiBAQCAtNDIsNyArNDIsNyBAQCBwYXJ0aXRpb25fc2V0cz0iJFBBUlRJVElPTlMiDQo+
ID4gPiA+IMKgIGNyZWF0ZV9maWxlX3N5c3RlbV9jbWQ9IiRDUkVBVEVfRklMRV9TWVNURU1fQ01E
Ig0KPiA+ID4gPiDCoCDCoCBpZiBbIC16ICIke2NyZWF0ZV9maWxlX3N5c3RlbV9jbWR9IiBdOyB0
aGVuDQo+ID4gPiA+IC3CoMKgwqAgY3JlYXRlX2ZpbGVfc3lzdGVtX2NtZD0ibWtlMmZzIC10IGV4
dDQiDQo+ID4gPiA+ICvCoMKgwqAgY3JlYXRlX2ZpbGVfc3lzdGVtX2NtZD0iL3Vzci9zYmluL21r
ZTJmcyINCj4gDQo+IFRoaXMgaXMgbm90IGNvcnJlY3QuDQoNCk9vcHMuLi4gUGFyYW1zIGxvc3Qg
OiggVGhlbiBkZWZhdWx0IHNob3VsZCBiZSBleHQyLg0KDQpCdXQgdGhlwqBjb25kaXRpb24NCglp
ZiBbIC16ICIke2NyZWF0ZV9maWxlX3N5c3RlbV9jbWR9IiBdOyB0aGVuDQoNCmlzIG5ldmVyIHRy
dWUsIGJlY2F1c2Ugb2YgIj8/PSIgaW4gdGhlIGluaXRyYW1mcy1jcnlwdC1ob29rXzAuMS5iYg0K
ZmlsZToNCkNSWVBUX0NSRUFURV9GSUxFX1NZU1RFTV9DTUQgPz89ICIvdXNyL3NiaW4vbWtlMmZz
IC10IGV4dDQiDQoNCj4gDQo+ID4gPiA+IMKgIGZpDQo+ID4gPiA+IMKgIMKgIHNlcnZpY2Vfd2F0
Y2hkb2coKSB7DQo+ID4gPiA+IGRpZmYgLS1naXQNCj4gPiA+ID4gYS9yZWNpcGVzLWluaXRyYW1m
cy9pbml0cmFtZnMtY3J5cHQtaG9vay9pbml0cmFtZnMtY3J5cHQtDQo+ID4gPiA+IGhvb2tfMC4x
LmJiDQo+ID4gPiA+IGIvcmVjaXBlcy1pbml0cmFtZnMvaW5pdHJhbWZzLWNyeXB0LWhvb2svaW5p
dHJhbWZzLWNyeXB0LQ0KPiA+ID4gPiBob29rXzAuMS5iYg0KPiA+ID4gPiBpbmRleCAxYzFiZjNk
Li4zYzNmNmJiIDEwMDY0NA0KPiA+ID4gPiAtLS0gYS9yZWNpcGVzLWluaXRyYW1mcy9pbml0cmFt
ZnMtY3J5cHQtaG9vay9pbml0cmFtZnMtY3J5cHQtDQo+ID4gPiA+IGhvb2tfMC4xLmJiDQo+ID4g
PiA+ICsrKyBiL3JlY2lwZXMtaW5pdHJhbWZzL2luaXRyYW1mcy1jcnlwdC1ob29rL2luaXRyYW1m
cy1jcnlwdC0NCj4gPiA+ID4gaG9va18wLjEuYmINCj4gPiA+ID4gQEAgLTMyLDcgKzMyLDcgQEAg
U1JDX1VSSSArPQ0KPiA+ID4gPiAiZmlsZTovL2VuY3J5cHRfcGFydGl0aW9uLmVudi50bXBswqBc
DQo+ID4gPiA+IMKgIENSWVBUX1BBUlRJVElPTlMgPz89ICJob21lOi9ob21lOnJlZW5jcnlwdA0K
PiA+ID4gPiB2YXI6L3ZhcjpyZWVuY3J5cHQiDQo+ID4gPiA+IMKgICMgQ1JZUFRfQ1JFQVRFX0ZJ
TEVfU1lTVEVNX0NNRCBjb250YWlucyB0aGUgc2hlbGwgY29tbWFuZCB0bw0KPiA+ID4gPiBjcmVh
dGUNCj4gPiA+ID4gdGhlIGZpbGVzeXN0ZW0NCj4gPiA+ID4gwqAgIyBpbiBhIG5ld2x5IGZvcm1h
dHRlZCBMVUtTIFBhcnRpdGlvbg0KPiA+ID4gPiAtQ1JZUFRfQ1JFQVRFX0ZJTEVfU1lTVEVNX0NN
RCA/Pz0gIm1rZTJmcyAtdCBleHQ0Ig0KPiA+ID4gPiArQ1JZUFRfQ1JFQVRFX0ZJTEVfU1lTVEVN
X0NNRCA/Pz0gIi91c3Ivc2Jpbi9ta2UyZnMgLXQgZXh0NCINCj4gPiA+ID4gwqAgIyBUaW1lb3V0
IGZvciBjcmVhdGluZyAvIHJlLWVuY3J5cHRpbmcgcGFydGl0aW9ucyBvbiBmaXJzdA0KPiA+ID4g
PiBib290DQo+ID4gPiA+IMKgIENSWVBUX1NFVFVQX1RJTUVPVVQgPz89ICI2MDAiDQo+ID4gPiA+
IMKgICMgV2F0Y2hkb2cgdG8gc2VydmljZSBkdXJpbmcgdGhlIGluaXRpYWwgc2V0dXAgb2YgdGhl
IGNyeXB0bw0KPiA+ID4gPiBwYXJ0aXRpb25zDQo+ID4gPiANCj4gPiA+IERvIHdlIGhhdmUgYm90
aCBhbHJlYWR5PyBBbHNvIGluIGNhc2Ugb2YgdGhlIGlzYXItY2lwLWNvcmUNCj4gPiA+IGdlbmVy
YXRlZA0KPiA+ID4gaW1hZ2VzLCBvciBvbmx5IHdpdGggYWRkaXRpb25hbCBjdXN0b21pemF0aW9u
cyBvZiB0aGUgaW5pdHJhbWZzPw0KPiA+ID4gSnVzdCB0bw0KPiA+ID4gdW5kZXJzdGFuZCB3aGVu
IHRoaXMgaXNzdWUgaXMgY3VycmVudGx5IHZpc2libGUuDQo+ID4gDQo+ID4gY2lwLWNvcmUgZG9l
cyBub3QgaW5jbHVkZSBidXN5Ym94IGluIHRoZSBpbml0cmFtZnMgLSB0aGVyZWZvcmUgdGhpcw0K
PiA+IHdhcw0KPiA+IG92ZXJsb29rZWQuDQo+IA0KPiBPaywgc28gdGhlIHBhdGggc2hvdWxkIGJl
IGFkanVzdGVkLg0KPiANCj4gQnV0IG5vdyBJJ20gd29uZGVyaW5nIHdoeSB0byBzcG90cyBoYXZl
IHRvIGJlIGNoYW5nZWQuIFRoZSBzY3JpcHQNCj4gY2hlY2tzDQo+IGZvciBjcmVhdGVfZmlsZV9z
eXN0ZW1fY21kLCBtZWFucyBDUllQVF9DUkVBVEVfRklMRV9TWVNURU1fQ01ELCBiZWluZw0KPiB6
ZXJvIGFuZCBmYWxscyBiYWNrIHRvIHRoZSBzdGFuZGFyZCBjcmVhdGlvbi4gQnV0IHRoZW4gd2Ug
aGF2ZSB0aGUNCj4gc3RhbmRhcmQgY29tbWFuZCBhbHNvIGluIHRoZSByZWNpcGUuIE9uZSBzaG91
bGQgZ28sIGFsc28gdG8gYXZvaWQNCj4gbWlzdGFrZXMgbGlrZSBkb25lIGJ5IHRoaXMgcGF0Y2gu
DQoNClNob3VsZCB3ZSBqdXN0IGRlbGV0ZSB0aGUgY29uZGl0aW9uIGFib3ZlIHdpdGhpbg0KZW5j
cnlwdF9wYXJ0aXRpb24uc3lzdGVtZC5zY3JpcHQgLSBzaW5jZSB0aGUgZGVmYXVsdCB2YWx1ZSBp
cyBhbHdheXMNCnNldD8gT3IgYXJlIHRoZXIgY2FzZXMsIHRoYXQgZG8gbm90IHVzZSB0aGUgaW5p
dHJhbWZzLWNyeXB0LWhvb2tfMC4xLmJiDQphbmQgYnJpbmcgaW4gb3duIGN1c3RvbWl6YXRpb25z
IHRoYXQgbWlnaHQgZmFpbCBhZnRlciBkcm9wcGluZyBpdD8NCg0KPiANCj4gSmFuDQo+IA0KDQot
LSANClN0ZWZhbiBLb2NoDQpTaWVtZW5zIEFHDQp3d3cuc2llbWVucy5jb20NCg==

