Return-Path: <SRS0=p6Ok=EM=lists.cip-project.org=bounce+64572+5753+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3861DC2D0A3
	for <cip-dev@archiver.kernel.org>; Fri,  6 Nov 2020 07:09:49 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CCB320704
	for <cip-dev@archiver.kernel.org>; Fri,  6 Nov 2020 07:09:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="QaStUZ7R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CCB320704
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5753+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id LrTQYY4521723xBgN89egLhK; Thu, 05 Nov 2020 23:09:47 -0800
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.153])
 by mx.groups.io with SMTP id smtpd.web10.8548.1604646584820671230
 for <cip-dev@lists.cip-project.org>;
 Thu, 05 Nov 2020 23:09:46 -0800
X-Received: by mo-csw.securemx.jp (mx-mo-csw1514) id 0A679acG023793; Fri, 6 Nov 2020 16:09:37 +0900
X-Iguazu-Qid: 34tru22SltYPFdDcni
X-Iguazu-QSIG: v=2; s=0; t=1604646576; q=34tru22SltYPFdDcni; m=tOR8u7zodbvLGGmMJLTVHWNagrZ05Gyh7A2fYrIGiXc=
X-Received: from imx2.toshiba.co.jp (imx2.toshiba.co.jp [106.186.93.51])
	by relay.securemx.jp (mx-mr1513) id 0A679ZWI006323;
	Fri, 6 Nov 2020 16:09:35 +0900
X-Received: from enc01.toshiba.co.jp ([106.186.93.100])
	by imx2.toshiba.co.jp  with ESMTP id 0A679ZO3014364;
	Fri, 6 Nov 2020 16:09:35 +0900 (JST)
X-Received: from hop001.toshiba.co.jp ([133.199.164.63])
	by enc01.toshiba.co.jp  with ESMTP id 0A679Zom029226;
	Fri, 6 Nov 2020 16:09:35 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mOQ6T3RUgD5iJJI0OLkpzSMu7fahvDnFSsPF328j3lPSSyHyCf+PbrdHVYb2Ngjqmoo0e8oKkU6VPTxKIcO/oOQkKTnBiIeiYE53QYMcNxC50QfMqOIbfSxxY+nvV62NreMlVzbiDqjWAPrW6CZftON2iliyYUrjRKDTDYXHfN8ZRVgSwUe8jLaVTIiwrpaoblu8g0bEvThv+6PtFCkgLaeeirtKG+YkSfx8TTmp67nX8+S9g+QjuXFts5zbcVdiDeUdp2ZRn5rpMb29e6EbfCXHrTV/6kR7rf7R4NvU4LMKQ9eLUMAs++4Fk191ThN8oa1GaxoG9gt1A+r4CxqHvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3TSJ646lar+TnMh/R3KGvF4aTB5Il0Acpj0vKUjwvCs=;
 b=Jgzp37woamCf/2W8Cx99XaQVV4hVH5wXMCsNk6jT1gevk31RyumlhCcyL2IGFPGmrhSEObcJohD6fpX33eP5JKB6pyA2rX/c73UU76xknqGYGlyN/eZh0VSNFTskhz9Rom7/pnh/PZKbQ+Ph/WVrQMLRkfdEHFUBTxDqKv09dQKbPZhCZl4dfBh3m6LNV3hpxUglyZrTElLJ3/w9+HwI/yrrMrCmDE/CWoICjKb06AqHPv+UyiHQEB2eelvHyNrqED14L8JCjORTZ5xLmp38YX0veHC7sT2WmTLT80X0PUYgzA3XbZug9am8miUjMfrgrneQstTiQe+TJnmb/D6ypQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: "Nobuhiro Iwamatsu" <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <pavel@denx.de>, <prabhakar.mahadev-lad.rj@bp.renesas.com>
