Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C323C36014
	for <webhook@archiver.kernel.org>; Tue,  1 Apr 2025 10:38:51 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.13])
 by mx.groups.io with SMTP id smtpd.web11.15753.1743503930025121189
 for <cip-dev@lists.cip-project.org>;
 Tue, 01 Apr 2025 03:38:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=PvVRqJbj;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.13, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=auKZnEtuuMuralgENM3lG7kQjgWS//O3Of5823rwEl55lBoqdEsffWVlYki3bm0SLlBmBMzC26b5h85JmMDpahBRkHFLZX1GVNI/JAtFmYGLbxhQQ1+maP+7SDXfGnI2Dh31eRWXVE4Y8pPGlgSPI+XZ+JnCAOQ0Yb5KxCQMd9jjahKH23P1+ZEjvBRAkPl58NKymjGHBpfES2XAj5YWZwkdCkAS1iXDzWjB+AizxrrUonNeX9moN6MDonQXgxoPvmCY/VBsLgRFCVxyFjzMG8YVKIfNV5owG2yZrOEVO7BKnTGqVFA4JwmnWyEtSTOp8U4cN7HHTZeWY3nyCOsgXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4aKr3umndHD5SVmcnajMiWMQ7/PeFkd2muFZB06h+M4=;
 b=gHvkuEW90kJNx94zL5MlIob/UEpnV4b4HnhC0EZhGhIHVo/0ZX7+u7JJiAQjbM1hG2R/5zFC55jhaCetp6meeMhih2umVcPQipbJgyS7ygOmy/FxK2ViFhbVKixENH9B1VrzrfwoFW5y6N6ALb5/rb40oDvkPUPR0pDTLExFeb6OM9TOt4h4+d65Fx4EQc0yYptb3+SbOshJ12NpBlGut2wgA11jgROO0+2MZKVpBmPsgmSBb5GMAtifGSSfQQh0XWcTxZswAnkGWAQ48zjwEAPE+mWfz3hLJ6C3W5IMUy1uEMlkGadK6yX5jAAaJulhgDdQCqs3Lhf2QmjXXsC7eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4aKr3umndHD5SVmcnajMiWMQ7/PeFkd2muFZB06h+M4=;
 b=PvVRqJbjLBN1WQXpA4iPwhhg6SdqY3icIE2SMbvdzQAw6/bh/si1uR86SMmTs7eNfpvLumZPSB2zd2eARnArUrj5Vm/7HoHjhPmh4myJfaz3YY5C1hQ2OzUjG5xsX6fkyMe5TRZPNDYlUG7U4Qm41m4Dzd5ywTyy3tuGtN7adVI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by OS9PR01MB14077.jpnprd01.prod.outlook.com (2603:1096:604:35e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.39; Tue, 1 Apr
 2025 10:38:38 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8583.038; Tue, 1 Apr 2025
 10:38:38 +0000
Date: Tue, 1 Apr 2025 12:38:21 +0200
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: Re: [PATCH 6.12.y-cip 05/13] pinctrl: renesas: rzg2l: Move
 RZG2L_SINGLE_PIN definition to top of the file
Message-ID: <Z-vCHQYcAsz_clJr@tom-desktop>
References: <20250331110659.252237-1-tommaso.merciai.xr@bp.renesas.com>
 <20250331110659.252237-6-tommaso.merciai.xr@bp.renesas.com>
 <Z+u/S2MaYNST5kNl@duo.ucw.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z+u/S2MaYNST5kNl@duo.ucw.cz>
X-ClientProxiedBy: FR4P281CA0184.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ca::19) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|OS9PR01MB14077:EE_
X-MS-Office365-Filtering-Correlation-Id: fb9de703-8c39-4c29-dcd0-08dd71095c91
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|52116014|366016|1800799024|376014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?R2dr32RE6rgbk7BPt04o2UOBJWWJ8XoYcWWwtZ6AAhfSkVt77r0foFh42ND7?=
 =?us-ascii?Q?OQPfirD9ZvPNmMs7YjrENfDieVsKvnxKAn5of4xiG/8aKYYVMHSwiq5KYSm6?=
 =?us-ascii?Q?1AAXqRSRM8OuRV3FNVuyosHLiNaKrhE6xcPhr/rZPGpa71rTJRA/3egxlP2S?=
 =?us-ascii?Q?Y2gid04IsNRo3GCeGPw92yncbYLpO3Lr7eCRq/shRFIhWwQ/lHVQe2VXTkKB?=
 =?us-ascii?Q?65+EUKoSc9a9a4Wfd/O730tp089f6Qz4bKg860DLnYZ8BKr7CkyvHYkECOEe?=
 =?us-ascii?Q?UmwsAfaGboV8qmYeBSunna9LVp4I+5SvtY4Xn8MfbmLwKZhMeGEHv0wRMYlb?=
 =?us-ascii?Q?PZQ1tc5xezll/Q5A7vUaimxXczEgICTBnfygJE/OYLGlJxPQcyPtecZjmZdy?=
 =?us-ascii?Q?eESu4sJC0jsvkjV+7elMRTb0HlRB7NBoG23Kady3txTE6OrUnXkdVQ+lViSL?=
 =?us-ascii?Q?XiRoRBBieabLekZU9VeqlR2VpBKnrY7tCtAS7t/AE5HCK3yueB7xAEN6m0k0?=
 =?us-ascii?Q?VN9slSx7b8qUaMgh9Wb27i85IpgD6wWxkzpuSGMIp+TjMDlGL4+gEyGAzwqk?=
 =?us-ascii?Q?gWMmVgzcKc/S8g5we7X9X98B77PR8H86BZ+lDD3DcRzMGiTjLgbf2z8VfT2N?=
 =?us-ascii?Q?Sfg4Q8isNIZYX5GzY+CQax8Yc1k+CvA1lY/eaYbIp4D5YoaKuYhckekPMP/P?=
 =?us-ascii?Q?0Rcck/gR51StIgjsIjj/OH4TcX57gpaSKMPuJciq3ci9s8xo6ipnuoOkcTvA?=
 =?us-ascii?Q?bnXAVSWOPTE0o4JuOt2flFhg0harXMfKUBVir9lCrf6AT3oLX32qjLC3+pw1?=
 =?us-ascii?Q?Wz/M8+EtaTr2VHqmUiMFHAjqv3Pa2Alqhv7ucrO7ORGIPEFJhW+grbuPR3QT?=
 =?us-ascii?Q?fOvKmQY8BIo0BKlqR/dCatHNz1/4JrfN9SLul/Ouxazj977ojUmV3USQMU/C?=
 =?us-ascii?Q?IOVm8a5q8sbUAcFVC6MvbsQnmcmrcFik6uSydCFhNpBpWvihYtiY0qNvE19y?=
 =?us-ascii?Q?7Jrrv7+MxZfvVU35Vg+eKaN28RIB6oPL+z3oxbqaevqSgjebeDqNQRDHNpPx?=
 =?us-ascii?Q?w5RSw9UCouM5vr+3znpr+yM9mXzOxP2Xe4Qdk0EyF3AU1uU/goQ0x8RxcYWc?=
 =?us-ascii?Q?30/n1qp6AyfuhJQ8em+7v/pYiHoCrA7cIWyx+aPE5JInuQzVxafy+5UDu6XJ?=
 =?us-ascii?Q?pJlpWX9B1TdJR1lFHR/YYM5frINKW5wn57vos5OJCHnhzpZ53oqczbPcfSaB?=
 =?us-ascii?Q?w+wvfvUJxjbqiCu+q6/j0xxsV9ngb6Sh8JHDLlhqQhhBMEAJ8gqTsRQ806Df?=
 =?us-ascii?Q?FH7nhRr01Up3c6Pp4z9QBhSuZsyIJdJTGYXSoZsnDbykQb1zKJeumvU/wPrC?=
 =?us-ascii?Q?PAIg2wbsvD034AoeYiTlsIhqdcGxaIxhR243E2OphhjZ99T9lZXsUof2W7di?=
 =?us-ascii?Q?Izwagde9NsLM4yhMNhbszz8FKx6at+sMk65X34qmxUmcC+bEWdAaSQ=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(1800799024)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?2IlAMThsJBzWrIqyJm3DRNeUBNn/PyjePn2Hufg1pon0ffomIiJZmSBhn9eL?=
 =?us-ascii?Q?ozoxf4BWmdjNsBff7scngg5JZmng/hL3iDYY2+juo6QvDnT3nNSuq0kVcjqq?=
 =?us-ascii?Q?PmSYHrKlP64eWxI701CFM6AK2mxyNJ9DOeUppLrMxttPe7FaIkFx+ncUr7Rv?=
 =?us-ascii?Q?OaEA6PaFlj4LIA+MjJIs6BEDesjC1HrgqNajtXaL7fzOUKCXQd3RurV34Ogg?=
 =?us-ascii?Q?dtEyM4tIC0ENBrUh0QkqD/f+JvvBTuHbGgv7xxB2yHoSEiEMNkZIaT5Cc/6I?=
 =?us-ascii?Q?qAW07jQA6NkcokDZGR5K5I8e8VEz9iA/yvrQK8jSANcMPz+9X5X0/nu1M7wS?=
 =?us-ascii?Q?46ojeUCXgUJv1DcGjwuGdfiJlMBalzP1TcOgPFU4qef59j+hpTfVzU21JUuX?=
 =?us-ascii?Q?q0t/sgvERV+uCpPXHD4YiP1AFYzHPM3ab9OExGb/l7VW1XuuM5EWoPUDNqXh?=
 =?us-ascii?Q?ifsjpIWXnc+CyBtZ1YTV4k2LCasQiLpfowBnDp1+Bba19+5/XSUK+Dqi2xw9?=
 =?us-ascii?Q?f8Za13X1oGdrlYRnOMQiG22jEC8VtfSivzKhIm228jxi1r/AkevkgLs1j0hX?=
 =?us-ascii?Q?aA0GYXoQ7/xBQchrcDLoSMqWl6dyUdPpOppfVjqRxy8ihCCkb8AhmmsUVmDm?=
 =?us-ascii?Q?AyNvSbD7FaHnmytr0mF11ssPsnyl2IMYjkaYI+9JtmYjRiszBiN7g4BMOC27?=
 =?us-ascii?Q?dSdt2drtktl/4jY0B4/Oasou6ks1/uW0x7rekUu5A5pd7/udvzKBfrAjE1oF?=
 =?us-ascii?Q?ownIXvTN5vN+7+A0VDfi/ZBZzNbtxJymziGb0YlJuoWG0x7aynMISm0J1sj3?=
 =?us-ascii?Q?v0B9vO8MgZRu796ycoAIgglE4bKRkLuDDRzuXu3CjG2SscbuI53RfenjH84a?=
 =?us-ascii?Q?VmLk6hjtoUPkgrWrM9ieXOX06JAhbfXoMINH54tw8wzbjHPUbefFDzPK1bCF?=
 =?us-ascii?Q?e6dlS0egQ289KMslMbQrCA6HcopqHgfVPiYyy2YYEvPgXxL3EEuya5D/GVTm?=
 =?us-ascii?Q?5hMzRORoknkJLFCm5XEVtUQ0R8GWZ85g2vCbvUqw56/UflDO43bPianDbVeG?=
 =?us-ascii?Q?/0aIIpeHNL+PGhu4SsCQCdrNb754tc0KcnK8iL+HaqQz3SWOKSIv5hqBXyVK?=
 =?us-ascii?Q?i5Uh+XkICN3KUMHfL2v2eo2wwY9jhjH4HcoX/Hcl1BRNC57LUAZSJofyLU/L?=
 =?us-ascii?Q?VSau2qLKBcUIcUR7pGbbbFMy57s6/09zgigvL6vttN4g9BVnKjN2kVLGKWAE?=
 =?us-ascii?Q?tR1w1Z9We8+01t/Pok6SinaJNUvcnPLFnfsxwwZfFohyQ3WSm2s7CdtsaCZr?=
 =?us-ascii?Q?7kqvwQ4bNc2m5WEaGSXW9gUyySrjCK9ej11EZYManBKG++j7nQEZMkgUQ8uD?=
 =?us-ascii?Q?9RePfEKc4mK/ZuGvcw1AiqqIXqnuU5oqp6LRpGL8/EoubIAOma9Vi0blMuvk?=
 =?us-ascii?Q?7hX30hfeGjuSxrNnifyXekZtB+af4SShFgBrtuAGHnJAutrBVJT+L+Xr4wHR?=
 =?us-ascii?Q?/MlKXllK21YQogj+e/Ra5oB+zcqefOmt3j+U+Cdou0NJSCLKSfwgP0zvRtYu?=
 =?us-ascii?Q?oc5Uw0fB/IpgLaI4/B8DCIUTBRjB3/djDPqYJ6b/KJRyTtZUovff3BrcF5/E?=
 =?us-ascii?Q?10OmZ8BuZtKrMcNNm5sCAR4=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb9de703-8c39-4c29-dcd0-08dd71095c91
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2025 10:38:38.1825
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ye0XTfXvvKH6Uf2tvcs3N1PecJXJe7G4GPhehf6Y7aBcwI/AQm+mo/oSRn7L2H+2S5nGAVcC9dAuSv7RZnpkrDlLbjj8bp4RTSWb6QiazBWHR6xkhOmTSJAo73pJVcf+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB14077
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 01 Apr 2025 10:38:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18451

