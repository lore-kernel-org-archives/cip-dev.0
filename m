Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A232CD5BA9
	for <webhook@archiver.kernel.org>; Thu, 13 Nov 2025 09:18:07 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.19734.1763025480994662218
 for <cip-dev@lists.cip-project.org>;
 Thu, 13 Nov 2025 01:18:02 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key1.smx header.b=vN5lyYFB;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.152, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key1.smx;t=1763025467;x=1764235067;bh=KDIR7yQuVRoXdCiMm6ANL3T8x66f7mvUf/ks+
	mXSxWM=;b=vN5lyYFBaCmVyrjbw/8Kshxo8uNhGHICsort6i/fG7dVijOknUSYfcOu6MzRDLBEor9
	nPkeB7SO4MNmklMEfSuITu7kFX8SpPyJ0Tocvkp+gFqZpO4A/BoQtEIElZXW2CEbXTEaGl8FBQMTq
	6E6Gzi0f9wpLmuYPyHeZwZLkChyaNthkzO5HYnEMzNYh3RVBMN2j4/yHZWj+gcBzSqlUoK2wx7/FQ
	ZKRo3r9yZpatsjuNasBv/icSnqxNsMh2cIkVgFad2GsJ7IWhYkJOkNvf6yHsZl+3NyWxhg7oH+yty
	7s5oTN8T5T7S1rDiPirBQ9llt2OzxewGx1kyuhVfqcEQ==;
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 5AD9Hl813977600; Thu, 13 Nov 2025 18:17:47 +0900
X-Iguazu-Qid: 2yAakGMojiCjFIGGNk
X-Iguazu-QSIG: v=2; s=0; t=1763025467; q=2yAakGMojiCjFIGGNk; m=FvpHLqR0GNR7ELldnf6wRDm9uD4ufj/BIJa5Jb8rqxM=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4d6ZRt4c4mzyPZ; Thu, 13 Nov 2025 18:17:46 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CLvX0L73rYUTWWmuK01lLqmVystG28vCZgcQlkiL5JMI3+0ValxtWPZW7KdNZ5uU2pLKmhjdxt/F/BOrl/hTZMZLo2KCuhu/Dro/QWUuCiAdGEjKPUZjNBJsLit6gOuUbcbkkP7J4nxiu/t441ZaAf5Kf50sv8O/ZQyS6zeEhIRhYt0anGHOTUC/xm2JtlsKrAcTfWJF3CK1SaLGZbQBWe2psWa9fIqJqmiD/Jtvl3+hJY8MNUjTr5xjgRY1LqnaDq+rSPjNCf8xs1XAQU8zYzKnFgm4zhoDCyeBkuYL7nA8dWQP54oKexwleXRS+SCLnP2sQvWzZpQrzC9CxMTFRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Xc03j5o6Y2k5U4wgP2j/tiTrb53k3r5gw82Jq7XIyM=;
 b=UCZWbureHtT6phl4nv1AIMEvubNnWeuuYodULMjAlH2e6acp3/wNHMjAiLCtc1GoxkmWTLbpLpObx8Doy/UnnrESmHJxoBLSFHrH5x8iHM26QjDtH6ncTX8Qk4QqERixam0zP33Bsh2Fi53CAor+Wxtcypx602xxHRo+UFn3nDiG6Z4bEsZa6beeMHOPnQHWkVr1yg6Qu8kUDeA5FKlfjmrnzQsjHGFHQ05Xf1W8ISqxVoSFd9GAVb9pkc1lzITgI9Uxe7A5wx/eOicZwpjUEs9/bwTRrc4WZRi9ADkY4hekrOomUehf//v0WPXae5iblYF3dPWuNCopwF0y3eAaPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <ovidiu.panait.rb@renesas.com>, <cip-dev@lists.cip-project.org>,
        <pavel@denx.de>
