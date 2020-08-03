Return-Path: <SRS0=4kNk=BN=lists.cip-project.org=bounce+64572+5082+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC7BAC433DF
	for <cip-dev@archiver.kernel.org>; Mon,  3 Aug 2020 12:38:08 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41BFE204EC
	for <cip-dev@archiver.kernel.org>; Mon,  3 Aug 2020 12:38:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="dvBYxHK+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41BFE204EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5082+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 6fpcYY4521723xeAOE0AnWQy; Mon, 03 Aug 2020 05:38:08 -0700
X-Received: from JPN01-TY1-obe.outbound.protection.outlook.com (JPN01-TY1-obe.outbound.protection.outlook.com [40.107.140.121])
 by mx.groups.io with SMTP id smtpd.web12.10230.1596458287278873870
 for <cip-dev@lists.cip-project.org>;
 Mon, 03 Aug 2020 05:38:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PTBxdrPLGVCw1RIih6jkC8Q5c9Vfq1GY6RrQScb3BnbM1h9IU1FZGXvYki7fLydOv8/HnA8vdLTj2lSEMMVMt44BzGPn32Et8Mso4aF0XkXrmrskZTCxukPLX4oJTRHwbQZ21IxdePCcE/4cgJVZKl6TdSDf8PUQxL0OPijqHY8CS5uYEIP8L4G5ozMb3rGxdP+pUO8uEpIlygawQ+CdYgg8yN540cu1FzFF79AbDR5UCuRN1FsXeSu/4PwVnJlsimxZBsznREalveCDbSp+0mQkWWcNHQlfgMYp81PzXJTkhXUDX0sUXdaYway5p5LJtExdYW6IhDDXTrxz/DhRrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DbdGtgbAHtjDEHFJ+Hjh7YQGaOySmYkT7mLYZbjp+FY=;
 b=AkzXjNQhyeGiOSNq09BzXd3dgxiHJeBfFcZg0EqSrGGuC++04IfSXnEkOv33MW1OhB/+Ikljr8KZOHuXbFSEOwPpDkKvcyGrQqDHVD1skISEbUDHPW91IzTSWov+HCgw47cuL1MyJdInAPOJF/V2bzicwMs/7R+THxDnaE7hJ/M0kTtZxCkc6JH7OtIV7bIDcf3UpcBqik3/wJjk1KCVtwnmvCeDclWbwBXJeStAaY2Id0F+dw9elcR/JuyM5tMGqOMPV269K/oJGVQaRJVW/zSR/MoO36A5foqEBvdpqI/NOvtqUAQSQVh4QgzajigKCIwjL4mNoXWinv7OeJXksw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
