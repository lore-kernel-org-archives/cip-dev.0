Return-Path: <SRS0=5oJY=7R=lists.cip-project.org=bounce+64572+4691+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DACFC433DF
	for <cip-dev@archiver.kernel.org>; Thu,  4 Jun 2020 06:43:17 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8151E2074B
	for <cip-dev@archiver.kernel.org>; Thu,  4 Jun 2020 06:43:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="NhrU58bH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8151E2074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4691+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id wKqVYY4521723xWFu9cuj5B7; Wed, 03 Jun 2020 23:43:16 -0700
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.157])
 by mx.groups.io with SMTP id smtpd.web11.8468.1591252993277418867
 for <cip-dev@lists.cip-project.org>;
 Wed, 03 Jun 2020 23:43:15 -0700
X-Received: by mo-csw.securemx.jp (mx-mo-csw1115) id 0546h1Ja030621; Thu, 4 Jun 2020 15:43:01 +0900
X-Iguazu-Qid: 2wHHWzHtPoLoUOUvDe
X-Iguazu-QSIG: v=2; s=0; t=1591252981; q=2wHHWzHtPoLoUOUvDe; m=vv0VEPACSnKVeLAy1lE3PJDFnNlzcvuOfbexJ7sO2ZE=
X-Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
	by relay.securemx.jp (mx-mr1110) id 0546gxPo014728;
	Thu, 4 Jun 2020 15:43:00 +0900
X-Received: from enc02.toshiba.co.jp ([61.202.160.51])
	by imx12.toshiba.co.jp  with ESMTP id 0546gxnX003204;
	Thu, 4 Jun 2020 15:42:59 +0900 (JST)
X-Received: from hop101.toshiba.co.jp ([133.199.85.107])
	by enc02.toshiba.co.jp  with ESMTP id 0546gwFo019649;
	Thu, 4 Jun 2020 15:42:58 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LOZv7qQxA8HWD4BLszbp1bHQkFoOSsBU0E8UoA8VVuWI0sAGOIfUycHxFNPc0GAxOvtHo4zjMU9FFm2n/ppuiRU+3cQHLFZ5pgt2Oa1n0ujJ+uMRqraBRUp5xYRKERQ9zHXsWQNGEojWQQPe6BEu3pt21LUtD0n0OZTlClHPFlw/+fjiLlMtfFAKs7y9x+AoA9NYQTxOkJjIroAL/R9Ygfq8elCed0QsMObOB38wxMGLxWZoCf+G7HbvK6oUOOysl/bA3Dl7bxbWz08I/pf/Kj2p3tZO+b9+XR/lJxQwBJVZ8rPAdfIBlSsASLgKqQyRJMbsUOckL/+lyKCPsbMzpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rHsYuTOBfaFVpqxQT2nNFUOKxXitVflHsy9BWpS1R6g=;
 b=NhZvujXo9CIqxI4Wiu8VNme8ck/Kxvn6ygUyysqZCJiN8edJTG7xGjkXDEAv+OzPKOocp4ZVbB67VL9p+NbNM42DaZLKqHLGRmDTApb59Vs0uC51OBzs/vLLBzIhC6yFAHymX+F7Lzt5RDrkBRhnmsUtFwZcJfPujIZz/QeAUvb3MlEtA/t+t7OQdOGOMO3kq7NPh/W8CU+S4tqce12sXmb2RZtvRgNeOtDJ5QvC4H72LFsuPBoq3pBUMBzNicR1VVizZoJ8alZ+wuYLFlB2tZZYGv6PVNXmxCcKsYLSV4RCV9BpYBtc9BET/kSS8GMKBY4qP5ATCEQpAid98xYCYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: "Nobuhiro Iwamatsu" <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <wens@csie.org>, <pavel@denx.de>
CC: <cip-dev@lists.cip-project.org>, <JohnsonCH.Chen@moxa.com>
Subject: Re: [cip-dev] [PATCH RESEND 4.4.y-cip 10/15] PM / OPP: Set cpu_dev->id in cpumask first
Thread-Topic: [PATCH RESEND 4.4.y-cip 10/15] PM / OPP: Set cpu_dev->id in
 cpumask first
Thread-Index: AQHWOic0D6onqsSXuEi4CUTLs0xUU6jIAfvA
Date: Thu, 4 Jun 2020 06:42:36 +0000
X-TSB-HOP: ON
Message-ID: <OSBPR01MB2983010E7127D8E9E981397792890@OSBPR01MB2983.jpnprd01.prod.outlook.com>
References: <20200604041745.28886-1-wens@csie.org>
 <20200604041745.28886-11-wens@csie.org>
