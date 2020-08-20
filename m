Return-Path: <SRS0=ONPv=B6=lists.cip-project.org=bounce+64572+5165+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5753FC433E1
	for <cip-dev@archiver.kernel.org>; Thu, 20 Aug 2020 23:08:28 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B846E2075E
	for <cip-dev@archiver.kernel.org>; Thu, 20 Aug 2020 23:08:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="LI3ID/kG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B846E2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5165+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id fMi1YY4521723xuGjN5VwROZ; Thu, 20 Aug 2020 16:08:27 -0700
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.157])
 by mx.groups.io with SMTP id smtpd.web12.121735.1597964904621620298
 for <cip-dev@lists.cip-project.org>;
 Thu, 20 Aug 2020 16:08:26 -0700
X-Received: by mo-csw.securemx.jp (mx-mo-csw1115) id 07KN8Lpe013755; Fri, 21 Aug 2020 08:08:22 +0900
X-Iguazu-Qid: 2wGrGhpI0NzimyMHwX
X-Iguazu-QSIG: v=2; s=0; t=1597964901; q=2wGrGhpI0NzimyMHwX; m=Fo7HKfL4Acrc3oN9Jr7OuFxQojNzKvEkNpZ1opmk4L8=
X-Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
	by relay.securemx.jp (mx-mr1113) id 07KN8Kju024047;
	Fri, 21 Aug 2020 08:08:21 +0900
X-Received: from enc03.toshiba.co.jp ([106.186.93.13])
	by imx12.toshiba.co.jp  with ESMTP id 07KN8KA8018004
	for <cip-dev@lists.cip-project.org>; Fri, 21 Aug 2020 08:08:20 +0900 (JST)
X-Received: from hop101.toshiba.co.jp ([133.199.85.107])
	by enc03.toshiba.co.jp  with ESMTP id 07KN8KL7027689
	for <cip-dev@lists.cip-project.org>; Fri, 21 Aug 2020 08:08:20 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IclfnzzTUYawBby1BCjzgr5AmBT2IYHy8C98xo1fcuYtcY5Gi00Dtwf6gROt68fFyvhvbJy021gNiWOUYOiAlbvu+lEq7dw0p9IDElFjK3RF+26435PH+L+4h+x7nscmS51BeF23Jm2R+Vx3jE6M3oFv6KKLty4n9B6V1UdJs6hNDv9nzUHz16dabjhgxf1ap+6C091CInKFpLWxBoroxmoMmiftTnzJcsBjpAyBSCzXdpwU1N2Nl7V42JDGO/X44dIvJvBDFwLBE5IAg/pCazY0hJzFkbBvoTIA3mT15RSsOEctrA8wZ9vwBh2nmdCdpnQ982ehFij1Fd05+4rV4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IuhfYmnJL4w+6rqFzTG/W3kQjOnSmahscWpA2o5KvcY=;
 b=KvNKGGd5zwIS4ElWghdLu4KJedsStnM3ox2hpei5S3bQoDV6IyslmtzkO/aRkEmEKBpfOCFOW35xL4FrJBbW9yQLkRVq0VzexaeFpF9LENhvLIMzJgIxB17+e8mICEf33ZGFhehIk+tL2C+gbAOf4v6KjOn2ptLQvTgNmYAvkJqAcwv87FHoNN80sC08vpRk21JTNThG9mH0hAL0hup4dDtyu7B1Pmxl++bEeHHQxRMDCITga+svh26WT3BMikicomlxxyd7az2H5Gam1NNVQSdxCcYn2ZJPCeVW7mGgWtdEIKL6DEwWYyPYq1jbqIUBHLokvrxPMZaeF1EzQ2kQgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: "Nobuhiro Iwamatsu" <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
Subject: Re: [cip-dev] [cip-kernel-config PATCH] qemu_cip_defconfig: Add EFI_STUB to config
Thread-Topic: [cip-dev] [cip-kernel-config PATCH] qemu_cip_defconfig: Add
 EFI_STUB to config
