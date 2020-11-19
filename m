Return-Path: <SRS0=W2bD=EZ=lists.cip-project.org=bounce+64572+5806+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E5BBC5519F
	for <cip-dev@archiver.kernel.org>; Thu, 19 Nov 2020 02:43:58 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67484246B8
	for <cip-dev@archiver.kernel.org>; Thu, 19 Nov 2020 02:43:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="s2oycFuI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67484246B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5806+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id g2euYY4521723x47X1y2tzEH; Wed, 18 Nov 2020 18:43:56 -0800
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.154])
 by mx.groups.io with SMTP id smtpd.web08.3874.1605753834149430872
 for <cip-dev@lists.cip-project.org>;
 Wed, 18 Nov 2020 18:43:55 -0800
X-Received: by mo-csw.securemx.jp (mx-mo-csw1515) id 0AJ2heiv031566; Thu, 19 Nov 2020 11:43:40 +0900
X-Iguazu-Qid: 34ts1bXBCjZnxef0l6
X-Iguazu-QSIG: v=2; s=0; t=1605753820; q=34ts1bXBCjZnxef0l6; m=P519yrU+mlVPUP5/9qthkhhmYBy3WqTO9ZADnQFh3tE=
X-Received: from imx2.toshiba.co.jp (imx2.toshiba.co.jp [106.186.93.51])
	by relay.securemx.jp (mx-mr1512) id 0AJ2hdVH014038;
	Thu, 19 Nov 2020 11:43:39 +0900
X-Received: from enc01.toshiba.co.jp ([106.186.93.100])
	by imx2.toshiba.co.jp  with ESMTP id 0AJ2hcnf025000;
	Thu, 19 Nov 2020 11:43:38 +0900 (JST)
X-Received: from hop001.toshiba.co.jp ([133.199.164.63])
	by enc01.toshiba.co.jp  with ESMTP id 0AJ2hb9Q005632;
	Thu, 19 Nov 2020 11:43:38 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B3iycUhfZJNTdgwgn4K5wSS5f5HbdUIFsElg/+2m1Mqjgxg/pm/P5lvUGcBqIdGqV2N9/h2cJ1WUoiKeTkEQwz9e28L3SzNIwtHoHjp2fjggQh+EK9BTjDYVttLoumMeFu1Fz4UMrYUQjF9t70Za9pgeob1L1FGAaZi0tuRF+ewEd28dz/0+kQm06JHI+rD5n6rUaDVct1FmcOSR6Kj45L84JPPaqjVOwbJJV9fXwS9ZhqXiDfU/A9le7F+SYvu86Rep/w6bn/vopqBe4eqML65ARsmDImlu9JHjD2gh+ScFirHFzVmxNElx7MnJlpuERQoPzULBxxQaN7cYjRAVjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CtpRc+4LI7aZKV0h8fP36q0ShDdAGrDPAj25flCrfyk=;
 b=UtobpTuAVIKtzBKdDOtmKQd/F9259p+qjRxroju++ZY83dHyCqdzRr6fF/JPJA9w9h3Jpe+csGo7wmhzfS3eWvXV4oi4FPV/hiTYjiX0Wdyo/T36l7hZpFFNBV+RsfnzbOJQ3DYsUGrPKCh/OEgpkw8iffoyLT+RAVzx1irv1dB+nZyeGyrArfx4qE8NX+VllTNmtqngntiJI9SZvqjJbiIlHjX4Uo2esVUzDX9EUyHEwtXpeYTXHQKNu3A12Fdoyq5ve89BNmvlFSCdQNvb3ixoubssRrFWNUvEYW+28Kry+Fw0J5I4z8o9iHWrjV05MYk7UC/Sx9ZnsriOndAavA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: "Nobuhiro Iwamatsu" <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <jan.kiszka@siemens.com>
CC: <cip-dev@lists.cip-project.org>, <wens@csie.org>, <pavel@denx.de>,
        <masashi.kudo@cybertrust.co.jp>
