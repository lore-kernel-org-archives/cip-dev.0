Return-Path: <SRS0=fFpj=OG=lists.cip-project.org=bounce+64572+6740+4520388+10495289@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9438EC433EF
	for <cip-dev@archiver.kernel.org>; Thu, 16 Sep 2021 04:56:20 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6E7B611CE
	for <cip-dev@archiver.kernel.org>; Thu, 16 Sep 2021 04:56:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E6E7B611CE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id tmvEYY4521723xCqwKYs05kx; Wed, 15 Sep 2021 21:56:19 -0700
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.154])
 by mx.groups.io with SMTP id smtpd.web09.6883.1631768176800716280
 for <cip-dev@lists.cip-project.org>;
 Wed, 15 Sep 2021 21:56:18 -0700
X-Received: by mo-csw.securemx.jp (mx-mo-csw1515) id 18G4uEvA024656; Thu, 16 Sep 2021 13:56:14 +0900
X-Iguazu-Qid: 34tr8rsmqvvo2yGINm
X-Iguazu-QSIG: v=2; s=0; t=1631768173; q=34tr8rsmqvvo2yGINm; m=POYgeKeTm6oWRiCxuieLwz/JX6lLIC9nE/DUY+BPiFs=
X-Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1513) id 18G4uDY5000983
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 16 Sep 2021 13:56:13 +0900
X-Received: from enc01.toshiba.co.jp (enc01.toshiba.co.jp [106.186.93.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by imx2-a.toshiba.co.jp (Postfix) with ESMTPS id 1021C100155
	for <cip-dev@lists.cip-project.org>; Thu, 16 Sep 2021 13:55:52 +0900 (JST)
X-Received: from hop001.toshiba.co.jp ([133.199.164.63])
	by enc01.toshiba.co.jp  with ESMTP id 18G4tpNk027313
	for <cip-dev@lists.cip-project.org>; Thu, 16 Sep 2021 13:55:51 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cLhHs1HFwK/KM7YQAqp+BhDDwGPf/bvGxIyPwXEES6z79Cxmjx3AMpr7yIbe9O8zjDOSzZuMGJoppGOPzgwwWGjpyA/FvsQ9VmwzUZnh8PCWXhSFDJuAaESAaLXKD0dgUhgBOswXHQIb+VKs1M5Vt5638V7mPrKYTCNhMM6a435tsQfRKoQ2o4JQT4BeWgkKRGN745RmeBAO2gMa2KWfJPOc9qKhgxiWDDC8BBs2Uo8YNk3SLja+w0i8hKAk9hQtFoYmtQf8ViI+EVlWMwhXTjH5P/8l93Bo5RPJAzmCLKuzVmzM+jJdOUMNcz6nDMPvM5XpjTY79fzxhKmmg54PTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=A4QqLMGbvcLDT17qwb4DPZ9hfEMMuXMAC6s2B2sP5yo=;
 b=RmTapKwpI8xYrxC6BltxM2ol1Y6D/khUrdVs1y5NquKBv/Y7zyc8jCQeKJRdKWqX8pkLJBkATzh41T16h3sUYQozoHZatmn7qUdzCuJXUFAFT5YECokIBJPcD+8f7T0q5W7AD3v/Oe2G1p03bIg72xfQqijpJhdPS/tLktch81/DzYrYNXYNbxjeqB2uPzG1KgT/Tv9/qOS5eIokBnI/KjSpKYY5o+mSnB0stNppAN9rhatxNEIqdaZl2mjyXP+595ydNoFZUuRzRCCQADa+fmypdwPlXqThe1lZLw8nI7Cnjy3fb86YCEQSHmn2eTkbDGpL3kXGoNioGSpK2zTLIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: "Nobuhiro Iwamatsu" <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
Subject: Re: [cip-dev] New CVE entry this week
Thread-Topic: [cip-dev] New CVE entry this week
Thread-Index: AQHXqpQdshsl+ylRR0ajowFSSZMSe6umFTig
Date: Thu, 16 Sep 2021 04:55:49 +0000
X-TSB-HOP: ON
Message-ID: <TYAPR01MB62524576B76503DEBD3EDF6892DC9@TYAPR01MB6252.jpnprd01.prod.outlook.com>
References: <CAODzB9rpFGi8xKkocVfEy-4wJFfR9AwkebC9kSrO3W=zK_PsTQ@mail.gmail.com>
In-Reply-To: <CAODzB9rpFGi8xKkocVfEy-4wJFfR9AwkebC9kSrO3W=zK_PsTQ@mail.gmail.com>
Accept-Language: ja-JP, en-US
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cea7c065-049a-4128-865a-08d978ce40c1
x-ms-traffictypediagnostic: TYYPR01MB6586:
x-microsoft-antispam-prvs: <TYYPR01MB6586B1A1E44294A38106909892DC9@TYYPR01MB6586.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:751;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam-message-info: 12BbbH2ENeTrhnmkBDqOxwDTc9vlleDXF6GZVTcwKHju+gbOXS5hU6rbTfvdWXIhV+HUipCKvyhsKcY0yJKMxhGw1BbtPZu+WSxWh77Ky2QNYxBrLG4/6HMteQn+7PjnaIGIkekUM/iey3w/l6w/OrRcCAXkjMo8IJMJT++dwDrWlugOiVlSeAUqQFq6GdRqlmYeCPuDBYL1FOYPK+VKd7XJIgKa7TtQCI3ZWFstX48pbwudeztA4/0Nc1NgB2++NRjqmRsVswliESIFZcro+wYe/3huR9BK45FCAg74pMhEXZUr+3G1NoiwmXaAIndEb2ocqxpP1Q3GdVQMphQMEuJkIgQXpq+RTGBUMm+VKUbYwSoWLmrnpOhB5I7/Bkt9oHuSwjxWAtQu0qW/5qyGQYRHLEJmc/GL5MaUgc64dGkZiDBWa7PYeKUFMOZu7T1ZKEcPOZAaF76tN64VMsgKzgUY+PLQjKdR65Edj7Qdz85Kmfm00cRIpvA3jUeaGOD2L/Uz0jR0gNJQ6UkaZ8x80CCE3UlUTV6cFOLtTGkVL7kHBqtP1um/jbhLYflnhQI3G9v+kfnIYYVd6JemyYnMjI2PV/9ry7bYTSHyNe1OFRBdlbfx75N5q/0rLnUvblOrE8pEmt5ujGoSYi6eXiOLA1KQWun7GPw5QiSMD5H6nsctgCacEVHX2V/geRu557V4DCFQEIYNISWaYmlfFi1/i0GxmtpoWBUjJBfLW0PI+J1M3vmQaO2iqfhBRAv6wsocy8bjV64kpRE4V6F50wQX9G1adt6qiMZlqJh01kWo0N3BC2zGdwKaZdN03VrW4bGPOwfCEhCBhQ9Cw6FQq/aZ1w==
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ODFmSG1IeittWG9WQ0ovdVJlaUp4V1YrQ3JBelRDandpWHRlQVhIQzFTVjFs?=
 =?utf-8?B?ZjNWbUJkQ244T0RuaUhFYit2K09nc1M2WTZlYXlENklqY3NqeHhwSUhvRkpi?=
 =?utf-8?B?WmNqclQ1VjhIQzJFT3QwZitTTlduUE85MHBoTHRtT0hvaWVoYnJ0NUdpWHp6?=
 =?utf-8?B?QjBHdTlwS0FpN2I0bHMyRGpwNUhnWDBxN0IrVVplTFVrd0grdkRjOU1BanB4?=
 =?utf-8?B?aDhBRlFGMnhtc056REtNQTk4Tm16Ulo4elZGcDhQd3NMWkZjdDJmTEpCL21k?=
 =?utf-8?B?V1dOclZRMHpOTXFwcTgzcjBIb2JyZjBDdjYvSEhSS0JRK3BPL3FPVXMrK052?=
 =?utf-8?B?alZCVWcrNjF4eUhsaERrUzF0N3h3TmFueUNxeUVDMUUxMDBRWDRaWXk1TFE5?=
 =?utf-8?B?MXdlcVk4VW5PWmRJbkwyK2ZUN0ZWZE5EYy9xLzZkUWFlVEtZT1R4L25VUytH?=
 =?utf-8?B?MDJoeCtuanh3N2pZeDhMbW84SHZKTStyZlQxNEE3ekhVUFp4MWNEZkllWE8w?=
 =?utf-8?B?eGpxWW9GV1ZUK255K2lLUFljUEs4R1NPZmNscnR6NnRLYlVxd25vWEF0dGRI?=
 =?utf-8?B?RGc5K240TWEzN25TTjBkSGdTTU8xUFhMVVFFM2ErdkJVNy9YRjVjSDlTTk5m?=
 =?utf-8?B?M0NSeENwS3NtSmk0YmFQNjhoN0VkVlZCaGV0RWxjOWZQZ29YcGtkZld3Y25o?=
 =?utf-8?B?RlZTbjZmQkgrK1VkR3JrLytzRGlQVmNSeXJzWnFzV2Z4aXpOZlU0Z08xa1Jk?=
 =?utf-8?B?NmoxSDYxcnEvaHM3RWgrcE1BR0dzL2lBa2dCQXJMOG9qTVFVSERVdnU1TU5M?=
 =?utf-8?B?YzhHSFF3cUUzL05qWE1LbjJLMWFsaHRzRTVqTHIrbXRZdjNYdnRqWTJXUUwr?=
 =?utf-8?B?RkkyT0FncXZRUjZwK3pTK3JYdWhPWXVnbDRveDVtNHJWV1lUSWhNRHVjT2xN?=
 =?utf-8?B?Z0FIV2ZETk5qNmlRaWZNcFlLN1Y2Yy83OFJTQWk2YkJ1eFFHTXlxM0xLOW8w?=
 =?utf-8?B?Q1FBcHhHc2lvNlpoZ2VHRFVreTlIWnZGbmFlWG1lWFNjdHF5VGE4aEhnTTBW?=
 =?utf-8?B?a0JCNG96bzNDMVlIZlp3RFFYN0V1b0J3bmRFT3NJUjNkektsQmZBQzFtQXdy?=
 =?utf-8?B?cCtSVWw0ZWJHSUNPRlVtRko1NUp3blBxbFBrbVhmUUh4dnVhYVU2bXY1UW5I?=
 =?utf-8?B?M1BSY245SUV4aENjSFA2a0RmcXVjZzdGeW1reDN2ZHA5UUowRzVZY0swdlNt?=
 =?utf-8?B?eXRrd1YyQlVyNzh5TU0zc0psT2JVL1R2bmQwMTdoWm5za05DS0gwakNSdFYz?=
 =?utf-8?B?cnI3dHNBb09iRGRlRW5uM3hBbmwxUnkzaFRyMlFkMjBCdEZWZ1RqU1RmRzg0?=
 =?utf-8?B?aG5uOFpDalY3NmNiYlpTQytLbzF3NEpxQWtaRzZzeHc3SE1DV29wL3JFaHRn?=
 =?utf-8?B?WkY1eFhrWk50Q2JpaUVhTnN2cVgvSDlBNHV0MnR3MnBINVFCcEZabFplL1Zn?=
 =?utf-8?B?dlFTc2gvNDhWdHJFVCtHZXQ5cUpwcndLZGYrelFXSFpZYnhTbVYvdXJPeWlI?=
 =?utf-8?B?bmZzQWh5WWptNmRWRU5CSFR5cWYyWkNJSmwzMGtsSW0zY29PUGpxM3FudDgy?=
 =?utf-8?B?SGhpeHdZTWxSVE05ZkJKYzMvUmwzTU9aYWwvMnVVY2k0S3hvK1l6YjM0MHVr?=
 =?utf-8?B?dTB2RU5oOElPbFlwcXdTcXlSbUw5RWVQT0R5UHVkSjhzQjBGNE95bGEyS3hs?=
 =?utf-8?Q?1Ijf+5/Cl12NT6fCZeG+mnY7eegODUOee+yq93a?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB6252.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cea7c065-049a-4128-865a-08d978ce40c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2021 04:55:49.3889
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RrJ0Z4ILnhFxAfMvaKbUV1utn/PNT21PhVQDlmSr7gsSbR7oT/szIN4Ke4OfimvFpYgQ8evwwyQ92o/WMNcpXrIWvXJnWxtBodKCE4JpcMS1Xz75ySbB3pLKlJoxTJnG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB6586
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: pt9O1n7k26delCwh1sRxxaOgx4520388AA=
Content-Type: multipart/mixed; boundary="xwxCoyd0k5VZQVJVWmzu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1631768179;
 bh=uFXovd9DqL56dWo1qzKhtFHQgTDmJpdYBX8eM2Saz/M=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=lhbWKAu1nG62qIV2RlM6oGfioE3Dl5lEFfkikJ7fWRcusWfvxZcLYRkeY+JtnWP4woW
 1d2nz3l2gd1Y1J9SsxcgkRsA3FsflfxYLxk6dZxRJfHvy05z5k3RwLBZ/sfhDO96MNX2I
 rb0c30AihT+9lwvG13pz5x+YCL67RVG/OSQ=

--xwxCoyd0k5VZQVJVWmzu
Content-Language: ja-JP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGkgYWxsLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IGNpcC1kZXZA
bGlzdHMuY2lwLXByb2plY3Qub3JnIFttYWlsdG86Y2lwLWRldkBsaXN0cy5jaXAtcHJvamVjdC5v
cmddIE9uIEJlaGFsZiBPZiBNYXNhbWkgSWNoaWthd2ENCj4gU2VudDogVGh1cnNkYXksIFNlcHRl
bWJlciAxNiwgMjAyMSA5OjQ0IEFNDQo+IFRvOiBjaXAtZGV2IDxjaXAtZGV2QGxpc3RzLmNpcC1w
cm9qZWN0Lm9yZz4NCj4gU3ViamVjdDogW2NpcC1kZXZdIE5ldyBDVkUgZW50cnkgdGhpcyB3ZWVr
DQo+IA0KPiBIaSAhDQo+IA0KPiBJdCdzIHRoaXMgd2VlaydzIENWRSByZXBvcnQuDQo+IA0KPiBU
aGlzIHdlZWsgcmVwb3J0ZWQgNCBuZXcgQ1ZFcy4NCj4gDQo+ICogTmV3IENWRXMNCj4gDQo+IENW
RS0yMDIxLTM3NDQ6IGNyeXB0bzogY2NwIC0gZml4IHJlc291cmNlIGxlYWtzIGluIGNjcF9ydW5f
YWVzX2djbV9jbWQoKQ0KPiANCj4gVGhpcyBidWcgaXMgaW4gdGhlIEFNRCBDcnlwdG9ncmFwaGlj
IENvcHJvY2Vzc29yIChDQ1ApIGRyaXZlci4gVGhpcw0KPiBidWcgaXMgcmVsYXRlZCB0byBDVkUt
MjAyMS0zNzQ0Lg0KPiANCj4gSW4gdGhlIGNpcC1rZXJuZWwtY29uZmlnIGRpcmVjdG9yeSwgNC40
IGtlcm5lbCB1c2VzIHRoaXMgZHJpdmVyLg0KPiANCj4gJCBmaW5kIC4gLXR5cGUgZiB8IHhhcmdz
IGdyZXAgLW4gImNjcC1vcHMuYyINCj4gLi80LjQueS1jaXAtcnQveDg2L3NpZW1lbnNfaTM4Ni1y
dC5zb3VyY2VzOjE3MTY6ZHJpdmVycy9jcnlwdG8vY2NwL2NjcC1vcHMuYw0KPiAuLzQuNC55LWNp
cC1ydC9hbGwuc291cmNlczozNjY1OmRyaXZlcnMvY3J5cHRvL2NjcC9jY3Atb3BzLmMNCj4gDQo+
IEZpeGVkIHN0YXR1cw0KPiANCj4gUGF0Y2ggaXMgYXZhaWxhYmxlIGJ1dCBpdCBoYXNuJ3QgYmVl
biBtZXJnZWQgeWV0Lg0KPiANCj4gQ1ZFLTIwMjEtMzc2NDogRG9TIGluIGNjcF9ydW5fYWVzX2dj
bV9jbWQoKSBmdW5jdGlvbg0KPiANCj4gVGhpcyB2dWxuZXJhYmlsaXR5IGlzIGEgbWVtb3J5IGxl
YWsgd2hpY2ggd2lsbCBjYXVzZSBEb3MgYXR0YWNrLg0KPiBUaGlzIGJ1ZyBpcyBpbiB0aGUgQU1E
IENyeXB0b2dyYXBoaWMgQ29wcm9jZXNzb3IgKENDUCkgZHJpdmVyLiBUaGlzDQo+IGJ1ZyBpcyBy
ZWxhdGVkIHRvIENWRS0yMDIxLTM3NjQuDQo+IA0KPiBGaXhlZCBzdGF0dXMNCj4gDQo+IFBhdGNo
IGlzIGF2YWlsYWJsZSBidXQgaXQgaGFzbid0IGJlZW4gbWVyZ2VkIHlldC4NCj4gDQo+IENWRS0y
MDIxLTM3NTI6IFVBRiBpbiBibHVldG9vdGgNCj4gDQo+IFRoZXJlIGlzIGEgdXNlIGFmdGVyIGZy
ZWUgYnVnIGluIGJsdWV0b290aCBtb2R1bGUuDQo+IA0KPiBGaXhlZCBzdGF0dXMNCj4gDQo+IFRo
aXMgQ1ZFIGhhc24ndCBiZWVuIGZpeGVkIGluIHRoZSBtYWlubGluZSB5ZXQuDQo+IA0KPiBDVkUt
MjAyMS0zODMwMDogYnBmLCBtaXBzOiBWYWxpZGF0ZSBjb25kaXRpb25hbCBicmFuY2ggb2Zmc2V0
cw0KPiANCj4gVGhpcyBidWcgb25seSBhZmZlY3RzIGJwZiBpbiBtaXBzIGFyY2hpdGVjdHVyZS4g
IFBhdGNoIGlzIGF2YWlsYWJsZSwNCj4gYnV0IGhhc24ndCBiZWVuIG1lcmdlZCB5ZXQuDQo+IA0K
PiBGaXhlZCBzdGF0dXM6DQo+IA0KPiBOb3QgeWV0Lg0KPiANCj4gKiBVcGRhdGVkIENWRXMNCj4g
DQo+IENWRS0yMDIxLTQwNDkwOiAgQSByYWNlIGNvbmRpdGlvbiB3YXMgZGlzY292ZXJlZCBpbg0K
PiBleHQ0X3dyaXRlX2lubGluZV9kYXRhX2VuZCBpbiBmcy9leHQ0L2lubGluZS5jIGluIHRoZSBl
eHQ0IHN1YnN5c3RlbQ0KPiBpbiB0aGUgTGludXgga2VybmVsIHRocm91Z2ggNS4xMy4xMw0KPiAN
Cj4ga2VybmVsIDUuNCBoYXMgYmVlbiBmaXhlZC4NCj4gDQo+IEZpeGVkIHN0YXR1cw0KPiANCj4g
bWFpbmxpbmU6IFthNTRjNDYxM2RhYzE1MDBiNDBlNGFiNTUxOTlmN2M1MWYwMjhlODQ4XQ0KPiBz
dGFibGUvNS4xMDogWzA5YTM3OTU0OTYyMGYxMjJkZTNhYTRlNjVkZjkzMjk5NzZlNGNkZjVdDQo+
IHN0YWJsZS81LjEzOiBbYzc2NGU4ZmE0NDkxZGE2Njc4MGZjYjMwYTBkNDNiZmQzZmNjZDEyY10N
Cj4gc3RhYmxlLzUuMTQ6IFtmOGVhMjA4YjNmYmJjMDU0NmQ3MWI0N2U4YWJhZjk4YjA5NjFkZWMx
XQ0KPiBzdGFibGUvNS40OiBbOWIzODQ5YmE2NjdhZjk5ZWU5OWE3ODUzYTAyMWE3Nzg2ODUxYjlm
ZF0NCg0KTm90ZTogVGhpcyBpcyBpbmNsdWRlZCBpbiB0aGUgLXJjIHJlbGVhc2Ugb2Ygb3RoZXIg
dHJlZXMuDQogIDQuNC55LXJjOiBodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgv
a2VybmVsL2dpdC9zdGFibGUvbGludXgtc3RhYmxlLXJjLmdpdC9jb21taXQvP2g9bGludXgtNC40
LnkmaWQ9YmZiYTZkY2JlYmEyMWUxNTNmODBiMjAzY2RmOTVlMTlmYmY2YjA5NA0KICA0LjE5Lnkt
cmM6IGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3N0YWJs
ZS9saW51eC1zdGFibGUtcmMuZ2l0L2NvbW1pdC8/aD1saW51eC00LjE5LnkmaWQ9MDU3MzhmOTYy
MDcxMjg1YTYwYjkyZDMwZmQ0YmJjNTM3NWQ2N2RmNw0KDQo+IA0KPiBDVkUtMjAyMS0zNjM1OiBm
bG93dGFibGUgbGlzdCBkZWwgY29ycnVwdGlvbiB3aXRoIGtlcm5lbCBCVUcgYXQNCj4gbGliL2xp
c3RfZGVidWcuYzo1MA0KPiANCj4gVGhpcyB2dWxuZXJhYmlsaXR5IGhhcyBiZWVuIGFmZmVjdGVk
IGZyb20gNC4xNi1yYzEgdG8gNS41LXJjNy4NCj4gVGhlcmVmb3JlIDQuNCBrZXJuZWwsIGFuZCBh
Ym92ZSA1LjUga2VybmVscyBhcmVuJ3QgYWZmZWN0ZWQuDQo+IA0KPiBGaXhlZCBzdGF0dXMNCj4g
DQo+IGNpcC80LjE5OiBbODI2MGNlNWFlZWU0ZDdjNGE2MzA1ZTQ2OWVkZWFlMTA2NmRlMjgwMF0N
Cj4gY2lwLzQuMTktcnQ6IFs4MjYwY2U1YWVlZTRkN2M0YTYzMDVlNDY5ZWRlYWUxMDY2ZGUyODAw
XQ0KPiBtYWlubGluZTogWzMzNTE3OGQ1NDI5YzRjZWU2MWI1OGY0YWM4MDY4OGY1NTY2MzA4MThd
DQo+IHN0YWJsZS80LjE5OiBbODI2MGNlNWFlZWU0ZDdjNGE2MzA1ZTQ2OWVkZWFlMTA2NmRlMjgw
MF0NCj4gc3RhYmxlLzUuNDogWzhmNGRjNTBiNWMxMmUxNTlhYzg0NmZkYzAwNzAyYzU0N2ZkZjJl
OTVdDQo+IA0KPiBDdXJyZW50bHkgdHJhY2tpbmcgQ1ZFcw0KPiANCj4gQ1ZFLTIwMjEtMzE2MTU6
IFVuZW5jcnlwdGVkIEJsdWV0b290aCBMb3cgRW5lcmd5IGJhc2ViYW5kIGxpbmtzIGluDQo+IEJs
dWV0b290aCBDb3JlIFNwZWNpZmljYXRpb25zIDQuMCB0aHJvdWdoIDUuMg0KPiANCj4gVGhlcmUg
aXMgbm8gZml4IGluZm9ybWF0aW9uLg0KPiANCj4gQ1ZFLTIwMjEtMzY0MDogVUFGIGluIHNjb19z
ZW5kX2ZyYW1lIGZ1bmN0aW9uDQo+IA0KPiBUaGVyZSBpcyBubyBmaXggaW5mb3JtYXRpb24uDQo+
IA0KPiBDVkUtMjAyMC0yNjU1NTogQlIvRURSIHBpbiBjb2RlIHBhaXJpbmcgYnJva2VuDQo+IA0K
PiBObyBmaXggaW5mb3JtYXRpb24NCj4gDQo+IENWRS0yMDIwLTI2NTU2OiBrZXJuZWw6IG1hbGxl
YWJsZSBjb21taXRtZW50IEJsdWV0b290aCBNZXNoIFByb3Zpc2lvbmluZw0KPiANCj4gTm8gZml4
IGluZm9ybWF0aW9uLg0KPiANCj4gQ1ZFLTIwMjAtMjY1NTc6IGtlcm5lbDogcHJlZGljdGFibGUg
QXV0aHZhbHVlIGluIEJsdWV0b290aCBNZXNoDQo+IFByb3Zpc2lvbmluZyBMZWFkcyB0byBNSVRN
DQo+IA0KPiBObyBmaXggaW5mb3JtYXRpb24uDQo+IA0KPiBDVkUtMjAyMC0yNjU1OToga2VybmVs
OiBBdXRodmFsdWUgbGVhayBpbiBCbHVldG9vdGggTWVzaCBQcm92aXNpb25pbmcNCj4gDQo+IE5v
IGZpeCBpbmZvcm1hdGlvbi4NCj4gDQo+IENWRS0yMDIwLTI2NTYwOiBrZXJuZWw6IGltcGVyc29u
YXRpb24gYXR0YWNrIGluIEJsdWV0b290aCBNZXNoIFByb3Zpc2lvbmluZw0KPiANCj4gTm8gZml4
IGluZm9ybWF0aW9uLg0KPiANCj4gDQpCZXN0IHJlZ2FyZHMsDQogIE5vYnVoaXJvDQo=


--xwxCoyd0k5VZQVJVWmzu
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6740): https://lists.cip-project.org/g/cip-dev/message/=
6740
Mute This Topic: https://lists.cip-project.org/mt/85642333/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/10495289/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--xwxCoyd0k5VZQVJVWmzu--
