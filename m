Return-Path: <john.madieu.xa@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC08BCCFA04
	for <webhook@archiver.kernel.org>; Tue,  4 Nov 2025 18:26:03 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.38])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.2888.1762280757828952056
 for <cip-dev@lists.cip-project.org>;
 Tue, 04 Nov 2025 10:25:58 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=AcqeoKiF;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.38, mailfrom: john.madieu.xa@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KMmGJJd+CgOVlgjjPmls7DtSQksVrctY3Pu3pTmMtxdewPOVxCMSvIv/u4j4cGr/ecnu+sOE86b7UxTmkJf6MWaZ2T6DmYpooev5n7UuON/kVHvWOBfCgdRVoCmIzaPJM/mXJoCQ3vhnq49oF0kb0O+2zfOk4Ni+x8OGjUGLoNP7h0/bo/ig6TYDTmd6VLtEboDUGb03FPp5XzhRacE1IPFebPAT+q56gGtUcD7sIl0IaLOQXesjQIpWSVBAAQnIoOoTT0wxEGxOAGRnR08yq+zX/BPDUfEQ9ncd3q+oGIjgOtbDsol/I6cCzfHGmO5xnVJfRVrjzvKsBHaLC2240A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rUBwV4QBxfDhFLrTrpYnYH2xN6cHQDPKOOfVfi8/oIo=;
 b=hAB6TdkSV1Q3KeaNUzEfpBCp8od0XGXAH/ONavZzWVbsSZxzHSxHkdTmyRMhPzpI1Fz90S7boZwH/auZuy3bd7wuBGW4DsH294Q/L9jN1tyfRexMDQ1aonEF9bbsDoeq+KWv2ie1wUPF0i2+sKbUsBpp7PeWs09Nds7G7dHsUXlDXleDjFSuqvyNE66iUy853tCOcnoqIg2yOIPNue9waCWJzU9FBXm+txL2kcl9JbTBB1S06lFsfENeGDqny6dXyunWn4WuXaGdvdIN3pZ8frqNPxAzUoPB1TVqRX/IJ3y1R3bBRMusS0msjlqClUM8m60xg3qIl//mdKD3m0mlgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rUBwV4QBxfDhFLrTrpYnYH2xN6cHQDPKOOfVfi8/oIo=;
 b=AcqeoKiFd2e2x9xhOBkHEkz+JBBd+nuWOp/0EVdvow14E1uQjt6CrsV0/1FXqf4cvsMcs8nwmlitWC84U0sHPcV1kSRveYy5zXbzL2A32BfMUxwvrWZjKAKq45pbCT1t52R4iin2rrLwq3kv0dv36CdC/1D/9KmOUgcP7fEKsHY=
