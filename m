Return-Path: <SRS0=f7Jy=JF=lists.cip-project.org=bounce+64572+6346+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C04CC433ED
	for <cip-dev@archiver.kernel.org>; Thu,  8 Apr 2021 01:56:10 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF15D61182
	for <cip-dev@archiver.kernel.org>; Thu,  8 Apr 2021 01:56:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF15D61182
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6346+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id JGryYY4521723xi1FuErHdt2; Wed, 07 Apr 2021 18:56:09 -0700
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.156])
 by mx.groups.io with SMTP id smtpd.web10.2285.1617846967090012149
 for <cip-dev@lists.cip-project.org>;
 Wed, 07 Apr 2021 18:56:08 -0700
X-Received: by mo-csw.securemx.jp (mx-mo-csw1114) id 1381tusF002712; Thu, 8 Apr 2021 10:55:56 +0900
X-Iguazu-Qid: 2wHHssSnbVVbDzWI7U
X-Iguazu-QSIG: v=2; s=0; t=1617846955; q=2wHHssSnbVVbDzWI7U; m=E+Hrn0dOHsGPSP3En1dYKg6tmQG3A/iZzczGJuqXQYM=
X-Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1112) id 1381tsLm001767
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 8 Apr 2021 10:55:54 +0900
X-Received: from enc01.toshiba.co.jp (enc01.toshiba.co.jp [106.186.93.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by imx2-a.toshiba.co.jp (Postfix) with ESMTPS id 4BC631000DF;
	Thu,  8 Apr 2021 10:55:54 +0900 (JST)
X-Received: from hop001.toshiba.co.jp ([133.199.164.63])
	by enc01.toshiba.co.jp  with ESMTP id 1381trB8030708;
	Thu, 8 Apr 2021 10:55:54 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oYZhThdcBlXFASPq5g1Dnk0kqdV2vvPZacT7oXNaPr1wpBToK0nJ1nmsiIbzBCLUYbpCqfFDln0QIx6yir2QqD64CLuNfT/9LwJM2ipx+5G7sqQ/GJt20NRgqAPr3+ved2ZtTiu/ytqIaqvqhpdMNf3Do62FnDXtRV+RhSOOcszzqldZmCX0racZ3nISljQVz63PNObJBaBvvwlIvc24AdkKaP88GK4n5IKeQb4iickQrFgcdAmpzzrb90x6E2N31PXL3JU0/7exk/bUfbw9At1PyfWDL9acztXwgBuuri0/WfTJWswwZ08gNH+qt2KeAVJEzksnrXwZduY/fPoW5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y1/MEC4yshoMv3/gtvJ1X5ewzDXujvIO67EkleXRzOk=;
 b=GvDBxpsRtKaueiIAEFicZ5LPlXkhEOlUXefCc0CB/WLVC8f/DKmnjrtCXOGDFN+HjEDQdsv5FgklOVSjwlN1dSTS1oc3bJYkxatWJHbSWzBuyYv/IK5K5Gz0Bvwzv/Ujo2g/dclNPsQT0pQH7mgQOT3LzcBxYfBblOp5tUWTQkFk4AAq9wIf8RQYCUaUi02oBZyV1WwIM+YQUqnW7OQ4MH7S/nX8QEl6tV4Z9NPxMaiobjILj/oJWSuPZys51mR5wTj4vrfIzpK9LKbwUanx7lDo09+TsLRrCE296GtPKYZo5zm+IwnCgfGd1Xjbxu0ohPEnI4JEICPxzTLv7ZDJXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: "Nobuhiro Iwamatsu" <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>, <jan.kiszka@siemens.com>,
        <minmin@plathome.co.jp>
CC: <pavel@denx.de>, <wens@csie.org>
Subject: Re: [cip-dev] [Feedback Requested] RE: Cip-kernel-sec Updates for Week of 2021-03-18
Thread-Topic: [cip-dev] [Feedback Requested] RE: Cip-kernel-sec Updates for
 Week of 2021-03-18
Thread-Index: Adcb155JKC5WxfCIQN+IRDjOQ0ZrGgAvwuCAAAEsNoAD36bk4A==
Date: Thu, 8 Apr 2021 01:55:51 +0000
X-TSB-HOP: ON
Message-ID: <OSBPR01MB2983E7B807513366EE13257392749@OSBPR01MB2983.jpnprd01.prod.outlook.com>
References: <TY2PR01MB4972E1E07AE85D162237E83CA0699@TY2PR01MB4972.jpnprd01.prod.outlook.com>
 <d111661c-cdda-3031-66e3-054a5cdcc943@siemens.com>
 <TY2PR01MB4972F52002A1794994A0EEF6A0689@TY2PR01MB4972.jpnprd01.prod.outlook.com>
In-Reply-To: <TY2PR01MB4972F52002A1794994A0EEF6A0689@TY2PR01MB4972.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
x-originating-ip: [103.91.184.0]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8ced1875-2dda-4f2b-1f2c-08d8fa31704e
x-ms-traffictypediagnostic: OSAPR01MB3778:
x-microsoft-antispam-prvs: <OSAPR01MB3778F0445ADAAA2E12B3CB4D92749@OSAPR01MB3778.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 4u0zaQmvOrTFvoYvIjXVa47vZN0gi9D5wT3q264tijW/cHdTo5VXk2hGhlXoyPRxlbErRwhkmjlz/Aag433Mb39aAJH/L6ftKNKIQwt7cTZQmHWhjORlML/eyzSNEKGyYduNB9M/qJ602x7b747UL9XAk3nQjUGmN5jLUKCy3WNKvMPF6QXNUtHGUjm0ZI7SUZJAIIdmPYTYJOz29MHCtMGRT8EBTV0uvllsZvEZVOqWIQ6/qlmB/CcniNQqvVJIoA3kdx8ack3T8iJJDPcqnWvWNoLYWG2Le6Hnc4v1ceuogKDEb11OgF0EttjtJwJ9nHqzDP3j9Ga0msswUwUSTfieZVvNl1Rakv1CYYmKb+MwCu7hCr8gzz3fgc3F9vPHcTzVaSuaVYNnu2X3dA7xsopKikOm5NxbA4+KHE4UpaJvdDIAwG9KMEzOaScPyDY2hxJlfBAf5qS3d3ZIfO8yMAI7JE4ygif8j8EuEt36ScTt78mrUaqCKbMuaMw5kwSBhIw4hmPc2Mm8B5Be0VZGc9L3e6egU5jeNYX1h3URBT2Qxp56UPEKvcFH5I4ovVXVnxLhzVHQft2FWseNJizf5Yze7fKA7Cl61PuklCn9XmxH/Lt7aO7OYwvEXc84Bqtfo5Io7T7v9pNJ9ZjjQ4uil/tITFwbUbPbivjMj3EB7H2PtT43i62I4QqKmNKwauln+Ej9m0btpEPRB1K9u4PClS8zXWOVn0t1PN9tlTS5QBvdHhm1bvONpDMNnTbTEWBn
x-ms-exchange-antispam-messagedata: =?utf-8?B?SkZDMzdSdi9MMWVvajRERTVGWnRIYTB1T2tmM3g5ZW1XYXdMdk8vNzlXWTE3?=
 =?utf-8?B?eGE3bUxseUdEZ1JZQWl5N3RHKzE4Y25JV3VsbTJFNy9oRTNEVDNvUXFTMWpl?=
 =?utf-8?B?RnFVMWdXaWJQc1Ztai9XaDdUWG10Vi9adUh3bUwvQkd4MGl4dVFSK2phOUt2?=
 =?utf-8?B?ZHZsOFBEczQ4dENJaXYyMHpteDUrSm94OHJPN0NyV3UwNENRS0MraUVkeU1j?=
 =?utf-8?B?YSt6RGJ4Ti9Xb25VN3hmd2NIMjI3V29CMnJ1YTh2QWRUM1lza1pWRVFOdlhm?=
 =?utf-8?B?Yk1pb0hHakJGS0tvUHpsSUJTWUppekMwVmplL29YUmRHTUx0TUtVdXlnVDlZ?=
 =?utf-8?B?RmdDck9PeTlQTGVuUEhHemNqNFI1bkhHclNHalpIRW5reEdHY3p2VzJQUDh0?=
 =?utf-8?B?V1d2QVN1MjhXdG0zZmlmaEprSHcrZE9oK3JmOUVQN0JGMUlXSUlzelVJQlRn?=
 =?utf-8?B?MFFvQW1iYnFiQnlaNHU4TXBNbmNvbDI3dys1MEJhckQ5VS9Za0JoWlc0U3hw?=
 =?utf-8?B?b2JmNHd1bHlqblAycEFXYjZ6RGlQczZRT1M1TmRZSnZ5S3VqcDZ0azJoSVFt?=
 =?utf-8?B?VFpzNDl4YmQ1NUxSQnV3THVtb0MzRHpPMWtUUEVOSFJJVndzZ3R5RGZFUzJx?=
 =?utf-8?B?QmVKK2RZbzlMTURmNlpzWnJUSjNHMHYwNEJQbE91d0lxYU82YXdCQWludXdS?=
 =?utf-8?B?YWxpWEszMkxDL3ZSVW4xSUM2NEYyZW9RSU9BZnkzMW9uellSNUt1RFJRMmVY?=
 =?utf-8?B?a0R2bm8rMmp2aDVJZGp4ZnVqbk4vQzJRUGo4cGsxK0JNbFVwNituVU5jUHl4?=
 =?utf-8?B?L3VBRzF4Rm1Ecy9kQnF0RGFXbW9HTW51bGdGWi92cFdoTGQ4NXladHNxN3Bo?=
 =?utf-8?B?ekp2OVpOZXdPblNtQk5WdzRtUFNnK0QzZDRESUxNSmlUUm9XU3RxZG94dnV2?=
 =?utf-8?B?SmxaWnZQaGdmdUllU2kxOGxEc21nMlBCcUdvcU9xdzZxODMzeUkxVSsxNjBy?=
 =?utf-8?B?ak93U0Ntc2lteXZTWkpVY3h5SitDSVQvVkJFbktrUmNxMXkvVnE5cFZobWhQ?=
 =?utf-8?B?TEdqajJCRG93aUhabStYQ0t4azV5SlN0UngyQVp1SXdlZ1pYTXdzaHU4UUhv?=
 =?utf-8?B?OVk0ZkpXNWZwUlFXTmlkcTR0OXl0b3pLTE9oZ1R2OWpDa2p6T1d4MHMyNFFY?=
 =?utf-8?B?ZmdQeGx2NldBS2JVV0lucWduUE4zb0t0czRGOW9TRjlDZHZNU2Z6Z2p1TXRh?=
 =?utf-8?B?cU5ld3JvdERoS2ZZSS9OaFlXc0Z6YVFJdExCcjNjM3lHZy9MVW9mR3YyV0oz?=
 =?utf-8?B?VlhEOU90czdHV29zKzVibFFlVU5aWVBjRkRhSWZ5VUU0Tkl0U052bEJ6UFZJ?=
 =?utf-8?B?TGpBdUQrZDN3UzdqcXhTcFBYM1U5cFdxOFRMYkRNcmVQM0Vyc2NwWVRaRGNt?=
 =?utf-8?B?M2lReUFsb1lKaHYrWFlEYXpLRVFpNlQ1bElHaTJKRVdvdy9OL3BjcEVNTEJq?=
 =?utf-8?B?akI3aitYYTFxcHQ4U2pMWitvazhBTURyK1RDditmalJMVUhRTlMweUljZTds?=
 =?utf-8?B?YW5vWkx2OXoxalFRRDNRSVMrZ2daNDFMOTJiQUZQcEZyUUtzZEFJVGY3WDZm?=
 =?utf-8?B?V2RPS0Q4aXh1K3ppYzFkWkE4UmgxczRDdGFVWDlGbm51bWRrd3NNaUw5cTJZ?=
 =?utf-8?B?SythQ21zUUJrYlhFL21RQzB4Q2orVWU3enBWbnZhSmxUdTVXY3lJUndPZ2ZJ?=
 =?utf-8?Q?+uGeFyKFiyN6WNi9Lk=3D?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2983.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ced1875-2dda-4f2b-1f2c-08d8fa31704e
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2021 01:55:51.6065
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qhxwx6mwCUu0J9X9I++3iRlX7E+1BiEel1BfHxK1AKKMHLmh+WIPEknY84xD41f9asRv33LkvWXp2ZMa86r99S1DBlCLAWXgUm0a1sKTRrbel9z3NLZ0C89hGhjEYzLe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB3778
MSSCP.TransferMailToMossAgent: 103
X-OriginatorOrg: toshiba.co.jp
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: WlJWQguLSTVNYkthUH4UThzOx4520388AA=
Content-Type: multipart/mixed; boundary="HBgL0RmcLZffsy7n5oRC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1617846969;
 bh=ZYp2LCrzzi7MlE180OfLxHkNW87aZm6zoYCErR1oGHI=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=KJtG0Ly9lqxVOKv/fI8O1ibtDt3NRIhRCDJo/rxfurvgiT3MafEgAxD06gf5dQEpgGo
 7U53OAMKvNnSBxyc5yjsM0PnTC/3kyLRLdvgqolLektQvZ/OXCavU6nNfZ+5qoBM/bNju
 RyYCLRv7HGrtuARqHJkigt1Qj0RM7ONsZWY=

--HBgL0RmcLZffsy7n5oRC
Content-Language: ja-JP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGkgYWxsLA0KDQpJIGRyb3BwZWQgZWFjaCBjb25maWcgZnJvbSBjb25maWcgZmlsZXMuDQoNCkJl
c3QgcmVnYXJkcywNCiAgTm9idWhpcm8NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0K
PiBGcm9tOiBjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZyBbbWFpbHRvOmNpcC1kZXZAbGlz
dHMuY2lwLXByb2plY3Qub3JnXSBPbiBCZWhhbGYgT2YNCj4gbWFzYXNoaS5rdWRvQGN5YmVydHJ1
c3QuY28uanANCj4gU2VudDogRnJpZGF5LCBNYXJjaCAxOSwgMjAyMSA1OjQ4IFBNDQo+IFRvOiBq
YW4ua2lzemthQHNpZW1lbnMuY29tOyBtaW5taW5AcGxhdGhvbWUuY28uanA7IGNpcC1kZXZAbGlz
dHMuY2lwLXByb2plY3Qub3JnDQo+IENjOiBwYXZlbEBkZW54LmRlOyBpd2FtYXRzdSBub2J1aGly
byjlsqnmnb4g5L+h5rSLIOKWoe+8s++8t++8o+KXr++8oe+8o++8tCkgPG5vYnVoaXJvMS5pd2Ft
YXRzdUB0b3NoaWJhLmNvLmpwPjsgd2Vuc0Bjc2llLm9yZw0KPiBTdWJqZWN0OiBSZTogW2NpcC1k
ZXZdIFtGZWVkYmFjayBSZXF1ZXN0ZWRdIFJFOiBDaXAta2VybmVsLXNlYyBVcGRhdGVzIGZvciBX
ZWVrIG9mIDIwMjEtMDMtMTgNCj4gDQo+IEhpLCBKYW4tc2FuLA0KPiANCj4gVGhhbmtzIGZvciB5
b3VyIGNvbmZpcm1hdGlvbiENCj4gDQo+IEl3YW1hdHN1LXNhbiwNCj4gDQo+IENvdWxkIHlvdSB0
dXJuIG9mZiBib3RoIGZlYXR1cmVzIGZyb20gdGhlIGZvbGxvd2luZyBjb25maWdzPw0KPiANCj4g
PiA+IC0gQ1ZFLTIwMjAtMzU1MTkgaXMgcmVsYXRpbmcgdG8gWC4yNS4NCj4gPiA+PiAgICAgNC4x
OS55LWNpcC1ydC94ODYvc2llbWVuc19pMzg2LXJ0LmNvbmZpZzpDT05GSUdfWDI1PW0NCj4gPiA+
PiAgICAgNS4xMC55LWNpcC1ydC94ODYvc2llbWVuc19pMzg2LXJ0X2RlZmNvbmZpZzpDT05GSUdf
WDI1PW0NCj4gPiA+IC0gQ1ZFLTIwMjEtMjAyNjEgaXMgcmVsYXRpbmcgdG8gZmxvcHB5Lg0KPiA+
ID4+ICAgICA0LjQueS1jaXAtcnQveDg2L3NpZW1lbnNfaTM4Ni1ydC5jb25maWc6Q09ORklHX0JM
S19ERVZfRkQ9bQ0KPiANCj4gQmVzdCByZWdhcmRzLA0KPiAtLQ0KPiBNLiBLdWRvDQo+IA0KPiA+
IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gRnJvbTogSmFuIEtpc3prYSA8amFuLmtp
c3prYUBzaWVtZW5zLmNvbT4NCj4gPiBTZW50OiBGcmlkYXksIE1hcmNoIDE5LCAyMDIxIDU6MDYg
UE0NCj4gPiBUbzog5bel6Jek44CA6ZuF5Y+477yIQ1RK44CAT1NT5LqL5qWt5o6o6YCy5a6k77yJ
IDxtYXNhc2hpLmt1ZG9AY3liZXJ0cnVzdC5jby5qcD47DQo+ID4gbWlubWluQHBsYXRob21lLmNv
LmpwOyBjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZw0KPiA+IENjOiBwYXZlbEBkZW54LmRl
OyBub2J1aGlybzEuaXdhbWF0c3VAdG9zaGliYS5jby5qcDsgd2Vuc0Bjc2llLm9yZw0KPiA+IFN1
YmplY3Q6IFJlOiBbRmVlZGJhY2sgUmVxdWVzdGVkXSBSRTogQ2lwLWtlcm5lbC1zZWMgVXBkYXRl
cyBmb3IgV2VlayBvZg0KPiA+IDIwMjEtMDMtMTgNCj4gPg0KPiA+IE9uIDE4LjAzLjIxIDEwOjMz
LCBtYXNhc2hpLmt1ZG9AY3liZXJ0cnVzdC5jby5qcCB3cm90ZToNCj4gPiA+IEhpLCBKYW4tc2Fu
LCBNaW5kYS1zYW4sDQo+ID4gPg0KPiA+ID4gUGxlYXNlIGZpbmQgdGhlIENWRSByZXBvcnQgYXMg
Zm9sbG93cy4NCj4gPiA+IEluIHRoZSBhbmFseXNpcyBvZiB0aG9zZSBDVkVzLCB3ZSBmb3VuZCBz
b21lIGRvdWJ0cyBhYm91dCB0aGUgY29uZmlncy4NCj4gPiA+DQo+ID4gPiAtIENWRS0yMDIwLTM1
NTE5IGlzIHJlbGF0aW5nIHRvIFguMjUuDQo+ID4gPiBYLjI1IGlzIGVuYWJsZWQgYXMgZm9sbG93
cywgYnV0IHdlIHdvbmRlciB3aGV0aGVyIFguMjUgaXMgcmVhbGx5IHVzZWQgb3Igbm90Lg0KPiA+
ID4+ICAgICA0LjQueS1jaXAveDg2L3BsYXRob21lX29ic3Z4MS5jb25maWc6Q09ORklHX1gyNT1t
DQo+ID4gPj4gICAgIDQuMTkueS1jaXAtcnQveDg2L3NpZW1lbnNfaTM4Ni1ydC5jb25maWc6Q09O
RklHX1gyNT1tDQo+ID4gPj4gICAgIDUuMTAueS1jaXAtcnQveDg2L3NpZW1lbnNfaTM4Ni1ydF9k
ZWZjb25maWc6Q09ORklHX1gyNT1tDQo+ID4gPg0KPiA+ID4gUGxlYXNlIGNvbmZpcm0sIGFuZCBs
ZXQgdXMga25vdyB3aGV0aGVyIFguMjUgc2hvdWxkIGJlIGRpc2FibGVkLg0KPiA+ID4NCj4gPiA+
IC0gQ1ZFLTIwMjEtMjAyNjEgaXMgcmVsYXRpbmcgdG8gZmxvcHB5Lg0KPiA+ID4gSXQgaXMgZW5h
YmxlZCBhcyBmb2xsb3dzLg0KPiA+ID4+ICAgICA0LjQueS1jaXAtcnQveDg2L3NpZW1lbnNfaTM4
Ni1ydC5jb25maWc6Q09ORklHX0JMS19ERVZfRkQ9bQ0KPiA+ID4NCj4gPiA+IFBsZWFzZSBjb25m
aXJtIHRoYXQgdGhpcyBjYW4gYmUgYWxzbyBkaXNhYmxlZC4NCj4gPiA+DQo+ID4NCj4gPiBZZXMs
IGJvdGggZmVhdHVyZXMgY2FuIGJlIHR1cm5lZCBvZmYuDQo+ID4NCj4gPiBUaGFua3MsDQo+ID4g
SmFuDQo+ID4NCj4gPiA+IEJlc3QgcmVnYXJkcywNCj4gPiA+IC0tDQo+ID4gPiBNLiBLdWRvDQo+
ID4gPg0KPiA+ID4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gPj4gRnJvbTogQ2hl
bi1ZdSBUc2FpIDx3ZW5zQGNzaWUub3JnPg0KPiA+ID4+IFNlbnQ6IFRodXJzZGF5LCBNYXJjaCAx
OCwgMjAyMSA1OjQ4IFBNDQo+ID4gPj4gVG86IGNpcC1kZXZAbGlzdHMuY2lwLXByb2plY3Qub3Jn
DQo+ID4gPj4gQ2M6IFBhdmVsIE1hY2hlayA8cGF2ZWxAZGVueC5kZT47IE5vYnVoaXJvIEl3YW1h
dHN1DQo+ID4gPj4gPG5vYnVoaXJvMS5pd2FtYXRzdUB0b3NoaWJhLmNvLmpwPjsg5bel6Jek44CA
6ZuF5Y+477yIQ1RK44CAT1NT5LqL5qWt5o6o6YCy5a6k77yJDQo+ID4gPj4gPG1hc2FzaGkua3Vk
b0BjeWJlcnRydXN0LmNvLmpwPg0KPiA+ID4+IFN1YmplY3Q6IENpcC1rZXJuZWwtc2VjIFVwZGF0
ZXMgZm9yIFdlZWsgb2YgMjAyMS0wMy0xOA0KPiA+ID4+DQo+ID4gPj4gSGkgZXZlcnlvbmUsDQo+
ID4gPj4NCj4gPiA+PiBTaXggbmV3IGlzc3VlcyB0aGlzIHdlZWsgZnJvbSB0aGUgVWJ1bnR1IHRy
YWNrZXI6DQo+ID4gPj4NCj4gPiA+PiAtIENWRS0yMDIwLTM1NTE5IFtuZXQveDI1OiBidWZmZXIg
b3ZlcmZsb3ddIC0gZml4ZWQNCj4gPiA+PiAgIExvb2tzIGxpa2UgYSBmZXcgY29uZmlncyBzdGls
bCBoYXZlIFguMjUgZW5hYmxlZDoNCj4gPiA+PiAgICAgNC40LnktY2lwL3g4Ni9wbGF0aG9tZV9v
YnN2eDEuY29uZmlnOkNPTkZJR19YMjU9bQ0KPiA+ID4+ICAgICA0LjE5LnktY2lwLXJ0L3g4Ni9z
aWVtZW5zX2kzODYtcnQuY29uZmlnOkNPTkZJR19YMjU9bQ0KPiA+ID4+ICAgICA1LjEwLnktY2lw
LXJ0L3g4Ni9zaWVtZW5zX2kzODYtcnRfZGVmY29uZmlnOkNPTkZJR19YMjU9bQ0KPiA+ID4+ICAg
TWF5YmUgdGhleSBzaG91bGQgYmUgcmV2aXNpdGVkPyBjaXAta2VybmVsLWNvbmZpZyBhbHNvIGdp
dmVzIHdhcm5pbmdzDQo+ID4gPj4gICBmb3IgQ09ORklHX1gyNS4NCj4gPiA+Pg0KPiA+ID4+IC0g
Q1ZFLTIwMjEtMjAyMTkgW2ltcHJvcGVyIHN5bmNocm9uaXphdGlvbiBpbiBmbHVzaF90b19sZGlz
YygpXSAtDQo+ID4gPj4gbGlrZWx5IFJlZEhhdCBvbmx5DQo+ID4gPj4gICBSZXBvcnQgbWVudGlv
bnMgaW5jb3JyZWN0IGJhY2twb3J0IGluIFJlZEhhdCBrZXJuZWxzLg0KPiA+ID4+DQo+ID4gPj4g
LSBDVkUtMjAyMS0yMDI2MSBbZmxvcHB5OiByYWNlIGNvbmRpdGlvbiBkYXRhIGNvcnJ1cHRpb25d
IC0gZml4ZWQNCj4gPiA+PiAgIE5vIG1lbWJlciBlbmFibGVzIHRoaXMgZXhjZXB0Og0KPiA+ID4+
ICAgICA0LjQueS1jaXAtcnQveDg2L3NpZW1lbnNfaTM4Ni1ydC5jb25maWc6Q09ORklHX0JMS19E
RVZfRkQ9bQ0KPiA+ID4+ICAgd2hpY2ggc2hvdWxkIHByb2JhYmx5IGJlIHR1cm5lZCBvZmYuDQo+
ID4gPj4NCj4gPiA+PiAtIENWRS0yMDIxLTI4Mzc1IFtmYXN0cnBjOiBhbGxvd3Mgc2VuZGluZyBr
ZXJuZWwgUlBDc10gLSBmaXhlZA0KPiA+ID4+ICAgTm8gbWVtYmVyIGVuYWJsZXMgdGhpcy4NCj4g
PiA+Pg0KPiA+ID4+IC0gQ1ZFLTIwMjEtMjg2NjAgW3J0bDgxODhldTogYXJyYXkgYWNjZXNzIG91
dC1vZi1ib3VuZHNdIC0gZml4ZWQNCj4gPiA+PiAgIE5vIG1lbWJlciBlbmFibGVzIHRoaXMuDQo+
ID4gPj4NCj4gPiA+PiAtIENWRS0yMDIxLTM0MjggW2ludGVnZXIgb3ZlcmZsb3cgaW4gZXh0NF9l
c19jYWNoZV9leHRlbnRdIC0gdW5jbGVhciBbMV0NCj4gPiA+PiAgIFJlcXVpcmVzIGEgc3BlY2lh
bGx5LWNyYWZ0ZWQgZXh0NCBGUyBpbWFnZSwgc28gd2UgbGlrZWx5IGRvbid0IGNhcmUuDQo+ID4g
Pj4NCj4gPiA+PiBVbmZvcnR1bmF0ZWx5IERlYmlhbidzIFNhbHNhIHNlcnZpY2UsIHdoZXJlIHRo
ZSBEZWJpYW4ga2VybmVsDQo+ID4gPj4gc2VjdXJpdHkgaXNzdWUgdHJhY2tlciBpcyBob3N0ZWQs
IGlzIGN1cnJlbnRseSBkb3duLCBzbyB3ZSBvbmx5IGhhdmUgb25lIHNvdXJjZQ0KPiA+IG9mIGRh
dGEgdGhpcyB3ZWVrLg0KPiA+ID4+DQo+ID4gPj4NCj4gPiA+PiBSZWdhcmRzDQo+ID4gPj4gQ2hl
bll1DQo+ID4gPj4NCj4gPiA+Pg0KPiA+ID4+IFsxXQ0KPiA+ID4+IGh0dHBzOi8vbG9yZS5rZXJu
ZWwub3JnL3N0YWJsZS8yMDIxMDMxNzE1MTgzNC5HRTI1NDFAcXVhY2syLnN1c2UuY3ovDQo+ID4N
Cj4gPg0KPiA+IC0tDQo+ID4gU2llbWVucyBBRywgVCBSREEgSU9UDQo+ID4gQ29ycG9yYXRlIENv
bXBldGVuY2UgQ2VudGVyIEVtYmVkZGVkIExpbnV4DQo=

--HBgL0RmcLZffsy7n5oRC
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6346): https://lists.cip-project.org/g/cip-dev/message=
/6346
Mute This Topic: https://lists.cip-project.org/mt/81425316/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--HBgL0RmcLZffsy7n5oRC--
