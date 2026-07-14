Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23C7EC43458
	for <webhook@archiver.kernel.org>; Tue, 14 Jul 2026 07:44:54 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.68])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.4902.1784015084132738307
 for <cip-dev@lists.cip-project.org>;
 Tue, 14 Jul 2026 00:44:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=nEH91cKD;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.68, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ehFQEHWW8B8AtT63Kz36NR0Fel5aszeYZV5c/Hgd+JJZZ5P7sOgFFTZl6hv5rTvPJgOij+mu6CuaSqk0GWmrd3z9nV6zwNgoVBySO0nFONyUHto11T9fm0rREBz1i7JV/grpnVHZDmoXfM1T4OeFz1nEvc9H344gGzZq3NlrXJpqWcNndFK8jBGc99K0AF2qeGz0CBPJVVPgiiITkO3KLSdMAKWJ6A4WgC6m64fzBh7Gv62beT11Uzt4gSGGQnfRs9orp+l1H0eSfawDneU+0p+BPz7CYLmxblhVkHM5Lo3sH3fRtbzc3zK178PHbEfERA8iTdR2GVzwM6nfbUMjIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V0VwFMZr6EUT+C2VG1yEimazIMYewzvC/K0zLgX+9As=;
 b=XcOm9xHqX54+lsSOD/w0rWxt/z5u6xTqqy+OpmgAuiToYVOHi3r6U/UGlihHKvsdck/kuIUOam0NHHCoxeTtWS4ryzjDmwMFzct7oGPVRbXnyU2q7LzsycdAlczVV0OXZibg2ZP4hx6lMW9Nu6L5dlp5PRjeURq9+JIbmNaQleM9CH3u30Amvtmx7xzN4aT8ofDjSfWCUDuv49FhQRELZjY3PR5HZQYbIoivcsnACqRY5me28jB/51Qkkae8hhumReoal0lzbjLbLkHoSc1Gm+uqIi2dIG65z7imWZmQBkXYDITD9yh0eGMvujJzp/jsHRicD8TUpQYU1YQAV0Jw5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V0VwFMZr6EUT+C2VG1yEimazIMYewzvC/K0zLgX+9As=;
 b=nEH91cKD0k5zo6v+i56JmNydD1zE7Mv6khvbZsylX8obToMFSJGhv6X1iKXAo12OWCLm5tBcfylrfU6VjSsXAURS+fS8obS957EHXBNhAGxf71TSEUpNo440tcEV29d0MWLCTGFi7eVWyho4VYww/LlUelzSqc0TMP/h1Y19/rI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYRPR01MB13588.jpnprd01.prod.outlook.com (2603:1096:405:18d::7)
 by OS9PR01MB15931.jpnprd01.prod.outlook.com (2603:1096:604:3d1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.20; Tue, 14 Jul
 2026 07:44:39 +0000
Received: from TYRPR01MB13588.jpnprd01.prod.outlook.com
 ([fe80::2f5b:8560:48ed:3828]) by TYRPR01MB13588.jpnprd01.prod.outlook.com
 ([fe80::2f5b:8560:48ed:3828%4]) with mapi id 15.21.0202.014; Tue, 14 Jul 2026
 07:44:39 +0000
Date: Tue, 14 Jul 2026 09:44:25 +0200
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: Pavel Machek <pavel@nabladev.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: Re: [PATCH 6.1.y-cip 00/32] Add RSPI support for RZ/G3E SoC
Message-ID: <alXo2aQkK6ajqmaI@tom-desktop>
References: <20260617083003.1071543-1-tommaso.merciai.xr@bp.renesas.com>
 <akBCKNYSELOi93EL@duo.ucw.cz>
 <ak9oegpiSZVBH6L5@tom-desktop>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ak9oegpiSZVBH6L5@tom-desktop>
X-ClientProxiedBy: FR0P281CA0201.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ad::10) To TYRPR01MB13588.jpnprd01.prod.outlook.com
 (2603:1096:405:18d::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYRPR01MB13588:EE_|OS9PR01MB15931:EE_
X-MS-Office365-Filtering-Correlation-Id: d54f950f-9bca-4927-184a-08dee17bc25e
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|52116014|366016|376014|23010399003|1800799024|18002099003|22082099003|4143699003|56012099006|11063799006|38350700014;
X-Microsoft-Antispam-Message-Info: 
	E/iJWKZ7c4MXdod2SAGDOEcFwBWBQMw73rtPOLhjYxg/oVBrKQv7QGTDjU2WCfH/4RABTGwuhf0Q/OS8XsSNG5guuGVG9elK80vCyTgxU/XfEuf6EIrQaXWH8hGLX4lTEQGjjCedo7aBSyeJiQkzkBdLdnhnFa+U92DVfY4E4BFzx9N+Xrp6ok3ao553GysYyjcwqgOcCFCv6vAx3DizzDJ7AoxdQUrGlFwp3Ocb/VPU7VZvcEcq3GxkXbPXs7RGb+k/PjylEvw0VqNZ09uLsEPEAi1IZ7co+h61vqIl1UP8HmQk3ozkYF3HosDnjuhtmWcFAn5/ZDTE76Tc4HtFc9r6D68yffyUz8hohOK7P0NygvbB/8rvufY3hcHRdK2cISKwo97WvIixWptnRyAQ/xLIaA8vOW0tBTayEwoTyfxVInFMkujl9ylTJUDIbyivOoR76g+joqgmbJDFiGFBdtl/TC0Eo2XUb63sYSexlWdVnyJP+1LC7Hc8+w+TMh62dRiBrp0dE7S6GplX0WF6kCEe/ZtRYNbqoI+1Pem7S9lKAly3HpQGcS2CRlht+TVEiBQmBX24wYNW8KVhV4kDKul9B3nSk6j2C5tmTKW6EA5mTnMN8YedX7AncFxl8DUpnVW+j5DWd+cF7C6rsgd65ZL4Pfpx3H6w8pO+XtU4TWP8Tk78ejdWpSwm2juyy2ozxH44JRefvSQc4EjBQlCgGvmchnMovYH6lcyVurwblSg=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYRPR01MB13588.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(376014)(23010399003)(1800799024)(18002099003)(22082099003)(4143699003)(56012099006)(11063799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?HDlgKCBIEdboU3InRPm42m3+3+mIxFijTQufBkqmTG1F0pkHVcLircNbB/kF?=
 =?us-ascii?Q?oZdkgoRvuIHB5j8iFvdn9tD0n2MunZOBTDV5zBFSX1fyk09DTLGKsjNuPiGe?=
 =?us-ascii?Q?ieyaushxTaqzk5klSf5jy9vb5Av8CgiqWziqs0KKTL3ICoOHMHKUj6kAifFM?=
 =?us-ascii?Q?TTWUuptuEqu6Fk70VLXhvPBiDeyMJvq1DTmE3M3rIlNjVi2dyJ3QqHFwi90K?=
 =?us-ascii?Q?CaKway3VDFFgqHAKpzecQvsNPl2FU4+/nx3weOYvg9WyWquGfrsRSzOmSU+1?=
 =?us-ascii?Q?y2tMjBScXLA+s7zYEZn3B6I4nP1pbHyKDGNSm+JaiEZEBxVsLLm3WPSVdWix?=
 =?us-ascii?Q?Prh4AMrNZXhbN/64CWCsdqO8tS3HK5P0IangzlsIan35vFQVe2rRw2e7gft1?=
 =?us-ascii?Q?XcRpek3vblZrONYo+st+YZgrVmbX/hhRWMIRHOllPwcEdSYWre3ajUH1mUdz?=
 =?us-ascii?Q?OFpdyRxAp/3GINJrX4F87TW4I5g2imXEV90L2L3/3BtpGbo//tHIkVNYKZn4?=
 =?us-ascii?Q?ejqou9H9Q82iOX/AxaK7mP7qUQnXgtIjLGpJeRnmdH4tokJGJjS04T/z6Jzj?=
 =?us-ascii?Q?Udk4emXhvEWielFjF78a4ICcVvmxJmwCyBbet3uDaYSpx9Q8kO2Xm70uD6fy?=
 =?us-ascii?Q?IFz53zKLj5mkkDU24roL4g5pAmXABmIZFKjN+2Dd5hXuDXlE7yOY4MgOwZ44?=
 =?us-ascii?Q?/MSY8vY1QhC4K8w6GE4qeQDt139nXVEhyLXtVIP1cJvcpMHxCTxBEizjHIIj?=
 =?us-ascii?Q?m4sBSUeuhMZPIPNbp/vgNWwpwlDp76drCX3iKUNbkW85rFu2GOPAyBfpFuxr?=
 =?us-ascii?Q?ZSFnmR3hKMFzzfwsXZwVAl9rtEJGw5R01v2N1wLVF4oCvLGW6K5msdPKSGKN?=
 =?us-ascii?Q?YvJpqXiunHncnNJh8RdTHPcVTMQKQsSglM6VNDlqOK700RmX3NBHNDZ1GgQW?=
 =?us-ascii?Q?DBuoD2AgODjAIkdu1ZMgcTxx6BBoy+J2/3i/EvNK5pfXAOkfTd/e9uU5gcc/?=
 =?us-ascii?Q?JJowjvCgMAbCPfmHefqwcHNvPPP8/n99dym8zFwuXjkb1n9sAVhcgrCsRFwR?=
 =?us-ascii?Q?Ay8v6mPySPLuybvaj8E8yFDvE1nL3v31fzwNmZRatkn3GJBxvi1zMNoMVwvK?=
 =?us-ascii?Q?TSV9TvWdeO/QITL7YmK6aQLS20obVUCs29aPq6xr5s0oACiuJ4YvE0ZqOMCC?=
 =?us-ascii?Q?TdJcA2TzCUIysFb8+qSS2XENfhF1zsSN/2kPFInL5nO4bVVVFsU0Hq2FXwDa?=
 =?us-ascii?Q?kcNggjcb6wLXxUwh9Tm2sokAsuM1nMzTgnMNKgge8xabQ3xnR3jU4eVllU3e?=
 =?us-ascii?Q?VCXWqG1CpgqHn+POA5jDrJUnfaY/kp9SFB4GUcGyUfJfC7UkGz29sNR5vXyn?=
 =?us-ascii?Q?nnQCl8j360KZvHOsy9zKXdpeDbuqNm/0Q7zd43x1yYOhrmNmEowCymFFmWWd?=
 =?us-ascii?Q?FPWbGvGAwlC8gsTHEfPsd1OSwg7t3TRMZG6/NBvXAm8wMQ+DGgk9xB9CIQjH?=
 =?us-ascii?Q?UT9cCagJlW7Pz/8do8bTkwUh8TNcSNIn4PbVEkyfLLCoFhr5pEascq7Y5IJy?=
 =?us-ascii?Q?uYRshiEg1F2u5Z7qDRWusvZq39mF9/qroyA224u/VzGzdiB0RLMQzi3UGCRX?=
 =?us-ascii?Q?4FAQXj/6uV/0KoehFM/coI7k7OpK+5leNYdpejpH7nsRVTI623qmxwfPJa75?=
 =?us-ascii?Q?jVks4XzyMeHOKUEm1kb2ELoWksOPKiUzXk2LSSSUqPUCZVnBY/+2rKHT2muA?=
 =?us-ascii?Q?MowZOrEcRWVaYTFW3a3NAVudOVSb0BHaPJwj66HVlNigg8s9HYGz?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d54f950f-9bca-4927-184a-08dee17bc25e
X-MS-Exchange-CrossTenant-AuthSource: TYRPR01MB13588.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 07:44:39.5599
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mP7QeL7HyIEsLH4EN9FumNzZ9qQVO9ZMLe3N61NAat1tt7QJSY3gi6N7/aqU4EgzWjVNdX4qaPO2TOfOmo0KxrFeXSAxbG/XuC13Xv/yN1U+REBYDMUgCsIreOfApM9Q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB15931
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 14 Jul 2026 07:44:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23573

Hi Pavel,

On Thu, Jul 09, 2026 at 11:23:06AM +0200, Tommaso Merciai wrote:
> Hi Pavel,
> Thanks for your work.
> 
> On Sat, Jun 27, 2026 at 11:35:36PM +0200, Pavel Machek wrote:
> > Hi!
> > 
> > > This patch series adds RSPI support for the Renesas RZ/G3E SoC, which
> > > features three RSPI controllers. The series also enables DMA support in
> > > the RSPI driver, and backports the necessary infrastructure changes
> > > into linux-6.1.y-cip.
> > 
> > Thank you, applied.
> 
> Just to double check with you.
> I'm not seeing this patch applied on [1].

*this series applied.

Shall I rebase and resend?
Please let me know. Thanks.


Kind Regards,
Tommaso

> Maybe I'm missing somenthing?
> 
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=linux-6.1.y-cip
> 
> Kind Regards,
> Tommaso
> 
> > 
> > Best regards,
> > 								Pavel
> 
> 
> 

