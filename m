Return-Path: <SRS0=UL+3=CF=lists.cip-project.org=bounce+64572+5278+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC3F9C433E1
	for <cip-dev@archiver.kernel.org>; Thu, 27 Aug 2020 07:15:02 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BDD320786
	for <cip-dev@archiver.kernel.org>; Thu, 27 Aug 2020 07:15:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="rKMe8Tzf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BDD320786
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5278+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id GCU8YY4521723xpkYmSlBEYk; Thu, 27 Aug 2020 00:15:02 -0700
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.153])
 by mx.groups.io with SMTP id smtpd.web12.13687.1598512500099377811
 for <cip-dev@lists.cip-project.org>;
 Thu, 27 Aug 2020 00:15:01 -0700
X-Received: by mo-csw.securemx.jp (mx-mo-csw1514) id 07R7Ef49017526; Thu, 27 Aug 2020 16:14:41 +0900
X-Iguazu-Qid: 34tKNrBeFqbaHeLZkb
X-Iguazu-QSIG: v=2; s=0; t=1598512480; q=34tKNrBeFqbaHeLZkb; m=wWM7XSe6mB7+6dheCgU+o7ph6Xx4/VDldVM9gOIppos=
X-Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
	by relay.securemx.jp (mx-mr1512) id 07R7Edq8013151;
	Thu, 27 Aug 2020 16:14:39 +0900
X-Received: from enc02.toshiba.co.jp ([61.202.160.51])
	by imx12.toshiba.co.jp  with ESMTP id 07R7EdEX024554;
	Thu, 27 Aug 2020 16:14:39 +0900 (JST)
X-Received: from hop101.toshiba.co.jp ([133.199.85.107])
	by enc02.toshiba.co.jp  with ESMTP id 07R7EdPu026602;
	Thu, 27 Aug 2020 16:14:39 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YaMbkAflD1URN2duu4DR++lyGAmc1zi5PSRno95HblEx1wWOwVyQzC2Xri7qy+M3vQkAKk9lG/e+dAjUhkmeFSQPSRFq5oi5zG9Wu14LoeYqogGfv/e8fK/fS9vqLpzVb10Tqmj7RxQbi58O4tkaWTZCAyGlKh9Luwc0R27iJFidw30ti7r63Y9oiJMtxIqQBeSj+aXJUVuNHmMqLY/wmxAfxFvATKoMnHuTB2wGWNkIalTLcbroyE6fvUOQU/R3ib3M4bSLr23w33yWgBLn5SzWr/7rO2iBtMzNXzZ/6kYrrvWpcpFsdUow+ltO1NOLuNCHuRCzjGFe0j6Ahmeq5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UTNe8hHCVNUjRKem1QfczzXoWbbFEMq+9JBjiQkMp0M=;
 b=Be8XOvW4HZjbNehrZJ+ZHZJJ/CleQV4SYYxEudtYCOplJMK3e8hq2fguhoMA1wbtzfnptHGDZkg7zFfksAmblDHtN9OY+nEVbRTaf3a/G6wZXir2c5UdsUZiVt/77J7JV2WrreBhAnIVe/dNFsOy3VIC42jfutN0Z1TebkkZjmphdpg8D++N4qg34e8XvtW9K9tNLb7SGrzETcB1Kg3gpdy/ZAWJRi1GX5QZIbD/Rb6gmMXKB552FDH6lVWnnt2bOMwiNun2UBm9EkWoCjztaU6d4dTj4eW4DDMp+B4cKkiENgsqW0w1LXPKdkWwAU8n9GBCy1638s8J6vRNUVnMgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: "Nobuhiro Iwamatsu" <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <biju.das.jz@bp.renesas.com>, <cip-dev@lists.cip-project.org>,
        <pavel@denx.de>
