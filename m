Return-Path: <SRS0=GUfG=BG=lists.cip-project.org=bounce+64572+5016+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 844DBC433DF
	for <cip-dev@archiver.kernel.org>; Mon, 27 Jul 2020 02:47:59 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBD12206D8
	for <cip-dev@archiver.kernel.org>; Mon, 27 Jul 2020 02:47:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="KShjgn8Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBD12206D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5016+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id lfJxYY4521723xULcc2mje3d; Sun, 26 Jul 2020 19:47:58 -0700
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.web12.47688.1595818075336789449
 for <cip-dev@lists.cip-project.org>;
 Sun, 26 Jul 2020 19:47:57 -0700
X-Received: by mo-csw.securemx.jp (mx-mo-csw1116) id 06R2lrLI011532; Mon, 27 Jul 2020 11:47:53 +0900
X-Iguazu-Qid: 2wHHQAbmwvj4KmyWMD
X-Iguazu-QSIG: v=2; s=0; t=1595818072; q=2wHHQAbmwvj4KmyWMD; m=MEFiKEONL263uZ9/I/Y15dUTkRNyqXt3Ffgk79h/Q+M=
X-Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
	by relay.securemx.jp (mx-mr1113) id 06R2lpSo023422;
	Mon, 27 Jul 2020 11:47:52 +0900
X-Received: from enc02.toshiba.co.jp ([61.202.160.51])
	by imx12.toshiba.co.jp  with ESMTP id 06R2lpCC027128;
	Mon, 27 Jul 2020 11:47:51 +0900 (JST)
X-Received: from hop101.toshiba.co.jp ([133.199.85.107])
	by enc02.toshiba.co.jp  with ESMTP id 06R2lphA010204;
	Mon, 27 Jul 2020 11:47:51 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MtDUTuao6+6CNc6xEe3v7pDSj/GtumoqxMBw+EcXxHL54p3LzyIzW/PnXAciHNFEo8FvRYOR2SPOHxWTrWm5yMMpjWixK+w1UqB1TCIVaTlQqJMa6kCN/ONIRLvhxOKKktE8qlZXxbQ2Btd1yjGeuadiG07sDgXuOkANLSDTfRZe4RVasfVzqZoKyWVYSv5FsOv5yp0CEMrwSqugfwQ1SAxFP/lCxCgJNyHDDA9MeLwq9KYLOguObqW5gSQunRz6Zr3u2libEXdUJ/fnGsBrc8w+SYKrg5grY27Y5kZLvbH7LeDiOvKv/+9DC36Fzbzwk1bm427l71KLtzT+zRY5YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ttfrcrGl3gnQSqftREKqUlEn1uda9sRfp+HNCKy/lJ8=;
 b=jX9nU6+Kr8pwp8M8Cl3RVlBElJp+DkiySk/NCeeHqwnzXzHG6WbBDrSEd12ha4usfVs246qZVoEURNqEOvgqGmVZ1XZMpvdY6wwe45IjnH/+NRD4rLyvz53YI44Je2FbiRbyTXx5NXosyFexAZoWMZVTRHKByjWOLFlr+V1H1Yvv5/cT6Bh0ZUqWs5d4XuxdWz3AEyeiXrZ/pdlkcCU8QcF/oWCWKNm2pc8/ZFS4kmcp+e3p4WFpVBnZwdWqGtd+qRYbn8GhB0Ql7ZmMuleSocGkCbpBbF+CxbraGSNxlhkf75UEgzYTYMOFVNPSV0H6o4eUNbrt7m+oY9IKref2mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: "Daniel Sangorrin" <daniel.sangorrin@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>, <Venkata.Pyla@toshiba-tsip.com>,
        <jan.kiszka@siemens.com>
Subject: Re: [cip-dev] [PATCH 1/3] cip-security: Add packages for IEC-62443-4-2 Evaluation.
Thread-Topic: [cip-dev] [PATCH 1/3] cip-security: Add packages for
 IEC-62443-4-2 Evaluation.
