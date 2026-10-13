Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4CCBCC6B03
	for <webhook@archiver.kernel.org>; Tue, 13 Oct 2026 04:56:51 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.134])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.493.1791867408676584659
 for <cip-dev@lists.cip-project.org>;
 Mon, 12 Oct 2026 21:56:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key2.smx header.b=eNEpaPug;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.134, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:CC:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key2.smx;t=1791867406;x=1793077006;bh=JpxpIgpO9geI/tkWP8WEWwWKYv84UQEGv23ta
	a/Rqqw=;b=eNEpaPuga1NDzjXUUcOiJymqSLal2ASq1PCY1FLPRj6LOHN3RmRp1ZmvjypA1BwhY0L
	HGX0m+4i1SpcojV6/zHUWFaSP2T6HkBkmHZp7O0wNHtAopRwUdyXXv0Q+/gXvlx1hNuTMcU+8nFhV
	WRVOH9H8NHTXyyllJARib8bnat0cPRJ0IrHHx+7zGMefCeEJwOozkyicj6X01wQN/N5CrayqwwsZI
	Inr+TaVTneu0mb4SwaS9nNg05aq2vZ0tenkxlo0Z+QHDiYBnnyCuAIH/HCDszPRyOYYpF057FlNFP
	8N1NsK5hqERSguZUMHNLTUJUE4bhavDnwX+BY7+PLvLw==;
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 69D4uk1Z1975792; Tue, 13 Oct 2026 13:56:46 +0900
X-Iguazu-Qid: 2yAaMsnyJxhzWmu2Og
X-Iguazu-QSIG: v=2; s=1; t=1791867405; q=2yAaMsnyJxhzWmu2Og; m=r7Vbwmc7DrX9amPzL1BtMrjZWU4IHJ5ZzUMaVS7x2Bg=
Received: from imx12-a.toshiba.co.jp (unknown [38.106.60.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4j3hrY0BFbzyPZ; Tue, 13 Oct 2026 13:56:45 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qRoF2PzZEnd5enVYLJQ0KOue6Fj7YzLr1p+bZkJqaFjb+yaPabUyQOoq+WHbWaAF9h6kSAjJiBE7abmpdkcAw0aau3vYv+4j8AlWo5dQ6VMlOwVHOf+fIl3edtP0x/4VBHHJ+TqCu5qgzR3XgdwTAy2+WTdn0MPJpPxsW1LlUn3+FTw9EV1XpwrhxH4WP02cNuUNYpIKvRFrALDudFYx9hFwCDguj4BLwJucRWsBvkzGf10OO5RhRdpG8qf1Xu+c1J0fhOFLVdpciU3LvuL3hyDtTNleQgiQ5swGmMUeiiXIpGiJwA+yMLM+I9dSDsUX5Uv0LZKArhqL7PvCF3NVNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oL8xMBck5iemYRa2HHzlgJ+uSGQBfxSfe7+clx9u3nE=;
 b=cVsfzpIKo2mE/DUX4shfm1jFiW4qBd4YVZTk9IxGIy8l73pMIwENNyR/T4K8eLPlOoiCyzGbnB2Ha40+x0bw/UHoEs+ZqRPQ5G3hxi9OB0xSAamRXG+5RpMo/rcXd9L+z01RBOyPVQd6rBpGv+ScWdRL8OPk9BfyPFzSr+z3UmtRsMfBH33xB28BCxZWv2cRxLWFyx8B+V9hWc94RlorhD3K1Ja8pJz3n5+EYuTlCEJbdlSQPfdESNGakZulm04Eaowp7iurhaoJZOIAwcvpCb54nmFbU4hrGGbSXzPotcLb5XAfwssszzgeXJvPbfq4D+Fosj4qYlnWvqUV+NUzOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <nobuhiro.iwamatsu.x90@mail.toshiba>, <biju.das.jz@bp.renesas.com>,
        <cip-dev@lists.cip-project.org>, <pavel@nabladev.com>
CC: <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [cip-dev] [PATCH 6.12.y-cip 0/3] Add Reneses RZ/G3L RSPI support
Thread-Topic: [cip-dev] [PATCH 6.12.y-cip 0/3] Add Reneses RZ/G3L RSPI support
Thread-Index: AQHdTAehex3U4PayT0iyxysdE3WCZbbokUwwgADXYuCAEZ18QA==
Date: Tue, 13 Oct 2026 04:56:42 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS7PR01MB14808028DB1B34295C7224F47CD9E2@OS7PR01MB14808.jpnprd01.prod.outlook.com>
References: <18D837EDDA8014EF.2416057@lists.cip-project.org>
 <TY3PR01MB113465D5BE3E3F4DA59396432868A2@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <18DA8E33316E63A1.2870736@lists.cip-project.org>
In-Reply-To: <18DA8E33316E63A1.2870736@lists.cip-project.org>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS7PR01MB14808:EE_|TYYPR01MB13352:EE_
x-ms-office365-filtering-correlation-id: 179d3a7b-184d-4fe4-9868-08df28e65f98
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|260925021911599003|260925022911599003|260925021311599003|10067099003|261009223027099003|38070700021|11063799006|4143699003|18002099003|22082099003|56012099006;
x-microsoft-antispam-message-info: 
 1Xtl1kWmjJyFKB3+Rb6jwNu2gHbV6y1XhXpPXGSjVXMsqzeTYc7HcYBGBWZykh0PzM+OPJfa6oKcKjd30BLhNpCOC63LghapfAB6yNpITCwbiQZ3zgP69nmOO6ojO9X2Pbgt1R/P5amy7p1SwcGrbyHOUhg4E/hJuJfHtQyl2lO6rfd/CSjYhwuP4by8DUdnJHGhh/caASLidFEbAwF4OqeZ5TH7wbmow98NF+wKmZa6CXinaNsAMmRfaTwFJVP0dlFwAMfU/bJsMA5YyKaMs2cW3JIRSCadfhbiowb3Zys/o+2CPfNRUWsyvcdn0Rrue1mX2/8F0nlmtnZSmVkwcmltZu2C1f5JT5vPU3RxqrQgaDgk/f9AGOMPg5tyzLO/2+ZkQzUl/yGu53/9ILEmUz1XnPk6kr3ZFnX4y+5mssGidkCT6ocVlQhVQ+Gf3UpvAWMKDAF0AMi3ovE5j8lDJcaPDhK/yA2M7BjX/t5iEhMPtyTUl9g/TYwkS2rYFv7qnO8VsXgB7y9GpLDBplAAI0Puw17uZBUBTC11QDJcIh1+e/TuWnBIjSANPnzjyBAZh2VDrcp20n4d+RLQUvpjd2ZA1pNgqRoyXMuyrjPsVMLN5LxOa85d4l1MNbGWiY6+23NmhZYR3ZLY59W468JAIpJxNCefiMMTqEKkq36ar54/KjZg8UJvubrk1ry13gt8
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS7PR01MB14808.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(260925021911599003)(260925022911599003)(260925021311599003)(10067099003)(261009223027099003)(38070700021)(11063799006)(4143699003)(18002099003)(22082099003)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?UGcySzcvUUFYdk10M1pzblJzWDI5ZjlPd3FwR1BpV1Rra1hBR1FrS0kv?=
 =?iso-2022-jp?B?Zi9nK3JObjM4S0pFd0hZeW1iVzhjV096Z0hPTm5IZG5JNW5CRHBzcWhM?=
 =?iso-2022-jp?B?QS9MNzhlb21wQ21IRWNNeFZWczlZYXVSalRWRVdrWUc2TVNISGtwSnhX?=
 =?iso-2022-jp?B?Q3hDdGJIVktjbjJjN1o1dEVCNXF0ajBFZDBuQ0NlSFZWaUtBcWdhajRM?=
 =?iso-2022-jp?B?MWwvV2tKT0dDLzkzTUFkTW5LdHVlVEVLZWh1L3BOUkprckZCY0I1NHdr?=
 =?iso-2022-jp?B?bnhOZU8rMUZaay9yc2l4MXBaR2xHZFp5QXZxNFBlblBld0g3N2xjWEN5?=
 =?iso-2022-jp?B?VFdXb0lIQUVmdTkyMVJRSTBlVXNML2tDdmNrSUFad25FNlVrdzRMYjNK?=
 =?iso-2022-jp?B?VHArNW5NSE9kYk9HRktkWThhSjlIbVZ6SEFKeWM4NE0xWVN0dlFDcDZ4?=
 =?iso-2022-jp?B?aksxMDcybmNsVkFrUklrWndCUWVqUHczbmg0UjVxUlZpZm90ZEVUdGVj?=
 =?iso-2022-jp?B?SCttVkpIM1JyK21icWtSV0pRajg5K2N4N0xIYUZoc1RGMW5KZytGQlBk?=
 =?iso-2022-jp?B?dFFqemc4bFlCUzZFak92b1h4QkdreDA4eFM0R1k1aXZOTGNFYlFNL3VB?=
 =?iso-2022-jp?B?TmlDdXpoUkZFdzhtWlllalZJTUVGaVRlekRrd1J3M0MrNWVHTzN3OXV1?=
 =?iso-2022-jp?B?NjUzd1E3eDk4NytJd0FNMTZoQTJUL1BBTFJ1bU9PR2NHa2RBa0s0UWZI?=
 =?iso-2022-jp?B?bWRmdW9UTWwwN0dWOGxnaVFoNFBydm0yZzc5aXZ0eDR4U3lGVjlpZnRE?=
 =?iso-2022-jp?B?dmVZSHpvc1dzbG5uSkU0V2Vha3VWbDBmM25MLzVCWWVDRXE2YlFMQjR6?=
 =?iso-2022-jp?B?TURGQmUrV2JZU2dURlhqZFRVRnozNFdMZmxueUxWNkxXSlhFUVpPWFN0?=
 =?iso-2022-jp?B?VFNaSmpxaHB0MVZSNnFid0p1MmVSRDVUYzV3OFozRkFxZEFpb3dKNGll?=
 =?iso-2022-jp?B?S2NFMFhwd2RkV3kyK1BCQktyR3NaN3J5VkJwOEMvN1hzK1lnWDAyUUgz?=
 =?iso-2022-jp?B?NjI5UWdZaFAvd2pQWFhnUWw3NUorUFN6Zm4wU05rcG9uSncxdm85SmN5?=
 =?iso-2022-jp?B?SmRPcXk5Z3ZQQ1I4b1h1SUdGeS9vRVFnQkQ0OFRoQlcvRStvQTJZUXpY?=
 =?iso-2022-jp?B?WXBYdmo0SnZBQm1Jb1MzU2E3U2ZaM2tlN0g0YzBmaDI3d1NuZ3dqK05o?=
 =?iso-2022-jp?B?dFc4dWltSzVuTFNEb0U4aitDNDhVMEVhS2h6d2dKVnRsZ1p3SUpTeExw?=
 =?iso-2022-jp?B?dGtvL0Z2WE5ZYWpnSVo2L0V2OWxUTThuSzMvUWVqN3piMisrUVBrZHJt?=
 =?iso-2022-jp?B?NFdPUzZNVHlKUjZ4d1VNUEZtQk0yQytrRDFrNWFWTWNPaUgzOFZITW5Q?=
 =?iso-2022-jp?B?YUlVOE9nbU13aENNUVpYZURBU3lQWjhzZlBUb1lVd3pUTnRMQThtU1NU?=
 =?iso-2022-jp?B?VWlMdkNONkkwa1hBRkhKcUJlcEJmSDY4TE5NbTFQNW01RFJNVGJFL2cx?=
 =?iso-2022-jp?B?ank3SnNnZ3psSXhLcTJGTUtPYXZDR1dwUDVlaTc5VkFubUxvNkd3eU02?=
 =?iso-2022-jp?B?WTRkWEdyTkU3eE9BUUlob09PZHA3Mm5zc0RvbzFDNXRGQklaMXRGTjZH?=
 =?iso-2022-jp?B?R0tPbXZkdVloR1hlRGY5NTgrZUtkcGorVXNlZkpONjMySGM3WUNISTFx?=
 =?iso-2022-jp?B?blc2RHlMekFQRUJPTDdmMTgyMEQwMGt3S2NmNVhMUXNxVDFxYXI5OENx?=
 =?iso-2022-jp?B?VkUwWittSDMxMzNwTzBVT3pkNEY1bExGbUtYYzBjeEpOT3NyandHMUpL?=
 =?iso-2022-jp?B?MmtvWUE5WElVR2hMMkVUdVd3SS85UnR1cTg4eGNTSkxITDdkS29OS3JI?=
 =?iso-2022-jp?B?Umswem52cXE3SW1uc2ZMMkpjUlo1dmErTU8wYytvODM1ODVMZnNXWUll?=
 =?iso-2022-jp?B?bnhIaXpGN3Z6QTIxdFpVSUc3bVRES0RGNWp0aXlLckxLaEUyVm1DWjlh?=
 =?iso-2022-jp?B?b3RnalIrSDVhM2x3Q3RsdnA3aHR5Qk0za3B2V1NtMTJwMWVTZDNiK2tq?=
 =?iso-2022-jp?B?ak9pV3BZaE1pMUpRZ3hXTHJNMUw2QTB1YUsxR1krQzM1eXQ1Y29wTVlL?=
 =?iso-2022-jp?B?WjZhY3pnVUFWeHZBWUhwZ1Zia05XZkNray9RTUhDRDVOcGpnNTB0VVQ4?=
 =?iso-2022-jp?B?RTNDdExLNm9BMU1jdUtDTmNFR2xFL2drU0tYVjNkMXlGRWs2RFYzaUdF?=
 =?iso-2022-jp?B?Y08wcStYVWxJTXdsR25OSzJKQkxINE5RYm1pVnF6dzNPV04wbFhZVFF2?=
 =?iso-2022-jp?B?TVE3a3hRa0ZKOUI3dHUxRHFzSUVCZkJ2RHZzdmlJU2szcjc2Si9qeVly?=
 =?iso-2022-jp?B?UzJ2R1picGpHK1NsRldtOEV1SjA2WUhBYVExMWJJL0tPWnRLQzM1ZVNh?=
 =?iso-2022-jp?B?L0dybmpvSVEveSt3dTJzTFAzZGh4MlU0SmM3S1hkZHJKQXllUDR0SGgw?=
 =?iso-2022-jp?B?d1VKd0FLZz0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
	ELZGKJdcAgdbUYU4uhGvw7FaYAvkfRgYqFLqhLbXsffO6gbUh6xlqJjGrmSoKU+PhxYYZcNeZF9wz7r0Dz9HMxG6SLcAfmKTKI1HVL1oxJzsfVE5b8A4elC/vdYPIumb+TpgMPWDqrJ1YfP+Qd6GOXUKlUvrnpbx9INkdbTrXEAoTCPZrfOuZQ7jQNmxL2xYj0rAkszk2h51N9T6aUScE2W9FPijixQ/CuWqTGdDAecg6trqNrl5ocxeG6SnPM+r6kLDLyHcds6C54TR6ayLPyJf0+pARilvUr2j4oz8GlfL63C+BYS8B5AXSxe1/RuHoc/RgEoYa36qbPlvatQbjA==
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS7PR01MB14808.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 179d3a7b-184d-4fe4-9868-08df28e65f98
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2026 04:56:42.0865
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TS1JUBq1mRhgJFFAUsAa2UAqmdET5WdIjWBwG4Jwg/2guJ7yG5INnx44WM5Jk8su8+1Gsvw8MwCDSlHOf9xeFjofxpzfrk9weF4ckr1NQy2QSyMitqtH0ATj0WRh5xE1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB13352
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 13 Oct 2026 04:56:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24447

Hi all,

> -----Original Message-----
> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On
> Behalf Of Nobuhiro Iwamatsu via lists.cip-project.org
> Sent: Friday, October 2, 2026 9:16 AM
> To: biju.das.jz@bp.renesas.com; cip-dev@lists.cip-project.org;
> pavel@nabladev.com
> Cc: prabhakar.mahadev-lad.rj@bp.renesas.com
> Subject: Re: [cip-dev] [PATCH 6.12.y-cip 0/3] Add Reneses RZ/G3L RSPI
> support
>=20
> Hi Biju,
>=20
> > -----Original Message-----
> > From: Biju Das <biju.das.jz@bp.renesas.com>
> > Sent: Thursday, October 1, 2026 8:06 PM
> > To: Biju Das <biju.das.jz@bp.renesas.com>;
> > cip-dev@lists.cip-project.org; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B?.=
MN=1B(B =1B$B""#D#I#T#C!{#C=1B(B
> =1B$B#P#T=1B(B)
> > <nobuhiro.iwamatsu.x90@mail.toshiba>; Pavel Machek
> > <pavel@nabladev.com>
> > Cc: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > Subject: RE: [cip-dev] [PATCH 6.12.y-cip 0/3] Add Reneses RZ/G3L RSPI
> > support
> >
> > Hi All,
> >
> > > -----Original Message-----
> > > From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org>
> > > On Behalf Of Biju Das via lists.cip- project.org
> > > Sent: 24 September 2026 10:32
> > > Subject: [cip-dev] [PATCH 6.12.y-cip 0/3] Add Reneses RZ/G3L RSPI
> > > support
> > >
> > > Add Renesas RZ/G3L RSPI support. All the patches in this series are
> > cherry-picked from mainline.
> > >
> > > Biju Das (3):
> > >   spi: dt-bindings: renesas,rzv2h-rspi: Document RZ/G3L SoC
> > >   arm64: dts: renesas: r9a08g046: Add RSPI{0..2} nodes
> > >   arm64: dts: renesas: r9a08g046l48-smarc: Enable RSPI2
> > >
> > >  .../bindings/spi/renesas,rzv2h-rspi.yaml      | 29 ++++++++
> > >  arch/arm64/boot/dts/renesas/r9a08g046.dtsi    | 69
> > +++++++++++++++++++
> > >  .../boot/dts/renesas/r9a08g046l48-smarc.dts   | 19 +++++
> > >  3 files changed, 117 insertions(+)
> > >
> > > --
> > > 2.43.0
> >
> > Gentle ping.
> >
>=20
> Sorry for the late review.
> I reviewed this series, looks good to me. I can apply this if tests are O=
K and
> there are no other comments.
>   Test:
> https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/290486085=
3
>=20
> Reviewed-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
>=20
Applied, thanks.

Best regards,
  Nobuhiro


