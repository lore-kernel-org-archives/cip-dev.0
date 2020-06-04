Return-Path: <SRS0=yfpt=7R=lists.cip-project.org=bounce+64572+4693+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41D01C433DF
	for <cip-dev@archiver.kernel.org>; Thu,  4 Jun 2020 06:55:56 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F17282072E
	for <cip-dev@archiver.kernel.org>; Thu,  4 Jun 2020 06:55:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="LTQEnoW2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F17282072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4693+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id DflWYY4521723x97FoSiyNwh; Wed, 03 Jun 2020 23:55:55 -0700
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.157])
 by mx.groups.io with SMTP id smtpd.web11.8582.1591253752927470314
 for <cip-dev@lists.cip-project.org>;
 Wed, 03 Jun 2020 23:55:54 -0700
X-Received: by mo-csw.securemx.jp (mx-mo-csw1115) id 0546thbL010593; Thu, 4 Jun 2020 15:55:43 +0900
X-Iguazu-Qid: 2wHHQAbmvTwPByT5HM
X-Iguazu-QSIG: v=2; s=0; t=1591253743; q=2wHHQAbmvTwPByT5HM; m=6G0/GiLX4SiRWSlPpAvXZlr/FuhAJ/zmgfSvvb4pcKI=
X-Received: from imx2.toshiba.co.jp (imx2.toshiba.co.jp [106.186.93.51])
	by relay.securemx.jp (mx-mr1110) id 0546tfDb004024;
	Thu, 4 Jun 2020 15:55:42 +0900
X-Received: from enc01.localdomain ([106.186.93.100])
	by imx2.toshiba.co.jp  with ESMTP id 0546tf4V020440;
	Thu, 4 Jun 2020 15:55:41 +0900 (JST)
X-Received: from hop001.toshiba.co.jp ([133.199.164.63])
	by enc01.localdomain  with ESMTP id 0546tfYE030884;
	Thu, 4 Jun 2020 15:55:41 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DG+qF9+yf18Cniy/FgFLlThPL0wuYeINK/qCIB5IuUHaKSGwlBQaEeJw55w1R7eD3H2JN1otoFnFe8B9F7pgnAbr/BDDTHebLfg8SM//M+Bs1sYEPM01XBgZ0u9R7mUXuyVKFVZj2OQhd4AzVq0PsZ6ovZk+mlJy4zqIEGKn1OQpw8vo3ZWyQ71BGneh/KhQ7pDhni8lH82g/M+md2tVoh9IS8bA694dIH8tPVPV32c0hpEwO19hCYgIpKVo2WMGymKhKYhme6TWOvk0y/lxhpX0SU7Yt0e4OYGhbFRl3WxY9qBDD3MiXTfP3FzRNasbyY+vedEqka/fNjexKi2W8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CWsBkjROuWyAtsoCm4/qfBEXV0DD7zbmWkTqMVkJBYw=;
 b=Be+R8YAHmsa5quF2mR6oZqXAKHIlm+0IGvRmNnig69IT6E6Q8c8eR0cqFU+7nM71RYVngPe29tKP4zvvfrzgnaNtoWcLTrV8OU3zzvkbWa+aRcb5qDo8kjx13ua1dE60nSGVCBq6lvPF3ZrE1Y5tEAP0gWox76s5qQL+QGorpTm5ZbUaEtQTEyFfDsLdGPOYdgxWmZLv5Q2mUn77zvizNe5PnmXQSLC32y/dQiI0MZdQPZB/roMgkzelBXdM5wi5RjSBbadSf45OMZ8+EC+t6MJ8wcE5JSFIzDVl60rT0fu06y4nLsJqw/Yzm1PdMsiSkn9wICGm2lJNC83bipSQ/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: "Nobuhiro Iwamatsu" <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <wens@csie.org>, <pavel@denx.de>
CC: <cip-dev@lists.cip-project.org>, <JohnsonCH.Chen@moxa.com>
Subject: Re: [cip-dev] [PATCH RESEND 4.4.y-cip 00/15] PM / OPP v2 & cpufreq backports part 1
Thread-Topic: [PATCH RESEND 4.4.y-cip 00/15] PM / OPP v2 & cpufreq backports
 part 1
