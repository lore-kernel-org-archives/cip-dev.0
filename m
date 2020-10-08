Return-Path: <SRS0=TFHO=DP=lists.cip-project.org=bounce+64572+5508+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CFB5C433E7
	for <cip-dev@archiver.kernel.org>; Thu,  8 Oct 2020 05:46:24 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AEB2C206E7
	for <cip-dev@archiver.kernel.org>; Thu,  8 Oct 2020 05:46:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="c0fsPxsF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEB2C206E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5508+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id uLuoYY4521723xT9d9PhPCoB; Wed, 07 Oct 2020 22:46:23 -0700
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.web11.5408.1602135982441320488
 for <cip-dev@lists.cip-project.org>;
 Wed, 07 Oct 2020 22:46:22 -0700
X-Received: by mo-csw.securemx.jp (mx-mo-csw1116) id 0985kJRJ032260; Thu, 8 Oct 2020 14:46:20 +0900
X-Iguazu-Qid: 2wHHcVw7VjomRHatlv
X-Iguazu-QSIG: v=2; s=0; t=1602135979; q=2wHHcVw7VjomRHatlv; m=u7thv9FgBawmAFZ0rZSSlpEXhanXX+Ri9CJxP4FV1cA=
X-Received: from imx2.toshiba.co.jp (imx2.toshiba.co.jp [106.186.93.51])
	by relay.securemx.jp (mx-mr1112) id 0985kJEb017151;
	Thu, 8 Oct 2020 14:46:19 +0900
X-Received: from enc01.toshiba.co.jp ([106.186.93.100])
	by imx2.toshiba.co.jp  with ESMTP id 0985kJkO000873
	for <cip-dev@lists.cip-project.org>; Thu, 8 Oct 2020 14:46:19 +0900 (JST)
X-Received: from hop001.toshiba.co.jp ([133.199.164.63])
	by enc01.toshiba.co.jp  with ESMTP id 0985kIiN009293
	for <cip-dev@lists.cip-project.org>; Thu, 8 Oct 2020 14:46:19 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ttm21kso8xPHrBXXXZgbf4O2J2GZNMswJGUZSWRFO4+keRTAkQTwzn4WOR6rnhe5qSiPBfOXFZCSbUJ5uAIJHkyJowjTmsgUjD0S7e3CyToSnIpZ0khA7fUEQUOfqzB78g1zTVej9Ij3WrnDe4bTNdxYe4RIKr8XucJQfZDGmqSzqJb2B0ODbPTVHnsG18AH4+PfkKw8nEeAkNrRSXGiM9PbtFUEPxQOML3ZxBfSs/dnfMIE22S6lDRlrtiGmrBr7LGO1MifGGk9eZGjDWE/xjAj1xuxIqM0nqyte/VuJL34ZvpNXcMh1XGpUjQua6JOre6eowd+rakjENf/PKBHgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9KG+VqKtxeC2jwN0+TT9+mdLEiEDYLCexb7K9Hb2Fuw=;
 b=RxKFQEThsMnS61f6ekDmwhPaF/bDLCt1HSPlmKW3GLc+PQu7yyWmDoJSQ6xpY+BMdCFDOUfXekb8vwPwOHJE5nryG7naavZSwYk7O6D/kx5UQjy1oII+70bCic14MV3U6wmo5agO28kq7FJuk+F3/Wsi8EYIVhgPPQkECBTWzi8y8K4//a3tqjruoEkd2uWfGVppTTSfcfIwwlIxgJcMlc/6McRt2IVwSUJGHiTwKkKeSApxZ1sPjnSSBO99igcwWhbhYJqehl3Mkkuqm8olFnqxOXiHZOl1Kmc6SK7scvAtvLCL5MD2ivxt7dwyw7hF2H65eQ472Wm2rALVgC2vVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: "Nobuhiro Iwamatsu" <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