CC: <cip-dev@lists.cip-project.org>, <biju.das.jz@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 4.19.y-cip 0/6] Renesas RZ/G2H add USB{2,3} support
Thread-Topic: [PATCH 4.19.y-cip 0/6] Renesas RZ/G2H add USB{2,3} support
Thread-Index: AQHWs1krmOIlHCLvU0GK0kD8ebXz6am5cwuAgAE9c1A=
Date: Fri, 6 Nov 2020 07:09:33 +0000
X-TSB-HOP: ON
Message-ID: <OSBPR01MB2983B5BB3FC2BBF6AD90C97392ED0@OSBPR01MB2983.jpnprd01.prod.outlook.com>
References: <20201105095039.4751-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20201105121203.GA11467@duo.ucw.cz>
In-Reply-To: <20201105121203.GA11467@duo.ucw.cz>
Accept-Language: ja-JP, en-US
x-originating-ip: [103.91.184.7]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 87a08b31-ceb7-4988-3b1b-08d88222e9c5
x-ms-traffictypediagnostic: OSAPR01MB3329:
x-microsoft-antispam-prvs: <OSAPR01MB3329540E7BA2B458401A472992ED0@OSAPR01MB3329.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ToUv86o21JXGMGZRLxRk7oFrjkc68GT0rZ3NRmSoU8H3Umhm4qAIuYIUU0aVnUbk/iN0gLXYWlGhSiMwf3IR3+4mZH0IlS63jPzF7jD1mu32SdTx4O03m/7ElRn1sX4xg1y7XbNjfhpsFxHyvFXmj4z984/cuNtncpzPSkw2u+pzvlBEA0HBldNwWc+0f3yi60OIu6yiEtFWAwz/OLYm6mU/0jxCBe1KaQn+xeX/OA5riB54yDJeZ2JfemwIYmU2J9zqzbF2eOFrTcug0zly7HCtVOwTSfN7E62MV5NNgusSLZqumd53ANjs8rTo0OXCWRjI1R8zBlVlwrXL5ATjqQ==
x-ms-exchange-antispam-messagedata: Vja62sc9qSLaXUabIVDYQGiiNBelhD9PXgytVY1q0vfgb9WPUpR/hVHZ7S1FTejFietxC/h7c7+Ti/zt2u11eJviwKRio8zxauNf7XSBr67RjBvJZWaH9AY5HQMOT4C7rBQ4AIFN1TR21rylkYWxpRpgACBSMCq4yLmqvpu4iA6+n2FXthWPk0O2Higl+RzgFe2+CqClayfUp2POEdw/aL0MDpSfg9QUyx1YY07DsqVaqUB4tHJq5NbH1emGTwH6QPQ+RTbr1EROqTtCPof50tlzx+ZvjlkkJ+DMGXKfJY2L811lo0KRRyOL1/DYqYEHZAZYezd+4sklj28eOfYXDBCwi3AwqdVAI/zB6XV+n9Kcg5TFw+3qkmra8TqC8UQzRSJLPaE0ze5JH/ASYUjLLgE6sILIb/hUbWFwnQb8dUM4U65PafgYW4z60esiNnIsDNDPiUOnzsPz52ijcHNsLx9gTmOAZb9f8LJvcen33wZNywUWr6+/b2DDQkFRKx5njnpMDJYE1mjQNUolXFA2SdlQNBV4qsEi1ds08ZkS11V1NQia3N2emduZ7hNBRDfSfye2geWLu0zIC+xQZ9qVh3PG/j5++2KcyH//jrAbB1iNICJUki61/e/Ii7YXjwFfzJdO+UTZaZ0dcbzE656kdw==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2983.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87a08b31-ceb7-4988-3b1b-08d88222e9c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2020 07:09:33.4921
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 961iaJVYIvKrG29aCWxR+BM2fqRgQnhX6Qa/wPV/lSDMi7qpQx28ZnBnwVSQqoBt+cI10HpBD0jTeeYO64BUAlFcxEuQieR59sSpPg0VOssZLPI8I9ZxDcSz9mTAlC0N
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB3329
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: UgCMfW1pFZxzrNjzswh5rZonx4520388AA=
Content-Type: multipart/mixed; boundary="rZkQzNrWqIFWwlKQ5hMm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1604646587;
 bh=IUZkGca/q7JaxKeA2ZRPVpj5/mSvFQz/b85pwc1IEgk=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=QaStUZ7RTOJhiSkhUmYwNpUjY6Rfb9VNIYZoeHH8erQidbepZhbgPWoDHxMSqLgbHyq
 AUMSO5MOuGG6sqFr8mYBJPo5YrHpDz/FNFYJO/7C243QntqtVqIL4MGTB69ROW3mDT7as
 JnUkAgsEcI3uCW8jRq114+EpS6UWF42cZS8=

--rZkQzNrWqIFWwlKQ5hMm
Content-Language: ja-JP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGksDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUGF2ZWwgTWFjaGVr
IFttYWlsdG86cGF2ZWxAZGVueC5kZV0NCj4gU2VudDogVGh1cnNkYXksIE5vdmVtYmVyIDUsIDIw
MjAgOToxMiBQTQ0KPiBUbzogTGFkIFByYWJoYWthciA8cHJhYmhha2FyLm1haGFkZXYtbGFkLnJq
QGJwLnJlbmVzYXMuY29tPg0KPiBDYzogY2lwLWRldkBsaXN0cy5jaXAtcHJvamVjdC5vcmc7IGl3
YW1hdHN1IG5vYnVoaXJvKOWyqeadviDkv6HmtIsg4pah77yz77y377yj4pev77yh77yj77y0KQ0K
PiA8bm9idWhpcm8xLml3YW1hdHN1QHRvc2hpYmEuY28uanA+OyBQYXZlbCBNYWNoZWsgPHBhdmVs
QGRlbnguZGU+OyBCaWp1IERhcyA8YmlqdS5kYXMuanpAYnAucmVuZXNhcy5jb20+DQo+IFN1Ympl
Y3Q6IFJlOiBbUEFUQ0ggNC4xOS55LWNpcCAwLzZdIFJlbmVzYXMgUlovRzJIIGFkZCBVU0J7Miwz
fSBzdXBwb3J0DQo+IA0KPiBIaSENCj4gDQo+ID4gVGhpcyBwYXRjaCBzZXJpZXMgYWRkcyBVU0J7
MiwzfSBzdXBwb3J0IHRvIFJlbmVzYXMgUlovRzJIIFNvQy4NCj4gPg0KPiA+IEFsbCB0aGUgcGF0
Y2hlcyBoYXZlIGJlZW4gY2hlcnJ5LXBpY2tlZCBmcm9tIExpbnV4IHY1LjEwLXJjMi4NCj4gDQo+
IFNlcmllcyBsb29rcyBvayB0byBtZSBhbmQgcGFzc2VzIG91ciB0ZXN0aW5nLCBJIGNhbiBhcHBs
eSBpdCBpZiB0aGVyZQ0KPiBhcmUgbm8gb3RoZXIgY29tbWVudHMuDQoNCkxvb2tzIGdvb2QgdG8g
bWUgdG9vLiBJIGFwcGxpZWQgYW5kIHB1c2hlZCB0byBrZXJuZWwub3JnLg0KDQpCZXN0IHJlZ2Fy
ZHMsDQogIE5vYnVoaXJvDQo=

--rZkQzNrWqIFWwlKQ5hMm
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5753): https://lists.cip-project.org/g/cip-dev/message=
/5753
Mute This Topic: https://lists.cip-project.org/mt/78047670/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--rZkQzNrWqIFWwlKQ5hMm--
