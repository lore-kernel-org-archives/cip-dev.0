Return-Path: <SRS0=n8Lp=7P=lists.cip-project.org=bounce+64572+4658+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2F43C433E0
	for <cip-dev@archiver.kernel.org>; Tue,  2 Jun 2020 04:50:39 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1EF7A20878
	for <cip-dev@archiver.kernel.org>; Tue,  2 Jun 2020 04:50:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="BURp1F/m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EF7A20878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4658+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 1vp5YY4521723xLpbJULH5Q5; Mon, 01 Jun 2020 21:50:38 -0700
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.153])
 by mx.groups.io with SMTP id smtpd.web12.3864.1591073435527217046
 for <cip-dev@lists.cip-project.org>;
 Mon, 01 Jun 2020 21:50:37 -0700
X-Received: by mo-csw.securemx.jp (mx-mo-csw1514) id 0524oXOG003099; Tue, 2 Jun 2020 13:50:33 +0900
X-Iguazu-Qid: 34trSYR0f3ho9ioGNe
X-Iguazu-QSIG: v=2; s=0; t=1591073432; q=34trSYR0f3ho9ioGNe; m=tRmvIuHVxKvrcXipvfnM05XnJRvJE2nKcl/xrCZ+MPc=
X-Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
	by relay.securemx.jp (mx-mr1510) id 0524oVfv040504;
	Tue, 2 Jun 2020 13:50:32 +0900
X-Received: from enc02.toshiba.co.jp ([61.202.160.51])
	by imx12.toshiba.co.jp  with ESMTP id 0524oVCH006691;
	Tue, 2 Jun 2020 13:50:31 +0900 (JST)
X-Received: from hop101.toshiba.co.jp ([133.199.85.107])
	by enc02.toshiba.co.jp  with ESMTP id 0524oVEV021047;
	Tue, 2 Jun 2020 13:50:31 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OX6jwh+rm+EvS/1Azvl+zWQZD7y6BbLRZgnWGlALF2u5039vb+m+KtCiOcFA1Na8vmsbqKuwIhv1mmmQXT3Xy4JrvlgiLozlYY2QYfSAgz0Rbda7GTew1/JctqJnHyLPmaKrZxaBTXoFMLHrk3/s+P4wtF718gaLqqrse45QWtH7T9anVBu1IlD612ySDPh76LxHxarZWBCymgxV2KoE+2/vcRIo2udB9ITsIQmDG2xdiEMym7CTKqiKWpmgFX1jQWYR6kx1PBkSRcaAg8P8WEBIO9qxs5KIyv0mTBNEnlBvyJXMSZ/SBuLWHjkT/07A6nM6bCo6XcXeqeYO7OSgcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zk3NWLr/V6lo4qm1KcDeHQllLmw0nGzdpbEB+uUAXu8=;
 b=MuqgI+RhvPW3w3EntQ3wQhUTvYjwRr+UNF4Vc9jeEP2LhvMVNFRaSFFj85kie81BB9K56XsHPRD8wCEYWRFin3SDE1C/6PgtHxAGmYX2gYGAMlaBrI2RnA6Lf+Qt3L+sl+fcshF0qpl60ZXrdYsrqOGOgX+ttD90aTj2XxZWehotR7mRjYQLbcV4QGGoXOydT7I7rkp1aCAJsApZXH/djCJSNCCZmy/fVWerU7Vfrprcxk4/hLu7d4r6LHAbGNOe+PdWrtD6aJW1LVTprgS7eXlGon/C5eEfhRpeCuj+hDoHQzRwBkV7nE0t2i6rzcDde7XSMnV1E+x0u71hRLlepg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: "Nobuhiro Iwamatsu" <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