Hi Pavel,
Thanks for your review.

On Tue, Apr 01, 2025 at 12:26:19PM +0200, Pavel Machek wrote:
> Hi!
> 
> > commit 13dcd63dc704b33a8ad94f1d161c0f5dad243a5b upstream.
> > 
> > Define `RZG2L_SINGLE_PIN` at the top of the file to clarify its use for
> > dedicated pins for improved readability.
> > 
> > While at it update the comment for `RZG2L_SINGLE_PIN_PACK` macro and place
> > it just above the macro for clarity.
> 
> Changelog no longer matches the patch.
> 
> > diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
> > index 5081c7d8064fa..b47f0f1257cff 100644
> > --- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
> > +++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
> > @@ -65,6 +65,8 @@
> >  #define RZG2L_SINGLE_PIN		BIT_ULL(63)	/* Dedicated pin */
> >  #define RZG2L_VARIABLE_CFG		BIT_ULL(62)	/* Variable cfg for port pins */
> >  
> > +#define RZG2L_SINGLE_PIN		BIT_ULL(63)	/* Dedicated pin */
> > +
> 
> And the patch was already applied, see the previous defines. I believe
> we can just drop this one safely.

Agreed. I've done a test on my side.
We can just drop this one safely.

Thanks,
Tommaso

> 
> Best regards,
> 								Pavel
> -- 
> DENX Software Engineering GmbH,        Managing Director: Erika Unter
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany



