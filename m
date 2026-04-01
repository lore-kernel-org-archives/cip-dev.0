Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F22A10F9312
	for <webhook@archiver.kernel.org>; Wed,  1 Apr 2026 00:45:50 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.2531.1775004341320988362
 for <cip-dev@lists.cip-project.org>;
 Tue, 31 Mar 2026 17:45:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key2.smx header.b=spLc3S/n;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.158, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:CC:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key2.smx;t=1775004336;x=1776213936;bh=TylCwQ8WZDQLwmi7kCeMcL16kko8hAj3uEkkH
	Vljs1M=;b=spLc3S/n4aO21MrxB+C8u+IZPxVMNYbL90DEtoJJiBN0+Gc9ZzCWWxp+jmmJPzPjoRG
	3PWCrW/uOg7TpDUtIFOcXUsu0lgQbRFR1VHciE5eWTih1htq39JqHlSRvHX9pKp6U0KX4KPgijLUK
	zs6J+cZfBjP1zLFH/mK2AB+rLc7Zk877LIJCwbAi7bofWolbcPOQ1iUGbezUpYLOMGn5dkAozGRZC
	YWVv2iP/xteVM/lZDz1+wdW9/esuBWbMJiqToqkVHfrdMu2swGxm4jSnRSxdcFbJeW5PeqIeg3QzQ
	Cxe1wqlWvpa0wA6SfjSloovWgDKKjCmdwbIDUPvaJF5Q==;
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 6310jZno3752900; Wed, 1 Apr 2026 09:45:35 +0900
X-Iguazu-Qid: 2rWhiLDMSC5Ty8LaDx
X-Iguazu-QSIG: v=2; s=0; t=1775004334; q=2rWhiLDMSC5Ty8LaDx; m=g7BEquL9jKVz3fj+ywxNQGGNQxKhGrPMGL3G+f7xPto=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4flmVk16bvz4vyq; Wed,  1 Apr 2026 09:45:34 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hY4mJ5+AjlXEHJlpw4NG9BKQms0li4CuYKsObEOlNZYeMqqznYOZK/MkxfvN659FLw/Gfvfo5HPb6rniMH7gsJOwhFtkhpxJ183uQxq9ip7Z+xFqzykty3+6xlC/+eKkek/A7GoNj4eiaBWtM66jovVWRiOHLOa+jYxwmGdxVJFkDz0ubtPycKk5bSIXds2lrQpUp96wt20mB6vrnwH/TeGeGcbsx0KMoNr7TOO/i4ZfKE/jniAapr8dqHa3urAoYMuXjk9EB/ltinjMdvuBlWxVq5Wo/EMBmfVBtbc7BYBzGkF69hHogXojwUOc+m21I0XcFOqiQZgdOQRpMNHrgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bqks2nArZBEsgq67smTuKjlF5FDcMqYp1iRvSiiD4ak=;
 b=egaZROWhUY/gb0GVi02cmNLWNVvwCuOwjm3BIVljzypcpYt9rfIMS1oVlb8Wvmzm9QJOkWkZB/NsYAErqiRrgw0oRTGCXKgmEL7s+48DI0Zt03H0RtIXNO/+1AzML8xJ4HP/VsUsVU2cGuffG3D/WKR3NDbdzdu45KOc/IocPxi3J58u7slFvDWGtUeqFTXbqprr1dR2uC8qNHC4sA6NjrUDYcxj/RrtZVoSl2ZqGgZo4Yu5is44mWriqDyL6zy4UFGhDkyv/AKemzagfN5heY2QgislGmOTDmd0jPnKteNWIfucQzatIAMoO0lZrAtXeq7V/s+wqypoZrMYXmJjTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <pavel@nabladev.com>, <biju.das.au@gmail.com>
CC: <cip-dev@lists.cip-project.org>, <biju.das.jz@bp.renesas.com>,
        <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [cip-dev] [PATCH 6.1.y-cip 00/39] Add Renesas RZ/G3E RSCI support
Thread-Topic: [cip-dev] [PATCH 6.1.y-cip 00/39] Add Renesas RZ/G3E RSCI
 support
Thread-Index: AQHctf+lrnEHyGO3j0CCOOYHZ0oUSLXHAeUAgAJyacA=
Date: Wed, 1 Apr 2026 00:45:31 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB148184101163C2E0246A08925CD50A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <20260317111718.281633-1-biju.das.jz@bp.renesas.com>
 <acpcChgY6z5s-Z2A@duo.ucw.cz>
