Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 132B7EA3F27
	for <webhook@archiver.kernel.org>; Wed, 11 Feb 2026 15:55:08 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.9])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.22331.1770825303313728990
 for <cip-dev@lists.cip-project.org>;
 Wed, 11 Feb 2026 07:55:04 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=WqgxBXuJ;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.9, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SQRsvC3ieBj7o01v3YBSkIByZs0dSVoK7VfZ4W0fSl39FIxAfqvhvlF/eoA815eTb1+F2hpluH/Ct8oP3W5TAhuRg/XdCX/Cje/WuZ3zRevJjn9kQrF0h15lZh6olidv4Lm8eY+vZlIEbk6mOt1azgsBhOKSWvYC0A3E7f6qlSRi2QEqXGGeHVO9W/GcbDLIS9r7UyNcIXYgs0pN+KH+qqa0yG5+6Q3uwdb844rMLHpXX7jba7Z7M0Rj1qm+K/PTnM5tgvCNRD8Sijfyvo7VjHAPTWGi7lZ1nZBWTkBJtdJuQsGE+MsCmjnH7s8ypDhW1F7iiZq5irQRWfoWGljxtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d69mO1Qky29H/K6qIHnuZE+VdZuCtZmPhtC3was4mis=;
 b=AFa29c5C7kox/qfaPrt1q43itNI4IXZeQp/+4JueDR1p0y0wGcd1Zz5JxChAaM1Aca1lZGPcmjjkahD3EweerEyNS8UMPQwjc6QpTGXVNcpSDy5QPIi46RbJfidEFZhjXTCtocyN+ctRSFZ3L/0r4ybPXMS90PrSOa0+vT9hGh2WbIWsdzxKmKUQYjX1Lo6nObW1sey54zyAauRsoKybsABuuqiyK8y4NsiW2F/HulXlMqOKgfJBZNBtyZdI+NCKfp7n1aqHUdndYgHYUNNPdYq+H+MmwL5OF4XvBkO4L6jVJLc+8lW+ux/Xkb8KtUNGUW5Peww/WfSeFcvOsg1a7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d69mO1Qky29H/K6qIHnuZE+VdZuCtZmPhtC3was4mis=;
 b=WqgxBXuJGTQGCbJPZjtbl3ZRZXd2FTG2awCDiXIgoIjUYjKJEfTMwIQX1annaLjSqM4yxZ5ld4jGKP1ytGe5mhT7aF/UmfGClTUeQsgOB1djmqO8/tAgB6vnCkaIsZtlkYoItEZm9BV1SwheVAI0Nt+z5L2XwPq5lsT+yZv7r4c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by TYRPR01MB16253.jpnprd01.prod.outlook.com (2603:1096:405:2ed::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Wed, 11 Feb
 2026 15:54:55 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8%5]) with mapi id 15.20.9611.008; Wed, 11 Feb 2026
 15:54:55 +0000
Date: Wed, 11 Feb 2026 16:54:42 +0100
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: Pavel Machek <pavel@nabladev.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: Re: [PATCH 6.1.y-cip] i2c: riic: Move suspend handling to NOIRQ phase
Message-ID: <aYymQmVrJ2Tt49Zf@tom-desktop>
References: <20260210102747.484082-1-tommaso.merciai.xr@bp.renesas.com>
 <aYyRTRXYwG57A9B/@duo.ucw.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aYyRTRXYwG57A9B/@duo.ucw.cz>
