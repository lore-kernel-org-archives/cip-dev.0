Return-Path: <SRS0=uEs2=7P=lists.cip-project.org=bounce+64572+4659+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02CABC433DF
	for <cip-dev@archiver.kernel.org>; Tue,  2 Jun 2020 05:23:45 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FBDC206A2
	for <cip-dev@archiver.kernel.org>; Tue,  2 Jun 2020 05:23:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="I34f3wo4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FBDC206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4659+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id xkQtYY4521723xYbMEmirpqi; Mon, 01 Jun 2020 22:23:41 -0700
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.157])
 by mx.groups.io with SMTP id smtpd.web12.4220.1591075418463770568
 for <cip-dev@lists.cip-project.org>;
 Mon, 01 Jun 2020 22:23:40 -0700
X-Received: by mo-csw.securemx.jp (mx-mo-csw1115) id 0525NasB022073; Tue, 2 Jun 2020 14:23:36 +0900
X-Iguazu-Qid: 2wHHWzHtPkrFmVw6pp
X-Iguazu-QSIG: v=2; s=0; t=1591075415; q=2wHHWzHtPkrFmVw6pp; m=tI8dOG9mcpj/bn9z4VXi0q4COsQMxKN9NS0sB8FvH2k=
X-Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
	by relay.securemx.jp (mx-mr1111) id 0525NYj8009316;
	Tue, 2 Jun 2020 14:23:35 +0900
X-Received: from enc02.toshiba.co.jp ([61.202.160.51])
	by imx12.toshiba.co.jp  with ESMTP id 0525NYbF027263;
	Tue, 2 Jun 2020 14:23:34 +0900 (JST)
X-Received: from hop101.toshiba.co.jp ([133.199.85.107])
	by enc02.toshiba.co.jp  with ESMTP id 0525NYIa018416;
	Tue, 2 Jun 2020 14:23:34 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KQMrwXZ7vMMRZ8h741P3L2UU4FYXt2oM0ASiOg1mZ3ovRxAceM90TPNkZmajAcReSAUVeawl8PQeXF2NeKRnnPPkdOfCbFZjTAmeYsUw6DleypXeUGPDWlDXGPJD2VbML2u1iXRtM+JTcu9TT/T8BVucj1pWehWDLfpy0uLAilzxialwUqwH34MvdHo5UHGuDAsG4mLwFeYylmif+YFYBmXZZF1lhI0SgTi83zNp6eWcUyPAkoZ3/NKReWZHpbJICGcaVPy12c+BIW/r9v3fFFWkUe4g2PVrpX7homkO2560KViHWLqQUEb6d9uMNmPvuwTD4CXXa2iAjdJWgIoCSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zc67IL4/rZdkjMacyRcurYNT7Ovp4Lw9gzDZONO5vhY=;
 b=PMgqKJDIxu8ekKH+U4eyDUSwoYviKp+LvFVFLFwRkl4ZQE8pQWexkPIeg+2qyGwNgmUF8keWXICLFG4mMDONEW7Dy+hxcP/3LRfX05TtQ3uCdJwHbcW2/ZvYHPRUlh7pXYLlGOHP8+J/jrf4ACvI5sblaK33aEXd6XtDKfIjBW4WXKCXht32azFP0vBrU+7NB9nB+uKRX0lI2DlmozWt6VQIwjM2Scg5i2UZx404i5UZdvRUzDq4tmyOCvIv8lDOzFmwHzgEiqbrQ7tw4YGYpaNMLpdMinA8MV5Ax9t/Kf7RnwpslFTtqWlY8iuV3L1o35kqertgvOMt5wpdZQUd9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: "Nobuhiro Iwamatsu" <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
CC: <SZ.Lin@moxa.com>
Subject: Re: [cip-dev] Kernel config warning
Thread-Topic: [cip-dev] Kernel config warning
Thread-Index: AdY4YgxrtHSDBaMZSpup0T/oNPPVRAANwYUwAADQSgA=
Date: Tue, 2 Jun 2020 05:23:32 +0000
X-TSB-HOP: ON
Message-ID: <OSBPR01MB29835BC2A60802C0BD3958D0928B0@OSBPR01MB2983.jpnprd01.prod.outlook.com>
References: <OSAPR01MB2385ECC888BFA203140CA3CEB78A0@OSAPR01MB2385.jpnprd01.prod.outlook.com>
 <1614A0DCA25C7189.14405@lists.cip-project.org>
