Return-Path: <SRS0=Fl7n=BT=lists.cip-project.org=bounce+64572+5107+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42956C433E0
	for <cip-dev@archiver.kernel.org>; Sun,  9 Aug 2020 11:31:54 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C1E6206D8
	for <cip-dev@archiver.kernel.org>; Sun,  9 Aug 2020 11:31:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="HSs7SYaF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C1E6206D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5107+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id aA3wYY4521723xMnuja5L0v4; Sun, 09 Aug 2020 04:31:53 -0700
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.157])
 by mx.groups.io with SMTP id smtpd.web12.22151.1596972710280575634
 for <cip-dev@lists.cip-project.org>;
 Sun, 09 Aug 2020 04:31:51 -0700
X-Received: by mo-csw.securemx.jp (mx-mo-csw1115) id 079BVN8L017309; Sun, 9 Aug 2020 20:31:23 +0900
X-Iguazu-Qid: 2wGqu78fiqWzlTRdT6
X-Iguazu-QSIG: v=2; s=0; t=1596972683; q=2wGqu78fiqWzlTRdT6; m=xegeNJM7DLejylX0KoZntWmCQKbYf7RkJ7eVI3a4kvw=
X-Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
	by relay.securemx.jp (mx-mr1113) id 079BVJ3T027932;
	Sun, 9 Aug 2020 20:31:20 +0900
X-Received: from enc03.toshiba.co.jp ([106.186.93.13])
	by imx12.toshiba.co.jp  with ESMTP id 079BVJdL017388;
	Sun, 9 Aug 2020 20:31:19 +0900 (JST)
X-Received: from hop101.toshiba.co.jp ([133.199.85.107])
	by enc03.toshiba.co.jp  with ESMTP id 079BVIJM016544;
	Sun, 9 Aug 2020 20:31:18 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KODMVlYZ5/rBe7qWy0VIpukDOE+sb8NI2drS4h0WsggjrANGNonzB02ddE8uKmbTv0+cl2P36S/GkSY5ioUfnceh6MbtsjRwe6+x0IYenJW04cgUceicCgOxNHmDW8+7uEwvapbhtXtbqt5lIw+Bgv8jRcjWI1ELbEhLQT3xX5zfMPp5c/MRgfjqMLldk14Wiq7rU/D014aXf55PiDCytWeOuofAkUtudjgBuYHxMg3KLEujLHdb6n1bJMtTGncQ6grtLtqHUa+oK/yMefU4MriW2r8XraIjgI6VQwXZqXab9iytFuHLK4ZyNtY9rU4aRUauwN9Q9yHqo168e6YLsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bzq85aJR+txu1Sh+b9IQ2/YDIC2u8vHGUWKbh5ru6ug=;
 b=JvD1M+Ggr//+VfwhBXRxKvEjgk+YjPpKEmCpeh4DBbmNX4srp0+pPzFU2SB2ULU8FhnUO6MHIi/FjQ4xF9pLUX2z07Cq1vQl7lNW0k99j87pj6aNphbzs8VVCc3o96Pf/M0zvCcVBKEnpWkQzFysmF0o0lhwyhTNTeCDBy4pwFEsL/npbtaIVd7gXvJgRCQ1C11WPBLMH6vuAYaRKJbYTiSdklw4+zTt+V2bSfNjLaXNfUiOwHuJYSPPPFUiTLT9EKDCLcymt5GloBdovVYBb6NZPu3F4Uxwn68ddMvdj3e81z2+IS7rUbkHqm2FkY61s9kzF5UuARoiWtI4xvqEPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: "Nobuhiro Iwamatsu" <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
CC: <masashi.kudo@cybertrust.co.jp>, <ben.hutchings@codethink.co.uk>,
        <pavel@denx.de>, <Chris.Paterson2@renesas.com>, <wens@csie.org>,
        <SZ.Lin@moxa.com>
