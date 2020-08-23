Return-Path: <SRS0=1820=CB=lists.cip-project.org=bounce+64572+5233+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB28DC433DF
	for <cip-dev@archiver.kernel.org>; Sun, 23 Aug 2020 23:08:56 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94CC02072D
	for <cip-dev@archiver.kernel.org>; Sun, 23 Aug 2020 23:08:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="V7f89eJ7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94CC02072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5233+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id UiEAYY4521723x4tVRtWQpXY; Sun, 23 Aug 2020 16:08:56 -0700
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.153])
 by mx.groups.io with SMTP id smtpd.web11.184356.1598224134203933153
 for <cip-dev@lists.cip-project.org>;
 Sun, 23 Aug 2020 16:08:55 -0700
X-Received: by mo-csw.securemx.jp (mx-mo-csw1514) id 07NN8j9B023531; Mon, 24 Aug 2020 08:08:45 +0900
X-Iguazu-Qid: 34tIYF04N4FWzzuIqs
X-Iguazu-QSIG: v=2; s=0; t=1598224124; q=34tIYF04N4FWzzuIqs; m=0YxvhItdT4aH8F86ei6qg7mc2iFaJ4H6HIw7m4olDfw=
X-Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
	by relay.securemx.jp (mx-mr1511) id 07NN8hQv018323;
	Mon, 24 Aug 2020 08:08:44 +0900
X-Received: from enc03.toshiba.co.jp ([106.186.93.13])
	by imx12.toshiba.co.jp  with ESMTP id 07NN8hkV006655;
	Mon, 24 Aug 2020 08:08:43 +0900 (JST)
X-Received: from hop101.toshiba.co.jp ([133.199.85.107])
	by enc03.toshiba.co.jp  with ESMTP id 07NN8hJa001190;
	Mon, 24 Aug 2020 08:08:43 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZszEZnSBkC3aQ6QUZiGRbcjx4VMqzZbgw9TR9OI4N/+IsgARA3I7XyN7vpJRp9qpDn9ISCNZBmO39U8DrwnJwZCLeKZhUXQmA5UN3Fo553u5KFlX4jrPNzGXUw3y14oaVBH84x02MZvnjXDa54uPQbtJhueNqszouaGmQhsIZqPwvnCBLI8RAEvqhQGEzvFmhrOzBaGHd14XpeHviqb0vAmDOzxHDnK6kxemnOmnIlAFtjCjJG7TGw8ZhJIfNJ3QwV/Jhmv8jp3f7EKyAIniMiHXego9AnTC+2oFXd4YrG+Lu5pFNaLdbIe8Rkton8BuXfo5usTiQQHHvuWvZzqvKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ym5W1u/idJzveOlCwSBMJcSBNWz/QqWw0HPTKyIwt5U=;
 b=ipgpTd9vUoks1tMJAEM+kSigIgPV0a/vN5nPxGdJiWVo9EFDFQf6GyfhJS8M5rx+eW2xSrMSwGXyOSSXhOF5au6pO71ylVQiA/gbGA6tNrg3cT468U8mYLuVcRvaVUn1lCeV6vKqy1tr/kYNcZBaEKG44VqRwwxCpyAGGvQbM1u9lz3GBZLR+2m+3LkGrEsINSxahGT4Q13I7zrSJv4mcGlPMWcwqItomobYZC923ooQzrVN6oGw6wQim1HQLnpVUR39R2eXxlMvvie/lNBs5VAfx8BdhanDqXyCszYJ/HaiQ6yKy92LuhoN7GgZ/RutVvVfunCog4rpNsCprSBQhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: "Nobuhiro Iwamatsu" <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <biju.das.jz@bp.renesas.com>, <cip-dev@lists.cip-project.org>,
        <pavel@denx.de>
CC: <chris.paterson2@renesas.com>, <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 4.19.y-cip 0/7] Add IPMMU/SYS-DMAC/GPIO/EAVB Support on R8A774E1
Thread-Topic: [PATCH 4.19.y-cip 0/7] Add IPMMU/SYS-DMAC/GPIO/EAVB Support on
 R8A774E1
