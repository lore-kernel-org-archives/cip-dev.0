Return-Path: <SRS0=63wE=CX=lists.cip-project.org=bounce+64572+5449+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE34AC43461
	for <cip-dev@archiver.kernel.org>; Mon, 14 Sep 2020 01:54:23 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26C92208FE
	for <cip-dev@archiver.kernel.org>; Mon, 14 Sep 2020 01:54:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="oT8jZHjG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26C92208FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5449+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id xpUDYY4521723xPYZRJlkmPN; Sun, 13 Sep 2020 18:54:22 -0700
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.154])
 by mx.groups.io with SMTP id smtpd.web11.52261.1600048460387009601
 for <cip-dev@lists.cip-project.org>;
 Sun, 13 Sep 2020 18:54:21 -0700
X-Received: by mo-csw.securemx.jp (mx-mo-csw1515) id 08E1sABQ032105; Mon, 14 Sep 2020 10:54:11 +0900
X-Iguazu-Qid: 34tMd2lThLgFHvxrvL
X-Iguazu-QSIG: v=2; s=0; t=1600048450; q=34tMd2lThLgFHvxrvL; m=Mc4K4ydmORSkrQ5gazwyB+kIQoDxb3GYfROLxsIBEOQ=
X-Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
	by relay.securemx.jp (mx-mr1513) id 08E1s98f032745;
	Mon, 14 Sep 2020 10:54:09 +0900
X-Received: from enc02.toshiba.co.jp ([61.202.160.51])
	by imx12.toshiba.co.jp  with ESMTP id 08E1s92O024896;
	Mon, 14 Sep 2020 10:54:09 +0900 (JST)
X-Received: from hop101.toshiba.co.jp ([133.199.85.107])
	by enc02.toshiba.co.jp  with ESMTP id 08E1s6qr032303;
	Mon, 14 Sep 2020 10:54:09 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JHegwgFXarHnzxsEUh42D0XmElouRGK58un6nJnpGTpmF2Lwl6auZM0TGPWQcp/fsg9cvu8nLVva3w5K20l+6hd7C3msOlS1FBS6RSaQNRroWEcPfaJq+L5b5aAQs1R7Aq+hZ3fjhMvzifRJtoNLFvbK1HUeLBWzfZ0uHByHCnGXkhcuySkbnxK1CMgGH78dAd9ehFPMD6TgVSbiTTXYF2PQZGXoix3cQUEDu5siLI+zOYUBG7hGqPgJIRz5DSwpuGd0CFfVmW5UCd5G6HvYgA55DtDJBdtrS/CziyfXo3HbG9Z0j4egFifRaxDUgXQ89x6nFxPcLck6l2NMEPnY8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ODAH6jEOMlzcrxwaPZ4DYyu8pBzjvkwu6MOQ6lXdLIc=;
 b=b4C27hobHyOJyg59stOkkpZqfL23BJCD2jHTlx7KYOShu+0/TYtzhfmCSgTjDy9bk0x4u8TeXE9MLCwz9C3hpDLILmFeJhcIqrwIgfrGDWbLS2XPXsf2wQs8dJ5hQo1V90ykaD//mWFZNEdLoAddTKaR/GnozTj1Sfusi1qtDYgXaEYO4URm97VYv1zhwQhwm5DOgs/D1r6Zl5IYNu7BxiFhPBVUp59zZc4x4lMiRpCCvFIL68Qln2IUloKM81z9e9IbEGuqdBrXBARSXa5ofgmTwJywuyMSi0vAC3t+zg1mmEW18e4OuAhe88JkmzVCNLsFnGUwxEtSgpl3miN3MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: "Nobuhiro Iwamatsu" <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <pavel@denx.de>
CC: <biju.das.jz@bp.renesas.com>, <cip-dev@lists.cip-project.org>,
        <chris.paterson2@renesas.com>,
        <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 4.4.y-cip 0/4] Add RZ/G1H Audio support
Thread-Topic: [PATCH 4.4.y-cip 0/4] Add RZ/G1H Audio support
Thread-Index: AQHWiDeS8SrWE1MEMkO0d4fGYaxdyaljZznAgAOtDgCAADtMYA==
Date: Mon, 14 Sep 2020 01:53:52 +0000
X-TSB-HOP: ON
Message-ID: <OSBPR01MB2983F064A474170CEF595E7992230@OSBPR01MB2983.jpnprd01.prod.outlook.com>
References: <20200911123201.7820-1-biju.das.jz@bp.renesas.com>
 <TYAPR01MB29901B8A1A5A2E227EF2E8BF92240@TYAPR01MB2990.jpnprd01.prod.outlook.com>
 <20200913211050.GA3924@amd>
