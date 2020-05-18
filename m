Return-Path: <SRS0=0uHO=7A=lists.cip-project.org=bounce+64572+4629+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB4CCC433DF
	for <cip-dev@archiver.kernel.org>; Mon, 18 May 2020 13:15:20 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4817720674
	for <cip-dev@archiver.kernel.org>; Mon, 18 May 2020 13:15:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="p4lMfF6n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4817720674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4629+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id ih0wYY4521723xg90jKv8ZeG; Mon, 18 May 2020 06:15:19 -0700
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.155])
 by mx.groups.io with SMTP id smtpd.web10.41708.1589807717066472476
 for <cip-dev@lists.cip-project.org>;
 Mon, 18 May 2020 06:15:18 -0700
X-Received: by mo-csw.securemx.jp (mx-mo-csw1516) id 04IDFEfd022234; Mon, 18 May 2020 22:15:14 +0900
X-Iguazu-Qid: 34trWq5axPjMKxy4yO
X-Iguazu-QSIG: v=2; s=0; t=1589807713; q=34trWq5axPjMKxy4yO; m=GtwKVB4JeHBNLC3HE5XjrIPL8TDkUwj7oxg80kSO8PU=
X-Received: from imx2.toshiba.co.jp (imx2.toshiba.co.jp [106.186.93.51])
	by relay.securemx.jp (mx-mr1512) id 04IDFCnS026395;
	Mon, 18 May 2020 22:15:13 +0900
X-Received: from enc01.localdomain ([106.186.93.100])
	by imx2.toshiba.co.jp  with ESMTP id 04IDFCJs014342;
	Mon, 18 May 2020 22:15:12 +0900 (JST)
X-Received: from hop001.toshiba.co.jp ([133.199.164.63])
	by enc01.localdomain  with ESMTP id 04IDFCvd025081;
	Mon, 18 May 2020 22:15:12 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FxqvHp4ozyQeDJVfuVs7BS3IHKIzvUP9MZGtMCkFhrtCCgjwolZxSpfVCkn04wuf0yJ8k+mex5bFyY1Btb2I6nzexMOryDOd3wSoPC52HMmsuxxLNib0pKus02m41FYN+E3KSXJGLGgZ+Q2duiiDhmSnr6P/c7JGhCWM+QoscT7GO9ALeg9eGcqMhUoeUASvCFHS/c38LlwgrpINJbIbcTIlqU46c7HbmEIYiNi4uJVakXNiYcA0Ams/mYoPqkF4v4zuBlVUvZ5PnuYgGIRPV9+TaeZdRNXL+gz3ySp5HT4evWVIlev2/TWkznQFO6efNmHQ1tUtz7nuW9ACGs6ehA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WgqoDfDVrCiXiwZPfFQrv5rJF4etjiS1+I2vPKWLOXY=;
 b=cvRuzZQieBbBPG/agZKfoJ+3Q1YTwJx3bDrdiP6MMQFbXMrVbKXekj9jrm6Ho5b05cb+fjtYSYIyXqjMJrbgfrj6/Jt3CmwUJucQIVAMJIC93DAmRgx/OROza9a6X1miwmO5pKmtkZVgTsSvom+cAaXQlPz0FTZQgChJd8f9hNEXOnH+b8BNtCdOzOBH3YeRLfBnet2i3WsFjTGCVZ/fT+hxzeb6etAZPc/dhD62WO8FoeuCHMdOADQAIcKHoghWf5hzQGvGmEsW+KpE/6Ytu3NAAKIrrY1PmZ9yuVLBUdLl0O8astY26Sew3Q1BtXCVx9CgrB5Z0m4ONbOlzhvDJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: "Daniel Sangorrin" <daniel.sangorrin@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>, <dinesh.kumar@toshiba-tsip.com>,
        <Chris.Paterson2@renesas.com>, <quirin.gylstorff@siemens.com>
CC: <cip-security@lists.cip-project.org>
Subject: Re: [cip-dev][isar-cip-core] Integration of test and security dependencies with cip-core
Thread-Topic: [cip-dev][isar-cip-core] Integration of test and security
 dependencies with cip-core
Thread-Index: AdYs0vpAUKy4cgndQaKwQlyaddtP7gAEPUoAAAtiQnA=
Date: Mon, 18 May 2020 13:15:10 +0000
X-TSB-HOP: ON
Message-ID: <OSBPR01MB2053DB98FF0A1FBA49CC2652D0B80@OSBPR01MB2053.jpnprd01.prod.outlook.com>
References: <OSBPR01MB2053900CD653D4E5CD4278EAD0B80@OSBPR01MB2053.jpnprd01.prod.outlook.com>
 <52a7bbd6-1d6a-53e9-6e17-f6516f374060@siemens.com>
