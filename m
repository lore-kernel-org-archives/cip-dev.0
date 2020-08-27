Return-Path: <SRS0=pMSo=CF=lists.cip-project.org=bounce+64572+5277+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9E81C433E1
	for <cip-dev@archiver.kernel.org>; Thu, 27 Aug 2020 07:09:43 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B4E222B4E
	for <cip-dev@archiver.kernel.org>; Thu, 27 Aug 2020 07:09:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="NWRjck5I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B4E222B4E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5277+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id JVMZYY4521723x42EysTlx1F; Thu, 27 Aug 2020 00:09:43 -0700
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.web12.13629.1598512180702652955
 for <cip-dev@lists.cip-project.org>;
 Thu, 27 Aug 2020 00:09:42 -0700
X-Received: by mo-csw.securemx.jp (mx-mo-csw1116) id 07R79W8f001673; Thu, 27 Aug 2020 16:09:32 +0900
X-Iguazu-Qid: 2wGr7dZaS6GiysIT9J
X-Iguazu-QSIG: v=2; s=0; t=1598512171; q=2wGr7dZaS6GiysIT9J; m=ZfBq8MOPkuNe6GDjpgbV7+GIX3elwA0PlfKbgECXp1k=
X-Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
	by relay.securemx.jp (mx-mr1110) id 07R79Uu4011710;
	Thu, 27 Aug 2020 16:09:30 +0900
X-Received: from enc02.toshiba.co.jp ([61.202.160.51])
	by imx12.toshiba.co.jp  with ESMTP id 07R79U28021593;
	Thu, 27 Aug 2020 16:09:30 +0900 (JST)
X-Received: from hop101.toshiba.co.jp ([133.199.85.107])
	by enc02.toshiba.co.jp  with ESMTP id 07R79TxN021809;
	Thu, 27 Aug 2020 16:09:30 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hwanZlfaM6ARn+h9sqzGe5H27zh0pj6tw3zeZRyh/tfUuhnz4WHXgAlgJpnsSCax7AwiLGdQTQ0gBASrcFE6Rj7+Fe412edQII5RAX3P5MgQpipP+MU2KPsFFYxAZZ2QAoB/8GZPoSxVYKTmqjIJmiDG99+JAvHcQY7bYedfBVYzJGMfAb1YSHUDFR/F+o8fNo5AXHJVDKnCT/qELtc4fI9UUwEDe4pLWkvlE19uKnMlvFWyEIFbnMplQNL5Wtk8n/VnPL5/t6itNlBTfTcDGlhiAU1vuvXkcQ2sPWJEhjGqloPX0Ajr/Zd+eTfi/2lCUsmmMBQNViDbJlXOa7l+bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kYld25VBgogta43SbEIufaUJfRAatew5O2JpAPQjI5U=;
 b=g3NyEvUqH2HRz7kVAe3EygUK4Alhxc62bfo9aC1D1O69zxcree6GUzUyZIgl25WZvSjVG48UmJyBznHTNgjkEQS7tHt22hXubno8scntW9vBgL79QMmbYnoN3MBH2ied7va0Q52nNiZFPc2bmx3JLFpeBjYhV3G5VYQZGiWWm3IgU6Y4HwPsXobA2n1ykWVCDNy6w+p2fi5z+VXHGKd9G8SDQEPL2KUC6p0xveaGtldUw5O7hbY10RB8sMIlo5mkOe6qgwmz/yu2hMTjSNNUWmT4uTG6OapKKY0D2JD3ClS+agj+IbbAZXnDw05xrmxVdYBKyNLsV2tTZeOmnGaq2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: "Nobuhiro Iwamatsu" <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <biju.das.jz@bp.renesas.com>, <pavel@denx.de>
CC: <Chris.Paterson2@renesas.com>, <cip-dev@lists.cip-project.org>,
        <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 4.19.y-cip 00/10] Add support for [H]SCIF/SDHI/I2C/RWDT/MSIOF
Thread-Topic: [PATCH 4.19.y-cip 00/10] Add support for
 [H]SCIF/SDHI/I2C/RWDT/MSIOF
