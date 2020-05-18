Return-Path: <SRS0=Os6S=7A=lists.cip-project.org=bounce+64572+4631+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 300C9C433DF
	for <cip-dev@archiver.kernel.org>; Mon, 18 May 2020 13:32:43 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1F2F207D3
	for <cip-dev@archiver.kernel.org>; Mon, 18 May 2020 13:32:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="GfRZV4tx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1F2F207D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4631+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id RFKvYY4521723xcOksmzDgU8; Mon, 18 May 2020 06:32:42 -0700
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.153])
 by mx.groups.io with SMTP id smtpd.web12.41705.1589808760145213826
 for <cip-dev@lists.cip-project.org>;
 Mon, 18 May 2020 06:32:41 -0700
X-Received: by mo-csw.securemx.jp (mx-mo-csw1514) id 04IDWbuQ012277; Mon, 18 May 2020 22:32:37 +0900
X-Iguazu-Qid: 34trWq5axPkdHOTw7k
X-Iguazu-QSIG: v=2; s=0; t=1589808757; q=34trWq5axPkdHOTw7k; m=9DHJr8qni+0EIy6/PsNe7xbx0nnxz3y281ioiLQh54g=
X-Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
	by relay.securemx.jp (mx-mr1511) id 04IDWap6018233;
	Mon, 18 May 2020 22:32:37 +0900
X-Received: from enc02.toshiba.co.jp ([61.202.160.51])
	by imx12.toshiba.co.jp  with ESMTP id 04IDWauH023403;
	Mon, 18 May 2020 22:32:36 +0900 (JST)
X-Received: from hop101.toshiba.co.jp ([133.199.85.107])
	by enc02.toshiba.co.jp  with ESMTP id 04IDWa1X028369;
	Mon, 18 May 2020 22:32:36 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OlCe045IhNrnUCayC7UDbypmvun+Nr7Go4TQR1Tcm0sDmg4Jf5knCV3LKDrm90LFN0lsosd99D7PR2oTX7A70/pbFOyr89ybcyvk0qDABYyOhJMF3nGs2ETMchMS+U5I6k0s+i4UQYJhikA4kkFs2Ydm1RSMhsQYsOqnYg6mmW/n5TsN+qkzFK8djoGDN8iieHJBizpRnsQQKIN/0nfWrNHcixr+hS4RZ9nMUTzzS8FT7s2MCTJw8dr9mvzQFiOmOAmnqmI6C14X7fXP2Ogf9I2u3nrbbBhehK96VE2EWbdAuMPTuE/ul5znyLVcHioZBz2CB/h7KcZTxTuhjypqCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=75Cl2O8OapWFIQ9wlaL3xlN3KLrrQR2M/HHgiM+jzUQ=;
 b=HJR2nTLzRFQwTV152ey4PEdRSGajxcYf69wS8oaZJ0dZ6Jy9atPhDoBP4B9GLZip47xekYOGe4Vr8HMUAtE4l0ilBdtj876+lYJr6+J3nCzblxcKGJBtwaFZwdFly0MaMmIRTnCcclwLpJtmjFg1lSHKe3dVaJ87eNaNoNzE1A02hoTX2Isa8C7k/TM8eGM2w36xnOqbxhs9/YxjPB3BvB8ce2eqxbYHGY4vq6MLd8F0kw9HZrrV4EyrspHr4SBAwI3AGsKWsW0joJhCw+gw6fmaN0iyW2/sJljHhsvfIKjIjFFWNoMxfZnaAkeZpk1BplHt4AXMNepjoLUY7reKGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: "Daniel Sangorrin" <daniel.sangorrin@toshiba.co.jp>
To: <quirin.gylstorff@siemens.com>
CC: <cip-security@lists.cip-project.org>, <cip-dev@lists.cip-project.org>
Subject: Re: [cip-dev][isar-cip-core] Integration of test and security dependencies with cip-core
Thread-Topic: [cip-dev][isar-cip-core] Integration of test and security
 dependencies with cip-core
Thread-Index: AdYs0vpAUKy4cgndQaKwQlyaddtP7gAFtRAQAAFh8IAAChvJcA==
Date: Mon, 18 May 2020 13:32:31 +0000
X-TSB-HOP: ON
Message-ID: <OSBPR01MB2053A9E6B06C6B94086E1F83D0B80@OSBPR01MB2053.jpnprd01.prod.outlook.com>
References: <OSBPR01MB2053900CD653D4E5CD4278EAD0B80@OSBPR01MB2053.jpnprd01.prod.outlook.com>
 <OSAPR01MB2385B768C9B6FF689451C626B7B80@OSAPR01MB2385.jpnprd01.prod.outlook.com>
 <83617f18-4aed-f6cb-6ba6-2cb8e274d5be@siemens.com>
