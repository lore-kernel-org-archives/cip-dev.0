Return-Path: <SRS0=hMRW=CF=lists.cip-project.org=bounce+64572+5275+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 311F7C433DF
	for <cip-dev@archiver.kernel.org>; Thu, 27 Aug 2020 06:48:39 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7876322B4D
	for <cip-dev@archiver.kernel.org>; Thu, 27 Aug 2020 06:48:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="tY4G7fex"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7876322B4D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5275+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id HFzbYY4521723xoGRuTNA0El; Wed, 26 Aug 2020 23:48:38 -0700
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.155])
 by mx.groups.io with SMTP id smtpd.web11.13269.1598510915115599552
 for <cip-dev@lists.cip-project.org>;
 Wed, 26 Aug 2020 23:48:36 -0700
X-Received: by mo-csw.securemx.jp (mx-mo-csw1516) id 07R6mWfP013451; Thu, 27 Aug 2020 15:48:32 +0900
X-Iguazu-Qid: 34tKSwRU8tPTOHPeMI
X-Iguazu-QSIG: v=2; s=0; t=1598510912; q=34tKSwRU8tPTOHPeMI; m=Akh7uFelIpSYnGBohhEVWDbS62k0+YVC1o54g1Cs50E=
X-Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
	by relay.securemx.jp (mx-mr1512) id 07R6mVXp021897;
	Thu, 27 Aug 2020 15:48:31 +0900
X-Received: from enc02.toshiba.co.jp ([61.202.160.51])
	by imx12.toshiba.co.jp  with ESMTP id 07R6mVBp008624;
	Thu, 27 Aug 2020 15:48:31 +0900 (JST)
X-Received: from hop101.toshiba.co.jp ([133.199.85.107])
	by enc02.toshiba.co.jp  with ESMTP id 07R6mUb6000577;
	Thu, 27 Aug 2020 15:48:30 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aw1lUh3PRP8WcXxeTqPn8KLMaAcXR15CeJzVVqVSoySQk6eyRNH0av10S9aEeJw++IdxmybqWALU8PeVAV5F9gtvHfJG95/kgdKmzBUYfNySD5yPWau7KxFyLpBll0DyUnhAuEliFu7KLPNjNREk/gyY+tIRLmevLv1YLS85mC5wXv33BPY3GtsHuuGeANANixhGCQF3pQXB9sHbeRk+ytIAxvYbaXYH02t6R0niq0+pV9lpx1cmkaMfg1D5VpI0GosQ11gjGO37BDiMrmGLMXv9/G5arn8jZVzo/dvUpwzBDJfKIFi55TwVHih57vIzaR2TZHDxvcDT+h3vgYB6LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j4pw8vxaTrX9PMb7V3pm4P9P9mclYIavAXZjMKTSx7U=;
 b=WKgrM2TPvt+UzJGb55obqnkD68doPm1quTkIHKqs7d6Ro0DpeRpgpTDjy3nxbgi85qIjHU62Saim25AkeFLGyG79pmlRoi80IswUdg71fwcakHt9jMxYWrOs0a7DVZtO10du8Uo495CFSRcp+S39snFUczJLfCKZR09/tOWjnbz82ujKeog+f40/fylW7XXuGCGmZajkij2tDLfeQnFSErsjKkFVsNNFHQkLIvYv3l1bwbrWntfTv1wiQjnyU1ynkHW4NMAkHiCrqPVQfFk8svAYYFFi0jFXueY6eXnXOT+2skSREuMnt1+mPmUA1//YyYsFlZndaziORQSOtgONJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: "Nobuhiro Iwamatsu" <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>, <Chris.Paterson2@renesas.com>