In-Reply-To: <20200604041745.28886-11-wens@csie.org>
Accept-Language: ja-JP, en-US
x-originating-ip: [103.91.184.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5f3de447-b554-4df7-b4c5-08d8085277d3
x-ms-traffictypediagnostic: OSBPR01MB4327:
x-microsoft-antispam-prvs: <OSBPR01MB432733F09F33F4CC1F0DA6FA92890@OSBPR01MB4327.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:556;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ajPzKmDhKGu6v9pUzfEfKs9vcAa+39ANQYXsivE6GvpLJ+0sYtuoKZ+Ge3yZjqx20hNXhg5my3ijAO68qTPczsVGyTij+mUAvANfIU7fLCDUsYmCopDaGZFIhUxzKFcmt8JD0MUF3E+9lQMEB4pE3TXW2CCZLmuSB5HggNNmpT7TConYULZnDaE6JnNB6h5p25SCHCLaTigtMvALC2qN9PabHvfexNPv3+17nq3Crt1SSPDUF0dy+nq3zdsXUfG398FiQh93PAiWR4p08xYOf1KpKrgHqgVUYxlShJP6OyQnSwiuDWLVFsCV+rFW4PNJop/e9nePqnZy82aZvhMIeQ==
x-ms-exchange-antispam-messagedata: P2ILpRmDIKm7TU0rGiFP/8+rQZiUvKSeM5EHshCARbjQ/nlqLkkfx6hdpz7ciIFntQ/O1Fi4+FiPVChLLAEZ5IdX0kRyf6sbDb0bChfdCobGIkLVp5fyLugT52F0BgvRph1q7V8sQyJV5/+VJYrQVHFfLdoyouTJNRIoupXe2aUYbxyhMBwmD1FzgnKDPLlt7drdOyyWm5DRuw4q5hlEBwN+7NG1lP1CJymuOlGNaOLdTQWr0frZJ+ZbJxVF4o1VpYgzfHfC3kHK6sCdvrci7o2pnp6v5PNHwFz0qVK4fzZbws/2eabqlRuDUVOFt6PY/b3lhsib9/7EbGtCkoAqF4eSYMptmi8cnPf+f63mi8Y2lpXkvMvxIcGzrTciDrUR0ec5jAs3V4WQXKvcYpWB/Rn+R+JsxYAEmkcWtRx1mfhTmfbSGdHOxuOaMTHSuaayJU6HYAJNW7/vKgn3Jcwzl6sPsfPlL4zJjSLao5bKhwM=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f3de447-b554-4df7-b4c5-08d8085277d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2020 06:42:36.3188
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QJ0JlT+i1qjsY+TxN+8p+24pt3uEtxr8t5xMuPSuPndt2JZtsRrbawNiVeVN6vXJQ0XmaCN0WfYJUms46coQLSlH+nAES6y/uQGGz1nDD2Wjug2fZrFh/n8OQj0K2rXu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB4327
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 98qZSJF4WM9SLSIi79uZG9JNx4520388AA=
Content-Type: multipart/mixed; boundary="Jus1h4Z6kAOkIm5Ffqx3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1591252996;
 bh=kuN6RL5qdyvGYVI6IdM6wU3ngcacYodasjCto35sYUE=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=NhrU58bH4H4JsrbuAwEAxc4vpD5Pb+/FZg8wx3Et7UvaEyNA2AxuG6crhqUOqnO1yYX
 GyQjluhuNy6Wh//EPdffsqbpBeTTXjlfCTJlGd4m/QRL8oARH01DvrlwlgmDpRFAfAYW0
 sIlT6xJcVUlv0U/dZj+PuNeU9XSMQxTiOjs=

--Jus1h4Z6kAOkIm5Ffqx3
Content-Language: ja-JP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGksDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQ2hlbi1ZdSBUc2Fp
IChNb3hhKSBbbWFpbHRvOndlbnNAY3NpZS5vcmddDQo+IFNlbnQ6IFRodXJzZGF5LCBKdW5lIDQs
IDIwMjAgMToxOCBQTQ0KPiBUbzogaXdhbWF0c3Ugbm9idWhpcm8o5bKp5p2+IOS/oea0iyDilqHv
vLPvvLfvvKPil6/vvKHvvKPvvLQpIDxub2J1aGlybzEuaXdhbWF0c3VAdG9zaGliYS5jby5qcD47
IHBhdmVsQGRlbnguZGUNCj4gQ2M6IGNpcC1kZXZAbGlzdHMuY2lwLXByb2plY3Qub3JnOyBKb2hu
c29uQ0guQ2hlbkBtb3hhLmNvbQ0KPiBTdWJqZWN0OiBbUEFUQ0ggUkVTRU5EIDQuNC55LWNpcCAx
MC8xNV0gUE0gLyBPUFA6IFNldCBjcHVfZGV2LT5pZCBpbiBjcHVtYXNrIGZpcnN0DQo+IA0KPiBG
cm9tOiBQaS1DaGVuZyBDaGVuIDxwaS1jaGVuZy5jaGVuQGxpbmFyby5vcmc+DQo+IA0KPiBTZXQg
Y3B1X2Rldi0+aWQgaW4gY3B1bWFzayBmaXJzdCB3aGVuIHNldHRpbmcgdXAgY3B1bWFzayBmb3Ig
Q1BVcyB0aGF0DQo+IHNoYXJlIHRoZSBzYW1lIE9QUCB0YWJsZS4gVGhpcyBtaWdodCBiZSBoZWxw
ZnVsIHdoZW4gaGFuZGxpbmcgY3B1bWFzaw0KPiB3aXRob3V0IHRoZSBvcmlnaW5hbCBDUFUgYml0
ZmllbGQgc2V0Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogUGktQ2hlbmcgQ2hlbiA8cGktY2hlbmcu
Y2hlbkBsaW5hcm8ub3JnPg0KPiBBY2tlZC1ieTogVmlyZXNoIEt1bWFyIDx2aXJlc2gua3VtYXJA
bGluYXJvLm9yZz4NCj4gU2lnbmVkLW9mZi1ieTogUmFmYWVsIEouIFd5c29ja2kgPHJhZmFlbC5q
Lnd5c29ja2lAaW50ZWwuY29tPg0KDQpZb3UgZm9yZ290IGFkZGluZyB5b3VyIHNpZ25lZC1vZmYt
YnkgdGFnIGFuZCB1cHN0cmVhbSBjb21taXQgaWQuDQoNCkJlc3QgcmVnYXJkcywNCiAgTm9idWhp
cm8NCg0KPiAtLS0NCj4gIGRyaXZlcnMvYmFzZS9wb3dlci9vcHAvY3B1LmMgfCAzICsrLQ0KPiAg
MSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvYmFzZS9wb3dlci9vcHAvY3B1LmMgYi9kcml2ZXJzL2Jhc2UvcG93
ZXIvb3BwL2NwdS5jDQo+IGluZGV4IDFhMmU4ZjI2MGIwNjAuLmEwZGI4YjM1NzVmMzggMTAwNjQ0
DQo+IC0tLSBhL2RyaXZlcnMvYmFzZS9wb3dlci9vcHAvY3B1LmMNCj4gKysrIGIvZHJpdmVycy9i
YXNlL3Bvd2VyL29wcC9jcHUuYw0KPiBAQCAtMjE4LDcgKzIxOCw2IEBAIEVYUE9SVF9TWU1CT0xf
R1BMKGRldl9wbV9vcHBfb2ZfY3B1bWFza19hZGRfdGFibGUpOw0KPiAgLyoNCj4gICAqIFdvcmtz
IG9ubHkgZm9yIE9QUCB2MiBiaW5kaW5ncy4NCj4gICAqDQo+IC0gKiBjcHVtYXNrIHNob3VsZCBi
ZSBhbHJlYWR5IHNldCB0byBtYXNrIG9mIGNwdV9kZXYtPmlkLg0KPiAgICogUmV0dXJucyAtRU5P
RU5UIGlmIG9wZXJhdGluZy1wb2ludHMtdjIgYmluZGluZ3MgYXJlbid0IHN1cHBvcnRlZC4NCj4g
ICAqLw0KPiAgaW50IGRldl9wbV9vcHBfb2ZfZ2V0X3NoYXJpbmdfY3B1cyhzdHJ1Y3QgZGV2aWNl
ICpjcHVfZGV2LCBjcHVtYXNrX3Zhcl90IGNwdW1hc2spDQo+IEBAIC0yMzQsNiArMjMzLDggQEAg
aW50IGRldl9wbV9vcHBfb2ZfZ2V0X3NoYXJpbmdfY3B1cyhzdHJ1Y3QgZGV2aWNlICpjcHVfZGV2
LCBjcHVtYXNrX3Zhcl90IGNwdW1hc2sNCj4gIAkJcmV0dXJuIC1FTk9FTlQ7DQo+ICAJfQ0KPiAN
Cj4gKwljcHVtYXNrX3NldF9jcHUoY3B1X2Rldi0+aWQsIGNwdW1hc2spOw0KPiArDQo+ICAJLyog
T1BQcyBhcmUgc2hhcmVkID8gKi8NCj4gIAlpZiAoIW9mX3Byb3BlcnR5X3JlYWRfYm9vbChucCwg
Im9wcC1zaGFyZWQiKSkNCj4gIAkJZ290byBwdXRfY3B1X25vZGU7DQo+IC0tDQo+IDIuMjcuMC5y
YzANCg0K

--Jus1h4Z6kAOkIm5Ffqx3
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4691): https://lists.cip-project.org/g/cip-dev/message=
/4691
Mute This Topic: https://lists.cip-project.org/mt/74665640/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--Jus1h4Z6kAOkIm5Ffqx3--
