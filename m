Return-Path: <SRS0=TCxV=KJ=lists.cip-project.org=bounce+64572+6456+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D056C433B4
	for <cip-dev@archiver.kernel.org>; Fri, 14 May 2021 08:29:33 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52F2161454
	for <cip-dev@archiver.kernel.org>; Fri, 14 May 2021 08:29:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52F2161454
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6456+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 8ZpeYY4521723xbcTR1k6uRe; Fri, 14 May 2021 01:29:31 -0700
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.155])
 by mx.groups.io with SMTP id smtpd.web09.6075.1620980969284280204
 for <cip-dev@lists.cip-project.org>;
 Fri, 14 May 2021 01:29:30 -0700
X-Received: by mo-csw.securemx.jp (mx-mo-csw1516) id 14E8TLP7004624; Fri, 14 May 2021 17:29:21 +0900
X-Iguazu-Qid: 34tMSNRmZJvuQz7aVW
X-Iguazu-QSIG: v=2; s=0; t=1620980960; q=34tMSNRmZJvuQz7aVW; m=l/A1dw5OXYo+leZx3Y7nzwM31yrDaXfd+xyjLvNeAqc=
X-Received: from imx12-a.toshiba.co.jp (imx12-a.toshiba.co.jp [61.202.160.135])
	by relay.securemx.jp (mx-mr1510) id 14E8TJtf038545
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 14 May 2021 17:29:19 +0900
X-Received: from enc02.toshiba.co.jp (enc02.toshiba.co.jp [61.202.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by imx12-a.toshiba.co.jp (Postfix) with ESMTPS id A51651000BB;
	Fri, 14 May 2021 17:29:19 +0900 (JST)
X-Received: from hop101.toshiba.co.jp ([133.199.85.107])
	by enc02.toshiba.co.jp  with ESMTP id 14E8TIoQ001029;
	Fri, 14 May 2021 17:29:19 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RIuaq6LZZB7xazqA5wyHGdkd6pmYUDQ7rLeQUBg9k6Pc4oUsEbR0WHOUIpF621BVjQLCyK/3YWM6VKGXSMl9p2prJ6KPQZfKINRQPWmh8MsvgXXbEDpuBbcem2HvJWB0MF08HHhjisWw32O4tKUVbukVouc4LyL3bt8Oj04MZlnzhxjrkHs7PX+Xm4wTZxm8O6vuBZMhoLdUSFixqJYKqMpU5LD6t7iNKMRy2K7cALlFswMwwteT+NJNgySDV64yPYRNSRESJzsoZ6oOp0QYF2jhJgVtoUP0N0ADxD44juHv5NPpIiQg7uGX2tHL2hTO57ciF4Q4b5nMXwKZcIgeRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bjOtHBtjQVnh7s4Vo1Z6+2+mB0XmINVlR5Hx6R2zlUM=;
 b=dj/VduoXiwTrtYr1Tz0NHp2MFP5EBO5hWPoa0gd9XMt/+7QN8oiaEn/AllnK1vZFVLJKSpYyMi0mxR8KNfG6+OaIXt7Vr+qHB09mx2K6pQgXlTlGSCJhXqay+nh5iNNxiCRhPKr+MwHIDG+8ZJCAJmzRinYr81gyw8sBPBAqNVsX5XtuPMTKaWzvXuvNiZhGRXug4a1XA1WF8fjRJd/Mtv+t1Vhzb08rAtYq3bjDWodE1+l8lzERAlcufTcAJNuS8tCzeUoGeVUL50B6O0F69wrYiwitasCMuoPSry5qbTl/5Kl98KLgPWyDpWj3rtE4KjVRy6sxbIpdlSePlr8s4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: "Nobuhiro Iwamatsu" <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <pavel@denx.de>, <prabhakar.mahadev-lad.rj@bp.renesas.com>
CC: <cip-dev@lists.cip-project.org>, <biju.das.jz@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 4.19.y-cip 0/2] media: i2c: imx219: Trivial Fixes
Thread-Topic: [PATCH 4.19.y-cip 0/2] media: i2c: imx219: Trivial Fixes
Thread-Index: AQHXR1CDV6lqGbY78kCKuPKj+0dLFKrgfnaAgAIbugCAAAzT4A==
Date: Fri, 14 May 2021 08:29:16 +0000
X-TSB-HOP: ON
Message-ID: <TYCPR01MB625553440ADBE43AEF00382D92509@TYCPR01MB6255.jpnprd01.prod.outlook.com>
References: <20210512170127.16390-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <TYAPR01MB6252C74E1E344EC9F27BCB5192519@TYAPR01MB6252.jpnprd01.prod.outlook.com>
 <20210514074027.GA6430@amd>
In-Reply-To: <20210514074027.GA6430@amd>
Accept-Language: ja-JP, en-US
x-originating-ip: [103.91.184.0]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c7016a5c-7028-4c95-5908-08d916b25cda
x-ms-traffictypediagnostic: TYXPR01MB1597:
x-microsoft-antispam-prvs: <TYXPR01MB15977578AAFE1B217404DC5592509@TYXPR01MB1597.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: g0FaCjvyPqx0jYtRJLkPne89/ASHwCqcOXVzj/bGTIC8LO24ayeXQMBOzcSOU8z+D1LvCirPD/SR7qwq9VAr+97Nk/L9a28bSaNMiOrJtKcbRVV/5BN6TbkT6yscBm5GeagXzkOxFWX93gc8FQJH1wR75Rga+ddVw0Th+mcOdZ474lrRRP3ycjyIHf4mPf4NCsR6Cb9mZLTAplsPdZPzPHKc1q8i5kgJlaTafXhDPDAkS3IDQRjPT0OA0CaQyN8qrfp9ffeIAqN8nLePFkHFd3Wj64gk6x5TcGfXuEwh1XPC+MmSepZaZ3a5qT6RKDf4KEkDdsm+vp6ms5G2YpZjCq4kkELssPAh21YeXsxtQm1pyuJjK4aOu7MdEsNGPAxItCZ/8jXptcyuM2A6gHVA56VAQuZAu/w9ibAC0IRTzoZPC/g3ajfwpce3yN0PmIeKax9+ET9XhkHwRQ5QJhmn2D9+9WN/7Vl2pTwEKALt5Y0K9YXKHQsO4FHA0z7gaYx0byGKQFd9UdHDMd7HAt3+8MIjnbe151VUY84aOX3xl+cQMAyjeXdLpwh7WXzaH2r7FKCcoYcornEvkgGzJEs1oQYtMnb7WmTCS/sesn8GzwkmMhESaAHysk9BT49Sl3GRnVCAOi7uV4QRqi0s55h27F/rlunr440zauY2CsiEHr2xGjoNMTcDjXI6dcQy5+FV
x-ms-exchange-antispam-messagedata: =?utf-8?B?UnVrMDV2a05WRCtTYURqcGRDZ0RUZmlqYVZoQWsxRHFMaTN5MXhTbldQcWky?=
 =?utf-8?B?SFl5cWltaFR5Ty9IaVZsYVRzNW9MOUNUc1d4c3plenU4VXBZMzZrc2tFWFQ0?=
 =?utf-8?B?NGU3NnNlYUdVdUtaQUg3MXRuUCtJNG84Qm5KcjFiNk1mUnp3cmRleEdBRnBY?=
 =?utf-8?B?VWNGNzlvYUY5c0dQNGVscHo3WGwrbUpnWlg1WDNtc0Q3UCsxR3JISE9Nakdu?=
 =?utf-8?B?MUhwL2c3WjJURjh3SU1XNmZRTE5XNWtkSS9mUzIvL1lkcU5jTEwrVFJNSWU2?=
 =?utf-8?B?cGo1OUlOMEkyaUQzMVNNdWtHUWhKSzZtNTNFUDJFMXRUMk9RZ0loWFVGRDZR?=
 =?utf-8?B?S2RzRHkwVlViMlZyM1FLV2ZRdjFxQ0NlMTdvbkxNZGRaczhTekFrcEFwc0tG?=
 =?utf-8?B?K0dLbHB5WXY1ZjZnWHAySDBwei90dk1ybTRwREVZc3VkS1M0NHIrOHhJSG5p?=
 =?utf-8?B?YUlJTWt1aGlVTm1id3NXNlVTRHVqVm9KUm5odWFjYndRNUgzVEdqTDBFVkQ1?=
 =?utf-8?B?LzNQa0p3WEJLbWtQM2lWRGg4TDJPdFhmYVgwRE15aXNjZGcxRThwenFHcTUx?=
 =?utf-8?B?ZklBRkpuSHlxTE16ck5WSk4xWnFjTGdwdS95UlhMOUZ0T0taaEZtckZHcC9Z?=
 =?utf-8?B?eEpCU2dGRUpSMkE1S3hock9qeFpMUmk5NUxudDJsZnBpOWVnd1dadFNVc2tq?=
 =?utf-8?B?Qy9JSGFYSkhjUExXQlBhbm5wbTA1M2FDUTA5RDR6SW1ZcmJWVWg1c0JZZjYr?=
 =?utf-8?B?UDFlZlZNUlFqenRLL01jT3dINkY0THAxWXVqbGM4Z0lVYXdXSmlydzhMTDZS?=
 =?utf-8?B?UjhEbWJLd2trRnZCOTAzRWk4OGcyV04vcEh4Yzk5eGVqNjNTRVU3QVptOWZ4?=
 =?utf-8?B?V3dOM1RULzI1RjRycVltejN6M01ickYwZ0VSZ0ZwY1pPYzRYazluQjNCZTdF?=
 =?utf-8?B?T1d0NmR6dWN5Umd0UTZUZUtkTTdrSWZpV3hxSXlRR3ZyZmphRENMWlBLdzAx?=
 =?utf-8?B?VVFwbnpCUVVadk41cFdqWGZ1WDJnN3IyQk9Vd29RdVIrVEk0Yk9IWkk1YVFB?=
 =?utf-8?B?UEtMQit2dkJMSkhYZlJaeCtuVGNHdVdsZjJ2SVU3R1ZqWGYydlJNSVhRWklO?=
 =?utf-8?B?alBRVWhHcXp5TlIydUdBWTBBcXllbWgyWURkODlqRWR6TG5nSGxiSlI4U0hX?=
 =?utf-8?B?U2VYcEZoUnd2dUpjU2RERXhEQWJYWE9oSFJmdFg5Z2FpVmdaWFlaYXJoZ0RQ?=
 =?utf-8?B?V3NLWGYyVlNFWVJuT1JXZEFnUUxpMG5WalVGd3c2cnlxNXNISnJNSXFOc3hS?=
 =?utf-8?B?RGhZNDhTU3A3b0pCNUdZd0xZV00zNEVJZ2hRelpKSlhKZnd1cCtMWHhZb1FC?=
 =?utf-8?B?ekJlaE1XUzQ3ZzNDUzlXZXFDTEFFK09VeUNUSFlmRW0rbjNkYVMwSjZxaWZ0?=
 =?utf-8?B?NDdpWVRWeHNtR0dOQ0NPU2hjcDFVRVo2dnlFc20vZlVDd1VGbkJEaURuMDZZ?=
 =?utf-8?B?Q1IwajRCZEowcXc5RE9DN21VZnc4NzJ4c3N4UGVMdGhzbllNYUJ6bmVrbkIz?=
 =?utf-8?B?ZUIrRTg3SW9LNHNTakNpRzdESlNOOFp1dEloNHdnZnAva2NsSDArbnZNaTYr?=
 =?utf-8?B?SU1RcWlqcUJuM2NzaTgrbVlrUndqdmV4SVFIR1VKYlRmL0dwZnp6OWFRSTcr?=
 =?utf-8?B?TVRqYXFyMml4ZTlKbUtYcE9UT0JrWkpJSEw2R2NOT1pXK1Mwb0ltdjZjME0x?=
 =?utf-8?Q?hKLhWKFYAXe66eYPMQ=3D?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB6255.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7016a5c-7028-4c95-5908-08d916b25cda
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2021 08:29:16.6353
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cAv4fX2U+VJm50n/kawgRRmwCZAg/Vxg1ZKqucphpJeZ82wyo2CVupr4sAWuy+GrctDwwgm2RfBRaJ8QPg7P6O31GEd4k0bTmVZA4GCVBTo1fldKgQn98hCdaxwJyfYm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYXPR01MB1597
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 0yyht7gstZ07IF2Xaa8p4l1Hx4520388AA=
Content-Type: multipart/mixed; boundary="9977uYI3rwFPdkznLMr0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1620980971;
 bh=ePCClC30iHqENBMmo9cOiA+ox4IUaEgh1GneaQUBgZk=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=l6y/EoYr+B6T7DAfDbDrWYs+Cr9fJHR+IgUNjRkOB9tg0Gcms+i5QMhQ2hK/xMWqK2W
 DQsQ7DJoo+AkJ0kPE4kT5SJ6W8H2VshY9UTN0X4z1RFdPuM/HVurSlI60TB7gSjo/5yDb
 pFk6uFWlItxUBOI8ZCCRngNoo+jCKwLxgb4=

--9977uYI3rwFPdkznLMr0
Content-Language: ja-JP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGksDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUGF2ZWwgTWFjaGVr
IFttYWlsdG86cGF2ZWxAZGVueC5kZV0NCj4gU2VudDogRnJpZGF5LCBNYXkgMTQsIDIwMjEgNDo0
MCBQTQ0KPiBUbzogaXdhbWF0c3Ugbm9idWhpcm8o5bKp5p2+IOS/oea0iyDilqHvvLPvvLfvvKPi
l6/vvKHvvKPvvLQpIDxub2J1aGlybzEuaXdhbWF0c3VAdG9zaGliYS5jby5qcD4NCj4gQ2M6IHBy
YWJoYWthci5tYWhhZGV2LWxhZC5yakBicC5yZW5lc2FzLmNvbTsgY2lwLWRldkBsaXN0cy5jaXAt
cHJvamVjdC5vcmc7IHBhdmVsQGRlbnguZGU7DQo+IGJpanUuZGFzLmp6QGJwLnJlbmVzYXMuY29t
DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggNC4xOS55LWNpcCAwLzJdIG1lZGlhOiBpMmM6IGlteDIx
OTogVHJpdmlhbCBGaXhlcw0KPiANCj4gSGkhDQo+IA0KPiA+ID4gTGFkIFByYWJoYWthciAoMik6
DQo+ID4gPiAgIG1lZGlhOiBpMmM6IGlteDIxOTogTW92ZSBvdXQgbG9ja2luZy91bmxvY2tpbmcg
b2YgdmZsaXAgYW5kIGhmbGlwDQo+ID4gPiAgICAgY29udHJvbHMgZnJvbSBpbXgyMTlfc2V0X3N0
cmVhbQ0KPiA+ID4gICBtZWRpYTogaTJjOiBpbXgyMTk6IEJhbGFuY2UgcnVudGltZSBQTSB1c2Ut
Y291bnQNCj4gPg0KPiA+IEJvdGggcGF0Y2hlcyBsb29rcyBnb29kIHRvIG1lLg0KPiA+IElmIG5v
IG90aGVyIG9waW5pb24sIEkgY2FuIGFwcGx5IHRoaXMgc2VyaWVzLg0KPiA+DQo+ID4gICBodHRw
czovL2dpdGxhYi5jb20vY2lwLXByb2plY3QvY2lwLWtlcm5lbC9saW51eC1jaXAvLS9waXBlbGlu
ZXMvMzAyMDMwMzAxDQo+IA0KPiBJdCBsb29rcyBva2F5IHRvIG1lLCB0b28uDQo+IA0KPiAoQW5k
IHNhbWUgcGF0Y2hlcyBhcmUgcXVldWVkIGZvciA1LjEwLjM3LCBzbyB3ZSB3b24ndCBuZWVkIHRv
IGRvDQo+IGFueXRoaW5nIHRoZXJlKS4NCg0KSSBqdXN0IHB1c2hlZCB0aGlzIHNlcmllcywgdGhh
bmtzLg0KDQpCZXN0IHJlZ2FyZHMsDQogIE5vYnVoaXJvDQoNCj4gDQo+IEJlc3QgcmVnYXJkcywN
Cj4gCQkJCQkJCQlQYXZlbA0KPiAtLQ0KPiBERU5YIFNvZnR3YXJlIEVuZ2luZWVyaW5nIEdtYkgs
ICAgICAgTWFuYWdpbmcgRGlyZWN0b3I6IFdvbGZnYW5nIERlbmsNCj4gSFJCIDE2NTIzNSBNdW5p
Y2gsIE9mZmljZTogS2lyY2hlbnN0ci41LCBELTgyMTk0IEdyb2ViZW56ZWxsLCBHZXJtYW55DQo=

--9977uYI3rwFPdkznLMr0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6456): https://lists.cip-project.org/g/cip-dev/message=
/6456
Mute This Topic: https://lists.cip-project.org/mt/82777615/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--9977uYI3rwFPdkznLMr0--
