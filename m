Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F76CC282EC
	for <webhook@archiver.kernel.org>; Fri, 14 Mar 2025 11:30:24 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.46])
 by mx.groups.io with SMTP id smtpd.web10.12027.1741951818645788007
 for <cip-dev@lists.cip-project.org>;
 Fri, 14 Mar 2025 04:30:19 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=Vi9t/ksI;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.46, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XhMfqwjUwpr75U8Cvu/MiSE0DcGIfqKMvuBi24u4Yxyl2SEha9X3tR1W1nBeoaGUokvHxzC/+5pEj9MdqytyY5QvioTOTV/mQ6ymtv1vGM5aNFUuKL0Hex5LGXjW5OVFHZxej3YpBlr8H7mciyi1hf8pM2BZeJSh02sdOAkv3u2ASQ1xcxtvBfFYKcoYCf7Fm9UaX8/6SVsehUD1iIdnMQE5jwzhud5JBWV2dX3qMUCE3byfcatTWCO47rEsg99xkSohei8e+y5ShRWLWT6jJJwt93N6GbU2jwRiubqw/qAYAGEdzqNkuIz5toqck/fkKNpW+XkfE6bF+LHaArEu/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e5p2BUpCSIoQ/qQ5dY+OSLqfgIYohFGBePTzb7fkOMw=;
 b=OPYF72QdVkC8SR08dYIlGj3sS4VSGL1mApPaVvzGj3KCuLqMvrCqZRc3M02ZywY1Y3acCJUiWJEAp109rilDUumJE5iNz/H7E9fo+d86aiAHXeQR+1yJ9JE4CnzwESBFiZ1FpKWZSfiSg1qF7p0ZAW1PJGKDUgk1l+7+pEIWMOvEn8nBFaKE88CuS4K9bNj/G1+miv7sVIkSK4T0yDNqLYmkv+Hgp8WCSP3MKTM6DPI7kbct3my/SldZoNxBPhlFujMCbF+k8aYqmQW2v4ZVJve2tIow6QL1KSft4yiHOkb9sa5X32nOKG+IDD87faGLcWGNBzbbkPqTTntEpfQMzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e5p2BUpCSIoQ/qQ5dY+OSLqfgIYohFGBePTzb7fkOMw=;
 b=Vi9t/ksIORNsNyNmVGltrL/CFKUpxhACyEjdzblLQJiNuASQXHK9awZCeqFRuSkskQ6H+seinGuzTtDekb12AwIRxtoJyiAhmeGDFqK/FTctMlyoEjK4UEan5hA3/zjJwQifGddmjodEOilojfhuYh1mbUpF8GWH8wKauYoypng=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by OSCPR01MB12722.jpnprd01.prod.outlook.com (2603:1096:604:33c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.25; Fri, 14 Mar
 2025 11:30:14 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8534.024; Fri, 14 Mar 2025
 11:30:14 +0000
Date: Fri, 14 Mar 2025 12:30:06 +0100
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: Re: [PATCH 6.1.y-cip 00/85] soc: renesas: Add RZ/G3E support
Message-ID: <Z9QTPtKb5Y3E3vqP@tom-desktop>
References: <20250312112302.1605750-1-tommaso.merciai.xr@bp.renesas.com>
 <Z9K4sW1iyC+0lJCg@duo.ucw.cz>
 <Z9LHJC92Bp3HxjT2@tom-desktop>
 <Z9P/qUzPfn368iGo@duo.ucw.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9P/qUzPfn368iGo@duo.ucw.cz>
X-ClientProxiedBy: FR0P281CA0071.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:49::10) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|OSCPR01MB12722:EE_
X-MS-Office365-Filtering-Correlation-Id: c209f89d-ad60-4a2e-9cfa-08dd62eb96a4
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?G/SdgPuoMvnV5aMj9fI+z0Lt2hHwlgh5/GmhMuSY5ucASxFxlK0DflqNuU+R?=
 =?us-ascii?Q?bJRvUoJsilvqC8yT0yfQuRJ90FaWNbUYWQ1mxd0lnnTRL+BZhd5eh+LXQ+2u?=
 =?us-ascii?Q?NNWJaeWyj3pv5pl7YSVxqwE99R5KfooO2AkIc496nCW36WreUQqANX6K/g/T?=
 =?us-ascii?Q?5OnlOErmlKsAx23pHG+A478TrE/FRqYl+sHRr3OH5qujC0dM0zelOY9de/sC?=
 =?us-ascii?Q?ItK/zu8JPhKPABZCwYewrqfucVNLKdCTTw8YdUx5F8okTOv1VlNTJajjGdho?=
 =?us-ascii?Q?8twyqK40n6Dmwmt2PTM+zG0Ww7vrmDOqKk3HEWkSaiSKz/1hd858F/fZ424i?=
 =?us-ascii?Q?T00QD6CAi9isymHMRebOWImktNmloph1IbMdNvU+OAmM3AI7MNw4KJ2QZ6sN?=
 =?us-ascii?Q?7iD0gMsDihV/ORrn7XBs8XKKfhmjx7mvN92r3A+5EtKmRvSq00WlWkrEGwVK?=
 =?us-ascii?Q?luWRE9NsajI35hq5ODUDLZKRIedVOrvZwCn1VzkAAYgtSdDHKqrZC3sycHBM?=
 =?us-ascii?Q?owwhqI+fIlg7WXpwrDEtId7ofXo7dDsm/nNbg11M77XdqPUf1a72FkVyyJ9T?=
 =?us-ascii?Q?KTzeZGbV48IdnRxF49hWFmPLhsU3StqS1kChlGYcwO7g16Es0/kShZQQtQYY?=
 =?us-ascii?Q?aXFSYzvVo43fDUnkKht0yZX4AwyRXbgubFITJfm/fXklJF1fyEVb7pfa6p8Y?=
 =?us-ascii?Q?u3/ogjVCLWwQZs+67sOQppNc4bwopSuMR2q3f0i+p+evPY7b4WISdcVpb5Zt?=
 =?us-ascii?Q?zNrzWj7YpLyjhkxCocVF506hBJNDdTa16k+l+jC+W9l9WgcuLPhb3dnNEowU?=
 =?us-ascii?Q?hHxWKKPhVsIkO7HIepHMPvpxBVCvK05AUep7NJlgZHOENVD56CC62gx31FKf?=
 =?us-ascii?Q?8fnnreYmJc/F1rY7Y+hTc8dm1ffkNoycgipkrFWL9kaj2aW7F7elAOIItFjx?=
 =?us-ascii?Q?sYGKcYM2m/Q8F6wKFEqOOrvNdhE7Xb9F6wp97Hf/c8JW4aEntmX6/xQmrXLT?=
 =?us-ascii?Q?BmYxZMAnz9avDeI6IuauS1905ylb06i7NDdWqwp9HvqV2ITTtcPkGG29tbvP?=
 =?us-ascii?Q?/hDy3/quvXhjdyaZBkk0vGJhe8Ig+N226f0Cg1mxFYAU5AJkCp/l+u8bkiDH?=
 =?us-ascii?Q?YsExVXT+9+7GPklQubvqNQQVkfU5W/YMAVEWK0kAc3oM/sv09oZn4ipneyod?=
 =?us-ascii?Q?Jv0NMykRp/gZQxWYTcaxrj5DjRnWbba0Ftx4G+wPW0QgwAtNVl4gn+kW5sSS?=
 =?us-ascii?Q?TRbr6oVwIG6AKDXLzplHBX7Ip0AyqHDQuywoYqutDcUyGYljDGd3vlZHuLF3?=
 =?us-ascii?Q?tiR8JMpSLXiR13tBOfkQ8EV4dnIZgFYtkdBkbhYlTuMgM4MmpiByjjuPs44m?=
 =?us-ascii?Q?8mGj6HEv4ld/GjyMoSdRTKZJBZylQdAOd5N5X0/9Uz4q0bzpYbcNtJSRfpVZ?=
 =?us-ascii?Q?YYO1bhnHSUOFv8LT1t7LYld1PDoQ1fw0?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?z7p5hA83gWUFcxzXVruZ0CHSuTW7oeEtw0wWsVA1arzwBQ25l+ffmrXeObdI?=
 =?us-ascii?Q?OFs+rOBg6cpavlzJCuUGoktO+jTkzETz1rgUlwQOMPPKsTh/C552XHNg+dsD?=
 =?us-ascii?Q?41o2t6iFFFyrVwubIuu3qieWlHyEVyn49Lyw1YdF7Nm34nmVVmTRsfctrEBa?=
 =?us-ascii?Q?GpBnf1Ngw6Nrx5/nRNcGuEAzOEa6URjXLvY0RV4vhDQgsl3f8zc0ythD1G33?=
 =?us-ascii?Q?XxuOdNBiDX+qTH2/zhKWb3IAdasbTw6KgNv4qRmUaRMvMCaJ53LMmPA38Al7?=
 =?us-ascii?Q?Eg+HqwYUqdEptGCtRQucypEwNU/ZEynL3jikmRtGWkULlOSswkTc/YMFN82I?=
 =?us-ascii?Q?mAeBdOEHQAWjOXVxuO+2nyBRlT6B17xZtzFfLx/NU72c/heCNd3aj2LgG988?=
 =?us-ascii?Q?wTx0hOAuSReg4YwHcrAu1H4QsCu++czkf0yiGzlSBEWe1n9Ir/yykTimxq1X?=
 =?us-ascii?Q?+P0rTqloC0fN4qbCuGG/8eMHkWikrXlIlMXFg7wGXvlOBn+drYQMp7iRKJKe?=
 =?us-ascii?Q?Ne1izEY6GFdqJyQeZZGHlhsmwYGBcexZMo+zsusJ2UC2o9oYWQnayptzH76i?=
 =?us-ascii?Q?vfSoL8sYmTe2AtbUEN+nElH8lfL2TtHD893zNzhDr+S5lOYk6T8ZHLHP3Ykg?=
 =?us-ascii?Q?PCWvWJNSOqX24IYqDxb/rALVtk2MmJ7c6CLIhDHc/mn/4K1cEaHPVUyQDrnA?=
 =?us-ascii?Q?kqE/lr9VYJ8Si54ocHd/aVLCuCWxagHNALlbMBFfQlt6D9LYMN41MRmJ+sIw?=
 =?us-ascii?Q?3Apxw5sZB31MqaUbZwvMWE4VK+/s/QEvgjhQdrUiBqDoIXTkCud7Pa306me5?=
 =?us-ascii?Q?YZZGeJrB68VQqOaKg9h3qqqfQqDg0pMp9o6TeXqC9HTwDhNyAzE64fhCfCPh?=
 =?us-ascii?Q?L3kd7Z7OkpaAbBctOwEvrtf94i/r5eecDkrdaLCVUxx3aa1TKkyZREbIxm7r?=
 =?us-ascii?Q?JTPcyEe6OJM+by6OzkjrQOgnkKJgb4a9nior9PcAmObOiHeyASlNSV9Z2XRw?=
 =?us-ascii?Q?zcEbBnu3opMMcC6CVteyThqK4995WKhXmM4kOFPQ2fwL3fwyKwS60QtpAgWB?=
 =?us-ascii?Q?U8pzcLL0yce+q3uSF/bhK1udQbjDE6Qy9rVFp4pifFLw00IkEMLf8ou3ojAx?=
 =?us-ascii?Q?XU4rRgQtwGhRRaXXP0l9tccBsSi/Pfnyia9Zl04uPa/nN757SWt+Wa6EVarN?=
 =?us-ascii?Q?LLrVovqHwPoUu8+cNrP1RcuvXAu5hr/tJafEMVdoMjPQACU/HILpM/1aLoF1?=
 =?us-ascii?Q?ynUk2Af1XH17IMKaQHTNIG5/c6xUrns/gQHLljkJoXNrQyMK7M/dyUAo0zVv?=
 =?us-ascii?Q?yBIipLvw2OKuxU9xmf5j4m7/ANBS9yociNPb4FjCtRPDDuPbqwiRL+e9eIpt?=
 =?us-ascii?Q?zA34b0uSQLO231mJWL8XF3iaqahyrpiCsV/XfDs5V39+yMGnQ6YuqgsSaB9W?=
 =?us-ascii?Q?0J1HKawkRU3Xd6VvNatJB9P6JJX4YeLKPKlNzorT/mNb1sDe7iYlxi5+1drl?=
 =?us-ascii?Q?pLEr5B3Rw7b0N75dH4g3DQQcUDeK5H1U3HQ/XEDyZm4g5Nog/domUhDQ6k79?=
 =?us-ascii?Q?1wzinp+VQTe5F8SIU67IIvHkTDsmo0R8ThG0/hVApYhitiDOXETlw3uZJAIT?=
 =?us-ascii?Q?NxuXNrYTgIzISjj9Qjsa0TU=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c209f89d-ad60-4a2e-9cfa-08dd62eb96a4
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2025 11:30:14.4067
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QllktgauZNizZTiWBcbWQMiBakaHWf5FX63EyUa/F+lW6800RCwQ2WTQHShunTv0f46pgiJCAFZXoM1rqP3qOZRD/xV5yTQY0CjFsPC3FE96ESi7UYUc9hQEe18sO458
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB12722
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 14 Mar 2025 11:30:24 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18215

