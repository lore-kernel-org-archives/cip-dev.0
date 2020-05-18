Return-Path: <SRS0=+Op5=7A=lists.cip-project.org=bounce+64572+4630+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A4DDC433E0
	for <cip-dev@archiver.kernel.org>; Mon, 18 May 2020 13:25:54 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA8052065F
	for <cip-dev@archiver.kernel.org>; Mon, 18 May 2020 13:25:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="ohP6Gehd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA8052065F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4630+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id ia0cYY4521723xvV04Nvzx7p; Mon, 18 May 2020 06:25:53 -0700
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.157])
 by mx.groups.io with SMTP id smtpd.web12.41546.1589808301845573109
 for <cip-dev@lists.cip-project.org>;
 Mon, 18 May 2020 06:25:03 -0700
X-Received: by mo-csw.securemx.jp (mx-mo-csw1115) id 04IDOwKj023470; Mon, 18 May 2020 22:24:58 +0900
X-Iguazu-Qid: 2wHH6kkKqiwtiAqtn6
X-Iguazu-QSIG: v=2; s=0; t=1589808298; q=2wHH6kkKqiwtiAqtn6; m=l/HtvWeh7NAwy/AkE6/LwREjq7OOCyjqP5Nkn83gEF4=
X-Received: from imx2.toshiba.co.jp (imx2.toshiba.co.jp [106.186.93.51])
	by relay.securemx.jp (mx-mr1111) id 04IDOuFD004113;
	Mon, 18 May 2020 22:24:57 +0900
X-Received: from enc01.localdomain ([106.186.93.100])
	by imx2.toshiba.co.jp  with ESMTP id 04IDOuIw014929;
	Mon, 18 May 2020 22:24:56 +0900 (JST)
X-Received: from hop001.toshiba.co.jp ([133.199.164.63])
	by enc01.localdomain  with ESMTP id 04IDOu7O026267;
	Mon, 18 May 2020 22:24:56 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K6P6mKsLAMonFVhd7Cobp62sbuBazT4J7WNJZUe10zA13Q0AeeQPA7BxNUDlcfF0vEF2pNO92uTJ5CISSjsiC5GrgFJ0xZbj3FxqxKVcdbSq1+Mek4v0JvLEKeMacMD8715hfd8a05qZG0WbXfP3oNBvWq4/QzBE3jh2wyD8EnBFdI+ge+Q9qSs47tpnLYsThmx++AatCmEgUfCr4zo0uPNC0MhBb7qCZWAhDYkIKbWOSh4jAeELdmSb+V9baLVAqMclXYiCPTvn/Z1A/8zLgp2j9ve7j/FfvpMdlf1o/QCSUy58N6yzLbhOxPGk3o3It1rubdgekPGLFileNy79hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VqNzZdneos/kym0JrOpC60m2Lq2WyL/39X0pglNNVh0=;
 b=Hnbul8TspyTARE5sbA81BpHB9cR3iOWPsYexXckKI0x7X5ozuU2E1jlSWHJPW2OnCozNK7cVro5w1oG/5netn3BsFhJPCAdfHcgSwgbz/qUduTNkoc8lKVp6cyd/bc8lpRPfBxw/WxbphXhxlWGbP7c0L2Bkcd1hPnm9OKAbhQRVrCRVKZ8ccVMp7yjsUNwDlzquoGXIhESjjM/FPhGcNE+opDcS3mftTEZDoJtN9dEZZ4sDCALKpybp6qLFRJcClEAHgIE9Mg/h6NxhKuQrSyJosIhFOdBNeJuScpw0Py8xF4V3EaTMUqWudi1L28UzsRV+tbb/pQOuJ/nEKghtTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: "Daniel Sangorrin" <daniel.sangorrin@toshiba.co.jp>
To: <Chris.Paterson2@renesas.com>, <dinesh.kumar@toshiba-tsip.com>,
        <jan.kiszka@siemens.com>
CC: <cip-dev@lists.cip-project.org>, <cip-security@lists.cip-project.org>
Subject: Re: [cip-dev][isar-cip-core] Integration of test and security dependencies with cip-core
Thread-Topic: [cip-dev][isar-cip-core] Integration of test and security
 dependencies with cip-core
