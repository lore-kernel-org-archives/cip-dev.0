Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CE4EC35FFA
	for <webhook@archiver.kernel.org>; Wed, 19 Mar 2025 10:32:40 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.30])
 by mx.groups.io with SMTP id smtpd.web11.4613.1742380353800513209
 for <cip-dev@lists.cip-project.org>;
 Wed, 19 Mar 2025 03:32:34 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=TaUhjLsN;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.30, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IwkgysIfDwQ3fgyD2itFGem853trF3LJSZXZTTXLyab1VAYHZ9Ax5MggATNSWMR7OiXTT0phH4ens9bUdF1LaJEx3wyTNE1CAYy1wdN1ctdhlY/DFLP7oYCGj7g+4QXBLYei7NSLayoMIrTTaRxoPbcsEHqlz+xx+hrasEM8dVEIcbf1Y6T4X+6eDxuE75JbQOGgpezkLTHq3Et2OfyWT2Nbsa1axwovSLoacTM+rDxcpT5tsqStkRka7rivwgfGftYaWxB9o9BFvxQfeDpPmyx8lrVg2VkX8ya1dGWrbDEvpNsaYK5qY6TPpdwtbYHERrhgZs46wX9ShJklow2aiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fBr2m8kXZb7VOKSsYpgiYAUgRGzux2QL8XgGz0xB76M=;
 b=SuAiv/l2FzJ7ax6Tjj8MGYI8VxIkSPVHAriJ4XwLlfOP2KxItTedgzzTywChvxNEFMX80r+QfHfM1l3nKQ3SMluJfNHgY72kkBMPPUF04D5nlVftphCvCrpleo0J+NiLqUGw+IJ5TV8OZvtFMEY5WSVDV158lRIDKLjLG69KVJp7Eqt+CNb2fdhAmgbZhhrz2DrQZojHL3HlCgmPmuVErKcmpmY5srK0Rf3W0/Mo1MYF32sQPejuHK7JE+E1p/qusE8EVMlfYYrz5TxHK+iVkKS3LbKfVALZ+cumrb7NyvIL4cPQHzAnnmn1zw+sqs6x9WgN40Gur6vjYTSUUpOuUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fBr2m8kXZb7VOKSsYpgiYAUgRGzux2QL8XgGz0xB76M=;
 b=TaUhjLsNFV7eds13hrqXICaYOO8kYzQeY3X7FG5wmI4sun9tLnJCw59PJFrnooRygNh6TMQGonXhcwwaffl0W7mxL5XRVkgEzOFcN5atFzZ/WLx3AzvUzRxj5s5syzkh4DfR5DP8LGb7A5eQDT/lz+IKM7uOl7BNYg1z7MjopbA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by TYYPR01MB12432.jpnprd01.prod.outlook.com (2603:1096:405:f9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Wed, 19 Mar
 2025 10:32:29 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8534.034; Wed, 19 Mar 2025
 10:32:28 +0000
Date: Wed, 19 Mar 2025 11:32:13 +0100
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: Re: [cip-dev] [PATCH 6.1.y-cip v2 00/12] serial: sh-sci: Add support
 for RZ/G3E serial driver
Message-ID: <Z9qdLZ6MSVEaMpj0@tom-desktop>
References: <20250319101629.2407727-1-tommaso.merciai.xr@bp.renesas.com>
 <182E2D5440856AF6.20726@lists.cip-project.org>
 <Z9qcRBPx38dI4QtV@duo.ucw.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9qcRBPx38dI4QtV@duo.ucw.cz>
X-ClientProxiedBy: FR0P281CA0148.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:96::9) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|TYYPR01MB12432:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bc68916-f6d6-4d3c-84bb-08dd66d15909
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?DTkNp2haqgrE88PKtgYm1Y8M7ab5PV3zzesTgeinCu+xeC+EuwUZdQJYZtQJ?=
 =?us-ascii?Q?rEb2WZ5xk8IUgo033M3MgMb9zdHDtzEQuKv7A1A9YwqYKB/KCo5FE7W5oG2f?=
 =?us-ascii?Q?2+C2bR2zsTUqY+61T6c8DuHXlfM6evpMXwXecO6maIO+soUcPiL2+r+NTTxv?=
 =?us-ascii?Q?1IhK3Ti1iINIDi1x2u3NE0yAzqfgBbSnyWaV8I8689X7MCz+mmkWbskKOCqA?=
 =?us-ascii?Q?nSEgjF7HzilRUi6JIPLsoSRP0ECpr5TQ2c8krncrE1+oz0RmTMOtjgk/q+rD?=
 =?us-ascii?Q?jzeizk8boAg9qFGV5p14q+brZjJJVjPE5jRBb5j1wNXjxVstqkXYX4kB+3zP?=
 =?us-ascii?Q?Jy7DPUvecFtxbgX89xpSGNuvZmET9B3n9Upv6lprpphqqJhbeEXVF7fSnN3f?=
 =?us-ascii?Q?DDirxhLhwLdhB7qykjSXclB9xlozOpVTME2lAoAO6iM+SCZzK55wQrSI9gXq?=
 =?us-ascii?Q?P/bbyb2ST9UwGaHH3w3Z0yzW0mGjxwmLGSjuZNIMJXSVDTpvS+nqxZyzCM5+?=
 =?us-ascii?Q?FcLTwMkam9yDegS5ePlSrVZq43nObip71+ZApyhqUv3wU952AFLe5fdGeMFc?=
 =?us-ascii?Q?mo7JyNytSYGoQ/1QH/LpF40m1V5uGTQlMQV7HAlnOYsu7peF9CA3TY9fzwF1?=
 =?us-ascii?Q?Y4jKliapO2QnW/y4dIyeCxkCeXCaCl7DIwd5RCeoPUVTWMsVUpjibz1ZxLlN?=
 =?us-ascii?Q?0vKV+jgmz4DNi+tmrBwzwwkrAVq4K10Ntabfyn1sb+hJnSO2gKgYUCqDY/p8?=
 =?us-ascii?Q?H3GijJj6WG+2EapXxU1SENLfiCimOiWxtca/cHC0qZHetta2iKabxOg+TZOt?=
 =?us-ascii?Q?AZB6pKCalOVNEKf2yoeK5laNz7J16wX3f94vi0D9VjwUEsHJeHVj1NzF/wjF?=
 =?us-ascii?Q?8Dll3Dy0baOy3rXMVUfmyDxKa784B85b3c6fTLGvNgbNWau/tx6pRo7pHrzW?=
 =?us-ascii?Q?7IcHuqzsYQO/E8ZgbXCbF5OVhZLddSjHDTlXEG0K//jMxXXhOeIT4Heva2VG?=
 =?us-ascii?Q?ddfzOjn5ULoFw66S62VOi+eJKmus6u+fiKNfQPOI2IJv1AIsCMIOuPiwCtib?=
 =?us-ascii?Q?DpfpHUlRjh62c+aploxdaVh2U0Qx4vW5I5GdWVNLDO4JikdO+LN9l8TM5abI?=
 =?us-ascii?Q?ticHIxQttgSYLDvLkTwl7aWc5lQ1usFXYHXUfWQbu49ut8gJU8AOthLYd2Ml?=
 =?us-ascii?Q?oyWlyXb2pMUXAd15PsPih+SFjjwLwQwGxyvq5LKC3SMf+SNjjnVPjw0TY+wf?=
 =?us-ascii?Q?yw0Z/tfH0eTNLj3mJlG5E+QaQOH+D7FsjO4TiHRj/DrfNgVeBs9HZ8GEbCU/?=
 =?us-ascii?Q?XEuiuaVuRWOeiGjzuFIulmxcmYi2WdNGF/OHeizGEAcVPXXA8S1gqEnNsLXw?=
 =?us-ascii?Q?9IchrnG1SMQnN5T5X7GQjtcHSOqu5tllgv8FmQ/qdO4NLZO4aLQk8Umaz/fh?=
 =?us-ascii?Q?WU9NodPI04U=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?r/cyUSeb3VbSVVtqhoj1yENpIuMfmMZ9a5gRLHmyVN2VHH9dmDXz2o4SGYls?=
 =?us-ascii?Q?zWB3G/4IybLlkax18UsLlZQmE2EEaIG+YKOekHgVBJXqAbIRnOSIbuOYvSQ4?=
 =?us-ascii?Q?XefIsw2sAik1MuIED3ruU0EBRVJ62ZaZnT/nM04Zp3MzDrTjkfvKyNVc+2nr?=
 =?us-ascii?Q?bO1LFs75hYNiugqvyJ8bcaoG8p5dlgp+d3OvPjUmSyn+n/E2jOkZ4A6RaUpm?=
 =?us-ascii?Q?AVao0/DRztmbJEfuRVctbN0X3kRs6LKhJwrfduD07rBj0/PglJM52exgBKQx?=
 =?us-ascii?Q?ySjCFgVC4zsTFwawrteBWuKBV2koQ8c38xqaZ3FL2AhqRzujWe7Hti5g/S9s?=
 =?us-ascii?Q?Apep0IDQ9eyYHrloeswi+sBlwTe8Du6g6NjedyygPjpWA4tUNvuCViUIrGnN?=
 =?us-ascii?Q?wgQ370CgtbJK0G1+CjUnGF0rWOVAUKVA3T4XRkUlCWb4L1mNfiVCCR70mWpy?=
 =?us-ascii?Q?3b/rAwMLgADhEK/6Ez2J5U6aRcneji2zZvuSyUHeDwahccuhyRjxfGxc7Qtw?=
 =?us-ascii?Q?QJwsEWJs9C1XpPiAyMTw4N5MOtyGZMyHN6AuZMD8pVGnKMUtooS20YeLqkii?=
 =?us-ascii?Q?ShQUHu5H2xHbrsXvwlqdb7YQPcIjJ5TyfnXbPW2Z31RTkn1WsxMIh65RINOa?=
 =?us-ascii?Q?FMV0wIh+EXZoTG2puYbJ4A7EwBD9mDB3KV8SU3CtF6bk2uOAfU69gTNwAusJ?=
 =?us-ascii?Q?Q1JI7F3DVfx/f/sqd4UY0M6RPtRRDfgS4Df5kWG8l86/SwtKrHZVNHngn506?=
 =?us-ascii?Q?OR65U2QuIxAPhSaM7hxen6Vx6F63bNiEIRUAyAb7yeBmgOIELrKCqXQXE2x9?=
 =?us-ascii?Q?AFnkrUwkSMJOuGaa1HFe414ZHsd9XTqEB4Yzl+FCFW+pNKFLZm8KaHC6LGt/?=
 =?us-ascii?Q?bgwGtB3U05xlxnOv16XKjFL1EVd5iROJ2EIB5qrTZAjmRBEFXiK7I6HIAEFV?=
 =?us-ascii?Q?+383OUwON0VuhG5W2OrVkdA6Vjnj7fScA5N4wY+Dsq9byBV1mfZ8KmWSY1R6?=
 =?us-ascii?Q?iT7vgjhBG50Qh23fOpwQqbvg/vinJxz3eHM+fxZu6V0TVnMBAdVHVoJMLebc?=
 =?us-ascii?Q?+zrSmRbB1rGgpBQfVYtyApKr9u6djsM2ZgjzYDVj3Ho3Bl/1Kkvcq3qInx4u?=
 =?us-ascii?Q?ec7joPH4I74DdgkSKnXsR/uaQKowXZd1py1p0ThUYgln6hEnK0+ODOfJK0Yk?=
 =?us-ascii?Q?kwtCbOBRT+158X1IQTV/oWFBlSaWslijYTkJ0IBEQF4TsSwEoV+QjQRLqPPU?=
 =?us-ascii?Q?NWOwVLcZNZe4EQWLwWBTYKSC5VzYRj0QzOJYDszogD7PnIXuO3rOqctprTM3?=
 =?us-ascii?Q?jPYkUI8tCFQkzx3nlCQnyPY9Kb+NgXD+vpxsnnHWYxhF4L2ZWusirm4PTdPh?=
 =?us-ascii?Q?bJr47PBFPFgAWMKLLYWIt7xkLw24ULSnJb8R0we+751oAxWxGnPKn5QnsXP1?=
 =?us-ascii?Q?Xmg0Bp680RG1VAjUrIkvuXmfFCCWb29/rLA3qTUf0eNDJGeFsdabkF39qpbH?=
 =?us-ascii?Q?GnoB7VJJELWF1n7WXmkSiZgSNrTOzDq34ydeVTEToc/QjvJdtHHHAG07euN2?=
 =?us-ascii?Q?CfY879Er8K9KpNPMfx12fmwDuVZo/rqVSrEq3WxbCyRggVMHTjQ42k68m+uX?=
 =?us-ascii?Q?D43qaAM75dttBAtZI1d+Ifc=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bc68916-f6d6-4d3c-84bb-08dd66d15909
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 10:32:28.8373
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gsGib1l3LucY56u65RIwCkkcfg4JsDKiHpgAls49M0is45X5i9uc5ddpDzS2mgSkMj6z4BsFaDz1wk2WP3uOf/r7uL9fnZMYQ3p+Zerdy6T5wnIzwd63MZuarCc1aCHU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB12432
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 19 Mar 2025 10:32:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18277

Hi Pavel,
Thanks for your comment.

On Wed, Mar 19, 2025 at 11:28:20AM +0100, Pavel Machek wrote:
> Hi!
> 
> > > This series add support for RZ/G3E SCIF interface to linux-6.1.y-cip kernel.
> > > SCIF interface in Renesas RZ/G3E is similar to the one available in RZ/G2L.
> > > This series add also some fixes found during SoC bring up stage.
> > > 
> > > All patches are cherry-picked from mainline kernel.
> > 
> > Okay, so I just reviewed v1 of this, and was ready to say that I'll
> > apply it provided there are no other comments and it passes testing.
> > 
> > Now you'll also have to tell me what is the difference between v1 and
> > v2 :-).
> 
> Aha, missing SoB. I'd expect that information in 0/ of the series, but
> you wrote it elsewhere. Still good.

Yup sorry, I forgot to update the cover letter :'(
Basically on v1 I missed my SOB.

> 
> Best regards,
> 								Pavel
> -- 
> DENX Software Engineering GmbH,        Managing Director: Erika Unter
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

Thanks & Regards,
Tommaso