CC: <jan.kiszka@siemens.com>
Subject: Re: [cip-dev] Everything failed in gitlab
Thread-Topic: [cip-dev] Everything failed in gitlab
Thread-Index: AQHWe3oYMRW6Nuf1qEKKdbQw/+P4O6lLhNuw
Date: Thu, 27 Aug 2020 06:48:24 +0000
X-TSB-HOP: ON
Message-ID: <TYAPR01MB29909A6D72BF6BF99367951092550@TYAPR01MB2990.jpnprd01.prod.outlook.com>
References: <20200826072457.GA6645@amd>
In-Reply-To: <20200826072457.GA6645@amd>
Accept-Language: ja-JP, en-US
x-originating-ip: [103.91.184.4]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: efd4814a-27cb-429a-5d95-08d84a553211
x-ms-traffictypediagnostic: TY2PR01MB2027:
x-microsoft-antispam-prvs: <TY2PR01MB202714240D399F16F14AD84992550@TY2PR01MB2027.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: lbNQ94yhnuLWSbiyZPU0EoTWTS4UCaybkEbLKgX0SLLkkLFJrB4KEqeqqm9FMoiREiCVY486k8VfXdRUaddWsB5Vw0QMvt/fzllJw/HyORzsHTpefDM6rvUVj6uC259R4MwvOHzWhcelFQF7GzcNTd0tXuL9l+3HizH+pgEKyMr4qTNAL1nA793xTzVTmShr60ExVMNHOMIcMLMI9LASnq59BWJAlmSeanKdkw7hfuMsq2Ppx9n6XE1fXbJacfFJiApd15mAZEnnWnnPVm8qwaIQvJG0zHCmhC8TRsRDKZMSoh1YsyfJdoQ7xRYHCHS3eFYKTXm/rCgeK8Rcxsb+eqaDVrGhdEuFKPS0cdHVmtC6VElFo6ie3MqxpJWdKAGzkR/m7tzIjHFyggw3BLbcnA==
x-ms-exchange-antispam-messagedata: mPe+q6GSeCxtiX36124dkuIGu/lYnXFNvtofFgHe4Y1jjLukMb0g8Hk2xBkBjQWYHbUI7or4iiaCsCItO6qf4EP5X7myhHA4Yh87Rz9C2XyFYjzDvvPWsDkyvjng6S9tUZQzaaDsEr3GKYV9i4S78IArz0LUP250kdXg9zZHRlzrwpniQZCue/FrJ78MZTKsp5/dDi77WJ/zYu7oddqh5PJeA7CYS0yha5eNm64TGHoU1WQ4w4fDKSNu34TudVH10Zx1iISzoHf/M4fj9KXx6u2NHbpBKwVmZ4r5hPsQcAzUC4AdCqyl9reg4eEuIqpfUMYAxK8e+UjdNGGmTanxncEkJ/lpzCizR5ySZOnBlsT1fgm/8BpK5DO92Wg6I0pplloVKNdZvQ8ftnyZ4d3Sj1Mw1803d03GCY0OOcbXhMJo7o6cFyXSdlD0X9Bz3WIvsmH3y5Xh6p4sGEK6yYIYVXXQW1y7MaaBBGQFlwUWECb92N2JosoO60cKbJdD+1p84gX5mnE6uanGB/TsJbgpO/0TuZLaxx8DcqVp7xyrXEvRWUxCph6t8r5OoiBfTKrKyr0jnvCujnPzGv0xvXJLwuBKWPCatFKRer6htRZaPaKqnhlJDYfrk6HSLSMBiMEwfm4za3BhZJ+BE1XCLsvKRA==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB2990.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efd4814a-27cb-429a-5d95-08d84a553211
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2020 06:48:24.5219
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cu3lXSCRY8+1wFLanMLtQODYE8AX6eZIvFgid+ZCOxD24iP85JU+cyMVOnjtyYhRk5kKHXy2vKBtiytEpJvybzriNRH5nkmzvZ2B7xkuNziYHV9V6Y4ftz6NqLfaU8eP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB2027
MSSCP.TransferMailToMossAgent: 103
X-OriginatorOrg: toshiba.co.jp
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: jGy3J00vKmNaxeNFUPVoyB9Yx4520388AA=
Content-Type: multipart/mixed; boundary="MxVp3iNvMO5nIJ3j5jDv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1598510918;
 bh=eeWYpzH1uOHH/ENWzxPstL3V8RBchvHdfYkUweX2zpk=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=tY4G7fex+NGoUHDyq7CRHgqdxNKhZqVFyYIgaQzy6WvnXICBMULxFHw14B4jlNDYIcJ
 7BUh5OPxxNg2Y5W/b0PBrMDwvcAnHUh4tWhjZpiM0t8xZwAODnf+AMvhphjYFqj4B0tn4
 JIEiYbGdmFpJr1PFtVCoPx9FNch4lvYmZg0=