In-Reply-To: <52a7bbd6-1d6a-53e9-6e17-f6516f374060@siemens.com>
Accept-Language: en-US
x-originating-ip: [103.91.184.0]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6b938e70-1c4a-4d91-5b30-08d7fb2d7e4c
x-ms-traffictypediagnostic: OSBPR01MB4949:
x-ld-processed: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f,ExtAddr
x-microsoft-antispam-prvs: <OSBPR01MB494917F00F5E38D5C93E7199D0B80@OSBPR01MB4949.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: v9Jz+Rm/jm0lnFxcFQnETSI4u/k56zzfTOa/SiyH0t14FKfGCmxEyWnIj9+IAKDTvfFPil46O7Whj7ekqlXG24GKL6XSzOxwsueLfZQQfy6bm9sSA1BWjlPgI0TC8BowRRV8s9e6Z25i72dtLxRGtrC/2ugAC8xxFEz8poQgDmVzvnA+9+ySQTX0KF4nwRClNreVi/Dw0GrswkOF79D3is8LLP/0zZuzf0/e06G2vvljAj2iqbuhRAYyoTUjsYi3qtjyvphKAvYhTjqxxwb8Qg3EY7yzN7Plx+PZW1rOAzjsApWrIDGMJf36OXDKHUp4FkoXAq5xTby/D426UrRK4yrmBOVWrkalzUllWbc9LRNaC5koJ3dI0quxkzieFuxb+IKAnVsQq0LJ7obEAxYDopHHcrxK4IibvN8R/l48a/BLmfV/SxCznqp0/j7P59SW4XUtgMxTJcHFi7b/TmLOyJEVb0TtsfEDn0Vbo7PsOJg=
x-ms-exchange-antispam-messagedata: JuUOLzSAqSblUDxgnXCMIYn2uH+6Dmus1iErxkyoNay1exUNYDAYqLqOyJjr8GGBLsrPF+NWiD8F/TnYNQZhLhqsszAFJ+CT7xFsWnxN5lp44VE6IxP7pvQMDnZFCTX/ve0sFE2QqRKd45iSRjvLyoMtd2zAv8vTBOItwd1k/fple6wKQdP9DrOFechw1nT0dnBiYkLStySQNLuRMcelPDqUt4vOBdgP8Mrc8ZIB506x8eQokJyBQo1BtXMySjLP/+kDY3X82vSF9vd3aHZHuAUWLz/E3K3xPud1EfF6BUQbMu7pTKY5mWd/oNTq/raGvbH1GyE6h4hT7XHG8asLv0jPx/hB9ldNw7jDloI6jpjB8p+WFfac02WiE1tj8a4u++GVd+43UcIlEFQ2lN5C/AyHzamueORrG5nG1zS1gaCtuwasz0dycCdrgUvisroRSQs/x7VZRC3zZ8XkgodGz3L+TyPmFLi3LNexvsj/S9I=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b938e70-1c4a-4d91-5b30-08d7fb2d7e4c
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2020 13:15:10.5319
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GRd+4jgsVxrU6eADcvfSElsRRjPjyCZW6WIR6f8gbh53VuiYEPJA6OhMnivkDKI332SuY1zWwOzJPAKEJEvlXUQFNbkbTIdU56re8EErB9k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB4949
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: PU88z7ZqvLiFy1DFALP7XYc1x4520388AA=
Content-Type: multipart/mixed; boundary="iUNPdWkLYJK0LJgTVDXK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1589807719;
 bh=bZFHMD1mvGyTeFh2rwVPMEfCnlEgv0/GciRDxUONGpc=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=p4lMfF6n8Fmo0fbHdwNtCoqsM3lOkDVdpRRdTbeXRPdB6gn/mQyDKq+SU9Antbx6tOA
 bc1SRB0PawkSqRHB7eH0iQbCztKINOCzy+RZxsM1D1MdtywVBGf/bWgfwRluhxi2M/5/5
 e9Cm7S91o44bL4L9DUTGy3J8cMhJwTGiWOs=