In-Reply-To: <acpcChgY6z5s-Z2A@duo.ucw.cz>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|TYCPR01MB8207:EE_
x-ms-office365-filtering-correlation-id: 7926fa39-3ddc-411e-699d-08de8f87fa1c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|1800799024|376014|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: 
 DUWec3WMp6B1uz/1gaSUSlWo0CwDHedtPqknjMDK92sYRLFyAAMMCc0YEZeueDyIrNcZR2P/Jja7JZEPh9WWeOSsapbNh3GZYYGL0azq2oHG11OLvEmG9+gKhRHgGK4x6nLrpqK76L06xYPRb1rLDelQFLp9EhOYWaAvqrAyMfaPozWIKdTo60Qr1ccYgPDpqrRRm6K5JYTDgQPT6gap2mXi11tdfCa/1IaX87BnVB5Yvtd21fKyG5Br1hZIYl7wHvErOA0vM2DZHEo6STuxIdMYWWScgVa5STE3WU7D45bx2DwhN9XRTYahH1KBD4M+sdz08U2n2ziMvhDQ4wwbAOYqVRAdq6QiQsJ7PGSj3KcsFho0SRTAeTxHsi1fv4FQUakS+haw+mm18VzNRKv5ZJVxbCydLdiScEj5JXs4U+yl5A0xCSRl2qisJg/DcPIrVPCHUaAjBfbzAwMsjg20Va0BtrIA9708MZvP4Ehw3irn2lONkWKXLujzRpVcB4phtPUEdQ7am3aMMr9SoBaycq8m+123FnpI3K6XdCrVS/hKoyWqXtK9KKktX86Lak2nl+gJlj0WjypUnO8nHZaTb4w6yhMehc81x/tUMYdYChMvY5w8weJY0+5K9GtbvuK7XlmcfvaaA7ZkWKEsmAsgE9nHF/P4dAYLdlJiJCjqVafKfUz2zCITDofJnh73W7Id0qiMfDOsX6WPyCkAZx9AG/EQrmDqbnVaBDKRj8xOTkVI4bDs7roiYdjMZbnBuqqezwCWgZu4yJAK1KU05f5sMCMgD0hMX7SmzPcyBoUXN+Q=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?ZFYrbW9jR0J6MGNjdUZVNWFLRnVNdjIzOThlaHc0enI0VEFDckdzTVpz?=
 =?iso-2022-jp?B?TGJ3Wm9mNWs1bHl4U2pWM0RveHVPYXQ4V1BaWXFjRGQxTG1vS2NFOWxP?=
 =?iso-2022-jp?B?Y0RUelAxZS9KRkowZ0xITm5rQlcrbHZGUTlXb2NaU0lmYk4zTzJlTGNM?=
 =?iso-2022-jp?B?dm9DS0IvMTNJcmlpUEt2bUJvZCs3OUVZaFFjS1FpK2ExalFOYU45Z0c0?=
 =?iso-2022-jp?B?UlFxT28yQVNUUlM2MVRZbTdDOFNXYy9GSktMd2dHUmtaQlZySEcrdXN5?=
 =?iso-2022-jp?B?K2FpYUZNbmtQZ2V0QnA5MFluRlZaZzk0aC9vclMxR2lrQ3pqMzlHZTdR?=
 =?iso-2022-jp?B?YmVJSnRPU0VrNVVaR1BGU3kwOGNXK0ZwdkUxZ3RRVmo5UGIwZzRJZTZi?=
 =?iso-2022-jp?B?MmprQjJjcXJ6L08zM3FFWGxNa0NxZXVnOEZub2JWUmkxMG11NHo0b0JQ?=
 =?iso-2022-jp?B?RS9neG91Wlk1eDJxcnpOak1MWDZRdzV6VVpzYjVUMWNRb2NRdUN1eFYv?=
 =?iso-2022-jp?B?MzNmZTRLZlQxUWd2TVRlUXVIY3ppbEUxSXgrT1N6d3U2Zm1KdVdwdEZ6?=
 =?iso-2022-jp?B?b3NNWm5GYWx5bUFEa1ZRL01JUEc0ZUlxT3JTbXlSYlJsRWxobTMzNnVh?=
 =?iso-2022-jp?B?Z04ycTIxeTErM0NpVldzdGMyemE3bDlmSHZvZlVnaUxwNG5CRXR2UzRy?=
 =?iso-2022-jp?B?ZGhTeDk3T1hGbXZTaTNvc1JFRUZibU1XaXU0TTdraTlEYVZVcmc1Wm1s?=
 =?iso-2022-jp?B?TUVtQnArZUFHcFlzMkZYRGtpNkNIODNnYlFvM211aDFoOGpBbHlrL3ho?=
 =?iso-2022-jp?B?RXMrKyt1UTVTUXJtTThpQzR5OU9vQ0Z1WXpmTFJSUUZsWWdrVkVtRGZK?=
 =?iso-2022-jp?B?d1BBWE1VbnVlWWtkMGxEQVRnak1kVnlETVB1LzZXa3l2a0l3Ti9qZDVS?=
 =?iso-2022-jp?B?S0xMbmgxZVp6Zmt6SkNuK0t0NWgxcG81UVFnWFJEaWE1NW9sY2lUcTBv?=
 =?iso-2022-jp?B?cTlROW5SSk9XR0R4Ky81ZEdJRmxNTmpRQ20xd0NkeGRTK0hqN2ZDbUN3?=
 =?iso-2022-jp?B?VnRrSUFSN0NuZE44bjRha1lhQWtCbWNmaXVKL0lmOGs2S0NOVE9qdnNH?=
 =?iso-2022-jp?B?cnBNZi9iMDJCZUJTc252bWFIRFQ3N25hVmUxRjMyMWkwUUtUTkRjOGRo?=
 =?iso-2022-jp?B?aHZwMk1uZ1ZKK3pvL3l5Si9WVVVzdTRLbjRLb1RGVE01VjUzN1cvckhI?=
 =?iso-2022-jp?B?OGJCY1B2MDdSSmxDb3FCdEMxYzlYenB2TzVDdHZhbEZ3WHlzKzNkbG4x?=
 =?iso-2022-jp?B?RmdoTjJjc1FQc1pRN213ZkVpcEZDL28xV2x2U0U0eFBDMi9iUVVIUFZC?=
 =?iso-2022-jp?B?aVRHaXpmcm15NFl0R3dZU0FVRSs1dXIwSVZ2d0xvMjloa0JOOEtScjhk?=
 =?iso-2022-jp?B?VHgrQXRETXYrZ1BrakFDNTVqOXBDVERiSGlCRTBEaDRXamVER0pLeDA1?=
 =?iso-2022-jp?B?T2RCbGh6cmNVbS9IZVFWWVpPQi9BTWxnYVYvM2ZDSm84d1NXVVQ3YmR5?=
 =?iso-2022-jp?B?YktLcnJ2MnF5K3NyL0VDaG9RZVgyM2t5RGxkczJ6R3crQ3IvMzBhdnpT?=
 =?iso-2022-jp?B?K3VoRzBNcHI3WEhVNjhuSHFRV3VvVHM5VG5halg0YmxRVEFieFBZbjRh?=
 =?iso-2022-jp?B?TTRadXV3NXg1amVqcXVkVWtaeXE3dlZ0cmRaZld0ckkzaWF6ZDZ6cW90?=
 =?iso-2022-jp?B?aVg2VGt3NWFpUmt5QUc1bDg3VWVuNHI1Q1hvVVNoV3c3d0dQVHpKMjE2?=
 =?iso-2022-jp?B?eVkycXZ0NGljVVFTRlZQY21aWnd6Mm1zL3NKdGdTVTByZmc3ZTNJWXUx?=
 =?iso-2022-jp?B?ay8vQmNyU3QveWNHS0hNZmlKV292Q20rSStVaTNEbmpMQnVhRWIreUo0?=
 =?iso-2022-jp?B?c2hyd2xjZTFUZ3JWN3FUNDcvL1I2TFhLMklCSGVVaStMTExsRi8rcmdO?=
 =?iso-2022-jp?B?K0V6WXNmU1NLUTdjaWFIU2FJYUxKNmdhVWRlamwxMWMxdG56OG9Sb0pC?=
 =?iso-2022-jp?B?OTRUQXNEWjk5QVlycWpxMEI1djYwaitMaXloYk5hY05PWXMvQkxaNEFT?=
 =?iso-2022-jp?B?TitvUWtiRGJGcTBFaTZhRVo2dlQ4dEZZMFdBSGVWNis5MWNKbkF5SUdX?=
 =?iso-2022-jp?B?ZGptdkhvTUdMcXRFbDJMYzNPUHdGN0kxbi85M05FdFhKTFVuM1IwZmV4?=
 =?iso-2022-jp?B?TWMwSk5NRlJzaWszelJINDlWNXlEVkVJMWhYWHo1V2htRUJYTUhYRmJ5?=
 =?iso-2022-jp?B?N3JPWWdrWWltaFRkS2JZSlJyczY3c3VhQW1zTGZyb3kreTY5Zk5NamFD?=
 =?iso-2022-jp?B?ZjZzb1JnVTBhZ3BTcVI1cE1CUUNFUFpRSDRteFUwOVFtY3BYZE11d3pF?=
 =?iso-2022-jp?B?SFZob1FlbnhiRkwzTjRoa290dlRSK0M1aVZhaDdzdGVqaVhSUHNoQWtC?=
 =?iso-2022-jp?B?VDNvVEZ4NkpTS2xSUDlYck5TM21ZQTBJb3dDbVprSFQ4djBTLzNHSkpu?=
 =?iso-2022-jp?B?dlVJd0JYUT0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
	Ez57QAgZctzwbsxVGjNdLThJSi+7JGb3/xIU/QG8hN+yg43vf0QlsPNh+Xp8oEKLEt733xrqhrpevAKEcN7EduAWVjET8zuDHoNoYnkP7hlNePrkxzhSmFHvLuwmOeRASxRKEXQjP1hsBz4MgRKPV+Mq+fusVPgTTz+n27JOQrxIewTLEEnpu0BGGyYLn4dGVnA5AlqB/77UCcd6rjnqMagq+nNTzbuvXEgwr+hj0Zjp9mgXcL0rtm1H2HirZc/gWNcse1xa+dgZNUfBPFi1HUna87BL+SeqMQtcBO3uo8e0beP23U+35umqr/A1YcIPJVnOmlFCZceBuXRfxLB44A==
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7926fa39-3ddc-411e-699d-08de8f87fa1c
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2026 00:45:31.2613
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ierUh953TDg3UFbXCgl4c/OFDhEINYIuUYscNwkcyb4WUy6ARZ7XV+52urIYrpZdYaUp1Rtp8Fo7YQ1LZJwo9hOdjF2WD9H2UC/TSA2PivpnYb/+Z29lPLCTA8tVYqlz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8207
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 01 Apr 2026 00:45:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22608

