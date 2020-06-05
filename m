Return-Path: <SRS0=Arhd=7S=lists.cip-project.org=bounce+64572+4721+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD88AC433E0
	for <cip-dev@archiver.kernel.org>; Fri,  5 Jun 2020 09:35:44 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4235A207D0
	for <cip-dev@archiver.kernel.org>; Fri,  5 Jun 2020 09:35:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="bR8nqOTR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4235A207D0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=moxa.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4721+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 5B5EYY4521723xulUywktatD; Fri, 05 Jun 2020 02:35:43 -0700
X-Received: from APC01-PU1-obe.outbound.protection.outlook.com (APC01-PU1-obe.outbound.protection.outlook.com [40.107.132.83])
 by mx.groups.io with SMTP id smtpd.web10.7257.1591349742430264239
 for <cip-dev@lists.cip-project.org>;
 Fri, 05 Jun 2020 02:35:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rfeb9i/kwLPRrx7/TcxKs/ly6/UNMBh+RXv+1UMVJs8kJbXjtagXsTUL8ts2+Z2K1pI0IhpBJRYEgxhDcl0NZleriTp23p8UCB0dVfDtGaLNhu1RglZhsB4rVqSQq3gO8rea4qJsqX9kC6wyrTf0sKrZkQvuq6Iab8ZZ6tIgniffVwr3S7aSnrWhpx4tttnoQecksRZdQyiJJ1kxLicG1NfCNC4oWYYqghtrGnigP6/y+QI/tsuvDmxklJZepilx3jZDkV2yBdx1mYw11kNt9D8lrySmbERmQYcqYSqfOyUur+R/EERz2E3FgZKRgQcJy+S26Lf8Q0gMTuMBS9PyqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1MpKFPqXGw1sSl0oItPwdJUSEPljl0wl1xa0EUQajxg=;
 b=LVKspkFcv/mhxZAKh0hLhPYIkP6TFsaB1L84KqgZab4MSZofzpq5XuVj1a4OZIrH3iGtuisJ+HdGbh1sPlNiYdMWlSecGtKBGczyVmG+sM2flW4OdOhTydUSYHBAxXkv8g0DGtmpL8GOVFTvPYb6eb2Ajci4kGGPxhpYIicD3zNXeDWpoXW2tc2gAv2G33P/ptNqSHgWXe4iL7nx8m2Ujk43A7PY0u974yhT/xHgijtEjanHgjsfIkbTAPuAXIuPFUSHwmlWJZwOebarW1IiO7hc5a5bjWJP8R/BZNq3jdoMzT49tAG5LyyUaxk3G4i+v7VI7Hm52xY25/EHXlTnzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=moxa.com; dmarc=pass action=none header.from=moxa.com;
 dkim=pass header.d=moxa.com; arc=none