Thread-Index: AdYs0vpAUKy4cgndQaKwQlyaddtP7gAFtRAQAAsjwcA=
Date: Mon, 18 May 2020 13:24:53 +0000
X-TSB-HOP: ON
Message-ID: <OSBPR01MB205380D313DD13B8BB4A3086D0B80@OSBPR01MB2053.jpnprd01.prod.outlook.com>
References: <OSBPR01MB2053900CD653D4E5CD4278EAD0B80@OSBPR01MB2053.jpnprd01.prod.outlook.com>
 <OSAPR01MB2385B768C9B6FF689451C626B7B80@OSAPR01MB2385.jpnprd01.prod.outlook.com>
In-Reply-To: <OSAPR01MB2385B768C9B6FF689451C626B7B80@OSAPR01MB2385.jpnprd01.prod.outlook.com>
Accept-Language: en-US
x-originating-ip: [103.91.184.0]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 58bcf44a-8d8f-42ac-ab09-08d7fb2ed9ce
x-ms-traffictypediagnostic: OSBPR01MB2264:
x-ld-processed: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f,ExtAddr
x-microsoft-antispam-prvs: <OSBPR01MB2264E36B8F4C20220FE80B5DD0B80@OSBPR01MB2264.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Eug2GMLEesY5+0TcC5LSOe2QMdmt6duaH2Gsnrpu3zjp0k8rZlju39MxC1Vt/0PFyFRZCuQRMDFwzq4+XEWwUkRMYrbhs+jZmRmpuFH/rtYUkK7A9SIyzq8IkDROO22e9CE//DEFR5Z8tZtA40Ym1wS5Tth1rblKVlAyP1AEgp1VReUVHCiNx1npET1s9byflAV0zda2Wi+9EtHhtnVQ/bkMderj5d+69th25f5b3L0+/a07eiuTeYWGccFS7XWR/CMX401XlFotRQNqSs/8UthaaFpV1jKMtFls+aVYoY016z3rA5AooHzcE/DdaoseGoZuBtKqeHTn7IRzaHhen8I/Iy4XP+cyOKfxJQjiIeefEoQkHiykRYihZcaHdRXuOVAuBAXPvqVu4HYtZeJkkLBQF1N5Ci536yHI7HF/TUwExzCzjF/PGUR/5UsWEKbW
x-ms-exchange-antispam-messagedata: 3VEUHuOHy21Qk8/o4lN4C6UXj+NsDBiA9QJBCK0XUSlJuE3OfyW5h7qqGBIyH2rebx9ysM/V0RLFcek0tsKrLd6LC9TGl74Dv/5tMNpikP0uneUqdcWCRVYPKvqeN1mE+UBOIRPmir14tlxqign06K49eIAO+ykxa5Hu4gldYNTVXiQeCRuLIC6JK1piBSKHnifyHwgTC8VEnG5QpLNDduNoAsPjXBQWWcdWoPEknOGdDWk8Zaj0DwFxGFZXRAhVJIUVmz2n/2qpMQjhbh6wdOF9tHCfO1unrEPRU5pAw/iRhNjLJIQ4jXLGyGNr9aottRDkWP+ei/f/GJ8Y0kreITIoetPimT3lWBb8Xs+mn09Eb0kSURAyUPGO6CLG2aA0tFldNWVrGIBjV8QhEMrQRTX4ozINMoisELqwMvH9WKsnPX2Xe/ZUP2mcjfbJ4tLMovqN1zWKHMBH8RuUu8UldzXXHGlDXD3uaB5HtL4Qj0s=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 58bcf44a-8d8f-42ac-ab09-08d7fb2ed9ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2020 13:24:53.6312
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xUA6PduJBH4Zqi6Lq9hGw/Qhcis9ilNPbowL0O3B1TviZC/s842kx7QmWCGPEwz3WVvzyS2TVSA5kLvsx+KFM9dHNjm8cr+ojvydLOnBVXo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB2264
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: hxqysIgQzuknwB9eH3MrZRpQx4520388AA=
Content-Type: multipart/mixed; boundary="5b3ntEWEnDtfq3ucSb5V"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1589808353;
 bh=Hv/tqM2DNYPaxCJdG+3TOxrdW0NrWzWW5hDekRcTBbY=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=ohP6GehdYXlmi4AhizqRl/bb9lTMclE/elVY7m70C3SEWXYcLV0G7c8/nQaFB30AEls
 86qtrQwoPt7nMyIBYgp8RwMqq6cGzrechGvsqmJ/mfDvVu7VsGDpDRUFkx9BtX8ArbFfQ
 eh64ldrFI9+vrCvaEvsGaYjudfpUH3Y1kEU=

