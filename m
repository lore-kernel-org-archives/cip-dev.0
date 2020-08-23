Return-Path: <SRS0=Tk1j=CB=lists.cip-project.org=bounce+64572+5234+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87D54C433DF
	for <cip-dev@archiver.kernel.org>; Sun, 23 Aug 2020 23:15:16 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C07A2072D
	for <cip-dev@archiver.kernel.org>; Sun, 23 Aug 2020 23:15:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="pRWpvbw5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C07A2072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5234+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id AM3DYY4521723xP3QTyuTYb0; Sun, 23 Aug 2020 16:15:15 -0700
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.156])
 by mx.groups.io with SMTP id smtpd.web10.184970.1598224513477493485
 for <cip-dev@lists.cip-project.org>;
 Sun, 23 Aug 2020 16:15:14 -0700
X-Received: by mo-csw.securemx.jp (mx-mo-csw1114) id 07NNF3NK013786; Mon, 24 Aug 2020 08:15:04 +0900
X-Iguazu-Qid: 2wGrV5Exka3PLUfZqd
X-Iguazu-QSIG: v=2; s=0; t=1598224503; q=2wGrV5Exka3PLUfZqd; m=CnXorI+ooFNSOuF8YU6NicF3h4FqxZM3yb4e1SWuSfU=
X-Received: from imx2.toshiba.co.jp (imx2.toshiba.co.jp [106.186.93.51])
	by relay.securemx.jp (mx-mr1112) id 07NNF2li021442;
	Mon, 24 Aug 2020 08:15:02 +0900
X-Received: from enc01.localdomain ([106.186.93.100])
	by imx2.toshiba.co.jp  with ESMTP id 07NNF2ZI015508;
	Mon, 24 Aug 2020 08:15:02 +0900 (JST)
X-Received: from hop001.toshiba.co.jp ([133.199.164.63])
	by enc01.localdomain  with ESMTP id 07NNF1C2009230;
	Mon, 24 Aug 2020 08:15:02 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MwdGQlmhDBZ9K6ephrJTnwK7LLiTtyKPJUFBaHNgUV+bOzcy2fEtBEYbDWCcOR7DLytqIMeIZdc7HVhjRYvez7UbmONR4U5sam2TECpPRSscmtUhQFdlLY3IbXYCW048qfl6zFg7myLvYyyJQTXsen/vbwwZiGZ77z6gyz8iJEqZjCixHLEgNeoBDYE0l0Izm/Q3ExyPX5UPV+nps7/LCsuGC+h0t0q9p63Prr9uprk2QhuOxsXguYKV7XsRF6uLsTMsPqUMM2vN3Nd7qvBz3n9sv4fl5eivOsG0DBSQ7B7cMxBw2OZnLKFifv39UwrgqjqX/IBh1NN6Ekp6tOlaIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bRYvSs0vCPaDxvGWSZl7LUhub+O7TnXZiLkUdqCH26c=;
 b=KGI87Sr0yyAfZhLEj3oVUCkKy8SusXPx+qLdDOYfy16I+t8F//ecpUuZU/9zigjyVlcdPYIWiK78eHzMhuW0ydZxnkm+Ilr9PsJBxnz/oUT4mLagXCaMehgwILj3XvqBjP3LQQXkYlkWSD/M+ptPnAn04UfyDzl1HvyPC0HXOBeEsoXXRwSWfgXxe6erMvZDAJbTlpdCF8vIqAEyg0owM20LDTIIdustKS9n70TtrNi1mkFf1OjV9xs5CKAdgej5HDcSMc7h9G2h8bwL7QeDqlrUPNv78wRQfjOF+daKnEcdasefPtuz92X2TRHqGfC9vjKFYmlTishTPws1vW9/WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: "Nobuhiro Iwamatsu" <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <pavel@denx.de>, <cip-dev@lists.cip-project.org>
