Return-Path: <SRS0=E6W4=ET=lists.cip-project.org=bounce+64572+5799+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 923DFC4742C
	for <cip-dev@archiver.kernel.org>; Fri, 13 Nov 2020 11:07:10 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D343C207DE
	for <cip-dev@archiver.kernel.org>; Fri, 13 Nov 2020 11:07:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="IlKRijsa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D343C207DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5799+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 0qjBYY4521723xa2KRcvfA6X; Fri, 13 Nov 2020 03:07:09 -0800
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.153])
 by mx.groups.io with SMTP id smtpd.web08.2799.1605265626832180307
 for <cip-dev@lists.cip-project.org>;
 Fri, 13 Nov 2020 03:07:08 -0800
X-Received: by mo-csw.securemx.jp (mx-mo-csw1514) id 0ADB6xEL009668; Fri, 13 Nov 2020 20:06:59 +0900
X-Iguazu-Qid: 34ts1bXBCZyOPtdO2F
X-Iguazu-QSIG: v=2; s=0; t=1605265618; q=34ts1bXBCZyOPtdO2F; m=sBQntBTUoD0EIUFJLZNFFPJnlTul2Nhw+fcRC192pdc=
X-Received: from imx2.toshiba.co.jp (imx2.toshiba.co.jp [106.186.93.51])
	by relay.securemx.jp (mx-mr1511) id 0ADB6v1g013184;
	Fri, 13 Nov 2020 20:06:58 +0900
X-Received: from enc01.toshiba.co.jp ([106.186.93.100])
	by imx2.toshiba.co.jp  with ESMTP id 0ADB6vle011705;
	Fri, 13 Nov 2020 20:06:57 +0900 (JST)
X-Received: from hop001.toshiba.co.jp ([133.199.164.63])
	by enc01.toshiba.co.jp  with ESMTP id 0ADB6vcX023781;
	Fri, 13 Nov 2020 20:06:57 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UioEibKNrcdz/nYcXJP9/QhrPlQSiEC5miQjTCSXcxClfWlitlzxSzompxc6zwsbkVI0cy+4E8nTCq0UoGegX+yuAXZai2wzYax0ytlrvfE+59b4UjbxDNc/a2zB8I/YW6y9+zm/gmBJn9yZOR67r+d5CTGlpy/QkdIqEC4HyVh3kzAlC0oEae3vZH8FCsHLJYoSXYbbMWf+q2FF7bGDTpCRHla4QE0JQDQgYt5yFurFkwWeSu+ihBzcGQsm49S0ODENBQSlxUdTvm6N9YfozXzo2gcI6zVJAmq+lE8VdrbVkuTJ6/Qld529dIttsYXB+NgZa4sZJxQXfkTk19EgJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V3wFgUcjWmZNbuZv+9x77/rV6UcuILqCnTGYsu3WvbI=;
 b=oH1a3lFv3hZp4TXB85Kwgq2zA/82QmZGq2rhEK+bbcg9+sJ67aGotnMjV8GdI0t4m7/R91g+lDoYyEFy1+ayAKXt2hvnYwZnGOxNSFmeghGBJ4kQtmZCJFgVPhp5iQOdmj1Mi9TwKwv7ENwogcornuihU0wLhvf7c/ZXtwmyMDzLjw/bsXCJpHfPKH77egs9EZK9IQWjk35tnYmowuFdFL8zJyrHsokYNbqauax8BKxPlAQ/KDNCtJscfoYCr3i547PBTlbcmjhjX4oEZXAUhLpkqb5Fx/KeIi2ih2A6M17xXnj8SAtdBA1trDp7V6HpqM8IrkF0Tsf1jfhVFsQrCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: "Nobuhiro Iwamatsu" <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>, <pavel@denx.de>
CC: <biju.das.jz@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 4.19.y-cip 00/17] Renesas RZ/G2H add FCP{FV}, VSP, FDP1, DU, HDMI, LVDS, PWM and sound support
Thread-Topic: [cip-dev] [PATCH 4.19.y-cip 00/17] Renesas RZ/G2H add FCP{FV},
 VSP, FDP1, DU, HDMI, LVDS, PWM and sound support