Thread-Index: AQHWd8XGttT52cMPOUmJr1HT0i2GN6lGVPcw
Date: Sun, 23 Aug 2020 23:08:41 +0000
X-TSB-HOP: ON
Message-ID: <OSBPR01MB2983686543822023408BDFD792590@OSBPR01MB2983.jpnprd01.prod.outlook.com>
References: <20200821141702.3977-1-biju.das.jz@bp.renesas.com>
In-Reply-To: <20200821141702.3977-1-biju.das.jz@bp.renesas.com>
Accept-Language: ja-JP, en-US
x-originating-ip: [103.91.184.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f7ca55b7-fe8f-4001-ae93-08d847b979f8
x-ms-traffictypediagnostic: OSAPR01MB4340:
x-microsoft-antispam-prvs: <OSAPR01MB43407DAE9460543B12FBCD0C92590@OSAPR01MB4340.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2887;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: aFbK3010UmAvPz4hAhZFnycGoU4M7SAoOxU5WgYJ50UwCNmiF1ckmXaG1rASqbXfUXO7TF6cx0s8ky7/3czl46OdFFhWe0U4nLAjX/TQmfyhlL67ElNeR+y5Qpbxy3adUKo9uHgcI5lyu8t4EUzh4U+x0F15qF82UCvjgluuWuH3fSk3+FvkHvl8okt6IulxKtDYTd9CdVYofDIoU+XooIpTytRUZNwQZ4bH9K1YL/ZBQxDLbxYhw0GpaAXA84BMZG6rzIDQzDbZawP1xHzJ3pKupdlY5TKXaR/tgmfom88+JWjbgT/NnZ6IClpTY4jlR89faEoi34GHdvAIAuBwyAWsX1/E8O2tOB96FgCUXZS1cfb0DyeH9SBvfZTVUlL/t7la4ZE53+KN2kbA2tolNg==
x-ms-exchange-antispam-messagedata: RiShWXQcP3balw4hGFu+nHKoQ7mChIxFHAMAuKUmqEwe0t0rcRkYJVbxsU7Q1j9YSOZZAKUnWjM24bOtrp5onhPsKA8w8CWo9GRuxMF5rmiQlYDXKS6uVpfcOeyYNlCUzUZJDxHq6FG5Hbt8ZDGXvPSW963ynXNNQ5wefxKYPDGFK9mZueGJRYAKSKisqjxFiCu1HLl/ciyGXBM5/zGIEElqJhdpcqfha4RbrErn743RyeWm8zGr9YjMPzsbTkpCJW7h9nG+vJ0jlpPKD7GpAueWDzle/+DQdHQd7xK4LQ5H7hjFrmNrDHSdrEhIqv+YPf/PZWZoRpt1FYAPVlPMX5uNHrMGzN4pZoLWbiZiyxt08/Yk0gEkKK4L7Wz/tKrS1kQKXuZQfQodvC2OAy7aWZQUpuA88UHsX6tQ178gmve3E4P/2PLQCWtlozEi9XbHfXeziW7pyFHeKp1R+PG3XFgy2KIXYe91/y3YOL0t0ZoHZTXpxCDkXEQc6PXHZbhj/H4PCUU0xefTRSihMGaAjp36oOVPO783yEp3p6K86OrUzUoNCf3X/1VlBEVmwblZQKVfWrfEsKq1RuWABeYsLGN25BmIes/hH0SpOKf9B4VWcfNzhlHkCa7HDUaIY2PAWx7X0ClDYB5EbUfRanJBUQ==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2983.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7ca55b7-fe8f-4001-ae93-08d847b979f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2020 23:08:41.2818
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eBToiDkRNHNpJuVaEnAUBeVbkLpSSJI5/IsWC6qBorJN7NOB/X/wSQN0KqotBZ/9UAZOZnX3TxYPv+3c9zIJ1K4UxYbsV7tT6HwhQGwzkFNuHhglZAkXCXhHWsomrGKn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB4340
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: FWy6YOngpIKcUgDGIs04lASMx4520388AA=
Content-Type: multipart/mixed; boundary="PVd3DlCk12lsPCubalyr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1598224136;
 bh=0V3KO4/gu8ahFAIbqb6wfrNt9mE2ZswMyk0aDNMbmSk=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=V7f89eJ7pUDRZq5iL7/yE8eEbTUuSpmBwfwB1tawFjJ55sMrPHeTGH+VcbmOTWqdOKj
 Far+SJwJ98T/ECl25Y0MeaEh14bht2O7o5MsrFvgJ4gh0CQH2gPGA76SVfenHGFCCCia5
 8mbI//YZQ8ykiDVSRD82dz/CdJvvfhsqRBU=

--PVd3DlCk12lsPCubalyr
Content-Language: ja-JP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGksDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQmlqdSBEYXMgW21h
aWx0bzpiaWp1LmRhcy5qekBicC5yZW5lc2FzLmNvbV0NCj4gU2VudDogRnJpZGF5LCBBdWd1c3Qg
MjEsIDIwMjAgMTE6MTcgUE0NCj4gVG86IGNpcC1kZXZAbGlzdHMuY2lwLXByb2plY3Qub3JnOyBp
d2FtYXRzdSBub2J1aGlybyjlsqnmnb4g5L+h5rSLIOKWoe+8s++8t++8o+KXr++8oe+8o++8tCkN
Cj4gPG5vYnVoaXJvMS5pd2FtYXRzdUB0b3NoaWJhLmNvLmpwPjsgUGF2ZWwgTWFjaGVrIDxwYXZl
bEBkZW54LmRlPg0KPiBDYzogQ2hyaXMgUGF0ZXJzb24gPGNocmlzLnBhdGVyc29uMkByZW5lc2Fz
LmNvbT47IEJpanUgRGFzIDxiaWp1LmRhcy5qekBicC5yZW5lc2FzLmNvbT47IFByYWJoYWthciBN
YWhhZGV2IExhZA0KPiA8cHJhYmhha2FyLm1haGFkZXYtbGFkLnJqQGJwLnJlbmVzYXMuY29tPg0K
PiBTdWJqZWN0OiBbUEFUQ0ggNC4xOS55LWNpcCAwLzddIEFkZCBJUE1NVS9TWVMtRE1BQy9HUElP
L0VBVkIgU3VwcG9ydCBvbiBSOEE3NzRFMQ0KPiANCj4gVGhpcyBwYXRjaCBzZXJpZXMgYWRkIHN1
cHBvcnQgZm9yIElQTU1VL1NZUy1ETUFDL0dQSU8vRUFWQiBvbg0KPiBIaUhvcGUgUlovRzJIIGJv
YXJkIGJhc2VkIG9uIFI4QTc3NEUxIFNvQy4NCj4gDQo+IFRoaXMgcGF0Y2hlcyBpbiB0aGlzIHNl
cmllcyBhcmUgY2hlcnJ5LXBpY2tlZCBmcm9tIG1haW5saW5lLg0KPiANCj4gVGhpcyBwYXRjaCBz
ZXJpZXMgZGVwZW5kIHVwb24gWzFdDQo+IFsxXTogaHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9y
Zy9wcm9qZWN0L2NpcC1kZXYvbGlzdC8/c2VyaWVzPTMzNjQ4OQ0KPiANCj4gTGFkIFByYWJoYWth
ciAoMik6DQo+ICAgZHQtYmluZGluZ3M6IGlvbW11OiByZW5lc2FzLGlwbW11LXZtc2E6IEFkZCBy
OGE3NzRlMSBzdXBwb3J0DQo+ICAgZHQtYmluZGluZ3M6IGRtYTogcmVuZXNhcyxyY2FyLWRtYWM6
IERvY3VtZW50IFI4QTc3NEUxIGJpbmRpbmdzDQo+IA0KPiBNYXJpYW4tQ3Jpc3RpYW4gUm90YXJp
dSAoNSk6DQo+ICAgaW9tbXUvaXBtbXUtdm1zYTogSG9vayB1cCBSOEE3NzRFMSBEVCBtYXRjaGlu
ZyBjb2RlDQo+ICAgYXJtNjQ6IGR0czogcmVuZXNhczogcjhhNzc0ZTE6IEFkZCBJUE1NVSBkZXZp
Y2Ugbm9kZXMNCj4gICBhcm02NDogZHRzOiByZW5lc2FzOiByOGE3NzRlMTogQWRkIFNZUy1ETUFD
IGRldmljZSBub2Rlcw0KPiAgIGFybTY0OiBkdHM6IHJlbmVzYXM6IHI4YTc3NGUxOiBBZGQgR1BJ
TyBkZXZpY2Ugbm9kZXMNCj4gICBhcm02NDogZHRzOiByZW5lc2FzOiByOGE3NzRlMTogQWRkIEV0
aGVybmV0IEFWQiBub2RlDQoNCkkgaGF2ZSByZXZpZXdlZCB0aGlzIHBhdGNoIHNlcmllcy4gSSBk
aWRuJ3Qgc2VlIGFueSBwcm9ibGVtcy4NCg0KQmVzdCByZWdhcmRzLA0KICBOb2J1aGlybw0KDQo+
IA0KPiAgLi4uL2JpbmRpbmdzL2RtYS9yZW5lc2FzLHJjYXItZG1hYy50eHQgICAgICAgIHwgICAx
ICsNCj4gIC4uLi9iaW5kaW5ncy9pb21tdS9yZW5lc2FzLGlwbW11LXZtc2EudHh0ICAgICB8ICAg
MSArDQo+ICBhcmNoL2FybTY0L2Jvb3QvZHRzL3JlbmVzYXMvcjhhNzc0ZTEuZHRzaSAgICAgfCAz
NjEgKysrKysrKysrKysrKysrKystDQo+ICBkcml2ZXJzL2lvbW11L2lwbW11LXZtc2EuYyAgICAg
ICAgICAgICAgICAgICAgfCAgIDUgKw0KPiAgNCBmaWxlcyBjaGFuZ2VkLCAzNDkgaW5zZXJ0aW9u
cygrKSwgMTkgZGVsZXRpb25zKC0pDQo+IA0KPiAtLQ0KPiAyLjE3LjENCg0K

--PVd3DlCk12lsPCubalyr
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5233): https://lists.cip-project.org/g/cip-dev/message=
/5233
Mute This Topic: https://lists.cip-project.org/mt/76329804/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--PVd3DlCk12lsPCubalyr--