Subject: [cip-dev] [ANNOUNCE] Release v4.19.138-cip32 and v4.4.231-cip48-rebase
Thread-Topic: [ANNOUNCE] Release v4.19.138-cip32 and v4.4.231-cip48-rebase
Thread-Index: AdZuQH+kfppGYGm7QCuvSJ4eJqUAQA==
Date: Sun, 9 Aug 2020 11:31:15 +0000
X-TSB-HOP: ON
Message-ID: <OSBPR01MB2983120644853CACA6FB69C392470@OSBPR01MB2983.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
x-originating-ip: [103.91.184.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 258b566e-5b5c-40e3-3dda-08d83c57ba5b
x-ms-traffictypediagnostic: OS0PR01MB5412:
x-microsoft-antispam-prvs: <OS0PR01MB5412FA101F8BB350E17D2F4392470@OS0PR01MB5412.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1751;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: FVvnF6MzA38naAmlPMxCRqS7iLfcf1MNxj3n+Nf2H1/e4jos4SsGjevAlOSgEuZDq+aGAjr0sWtRptuFF5rUoTFKGWUcP0S16UoJVkawyMrWXS0xR3OAAQXoYVOfa+sGAWxHpR9k35lACWhpQ8wpfSN+YxFghm/fPgUAnF9iPgOR2uuJL3nISWzbGhQqotPEiui2iWMTha1KBVmmBx/un8T+aQcFJWUOPp+khgDTqbKk5W5ERlIKsldXnLo63ESaHNuY4godNKgHnueQ07T4LgqOJP+LSKRwVq/w2rnOijzns7BGDIkhO9pl0+HFnfKYfuLxTvE1feCgYrE86s2/U/OLpJjjVKZlEpgcSKxduBTJW+gxIBj8Gj+wL6jyg2WYw4cLVuF+IuKNvgMahZEBiQ==
x-ms-exchange-antispam-messagedata: yTW1hpgR3ylZO2J3fQnK39oTLyO3p4acGgDUiODw6+x2gFvE6rPdSaGyFiL+GAc2COZek9LxaofvTgr6yBT81H3bf7D7g5x8c1keX10ULxbjvxvWMbGfBTpNKVlsODEBp/bTsjYGhdL5yfCK1JrMb+DUOwQIHKIFTxdI0ipaPKUKc7gQp4g4b4ALWhkrihsUO2A+KskVuj/+9OW3BTgeDAopjsN2WffpyUQ3z3CKKjxszBt7nN2gEDCaAIZt3hzLmKrVL9oCbq+YGlIBqhu/I7LtMmeD5Vi0rbhRLt5+s3EWPhFqpFCoawlpehF2XNY/fWggReXO2PrE01M693jonPMJEMs7OrPdoFvgsNhrak2OJTqLZThbNV/PukvlrZniV28xbcyca+bW16z9X3ODVohRJrRKiMJMK8OCoFPrVbwvVix8ksO45PWTVgWs5SMBlguhZs/4WhLSwaMMX04XRpJ4R2sEpLhKdyEbhhLJHHVr+98yBC/yilmhvMVsqPO55rHSpebLSclBYrgUmZYdbzn9jndwAZKZlRm3PO8LJ+CzhkRdvHMXTsmUuovqa28yEGiCbi8kv9gUIWGiw9N+9vSvOIW0wGhsqqkKd5aCgIh0KhCryznqBChKIE7uHxgCpWtzwF8UQYZrZOXkwsxG3Q==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2983.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 258b566e-5b5c-40e3-3dda-08d83c57ba5b
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2020 11:31:15.7799
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4/GZlGl5KfLD7KmKTSpqGEYknorNuxrN1W7fASaUjUIzUra5dbJK998gf3N2xq4mvT4p8ppQ8hAmSwKzrKzz0u70Hy+X6TbiI/tTvgN1Zn4sdiTtrC1XlskEHbevVA+r
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB5412
MSSCP.TransferMailToMossAgent: 103
X-OriginatorOrg: toshiba.co.jp
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: AyUzPXB2dWhsdqEtViwMBqA5x4520388AA=
Content-Type: multipart/mixed; boundary="mqzu5AjPQiNTL9urJfZY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1596972713;
 bh=Esigzpj5M8dtDrGgnwg42SNiqtUJlDxBhdKy5rziVqs=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=HSs7SYaFjIQNa6RetWkjUVsc1Ptw8++G+2i34Pvas45lT4ArP8vbl4paQPSqvuzCyX5
 /EUdG962pucNnRG3Pn60CvrHk+aRHmbOwhb/uKuGlToX+KVoeNl0r41+P2tZrY7khhpad
 0ayjoEbxOJgePq2nOW+3KF60MHBXZTkT0sA=

--mqzu5AjPQiNTL9urJfZY
Content-Language: ja-JP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGksDQoNCkNJUCBrZXJuZWwgdGVhbSBoYXMgcmVsZWFzZWQgTGludXgga2VybmVsIHY0LjE5LjEz
OC1jaXAzMiBhbmQgdjQuNC4yMzEtY2lwNDgtcmViYXNlLg0KVGhlIGxpbnV4LTQuMTkueS1jaXAg
dHJlZSBoYXMgYmVlbiB1cGRhdGVkIGJhc2UgdmVyc2lvbiBmcm9tIHY0LjE5LjEzNCB0byB2NC4x
OS4xMzgsDQphbmQgdGhlIGxpbnV4LTQuNC55LWNpcCB0cmVlIGhhcyBiZWVuIHVwZGF0ZWQgYmFz
ZSB2ZXJzaW9uIGZyb20NCnY0LjQuMjMwIHRvIHY0LjQuMjMxLg0KQW5kIEluIGxpbnV4LTQuNC55
LWNpcCwgYSBwYXRjaCBmb3IgYWRkaW5nIHRoZSB1cGRhdGl0bmcgRFUgYW5kIHRvdWNoIHBhbmVs
IGZ1bmN0aW9ucyBmb3IgUlovRzEgaGFzIGJlZW4gYWRkZWQuDQoNCllvdSBjYW4gZ2V0IHRoaXMg
cmVsZWFzZSB2aWEgdGhlIGdpdCB0cmVlIGF0Og0KDQogIHY0LjE5LjEzOC1jaXAzMjoNCiAgICBy
ZXBvc2l0b3J5Og0KICAgICAgaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tl
cm5lbC9naXQvY2lwL2xpbnV4LWNpcC5naXQNCiAgICBicmFuY2g6DQogICAgICBsaW51eC00LjE5
LnktY2lwDQogICAgY29tbWl0IGhhc2g6DQogICAgICA4N2UzMGFkMzgwYjJkYTg5YjhmYjI3ZTYx
YTM4YzQ2N2E2MjhiMTAyDQogICAgYWRkZWQgY29tbWl0czoNCiAgICAgIENJUDogQnVtcCB2ZXJz
aW9uIHN1ZmZpeCB0byAtY2lwMzIgYWZ0ZXIgbWVyZ2UgZnJvbSBzdGFibGUNCiAgICAgIGRybTog
b2Y6IEZpeCBkb3VibGUtZnJlZSBidWcNCg0KICB2NC40LjIzMS1jaXA0OC1yZWJhc2U6DQogICAg
cmVwb3NpdG9yeToNCiAgICAgIGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9r
ZXJuZWwvZ2l0L2NpcC9saW51eC1jaXAuZ2l0DQogICAgYnJhbmNoOg0KICAgICAgbGludXgtNC40
LnktY2lwDQogICAgY29tbWl0IGhhc2g6DQogICAgICA3ZDhlYTUwN2ZlYTFiNjk1NTc5OTRmM2Rj
MGQ5NmQyNTA1YWY5NWVhDQogICAgYWRkZWQgY29tbWl0czoNCiAgICAgIENJUDogQnVtcCB2ZXJz
aW9uIHN1ZmZpeCB0byAtY2lwNDggYWZ0ZXIgbWVyZ2UgZnJvbSBzdGFibGUNCiAgICAgIEFSTTog
ZHRzOiBpd2cyMmQtc29kaW1tOiBFbmFibGUgdG91Y2hzY3JlZW4NCiAgICAgIEFSTTogZHRzOiBp
d2cyMmQtc29kaW1tOiBFbmFibGUgTENEIHBhbmVsDQogICAgICBBUk06IHNobW9iaWxlOiBkZWZj
b25maWc6IEVuYWJsZSBzdXBwb3J0IGZvciBwYW5lbHMgZnJvbSBFRFQNCiAgICAgIEFSTTogc2ht
b2JpbGU6IGRlZmNvbmZpZzogRW5hYmxlIGZyYW1lIGJ1ZmZlciBjb25zb2xlIGZvciBhcm1hZGls
bG84MDBldmENCiAgICAgIGRybTogcmNhci1kdTogVXNlIHRoZSBEUk0gcGFuZWwgQVBJDQogICAg
ICBkcm06IHJjYXItZHU6IFN1cHBvcnQgcGFuZWxzIGNvbm5lY3RlZCBkaXJlY3RseSB0byB0aGUg
RFBBRCBvdXRwdXRzDQogICAgICBkcm0vcGFuZWw6IHNpbXBsZTogQWRkIEVEVCBwYW5lbCBzdXBw
b3J0DQogICAgICBkdC1iaW5kaW5nczogZGlzcGxheTogQWRkIGJpbmRpbmdzIGZvciBFRFQgcGFu
ZWwNCiAgICAgIG9mOiBhZGQgbm9kZSBuYW1lIGNvbXBhcmUgaGVscGVyIGZ1bmN0aW9ucw0KICAg
ICAgZHJtOiBBZGQgYW4gZW5jb2RlciBhbmQgY29ubmVjdG9yIHR5cGUgZW51bSBmb3IgRFBJLg0K
ICAgICAgc2VyaWFsOiBzaC1zY2k6IE1ha2Ugc3VyZSBzdGF0dXMgcmVnaXN0ZXIgU0N4U1IgaXMg
cmVhZCBpbiBjb3JyZWN0IHNlcXVlbmNlDQoNCkJlc3QgcmVnYXJkcywNCiAgIE5vYnVoaXJvDQo=

--mqzu5AjPQiNTL9urJfZY
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5107): https://lists.cip-project.org/g/cip-dev/message=
/5107
Mute This Topic: https://lists.cip-project.org/mt/76082569/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--mqzu5AjPQiNTL9urJfZY--