--MxVp3iNvMO5nIJ3j5jDv
Content-Language: ja-JP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGksDQoNClRoZXJlIHNlZW1zIHRvIGJlIGEgcHJvYmxlbSB3aXRoIGt1YmVybmV0ZXMgcnVubmlu
ZyBnaXRsYWItcnVubmVyLg0KQUZBVUssIHRoaXMgcHJvdmlkZWQgYnkgU2llbWVucy4gSmFuLCBk
byB5b3UgaGF2ZSBhbnkgaW5mb3JtYXRpb24gYWJvdXQgdGhpcz8NCg0KQmVzdCByZWdhcmRzLA0K
ICBOb2J1aGlybw0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IGNpcC1k
ZXZAbGlzdHMuY2lwLXByb2plY3Qub3JnIFttYWlsdG86Y2lwLWRldkBsaXN0cy5jaXAtcHJvamVj
dC5vcmddIE9uIEJlaGFsZiBPZiBQYXZlbCBNYWNoZWsNCj4gU2VudDogV2VkbmVzZGF5LCBBdWd1
c3QgMjYsIDIwMjAgNDoyNSBQTQ0KPiBUbzogQ2hyaXMuUGF0ZXJzb24yQHJlbmVzYXMuY29tOyBj
aXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZw0KPiBTdWJqZWN0OiBbY2lwLWRldl0gRXZlcnl0
aGluZyBmYWlsZWQgaW4gZ2l0bGFiDQo+IA0KPiBIaSENCj4gDQo+IEkgdHJpZWQgc3VibWl0dGlu
ZyBrZXJuZWwgZm9yIHRlc3RpbmcsIGFuZCBnb3QgImV2ZXJ5dGhpbmcgZmFpbGVkIg0KPiByZXN1
bHQgYWZ0ZXIgdGltZW91dC4gSSBiZWxpZXZlIHNvbWV0aGluZyBpcyB3cm9uZyB3aXRoIHRlc3Rp
bmc6DQo+IA0KPiBodHRwczovL2dpdGxhYi5jb20vY2lwLXByb2plY3QvY2lwLWtlcm5lbC9saW51
eC1jaXAvLS9waXBlbGluZXMvMTgxOTQ1MzkwDQo+IA0KPiBBbnkgaWRlYXM/DQo+IA0KPiBCZXN0
IHJlZ2FyZHMsDQo+IAkJCQkJCQkJCVBhdmVsDQo+IC0tDQo+IChlbmdsaXNoKSBodHRwOi8vd3d3
LmxpdmVqb3VybmFsLmNvbS9+cGF2ZWxtYWNoZWsNCj4gKGNlc2t5LCBwaWN0dXJlcykgaHR0cDov
L2F0cmV5Lmthcmxpbi5tZmYuY3VuaS5jei9+cGF2ZWwvcGljdHVyZS9ob3JzZXMvYmxvZy5odG1s
DQo=

--MxVp3iNvMO5nIJ3j5jDv
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5275): https://lists.cip-project.org/g/cip-dev/message=
/5275
Mute This Topic: https://lists.cip-project.org/mt/76423839/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--MxVp3iNvMO5nIJ3j5jDv--