Subject: RE: [PATCH 6.12.y-cip 0/1] Add RZ/V2H ICU support
Thread-Topic: [PATCH 6.12.y-cip 0/1] Add RZ/V2H ICU support
Thread-Index: AQHcSXohAN8na7gZ1UiuF/m8YRQGZbTbeywwgBTkMcCAAAnD0A==
Date: Thu, 13 Nov 2025 09:17:42 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB14818BA7A37D7D94DC3D9784DCDCDA@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <20251030084927.47505-1-ovidiu.panait.rb@renesas.com>
 <TY7PR01MB148188796779012A1BC1EDA69CDF8A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
 <TY7PR01MB14910BC4525FB7ADD0057D7B2D3CDA@TY7PR01MB14910.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <TY7PR01MB14910BC4525FB7ADD0057D7B2D3CDA@TY7PR01MB14910.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|TY7PR01MB17204:EE_
x-ms-office365-filtering-correlation-id: d5a237c5-0786-450f-79d3-08de22957fbd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|18002799006;
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:OSPM;SFS:(13230040)(1800799024)(18002799006);DIR:OUT;SFP:1501;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?ZFhiVDRhOVh4RTVWL1RScmdZaHpsY0xFNms1dTZKS1NSOVBTY2hLUkdO?=
 =?iso-2022-jp?B?UkJKd05pcUFTT3p6RHMwdFVTTVdEb1VpakZBQnRjd0p0S1dmV2xWZnJK?=
 =?iso-2022-jp?B?K0hJbzRkdExZM3JyWG1DR0VTdk1kVmVScHVlbnNFT1JFNmE5SW53d1lG?=
 =?iso-2022-jp?B?NUxCdG8zT3V2dUVyZDFWN3NzRVFhSGlQY1YxNyt2ckFWZE9hOThQTXFv?=
 =?iso-2022-jp?B?MnllZkNLd3ZLTXNQL1hhUGUrOXlkb2tRTEltbDI1Unp4TitRL045OW1L?=
 =?iso-2022-jp?B?ZkVORTNKazcreFNubklnd1Q3T2pmSG5mNmJ5MTJ6YmIrMU9uZWlWTTF6?=
 =?iso-2022-jp?B?Sy81dWJZK3dCTmNwS3VXQWFiYzV5a0xKcWllQW1FNWtIVmNIRkxXdWox?=
 =?iso-2022-jp?B?d3hFZWcwaktlQlVqVE5GMXZEZTViL3l0Rk05a2J0RmRYMDhScTVwdTQv?=
 =?iso-2022-jp?B?VWpkbmVNUllndWNWUVY4TGtwM3pRVUJmOEFEQTNOYis2WnB6VlJTZ09j?=
 =?iso-2022-jp?B?aG1TdEsxZWdkYkUydW9HcHVsWENBajdZRnNYWHRkeDc4aVlqR0pJZklZ?=
 =?iso-2022-jp?B?YzJrSmlCUXNPS05NS0Z0RlgyMXFHNGZvb0RHM1d6a3hINTNobThXeVRr?=
 =?iso-2022-jp?B?ZzNBd0VWVkZTaEdzenBCZi9rS1I0c25vKzVmaklTb0VPTFVmTXNMNisz?=
 =?iso-2022-jp?B?UVdOMTlqR3ErT2R6MlBjcEN5cFcvZXlXa1hDREdaT2ttZ2UwcmdxbW1a?=
 =?iso-2022-jp?B?RDB5ZlJobEpIZTNYeEhYQ3VRZDUyUVoxR3hsZjVDQ001ZW1UdkV0VU96?=
 =?iso-2022-jp?B?S21POU1ZcksyTExhWUprNEh0UkxoRHErYk11ckNzNFZXMm1rK1lLdUJR?=
 =?iso-2022-jp?B?Mnd6R2F2ZGhqTEsyMHNuOStZQ0lzb001NUtQYkZlYTJONE5vcjZBNHY4?=
 =?iso-2022-jp?B?cGxKVFlzSlFOb09JWDNLUFlPYWlmVVNqRW5aN00xZUl3NW81MXJjRWE1?=
 =?iso-2022-jp?B?WURhM0lFVmxiSmxzUklYZU15OUhOMWVacW9KdXptalY4aDAyVVBjMTJO?=
 =?iso-2022-jp?B?S3VQQVQ0TVVQaHlDMlVsU1RjNys1a2hUazhDbWo5QktxalpEQS83c3gx?=
 =?iso-2022-jp?B?U1A2YWtjdEtHMUd6ek1MSXJBVU96YkZmWk9wNTR2TEExOWF2UWZZVWlG?=
 =?iso-2022-jp?B?RVVsOWJTQS9HczdTRExTOU5rZEZmSGJZNzBnTHNFMWc0QXNBTHd4SmFH?=
 =?iso-2022-jp?B?OFlhek8zREFERlJrZitDUHhtRUIvMldYWW1VVWhRZXdoaFMrck9YUTQv?=
 =?iso-2022-jp?B?d0pmNEFKSzdRRW9NWlhNc25HTXhKbVZVcDV5dUlqKzRna25pWTVERGsz?=
 =?iso-2022-jp?B?bG5RODBxdFZsSXY2L1lFdXRoNW5QOEh2OG9tWlhTN3BpdEg1SnhPUmpw?=
 =?iso-2022-jp?B?U1prbEtMRWxIZkZHSUl6Y3hTTStlbTlSVDhOVHB6WlUrWkwwUklPdTBN?=
 =?iso-2022-jp?B?VXhrSSsrOTZXc1JHRlI2czNtWGJzUVVaamVSMVhGMkEyMWozZzhNeGVW?=
 =?iso-2022-jp?B?dldscWFOa2RrNk5WTXUrQitOd0Y4aHNpQUJ3Z3JTN3NLT3lxcFJwN3hM?=
 =?iso-2022-jp?B?V2JGSDB1MUM4NzlBT04wQzBMbGsxeWVwMXU4TGZZc2poaWVXc0Iwc21s?=
 =?iso-2022-jp?B?Mlp3ZjVSOGdFY01vS3NnSkkvWTlhOXEwRWpnUHYzME1jMFNOSjNVU0VQ?=
 =?iso-2022-jp?B?alVyZzhXbDdwR1g4MVovWFIvTHFUK1VmU0Vrb2pBenQyNHBnSEVtbVRW?=
 =?iso-2022-jp?B?ZGhCYTA3MmlEMi9HbzZvTWNGMEtoemREdlRadXR6TEF1NGt0Wlhvekcv?=
 =?iso-2022-jp?B?Zks4dWFRbjU3VFFNenE0b1c0Z01taDFqclVpL05ucHVGNEJLdDZJdUpT?=
 =?iso-2022-jp?B?VGM2eW9va1g1R1ZOcmVDMm95OTdTbXpXTWE4ZHN5eXB6M3QxbHM4TWhS?=
 =?iso-2022-jp?B?VWRra0dhR2o1eW5lNk1wdWZNYi9QQm5PcjVkUFlKSGh1elZ3ZzRodjE3?=
 =?iso-2022-jp?B?S0tPUEF0bmVWaE1PQWJDcVZaS0tpT2g4TlR4cTlYcnNwZURnOWNId093?=
 =?iso-2022-jp?B?aFA3S2hCQUFvc3RUcUFCTm5JYVRvTVZsb2JMNzBFZk0zcG9iZTJvTGg4?=
 =?iso-2022-jp?B?Z0xHZzdmNFBKNHYvQXI4bXVuQUVOVXFuL2MyeFo1VS9yTThpWGRUbWlH?=
 =?iso-2022-jp?B?VUkwb3F1S1A5b1dqekN0UXorb1B4aXZYRDVXRFZtNFJ5blJlSnRUTENL?=
 =?iso-2022-jp?B?c0YvZUROK2g3MTIvNjJtN2ZJNnFrcDNkcnc9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5a237c5-0786-450f-79d3-08de22957fbd
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2025 09:17:42.1315
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I65dh67gkW8qsb6BWIOk0Djo4oPzB8oZuF64ii6wrgikOg2YL96u7jlvVT6y6RnVIYJMZbRnk1d0daXiKOS0BxDNMv7GKSMDxC+HhmG6maxQqLtYqpomyWwzrdZqg6wQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7PR01MB17204
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 13 Nov 2025 09:18:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20520