Thread-Index: AQHWOic4O7W+cZcsJUyrzqIpoGw83qjIBV2w
Date: Thu, 4 Jun 2020 06:55:38 +0000
X-TSB-HOP: ON
Message-ID: <OSBPR01MB29831550F3393A10777EF21D92890@OSBPR01MB2983.jpnprd01.prod.outlook.com>
References: <20200604041745.28886-1-wens@csie.org>
In-Reply-To: <20200604041745.28886-1-wens@csie.org>
Accept-Language: ja-JP, en-US
x-originating-ip: [103.91.184.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: acc59916-c4f2-40b8-06c1-08d808544a5c
x-ms-traffictypediagnostic: OSBPR01MB5272:
x-microsoft-antispam-prvs: <OSBPR01MB5272B4A39FA7A39BC1F4B0B392890@OSBPR01MB5272.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: giNTgtQy2Xd8ju0KD9XvHYe71SEb1f4u2Mb6mrNMZ62K2/O8pUmUpYtgemfp13S0Yi0zfyJXUkyYc/9UqwLZvvril7/6OFotCzt6nCAlrj7H0qpMydssOi+WnNuxqreJgEzqy+mWytSue1RShXom0M6VJixCNvJw5vi/h/+cYHQiCddXCuxtAS0Ax3592vqsGcn3Yxqc+9DPv24cKm+D+J05VQLd9GslCN+8cW3mUS5olWsf6LcnynvLEyu2INnSpvYew3SunRPZhYFpEj3H1NCF2RHpHyq/OhYGFmEuWs177iRiZVC6UxvmIoerpLnH4Eh8YYx6SpkSlRkvXCXksw==
x-ms-exchange-antispam-messagedata: wZ+JIvuzjtgSLyFMDPkA3EKpmYt770PgQJpyYU1Hd25/B9v6U2o1yg71I8q03ubYSLyDN3pfEpB6OMAszJyMTHgJGlP1NYojMSQA5a5SoB8w+ZoGz4pXhLb3KNqhOe7p9BVZtGOsOtAYuwhQvEA44l+uX73TM1atYeSRhIW/HPsB7Ja6gmQMvg383XtdtyRE+ljDVii4GnAgCiI+E97zrAOftW9T+yS/a6lzbg+ZURFhFywH6SFpBfzvz2Gx2vqoKrLfbZzqjkdD/7RarOQ9r1jruY5f/uZSv/vnpOOd7e/C+BynPHaSYCx6Vh/swk7+XxwBMQrUYp99cOflKB+ZxznV1gQMSN69Id2tdL+ohpsHBYOGCTrmXS6EoFecXhcb5GUgBYW4ktpcdZ3oK7BlG+nqlQgwLU1+KuO+x8XS9iPNztQjaDB/NG3CytxijD/SMHmmMPXf2oHdWqcqknZkVjctYSF3F0CMPArciMhryss=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: acc59916-c4f2-40b8-06c1-08d808544a5c
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2020 06:55:38.9715
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RV+KeLpkmRizHcWLhdG9tGhi0NIpwEp4+AZLPm92GbrCOet/UzGY2GXeFypEF23haNszsOhGEZhq5PnsMyGtksM5o6HCkWaC1m+4OLlncdIeHpehooSgX5xu+yG/utmr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB5272
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: gwcCppLuvrmYUaeV8R8T2LH4x4520388AA=
Content-Type: multipart/mixed; boundary="pReXRB3GYQ4Pxp3FFSrC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1591253755;
 bh=Qyo9LPjPUI45hisENt7oMpv8meUftjLTgD1m55Gr5B4=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=LTQEnoW2fzgMr/Nf8FwfAAPcWWQnMwEN4he+phV7vurijRZIcLa5qHP3dZ6x+8+rC95
 j2U86xSsbi6l5VDdegPi1ZRnlB0yixXJyElynquMzT8bWSEQfnfKcY9e2XSGV42DgXb2S
 quEuN2xbqYMyJbHkbC020lF6VF+30eOKDGs=

--pReXRB3GYQ4Pxp3FFSrC
Content-Language: ja-JP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGkgV2VucywNCg0KVGhhbmtzIGZvciB5b3VyIHBhdGNoIQ0KDQo+IC0tLS0tT3JpZ2luYWwgTWVz
c2FnZS0tLS0tDQo+IEZyb206IENoZW4tWXUgVHNhaSAoTW94YSkgW21haWx0bzp3ZW5zQGNzaWUu
b3JnXQ0KPiBTZW50OiBUaHVyc2RheSwgSnVuZSA0LCAyMDIwIDE6MTggUE0NCj4gVG86IGl3YW1h
dHN1IG5vYnVoaXJvKOWyqeadviDkv6HmtIsg4pah77yz77y377yj4pev77yh77yj77y0KSA8bm9i
dWhpcm8xLml3YW1hdHN1QHRvc2hpYmEuY28uanA+OyBwYXZlbEBkZW54LmRlDQo+IENjOiBjaXAt
ZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZzsgSm9obnNvbkNILkNoZW5AbW94YS5jb20NCj4gU3Vi
amVjdDogW1BBVENIIFJFU0VORCA0LjQueS1jaXAgMDAvMTVdIFBNIC8gT1BQIHYyICYgY3B1ZnJl
cSBiYWNrcG9ydHMgcGFydCAxDQo+IA0KPiBIaSBldmVyeW9uZSwNCj4gDQo+IFRoaXMgaXMgcGFy
dCAxIG9mIE1PWEEncyBQTSAvIE9QUCAvIGNwdWZyZXEgYmFja3BvcnQgc2VyaWVzLiBUaGUgd2hv
bGUNCj4gc2VyaWVzIGFpbXMgdG8gYmFja3BvcnQgcGF0Y2hlcyByZWxhdGVkIHRvIFBNIC8gT1BQ
djIgYW5kIGNwdWZyZXENCj4gd2hpY2ggd2VyZSBpbmNsdWRlZCBpbiB0aGUgdjQuNCBrZXJuZWwg
ZnJvbSBUSSdzIFNESy4gVGhlIGVuZCBnb2FsIGlzDQo+IHRvIGluY2x1ZGUgY3B1ZnJlcS10aSBh
bmQgY29udmVydCBhbTMzeHggdG8gdXNpbmcgaXQgYW5kIE9QUHYyLg0KPiANCj4gUGFydCAxIGhl
cmUgaW5jbHVkZXMgcGF0Y2hlcyBmcm9tIHRoZSB2NC41IGN5Y2xlLCBsaXN0ZWQgaW4gdG9wb2xv
Z2ljYWwNCj4gb3JkZXI6DQo+IA0KPiAgICAgZGVhYTUxNDY1MTA1IFBNIC8gT1BQOiBBZGQgZGVi
dWdmcyBzdXBwb3J0DQo+ICAgICAxYzRkMTJkZTI3MTkgUE0gLyBPUFA6IEFkZCAib3BwLXN1cHBv
cnRlZC1odyIgYmluZGluZw0KPiAgICAgZmZkYjhjYzdhMjdjIFBNIC8gT1BQOiBBZGQge29wcC1t
aWNyb3ZvbHR8b3BwLW1pY3JvYW1wfS08bmFtZT4gYmluZGluZw0KPiAgICAgYWY4N2EzOWE1Zjdj
IFBNIC8gT1BQOiBSZW1vdmUgJ29wZXJhdGluZy1wb2ludHMtbmFtZXMnIGJpbmRpbmcNCj4gICAg
IDc1NGRjZjM1ZjM0NiBQTSAvIE9QUDogUmVuYW1lIE9QUCBub2RlcyBhcyBvcHBAPG9wcC1oej4N
Cj4gICAgIGRjNGU3YjFmYTIwYSBQTSAvIE9QUDogQWRkIG1pc3NpbmcgZG9jIGNvbW1lbnRzDQo+
ICAgICA3ZGUzNmIwYWE1MWEgUE0gLyBPUFA6IFBhcnNlICdvcHAtc3VwcG9ydGVkLWh3JyBiaW5k
aW5nDQo+ICAgICAwMWZiNGQzYzM5ZDMgUE0gLyBPUFA6IFBhcnNlICdvcHAtPHByb3A+LTxuYW1l
PicgYmluZGluZ3MNCj4gICAgIGZkOGQ4ZTYzNDY3YyBQTSAvIE9QUDogRml4IHBhcnNpbmcgb2Yg
b3BwLW1pY3Jvdm9sdCBhbmQgb3BwLW1pY3JvYW1wIHByb3BlcnRpZXMNCj4gICAgIGQ5ZGUxOWIx
Y2MwMSBQTSAvIE9QUDogU2V0IGNwdV9kZXYtPmlkIGluIGNwdW1hc2sgZmlyc3QNCj4gICAgIDVm
ZjI0ZDYwMTA5MiBQTSAvIE9QUDogVXNlIHNucHJpbnRmKCkgaW5zdGVhZCBvZiBzcHJpbnRmKCkN
Cj4gICAgIDNiZTNmOGYzNmU3MyBkZXZpY2V0cmVlOiBiaW5kaW5nczogQWRkIG9wdGlvbmFsIGR5
bmFtaWMtcG93ZXItY29lZmZpY2llbnQgcHJvcGVydHkNCj4gICAgIGY4ZmE4YWUwNmI4YyBjcHVm
cmVxLWR0OiBTdXBwbHkgcG93ZXIgY29lZmZpY2llbnQgd2hlbiByZWdpc3RlcmluZyBjb29saW5n
IGRldmljZXMNCj4gICAgIDkyOWNhODljMzA1YSBjcHVmcmVxLWR0OiBmaXggaGFuZGxpbmcgcmVn
dWxhdG9yX2dldF92b2x0YWdlKCkgcmVzdWx0DQo+ICAgICBiMzMxYmMyMGQ5MjggY3B1ZnJlcTog
Y3B1ZnJlcS1kdDogYXZvaWQgdW5pbml0aWFsaXplZCB2YXJpYWJsZSB3YXJuaW5nczoNCj4gDQo+
IE9mIHRoZXNlLA0KPiANCj4gICAgIGRjNGU3YjFmYTIwYSBQTSAvIE9QUDogQWRkIG1pc3Npbmcg
ZG9jIGNvbW1lbnRzDQo+IA0KPiB3YXMgaWRlbnRpZmllZCBhcyBhIHBhdGNoIGRlcGVuZGVuY3ks
IGJ1dCBvdGhlcndpc2Ugc2VydmVzIG5vIHB1cnBvc2UuIEFuZA0KPiANCj4gICAgIGQ5ZGUxOWIx
Y2MwMSBQTSAvIE9QUDogU2V0IGNwdV9kZXYtPmlkIGluIGNwdW1hc2sgZmlyc3QNCj4gDQo+IHdh
cyBmb3VuZCB3aGlsZSBsb29raW5nIHRocm91Z2ggZ2l0IGxvZ3MuIExhc3QsDQo+IA0KPiAgICAg
M2JlM2Y4ZjM2ZTczIGRldmljZXRyZWU6IGJpbmRpbmdzOiBBZGQgb3B0aW9uYWwgZHluYW1pYy1w
b3dlci1jb2VmZmljaWVudCBwcm9wZXJ0eQ0KPiANCj4gaXMgcmVsYXRlZCB0bw0KPiANCj4gICAg
IGY4ZmE4YWUwNmI4YyBjcHVmcmVxLWR0OiBTdXBwbHkgcG93ZXIgY29lZmZpY2llbnQgd2hlbiBy
ZWdpc3RlcmluZyBjb29saW5nIGRldmljZXMNCj4gDQo+IEFsbCBvdGhlciBwYXRjaGVzIHdlcmUg
aW5jbHVkZWQgZnJvbSBUSSdzIFNESy4NCj4gDQo+IFRoZSBwYXRjaGVzIGFwcGx5IGNsZWFubHkg
b24gdG9wIG9mIGxpbnV4LTQuNC55LWNpcC4gUGxlYXNlIGhhdmUgYSBsb29rLg0KPiANCg0KSSBo
YXZlIG5vdGhpbmcgdG8gcG9pbnQgb3V0IG90aGVyIHRoYW4gdGhlIGNvbW1lbnQgb24gIlBNIC8g
T1BQOiBTZXQgY3B1X2Rldi0+aWQgaW4gY3B1bWFzayBmaXJzdCIuDQoNCj4gDQo+IFJlZ2FyZHMN
Cj4gQ2hlbll1DQo+IA0KDQpCZXN0IHJlZ2FyZHMsDQogIE5vYnVoaXJvDQoNCj4gDQo+IEFuZHJ6
ZWogSGFqZGEgKDEpOg0KPiAgIGNwdWZyZXEtZHQ6IGZpeCBoYW5kbGluZyByZWd1bGF0b3JfZ2V0
X3ZvbHRhZ2UoKSByZXN1bHQNCj4gDQo+IEFybmQgQmVyZ21hbm4gKDEpOg0KPiAgIGNwdWZyZXE6
IGNwdWZyZXEtZHQ6IGF2b2lkIHVuaW5pdGlhbGl6ZWQgdmFyaWFibGUgd2FybmluZ3M6DQo+IA0K
PiBCYXJ0bG9taWVqIFpvbG5pZXJraWV3aWN6ICgxKToNCj4gICBQTSAvIE9QUDogRml4IHBhcnNp
bmcgb2Ygb3BwLW1pY3Jvdm9sdCBhbmQgb3BwLW1pY3JvYW1wIHByb3BlcnRpZXMNCj4gDQo+IFBp
LUNoZW5nIENoZW4gKDEpOg0KPiAgIFBNIC8gT1BQOiBTZXQgY3B1X2Rldi0+aWQgaW4gY3B1bWFz
ayBmaXJzdA0KPiANCj4gUHVuaXQgQWdyYXdhbCAoMik6DQo+ICAgZGV2aWNldHJlZTogYmluZGlu
Z3M6IEFkZCBvcHRpb25hbCBkeW5hbWljLXBvd2VyLWNvZWZmaWNpZW50IHByb3BlcnR5DQo+ICAg
Y3B1ZnJlcS1kdDogU3VwcGx5IHBvd2VyIGNvZWZmaWNpZW50IHdoZW4gcmVnaXN0ZXJpbmcgY29v
bGluZyBkZXZpY2VzDQo+IA0KPiBWaXJlc2ggS3VtYXIgKDkpOg0KPiAgIFBNIC8gT1BQOiBBZGQg
ZGVidWdmcyBzdXBwb3J0DQo+ICAgUE0gLyBPUFA6IEFkZCAib3BwLXN1cHBvcnRlZC1odyIgYmlu
ZGluZw0KPiAgIFBNIC8gT1BQOiBBZGQge29wcC1taWNyb3ZvbHR8b3BwLW1pY3JvYW1wfS08bmFt
ZT4gYmluZGluZw0KPiAgIFBNIC8gT1BQOiBSZW1vdmUgJ29wZXJhdGluZy1wb2ludHMtbmFtZXMn
IGJpbmRpbmcNCj4gICBQTSAvIE9QUDogUmVuYW1lIE9QUCBub2RlcyBhcyBvcHBAPG9wcC1oej4N
Cj4gICBQTSAvIE9QUDogQWRkIG1pc3NpbmcgZG9jIGNvbW1lbnRzDQo+ICAgUE0gLyBPUFA6IFBh
cnNlICdvcHAtc3VwcG9ydGVkLWh3JyBiaW5kaW5nDQo+ICAgUE0gLyBPUFA6IFBhcnNlICdvcHAt
PHByb3A+LTxuYW1lPicgYmluZGluZ3MNCj4gICBQTSAvIE9QUDogVXNlIHNucHJpbnRmKCkgaW5z
dGVhZCBvZiBzcHJpbnRmKCkNCj4gDQo+ICAuLi4vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vY3B1
cy50eHQgICAgICAgICAgfCAgMTcgKw0KPiAgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRp
bmdzL29wcC9vcHAudHh0IHwgMTMyICsrKysrLS0NCj4gIGRyaXZlcnMvYmFzZS9wb3dlci9vcHAv
TWFrZWZpbGUgICAgICAgICAgICAgICB8ICAgMSArDQo+ICBkcml2ZXJzL2Jhc2UvcG93ZXIvb3Bw
L2NvcmUuYyAgICAgICAgICAgICAgICAgfCAzMzYgKysrKysrKysrKysrKysrKystDQo+ICBkcml2
ZXJzL2Jhc2UvcG93ZXIvb3BwL2NwdS5jICAgICAgICAgICAgICAgICAgfCAgIDMgKy0NCj4gIGRy
aXZlcnMvYmFzZS9wb3dlci9vcHAvZGVidWdmcy5jICAgICAgICAgICAgICB8IDIxOSArKysrKysr
KysrKysNCj4gIGRyaXZlcnMvYmFzZS9wb3dlci9vcHAvb3BwLmggICAgICAgICAgICAgICAgICB8
ICA1MyArKy0NCj4gIGRyaXZlcnMvY3B1ZnJlcS9jcHVmcmVxLWR0LmMgICAgICAgICAgICAgICAg
ICB8ICAyOSArLQ0KPiAgaW5jbHVkZS9saW51eC9wbV9vcHAuaCAgICAgICAgICAgICAgICAgICAg
ICAgIHwgIDIyICsrDQo+ICA5IGZpbGVzIGNoYW5nZWQsIDc0MiBpbnNlcnRpb25zKCspLCA3MCBk
ZWxldGlvbnMoLSkNCj4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL2Jhc2UvcG93ZXIvb3Bw
L2RlYnVnZnMuYw0KPiANCj4gLS0NCj4gMi4yNy4wLnJjMA0KDQo=

--pReXRB3GYQ4Pxp3FFSrC
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4693): https://lists.cip-project.org/g/cip-dev/message=
/4693
Mute This Topic: https://lists.cip-project.org/mt/74665632/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--pReXRB3GYQ4Pxp3FFSrC--
