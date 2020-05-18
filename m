Return-Path: <SRS0=PNny=7A=lists.cip-project.org=bounce+64572+4624+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65A98C433E0
	for <cip-dev@archiver.kernel.org>; Mon, 18 May 2020 06:37:38 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C694920787
	for <cip-dev@archiver.kernel.org>; Mon, 18 May 2020 06:37:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="POIDdWZ+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C694920787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4624+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id R1GWYY4521723xIkO7SrSdzA; Sun, 17 May 2020 23:37:37 -0700
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.155])
 by mx.groups.io with SMTP id smtpd.web12.36682.1589783854917304819
 for <cip-dev@lists.cip-project.org>;
 Sun, 17 May 2020 23:37:36 -0700
X-Received: by mo-csw.securemx.jp (mx-mo-csw1516) id 04I6bWJq020179; Mon, 18 May 2020 15:37:32 +0900
X-Iguazu-Qid: 34trDAmeJ2nWOahHQG
X-Iguazu-QSIG: v=2; s=0; t=1589783851; q=34trDAmeJ2nWOahHQG; m=cNHfjkrqAsgj1VprR2yHoRJ7Ji7bXnYp1IIsPqTFgcM=
X-Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
	by relay.securemx.jp (mx-mr1511) id 04I6bVvA027148;
	Mon, 18 May 2020 15:37:31 +0900
X-Received: from enc02.toshiba.co.jp ([61.202.160.51])
	by imx12.toshiba.co.jp  with ESMTP id 04I6bU3D025617;
	Mon, 18 May 2020 15:37:30 +0900 (JST)
X-Received: from hop101.toshiba.co.jp ([133.199.85.107])
	by enc02.toshiba.co.jp  with ESMTP id 04I6bUtu009282;
	Mon, 18 May 2020 15:37:30 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ANDMazRhLYoXXbyyDxWD2hMdQS1AQSivzpf1qPp7+TAK93toxkL9rPBdYU+5eoKR5NPECMepbhpDH5tXl6z/10RF/qRFy0AMUW9XW2bWG2oBUH043gD0dyfLE0YAPl31aocs0t4LY5jnE4rV6wNhazS51i8HeCOzJC0LHgQv3m8UzxHjoUA+yse9lpQ/8H1/0ImuNMEPaeTCpxtdlHeID3iBCWsQLvvznu7ZqErYjuRAc8WUUL6+ri3ywMGwxPUULqlt0GYUbbu1/hwcY3KIQnqhAI20m2SlnElnbf29jrm+3qATHNV8NEq8TG64z66B+MEl7cmqVhsJARtifVrXnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mdwmXHTDT8FxsXdMpOYTfQc03rUkRovym4dIahqExTw=;
 b=Kku7uD3JcoanOeQkf4RMeRPDtsYH/0GVsZKykE4Zm2IsrtPnQv7LvsGtRtgd3rG62AoJ7AavjVtPLtA/Gx4Ug8SqMifmeGZBHjgUlhcr7QsQPLOWa2IafSXa6VfNyveVIplT4yYOh86JpsgIagePZ2ylzlwjiUGX0Tx3afXlvVKGitExkXH6aLAJzknr7NLG+1bfUbu6WYt+p5J+JoRNm7ztk5+DptZOtg+AGqFSe8Y8eJ1zy5AbvuVrw1XyMgU3OTFGyu6MFH9dGjRudIP2OvyAsQdqXm4C1YMSh2Mv0rz3Rg1rC4XstB6Et81L0oKjpjjKmNyiWi0XujqFGyKxTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: "Daniel Sangorrin" <daniel.sangorrin@toshiba.co.jp>
To: <dinesh.kumar@toshiba-tsip.com>, <jan.kiszka@siemens.com>,
        <Chris.Paterson2@renesas.com>
CC: <cip-dev@lists.cip-project.org>, <cip-security@lists.cip-project.org>
Subject: [cip-dev][isar-cip-core] Integration of test and security dependencies with cip-core
Thread-Topic: [cip-dev][isar-cip-core] Integration of test and security
 dependencies with cip-core
