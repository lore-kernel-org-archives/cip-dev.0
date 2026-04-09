Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFED8E98FA9
	for <webhook@archiver.kernel.org>; Thu,  9 Apr 2026 04:22:18 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.124956.1775708535097462705
 for <cip-dev@lists.cip-project.org>;
 Wed, 08 Apr 2026 21:22:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key2.smx header.b=M/69P0hp;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.158, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:CC:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key2.smx;t=1775708532;x=1776918132;bh=YpX4u+oQSgxR0tkCLdiFJdyBze+F6xNEE4H54
	q3uECM=;b=M/69P0hpK/q7moMHHDpuse4UKzjbCwrxrxhHsVedVguC9VR78uxUp7+rrW62rfytjp5
	Yu39Y7EKoMxtU+CPfu5K6rFCyPGzzE2VWc6uAXaXFUAoGuMlXukfuhEA3NvM0JYJ7q+lWZsvLYruP
	5jR0tsKL7AFMBZ5flqsTR9WuxLf0uh7+L0XtM1O78z15yHMSzOW7jpy+EdyQrcWCGLWcnhR01pzpN
	KzC7Av2OExm17vnXmGzqa7Zr/P7zZnClCMDlmnzZKuDFGwtUOuW6X21mXUOys/EmYX54IUB7FyJwO
	8nbiU5Tc/GH/AozPpeBN5taIOc/z5nbDpwNY7gmx62xg==;
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 6394MC1O2961022; Thu, 9 Apr 2026 13:22:12 +0900
X-Iguazu-Qid: 2rWhiLDMSPwK7LEDNy
X-Iguazu-QSIG: v=2; s=0; t=1775708532; q=2rWhiLDMSPwK7LEDNy; m=jU8N/gbQ9s0ilmY64gT4NPlouXHc28y1jhbrGxPwCdM=
Received: from imx12-a.toshiba.co.jp (unknown [38.106.60.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4frmx004T7z1xnZ; Thu,  9 Apr 2026 13:22:11 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZiOzwiMvN5o533mjS7jM0taefYm9gPHyMaK+3Hm1qriO3/GwnlqSD4n4m309RYjRyAxe09L9ceOiceBMgW/7twkOVZqqmKNiYYwLfvd65bemq6I3Xnh/hiQjxn15u7naOQyKGeIAPae3Acn60ZOp+Ovt+eZXBu+QsR6/todmriX4+GYDVn2ArEZzppEpJCVb+7rxGKR7jAOB21dqAMosDjiq+P9Ec9MWl2yT1bIqpcPm53izefkbOTOieBDytE/oaioTTZ9VEeAHsWsZMSXcEIjpa3jJ4cwv6ulArSB7dElG2INP/A8E07Mi4YJ2OC9F7z7bKFHSfZJEHKl6Bs4OHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3nyasn8P8tEvtJwvP/f4FM2tTIkc5zCrLgThxVTtB8I=;
 b=u132822fOX/uiFsSizMR/E0k35l81A34n4a/wYicMgWpSIz7RvEoa9lZP6S5XsWfyywJwssDLHaQNSEdJO2fH2ipyzBVjj0Zn1h9cIIw61HqAYtYLn7+rE7f+TYlfUn+L8aTp7dAwWxYnjvX79gxQKsgReMManiMnA+h4i8dxC4t6VDKo3NAJnFE/IBpEmBiCSX5q1ty47CdhDErWWZkGTBWs1jRm1Q8vZ4/pvqxY4+u9COdnyxNu4c/l2PyCK9OI9QXBl6rXF6+bfPMrNgnUR5KulGCXZUmSWpfvHppV0tkJoDqGigEs8eWeAIYnhGDkGnTY/XFOVWq4DmgJKyrXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <pavel@nabladev.com>, <ovidiu.panait.rb@renesas.com>
CC: <cip-dev@lists.cip-project.org>
Subject: RE: [cip-dev] [PATCH 6.12.y-cip 0/7] Add RZ/V2N TSU support
Thread-Topic: [cip-dev] [PATCH 6.12.y-cip 0/7] Add RZ/V2N TSU support
Thread-Index: AQHcxzv0CwWR+M+o9kaY+V09kTR307XU/CaAgAEmJQA=
Date: Thu, 9 Apr 2026 04:22:09 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB14818EFC2211CB8FA466E754BCD582@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <20260408094150.66941-1-ovidiu.panait.rb@renesas.com>
 <adYynUqP_N4K2CfJ@duo.ucw.cz>
In-Reply-To: <adYynUqP_N4K2CfJ@duo.ucw.cz>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|TYRPR01MB12724:EE_
x-ms-office365-filtering-correlation-id: 245bff6b-0651-4ccc-5995-08de95ef9107
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|376014|366016|22082099003|56012099003|38070700021|18002099003;
x-microsoft-antispam-message-info: 
 SnKDWtCjjoHK4vSFbfSzoAOyAGapZZ2EEA646nMwyKprD3hyR82pqy7h3AAPPMX8MUHptS2+eEDaWAJzWAtMyIiVmx8F30bAIo9GBeJ+1GBFaJ7SBZp+OKW1mGGMYB2045D4GRfg0OrEsSwwGC11c6bzG8/h+hNYb8M25+zuoxC3wpHIQYXlE81lNPBLQXNdIfv+X6dfLm5BLTuz41YrIlblJ8/en2a3QYcOtv6NJslVcEnEYh8zA4mCadNtXCnVBXNK679vy0F81W6zUhFYB6p9G64gtxOE3NC455N6cmo8vYwsWLNtowmvLEcRMG6JFXguP6SoCD7QaXMF7pDuWTuQUiKmQ28+OS8UFEySrdJmKwYIiz3WcnwEj8/pb0FrKu3lqHzpifdNiLuxxgtkA1cOfS1h2h64iUywNortC5Z2z1jiOO3ohzPpHFb8A53MSczorF5fABIrtLe2sIZFGSrgZC6xG4ta+SIdztMY648S37BTDw3fSmRqj7EF9twBbHTpf1KmqRjy2hVIAhVRrtIsQK3fKpF1znDoCcvAY9ce66laXwCKZH/fRerDpugCzdNMuKLN5GppDLVxlfSpWKcIzBk276pyg0BM+HxxbZw5F6ZxtL0GIFq0SRlm++JXThsRNLPWnz1wubh+AGNMaVBMaqy/YC5jHjZYMejmFdVQfMnQtUllMpvLcqCpX6fczwUBDI1tk26amPBN31XRBAIdvdlULsZTImSL1S/EmacpFNJlFf5XVy0Wk51poqOllpa55JUJnr2NQw1wnxGFAMWBRU/SwfcCbTRdNAjjqHs=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(22082099003)(56012099003)(38070700021)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?OThzQTB5eHhTM0srL0VqbFl3L1VQYVdLV2crdXN3b3l4d1ZhbmxlWmFX?=
 =?iso-2022-jp?B?Mml3KytaWXJkWlVGZ0ljNlVhd0g0WkVrMUZoVll0YklQcmYrT09iMW1L?=
 =?iso-2022-jp?B?MFBEa25KRXBYalo5dlYvRnNrUi9lK21xVDZpbndEZTdMTFg5RFRqRTll?=
 =?iso-2022-jp?B?dE9iSHVIQUd4MGp3aFp4K0hFWSt4aVk2ekVWb0dWOGw0dFBERDREbXFx?=
 =?iso-2022-jp?B?b0NmNk5odEIyY2hBb080d1ROcUVBOVBHbDdEcGpUdStNVm9ETzgySVpa?=
 =?iso-2022-jp?B?c1dJOTdETmRUdFREclE4MlZncEw5N2hwa2NBM2x5VW9NV1pmaEJSalFC?=
 =?iso-2022-jp?B?WW5oNG91TlVpUzM1Wk5ESHZaNDVGQ2x0UVIwNDNNYUFESHNqV2pUU0tr?=
 =?iso-2022-jp?B?bVR5VFJuaStwaU0zaFFpOEhxSmFzNDhrWDBLTG1RcVg2R2tSamNPd0RS?=
 =?iso-2022-jp?B?UnBoS1JmZUxLbUN3TVdCeFFCSGF4ZTM1WnVjMmlkVVdaMm1TVk91SkUy?=
 =?iso-2022-jp?B?WnczeW9xWFMwQ2tUZzFYMUttbk5MQk1BQ2pGUWI5Y3hCcXFTQ0dnbFlK?=
 =?iso-2022-jp?B?bWZEaU9ZalRYd1VnSXRucFpVN0VsZ3pCcmJUTmpIZEo2bG5EVTQrZ245?=
 =?iso-2022-jp?B?NWg1S0VUY1NXS1FVYWJtKzVKOWFmN3U5aDVqTFJGR1RhdWNHS2lFaDFQ?=
 =?iso-2022-jp?B?UDlEWVRMSmFIbzZQV2Jsak95RVY1d2tXRjBFci83dVYvQUFsL0VUZE9a?=
 =?iso-2022-jp?B?cWcrUnhsZFFHWEtVMjUzSC9LNlQ5N09OeENkYkMrSE9zSnp4bk45VytJ?=
 =?iso-2022-jp?B?UXN4eTBIeUFzdXVrRElnMVkzVGNJU1c5MlMvMUF1NmtOSkhJVE9RVFNr?=
 =?iso-2022-jp?B?dytLQnVuYUdQMHdDQ3VyK1pyS1phMEljR05XZnVpTWlkVkZGMlRtRW0z?=
 =?iso-2022-jp?B?aWVGNDRIRHRxSkNXa0xiUENqMEdQcXF4TnhMbTJHT3NLbWl6bHpsTjVa?=
 =?iso-2022-jp?B?QUFsTmNpQVRWYXBycUd3UFpkbjZhNnRXcTdqM2J0TldqUEZwRjdqT3JG?=
 =?iso-2022-jp?B?OWloMVZ5RmdhemZsK2kvQVNoUkZ5TE1mQ1A3WmpSZSt4UkZXcFVBRU9N?=
 =?iso-2022-jp?B?c0FOMC9mSVlwNjhSZ3RZY2tQZVlMQmF1aDNZOC9WYWdzNXZkM2xpRnBh?=
 =?iso-2022-jp?B?bVVHMXFDU3dOTzFtdDZ6d2E1SW1QNEQwcGtDM09iZUg2NUIxazZMN3BN?=
 =?iso-2022-jp?B?aWZ0RUw4S2N4SlRMSVFWR2dwSmJEbDNLVkg2ZCtQQ29tSlI4R0FRaGNQ?=
 =?iso-2022-jp?B?SnZQR0drc3laQzk4SWZOd3VybWNEVTFIU1dlL3VpcFJMZVZpcUZ1RGNC?=
 =?iso-2022-jp?B?OENZbE1BMVpBZmpQWVBla2M0RXZSVFUwM1ZVTEVjaUhYbm95NE1aN3V0?=
 =?iso-2022-jp?B?MjQxc0wxUW8vV1ZkQml6MEZXMk1SY2dvTzF2cnJQRnJEZGFLMWVaSW1L?=
 =?iso-2022-jp?B?a1pYdk4zYXdBVm1QTFdIWW82OVF2V2ZrU3NVd3BQeU4zNjlHT0NRZFRy?=
 =?iso-2022-jp?B?WXBIQVVEaUcyRGZRcjdRN3g0d2FHQ3FPUUwwZXlROUVRSWlXWTVEYnFk?=
 =?iso-2022-jp?B?b0ViejN4cERTTHRGSzZkTXJwd0hycTNpVm90RTIxelpZL2c4YVYrbHYx?=
 =?iso-2022-jp?B?QzZ3Z0tPVENOS3RWYk95ZTQxZWdSZHlCZFB2SG8zenJST2tuNWxUejl1?=
 =?iso-2022-jp?B?OUFoRFYvbFEwZTdlRWJuZGVEdDV3ekE0cEdMMEdEVnRQSkVUTU9Zbnp5?=
 =?iso-2022-jp?B?Y3B5YzJVT25CaE1UUGxNcE5lM2ViSmwzdDAxTkMvN2s2NnViVnNnNGVP?=
 =?iso-2022-jp?B?VTExZ1FtYUZyeUppU01rLzRpUCtMcnRXTWFhSTF1WmVhVXVjV0wyU2w1?=
 =?iso-2022-jp?B?blZQVGR0eWdLYTVkMTN0TFp6SmpqUmxEcklUSk9WVm9uYm5WdUFackNK?=
 =?iso-2022-jp?B?VGpmWVMwMnhmc1BFcWYvYnVrdVZld2NYN3hFTUlzVXVkdmRKU1NoUHUz?=
 =?iso-2022-jp?B?cExHNThXdzI2bzU5eEt6T3lDZUxQaWwvMkNNbVJXcUFTbFBsOFUvR0tI?=
 =?iso-2022-jp?B?azZGUjVVallTRklCTEp4MHVTWUJBcFBhYmlSN3VmQUhxVVQ1SFhYQlhn?=
 =?iso-2022-jp?B?VlVhY3dOQmxTQ3oranRLUkkwM3Vob3pISjM1eFNicXgzeWE1RUJDWmtS?=
 =?iso-2022-jp?B?MDIwbnZxN1g4N1NNb1ZJcWh0ZGZBYmR3cWxaWFpLbGVNRGticUs4R0JZ?=
 =?iso-2022-jp?B?aGZ1aW45eGZQdjQzWnhWYk14OVZTVWdrQ3o3TWZZQXZNRzdGcEp1VEJm?=
 =?iso-2022-jp?B?TDI2MTNyYWV6Rmk3QkwyUXZvZ1BOQW4zMEZFd0FhRzVmam9rZ0NMclRM?=
 =?iso-2022-jp?B?VlZkaDRyZ1VuL2ZPTUh4QkticEVvSm5MNWd2SzFvOVMvckV6NXdRb25M?=
 =?iso-2022-jp?B?cm5ReTdwSWtPM1EyeWRkbWVpNkU5blBmaVlIejRyVHJMQkNvZFRZaU5v?=
 =?iso-2022-jp?B?b2h5b0Ftaz0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
	SAzNjyGAJ231qVjKLWlckYaXJAKiykuiLFyQPG9lJGtC5GsgvPZa4ZWSxQ7ERueYukXUGkpLgcMejzcf8vk8uBIafvXdENAZ96oQnA1q/Vm8KGF4cYFL2nP7Ks8Z2N/1pCpSRGINMp7PomQruMRTpZvj+jQF4toWKc5VTmDx1pU1i8k99fhs5rEvtdkDy/NpNSftOKfOK4cJ8kxw6vdayw+mqfV8jax4zPW+UNpVPfFlQgCWIOHM7KQ6CwjuRhaRQIq8XfxMhEhdeOfBLja1P4EBvxwag9yD8KS5NrbPlEOY9DgTeZHFFM4SnniQTTL441lt49k2t2dSPX4yRw8ssg==
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 245bff6b-0651-4ccc-5995-08de95ef9107
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2026 04:22:09.4933
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pkTOv/x1j3Du3jopejzVT9YBIiTyrVNoXDlqmrwl1okZ8h1tHSBeIimuTb3uOezuTg6vRy/xU69KAaO0L7/dShW20ATV6xCFnkkurnDuW84Y1DlqeDD54Rp3BbzgWeQ3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB12724
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 09 Apr 2026 04:22:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22657

Hi all,

> -----Original Message-----
> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On Be=
half Of Pavel Machek via lists.cip-project.org
> Sent: Wednesday, April 8, 2026 7:49 PM
> To: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
> Cc: cip-dev@lists.cip-project.org; pavel@nabladev.com; iwamatsu nobuhiro(=
=1B$B4d>>=1B(B =1B$B?.MN=1B(B =1B$B""#D#I#T#C!{#C#P#T=1B(B)
> <nobuhiro.iwamatsu.x90@mail.toshiba>
> Subject: Re: [cip-dev] [PATCH 6.12.y-cip 0/7] Add RZ/V2N TSU support
>=20
> Hi!
>=20
> > This series adds TSU support for the Renesas RZ/V2N SoC.
> >
> > All patches, except for patches 4/7 and 6/7, were cherry-picked from
> > mainline kernel.
> >
> > The RZ/V2H binding patch (1/7) was missed during RZ/V2H TSU
> > backporting, so it was added in this series.
> >
> > Patch 4/7 is needed to fix asynchronous aborts during unbind. See the
> > MSTOP series for more details:
> > https://lore.kernel.org/cip-dev/20260115083451.1064048-1-claudiu.bezne
> > a.uj@bp.renesas.com/
> >
> > Patch 6/7 is a backport specific change that is needed to allow the
> > thermal driver to read calibration data from the system controller.
>=20
> This looks okay to me.
>=20
> Reviewed-by: Pavel Machek <pavel@nabladev.com>
>=20
> I can apply the series if it passes testing and there are no other commen=
ts.

I reviewed this series, looks good to me too.
I applied with Pavel's reviewed-by tag.

>=20
> Best regards,

>                                                                 Pavel

Best regards,
  Nobuhiro