Thread-Index: AQHWfECsG/iuj+coB0OqvDrKNbbhHKlLiQ3w
Date: Thu, 27 Aug 2020 07:09:23 +0000
X-TSB-HOP: ON
Message-ID: <TYAPR01MB299093451ADBFF82CF94DECE92550@TYAPR01MB2990.jpnprd01.prod.outlook.com>
References: <20200826112132.4090-1-biju.das.jz@bp.renesas.com>
 <20200826214624.GB15974@amd>
 <TYBPR01MB53095251790B479E03B8D1F186550@TYBPR01MB5309.jpnprd01.prod.outlook.com>
 <20200827070003.GA20517@amd>
 <TYBPR01MB5309F4A53E0487828CB66B5686550@TYBPR01MB5309.jpnprd01.prod.outlook.com>
In-Reply-To: <TYBPR01MB5309F4A53E0487828CB66B5686550@TYBPR01MB5309.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
x-originating-ip: [103.91.184.4]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e1d5ee25-cc8c-44c2-b3eb-08d84a5820bb
x-ms-traffictypediagnostic: TY2PR01MB2283:
x-microsoft-antispam-prvs: <TY2PR01MB2283D56284BF29DCCE71404692550@TY2PR01MB2283.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 3OC/Z2MnOVmyatHOfHUTbx4nb/yaH1sXEoNtliqpyoTLmnH9agEY7wiX/CiedTzJYrbKMxh+t04ziKD7fa8ArCeDDlHMcZwwa7eVOpZuolD4ocricspVAcOfahwoV/MCUDOdmQoBEkFPtK10KYiankh2iKxjGYX7VJGxdG1MWMtRux2aD3BRz65id32I8w6ZqDd0h4n3qhOKa239WqrLeCqf5jgOnnj2sWaYT724Oco8tXh2z+dGIEdc+jR7aDbllc1wOo23zV56DSWPYzI8b06RnktgabmgFjtz4NAxg0NRZpHSyuw0ImHrxkcM0W1EmnTerJvNSPVQicythwQRag==
x-ms-exchange-antispam-messagedata: +tegAvohxmfNsEnduwWXGipIefXEo7Vsy90mOmszvHc6kHRV4qoYh8zW6Mbec8WjMOy2kISUcAz+JqSZlYYmpSInPPjWCG5Ee0W53JfDYl02DgRYVPCVOGLWmtZbcM7k/KRA2lCsFVgcMC3aUMAX/xgdlLrxrEvwV9DJaRgGSOvtjCwzykQAoECEeFuC9SGPfMjiZv1VuG9KNuK4LtYMayYZ8INbA+LU83kRoBiXnBTAEJFMZsOB5nRub9KQTdMrxYrXXDtoEf9GCbbavi2tukPDJFxLke4j3xArP0Pf06Sk9dwHfGb8JTolMKrLp8AMn1BA8e3BQ/M1NoAA/txxF857j3e+vFqH4Mnd3ePPZ1+oMwbheEy9GhVZE1zB4zTSFOpDOyTkHL+4ydpN0Iz1zpl4u66pn5qI5E8VU4wVi/sqEanebW2GUOc8yYe6QzipNAHdyy1GZ6jhZNUeMzVHffG7y8ohDKbyY0widHuB1td7V+4bQU20Ge+izmE+V38HUZVyEzv+zWwe94dmqQSMirA9NSS59PSA98mmL22yXy0c+wt/1oRrlEBhGg2GEPomr+foNOsOqszjZusR2/rhGoPuOuDJ5U7Bc3xsI9qqbJbNYuHTtBHS0/3Q3YI5TiruiwlK0lB4XkjgUedNXKV6OQ==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB2990.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1d5ee25-cc8c-44c2-b3eb-08d84a5820bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2020 07:09:23.3728
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: txMgQn8vPgAOjHi/f2MvHKqksgrNxKwMcZESu10OTQdHOiM42QeOxv6cL5pttBYPh7r09sB2aotTYmGFs/wml+NgXgbX1H9M4iDv6NPNRKhTpk0JanNbFe+PQ2XGbfpr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB2283
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 8Perjqt7I3EhATaOSBXoEoXsx4520388AA=
Content-Type: multipart/mixed; boundary="rI30mZPHaON4f2me112E"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1598512183;
 bh=fJOSwp/QeAr/v21ZvB0pZ2tKmVDh4YZ6BoYEpxloheE=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=NWRjck5IShvkd1ya/TM4k0Y0iyZOxEs5FYtXREfn99EzkEkjPxgS0tkr6XBU7bwvIHN
 yysv2T03rpM3egnl5aN868Q/UkRXZ6mtuGAwA0I8Ci/he163NjgQzrbWbmhZKY78XlZZL
 KRrc4je0/wVmRTpSN7juItvDydNg1MUijnY=