In-Reply-To: <1614A0DCA25C7189.14405@lists.cip-project.org>
Accept-Language: ja-JP, en-US
x-originating-ip: [103.91.184.7]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e9258bf7-420b-498e-d5b9-08d806b51760
x-ms-traffictypediagnostic: OSBPR01MB3112:
x-microsoft-antispam-prvs: <OSBPR01MB31127B82A0FEE1B130EF81AC928B0@OSBPR01MB3112.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:114;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 8CeTH5QZyWNU38YpmgVX+xCeZM4rk9xEhlYqfegP6353RbyDcBJHWAjdJm8Fpj65bKlQ4nXpZC0KSgwtmGWV9+nXr+OazYdrKt2R5XTkeWlnE1Jd0daq03CcgQkuA1yT76fsNcSOwJG3r0HHaJyIODZem/hHULTaHlMH1S28Rbe5ezujChRt8n0tCosqrZoVl7MBtLpuXRD9Ncrk4H0uNOp4EKoBZeiAUcvnA1VIVQOz1py5H3FNiu9Ct3m5k1D7bwRbTz960NnhMubX262QN9N27/gQdW6tJkSW/lo9+u0vI8s529pBhW1U6X9MdGBzV0PU/E91y/h6oabgrraD9BcUswidrdWDUpZ0XLhQGpC78ejhSdDqmWdQSbybHmnLP+YF61hrX4JNWnZa7mYhUQ==
x-ms-exchange-antispam-messagedata: bouK+rOtE2zi807xIKYQEEwoEP836nPKYP3T92TLxs1VJAN7ffBpNLXJ73gpXrjO0uUkgr+kUEvZpa3PNuT/ksn3Iox8nWZa94srO6XY6XK35FHk3tDG1lUcegt9S/3+NfKei14GvPuDt/uBjKzBDQknjoY7hoQTaIsnWUCFLH+q61EnhkHD5hANvvXExGEsh7vGwQCqLsEsQcb7/39s0IRP3LzQd+oVYLNauzuSvRK3/5uC1brAlDEUb23CrIhUF0Jhn7yVpW22R9pFp6gBB7gnhQDAOaz07McJRyo+j0sHEkudeEk2VcOzqKnkl5uNA8vmwVqan3gdSbQq/Mq+BlMQxbldEiSjMuqZz7q1pftXwBdS4bvsm/gv0Czoy9xUXMe0Ey66asZ25HQozk6fjJOL4M89jBrf1gkVWgI70l7QE8TV8/i8wmWtpd3A6cTEgXxBrOsWUDuRtxc6YXBtOpqUolSYU27owuoQPLNHk94=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: e9258bf7-420b-498e-d5b9-08d806b51760
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2020 05:23:32.2775
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0v0o3ENMZR1w6SDH/Lvzi2LMAkShMggxCDR0mIZl4mraMIM2F7qPyrA+rYBPt9rAXNDvSHXPI8/oHuyZS7fxhDujZdD0CWE/xfY3YEL6UafPEt81gqhS2pZUwKGonxjT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB3112
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: TeB7zgn0foQqYQQcKadCPNLfx4520388AA=
Content-Type: multipart/mixed; boundary="lJQVZKgeOrbcscNQm6xZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1591075421;
 bh=KqtJlSPpxoqQPCAdNREnh/gw2S9+n7+yWtwFrENVDwA=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=I34f3wo4GJhT1NpRXKAC3OXfLUQu4MZJBqrYgDQs47tOIo4kwCSV7B49aT9TT1FDP0g
 QfwQbrhhg1wsv/EyVi4noXIoFGzd1nnyIBJD4wn2ii/xOUf14mqi+koe6re/InjHrONhl
 Yy8DiyK/vFXCNDxX6VVpg+C050HLYS3i3UY=

