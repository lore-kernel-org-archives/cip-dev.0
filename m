Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D868C43458
	for <webhook@archiver.kernel.org>; Thu,  9 Jul 2026 09:23:36 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.65])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.5262.1783589008380582345
 for <cip-dev@lists.cip-project.org>;
 Thu, 09 Jul 2026 02:23:28 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=jQsBy/S6;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.65, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q6ZLMK5kdeg/qFze99BjhLmQz9Kp1BU+dMEFLfbUY7pr1OFodLr5ZP87mQSoSG+ha7Y3Owper9lZReebk1ajc28RvqNxx7vbWWJpPK8NcIP9YL6/HpuqTS+PQMH3BdqYHns877WNaeIY5BUrHozZbvVOz00Tb/kmadfZX4h5Xt6hp8Iq1xLVcu4M9pPIU9ZMudMizGvsDgITZFtOFU0nf/cb2NTS9voRrBNbewROBK4G34ElSq1mFvAg9DXlEEt0EiUfo+yj/AkOt+Ajmyio+w68BbSgMxjpRceLvwHIm5eMwhqjLLsSlJ+zwawXKL3iBUd2t+UewXDC47OgXdoZow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yzVHLYkZfl4g853sr0Ts4VQz5wqMF0t1ELhYGmFAzMU=;
 b=KR9dlmhFlEEzm0w/K8/VvLT8zzgYF5vIRulQx/VI7bK1H+gReZVfx2SDoUK3NXNQiE2WkfPCAhZZSZpLCc9iROsaT0g5ils45b1BSA3wdAGE3AH/0Sah/AWlJbqYbTO+miGH6gx2pDC0s9SRa0Mm6MXffhUZHiHClCuCcXTGpw3oYh843KeRwv450Ub3vwQZhdlgJ/AzYDhfOwp2S2SXRjtXUzD0G6wr5Y898rJdt3PN+ygyhISA2zNNKglrY2FaO6SkgFwyzQtL7tcxzONUp43kqunMQzV/u8iSq812QfQxCCo0YL9yU5s/n5B7KNkt/4WrN6PfBA/NnYc9p0uK6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yzVHLYkZfl4g853sr0Ts4VQz5wqMF0t1ELhYGmFAzMU=;
 b=jQsBy/S6VQxNcMORtNiflFiB/mj7ZvQBZP5UJRN7c7Z1jBtdMTTZ0tg0x4nCKLgH/xhef9FV9x63F7iTgHvmJ8QtWfN7KHlkNgLx04qY+uFsY8sSpL5wHBpap+m8pD1u9+mn6ikeDZAjC4XhTDPZNgHT72YjOFHp4I3GYQO3gQA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYRPR01MB13588.jpnprd01.prod.outlook.com (2603:1096:405:18d::7)
 by OSCPR01MB13534.jpnprd01.prod.outlook.com (2603:1096:604:330::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Thu, 9 Jul
 2026 09:23:22 +0000
Received: from TYRPR01MB13588.jpnprd01.prod.outlook.com
 ([fe80::2f5b:8560:48ed:3828]) by TYRPR01MB13588.jpnprd01.prod.outlook.com
 ([fe80::2f5b:8560:48ed:3828%4]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 09:23:22 +0000
Date: Thu, 9 Jul 2026 11:23:06 +0200
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: Pavel Machek <pavel@nabladev.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: Re: [PATCH 6.1.y-cip 00/32] Add RSPI support for RZ/G3E SoC
Message-ID: <ak9oegpiSZVBH6L5@tom-desktop>
References: <20260617083003.1071543-1-tommaso.merciai.xr@bp.renesas.com>
 <akBCKNYSELOi93EL@duo.ucw.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <akBCKNYSELOi93EL@duo.ucw.cz>
X-ClientProxiedBy: FR0P281CA0137.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:96::13) To TYRPR01MB13588.jpnprd01.prod.outlook.com
 (2603:1096:405:18d::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYRPR01MB13588:EE_|OSCPR01MB13534:EE_
X-MS-Office365-Filtering-Correlation-Id: 954117e9-1242-4ef5-c8d3-08dedd9bb8d1
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|23010399003|52116014|1800799024|376014|366016|11063799006|56012099006|4143699003|38350700014|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 
	zWxjBk0Zi/nmVdKDyZbiukx/lkxLOngl9kLvJdDiq8O5JGtDktMgEiLaR+HOlUhtO7hHPVy1mbiKciF8dHq/AwqvIPibvWPH+UXpIEVAfhzvzgYDBnxslt8aiDM0mP7C+mADaIgz38HLhlSVld9Xn3xDsIjoEEDYMjaTF3p4ObVH9xOzYVuQbEIMOavSE0iOGxNNm9+bsvQZvlQFORdbpjZygGATS/KNSwVTRFuEtnHKQotxlCCaI3f4IKEX7jwqS2blgNFWgzydk9VY/5kYUFhVAoRKfEjPJ3rJg9HtV86Y3zuiAkUoYoP7yt/eG50w6IP2gsSzZNIBZeJvotDH80ZXgB7qFHGRAWFV5lqmBPXHWzwAP5VCpusSgY0k/G6OTxKfP0m1kxZMw/kGywqivdHLQwkRBYVJh7roGCX3yXy9d2JRKivbalwv1Ui3faNjzvXXDrz3PNkmDnDA5BUrWqMXYDhMhRTlW+f6xyRMtofOtdnyYez3O3cI85/ZkbUiH5x0mKUgWSQSfAFza/rHktC9Fu6GoI/ldOXfYpP3IGprbPIhNWKbk1/fQf2MTYOmIy6L+MqymyiIhLPJR2WJixRVB4qS8amK3NT2FlOo8uSUeRlCe0XdILEFMknevRLGlukgX/alNyLwv/O9LqKjf4PDZoQQq+mdm9koHa7skC0QgVdmbMmx+i1ehHPcaA7+302gR3ZE9+7+iRCmhf6jTAVfFNe1fFYcA3q707sQGSk=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYRPR01MB13588.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(52116014)(1800799024)(376014)(366016)(11063799006)(56012099006)(4143699003)(38350700014)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Imql21RC6SwhmBGY6g6U350fjbzqGHdjQwoAtZP/UdMquwlOmQO4xWG+xTB6?=
 =?us-ascii?Q?4DItZJ+N0Oi3JujYk9CqOobV96ef99UISqg5G0sKGo31wYORl68tmhtuhdhO?=
 =?us-ascii?Q?fGwby/t+mby1TEKHQXtHN6TdU4wMpySQyvzREnQgLJqmFbanbtibjzbediP+?=
 =?us-ascii?Q?psrUPP3x4/TsC0x19kKKnSoCGfs1fHSaxsa3Y3LTQmnc6Md81q07qpInOSSG?=
 =?us-ascii?Q?5NRNw7Wy3d5HiGQ7zn0QTdPlZMyMNHUq3EAuvuWEu2VpKE6nW+Lz01p7xH6Q?=
 =?us-ascii?Q?GyU1Ak1u/EC8rFmNitfs2p1LPogjaL3gm8MUU2RW3okjkFfdtPw2J5gQroHm?=
 =?us-ascii?Q?018znlgUtz/p91gCBBIGY1X/u9D8cfqn/wXYYfAgbRl33ZVn/Anhj4lR7JDS?=
 =?us-ascii?Q?+z16YVBgwV3DVSW8rhiIcDHQum+nbRujK3861mlbWLte0P8W5AoozjcBeFFH?=
 =?us-ascii?Q?hQp68gcjCkx2MG87AD2WphC/xknXVjYIFytlF1ncwYbXyaIdyvZ92l4O49xI?=
 =?us-ascii?Q?ptGd5jrIPFuvqvrDmXlsIERQF8JCuDwRVQSfK2TnhBYWi9XKT1SnnkSilx64?=
 =?us-ascii?Q?QTgDAaAMcYzyJRL7hc+KbjmYHYhJ9Q2ps2nNsLAbiCc6vmEMonS/P13dzwwq?=
 =?us-ascii?Q?G32T0I3g6bBIDwGfs2+w+ZXyF2/wBpH6k4l2xKgKzNFHXS5tc0Ed5fOqXa5J?=
 =?us-ascii?Q?iHMwyauJd78XyPyU+yTvMD6KM2bICR/l7t1mGAE/DPSC+c011kXWowrllSq4?=
 =?us-ascii?Q?rryFaFNHNRbFgddBOuCLvvBcOM/Cn6PHcajwRv5lVqrbyCI2buddA7Ut/fFW?=
 =?us-ascii?Q?2UOLQnLQtfAxzzKaLiXygg902HIKzPxTTW5g/wefHbWj0wbNnWdoliGEOI0t?=
 =?us-ascii?Q?2wL9Nlfd0AkL6pKLtI01nh5EqSWnIpxyyhX9VbrDicoxZ2fxQ6JaGFNWPxQM?=
 =?us-ascii?Q?Y/PJ6LlbtzcKIwbw/AibGOpzLGx/INSMCH2gpF92hyzPQWUQk3yj3bOG3iHS?=
 =?us-ascii?Q?jPjkctJna4Ee98ZELqjoMW2Fnsz5aPC/7YKBQo34A1WJFcDWMwQMZm9WYrDp?=
 =?us-ascii?Q?/qnnhOah55RCg4RDilHLLgPCkIiisfARFlgd33pCFG76E9Nmz/1r6ZJRjxfM?=
 =?us-ascii?Q?lXYcWnonOL/LcleCxI7KL4itZtcWszHbyCFkZgyjKQt94gBcDmBKz8f3chpe?=
 =?us-ascii?Q?K/VB1B+yOODRilZsAldBzmPlnJ5ywqRqfdbhBMCTIUbKn9oTat8h4+xgm2jm?=
 =?us-ascii?Q?HoRxlOhbNZmye5rDmtzIgFsjf6kuYrcnKxOm9JxIM9g6UwJNkTE9WnhwtKm2?=
 =?us-ascii?Q?1+/dgHjHA59xbrEk0uiMHVT8I+DhZ/mFURm+CRv5iJKYmzA6gSIMW9jlijEB?=
 =?us-ascii?Q?Sxrk6Ty/dLav9svSBOcVKGGsXZBNVxNHVwyUEgE+y3Qgk9mzqiJNPnE5aaAq?=
 =?us-ascii?Q?cGpmLHRd9Lzu8cv+cissC682j9WcFYf5FgNVteI0jFVr1lwrdiXGRtR0E3y9?=
 =?us-ascii?Q?JRRQshIot80DqB6P6SBOM9Y1xe5mSj76zorTDZj535kwZcwJA8JL9Gr6wmPr?=
 =?us-ascii?Q?D6fg3GfKTx9+MwUnAD7n6Nz3w4PNgOjkBzEl6stuVgHFzP28MecQ6SV3XPm6?=
 =?us-ascii?Q?/88cBUQUn20f5sGxnAa4d+Rb+n7P38U3h/oAOCiRwFntiN0h6cgoT0VUCRBA?=
 =?us-ascii?Q?O0ZkR0U5ZmQHHLkbfXOH7c/gGk84apyevCe1W3YsiznKFUi0wSw0iuZqAxai?=
 =?us-ascii?Q?x51AS0aPZsT5jMbHDufKYBhsopGtMj3j8MVxKeUS5eJ7t5ZLUPpc?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 954117e9-1242-4ef5-c8d3-08dedd9bb8d1
X-MS-Exchange-CrossTenant-AuthSource: TYRPR01MB13588.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 09:23:22.6457
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hhHKIpChYqH0LxFwGOtQBCC0zT8u2Vy4CQIVopA2gI0Q/4kVDcdey4nHQ48gCcuF+ATz+10L/RecX7OP6m+JCD99LYfw/rHW8AOAABJDFBqPkZINisFsUvEDh9NvWWqg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB13534
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 09 Jul 2026 09:23:36 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23557

Hi Pavel,
Thanks for your work.

On Sat, Jun 27, 2026 at 11:35:36PM +0200, Pavel Machek wrote:
> Hi!
> 
> > This patch series adds RSPI support for the Renesas RZ/G3E SoC, which
> > features three RSPI controllers. The series also enables DMA support in
> > the RSPI driver, and backports the necessary infrastructure changes
> > into linux-6.1.y-cip.
> 
> Thank you, applied.

Just to double check with you.
I'm not seeing this patch applied on [1].
Maybe I'm missing somenthing?


[1] https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=linux-6.1.y-cip

Kind Regards,
Tommaso

> 
> Best regards,
> 								Pavel



