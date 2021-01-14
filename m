Return-Path: <SRS0=3JX2=GR=lists.cip-project.org=bounce+64572+6086+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A7B5C433DB
	for <cip-dev@archiver.kernel.org>; Thu, 14 Jan 2021 06:32:13 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A32AC238E7
	for <cip-dev@archiver.kernel.org>; Thu, 14 Jan 2021 06:32:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A32AC238E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6086+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id M3oMYY4521723xQAD8te1hPU; Wed, 13 Jan 2021 22:32:12 -0800
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.154])
 by mx.groups.io with SMTP id smtpd.web08.4534.1610605929320531460
 for <cip-dev@lists.cip-project.org>;
 Wed, 13 Jan 2021 22:32:11 -0800
X-Received: by mo-csw.securemx.jp (mx-mo-csw1515) id 10E6W0mL015445; Thu, 14 Jan 2021 15:32:01 +0900
X-Iguazu-Qid: 34tMScsDA2tqR2WgwI
X-Iguazu-QSIG: v=2; s=0; t=1610605920; q=34tMScsDA2tqR2WgwI; m=YrKFTyHdl9lEZhUgjH/YddZH5aUXQauaiVdiG3bNo7g=
X-Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
	by relay.securemx.jp (mx-mr1511) id 10E6VxGt012461;
	Thu, 14 Jan 2021 15:31:59 +0900
X-Received: from enc02.toshiba.co.jp ([61.202.160.51])
	by imx12.toshiba.co.jp  with ESMTP id 10E6Vx0r025070;
	Thu, 14 Jan 2021 15:31:59 +0900 (JST)
X-Received: from hop101.toshiba.co.jp ([133.199.85.107])
	by enc02.toshiba.co.jp  with ESMTP id 10E6VxU4026300;
	Thu, 14 Jan 2021 15:31:59 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kdx+SVytZqJY73k072w8h4etElYyJ9ip6Kv93eZ59sp6asXKLRtC9wt6BIjuEfSa7ou6311T5vfL8bEqClo9b39cGrC0+PQ8dSqFnQvdz+bxbjAfkh7dpgTIcn+Vu5Y8t0N9kZGkPnKKxvn+ZLuzdDSihDt5hn6at8rvGYIA98GnlYHcdthpLJIpH8OHr3bm45vXZV1c/JgeWvzkWisu/UM9/heYKhVDAhYcCMgbZfmsg/uxzMsaCqY7cCkmfs4MO288rRBaUDUGkwd5ZMeEhfXWnRhEJsQvg5T91Qqjs2i3TGrJFpLvqEYkt4Xu9L8RWUO+Jf3BFKKiTkkzykdT+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qwl4TjSutMM2I3aszCw3vmeabSfDziEDCnXyJmzkgQ4=;
 b=Y01/R91oyOb3AgU6Z60VAN4WK6N5HXkEBmuWJTs3JAx7aBGisWHnYaAJFVF6IyVqRCh+oqDSVnAlNr84IAk0htCKBd8IGzHyw/7bDbLhHUMcLEGs+yxplma6i74j/LWujgq4xcr4MN8hTlNrkj7Njqv/pBgdUEkd6kmYjcPCEc39MMKm2vbmwmArMleya/rRjfW0Qt2GH0NuALLshxLBFDUD6Bc8GXoCaxs965yfUpyf9XI9b/QkNuXWfwB4AdZ/X3Wx16IaFycnxKZ+ZHJEomYlrLVBo0uiE2AKLpNbxg6p99VkhGzKTCudzMNP/5462svFHGB2bVSuoD0vhpTAIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: "Nobuhiro Iwamatsu" <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <pavel@denx.de>, <prabhakar.mahadev-lad.rj@bp.renesas.com>
CC: <cip-dev@lists.cip-project.org>, <biju.das.jz@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 4.4.y-cip 0/9] Renesas RZ/G1 add support for DU, TPU, PWM, LCD
Thread-Topic: [PATCH 4.4.y-cip 0/9] Renesas RZ/G1 add support for DU, TPU,
 PWM, LCD