--5b3ntEWEnDtfq3ucSb5V
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGVsbG8gQ2hyaXMsIHRoYW5rcyBmb3IgeW91ciBmZWVkYmFjay4gU2VlIHRoZSBjb21tZW50cyBp
bmxpbmUuDQoNCj4gRnJvbTogQ2hyaXMgUGF0ZXJzb24gPENocmlzLlBhdGVyc29uMkByZW5lc2Fz
LmNvbT4NCj4gPiAqIFtORVddIHRlc3RpbmcgaW1hZ2VzOiB0YXJnZXQgaW1hZ2VzICsgdGVzdCBk
ZXBlbmRlbmNpZXMNCj4gPiAgICAgKiByZWxlYXNlIHRoZW0gdXNpbmcgb3B0LXRhcmd6LWltZyBz
byB0aGV5IGNhbiBiZSB1c2VkIGluIExBVkENCj4gPiAgICAgKiBhZGQgdGhlIHRlc3QgZGVwZW5k
ZW5jaWVzDQo+ID4gICAgICAgICAqIHBhY2thZ2VzOiBweXRob24yLjcsIHB5dGhvbjMsIC4uLg0K
PiA+ICAgICAgICAgKiB0ZXN0czogTFRQLCAuLi4NCj4gPiAgICAgICAgICAgICAqIG1ldGhvZCAx
OiBidWlsZCB0aGVtIG9uIGEgc2VwYXJhdGUgcmVwbyBhbmQgaW5jbHVkZSBpbiB0aGUgaW1hZ2UN
Cj4gPiAgICAgICAgICAgICAqIG1ldGhvZCAyOiBidWlsZCB0aGVtIHdpdGggSVNBUiAobmV3IHJl
Y2lwZXMpIGFuZCBpbmNsdWRlIGluIHRoZSBpbWFnZQ0KPiA+ICAgICAgICAgICAgICogbWV0aG9k
IDM6IHRoZSBhcnRpZmFjdHMgYXJlIGRvd25sb2FkZWQgYnkgTEFWQSA8LS0gTXkgcHJlZmVyZW5j
ZQ0KPiANCj4gQnkgImFydGlmYWN0cyIgZG8geW91IG1lYW50IHRoZSBlbnRpcmUgZmlsZXN5c3Rl
bT8gT3IganVzdCBpbmRpdmlkdWFsIHRlc3QgcGFja2FnZXMgZXRjLj8NCg0KSSBtZWFudCB0aGUg
aW5kaXZpZHVhbCB0ZXN0IGJpbmFyaWVzL3BhY2thZ2VzLiBUaGlzIGlzIHRoZSB3YXkgaXQncyBk
b25lIGluIExpbmFybyBBRkFJSy4NCiAgICAqIHVwc2lkZXM6DQogICAgICAgICogeW91IG9ubHkg
bmVlZCB0byBzdG9yZSBpdCBvbmNlLCBub3QgZm9yIGV2ZXJ5IGltYWdlDQogICAgICAgICogeW91
IG9ubHkgbmVlZCB0byBkb3dubG9hZCBvbmUgb2YgdGhlIHRlc3QgYXJ0aWZhY3RzIHBlciB0ZXN0
DQogICAgICAgICAgICAqIGhpZ2hlciBkb3dubG9hZCBzcGVlZHMgY29tcGFyZWQgdG8gaGF2aW5n
IHRvIGRvd25sb2FkIGFsbCB0ZXN0cw0KICAgICAgICAgICAgKiBsZXNzIHNwYWNlIHJlcXVpcmVk
IG9uIHRoZSB0YXJnZXQgZGV2aWNlIChpbiBjYXNlIG9mIG5mcyBpdCBkb2VzbnQgbWF0dGVyKQ0K
ICAgICAgICAqIHlvdSBjYW4gdXNlIHNpbXBsZSBidWlsZCBzY3JpcHRzIG9uIGdpdGxhYiAobm8g
bmVlZCB0byBjcmVhdGUgZGViaWFuIHJlY2lwZXMpDQogICAgKiBkb3duc2lkZXMNCiAgICAgICAg
KiB5b3UgbmVlZCB0byBzcGVjaWZ5IHRoZSBhcnRpZmFjdHMgVVJMIG9uIHRoZSB0ZXN0IGRlZmlu
aXRpb24gb3IgdXNlIHRlc3QgZGVmaW5pdGlvbiB0ZW1wbGF0ZXMgYW5kIGZpbGwgdGhhdCB3aGVu
IHlvdSBzdWJtaXQgYSBqb2INCiAgICAgICAgKiB5b3UgbmVlZCB0byB0cmFjayBtb3JlIG1ldGFk
YXRhDQogICAgICAgICogeW91IG5lZWQgZXh0cmEgcmVwb3NpdG9yaWVzIGZvciBidWlsZGluZyB0
aGUgdGVzdHMgZXRjLi4NCg0KPiBNeSBwcmVmZXJlbmNlIHdvdWxkIGJlIGZvciB0aGUgd2hvbGUg
ZmlsZXN5c3RlbSBpbmNsdWRpbmcgdGhlIHRlc3QgcGFja2FnZXMgdG8gYmUgYnVpbHQgYnkgSVNB
UiwgdGhlbiBMQVZBIGp1c3QNCj4gZG93bmxvYWRzIHRoZSAnbGF0ZXN0JyBjaXAtY29yZS10ZXN0
IGltYWdlIHdoZW4gcnVubmluZyB0ZXN0cy4NCg0KT0ssIHRoYW5rIHlvdS4gSmFuIG1lbnRpb25l
ZCB0aGUgbmVlZCB0byB0ZXN0IG1hbnVhbGx5IHRvbywgc28gSSBndWVzcyBtZXRob2QgMiBpcyB0
aGUgY2hvaWNlLg0KDQo+ID4gICAgICAgICAqIEhvdyB0byBpbXBsZW1lbnQgdGhpcw0KPiA+ICAg
ICAgICAgICAgICogbWV0aG9kIDE6IHVzaW5nIHRoZSBvcHQgeWFtbCBmb3JtYXQgPC0tIE15IHBy
ZWZlcmVuY2UgaWYgd2Ugb25seSBuZWVkDQo+ID4gdG8gc3BlY2lmeSBwYWNrYWdlcw0KPiA+ICAg
ICAgICAgICAgICogbWV0aG9kIDI6IGNyZWF0aW5nIGEgc2VwYXJhdGUgbWV0YSBsYXllcg0KPiA+
ICAgICAgICAgICAgICogbWV0aG9kIDM6IHVzaW5nIGEgbmV3IGltYWdlIChjaXAtY29yZS1pbWFn
ZS10ZXN0aW5nLmJiKQ0KPiANCj4gQXMgbG9uZyBhcyB0aGUgJ3N0YW5kYXJkJyBjaXAtY29yZSBp
cyBpbmNsdWRlZC9pbmhlcml0ZWQgcmF0aGVyIHRoYW4gY29waWVkIEkgZG9uJ3QgbWluZCB0aGUg
bWV0aG9kLg0KPiBUaGlzIHdpbGwgcmVkdWNlIHRoZSBtYWludGVuYW5jZSBidXJkZW4uDQoNClll
cywgaXQgaXMgaW5oZXJpdGVkLg0KDQpUaGFua3MsDQpEYW5pZWwNCg0KDQoNCg==

--5b3ntEWEnDtfq3ucSb5V
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4630): https://lists.cip-project.org/g/cip-dev/message=
/4630
Mute This Topic: https://lists.cip-project.org/mt/74286250/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--5b3ntEWEnDtfq3ucSb5V--