In-Reply-To: <20200913211050.GA3924@amd>
Accept-Language: ja-JP, en-US
x-originating-ip: [103.91.184.0]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: baae7cba-727d-4ae2-588b-08d858510875
x-ms-traffictypediagnostic: OS0PR01MB5300:
x-microsoft-antispam-prvs: <OS0PR01MB53008BB994DB113D8C1F6D0292230@OS0PR01MB5300.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2449;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: OdrAyHUeDINTZ0IrJhu99ivOw+mGPQMqS8gzZ71Hfb4RbtjrOaV7lUPaLMlNYbHH2qe+Y3HYg471HIpveOYpmvOcvJEyvzxAjuZNRTSO/zpefvQhEYdnTXXlylfka9UK99nUUvbKEiI36Oc3mSLrx/HH0EiU6PhREio+ccVLIZ+OdhvK/ZcMIn9wNi5M5YlihYdDqRRjaBaf6bPwuO2l+XdgYR89+eH1Lxyo5oXuX2WjA6kOTyIdjvVKTxa+h4xlqetvHHWZLzmtYJvzUrIrltZXqXLUt4TQs07jIruHFXM0ravGgvJY8HmCSiUKC6ir8r4ReRgT5nN9kTxK3QEEsm7dfl85ykp27emnIMiERDPPGnYKk3CF7rjlrDqMJBNtvgIj2j/i7Gl63GzbFpv8Ug==
x-ms-exchange-antispam-messagedata: fZwB1bcuShRBybDjft4Bk7Nu4nSd8YxwKVUj+WMfhXjW9Sm5LyiXT1h8CUH5Pb5TCD2h2DpmUwLPs4rksUFqqOeuQjF+9zoc3RFftfa/tu2Q4HC4EiabSCmJMOaV8RhAxkt99F6gU6al/N4sD7EbX6z8h1ctDkdn0+PgkuPhsmg6/hdGMwGGvdzrZsoAyBleIgakZLrx/6nj6WKpLfhroo7s8W9RSwEL/5jbQn0hvQLIX8BEjF3bBC5X8QK5XsAYFxoDU0cryaXAbEJokVXgkkRXbBGmwzZdXCSuvxggTAAG6voFdzzMA+M9aS/YISAc63dpMx/FshMj+yIrw+0K+Lz2jl1FxY74tL4+cgNhNiv351FfeD59tFiG+Sp12b9EH4t0kovfQgfljIE/wTSp0aNXoySUBhVZA1F8w6hiXkc/mcndpqYuGE20pI6hnO6gRqm34p/p5RxG2Y+3uTi5j0BmOG+7octps3Q5mLh3VzbD+rpoCyyuhlk5hLsUUGUv6vDFFJ8KLkodTFwLDAkqVl6T+bhfmhSOg2RSGX9WG6H5Hc4KjkkySTzNjV4+ApyciMsZLz6bDvGSNW/7VS6OvyNvBnLBJ5Ln6142HIzptt7NoEKJRPB8rBr/Jv8uYJYgp3WU9/7CeUOTiPaDiR18ew==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2983.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: baae7cba-727d-4ae2-588b-08d858510875
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2020 01:53:52.9938
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JT9MBXlUQXmk/cML2KZCdwuEzE4xqdUXVqVvwhfc7uPKCQvlRAr31GQxhrKi+V8BOS7FwbShF2tX9ipQ0wFQUvW65ODjVm9soc3BETfqtTI48iSkMGYZ8NG32TxOew/I
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB5300
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 9orNuhoircY2r4rfsRDPodLWx4520388AA=
Content-Type: multipart/mixed; boundary="SrUzy7i7qHfxrRdg3wtE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1600048462;
 bh=0SNMdV8j0N3SJMvY+bd8q5rNbzP108gWsZ4tlIldnMg=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=oT8jZHjGtbm/DJQXb1G8E21bYVC7Uwkn6T7qoX/SzMBAXAjH5jhC6vqFuQnCw2sFNTl
 jQCM1c7yDzEM067i8cJhs40h7ztsGicUIXFAvoCBnqd5+rEhSvPO8kadjynLYoQjdhc5+
 6RMvOgXA9Y/p/OT+BQflhA7bfJ8+FR/IXp8=

