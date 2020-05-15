Return-Path: <SRS0=nENq=65=lists.cip-project.org=bounce+64572+4622+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93A37C433E0
	for <cip-dev@archiver.kernel.org>; Fri, 15 May 2020 00:46:44 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0A1A206B6
	for <cip-dev@archiver.kernel.org>; Fri, 15 May 2020 00:46:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="Mrob4SYA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0A1A206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4622+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id v9pSYY4521723xNFSZCZwavp; Thu, 14 May 2020 17:46:43 -0700
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.153])
 by mx.groups.io with SMTP id smtpd.web10.4951.1589503600713503100
 for <cip-dev@lists.cip-project.org>;
 Thu, 14 May 2020 17:46:42 -0700
X-Received: by mo-csw.securemx.jp (mx-mo-csw1514) id 04F0kV5G010980; Fri, 15 May 2020 09:46:32 +0900
X-Iguazu-Qid: 34trcFcTSi6EgfrARm
X-Iguazu-QSIG: v=2; s=0; t=1589503591; q=34trcFcTSi6EgfrARm; m=NEzLQKC3gWlc6MjrYp8ZLXuvjEyaw719Q5uxYRzZLjs=
X-Received: from imx2.toshiba.co.jp (imx2.toshiba.co.jp [106.186.93.51])
	by relay.securemx.jp (mx-mr1513) id 04F0kUBG003023;
	Fri, 15 May 2020 09:46:30 +0900
X-Received: from enc01.localdomain ([106.186.93.100])
	by imx2.toshiba.co.jp  with ESMTP id 04F0kUpI003408;
	Fri, 15 May 2020 09:46:30 +0900 (JST)
X-Received: from hop001.toshiba.co.jp ([133.199.164.63])
	by enc01.localdomain  with ESMTP id 04F0kU5T000559;
	Fri, 15 May 2020 09:46:30 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ihkikWADpjLAGVh2OSBI+DeP5++qe6xmxP9D08YXWL7ptTyubISpxMUTetM1rigGWf+JiyS4kx8e6tlWPfMqj96T7ZzM13UKO7dZMAFD++jjU9Zu5nOqUHUyplVu9fI2+uOcoFQusUbwp1O8tKtY5/ckI4PCFGt/yzIJ9OTcToB/G/7dZ66ksEE5s3WM7krDl3txNYvBf57a+yuY6uOk8fp25PGa/4xYbpdsnUIy91ZUqzht+UVRP+K/1TVfmZQhVnehQWaF+9GZNI/m6qKEyKRk4NgIyKHZj39hBkrwp6yGiH2EFfXLfqBv2PnNsyEGujC8+/0Go8Hqxf3EWfTrqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u2lYLtiG4oBa6fay+EeGiADVMdH2y2158Tz21Jv/AuE=;
 b=HmCoWSdcWKnDsTghnu2rOX+LUBXP5Kjf4FIEWAajhFx+wgLkpp+tyOqpZyPKt2kdcjJiGkE/W4az8+x5wg/BXfLy5bkU1Fu6eyEEp1CYs++/i4FjX5ZoXVC4Yd9mm3Oe02w2T86+lq6sTljs7jZy919/tCqVNNa0WkqpmbzGSlg52m89wsi0EDRUpwYaPJ7fMPr5L2DHAfFUUrW8vTc+IOSl5jjM53DhSzBdcpdX63urbBQna1ZOBTNYpf34RFBSQSYIfZO/Mh4cYLiDrbc+fkRjoWQ4G5UX4056bRC/KlXZvIo79udI3P5uE61IpcjRMX63Ut+0q4qzBlk5WLdzEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: "Nobuhiro Iwamatsu" <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <pavel@denx.de>
