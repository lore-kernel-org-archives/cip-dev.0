Return-Path: <SRS0=CBau=AY=lists.cip-project.org=bounce+64572+4920+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC58FC433E7
	for <cip-dev@archiver.kernel.org>; Mon, 13 Jul 2020 06:19:59 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 315012075F
	for <cip-dev@archiver.kernel.org>; Mon, 13 Jul 2020 06:19:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="MJmR5s1Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 315012075F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4920+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id KzXcYY4521723xHfPHvV584t; Sun, 12 Jul 2020 23:19:58 -0700
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.153])
 by mx.groups.io with SMTP id smtpd.web10.13913.1594621195835473876
 for <cip-dev@lists.cip-project.org>;
 Sun, 12 Jul 2020 23:19:57 -0700
X-Received: by mo-csw.securemx.jp (mx-mo-csw1514) id 06D6JZgE008061; Mon, 13 Jul 2020 15:19:35 +0900
X-Iguazu-Qid: 34tr8v5ejkIAETRu5u
X-Iguazu-QSIG: v=2; s=0; t=1594621174; q=34tr8v5ejkIAETRu5u; m=McU2Swp565DeTz+8PMT+N3vL178aGHWY18K2jfx0EhQ=
X-Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
	by relay.securemx.jp (mx-mr1511) id 06D6JW2T032093;
	Mon, 13 Jul 2020 15:19:33 +0900
X-Received: from enc02.toshiba.co.jp ([61.202.160.51])
	by imx12.toshiba.co.jp  with ESMTP id 06D6JWO5008491;
	Mon, 13 Jul 2020 15:19:32 +0900 (JST)
X-Received: from hop101.toshiba.co.jp ([133.199.85.107])
	by enc02.toshiba.co.jp  with ESMTP id 06D6JWSc014740;
	Mon, 13 Jul 2020 15:19:32 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cxzJqVJMdiH4rSlK4rHqx0ArvFt8UseGQEFHrAbGQM6LjA4Vb0fREiPbZuMdudMlKUMg1fJZRmqBYRg6eyzqO4rZBdWWT4VaV+9+eepzIVzmXr2QvbEIrbNqj32UykGiurimy+whXe1cdsPBCs/2ifX8eoNMSN/nBiGki5naR/GmRgBiDGR7N4nxPn2wBVg9fRESwteBje7Q6+QtJiWa/hRCqKkClsAryYqg2ye+Iaajo/p6E4ItJGQM66aR4BzPJUu4LFiN45+lxHovYYXYEjOSoyD63lzSUmV96r3jLrm/ir/DaQgI0noR/Cm2zVJBImbV9vnRmYQWMIJ7/fxn8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gLquWDgzOLWsdCLO3Vm/J9F3nILb9AUSelwsKvkYFwk=;
 b=hCe7ucyDhY6Tp8aQAbV3/iReu5NSXv4oRrax3y3sImf4FGNadehLx5Uyz5uUCpvBHFaOzT+AGE7D9pUy/OynCRAULzhUCOp8S9su5wtFan3b3N2lGyv8cD/QewSnTIOQzHJbDFAprpxPlpUH7hG48W9G7PgAIQ1slLo6+008rWNPWXawzarDSfxLG5QrBS4d3MzwTDqoLof8JZ0pNbJuSwKUPu/iQxow9haF12OIabVWYc2os86d1JNtcTGDO23kEvEscRSPE7RxZqZrqiamIFECOJmkiKb1cT+ls9Som619ASuMgw73qF1ETw0pPKdJUQewLtD+/OmCPygJaEH6Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: "Nobuhiro Iwamatsu" <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
CC: <ben.hutchings@codethink.co.uk>, <wens@csie.org>, <pavel@denx.de>,
        <Chris.Paterson2@renesas.com>, <masashi.kudo@cybertrust.co.jp>
