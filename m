Return-Path: <SRS0=P3Fm=BF=lists.cip-project.org=bounce+64572+5014+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D6C4C433DF
	for <cip-dev@archiver.kernel.org>; Sun, 26 Jul 2020 11:01:35 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78A772070A
	for <cip-dev@archiver.kernel.org>; Sun, 26 Jul 2020 11:01:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="hf36f4GF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78A772070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5014+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 4gw3YY4521723xPbyt6RUvFM; Sun, 26 Jul 2020 04:01:34 -0700
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.156])
 by mx.groups.io with SMTP id smtpd.web10.26768.1595761290788790361
 for <cip-dev@lists.cip-project.org>;
 Sun, 26 Jul 2020 04:01:32 -0700
X-Received: by mo-csw.securemx.jp (mx-mo-csw1114) id 06QB1SHf026588; Sun, 26 Jul 2020 20:01:28 +0900
X-Iguazu-Qid: 2wHHK1VZs2G0YeJ9Xt
X-Iguazu-QSIG: v=2; s=0; t=1595761288; q=2wHHK1VZs2G0YeJ9Xt; m=YAFtNKrSrGkMImawF5k58W4nnpoQca2lTfJSmS/L/78=
X-Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
	by relay.securemx.jp (mx-mr1112) id 06QB1Rli015032;
	Sun, 26 Jul 2020 20:01:27 +0900
X-Received: from enc02.toshiba.co.jp ([61.202.160.51])
	by imx12.toshiba.co.jp  with ESMTP id 06QB1Q9C016102
	for <cip-dev@lists.cip-project.org>; Sun, 26 Jul 2020 20:01:27 +0900 (JST)
X-Received: from hop101.toshiba.co.jp ([133.199.85.107])
	by enc02.toshiba.co.jp  with ESMTP id 06QB1Q1n009037
	for <cip-dev@lists.cip-project.org>; Sun, 26 Jul 2020 20:01:26 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KJqA/MeGPXHvJ0/WfCnZORS1jJHmqZTheb565AtjDnehyqGyWg8H+fUUUnQQ7TDvzJVERiUIx1EcOc/yxIk+lf58DruA9oUOECBl3tqAOrA/cPrBHkFojE1ZhCj51bANsrMuCn/eMT3gjA4sRWtk5ms98cBExhTR84bbsgJt6DRGLoTQnZZeHXCVOy6MFeOMI9AblefSAv1pCZLAmiBnyKsNYTNSDOarR2F+bfICSnAeTWG02YB2JYaLBktseAGZwpZkEQyhSrkIjBScfcTZ5NToHaTvSAtyGOsdGXahPuyttvZnj/eoWqy4g09sh7er2NC4dc0YjrFCDE/fLzgdcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jpOwPvFjfrzjN5M5VMru7CuSHwitSXOxnLo26fYyUws=;
 b=FkvlrBdPObzZTCQDw9Ey5aPoCxxpVm7fCx2yqCxBi0PgEhekFPu8lMra6XbBTJ/xvm1X7sNJQaA2fKkZ9zgr2VMZbb85VQzpT00LzxCublCPIo8pT8mragvXtya1fFKSwesCGsFH9NO/i7F3gzH6jlRbhshnJOBZfTIi2EDMhzlE3W5qpt99LFuorR+LYlzreZtVKx4XVEXUj5uqd8EUVmUoVO2D98m6FyFmjOLmD9HqxIWx/t4Q4RUPdP94lgKJS8KvuL6O5nENB9A8O7gccFbiz3k24XyTu3h93ktcVa8jIAEmNu+RGqjnlH4pWDwvXcNZe5yACQhGwCprp0LrYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: "Nobuhiro Iwamatsu" <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