--iUNPdWkLYJK0LJgTVDXK
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGkgSmFuLCB0aGFua3MgZm9yIHlvdXIgZmVlZGJhY2suIFNvbWUgY29tbWVudHMgaW5saW5lDQoN
Cj4gRnJvbTogY2lwLWRldkBsaXN0cy5jaXAtcHJvamVjdC5vcmcgPGNpcC1kZXZAbGlzdHMuY2lw
LXByb2plY3Qub3JnPiBPbiBCZWhhbGYgT2YgSmFuIEtpc3prYQ0KPiA+ICogW05FV10gdGVzdGlu
ZyBpbWFnZXM6IHRhcmdldCBpbWFnZXMgKyB0ZXN0IGRlcGVuZGVuY2llcw0KPiA+ICAgICAgKiBy
ZWxlYXNlIHRoZW0gdXNpbmcgb3B0LXRhcmd6LWltZyBzbyB0aGV5IGNhbiBiZSB1c2VkIGluIExB
VkENCj4gPiAgICAgICogYWRkIHRoZSB0ZXN0IGRlcGVuZGVuY2llcw0KPiA+ICAgICAgICAgICog
cGFja2FnZXM6IHB5dGhvbjIuNywgcHl0aG9uMywgLi4uDQo+ID4gICAgICAgICAgKiB0ZXN0czog
TFRQLCAuLi4NCj4gPiAgICAgICAgICAgICAgKiBtZXRob2QgMTogYnVpbGQgdGhlbSBvbiBhIHNl
cGFyYXRlIHJlcG8gYW5kIGluY2x1ZGUgaW4gdGhlIGltYWdlDQo+ID4gICAgICAgICAgICAgICog
bWV0aG9kIDI6IGJ1aWxkIHRoZW0gd2l0aCBJU0FSIChuZXcgcmVjaXBlcykgYW5kIGluY2x1ZGUg
aW4gdGhlIGltYWdlDQo+ID4gICAgICAgICAgICAgICogbWV0aG9kIDM6IHRoZSBhcnRpZmFjdHMg
YXJlIGRvd25sb2FkZWQgYnkgTEFWQSA8LS0gTXkgcHJlZmVyZW5jZQ0KPiANCj4gMSBvciAyLiBX
ZSBjYW4gc3RhcnQgd2l0aCAyIGFuZCBmYWN0b3Igb3V0IDEgd2hlbiBpdCBiZWNvbWVzIHRvbyBs
YXJnZS4NCj4gDQo+IFlvdSBkbyBub3Qgd2FudCB0byBjcmVhdGUgdGhlIHRlc3RlZCBpbWFnZSBv
bmx5IGluIGxhdmEgIm9uIHRoZSBmbHkiLA0KPiB5b3Ugd2FudCB0aGF0IGxvY2FsbHkgYXMgd2Vs
bC4NCg0KT0ssIEkgd2FzIGFzc3VtaW5nIHRoYXQgd2Ugb25seSB3YW50ZWQgdG8gdGVzdCBpbiBM
QVZBLiBJbiB0aGF0IGNhc2UsIHdlIHNob3VsZCBhbHNvIGNyZWF0ZSBhIGxpbmsgdG8gdGhlIGxh
dGVzdCB0ZXN0aW5nIGltYWdlcyBmb3IgcGVvcGxlIHRvIGRvd25sb2FkLg0KDQo+ID4gICAgICAg
ICAgKiBIb3cgdG8gaW1wbGVtZW50IHRoaXMNCj4gPiAgICAgICAgICAgICAgKiBtZXRob2QgMTog
dXNpbmcgdGhlIG9wdCB5YW1sIGZvcm1hdCA8LS0gTXkgcHJlZmVyZW5jZSBpZiB3ZSBvbmx5IG5l
ZWQgdG8gc3BlY2lmeSBwYWNrYWdlcw0KPiA+ICAgICAgICAgICAgICAqIG1ldGhvZCAyOiBjcmVh
dGluZyBhIHNlcGFyYXRlIG1ldGEgbGF5ZXINCj4gPiAgICAgICAgICAgICAgKiBtZXRob2QgMzog
dXNpbmcgYSBuZXcgaW1hZ2UgKGNpcC1jb3JlLWltYWdlLXRlc3RpbmcuYmIpDQo+IA0KPiBEZWZp
bmUgYSB0ZXN0IGltYWdlLCB0aGF0IGlzIGNsZWFuZXN0LiBJdCBzaGFsbCBiZSBkZXJpdmVkIGZy
b20gdGhlIGJhc2UNCj4gaW1hZ2UgYW5kIGNvbnRhaW4gYWxsIHBhY2thZ2VzIG5lZWRlZCBmb3Ig
dGVzdGluZy4gV2UgZG8gdGhpcyBpbnRlcm5hbGx5DQo+IGFzIHdlbGwuIA0KDQpPSywgdGhhdCBz
b3VuZHMgbGlrZSB0aGUgbWV0aG9kIDMgd2hpY2ggaXMgdGhlIHNhbWUgYXMgd2hhdCB3ZSBjdXJy
ZW50bHkgZG8gaW4gdGhlIHNlY3VyaXR5IGJyYW5jaCAoY2lwLWNvcmUtaW1hZ2Utc2VjdXJpdHku
YmIgaW5oZXJpdHMgdGhlIG1pbmltYWwgaW1hZ2UpLg0KDQo+IFRoYXQgaW1hZ2UgaXMgc2VsZWN0
ZWQgYnkgYSBrYXMgb3B0aW9uOiBvcHQtdGFyZ3otaW1nIGNvdWxkDQo+IGJlY29tZSBvcHQtbGF2
YS1pbWcgb3Igc28uDQoNClNvbWV0aGluZyBsaWtlIHRoaXM/DQogICQgLi9rYXMtZG9ja2VyIC0t
aXNhciBidWlsZCBrYXMueW1sOmJvYXJkLXh4eC55bWw6b3B0LXRlc3Rpbmc6b3B0LWxhdmEtaW1n
DQpXaGVyZSBJDQogICAqIGNoYW5nZWQgYWRkZWQgYSBuZXcgb3B0aW9uIGNhbGxlZCBvcHQtdGVz
dGluZy55bWwNCiAgICogcmVuYW1lZCBvcHQtdGFyZ3otaW1nLnlhbWwgdG8gb3B0LWxhdmEtaW1n
LnltbA0KDQpUaHdyZSBpcyBhbHNvIHRoaXMgb3B0aW9uIEkgdGhpbms6DQokIC4va2FzLWRvY2tl
ciAtLWlzYXIgYnVpbGQgLS10YXJnZXQgY2lwLWNvcmUtaW1hZ2UtdGVzdGluZyBrYXMueW1sOmJv
YXJkLXh4eC55bWw6b3B0LWxhdmEtaW1nDQpXaGVyZSBJDQogICAqIGNoYW5nZWQgdGhlIHRhcmdl
dCB0byBjaXAtY29yZS1pbWFnZS10ZXN0aW5nDQogICAqIHJlbmFtZWQgb3B0LXRhcmd6LWltZy55
YW1sIHRvIG9wdC1sYXZhLWltZy55bWwNCg0KPiA+ICogW05FV10gc2VjdXJpdHk6IHRhcmdldCAr
IHNlY3VyaXR5IHBhY2thZ2VzICsgc2VjdXJpdHkgdGVzdHMgYW5kIGRlcGVuZGVuY2llcw0KPiA+
ICAgICAgKiByZWxlYXNlIGluIHR3byBmb3JtYXRzDQo+ID4gICAgICAgICAgKiB1c2luZyBvcHQt
dGFyZ3otaW1nIHNvIHRoZXkgY2FuIGJlIHVzZWQgaW4gTEFWQQ0KPiANCj4gb3B0LWxhdmEtaW1n
IC0+IHNlbGVjdCB0ZXN0IGltYWdlICh3aXRoIGV4dHJhIHBhY2thZ2VzKSwgc3dpdGNoIG91dHB1
dA0KPiBmb3JtYXQuDQoNCk1tbSB5b3VyIGNvbW1lbnQgaXMgYSBiaXQgY3J5cHRpYyBmb3IgbWUu
IEkgd2FzIHRoaW5raW5nIGFib3V0IHNvbWV0aGluZyBsaWtlIHRoaXM6DQokIC4va2FzLWRvY2tl
ciAtLWlzYXIgYnVpbGQga2FzLnltbDpib2FyZC14eHgueW1sOm9wdC1zZWN1cml0eQ0KW0FsdF0g
JCAuL2thcy1kb2NrZXIgLS1pc2FyIGJ1aWxkIC0tdGFyZ2V0IGNpcC1jb3JlLWltYWdlLXNlY3Vy
aXR5IGthcy55bWw6Ym9hcmQteHh4LnltbA0KJCAuL2thcy1kb2NrZXIgLS1pc2FyIGJ1aWxkIGth
cy55bWw6Ym9hcmQteHh4LnltbDpvcHQtc2VjdXJpdHk6b3B0LWxhdmEtaW1nDQpbQWx0XSAkIC4v
a2FzLWRvY2tlciAtLWlzYXIgYnVpbGQgLS10YXJnZXQgY2lwLWNvcmUtaW1hZ2Utc2VjdXJpdHkg
a2FzLnltbDpib2FyZC14eHgueW1sOm9wdC1sYXZhLWltZw0KDQo+ID4gICAgICAgICAgKiBhcyBp
bWFnZXMgZm9yIG91ciByZWZlcmVuY2UgaGFyZHdhcmUgYm9hcmRzDQo+ID4gICAgICAgICAgICAg
ICogYWRkIHRvIHRoZSBnaXRsYWIgd2lraSBsaW5rcyB0byB0aGUgbGF0ZXN0IGltYWdlcyBhbmQg
aG93LXRvLWluc3RhbGwgcmVhZG1lcyB0b28NCj4gPiAgICAgICogSG93IHRvIGltcGxlbWVudCB0
aGlzDQo+ID4gICAgICAgICAgKiBtZXRob2QgMTogdXNpbmcgdGhlIG9wdCB5YW1sIGZvcm1hdA0K
PiA+ICAgICAgICAgICogbWV0aG9kIDI6IGNyZWF0aW5nIGEgc2VwYXJhdGUgbWV0YSBsYXllciA8
LS0gTXkgcHJlZmVyZW5jZSBpZiBpdCBnZXRzIGNvbXBsZXgNCj4gDQo+IFNvbWV0aGluZyBmb3Ig
bGF0ZXIuIEF0IHRoaXMgc3RhZ2UsIGl0IHdpbGwgb25seSBpbmNyZWFzZSB0aGUgQ00gZWZmb3J0
Lg0KPiANCj4gPiAgICAgICAgICAqIG1ldGhvZCAzOiB1c2luZyBhIG5ldyBpbWFnZSAoY2lwLWNv
cmUtaW1hZ2Utc2VjdXJpdHkuYmIpIDwtLSBDdXJyZW50IG1ldGhvZA0KPiA+DQo+IA0KPiBBIG5l
dyBpbWFnZSByZWNpcGUgdG9nZXRoZXIgd2l0aCBhIG5ldyB0b3AtbGV2ZWwga2FzIGZpbGUgdG8g
c2VsZWN0IHRoZQ0KPiBpbWFnZSAtIGFuZCBsaWtlbHkgbW9yZS4gSSBjYW4gaW1hZ2luZSB0aGF0
IGEgc2VjdXJlIGNvcmUgaW1hZ2Ugd2lsbA0KPiBldmVudHVhbGx5IG5vdCBvbmx5IGFmZmVjdCB0
aGUgaW1hZ2UgcmVjaXBlIGJ1dCBhbHNvIGNvbmZpZ3VyYXRpb24NCj4gb3B0aW9ucyBvZiB0aGUg
YnVpbGQsIGZpbGVzeXN0ZW0sIHNlY3VyZSBib290IGV0Yy4gU28sIHNvbWV0aGluZyBsaWtlDQo+
IA0KPiAgIC0ga2FzLWNpcC1jb3JlLnltbA0KPiAgIC0ga2FzLWNpcC1zZWN1cmUueW1sDQoNCk9L
LCBJIHN1cHBvc2UgdGhhdCB3ZSBjYW4gc3RhcnQgd2l0aCBrYXMtY2lwLWNvcmUueW1sIGFuZCB3
aGVuIHRoZSBuZWVkIGFyaXNlcyBhZGQgYSBrYXMtY2lwLXNlY3VyZS55bWwuDQoNCj4gQWxsIHRo
YXQgc2FpZDogTm90aGluZyBuZWVkcyB0byBiZSBzZXQgaW4gc3RvbmUgdXBmcm9udC4gV2UgY2Fu
IGFkanVzdA0KPiB0aGUgbW9kZWxpbmcgYXMgdGhlIHVzYWdlIGV2b2x2ZXMgYW5kIHRoZSB2YXJp
YW50cyB0aHJlYXRlbiB0byBpbmNyZWFzZS4NCj4gQnV0IHNwZWNpZmljYWxseSBkdWUgdG8gdGhl
IGxhc3QgYXNwZWN0LCB0aGUgbWF0cml4IHNob3VsZCByZW1haW4gYXMNCj4gc21hbGwgYXMgcG9z
c2libGUuDQoNCk9LLCB0aGFua3MgZm9yIHlvdXIgZmVlZGJhY2suDQoNCkRhbmllbA0K

--iUNPdWkLYJK0LJgTVDXK
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4629): https://lists.cip-project.org/g/cip-dev/message=
/4629
Mute This Topic: https://lists.cip-project.org/mt/74286250/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--iUNPdWkLYJK0LJgTVDXK--
