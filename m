Return-Path: <SRS0=S1hg=DQ=lists.cip-project.org=bounce+64572+5515+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2434C433DF
	for <cip-dev@archiver.kernel.org>; Fri,  9 Oct 2020 00:23:23 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8DBA22253
	for <cip-dev@archiver.kernel.org>; Fri,  9 Oct 2020 00:23:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="xHQ9YtVq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8DBA22253
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5515+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id EVudYY4521723xpKVU6v9nvP; Thu, 08 Oct 2020 17:23:22 -0700
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.web11.2587.1602202999712987805
 for <cip-dev@lists.cip-project.org>;
 Thu, 08 Oct 2020 17:23:21 -0700
X-Received: by mo-csw.securemx.jp (mx-mo-csw1116) id 0990NGvQ022317; Fri, 9 Oct 2020 09:23:16 +0900
X-Iguazu-Qid: 2wHHvXjr2ESb2dWtFJ
X-Iguazu-QSIG: v=2; s=0; t=1602202996; q=2wHHvXjr2ESb2dWtFJ; m=aQIwPP/5mcShaEVp32TWsU57qvvnjlecZY7RXXw0Ar8=
X-Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
	by relay.securemx.jp (mx-mr1113) id 0990NFXB038124;
	Fri, 9 Oct 2020 09:23:15 +0900
X-Received: from enc02.toshiba.co.jp ([61.202.160.51])
	by imx12.toshiba.co.jp  with ESMTP id 0990NFH8017798;
	Fri, 9 Oct 2020 09:23:15 +0900 (JST)
X-Received: from hop101.toshiba.co.jp ([133.199.85.107])
	by enc02.toshiba.co.jp  with ESMTP id 0990NFcN018009;
	Fri, 9 Oct 2020 09:23:15 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VCgJDXuCZYXF5v0SO0BtFIy7g0silDr/y/uJkTXxCEf06rpWtxXxS5LfiB1MMb5wwWAoo/9/CaEfGKKpLucdKFi35+ARgQ0Jir3hcfrdzL0yIwyu52IIyGWlwnxAUKmEwk5Zr/2+XLyttlM5etN+tQa9nzQhaDXc8FcvqUF3mQLSuJ0Pz++D3AcPot5RD6iS/FOjYSUw0lF9aVMdQexNoFL2AHrt8eNFg1i68hOfQdft161cXPrSUb6O83MXrAFmv8CijCb1xSb6p3NNBazK5BxnpZmf+UVoo7qdpoooS3TkUtcb210lVamjyAQjg8zCMfT9JhO9W/BSW43KIQtkEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BfF1vgSPexvBe/tT6peRs1F9Zc5fBhvNRHPT4KBfVPw=;
 b=meoVyAUFZkjUozxCeWB1lSFuPjQ/uBp8RUgk4u/rTIiwvcrnFRC6uH5DbBz7jxYQaId5dXiVcr6d5C+nLwh8SUTyc58bAVdEjYKDs8YI1sBaHXgPd3SoS0Lkv4w3mkSg4sT2lUzkYTTIQUiCECgPqUqsm2xvNw/QeXQxlxICuskM7LRMH31rGbCT7xOIK4gGX6NaVDo9RqoodRsv7PNR5gXqM6Yzpl1MLRD6L129kpAwYpNr4crhkD4cVRMCghY+eFvnvVkMWE2SpSPKZZuBoFlbllx3mwuyiI7hJ/s9h5A6xFFQA1RG9DOrnbAYJcWWZ0Hz0JLSrZJQKgxGXwhU7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: "Nobuhiro Iwamatsu" <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