Subject: [cip-dev] [ANNOUNCE] Release v4.19.132-cip30 and v4.4.230-cip47
Thread-Topic: [ANNOUNCE] Release v4.19.132-cip30 and v4.4.230-cip47
Thread-Index: AdZYqFAlGKZ/wTU2RfGqjgJby72fLg==
Date: Mon, 13 Jul 2020 06:19:28 +0000
X-TSB-HOP: ON
Message-ID: <OSBPR01MB2983573204C4568FC97C866392600@OSBPR01MB2983.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
x-originating-ip: [103.91.184.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7f074b25-3dc9-4599-ab75-08d826f4b2aa
x-ms-traffictypediagnostic: OSAPR01MB2002:
x-microsoft-antispam-prvs: <OSAPR01MB20029D49E36DA698BD698F5492600@OSAPR01MB2002.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:393;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: MNpIQdQd+tD8WwADMdyscXUqAPoVX6uFviCQyObJGZAxiSXPkjsWgGZwQEz+AJYs1u7lnamLowk48+DGwuvBGQcqNtKDZcwDDO4aegpl0uqoSxHyASuOD3e4k5KvxTLT7JSAAkwF/4qFV4fuo83eA1NiK2Wii+UQzT4HmscbbcY0GIhGCiRiKAHvqLwpobj03Ay6IGDADL8DUS+tLmNVOlzdQxaU5HkxLPwjm8Y57QEW+PZYvT1IT301g0VSjiG3U5Cp+B1dCKYN6bzaH2saMKtgAJ2iXBhNUhvk28gA8khLYXF1vET8v74DFbN73iVd5/FQhhk6F1r3Q2ERVwXCSXP02N3CBCXpbyQ4gcyu82xPOdQyA7Fs10Sbdxexne1jRMKpICY1+LicR7m+fRfafA==
x-ms-exchange-antispam-messagedata: oZF0OH1uAa3rK3o89CWyBxyKtn7TkBXm9RpiqvOTDGJkTJ4Sxds4LkY3Zw52LqSaf5f9tIdv9lcYx0Z+Ji9kOF63EHR6ouoxlAx1BbsJL22ivcN3R3SJ3ugu9WwGHDlLt+49FnD21YeSIvVfU1J1Ed/7p2GYYXMu/EvpPmHtcqMVvDMwQ63HMvsqxvhvsQU+F901fzPX2isflgBQRbQ7DV2OBeaXopNWJgX1ijIaFsJ3BeQBLQjC+T7XSOglQmxO3V5uhDe2Zl16TFnPrzGonynkvvIMjZRvyoL74mFCdwCCXypP0ThSwzoMRc4u+ePJmhVNTyZ48W78rdSu9d7segYFVbfmUrGZMgTb8NTtKHlPk6Somr+lOon7R+hXA0MlqE1h0B2nhHH2FFlRaF3EcNo0GxYx/uoELYGrN7SI92sZFIFwUgL9XnqPPgAhM87yPmenYAE+Whre9GSFn/trJ9Ii8ea/DxD2j7tUSgVOEeA=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2983.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f074b25-3dc9-4599-ab75-08d826f4b2aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2020 06:19:28.3420
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KRSXCjAYftjdUzTES4U0IWqelmpirURxtsycpmGreKUv/0IUq5aEEywuCMYH07qNojKw0F1dc/wPKOH04KL4iK0oI60cAqflg6Iq0FbPej6fl0WEVlZx84/F/fv35n6Q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB2002
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: qtKm6lFW1A1bhMPs8qJzl43ax4520388AA=
Content-Type: multipart/mixed; boundary="8mCDCZ2PjPwZVPtfFpn4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1594621198;
 bh=bs2JYc/tGemR9VDLzerDJwkePySCMRQXm1gMZQjw4nM=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=MJmR5s1QWYuogA2gxVRYX+DSCgX6IzYIm7nVRs1k7P8j/o3BfaOwRql1a9gOKCueIji
 w8cIlErd5fcFZazOk0TEB7HgYych3NS2qZiE2BOo51oNGQWbeO41DHDVHY/03Vc+owL0c
 N/zgfrF79RCHNfK/pBZ9zVnQik4ySdi3GbI=

--8mCDCZ2PjPwZVPtfFpn4
Content-Language: ja-JP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGksDQoNCkNJUCBrZXJuZWwgdGVhbSBoYXMgcmVsZWFzZWQgTGludXgga2VybmVsIHY0LjE5LjEz
Mi1jaXAzMCBhbmQgdjQuNC4yMzAtY2lwNDcuDQpUaGUgbGludXgtNC4xOS55LWNpcCB0cmVlIGhh
cyBiZWVuIHVwZGF0ZWQgYmFzZSB2ZXJzaW9uIGZyb20gdjQuMTkuMTMwIHRvIHY0LjE5LjEzMiwN
CmFuZCBsaW51eC00LjQueS1jaXAgdHJlZSBoYXMgYmVlbiB1cGRhdGVkIGJhc2UgdmVyc2lvbiBm
cm9tIHY0LjQuMjI3IHRvIHY0LjQuMjMwLg0KWW91IGNhbiBnZXQgdGhpcyByZWxlYXNlIHZpYSB0
aGUgZ2l0IHRyZWUgYXQ6DQoNCiAgdjQuMTkuMTMyLWNpcDI5Og0KICAgIHJlcG9zaXRvcnk6DQog
ICAgICBodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9jaXAv
bGludXgtY2lwLmdpdA0KICAgIGJyYW5jaDoNCiAgICAgIGxpbnV4LTQuMTkueS1jaXANCiAgICBj
b21taXQgaGFzaDoNCiAgICAgIDRkYTk1YjY4ZWIyYjA0ZGU0ZWMyMTJjMTdkYjQ4NjNkMDMwMWU3
ZjkNCiAgICBhZGRlZCBjb21taXRzOg0KICAgICAgQ0lQOiBCdW1wIHZlcnNpb24gc3VmZml4IHRv
IC1jaXAzMCBhZnRlciBtZXJnZSBmcm9tIHN0YWJsZQ0KDQogIHY0LjQuMjMwLWNpcDQ3Og0KICAg
IHJlcG9zaXRvcnk6DQogICAgICBodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgv
a2VybmVsL2dpdC9jaXAvbGludXgtY2lwLmdpdA0KICAgIGJyYW5jaDoNCiAgICAgIGxpbnV4LTQu
NC55LWNpcA0KICAgIGNvbW1pdCBoYXNoOg0KICAgICAgZmVjNDVkMWE0ZTM4YmJlNWNjOTI0OGM5
NDAwNzQ4Yzg1NzA1MmJiNg0KICAgIGFkZGVkIGNvbW1pdHM6DQogICAgICBDSVA6IEJ1bXAgdmVy
c2lvbiBzdWZmaXggdG8gLWNpcDQ3IGFmdGVyIG1lcmdlIGZyb20gc3RhYmxlDQoNCkJlc3QgcmVn
YXJkcywNCiAgIE5vYnVoaXJvDQo=

--8mCDCZ2PjPwZVPtfFpn4
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4920): https://lists.cip-project.org/g/cip-dev/message=
/4920
Mute This Topic: https://lists.cip-project.org/mt/75471860/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--8mCDCZ2PjPwZVPtfFpn4--