Thread-Index: AQHWaX6lfBZmtPjHaUaZ6kNYeyjoB6kqp0XQgACA/YCAAghzEIATmjUAgADvPmA=
Date: Thu, 20 Aug 2020 23:08:03 +0000
X-TSB-HOP: ON
Message-ID: <OSBPR01MB2983A7A6D1FE5604D1AE647A925A0@OSBPR01MB2983.jpnprd01.prod.outlook.com>
References: <20200803101217.6961-1-Quirin.Gylstorff@siemens.com>
 <OSBPR01MB298330C0C2BA66778FAB84AD92480@OSBPR01MB2983.jpnprd01.prod.outlook.com>
 <c0e08e23-2cc0-0ded-6266-2c4da2ccf4af@siemens.com>
 <OSBPR01MB298341D4C5B082E32DB5587792490@OSBPR01MB2983.jpnprd01.prod.outlook.com>
 <d5786804-0453-cfe5-aeef-f090c363a0fd@siemens.com>
In-Reply-To: <d5786804-0453-cfe5-aeef-f090c363a0fd@siemens.com>
Accept-Language: ja-JP, en-US
x-originating-ip: [103.91.184.3]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d998fd09-b7a7-4d30-b0d4-08d8455de46c
x-ms-traffictypediagnostic: OSAPR01MB4818:
x-microsoft-antispam-prvs: <OSAPR01MB48185DB0DAD8F04F22647674925A0@OSAPR01MB4818.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: NiMrc4oONERaKR5vqSBWkRgtP35fcgtPV6wL2FZ1Uy2vQgJ8AGxfMH536X0fQtiUrkZ2yCTE6ks7CKTW8Ce3SITElUDmsQzPkMtFENbYZEdXW0pKwob52S0QqKbFdMn7ecF+TDyMzUQzjzxqDKnkrd+4RAamdWbODatB7+FNsF2e4d/ipnP5Ipyt8XlCraWxjQgmRlOMefMQ917vGNhJiIQXLxkA5ZvFCCzB0SH/39t5qQLlLqvP0MdAcb3ZdJMLv1/u2V4r5PmZUiZXY5eg65XlVcPg5gkX+TSDEMtcKv4vrYzd3PbK73PMMUFDzbYCTJKpp9ag0Ec8LCSdeMqirQ==
x-ms-exchange-antispam-messagedata: J24ML9tLUeavqrLxmI/xSdGqQjv1KqUa0UI9r1KIFBLsyKnPqPn9J9igYUjROMNpnUkXiMU2M5cLv/D9ZwuSq7lPomh1tcw/qf3Nq3xXlhEVzTE+ZOW0Wwk/J6KK0TlX94jVVY1WBBWCEE/C6wiAQYeERPbZZrt88PLnpVVcZaMu+LZtGrnh/RSTmku0E9cHbpeuXc2Q5wWliQR+GQxccsqPkQyrwUIsqb8IEq1Si4Q9hO07WjCSV6HaBhpz6zEX/Zft2pwUR7XsqhhGs9NYw2p9iJu4tzYm1WvxMXsk+Zy6Q0tnvi6HEUMe/47jgQjI7l2Q1UM1p3V2X3KSoNKcX6B6iTs1/dV7aySwusYC+UJYKaIYsSYgWU8qQGYK/MicMpY/0U2nL9J28wLHZSJDyQ9T+s2SGjC4jK8edZZtz0xIvgivgetxx7S7uIkkt52IJLt7ANmG2Lpzqh/pYcCm23Ae8G/mh3BH/5Wl6tVN7DNNnQczegVYpq3nuL/u8GWxcgxW8HsrH8Z5xYy7iRjJvkvxkj7TQLkulxnXbTORE6nDi6vSMyIQ69MdUA4vdW27LSjitHKjGaoja0LGvbaz20MA9zAU0tvj8LhGHjeMxKUBrtiWTTIcoYNDaYiABVhuF3m/QcU8nZHcVKgiLTygRQ==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2983.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d998fd09-b7a7-4d30-b0d4-08d8455de46c
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2020 23:08:03.8629
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CmOH1dr6CVejD1Dbn4vYBKjtwiiPwKTaVNCrcCELY29MVPlIjqIn9+mD8vPby1Xw/QA2O5ULpl9CR77bcwDnyOtyBriKP3+9egq4vkZSDqwBdVi5/KeTCgJiM+y8Hmlo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB4818
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: VUHtVn4HgwVjr3i6u5oIpOGUx4520388AA=
Content-Type: multipart/mixed; boundary="XKpdsHG9yCtcAbFvWEfZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1597964907;
 bh=ehzDX88Kwa/i9A6pf1cgQAqQqlhbUtJ/jbQwakDmAdk=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=LI3ID/kGed2fvmvWppc3N1WC7cJq1LyZhi2NfgVJ534Of0dBrB+k9bIbMk01sPjToe/
 UxDMcrIqou3NADGSjcERRW/5FssYCq2kbEGqtDkMzPUT9rxoeHiJ0crsZTcoIMzIb/Vph
 lQ/ELmjGbzK4ahbNzN4HmDKqBA3azGELwD0=

