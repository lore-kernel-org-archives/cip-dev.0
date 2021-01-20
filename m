Return-Path: <SRS0=0ln8=GX=lists.cip-project.org=bounce+64572+6112+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6D2AC433DB
	for <cip-dev@archiver.kernel.org>; Wed, 20 Jan 2021 02:34:14 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F245222509
	for <cip-dev@archiver.kernel.org>; Wed, 20 Jan 2021 02:34:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F245222509
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6112+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id uBeLYY4521723xFmNMApVB88; Tue, 19 Jan 2021 18:34:13 -0800
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.153])
 by mx.groups.io with SMTP id smtpd.web10.22418.1611110050766437631
 for <cip-dev@lists.cip-project.org>;
 Tue, 19 Jan 2021 18:34:12 -0800
X-Received: by mo-csw.securemx.jp (mx-mo-csw1514) id 10K2XuiY020175; Wed, 20 Jan 2021 11:33:57 +0900
X-Iguazu-Qid: 34tKPbYPPemyS7Ouf7
X-Iguazu-QSIG: v=2; s=0; t=1611110036; q=34tKPbYPPemyS7Ouf7; m=dE7qbJk2Jys2iZdvC7oBI5WY2x5dhPIFLYq/YDgnKKQ=
X-Received: from imx2.toshiba.co.jp (imx2.toshiba.co.jp [106.186.93.51])
	by relay.securemx.jp (mx-mr1510) id 10K2XtYH001536;
	Wed, 20 Jan 2021 11:33:55 +0900
X-Received: from enc01.toshiba.co.jp ([106.186.93.100])
	by imx2.toshiba.co.jp  with ESMTP id 10K2Xt5Q029239;
	Wed, 20 Jan 2021 11:33:55 +0900 (JST)
X-Received: from hop001.toshiba.co.jp ([133.199.164.63])
	by enc01.toshiba.co.jp  with ESMTP id 10K2XtQc007715;
	Wed, 20 Jan 2021 11:33:55 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lzMp/gCw83ia9A5WgPS9u8T7avRGgAjo8Wz/kzmAWAojdZhKesYpMjyG4PjStBv0bEHn3tokep1MR2DZxRfpyjFeMmFeUvkIb4VMotzb2VnhfmzSFLSzDup0csA4m4IAPgf6Tb33100my+gM4xYyCM8H7PoGR3bp5yJgqPiVK9rAkWp88tN+wVgv8fecHKxJcYgyCQ0+dyH5V3WdXrfqV99RY4Xc/W53ui4pewOeLjSTsFlcRDXh54uMoqZvZgYQUIEaNb893/jQAUj99JtEpfM9xdsQT0x472YBtzjNOz+Bygh7CYE4TorEYMLfe5a6jVDcBJ1iZO8cuGkZfJxAWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IuSnrUz3oGDrwVaj8ayTHgYa+FEVvZsOYF+jxlar5p4=;
 b=AybwHThCQV5HrqZ845XAQbUzgE78s+5CWc4b5GyakcQFGFL4uFJAf8QOnbweFZolVTVkFyWZvrxiESE8BdiTGgHpTOZfqrT9M/EQ1aROdJL7/YBblhJN7oCKfMSvKhsCTAwD73uKxkv9NM6r+MQjYOAvRfAXB5RTB+emWWK6gfmWsF9JHnxPOmNBcxvHLvDOwCwBJRhtqSbd3XO6VPzlx1jcv7VbJra94wzG/HwvQam1MNt/eOFLmBoJ8tSjmldwjXztgfF/j7or0YJiuQsL7hofprWi4ylk4N9NPHOVSbvETU64sLshRtGFvvbB80tO411t2m4Fx4DbrzfMy4evCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: "Nobuhiro Iwamatsu" <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <pavel@denx.de>, <masashi.kudo@cybertrust.co.jp>,
        <cip-dev@lists.cip-project.org>