Thread-Index: AQHW6cVZhfQ9r1FxwUilY6ViqV7Rpqol3iIAgADL/GA=
Date: Thu, 14 Jan 2021 06:31:57 +0000
X-TSB-HOP: ON
Message-ID: <OSBPR01MB29836C639D484CD9EBBA14A592A80@OSBPR01MB2983.jpnprd01.prod.outlook.com>
References: <20210113160102.16310-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20210113182058.GA25010@duo.ucw.cz>
In-Reply-To: <20210113182058.GA25010@duo.ucw.cz>
Accept-Language: ja-JP, en-US
x-originating-ip: [103.91.184.0]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 972cf5fd-942a-432a-eacd-08d8b85617c5
x-ms-traffictypediagnostic: OS0PR01MB5681:
x-microsoft-antispam-prvs: <OS0PR01MB56814014DECFC093FE4B4FAB92A80@OS0PR01MB5681.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3173;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: WuZ0Epk2ApZ3xQIiz52pUDsGbi1JrDF5N9fZ/85vKBWlQhNs6q5fg4e2y3DXb2+ldYu0B7PYaSo6IH7t2o7s9IN+HcB6sY0tFtk4FhSnLUhHSlYriGmPx80eWLP5VTzXEajkwUDxmeXN55naC49NKGl7CRsHkNAJCWuJvjI79Go90mwS23ae6dJ75PeK0R9rrMxhdi5PGJYWP+sntau5jvPRqSm2wiWxK67gX+CZ8CPFV+3wdi+L8+m188KEBU0x68FEBz3ITvrva8Kdn6Pt1PnVAhZbamwwrbmjoauNwsymTSB04Nq5ZjdMmnBFuNd5ObZMoXVqRzivNpWfNsP2Gz7u0kguetNuNiW+Zs1O/fZ12jwqaMFsmUYxy6MInLGML/GP42yicsHvrCIniGKncA==
x-ms-exchange-antispam-messagedata: =?utf-8?B?VXMwNnJnbzVPNjMvbjI0TDNPZmZITThSMXZGZHNuOTlsc1U4OTA4d3ZIcFBo?=
 =?utf-8?B?ZElkeHFZUUUrSUFmVWJjSkZnSE9ZdGRBVlg2TzlEcmUvUnJWUXlKTFJScEJh?=
 =?utf-8?B?YzRCZkN3Q3VRWnF6bmkvNjZFVGkyTk9IUkcvR2xtdkFHRis5SjlGUkJBc1pK?=
 =?utf-8?B?MW90ZCtVb0tQUlc1bWVTWjlrWklpdzQxTFBrNFJVZkhtKzR5SUJHWHQ3RDg3?=
 =?utf-8?B?RnU1TmxETDEwL3RuWTM2OEc3VW5UU01LQXB6MloyV3ZwTEtuSVhPN3ZQREFF?=
 =?utf-8?B?eS9ia2dhbjdsSUhXanQyTXlSeHpJNHhJVlY2bGF4ZCtVNllPNE5XT1R0amFl?=
 =?utf-8?B?Q3pMQW9HYStkK1VtZkErOW9BcWlqdFBLRVNRNUx1ejQ2QlZUMlhyUEpPS3pU?=
 =?utf-8?B?UzFLdVRuYzJERjZZOW13ZFJGQUVjNWo0Rll6Zyt0VTR4RXhndi9CT3VmbG1k?=
 =?utf-8?B?b000SEk3R0h0VThQVTRpeTg4anY0OElESkJvTDh6NVVXTFEzWXozdXorNkJK?=
 =?utf-8?B?RFkvZHlLL01GZDUvcEY0MHhjWDZBRmYrR2hxazg1K2o2cFpJRHhpMFlNSXNH?=
 =?utf-8?B?blJaVGNFQURGSms4V3hxTG9LN2tTTlBHOHczMGMrUmZ1YzVpbmdSTCtVQk5O?=
 =?utf-8?B?Wi9lS0puYVpPb1BOa21qTk5leUgrcEJmL1Y1V0pmV01lSnk0MXVlQzczMVNl?=
 =?utf-8?B?M01lc0hEcHNDY2FTcHBtTzJGMTRYOGhZZ3RRZ0hyUTZEcmgzUUc3TlZpRGhW?=
 =?utf-8?B?OVNkNXExQXFZTVRTK29oenMzVWZjaU5WY3FPdURnQ1ZENE5Ld2pkNGJ5Y3ZT?=
 =?utf-8?B?TkphMGtLeXArdlo0ajJCaldRWjd0WmorakhaTEVKVVJSNDR1T3Y2RVRmS2pj?=
 =?utf-8?B?WVZVa3lWejVGMVBjWmNUVHVrbUd3R2hnOTlrcUFrVHZZWjNSUVc0bi9xbW4v?=
 =?utf-8?B?aVcwOU5XWFA5TVhNeXhhTldzQ1dDVysySkQ1Q05Ocm44eWphWHpMVFBWMjZx?=
 =?utf-8?B?Ylo4WTFEd1RZc1UydlRoQkNTN3E2dm4vREV6OGNHYStZb3BQV1AwYjZqb0JV?=
 =?utf-8?B?d256MWZHN1JLT216VGkzUVowa0ttWnljZlRrN2VMTWUwU0NGWnhHalRGWjhR?=
 =?utf-8?B?bHhTczRmMUhiTnovZUdpL2dZZXNUaWFhT1g4YTkvbjFJSThGTW1aNy9tdXI1?=
 =?utf-8?B?NWJOWDlWM1Roa3JZSkl5UjU2VEtyYm0yb2xkZjJmT1IrZm9jc0tLeG1rcmoy?=
 =?utf-8?B?Y2hpdkw1UC9ieGt0eHExRC93NisyclY0YVlJb01lRzI5cyt3cklIbU5Jejly?=
 =?utf-8?Q?YyTL8/ojgDzbg=3D?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2983.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 972cf5fd-942a-432a-eacd-08d8b85617c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2021 06:31:57.7890
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1vje5u8fOxRv0ReZe0OX8C96q2ropSVqQ1XMVKiou4ZF+xk6Icnnnk+QO9kus+CfgyHCrT5Q9ypI+sc1I9IyP/TGwTIhKrHQuuJuNUDQ1s8fB//iRNg/eEteN04zzMoQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB5681
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: uI3s9XhJnkaj0uCju6Dn3zHUx4520388AA=
Content-Type: multipart/mixed; boundary="8SEK8LSddkxO0w8y5vi3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1610605932;
 bh=PWCa3VPq9OoEiQnZ6bH3a6cVOzuSr1bjVZZ/F9KKRRg=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=ON1Zmd7OjA95VC1aCGVj8Q5i6iRGL8qLfdfzqNTQ7wgCuxabLqwyG5Ko/AeQ7o4agGU
 zUF6Rnwqbxsbck47U3IbWsCl5vO9sP6/8xh5GlFctSgBSLVVJ38hRiF9XEjT9rvRisWpk
 joALLzsuuDYFH6hnEmIouxUyB4V4hJW039w=