CC: <chris.paterson2@renesas.com>, <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 4.19.y-cip 00/10] Add support for [H]SCIF/SDHI/I2C/RWDT/MSIOF
Thread-Topic: [PATCH 4.19.y-cip 00/10] Add support for
 [H]SCIF/SDHI/I2C/RWDT/MSIOF
Thread-Index: AQHWe5saAd/sKD3wYEKQHRY5n4oslalLi+/A
Date: Thu, 27 Aug 2020 07:14:33 +0000
X-TSB-HOP: ON
Message-ID: <TYAPR01MB29908A7A7B5BA85D252D5AC492550@TYAPR01MB2990.jpnprd01.prod.outlook.com>
References: <20200826112132.4090-1-biju.das.jz@bp.renesas.com>
In-Reply-To: <20200826112132.4090-1-biju.das.jz@bp.renesas.com>
Accept-Language: ja-JP, en-US
x-originating-ip: [103.91.184.4]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 52fdd9b1-b9c7-485c-7321-08d84a58d987
x-ms-traffictypediagnostic: TYAPR01MB2701:
x-microsoft-antispam-prvs: <TYAPR01MB27010DA9A093943B71C8994892550@TYAPR01MB2701.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: dNy4SgJJWzCuNgK58eFpoDezND8wQQFQqWwQZjpQyyafzL2KWmRfxz6znGyTp80wgfCtxiuic0Lu8tA2xVb9In2BKtllw8+pekN3t4xLBu1YJNTJhbQbscfmKreEu0rCuhaC9fCW56FdPeCOtprIwBowWufpisQx1AxhXceTWgefJLPve1PQVIqjj+4dMrx7x24weSD/cUAGYJKijNuEt+4dNJJikW1KYNpzEB8UVaHFmmjBu/rN1NyGO8LbTLbbAWPm7wnl6nxOwv+xauvwyQny6u1w2vlCc+6cMhmw9KG3gnD4m2KIHhkR7EbVKxznwTEuj6z6oVWpQTqlwZkfz3fOdwAz4Ga4URgFgMV+1FKFXbxisbbFIVchjAgUv4Wv460YvmI90Li86LBoN1hKKQ==
x-ms-exchange-antispam-messagedata: xdxFtfwy0n7fwM7Iqg9N0UHft7ZZuU4b87KpUZETWJmQfJ/ZNwjH6q2VYdiGpJqFaArEqOF1gXxxF2mu0rYAccZTJ5mrIgTE9KUPNdj53+CNVM9H2Ni6leXNbmpTcgpJrjUAsGMG3J/VtZoMhQX9YtfaVjJKy5qYaodhvsB/PkcQjAtRD6u8gYBVrEZ7U+xe43lPWYIlNERkLF3KYEaKAbbm1w06gO3f4R1BThG+eGCuH/oB4C8kb6OQ9T/1QYLDPBogv0n6NU7uaaTNbm4FbZUlaQg12DLNbl/MAzEDD+szTunCR9HWaydgFZEK+Yuc/in6zXkPnml0h7FqPDgDUaMf1D22GFXUSbru8Hl6tH6fSMzE0l/MFG8uNBQtB8a3ya82Oje4VoJENeZKZszPmtCltU5jJNxTbe+pAymRlCTmR/gUlZ9A8WU/PZec/DXDbgRsiKrap9lST/cAX9DHPh4ePFMbw9dmZCSi5gR1ufAr7A2IqajBvv3Ni/WJUUdjsYwlDGQ9zN1zNxi2NU9SZIBlSJr0w6XP+zA4JeJROTu5/X8vipF+5s01Qrc0o8FKTdTC4cpwfk+Z/husngEaN5scOfjBUplReq9sNQz+qcGtBzEmZbRY6XqsqhD9gdr3yAVgQqzibzOKjdSTUS173A==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB2990.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52fdd9b1-b9c7-485c-7321-08d84a58d987
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2020 07:14:33.9525
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 57n3IW87uG4p4Gtyy9nK7K/yf2jtER+LlNyUdl0QKtn4JXLzaD1iBHmnh/f7agQv54phN3HyGdiNresL5EtnTc6pNfFAekszNDSKsJTuM7uevKFhErsexXcQ7J7ue3fe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB2701
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: Fnlh9Pd3rAvcoMIvmLjO0vzFx4520388AA=
Content-Type: multipart/mixed; boundary="q6Al1oyzxbuQHbt5GNCB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1598512502;
 bh=4jzwysitutPXENfKQkF9cRx4ySkPyUtXgu6+EM2GJnE=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=rKMe8TzfnYjx3MOV5pVuTwwOdFDGeLra1yMfm5qRhG+TxWRSd1riLqm5TsvMBtVT3j8
 H19O/U4uMey7Aizxc6oWGL5NycD1sCSBtQS5J1LFRUPCx1GYlqW+e+3UA0y0WmLbiTQPS
 0Yo8FjCUylonQxoNO5TVssRKHUGZTHqwGpo=

