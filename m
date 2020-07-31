Return-Path: <SRS0=9f/j=BK=lists.cip-project.org=bounce+64572+5077+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4EC3C433E0
	for <cip-dev@archiver.kernel.org>; Fri, 31 Jul 2020 20:05:09 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3952B21744
	for <cip-dev@archiver.kernel.org>; Fri, 31 Jul 2020 20:05:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="Wmx9whBO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3952B21744
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5077+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id XBbuYY4521723xDMi0hxZbtb; Fri, 31 Jul 2020 13:05:08 -0700
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.153])
 by mx.groups.io with SMTP id smtpd.web12.3017.1596225906261032997
 for <cip-dev@lists.cip-project.org>;
 Fri, 31 Jul 2020 13:05:07 -0700
X-Received: by mo-csw.securemx.jp (mx-mo-csw1514) id 06VK52gF008226; Sat, 1 Aug 2020 05:05:03 +0900
X-Iguazu-Qid: 34trDAmeL5WG44raUN
X-Iguazu-QSIG: v=2; s=0; t=1596225902; q=34trDAmeL5WG44raUN; m=EzbQVd4Z6LQMN3q0ggJ6afQHnvB1vecJl2t+r+chKfU=
X-Received: from imx2.toshiba.co.jp (imx2.toshiba.co.jp [106.186.93.51])
	by relay.securemx.jp (mx-mr1510) id 06VK51ku031606;
	Sat, 1 Aug 2020 05:05:02 +0900
X-Received: from enc01.localdomain ([106.186.93.100])
	by imx2.toshiba.co.jp  with ESMTP id 06VK51MF011045;
	Sat, 1 Aug 2020 05:05:01 +0900 (JST)
X-Received: from hop001.toshiba.co.jp ([133.199.164.63])
	by enc01.localdomain  with ESMTP id 06VK51lI022306;
	Sat, 1 Aug 2020 05:05:01 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nwbgO4Z3nWLjbGdB9dhmWOFUljhXp85v0kIJ4FluE9OzCOyj215/dKotEVXapMd0Yy0d5baYvOJ62alQ9liNj3jKDE6K76f7MAtx2pBQGdx3+pMh2EBcXAOYcWapex9JywgjwDUFCuEye7dQzcuchE4TUCbLLXpnofAw62KIVjlg/kM0QDh6c0v5Q68HOjmUJZK1JT48rWdwNULWov7tKwfyxQoYR0fbdvIpdQnUKEG/F10yTPW/sK5KaGPJOG8/IRGEPU65bpSmzLFvD0937JM3Os8ngIprKghUvUg0vHxPR9MNELkKbf69sYDz3u6d9fA6vYR4E7DY5T1vkk70Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+KqmcOR1ZBppDRAp+4SE/3Uj6KiX2QpByd80LpGeSss=;
 b=g8JLGX0+OkUc4unpYjdC0f/kFUydNTdJvZoHTh3iS3hFBeV80RBERD+JQ/iLPuRjetTIySoeK9ISmHZu5yoS6rxBJUDOIlFSh3NjmcvBK2l3sBHUFAh0YsBJFtjWQ044v603ZnOgr7po6Ppej2AFecNJJrv/u4HouzV45yaghbkrh2kwacwqRqypKzIOXhJoFNakFfQlIWc7USM2gbTE3RvYuXqtPaPp1qssSowL15amXg0+ob6R9Os6qzYBwAE3VvvT36l3IhaP7PgYO28R8RLew2bIShe6/Dsue/B46E5b2effj8BD1hymf8h3Z0SVfzGTVko52rF/pIrXOXWZ9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: "Nobuhiro Iwamatsu" <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <biju.das.jz@bp.renesas.com>, <cip-dev@lists.cip-project.org>