--8SEK8LSddkxO0w8y5vi3
Content-Language: ja-JP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGkgYWxsLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFBhdmVsIE1h
Y2hlayBbbWFpbHRvOnBhdmVsQGRlbnguZGVdDQo+IFNlbnQ6IFRodXJzZGF5LCBKYW51YXJ5IDE0
LCAyMDIxIDM6MjEgQU0NCj4gVG86IExhZCBQcmFiaGFrYXIgPHByYWJoYWthci5tYWhhZGV2LWxh
ZC5yakBicC5yZW5lc2FzLmNvbT4NCj4gQ2M6IGNpcC1kZXZAbGlzdHMuY2lwLXByb2plY3Qub3Jn
OyBpd2FtYXRzdSBub2J1aGlybyjlsqnmnb4g5L+h5rSLIOKWoe+8s++8t++8o+KXr++8oe+8o++8
tCkNCj4gPG5vYnVoaXJvMS5pd2FtYXRzdUB0b3NoaWJhLmNvLmpwPjsgUGF2ZWwgTWFjaGVrIDxw
YXZlbEBkZW54LmRlPjsgQmlqdSBEYXMgPGJpanUuZGFzLmp6QGJwLnJlbmVzYXMuY29tPg0KPiBT
dWJqZWN0OiBSZTogW1BBVENIIDQuNC55LWNpcCAwLzldIFJlbmVzYXMgUlovRzEgYWRkIHN1cHBv
cnQgZm9yIERVLCBUUFUsIFBXTSwgTENEDQo+IA0KPiBIaSENCj4gDQo+IA0KPiA+IFRoaXMgcGF0
Y2ggc2VyaWVzIGFkZHMgc3VwcG9ydCBmb3IgVFBVLCBQV00sIERVIHRvIFI4QTc3NDIgU29DIGFu
ZA0KPiA+IGVuYWJsZSBMQ0Qgb24gaXdnMjFkIGJvYXJkLg0KPiA+DQo+ID4gQWxsIHRoZSBwYXRj
aGVzIGhhdmUgYmVlbiBjaGVycnkgcGlja2VkIGZyb20gdjUuMTEtcmMzLg0KPiANCj4gU2VyaWVz
IGxvb2tzIG9rYXkgdG8gbWUuIEkgY2FuIGFwcGx5IGl0IGlmIHRoZXJlIGFyZSBubyBvdGhlcg0K
PiBjb21tZW50cy4NCg0KVGhpcyBzZXJpZXMgbG9va3MgZ29vZCB0byBtZSwgdG9vLiBJIHdpbGwg
bWVyZ2UgYW5kIHB1c2guDQoNCkJlc3QgcmVnYXJkcywNCiAgTm9idWhpcm8NCg0KDQo+IA0KPiBC
ZXN0IHJlZ2FyZHMsDQo+IAkJCQkJCQkJUGF2ZWwNCj4gDQo+IC0tDQo+IERFTlggU29mdHdhcmUg
RW5naW5lZXJpbmcgR21iSCwgICAgICBNYW5hZ2luZyBEaXJlY3RvcjogV29sZmdhbmcgRGVuaw0K
PiBIUkIgMTY1MjM1IE11bmljaCwgT2ZmaWNlOiBLaXJjaGVuc3RyLjUsIEQtODIxOTQgR3JvZWJl
bnplbGwsIEdlcm1hbnkNCg==

--8SEK8LSddkxO0w8y5vi3
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6086): https://lists.cip-project.org/g/cip-dev/message=
/6086
Mute This Topic: https://lists.cip-project.org/mt/79653996/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--8SEK8LSddkxO0w8y5vi3--