Subject: Re: [cip-dev] Starting 5.10.y branch?
Thread-Topic: Starting 5.10.y branch?
Thread-Index: AQHW7o/x1uY+kqKA8U+GhAHXhFfHh6ovyVyQ
Date: Wed, 20 Jan 2021 02:33:38 +0000
X-TSB-HOP: ON
Message-ID: <OSBPR01MB2983F1F88A1455F26BA7194392A20@OSBPR01MB2983.jpnprd01.prod.outlook.com>
References: <20210119182125.GA17515@duo.ucw.cz>
In-Reply-To: <20210119182125.GA17515@duo.ucw.cz>
Accept-Language: ja-JP, en-US
x-originating-ip: [103.91.184.9]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c28a351e-b472-4abc-e2ff-08d8bcebcb22
x-ms-traffictypediagnostic: OSAPR01MB1842:
x-microsoft-antispam-prvs: <OSAPR01MB18421CE7D3622F3379C5545692A20@OSAPR01MB1842.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: TuvCpVpdkaQyx41nCpXG6wR4/L6f9sYjtMt11ZHcLs6uRK/kqSgAwnsDoKTTJ5EOvRDjQk4PmKSJHCdhQBvZx0Q5nNSNKf6NzPet2YPzSrcpS5GI3fHSbGdCIKduxQ3NWt3jjzmEf7RUCn1K0uHKmeO4d9mdl+b0N4g7ajRIzGKDe/BjM/ZIdq753t5Ls5vGHGsp4Gk9RSE/QBXROc8nRygGHBw2mK1zwmYNsA9D10MZLayBOMhbR77xEAPvb4eZkrDXdIsRJ6RTOiYEa3BUII0jxC9BeXaTCn83tlD3kn9THQDT6d/LAOpii5rhLCGPQQrMrX6p0AEuCZyAk457gKlzQmgVXP7NogQ5PnCItuH0Mt4o1kSEjjEEkJZDIZkGUXg5KqSX1hebShakZSS668lwDwu2xEQpL29TC7zbOaT/zrCAuBjOoVdRezs04/jZ7quMT8tk1XBRlnkU5K38DWYo6wvetgOdZLRSh2G65otIWko7j+yEzfm8dGYe1fDYH341EkwVnP4EZnjfB79mSw==
x-ms-exchange-antispam-messagedata: =?utf-8?B?ZE5YamdVdC8ySUFOb2piOC9GVmhubWN6NTBMekllRkp3MnA5NzVUZTFXMzNW?=
 =?utf-8?B?MHM4MWZKUFhyTWRSQkJYNTN1anFub2ZnVmFWL3RjVjVnMGtYOHN0Njl0c0dl?=
 =?utf-8?B?M2Z2ZU11c0JMSEkwN3JTYUtTd25zcC9zSnFhVHJsb1owY3YwRTFORExhQ2xF?=
 =?utf-8?B?ZERYaTAyaXZ1WnFsdThjMUU4cGZKeEVHaFgxZThQTnQ0VnczTDdEbUNSQ0V2?=
 =?utf-8?B?clM1ZEtPb0tObm9nTzUrNHlKTGJMSzFtUjZCUHlEYWl0NE80dXBqcnJEcU5E?=
 =?utf-8?B?c05Gb2VXczVTWHd5VkE3QllxNXNsYVFSNDdBbU9Bc2VmOHNWeVlldnpmQW5O?=
 =?utf-8?B?VWVtL213dHZ6UklETzdsNFVqWjNhcy9UaXpSa0dZT3E0L2dwWmQwMWlaVXpD?=
 =?utf-8?B?RjdTZE5vMHBWTW5RRUVtb0VYQnFzcjJCcHY3SnVrQXVDcFdLRlhrWVZTQ1lK?=
 =?utf-8?B?NDlyWGRyS3RhUzhyNXg1RFFqd0JFYTF2WWM2ejVvNDlqMmp4b1ltb2tyYllK?=
 =?utf-8?B?bHN0N1UvNjhwR2tKcWMwcVNlQXUzZGloU0cvMENmazdPUXp3US9wZWV3eFVI?=
 =?utf-8?B?dEhTSnRZazJJaERzZ1lSeXRVR1JWUEtwcmVwSVg0cUxjaWw3S2Ridm9jYW1s?=
 =?utf-8?B?UDFYdkdVQngxWDE1Rkp6aExvWWtkN2IyYnNEc2lmeEpHb2VKazduSVJjZi90?=
 =?utf-8?B?WVNBTFdqZjNwVVJnNTFaSWF2NC9oelpYR2NwNlgraUlPeGoxV1k3SVcySTJq?=
 =?utf-8?B?amdwYTliRUZsWGhDcC81b280bjFXZlpyRXN4eXVqSTB4bTUyRjJCODJ5YnJ5?=
 =?utf-8?B?RkFqcHNpQzdFd0xoUlFIT2VDMFZCc1JSYnJOb1FNaTJ0SzZMbk9FZXhYRC9q?=
 =?utf-8?B?ZEtRRXZrNEl4QVlGTEVhN1c5MHJxRUQvV25Ba0VvdGlncCtzYTllbVc2WWdI?=
 =?utf-8?B?Y2habTdvQnZKQmUxczV4bWYvcGRYeTdmVWRnbzRuZk1melF2MkpCUGJrYUZK?=
 =?utf-8?B?N3owdnh6MjV0anpLQUE1ZzVGT0E3TFVxRUh1bFBWWktwN0NkbktZUDU3WU5i?=
 =?utf-8?B?RDNuU0dwVFBTTWJoOXFOYkduU21HaStkWkQ1dVdIOGxrdWNoVTlJbXNrRy9B?=
 =?utf-8?B?ZXJHTjNZSlpEYkRPdGNmb2hwZ0NXZVBkVGVMK3p3WFJ2ZHc5Y1ZPNkxTQ0Vt?=
 =?utf-8?B?RitHTVdzeUtiMU8yckNqWFZkSU80K2ZRZUNMdlpPM3AyNTdibFdHa2pMVnd1?=
 =?utf-8?B?UmlwRlN0dEE2cXVzTnBYeWFwZkhqcllhQmk1NlRYa3RBYXNUNFZCM1laWUtK?=
 =?utf-8?B?Z1pmcVZQVndMYnVhbGlZbnRTZUorQUI3Tm1NSHdyUzF6ZHFGdExuZWs3U1ph?=
 =?utf-8?B?bGVOSm9SYXdsVXR2UlBsZm53ZVVRUXdJL0hJL3JKYU9IRHhISVd1cWxyVkwv?=
 =?utf-8?Q?yptC++ZM?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2983.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c28a351e-b472-4abc-e2ff-08d8bcebcb22
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2021 02:33:38.3213
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9BDJwpzatYOOX04fKou5bftz/xIUKN0XmXshpWxsotQOFmZXRSgip7h1FjpE46emZtebNocIY5PkTGQLrw0qO8pjo4xYj07dRhn3qeLmSM7nT/o+XboLsfU63JTvlLg/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB1842
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: t54Gfa8u98LOZbKJa8sbphPxx4520388AA=
Content-Type: multipart/mixed; boundary="i50YXH4f40IkZiHrFuej"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1611110053;
 bh=X6YFhSNpWHHVUAk5xu7i++xHG1S6cAYU+F3lceizUnQ=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=c0AHhwKSZqjJD8eo7X+/xwz58l34hvupIDwXaCWMLbmJoSP4F5QNlUMSzVdh2Bpuccw
 yyQfOkBormGWkwh+MlRR+gQHQaFwm/k+HFTQW99tMp5COTJ/cDeGBmCAVK8kFtTm/WVKU
 aIGYUYh0jAY2MhuMZRkKuIHJvl2xaGaHpXI=

