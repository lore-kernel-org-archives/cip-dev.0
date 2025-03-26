Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8062C36008
	for <webhook@archiver.kernel.org>; Wed, 26 Mar 2025 13:43:39 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.23])
 by mx.groups.io with SMTP id smtpd.web10.22716.1742996613786125592
 for <cip-dev@lists.cip-project.org>;
 Wed, 26 Mar 2025 06:43:34 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=HGBCO6bb;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.23, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y7d/aQO0NMOiB139yJkqB8T4BbkNvMExeBRigzJC9cusoanWrIOErbEnkqFkcaUbJrJzRtt64ddjwZfAUZXThE3rlPZ4GCysXCzDjoek/6vRvBabog82v0ngc56/5JfATueAM5/eW7rnW+dbXXrye+U5rN2QkPmbBlf6WWasgGJkGbZPBzxdxtvXQWtjQK9TH2VDZQIDFq3zeZ68F/nTS280NXRnI0IoGtJUwPrWSc7g5JkocmAb7u3DttvPv/P7IaQFyRRZB9kER2zErisocKKYjniYFqleavDTLT1e7P+wB9kxzajChFpgGtV6AzmWxaqkBY7K5VuSKziN87U7gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NWGxDJQt7jYXTi+0m8+fAgh4C2ikqNDTqZxtaQzDyLQ=;
 b=wHto7cfomZJjraDi4Rd8hQaF1wWP4JvN11sM/dLPpj7NFeVFsS1TKAyCJd8lfyAdPVk5/y8Pbwm40nzhvrR/yRbjIbApmnX9NEUeTSNpFtR61lhIOLNWs05hagQGF79pp7h8KAI8GCijIZH+ymjOqeSLteZcYFnfgEoM0jlztiXfTWLPR8UhuqAFLwrpB7yQ6hVTfxSZvJ5Y8/c2YTCCbf7aJ0AZdgIIinLvcIP+4Elr3CWAbnC6y2+G2XwCxLZ7u6Tm6KBZSm4sA3et9O4EtQM+yXLYoQphr18d9ai/8xZdojAVJqY5Ti59Vbq1tpoBiJcsNF85DjDabHiakwxH+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NWGxDJQt7jYXTi+0m8+fAgh4C2ikqNDTqZxtaQzDyLQ=;
 b=HGBCO6bbyGnB2bDOPcXYS/GJz+Vug3s5y4M4cDysEAs5bpxiKJ2vze3redU34OPR8Rza1RW+FSTUFHYyBYXK4tFZx+JEU5OOlXbk156lFKzWZfDr4IPUTm1MB68nJnjqclRrciJLBX/mNscL47BcQOw1ygPWHoW/oUhS520n9bg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by TY4PR01MB15710.jpnprd01.prod.outlook.com (2603:1096:405:28d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Wed, 26 Mar
 2025 13:43:29 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8534.043; Wed, 26 Mar 2025
 13:43:29 +0000
Date: Wed, 26 Mar 2025 14:43:13 +0100
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: Re: [PATCH 6.1.y-cip 00/21] Add support for Renesas RZ/G3E SoC and
 SMARC-EVK platform
Message-ID: <Z-QEcdrAz23PkN7h@tom-desktop>
References: <20250321110021.3612805-1-tommaso.merciai.xr@bp.renesas.com>
 <Z+P5EcmP5S5leD9O@duo.ucw.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z+P5EcmP5S5leD9O@duo.ucw.cz>
X-ClientProxiedBy: FR4P281CA0418.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d0::13) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|TY4PR01MB15710:EE_
X-MS-Office365-Filtering-Correlation-Id: 496cbfc0-4128-45b2-1f6a-08dd6c6c30aa
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?Lxmy4HNPUgYIyt0avjub+1A8YPpd6E15xAv1fDvXDVaxtJwTHxeEBZFQKN3T?=
 =?us-ascii?Q?rasxYVABsjWRdV7jCiW1uBKJhCFLWoeLDxCQ+KNHRHfYoNJK14MfxFfCwmiV?=
 =?us-ascii?Q?lE41mupj3AN1wGYHRQnDH//AkRHIsSuZj3qDhp8w02yDDdS58oIPkorqMhhl?=
 =?us-ascii?Q?2ptgF+yfkq+f0k6TvOzf/36Fr4sC+vEEWMwBJkfLplJ17KPxajSkRzhQWSbd?=
 =?us-ascii?Q?GK+LSgct+zuts7vCOgeUbhtPl/9R6jADA+ywNSD5ogQpewh5sMzHcPzRTKO9?=
 =?us-ascii?Q?s8Bf5dFtY7Dm/56RJFmoVfrkyLE6heJKuFz2K58zNGy6ScUCF4v3E0/qSFu2?=
 =?us-ascii?Q?1zaALIK1immh3cU5P0rmemQYTGrLzPSoLJNuYdTqGywqPu4XKOlBzAZaEB/v?=
 =?us-ascii?Q?FBbHts3nBC1NGQZrkjUHkY4+qdaSwVBiV8EgHzgQIf5evRXFbcQdN6+mKYNh?=
 =?us-ascii?Q?c/JJFPE0GzZLYxJa7OB5zygeKMGNltWDWXvSKOtqKZ4TgJmAj/5x7n3Nzf5t?=
 =?us-ascii?Q?Po/2E5zycNnyLO95eFYgFKwVC8DbB7ZcTPNnOVDca5xLNDn0iJlOQ/FUParY?=
 =?us-ascii?Q?ioWuC3GW6WL08ROFyDTuvkt9imX36lDYDN4YYT6QqVojTm8GxaTmBMSEdZHg?=
 =?us-ascii?Q?J4IZ2RvJDNAQHNMB98xJD5CJHuos/abRgmLQD/R7PCcSOAvHrrtuBxRwyywm?=
 =?us-ascii?Q?GmT2SLS5ocRGDsh5xdb52kxF3RH5052Pcg4++edPaMsU+Uu6asUKSKhDGIxK?=
 =?us-ascii?Q?7v/pHcr1IJJqvr53fZWIkXSI6xE6PlFtnRhek/FkyPP3uCgADM+LYcWj+7mH?=
 =?us-ascii?Q?lyMgF4F/ynAwhSuM0NpTQRLu/+1P4/LGYLhA5bsnvcfdz4tMh66XDBRNcOWt?=
 =?us-ascii?Q?E2m6WKAZz3nVaJfbs6A+Z4Rin3pMSegFxFJKImYVVZLkC001z234Gmqa9yZt?=
 =?us-ascii?Q?kptvLIEdX+Y2yT9+aHjXMhKw4LlJt6iAonbFDR5ea7jjOSg02uzCo5T3/HJp?=
 =?us-ascii?Q?yuCloH1+DL7L4VqFjFlQ+x/HAuD1fEyBYeb2kRlcqlmjGJHKsRjIPQm6RwkB?=
 =?us-ascii?Q?RrdqiDZPSXrQzrRy7xR48dSRA8Fet4E/4sdIcbJBhvKB/0E3wOa+HsHDAGGB?=
 =?us-ascii?Q?I/+Ovs1Vm0Gsrv/SCzdUIChJ6Yb/ka9qHVNkRa/GorUbwTodL0YaAjmdk2v4?=
 =?us-ascii?Q?cxfI/vs38WjCrZF/EVkYNAFYGX5wBPT9TxJ+nrJtC2YTMr1a+jDjbza3glPO?=
 =?us-ascii?Q?izBVdAMW3wVw6ISY7ob/PmTtiMtfggif+kD8EYxdwIGHxOgSpfcjR6ENbCzV?=
 =?us-ascii?Q?p+rnkZmMIj8mZTdig8Q96SDUmLI0kGwAShf9DYBNnMmm10RX85vLmYdM5sM4?=
 =?us-ascii?Q?uV9HiL68JA2h5pnma2pY8+m6Xg/tMOqY0nknrmgkFp7TtVkoTtDotaAOiJoW?=
 =?us-ascii?Q?AzbGqSHFho+mjMZDlyYKB7YcnpTOO40N?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?MkiQJZyb8iNONa6F+SmaPJWbcHas2eaXcGJIvq/nilVX1HROJVqyRndOya39?=
 =?us-ascii?Q?LMWwqv49X3WDaIRMX0vlR6zHW/owHW4/bSYtTwWiRwUnPTgsHbKpvJC5G+dC?=
 =?us-ascii?Q?p7vwXpGpR5Hxb4+ip9hG1rCEnieP8grUqPA2e3mktK5vYozyU2XQabI/XaME?=
 =?us-ascii?Q?k4JSGZVb7V4+JSWVoekFrCVAuXdtrfRI9jCJ94wUHtqrP9FPyb1rQurbb1bb?=
 =?us-ascii?Q?H0SlprSq1RB3qf0D14FGCTKqYPHfD5PiiIcjx4QLNRZahMIfJMoaXPDXPwMu?=
 =?us-ascii?Q?N/LtiDY/fb53tFULK2ct2psM60B2Fqv51aJp2nvDznUK0F8w+GGo547rXMHr?=
 =?us-ascii?Q?dFp21pJ+SgEdtWypWwRfHtExbvfzKx1P/qgemjgTTy5jLsriH1xoJU1QqmPl?=
 =?us-ascii?Q?9A83Axy6VojTfQjVduh20Cxk2htpfBDCeDAlFYzNvHzsICPWoJmouRc+uxht?=
 =?us-ascii?Q?pLO6TS6aLoZQwXzLu6QJUDj0JSmXMfOWjchi1zxcuRW6zkYZmrwMScGEeIid?=
 =?us-ascii?Q?YBi4jFv9MGipd6+RGqH3+GCnmR50Cs6XSXqVbK5aartTCfGhvJKGeBsnpMOx?=
 =?us-ascii?Q?QdU4QtaSUDWlEXzncDr+Y/SmmShqlcDT3AGnXXWDlkFJsS2QNMKw+CiiauMS?=
 =?us-ascii?Q?ncfzh1/cuCU0V77l/Xqzzq2/ekLqfDRZXSU3fDUcfS+lDbSSFQAWIm5v4vFp?=
 =?us-ascii?Q?Z7KbOMQIlFHKM+5YVx0NR2Xr0L4mPKFqCxGlZeO4bmh8opZJZIHtGIV+5IY2?=
 =?us-ascii?Q?s2bsZsyRkX+ZgTDS6ZQpb9Q7gJtlPtXxJrPGqOkW8lmOF7EvWoC18u7XEQgl?=
 =?us-ascii?Q?42FfFbClTGbwzYCxcsWkVk7s8bpz15PAUO3SMmNZVgK3V/tBl04WQW97Q/J4?=
 =?us-ascii?Q?GEahjVQs+vtlZKs9goQVvIg0i/KvDusYe/GaZ+iQunVlJBguuJHagcb1hD9W?=
 =?us-ascii?Q?TVE8srX0Ibm7vVZwO5YlUE9hfcFTzO7KZnMxZswRzbQbw+fnusLXqIS79MHg?=
 =?us-ascii?Q?UaSv+k5QPlySciF5mDVQz97TXiRx3uu+d1FmB6ZwTdONDIfX/YV3YYLtYqAv?=
 =?us-ascii?Q?e5MQdR/yMzNDLPRJtfPcyYZ5wPsgfIPQSFrMstx7y3a69TjpI+oLZh+2UefF?=
 =?us-ascii?Q?mCPkHwAzJtaD8bQhnjYfOKapvVS0+nuB6zq0ScPBW/DYHPiQHUWbt6swbP/m?=
 =?us-ascii?Q?yddvRto7X3sJc9+V6jfp/auYZEmYCdgXxoZhylaV8At0kCVM9NlPzd2DENXr?=
 =?us-ascii?Q?5XkMYjnphH6GpP3lSk4oieS9zYbExGfojeG7SXWqXY3lz+6g9smQM3FVnkqB?=
 =?us-ascii?Q?bK3pMrAItU9gD6uYDb1ebRNuMu0dH26ozuR7/diWsl2vbQ83mSeV5g0yTFXt?=
 =?us-ascii?Q?yWzTa0GE0NkqaOG9hWdcQ0IUGsq/rp4kRkxGMKELa6cJOpCLsIcM0hE9RFpE?=
 =?us-ascii?Q?Na34WB+0kPkXqLsSPOip+t0lU+Qy6a9irOkL3bKdE73fAl+MfjQZi6beZIOn?=
 =?us-ascii?Q?B7a2XC2kTSDlVzC9wQwaf6DUsi4P4lvS0f92bkRzt1E9Y5PGuWKFELsEZdSP?=
 =?us-ascii?Q?3KsKsHB94SCk4u0QBTnQZP+X8FFizQBhWaiwQC1wQaKogeUiWgZ5HmpoEtXf?=
 =?us-ascii?Q?jAc4VV+vKLGKi7qng6FMNio=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 496cbfc0-4128-45b2-1f6a-08dd6c6c30aa
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2025 13:43:29.2744
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ghjzff6B6pZ0NbqmA5wCv4e0REKE+b3wCK9QBlV5wANGZ2qNAX7fk7wYqlVOWEQ6DODkrOw803Vq+S78ibfOPg03hSa8mzD743unzTcex1P6tlvoMrNWKGR/rKSZFVXz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB15710
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 26 Mar 2025 13:43:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18371