--lJQVZKgeOrbcscNQm6xZ
Content-Language: ja-JP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGksDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogY2lwLWRldkBsaXN0
cy5jaXAtcHJvamVjdC5vcmcgW21haWx0bzpjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZ10g
T24gQmVoYWxmIE9mIE5vYnVoaXJvIEl3YW1hdHN1DQo+IFNlbnQ6IFR1ZXNkYXksIEp1bmUgMiwg
MjAyMCAxOjUwIFBNDQo+IFRvOiBjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZw0KPiBDYzog
U1ouTGluQG1veGEuY29tDQo+IFN1YmplY3Q6IFJlOiBbY2lwLWRldl0gS2VybmVsIGNvbmZpZyB3
YXJuaW5nDQo+IA0KPiBIaSwNCj4gDQo+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4g
PiBGcm9tOiBjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZyBbbWFpbHRvOmNpcC1kZXZAbGlz
dHMuY2lwLXByb2plY3Qub3JnXSBPbiBCZWhhbGYgT2YgQ2hyaXMgUGF0ZXJzb24NCj4gPiBTZW50
OiBUdWVzZGF5LCBKdW5lIDIsIDIwMjAgNzoxOCBBTQ0KPiA+IFRvOiBjaXAtZGV2QGxpc3RzLmNp
cC1wcm9qZWN0Lm9yZw0KPiA+IENjOiBTWi5MaW5AbW94YS5jb20NCj4gPiBTdWJqZWN0OiBbY2lw
LWRldl0gS2VybmVsIGNvbmZpZyB3YXJuaW5nDQo+ID4NCj4gPiBIZWxsbyBLZXJuZWwgbWFpbnRh
aW5lcnMsDQo+ID4NCj4gPiBJIHNhdyB0aGlzIHdhcm5pbmcgWzBdIGJ5IGNoYW5jZSB0aGlzIGV2
ZW5pbmcgd2hlbiBkb2luZyBhIGJ1aWxkIHdpdGggdGhlIG1veGFfbXhjX2RlZmNvbmZpZyBbMV0g
S2VybmVsIGNvbmZpZy4NCj4gPg0KPiA+IElzIHRoaXMgc29tZXRoaW5nIHdlIHdhbnQgdG8gY29y
cmVjdD8NCj4gDQo+IFRoYW5rcyBmb3IgeW91ciByZXBvcnQuDQo+IFJUQ19EUlZfRFMxMzc0X1dE
VCBjYW4gbm90IHNldCAneScuIEkgd2lsbCB1cGRhdGUgbW94YV9teGNfZGVmY29uZmlnLg0KPiAN
Cg0KUlRDX0RSVl9EUzEzNzRfV0RUIGNhbiBub3Qgc2V0ICdtJy4NCkFuZCBJIHVwZGF0ZWQgbW94
YV9teGNfZGVmY29uZmlnIGFuZCBwdXNoZWQuDQoNCj4gPg0KPiA+IFswXQ0KPiA+ICJhcmNoL2Fy
bS9jb25maWdzL21veGFfbXhjX2RlZmNvbmZpZzo3NDU6d2FybmluZzogc3ltYm9sIHZhbHVlICdt
JyBpbnZhbGlkIGZvciBSVENfRFJWX0RTMTM3NF9XRFQiDQo+ID4gaHR0cHM6Ly9naXRsYWIuY29t
L2NpcC1wcm9qZWN0L2NpcC1rZXJuZWwvbGludXgtY2lwLy0vam9icy81NDYwNjU2ODgjTDEyOQ0K
PiA+IFsxXSBodHRwczovL2dpdGxhYi5jb20vY2lwLXByb2plY3QvY2lwLWtlcm5lbC9jaXAta2Vy
bmVsLWNvbmZpZy8tL2Jsb2IvbWFzdGVyLzQuNC55LWNpcC9hcm0vbW94YV9teGNfZGVmY29uZmln
DQo+ID4NCj4gPiBLaW5kIHJlZ2FyZHMsIENocmlzDQo+IA0KQmVzdCByZWdhcmRzLA0KICBOb2J1
aGlybw0K

--lJQVZKgeOrbcscNQm6xZ
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4659): https://lists.cip-project.org/g/cip-dev/message=
/4659
Mute This Topic: https://lists.cip-project.org/mt/74616319/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--lJQVZKgeOrbcscNQm6xZ--