CC: <cip-dev@lists.cip-project.org>
Subject: Re: [cip-dev] CVE-2020-12770: easy backport of sg code
Thread-Topic: [cip-dev] CVE-2020-12770: easy backport of sg code
Thread-Index: AQHWKjp9pYdkI1X7qE2dNssQpNa+3KioT/aA
Date: Fri, 15 May 2020 00:46:28 +0000
X-TSB-HOP: ON
Message-ID: <TYAPR01MB29901D208818C6787E91ECB592BD0@TYAPR01MB2990.jpnprd01.prod.outlook.com>
References: <20200514215552.GA18872@amd>
In-Reply-To: <20200514215552.GA18872@amd>
Accept-Language: ja-JP, en-US
x-originating-ip: [103.91.184.3]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 38f4f28d-5f34-49f3-d453-08d7f869672c
x-ms-traffictypediagnostic: TYAPR01MB3151:
x-microsoft-antispam-prvs: <TYAPR01MB31517DEDF0B14439AE53F40992BD0@TYAPR01MB3151.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1775;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: TbYSKXgHksfZAngFT6uB3UNZwJyV0rVVrbGRxXkD/Rx/nczfJ9TqrJN0Y55GBYpj8Qxkn26B2kQQy3WBZHSLaPYqP2uC0vtH8W5OKSeArAZkItgWpN9G0TKA/fopGgfCu2HnhkDjh8PU2CxMlqZqu2Ik5meX8ffaaa9VdekNzTIf7COjwvnlAmrznYSHF0YYKGBzJs/ozAxN9EjyCnqYMMl2jiPun6Oaq/7Z6sR5VelO7uD3psRgP/7OItFgnMeHjW4VM45c63FhpBSyFgiW3UKMJVS21x5IFEF57NYz4WQ5plPPboLcTGJCF2PkLz4vGFea7zSBTaaN2tkjT+1HsE5YGi+VNPS49GAp/ZnjQD2Wk0R4Lhwup95THXllYeVhZB8qlNYg8KUBJPY3woy8Nvcf3Bcj+4VTd6XLoSMAONtIkRrKzbpL/Z3r/bpj3WDD3JTYLb/C6pbLaL7w5MCVftfpbtOn2zsuXQ/Bv6VbRfyaVehxA5YBWC1k8O1zVDR5l0jSuDx2wYfKg5431xO4GA==
x-ms-exchange-antispam-messagedata: JxjwcFVLEkOgmWNRphYEnNIpWI+ob4nh9X53C3X4VU/zpjaOsVQbP4adgkdZrOpcIJPV3GwuEKx5kGcAYckC8iwCs3bt+0YSJSJBPDzjpP/LX/OBJUnIn/YRxWTf1Kda2ocgzdy515z5p4Pq4VV0gvk8ZgOpKKDbkd+Asjy4OeavdwI9pjISTWSz2EuvLngOHZOksFZ4yI0onUy37IjFW7xs4zs/BPwJ0icFadOdm0VpNNuSBeF3+akjC5IoPLWCaIGztl3plIGiibE99rwUGi3hvzRGvMvQgOTeLp4GieS9CpOwSDWn7nP4r4oT0rxw3O8ItBXKPNY+/juErqrJYHUrzgw8llU281KcX/yrUM05bYDUzxkhb5lRgZcOZ2L6CUCIv97BcSvbIifaSxlno2LBT4Azkfw1WD5AjCizKrGRHbyunEUC1QsknoqIJtJ7dmppYJGg7/OmA5AJ20xOLm/U8liYFjfuk8sZjvgSATM=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 38f4f28d-5f34-49f3-d453-08d7f869672c
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2020 00:46:28.1696
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w0FSQ2Kyb9Xo0i91BejXR/CW/eiE+L468ETPfbhYoCFq4LRy+ezw6vqUkWYolmXLvaAL8UvTssKh3p7pCm90tbGYWG0iom3cDvTSrJ9bdBnnhdRCN/ETweNX7XMwsiv5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB3151
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: JZXPyXnEl82oU3OV3ZEbqqsUx4520388AA=
Content-Type: multipart/mixed; boundary="JOb6ze8FLuWNTufbTUmt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1589503603;
 bh=k95fAgURiVF3wK/cwEGWXgHuqA/SC/Yb0Jz/3LIIYxQ=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=Mrob4SYA1U2cY8vJIwd5lli0Usca8gUjUhjn58iUzLUmoJyc55kO0sGudqeq0W8H5ng
 0hyqX2jfKUddXAvGW6sTpvFf0YV3BZ6UAodOHr3RxrNrNvfOaxEIpL1iTqHvEZekJzo3f
 bEInMWcNo/9QomtZDk1VtlTRccv52sJzTLw=