CC: <SZ.Lin@moxa.com>
Subject: Re: [cip-dev] Kernel config warning
Thread-Topic: Kernel config warning
Thread-Index: AdY4YgxrtHSDBaMZSpup0T/oNPPVRAANwYUw
Date: Tue, 2 Jun 2020 04:50:28 +0000
X-TSB-HOP: ON
Message-ID: <OSBPR01MB29830C43714592989F515599928B0@OSBPR01MB2983.jpnprd01.prod.outlook.com>
References: <OSAPR01MB2385ECC888BFA203140CA3CEB78A0@OSAPR01MB2385.jpnprd01.prod.outlook.com>
In-Reply-To: <OSAPR01MB2385ECC888BFA203140CA3CEB78A0@OSAPR01MB2385.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
x-originating-ip: [103.91.184.7]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 139b4249-da73-429e-f18e-08d806b07927
x-ms-traffictypediagnostic: OSBPR01MB4405:
x-microsoft-antispam-prvs: <OSBPR01MB44050DE8537380441A0B473A928B0@OSBPR01MB4405.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:114;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 4MncyDI7C7eQey+FzvNbJtN/aaxwKxx9KaRA7ksOw+6sdT0OSAGaKpXiVJYvXsJ3UQbZiq7xr1yQt8DUUR3XQiRACzibNZTp55ALZ8AgHz8b+8IIh8u8d0E8Rj0sJ+6uH5uBoLouqx5tQrH9MbFSQvto5JpTRGEAJaJkAfghtb27/X1ZznAWeiBnE9jVF28SepoKCLyCmvfIe5JjnhCiVouFNxvUTW80jTu6nasiNYSBnMndwoPodBcz53X/pd1mQTtCqDg40FUPAB+dO9bgpF8BvVranyq491bBKM1oQlgmlkGCXhaaNKg2XOZYyaTHJraR5KNzzKLMZy5j0eP1Y1grHXFBDdp4sNh70A4Grpxf+cP7WDnS8ULMvk1b/rsIBveZ7gG3Hs12NHlmZ2zZmw==
x-ms-exchange-antispam-messagedata: LMnX0ZNr1qz10Ws8Hha60wl5M9fp2JmubRPm7tN2IQkbhabzpzyQrc6iiuOXa0ef1DJJZtzv8QfNMpn5zi/NXL6dcbmM7GUlDs7N1maC+zlzyGWjGOurq6MIKiUafLy/STulw8DpaJrIKJqGM21t9ifUixwdMw+KlDFhraSX6aYkws/UD3gSZ2iF2NCXdz+ANk7sN6sId2ypbm0nJfJLVpizrNTLrRc5sWy9l/9N5hBAlgy2SLL/2Fysl59nveLFMQ3TXU0h5OBORRSsptKy2dqNREuF64pjkODeAPn9Dy8P9/Z+LcOh+PymYosbGyOajDnQRouzpJewuqZ/CQGwNWEwyVu4zWA1zH6AA7T5b67ReGn3Lgk8Y8T8/W5rz4mUmsXHx25W4SRHYZgDeiOBiBlCTwNLu8b8f2I+W5Uw9ZHJFnuNunlDiyNBp5yj9DVZXDPMpDZ9ifyxE4DhHKs+PWauE1SG9NkpVhxDTqy6wug=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 139b4249-da73-429e-f18e-08d806b07927
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2020 04:50:28.8917
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: spfq9EeLwKsS612EoceotEijEG7+7BcTcrEbzmn1xHXqJBDqc7y2n/CAEBklsTtY0222G7/9R+21GmHr9jUnldHd9GsRh1jaK74+J6ovh8b2MSsPSJ8fHTwmReoWATEo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB4405
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 7NhKFbnphdRkUQBTcV68HUnRx4520388AA=
Content-Type: multipart/mixed; boundary="dGmKHrHbmaR2JkGrkSnv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1591073438;
 bh=G4uVOeFx6OpHII9xxZXtBgH+7t4CQx0qGy9BxASgGhc=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=BURp1F/mjkM6sNFs84vcxjn24VH4cxbkwdLuD06l3jxv4nSIHS0YQel5U9B+2b7gNTc
 qu963slEITXj91U10VUzuKsUBHed7voygQMGGS4VUzGgcDyMqS5vOlKiLwxNRk2UgnIud
 YPaxjls0Z+6pj5U9BSIdLMMG7R3briN+ivM=

--dGmKHrHbmaR2JkGrkSnv
Content-Language: ja-JP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGksDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogY2lwLWRldkBsaXN0
cy5jaXAtcHJvamVjdC5vcmcgW21haWx0bzpjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZ10g
T24gQmVoYWxmIE9mIENocmlzIFBhdGVyc29uDQo+IFNlbnQ6IFR1ZXNkYXksIEp1bmUgMiwgMjAy
MCA3OjE4IEFNDQo+IFRvOiBjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZw0KPiBDYzogU1ou
TGluQG1veGEuY29tDQo+IFN1YmplY3Q6IFtjaXAtZGV2XSBLZXJuZWwgY29uZmlnIHdhcm5pbmcN
Cj4gDQo+IEhlbGxvIEtlcm5lbCBtYWludGFpbmVycywNCj4gDQo+IEkgc2F3IHRoaXMgd2Fybmlu
ZyBbMF0gYnkgY2hhbmNlIHRoaXMgZXZlbmluZyB3aGVuIGRvaW5nIGEgYnVpbGQgd2l0aCB0aGUg
bW94YV9teGNfZGVmY29uZmlnIFsxXSBLZXJuZWwgY29uZmlnLg0KPiANCj4gSXMgdGhpcyBzb21l
dGhpbmcgd2Ugd2FudCB0byBjb3JyZWN0Pw0KDQpUaGFua3MgZm9yIHlvdXIgcmVwb3J0Lg0KUlRD
X0RSVl9EUzEzNzRfV0RUIGNhbiBub3Qgc2V0ICd5Jy4gSSB3aWxsIHVwZGF0ZSBtb3hhX214Y19k
ZWZjb25maWcuDQoNCj4gDQo+IFswXQ0KPiAiYXJjaC9hcm0vY29uZmlncy9tb3hhX214Y19kZWZj
b25maWc6NzQ1Ondhcm5pbmc6IHN5bWJvbCB2YWx1ZSAnbScgaW52YWxpZCBmb3IgUlRDX0RSVl9E
UzEzNzRfV0RUIg0KPiBodHRwczovL2dpdGxhYi5jb20vY2lwLXByb2plY3QvY2lwLWtlcm5lbC9s
aW51eC1jaXAvLS9qb2JzLzU0NjA2NTY4OCNMMTI5DQo+IFsxXSBodHRwczovL2dpdGxhYi5jb20v
Y2lwLXByb2plY3QvY2lwLWtlcm5lbC9jaXAta2VybmVsLWNvbmZpZy8tL2Jsb2IvbWFzdGVyLzQu
NC55LWNpcC9hcm0vbW94YV9teGNfZGVmY29uZmlnDQo+IA0KPiBLaW5kIHJlZ2FyZHMsIENocmlz
DQoNCkJlc3QgcmVnYXJkcywNCiAgTm9idWhpcm8NCg==

--dGmKHrHbmaR2JkGrkSnv
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4658): https://lists.cip-project.org/g/cip-dev/message=
/4658
Mute This Topic: https://lists.cip-project.org/mt/74616319/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--dGmKHrHbmaR2JkGrkSnv--
