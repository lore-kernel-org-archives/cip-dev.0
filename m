Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D54D9C28B30
	for <webhook@archiver.kernel.org>; Thu, 20 Mar 2025 10:13:17 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.52])
 by mx.groups.io with SMTP id smtpd.web11.3938.1742465587123197487
 for <cip-dev@lists.cip-project.org>;
 Thu, 20 Mar 2025 03:13:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=k39hACyo;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.52, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j0Rn33744fjdm+Pzk8m+ZBD8IroT1VKT9aSqPcyWU6Nz89XGM2UAmtNmEIIHehDCK0KGDF6taHqejdosIZDUE4k69vQ7XWJ9sU2jRwJyw+WPSb5XlMLZo8brt/ZKQiYoQgTIuyPaZcZWMPb8K6lnVfcRPS8EYRYsOOCyF+Cl+perPNY8FPxDTVJq7VKyTdZveb2cUTLDZFPOYNAr4slU2jP2mJ19juFp4wP5y3sVhhvBZfwyl0bLohCf9l4oscVCRWRWautXwu4UOGKPIHFBAhCrnwf3Q0CQ1dLeQCSsjX5swqr6i+UD+2CubB54B3L5n5jn0ogQnYaUkfhxXmjXpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YDBmesCsPjQMuMcVX9XZloLt+fIaLP5nnVJiuQ9eACI=;
 b=xKJZv3eAwGI1SHQ3IKt60PAnvxj1Y+gYwX3jbE3BZSiYrUut4LPLYhwvRmrhqeETJy7mZQlgD6IgUZIlcWGU9bZJ+OQL1Wef4UbLpuBoacAyHTvDZx3isS9dSkDpMf1+6f+PA0WMx5J2ytXRS7OSKsNWj/NJfMjaaUQl+3A7vNHb7aEIWaRklO2v3agibvwy0uP93jAGjCNjUoYs/0wGEDeyW0Tr/PFUSdsZEnrLUAuoh7FsGL/Bj+N6cG7F4kf85hPnjOc78ZKxKznwTuQu1g53mH42b5n7n20Lp0X4fUBFs0OcTICfBS5vNsSqQcOs5NIGi6eZ44QqNJoMdYOENA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YDBmesCsPjQMuMcVX9XZloLt+fIaLP5nnVJiuQ9eACI=;
 b=k39hACyotFFQUAS2QNG5SQgofrcMPyCjZZZmxThuTlKES0i6NDhHKeYSkG/bD4PLYYCit/CKS6WJdK832QP+Ly5JapJ9jmprkjb34Fmxq+vNXYg9OG1xOsBxPDqoFjoCvQ4dOc//896AHu8O6OVXJIO1891PEnMMCNAgj7pZt3g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by OS3PR01MB7310.jpnprd01.prod.outlook.com (2603:1096:604:11f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Thu, 20 Mar
 2025 10:13:02 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8534.034; Thu, 20 Mar 2025
 10:13:02 +0000
Date: Thu, 20 Mar 2025 11:12:44 +0100
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: Re: [cip-dev] [PATCH 6.1.y-cip v2 00/12] serial: sh-sci: Add support
 for RZ/G3E serial driver
Message-ID: <Z9vqHMBvy1O1qB8i@tom-desktop>
References: <20250319101629.2407727-1-tommaso.merciai.xr@bp.renesas.com>
 <182E2D5440856AF6.20726@lists.cip-project.org>
 <Z9qcRBPx38dI4QtV@duo.ucw.cz>
 <Z9qdLZ6MSVEaMpj0@tom-desktop>
 <Z9vns4WDhX0uvZ2N@duo.ucw.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9vns4WDhX0uvZ2N@duo.ucw.cz>