Thread-Index: AdYs0vpAUKy4cgndQaKwQlyaddtP7g==
Date: Mon, 18 May 2020 06:37:10 +0000
X-TSB-HOP: ON
Message-ID: <OSBPR01MB2053900CD653D4E5CD4278EAD0B80@OSBPR01MB2053.jpnprd01.prod.outlook.com>
Accept-Language: en-US
x-originating-ip: [103.91.184.6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c8d27f62-f425-4cb8-3a91-08d7faf5e4b7
x-ms-traffictypediagnostic: OSBPR01MB5285:
x-ld-processed: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f,ExtAddr
x-microsoft-antispam-prvs: <OSBPR01MB5285FF9315FE9AC4026FF338D0B80@OSBPR01MB5285.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: VsRmpTIi6IwIrpVqrMolXLO/ryA8UWpDw2iSuvBfqG+CTB+8JoRELPHIbP7A94DxLFzPwSYd2taVA032b1u63RyUtH6g29yOgD8+LptGoOcrsaby5XeTIac55+K4FXuXZD0yM3BnD0jmy8y76clrQjitwFo5N2AXIwhqHU4Gbtmxai+MvgyODyYbqpsuU3aWgUAMyJt0Xu6UlVBI/kVFxz5YyL2zDNteh3DmTIx6k28xY9pmIOLquTrvsa5+Zu1AkzLci0ERAcrQjag9I4hBw+0G/fCrcuKUBfu//rIt3Y53yEPzAQMf7rzMIu4bd1MDHDBIEJTv53xeSn8A/iw7Yn/Wr6SoKMpqljF+k8SUbfRqw2oIazCHNLBlV4KwXUb5XQyOTcpvyUaPI19/DuDiJF6fUs+6XYqgjOmOoRhAC5AJW8kALQIn1psK0/gabQKi15E0uSn5yl9DaA9zD86qz7joo/Eok7UB2A9LasQ3AfLyq2/YD/GDRwIgD+oaD9hnor7ay66gNY+BrWkSIz9tXA==
x-ms-exchange-antispam-messagedata: E6QPpeeSEjS/LnBtcmo3r4sjnVqLAFXDg8MAyEyNviG6huJyBKalyGVraSkAiyBLHKUh/RVNBJBK5exxjzyMe/gU+nffCEpnfNnCchJ38azyVW+ntYr8C66oq8noDmmC8sXsIOujVPRtNpXsLg5EuJFw+P051aqAe27nyck8YouvtrYrQGKPmYPL8zLyBc0QP/8k9ZUpExaDEf3UoieOPLGGaE3rivegaebY0EfQuIecoPbAJW5J2MTKL4Y3RgMx/3j63iZsSXW8RLPHFO+QvS1l1sMCMRYaQD6LROu0xEi6XOZb+aasLk/X1oyKBEtWXul8LC2XAg3QLqPF74JEtb28y+TUGeZhXSQoOOmb5OjL6n/wbyaOIo5JUZ8GtQLr2AXIGHVIxpDov9MNQVx8/ogoRK5qvPoIOamPTQulHkpOXt4R/7T30w+8Ut5bMyteJA7ixo0Qw09ZffjSJ5MMajoz+uM0mIWbXFgzsITmvC8=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: c8d27f62-f425-4cb8-3a91-08d7faf5e4b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2020 06:37:10.6160
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IPZJyOFvjdSbpURcAlyJbnH2rrjwqqqsXo+xQup7dXkiCqHrZXWILdkqlYOgxE9zbfVzKr1Lo0EI26qgacyQsL4p3zDXOS47BXjKfmISiA8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB5285
MSSCP.TransferMailToMossAgent: 103
X-OriginatorOrg: toshiba.co.jp
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: modrTTOFqtq6Xqwk5AKLcW4rx4520388AA=
Content-Type: multipart/mixed; boundary="r5YCsWPz2b8873VtAWHB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1589783857;
 bh=06hicYFQUEKb4imItxtlDXFT0XHQCwUPIKJjvSc4lSs=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=POIDdWZ+0clQV2D9GLpmA79QjjVI8W1OAkzIjy8hLKGajvSt4J2mRwSNsOaNa4FUHNL
 rVhUAAn+MPk4PeOR8tDpjcFlnFDNxyS4jV5sGrHPnGgPKxw3yfyBLS1etqJ76WvIMw5X5
 0N5WAriUnNXV/MLpH3F/qy4efL8b0/zVQ9k=

--r5YCsWPz2b8873VtAWHB
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGVsbG8gRGluZXNoLCBDaHJpcywgSmFuOg0KDQojIEJBQ0tHUk9VTkQNCg0KQXMgSSBtZW50aW9u
ZWQgaW4gb3VyIGxhc3QgdGVjaG5pY2FsIHN0ZWVyaW5nIGNvbW1pdGUgbWVldGluZywgb3VyIGdp
dGxhYi1jaSBzY3JpcHRzIHNob3VsZCBiZSBhYmxlIHRvIHByb2R1Y2UgbXVsdGlwbGUgT1MgaW1h
Z2VzLiBGb3IgZXhhbXBsZSwgdGhlIHRlc3RpbmcgdGVhbSBuZWVkcyB0byBoYXZlIHB5dGhvbiBh
bmQgcG9zc2libHkgb3RoZXIgc29mdHdhcmUgaW5jbHVkaW5nIHRoZSB0ZXN0cyB0aGVtc2hlbHZl
czsgYW5kIHRoZSBzZWN1cml0eSB0ZWFtIG5lZWRzIHRvIGhhdmUgZXh0cmEgcGFja2FnZXMgYW5k
IHByb2JhYmx5IGxvdHMgb2YgY3VzdG9taXphdGlvbnMuDQoNCiMgQ1VSUkVOVCBTVEFUVVMNCg0K
QXQgdGhlIG1vbWVudCB3ZSBoYXZlIHdoYXQgSSB3b3VsZCBjYWxsICJ0YXJnZXQgaW1hZ2VzIiwg
d2hpY2ggY29udGFpbjoNCg0KKiBzb21ldGhpbmcgY2xvc2UgdG8gd2hhdCBJIHdvdWxkIGNhbGwg
dGhlICJDSVAgQ29yZSBHZW5lcmljIHByb2ZpbGUiOiANCiAgICAqIHRoZSBJU0FSIGNvcmUgcGFj
a2FnZXMNCiAgICAgICAgKiBJIHRoaW5rIHRoZXNlIGFyZSBiYXNpY2FsbHkgZGVib290c3RyYXAg
bWluYmFzZSAoaXNhci9tZXRhL3JlY2lwZXMtY29yZS9pc2FyLWJvb3RzdHJhcCkNCiAgICAqIHNv
bWUgZXh0cmEgY3VzdG9taXphdGlvbnMNCiAgICAgICAgKiBodHRwczovL2dpdGxhYi5jb20vY2lw
LXByb2plY3QvY2lwLWNvcmUvaXNhci1jaXAtY29yZS8tL3RyZWUvbWFzdGVyL3JlY2lwZXMtY29y
ZS8NCiogdGFyZ2V0LWRlcGVuZGVudCBwYWNrYWdlcyAoa2VybmVsLCB1LWJvb3QsIGZpcm13YXJl
LCBldGMpDQogICAgKiB0aGVzZSBhcmUgYWRkZWQgdXNpbmcgS0FTIG9wdC55YW1sIHN5bnRheCwg
aW5zdGVhZCBvZiB1c2luZyBhIG1ldGEtbGF5ZXINCiogb3B0aW9ucw0KICAgICogb3B0LXJ0OiB3
aWxsIHVzZSBhIGtlcm5lbCB3aXRoIFBSRUVNUFQtUlQgcGF0Y2gNCiAgICAqIG9wdC1zdHJldGNo
OiB3aWxsIHVzZSBzdHJldGNoIGFzIGRpc3Rybw0KICAgICogb3B0LTQuNDogd2lsbCB1c2Uga2Vy
bmVsIHY0LjQgaW5zdGVhZCBvZiB0aGUgZGVmYXVsdCA0LjEwDQogICAgKiBvcHQtdGFyZ3otaW1n
OiBleHBvcnRzIHRoZSBpbWFnZSBhcyBhIHRhcmJhbGwgZm9yIExBVkENCg0KT24gdGhlIGJyYW5j
aCwgaWVjLWV2YWx1YXRpb24gdGhlcmUgaXMgYW4gaW5pdGlhbCBpbXBsZW1lbnRhdGlvbiBvZiB0
aGUgc2VjdXJpdHkgaW1hZ2U6DQogICAgKiBodHRwczovL2dpdGxhYi5jb20vY2lwLXByb2plY3Qv
Y2lwLWNvcmUvaXNhci1jaXAtY29yZS8tL3RyZWUvc2VjdXJpdHkvaWVjLWV2YWx1YXRpb24NCiAg
ICAqIGF0IGZpcnN0IHRoZXkgYWRkZWQgYW4gb3B0LXNlY3VyaXR5LnlhbWwgZmlsZToNCiAgICAg
ICAgKiBodHRwczovL2dpdGxhYi5jb20vY2lwLXByb2plY3QvY2lwLWNvcmUvaXNhci1jaXAtY29y
ZS8tL2NvbW1pdC9hODIxNmQ0Y2E1ZWVkNGQ3M2RmZjJlMDA2MDFkZWE3YzlkNzMzZjQ1DQogICAg
KiB0aGVuIHRoZXkgY2hhbmdlZCB0byB1c2UgcmVjaXBlcy1jb3JlL2ltYWdlcy9jaXAtY29yZS1p
bWFnZS1zZWN1cml0eS5iYiB0aGF0IGV4dGVuZHMgSU1BR0VfUFJFSU5TVEFMTA0KICAgICAgICAq
IGh0dHBzOi8vZ2l0bGFiLmNvbS9jaXAtcHJvamVjdC9jaXAtY29yZS9pc2FyLWNpcC1jb3JlLy0v
Y29tbWl0LzM0NjFhNTAyOTdlMzcwMjEwZDc2ZDg1ZDQzNGZiNjI1YzhjNDI0OGMNCiAgICAqIHNl
ZSB0aGUgb3JpZ2luYWwgdGhyZWFkIGhlcmU6DQogICAgICAgICogaHR0cHM6Ly9sb3JlLmtlcm5l
bC5vcmcvY2lwLWRldi9UWVhQUjAxTUIxODA4MTdDODgzRjg3NEIzMjFEQkEyNjRFMUZEMEBUWVhQ
UjAxTUIxODA4LmpwbnByZDAxLnByb2Qub3V0bG9vay5jb20vVC8jbTc1MmExMTZkODM3MjIyMmQ3
Mjc3MjJmNGZlMThjYTE5ZDk0ODM4ZWINCg0KIyBNWSBQUk9QT1NBTA0KDQpNeSBwcm9wb3NhbCBh
cyB0aGUgbmV4dCB0YXNrIGZvciB0aGUgQ0lQIENvcmUgd29yayBncm91cCBpcyB0byBhZGQgbWV0
YWRhdGEgZm9yIHJlbGVhc2luZyB0aGVzZSBpbWFnZXM6DQoNCiogdGFyZ2V0IGltYWdlczogaXNh
ciBkZWJvb3RzdHJhcCArIGN1c3RvbWl6YXRpb25zICsga2VybmVsL3UtYm9vdC9mdw0KICAgICog
W05FV10gcmVsZWFzZSB0aGVtIGFzIGJtYXAgaW1hZ2VzIGZvciBvdXIgcmVmZXJlbmNlIGhhcmR3
YXJlIGJvYXJkcw0KICAgICogW05FV10gY3JlYXRlIGEgcGFnZSAoZ2l0bGFiIHdpa2kpIHRoYXQg
d2lsbCBjb250YWluIGxpbmtzIHRvIHRoZSBsYXRlc3QgaW1hZ2VzIGFuZCBob3ctdG8taW5zdGFs
bCByZWFkbWVzIGZvciBlYWNoIHJlZmVyZW5jZSBib2FyZA0KICAgICogW05FV10gcmVmZXIgdG8g
dGhhdCBwYWdlIGZyb20gdGhlIENJUCB3aWtpIHBhZ2UgKGh0dHBzOi8vd2lraS5saW51eGZvdW5k
YXRpb24ub3JnL2NpdmlsaW5mcmFzdHJ1Y3R1cmVwbGF0Zm9ybS9jaXB0ZXN0aW5nL2NpcHJlZmVy
ZW5jZWhhcmR3YXJlKQ0KKiBbTkVXXSB0ZXN0aW5nIGltYWdlczogdGFyZ2V0IGltYWdlcyArIHRl
c3QgZGVwZW5kZW5jaWVzDQogICAgKiByZWxlYXNlIHRoZW0gdXNpbmcgb3B0LXRhcmd6LWltZyBz
byB0aGV5IGNhbiBiZSB1c2VkIGluIExBVkENCiAgICAqIGFkZCB0aGUgdGVzdCBkZXBlbmRlbmNp
ZXMNCiAgICAgICAgKiBwYWNrYWdlczogcHl0aG9uMi43LCBweXRob24zLCAuLi4NCiAgICAgICAg
KiB0ZXN0czogTFRQLCAuLi4NCiAgICAgICAgICAgICogbWV0aG9kIDE6IGJ1aWxkIHRoZW0gb24g
YSBzZXBhcmF0ZSByZXBvIGFuZCBpbmNsdWRlIGluIHRoZSBpbWFnZQ0KICAgICAgICAgICAgKiBt
ZXRob2QgMjogYnVpbGQgdGhlbSB3aXRoIElTQVIgKG5ldyByZWNpcGVzKSBhbmQgaW5jbHVkZSBp
biB0aGUgaW1hZ2UNCiAgICAgICAgICAgICogbWV0aG9kIDM6IHRoZSBhcnRpZmFjdHMgYXJlIGRv
d25sb2FkZWQgYnkgTEFWQSA8LS0gTXkgcHJlZmVyZW5jZQ0KICAgICAgICAqIEhvdyB0byBpbXBs
ZW1lbnQgdGhpcw0KICAgICAgICAgICAgKiBtZXRob2QgMTogdXNpbmcgdGhlIG9wdCB5YW1sIGZv
cm1hdCA8LS0gTXkgcHJlZmVyZW5jZSBpZiB3ZSBvbmx5IG5lZWQgdG8gc3BlY2lmeSBwYWNrYWdl
cw0KICAgICAgICAgICAgKiBtZXRob2QgMjogY3JlYXRpbmcgYSBzZXBhcmF0ZSBtZXRhIGxheWVy
DQogICAgICAgICAgICAqIG1ldGhvZCAzOiB1c2luZyBhIG5ldyBpbWFnZSAoY2lwLWNvcmUtaW1h
Z2UtdGVzdGluZy5iYikNCiogW05FV10gc2VjdXJpdHk6IHRhcmdldCArIHNlY3VyaXR5IHBhY2th
Z2VzICsgc2VjdXJpdHkgdGVzdHMgYW5kIGRlcGVuZGVuY2llcw0KICAgICogcmVsZWFzZSBpbiB0
d28gZm9ybWF0cw0KICAgICAgICAqIHVzaW5nIG9wdC10YXJnei1pbWcgc28gdGhleSBjYW4gYmUg
dXNlZCBpbiBMQVZBDQogICAgICAgICogYXMgaW1hZ2VzIGZvciBvdXIgcmVmZXJlbmNlIGhhcmR3
YXJlIGJvYXJkcw0KICAgICAgICAgICAgKiBhZGQgdG8gdGhlIGdpdGxhYiB3aWtpIGxpbmtzIHRv
IHRoZSBsYXRlc3QgaW1hZ2VzIGFuZCBob3ctdG8taW5zdGFsbCByZWFkbWVzIHRvbw0KICAgICog
SG93IHRvIGltcGxlbWVudCB0aGlzDQogICAgICAgICogbWV0aG9kIDE6IHVzaW5nIHRoZSBvcHQg
eWFtbCBmb3JtYXQNCiAgICAgICAgKiBtZXRob2QgMjogY3JlYXRpbmcgYSBzZXBhcmF0ZSBtZXRh
IGxheWVyIDwtLSBNeSBwcmVmZXJlbmNlIGlmIGl0IGdldHMgY29tcGxleA0KICAgICAgICAqIG1l
dGhvZCAzOiB1c2luZyBhIG5ldyBpbWFnZSAoY2lwLWNvcmUtaW1hZ2Utc2VjdXJpdHkuYmIpIDwt
LSBDdXJyZW50IG1ldGhvZA0KDQojIEZFRURCQUNLDQoNClBsZWFzZSBjaGVjayBteSBpbml0aWFs
IHByb3Bvc2FsIGFuZCBzZW5kIG1lIGZlZWRiYWNrLg0KDQpUaGFua3MsDQpEYW5pZWwgU2FuZ29y
cmluDQoNCg0KDQoNCg==

--r5YCsWPz2b8873VtAWHB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4624): https://lists.cip-project.org/g/cip-dev/message=
/4624
Mute This Topic: https://lists.cip-project.org/mt/74286250/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--r5YCsWPz2b8873VtAWHB--