--SrUzy7i7qHfxrRdg3wtE
Content-Language: ja-JP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGksDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUGF2ZWwgTWFjaGVr
IFttYWlsdG86cGF2ZWxAZGVueC5kZV0NCj4gU2VudDogTW9uZGF5LCBTZXB0ZW1iZXIgMTQsIDIw
MjAgNjoxMSBBTQ0KPiBUbzogaXdhbWF0c3Ugbm9idWhpcm8o5bKp5p2+IOS/oea0iyDilqHvvLPv
vLfvvKPil6/vvKHvvKPvvLQpIDxub2J1aGlybzEuaXdhbWF0c3VAdG9zaGliYS5jby5qcD4NCj4g
Q2M6IGJpanUuZGFzLmp6QGJwLnJlbmVzYXMuY29tOyBjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0
Lm9yZzsgcGF2ZWxAZGVueC5kZTsgY2hyaXMucGF0ZXJzb24yQHJlbmVzYXMuY29tOw0KPiBwcmFi
aGFrYXIubWFoYWRldi1sYWQucmpAYnAucmVuZXNhcy5jb20NCj4gU3ViamVjdDogUmU6IFtQQVRD
SCA0LjQueS1jaXAgMC80XSBBZGQgUlovRzFIIEF1ZGlvIHN1cHBvcnQNCj4gDQo+IEhpIQ0KPiAN
Cj4gPiA+IFRoaXMgcGF0Y2ggc2VyaWVzIGFkZCBhdWRpbyBzdXBwb3J0IGZvciBpV2F2ZSBSWi9H
MUggYm9hcmQgYmFzZWQgb24NCj4gPiA+IHI4YTc3NDIgU29DIHRvIDQuNC55LWNpcCBrZXJuZWwu
IEFsbCBwYXRjaGVzIGluIHRoaXMgc2VyaWVzDQo+ID4gPiBhcmUgY2hlcnJ5LXBpY2tlZCBmcm9t
IG1haW5saW5lLg0KPiA+ID4NCj4gPiA+IExhZCBQcmFiaGFrYXIgKDQpOg0KPiA+ID4gICBkdC1i
aW5kaW5nczogQVNvQzogcmVuZXNhcyxyc25kOiBBZGQgcjhhNzc0MiBzdXBwb3J0DQo+ID4gPiAg
IEFSTTogZHRzOiByOGE3NzQyOiBBZGQgYXVkaW8gc3VwcG9ydA0KPiA+ID4gICBBUk06IGR0czog
cjhhNzc0Mi1pd2cyMWQtcTc6IEVuYWJsZSBTR1RMNTAwMCBhdWRpbyBjb2RlYw0KPiA+ID4gICBB
Uk06IGR0czogcjhhNzc0Mi1pd2cyMWQtcTc6IFNvdW5kIERNQSBzdXBwb3J0IHZpYSBEVkMgb24g
RFRTDQo+ID4gPg0KPiA+ID4gIC4uLi9iaW5kaW5ncy9zb3VuZC9yZW5lc2FzLHJzbmQudHh0ICAg
ICAgICAgICB8ICAgMSArDQo+ID4gPiAgYXJjaC9hcm0vYm9vdC9kdHMvcjhhNzc0Mi1pd2cyMWQt
cTcuZHRzICAgICAgIHwgMTAwICsrKysrKysNCj4gPiA+ICBhcmNoL2FybS9ib290L2R0cy9yOGE3
NzQyLmR0c2kgICAgICAgICAgICAgICAgfCAyNzIgKysrKysrKysrKysrKysrKysrDQo+ID4gPiAg
MyBmaWxlcyBjaGFuZ2VkLCAzNzMgaW5zZXJ0aW9ucygrKQ0KPiA+ID4NCj4gPg0KPiA+IEkgcmV2
aWV3ZCB0aGlzIHBhdGNoIHNlcmllcy4NCj4gPiBMb29rcyBnb29kIHRvIG1lLiBJZiBJZiBubyBv
YmplY3Rpb24sIEkgd2lsbCBhcHBseSBhbmQgcHVzaCB0aGlzLg0KPiA+IEFuZCBJIGFtIHRlc3Rp
bmcgb24gaHR0cHM6Ly9naXRsYWIuY29tL2NpcC1wcm9qZWN0L2NpcC1rZXJuZWwvbGludXgtY2lw
Ly0vcGlwZWxpbmVzLzE4ODgyNzIzOS4NCj4gPg0KPiANCj4gTG9va3MgZ29vZCB0byBtZSwgdG9v
LiBJIGhhdmUgbm8gb2JqZWN0aW9ucy4NCg0KVGhhbmtzISBJIGFwcGxpZWQgYW5kIHB1c2hlZC4N
Cg0KQmVzdCByZWdhcmRzLA0KICBOb2J1aGlybw0K

--SrUzy7i7qHfxrRdg3wtE
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5449): https://lists.cip-project.org/g/cip-dev/message=
/5449
Mute This Topic: https://lists.cip-project.org/mt/76778357/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--SrUzy7i7qHfxrRdg3wtE--