X-ClientProxiedBy: FR2P281CA0089.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::15) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|OS3PR01MB7310:EE_
X-MS-Office365-Filtering-Correlation-Id: 444bc2f6-f894-4e05-8972-08dd6797cc9b
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?zvv7ctq3W/xlGMo8HqxkmJ0U5t0EcXxPeBbj/Yes8jRP7b8+g9iAdO13FVXO?=
 =?us-ascii?Q?UBWrmgZtT8fOKwg04D5bVQWLUWBc6H+N7lTANeRdBbniGlEG/C6JU2iz23/D?=
 =?us-ascii?Q?1HzyyZt2q1CYF9MXIF2Dmhmxjwq+TwvXOo5sI3Q9WL4bu6ca79vRppOAdI2A?=
 =?us-ascii?Q?s5vShiqJJfh1EJUOKIjBr802L+Hb9HgmjHtqbHussjn0j3Xu62D9P7D8PoFx?=
 =?us-ascii?Q?0fxGhv/2qcBUaN0qJ6T6ahPi8qoe8Op/KKUfRZ/n4S6JKh6KCHAVO5G7dpAD?=
 =?us-ascii?Q?vNtzCY6Fd2uJvS0j0RJeEkbjTnxLK9FM8Qfg0TcNlNL17vqLaal6C8Wbj3vt?=
 =?us-ascii?Q?6Suk7f5rmA9+rKqzdnYgExYvlVbEKAQoOKllU9WtPYfzsOXHoY79axEC4mTx?=
 =?us-ascii?Q?GMGS71kHTVSQ9K+aQpmqFOhVJHZOciCEmat88VCr0bxqqjPGUSsm4HVMdh/f?=
 =?us-ascii?Q?5H/CrTn8kGr6yS58Qp0WR20Z6qcFqc2UD23Dr6b1AShje4v43AVIMZ6y1keg?=
 =?us-ascii?Q?StuRL1TguIjcgJAhY+//1Ljd1o6imUViX+Tpzt7rirBQIlWEPum5hkAizLdZ?=
 =?us-ascii?Q?ruFj+M5hpMtK3t/NejEWF9jHlWs4ACG6T5lML4Z4jypa+5CTtjSIW2Hjaqfk?=
 =?us-ascii?Q?S+Q9kAhKAzTc1Zk6vWrNDkOTBtcrb+SLhTal9CHw0N/0JYM6X/WnQIPAyUVX?=
 =?us-ascii?Q?/o06PKzN1ooM/g706VOpIZj/g8l+ryY7EYaAY2+yHBlRQz3z8ESMs5lAm5P1?=
 =?us-ascii?Q?lSRtDWGB8l+sObKEgQnXnjQN6ZjYCx1clLI7AaJZ94e/B5T/M7Tz5FBClzVW?=
 =?us-ascii?Q?Paa+2mfn9AYYHw+yOyoHJT5NaYK7doMRjQrt8zbD3GTFC/83SHUAPDFHYbyM?=
 =?us-ascii?Q?JEwY55L6LP8I071l+VIepsi5uTyHax4VGMtOih+U9ZgmScbV7sgeIm+eWaLR?=
 =?us-ascii?Q?QwQqy1kYwOtuN8eEg+z+/u3FGg+Nf3TsN6xzrKi4f85yz1TQPi/LUm9BhfNM?=
 =?us-ascii?Q?9YwDy8l7xMEZWosafpXDLxg1OK6wORMvKWLb63Czg2yGNq+kUf/X2Ha3eoZE?=
 =?us-ascii?Q?IEz6S167aewuyHNUE+LlZbNxIrtwJSUqgwaiqFMBfRSrgkZdTInQ0XWRC6g3?=
 =?us-ascii?Q?RCNt4xfrADVWlSWlPd+Wl9b3R7gbjbS7rdi2hgZKj3oL4Jx43EhvkuI+JFn7?=
 =?us-ascii?Q?6jEscjgnKzTpJRhliWFDUO2TVkFeGsRy/XWmW04ES6ot/xDdgEIzS17qsuv7?=
 =?us-ascii?Q?Ct2tdagWRaviMrXFCffpgp1otFtbqGbc+l74ml0Yp8n4jP1dob98QjIowl1M?=
 =?us-ascii?Q?qur9FL1oYqQdgGrbl8SvjFfM0gV63z11eOJDjukd5el8XzTQNdZhwA+klDMh?=
 =?us-ascii?Q?fidYeH8YGayERnOr40EzePUedjm+JZKaoQOsuHw2XcetEkUDO/jhLhPPY2mN?=
 =?us-ascii?Q?rSju2AHV5pJ+vnUmwjJb9LHCM4iAbPiv?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?lUqPbUfP7kjZtbpCve/sMPqIbpJTlvbAgBoCSajfep6GWCaBAZOK/1Qqee5m?=
 =?us-ascii?Q?sP5ew1pofNxdERIc1GhW3vrg+3x1s7o2gfLF3XjK8Q48w3Yg64ycvafJdH75?=
 =?us-ascii?Q?l509ULeRpm3ur306DW+VozWd9reGR+19U3E8CgMDUpvtlUMyj9r+C7NmvPao?=
 =?us-ascii?Q?yAcgtn1xiBFqRm+fpDa9mj92DXuTOBna5lgfFAQ+NPH6U9KNQeXtwOqYHGrd?=
 =?us-ascii?Q?3GhtNfo9xCQwxI/fNZtr4Rj2Xr9snPo9BqIXJ3VBtVCQuTyEKTx63QBbszfR?=
 =?us-ascii?Q?nPxNSugXBRyH3kJ24Q1Vqr9+RGivMlSp0wrFR8A2gtBsSoZ6JQLkEt9BJeUu?=
 =?us-ascii?Q?G0yF6AREiOtrNCAuNKzYBuQAWvn82L1F46ZKySxknWn68EK1cw7C4GGhBYk1?=
 =?us-ascii?Q?5Q32y9QORluXWg1FaprTbZH+9sboWpsshFwwrW2+cy0HgoGJTu8PmjXchUoP?=
 =?us-ascii?Q?F5PfzKydrRX6Ey11vKaxzkTp4gYJBq58MFgGP0/kFGWR7v5oT+i3eqPJ9NKU?=
 =?us-ascii?Q?zNULey065ls4ta/mnX/i7vwJWYcz3VK+rq/JoWbog6tJvNJ97ncGGFIiOh66?=
 =?us-ascii?Q?2nhMXinm0T0Uz756Fq+elo2Uo0Wy6Y1qTq9gJiOvlxLLmMGmAAmYrRKNh2PV?=
 =?us-ascii?Q?U9fRS/Pkdj7waEzN+hPilEPsyqcAsuud4HgACvh7RnGPBVJNl0DyjhB8AUuk?=
 =?us-ascii?Q?Goprc0Mvr63K95hj8Y9dVcM69mCYHrGRptSNw7tZ1OW4/QMx4Mx5m86xyLEm?=
 =?us-ascii?Q?vYv4TtSuy8THtGjALYsHw6mOdY0qHWtKv505PyKXAd/y4e3Qdj4Jdv+v/6yf?=
 =?us-ascii?Q?OH6olAk9Wteg/4bHMroD/7X7HTh1XcO2ka58Rhlp2JOqNY+e2k6HtGe2+h7P?=
 =?us-ascii?Q?4SU3S7mBtLX8zNUwLkYg9Bt0AY2NRQEBADknRmU8I1WimJKA2OYTcTklMd8a?=
 =?us-ascii?Q?ctwwaWB+28/9S6ZFKghR7gbBJsaHYR6e6JeX7RzNa6y/YouItgcQ7DYTp/hm?=
 =?us-ascii?Q?n8W+2zMU5z3EB9keP46VkFCCkTPDGHG7EzeTi6fcdMeWLIup3/IHdC25OLFV?=
 =?us-ascii?Q?q7lsfETL+WNbkDeYgnjeRHut8d6B5gWjb2TwIq23NDTwhVxbKWzzZej+ipfJ?=
 =?us-ascii?Q?ociAj8pBMzoSKBCIKPjaQ8SJ1kE8d4roDnEb1+MVRlQ0UZW3cieobOxF5jdB?=
 =?us-ascii?Q?ziBh29RbAnFix8cQd5W4AA0DrPZf83bGcxMMMuhmyLOQ++eGASh3CAB4Fkbt?=
 =?us-ascii?Q?eTc1peggt09WTY95SstbOw0GQJZvdft6+oFkUykp44Z5At0Ik05QEJF+Kyle?=
 =?us-ascii?Q?QqaKfBhkLbrjXcBm8E9or8fqD5/e4N05+NWD0F+6Urn9/tMLml4lnUpUGDyw?=
 =?us-ascii?Q?0d+YMmWYDFnY097PETF6V60cKHpGtHR6tS8rO33QK6bHrxtQKR3ObrHmsCxH?=
 =?us-ascii?Q?GujsL++RDkXU+nWwvMDtU5822e8VKAczzjfL/WSeM4bG4rRkWtaHY00XVtwh?=
 =?us-ascii?Q?gzeqRdEdsZazTz8KTO5Bd5R1IgL4rKj7d7GwYvnqPZvHAg9YtUvma8QTlgyJ?=
 =?us-ascii?Q?0SNExy7nx5W6qayYdhM9JtDKqs5Thd6dh1ljb1aUuZmb6U4H8IwmyLRFjQq2?=
 =?us-ascii?Q?9sjZ0n8k+bmSjLswrXHV7/8=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 444bc2f6-f894-4e05-8972-08dd6797cc9b
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2025 10:13:02.8008
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VIICKtmxFjNJfg4Ef2IdPboF9tesN9obATDpTrnYX4KMprIkTRC2YH/gsvodNnQjLSdvBMbco1zfTde/PyRMf0FIEPxMasxw6cFLG3yJBoKQaDkZZajL5ujPSjIXLKi8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB7310
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 20 Mar 2025 10:13:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18291

Hi Pavel,
Thanks for your work.

On Thu, Mar 20, 2025 at 11:02:27AM +0100, Pavel Machek wrote:
> Hi!
> 
> > Yup sorry, I forgot to update the cover letter :'(
> > Basically on v1 I missed my SOB.
> 
> No problem.
> 
> For some reason, your patches don't seem to hit the cip-dev mailing
> list (?).

Thanks for let me know.
Mmmm I'm seeing that on [1].

> 
> It passed the testing so I applied the series.

Thanks for this.
I'm going to prepare next series with a minimal support for RZ/G3E then.

> 
> Best regards,
> 								Pavel
> -- 
> DENX Software Engineering GmbH,        Managing Director: Erika Unter
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

[1] https://patchwork.kernel.org/project/cip-dev/list/?series=945527

Thanks & Regards,
Tommaso

