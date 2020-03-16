Return-Path: <SRS0=ZUnv=5B=lists.cip-project.org=cip-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 377B1C0044D
	for <cip-dev@archiver.kernel.org>; Mon, 16 Mar 2020 22:49:24 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8CF120679
	for <cip-dev@archiver.kernel.org>; Mon, 16 Mar 2020 22:49:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8CF120679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cip-dev-bounces@lists.cip-project.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id BD8C686F0C;
	Mon, 16 Mar 2020 22:49:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xddrXV2HPC3o; Mon, 16 Mar 2020 22:49:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id CC8B585AF1;
	Mon, 16 Mar 2020 22:49:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BF0FEC18DA;
	Mon, 16 Mar 2020 22:49:22 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 30F5BC013E
 for <cip-dev@lists.cip-project.org>; Mon, 16 Mar 2020 22:49:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 2A6BB21FAD
 for <cip-dev@lists.cip-project.org>; Mon, 16 Mar 2020 22:49:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vQgDUQPPdawS for <cip-dev@lists.cip-project.org>;
 Mon, 16 Mar 2020 22:49:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mo-csw.securemx.jp (mo-csw1516.securemx.jp [210.130.202.155])
 by silver.osuosl.org (Postfix) with ESMTPS id 25D262151E
 for <cip-dev@lists.cip-project.org>; Mon, 16 Mar 2020 22:49:18 +0000 (UTC)
Received: by mo-csw.securemx.jp (mx-mo-csw1516) id 02GMn9jZ003863;
 Tue, 17 Mar 2020 07:49:09 +0900
X-Iguazu-Qid: 34trcFcTR5gbbxq3Ps
X-Iguazu-QSIG: v=2; s=0; t=1584398949; q=34trcFcTR5gbbxq3Ps;
 m=HikYOFpio08ZTVI/r2rJWf5a2y2RrHG6tXsUjPmuyfU=
Received: from imx2.toshiba.co.jp (imx2.toshiba.co.jp [106.186.93.51])
 by relay.securemx.jp (mx-mr1512) id 02GMn89i023710;
 Tue, 17 Mar 2020 07:49:08 +0900
Received: from enc01.localdomain ([106.186.93.100])
 by imx2.toshiba.co.jp  with ESMTP id 02GMn8VF023338;
 Tue, 17 Mar 2020 07:49:08 +0900 (JST)
Received: from hop001.toshiba.co.jp ([133.199.164.63])
 by enc01.localdomain  with ESMTP id 02GMn7YL030247;
 Tue, 17 Mar 2020 07:49:07 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jd6KG4GsSkHkmTW/7Y+LmKEhlxhAoMCkK9QSOEXXT6/mRqNjHXxCflNAcDFVnAIw5ZpTBuQMz1NXpynqR0BIo2otGWlxhRXm9Ci6eKraYJnb/dDg48CjNo/yq8mCNn9UgeeLsFZ/3Ki9EJgoy63k+mzhO/dxwHiDeQHw05IBnxyaW0IkhqQckkQoPeyHxn+7SlkcYuvE1EwMEbQrn73grGLruVGPznFYMyw1BsdoeCi+gnBhXr35LNow5MMNtCaNJrf3BxLksxcWPXq/GCLfWN63mGk/W8rh4lfwjXPvm+fGhszGnMHg19DONjjcGa+A/22yLFOZzEVkTeQPvyjW6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gs2yboSBuwTX/NhUYuaUbxTbb25pV/kicb8n2YX12Us=;
 b=IfsvsLf62F5db+pUDUamXiI6RPSMN+FXwEv1opq1IXOb4XL4nqlbUgLs1v5Htz7TqCthPfdLTpYrYFHc/u6mZZLtekxkCMkgno5pCttSl7HJxEXNDydBYfsqLP8aFbPlip5KsMqHRwyIct/khmIoWk9xV1oBya4n9pcXDIZnksWtd0tkLdXzTJnfokqoA5i02w21KZjroh7xC8bQjSImBOB2x0F95KeHyuOPe7F/HJaE7+yjsqFJplEWiIoa3ITEKx+SpR9ajfBJBUJkUlt3yVjieDuY9IAIOe47ClCWEDjrhlVX7OZbe508m/ptpBpzDM4tQUwxM5WdMTsdhMmecw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <jan.kiszka@siemens.com>, <vijaikumar.kanagarajan@gmail.com>,
 <cip-dev@lists.cip-project.org>, <Chris.Paterson2@renesas.com>,
 <pavel@denx.de>