--i50YXH4f40IkZiHrFuej
Content-Language: ja-JP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGkgUGF2ZWwsDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUGF2ZWwg
TWFjaGVrIFttYWlsdG86cGF2ZWxAZGVueC5kZV0NCj4gU2VudDogV2VkbmVzZGF5LCBKYW51YXJ5
IDIwLCAyMDIxIDM6MjEgQU0NCj4gVG86IG1hc2FzaGkua3Vkb0BjeWJlcnRydXN0LmNvLmpwOyBp
d2FtYXRzdSBub2J1aGlybyjlsqnmnb4g5L+h5rSLIOKWoe+8s++8t++8o+KXr++8oe+8o++8tCkN
Cj4gPG5vYnVoaXJvMS5pd2FtYXRzdUB0b3NoaWJhLmNvLmpwPjsgY2lwLWRldkBsaXN0cy5jaXAt
cHJvamVjdC5vcmcNCj4gU3ViamVjdDogU3RhcnRpbmcgNS4xMC55IGJyYW5jaD8NCj4gDQo+IEhp
IQ0KPiANCj4gSSBiZWxpZXZlIHRoZSBuZXh0IHN0ZXAgd2l0aCA1LjEwLnkgaXMgdG8gY3JlYXRl
IGxpbnV4LTUuMTAueS1jaXANCj4gYnJhbmNoIGF0IGtlcm5lbC5vcmcuIEknZCBwcm9wb3NlIHRv
IHN0YXJ0IHdpdGggd2hhdGV2ZXIgaXMgbmV3ZXN0DQo+IHN0YWJsZSBhdCB0aGUgbW9tZW50LCBz
byBwcm9iYWJseSA1LjEwLjggb3IgNS4xMC45LiBJcyBpdCBva2F5IGZvciBtZQ0KPiB0byBkbyB0
aGF0Pw0KDQpJIGRvbuKAmXQgaGF2ZSBhIG9waW5pb24gYWJvdXQgdGhpcy4NClBsZWFzZSBkbyB0
aGlzLg0KDQo+IA0KPiBOZXh0IHN0ZXBzIHByb2JhYmx5IGFyZToNCj4gDQo+ICogVmVyaWZ5IG1p
cnJvcmluZyB0byBnaXRsYWINCg0KVGhpcyBpcyBkb25lIGF1dG9tYXRpY2FsbHkuDQoNCj4gKiBQ
dXQgcmVxdWlyZWQgLmdpdGxhYi1jaS55bWwNCj4gKiBHYXRoZXIgdGVzdCByZXN1bHRzDQoNCkkg
dGhpbmsgdGhlc2UgbmVlZCB0byBiZSB0ZXN0ZWQgZmlyc3QuIFNvbWUga2VybmVsIGNvbmZpZ3Mg
YXJlIGFscmVhZHkgc3VwcG9ydGVkLCBzbyBpdCdzIGVhc3kgdG8gY2hlY2sgdGhlIG9wZXJhdGlv
bi4NCg0KDQpCZXN0IHJlZ2FyZHMsDQogIE5vYnVoaXJvDQo=

--i50YXH4f40IkZiHrFuej
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6112): https://lists.cip-project.org/g/cip-dev/message=
/6112
Mute This Topic: https://lists.cip-project.org/mt/79958721/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--i50YXH4f40IkZiHrFuej--