X-ClientProxiedBy: MR2P264CA0169.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501::8)
 To TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB11947:EE_|TYRPR01MB16253:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f1c210f-fea7-42df-45d9-08de6985e6a5
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?6IS4TkyQSnxnuzDiOLNhZR+npxgb8DnYh4z1CGnUceCpL77zQVnD29zH1fPG?=
 =?us-ascii?Q?uB81nrjRBtM7U3WVi0rGj+siv5KIWr3aT3Dx5kTdNCWN9CHNQQp8dcmplYC0?=
 =?us-ascii?Q?Q2H889UfujPcu4Kv6r8DNXdTRKygG8IIXkbRQi9pBEFgokhayWAyvNGzB6+i?=
 =?us-ascii?Q?0CP/vYR3vyK1AvwOXk003Cx4RYOkf9dw9HmgCFsF75CBc/ajEafnTllwVhlb?=
 =?us-ascii?Q?rk9aCtCAZZOMHMENC99qQ68LGTLl3BHupzW94vY4LOKqxRkBwWYxBPgvSoVH?=
 =?us-ascii?Q?djZxw7DuHNp4hIyr2lKi2VxbUS0//yfP/+TqIx50KcPutcpZGIW8JnK2CL6v?=
 =?us-ascii?Q?k/CvM0tlY27x+pfwfgNlXng2eS0mF4ZWMoSahKzh6vQGPyG4ytwn/57p18oI?=
 =?us-ascii?Q?+6PSE/m6y4hMKFxLLmLn7foJX5BlSevMHFA9CUNI8+sI9S0rzeZd4lsi7upf?=
 =?us-ascii?Q?QPSZvN9bwaFEcUECOEwssij6avH1Aw7xhZduscx8+mABNzUCHwbNuxzfeBTj?=
 =?us-ascii?Q?NoMZdXfkBEnp2g/LraxNrdC3Ili7E/9Xi9fN8B7VV9eaAEJIQXEFsLrstVWt?=
 =?us-ascii?Q?kJzzKwVBF2ADVp35mQoD+l3QLNUqw+dabeHx6QL8lA9wkaU7Kigzn5dMFah6?=
 =?us-ascii?Q?AFtztsZdWayHvrjBAMXVois62wcMa93/p36BXhwbq2aFNA3RVjMRoHk7NcJO?=
 =?us-ascii?Q?iSSh4RHXfA0LlaIpXDrMAdUlbbMiMUrGL423lor9FJXRXQCbhub+cUz0UMN7?=
 =?us-ascii?Q?RksuWfiBo3mk6lBnWTBqXDkuIPfrRY9piF0g6tkv2DZgRXS71i5T7/QRyNDa?=
 =?us-ascii?Q?QtzNi7s3tQ8w2c80gIl5WkIHlONHNQH5KMZmhm70S33A0QqW5b4uegWn6mpm?=
 =?us-ascii?Q?FqyR65aETT+ZiuNnaJ6/ddPzXGc2FCaW2MGkIkytzwEbr5Op4stnsk9QIz47?=
 =?us-ascii?Q?2OWW4U9a2XKXGJBGYWTTKoeP5fGZbch8bm5wlKbzdmqIllWL+nAgxlXFSGZi?=
 =?us-ascii?Q?hOzZIKijoBogqNP47+sG9jZFm1vd4bcDb1+ucqHOX6fHgF/CmWVU00oWOF+h?=
 =?us-ascii?Q?Ah2Yt33nsFwscfLQIBeKSk3uk+URoqJNhiUt83GboOwJGKhirVav5b3jrICL?=
 =?us-ascii?Q?WdMl/iwazXz3vjjbsrqOy7kTwB0aGmpsK4tJhEUJlGcAn8eKrkZnDklTsVNV?=
 =?us-ascii?Q?ME2+tiihgh8kX+j4EH0M5sVh95pgHccoIX7Y59jumELUf8q4xcLE3LG+C3cQ?=
 =?us-ascii?Q?sNJGGOWrI1ozbds3P3tlu/ViEzSLH86w+b/HJqfcFfL9db71jt9c1nfIEFuo?=
 =?us-ascii?Q?i7yQRlsmHnIXHTu31M7LzRl48aBQnTEntE2TgBJpLeINK5R1MhpFcvqHu0aC?=
 =?us-ascii?Q?amQthJbaJv/xH2QNnilL0m2tyE43Wn+vZvMIHLROc+nyZt1SUFCzt1MfZOYz?=
 =?us-ascii?Q?gN4AQJvsygKJJvpHq9Vu4/RkhSDtG4I6FhXYImNpaPgN/qUwzJYsCcLX8rk5?=
 =?us-ascii?Q?bsE8xIs7l0U49iV+DRinsnrHSFYUpJlp4sPyslaBwj0euKSWfEMIwZkj2048?=
 =?us-ascii?Q?llclwbxkyVldOyYpjQI=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?ps0w3YtmVjfJ81MBk/ztR0iatSgmbwHj4jxvCuau5drxkhiWA50gYh6DiaF3?=
 =?us-ascii?Q?/sNCrc72qkmCpSsilYeYosxjk6UerkaAlbDy/+Wa92XJyqmvjR/TaohrwtcL?=
 =?us-ascii?Q?SyE6N19vsFodeOEbnEvwbeV96GDQEZQ5yqOw4o+3k22FrL4wMthVGu9XUF4r?=
 =?us-ascii?Q?l1RnB+GfzyMOGTLBYG6AXR5ozbQBgGFydgyLfgsegwdo4JjY5Eh626FYuZUT?=
 =?us-ascii?Q?nECzefA+IPTrG6BEO3GC2nua9o8UBbS9/ZF9xRAbrTCZVhL/0pXudV25sHSR?=
 =?us-ascii?Q?VwmbqEjbdBwxOTU4ZC6szFe49ysuK4PqfTIB070c1e55rujZtN09CEegCAFY?=
 =?us-ascii?Q?g4Hh+pXkyK/xEN2UDEbUbboivkvn1wOgjTYckzimKVZUwERqWmyL78Q3GYjn?=
 =?us-ascii?Q?YQnoLM2OWf8w3ZaTOXU9u1UQE66YakNhvVJgmzlVbNgAdN074LzXF4YAs18f?=
 =?us-ascii?Q?QP4Bsp5gZRKGXmRStsOiZZsJm/CL9FHjeuzM7hAyFQyYWn1Rn28F1K5taRaL?=
 =?us-ascii?Q?3pUDtcm+Xf46uWk5CNpf/Xbx6o9tfTXQUTg3SlE3KrHizLDe59E3FixvFiH5?=
 =?us-ascii?Q?QQpggvszG/6Tc+34EQGJ0fqVN7ssO0yiKiTPhaJDLKgk4bin4x7l76NDJIHW?=
 =?us-ascii?Q?jKO5Id1mbm6u93qOJD7Bwp1q4CooWogQI4xExCdT2WTzNYcIZ778Z10VhMQU?=
 =?us-ascii?Q?BN/GmLhwB4i4PK8EJPm9yY9gtHG1xqwtq6344BfB3PCPCnRqBoGANp67irZt?=
 =?us-ascii?Q?N56MlxGaskbRZDoCt7qJqe3aAcG+vb0zEwxycbH4Msu/vwdSEYuvff1kxB0X?=
 =?us-ascii?Q?hF5/mtLm1SM0tKvgNEJbnTFh40COQUtmPabFPcczelH3yjsUVwcNKEemxFId?=
 =?us-ascii?Q?wrd5YAhoXPTU+uY5gEKYX3jFP5HFeOZCgG9yNUmfH2w9gRT4EZwux0QZo1/L?=
 =?us-ascii?Q?6NUgQBpe42opn6f9WoU8+2oK/aKfEeitwJoMKdJR11zGWs2JuRWUJN2Ke7KE?=
 =?us-ascii?Q?Ugog0bQ4y19Nz76qYpvatVSfk5PuPQyp+99eGff+8MN+v6KCk2JDxeOWt3SR?=
 =?us-ascii?Q?A7MzdtftfNixzEw9QbYIM/q8tB690W8cw8ASXnQaV5+Yzd7+m3U3k7rIagoT?=
 =?us-ascii?Q?ka/BVVCGddER4NFUmSCtkimnUionGOKUy6SGmvV8ZNfnF+0AWuM2+ygtVgBQ?=
 =?us-ascii?Q?F0Bem3a3UZePImqam8xszYRbo34OwIgc6UwSi4VKoW+TsN/bqOe0SDwzGuaL?=
 =?us-ascii?Q?EYHRSBqwjdMI6oOKyZ62zrK5KxGB+1LzFS+X+nWwwLXA5sK8E4lnQHO7jpCT?=
 =?us-ascii?Q?VLGFP71rBHMinRZHiLjAnd2E+wJegJUqXzG1ftvnwFVUj4mkI7targyuQ2ul?=
 =?us-ascii?Q?YI7uLuzJD++jqjGokDugtgf1WJhee39taYsXMcA7BZUfF8Xz961BYR+jhKOt?=
 =?us-ascii?Q?WaYjnNhaA5Rqi0H4zuP0tYtSZFPgzGbV/Pa1I6vsbidP1aXr20Vz6U10v1RT?=
 =?us-ascii?Q?x0pUCuKg4xtT/hQTZnBekDvW32W9n20/xAHgZ6amYFoRWJblTFYVO/MPadFL?=
 =?us-ascii?Q?kq9gis7a7JC2p2P+gbQdGRATzVAHdL96msh+7Z8LajFYnfnF5s/0KbNLUNuu?=
 =?us-ascii?Q?PGGrwmwNBpT0fEIz0H+HN1CfZdtDWoW5eJZWbJ468cxc7ozp0bJ5hdN5zgoe?=
 =?us-ascii?Q?tTCap0en/+daBmDDOU1EKrCvAzTtsnMaLiv1lVH644Wzu2MykN7ChA8DOpy8?=
 =?us-ascii?Q?CWUK3DL1lBpgWvMECIl71YUQeulVU9EKHpQ1YbQDBDEQXjPLvriI?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f1c210f-fea7-42df-45d9-08de6985e6a5
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2026 15:54:55.5421
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J06cQJm8KP3LlJV8ZhxhGBO6QP/Ai0cZHNuWf+ryklzjhwQ7IyoV87PsenTykkaVl4S7zXbOdoqiIg3pa3hS5GrGJCqhcp4fUTqD41ABHm4VTUltanZ1Gj4dRpBGHwq6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB16253
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 11 Feb 2026 15:55:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21856

Hi Pavel,
Thanks for your review!

On Wed, Feb 11, 2026 at 03:25:17PM +0100, Pavel Machek wrote:
> Hi!
> 
> > commit e383f0961422f983451ac4dd6aed1a3d3311f2be upstream.
> > 
> > Commit 53326135d0e0 ("i2c: riic: Add suspend/resume support") added
> > suspend support for the Renesas I2C driver and following this change
> > on RZ/G3E the following WARNING is seen on entering suspend ...
> 
> I don't see anything obviously wrong with this patch, but ... do we
> need 6.12 version, too?

I see that this patch is already into linux-6.12 stable branch [0].

[0] https://github.com/gregkh/linux/blob/linux-6.12.y/drivers/i2c/busses/i2c-riic.c

Please correct me if I'm wrong.

Thanks & Regards,
Tommaso

> 
> Thanks and best regards,
> 								Pavel
> 
> -- 
> In cooperation with Nabla.