Thread-Topic: [cip-dev] Linux-cip: Kselftest plans
Thread-Index: AQHV85BZp2pd/uftOUK/zFbOoHXxnKhLZ3EAgAB45fA=
Date: Mon, 16 Mar 2020 22:49:05 +0000
X-TSB-HOP: ON
Message-ID: <OSAPR01MB36676897A7976E3D6079ECDE92F90@OSAPR01MB3667.jpnprd01.prod.outlook.com>
References: <CALLGG_Juuz3wktbc71uo68shAU4ZpaxKzAqycKtzKd0R4Meemg@mail.gmail.com>
 <8cc7afeb-409b-3dee-df4b-e6a63f979723@siemens.com>
In-Reply-To: <8cc7afeb-409b-3dee-df4b-e6a63f979723@siemens.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=nobuhiro1.iwamatsu@toshiba.co.jp; 
x-originating-ip: [209.137.146.201]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 68dc1170-8425-4db4-dbd8-08d7c9fc3afa
x-ms-traffictypediagnostic: OSAPR01MB4177:
x-microsoft-antispam-prvs: <OSAPR01MB41771DF103359C77333B3CE792F90@OSAPR01MB4177.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 03449D5DD1
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(136003)(376002)(366004)(346002)(396003)(199004)(6506007)(53546011)(9686003)(316002)(478600001)(55016002)(2906002)(81156014)(81166006)(71200400001)(186003)(110136005)(8676002)(66556008)(66446008)(64756008)(86362001)(76116006)(7696005)(26005)(33656002)(5660300002)(52536014)(8936002)(66476007)(66946007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:OSAPR01MB4177;
 H:OSAPR01MB3667.jpnprd01.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
received-spf: None (protection.outlook.com: toshiba.co.jp does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: svXe4AHhRr3Bztdsg0jfGjMa/SI11d9bnJjinzk/sh7rs2TP2IzI0iKLNwGuZmYunnsRe1wjGYO0nJ3atbJ8ittUM1Tq90mtlirNtDO+ijEEDoBSA5qtcPzl8TL9U5BP/dWbAJm1qxZZmGRBmSf/6K4GpbiBXjsS7V41c1tGyni6OMsuIm1MmI+EGNaTZimfH1CF9HCJluBHSGZtmLjfCOzdTn6SZ0bNbnSgedxTl+bI0ggkFL4zyYsPHnGFQ2y2ZvtuRfYFQCNopNNxegUIg3e2YzyITXLUL2cizwkZkcF/nqr1jzesfXJBzPeDkFsYCpa75efyoAxf7o7wH1FjP+7IOqM69Y97j/VL3HXj6Ru7o7M/xpNkWaxMlAMmTGXAezMZCpMAI8VV0R1zKNs8JSWsUUYRlLxDWRFCcSkDKLybu0ohPMS1iCn46bDgdaTA
x-ms-exchange-antispam-messagedata: nHHPpGN8pPYU6PDV6SnQuUWwL79hIZuIo62JUyeA5Uf0EWkuFNwVoEe34MFENQgeOoIeVi+cZc670gkU0n8r2ZbuZDuvtI/6K4lLioqY2h9uDZlDHw4z1yZB3hyEhRDjt7FTkfuZMqsXJEgJos5Wcw==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 68dc1170-8425-4db4-dbd8-08d7c9fc3afa
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2020 22:49:05.3625 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 32auLlFqdtCJZgIi44fMRq/LRA0Ur6esjQcZhjXGv61vCzd7O7PXHnJVrX/BETqIZ5WgDZQqln3av0S9dIZMUHqpSx1B8Bw4+sI4louKufG/L52d45dDQK/MAokPeK5n
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB4177
MSSCP.TransferMailToMossAgent: 103
X-OriginatorOrg: toshiba.co.jp
Subject: Re: [cip-dev] Linux-cip: Kselftest plans
X-BeenThere: cip-dev@lists.cip-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: <cip-dev.lists.cip-project.org>
List-Unsubscribe: <https://lists.cip-project.org/mailman/options/cip-dev>,
 <mailto:cip-dev-request@lists.cip-project.org?subject=unsubscribe>
List-Archive: <http://lists.cip-project.org/pipermail/cip-dev/>
List-Post: <mailto:cip-dev@lists.cip-project.org>
List-Help: <mailto:cip-dev-request@lists.cip-project.org?subject=help>
List-Subscribe: <https://lists.cip-project.org/mailman/listinfo/cip-dev>,
 <mailto:cip-dev-request@lists.cip-project.org?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: cip-dev-bounces@lists.cip-project.org
Sender: "cip-dev" <cip-dev-bounces@lists.cip-project.org>

SGkgYWxsLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEphbiBLaXN6
a2EgW21haWx0bzpqYW4ua2lzemthQHNpZW1lbnMuY29tXQ0KPiBTZW50OiBUdWVzZGF5LCBNYXJj
aCAxNywgMjAyMCAxMjoyNyBBTQ0KPiBUbzogdmlqYWkga3VtYXIgPHZpamFpa3VtYXIua2FuYWdh
cmFqYW5AZ21haWwuY29tPjsNCj4gY2lwLWRldkBsaXN0cy5jaXAtcHJvamVjdC5vcmc7IENocmlz
IFBhdGVyc29uDQo+IDxDaHJpcy5QYXRlcnNvbjJAcmVuZXNhcy5jb20+OyBpd2FtYXRzdSBub2J1
aGlybyjlsqnmnb4g5L+h5rSLIOKXi++8s++8t++8o+KWoQ0KPiDvvK/vvLPvvLQpIDxub2J1aGly
bzEuaXdhbWF0c3VAdG9zaGliYS5jby5qcD47IFBhdmVsIE1hY2hlaw0KPiA8cGF2ZWxAZGVueC5k
ZT4NCj4gU3ViamVjdDogUmU6IFtjaXAtZGV2XSBMaW51eC1jaXA6IEtzZWxmdGVzdCBwbGFucw0K
PiANCj4gT24gMDYuMDMuMjAgMDk6MjEsIHZpamFpIGt1bWFyIHdyb3RlOg0KPiA+IEhpIEFsbCwN
Cj4gPg0KPiA+IElzIGtzZWxmdGVzdCBtYWludGFpbmVkIGluIHRoZSBjaXAta2VybmVsIHRyZWU/
IEkgZG8gc2VlIHNvbWUNCj4gPiBicmFuY2hbMV0gbWFpbnRhaW5lZCBieSBOb2J1aGlyby1zYW4g
Zm9yIGtzZWxmdGVzdCwgYnV0IGl0J3Mgb3V0IG9mDQo+ID4gNS42IGxpbnV4IHRyZWUuDQo+ID4N
Cj4gPiBUaGUgcmVhc29uIGJlaW5nIHRvIGdhdGhlciBjb2xsZWN0aXZlIHRob3VnaHRzIGFib3V0
IHRoZSBwbGFuIGZvcg0KPiA+IGtzZWxmdGVzdCBiYXNlZCB0ZXN0cyBmb3IgY2lwIGtlcm5lbC4g
QXJlIHRoZXJlIGFueSBleGlzdGluZyBvciBmdXR1cmUNCj4gPiBwbGFucyBmb3IgdXNpbmcga3Nl
bGZ0ZXN0IGZvciB0ZXN0aW5nIGNpcCBrZXJuZWxzPyBJZiBzbyBhcmUgd2UgZ29pbmcNCj4gPiB0
byB1c2UgdGhlIGxhdGVzdCB0cmVlIGZyb20gdXBzdHJlYW0gb3IgcGxhbiB0byBmaXgvYmFja3Bv
cnQgdGVzdA0KPiA+IGNhc2VzIHRvIGN1cnJlbnQgY2lwIGtlcm5lbCB2ZXJzaW9ucz8NCg0KSSBh
bSBub3cgaW1wbGVtZW50aW5nIExBVkEncyBrc2VsZnRlc3QuIFRoaXMga3NlbGZ0ZXN0IHVzZXMg
a3NlZmxmdGVzdCBpbmNsdWRlZCBpbiB0aGUgbGF0ZXN0IGtlcm5lbC4NClRoZXJlIGFyZSBubyBw
bGFucyB0byBiYWNrcG9ydCB0ZXN0cyB0byA0LjQgb3IgNC4xOS4gSSBiZWxpZXZlIHRoYXQga3Nl
Zmx0ZXN0IGluY2x1ZGVkIGluIHRoZSBDSVAga2VybmVsDQppcyBpbmFkZXF1YXRlIGluIGZ1bmN0
aW9uIGFuZCBkaWZmaWN1bHQgdG8gdXNlIGFzIGl0IGlzLg0KSSBzdWdnZXN0IHVzaW5nIGEgbmV3
IGtlcm5lbCB0ZXN0IHRoYXQgaW5jb3Jwb3JhdGVzIHRoZSBsYXRlc3QgdGVzdHMuDQoNCkJlc3Qg
cmVnYXJkcywNCiAgTm9idWhpcm8NCg0KDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpjaXAtZGV2IG1haWxpbmcgbGlzdApjaXAtZGV2QGxpc3RzLmNpcC1w
cm9qZWN0Lm9yZwpodHRwczovL2xpc3RzLmNpcC1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2NpcC1kZXYK