--XKpdsHG9yCtcAbFvWEfZ
Content-Language: ja-JP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGksDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogY2lwLWRldkBsaXN0
cy5jaXAtcHJvamVjdC5vcmcgW21haWx0bzpjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZ10g
T24gQmVoYWxmIE9mIFF1aXJpbiBHeWxzdG9yZmYNCj4gU2VudDogVGh1cnNkYXksIEF1Z3VzdCAy
MCwgMjAyMCA1OjUwIFBNDQo+IFRvOiBjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZzsgaXdh
bWF0c3Ugbm9idWhpcm8o5bKp5p2+IOS/oea0iyDilqHvvLPvvLfvvKPil6/vvKHvvKPvvLQpIDxu
b2J1aGlybzEuaXdhbWF0c3VAdG9zaGliYS5jby5qcD4NCj4gU3ViamVjdDogUmU6IFtjaXAtZGV2
XSBbY2lwLWtlcm5lbC1jb25maWcgUEFUQ0hdIHFlbXVfY2lwX2RlZmNvbmZpZzogQWRkIEVGSV9T
VFVCIHRvIGNvbmZpZw0KPiANCg0KPHNuaXA+DQoNCj4gPj4+Pg0KPiA+Pj4+IFNpZ25lZC1vZmYt
Ynk6IFF1aXJpbiBHeWxzdG9yZmYgPHF1aXJpbi5neWxzdG9yZmZAc2llbWVucy5jb20+DQo+ID4+
Pj4gLS0tDQo+ID4+Pj4gICAgNC4xOS55LWNpcC94ODYvY2lwX3FlbXVfZGVmY29uZmlnIHwgMSAr
DQo+ID4+Pj4gICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspDQo+ID4+Pg0KPiA+Pj4g
UGxlYXNlIHVwZGF0ZSBjaXBfcWVtdS5zb3VyY2VzIHRvby4NCj4gPj4NCj4gPj4gV2hlbiBpIHRy
eSB0byBnZW5lcmF0ZSB0aGUgc291cmNlcyAtIGFsbCAuYyBhbmQgYXNtIGZpbGVzIGFyZSBubyBs
b25nZXINCj4gPj4gcGFydCBvZiB0aGUgY2lwLXFlbXUuc291cmNlcy4gRGlkIEkgbWlzcyBzb21l
dGhpbmc/IE9yIHNob3VsZCBJIHRyeQ0KPiA+PiBhZ2FpbiBsaWtlIHRoZSBsYXN0IHRpbWUgdGhp
cyBoYXBwZW5lZD8NCj4gPg0KPiA+IFRoYW5rcyBmb3IgeW91ciBjaGVjay4NCj4gPiBTb3JyeSwg
SSB3YW50ZWQgdG8gY2hlY2sgaWYgdGhlcmUgd2FzIGEgZml4IGluIGNpcF9xZW11LnNvdXJjZXMu
DQo+ID4gSSBhcHBsaWVkIHRoaXMgcGF0Y2guDQo+ID4NCj4gDQo+IEhpLA0KPiANCj4gSSBkaWRu
J3QgZmluZCB0aGUgcGF0Y2ggYXBwbGllZCB0byBjaXAta2VybmVsLWNvbmZpZy4gSXMgc29tZXRo
aW5nIG1pc3Npbmc/DQo+IA0KDQpTb3JyeSwgSSBqdXN0IHB1c2hlZC4NCg0KPiBLaW5kIHJlZ2Fy
ZHMsDQo+IHF1aXJpbg0KDQpCZXN0IHJlZ2FyZHMsDQogIE5vYnVoaXJvDQo=

--XKpdsHG9yCtcAbFvWEfZ
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5165): https://lists.cip-project.org/g/cip-dev/message=
/5165
Mute This Topic: https://lists.cip-project.org/mt/75962579/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--XKpdsHG9yCtcAbFvWEfZ--
