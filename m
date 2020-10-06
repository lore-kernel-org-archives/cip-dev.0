Return-Path: <SRS0=teY2=DN=lists.cip-project.org=bounce+64572+5501+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6150AC4363D
	for <cip-dev@archiver.kernel.org>; Tue,  6 Oct 2020 23:43:28 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 700D820B80
	for <cip-dev@archiver.kernel.org>; Tue,  6 Oct 2020 23:43:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="Ue4reciQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 700D820B80
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5501+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id AojMYY4521723xdiNshw9xHb; Tue, 06 Oct 2020 16:43:26 -0700
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.155])
 by mx.groups.io with SMTP id smtpd.web11.1284.1602027804567121866
 for <cip-dev@lists.cip-project.org>;
 Tue, 06 Oct 2020 16:43:26 -0700
X-Received: by mo-csw.securemx.jp (mx-mo-csw1516) id 096Nh5to010424; Wed, 7 Oct 2020 08:43:05 +0900
X-Iguazu-Qid: 34trqomzYyQEbOjKiI
X-Iguazu-QSIG: v=2; s=0; t=1602027785; q=34trqomzYyQEbOjKiI; m=r051/tQnqRA4VxOXxLlwFCueE6wihkmab7JHbHvg/a4=
X-Received: from imx2.toshiba.co.jp (imx2.toshiba.co.jp [106.186.93.51])
	by relay.securemx.jp (mx-mr1510) id 096Nh3pG015002;
	Wed, 7 Oct 2020 08:43:04 +0900
X-Received: from enc01.toshiba.co.jp ([106.186.93.100])
	by imx2.toshiba.co.jp  with ESMTP id 096Nh3pF024203;
	Wed, 7 Oct 2020 08:43:03 +0900 (JST)
X-Received: from hop001.toshiba.co.jp ([133.199.164.63])
	by enc01.toshiba.co.jp  with ESMTP id 096Nh01u024791;
	Wed, 7 Oct 2020 08:43:02 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N3270uwiPN9oZfCcmHj6IQ0ZsvgfUe+zfSlo273PCRrBJji9yANyh7g8IVFyf6iwE77mkRNAYSDLnLCLgAO+ObfukgvyhinB6pf8ttS/m5rs8s78SbeFIv8d0qLdcZ1lUgKUmNC9AHQYHGzOEa9ooLJlGDH5kbbAsbWLSfogrIrGQag+m8TQW565MLckAkrJ2SHw5AdOCaeLCcgw6GmutW7Wbc2no2wNXr+JgV1kxj/gup8fn1gBZKzFNEP+qYnZ6BXQLXvsRe4EBibKjVsdhSzWza+G7X5Kma5EILCa+0nQ+pGwdpDwG1MfZD2noGyoCMKFfeJDdeEQJZuXxv4Skg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d+gDx1R/OX4G1AqJJlNP++//80CRXmlpmUoNYY6Pz3w=;
 b=EuKXCyPSScF9xyslMmX/jmVK3Lk3ymyPsBrJxX9N5/l7STv4kejVc8qyiIC+o6lxlw2L+yutb51OV9USQ1pqlBo9hi4Y/Eo3LEm0xVmH7IevWamppgKEO3pqu4etJrHvX4ZcimLXDtEqyfIEHj9pI/tgIC5TNlIvB8GT1yoelEYGSOsEfhONdoTYv7Nio0Xx43AlCZrSU3e2aTAEqWjud5XSPK0qAvqdKJek8TwhfTK9cHf/IGETlg/CxxBSAbNG+/vxMh97b4NS8XK1YChTTDLavF5fI6lbI0aPy4NuPMH1IrcG+5i8/znc4mtPQQmbXhgUxPokRqLM6CCeIB6srA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: "Nobuhiro Iwamatsu" <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>, <pavel@denx.de>
CC: <jan.kiszka@siemens.com>, <SZ.Lin@moxa.com>,
        <ben.hutchings@codethink.co.uk>, <Chris.Paterson2@renesas.com>
