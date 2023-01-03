Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D2F8C5479D
	for <webhook@archiver.kernel.org>; Tue,  3 Jan 2023 20:19:18 +0000 (UTC)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (EUR03-AM7-obe.outbound.protection.outlook.com [40.107.105.79])
 by mx.groups.io with SMTP id smtpd.web11.4448.1672777048416196006
 for <cip-dev@lists.cip-project.org>;
 Tue, 03 Jan 2023 12:17:29 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=BV1D2SU7;
 spf=pass (domain: siemens.com, ip: 40.107.105.79, mailfrom: henning.schild@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GMU+8vPduzKQo1G68gAAvSkEiBun8gJq1tlUO/HJQWtz5y/EaQbv5F1N7Qggnv+u7mMml+alpU/h3i9FK40nm7+1098vz9j7An2q2KdO0IaiqwldOmJ7BcrDEOui5QuLyEyuL4hR5tvyDb8ZkklBbZbDoqyD3bXC5bJ9UPGCKNpSkqhIXh2ljYVem8bmd1n7Hj63CGGtB261Xf9lPXB/JoaZCpF+4bFEmCCaFxWYiRwO47I9bgWwCqUT76rQww/VjX0comEwnpSky2dvIhueDIc2gOa+6Fp6xF93GVN2hUgPL6j71feWU4nTvDaMv84UKVgVeqgSh5RLBv1NhEtxaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HQJd86uZH4xdh4nlcDVAV6Xef8K26EGQ+rf6f73mynM=;
 b=TvXFPSsAOb+Lgz2Q/EMDxT2qOyXrts0GY2NCv1Z/LKshOLRZkBqjHALgfBxp26J1CEnWfpL5RsHMmY8Vao/9vylsnUPIvHjMiRlTZu/2876CW+NTWfd/RzV1lN4nKDE67jKYl9e0XBLsnUSFvXdERvgN49tRSNAZsLeTduc6MPi+SaAZ3em0HC9r4UiRdbPT6UylAF3CAuXdriYhqX2ywsm3pXYGIoKtaIktEzUgg6+RnZfrt8N1w9eyLk7Gm9thCR2xWqSN4djTtfIoQF6UialFM1AsuAUJIjCGoTFwYBk58OSb0dGXQAeZvH0fFg0VUQf6xyMK8sj/yUHoplQpGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HQJd86uZH4xdh4nlcDVAV6Xef8K26EGQ+rf6f73mynM=;
 b=BV1D2SU7MPx111pOQ8YLqG7DitNVx2oxB6kkxJXJXbg9TIOJCc5a+mHzE5OiFmoY4tbPFbtjtFrDiHOovXEd7q/zBw3ztB9A621HMXVEeZfy6yeO8tndneBAPIabCiwrViYqQffa2Ond2aC4OAxWe7sNoIv1lUkAe6HkDmz96qLUm8Cwzp6YM34L9vwTNDCy5LQzm3YabQOhDwdCyaELwqwr3weAFKhV+L26i9SqF1eSH4h0bHrIx2q5HmInkLYmoCeSlUq4m7BjpkUZq+UfwK7wbwhWl2Y019gVf80P4gHsVtfRDDM54tjlZBgjbna0rbk2eRfKTxK586Z7M6EJIQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:269::8)
 by DU2PR10MB7836.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:496::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Tue, 3 Jan
 2023 20:17:25 +0000
Received: from PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::bdf0:fdeb:f955:bc79]) by PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::bdf0:fdeb:f955:bc79%3]) with mapi id 15.20.5944.019; Tue, 3 Jan 2023
 20:17:25 +0000
Date: Tue, 3 Jan 2023 21:17:20 +0100
From: Henning Schild <henning.schild@siemens.com>
To: Wang Jing <wangjing@siemens.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, cip-dev@lists.cip-project.org
Subject: Re: [isar-cip-core][PATCH 6/6] change-root-homedir: split root home move into own package
Message-ID: <20230103211720.4e7ea875@md1za8fc.ad001.siemens.net>
In-Reply-To: <9ab8ffb5-cab6-3fe0-ae2a-df9c2e5f772d@siemens.com>
References: <20230102170818.17689-1-henning.schild@siemens.com>
	<20230102170818.17689-7-henning.schild@siemens.com>
	<9ab8ffb5-cab6-3fe0-ae2a-df9c2e5f772d@siemens.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.35; x86_64-pc-linux-gnu)