Subject: [cip-dev] [ANNOUNCE] Release v4.19.134-cip31
Thread-Topic: [ANNOUNCE] Release v4.19.134-cip31
Thread-Index: AdZjPBFE/rCqLHxbT665hOuJpXybvg==
Date: Sun, 26 Jul 2020 11:01:24 +0000
X-TSB-HOP: ON
Message-ID: <OSBPR01MB2983228DD6C2A0B96510137392750@OSBPR01MB2983.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
x-originating-ip: [103.91.184.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d92ee9ee-fce8-4b1f-5dfe-08d831533cbc
x-ms-traffictypediagnostic: OSBPR01MB2982:
x-microsoft-antispam-prvs: <OSBPR01MB29828FD8840DCB64A831354492750@OSBPR01MB2982.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:494;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: tGwbBAnEO3UAijbP8ieSt5lPVeJm8fy6amVwvhV1K8NckfYF4zecyhE7RFxHv4ZNUqNstYo325cFLoo3FmzRn1hiuZoJnxVOQKDubka/uGtwSxcCKEa+zEoS6E4WBDZb5d8NLl9jtUnWqQupJfJsfZctnCKqol+Wgl2iAl8MRileazpiOvunsZwjIeRHUqFtie0SbCSkhgVJ2xbfS7ICWJLcJuHl2D7lGwvFdy+sBbLOAOOAJzcq5epW9ofymBKJno+xpl2f1Zp3XCY7zGCFy61Xx47grBWGzgMYZsC6fXbYfdtUQhuPcBWhaCYzCF2eh+J44d5upunsxrdjKOV3OFPvpIVWB3UZdRlmLcauTEmbC+dz22tgj0aZrMCXHWfJ9KgitcNUz0b2wvrj1oC9YQ==
x-ms-exchange-antispam-messagedata: PG+on99TWrH5mViVHWgdEwrJCQ6wB9QjqmxpGOip9DEAzpW6FlSChP+qJKTdYNYx0NM6U+spjtqRJfv/1a2iGChCESv+YTduLi3cc5yKpM136/vi8+AYHvB2vNdkdzEKNmaZGP3Mw6UhFDJ5WMPJBTm4fXovUUu6SHkOqMT5gQ47ibIgm2AQ2D3F3cSoyn5SaCShbbjI/xoThPo2NO81zMGGQtswlCvZMafk5ZWdiax3Pj6wCnKWeVNrfrqnY5IpA77CVcaAAF6Wzn/4b0QAEMAOA8N/3VtQLVT0Sx8FWkdpRRyyt4kAWqKBdgYtteeHB9Oywd1dAkjm9G7T2yb+k4IzKT+BzhL3LHeY2zZWPuFO4zHSUVAqkVTcVC0tDbDvbV43131gmBAHSgsH8Mi8LHKqK5Dfvii3nFQA7imkxTxXpZeFjvhlfRbeXM0xBIlvaSTqPb3fWiP/XQ9mxL8unBHyy5ljyfMkMCSYdbD2ZUE=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2983.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d92ee9ee-fce8-4b1f-5dfe-08d831533cbc
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2020 11:01:24.2870
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tmzk6utagQ4l1jbAS85A4l5tCEUfctuQIOS22C7l3YZLM5LhuRupXljrGz/+vZlyTjYvUtWejG1kbaxyLBj/J3KA3Jrxd+uz6uu0DZ9f/7kgAo06/O+QVnKTOBW3rBj8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB2982
MSSCP.TransferMailToMossAgent: 103
X-OriginatorOrg: toshiba.co.jp
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: GawNoW8cyzULIfRmiEs2zBDzx4520388AA=
Content-Type: multipart/mixed; boundary="RZAKezelEHWrtuixmtJw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1595761294;
 bh=4SYCp6VdvyNSn/mR+k7VEOghGi62VxKL/0kteR62ZU4=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=hf36f4GFow85bsyEUQcCIDtIWyYDbLnZnomiZ0tNwsAjvjL/IgeRUqlyr2rJwFy93Sz
 CZHdN3ILiT6utyf+jgTt/wmf7tmGhNZ742NTVOHni4miTk53xgxZ7DYucCvBipvVanOBI
 PY0WCrTTq57g8qhmW/1Fg6paIMNB8HcclTM=

--RZAKezelEHWrtuixmtJw
Content-Language: ja-JP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGksDQoNCkNJUCBrZXJuZWwgdGVhbSBoYXMgcmVsZWFzZWQgTGludXgga2VybmVsIHY0LjE5LjEz
NC1jaXAzMS4NClRoZSBsaW51eC00LjE5LnktY2lwIHRyZWUgaGFzIGJlZW4gdXBkYXRlZCBiYXNl
IHZlcnNpb24gZnJvbSB2NC4xOS4xMzINCnRvIHY0LjE5LjEzNCwNCkluIGFkZGl0aW9uLCB0aGUg
cmNhci1kdSBhbmQgZGlzcGxheSBmZWF0dXJlcyBoYXZlIGJlZW4gYmFja3BvcnRlZCBmb3INCnRo
ZSBSWi9HMi4NCg0KWW91IGNhbiBnZXQgdGhpcyByZWxlYXNlIHZpYSB0aGUgZ2l0IHRyZWUgYXQ6
DQoNCiAgdjQuMTkuMTM0LWNpcDMxOg0KICAgIHJlcG9zaXRvcnk6DQogICAgICBodHRwczovL2dp
dC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9jaXAvbGludXgtY2lwLmdpdA0K
ICAgIGJyYW5jaDoNCiAgICAgIGxpbnV4LTQuMTkueS1jaXANCiAgICBjb21taXQgaGFzaDoNCiAg
ICAgIGVkNWY5NzY1MTg2Y2MzNDJjZmMyNTBlNmIxMDFjZWE5NWE5MjE2NjYNCiAgICBhZGRlZCBj
b21taXRzOg0KICAgICAgQ0lQOiBCdW1wIHZlcnNpb24gc3VmZml4IHRvIC1jaXAzMSBhZnRlciBt
ZXJnZSBmcm9tIHN0YWJsZQ0KICAgICAgYXJtNjQ6IGR0czogcmVuZXNhczogQWRkIEVLODc0IGJv
YXJkIHdpdGggaWRrLTIxMjF3ciBkaXNwbGF5IHN1cHBvcnQNCiAgICAgIGR0LWJpbmRpbmdzOiBk
aXNwbGF5OiBBZGQgaWRrLTIxMjF3ciBiaW5kaW5nDQogICAgICBhcm02NDogZHRzOiByZW5lc2Fz
OiByemcyOiBBZGQgcmVzZXQgY29udHJvbCBwcm9wZXJ0aWVzIGZvciBkaXNwbGF5DQogICAgICBh
cm02NDogZHRzOiByZW5lc2FzOiByOGE3NzRjMDogUG9pbnQgTFZEUzAgdG8gaXRzIGNvbXBhbmlv
biBMVkRTMQ0KICAgICAgZHJtOiByY2FyLWR1OiBsdmRzOiBBbGxvdyBmb3IgZXZlbiBhbmQgb2Rk
IHBpeGVscyBzd2FwDQogICAgICBkcm06IHJjYXItZHU6IGx2ZHM6IEdldCBkdWFsIGxpbmsgY29u
ZmlndXJhdGlvbiBmcm9tIERUDQogICAgICBkcm06IG9mOiBBZGQgZHJtX29mX2x2ZHNfZ2V0X2R1
YWxfbGlua19waXhlbF9vcmRlcg0KICAgICAgZHJtOiByY2FyLWR1OiBsdmRzOiBJbXByb3ZlIGlk
ZW50aWZpY2F0aW9uIG9mIHBhbmVscw0KICAgICAgZHJtOiByY2FyLWR1OiBsdmRzOiBHZXQgbW9k
ZSBmcm9tIHN0YXRlDQogICAgICBkcm06IEFkZCBhdG9taWMgdmFyaWFudHMgZm9yIGJyaWRnZSBl
bmFibGUvZGlzYWJsZQ0KICAgICAgZHJtOiBBZGQgZHJtX2F0b21pY19nZXRfKG9sZHxuZXcpX2Nv
bm5lY3Rvcl9mb3JfZW5jb2RlcigpIGhlbHBlcnMNCiAgICAgIGRybTogcmNhcl9sdmRzOiBGaXgg
ZHVhbCBsaW5rIG1vZGUgb3BlcmF0aW9ucw0KICAgICAgZHJtOiByY2FyLWR1OiBTa2lwIExWRFMx
IG91dHB1dCBvbiBHZW4zIHdoZW4gdXNpbmcgZHVhbC1saW5rIExWRFMgbW9kZQ0KICAgICAgZHJt
OiByY2FyLWR1OiBsdmRzOiBBZGQgc3VwcG9ydCBmb3IgZHVhbC1saW5rIG1vZGUNCiAgICAgIGR0
LWJpbmRpbmdzOiBkaXNwbGF5OiByZW5lc2FzOiBsdmRzOiBBZGQgcmVuZXNhcyxjb21wYW5pb24g
cHJvcGVydHkNCiAgICAgIGRybTogYnJpZGdlOiBBZGQgZHVhbF9saW5rIGZpZWxkIHRvIHRoZSBk
cm1fYnJpZGdlX3RpbWluZ3Mgc3RydWN0dXJlDQogICAgICBkcm06IHJjYXItZHU6IGx2ZHM6IFJl
bW92ZSBMVkRTIGRvdWJsZS1lbmFibGUgY2hlY2tzDQogICAgICBhcm02NDogZGVmY29uZmlnOiBF
bmFibGUgYWRkaXRpb25hbCBzdXBwb3J0IGZvciBSZW5lc2FzIHBsYXRmb3Jtcw0KICAgICAgQVNv
QzogcnNuZDogZml4dXAgU1NJIGNsb2NrIGR1cmluZyBzdXNwZW5kL3Jlc3VtZSBtb2Rlcw0KDQpC
ZXN0IHJlZ2FyZHMsDQogICBOb2J1aGlybw0KDQo=

--RZAKezelEHWrtuixmtJw
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5014): https://lists.cip-project.org/g/cip-dev/message=
/5014
Mute This Topic: https://lists.cip-project.org/mt/75800389/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--RZAKezelEHWrtuixmtJw--