Subject: Re: [cip-dev] [ANNOUNCE] v4.19.148-cip35-rt15
Thread-Topic: [cip-dev] [ANNOUNCE] v4.19.148-cip35-rt15
Thread-Index: AQHWmi3HbeDruN0ZlkG2LoC92+G9x6mH5dqAgAATW4CAAhzRMIABKiPA
Date: Tue, 6 Oct 2020 23:43:00 +0000
X-TSB-HOP: ON
Message-ID: <OSBPR01MB2983148027370F1B4D02B0B6920D0@OSBPR01MB2983.jpnprd01.prod.outlook.com>
References: <20201004090653.GA18130@amd>
 <TYAPR01MB23984E9AECF0CDEE4B32B7F1B70F0@TYAPR01MB2398.jpnprd01.prod.outlook.com>
 <20201004213905.GA8065@duo.ucw.cz>
 <163B547D5FFC3079.30511@lists.cip-project.org>
In-Reply-To: <163B547D5FFC3079.30511@lists.cip-project.org>
Accept-Language: ja-JP, en-US
x-originating-ip: [103.91.184.0]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3eaf5b04-6b2d-439b-3347-08d86a518f92
x-ms-traffictypediagnostic: OSBPR01MB4359:
x-microsoft-antispam-prvs: <OSBPR01MB435943D80CC3C3D3547A94E3920D0@OSBPR01MB4359.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: mOO3J7rC6Du5DU1CVIkF35oLRdNEQy0JBdUcZYb56mrcuYIGQhm/XN27/d47iL+2ySGRB6MY+0TWmlxwds96KgM0z8kCSweXhkf4ZcaDiRyZXNRg7dFqzB61gSMyHK5EatfVa9WFO6vr0+KL/4nbBDRPGf0Bo6JczzwxLgFXT2KK+pID8GR53cpucGdE13UNT2XIbJXbXOYg/JTwLJ/V5UxDLTQ1tGPi7l2FRo4/dgACQqF8WPqWR0gpZNWa0eOLb/qBBYuzUSnhUYIQ3W/P8a1qfTO53P3+ZNxRId6j+KWSpso0SU5O3A3cabF6VsI6Y3g2nfgredBDJxuQLHph2IKLWdWqs5m+OZTHaePmhGyQAnO2uWhU8rCXEpRMSjFVKnxK2xLdK6KdR+rcb4d/+A==
x-ms-exchange-antispam-messagedata: MTWhy3DiN2XNFDjbP+G5dcyC7lAxv2lNxmnPVOdO9cUInPcSHMBO2P4Q+oRd7H8E59spqh0uIU2gXgBqnPhOkNLYVLSlzWnFwBmPN8mXAtq3jhn0LqBYYgGV5EbHvmOihS+wl2adzMeF3yAyMaiyrvzL0GACzwn9kCQtCRmMcS1EW6Y8WLHNJcfeOpHqe8CXJrizW/gYXAwrHxbbcIGbwBfLP5dw5CJ+Mz1CKEXNLgkpAaoWdXnp38ZYarw+1rK5qdAUca/qiTCuZhIzaklPtlbx8oMbknLtFfuuH6lSanSpymB8TA/nSdpslz65A8/wwDswrnckyf46kZbKEWfJKuVeJxRaxb9Jzt2cmBsNHWe6+0Wf9ZrrGnVP7g+GA9oeOTGHezFj7U7f5MPocBlwAADfdscMS+8aZr5V7fEq3knfnDnPGnp+qGmrChOwOzp/6l0lcr9nvPs7QUxZUQmvT48s5SfpGw/SR1galpmIj2XIVLTwASAyfxDMEVzuz81Z/OCjmTykAdtfA/OSDBt+HFR9pE8NrgqOK1NSU1umuuEisvbh5FQW4u/0dSGHkYc1yNvgc+RqoAyQfeVziztLdyo+ol1vVIbd2o2GPPacRmBrvvpf7NhUQ8Hmf7ydDgErRd1NjCewK1sJ+QuXQow9gw==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2983.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3eaf5b04-6b2d-439b-3347-08d86a518f92
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2020 23:43:00.5844
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0KxCaWk0BTakplRkY9wCTUcbPLpntS0c84NAByoZ8ZoYkClhTlrQqwgshcK5N6Nclow6w+i9sRkvaSdcrbA7tAh7yaCNXVlBbk2prtVZcOi1Gx1uYTLKoXjHh7I+pxOv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB4359
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: pEdYefLY30bSnpWO1KWNTK9hx4520388AA=
Content-Type: multipart/mixed; boundary="dznSzJf3Knj69XBijJ6L"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1602027806;
 bh=6NVnBzLYh4bZH4icGYrSPzexn70ILGArMG+Uil66bTo=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=Ue4reciQUawrgmEf9utsftRx0lH5Iwv1Acf1xZhVEpRiu9rAfoX9APVtOS0tt1tTaTA
 HpatDv//f7BqENTIJGZMEgRY9//N2X1k9Q7/imJSb3GXa529yb7bkOV9L9tdGU54jN1Ep
 YMs8iCFHoRiw4SV8DppgNA4vMP7DuyV4ZP4=