Subject: Re: [cip-dev] CIP IRC weekly meeting today
Thread-Topic: CIP IRC weekly meeting today
Thread-Index: AdadDdEK75ALNrT6TDiJMlv9gfwWTwAJtDhQ
Date: Thu, 8 Oct 2020 05:46:17 +0000
X-TSB-HOP: ON
Message-ID: <OSBPR01MB29831FBC6C347EE55CE3A0BD920B0@OSBPR01MB2983.jpnprd01.prod.outlook.com>
References: <OSBPR01MB4967B53707E24AB20B083FA0A00B0@OSBPR01MB4967.jpnprd01.prod.outlook.com>
In-Reply-To: <OSBPR01MB4967B53707E24AB20B083FA0A00B0@OSBPR01MB4967.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
x-originating-ip: [103.91.184.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 16f991f8-a45b-4d9f-b803-08d86b4d7a00
x-ms-traffictypediagnostic: OS0PR01MB5298:
x-microsoft-antispam-prvs: <OS0PR01MB529863E45052F187D4F50566920B0@OS0PR01MB5298.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 19jXcPoCzeb1Y5dnyjI7O1Tx5fme1v76L29x/1T8Fa3AIUlbU7vbpF6ajsW/cisWEAbYwXzCkjhb0cb8pNmiYOc/Jd0+PNiIfpTBtNgFSsH00L3TVGoPKd9fI8RMIvU5GfHlGsHicznQeKYflWiaati0J5f4DiDacEs22yGnruFYse6cfDJVB6nxWMJbnyvUkCLeG4i7+8PiUKo/w3Xr404HWLTqBnMm60iVI1sFKaHx5IEncKWTXYiwRZiiKVlaL9LDVSCJn9kMU8qn5G1tyB6B96oN5msF5VibTzYdwZ2+VPDYji9/mfhVD0BrV+E2EPMsAWUqbzk3c8N7YAskuyDg+Sgs9Nx+4/RmIjcLTcNwxe8zlALX48Er6xmr1D7NMd5oZhwxe4hFEjWn7L9k5A==
x-ms-exchange-antispam-messagedata: SZXhEQRwX2Xk3uQRZJ3Cx74JrOTJIccyyN7VR8DqXIQ4UNV1fCN1IWVbT0EWrB+kxWFWzbkqObtSTNlpSs/kNLblw1oHSedbI/qVy+xestcOMLEw169wM5NhMluXn0tL63TP9huVDoymSDU74JM7zCxXh6YbIPtevxiTToivBgCGyYeO7mhP/cc1UUUF/mF+RtkuWCiBn/MWC0x94gYBwpGmfb1mtyj9x/VKbcJ3f9IELLp4ExXQSQ21eN+mIZAp4UEXHPL1p8y8s15nWR7FYq85Y1/abiNfVluTgFKQGGfJNF+u4jLTbUz0jzuVmDMG6SHf3gviTwS2iSUzTIfUGLJeP9IhrXMmLjBPnUhTtZ+6KLJASeBAKUkTqsmQb6QlZkSmxiCLktfThfOepd+nsynzKi3iY0Gzeo2NM7G2bkdEhrAxzYWpuwFu7kx9rGWsWSEaMbZ9XbBEUAT4YdM0hslyj8Ucnf4jvetqWqGJjrR0sgrg0GmIVwGsbEo14w5SNu4vQ+AXq+sUrAmvupP4ZzNXhRTbGC6b8EzULTYpXjxQ4fw+hqlgsdgAvFxH9fVBsDnCPtGatiVK05F7vso1KFsB2jtsg+v28jQmMNrYH5e3IeDLXRWvLD/1JE82ncJV2APmL+LCTziq21pxRmthEA==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2983.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16f991f8-a45b-4d9f-b803-08d86b4d7a00
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2020 05:46:17.5816
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eE5EUiKhGrg6+bbqIQR6Ut/skJjUWwOJt7Wy+S+ewwgV2SWcuDDZ2wD/0vHWnuTqsRrt5RsPsOdfhzOaCXT+phGtiSiGxillUxMm9ttUN5c0TOzTIPBLKStuSx0h0Kxj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB5298
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: aq5fa6mE2oJ3vFFGSckLRl3Vx4520388AA=
Content-Type: multipart/mixed; boundary="j9rJOz4kXmYtQY981XDk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1602135983;
 bh=LlIX6keI/VzIrGu0PwHrN7b2JiRnToAL22MxLkRPWMQ=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=c0fsPxsF9npHzCd1vFYodFzl0XLOg7dhb/LXhv64mZV2qVf9x+uakL8EhfG9YOXIqrq
 E4YRIBscZLNdBjCv+R9YsSm/aTnZrityMLBh52/5p05XX5UqklTxGPodu6VuIjRD6Zr7Q
 koG+HGT9w6Q3ocqOl6ZRIDyR7aNFHzNW09E=

--j9rJOz4kXmYtQY981XDk
Content-Language: ja-JP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGkgS3Vkby1zYW4sDQoNClNvcnJ5LCBJIGNhbiBub3QgcGFydGljaXBhdGUgSVJDIG1lZXRpbmcg
dG9kYXkuDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogY2lwLWRldkBs
aXN0cy5jaXAtcHJvamVjdC5vcmcgW21haWx0bzpjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9y
Z10gT24gQmVoYWxmIE9mDQo+IG1hc2FzaGkua3Vkb0BjeWJlcnRydXN0LmNvLmpwDQo+IFNlbnQ6
IFRodXJzZGF5LCBPY3RvYmVyIDgsIDIwMjAgOTo1NyBBTQ0KPiBUbzogY2lwLWRldkBsaXN0cy5j
aXAtcHJvamVjdC5vcmcNCj4gU3ViamVjdDogW2NpcC1kZXZdIENJUCBJUkMgd2Vla2x5IG1lZXRp
bmcgdG9kYXkNCj4gDQo+IEhpIGFsbCwNCj4gDQo+IEtpbmRseSBiZSByZW1pbmRlZCB0byBhdHRl
bmQgdGhlIHdlZWtseSBtZWV0aW5nIHRocm91Z2ggSVJDIHRvIGRpc2N1c3MgdGVjaG5pY2FsIHRv
cGljcyB3aXRoIENJUCBrZXJuZWwgdG9kYXkuDQo+IA0KPiAqUGxlYXNlIG5vdGUgdGhhdCB0aGUg
SVJDIG1lZXRpbmcgd2FzIHJlc2NoZWR1bGVkIHRvIFVUQyAoR01UKSAwOTowMCBzdGFydGluZyBm
cm9tIHRoZSBmaXJzdCB3ZWVrIG9mIEFwci4gYWNjb3JkaW5nDQo+IHRvIFRTQyBtZWV0aW5nKg0K
PiBodHRwczovL3d3dy50aW1lYW5kZGF0ZS5jb20vd29ybGRjbG9jay9tZWV0aW5nZGV0YWlscy5o
dG1sP3llYXI9MjAyMCZtb250aD0xMCZkYXk9OCZob3VyPTkmbWluPTAmc2VjPTAmcDE9MjI0JnAy
PQ0KPiAxNzkmcDM9MTM2JnA0PTM3JnA1PTI0MSZwNj0yNDgNCj4gDQo+IFVTV2VzdAlVU0Vhc3QJ
VUsJREUJVFcJSlANCj4gMDI6MDAJMDU6MDAJMTA6MDAJMTE6MDAJMTc6MDAJMTg6MDANCj4gDQo+
IENoYW5uZWw6DQo+ICogaXJjOmNoYXQuZnJlZW5vZGUubmV0OjY2NjcvY2lwDQo+IA0KPiBMYXN0
IG1lZXRpbmcgbWludXRlczoNCj4gaHR0cHM6Ly9pcmNsb2dzLmJhc2Vyb2NrLm9yZy9tZWV0aW5n
cy9jaXAvMjAyMC8xMC9jaXAuMjAyMC0xMC0wMS0wOS4wMC5sb2cuaHRtbA0KPiANCj4gQWdlbmRh
Og0KPiANCj4gKiBBY3Rpb24gaXRlbQ0KPiAgIDEuIENvbWJpbmUgcm9vdCBmaWxlc3lzdGVtIHdp
dGgga3NlbGZ0ZXN0IGJpbmFyeSAtIGl3YW1hdHN1DQoNCk5vIHVwZGF0ZS4NCg0KPiAgIDIuIENo
ZWNrIHdoZXRoZXIgQ1ZFLTIwMjAtMjUyODQgbmVlZHMgdG8gYmUgYmFja3BvcnRlZCB0byA0LjQt
cnQNCj4gICAgICAgLT4gIERlbGV0ZSByYmQgKCBDZXBoIGJsb2NrIGRldmljZSApIGZyb20gNC40
LXJ0IHg4NiBjb25maWcgLSBpd2FtYXRzdQ0KPiAgICAgICAtPiAgRG9uZSwgc28gd2lsbCBiZSBj
bG9zZWQgdG9kYXkuDQo+IA0KPiAqIEtlcm5lbCBtYWludGVuYW5jZSB1cGRhdGVzDQoNCkkgcmV2
aWV3ZWQgNC40LnktcmMuDQoNCj4gKiBLZXJuZWwgdGVzdGluZw0KPiAqIFNvZnR3YXJlIHVwZGF0
ZQ0KPiAqIENJUCBTZWN1cml0eQ0KPiAqIEFPQg0KPiANCj4gVGhlIG1lZXRpbmcgd2lsbCB0YWtl
IDMwIG1pbiwgYWx0aG91Z2ggaXQgY2FuIGJlIGV4dGVuZGVkIHRvIGFuIGhvdXIgaWYgaXQgbWFr
ZXMgc2Vuc2UgYW5kIHRob3NlIGludm9sdmVkIGluIHRoZSB0b3BpY3MNCj4gY2FuIHN0YXkuIE90
aGVyd2lzZSwgdGhlIHRvcGljIHdpbGwgYmUgdGFrZW4gb2ZmbGluZSBvciBpbiB0aGUgbmV4dCBt
ZWV0aW5nLg0KPiANCg0KQmVzdCByZWdhcmRzLA0KICBOb2J1aGlybw0KDQo=

--j9rJOz4kXmYtQY981XDk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5508): https://lists.cip-project.org/g/cip-dev/message=
/5508
Mute This Topic: https://lists.cip-project.org/mt/77375242/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--j9rJOz4kXmYtQY981XDk--