X-ClientProxiedBy: FR3P281CA0002.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::12) To PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:269::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5780:EE_|DU2PR10MB7836:EE_
X-MS-Office365-Filtering-Correlation-Id: 2da5e722-4a1b-4797-30d6-08daedc7875f
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	O2h+tHj9dJOiY4Itx85ICdIpVhRrtIzhsCBRwQUalovHIRe2lS0tAMNLkHKuoGlro9eyjbrFHmU7dPhhzBLI5PSZEAmAu038anbHE7Pr00v7/ShtRYgZq0MK/DaXJA/I1ShHQBCRclZfIcI1rJ5gqwAIlPFmG7DOZIPIBInctx8nRCAgmdBJHSB2X4xqRij5ySCUXBK+oxgKoiRzJzAoKlE37iKRKwGk7ACezijJPLhtkVsP8s8n+9rhcMOhiDvy3TcQbgebI21qqx0S8QnsN7hu0lrPEF8H+cMxm1P0Jfm/+wKTW910f1iEfng/DEVkZMqZBbBesOQWl1uppirKecH2RqtqV/q/v9Dw+WeuigANRn5fx1Syd8VqfakuHp6W+TfZkmuS8df1OF82WJno/QEUgrsPcwZzFNHovZC9ZemDzDN+YQosODdSRA4gHueWEM7s/PFMIfYkkKJNlU7NJqWi2azXqTz85VF+HFS+ltE8SsmVUrq6ka8fGROUApMUkdLIoLWZOCS8Aeh3Rup2g428AyYRwMPJOkEV1zGqOgRwR20HE73zoPSKioLw0Fzw9ShAHNKth0ss9wXGXf0DuQuT347hu78coNF+ApmjgSuRk3EVnC1obUGsr+Yh1W/T6Rtat7MHZOfvvScz1E06C29cjP0DE7kmlgOHzZx7l+ldLf85ijYyjNBVdshmVv5A
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(366004)(136003)(346002)(396003)(39860400002)(451199015)(5660300002)(2906002)(44832011)(8936002)(8676002)(4326008)(41300700001)(478600001)(6862004)(316002)(66476007)(6636002)(66946007)(66556008)(6486002)(53546011)(6512007)(9686003)(6506007)(6666004)(83380400001)(1076003)(82960400001)(186003)(38100700002)(86362001)(22166006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?XUByb1lUZwf1+fMTszmA579o5I2l5aG+SC9ndPp1HWp0PH8vV689DtaC4Ch3?=
 =?us-ascii?Q?8T24IQMwwemv96ZOfQ/2IkGkf3Nm+agThb21UlONa6FSsUzB5GoBke1pcdUq?=
 =?us-ascii?Q?Up6y4EnXjJ7dOrWhWJvbcwR5vFn29VvYe41fIoeSLhHLAlXLN8lc3SCXrm6s?=
 =?us-ascii?Q?Vbch4UDtumF1eV41U6KatzaVUL1QvhdMsE/vlSaf7QZ9t9+S2OGJWr7KmKlc?=
 =?us-ascii?Q?iBSHFLKxIvYuFQ5vFrtHjEjiL+5G3dMt58yioxK+4gC7WZHf92AAW7KPR5Uk?=
 =?us-ascii?Q?+ufuY8A98bUr7WmwcbP+A4fHHAwxrFFU561j2yBC88lRTCCRJQd+PP5f2wPU?=
 =?us-ascii?Q?i2S8UUMLccY2X1gTPApxKfVFozR9VKL1txcUUEMrgg5TZGBLVu7z7EAyAsxb?=
 =?us-ascii?Q?sF/owfv7QAQQ0i18ChmFX1uJ8EiH6EhHVRrgk83bd2Akdl0rRJBldsz5Lixx?=
 =?us-ascii?Q?70kZ3qavYN0wrx0mgsP0MRa1yAT216NL+2KlHbWdcJBt0R9R+xYMB5jk2YUV?=
 =?us-ascii?Q?ZFIBAaBktaaOkx98gQUzfCgbv4XRd9Z6V0VKs66x/Jq0KdeVh+yMFzM0NYdl?=
 =?us-ascii?Q?+Em33oe6aIdNGmVNA15Wety4rWTg1ZbirG2sy3T8g8H2Nqlcxp3h0gdd1jBs?=
 =?us-ascii?Q?r0PhJmunXnvU9SyLu0WYgKEzjWRn++FZ6of0NzJys2o2d17sfeSg84kxxRcP?=
 =?us-ascii?Q?DoP0W3LMvoB/L+0Rqx5BaRenv/2sjLxbxdMBfOwE2NKXG5XdXeiyhBcmkGRS?=
 =?us-ascii?Q?tF0TMHXoJNCPfgziBxbrDBmfjw3MNhry8PQ//cPCNX6FNaMnQkJKf2PMrGmH?=
 =?us-ascii?Q?AvJ8m/tmceDFbtpdJXX1K8ks314OqHtSjYLAGo9H/5U83G6bvCOXHN3CruB1?=
 =?us-ascii?Q?VezLlkkbes+mIvlFa9gmDn8KTZzFPY/c3WrTj5Y459gdcj3GfXak2PFdSsZ0?=
 =?us-ascii?Q?BCiFqUrGPHck3FgF2/MrpT0JC9QZz69sXc9WkrO/QC9I4VOUFnrVZBJcaPE9?=
 =?us-ascii?Q?8M/vXdytJdMzpu/CLWHX4Dw6m1OaTFhtZ8iccBT0PTlGweaa41o8QWhAwhvP?=
 =?us-ascii?Q?aKd2XvyXFdZZNE3UN5R+EDu8o2ODQcuEXrlaAbRxg5M7MbjB0blAK7Ab6Q8K?=
 =?us-ascii?Q?ayDHt1eeezxjKFtZMlJXbsQOj9F8NE2vQVaalmEjZu6EXmnf3dVYw6kfaFdf?=
 =?us-ascii?Q?w9r9a9+ajleSPH1+/mGEe5GGcubTl25DaWHYZVOJMA2tuDf5ZKmmhZijB0l4?=
 =?us-ascii?Q?TsKDKL7+7IhuKV2RTfhnPeaWPVJE8hOBw0C2bvuMs+0TVkcGFP40SIgmNmi/?=
 =?us-ascii?Q?4/Obk38jljj/lebT1vEyuciZQFn7LvHOoTqcDfHC32A1YhLxgZFIuIBBoRQm?=
 =?us-ascii?Q?KmXWY4dfXfJvVJp1ZuTUE28z+vPXWJWyH9Cg0ECsG47IpbTcf2hA0QdX3sQb?=
 =?us-ascii?Q?pgKq3VKg8WM/BPjui+jfPjkBJXG4BneqBqSmd7lXL9YZPQ5mkFrAehu/IDih?=
 =?us-ascii?Q?/PLpYoVPD7NPeVrS05GSatWHHP35gMHQQoYLPUocd/VnFs11OHXhR/yt1YrU?=
 =?us-ascii?Q?nJm1xccxYmRh62WSDWV3S9i0xdBn7CqCyH3/CobjgcmlP7eePfmeTHi8VJN9?=
 =?us-ascii?Q?0RPY3AVoyEdxLby1LsHtWMowUlgWSU9y9OuYxfWWNFOcbY5CnBxoMa3sjA27?=
 =?us-ascii?Q?ms+/AA=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2da5e722-4a1b-4797-30d6-08daedc7875f
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2023 20:17:25.3659
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eGI3GFhjFkMW84NZkcbQDBAMXMiTrVaqVwxLb+4z2e/kQzhlu2csLM+liAcw6nFXSQ3//rkm8oMTHj+m9375imkkt9tNKuKFLdgV8NjhzPg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR10MB7836
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 03 Jan 2023 20:19:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10292

Wang Jing maybe you want to address those comments and send this one
again?

If so you should only use this patch, change it and add your
Signed-Off. You could even make yourself the author and drop my
Signed-Off if you want. I think the latter would be the best idea if
you took over.

Further you want to add a cover letter where you mention that you are
based on next and add a "changed since v1" section to that cover letter.

Please reply if or if not you want to continue here. I will only pick
this up again when i hear from you.

Henning

Am Tue, 3 Jan 2023 17:54:25 +0100
schrieb Jan Kiszka <jan.kiszka@siemens.com>:

> On 02.01.23 18:08, Henning Schild wrote:
> > Changing the homedir of root that way is required by any layer that
> > takes ro rootfs pieces from here. Making it its own package allows
> > reuse without having to take some other customizations.
> > 
> > Signed-off-by: Henning Schild <henning.schild@siemens.com>
> > ---
> >  .../change-root-homedir.bb                    |  5 +++++
> >  .../change-root-homedir/files/postinst        | 21
> > +++++++++++++++++++ recipes-core/customizations/common.inc        |
> >  5 +++-- recipes-core/customizations/files/postinst    |  8 -------
> >  4 files changed, 29 insertions(+), 10 deletions(-)
> >  create mode 100644
> > recipes-core/change-root-homedir/change-root-homedir.bb create mode
> > 100644 recipes-core/change-root-homedir/files/postinst
> > 
> > diff --git
> > a/recipes-core/change-root-homedir/change-root-homedir.bb
> > b/recipes-core/change-root-homedir/change-root-homedir.bb new file
> > mode 100644 index 000000000000..dc4631bd6b16 --- /dev/null
> > +++ b/recipes-core/change-root-homedir/change-root-homedir.bb
> > @@ -0,0 +1,5 @@  
> 
> Missing copyright header.
> 
> > +inherit dpkg-raw
> > +
> > +DESCRIPTION = "Move roots homedir to /home for read-only rootfs"
> > +
> > +SRC_URI = "file://postinst"
> > diff --git a/recipes-core/change-root-homedir/files/postinst
> > b/recipes-core/change-root-homedir/files/postinst new file mode
> > 100644 index 000000000000..205ee4839e82
> > --- /dev/null
> > +++ b/recipes-core/change-root-homedir/files/postinst
> > @@ -0,0 +1,21 @@
> > +#!/bin/sh
> > +#
> > +# CIP Core, generic profile
> > +#
> > +# Copyright (c) Siemens AG, 2019  
> 
> Maybe update to "2019-2023" at this chance.
> 
> > +#
> > +# Authors:
> > +#  Jan Kiszka <jan.kiszka@siemens.com>
> > +#
> > +# SPDX-License-Identifier: MIT
> > +#
> > +
> > +set -e
> > +
> > +# needed for read-only rootfs with writable /home
> > +if [ ! -L /root ]; then
> > +	# usermod --move-home can not be used while the target user
> > +	# has running processes, also we keep a symlink here
> > +	mv /root /home/
> > +	ln -s /home/root /root
> > +fi
> > diff --git a/recipes-core/customizations/common.inc
> > b/recipes-core/customizations/common.inc index
> > 1124ff2d3590..24c862c32e3b 100644 ---
> > a/recipes-core/customizations/common.inc +++
> > b/recipes-core/customizations/common.inc @@ -22,10 +22,11 @@
> > SRC_URI = " \ WIRELESS_FIRMWARE_PACKAGE ?= ""
> >  INSTALL_WIRELESS_TOOLS ??= "0"
> >  
> > -DEPENDS += "sshd-regen-keys"
> > +DEPENDS += "sshd-regen-keys change-root-homedir"
> >  
> >  DEBIAN_DEPENDS = " \
> > -    ifupdown, isc-dhcp-client, net-tools, iputils-ping, ssh,
> > sshd-regen-keys \
> > +    ifupdown, isc-dhcp-client, net-tools, iputils-ping, ssh,
> > sshd-regen-keys, \
> > +    change-root-homedir \
> >      ${@(', iw, wireless-regdb, ' +
> > d.getVar('WIRELESS_FIRMWARE_PACKAGE')) \ if
> > d.getVar('INSTALL_WIRELESS_TOOLS') == '1' else ''}" 
> > diff --git a/recipes-core/customizations/files/postinst
> > b/recipes-core/customizations/files/postinst index
> > 7a0b00d98680..7e7ea3692325 100644 ---
> > a/recipes-core/customizations/files/postinst +++
> > b/recipes-core/customizations/files/postinst @@ -21,11 +21,3 @@ fi
> >  HOSTNAME=demo
> >  echo "$HOSTNAME" > /etc/hostname
> >  echo "127.0.0.1 $HOSTNAME" >> /etc/hosts
> > -
> > -# needed for read-only rootfs with writable /home
> > -if [ ! -L /root ]; then
> > -	# usermod --move-home can not be used while the target user
> > -	# has running processes, also we keep a symlink here
> > -	mv /root /home/
> > -	ln -s /home/root /root
> > -fi  
> 
> Jan
> 