X-Received: from HK2PR01MB3281.apcprd01.prod.exchangelabs.com
 (2603:1096:202:22::12) by HK2PR01MB3140.apcprd01.prod.exchangelabs.com
 (2603:1096:202:18::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Fri, 5 Jun
 2020 09:35:39 +0000
X-Received: from HK2PR01MB3281.apcprd01.prod.exchangelabs.com
 ([fe80::712b:170d:f873:68a3]) by HK2PR01MB3281.apcprd01.prod.exchangelabs.com
 ([fe80::712b:170d:f873:68a3%6]) with mapi id 15.20.3066.018; Fri, 5 Jun 2020
 09:35:39 +0000
From: "johnsonch.chen@moxa.com" <JohnsonCH.Chen@moxa.com>
To: "nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>,
	"pavel@denx.de" <pavel@denx.de>, "cip-dev@lists.cip-project.org"
	<cip-dev@lists.cip-project.org>
Subject: [cip-dev][PATCH 4.4.y-cip 0/2] Add dts for Moxa UC-8100-ME-T platform
Thread-Topic: [cip-dev][PATCH 4.4.y-cip 0/2] Add dts for Moxa UC-8100-ME-T
 platform
Thread-Index: AdY7G2A7nn/CzWtOQAm/F+wBzLjLgQ==
Date: Fri, 5 Jun 2020 09:35:38 +0000
Message-ID: 
 <HK2PR01MB32816DED0D73E7481744817CFA860@HK2PR01MB3281.apcprd01.prod.exchangelabs.com>
Accept-Language: zh-TW, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [123.51.145.16]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3eb1bd5a-6560-43f6-1896-08d80933cee0
x-ms-traffictypediagnostic: HK2PR01MB3140:
x-microsoft-antispam-prvs: 
 <HK2PR01MB3140A64A07C57945D6CAA2FDFA860@HK2PR01MB3140.apcprd01.prod.exchangelabs.com>
x-ms-oob-tlc-oobclassifiers: OLM:3173;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 5Ems5qASWsFbjYUKyJ9cu1q4EjpYlp9ZxhWXKkABmsWEAQwjqwt4WgAAPs9ivYcapw4j3p/nunKe4MHqne9o19QOPQULidICXklkWSgRsqTEJUj0nmQj1Lc6sUghVgKUbWk6DNA2gagqME1nnroeesddZEETZSUYNnInGe8JTixY2rC3YyXpDvCwsy2eKNTDRApO5+nHiFLe/OIaPpzvpZU1gEzGgwxMdudFZ8Lmr2z88qDRwhSSnPK4N4KkzXqkBkHhEOFMvf0mLEzL2Xj6r85Z6R95vscDAa+sNDlcRtOV5gbih558/VcAK9+EnvF26yNfuhPHRVplEkKmHr9C2w==
x-ms-exchange-antispam-messagedata: 
 azAVRXUIQoGjiDyCXJzA++b5M1qgKf7c5Ea9UZWPbjFf24MqEa8m5tebjbjJtBCFqMfEAP8QItF+JOtqy9rPbJXbaUxGzBsbF4xGj6hDcaVG1TO3PwpATG9gOawPsfkpmxbLbFZ+weyQahrglHFWo8mPKGM7AdVR3aoRdKHslMj1ZQZi4Bc7MJiBOPf3di47ey0G523zBPxHVBAVKxjEG1MH9Vu4CWpP5tR/p3NI8Wd+617i/rdxxVyq3aZTFagCrtVtA5S+C/tufKeuPe03nB8XXY7JpyudvmOtqbJlSxSQHul2fl0htASufxsIzyhTeTs8ezeAOLtnwN9KmhtT7FS7TZyWSx+00foVTFYE0eQRoYYvPVRog9xMseO5qoPIJwFb6LBkMutHKsJ8WjXsnyBg0XjAWoofb2Sw90rnmoGs1zdqD8WE58vP9vbBMFE8TSi5yTK382XYk7jKR4vdJIEITwBz7nXs5SqMOwfWzvM=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: moxa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3eb1bd5a-6560-43f6-1896-08d80933cee0
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2020 09:35:38.9841
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5571c7d4-286b-47f6-9dd5-0aa688773c8e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5TfZd93m4ZV/VCfkENz5zN/+dJgyL8+4UNwDoX5XpOnswAVkO4hWjkA1OILVe/KcvuYkHEOvaG7qUOt5lzCE/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK2PR01MB3140
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: Rd5lxolWp24AtZThMHDGvvT1x4520388AA=
Content-Type: multipart/mixed; boundary="R4oQwqnBw6nOCOOLw7vn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1591349743;
 bh=tjfBAUkN2lZi3pJ++pZgyrSwszOFHT5MAn8aXGQUxAw=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=bR8nqOTRqABc0X1/l+qDZcScuS/7hDuSaeQ641gY20jOIjoY5zb7dveCaPqkai2mnzm
 JTEBrTB2p87iUfTnEEngI8Y6pDxlazs6NvKphfbj/Cvs/shENdoPXiQtAsQt93NGL9zU6
 IcCz6FejtpoMJzccjj4e7mCA2CqKlgm/5ts=

--R4oQwqnBw6nOCOOLw7vn
Content-Language: zh-TW
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGVsbG8gYWxsLA0KDQpNT1hBIFVDLTgxMDAtTUUtVCBpcyBidWlsdCBhcm91bmQgYSBDb3J0ZXgt
QTggcHJvY2Vzc29yIGZvciBUSSBBTTMzNXgsIA0KYW5kIGl0J3MgZGVzaWduZWQgZm9yIGVtYmVk
ZGVkIGRhdGEgYWNxdWlzaXRpb24gYXBwbGljYXRpb24uIEhlcmUgd2UgYWRkDQp0aGUgZGV2aWNl
IHRyZWUgYW0zMzV4LW1veGEtdWMtODEwMC1tZS10LmR0cy4gQmVzaWRlcywgYWxzbyBhZGQgbmV3
IERUIA0KYmluZGluZyBmb3IgdGhlIGVETUEzIGJlY2F1c2UgZnVuY3Rpb24gb2YgZWRtYSBjcm9z
c2JhciBpcyB1c2VkIGluIA0KVUMtODEwMC1NRS1ULCBhbmQgbWVtb3J5IGlzIHNhZmUgZm9yIHdp
dGggdGhlIG5ldyBiaW5kaW5nLg0KDQoxLiBVc2UgdGhlIG5ldyBiaW5kaW5nIGZvciBlRE1BMyBv
ZiBhbTMzeHguDQoyLiBBZGQgZHRzIGZvciBNT1hBIFVDLTgxMDAtTUUtVCAgDQoNCkl0J3MgdGVz
dGVkIHdpdGggYSBNT1hBIFVDLTgxMDAtTUUtVCBwbGF0Zm9ybS4NCg0KdGhhbmtzIQ0KSm9obnNv
bg0KDQpQZXRlciBVamZhbHVzaSAoMSk6DQogIEFSTTogRFRTOiBhbTMzeHg6IFVzZSB0aGUgbmV3
IERUIGJpbmRpbmdzIGZvciB0aGUgZURNQTMNCg0KU1ogTGluICgxKToNCiAgQVJNOiBkdHM6IGFt
MzM1eDogYWRkIHN1cHBvcnQgZm9yIE1veGEgVUMtODEwMC1NRS1UIG9wZW4gcGxhdGZvcm0NCg0K
IC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9vbWFwL29tYXAudHh0ICAgICAgICAgIHwgICAz
ICsNCiAuLi4vZGV2aWNldHJlZS9iaW5kaW5ncy92ZW5kb3ItcHJlZml4ZXMudHh0ICAgICAgICB8
ICAgMSArDQogYXJjaC9hcm0vYm9vdC9kdHMvTWFrZWZpbGUgICAgICAgICAgICAgICAgICAgICAg
ICAgfCAgIDEgKw0KIGFyY2gvYXJtL2Jvb3QvZHRzL2FtMzM1eC1ldm0uZHRzICAgICAgICAgICAg
ICAgICAgIHwgICA5ICstDQogYXJjaC9hcm0vYm9vdC9kdHMvYW0zMzV4LW1veGEtdWMtODEwMC1t
ZS10LmR0cyAgICAgfCA1MjUgKysrKysrKysrKysrKysrKysrKysrDQogYXJjaC9hcm0vYm9vdC9k
dHMvYW0zMzV4LXBlcHBlci5kdHMgICAgICAgICAgICAgICAgfCAgMTEgKy0NCiBhcmNoL2FybS9i
b290L2R0cy9hbTMzeHguZHRzaSAgICAgICAgICAgICAgICAgICAgICB8ICA5NCArKy0tDQogNyBm
aWxlcyBjaGFuZ2VkLCA2MDEgaW5zZXJ0aW9ucygrKSwgNDMgZGVsZXRpb25zKC0pDQogY3JlYXRl
IG1vZGUgMTAwNjQ0IGFyY2gvYXJtL2Jvb3QvZHRzL2FtMzM1eC1tb3hhLXVjLTgxMDAtbWUtdC5k
dHMNCg0KLS0gDQoyLjExLjANCg==

--R4oQwqnBw6nOCOOLw7vn
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4721): https://lists.cip-project.org/g/cip-dev/message=
/4721
Mute This Topic: https://lists.cip-project.org/mt/74689396/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--R4oQwqnBw6nOCOOLw7vn--