CC: <jan.kiszka@siemens.com>
Subject: Re: [cip-dev] Backporting of security patches for Intel i40e drivers required?
Thread-Topic: Backporting of security patches for Intel i40e drivers required?
Thread-Index: AdadV2Jnu1CNqzkrSoynC++LmpFHXAAeQTNQ
Date: Fri, 9 Oct 2020 00:23:04 +0000
X-TSB-HOP: ON
Message-ID: <OSBPR01MB298313D24CA5EF5B0517AB4792080@OSBPR01MB2983.jpnprd01.prod.outlook.com>
References: <TY2PR01MB49721EDA34600391409FFB07A00B0@TY2PR01MB4972.jpnprd01.prod.outlook.com>
In-Reply-To: <TY2PR01MB49721EDA34600391409FFB07A00B0@TY2PR01MB4972.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
x-originating-ip: [103.91.184.3]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ffaf9b24-756f-45b4-21e5-08d86be97d23
x-ms-traffictypediagnostic: OS0PR01MB5505:
x-microsoft-antispam-prvs: <OS0PR01MB5505C2DF878425AC3C47813392080@OS0PR01MB5505.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 9NM9QNNGXLipQVI8FKkDoLyZomV1TAqQZockW6GN1KMWGdPGjrte16z2Od7bvrFAo/RRNwykFS7L9PyO/OQoMxy5FF8FB52BVEmSotVpAFxW7ZbQV9MnBlosG3VK94TsPn1kgS4sg4ZgEuoirTdnPvpsUfTpbgkp1YuhYrCCIX0tJtauvIxbdlT3W7in3xISkuhl+QK5LJVJPwATZwPGH54ui8Thu3kKZH3r5l7shxwjoTqpw3tGEh5I105TeieFLL2v7UGhUiIsF0EmTKyPIfj+5HR7qWjD0QIptTKaLSs5FI3cXH1oYWkz2r8l6RGrITr6W5IFMtfwQF9GkmGXrPi7I4d0sYMv2k/bEJIFbGX4Yh3GpRdjZEUtygNTQa079hPbDA0QhNDsEla3HuoTNQ==
x-ms-exchange-antispam-messagedata: iwBxdfAOknEPNcHjIV62HYMm+HuBR7zznjGbYF/UFL9O4enF8jq9bLaaSXxGN+dqIuqkFXHIM7nYK4qvT2Fq6/HeN6Ufp6bwax2gozZIy02IbIAGASGr9va/ndy7XxkA8rZjJT9stMZvtrUkyy+W328m0qnHpvGyqEoD34bPge4Yi9UHxqm4DFTRixrFaYd8GibDrieUdcPDGFiCgxhNVryHl5wo8nXzN+0H+/fdGL4JkR4Q496Jy3MQsasTtE/liuwGxFqOBIs9wHNaZInKBZSP9IY/sKKHw3a17+hJralHqkOG0dufUvRbjlf04IAfRNmUS6WzjZweIO0cqIKac/LdZDJnq1Dy3sR35ZuTUwAPFnjK7Pwt5O/SI6zwVCnNFOe5kf6i2kllppDtEjgWw1A52zcYUUnk8By56xKIZLGI2Pd7BXs9iaOqF4+PeJaYtt2G4ppkFkbxNGjG1Nk40oGQyuMhYrYyOMri2xbBzA+db/Te6A0H6VnRsIHQI9CIjVFOiQYtaKWAg5lE4NiQ9G8UHlRQCNkOyK0kYF33RpJya1cUslOLKkhOOGE/9eXw3pqjmMfG7Jnx5kZKV3TmBXNORNASaK/cqPuyGsNB7FE8cvjx9GQbqOaROxcOUOMSJzs72LWXi402ZaTZozLaRQ==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2983.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffaf9b24-756f-45b4-21e5-08d86be97d23
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2020 00:23:04.2542
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xxSfB1BN9WmTKyNO2e2RqUx8dFy2dB3fxfeaw6gEWD+DNKzjUwfiG1XL0kdA24wRuWHxxAd0Hp7Zqmw8dKRt38caZb2Vx4v+hYlZLuXo6XRprRzjKpDZwzOqNm5jwlSw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB5505
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: uZRi81rpiuav7xsiGmmWhEvTx4520388AA=
Content-Type: multipart/mixed; boundary="wAg0O3FhSkYaUhzgoYci"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1602203002;
 bh=t4x9i3jjCQwKAgi5zVLcJVV+XpL1ybpXAyCRG0ndZCw=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=xHQ9YtVqv//Dslal4H9c6yDW76rUEOXWUO3KYW5f9kiHiMHuKTG4M+glUX+JTSTTUyr
 4wIeLX24oLDzUJGPaLnQ4RJntpnmTVSMYJvRrseFILyuEzNotyvid/tgBjmPQ35ledFq7
 j2cr/H8DISRML30ndbDiAiqxPv5F8QYi3Tw=