Thread-Index: AQHWXzc25n0IzIqyC0ejDEcnbTWtIKkU/A6AgAAroICAAAr7gIAFiNLQ
Date: Mon, 27 Jul 2020 02:47:49 +0000
X-TSB-HOP: ON
Message-ID: <OSBPR01MB20532EF3D24322AEFD62700BD0720@OSBPR01MB2053.jpnprd01.prod.outlook.com>
References: <ab8b6d0d-aff4-cdfe-e926-385f62aae02d@siemens.com>
 <15065.1595510009905529924@lists.cip-project.org>
 <06f7fc59-f004-3d68-d169-0e7d41f33038@siemens.com>
In-Reply-To: <06f7fc59-f004-3d68-d169-0e7d41f33038@siemens.com>
Accept-Language: en-US
x-originating-ip: [103.91.184.0]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7480a015-8f2c-4e05-6dd8-08d831d77342
x-ms-traffictypediagnostic: OSAPR01MB3266:
x-ld-processed: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f,ExtAddr
x-microsoft-antispam-prvs: <OSAPR01MB3266A9C4052DC1A5FFAE53DDD0720@OSAPR01MB3266.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 1t/Tvj8MWQGrlH9PZ6l+5tbcsLeWMKH0xBSxQ0zD7Bd/W0mVZh0+f5JMawKGxg0fwaIqQY5JJf9Hj7XxAqD2ExtTFTD4E88hIJQcCPDpCuCV9mkhO1WCoCKnRPx4CzuWKYWOKbQGS8CmkHx9TE0Ewojf6FDEH0+M1S3lMoPaEtXhFOqIfpT2bWUBZCzcbEsvzFbmgpYDHW4+NvxODqjD/bv1gxLlCfoNKFpZK3vay8MixKyDJGUJ+gXAkgvLccd2xrwFhaEO5+ySzBJkghwtSSuPwgP0+Q4F17oBwFHQDvP9YIMN6EJ9N7INm5vvUxgmNkquUGeevO+jZWjUVNwToA==
x-ms-exchange-antispam-messagedata: fsKwPXhog29Ba7tU6tVJewIf0Im7vA92OeY+TS3I/d3TfZh193SyRK6ZTp1Xe6RThbggd9E3uNV8pSL2CoBmScVRrtIkB6IcWKOd+lyjwpRngLBiPG0bK6FRy9FMIqSt12iUk/O9YCWjFwKzvUEEebeWO9yJx1qyxappoKnsqBpWQEyZaUakxtpW2UzPzpheMvxABRzup3u4KV9//UItAYiFkmH8ZUydL9YkuPTxsOLvWsl8izyn2xJpeopif1NmWjxqqjaHckgJlH5kkakoRNLspFc2e/utp4nKH7YFy3mql/usD8s+3IEYxcimEVTQU9MEWDmGKdfTVYACnc6eykxXeAUeUKIxqE2k8XZD3RAnKSSzSkP7Fq4J15Ahx3U1ES12fMrXx9ByP7VAaKyEeGbjTh4c/psxdPuNx+N0SLYOH//JhDjT8z1r+qu6bvsKwld2tZebgYSXKch+ipISBS046MP3suUW+RFrkPXDTM0=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2053.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7480a015-8f2c-4e05-6dd8-08d831d77342
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2020 02:47:49.3848
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0v4y8RyeEhi6Eo2OlF7IcdRxS9VFb6IY/6+8S6kVhgaY7RhPw3sHoduxCgSYYGYD2xkZ0mDqOwLuVO5KcUzOkV8dS+3MHrJJHBOduBIdcOo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB3266
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: b8Nuw6ZtGdChrnYbgaY65Brmx4520388AA=
Content-Type: multipart/mixed; boundary="QeoGEV0B2QDSyJxtKzdQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1595818078;
 bh=GWI8HzWuwwQamkVaVRBZCAdXgisx+s73cBZhHNj/ano=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=KShjgn8ZhW2raSbj9lST1I6Wt4ieq4GXsAsxo6KiQurH/Yy2nrV/g8IsKDczXygDOoo
 TbB2v+Ny42o56EwAxEH2d45tg1LAz6fQB3kEvrOg0UF3qYttxEn2mQyDeGD5bzCsL7JV6
 W8ee+A7uPGb+ZfhEFFISa3D2kpxUFV95RXI=

