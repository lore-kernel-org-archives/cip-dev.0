Return-Path: <SRS0=qYEI=FH=lists.cip-project.org=bounce+64572+5934+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B14C5C64E7C
	for <cip-dev@archiver.kernel.org>; Thu,  3 Dec 2020 02:29:18 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B780E21D91
	for <cip-dev@archiver.kernel.org>; Thu,  3 Dec 2020 02:29:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B780E21D91
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5934+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id LuWiYY4521723xJdECgLw8td; Wed, 02 Dec 2020 18:29:16 -0800
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.web09.4160.1606962554459754225
 for <cip-dev@lists.cip-project.org>;
 Wed, 02 Dec 2020 18:29:16 -0800
X-Received: by mo-csw.securemx.jp (mx-mo-csw1116) id 0B32T4JN031746; Thu, 3 Dec 2020 11:29:05 +0900
X-Iguazu-Qid: 2wHHjV7mx6NM98aUsu
X-Iguazu-QSIG: v=2; s=0; t=1606962544; q=2wHHjV7mx6NM98aUsu; m=i2xV6JnTbFPvw3lmdpJoy1f6ij0bqZIjvC0n3pDQA+s=
X-Received: from imx2.toshiba.co.jp (imx2.toshiba.co.jp [106.186.93.51])
	by relay.securemx.jp (mx-mr1113) id 0B32T1Ug037747;
	Thu, 3 Dec 2020 11:29:02 +0900
X-Received: from enc01.toshiba.co.jp ([106.186.93.100])
	by imx2.toshiba.co.jp  with ESMTP id 0B32T1i9004880;
	Thu, 3 Dec 2020 11:29:01 +0900 (JST)
X-Received: from hop001.toshiba.co.jp ([133.199.164.63])
	by enc01.toshiba.co.jp  with ESMTP id 0B32T1fA001579;
	Thu, 3 Dec 2020 11:29:01 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P6oOOCdthia9eCxO9efRarzQqFpsITR6jEpHpGN839450sT2AOhIxkEDT5ykrhdprrj7JsDizJGM5rRVWb+VgYfmsrmGt3rQJjqNL4b7Zb16Ur3j9Sxy5qYXb2uAZx8PBi8H3SPmyOT5y7d34iMgdqObQekXGbVO2lqrn3oMgRhE20YFcUTHK7iuG8t4whGY6K5ZVxfhDQv7Yzq+1bPAQ6ZGBluQ3EPx6VrhAc8AjX7D+Gt6fv9uKuyQ4rA5Jo/ACp3ISYKg1knolFsNbysHRMJazd50xqmw2GMJiRvZpyA/xWuMeAaTXvGDsf42FXsY6MAOm05PLnN8CTDHLnkquQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eVmmL2pPjxqkbRF9mn7MZtL1wvnLFQgBLHmtvZJONOg=;
 b=VvZE2Bm+XuneQ65WnQqsL0AasXrWfNs74oYNsV9PjAJwc+Db/ktIx6WmGtvDiMpXUUdchbLPruw/0TTIQbZgcPn593yv7qUcTYxBPywCjuc4RdhZCZzuAqOy2etY7AKsrR8/FLnJBTf6IfXGHyy6JXRgRzfQWIsdTd94npemoBTGKoHjlPjtD9h9J6feD+FEvCKj4R2v+g/xm7XoDmfaAcxPLpcHOXd6qv9hk6npjB3EW6OmyQgtJnxX8+0BgS9/PtRrFWPbInvb7znaox30WSMWRoBzutVIAK3rmstyJOEPfZyH4FZMlutnG1ZqJHmLi5xK4KQNj8AeURAwo6h8qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: "Nobuhiro Iwamatsu" <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <pavel@denx.de>, <prabhakar.mahadev-lad.rj@bp.renesas.com>
CC: <cip-dev@lists.cip-project.org>, <biju.das.jz@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH v2 4.4.y-cip 00/11] Renesas RZ/G1x add SoC detection support
Thread-Topic: [PATCH v2 4.4.y-cip 00/11] Renesas RZ/G1x add SoC detection
 support