Subject: [cip-dev] About corresponding CVE-2020-25669 from CIP kernel config side
Thread-Topic: About corresponding CVE-2020-25669 from CIP kernel config side
Thread-Index: Ada+HcbxHj2VtR2NRheusAWsF8UA+w==
Date: Thu, 19 Nov 2020 02:43:36 +0000
X-TSB-HOP: ON
Message-ID: <OSBPR01MB29831AC14AD65ADE956DFF3392E00@OSBPR01MB2983.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
x-originating-ip: [103.91.184.4]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2e34f060-3d65-46ec-d040-08d88c34ea30
x-ms-traffictypediagnostic: OSBPR01MB4136:
x-microsoft-antispam-prvs: <OSBPR01MB413678C5D3D8B45B1CADC15292E00@OSBPR01MB4136.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: fLyb5sIwOjn/S0oSP1qrFWtEFUzo+39GmLdo4b9JeZ+ttBDyWAWA23rwa4s8ZWAy/wHsbsThiK6XHzuUADuM5Mqmp5TJD/P3aVxVnfxRYZqI2jBkV1+sT/+ZLUzPVb4Z90EskiBvFfhTN4erF/gTLLyAvGn3diqXVtX93r+Htrv8Yj6P2gACGjfc7zq8dKldhRkBinAdy4PECs3QlWsH/85cFujYi9UTx9ZPskcmXk60jHUgq/5rkLidPX9TW6w+b08Dzt0GolKUNuApJH8rR7A57KIhP0MIWK1Hx5jXHIniUQLtaLSYSHFudhjaqKECFFgFo7JcP757L1Ulj9lshMaxCJwA6rG0wHYleDVeiyNp4BdjgvzUsQjeUBu6hvTIi5536C4KaKx+84CYt3tKqQ==
x-ms-exchange-antispam-messagedata: NujxjwPiHWUIFpaMiZ1LxpauChga+R6JP+tSrAmPOkxLv4DPtSR2Bx24EvMavVVQLsCrFEOin8FEYHe0s5O301hBS2iS6UST3w+4DW6+iiCQQBsOOFQhjCrEGxR1M9nwNkVHyi897J8E2DLaSojKeKbjCFYaEOMI1462TtSsm67c1rsLURkfOj+UfXNjcdzJatub+7iqfS2SbZnsKSfrY4kQ/dQfRaRBL+RVSJ8GiXgEc3kExxPwplEY4EyyNlFR3IOloCVReLPg+0els/p7aGCtU8xQilGEUbbvixLH0SC5vAAWBNCiPvXZ+akF3Jx25blcv8aZ84rhu/ypXqnOzWUflyrWiF4CZKuERtpriz3osWi7wwxIQm1gxnJ0mPwPzUCoZthRZzfXU4ov92P8jlZoGP50DVwIknbuuLoGNHwgGYLP1MFZYI+qFefeUrIA/uywz4I9KjPWgNfvSAtsveephgbo9Gu+gheK+Sfh62Tl0gw3LWMc9hieOYupnu99wfhSFHL/ZGFrmlb25lMeIan2BEkyUReaV2yL6dvF4+OTqlSlDk1CdefLn+L1uEVS92wM9VqdIB+dPkmnYYB0/1WL8R/O6AdzH+v7YXUe7on4gd5MUsQQ82cUOxYc5NyKUEyidkg0kFEw3yI992cJvT8TKPNRa058N5fXrt0pNni6oWbmAjcecKqruGT8JyIaj/JMj3ASCACg5iNOnHsdNG+vqvYZNA7YfIu2A2PGReIkqPZg5F9dnbzP6JU3VBcTaDbQuWVV4Iu73KcOsxD67qJsdnsZ9RIncP6PANKpL79/5RF9wQEKaKYMp8NLJ/ZUciBXrx+5ltW9uFgidzG/uFD63kT9TAGdUD5ogpCp9euZWOWVDIiIVFsmJu+O91kHU8bja8vQnmxyenxCPsIsJQ==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2983.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e34f060-3d65-46ec-d040-08d88c34ea30
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2020 02:43:36.7920
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pHsvk+C7L4kYpaYakj72VyIFqSP+xzMBf7SfLtmNsCbJegTuF7DSqQGYyOk52roo3FyZZuTAN2fUsCyOMz8ayrwNZMKRS8zE2W3UNMk7nGIoQU+3aqdFZHQaW5v0X5R0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB4136
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: V7n8Pl2ya0FnNKe1plerxPxSx4520388AA=
Content-Type: multipart/mixed; boundary="OjSITfdeGWWH9ZcbAVUl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1605753836;
 bh=p1VjgQll0x7Jf9rXPk0SiTmLULMjelEyOrUar6vC1yk=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=s2oycFuIGNLZ/XregiRXHGCC0Ssji40OR2JrDbBadtENlCiRJV2s9zoYFxzkyp31XtD
 WxUrwKcLAB4IFz00brqP9zJ+X1odkMPWopTPbjDIU41WCIbHUJ7zP1rzG+BMoAjCFyH0K
 aBqTUCTi2GrhpjjONo21Ha/RSVsCIO4h400=

