Return-Path: <SRS0=jkEm=CJ=lists.cip-project.org=bounce+64572+5341+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A10EC433E6
	for <cip-dev@archiver.kernel.org>; Mon, 31 Aug 2020 22:44:36 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0E932083E
	for <cip-dev@archiver.kernel.org>; Mon, 31 Aug 2020 22:44:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="MWxb1Jxm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0E932083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5341+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 8w1pYY4521723xp2Pf793f45; Mon, 31 Aug 2020 15:44:35 -0700
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.157])
 by mx.groups.io with SMTP id smtpd.web11.453.1598913872822888951
 for <cip-dev@lists.cip-project.org>;
 Mon, 31 Aug 2020 15:44:34 -0700
X-Received: by mo-csw.securemx.jp (mx-mo-csw1115) id 07VMiT92028136; Tue, 1 Sep 2020 07:44:30 +0900
X-Iguazu-Qid: 2wGrblJYEjHCCBzmUq
X-Iguazu-QSIG: v=2; s=0; t=1598913869; q=2wGrblJYEjHCCBzmUq; m=CB014SDAkDuw1bmw3H7IM5DJJmCRdXpVc/sNzU+QiJs=
X-Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
	by relay.securemx.jp (mx-mr1111) id 07VMiSar035609;
	Tue, 1 Sep 2020 07:44:28 +0900
X-Received: from enc02.toshiba.co.jp ([61.202.160.51])
	by imx12.toshiba.co.jp  with ESMTP id 07VMiRwg002787;
	Tue, 1 Sep 2020 07:44:27 +0900 (JST)
X-Received: from hop101.toshiba.co.jp ([133.199.85.107])
	by enc02.toshiba.co.jp  with ESMTP id 07VMiROp013977;
	Tue, 1 Sep 2020 07:44:27 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H0MaA8j2zFRR2uFYY+GMlqlDRuntIk1qTp7XW8t5fvTwslVPW/kIbLtu/lrG0+/JGTaqS3ZLaWqghHUsNy2f4ABQxs9XP+bmGTGTRUuAkqVNZoEHA/wm97XP2s0JIUD7W9CZTKIkUxugyRoJxH1RJSwy6hgsbyDPDVLbjH8zopy9usG3Kx0lRCeEG56KZf0VzWPO5F1LUK/kapGuhOVRhL/nK9zEcKFJmxstMqUhz4I6bbmkr+zirrb2Vf6uAq80smu+qg2578JUYC/wI5Bi+pwA+atawvIR1U+92jY0u+uGZr3dkdfEkYBjEpZcE6ndXFD82Ecehq/smG5730V8jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GgXx8QF7BmKuSAWnPC2ix7zrtU8t6oHJlkw+d5SmL60=;
 b=W5+6bfhvsQX16vYaKISFuw5uEPbspuoAnlFu1HI60W6qzDMvbO9fDyyOFLOFXWkxsqaGxjEyFCMXIEdkraBw/DaHBub0AuMK3rkp7G1dAi/iCEqez9uI3+u84ZaHpX13j/Gy2mzlg1gs0L9lbie6qdgQ+pm080k4mo2L/mMiPHCgwLJaSmq8mXwR4mGmzfLrherL2em0xVBuOmBrHjXjxMKMa3cRyYVkolxyu3NkXMNqhy+zwKtagYLK4BO8Uc2xONH9/8cSwJ7+vVASG1CZqbaX5v4Cx3lFQy8k1LbKOwIpLqMajBewRrl+P0WJc9tro+0JpWEvFm/kElIwLK07+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: "Nobuhiro Iwamatsu" <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <jan.kiszka@siemens.com>, <cip-dev@lists.cip-project.org>