--dznSzJf3Knj69XBijJ6L
Content-Language: ja-JP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGksDQoNCkZZSToNCiBodHRwczovL3BhdGNod29yay5vemxhYnMub3JnL3Byb2plY3QvbmV0ZGV2
L3BhdGNoLzIwMjAwOTIyMDcyOTMxLjIxNDgtMS1nZWVydCtyZW5lc2FzQGdsaWRlci5iZS8NCg0K
QmVzdCByZWdhcmRzLA0KICBOb2J1aGlybw0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0t
DQo+IEZyb206IGNpcC1kZXZAbGlzdHMuY2lwLXByb2plY3Qub3JnIFttYWlsdG86Y2lwLWRldkBs
aXN0cy5jaXAtcHJvamVjdC5vcmddIE9uIEJlaGFsZiBPZiBOb2J1aGlybyBJd2FtYXRzdQ0KPiBT
ZW50OiBUdWVzZGF5LCBPY3RvYmVyIDYsIDIwMjAgMzo0OSBQTQ0KPiBUbzogY2lwLWRldkBsaXN0
cy5jaXAtcHJvamVjdC5vcmc7IHBhdmVsQGRlbnguZGUNCj4gQ2M6IGphbi5raXN6a2FAc2llbWVu
cy5jb207IFNaLkxpbkBtb3hhLmNvbTsgYmVuLmh1dGNoaW5nc0Bjb2RldGhpbmsuY28udWs7IENo
cmlzLlBhdGVyc29uMkByZW5lc2FzLmNvbQ0KPiBTdWJqZWN0OiBSZTogW2NpcC1kZXZdIFtBTk5P
VU5DRV0gdjQuMTkuMTQ4LWNpcDM1LXJ0MTUNCj4gDQo+IEhpLA0KPiANCj4gVGhpcyBpc3N1ZSBz
ZWVtcyB0byBvY2N1ciByYW5kb21seS4NCj4gDQo+ICMgY2lwK3J0IGtlcm5lbA0KPiBORzogaHR0
cHM6Ly9sYXZhLmNpcGxhdGZvcm0ub3JnL3NjaGVkdWxlci9qb2IvNTcxMjkNCj4gICAgIGh0dHBz
Oi8vbGF2YS5jaXBsYXRmb3JtLm9yZy9zY2hlZHVsZXIvam9iLzU3ODQyDQo+IE9LOiBodHRwczov
L2xhdmEuY2lwbGF0Zm9ybS5vcmcvc2NoZWR1bGVyL2pvYi81Nzg1MQ0KPiAgICAgaHR0cHM6Ly9s
YXZhLmNpcGxhdGZvcm0ub3JnL3NjaGVkdWxlci9qb2IvNTc4NDENCj4gDQo+ICMgNC4xOS4xNDgr
Y2lwIGtlcm5lbA0KPiBORzogaHR0cHM6Ly9sYXZhLmNpcGxhdGZvcm0ub3JnL3NjaGVkdWxlci9q
b2IvNTg4MzYNCj4gT0s6IGh0dHBzOi8vbGF2YS5jaXBsYXRmb3JtLm9yZy9zY2hlZHVsZXIvam9i
LzU4ODM3DQo+IA0KPiANCj4gV2UgbWF5IG5lZWQgdG8gY29uZmlybSB0aGVzZSByZWxhdGlvbnNo
aXBzIHdpdGggQ0lQIGtlcm5lbCBwYXRjaGVzLg0KPiANCj4gQmVzdCByZWdhcmRzLA0KPiAgIE5v
YnVoaXJvDQo+IA0KPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gRnJvbTogY2lw
LWRldkBsaXN0cy5jaXAtcHJvamVjdC5vcmcgW21haWx0bzpjaXAtZGV2QGxpc3RzLmNpcC1wcm9q
ZWN0Lm9yZ10gT24gQmVoYWxmIE9mIFBhdmVsIE1hY2hlaw0KPiA+IFNlbnQ6IE1vbmRheSwgT2N0
b2JlciA1LCAyMDIwIDY6MzkgQU0NCj4gPiBUbzogQ2hyaXMgUGF0ZXJzb24gPENocmlzLlBhdGVy
c29uMkByZW5lc2FzLmNvbT4NCj4gPiBDYzogUGF2ZWwgTWFjaGVrIDxwYXZlbEBkZW54LmRlPjsg
amFuLmtpc3prYUBzaWVtZW5zLmNvbTsgY2lwLWRldkBsaXN0cy5jaXAtcHJvamVjdC5vcmc7IFNa
LkxpbkBtb3hhLmNvbTsNCj4gPiBiZW4uaHV0Y2hpbmdzQGNvZGV0aGluay5jby51aw0KPiA+IFN1
YmplY3Q6IFJlOiBbY2lwLWRldl0gW0FOTk9VTkNFXSB2NC4xOS4xNDgtY2lwMzUtcnQxNQ0KPiA+
DQo+ID4gSGkhDQo+ID4NCj4gPiA+ID4gTmV3IHJlYWx0aW1lIHRyZWVzIHNob3VsZCBiZSBhdmFp
bGFibGUgYXQga2VybmVsLm9yZy4NCj4gPiA+ID4NCj4gPiA+ID4gVHJlZXMgYXJlIGF2YWlsYWJs
ZSBhdA0KPiA+ID4gPg0KPiA+ID4gPiBodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGlu
dXgva2VybmVsL2dpdC9jaXAvbGludXgtDQo+ID4gPiA+IGNpcC5naXQvbG9nLz9oPWxpbnV4LTQu
MTkueS1jaXAtcnQNCj4gPiA+ID4gaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4
L2tlcm5lbC9naXQvY2lwL2xpbnV4LQ0KPiA+ID4gPiBjaXAuZ2l0L2xvZy8/aD1saW51eC00LjE5
LnktY2lwLXJ0LXJlYmFzZQ0KPiA+ID4gPg0KPiA+ID4gPiBBbmQgdGhlaXIgY29udGVudCBzaG91
bGQgYmUgaWRlbnRpY2FsLg0KPiA+ID4NCj4gPiA+IFRoYW5rIHlvdSBmb3IgdGhlIHJlbGVhc2Uu
DQo+ID4gPg0KPiA+ID4gPg0KPiA+ID4gPiBUaGlzIHBhdGNoIG1lcmdlcyA0LjE5LjE0OC1zdGFi
bGUgaW50byAtY2lwLXJ0IChiZWNhdXNlIHRoYXQncyB3aGF0DQo+ID4gPiA+IHJlY2VudCAtcnQg
aXMgYmFzZWQgb24sIGFuZCBvbGRlciAtcnQgdHJlZSBpcyB0b28gb2xkKS4gVW5mb3J0dW5hdGVs
eSwNCj4gPiA+ID4gdGhhdCBicmluZ3MgcmVncmVzc2lvbiB3aXRoIGV0aGVybmV0IG9uIFJlbmVz
YXMgQXJtNjQgdGFyZ2V0cywgd2hpY2gNCj4gPiA+ID4gd2lsbCBwcmV2ZW50IGJvb3QsIGFuZCBm
YWlsIHRlc3RzIGV0Yy4NCj4gPiA+ID4NCj4gPiA+ID4gS2VybmVsIHRoYXQgc2hvdWxkIHdvcmsg
b2sgb24gUmVuZXNhcyBBcm02NCBtYWNoaW5lcyBjYW4gYmUgb2J0YWluZWQNCj4gPiA+ID4gYnkg
cmV2ZXJ0aW5nIGZiM2E3ODBlN2E3NmNmOGVmYjA1NWY4MzIyZWMwMzk5MjNjZWU0MWYgInJhdmI6
IEZpeGVkIHRvDQo+ID4gPiA+IGJlIGFibGUgdG8gdW5sb2FkIG1vZHVsZXMiIG9uIHRvcCBvZiAt
Y2lwLXJ0IHJlbGVhc2UuDQo+ID4gPg0KPiA+ID4gU28gd2UncmUgcmVsZWFzaW5nIGEgS2VybmVs
IHRoYXQgd2Uga25vdyBkb2Vzbid0IGJvb3Qgb24gb25lIG9mIENJUCdzIHJlZmVyZW5jZSBwbGF0
Zm9ybXM/DQo+ID4gPiBPciBkaWQgeW91IGFscmVhZHkgcmV2ZXJ0IHRoZSBhYm92ZSBwYXRjaCBh
cyBwYXJ0IG9mIHlvdXIgcmVsZWFzZT8NCj4gPg0KPiA+IFllcywgSSBkaWQgdGhhdCwgYXMgdGhl
IGNoYW5nZWxvZyBleHBsYWlucy4gU29ycnkuDQo+ID4NCj4gPiBJIGhhZCB0byBzZWxlY3QgZnJv
bSBmZXcgYmFkIG9wdGlvbnM6IDQuMTkuMTQ3LXJ0IHJlbGVhc2UgaXMgbm90DQo+ID4gYXZhaWxh
YmxlIGFuZCBwcmV2aW91cyByZWxlYXNlIGlzIHRvbyBvbGQuIFNvIC1jaXAtcnQgaXMgYmFzZWQg
b24NCj4gPiA0LjE5LjE0OC1ydCwgYW5kIGl0IGJyaW5ncyBpbiB0aGUgYmFkIGNvbW1pdC4NCj4g
Pg0KPiA+IEkgdGhvdWdodCBhYm91dCByZXZlcnRpbmcgaXQgZm9yIHJlbGVhc2UsIGJ1dCBhbGwg
SSdkIGdldCB3b3VsZCBiZQ0KPiA+IHJlamVjdHMsIGFzIGl0IHJlYWxseSBuZWVkcyB0byBiZSBz
b2x2ZWQgaW4gLWNpcCwgbm90IC1jaXAtcnQuDQo+ID4NCj4gPiBQcm9wZXIgc29sdXRpb24gaXMg
bGlrZWx5IHVwZGF0aW5nIDQuMTktY2lwIHRvIDQuMTkuMTQ4LCBmaXJzdC4gIFRoZW4NCj4gPiBm
aWd1cmluZyBvdXQgd2hhdCBpcyB0aGUgY2xlYW4gd2F5IHRvIHNvbHZlIHRoZSBwcm9ibGVtLCBh
bmQgdGhlbg0KPiA+IGNyZWF0aW5nIG5ldyAtcnQgcmVsZWFzZS4gQnV0IHRoYXQgd2lsbCBsaWtl
bHkgdGFrZSBtb3JlIHRoYW4gZmV3DQo+ID4gZGF5cywgYW5kIGl0IHdpbGwgZW5kIHVwIHdpdGgg
ZGlmZmVyZW50IHJlbGVhc2UgbnVtYmVyLg0KPiA+DQo+ID4gSSBjYW4gY3JlYXRlIG5ldyAtY2lw
LXJ0IHJlbGVhc2Ugd2hlbiB0aGF0IGlzIGRvbmUuDQo+ID4NCj4gPiBCZXN0IHJlZ2FyZHMsDQo+
ID4gCQkJCQkJCQlQYXZlbA0KPiA+IC0tDQo+ID4gREVOWCBTb2Z0d2FyZSBFbmdpbmVlcmluZyBH
bWJILCAgICAgIE1hbmFnaW5nIERpcmVjdG9yOiBXb2xmZ2FuZyBEZW5rDQo+ID4gSFJCIDE2NTIz
NSBNdW5pY2gsIE9mZmljZTogS2lyY2hlbnN0ci41LCBELTgyMTk0IEdyb2ViZW56ZWxsLCBHZXJt
YW55DQo=

--dznSzJf3Knj69XBijJ6L
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5501): https://lists.cip-project.org/g/cip-dev/message=
/5501
Mute This Topic: https://lists.cip-project.org/mt/77295090/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--dznSzJf3Knj69XBijJ6L--
