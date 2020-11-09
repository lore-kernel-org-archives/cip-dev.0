Return-Path: <SRS0=SRZN=EP=lists.cip-project.org=bounce+64572+5765+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD58BC388F9
	for <cip-dev@archiver.kernel.org>; Mon,  9 Nov 2020 01:46:20 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E820F206A5
	for <cip-dev@archiver.kernel.org>; Mon,  9 Nov 2020 01:46:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="ebjVaAw/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E820F206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5765+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id dWmWYY4521723xUjdPtIqg0F; Sun, 08 Nov 2020 17:46:19 -0800
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.156])
 by mx.groups.io with SMTP id smtpd.web10.5541.1604886377231694134
 for <cip-dev@lists.cip-project.org>;
 Sun, 08 Nov 2020 17:46:18 -0800
X-Received: by mo-csw.securemx.jp (mx-mo-csw1114) id 0A91k591030761; Mon, 9 Nov 2020 10:46:06 +0900
X-Iguazu-Qid: 2wHHmca9ffu3EKWqrV
X-Iguazu-QSIG: v=2; s=0; t=1604886365; q=2wHHmca9ffu3EKWqrV; m=P23qz9fZQbrWi5UcM64inBhOQR6u78hlU9Fy9rYKnHo=
X-Received: from imx2.toshiba.co.jp (imx2.toshiba.co.jp [106.186.93.51])
	by relay.securemx.jp (mx-mr1112) id 0A91k4wl020382;
	Mon, 9 Nov 2020 10:46:04 +0900
X-Received: from enc01.toshiba.co.jp ([106.186.93.100])
	by imx2.toshiba.co.jp  with ESMTP id 0A91k4p3029057;
	Mon, 9 Nov 2020 10:46:04 +0900 (JST)
X-Received: from hop001.toshiba.co.jp ([133.199.164.63])
	by enc01.toshiba.co.jp  with ESMTP id 0A91k3oK018478;
	Mon, 9 Nov 2020 10:46:03 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=glVID1cP+fG4G199zOS+P25Q7On2GuStdi2rkly+i0Iv0FXLq0oqNJnrUkY1y/rgni8aFGuurohOQK+UNWaNNtqxfEdSvlNiBtkWrf2yvjN9HQyQRbudKt3+U+r2GVPLhbWvi8cIoulGxIUtDDDL20XXOUqincPCdYQyXsqXgT1OGSIKA14fm2tf+GiaqMJt87oSeerLfjqivX1Aza0/CYSFRaU5MTOVS727S7Gzy58KSIX5+tj5+fynRVZ90lnF5e5LzOZmFA6inSzeHg9+DMjwWxEN4xix3xbcOVsN6yLtTdfw9ZeoaTqyPkL6vzgmVxJj98MeUvCruejOSi+uJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mKo85wODb3YM71DlVA22X8aRziSNk7Nkvwiri19/8xs=;
 b=nP5bcv4D+AWfzMb7NGE3+kSzMo6vyKBZhtMSczYdmBnwPHxQ6KoZAXzh9K7qRF3Bx/Z4cFe4aQWjLiLDEQIG8Vo4GPkfhSzgJnAnes3zwZjyoIHIoBFezL+qV8uLG0r2aVq9DveEudIsuAKsiF+dTq25kG3dxJ8/d4RIFdMBDYTyeM3LvsE+lfRke4ZeL0xhqWf7VL8cpVEZZM9EG+kCGggcEESterTGANE66+TNKYWYNRw2n8PjPAyb/vERBFHsWoSb14Oi3B6ufGv1d5mOBpQ77i9R2pKA13omk4prmVnAkjvfFBUO7nHcUqJsedgMx1D4Nt5+IeXsc2Z3+Neb/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: "Nobuhiro Iwamatsu" <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <pavel@denx.de>, <prabhakar.mahadev-lad.rj@bp.renesas.com>
CC: <cip-dev@lists.cip-project.org>, <biju.das.jz@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 4.4.y-cip 0/8] Renesas RZ/G1H add PCIe, SATA and VSP support
Thread-Topic: [PATCH 4.4.y-cip 0/8] Renesas RZ/G1H add PCIe, SATA and VSP
 support