--JOb6ze8FLuWNTufbTUmt
Content-Language: ja-JP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGkgUGF2ZWwsDQoNClRoYW5rcyBmb3IgeW91ciB3b3JrLg0KSSB3YXMgYWxzbyB3b3JraW5nIG9u
IHRoaXMuDQpCdXQgdGhlIHNhbWUgcGF0Y2ggc2VlbXMgdG8gaGF2ZSBhbHJlYWR5IGJlZW4gcG9z
dGVkIGJ5IEd1ZW50ZXIgUm9lY2suDQoNCiAgaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvc3RhYmxl
LzIwMjAwNTE0MTUwNTUxLjI0MDI3NS0xLWxpbnV4QHJvZWNrLXVzLm5ldC8NCg0KQmVzdCByZWdh
cmRzLA0KICBOb2J1aGlybw0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206
IGNpcC1kZXZAbGlzdHMuY2lwLXByb2plY3Qub3JnIFttYWlsdG86Y2lwLWRldkBsaXN0cy5jaXAt
cHJvamVjdC5vcmddIE9uIEJlaGFsZiBPZiBQYXZlbCBNYWNoZWsNCj4gU2VudDogRnJpZGF5LCBN
YXkgMTUsIDIwMjAgNjo1NiBBTQ0KPiBUbzogY2lwLWRldkBsaXN0cy5jaXAtcHJvamVjdC5vcmcN
Cj4gU3ViamVjdDogW2NpcC1kZXZdIENWRS0yMDIwLTEyNzcwOiBlYXN5IGJhY2twb3J0IG9mIHNn
IGNvZGUNCj4gDQo+IEhpIQ0KPiANCj4gU28gbGV0IG1lIGludmVzdGlnYXRlLi4uIE1haW5saW5l
IGZpeCBpcyBjb21taXQgODNjNmYyMzkwMDQwZjE4OGNjMjViMjcwYjRiZWZlYjU2MjhjMWFlZS4N
Cj4gDQo+IEJhY2twb3J0IGZvciA0LjE5IGxvb2tzIHJlYWxseSBlYXN5LCBhbmQgSSBjYW4ndCBz
ZWUgYW55dGhpbmcgd3JvbmcNCj4gdGhlcmU6DQo+IA0KPiBjb21taXQgYzQ1ZTNiY2RlYmIyMDRl
ZjFiYTFkMDBmNDFmZTdlZDM5YzRkZDhjZA0KPiBBdXRob3I6IFBhdmVsIE1hY2hlayA8cGF2ZWxA
dWN3LmN6Pg0KPiBEYXRlOiAgIFRodSBNYXkgMTQgMjM6NDc6NDIgMjAyMCArMDIwMA0KPiANCj4g
ICAgIEJhY2twb3J0Lg0KPiANCj4gICAgIGNvbW1pdCA4M2M2ZjIzOTAwNDBmMTg4Y2MyNWIyNzBi
NGJlZmViNTYyOGMxYWVlDQo+ICAgICAuLi4NCj4gICAgICAgICBzY3NpOiBzZzogYWRkIHNnX3Jl
bW92ZV9yZXF1ZXN0IGluIHNnX3dyaXRlDQo+IA0KPiAgICAgICAgIElmIHRoZSBfX2NvcHlfZnJv
bV91c2VyIGZ1bmN0aW9uIGZhaWxlZCB3ZSBuZWVkIHRvIGNhbGwNCj4gICAgICAgICBzZ19yZW1v
dmVfcmVxdWVzdA0KPiAgICAgICAgICAgICBpbiBzZ193cml0ZS4NCj4gDQo+ICAgICAgTGluazog
aHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvci82MTA2MThkOS1lOTgzLWZkNTYtZWQwZi02Mzk0Mjgz
NDNhZjdAaHVhd2VpLmNvbQ0KPiAgICAgIEFja2VkLWJ5OiBEb3VnbGFzIEdpbGJlcnQgPGRnaWxi
ZXJ0QGludGVybG9nLmNvbT4NCj4gICAgICBTaWduZWQtb2ZmLWJ5OiBXdSBCbyA8d3VibzQwQGh1
YXdlaS5jb20+DQo+ICAgICAgU2lnbmVkLW9mZi1ieTogTWFydGluIEsuIFBldGVyc2VuIDxtYXJ0
aW4ucGV0ZXJzZW5Ab3JhY2xlLmNvbT4NCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3Njc2kv
c2cuYyBiL2RyaXZlcnMvc2NzaS9zZy5jDQo+IGluZGV4IDhhMjU0YmI0NmE5Yi4uNGYwMGQzMDYy
YmQ2IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3Njc2kvc2cuYw0KPiArKysgYi9kcml2ZXJzL3Nj
c2kvc2cuYw0KPiBAQCAtNjk0LDggKzY5NCwxMCBAQCBzZ193cml0ZShzdHJ1Y3QgZmlsZSAqZmls
cCwgY29uc3QgY2hhciBfX3VzZXIgKmJ1Ziwgc2l6ZV90IGNvdW50LCBsb2ZmX3QgKiBwcG9zKQ0K
PiAgCWhwLT5mbGFncyA9IGlucHV0X3NpemU7CS8qIHN0cnVjdHVyZSBhYnVzZSAuLi4gKi8NCj4g
IAlocC0+cGFja19pZCA9IG9sZF9oZHIucGFja19pZDsNCj4gIAlocC0+dXNyX3B0ciA9IE5VTEw7
DQo+IC0JaWYgKF9fY29weV9mcm9tX3VzZXIoY21uZCwgYnVmLCBjbWRfc2l6ZSkpDQo+ICsJaWYg
KF9fY29weV9mcm9tX3VzZXIoY21uZCwgYnVmLCBjbWRfc2l6ZSkpIHsNCj4gKwkJc2dfcmVtb3Zl
X3JlcXVlc3Qoc2ZwLCBzcnApOw0KPiAgCQlyZXR1cm4gLUVGQVVMVDsNCj4gKwl9DQo+ICAJLyoN
Cj4gIAkgKiBTR19EWEZFUl9UT19GUk9NX0RFViBpcyBmdW5jdGlvbmFsbHkgZXF1aXZhbGVudCB0
byBTR19EWEZFUl9GUk9NX0RFViwNCj4gIAkgKiBidXQgaXMgaXMgcG9zc2libGUgdGhhdCB0aGUg
YXBwIGludGVuZGVkIFNHX0RYRkVSX1RPX0RFViwgYmVjYXVzZSB0aGVyZQ0KPiANCj4gQW5kIEkg
ZG9uJ3Qgc2VlIGEgcHJvYmxlbSB3aXRoIDQuNCwgZWl0aGVyLg0KPiANCj4gQmVzdCByZWdhcmRz
LA0KPiAJCQkJCQkJCQlQYXZlbA0KPiAtLQ0KPiAoZW5nbGlzaCkgaHR0cDovL3d3dy5saXZlam91
cm5hbC5jb20vfnBhdmVsbWFjaGVrDQo+IChjZXNreSwgcGljdHVyZXMpIGh0dHA6Ly9hdHJleS5r
YXJsaW4ubWZmLmN1bmkuY3ovfnBhdmVsL3BpY3R1cmUvaG9yc2VzL2Jsb2cuaHRtbA0K

--JOb6ze8FLuWNTufbTUmt
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4622): https://lists.cip-project.org/g/cip-dev/message=
/4622
Mute This Topic: https://lists.cip-project.org/mt/74215710/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--JOb6ze8FLuWNTufbTUmt--