--rI30mZPHaON4f2me112E
Content-Language: ja-JP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGksDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQmlqdSBEYXMgW21h
aWx0bzpiaWp1LmRhcy5qekBicC5yZW5lc2FzLmNvbV0NCj4gU2VudDogVGh1cnNkYXksIEF1Z3Vz
dCAyNywgMjAyMCA0OjA3IFBNDQo+IFRvOiBQYXZlbCBNYWNoZWsgPHBhdmVsQGRlbnguZGU+DQo+
IENjOiBDaHJpcyBQYXRlcnNvbiA8Q2hyaXMuUGF0ZXJzb24yQHJlbmVzYXMuY29tPjsgY2lwLWRl
dkBsaXN0cy5jaXAtcHJvamVjdC5vcmc7IGl3YW1hdHN1IG5vYnVoaXJvKOWyqeadviDkv6HmtIsg
4pah77yzDQo+IO+8t++8o+KXr++8oe+8o++8tCkgPG5vYnVoaXJvMS5pd2FtYXRzdUB0b3NoaWJh
LmNvLmpwPjsgUHJhYmhha2FyIE1haGFkZXYgTGFkIDxwcmFiaGFrYXIubWFoYWRldi1sYWQucmpA
YnAucmVuZXNhcy5jb20+DQo+IFN1YmplY3Q6IFJFOiBbUEFUQ0ggNC4xOS55LWNpcCAwMC8xMF0g
QWRkIHN1cHBvcnQgZm9yIFtIXVNDSUYvU0RISS9JMkMvUldEVC9NU0lPRg0KPiANCj4gSGkgUGF2
ZWwsDQo+IA0KPiBUaGFua3MgZm9yIHRoZSBmZWVkYmFjay4NCj4gDQo+ID4gU3ViamVjdDogUmU6
IFtQQVRDSCA0LjE5LnktY2lwIDAwLzEwXSBBZGQgc3VwcG9ydCBmb3INCj4gPiBbSF1TQ0lGL1NE
SEkvSTJDL1JXRFQvTVNJT0YNCj4gPg0KPiA+IEhpIQ0KPiA+DQo+ID4gPiBUaGFua3MgZm9yIHRo
ZSBmZWVkYmFjay4NCj4gPiA+DQo+ID4gPiA+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggNC4xOS55LWNp
cCAwMC8xMF0gQWRkIHN1cHBvcnQgZm9yDQo+ID4gPiA+IFtIXVNDSUYvU0RISS9JMkMvUldEVC9N
U0lPRg0KPiA+ID4gPg0KPiA+ID4gPiBIaSENCj4gPiA+ID4NCj4gPiA+ID4gPiBBZGQgUlovRzJI
IFNvQyBzdXBwb3J0IGZvciBbSF1TQ0lGL1NESEkvSTJDL1JXRFQvTVNJT0Ygb24NCj4gPiA+ID4g
PiA0LjE5LnktY2lwDQo+ID4gPiA+IGtlcm5lbC4NCj4gPiA+ID4gPg0KPiA+ID4gPiA+IEFsbCB0
aGUgcGF0Y2hlcyBpbiB0aGlzIHNlcmllcyBhcmUgY2hlcnJ5LXBpY2VkIGZyb20gTUwsIGV4Y2Vw
dA0KPiA+ID4gPiA+IFsxXSB3aGljaCBpcyBhIG5ldyBwYXRjaCBzaW1pbGFyIHRvIHRoZSB3b3Jr
ZG9uZSBmb3Igb3RoZXIgc2ltaWxhcg0KPiA+ID4gPiA+IFNvQydzDQo+ID4gPiA+DQo+ID4gPiA+
IFNlcmllcyBsb29rcyBnb29kIHRvIG1lLiAoQnV0IGdpdGxhYiB0ZXN0aW5nIGRvZXMgbm90IHNl
ZW0gdG8gd29yaywNCj4gPiA+ID4gYW5kIGl0IHdvdWxkIGJlIGdvb2QgdG8gdGVzdCBpdCBiZWZv
cmUgYXBwbHlpbmcpLg0KPiA+ID4NCj4gPiA+IEkgYW0gIG5vdCBzdXJlIGFib3V0IHRoZSBmYWls
dXJlLiAgSWYgaXQgaXMgcmVsYXRlZCB0byB0ZXN0aW5nIG9uDQo+ID4gPiBSWi9HMkggYm9hcmQs
IHRoZW4NCj4gPg0KPiA+IE5vLCBpdCBpcyBkZWZpbml0ZWx5IG5vdCByZWxhdGVkIHRvIHlvdXIg
Ym9hcmRzLiBOb3RoaW5nIGV2ZXIgYnVpbGRzLi4uIGl0IGNhbid0IGJlDQo+ID4geW91ciBmYXVs
dCBvciBmYXVsdCBvZiB5b3VyIGJvYXJkLCBidXQgaXQganVzdCBwcmV2ZW50cyB0ZXN0aW5nIDot
KC4NCj4gDQo+IEkgaGF2ZSBhcHBsaWVkIHRoZSBlbnRpcmUgc2VyaWVzIGFuZCBpdCBidWlsZHMg
ZmluZSBpbiBteSBlbnZpcm9ubWVudCB3aXRoIGxpbnV4LTQuMTkueS1jaXAoNC4xOS4xMzgtY2lw
MzIpLg0KPiBXaGF0IGlzIHRoZSBidWlsZCBpc3N1ZSByZWxhdGVkIHRvIGdpdGxhYiB0ZXN0aW5n
Pw0KPiANCkFzIEkgd3JpdGUgb3RoZXIgbWFpbCwgdGhpcyBzZWVtcyB0byBiZSBhIGlzc3VlIGlu
IHRoZSBlbnZpcm9ubWVudCB0aGF0IHJ1bnMgZ2l0bGFiIHJ1bm5lci4NCg0KPiBDaGVlcnMsDQo+
IEJpanUNCj4gDQoNCkJlc3QgcmVnYXJkcywNCiAgTm9idWhpcm8NCg0KPiANCj4gUmVuZXNhcyBF
bGVjdHJvbmljcyBFdXJvcGUgR21iSCwgR2VzY2hhZWZ0c2Z1ZWhyZXIvUHJlc2lkZW50OiBDYXJz
dGVuIEphdWNoLCBTaXR6IGRlciBHZXNlbGxzY2hhZnQvUmVnaXN0ZXJlZCBvZmZpY2U6DQo+IER1
ZXNzZWxkb3JmLCBBcmNhZGlhc3RyYXNzZSAxMCwgNDA0NzIgRHVlc3NlbGRvcmYsIEdlcm1hbnks
IEhhbmRlbHNyZWdpc3Rlci9Db21tZXJjaWFsIFJlZ2lzdGVyOiBEdWVzc2VsZG9yZiwgSFJCIDM3
MDgNCj4gVVN0LUlETnIuL1RheCBpZGVudGlmaWNhdGlvbiBuby46IERFIDExOTM1MzQwNiBXRUVF
LVJlZy4tTnIuL1dFRUUgcmVnLiBuby46IERFIDE0OTc4NjQ3DQo=

--rI30mZPHaON4f2me112E
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5277): https://lists.cip-project.org/g/cip-dev/message=
/5277
Mute This Topic: https://lists.cip-project.org/mt/76426354/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--rI30mZPHaON4f2me112E--