Hi Pavel,

> -----Original Message-----
> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On Be=
half Of Pavel Machek via lists.cip-project.org
> Sent: Monday, March 30, 2026 8:19 PM
> To: Biju <biju.das.au@gmail.com>
> Cc: cip-dev@lists.cip-project.org; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B=
?.MN=1B(B =1B$B""#D#I#T#C!{#C#P#T=1B(B)
> <nobuhiro.iwamatsu.x90@mail.toshiba>; Pavel Machek <pavel@nabladev.com>; =
Biju Das
> <biju.das.jz@bp.renesas.com>; Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.=
renesas.com>
> Subject: Re: [cip-dev] [PATCH 6.1.y-cip 00/39] Add Renesas RZ/G3E RSCI su=
pport
>=20
> Hi!
>=20
> > From: Biju Das <biju.das.jz@bp.renesas.com>
> >
> > Hi All,
> >
> > Add RZ/G3E RSCI support for FIFO and non-FIFO mode. RSCI IP found on
> > RZ/G3E SoC is similar to one on RZ/T2H, but has 32-stage fifo. RZ/G3E
> > has
> > 6 clocks (5 module clocks + 1 external clock) compared to 3 clocks
> > (2 module clocks + 1 external clock) on RZ/T2H, and it has multiple
> > resets. It has 6 irqs compared to 4 on RZ/T2H. Add support for the
> > hardware flow control.
> >
> > The device RZ/T2H is not present in 6.1, so squashed all the binding
> > patches into single commit that document RZ/G3E RSCI.
> >
> > The set_rtrg() uses field_prep() and later replaced by PREP_MODIFY But
> > field_prep() not present in 6.1. So squashed the commit.
> >
> > Replaced kfifo_*()->uart_circ_*() in rsci_transmit_chars() to make
> > similar implementation with sci_transmit_chars() for fixing tx issue
> > with 6.1 kernel.
>=20
> I will have some minor comments here, but those should be fixed in mainli=
ne, first, so they should not block the merge.
>=20
> Reviewed-by: Pavel Machek <pavel@nabladev.com>

Thank you.
I had forgotten about the issue you reported. It has been included in the l=
atest release.
>=20
> Best regards,
>                                                                 Pavel

Best regards,
  Nobuhiro


