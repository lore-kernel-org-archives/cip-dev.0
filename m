Return-Path: <SRS0=/rwL=JJ=lists.cip-project.org=bounce+64572+6357+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C032C433B4
	for <cip-dev@archiver.kernel.org>; Mon, 12 Apr 2021 07:19:52 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0CC161206
	for <cip-dev@archiver.kernel.org>; Mon, 12 Apr 2021 07:19:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0CC161206
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6357+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id aWAhYY4521723xbSriJ0HxKa; Mon, 12 Apr 2021 00:19:51 -0700
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.web08.15244.1618211988842267585
 for <cip-dev@lists.cip-project.org>;
 Mon, 12 Apr 2021 00:19:50 -0700
X-Received: by mo-csw.securemx.jp (mx-mo-csw1116) id 13C7Ja0V020845; Mon, 12 Apr 2021 16:19:36 +0900
X-Iguazu-Qid: 2wHHmufQV2wTUsIJUX
X-Iguazu-QSIG: v=2; s=0; t=1618211976; q=2wHHmufQV2wTUsIJUX; m=3MMt1k461uLnyQfsMz/5ao+UhF4JUfnapW6sReR/25M=
X-Received: from imx12-a.toshiba.co.jp (imx12-a.toshiba.co.jp [61.202.160.135])
	by relay.securemx.jp (mx-mr1111) id 13C7JZ65005214
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 12 Apr 2021 16:19:35 +0900
X-Received: from enc02.toshiba.co.jp (enc02.toshiba.co.jp [61.202.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by imx12-a.toshiba.co.jp (Postfix) with ESMTPS id D53571000C2;
	Mon, 12 Apr 2021 16:19:34 +0900 (JST)
X-Received: from hop101.toshiba.co.jp ([133.199.85.107])
	by enc02.toshiba.co.jp  with ESMTP id 13C7JYl8003122;
	Mon, 12 Apr 2021 16:19:34 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XqdkZBRPik51rbcEOT8nBe+yEwdbbrp2seCrDCfAf5VAuXX6FSUe8U+RgIm/l/JjCNc2T5ABViTwg6tUcM3xV8MCObU/FMhfAuogaQ9ZG7Si1Pr40mbemWo6PtQe6R1TKmz5gjc+FEOd50kOlJbkK4tF00KlAwtPpqkKjQS+BAX+2dDjk2xvVnr3V8BpYZHrlb4TCoLXN+efE/xNAta3Hpd22AGWU+afudqVieT9pxVAmpX14aalRgA1mAr/XbRRCA51dfyWi3piTZu0G5B9fp9D9MlPV5CCjQ1N5AXa2jSpIh9mmrGg5JrEeQuvb945a9ORQwRM09Vn2TeGcx7bTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2wzqkN3wUPRlZeonQKjt0hXLP4eDKNm2Ybps1HGBjqg=;
 b=Iafw6N0HCBewubl4UzYo5yzvHe4eN6Cchvy50r4u44KU6yYzlDU1924u8iIX43ukqxI91O238gMSPgYUsxel3k3LgFn2RjvlG1yxTsq1EQB2mZzuGWhXYr7tnZwavTfXdNJusyGoa/zZ9+QReYXBONU1CRr50OyKebqMJFWTC+DK1lzjExbF4WKl6pC1ZI9T5ySQPD4g7tEt+WzQRnp3U5ywvR6gpOFFLGvWKRklueHwkWSYeZ56akywGeOBFWi+1fK3cKW3TwdN/z1J2Jhlx9ksJ4gzXGjGyza8esbnFe0Yrx2MHQUzGz9dKzf7ymsYc8maBSMRvHuoyJTMav/HtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: "Nobuhiro Iwamatsu" <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <biju.das.jz@bp.renesas.com>, <cip-dev@lists.cip-project.org>,
        <pavel@denx.de>
CC: <chris.paterson2@renesas.com>, <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 4.19.y-cip] drm: rcar-du: Fix crash when using LVDS1 clock for CRTC
Thread-Topic: [PATCH 4.19.y-cip] drm: rcar-du: Fix crash when using LVDS1
 clock for CRTC
Thread-Index: AQHXLVt3gZqx1zlk+ki6BLkNm2PktKqweeuA
Date: Mon, 12 Apr 2021 07:19:19 +0000
X-TSB-HOP: ON
Message-ID: <OSBPR01MB2983AFFCF8CE63A21F53B8F092709@OSBPR01MB2983.jpnprd01.prod.outlook.com>
References: <20210409161436.10953-1-biju.das.jz@bp.renesas.com>
In-Reply-To: <20210409161436.10953-1-biju.das.jz@bp.renesas.com>
Accept-Language: ja-JP, en-US
x-originating-ip: [103.91.184.3]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 31bafd3b-2581-4f95-2ab6-08d8fd834a38
x-ms-traffictypediagnostic: OSAPR01MB4994:
x-microsoft-antispam-prvs: <OSAPR01MB49945598E89587BA85FBE9A692709@OSAPR01MB4994.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:407;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: qvyJQRB7pvbA2wq1eIbFu442Pd1GkaR87YTPX1b4q/ssVAuFjSypuDimTxVBEAO6+QTjUtdIIeJ3zso7E/nrF2a+LBfE/smh9GakkTFvAuzmlt4EMW3dI33/03kccz/StHT+HQCGA846YcqHIO9YaM7y8NuAyy6WKQH1gwXHsfbsNmkoi5bkh/SuXx1n/NHTf1PMZCSaxjs8KX//Q0NvXo9e4eYshbSnx60Ly+3EcbswHA4PjVb6boRXSLHhdZ9VKk10HWkvpTj7NH8I56AEdxCYfDNb5yW3PuqJprTCzYLebU58n9nocmJJXyvRtfrBSSGsw4y/iVAApd7unBng+F3qF+c56TPoxD6xUsdwTxsK8ys0OlrLmD1Xkypq7slW4rsL7zuXBABXGOAMStxxP90GBVlpRNEVCVm9KjfUh+MhO9AbdmkABnPMZhuHFs1+73y9CNAhvPUzY2J95l9xQ01Q8vCZ7vDse7MaJ8GqFDeAnmeTNCiL947q3hc2cS1AbUptr7E6ZGEVBIB8sochjerCzZTFPLFO0ybmpsHNRbXcyhxakSgNT2LEjzE715dRcPHZe6sMTY4dPx8HDxAJu6aVyIfCXAlcEEJpSWqRpOE=
x-ms-exchange-antispam-messagedata: =?utf-8?B?MkRoZWlGcUFQMFd3Yk9kQ1IvUUdnMk41TlZhS3czdGgwQmgyaTdGeHRMcDRs?=
 =?utf-8?B?TEZNOHJOZFpRVjhVbU9SZUZMd1NGaVFRUzZ6dE1YRFhzR1UxbFVFOHZsY1Vx?=
 =?utf-8?B?ek85RGNOQTBzemt3WW5FNksvTkpGOWswL0JQZitrUFl2ZzNGRjAyNlEvM1NP?=
 =?utf-8?B?Y0x0K0NmbVppc1AxTEN5ekZLTGtSZis0cm9qR3JmamFER3JDbHdxWmR5cFl2?=
 =?utf-8?B?OW5YMmd0STRZWlkzQ0gyMkozbktJWGtqdThMNU43K1BpcEJod2ppV0pQMGRh?=
 =?utf-8?B?anBsK2t6YitUTEp3NFBsS2xvVEdHR2xlN1hNR1NKaG9JWDkvNCsxZTBwZUpi?=
 =?utf-8?B?NjVVMEhQTVFjdDYxWlVEQkkvUFYyWHZFVVF4TGc2Z0NrNUJ3V0pFOEc0eFZz?=
 =?utf-8?B?MFBDQ0l0c3BZbDVhelRlYVBCdTk5UFllVW1qbCt1SkhicEYzQk9wdzF5MTI1?=
 =?utf-8?B?bjNKSHo5MURtRjM3RmJaNWZoUmtkUFZWVlE3NURpNldWRkhWWUtjWmJwV1Bl?=
 =?utf-8?B?eTdxUmpPWGE5eW5ScTdSVWxGL0R2ZlM1RDdOY0ZQYUVVV0J3bGtwZmpjbHQw?=
 =?utf-8?B?VmJ1b29tZElBdmFRVlk5bnZmcDMxalB1eDdiUWpVV2pIbW51NHhTNnFKblB6?=
 =?utf-8?B?RjAvczVCTDVDNjc4WEpkL054Umpadktnd2cycW14R1MxckZGaTNxdFF2M1k2?=
 =?utf-8?B?MWJtS1JCanVUOC9EVnIvdU10M3F2ZWtaakViUzh3dGxYMitVbk80ZG9USFJw?=
 =?utf-8?B?N3NFeUZhSDVkbFZmUnI2RXRPb05SdUM5UjNiWWVPVnNIZWFqZ0JlNTU4anFl?=
 =?utf-8?B?TkRlbWFBaUhTVHdpV3RBMmI1UENIczB0dmtWM1Z1WnpjWWNhR3hrQmNSNDRu?=
 =?utf-8?B?T0lLa00vL1hSZ0h4aTJ4R0M4VnFyZXFUbis0QTZPZFh3M3o1Q2p4OEorOUtX?=
 =?utf-8?B?TGhyTkpWNkRxaG8zYjZqdlg5UjV2MlZSZnliaVFLR2pUSUk2SG9qdy93c1dz?=
 =?utf-8?B?WXRrSmZCZmRqUVNHZEM2ZzE0UVdkRzNFWXM3WmVKajMyTjVRdThOOXdvc2pm?=
 =?utf-8?B?b0thSUtRN3k4b2FDYmd6TDZyTVpnaEl0VEViRTIremJJTEx2MWY4dmk4QW1Y?=
 =?utf-8?B?SHk1R1dSaHpSVm5kWHdEVDdhZGhQdGxEcTQybkxzRjR2RjlvZEJtUS9iMWxR?=
 =?utf-8?B?NWJWWXZ5eUsvNlZyQ3UwRE5QNHA0UHp1bzNQU0M2Wk5Dc3ZUVHQxUTkyaEJx?=
 =?utf-8?B?U0kxUTB4VEw4VEhCWENuSXVCYXVkMWdzVG8rbmZEdU92SnpKcy8wVDd0OEVs?=
 =?utf-8?B?UzhJTFlIRFYwT3VsNm1rUXVoY0V5OTQwVlNDenc0UWkrVTJFTnd3UmxsUmNS?=
 =?utf-8?B?V1Y0Qm5Ja0s0UlRWTkMrSnNMczBzc1J4MVNrcHhTZnplSy95eStXWE5SbWJU?=
 =?utf-8?B?ZWw1WWs0dmtaMXluaTBveXk5T3NJZnVRSjZza2NvbUNyN1lKWXBmaGFRdnd3?=
 =?utf-8?B?QUFURTR2SUNEWndIbkxPUjY0TkFrczNsbldnRUF6WVRrQnhDL0VsVHdvK3hE?=
 =?utf-8?B?Q0JJSXB5cHNLS05MbUh4anF3b0N6RHRYL3Uzdk5Za2cwdkxRbFBmc3FQU2ZV?=
 =?utf-8?B?Slp5TTF6VG9Eb1k1ekRaY2RqMXJXM1NlSEFNb1ViUUw3TnNpQTJEYkhSRkl4?=
 =?utf-8?B?RE1FQkpEZytaTTFBZkNBd1FPV0JteldxQk5hSmYwcmVqSUJuMlZWeEFnVERo?=
 =?utf-8?Q?Hv3hgFn0ozeQ7KFItA=3D?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2983.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31bafd3b-2581-4f95-2ab6-08d8fd834a38
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2021 07:19:19.9683
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3n/Vd8dO2VOkgfWiQ68F6TAj8NF7aR1sSYlRWeZBk26PX8h4oAjzMq4Ef15cpdVVIQJgtNE9K9eOSHdis4vEMryZzbdUS/ewv7j/KRxDhlvMCYrWpEdel2JlSnWuaeDS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB4994
MSSCP.TransferMailToMossAgent: 103
X-OriginatorOrg: toshiba.co.jp
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: cwaHFV8rbYPCLUM7892BDd4Jx4520388AA=
Content-Type: multipart/mixed; boundary="lvXqB60y15bmf2PXZfBf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1618211991;
 bh=ETpQ5rrXbaSeg+3CQgmAVHhb2pyb3boT1jUk1zuwrqg=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=QAw7rWHCxJPA3DsDGhdPEOnhS5/2DHwc6y1zbBUe3+LGRgqRESlPXZl6+BVI6dXBK7U
 zUWsvmtjYITdKBy1mjC4PPxeMvAiWkrGxWST0NU0YxuF/QLQBz6S9BMdQ1++uc0Gb90FA
 qQFkDflW8P6ySb7zhx72X+lSVaAC0OEwThc=

--lvXqB60y15bmf2PXZfBf
Content-Language: ja-JP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGksDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQmlqdSBEYXMgW21h
aWx0bzpiaWp1LmRhcy5qekBicC5yZW5lc2FzLmNvbV0NCj4gU2VudDogU2F0dXJkYXksIEFwcmls
IDEwLCAyMDIxIDE6MTUgQU0NCj4gVG86IGNpcC1kZXZAbGlzdHMuY2lwLXByb2plY3Qub3JnOyBp
d2FtYXRzdSBub2J1aGlybyjlsqnmnb4g5L+h5rSLIOKWoe+8s++8t++8o+KXr++8oe+8o++8tCkN
Cj4gPG5vYnVoaXJvMS5pd2FtYXRzdUB0b3NoaWJhLmNvLmpwPjsgUGF2ZWwgTWFjaGVrIDxwYXZl
bEBkZW54LmRlPg0KPiBDYzogQ2hyaXMgUGF0ZXJzb24gPGNocmlzLnBhdGVyc29uMkByZW5lc2Fz
LmNvbT47IEJpanUgRGFzIDxiaWp1LmRhcy5qekBicC5yZW5lc2FzLmNvbT47IFByYWJoYWthciBN
YWhhZGV2IExhZA0KPiA8cHJhYmhha2FyLm1haGFkZXYtbGFkLnJqQGJwLnJlbmVzYXMuY29tPg0K
PiBTdWJqZWN0OiBbUEFUQ0ggNC4xOS55LWNpcF0gZHJtOiByY2FyLWR1OiBGaXggY3Jhc2ggd2hl
biB1c2luZyBMVkRTMSBjbG9jayBmb3IgQ1JUQw0KPiANCj4gRnJvbTogTGF1cmVudCBQaW5jaGFy
dCA8bGF1cmVudC5waW5jaGFydCtyZW5lc2FzQGlkZWFzb25ib2FyZC5jb20+DQo+IA0KPiBbIFVw
c3RyZWFtIGNvbW1pdCA1M2NlZDE2OTM3M2FhYjUyZDNiNWRhMGZlZTZhMzQyMDAyZDE4NzZkIF0N
Cj4gDQo+IE9uIEQzIGFuZCBFMyBwbGF0Zm9ybXMsIHRoZSBMVkRTIGVuY29kZXIgaW5jbHVkZXMg
YSBQTEwgdGhhdCBjYW4NCj4gZ2VuZXJhdGUgYSBjbG9jayBmb3IgdGhlIGNvcnJlc3BvbmRpbmcg
Q1JUQywgdXNlZCBldmVuIHdoZW4gdGhlIENSVEMNCj4gb3V0cHV0IHRvIGEgbm9uLUxWRFMgcG9y
dC4gVGhpcyBtZWNoYW5pc20gaXMgc3VwcG9ydGVkIGJ5IHRoZSBkcml2ZXIsDQo+IGJ1dCB0aGUg
aW1wbGVtZW50YXRpb24gaXMgYnJva2VuIGluIGR1YWwtbGluayBMVkRTIG1vZGUuIEluIHRoYXQg
Y2FzZSwNCj4gdGhlIExWRFMxIGRybV9lbmNvZGVyIGlzIHNraXBwZWQsIHdoaWNoIGNhdXNlcyBh
IGNyYXNoIHdoZW4gdHJ5aW5nIHRvDQo+IGFjY2VzcyBpdHMgYnJpZGdlIGxhdGVyIG9uLg0KPiAN
Cj4gRml4IHRoaXMgYnkgc3RvcmluZyBicmlkZ2UgcG9pbnRlcnMgaW50ZXJuYWxseSBpbnN0ZWFk
IG9mIHJldHJpZXZpbmcNCj4gdGhlbSBmcm9tIHRoZSBlbmNvZGVyLiBUaGUgcmNhcl9kdV9kZXZp
Y2UgZW5jb2RlcnMgZmllbGQgaXNuJ3QgdXNlZA0KPiBhbnltb3JlIGFuZCBjYW4gYmUgZHJvcHBl
ZC4NCj4gDQo+IEZpeGVzOiA4ZThmZGRhYjBkMGEgKCJkcm06IHJjYXItZHU6IFNraXAgTFZEUzEg
b3V0cHV0IG9uIEdlbjMgd2hlbiB1c2luZyBkdWFsLWxpbmsgTFZEUyBtb2RlIikNCj4gU2lnbmVk
LW9mZi1ieTogTGF1cmVudCBQaW5jaGFydCA8bGF1cmVudC5waW5jaGFydCtyZW5lc2FzQGlkZWFz
b25ib2FyZC5jb20+DQo+IFJldmlld2VkLWJ5OiBKYWNvcG8gTW9uZGkgPGphY29wbytyZW5lc2Fz
QGptb25kaS5vcmc+DQo+IFJldmlld2VkLWJ5OiBLaWVyYW4gQmluZ2hhbSA8a2llcmFuLmJpbmdo
YW0rcmVuZXNhc0BpZGVhc29uYm9hcmQuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBTYXNoYSBMZXZp
biA8c2FzaGFsQGtlcm5lbC5vcmc+DQoNCkNvbW1pdDogNTNjZWQxNjkzNzNhYWI1MmQzYjVkYTBm
ZWU2YTM0MjAwMmQxODc2ZCBkb2VzIG5vdCBoYXZlIFNhc2hhJ3Mgc2luZ2VkLW9mZi4NCiMgQmFj
a3BvcnRlZCBmcm9tIDUuMTEgb3IgNS4xMD8NCklmIHlvdSBiYWNrcG9ydGVkIGZyb20gNTNjZWQx
NjkzLCBJIGRvbid0IHRoaW5rIHRoaXMgaXMgbmVjZXNzYXJ5Lg0KDQo+IFtCaWp1OiBNYW51YWxs
eSBhcHBsaWVkIHRoZSBjaGFuZ2VzIHRvIGFkYXB0IHdpdGggNC4xOSBrZXJuZWxdDQo+IFNpZ25l
ZC1vZmYtYnk6IEJpanUgRGFzIDxiaWp1LmRhc0BicC5yZW5lc2FzLmNvbT4NCg0KSXQgbWF5IGJl
IGEgcHJvYmxlbSBpbiBteSBlbnZpcm9ubWVudCwgSSBjYW4gbm90IGFwcGx5IHRoaXMgcGF0Y2gg
dG8gbGludXgtNC4xOS55LWNpcCB0cmVlLg0KQW5kIEkgY2FuIG5vdCBmaW5kIHRoaXMgbWFpbCBm
cm9tIGNpcC1kZXYgTUwgYW5kIHBhdGNod29yay4NCg0KQmVzdCByZWdhcmRzLA0KICBOb2J1aGly
bw0KDQo+IC0tLQ0KPiAgZHJpdmVycy9ncHUvZHJtL3JjYXItZHUvcmNhcl9kdV9jcnRjLmMgICAg
fCAxMSArKysrLS0tLS0tLQ0KPiAgZHJpdmVycy9ncHUvZHJtL3JjYXItZHUvcmNhcl9kdV9kcnYu
aCAgICAgfCAgNiArKystLS0NCj4gIGRyaXZlcnMvZ3B1L2RybS9yY2FyLWR1L3JjYXJfZHVfZW5j
b2Rlci5jIHwgIDUgKysrKy0NCj4gIDMgZmlsZXMgY2hhbmdlZCwgMTEgaW5zZXJ0aW9ucygrKSwg
MTEgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL3JjYXIt
ZHUvcmNhcl9kdV9jcnRjLmMgYi9kcml2ZXJzL2dwdS9kcm0vcmNhci1kdS9yY2FyX2R1X2NydGMu
Yw0KPiBpbmRleCBjZWM0YjVjMjFlZWEuLjMzNjJjY2NlZDA1YSAxMDA2NDQNCj4gLS0tIGEvZHJp
dmVycy9ncHUvZHJtL3JjYXItZHUvcmNhcl9kdV9jcnRjLmMNCj4gKysrIGIvZHJpdmVycy9ncHUv
ZHJtL3JjYXItZHUvcmNhcl9kdV9jcnRjLmMNCj4gQEAgLTY3NiwxMyArNjc2LDExIEBAIHN0YXRp
YyB2b2lkIHJjYXJfZHVfY3J0Y19hdG9taWNfZW5hYmxlKHN0cnVjdCBkcm1fY3J0YyAqY3J0YywN
Cj4gIAkgKi8NCj4gIAlpZiAocmNkdS0+aW5mby0+bHZkc19jbGtfbWFzayAmIEJJVChyY3J0Yy0+
aW5kZXgpICYmDQo+ICAJICAgIHJzdGF0ZS0+b3V0cHV0cyA9PSBCSVQoUkNBUl9EVV9PVVRQVVRf
RFBBRDApKSB7DQo+IC0JCXN0cnVjdCByY2FyX2R1X2VuY29kZXIgKmVuY29kZXIgPQ0KPiAtCQkJ
cmNkdS0+ZW5jb2RlcnNbUkNBUl9EVV9PVVRQVVRfTFZEUzAgKyByY3J0Yy0+aW5kZXhdOw0KPiAr
CQlzdHJ1Y3QgZHJtX2JyaWRnZSAqYnJpZGdlID0gcmNkdS0+bHZkc1tyY3J0Yy0+aW5kZXhdOw0K
PiAgCQljb25zdCBzdHJ1Y3QgZHJtX2Rpc3BsYXlfbW9kZSAqbW9kZSA9DQo+ICAJCQkmY3J0Yy0+
c3RhdGUtPmFkanVzdGVkX21vZGU7DQo+IA0KPiAtCQlyY2FyX2x2ZHNfY2xrX2VuYWJsZShlbmNv
ZGVyLT5iYXNlLmJyaWRnZSwNCj4gLQkJCQkgICAgIG1vZGUtPmNsb2NrICogMTAwMCk7DQo+ICsJ
CXJjYXJfbHZkc19jbGtfZW5hYmxlKGJyaWRnZSwgbW9kZS0+Y2xvY2sgKiAxMDAwKTsNCj4gIAl9
DQo+IA0KPiAgCXJjYXJfZHVfY3J0Y19zdGFydChyY3J0Yyk7DQo+IEBAIC03MDAsMTQgKzY5OCwx
MyBAQCBzdGF0aWMgdm9pZCByY2FyX2R1X2NydGNfYXRvbWljX2Rpc2FibGUoc3RydWN0IGRybV9j
cnRjICpjcnRjLA0KPiANCj4gIAlpZiAocmNkdS0+aW5mby0+bHZkc19jbGtfbWFzayAmIEJJVChy
Y3J0Yy0+aW5kZXgpICYmDQo+ICAJICAgIHJzdGF0ZS0+b3V0cHV0cyA9PSBCSVQoUkNBUl9EVV9P
VVRQVVRfRFBBRDApKSB7DQo+IC0JCXN0cnVjdCByY2FyX2R1X2VuY29kZXIgKmVuY29kZXIgPQ0K
PiAtCQkJcmNkdS0+ZW5jb2RlcnNbUkNBUl9EVV9PVVRQVVRfTFZEUzAgKyByY3J0Yy0+aW5kZXhd
Ow0KPiArCQlzdHJ1Y3QgZHJtX2JyaWRnZSAqYnJpZGdlID0gcmNkdS0+bHZkc1tyY3J0Yy0+aW5k
ZXhdOw0KPiANCj4gIAkJLyoNCj4gIAkJICogRGlzYWJsZSB0aGUgTFZEUyBjbG9jayBvdXRwdXQs
IHNlZQ0KPiAgCQkgKiByY2FyX2R1X2NydGNfYXRvbWljX2VuYWJsZSgpLg0KPiAgCQkgKi8NCj4g
LQkJcmNhcl9sdmRzX2Nsa19kaXNhYmxlKGVuY29kZXItPmJhc2UuYnJpZGdlKTsNCj4gKwkJcmNh
cl9sdmRzX2Nsa19kaXNhYmxlKGJyaWRnZSk7DQo+ICAJfQ0KPiANCj4gIAlzcGluX2xvY2tfaXJx
KCZjcnRjLT5kZXYtPmV2ZW50X2xvY2spOw0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJt
L3JjYXItZHUvcmNhcl9kdV9kcnYuaCBiL2RyaXZlcnMvZ3B1L2RybS9yY2FyLWR1L3JjYXJfZHVf
ZHJ2LmgNCj4gaW5kZXggZjE2Y2QyNjNkMmMxLi41NThlYmVmY2U0YWMgMTAwNjQ0DQo+IC0tLSBh
L2RyaXZlcnMvZ3B1L2RybS9yY2FyLWR1L3JjYXJfZHVfZHJ2LmgNCj4gKysrIGIvZHJpdmVycy9n
cHUvZHJtL3JjYXItZHUvcmNhcl9kdV9kcnYuaA0KPiBAQCAtMjMsOSArMjMsOSBAQA0KPiANCj4g
IHN0cnVjdCBjbGs7DQo+ICBzdHJ1Y3QgZGV2aWNlOw0KPiArc3RydWN0IGRybV9icmlkZ2U7DQo+
ICBzdHJ1Y3QgZHJtX2RldmljZTsNCj4gIHN0cnVjdCByY2FyX2R1X2RldmljZTsNCj4gLXN0cnVj
dCByY2FyX2R1X2VuY29kZXI7DQo+IA0KPiAgI2RlZmluZSBSQ0FSX0RVX0ZFQVRVUkVfQ1JUQ19J
UlFfQ0xPQ0sJQklUKDApCS8qIFBlci1DUlRDIElSUSBhbmQgY2xvY2sgKi8NCj4gICNkZWZpbmUg
UkNBUl9EVV9GRUFUVVJFX1ZTUDFfU09VUkNFCUJJVCgxKQkvKiBIYXMgaW5wdXRzIGZyb20gVlNQ
MSAqLw0KPiBAQCAtNzMsNiArNzMsNyBAQCBzdHJ1Y3QgcmNhcl9kdV9kZXZpY2VfaW5mbyB7DQo+
ICAjZGVmaW5lIFJDQVJfRFVfTUFYX0NSVENTCQk0DQo+ICAjZGVmaW5lIFJDQVJfRFVfTUFYX0dS
T1VQUwkJRElWX1JPVU5EX1VQKFJDQVJfRFVfTUFYX0NSVENTLCAyKQ0KPiAgI2RlZmluZSBSQ0FS
X0RVX01BWF9WU1BTCQk0DQo+ICsjZGVmaW5lIFJDQVJfRFVfTUFYX0xWRFMJCTINCj4gDQo+ICBz
dHJ1Y3QgcmNhcl9kdV9kZXZpY2Ugew0KPiAgCXN0cnVjdCBkZXZpY2UgKmRldjsNCj4gQEAgLTg3
LDEwICs4OCw5IEBAIHN0cnVjdCByY2FyX2R1X2RldmljZSB7DQo+ICAJc3RydWN0IHJjYXJfZHVf
Y3J0YyBjcnRjc1tSQ0FSX0RVX01BWF9DUlRDU107DQo+ICAJdW5zaWduZWQgaW50IG51bV9jcnRj
czsNCj4gDQo+IC0Jc3RydWN0IHJjYXJfZHVfZW5jb2RlciAqZW5jb2RlcnNbUkNBUl9EVV9PVVRQ
VVRfTUFYXTsNCj4gLQ0KPiAgCXN0cnVjdCByY2FyX2R1X2dyb3VwIGdyb3Vwc1tSQ0FSX0RVX01B
WF9HUk9VUFNdOw0KPiAgCXN0cnVjdCByY2FyX2R1X3ZzcCB2c3BzW1JDQVJfRFVfTUFYX1ZTUFNd
Ow0KPiArCXN0cnVjdCBkcm1fYnJpZGdlICpsdmRzW1JDQVJfRFVfTUFYX0xWRFNdOw0KPiANCj4g
IAlzdHJ1Y3Qgew0KPiAgCQlzdHJ1Y3QgZHJtX3Byb3BlcnR5ICpjb2xvcmtleTsNCj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9yY2FyLWR1L3JjYXJfZHVfZW5jb2Rlci5jIGIvZHJpdmVy
cy9ncHUvZHJtL3JjYXItZHUvcmNhcl9kdV9lbmNvZGVyLmMNCj4gaW5kZXggZGU4ZmU3NGMwMzYy
Li4zMjVlMzAxZjk3ZTMgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9yY2FyLWR1L3Jj
YXJfZHVfZW5jb2Rlci5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9yY2FyLWR1L3JjYXJfZHVf
ZW5jb2Rlci5jDQo+IEBAIC00Nyw3ICs0Nyw2IEBAIGludCByY2FyX2R1X2VuY29kZXJfaW5pdChz
dHJ1Y3QgcmNhcl9kdV9kZXZpY2UgKnJjZHUsDQo+ICAJaWYgKHJlbmMgPT0gTlVMTCkNCj4gIAkJ
cmV0dXJuIC1FTk9NRU07DQo+IA0KPiAtCXJjZHUtPmVuY29kZXJzW291dHB1dF0gPSByZW5jOw0K
PiAgCXJlbmMtPm91dHB1dCA9IG91dHB1dDsNCj4gIAllbmNvZGVyID0gcmNhcl9lbmNvZGVyX3Rv
X2RybV9lbmNvZGVyKHJlbmMpOw0KPiANCj4gQEAgLTYxLDYgKzYwLDEwIEBAIGludCByY2FyX2R1
X2VuY29kZXJfaW5pdChzdHJ1Y3QgcmNhcl9kdV9kZXZpY2UgKnJjZHUsDQo+ICAJCWdvdG8gZG9u
ZTsNCj4gIAl9DQo+IA0KPiArCWlmIChvdXRwdXQgPT0gUkNBUl9EVV9PVVRQVVRfTFZEUzAgfHwN
Cj4gKwkgICAgb3V0cHV0ID09IFJDQVJfRFVfT1VUUFVUX0xWRFMxKQ0KPiArCQlyY2R1LT5sdmRz
W291dHB1dCAtIFJDQVJfRFVfT1VUUFVUX0xWRFMwXSA9IGJyaWRnZTsNCj4gKw0KPiAgCS8qDQo+
ICAJICogT24gR2VuMyBza2lwIHRoZSBMVkRTMSBvdXRwdXQgaWYgdGhlIExWRFMxIGVuY29kZXIg
aXMgdXNlZCBhcyBhDQo+ICAJICogY29tcGFuaW9uIGZvciBMVkRTMCBpbiBkdWFsLWxpbmsgbW9k
ZS4NCj4gLS0NCj4gMi4xNy4xDQoNCg==

--lvXqB60y15bmf2PXZfBf
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6357): https://lists.cip-project.org/g/cip-dev/message=
/6357
Mute This Topic: https://lists.cip-project.org/mt/82032629/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--lvXqB60y15bmf2PXZfBf--