Thread-Index: AQHWtCJ6/Lr18dW250qWzN8j7H/IrKm8SC6AgALDKnA=
Date: Mon, 9 Nov 2020 01:46:01 +0000
X-TSB-HOP: ON
Message-ID: <OSBPR01MB298301B9CB770BFB9AFF789892EA0@OSBPR01MB2983.jpnprd01.prod.outlook.com>
References: <20201106095151.25880-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20201107073303.GA14654@amd>
In-Reply-To: <20201107073303.GA14654@amd>
Accept-Language: ja-JP, en-US
x-originating-ip: [103.91.184.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 564ef347-82b4-4957-95b7-08d8845136b7
x-ms-traffictypediagnostic: OSAPR01MB1553:
x-microsoft-antispam-prvs: <OSAPR01MB15530DA2ABF05F78B7D45AB292EA0@OSAPR01MB1553.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: xcqdlczGpgPowcua7AB95iCfrBhedtk92vVFmZRfjAfhiw35gXopCH4YBZCOcfpkyVN61XEe9KiaF6ladxyPjm/BeStCDBEbg50Kt4kKMnbeslaNwHV3Fw+MjfpeSoMmDO6ZFt8RG4CnnDWeU/8f6zeXynQBkLnaJftMR0xvk+oxP/ZGMfTYSl7pMb+rCV03JzqOWO+dZMmUKJ93Xi5DYIwlF3NtKQcVqUm6eaScEfmHdpSRVYNyWVvl1mDzpqFH+K80iUQjfnrNBeUGmItXx0+71Vv2ZWUa43GPAvHjn0byXxueZUEaXFFEXo8h+zU+
x-ms-exchange-antispam-messagedata: +jvKWEWOleVjG8AXjrGZr96FfZMLu7AkV0AVEEt1l/SIQVWVmi4mYVIcRLB2PQ7NiO/EvctiPuCQ6nmo63KGKIgblPGq1VkkxxY5hYlP0AGdviUOK9EJo0SuHPEo9LMBN0XgAfHZOOX6/n47dNSAMlos4v55CqHq+ozGR/h/rjMuyhfNy/9zkAlApwAyFLsB2ZXlhsiz23apkE8hJyYRFAEHy2vIol6kvznMwiGTk+QEg+EcuhFJXE2kpiek7Y7JIWdNwHY0bZPOAa7OYO8CDA0AtSIe9tJjFE+B6tIa+H1rt7XoQw8jAbN6lJHb+XJFPs0mSLWRQXmtlDzkbb+sPO6R00Otcvc8h9Ubyy8skCLXhplETZIpQslXGzl+/iekAjmvQtyibQrsMu9bvBAUU0jD94fXgVy3FWfZZC4SlVj9+sgv27CMXaXGeKFt6lbbEape9W8e9KeS8zMIOMboXRQuplNih6XtUzgLojkj/8NdtCr8Ik3h/HEd/ENuD2hV7CuJ0PJZnpNBZ9UXQOa9b1OAShY5Bc6PIOR78er2qIrUmiKfAgoB3gNj9u63tMRH909NVoa590REnAF32A0WRgkjUAkHdQV5RurewNRJ/6GVhCUNML094tL/JILeTWTZzDRWkQovLySWwqaeNhZkIHAxM6JswkqoKrK1fmOIgghYY0/pPvOZHwuV9Lce3MKrQ1d/h0LiHzPWjH4xVDNoinj2FT53rjrUBP6lS235ggPToZTxmhHYWGEI6Z1eDNon/OKQ4fNkUHqFctg92XHTGXVuqnqiS4ISNOAIMjWuniJrS2xzbv/MmwR2Tw12G6C+WvVJ5XPTCUm/pGUlpccrb/ZtHYSySW9L+/AeN9jPOS49vTf1KhbcNE7Eof9jSmRVZ1UOsVnelRJr7K+tt9h3iw==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2983.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 564ef347-82b4-4957-95b7-08d8845136b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2020 01:46:01.6924
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hhq/CieHLuMsuK3o2Al3vBraoCHIjHnSIGaJC5gfbYw6f+4qicl0cIjytgBuiub68PLABIksB8msa1txXYE2+uSMOTitBVMkwxx7yidAzTKZltgchFp5yffuJ7ULea97
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB1553
MSSCP.TransferMailToMossAgent: 103
X-OriginatorOrg: toshiba.co.jp
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: WlL2nF1X2AHbmnfPXNOVRZRcx4520388AA=
Content-Type: multipart/mixed; boundary="wmQfVr9DtlojG1XfjxwU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1604886379;
 bh=P5e980PgiyA4kkmZbgqBfQYNILUnqk+WCGw5Q1Oq6po=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=ebjVaAw/a5pJY+CPOMX/cbkWuanH0B0oWZxbdOqm4c5noC2aXfMgrclvIWZDQ8WoEKK
 KTMJ0i6EKX489LkcQdpyvJ8mEBgObctzyhHBf9l7TNtp1HhZ2pV+/fD5iHkFnPB+Wzw0W
 VHuTk7l1doz9TSMyC/vlGfRNehlPHLIz6Tg=

--wmQfVr9DtlojG1XfjxwU
Content-Language: ja-JP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGkgYWxsLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFBhdmVsIE1h
Y2hlayBbbWFpbHRvOnBhdmVsQGRlbnguZGVdDQo+IFNlbnQ6IFNhdHVyZGF5LCBOb3ZlbWJlciA3
LCAyMDIwIDQ6MzMgUE0NCj4gVG86IExhZCBQcmFiaGFrYXIgPHByYWJoYWthci5tYWhhZGV2LWxh
ZC5yakBicC5yZW5lc2FzLmNvbT4NCj4gQ2M6IGNpcC1kZXZAbGlzdHMuY2lwLXByb2plY3Qub3Jn
OyBpd2FtYXRzdSBub2J1aGlybyjlsqnmnb4g5L+h5rSLIOKWoe+8s++8t++8o+KXr++8oe+8o++8
tCkNCj4gPG5vYnVoaXJvMS5pd2FtYXRzdUB0b3NoaWJhLmNvLmpwPjsgUGF2ZWwgTWFjaGVrIDxw
YXZlbEBkZW54LmRlPjsgQmlqdSBEYXMgPGJpanUuZGFzLmp6QGJwLnJlbmVzYXMuY29tPg0KPiBT
dWJqZWN0OiBSZTogW1BBVENIIDQuNC55LWNpcCAwLzhdIFJlbmVzYXMgUlovRzFIIGFkZCBQQ0ll
LCBTQVRBIGFuZCBWU1Agc3VwcG9ydA0KPiANCj4gSGkhDQo+IA0KPiA+IFRoaXMgcGF0Y2ggc2Vy
aWVzIGFkZHMgc3VwcG9ydCBmb3IgUENJZSwgU0FUQSBhbmQgVlNQLg0KPiA+DQo+ID4gQWxsIHRo
ZSBwYXRjaGVzIGhhdmUgYmVlbiBjaGVycnktcGlja2VkIGZyb20gTGludXggdjUuMTAtcmMyLg0K
PiANCj4gSSBkb24ndCBzZWUgYW55IHByb2JsZW1zIHdpdGggdGhlIHNlcmllcywgYW5kIGl0IHBh
c3NlZCBiYXNpYyB0ZXN0aW5nLA0KPiBzbyBJIGNhbiBhcHBseSBpdCBpZiB0aGVyZSBhcmUgbm8g
b3RoZXIgY29tbWVudHMuDQo+IA0KDQpJIHJldmlld2VkIHRoaXMgcGF0Y2ggc2VyaWVzLCB0aGVy
ZSB3YXMgbm8gaXNzdWUuDQpTbywgSSBhcHBsaWVkIGFuZCBwdXNoZWQuDQoNCkJlc3QgcmVnYXJk
cywNCiAgTm9idWhpcm8NCg0K

--wmQfVr9DtlojG1XfjxwU
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5765): https://lists.cip-project.org/g/cip-dev/message=
/5765
Mute This Topic: https://lists.cip-project.org/mt/78070979/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--wmQfVr9DtlojG1XfjxwU--