Thread-Index: AQHWx72SeJE3BF+LJ0yOXR/xmpdPPqnh+SQAgAKvWzA=
Date: Thu, 3 Dec 2020 02:28:59 +0000
X-TSB-HOP: ON
Message-ID: <OSBPR01MB298357DC462CE3BB01390EC592F20@OSBPR01MB2983.jpnprd01.prod.outlook.com>
References: <20201201083938.32688-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20201201092822.GB4219@duo.ucw.cz>
In-Reply-To: <20201201092822.GB4219@duo.ucw.cz>
Accept-Language: ja-JP, en-US
x-originating-ip: [103.91.184.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 238885c3-0918-48aa-ee13-08d897333116
x-ms-traffictypediagnostic: OS0PR01MB5300:
x-microsoft-antispam-prvs: <OS0PR01MB530035A4EA029D75A5D8742892F20@OS0PR01MB5300.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 9FVOta2wrtLIjkwyORpK9DwsMbllFHalc7yhvDKq4njvSxHLKXhVVeoiGL2H/Tj9c6rVvi7SSTFc4QT1RfM43gI57zc6Ey2aBh5Se6vCBerc/wCKtUfafoUdeaMB8IXpOtyz6OX0MFmJ7OfClSnhJppSZFHD/ElarmJlWCeVS+DXL0GzL9G5R11WWM1a0rtQg8Msdgak7HAvNTkRF6970wYOGYypIF3FYD3/8t2M/U5tCfkLwS5VSagU33MWhTS0q40lTws5ao1g6ZbHULvCpDbV9D4LTWJ8BmhPwxqx3PK1WX6GF1/0QbKotioOQcnuaNm+HUj4jvJ7yI5hbDwKUQ==
x-ms-exchange-antispam-messagedata: =?utf-8?B?TmxoaER2cEJSOW1HZG0rbHUvR05NK3JaSTlOajhBVnJnMkYvbFZIREI5SHRH?=
 =?utf-8?B?Q08rT3JxUlRyRUkyZGxCbERzaVArR3pZQkNzUy9TYk0zUmxqTlJWNW1LNGVK?=
 =?utf-8?B?bEg2d0lYQStMVVdEVEc2bC9JZllGL3dIbnhncUVKUmlMbVo1SFhEMzNSQjhy?=
 =?utf-8?B?Ylg4eDVNQVNTOXJHbnZ3VldlMFhrOVlDV0d1OTgxeUV1Zkc0Nk5BK1RYK21k?=
 =?utf-8?B?SFZGZ3gxdjByMTFBSTdCMUZvK3cwMERRQ0FCTS8yNVFhQisyNXFmRWlpY3Uv?=
 =?utf-8?B?bUZhZm9SY3FDeCtCemFUTjBtUlRyM3JWMldSQys4ZmQ2YmdWMDFUaE5NcnJk?=
 =?utf-8?B?d3ZGdEJzdlVudTYzcUdUTU9TcCtNdlZaZk1JbDFWUzFFNlpJNzhQcTlYN1BC?=
 =?utf-8?B?QmtTM2ZaZjRSQkJQYXdNeUZMKzRMdlJEMGdQRkZRcWl0emlTZmcvSG5CMGpq?=
 =?utf-8?B?ZzJZWkQyRXNjWVRkOVlQNWgrU1pwYXg2YURycW9xbXZvN1UrbTlEL2p4M2JG?=
 =?utf-8?B?THBSeHpFVDhodG5NWUkwMmZMRGF1M0VVaFE2YU1QTFZDTmFiazZvWnN5eUFT?=
 =?utf-8?B?RUNJd050K1FMWEVUdzkzYm1ScHJjSXNCNWhsaUxGQ3ZlOUw2ekxUVUduT0RY?=
 =?utf-8?B?K2RRWjNHeEVGMVU3T2Y0SmRPR0oyZDJOTW1hNjJZYUc4cFZ5YW1KbU1wUkli?=
 =?utf-8?B?d0l5SmVhdVcybHR0b1gwSXhhUEJUUmpmZmh5VEZqeTFNQW4yZFlCUjZNcnlj?=
 =?utf-8?B?QzMwK0FpRHAxVE5CMDRRQmppd1BrYkVQNi9BRDhyaTNHUXB1UGt3WWcyTXlF?=
 =?utf-8?B?ak93MWVzbjgyVitkblZ6VmVuSkNTRk5Gd044blpmVmVmWjdheGhyclBnZzNV?=
 =?utf-8?B?Rkh5bGh2eXhJSjNNeG13TTdLYlJaTXhQUzRpcnV4T2NRNmk3dzduVVZCQU5E?=
 =?utf-8?B?TkxIUFFVb2t1MHRTMzdpdVBkZlptS0NjR3FaQ1RLQXZ1ZjJ2UVNQMG5ydkxz?=
 =?utf-8?B?NU1tUUZmZjJnVnFqWVF4MGZUSTBmdlVmeitxNitTS3k5K29WaElXdkpJaith?=
 =?utf-8?B?Yk9zMVZMTUpnZ0R1UEhHT2tQRzc5QU9wYU5rRzlTS0NhNWRpNGxoMlRsN2FY?=
 =?utf-8?B?L1R2d0Q2eWpVbXFIOHBuQm40aUtIVzF6Zm9DZlFybWh1RlptMW8waTFNN3h5?=
 =?utf-8?B?WDdhNTJTM3UyaDcwUWVGNy9ZbTFmSDZwSnFNMXFoVjN3emUxUmNYaXhRbzBI?=
 =?utf-8?B?dHFRYkJESVpOZHBvcnNRMFJoSG4vYW9uUVdkeFU2ajMyZGFxSFdoTFpGb1NP?=
 =?utf-8?Q?aDlemjn1ouSqY=3D?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2983.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 238885c3-0918-48aa-ee13-08d897333116
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2020 02:28:59.4478
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1E2gWVJdDzrzWZXzJmkNUjCFfLIAXCwXD26ADlA00FgSa0k2MVEbb84rzk5BNmVf07Vm7vJbWh6E6tiWDqCc/2Mhid+cF0mRFlsrGNLYeWvtc4A6weGxQV4FN/89owGF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB5300
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 58O0YSyDY3qQueo4UUkP0UWEx4520388AA=
Content-Type: multipart/mixed; boundary="XqQTwPCsHSG8luPGjpr4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1606962556;
 bh=WqUxeuxFyF7RfGa/WBowM9CrbkzaIh1wzGDkDCUBA4E=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=Nh0VWI/yoX/JjJETetBYICmfxMWWuABiXLGNH5WsxURan3C0SkspRhZoKUNxz6fB7dT
 6n+JBgfne7J/ubrxLsHb7c8li/ACYYvRv8h2ESLI7iO0UzLXnwoH/LKpCp1LJvhmNAD0c
 2H83NsWjUTpiorjBvt0gGL+pu2+zZJCmXuU=

--XqQTwPCsHSG8luPGjpr4
Content-Language: ja-JP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGksDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUGF2ZWwgTWFjaGVr
IFttYWlsdG86cGF2ZWxAZGVueC5kZV0NCj4gU2VudDogVHVlc2RheSwgRGVjZW1iZXIgMSwgMjAy
MCA2OjI4IFBNDQo+IFRvOiBMYWQgUHJhYmhha2FyIDxwcmFiaGFrYXIubWFoYWRldi1sYWQucmpA
YnAucmVuZXNhcy5jb20+DQo+IENjOiBjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZzsgaXdh
bWF0c3Ugbm9idWhpcm8o5bKp5p2+IOS/oea0iyDilqHvvLPvvLfvvKPil6/vvKHvvKPvvLQpDQo+
IDxub2J1aGlybzEuaXdhbWF0c3VAdG9zaGliYS5jby5qcD47IFBhdmVsIE1hY2hlayA8cGF2ZWxA
ZGVueC5kZT47IEJpanUgRGFzIDxiaWp1LmRhcy5qekBicC5yZW5lc2FzLmNvbT4NCj4gU3ViamVj
dDogUmU6IFtQQVRDSCB2MiA0LjQueS1jaXAgMDAvMTFdIFJlbmVzYXMgUlovRzF4IGFkZCBTb0Mg
ZGV0ZWN0aW9uIHN1cHBvcnQNCj4gDQo+IEhpIQ0KPiANCj4gPiBUaGlzIHBhdGNoIHNlcmllcyBh
ZGRzIFNvQyBkZXRlY3Rpb24gc3VwcG9ydCBmb3IgUmVuZXNhcyBSWi9HMXggU29DJ3MuDQo+ID4N
Cj4gPiBBbGwgdGhlIHBhdGNoZXMgYXBhcnQgZnJvbSB7NywgOSwgMTF9LzExIGhhdmUgYmVlbiBj
aGVycnkgcGlja2VkIGZyb20NCj4gPiBMaW51eCB2NS4xMC1yYzYNCj4gDQo+IFNlcmllcyBsb29r
cyBnb29kIHRvIG1lLCBJIGNhbiBhcHBseSBpdCBpZiB0aGVyZSBhcmUgbm8gb3RoZXINCj4gY29t
bWVudHMuDQoNCkkgYXBwbGllZCBhbmQgcHVzaGVkIHRoaXMgc2VyaWVzLg0KDQpCZXN0IHJlZ2Fy
ZHMsDQogIE5vYnVoaXJvDQoNCg==

--XqQTwPCsHSG8luPGjpr4
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5934): https://lists.cip-project.org/g/cip-dev/message=
/5934
Mute This Topic: https://lists.cip-project.org/mt/78628858/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--XqQTwPCsHSG8luPGjpr4--