Hi Ovidiu,

> -----Original Message-----
> From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
> Sent: Thursday, November 13, 2025 6:04 PM
> To: iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B?.MN=1B(B =1B$B""#D#I#T#C!{#C#P=
#T=1B(B)
> <nobuhiro.iwamatsu.x90@mail.toshiba>; cip-dev@lists.cip-project.org;
> pavel@denx.de
> Subject: RE: [PATCH 6.12.y-cip 0/1] Add RZ/V2H ICU support
>=20
> Hi,
>=20
> > -----Original Message-----
> > From: nobuhiro.iwamatsu.x90@mail.toshiba
> > <nobuhiro.iwamatsu.x90@mail.toshiba>
> > Sent: Friday, October 31, 2025 3:39 AM
> > To: Ovidiu Panait <ovidiu.panait.rb@renesas.com>; cip-dev@lists.cip-
> > project.org; pavel@denx.de
> > Subject: RE: [PATCH 6.12.y-cip 0/1] Add RZ/V2H ICU support
> >
> > Hi,
> >
> > > -----Original Message-----
> > > From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
> > > Sent: Thursday, October 30, 2025 5:49 PM
> > > To: cip-dev@lists.cip-project.org; pavel@denx.de; iwamatsu
> > > nobuhiro(=1B$B4d>>=1B(B
> > =1B$B?.=1B(B
> > > =1B$BMN=1B(B =1B$B""#D#I#T#C!{#C#P#T=1B(B) <nobuhiro.iwamatsu.x90@mai=
l.toshiba>
> > > Subject: [PATCH 6.12.y-cip 0/1] Add RZ/V2H ICU support
> > >
> > > Hi,
> > >
> > > This series adds the ICU dts node for the Renesas RZ/V2H SoC, to the
> > > linux-6.12.y-cip kernel.
> > >
> > > The ICU driver and its dependencies are already present in the
> > > 6.12.y-
> > cip
> > > branch, having been included earlier as part of the RZ/G3E
> > > backporting
> > work.
> > >
> > > For reference, see the related commits:
> > > [1]
> > > https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-
> > cip.git/commit/?h
> > > =3Dlinux-6.12.y-cip&id=3D3d3a549e2fb073619507de56be14aab242f87b7b
> > > [2]
> > > https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-
> > cip.git/commit/?h
> > > =3Dlinux-6.12.y-cip&id=3Dae9102da607f85ba0831c6b5af0c0d52d5166f7d
> > > [3]
> > > https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-
> > cip.git/commit/?h
> > > =3Dlinux-6.12.y-cip&id=3D69c328745d39318be83b84a7f379009cc574d072
> > > [4]
> > > https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-
> > cip.git/commit/?h
> > > =3Dlinux-6.12.y-cip&id=3D9fc198d9b2c292fb089eaaa2a5b679b24d26f072
> > > [5]
> > > https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-
> > cip.git/commit/?h
> > > =3Dlinux-6.12.y-cip&id=3D2e7375bcebd154ccf175eed1982d11b8b3c4cb8a
> > > [6]
> > > https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-
> > cip.git/commit/?h
> > > =3Dlinux-6.12.y-cip&id=3D1fe131fc74f7fa9d0753fbfb7dbb92483a10ba01
> > >
> > > The patch was cherry-picked from mainline kernel.
> > >
> > > Best regards,
> > > Ovidiu
> > >
> > > Fabrizio Castro (1):
> > >   arm64: dts: renesas: r9a09g057: Add ICU node
> > >
> > >  arch/arm64/boot/dts/renesas/r9a09g057.dtsi | 90
> > > ++++++++++++++++++++++
> > >  1 file changed, 90 insertions(+)
> > >
> >
> > Thanks for your patch.
> > Looks good to me. I can apply this patch if there are no other comments=
.
> >
> > Reviewed-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
> >
>=20
> I noticed that a new 6.12 release was published (v6.12.57-cip12). Looks l=
ike
> this patch wasn't included in the release, whereas the RZ/V2H Ethernet se=
ries
> [1], which was sent later, was.
>=20
> Same for 6.1.
>=20
> Just wanted to check whether this patch might have slipped through the
> cracks. If there is anything needed from my side, please let me know.
>=20
> [1]
> https://lore.kernel.org/all/20251106104024.28947-1-ovidiu.panait.rb@renes=
as
> .com/

I had overlooked this. Thank you for letting me know.=20
I will release a new CIP kernel that apply this.

>=20
> Thanks!
> Ovidiu

Best regards,
  Nobuhiro


>=20
> > Best regards,
> >   Nobuhiro