Subject: Re: [cip-dev] [isar-cip-core][PATCH] ci: Change to single job
Thread-Topic: [cip-dev] [isar-cip-core][PATCH] ci: Change to single job
Thread-Index: AQHWfzJ64ksrLwZ6tkevtTUubfuY9KlRufqAgAEXmnA=
Date: Mon, 31 Aug 2020 22:44:26 +0000
X-TSB-HOP: ON
Message-ID: <OSBPR01MB2983F3AC334DC70D8DF1EB7E92510@OSBPR01MB2983.jpnprd01.prod.outlook.com>
References: <20200831010244.2629769-1-nobuhiro1.iwamatsu@toshiba.co.jp>
 <08d5685b-5e0a-7ac0-7564-df8df859588b@siemens.com>
In-Reply-To: <08d5685b-5e0a-7ac0-7564-df8df859588b@siemens.com>
Accept-Language: ja-JP, en-US
x-originating-ip: [103.91.184.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e005cb56-e6fc-4618-3d8e-08d84dff69f7
x-ms-traffictypediagnostic: OSYPR01MB5381:
x-microsoft-antispam-prvs: <OSYPR01MB53813D187F5E33138D69417392510@OSYPR01MB5381.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: /dMZ8njfeJ6puz9zzc6Af0WD9E3wSPvfiM98Hn0mEW3SHPK/YEPZpO/hzmZwCDFTUWvlonGV8erkVTxUstvFCvwZ5t6nou96ji0nA/rWD9qrkRzkc/otIqxsjk4s+OL6yScTqUS6mQaESTxtQ7odg/Tu8YUWKVPkiv9ivCtVlOORw5+HGWirFry1nAdQt0kh/p1ce4gTrOmLIUh/7sWFCdzPxcnlPPt1mC80xhUeKypJ0aqI6k4odDSV6f8lNmCaErb6TZ6BpQtmjts6cugz23pGY/UV7+ZV3MUp/IJifQxR4rn2SF1B1thpRe1O4RpKPF0zqYSYXH4IqYwTMFwLDUks77ZR4U0ZOs432ukwtH1sxAuvOIA72xEYv72pnh2195R0KKo4lWw72i8yrrpKyg==
x-ms-exchange-antispam-messagedata: Udyq2Vzl3FnCDPOoDuNxHkf2OjGk0hvFyR9eGLfOKTnTdmmFdgo6iz08dZbok6eoFWVTgM4ak5UllXT6noju6HMHqxzx84xp0gb4Sh0AIZ8iRahjSNfJtpkSqjpYf5+BY50xC6VWP9MBBYJcWvaz4P/XqVFNmxCisEmX2IZLD9KLd0RwshaRazwJX3dz9/lt451sJ0vlkUVAMdllFy7lY4XFGnKuDgc0pCPbYA1Sxc/trey21iRAXQceo9LI2jhRtig2MeKjSP/zU39ay23mbapxteicG7t6V7hK7vYXd+OM3NaDQrx1SZzufeA4x4hnh36Yn0XmbNjvobAn7esLXCj+DdnG9psw5+VLYi3bNI0u4WxHLLxph7rRD4SzMvaem190hGIJwvo0NKcIfG+WvumYDkivWMGGNa5ZKOovE9qQora4EBNKmYgOgfJT9N9lhjvuLuZ/w1ZadhZ8cpGZLQ1rsNtInkDnbSrRNYSUHklsTO5YylxwslaXF9zLwW+80zL7M7knJpi5F6Gk8+racffmQIEUhpJgWhCaulyZCPX67r2rMQ2OC5FNeqU2pX3OsJ1xxHYQmnkjJkuVceydTxkMrMsHlddk6CZSjqdgc3RP+BNQAjNefaxkyaPAkmcELulLRQCh/bLzHmbAea28zw==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2983.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e005cb56-e6fc-4618-3d8e-08d84dff69f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2020 22:44:26.2085
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ghv/Ib1DGF6MDo5FW/Xngku8/PWpjcE9EK7Vkfeii6HNyFKm4GJI3Lj6UzJHt6SvQJO9Zp8oKnYfhBiweP6Gxml8vqNURZBWe21fisVsvadAiJExgQsou0FrEAxuf7zv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSYPR01MB5381
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 4nqbxTNFvOxkSHcl0nn9oSAtx4520388AA=
Content-Type: multipart/mixed; boundary="H4ehqTTL6nzIMqABdvkb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1598913875;
 bh=lT4aQwLTmhRGNWLxPhm6dSGFmATz2G2L3p1PkLcmEK8=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=MWxb1Jxm5EaOdDD/qo7aLgF81h4HVysss8YC+mNH+gvOAPD31vlO5lDLyODClm+/Pj4
 xALqVt1d0GqCLDoBtaMPD7xH1RgqcUX3QcUaL+rQXQ4wRlMYs47S1OQPwNza5Qfb/hRfp
 cGKV9m6EnIMDNqaU/46g3Zn9qyFqGRTrTcI=

--H4ehqTTL6nzIMqABdvkb
Content-Language: ja-JP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGksDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSmFuIEtpc3prYSBb
bWFpbHRvOmphbi5raXN6a2FAc2llbWVucy5jb21dDQo+IFNlbnQ6IE1vbmRheSwgQXVndXN0IDMx
LCAyMDIwIDM6MDIgUE0NCj4gVG86IGNpcC1kZXZAbGlzdHMuY2lwLXByb2plY3Qub3JnOyBpd2Ft
YXRzdSBub2J1aGlybyjlsqnmnb4g5L+h5rSLIOKWoe+8s++8t++8o+KXr++8oe+8o++8tCkgPG5v
YnVoaXJvMS5pd2FtYXRzdUB0b3NoaWJhLmNvLmpwPg0KPiBTdWJqZWN0OiBSZTogW2NpcC1kZXZd
IFtpc2FyLWNpcC1jb3JlXVtQQVRDSF0gY2k6IENoYW5nZSB0byBzaW5nbGUgam9iDQo+IA0KPiBP
biAzMS4wOC4yMCAwMzowMiwgTm9idWhpcm8gSXdhbWF0c3Ugd3JvdGU6DQo+ID4gU2lnbmVkLW9m
Zi1ieTogTm9idWhpcm8gSXdhbWF0c3UgPG5vYnVoaXJvMS5pd2FtYXRzdUB0b3NoaWJhLmNvLmpw
Pg0KPiA+IC0tLQ0KPiANCj4gVGhlIHJlYXNvbiBzaG91bGQgYmUgZG9jdW1lbnRlZCBpbiB0aGUg
Y29tbWl0IGxvZy4gSG93IGFib3V0DQo+IA0KPiAiUGFyYWxsZWwgZmV0Y2hpbmcgb2YgZ2l0IHNu
YXBzaG90cyBmcm9tIGtlcm5lbC5vcmcgb2Z0ZW4gZmFpbGVkLCBlaXRoZXINCj4gZHVlIHRvIHRo
cm90dGxpbmcgb3Igc29tZSBwcm9ibGVtIG9mIHRoZSBzZXJ2ZXIuIFdlIG5lZWQgdG8gYXZvaWQg
dGhpcw0KPiBmb3Igbm93LiINCj4gDQo+ID8NCj4gDQoNClJpZ2h0LiBJIHdpbGwgYWRkLg0KDQo+
IEFsc28sIHRoaXMgZG9lcyBub3QgYWRkcmVzcyB0aGUgYnJlYWthZ2Ugb2YgdGhlIGhpaG9wZS1y
emcybSBkZXBsb3ltZW50Lg0KPiBJJ2xsIHNlbmQgYSBwYXRjaCwgcGxlYXNlIGRvdWJsZSBjaGVj
ayBpdA0KPiANCg0KT2gsIHNvcnJ5LCBJIHdpbGwgY2hlY2sgeW91ciBwYXRjaC4NCg0KPiBKYW4N
Cg0KQmVzdCByZWdhcmRzLA0KICBOb2J1aGlybw0KDQoNCj4gDQo+ID4gIC5naXRsYWItY2kueW1s
IHwgMTIyICsrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0N
Cj4gPiAgMSBmaWxlIGNoYW5nZWQsIDMyIGluc2VydGlvbnMoKyksIDkwIGRlbGV0aW9ucygtKQ0K
PiA+DQo+ID4gZGlmZiAtLWdpdCBhLy5naXRsYWItY2kueW1sIGIvLmdpdGxhYi1jaS55bWwNCj4g
PiBpbmRleCA4MDJkYmNkLi41YmQ0Nzc0IDEwMDY0NA0KPiA+IC0tLSBhLy5naXRsYWItY2kueW1s
DQo+ID4gKysrIGIvLmdpdGxhYi1jaS55bWwNCj4gPiBAQCAtMiwxNyArMiwxMCBAQCBpbWFnZTog
a2FzcHJvamVjdC9rYXMtaXNhcjoxLjENCj4gPg0KPiA+ICB2YXJpYWJsZXM6DQo+ID4gICAgR0lU
X1NUUkFURUdZOiBjbG9uZQ0KPiA+IC0gIHJlbGVhc2U6IGJ1c3Rlcg0KPiA+IC0gIGV4dGVudGlv
bjogYmFzZQ0KPiA+IC0gIHVzZV9ydDogZW5hYmxlDQo+ID4gLSAgdGFyZ3o6IGVuYWJsZQ0KPiA+
IC0gIGR0Yjogbm9uZQ0KPiA+DQo+ID4gLXN0YWdlczoNCj4gPiAtICAtIGJ1aWxkDQo+ID4gLQ0K
PiA+IC1kZWZhdWx0Og0KPiA+IC0gIGJlZm9yZV9zY3JpcHQ6DQo+ID4gK2FsbDoNCj4gPiArICBz
dGFnZTogYnVpbGQNCj4gPiArICBzY3JpcHQ6DQo+ID4gICAgICAtIGV4cG9ydCBodHRwX3Byb3h5
PSRIVFRQX1BST1hZDQo+ID4gICAgICAtIGV4cG9ydCBodHRwc19wcm94eT0kSFRUUFNfUFJPWFkN
Cj4gPiAgICAgIC0gZXhwb3J0IGZ0cF9wcm94eT0kRlRQX1BST1hZDQo+ID4gQEAgLTIwLDgzICsx
MywzMiBAQCBkZWZhdWx0Og0KPiA+ICAgICAgLSBleHBvcnQgQVdTX0FDQ0VTU19LRVlfSUQ9JEFX
U19BQ0NFU1NfS0VZX0lEDQo+ID4gICAgICAtIGV4cG9ydCBBV1NfU0VDUkVUX0FDQ0VTU19LRVk9
JEFXU19TRUNSRVRfQUNDRVNTX0tFWQ0KPiA+DQo+ID4gLS5idWlsZF9iYXNlOg0KPiA+IC0gIHN0
YWdlOiBidWlsZA0KPiA+IC0gIHZhcmlhYmxlczoNCj4gPiAtICAgIGJhc2VfeWFtbDogImthcy1j
aXAueW1sOmthcy9ib2FyZC8ke3RhcmdldH0ueW1sIg0KPiA+IC0gIHNjcmlwdDoNCj4gPiAtICAg
IC0gc3VkbyBybSAtcmYgYnVpbGQvdG1wDQo+ID4gLSAgICAtIGlmIFsgIiR7dXNlX3J0fSIgPSAi
ZW5hYmxlIiBdOyB0aGVuIGJhc2VfeWFtbD0iJHtiYXNlX3lhbWx9Omthcy9vcHQvcnQueW1sIjsg
Zmk7DQo+ID4gLSAgICAtIGlmIFsgIiR7ZXh0ZW50aW9ufSIgIT0gImJhc2UiIF07IHRoZW4gYmFz
ZV95YW1sPSIke2Jhc2VfeWFtbH06a2FzL29wdC8ke2V4dGVudGlvbn0ueW1sIjsgZmk7DQo+ID4g
LSAgICAtIGlmIFsgIiR7dGFyZ3p9IiA9ICJlbmFibGUiIF07IHRoZW4gYmFzZV95YW1sPSIke2Jh
c2VfeWFtbH06a2FzL29wdC90YXJnei1pbWcueW1sIjsgZmk7DQo+ID4gLSAgICAtIGthcyBidWls
ZCAke2Jhc2VfeWFtbH0NCj4gPiAtICAgIC0gc2NyaXB0cy9kZXBsb3ktY2lwLWNvcmUuc2ggJHty
ZWxlYXNlfSAke3RhcmdldH0gJHtleHRlbnRpb259ICR7ZHRifQ0KPiA+IC0NCj4gPiAtIyBiYXNl
IGltYWdlDQo+ID4gLWJ1aWxkOnNpbWF0aWMtaXBjMjI3ZS1iYXNlOg0KPiA+IC0gIGV4dGVuZHM6
DQo+ID4gLSAgICAtIC5idWlsZF9iYXNlDQo+ID4gLSAgdmFyaWFibGVzOg0KPiA+IC0gICAgdGFy
Z2V0OiBzaW1hdGljLWlwYzIyN2UNCj4gPiAtDQo+ID4gLWJ1aWxkOmJiYi1iYXNlOg0KPiA+IC0g
IGV4dGVuZHM6DQo+ID4gLSAgICAtIC5idWlsZF9iYXNlDQo+ID4gLSAgdmFyaWFibGVzOg0KPiA+
IC0gICAgdGFyZ2V0OiBiYmINCj4gPiAtICAgIGR0YjogYW0zMzV4LWJvbmVibGFjay5kdGINCj4g
PiAtDQo+ID4gLWJ1aWxkOml3ZzIwbS1iYXNlOg0KPiA+IC0gIGV4dGVuZHM6DQo+ID4gLSAgICAt
IC5idWlsZF9iYXNlDQo+ID4gLSAgdmFyaWFibGVzOg0KPiA+IC0gICAgdGFyZ2V0OiBpd2cyMG0N
Cj4gPiAtICAgIGR0YjogcjhhNzc0My1pd2cyMGQtcTctZGJjbS1jYS5kdGINCj4gPiAtDQo+ID4g
LWJ1aWxkOmhpaG9wZS1yemcybS1iYXNlOg0KPiA+IC0gIGV4dGVuZHM6DQo+ID4gLSAgICAtIC5i
dWlsZF9iYXNlDQo+ID4gLSAgdmFyaWFibGVzOg0KPiA+IC0gICAgdGFyZ2V0OiByemcybQ0KPiA+
IC0gICAgZHRiOiByZW5lc2FzL3I4YTc3NGExLWhpaG9wZS1yemcybS1leC5kdGINCj4gPiAtDQo+
ID4gLWJ1aWxkOnFlbXUtYW1kNjQtYmFzZToNCj4gPiAtICBleHRlbmRzOg0KPiA+IC0gICAgLSAu
YnVpbGRfYmFzZQ0KPiA+IC0gIHZhcmlhYmxlczoNCj4gPiAtICAgIHRhcmdldDogcWVtdS1hbWQ2
NA0KPiA+IC0gICAgZXh0ZW50aW9uOiBzZWN1cml0eQ0KPiA+IC0gICAgdXNlX3J0OiBkaXNhYmxl
DQo+ID4gLSAgICB0YXJnejogZGlzYWJsZQ0KPiA+IC0NCj4gPiAtIyB0ZXN0DQo+ID4gLWJ1aWxk
OnNpbWF0aWMtaXBjMjI3ZS10ZXN0Og0KPiA+IC0gIGV4dGVuZHM6DQo+ID4gLSAgICAtIC5idWls
ZF9iYXNlDQo+ID4gLSAgdmFyaWFibGVzOg0KPiA+IC0gICAgdGFyZ2V0OiBzaW1hdGljLWlwYzIy
N2UNCj4gPiAtICAgIGV4dGVudGlvbjogdGVzdA0KPiA+IC0NCj4gPiAtYnVpbGQ6YmJiLXRlc3Q6
DQo+ID4gLSAgZXh0ZW5kczoNCj4gPiAtICAgIC0gLmJ1aWxkX2Jhc2UNCj4gPiAtICB2YXJpYWJs
ZXM6DQo+ID4gLSAgICB0YXJnZXQ6IGJiYg0KPiA+IC0gICAgZXh0ZW50aW9uOiB0ZXN0DQo+ID4g
LSAgICBkdGI6IGFtMzM1eC1ib25lYmxhY2suZHRiDQo+ID4gLQ0KPiA+IC1idWlsZDppd2cyMG0t
dGVzdDoNCj4gPiAtICBleHRlbmRzOg0KPiA+IC0gICAgLSAuYnVpbGRfYmFzZQ0KPiA+IC0gIHZh
cmlhYmxlczoNCj4gPiAtICAgIHRhcmdldDogaXdnMjBtDQo+ID4gLSAgICBleHRlbnRpb246IHRl
c3QNCj4gPiAtICAgIGR0YjogcjhhNzc0My1pd2cyMGQtcTctZGJjbS1jYS5kdGINCj4gPiAtDQo+
ID4gLWJ1aWxkOmhpaG9wZS1yemcybS10ZXN0Og0KPiA+IC0gIGV4dGVuZHM6DQo+ID4gLSAgICAt
IC5idWlsZF9iYXNlDQo+ID4gLSAgdmFyaWFibGVzOg0KPiA+IC0gICAgdGFyZ2V0OiByemcybQ0K
PiA+IC0gICAgZXh0ZW50aW9uOiB0ZXN0DQo+ID4gLSAgICBkdGI6IHJlbmVzYXMvcjhhNzc0YTEt
aGlob3BlLXJ6ZzJtLWV4LmR0Yg0KPiA+ICsgICAgIyBzaW1hdGljLWlwYzIyN2UNCj4gPiArICAg
IC0ga2FzIGJ1aWxkIGthcy1jaXAueW1sOmthcy9ib2FyZC9zaW1hdGljLWlwYzIyN2UueW1sOmth
cy9vcHQvcnQueW1sOmthcy9vcHQvdGFyZ3otaW1nLnltbA0KPiA+ICsgICAgLSBzY3JpcHRzL2Rl
cGxveS1jaXAtY29yZS5zaCBidXN0ZXIgc2ltYXRpYy1pcGMyMjdlIGJhc2Ugbm9uZQ0KPiA+ICsg
ICAgIyBiYmINCj4gPiArICAgIC0ga2FzIGJ1aWxkIGthcy1jaXAueW1sOmthcy9ib2FyZC9iYmIu
eW1sOmthcy9vcHQvcnQueW1sOmthcy9vcHQvdGFyZ3otaW1nLnltbA0KPiA+ICsgICAgLSBzY3Jp
cHRzL2RlcGxveS1jaXAtY29yZS5zaCBidXN0ZXIgYmJiIGJhc2UgYW0zMzV4LWJvbmVibGFjay5k
dGINCj4gPiArICAgICMgaXdnMjBtDQo+ID4gKyAgICAtIGthcyBidWlsZCBrYXMtY2lwLnltbDpr
YXMvYm9hcmQvaXdnMjBtLnltbDprYXMvb3B0L3J0LnltbDprYXMvb3B0L3Rhcmd6LWltZy55bWwN
Cj4gPiArICAgIC0gc2NyaXB0cy9kZXBsb3ktY2lwLWNvcmUuc2ggYnVzdGVyIGl3ZzIwbSBiYXNl
IHI4YTc3NDMtaXdnMjBkLXE3LWRiY20tY2EuZHRiDQo+ID4gKyAgICAjIHJ6ZzJtDQo+ID4gKyAg
ICAtIGthcyBidWlsZCBrYXMtY2lwLnltbDprYXMvYm9hcmQvcnpnMm0ueW1sOmthcy9vcHQvcnQu
eW1sOmthcy9vcHQvdGFyZ3otaW1nLnltbA0KPiA+ICsgICAgLSBzY3JpcHRzL2RlcGxveS1jaXAt
Y29yZS5zaCBidXN0ZXIgcnpnMm0gYmFzZSByZW5lc2FzL3I4YTc3NGExLWhpaG9wZS1yemcybS1l
eC5kdGINCj4gPiArDQo+ID4gKyAgICAjIHFlbXUtYW1kNjQgLyBzZWN1cml0eQ0KPiA+ICsgICAg
LSBrYXMgYnVpbGQga2FzLWNpcC55bWw6a2FzL2JvYXJkL3FlbXUtYW1kNjQueW1sOmthcy9vcHQv
c2VjdXJpdHkueW1sDQo+ID4gKyAgICAtIHNjcmlwdHMvZGVwbG95LWNpcC1jb3JlLnNoIGJ1c3Rl
ciBxZW11LWFtZDY0IHNlY3VyaXR5IGJhc2UNCj4gPiArDQo+ID4gKyAgICAjIHNpbWF0aWMtaXBj
MjI3ZSAvIHRlc3QNCj4gPiArICAgIC0ga2FzIGJ1aWxkIGthcy1jaXAueW1sOmthcy9ib2FyZC9z
aW1hdGljLWlwYzIyN2UueW1sOmthcy9vcHQvcnQueW1sOmthcy9vcHQvdGVzdC55bWw6a2FzL29w
dC90YXJnei1pbWcueW1sDQo+ID4gKyAgICAtIHNjcmlwdHMvZGVwbG95LWNpcC1jb3JlLnNoIGJ1
c3RlciBzaW1hdGljLWlwYzIyN2UgdGVzdCBub25lDQo+ID4gKyAgICAjIGJiYiAvIHRlc3QNCj4g
PiArICAgIC0ga2FzIGJ1aWxkIGthcy1jaXAueW1sOmthcy9ib2FyZC9iYmIueW1sOmthcy9vcHQv
cnQueW1sOmthcy9vcHQvdGVzdC55bWw6a2FzL29wdC90YXJnei1pbWcueW1sDQo+ID4gKyAgICAt
IHNjcmlwdHMvZGVwbG95LWNpcC1jb3JlLnNoIGJ1c3RlciBiYmIgdGVzdCBhbTMzNXgtYm9uZWJs
YWNrLmR0Yg0KPiA+ICsgICAgIyBpd2cyMG0gLyB0ZXN0DQo+ID4gKyAgICAtIGthcyBidWlsZCBr
YXMtY2lwLnltbDprYXMvYm9hcmQvaXdnMjBtLnltbDprYXMvb3B0L3J0LnltbDprYXMvb3B0L3Rl
c3QueW1sOmthcy9vcHQvdGFyZ3otaW1nLnltbA0KPiA+ICsgICAgLSBzY3JpcHRzL2RlcGxveS1j
aXAtY29yZS5zaCBidXN0ZXIgaXdnMjBtIHRlc3QgcjhhNzc0My1pd2cyMGQtcTctZGJjbS1jYS5k
dGINCj4gPiArICAgICMgcnpnMm0gLyB0ZXN0DQo+ID4gKyAgICAtIGthcyBidWlsZCBrYXMtY2lw
LnltbDprYXMvYm9hcmQvcnpnMm0ueW1sOmthcy9vcHQvcnQueW1sOmthcy9vcHQvdGVzdC55bWw6
a2FzL29wdC90YXJnei1pbWcueW1sDQo+ID4gKyAgICAtIHNjcmlwdHMvZGVwbG95LWNpcC1jb3Jl
LnNoIGJ1c3RlciByemcybSB0ZXN0IHJlbmVzYXMvcjhhNzc0YTEtaGlob3BlLXJ6ZzJtLWV4LmR0
Yg0KPiA+DQo+ID4NCj4gPiANCj4gPg0KPiANCj4gLS0NCj4gU2llbWVucyBBRywgQ29ycG9yYXRl
IFRlY2hub2xvZ3ksIENUIFJEQSBJT1QgU0VTLURFDQo+IENvcnBvcmF0ZSBDb21wZXRlbmNlIENl
bnRlciBFbWJlZGRlZCBMaW51eA0K

--H4ehqTTL6nzIMqABdvkb
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5341): https://lists.cip-project.org/g/cip-dev/message=
/5341
Mute This Topic: https://lists.cip-project.org/mt/76525805/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--H4ehqTTL6nzIMqABdvkb--