CC: <biju.das.jz@bp.renesas.com>, <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 4.19.y-cip 00/12] Support RZ/G2[MN] rev4 board
Thread-Topic: [cip-dev] [PATCH 4.19.y-cip 00/12] Support RZ/G2[MN] rev4 board
Thread-Index: AQHWdkbxX/juT+uBnkyQ61ZJRT4BiKk/sq2AgAEF8YCABWSRgIAAPBnw
Date: Sun, 23 Aug 2020 23:15:00 +0000
X-TSB-HOP: ON
Message-ID: <OSBPR01MB29835B16492823EE8943DCE592590@OSBPR01MB2983.jpnprd01.prod.outlook.com>
References: <20200819163634.5430-1-biju.das.jz@bp.renesas.com>
 <20200819173857.GA5567@amd>
 <OSAPR01MB238513FFAB73D179C17BDE5CB75A0@OSAPR01MB2385.jpnprd01.prod.outlook.com>
 <20200823193743.GE25365@duo.ucw.cz>
In-Reply-To: <20200823193743.GE25365@duo.ucw.cz>
Accept-Language: ja-JP, en-US
x-originating-ip: [103.91.184.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f765614f-587c-4511-e79b-08d847ba5bce
x-ms-traffictypediagnostic: OSAPR01MB4340:
x-microsoft-antispam-prvs: <OSAPR01MB43409697BA892D87C9D8355292590@OSAPR01MB4340.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: aJGq05zkPNOPsk+sljPzh+Mb4m9o1/OTA+HzNInWsVV+zSzopMdpwPNsXDFnaTi41GBDB6s5edUQJfJ7Z35GerN5nN7Vze/8Y/3xauW7cGKfNTqPpFf5BsCfHA8UhVGLkGESRUr2xxdKGA4tKjBJld1A8KzJ8CvGULlup09F1qQjJysObG8xKR+E2AnVFKAkxW9JSM3WHXi2z3D+9QPAEilN5jspq3pFr4sCHbiIOBU5tjQ0huFv9uAx0kG6vC3YdlADvYlyKcN4oy79tn3nbp2pCjNUnB0d8+GJ/HetXE2luHpfZWV2fPYLs1pX0KNljyThj0YlxVeMIaBFRWzNow==
x-ms-exchange-antispam-messagedata: JL8a8Z9+7YbZT3idgzDOPINvWl3Pvvh9f6xDRDtpu9jM79BG55Aidnf2Eh0xN1/2IIX1RTEYp9pEhMmzMrkIObEtPdvumLYTRQ7kLg4F9vzKKbeF9YTkhMQGe+mKdQogM8RFsh88XeNMseWmyw6o+xdiqAw0hRlwrDukXVsQhpewM+UePJuq1Sxyf+ndKJM9tpUKER9p1Sf9hTedtER0l1faIDj2lIfvKdXcBjn9G/NkcclfRaLG07s+vKcflm2Dp7KKGF7QqS8Q43K60OZFHFitZ+pt/PjfcVFIq9S3H94DZuWNDoQRZ6bRl6PELv4V4q/OexnOrMF/t/WIcGy2UCtFbz3xyHcfH+3UQx3WRa1PyIbSBB0QMcLyJ9SQDox0QGrFZkjUaBPBa7xpvLBCCHKi2EE5V+Nn3KrQaI0DGHYCIy4DTe34lzlEqDHmPp/YqOMr8f5pxNRMNKUxW46XOMjie7q7SXmmQ51SiZGzDeGtSyFMbu/1JZbJkdnryTyB8es2mVdnDX96AyvfzV6qifV1BVt7SGVhMFMMHWU9PVW8d6gn4ObeuxBTPWiTE5MRbSn88xHTsvODmanrodYB7oAeJO6T31iwG/jPVGYxU7gg27wr75Ps42L64Ie8Vpt1jA45H7wOV8chs97CrF4vug==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2983.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f765614f-587c-4511-e79b-08d847ba5bce
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2020 23:15:00.1641
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rnZhx8hVLnBlPwBctPOXeuJDJ+8NMuGVNMBnhCZQAtFkEdxwe6trjRUiHh2oNyHx2fdPgFkgtUaNJgCgJQC7KnBl5AubPXEQPhTzmMBYtVw3kWWSk+RrD7VX40iSg1mW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB4340
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 9kEMy3c0OEQB2xTtRQ5Z6hx2x4520388AA=
Content-Type: multipart/mixed; boundary="X3w3ZnuodaMtFSL49YiH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1598224515;
 bh=1g1TrA7XbU1BXQeFRUsfcnBw4Fdk9LevtnphAYFRo0I=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=pRWpvbw5alBm6NW2EctyYHKd50pqOXPDN18nSmgwunJSufLoB5L5yXgyhni84uB/vMG
 5sCHlDZNCZW0wuFMb3YVrmaBl1EvTua37IV23cVUu+BusLX7XHQ1xYA4h+/MF4wfJtjbs
 yRBTSJl1FoUmIE7eh/R+CR8KG8rRx4jOHkg=

--X3w3ZnuodaMtFSL49YiH
Content-Language: ja-JP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGksDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUGF2ZWwgTWFjaGVr
IFttYWlsdG86cGF2ZWxAZGVueC5kZV0NCj4gU2VudDogTW9uZGF5LCBBdWd1c3QgMjQsIDIwMjAg
NDozOCBBTQ0KPiBUbzogY2lwLWRldkBsaXN0cy5jaXAtcHJvamVjdC5vcmcNCj4gQ2M6IFBhdmVs
IE1hY2hlayA8cGF2ZWxAZGVueC5kZT47IEJpanUgRGFzIDxiaWp1LmRhcy5qekBicC5yZW5lc2Fz
LmNvbT47IGl3YW1hdHN1IG5vYnVoaXJvKOWyqeadviDkv6HmtIsg4pah77yz77y377yj4pev77yh
DQo+IO+8o++8tCkgPG5vYnVoaXJvMS5pd2FtYXRzdUB0b3NoaWJhLmNvLmpwPjsgUHJhYmhha2Fy
IE1haGFkZXYgTGFkIDxwcmFiaGFrYXIubWFoYWRldi1sYWQucmpAYnAucmVuZXNhcy5jb20+DQo+
IFN1YmplY3Q6IFJlOiBbY2lwLWRldl0gW1BBVENIIDQuMTkueS1jaXAgMDAvMTJdIFN1cHBvcnQg
UlovRzJbTU5dIHJldjQgYm9hcmQNCj4gDQo+IEhpIQ0KPiANCj4gPiA+ICoqKiBncGc0byB8IFRo
ZSBzaWduYXR1cmUgb2YgdGhpcyBlbWFpbCBjb3VsZCBub3QgYmUgdmVyaWZpZWQgYmVjYXVzZSB0
aGUNCj4gPiA+IGZvbGxvd2luZyBwdWJsaWMga2V5IGlzIG1pc3NpbmcuIENsaWNrIGhlcmUgdG8g
c2VhcmNoIGFuZCBpbXBvcnQgdGhlIGtleQ0KPiA+ID4gMzBFN0YwNkE5NURCRkFGMiAqKioNCj4g
PiA+DQo+ID4gPiBIaSENCj4gPiA+DQo+ID4gPiA+IFRoaXMgcGF0Y2ggc2VyaWVzIGZvciBzdXBw
b3J0aW5nIFJaL0cyW01OXSByZXY0IGJvYXJkIHRvIGNpcC00LjE5LnkNCj4gPiA+ID4ga2VybmVs
Lg0KPiA+ID4NCj4gPiA+ID7CoCBhcmNoL2FybTY0L2Jvb3QvZHRzL3JlbmVzYXMvcjhhNzc0YTEu
ZHRzaSB8IDExIC0tLS0tLS0tLS0tDQo+ID4gPiA+wqAgMSBmaWxlIGNoYW5nZWQsIDExIGRlbGV0
aW9ucygtKQ0KPiA+ID4NCj4gPiA+IEknbSBwcmV0dHkgc3VyZSB0aGlzIGlzIG5vdCB0aGUgcmVh
bCBkaWZmc3RhdC4NCj4gPiA+DQo+ID4gPiBMZXQgbWUgZ28gdGhyb3VnaCB0aGUgY2hhbmdlcy4g
T25lIGNvbmNlcm46IHlvdSBhcmUgcmVuYW1pbmcgZHRzDQo+ID4gPiBmaWxlcy4gTmV3IG5hbWVz
IG1ha2UgYSBsb3Qgb2Ygc2Vuc2UsIGJ1dCB0aGF0IHdpbGwgbGlrZWx5IGJyZWFrIHRoZQ0KPiA+
ID4gdXNlcnMsIGluY2x1ZGluZyBvdXIgdGVzdCBpbmZyYXN0cnVjdHVyZSwgbm8/DQo+IA0KPiA+
ICBUZWNobmljYWxseSB5ZXMsIGl0IHdvdWxkIGNhdXNlIHByb2JsZW1zLiBIb3dldmVyIHRoaXMg
c2VlbXMgdG8gYmUNCj4gPiB0aGUgd2F5IG9mIGRvaW5nIHRoaW5ncyB1cHN0cmVhbS4gIEkgZ3Vl
c3MgdXBzdHJlYW0gaXMgYSBiaXQNCj4gPiBkaWZmZXJlbnQgdGhvdWdoIGFzIHVzZXJzIHdvdWxk
IGV4cGVjdCBzdWNoIHRoaW5ncyB3aGVuIHVwZ3JhZGluZw0KPiA+IEtlcm5lbCB2ZXJzaW9ucy4N
Cj4gDQo+IFllcywgaXQgaXMgdXBzdHJlYW0gcHJvYmxlbSwgYW5kIHNob3VsZCBiZSBmaXhlZCB1
cHN0cmVhbS4NCj4gDQo+IEFuZCBubywgbm90IGV2ZW4gdXBncmFkaW5nIGtlcm5lbCB2ZXJzaW9u
cyBzaG91bGQgYnJlYWsgYW55dGhpbmcuDQo+IA0KPiA+IGxhYi1jaXAtcmVuZXNhcyB1c2VzIHJl
djQgYm9hcmRzLCBzbyBmcm9tIGEgQ0lQIHRlc3RpbmcgcG9pbnQgb2YNCj4gPiAgdmlldyB0aGVy
ZSB3aWxsIGJlIG5vIGlzc3Vlcy4NCj4gDQo+IE9rLCBnb29kIHRvIGtub3csIGl0IHNlZW1zIC1y
ZXYyIGJvYXJkcyBhcmUga2luZCBvZiByYXJlPw0KPiANCj4gSSBndWVzcyB3ZSBjb3VsZCBjcmVh
dGUgIlJFQURNRS5jaXAiIGV4cGxhaW5pbmcgc3VjaCBub24tc3RhbmRhcmQNCj4gaXNzdWVzLCBh
bmQgbWVudGlvbiBpdCBpbiByZWxlYXNlIGNoYW5nZWxvZy4NCg0KT3IgSSB0aGluayB3ZSBjYW4g
ZG8gdGhpcyBieSBpbmNsdWRpbmcgbW9yZSBpbmZvcm1hdGlvbiBvbiB0aGUgcmVmZXJlbmNlIGhh
cmR3YXJlDQphbmQgdGVzdCBpbmZvcm1hdGlvbiBvbiBDSVAgd2lraS4NCg0KPiANCj4gQmVzdCBy
ZWdhcmRzLA0KPiAJCQkJCQkJCVBhdmVsDQoNCkJlc3QgcmVnYXJkcywNCiAgTm9idWhpcm8NCg0K
PiAtLQ0KPiBERU5YIFNvZnR3YXJlIEVuZ2luZWVyaW5nIEdtYkgsICAgICAgTWFuYWdpbmcgRGly
ZWN0b3I6IFdvbGZnYW5nIERlbmsNCj4gSFJCIDE2NTIzNSBNdW5pY2gsIE9mZmljZTogS2lyY2hl
bnN0ci41LCBELTgyMTk0IEdyb2ViZW56ZWxsLCBHZXJtYW55DQo=

--X3w3ZnuodaMtFSL49YiH
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5234): https://lists.cip-project.org/g/cip-dev/message=
/5234
Mute This Topic: https://lists.cip-project.org/mt/76290780/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--X3w3ZnuodaMtFSL49YiH--