--q6Al1oyzxbuQHbt5GNCB
Content-Language: ja-JP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGksDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQmlqdSBEYXMgW21h
aWx0bzpiaWp1LmRhcy5qekBicC5yZW5lc2FzLmNvbV0NCj4gU2VudDogV2VkbmVzZGF5LCBBdWd1
c3QgMjYsIDIwMjAgODoyMSBQTQ0KPiBUbzogY2lwLWRldkBsaXN0cy5jaXAtcHJvamVjdC5vcmc7
IGl3YW1hdHN1IG5vYnVoaXJvKOWyqeadviDkv6HmtIsg4pah77yz77y377yj4pev77yh77yj77y0
KQ0KPiA8bm9idWhpcm8xLml3YW1hdHN1QHRvc2hpYmEuY28uanA+OyBQYXZlbCBNYWNoZWsgPHBh
dmVsQGRlbnguZGU+DQo+IENjOiBDaHJpcyBQYXRlcnNvbiA8Y2hyaXMucGF0ZXJzb24yQHJlbmVz
YXMuY29tPjsgQmlqdSBEYXMgPGJpanUuZGFzLmp6QGJwLnJlbmVzYXMuY29tPjsgUHJhYmhha2Fy
IE1haGFkZXYgTGFkDQo+IDxwcmFiaGFrYXIubWFoYWRldi1sYWQucmpAYnAucmVuZXNhcy5jb20+
DQo+IFN1YmplY3Q6IFtQQVRDSCA0LjE5LnktY2lwIDAwLzEwXSBBZGQgc3VwcG9ydCBmb3IgW0hd
U0NJRi9TREhJL0kyQy9SV0RUL01TSU9GDQo+IA0KPiBBZGQgUlovRzJIIFNvQyBzdXBwb3J0IGZv
ciBbSF1TQ0lGL1NESEkvSTJDL1JXRFQvTVNJT0Ygb24gNC4xOS55LWNpcCBrZXJuZWwuDQo+IA0K
PiBBbGwgdGhlIHBhdGNoZXMgaW4gdGhpcyBzZXJpZXMgYXJlIGNoZXJyeS1waWNlZCBmcm9tIE1M
LCBleGNlcHQgWzFdIHdoaWNoIGlzDQo+IGEgbmV3IHBhdGNoIHNpbWlsYXIgdG8gdGhlIHdvcmtk
b25lIGZvciBvdGhlciBzaW1pbGFyIFNvQydzDQo+IA0KPiBbMV0gbW1jOiByZW5lc2FzX3NkaGlf
aW50ZXJuYWxfZG1hYzogQWRkIHI4YTc3NGUxIHN1cHBvcnQNCj4gDQo+IFRoaXMgcGF0Y2ggc2Vy
aWVzIGRlcGVuZCBvbiBbMl0NCj4gWzJdIGh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcHJv
amVjdC9jaXAtZGV2L2xpc3QvP3Nlcmllcz0zMzgyMzUNCj4gDQo+IEJpanUgRGFzICgxKToNCj4g
ICBtbWM6IHJlbmVzYXNfc2RoaV9pbnRlcm5hbF9kbWFjOiBBZGQgcjhhNzc0ZTEgc3VwcG9ydA0K
PiANCj4gTGFkIFByYWJoYWthciAoOSk6DQo+ICAgYXJtNjQ6IGR0czogcmVuZXNhczogcjhhNzc0
ZTE6IEFkZCBTQ0lGIGFuZCBIU0NJRiBub2Rlcw0KPiAgIGFybTY0OiBkdHM6IHJlbmVzYXM6IHI4
YTc3NGUxOiBBZGQgU0RISSBub2Rlcw0KPiAgIGR0LWJpbmRpbmdzOiBpMmM6IHJlbmVzYXMsaTJj
OiBEb2N1bWVudCByOGE3NzRlMSBzdXBwb3J0DQo+ICAgZHQtYmluZGluZ3M6IGkyYzogcmVuZXNh
cyxpaWM6IERvY3VtZW50IHI4YTc3NGUxIHN1cHBvcnQNCj4gICBhcm02NDogZHRzOiByZW5lc2Fz
OiByOGE3NzRlMTogQWRkIEkyQyBhbmQgSUlDLURWRlMgc3VwcG9ydA0KPiAgIHNwaTogcmVuZXNh
cyxzaC1tc2lvZjogQWRkIHI4YTc3NGUxIHN1cHBvcnQNCj4gICBhcm02NDogZHRzOiByZW5lc2Fz
OiByOGE3NzRlMTogQWRkIE1TSU9GIG5vZGVzDQo+ICAgZHQtYmluZGluZ3M6IHdhdGNoZG9nOiBy
ZW5lc2FzLHdkdDogRG9jdW1lbnQgcjhhNzc0ZTEgc3VwcG9ydA0KPiAgIGFybTY0OiBkdHM6IHJl
bmVzYXM6IHI4YTc3NGUxOiBBZGQgUldEVCBub2RlDQo+IA0KPiAgLi4uL2RldmljZXRyZWUvYmlu
ZGluZ3MvaTJjL3JlbmVzYXMsaTJjLnR4dCAgIHwgICAxICsNCj4gIC4uLi9kZXZpY2V0cmVlL2Jp
bmRpbmdzL2kyYy9yZW5lc2FzLGlpYy50eHQgICB8ICAgMSArDQo+ICAuLi4vZGV2aWNldHJlZS9i
aW5kaW5ncy9zcGkvc2gtbXNpb2YudHh0ICAgICAgfCAgIDEgKw0KPiAgLi4uL2JpbmRpbmdzL3dh
dGNoZG9nL3JlbmVzYXMsd2R0LnR4dCAgICAgICAgIHwgICAxICsNCj4gIGFyY2gvYXJtNjQvYm9v
dC9kdHMvcmVuZXNhcy9yOGE3NzRlMS5kdHNpICAgICB8IDM5MCArKysrKysrKysrKysrKysrKy0N
Cj4gIGRyaXZlcnMvbW1jL2hvc3QvcmVuZXNhc19zZGhpX2ludGVybmFsX2RtYWMuYyB8ICAgMSAr
DQo+ICA2IGZpbGVzIGNoYW5nZWQsIDM4NiBpbnNlcnRpb25zKCspLCA5IGRlbGV0aW9ucygtKQ0K
PiAJDQoNCkkgcmV2aXdlZCB0aGlzIHBhdGNoIHNlcmllcywgbG9va3MgZ29vZCB0byBtZS4NCg0K
QmVzdCByZWdhcmRzLA0KICBOb2J1aGlybw0KDQo=

--q6Al1oyzxbuQHbt5GNCB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5278): https://lists.cip-project.org/g/cip-dev/message=
/5278
Mute This Topic: https://lists.cip-project.org/mt/76426354/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--q6Al1oyzxbuQHbt5GNCB--