--QeoGEV0B2QDSyJxtKzdQ
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGkgSmFuLA0KDQo+IEZyb206IGNpcC1kZXZAbGlzdHMuY2lwLXByb2plY3Qub3JnIDxjaXAtZGV2
QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZz4gT24gQmVoYWxmIE9mIEphbiBLaXN6a2ENCj4gU2VudDog
VGh1cnNkYXksIEp1bHkgMjMsIDIwMjAgMTA6NTMgUE0NCj4gRG9uJ3Qgd29ycnkuIFRoZSBzdWJt
aXNzaW9uIGxvb2tlZCBmYWlybHkgZ29vZCBvdGhlcndpc2UsIG5vdCBsaWtlIGZpcnN0LXRpbWUh
DQo+IA0KPiBCVFcsIEknbSBzdGlsbCBhbWJpdmFsZW50IHdoZXRoZXIgdG8gZG8gVUkgKE1Scykg
b3IgY2lwLWRldiBiYXNlZCBwYXRjaCByZXZpZXdzIGZvciBpc2FyLWNpcC1jb3JlLiBBcyBjb250
cmlidXRpb25zIGluY3JlYXNlLCB5b3UNCj4gY29udHJpYnV0b3JzIG5lZWQgdG8gZXhwcmVzcyB5
b3VyIHByZWZlcmVuY2UuIEknbSB1c2VkIHRvIGJvdGggYnkgbm93LCBJIGhhdmUgdHJvdWJsZXMg
d2l0aCBib3RoIGJ5IG5vdy4gSG93ZXZlciwgd2UganVzdCBuZWVkIHRvDQo+IGNvbnNvbGlkYXRl
IG92ZXIgb25lIHN5c3RlbSBiZWNhdXNlIHdlIGNhbid0IGNvdXBsZSB0aGVtIHJlYXNvbmFibHku
DQoNClBhdGNoZXMgZ2l2ZSB5b3UgZ3JlYXRlciB2aXNpYmlsaXR5IChhbGwgY2lwLWRldiBtZW1i
ZXJzKSwgYnV0IEkgY2FuIHNlZSBzb21lIGJlbmVmaXRzIGluIHVzaW5nIE1ScyBhcyB3ZWxsOg0K
KiBtZXJnZSB3aGVuIHRoZSBwaXBlbGluZSBzdWNjZWVkcw0KKiBtYXAgaXNzdWVzIHdpdGggdGhl
IHBhdGNoZXMgdGhhdCBjbG9zZSB0aGVtDQoqIGRpc2N1c3Npb25zIGFyZSBrZXB0IGNsb3NlIHRv
IHRoZSBjb2RlDQoqIG5vIG5lZWQgZm9yIGd1cnUgZS1tYWlsIGNsaWVudHMgdGhhdCBkb24ndCBt
ZXNoIHdpdGggeW91ciBUQUJzIExvbC4NCiogdGhleSBhcmUgbW9yZSB1c2VyIGZyaWVuZGx5IChw
dXNoIHRoZSBtZXJnZSByZXF1ZXN0IGJ1dHRvbiBpbnN0ZWFkIG9mIGhhdmluZyB0byBjb25maWd1
cmUgZ2l0IHNlbmQtZW1haWwgd2hpY2ggY2FuIGJlIHByb2JsZW1hdGljIGluIGNvcnBvcmF0ZSBl
bnZpcm9ubWVudHMpDQoNCkkgYW0gb3BlbiB0byB1c2UgYW55IG9mIHRoZW0uDQoNClRoYW5rcywN
CkRhbmllbA0KDQo=

--QeoGEV0B2QDSyJxtKzdQ
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5016): https://lists.cip-project.org/g/cip-dev/message=
/5016
Mute This Topic: https://lists.cip-project.org/mt/75699592/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--QeoGEV0B2QDSyJxtKzdQ--