X-Received: from OSAPR01MB2385.jpnprd01.prod.outlook.com (2603:1096:603:37::20)
 by OSBPR01MB4997.jpnprd01.prod.outlook.com (2603:1096:604:7d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.18; Mon, 3 Aug
 2020 12:38:04 +0000
X-Received: from OSAPR01MB2385.jpnprd01.prod.outlook.com
 ([fe80::9dba:6049:dd66:3c70]) by OSAPR01MB2385.jpnprd01.prod.outlook.com
 ([fe80::9dba:6049:dd66:3c70%7]) with mapi id 15.20.3239.021; Mon, 3 Aug 2020
 12:38:04 +0000
From: "Chris Paterson" <chris.paterson2@renesas.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, "cip-dev@lists.cip-project.org"
	<cip-dev@lists.cip-project.org>, Nobuhiro Iwamatsu
	<nobuhiro1.iwamatsu@toshiba.co.jp>, "masashi.kudo@cybertrust.co.jp"
	<masashi.kudo@cybertrust.co.jp>, "pavel@denx.de" <pavel@denx.de>,
	"ben.hutchings@codethink.co.uk" <ben.hutchings@codethink.co.uk>,
	"SZ.Lin@moxa.com" <SZ.Lin@moxa.com>, "wens@csie.org" <wens@csie.org>
Subject: Re: [cip-dev] CIP Patchwork
Thread-Topic: [cip-dev] CIP Patchwork
Thread-Index: AdZg1ErSblGkeTY5RLCzs1AcoDxFYwFfNTKAAAEJDYAAz2RYMA==
Date: Mon, 3 Aug 2020 12:38:03 +0000
Message-ID: 
 <OSAPR01MB23857D519CBAA0C40F126AD9B74D0@OSAPR01MB2385.jpnprd01.prod.outlook.com>
References: 
 <OSAPR01MB238534DE1045DDA72E9C7548B7760@OSAPR01MB2385.jpnprd01.prod.outlook.com>
 <OSBPR01MB29830A4698C039B05CDB23DB92710@OSBPR01MB2983.jpnprd01.prod.outlook.com>
 <c6c138de-9109-9a32-59de-2cae3dffda04@siemens.com>
In-Reply-To: <c6c138de-9109-9a32-59de-2cae3dffda04@siemens.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 819e0ef4-8592-4447-8945-08d837aa10f1
x-ms-traffictypediagnostic: OSBPR01MB4997:
x-microsoft-antispam-prvs: 
 <OSBPR01MB499702DD6F1C23C22DC360ACB74D0@OSBPR01MB4997.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 NLqJ16vyA+0NgguQBCzYA4Ex7l8nQce3CE6ghICYEg4T6vpEkRmU29/hL1eWGlPf8o22n3FRBw3i//1dRwzzhhObEoiQ69Ul5aVfXoS1UM12jcGknWMELmnJiugGyO1yHBTC/AWxR78awjhWRZs9ICAyaOXifDi0qc4Cbwkerz/orbxj7mgthKi3Y4hmxwIEjA9MAC5GSfPyHTUZ2vFJXPN+w7fJx5lP/m/ZIO7x7Fm/gQgBPZF6iTGsbx4ACY8bqt84RYGyQl8r527YgmPZZtbSRpuPnneb8zqclaRYpTv2s77Pno7Vfn0Msu2IENatXPiT/3c/IP8UOlUlG7oBpeV9i6gLxg0DT08ZW+07Xow6iZDmV5XVNwUQyOYrpGTiaLW21E4jI2PdQhhmPH4m2A==
x-ms-exchange-antispam-messagedata: 
 Vk8lhx2mYNQk6ONEDFcKA6eBirET/7B+3liejIyfHpc5GzQMM+hubj9lElkRLSXG9fO3P9Kh5bVDfKj1Lv3DUpzywQaZ6hHg0uvMWzACRLglhuflnVgT2X+GzkU5Xa7E5d3Wgixemp3umCmJarRbJAcpXWup8cKJPq8sd8UlYRNIfyv9qAIrtJFeEr+cgr+Wni+HvKb43YoHyWV3cskLh8C6tCVpzM1MgnZyEfG+y4TYEI3+1lNd0TyY9NHOpa0fMuPowWR0yeirHxeMvf+mhy3dVsYCDl+4srzpoM0CZoOlLQyvZOH7Me8NFH3Oy1AK98bcHIroLgZlXBdIiV7XP3l2b3WGOT5PUhthtsAWKKK155GQTRsro1Q82NM7xNloqW40gUNWddDzyuuwAKUCKYK2/hfAlEezo4A8cyHdZmlMZbI/PW0yH+Pc1E6+X78knqEv2LYcrx2ANydFJWkXXRfHKZQc99YMGS5FAHsDQijIstDT/ysVH+rMVa/nlsrWDaRD4fG8YeeW3nLcShOwsvvNOyg8vqxhFQdICve/S/SNz4jlVzAt5HRu7p3oXkjXUFmDeiS1s2gm8NPwsCipzlDQZBPEk57Sl5EGDJbxZaPmKP9WlUGs9EihjqT/utdKRaaFG0qbbGV3Te560aKqFA==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSAPR01MB2385.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 819e0ef4-8592-4447-8945-08d837aa10f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2020 12:38:03.8729
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uHn0VG1vlDdZ6+K9S5nzFL6hfYyeC3bJ6dyYoc1XuotuL1RmPONeQgnpIYlGcmOQKuEeLgOL/KG8SGZJT22ISU4qxd1m5sCLUVWrvZ8zcqA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB4997
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: mcjOd3UQzJ08n6zrzKB5J0H7x4520388AA=
Content-Type: multipart/mixed; boundary="pBJdku8dQxLRuEz5bMU0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1596458288;
 bh=eNKD9FT10p/AqgI7fAYPFBX/6Xl0xoFiIuPMco2Iv/A=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=dvBYxHK+oBt4emDqWvMzZKKcvsBuHbSkkfHaEdGPFvv+nsvtScj+QbH1nEQDCp1CTef
 EMEtSGmOxElhpVq0wys8THva1zIqOrQeN+QlAuyH/p+/eZQFA29fVTimaorIX1FWoNqk9
 dJzZARpB3PIpqTYRD7BXW5G0Y57QtgmhVs0=

--pBJdku8dQxLRuEz5bMU0
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGVsbG8sDQoNCj4gRnJvbTogSmFuIEtpc3prYSA8amFuLmtpc3prYUBzaWVtZW5zLmNvbT4NCj4g
U2VudDogMzAgSnVseSAyMDIwIDEwOjM5DQo+IA0KPiBPbiAzMC4wNy4yMCAxMToxNiwgTm9idWhp
cm8gSXdhbWF0c3Ugd3JvdGU6DQo+ID4gSGksDQo+ID4NCj4gPj4gLS0tLS1PcmlnaW5hbCBNZXNz
YWdlLS0tLS0NCj4gPj4gRnJvbTogQ2hyaXMgUGF0ZXJzb24gW21haWx0bzpDaHJpcy5QYXRlcnNv
bjJAcmVuZXNhcy5jb21dDQo+ID4+IFNlbnQ6IFRodXJzZGF5LCBKdWx5IDIzLCAyMDIwIDY6Mzcg
UE0NCj4gPj4gVG86IG1hc2FzaGkua3Vkb0BjeWJlcnRydXN0LmNvLmpwOyBpd2FtYXRzdSBub2J1
aGlybyjlsqnmnb4g5L+h5rSLIOKWoe+8sw0KPiDvvLfvvKPil6/vvKHvvKPvvLQpDQo+ID4+IDxu
b2J1aGlybzEuaXdhbWF0c3VAdG9zaGliYS5jby5qcD47IHBhdmVsQGRlbnguZGU7DQo+IGJlbi5o
dXRjaGluZ3NAY29kZXRoaW5rLmNvLnVrOyBTWi5MaW5AbW94YS5jb207IHdlbnNAY3NpZS5vcmcN
Cj4gPj4gQ2M6IGNpcC1kZXZAbGlzdHMuY2lwLXByb2plY3Qub3JnDQo+ID4+IFN1YmplY3Q6IENJ
UCBQYXRjaHdvcmsNCj4gPj4NCj4gPj4gSGVsbG8gYWxsLA0KPiA+Pg0KPiA+PiBDSVAgaGFzIGEg
UGF0Y2h3b3JrIGluc3RhbmNlIFswXSB0aGF0IG1vbml0b3JzIHRoZSBjaXAtZGV2IG1haW5saW5l
IGxpc3QgZm9yDQo+IHBhdGNoZXMuDQo+ID4+DQo+ID4+IEl0IGRvZXNuJ3QgbG9vayBsaWtlIGl0
J3MgcGFydGljdWxhcmx5IG1haW50YWluZWQsIHdpdGggbW9zdCBwYXRjaGVzIGluIHRoZQ0KPiAi
bmV3IiBzdGF0ZS4NCj4gPj4gQXMgYSBwcm9qZWN0LCBkbyB3ZSB3YW50IHRvIHN0YXJ0IG1haW50
YWluaW5nIFBhdGNod29yaz8gU2hvdWxkIHdlIGtpbGwgaXQNCj4gb2ZmPyBPciBqdXN0IHN0aWNr
IHdpdGggdGhlIHN0YXR1cy1xdW8/DQo+ID4+DQo+ID4+IFdlIGJyaWVmbHkgZGlzY3Vzc2VkIHRo
aXMgaW4gdGhlIElSQyBtZWV0aW5nIHRvZGF5LCBidXQgSSB0aG91Z2h0IHdlDQo+IHNob3VsZCBj
aGVjayB3aXRoIGEgd2lkZXIgYXVkaWVuY2UgYmVmb3JlIG1ha2luZw0KPiA+PiBhIGRlY2lzaW9u
Lg0KPiA+DQo+ID4gTm90IGFsbCwgSSBzb21ldGltZSBjaGVja2VkIGFuZCB1cGRhdGVkIHRoaXMu
DQo+ID4gVGhlcmUgYXJlIG1vcmUgbm9uLWtlcm5lbCBwYXRjaGVzLCBzbyBJIHJlLWNoZWNrIHRo
aXMuDQo+ID4gQW5kIEkgdXNlIHRoaXMgZm9yIHBhdGNoIHRyYWNraW5nIGFuZCBwYXRjaCBhcHBs
aW5nLg0KPiA+DQo+IA0KPiBDYW4gd2Ugc2V0IGZpbHRlcnMgYmFzZWQgb24gY29tbW9uIHRhZ3Mg
bGlrZSAiW2lzYXItY2lwLWNvcmVdIiAod2hpY2ggSQ0KPiBqdXN0IGZvcmdvdCB0byB1c2UpPw0K
DQpJIGNhbid0IHNlZSBhbnkgb3B0aW9ucyB0aHJvdWdoIHRoZSBndWksIGJ1dCBwZXJoYXBzIHRo
ZXJlIGFyZSBzb21lIGNvbmZpZ3VyYXRpb24gb3B0aW9ucyBzZXJ2ZXItc2lkZS4NCg0KS2luZCBy
ZWdhcmRzLCBDaHJpcw0KDQo+IA0KPiBKYW4NCj4gDQo+ID4NCj4gPj4NCj4gPj4gU28sIGFueSB0
aG91Z2h0cz8NCj4gPj4NCj4gPj4gWzBdIGh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcHJv
amVjdC9jaXAtZGV2L2xpc3QvDQo+ID4+DQo+ID4+IEtpbmQgcmVnYXJkcywgQ2hyaXMNCj4gPg0K
PiA+IEJlc3QgcmVnYXJkcywNCj4gPiAgICBOb2J1aGlybw0KPiA+DQo+ID4NCj4gPiANCj4gPg0K
PiANCj4gLS0NCj4gU2llbWVucyBBRywgQ29ycG9yYXRlIFRlY2hub2xvZ3ksIENUIFJEQSBJT1Qg
U0VTLURFDQo+IENvcnBvcmF0ZSBDb21wZXRlbmNlIENlbnRlciBFbWJlZGRlZCBMaW51eA0K

--pBJdku8dQxLRuEz5bMU0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5082): https://lists.cip-project.org/g/cip-dev/message=
/5082
Mute This Topic: https://lists.cip-project.org/mt/75742669/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--pBJdku8dQxLRuEz5bMU0--