CC: <Chris.Paterson2@renesas.com>, <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 4.4.y-cip] ARM: dts: iwg22d-sodimm: Enable touchscreen
Thread-Topic: [PATCH 4.4.y-cip] ARM: dts: iwg22d-sodimm: Enable touchscreen
Thread-Index: AQHWZZbsTZShj1jcWUW22ApezgPMtqkfSnjggABrYwCAAmjIIA==
Date: Fri, 31 Jul 2020 20:03:54 +0000
X-TSB-HOP: ON
Message-ID: <OSBPR01MB2983E85BDA4101EF8C01318A924E0@OSBPR01MB2983.jpnprd01.prod.outlook.com>
References: <20200729105621.8242-1-biju.das.jz@bp.renesas.com>
 <OSBPR01MB2983E426B309BE9BA68FAC3392710@OSBPR01MB2983.jpnprd01.prod.outlook.com>
 <TYBPR01MB5309707BB448C3DE7D5F282686710@TYBPR01MB5309.jpnprd01.prod.outlook.com>
In-Reply-To: <TYBPR01MB5309707BB448C3DE7D5F282686710@TYBPR01MB5309.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
x-originating-ip: [103.91.184.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ce15fae9-7ae4-4163-8c3e-08d8358cda38
x-ms-traffictypediagnostic: OSBPR01MB2245:
x-microsoft-antispam-prvs: <OSBPR01MB2245C5B48A875F730F72B684924E0@OSBPR01MB2245.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: kJlfUIBYbNmdXMXs+JS0sZYs9b+G53KFLLVQPAl7h9XFCvFgv7qoYyJZQTEvpa+kYNZv2dNtfjqn+PcfeYlRiMcRQtNX3ytBeXEyPr7iMVJ/bTT6mWGrDfQLb8b6pDQaWaBabGIKWJBoAw8lq9XZNcNBd721U4Hf6Zlu9dQCV7jkXtosjmtZIOG67c8VsD4K9ulvvJcvffhqIIgcTxFihhdBsvQoWK5MVxV+f/ZCqY9NOkTUaP8W6M2y4/BdWGdHi6sST34zSDdaS3j74xvW4DOBZQiS6BgxXs2nH1+DRP+VnXpk7Fa44GO5SLzOKtmP+JMrdm7Ttom2wypmlJ9fciUD4Hi0JV9l9CGlYm6lT7xNnUYjL07sRbi9nKQpd4o+RpAqbjcaKvqQuN7Z50kY/Q==
x-ms-exchange-antispam-messagedata: TvLUTDEtYWrfmO6kmLoyJ6UiRSSqarBZlLlD0pN6m4TRxKdeB+f1foHSXJHSZUQyCr+zRRI02vL2IDhJH/rUgSlQ+i8KIohGDqMFyLyqkwPkrDciDfXQ/fVTshAouhQndkmHJmqoDhyS0ugJ+C7HqVD3bHF3BfU8Z5o5PwZAqSSlnP59EJr8Kabwggg9aUfX4XqcR3b5X41txx0BJjLMzzuVSGa9cxZoRJBwgHzceZxToBSo9i1sJr3KsX6Gvj1KUN0u5oAj+j9hqTwEDU+h6AodlIL0GP35y+Z/hvyZgmKOGfbJNWt3DPM7/R0Ao9vh2JtF/Dlwg2v/jCQ0P4NJUCgezlywCQnenRpak1TFJ3JAhthdHlZuBw7IObg985mQwrQO9DDrk0R1VSiJvrruDtJp/uuY+0pUSLl/Zz2Z8ffJruolJ62spQ/oE2UNkSgXoWEVOLYD6IH6P8cbeWRE0zjIOcSdgf2KqleLVMyaMTw=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2983.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce15fae9-7ae4-4163-8c3e-08d8358cda38
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2020 20:03:54.5058
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sXzpcziNUO2kdGbCBZP2kZKD+JAKj1RL4NOfkdt7neWverRQYQ5AhXeSAKAdZhsC71kF1pfO6jArMwmhsyGpmYtsJx5KqqURYB71k3SN2ycd9wyiM/++6CHzotqh8u11
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB2245
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: m95Vil9Rk1b6S5R1CEwtBRkwx4520388AA=
Content-Type: multipart/mixed; boundary="MqYQeJua8scGFFkiFTzs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1596225908;
 bh=K5NV6EAji1fO8jGjnvsfWS7JhPHakWVSniB3DXgJAfs=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=Wmx9whBOcWkPA322ztIGa6FnarW6eWynzXR2vwZFy+/XlERNz0wpUFj3DbekDI2mBie
 nbLPBsmj2kCbRIZlYJh6MGTBVsd5t2CYeIaveSn8bcxUWZDxLpRW76zs0oVO3PBft+ode
 8dKnFjmi5zkdH9z+w44HVCOiWlS5UczSFDo=

--MqYQeJua8scGFFkiFTzs
Content-Language: ja-JP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGksDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQmlqdSBEYXMgW21h
aWx0bzpiaWp1LmRhcy5qekBicC5yZW5lc2FzLmNvbV0NCj4gU2VudDogVGh1cnNkYXksIEp1bHkg
MzAsIDIwMjAgNDoxMSBQTQ0KPiBUbzogaXdhbWF0c3Ugbm9idWhpcm8o5bKp5p2+IOS/oea0iyDi
lqHvvLPvvLfvvKPil6/vvKHvvKPvvLQpIDxub2J1aGlybzEuaXdhbWF0c3VAdG9zaGliYS5jby5q
cD47IGNpcC1kZXZAbGlzdHMuY2lwLXByb2plY3Qub3JnDQo+IENjOiBDaHJpcyBQYXRlcnNvbiA8
Q2hyaXMuUGF0ZXJzb24yQHJlbmVzYXMuY29tPjsgUHJhYmhha2FyIE1haGFkZXYgTGFkIDxwcmFi
aGFrYXIubWFoYWRldi1sYWQucmpAYnAucmVuZXNhcy5jb20+DQo+IFN1YmplY3Q6IFJFOiBbUEFU
Q0ggNC40LnktY2lwXSBBUk06IGR0czogaXdnMjJkLXNvZGltbTogRW5hYmxlIHRvdWNoc2NyZWVu
DQo+IA0KPiBIaSBOb2J1aGlyby1zYW4sDQo+IA0KPiBUaGFua3MgZm9yIHRoZSBmZWVkYmFjay4N
Cj4gDQo+ID4gU3ViamVjdDogUkU6IFtQQVRDSCA0LjQueS1jaXBdIEFSTTogZHRzOiBpd2cyMmQt
c29kaW1tOiBFbmFibGUgdG91Y2hzY3JlZW4NCj4gPg0KPiA+IEhpLA0KPiA+DQo+ID4gPiAtLS0t
LU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+ID4gRnJvbTogQmlqdSBEYXMgW21haWx0bzpiaWp1
LmRhcy5qekBicC5yZW5lc2FzLmNvbV0NCj4gPiA+IFNlbnQ6IFdlZG5lc2RheSwgSnVseSAyOSwg
MjAyMCA3OjU2IFBNDQo+ID4gPiBUbzogY2lwLWRldkBsaXN0cy5jaXAtcHJvamVjdC5vcmc7IGl3
YW1hdHN1IG5vYnVoaXJvKOWyqeadviDkv6HmtIsg4pah77yz77y377yjDQo+ID4g4pev77yh77yj
77y0KQ0KPiA+ID4gPG5vYnVoaXJvMS5pd2FtYXRzdUB0b3NoaWJhLmNvLmpwPjsgUGF2ZWwgTWFj
aGVrIDxwYXZlbEBkZW54LmRlPg0KPiA+ID4gQ2M6IENocmlzIFBhdGVyc29uIDxjaHJpcy5wYXRl
cnNvbjJAcmVuZXNhcy5jb20+OyBCaWp1IERhcw0KPiA+ID4gPGJpanUuZGFzLmp6QGJwLnJlbmVz
YXMuY29tPjsgUHJhYmhha2FyIE1haGFkZXYgTGFkDQo+ID4gPiA8cHJhYmhha2FyLm1haGFkZXYt
bGFkLnJqQGJwLnJlbmVzYXMuY29tPg0KPiA+ID4gU3ViamVjdDogW1BBVENIIDQuNC55LWNpcF0g
QVJNOiBkdHM6IGl3ZzIyZC1zb2RpbW06IEVuYWJsZSB0b3VjaHNjcmVlbg0KPiA+ID4NCj4gPiA+
IEZyb206IE1hcmlhbi1DcmlzdGlhbiBSb3Rhcml1DQo+ID4gPiA8bWFyaWFuLWNyaXN0aWFuLnJv
dGFyaXUucmJAYnAucmVuZXNhcy5jb20+DQo+ID4gPg0KPiA+ID4gY29tbWl0IDk5YWU3OGYxZmMz
YTczYzg4ZmU3MjZjNjc2YWU5NjNjZTcyMmJmMjAgdXBzdHJlYW0uDQo+ID4gPg0KPiA+ID4gSW4g
b25lIG9mIHRoZSBpV2F2ZS1HMjJEIGRldmVsb3BtZW50IGJvYXJkIHZhcmlhbnRzLCBjYWxsZWQg
R2VuZXJpYw0KPiA+ID4gU09ESU1NIERldmVsb3BtZW50IFBsYXRmb3JtLCB3ZSBoYXZlIGFuIExD
RCB3aXRoIHRvdWNoc2NyZWVuLiBUaGUNCj4gPiA+IHJlc2lzdGl2ZSB0b3VjaCBjb250cm9sbGVy
LCBTVE1QRTgxMSBpcyBvbiB0aGUgZGV2ZWxvcG1lbnQgYm9hcmQgYW5kDQo+ID4gPiBpcyBjb25u
ZWN0ZWQgdGhyb3VnaCB0aGUgaTJjNSBvZiB0aGUgUlotRzFFLg0KPiA+ID4NCj4gPiA+IEFkZGl0
aW9uYWxseSwgdGhpcyBjb250cm9sbGVyIHNob3VsZCBnZW5lcmF0ZSBhbiBpbnRlcnJ1cHQgdG8g
dGhlIENQVQ0KPiA+ID4gYW5kIGl0IGlzIGNvbm5lY3RlZCB0aHJvdWdoIEdQSU80LDQgdG8gdGhl
IEdJQy4NCj4gPiA+DQo+ID4gPiBUb3VjaCB3YXMgdGVzdGVkIHdpdGggb25lIG9mIG91ciBpVy1S
YWluYm9XLUcyMkQtU09ESU1NIFJaL0cxRQ0KPiA+ID4gZGV2ZWxvcG1lbnQgcGxhdGZvcm1zLg0K
PiA+ID4NCj4gPiA+IE1vcmUgZGV0YWlscyBvbiB0aGUgaVdhdmUgd2Vic2l0ZToNCj4gPiA+IGh0
dHBzOi8vd3d3Lml3YXZlc3lzdGVtcy5jb20vcnotZzFlLXNvZGltbS1kZXZlbG9wbWVudC1raXQu
aHRtbA0KPiA+ID4NCj4gPiA+IFNpZ25lZC1vZmYtYnk6IE1hcmlhbi1DcmlzdGlhbiBSb3Rhcml1
DQo+ID4gPiA8bWFyaWFuLWNyaXN0aWFuLnJvdGFyaXUucmJAYnAucmVuZXNhcy5jb20+DQo+ID4g
PiBMaW5rOg0KPiA+ID4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvci8xNTgzMzM2NjUwLTI1ODQ4
LTEtZ2l0LXNlbmQtZW1haWwtbWFyaWFuLWNyaQ0KPiA+ID4gc3RpYW4ucm90YXJpdS5yYkBicC5y
ZW5lc2FzLmNvbQ0KPiA+ID4gU2lnbmVkLW9mZi1ieTogR2VlcnQgVXl0dGVyaG9ldmVuIDxnZWVy
dCtyZW5lc2FzQGdsaWRlci5iZT4NCj4gPiA+IFNpZ25lZC1vZmYtYnk6IEJpanUgRGFzIDxiaWp1
LmRhcy5qekBicC5yZW5lc2FzLmNvbT4NCj4gPg0KPiA+IFRoZXJlIHNlZW1zIHRvIGJlIG5vIGlz
c3VlIHdpdGggdGhpcyBwYXRjaCwgYnV0IHdlIGFsc28gbmVlZCB0byB1cGRhdGUNCj4gPiBkZWZj
b2ZuaWcuDQo+IA0KPiBXZSBuZWVkIHRvIGVuYWJsZSB0aGUgYmVsb3cgY29uZmlncyBpbiBzaG1v
YmlsZV9kZWZjb25maWcuIEN1cnJlbnRseSB0aGlzIGNvbmZpZ3MgYXJlIG5vdCBlbmFibGVkIGlu
DQo+IE1haW5saW5lLiBOb3Qgc3VyZSB3ZSBzaG91bGQgdXBzdHJlYW0gdGhpcyAgYW5kIGJhY2tw
b3J0IGl0IG9yIEp1c3QgZW5hYmxlIGl0IGluIGNpcC1rZXJuZWwtY29uZmlnPyBQbGVhc2UgbGV0
IG1lIGtub3cuDQo+IA0KPiBDT05GSUdfTUZEX1NUTVBFPXkNCj4gQ09ORklHX1NUTVBFX0kyQz15
DQo+IENPTkZJR19UT1VDSFNDUkVFTl9TVE1QRT15DQoNCkZpcnN0LCBJIHRoaW5rIGl0J3MgYSBn
b29kIHRvIHBvc3QgdGhlIHBhdGNoIHRvIGVuYWJsZSB0aGlzIHRvIFVwc3RyZWFtLg0KDQpCZXN0
IHJlZ2FyZHMsDQogIE5vYnVoaXJpbw0KDQo+IA0KPiBDaGVlcnMsDQo+IEJpanUNCj4gDQo+IA0K
PiBSZW5lc2FzIEVsZWN0cm9uaWNzIEV1cm9wZSBHbWJILCBHZXNjaGFlZnRzZnVlaHJlci9QcmVz
aWRlbnQ6IENhcnN0ZW4gSmF1Y2gsIFNpdHogZGVyIEdlc2VsbHNjaGFmdC9SZWdpc3RlcmVkIG9m
ZmljZToNCj4gRHVlc3NlbGRvcmYsIEFyY2FkaWFzdHJhc3NlIDEwLCA0MDQ3MiBEdWVzc2VsZG9y
ZiwgR2VybWFueSwgSGFuZGVsc3JlZ2lzdGVyL0NvbW1lcmNpYWwgUmVnaXN0ZXI6IER1ZXNzZWxk
b3JmLCBIUkIgMzcwOA0KPiBVU3QtSUROci4vVGF4IGlkZW50aWZpY2F0aW9uIG5vLjogREUgMTE5
MzUzNDA2IFdFRUUtUmVnLi1Oci4vV0VFRSByZWcuIG5vLjogREUgMTQ5Nzg2NDcNCg==

--MqYQeJua8scGFFkiFTzs
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5077): https://lists.cip-project.org/g/cip-dev/message=
/5077
Mute This Topic: https://lists.cip-project.org/mt/75862490/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--MqYQeJua8scGFFkiFTzs--