--wAg0O3FhSkYaUhzgoYci
Content-Language: ja-JP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGksDQoNCkkgaGF2ZSBzb21lIGNvbW1lbnQgZm9yIHRoaXMgaXNzdWUuDQogIGh0dHBzOi8vbGlz
dHMub3N1b3NsLm9yZy9waXBlcm1haWwvaW50ZWwtd2lyZWQtbGFuL1dlZWstb2YtTW9uLTIwMjAw
ODEwLzAyMTAwNi5odG1sDQogIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3N0YWJsZS8yMDIwMDgw
NzIwNTUxNy4xNzQwMzA3LTEtamVzc2UuYnJhbmRlYnVyZ0BpbnRlbC5jb20vDQoNClRoZXJlIGFy
ZSBtdWx0aXBsZSBwYXRjaGVzIGZpeGVkIGZvciA0LjE5LCB3aGljaCBjYW4gYmUgc2VwYXJhdGVk
IGJ5IGZlYXR1cmUuDQoNCiAtIGk0MGU6IGFkZCBudW1fdmVjdG9ycyBjaGVja2VyIGluIGl3YXJw
IGhhbmRsZXINCg0KICAgICBUaGlzIGlzc3VlIGhhcyBiZWVuIHByb2R1Y2VkIGJ5IGUzMjE5Y2U2
YTc3NTQgKCJpNDBlOiBBZGQgc3VwcG9ydCBmb3IgY2xpZW50IGludGVyZmFjZSBmb3IgSVdBUlAg
ZHJpdmVyIikuDQogICAgIGUzMjE5Y2U2YTc3NTQgaXMgbm90IGluY2x1ZGVkIGluIDQuNC55IGFu
ZCBjYW4gYmUgaWdub3JlZC4NCg0KIC0gaTQwZTogV3JvbmcgdHJ1bmNhdGlvbiBmcm9tIHUxNiB0
byB1OA0KICAgVGhpcyBjYW4gYmUgYXBwbHkgaW4gNC40LnkuDQoNCiAtIGk0MGU6IEZpeCBvZiBt
ZW1vcnkgbGVhayBhbmQgaW50ZWdlciB0cnVuY2F0aW9uIGluIGk0MGVfdmlydGNobmwuYw0KDQog
ICBUaGlzIGlzc3VlIGhhcyBiZWVuIHByb2R1Y2VkIGJ5IGUyODRmYzI4MDQ3M2IgKCJpNDBlOiBB
ZGQgYW5kIGRlbGV0ZSBjbG91ZCBmaWx0ZXIiKS4NCiAgIEl0IGlzIG5vdCBpbmNsdWRlZCBpbiA0
LjQueS4gSG93ZXZlciwgdGhpcyBwYXRjaCBoYXMgc2V2ZXJhbCBkaWZmZXJlbnQgZml4ZXMsIHNv
IHNvbWUgcGF0Y2hlcyBuZWVkIHRvIGJlIGFwcGxpZWQuDQoNCi0tLSBhL2RyaXZlcnMvbmV0L2V0
aGVybmV0L2ludGVsL2k0MGUvaTQwZV92aXJ0Y2hubF9wZi5jDQorKysgYi9kcml2ZXJzL25ldC9l
dGhlcm5ldC9pbnRlbC9pNDBlL2k0MGVfdmlydGNobmxfcGYuYw0KQEAgLTE4MSw3ICsxODEsNyBA
QCBzdGF0aWMgaW5saW5lIGJvb2wgaTQwZV92Y19pc3ZhbGlkX3ZzaV9pZChzdHJ1Y3QNCmk0MGVf
dmYgKnZmLCB1MTYgdnNpX2lkKQ0KICAqIGNoZWNrIGZvciB0aGUgdmFsaWQgcXVldWUgaWQNCiAg
KiovDQogc3RhdGljIGlubGluZSBib29sIGk0MGVfdmNfaXN2YWxpZF9xdWV1ZV9pZChzdHJ1Y3Qg
aTQwZV92ZiAqdmYsIHUxNiB2c2lfaWQsDQotICAgICAgICAgICAgICAgICAgICAgICAgdTggcWlk
KQ0KKyAgICAgICAgICAgICAgICAgICAgICAgIHUxNiBxaWQpDQogew0KICAgICBzdHJ1Y3QgaTQw
ZV9wZiAqcGYgPSB2Zi0+cGY7DQogICAgIHN0cnVjdCBpNDBlX3ZzaSAqdnNpID0gaTQwZV9maW5k
X3ZzaV9mcm9tX2lkKHBmLCB2c2lfaWQpOw0KDQoNCiAtIGk0MGU6IE1lbW9yeSBsZWFrIGluIGk0
MGVfY29uZmlnX2l3YXJwX3F2bGlzdA0KICAgVGhpcyBpc3N1ZSBoYXMgYmVlbiBwcm9kdWNlZCBi
eSBlMzIxOWNlNmE3NzU0ICgiaTQwZTogQWRkIHN1cHBvcnQgZm9yIGNsaWVudCBpbnRlcmZhY2Ug
Zm9yIElXQVJQIGRyaXZlciIpLg0KICAgZTMyMTljZTZhNzc1NCBpcyBub3QgaW5jbHVkZWQgaW4g
NC40LnkgYW5kIGNhbiBiZSBpZ25vcmVkLg0KDQpCZXN0IHJlZ2FyZHMsDQogIE5vYnVoaXJvDQoN
Cj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogY2lwLWRldkBsaXN0cy5jaXAt
cHJvamVjdC5vcmcgW21haWx0bzpjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZ10gT24gQmVo
YWxmIE9mDQo+IG1hc2FzaGkua3Vkb0BjeWJlcnRydXN0LmNvLmpwDQo+IFNlbnQ6IFRodXJzZGF5
LCBPY3RvYmVyIDgsIDIwMjAgNjo0MyBQTQ0KPiBUbzogY2lwLWRldkBsaXN0cy5jaXAtcHJvamVj
dC5vcmcNCj4gQ2M6IGphbi5raXN6a2FAc2llbWVucy5jb20NCj4gU3ViamVjdDogW2NpcC1kZXZd
IEJhY2twb3J0aW5nIG9mIHNlY3VyaXR5IHBhdGNoZXMgZm9yIEludGVsIGk0MGUgZHJpdmVycyBy
ZXF1aXJlZD8NCj4gDQo+IEhpLCBKYW4tc2FuLCBBbGwsDQo+IA0KPiBBdCB0aGUgSVJDIG1lZXRp
bmcgdG9kYXksIHdlIGlkZW50aWZpZWQgdGhlIGZvbGxvd2luZyBuZXcgQ1ZFcyBhcmUgbm90IGlu
IExUUzQuNCB5ZXQuDQo+IA0KPiAtIENWRS0yMDE5LTAxNDUsIENWRS0yMDE5LTAxNDcsIENWRS0y
MDE5LTAxNDggW25ldC9pNDBlXSAtIEZpeGVkIGZvciBtYWlubGluZSBhbmQgNC4xOSsNCj4gDQo+
IFRoZXNlIGFyZSBmb3IgaTQwZSBkcml2ZXIgZm9yIEludGVsLg0KPiANCj4gVGhlIGtlcm5lbCB0
ZWFtIHdvdWxkIGxpa2UgdG8ga25vdyB3aGV0aGVyIHRoZWlyIGJhY2twb3J0aW5nIGlzIG5lZWRl
ZCBvciBub3QuDQo+IA0KPiBGb3IgZGV0YWlscyBvZiB0aG9zZSBDVkUgY2hlY2tpbmcgcmVzdWx0
cywgcGxlYXNlIHNlZSB0aGUgZm9sbG93aW5nLg0KPiBodHRwczovL2dpdGxhYi5jb20vY2lwLXBy
b2plY3QvY2lwLWtlcm5lbC9jaXAta2VybmVsLXNlYy8tL21lcmdlX3JlcXVlc3RzLzc1L2RpZmZz
DQo+IA0KPiBSZWdhcmRpbmcgdGhlIGRpc2N1c3Npb24gb2YgdGhlIElSQyBtZWV0aW5nLCBwbGVh
c2Ugc2VlIHRoZSBmb2xsb3dpbmcuDQo+IGh0dHBzOi8vaXJjbG9ncy5iYXNlcm9jay5vcmcvbWVl
dGluZ3MvY2lwLzIwMjAvMTAvY2lwLjIwMjAtMTAtMDgtMDkuMDAubG9nLmh0bWwNCj4gDQo+IEJl
c3QgcmVnYXJkcywNCj4gLS0NCj4gTS4gS3Vkbw0K

--wAg0O3FhSkYaUhzgoYci
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5515): https://lists.cip-project.org/g/cip-dev/message=
/5515
Mute This Topic: https://lists.cip-project.org/mt/77380165/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--wAg0O3FhSkYaUhzgoYci--