Received: from OS9PR01MB16368.jpnprd01.prod.outlook.com (2603:1096:604:2b8::6)
 by TYYPR01MB12451.jpnprd01.prod.outlook.com (2603:1096:405:f6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Tue, 4 Nov
 2025 18:25:53 +0000
Received: from OS9PR01MB16368.jpnprd01.prod.outlook.com
 ([fe80::69fe:a6bb:3371:3f0c]) by OS9PR01MB16368.jpnprd01.prod.outlook.com
 ([fe80::69fe:a6bb:3371:3f0c%7]) with mapi id 15.20.9298.007; Tue, 4 Nov 2025
 18:25:53 +0000
From: John Madieu <john.madieu.xa@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Nobuhiro
 Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: RE: [PATCH 6.12.y-cip 19/22] net: stmmac: Add DWMAC glue layer for
 Renesas GBETH
Thread-Topic: [PATCH 6.12.y-cip 19/22] net: stmmac: Add DWMAC glue layer for
 Renesas GBETH
Thread-Index: AQHcTYjo5DbmigVP90CT69yNX1/OILTi1Yxw
Date: Tue, 4 Nov 2025 18:25:53 +0000
Message-ID: 
 <OS9PR01MB163685666B9EC05213D4BD7C2FFC4A@OS9PR01MB16368.jpnprd01.prod.outlook.com>
References: <20251103113817.36331-1-john.madieu.xa@bp.renesas.com>
 <20251103113817.36331-20-john.madieu.xa@bp.renesas.com>
 <aQn1YhAeLQvfPwKU@duo.ucw.cz>
In-Reply-To: <aQn1YhAeLQvfPwKU@duo.ucw.cz>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS9PR01MB16368:EE_|TYYPR01MB12451:EE_
x-ms-office365-filtering-correlation-id: 6af3cd84-af45-4d1c-2b03-08de1bcf96cb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?7PDCfQJqUP8cQwvfK31S1lo1gtCbAxvjH/mYuwkVn8H5uknDHUlxQyKBnW64?=
 =?us-ascii?Q?hjMC+cltaQ+1SxJa2UH1yik3OCWaHjV7pyPOFq4LuiJQethmUptLLvioYAFR?=
 =?us-ascii?Q?Rxu49hLmeuTfHBqL6I3V7B1L+iUfaFl6wYt9PAc7HJOH3TmdUftKI2DNCEDz?=
 =?us-ascii?Q?XXTGswfUfZHoDDLW2QtJaQ2Gxm69MZQtAYcg8C6e09g5DvBbPfQCRV+sIJBS?=
 =?us-ascii?Q?pzUeR0iCg9ARJogZHHuW9Dtzbb3i5a0Ld77AM7v7NP0MVJa/gGV1m2z83cBQ?=
 =?us-ascii?Q?N/SjE7bMSYOsJqkrJyoHglvhIUF3V7u0x9UcnuD7JNRtqezCl0ECpkwKWQCy?=
 =?us-ascii?Q?ahAH6rECSRHyqcnfF+6h9mgVBZH6/Ph4neR7QkGayeJwCQ0Ew4964JWq8j8F?=
 =?us-ascii?Q?uSt1jii/B9+wkzhaT43lAP+LHDu95X0w/AHAQGqoe3Wu+7qjHJmIucauWmX6?=
 =?us-ascii?Q?PQ361Gf/EAnz+ivkfo7HiFNB/wSgaadfzhLJamDEGLwvCmUC6hV4Kmf33WdO?=
 =?us-ascii?Q?zRPrgSHgTVpwWeiauSBNsGb71I92bOs/9mMLdkYFWUkSlmiBFdnYs//a4FbW?=
 =?us-ascii?Q?2Yk2e4dEV+pL36kXsgi0JDh0RMGL7LU+ltRI6UtQhcHmKUg+fhXEGPSpxBrV?=
 =?us-ascii?Q?BkKYh5Wsb8aRGhizia9MX0hDKX+ByluwX6RTb56bkTodNNE0X/3lWYSuBlCx?=
 =?us-ascii?Q?RV5ztGh8g1veRS+zzKcQyzFPzd+eU1EhqxrIyyFlL1W0+OEyXfROmcVkyV6/?=
 =?us-ascii?Q?hpH6wWrId6YMjxlKR2BcrsasaZrIIsxXjec/7B87A4OJMniU9379ZlwgPL7A?=
 =?us-ascii?Q?CmNH/zDPYx/nqYcYQgORhfHv/XlYlEJMNowzRKgthUlw6mv6NXJXH4/UXVYM?=
 =?us-ascii?Q?HQFu0Sqdp+Toxuk5jzRnYFgK6DIDTEe0T/8O3b30HVhLfr4hcVwZjYppcGCs?=
 =?us-ascii?Q?gHAqZfuQGdDHX76aE4g/wDXCsMazl60LVTq0AqbbQt3yTyVH7kdgGFZhKzrY?=
 =?us-ascii?Q?at2l+AGp1C6cH2y8oI7fA1hE+OESd/X5piAnqudl/9VX0eDvrx5VbAeVTWgI?=
 =?us-ascii?Q?yaFvmmOI1oYOd4Mz2eVRbXGNzMXDpikfLT5dP61tsb1vJVQ+S1PtdxpmxQ9m?=
 =?us-ascii?Q?yDTaKp0PHukHbaABKrhqsT9P40WcQNpe6T5Dah0RvfzV2qeFH4jisBl2GyfG?=
 =?us-ascii?Q?8+xFMxB22DUjBjZfb9RjNRz+djek27cru7stsEr25kyowtu63TIjZRXSssIv?=
 =?us-ascii?Q?lGBTGH3XhYSeNbzW0CZi0OCu5q0MolPlj39d0fUiKp0b2cwV2BYkGSOZ7Lp9?=
 =?us-ascii?Q?ASBz13Fy9xuKqBIgIMiZOpnCyYOom9X5TU/fSiyZHg5JSORvpw/RmXeJ9GIq?=
 =?us-ascii?Q?KSTKpEW8ULS72brNJGl8/9A5abwqybpC8FsH6eV4wKNApjPPE0SG3Ir6XgFs?=
 =?us-ascii?Q?2YuDW+ARn+L/3ZzF28cZ28Aquuo1m95Q9cA0x5SnaPw04L2E3YAYAIQmXRsk?=
 =?us-ascii?Q?kPdvi17zRUXT34U8cauUro2KipcS8Ux0+9wB?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB16368.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?Lxm57ghiNzq39rzXVktEyRrUafAd5qf9aMaI2stLA2jimQAoKnzJkgCkiEst?=
 =?us-ascii?Q?opJU0a021vhRhxZqnana0kFbjc7/RHg9hnLb4XNllFhgDWu+QBVVAYpaHGi7?=
 =?us-ascii?Q?menNwmQPFK1eZlsYeG8748QBUSBZf5pXYioAOlYBM84XU017VpCQT0N/yv6V?=
 =?us-ascii?Q?sHEJTCoVjeABnrXyfIukrnjCx1dPBZKivWMXAITRlBClXMARpAyn0nGpvkX2?=
 =?us-ascii?Q?LNycYBnmXxoR8sNrbQNzTbne7e5mAQfJSzBVC8QwBL6lnjhZ632SJL0QH9Tb?=
 =?us-ascii?Q?tps3IZAABcio6RRHzdRzawbQfjJFyt6YplKoDXlEvu+nxQXsJB7EJ3jmJTGY?=
 =?us-ascii?Q?8Oe7z1qsUUMjdRg0uCRKkn3j/vZnUzk2r7qVVQGRb5GlkhsM6A2bSyN0TH5B?=
 =?us-ascii?Q?J30RsmovB+VOPmyOBEOhPnkuVKiQVyzik4q4BGLkXs3X6WhKkJ0Jw5zpmike?=
 =?us-ascii?Q?JKKjyr+gPiLOz84PJ8AqM914U16R0TV2TanUZLDO9mT21KKvmTk0BSV389VL?=
 =?us-ascii?Q?j6vgi4aMJ5Oi9Oq39DXSH0Gxn7G9p1+ZrIGdFSP3A5L8HzWZPhCcSgiTrBaS?=
 =?us-ascii?Q?O6VbCaB0sflzSbRBZKvbg6yySYu4l2dMHNm6iZ6YuiKtPGTDU4MvtuK/1NzM?=
 =?us-ascii?Q?2NyFG75WXmD5yprnQ73EhXTkCTfIQZYmQxsymiEX9/Oxp3qTNRHH31PuvPBC?=
 =?us-ascii?Q?QdX0w+ddTOWRvV0VV2I+rz/Z3L4SqNn1adTgLvye9X8ELvLK8TZrePH/cj4z?=
 =?us-ascii?Q?cmNlrB7viKfR38MFwCR266HLamb01Wtycec98tegMI3ZCxvy36/O+lvnnG9W?=
 =?us-ascii?Q?adQp1f2FYkTgthowOJwn7nYUI04yTvSYNmAtlpGNyhtHIiy7Oo9xuz1CVmOS?=
 =?us-ascii?Q?GkTE2Bd3EMBtH7vjL8IzuJKHbQZn1/WfLeqj2qBoqgTiblZ66YqX7MpbTuGM?=
 =?us-ascii?Q?wnp8z4M8q/MBeACNOfVB6F+OJPuHklIQCGFbYwyQr1o520lxNOEbBSkBpRh9?=
 =?us-ascii?Q?wgzx3fEzbPl8buqJSANe/NpxPr/9j54x/vBmg7Vvl0JOu8Kbb1Tm9BGJCctX?=
 =?us-ascii?Q?nKqFhDvPtHtdSBiGk/rztkNKR4+yZEd/fCEmf596B1FL1kuSvRGpqfoALOQc?=
 =?us-ascii?Q?uKnqjszuujzz1NFEt04c5CZmSwzcex4WYzeU+XggmUwzN147moIXDXXVZcit?=
 =?us-ascii?Q?KtNY73OiqHtlinY3ZXV+dESXDvPMtLydd76hfQ29dQNLb0FQKIyci5wWvw07?=
 =?us-ascii?Q?wfZmbcRjaMqenzLu5ZcPIuhHjVv5qe/YP6CKmc6Z/ASq/PFXZHJTf57dJYGq?=
 =?us-ascii?Q?th+g1BcaVqPTb9tC60hi3yLBinCfKRLUJJDWwUgmPthrgUmu0zELEFsNqDki?=
 =?us-ascii?Q?taojVY20taL67geSkx5E+1FWW84Y+goSRAJx3WGBRXpAK2QWuOxN6A8zaeJ7?=
 =?us-ascii?Q?5JHrsq2qJ3F0dNsNhzzFP6iO1WlM3vIoaUnb3o+03hpo3Jr8m9U/hCHUxxHR?=
 =?us-ascii?Q?11i5jF0QPgDz3qrRx58lpdZVksaluGxQwcIvAfjR0yATH7lkPDKqlUDibDKz?=
 =?us-ascii?Q?puojBsQqCVp0VG+dXW1Sz/nZDNCzrsSNwCEobvccPuvoKrx3t+fho0Kmlm2i?=
 =?us-ascii?Q?xg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB16368.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6af3cd84-af45-4d1c-2b03-08de1bcf96cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2025 18:25:53.4829
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3RPDCfLBbbCSgLS7V41CQD8MxyGyW2UWrADEdsfnYHr1s3mIR9acOmDVqkkTWqivdje8KlUTTkhHQg+64Rw0JL/AcFzNia1aUCqfeRUbtGI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB12451
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 04 Nov 2025 18:26:03 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20354

Hi Pavel,
Thanks for the review.

> -----Original Message-----
> From: Pavel Machek <pavel@denx.de>
> Sent: Tuesday, November 4, 2025 1:45 PM
> To: John Madieu <john.madieu.xa@bp.renesas.com>
> Cc: cip-dev@lists.cip-project.org; Nobuhiro Iwamatsu
> <nobuhiro1.iwamatsu@toshiba.co.jp>
> Subject: Re: [PATCH 6.12.y-cip 19/22] net: stmmac: Add DWMAC glue layer
> for Renesas GBETH
>=20
> Hi!
>=20
> > [ Upstream commit 461f6529e5946d98ef91bf115d5ced61d8439a6a ]
> >
> > Add the DWMAC glue layer for the GBETH IP found in the Renesas
> > RZ/V2H(P) SoC.
>=20
> > @@ -131,6 +131,17 @@ config DWMAC_QCOM_ETHQOS
> >  	  This selects the Qualcomm ETHQOS glue layer support for the
> >  	  stmmac device driver.
> >
> > +config DWMAC_RENESAS_GBETH
> > +	tristate "Renesas RZ/V2H(P) GBETH support"
> > +	default ARCH_RENESAS
> > +	depends on OF && (ARCH_RENESAS || COMPILE_TEST)
> > +	help
> > +	  Support for Gigabit Ethernet Interface (GBETH) on Renesas
> > +	  RZ/V2H(P) SoCs.
> > +
> > +	  This selects the Renesas RZ/V2H(P) Soc specific glue layer
> support
> > +	  for the stmmac device driver.
> > +
>=20
> I believe "Soc specific" -> "SoC specific" should be done for
> consistency.
>=20
Indeed, thanks for pointing it. This will be fixed upstream and then
backported.

> Best regards,
Regards,
John.

> 								Pavel
> --
> In cooperation with DENX Software Engineering GmbH, HRB 165235 Munich,
> Office: Kirchenstr.5, D-82194 Groebenzell, Germany

