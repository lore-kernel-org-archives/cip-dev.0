Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1359C28B30
	for <webhook@archiver.kernel.org>; Thu, 20 Mar 2025 13:14:48 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.35])
 by mx.groups.io with SMTP id smtpd.web10.7072.1742476482432064577
 for <cip-dev@lists.cip-project.org>;
 Thu, 20 Mar 2025 06:14:43 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=GI1vVSBj;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.35, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SrFb6GAorxCs3HJXiNFTjjS6JAKx90rMTeiSKZJm7Zk+nb8JHKhW4o+B2uNGFQhHi5DOb5ShFhifsVeqKRY9CDA63iEcNhxrfEe3XuFUoNZj8Hk4TKmdECgCy7HTXdM8qlPmi1+ErURmWwwbmS54aD08hrZCXmKNldcHB2NJZw/26py+V+OsrAa6XPpS2pBesfn7mzHIx3WHC0rXuZHBXdb6Fe+8uU0hYPBQpGKU1g9dbJToExT6NU7P9MXkR4d6LQJh0VpTsGfSJdGViZeAbFbsXro1yKPPOFWHMDuWCabHifNli9gjpNZyBqaPSc89YtvkRjFYf3jp4+9Ig9W0UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BBakU2+wDBrcQTWleAfM5HNJYNrScLQixeuoz90vDh8=;
 b=bc1i9f7Gle++4Za4PgEwTgtYCx5mxSEz045o7fS9n8kTOSCCQUcvv9SEEEZtTdR5arWvR377ieTIWoHKFLn5BWvfTeibXgpZkhqkLnbzO+U+mDwTvnHismAao4PzO4L/slQez3lim3ZQST8REA+Chyhld9WDFEwGYmZmrKbOghW8Llut4x6fCej5NrkbgxTn1G0zQSiIjtAB0ipWdSYl4WLmqQ6cgz9Y0BjdNP8ADohab0kdrwUn7bU+Vg9nsmXqjGSlujWN3edxovdnK0ja36l75JHOqFSEk6uS1Hu7eSdAhI7+YZ+aoSaUAwGoNupm9aNP4bMQFH+2fADT2/rw0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BBakU2+wDBrcQTWleAfM5HNJYNrScLQixeuoz90vDh8=;
 b=GI1vVSBjzJ1I7d/sLB48AcJKmSDZwA+dkuCPNh+mcyWoaPLS2izrDWR4R/fzpBoT/s32XAGJirxTcq5HGdlA32eULeMRaXls+0q7nXUrCrCgVmI7rtQ9UkgYVzV5lJDgZTKthEkw+FLQmQP24pBZMS9gRKKWB4e0y/qwoAxWj2U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by TYWPR01MB9469.jpnprd01.prod.outlook.com (2603:1096:400:1a6::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.35; Thu, 20 Mar
 2025 13:14:36 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8534.034; Thu, 20 Mar 2025
 13:14:36 +0000
Date: Thu, 20 Mar 2025 14:14:24 +0100
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: Re: [cip-dev] [PATCH 6.1.y-cip v2 00/12] serial: sh-sci: Add support
 for RZ/G3E serial driver
Message-ID: <Z9wUsJRHf4zN_8XY@tom-desktop>
References: <20250319101629.2407727-1-tommaso.merciai.xr@bp.renesas.com>
 <182E2D5440856AF6.20726@lists.cip-project.org>
 <Z9qcRBPx38dI4QtV@duo.ucw.cz>
 <Z9qdLZ6MSVEaMpj0@tom-desktop>
 <Z9vns4WDhX0uvZ2N@duo.ucw.cz>
 <Z9vqHMBvy1O1qB8i@tom-desktop>
 <Z9wA6lxJxbodUrO6@duo.ucw.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9wA6lxJxbodUrO6@duo.ucw.cz>
X-ClientProxiedBy: FR0P281CA0174.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b4::7) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|TYWPR01MB9469:EE_
X-MS-Office365-Filtering-Correlation-Id: 5af6fb9d-428b-4850-af72-08dd67b129ed
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?JzpA8m6/dTd0+nUGRz0s0aGim7BlQa8jw40Y2M3NF4ZWFrA9vw0LDVzTG+eM?=
 =?us-ascii?Q?Liw6ULsh9xGHj5uVJlAlGpCCwF+GbFmdIo7nqrhlVgillkGZrmcq04kNHDn/?=
 =?us-ascii?Q?cJAyDDifaN/8zozhVyHH2xhKAcXwBf4TCIWRuNuw/5u6wcBvi1Pj2/dhVEwr?=
 =?us-ascii?Q?QAChMsN7/TbXnILp88UcsNRDJqZiRGb8wWnomV4v1/Hb9ycOfKgWRY+3SB/h?=
 =?us-ascii?Q?PLlTf6UcLQ+EYTPjU0Hxx1F+l6Jfafbw12lXW3qZHyUdTvtxF3ksWyJq5f7R?=
 =?us-ascii?Q?myevAvDpoMlBOdjOynyPO+0Z22PWgNjxCibBwO2Vp9XStwJBPIlMEzYqFYKN?=
 =?us-ascii?Q?WU6LQbsGLfadwlnvODvLIb4vzMkuc9iSuq+9eVFgZ8gugMYzRCi5WINvMlL2?=
 =?us-ascii?Q?z3aisCyvDPyrIcgDC/qm0vKgSnhZ/IoBXb2aBCNYWnxXx7tQRAA/LS4vjpSr?=
 =?us-ascii?Q?G5z50bGIWlcflKSwqpT0QAxXfn64Xj/UuevCRPfV71nGsYj7+SDYq1wpACya?=
 =?us-ascii?Q?2nBlwEsqrkqFIFD1UCAhGGfwdnv7KQu7/MlSijLxMei3ykB1XphA79Hn8nAp?=
 =?us-ascii?Q?zHDPiW1R45TmDBemMkLsY5DtzxzijqdCEusMsvP5jPbiJcMcTNKtRkoJPtjJ?=
 =?us-ascii?Q?Mb4+6rhnyO35bHSTG2z8jBkiYgqLkISY15dnT//ZxrzpdHC/7idgsW0Axzpm?=
 =?us-ascii?Q?2MWRql4H17hoWypqSU+77FD1GJzdTN9aeABbBxc88ZjCYpYS6l5LYjmr3SAU?=
 =?us-ascii?Q?65S0iia0NyuLdpDprVga8rzDPXRoCkVr72JUw0PML/5fg9/jxdnC9qyLvcSU?=
 =?us-ascii?Q?sWLXjz6B1gfFTxEFyg+5o2aaL+cYgLFPwa7GITbqIVotPtcbsbw49PVrJv2K?=
 =?us-ascii?Q?nYi0fqTAkGMFrqFQPWH7zJoCfcwXd3pEjRpylU1WRHujYJbbWKLGQAFRhBiU?=
 =?us-ascii?Q?mVwIRqYX8ZJSZn0GF+j/USw+Y8r0xZ9SF1JqM5EmdqYD9wV9YgMEMkrLpcBa?=
 =?us-ascii?Q?39N1NvX9DsCe3Rc2WgbB0sL6ctLr/h6pBWjzkL+f1x8OlyhV0AN4ISRoGyQ0?=
 =?us-ascii?Q?/fVA3cBHnRDD+M+FTxFkdcUVc0Y7yLrdIRMr3CdfI90uyNuUYj8U66W0rJBT?=
 =?us-ascii?Q?PYpoTc7YJ49Q00g+QHPWITT6ynbaaljPqq1toJXv0fTKbeC2OJgzFscRvq+m?=
 =?us-ascii?Q?qznsY3jSDSocqfnyKqpSk5h6rV6JsIvOsCbdcOsv9pSHVmZ2hTz17hMvqhm7?=
 =?us-ascii?Q?a5I650wSgvB21qcFfNvFoPJTM08y6q8g34BH89LQaYCJxwTuNKwLuhBAeG/G?=
 =?us-ascii?Q?a1ln8wRb8LkF8iCl0xaNEm50a2yfZERBnjpg+mrz6sp8l0JukEApJAGE/3so?=
 =?us-ascii?Q?ybTwAZsm5pZX/dN5wAICFJCcMUOFufr6wsuVmlbm6Bxi429GOP3xSrODzNXA?=
 =?us-ascii?Q?3KRVyyAMsC0=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Q4kZpp3rl35krGKwl/Kmo/sMfpF7YGa9reQ+LbxHVcmufJbQ6hoTtoW+ARsN?=
 =?us-ascii?Q?Fi/bW7U36dmcYBUPevZ8jGN4tMLWCnEWfhtuNyamwcy0lJHXBQGLPsAluFlW?=
 =?us-ascii?Q?mnZD+0/QvkMe3E6tOYBkXNU8lTLc4o4Pfdl167w7EKD++8RAz//T+pShd3X0?=
 =?us-ascii?Q?lPTYUTBZqCzbXFL3yCC2V1vYeeduE6vMbZzZt6+n2wHxAAhJrHbr7F38qnD/?=
 =?us-ascii?Q?mEknQwGSEkOwTftV5feWgGxNyi0MXMN0nQ2kOmwK59jRrvhx22G6cKoi+1Ya?=
 =?us-ascii?Q?M5yv1wo980PjJJIsYom+FDL5B+YgUJrXWcD6GQgpEDFq4B9+tZy88N2Aa1bA?=
 =?us-ascii?Q?LZo/8ffhimCauPF6bk8n77e/9glN1nCwgI2Xp/OTrRdy3iFsYueTl1CkC03Y?=
 =?us-ascii?Q?aWl4DXOiQBfdVP7UlVR3PKhGpSNuc0ZlVV9TIryya3gUXXQwFgrj9nws1l0Q?=
 =?us-ascii?Q?gSTvoO584oSrED2pLSCCqJBmOmZE9MIMAx7RzLANJS6OxeoysLTBsDESHrha?=
 =?us-ascii?Q?L9yOTJtfhC7Xy6B2o76na0aJFVgAmNrTMMHQgr3iLttk5oMklsxrFhl7Dnl9?=
 =?us-ascii?Q?Mcxk4dGrhrum9HV0RHZb/vkR3JALQtslDQShF03JXHZg9+9UVuqal6FYrQTO?=
 =?us-ascii?Q?3ob+qYNdw6OK+phT0A4r1n4M/SCWyMWDuzaFJr3WIcJBE9L+d4+AZkgSUXSe?=
 =?us-ascii?Q?GlIRlzT9fA9W0HCSve5pZaBSw/KWDrbRJufWqh7i7XAgprdHLfPntfiFleps?=
 =?us-ascii?Q?oO2gu0vdD4/Ygbrf7axcZSsD5obTDZIXu0Y/kQ2FbbrhrX3P9JMBlBgNOjPc?=
 =?us-ascii?Q?N6q5MRHpDZURmNaNUNg27Kc7KAmJd6/kQCg0AzwJYoCTZPXSEC8hTJZ+adis?=
 =?us-ascii?Q?4KiRkkb7n7wTrXUvR4n5A4WnARZZvmxHfhF6xSxMhiRVC66cIqlQMxEBvIc9?=
 =?us-ascii?Q?9rAm3AYx/NFkjxl+3G5t8D4XVLnrRMuy8QwBg7hkYaufA/HXOAg0OIa9QGqF?=
 =?us-ascii?Q?gXssJfnU8mPwIH6u8LTaagi7CWTT65jUG3UVo93lAzUaBqddK3qh5QLkke43?=
 =?us-ascii?Q?fkkj4JDmZSFDXnrIULZ5Soh1PVixnyJDTgC/78hnrBdELpNb+BYH72obQ1lI?=
 =?us-ascii?Q?Gud7sLsb4sERysV/guvl2VJk9IysYmtlWrWrqKAd+HqBxZNgWeODjlD2WNag?=
 =?us-ascii?Q?t2wRgWrjUmwR4s8YoDbvJNp65Xk3hh1bJco0ycqIQPI9ruSFfA6L7kdReA44?=
 =?us-ascii?Q?gfCIkiSEgn3Vo4fes63wzjxQ9oBhTljcZt3etRqeiTECYLLsYaBabNYxdzcp?=
 =?us-ascii?Q?y7HCbEhIGJ0pUUhxJi9OvPUwCy7GSa/5ToLAAYIySUljHI9s/W3/XpfzrWwh?=
 =?us-ascii?Q?koARuycUbIJFTWOXT9oL+M8ARAFaZTWEMELdLTLcBOxDb4ENNeywYlW8cBPU?=
 =?us-ascii?Q?xRLrN97VFT0T3TaGqYYSdR2e8jX6kDL+qfC8dQK9ZismyAyAgYHta16EJkRE?=
 =?us-ascii?Q?ESh5v6ncv4oNymmFOvB0fubQM921Ckn2vDDIO3CXQMfaejcuYfi54RCagLiK?=
 =?us-ascii?Q?e3KsL/xq0ilroy4FXyMwlvY9dKuSJ283HIK8ZV7DLVk4mIbPk1mSMTc+hJdd?=
 =?us-ascii?Q?7MZwcPYa8nGOLM41CNP7b2w=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5af6fb9d-428b-4850-af72-08dd67b129ed
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2025 13:14:36.7818
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9adZn6CcvJymyqumrGWh+uYN6BX5XMnOX7SY6LWT2ApOJxzzn0mRi52FNKeqV+S0YIozy5B/FuUt9KTvs9cy0wEIr9pCgA2FyDTiAZSVepsTyGFJ37qew6nlf/HbsdWJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB9469
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 20 Mar 2025 13:14:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18297

Hi Pavel,

On Thu, Mar 20, 2025 at 12:50:02PM +0100, Pavel Machek wrote:
> Hi!
> 
> > Thanks for this.
> > I'm going to prepare next series with a minimal support for RZ/G3E then.
> 
> Ok, thanks. Please note we'll need 6.12 version at this point, too.

Perfect, thanks for the reminder.

> 
> Best regards,
> 								Pavel
> -- 
> DENX Software Engineering GmbH,        Managing Director: Erika Unter
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

Regards,
Tommaso