Hi Pavel,

On Fri, Mar 14, 2025 at 11:06:33AM +0100, Pavel Machek wrote:
> Hi!
> 
> > > What is RZ/G3E? Is it new generation of something? Is it used
> > > somewhere?
> > 
> > The RZ/G3E device is a general-purpose microprocessor with a quad-core CA-55,
> > single core CM-33, Ethos-U55 NPU, Mali-G52 3-D Graphics and other peripherals.
> > 
> > Here the first introduction to the kernel: [1]
> 
> Ok, thanks for pointer, that is useful.
> 
> What is relation between RZ/G3E and rzg2l? Because early patches seem
> to be for rzg2l support, not RZ/G3E. Splitting those preparations up
> would be good.

Thanks for your comment.

RZ/G3E and RZ/G2L SoC have some similar IP's.
For that we need some patches for RZ/G2L in preparation to support
RZ/G3E.

> 
> > > Why is it important? Why is it important for -cip?
> > > 
> > > Does this add complete support? Or just enough to boot?
> > 
> > At the moment mainline supports only boot. So same backported here.
> > Going foward will add complete support.
> 
> Ok, 85 patches in the series is really a bit hard to work with. It
> seems dts is merged quite early in the series, so that should be good
> place to split stuff. Could we get smaller series (perhaps 15
> patches?) with only stuff that's already in 6.12?

Fully agree.
I will split backporting in smaller patchset as you suggested.
Thanks.

> 
> Best regards,
> 								Pavel
> -- 
> DENX Software Engineering GmbH,        Managing Director: Erika Unter
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

Regards,
Tommaso