Thread-Index: AQHWsgd//I5iIs3v20mmEg7J7HgJK6m3P6TAgABlSoCAACrBQIAOISWQ
Date: Fri, 13 Nov 2020 11:06:55 +0000
X-TSB-HOP: ON
Message-ID: <OSBPR01MB29833BA3F208593382EF399B92E60@OSBPR01MB2983.jpnprd01.prod.outlook.com>
References: <20201103173336.2829-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <OSBPR01MB2983B43D8C63FD5AFE24C87892EF0@OSBPR01MB2983.jpnprd01.prod.outlook.com>
 <20201104082839.GA5821@amd>
 <OSBPR01MB5048C1E56BE8E9C5BC4CF78DAAEF0@OSBPR01MB5048.jpnprd01.prod.outlook.com>
In-Reply-To: <OSBPR01MB5048C1E56BE8E9C5BC4CF78DAAEF0@OSBPR01MB5048.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
x-originating-ip: [103.91.184.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e782318a-a58a-40ad-f928-08d887c43b8e
x-ms-traffictypediagnostic: OS0PR01MB5298:
x-microsoft-antispam-prvs: <OS0PR01MB52982D85A16F3383AAC2D86D92E60@OS0PR01MB5298.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3173;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: BLfyueeN3/pGjwDCdRg8kHspDWV7TVz2KFwZRmrCIh/lfdw5KDlakoEPspW/Skrkf5WgPSzzJB7kOOXwT9ksXiapyKk6+c6BQRrEKTj7cWfKOMFEBdstDIBs2Awprmj0Pu7TCqoyfUQOeRF0abIm+cImRTldjXtX01WHRz4dfq7nvf3o3bEXy4AYAQQTGqR2/fEhx334whPN5EkYt4cSShp66W856PsD3+ctYbyKNccWXtcqLXPlNRamTmeMtxLanMdYvBoICYOQsjNJ2kxokvlQI+3nbLrCSOhlahjT5YWr22gSzX8eNNSxiKrTUags
x-ms-exchange-antispam-messagedata: 0UYNar3yzoWgSrSgJdKeGxobN/5JOLBaiR6RwipmgkfpFShJRWjpc3sr2oEDjOAkoO3tifKjwsCTEEQfl4I03TAPpw3lA+K/XCdgOd7eJTlxQXv/eTmB2ZlJ58QjIN9y80mkTOn6zgpuszmHw37Wxod3Q0BUk4TEw4oqZ3eSSZejEiePXQPWufETdvZvCgJJD0bdQT6cqXKAlHfmosHRwKw1u8/xt3QGIKXqRQQlc0lhiMW6+KiqvAkGTd1+aUR1Crnw8+sGskCF7f1RwcEr9jRufexLWTpYknfDPvtQfdREKlwyVobNVtEtC/9qg2m+yuWH+dGSraoaDrozLsr7W1vFlIebC/cflBuaenj5RPVti0AiCVFwnIpeLTtTvSFKBD6Z2AZY8xelM2jdnPcW0YpSQqeCNV5iUFJ02MRleIq7/78ZuX4EMe2n0JTzqrTFbA5b145VDxEm5433BWBNyQ2TvwtNSci9VB8EtmfsuUkHsQL1g3FETzh/1hRwor+hKLTuotcwOQf/HCxU4zylf8iJXbaxLjRWs70FUO/paI/X4oqE5FZocB6EFrvoOIQAm6/JMze3HwWh3ULOFLgHSVen0BVGFLrabP4vmw/s0qKX4BVwWavR1dwG1HqmfYrsD93gIHViqVCVw6zKQAUMHBBfKfDxOQT3xiSTAyFVYw4niAHhjE+Hk/MC/j1tvfX/5vEM/P2dlWwJTW4cBhehe0q771ByWhmaDFWJORnv2deCfflssXtEFXskQDHDW5nBd/Oa4vUAbgBZVeT41G7VuqtvfbrIHL8p+fE0tgEkPiQdxJMRW4yFk92iJoocismD98eYlpNRASoAMeoi1wov7LynFbOcsU68d+qOPVNis6bLO3bCTbsWWXwXeO+bZST24rK6RXXRLQKPu7XwGTeWUg==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2983.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e782318a-a58a-40ad-f928-08d887c43b8e
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2020 11:06:55.4191
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2GR7IOS6hvupSN7WConFFbKhkItK2jFCoirNJPiu3wkqnvMKYFeIlntrdTxWoyOGyYcPQyrqiOHj0RRrkJ5D/1qUj/LEhS0e6ywdTsBuoOGAkDK4FZcpaWdMcm4ogS5J
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB5298
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: bUpziqgaHTHDQnHlkwALxanxx4520388AA=
Content-Type: multipart/mixed; boundary="ayDmOCzfCp8VHWBY56jB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1605265629;
 bh=YmPoXBEnl4AuWoeW5LOfO/xhRvI4vGmpHs5T8+ffpdk=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=IlKRijsalgVNo2evKVooJyCjcSCVnshYcekwXmJbyRcWaJYu8UHt+mMs3lk42c2N6so
 JRlQ1YTmd324ZcF1xjwveuyCJVvY6Pc9L3WmbGReSO6Qt9qHYoaBtQDxSBL4vq49/dHx1
 0pi19QqTCqvKzlfdAUAiNZkkdxofA/BPP9E=

--ayDmOCzfCp8VHWBY56jB
Content-Language: ja-JP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGkgYWxsLA0KDQpTb3JyeSwgSSBub3RpY2VkIHRoYXQgdGhlIGNvbW1pdHMgaW4gdGhpcyBwYXRj
aCBzZXJpZXMgZGlkIG5vdCBoYXZlIHRoZSBzaWduZWQtb2ZmLWJ5IHRhZyBieSBDSVAga2VybmVs
IG1haW50YWluZXJzLg0KSSBmb3JjZS1wdXNoZWQgd2l0aCBzaWduZWQtb2ZmLWJ5IHRhZy4gUGxl
YXNlIG5vdGUgdGhhdCB0aGUgY29tbWl0LWhhc2ggb2YgZ2l0IHRyZWUgd2lsbCBjaGFuZ2UgYW5k
IHlvdQ0Kd2lsbCBub3QgYmUgYWJsZSB0byB1cGRhdGUgaXQgd2l0aCAnZ2l0IHB1bGwnLiBQbGVh
c2UgdXNlICdnaXQgcmVtb3RlIHVwZGF0ZScgb3Igb3RoZXIgZ2l0IGNvbW1hbmQgaW5zdGVhZCBv
Zi4NCg0KQmVzdCByZWdhcmRzLA0KICBOb2J1aGlybw0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2Fn
ZS0tLS0tDQo+IEZyb206IGNpcC1kZXZAbGlzdHMuY2lwLXByb2plY3Qub3JnIFttYWlsdG86Y2lw
LWRldkBsaXN0cy5jaXAtcHJvamVjdC5vcmddIE9uIEJlaGFsZiBPZiBMYWQgUHJhYmhha2FyDQo+
IFNlbnQ6IFdlZG5lc2RheSwgTm92ZW1iZXIgNCwgMjAyMCA4OjA0IFBNDQo+IFRvOiBQYXZlbCBN
YWNoZWsgPHBhdmVsQGRlbnguZGU+OyBpd2FtYXRzdSBub2J1aGlybyjlsqnmnb4g5L+h5rSLIOKW
oe+8s++8t++8o+KXr++8oe+8o++8tCkgPG5vYnVoaXJvMS5pd2FtYXRzdUB0b3NoaWJhLmNvLmpw
Pg0KPiBDYzogY2lwLWRldkBsaXN0cy5jaXAtcHJvamVjdC5vcmc7IEJpanUgRGFzIDxiaWp1LmRh
cy5qekBicC5yZW5lc2FzLmNvbT4NCj4gU3ViamVjdDogUmU6IFtjaXAtZGV2XSBbUEFUQ0ggNC4x
OS55LWNpcCAwMC8xN10gUmVuZXNhcyBSWi9HMkggYWRkIEZDUHtGVn0sIFZTUCwgRkRQMSwgRFUs
IEhETUksIExWRFMsIFBXTSBhbmQgc291bmQNCj4gc3VwcG9ydA0KPiANCj4gSGkgUGF2ZWwsIE5v
YnVoaXJvLA0KPiANCj4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+IEZyb206IFBh
dmVsIE1hY2hlayA8cGF2ZWxAZGVueC5kZT4NCj4gPiBTZW50OiAwNCBOb3ZlbWJlciAyMDIwIDA4
OjI5DQo+ID4gVG86IG5vYnVoaXJvMS5pd2FtYXRzdUB0b3NoaWJhLmNvLmpwDQo+ID4gQ2M6IFBy
YWJoYWthciBNYWhhZGV2IExhZCA8cHJhYmhha2FyLm1haGFkZXYtbGFkLnJqQGJwLnJlbmVzYXMu
Y29tPjsgY2lwLWRldkBsaXN0cy5jaXAtcHJvamVjdC5vcmc7IHBhdmVsQGRlbnguZGU7DQo+IEJp
anUgRGFzDQo+ID4gPGJpanUuZGFzLmp6QGJwLnJlbmVzYXMuY29tPg0KPiA+IFN1YmplY3Q6IFJl
OiBbUEFUQ0ggNC4xOS55LWNpcCAwMC8xN10gUmVuZXNhcyBSWi9HMkggYWRkIEZDUHtGVn0sIFZT
UCwgRkRQMSwgRFUsIEhETUksIExWRFMsIFBXTSBhbmQgc291bmQgc3VwcG9ydA0KPiA+DQo+ID4g
SGkhDQo+ID4NCj4gPiA+ID4gVGhpcyBwYXRjaCBzZXJpZXMgYWRkcyBzdXBwb3J0IGZvciBmb2xs
b3dpbmcgcGVyaXBoZXJhbCB0byBSZW5lc2FzDQo+ID4gPiA+IFJaL0cySCwNCj4gPiA+ID4gKiBG
Q1BGLCBGQ1BWDQo+ID4gPiA+ICogRkRQMQ0KPiA+ID4gPiAqIFBXTQ0KPiA+ID4gPiAqIERVLCBI
RE1JLCBMVkRTDQo+ID4gPiA+ICogU291bmQNCj4gPiA+ID4NCj4gPiA+ID4gQWxsIHRoZSBwYXRj
aGVzIGhhdmUgYmVlbiBjaGVycnkgcGlja2VkIGZyb20gTGludXgga2VybmVsDQo+ID4gPiA+IHY1
LjEwLXJjMi4NCj4gPg0KPiA+ID4gPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGFyY2gvYXJtNjQvYm9v
dC9kdHMvcmVuZXNhcy9yOGE3NzRlMS1oaWhvcGUtcnpnMmgtZXgtaWRrLTExMTB3ci5kdHMNCj4g
PiA+ID4NCj4gPiA+DQo+ID4gPiBJIHJldmlld2VkIHRoaXMgcGF0Y2ggc2VyaWVzLiBJIGNvbW1l
bnRlZCB0byAxNy8xNy4NCj4gPiA+IEkgZG9uJ3QgdGhpbmsgdGhpcyBpc3N1ZSB3aWxsIGFmZmVj
dCBvdXIgcmVmZXJlbmNlIGJvYXJkLCBidXQgaXQgc2hvdWxkIGJlIGZpeGVkLg0KPiA+ID4NCj4g
PiA+IEFuZCBsb29rcyBnb29kIHRvIG1lIHdpdGhvdXQgMTcvMTcuDQo+ID4NCj4gPiBJIGRvbid0
IHNlZSBhbnkgcHJvYmxlbXMgd2l0aCBwYXRjaGVzIHVwLXRvIDE2LCBhbmQgb3VyIHRlc3RpbmcN
Cj4gPiBwYXNzZXMsIHNvIEkgYXBwbGllZCB0aGF0Lg0KPiA+DQo+IFRoYW5rIHlvdS4NCj4gDQo+
IENoZWVycywNCj4gUHJhYmhha2FyDQo=

--ayDmOCzfCp8VHWBY56jB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5799): https://lists.cip-project.org/g/cip-dev/message=
/5799
Mute This Topic: https://lists.cip-project.org/mt/78011684/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--ayDmOCzfCp8VHWBY56jB--