Hi Pavel,

On Wed, Mar 26, 2025 at 01:54:41PM +0100, Pavel Machek wrote:
> Hi!
> 
> > This patch series adds initial support for the Renesas RZ/G3E SoC and
> > RZ/G3E SMARC EVK platform to linux-6.1.y-cip kernel. The RZ/G3E device is a
> > general-purpose microprocessor with a quad-core CA-55, single core CM-33,
> > Ethos-U55 NPU, Mali-G52 3-D Graphics and other peripherals.
> > 
> > All patches are cherry-picked from mainline kernel.
> 
> Thank you, applied.

Thanks for the update! :)

Next step will be: pinctrl support

This for 6.1.y-cip will be a patchset from:

[6.1.y-cip,23/85] dt-bindings: pinctrl: renesas: Add alpha-numerical port support for RZ/V2H
..
to
[6.1.y-cip,64/85] arm64: dts: renesas: r9a09g047: Add pincontrol node
+
[6.1.y-cip,77/85] arm64: dts: renesas: r9a09g047e57-smarc: Add SCIF pincontrol


What do you think?
Thanks in advance.

----

I've tested the same on 6.12.y-cip. I can share that a smaller patchset
is required to bring up the pinctrl support + SCIF pincontrol on RZ/G3E.

21eaffd338902 arm64: dts: renesas: r9a09g047e57-smarc: Add SCIF pincontrol
60e58e522d319 arm64: dts: renesas: r9a09g047: Add pincontrol node
e3acc80c6ba8f pinctrl: renesas: rzg2l: Add support for RZ/G3E SoC
92421d6d2daf2 pinctrl: renesas: rzg2l: Update r9a09g057_variable_pin_cfg table
ad84e8733dfb2 pinctrl: renesas: rzg2l: Use gpiochip_populate_parent_fwspec_twocell helper
729b42260235e pinctrl: renesas: rzg2l: Add support for configuring schmitt-trigger
ec01f77780384 pinctrl: renesas: rzg2l: Add support for enabling/disabling open-drain outputs
d29a0e1f3a42f pinctrl: renesas: rzg2l: Remove RZG2L_TINT_IRQ_START_INDEX
64772cc20274c pinctrl: renesas: rzg2l: Move RZG2L_SINGLE_PIN definition to top of the file
da0cd8ac391d8 dt-bindings: pinctrl: renesas: Document RZ/G3E SoC
4cbfebe8e22d1 dt-bindings: pinctrl: renesas,rzg2l-pinctrl: Allow schmitt and open drain properties
63f78eb380bd8 dt-bindings: pinctrl: renesas: Document RZ/V2H(P) SoC
35cfeaff9607d dt-bindings: pinctrl: renesas: Add alpha-numerical port support for RZ/V2H

I will send the series.

> 
> Best regards,
> 								Pavel
> -- 
> DENX Software Engineering GmbH,        Managing Director: Erika Unter
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

Thanks & Regards,
Tommmaso