--OjSITfdeGWWH9ZcbAVUl
Content-Language: ja-JP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGkgSmFuLA0KDQpDVkUtMjAyMC0yNTY2OVswXSBpcyBhIENWRSBmb3IgU1VOS0JEIChzdW40L3N1
bjUga2V5Ym9hcmQpLCB3aGljaCBpcw0KZW5hYmxlZCBpbiBzaWVtZW5zX2kzODYtcnQga2VybmVs
Lg0KDQpgYGANCiQgZ2l0IGdyZXAgU1VOS0JEDQo0LjE5LnktY2lwLXJ0L3g4Ni9zaWVtZW5zX2kz
ODYtcnQuY29uZmlnOiMgQ09ORklHX0tFWUJPQVJEX1NVTktCRCBpcyBub3Qgc2V0DQo0LjE5Lnkt
Y2lwL3g4Ni9wbGF0aG9tZV9vYnN2eDIuY29uZmlnOiMgQ09ORklHX0tFWUJPQVJEX1NVTktCRCBp
cyBub3Qgc2V0DQo0LjE5LnktY2lwL3g4Ni9zaWVtZW5zX2lvdDIwMDAuY29uZmlnOiMgQ09ORklH
X0tFWUJPQVJEX1NVTktCRCBpcyBub3Qgc2V0DQo0LjQueS1jaXAtcnQveDg2L3NpZW1lbnNfaTM4
Ni1ydC5jb25maWc6Q09ORklHX0tFWUJPQVJEX1NVTktCRD1tDQo0LjQueS1jaXAvYXJtL3NpZW1l
bnNfYW01N3h4LXB4bTMuY29uZmlnOiMgQ09ORklHX0tFWUJPQVJEX1NVTktCRCBpcyBub3Qgc2V0
DQo0LjQueS1jaXAvYXJtL3NpZW1lbnNfaW14Nl9kZWZjb25maWc6IyBDT05GSUdfS0VZQk9BUkRf
U1VOS0JEIGlzIG5vdCBzZXQNCjQuNC55LWNpcC94ODYvcGxhdGhvbWVfb2JzdngxLmNvbmZpZzoj
IENPTkZJR19LRVlCT0FSRF9TVU5LQkQgaXMgbm90IHNldA0KNC40LnktY2lwL3g4Ni9zaWVtZW5z
X2lvdDIwMDAuY29uZmlnOiMgQ09ORklHX0tFWUJPQVJEX1NVTktCRCBpcyBub3Qgc2V0DQpgYGAN
Cg0KSXMgdGhpcyBkcml2ZXIgdXNlZD8gSWYgeW91J3JlIG5vdCB1c2luZyBpdCwgSSdkIGNvbnNp
ZGVyIHJlbW92aW5nIGl0IGZyb20gdGhlIGtlcm5lbCdzDQpjb25maWcgdG8gc3VwcG9ydCB0aGlz
IENWRS4gQ291bGQgeW91IGdpdmUgbWUgeW91ciBvcGluaW9uIG9uIHRoaXM/DQoNCg0KQmVzdCBy
ZWdhcmRzLA0KICBOb2J1aGlybw0KDQpbMF06IGh0dHBzOi8vc2VjdXJpdHktdHJhY2tlci5kZWJp
YW4ub3JnL3RyYWNrZXIvQ1ZFLTIwMjAtMjU2NjkNCg==

--OjSITfdeGWWH9ZcbAVUl
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5806): https://lists.cip-project.org/g/cip-dev/message=
/5806
Mute This Topic: https://lists.cip-project.org/mt/78357177/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--OjSITfdeGWWH9ZcbAVUl--