In-Reply-To: <83617f18-4aed-f6cb-6ba6-2cb8e274d5be@siemens.com>
Accept-Language: en-US
x-originating-ip: [103.91.184.0]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7b81d236-dce9-4ffe-a0c2-08d7fb2fec44
x-ms-traffictypediagnostic: OSBPR01MB2885:
x-microsoft-antispam-prvs: <OSBPR01MB2885992A57456C3BD760CFA2D0B80@OSBPR01MB2885.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 9irAB/F79VB7i8T4Vu+1ZTkznoo5E1O6WXsBVc9BK17QB+crf9izns5rPQelVfE+Y6MBRn4zD7Z5rhUqV4uU7Rey0kLvdxAYPBn0rE8CDdDVgQC+PzpDa/lNdDDIjbWHeCR8hXXwaEWuKm1QbNkD9Urls5NARNOxwLuUhYlYmd6zChycpFbVsyXmz7Lumg/5/kQaUeCQoNxkEp2ePb/X2ZpA5qWZSw/yaH7jOm/z0iKuJBjkK5AUygqXZj2Fcezq5SsKn2NPFgEI795KzMJnxlAU6OAntSmowBiXZsrMRH+MnRZOuxGE+bNHTY8rKi+EsGBMYwi17kyEUi2dw+tEZ2PfDukCPEecGFHodoscs8pfmu88LcApTxpbX+jmccGS1nA69+g2LigZVMCaNBEHOX8OgH4O9qyLr4Ew5RLwvdAUy0RsHnm3aQq/ZYPs08Qu
x-ms-exchange-antispam-messagedata: SFmdWCV+TNg6LHoiO3O8lqMY1eydI2hkwMVE9xxHwnoPTkXRNn40ukkQo8Pz+qoJtVapM3UpsaRoY2sKH4vhh9LIU9J2h3ZKhmb0PKi39InWrBBrEX8qHcrqhzRgRe4zjqVSdkQLrPmD0QB6SKpb1auZuZ+LeBMLzUlK/WlLXAq3pS3lMKAG5KYEYVhe3SsXvR8IGvz2KoPVJ2CbCwr/D1QMJeLdjl9FgdMfxrhuI5u2N+4Qe2Qbth2BC0lvQJdHCTe6baODN2zOBOZmBBLlDQZLm8KJ34BN6fGEuXFSp/dHcFbtXIAlKXA1mExpvEDRd6iJd60GfFaxudz4OJl2GelSp6KyyDIq7bnRjkCgRQNFaSAp70UuKQgjCJc1dZg7sK+s4VtQ2TCx8IVoJihKM/oHG7qzVdEmzarRdHsHlZf1VEyjTJno/AEj6RNO6UZ+nm7ICMa/QXonB+/mk2JNFgIUqzfzFESJhnb5k4f1uWs=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b81d236-dce9-4ffe-a0c2-08d7fb2fec44
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2020 13:32:32.7388
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xYJP0fUPkAIiA4Ewdr+SXBdoQbSbxT778eKxQdT2hKDSazM1yBnjMQTPHiYnVp1QZWxZ4Fs2tA9j1GCSw1F7B2EzphFAdb8tjg2EBGkHnsA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB2885
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: NTcuVwk82eaHGZM2M3JZTYB3x4520388AA=
Content-Type: multipart/mixed; boundary="AsgnYoUUHwsU0d0HzX3I"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1589808762;
 bh=W0VaM5TDgzqaQVvtB1Sbj4yUngtob0LAoAy7YP8DPyU=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=GfRZV4tx4lbpaLC0tuh2yGWnnK4vMN69sjo/0mAW2b4tonuEY73q61oGooPEy37AWky
 GoCLqGXhy0eD7EVumfqXj+R3cNrG7KG6HKnDVrNS4nLJp0k0TexZkuuHVyAgULyETsCxI
 78Vna1+qD6snDGP9Oh9UW+jpqfjeQwmRHM4=

--AsgnYoUUHwsU0d0HzX3I
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

PiBGcm9tOiBjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZyA8Y2lwLWRldkBsaXN0cy5jaXAt
cHJvamVjdC5vcmc+IE9uIEJlaGFsZiBPZiBRdWlyaW4gR3lsc3RvcmZmDQo+ID4gTXkgcHJlZmVy
ZW5jZSB3b3VsZCBiZSBmb3IgdGhlIHdob2xlIGZpbGVzeXN0ZW0gaW5jbHVkaW5nIHRoZSB0ZXN0
IHBhY2thZ2VzIHRvIGJlIGJ1aWx0IGJ5IElTQVIsIHRoZW4gTEFWQSBqdXN0DQo+IGRvd25sb2Fk
cyB0aGUgJ2xhdGVzdCcgY2lwLWNvcmUtdGVzdCBpbWFnZSB3aGVuIHJ1bm5pbmcgdGVzdHMuDQo+
ID4NCj4gDQo+IE9ubHkgYXMgaW5mbyBMVFAgaXMgcGFydCBvZiBpc2FyLWNpcC1jb3JlIGluIG5l
eHQgc2luY2UgY29tbWl0DQo+IGY4NGE4MTVkYzY5NjllYjJiMGIyNzZlMTVjOGZjZTJkNTI5Mzcx
MTQNCg0KVGhhbmtzIGZvciB0aGUgaW5mbywgUXVpcmluLg0K

--AsgnYoUUHwsU0d0HzX3I
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4631): https://lists.cip-project.org/g/cip-dev/message=
/4631
Mute This Topic: https://lists.cip-project.org/mt/74286250/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--AsgnYoUUHwsU0d0HzX3I--
