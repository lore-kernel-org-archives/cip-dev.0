Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71D6CC4332F
	for <webhook@archiver.kernel.org>; Wed,  4 Jan 2023 13:51:33 +0000 (UTC)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (EUR04-DB3-obe.outbound.protection.outlook.com [40.107.6.66])
 by mx.groups.io with SMTP id smtpd.web11.12382.1672840285394343726
 for <cip-dev@lists.cip-project.org>;
 Wed, 04 Jan 2023 05:51:26 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=pejNRtOk;
 spf=pass (domain: siemens.com, ip: 40.107.6.66, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zgpb92GDxB2WGE4BZ8WVFvv+e8bFgiJLv4/3VxcYwMEpMUIfczuBkB5s1VVkQHA4ZOuP+h6b1/Q9NK92/UL2ZBDFLtC2Dou+Gu0sgusuoMs0seuJecbaaTAJ3FbSlPhWuZyJM4aO1rSGIivElRi7SsfEu2EDeegn0iKMV6Jl7BHcjj4SrQGXdYMPislEmvI8RzYpCBgRpMSvNRSVJJb1I+glJwhboO02Cn+l77xVzF0cVASSL+Sao/NCkRKUffblO2aQm4+BTZTFTBLU4EGCv3q9/ETiMbt5W15GyP0380ATiKd0RkOqOsZeJyAwwCL48wC6mH5HRkCHH1lzU/rl4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aqEKm5/xrGAXzjS/dk8drbs5qC+MQdmHNEwnvkn9gJ8=;
 b=kRRfLZ95b8xNZZxVIF8pepLCNx6aB7hjJuvWgCyEJU6ZJLYYpWldUUJkhKR7tQ1mdYwQs3Stf/D+rXjrk4jYvLK0Z6ye1nHFSGitYHmPWJhEdTQkMEBAwM1M4SmofKzEUKD5t8foIyrEqu5Ss7qfzwCcrBcn0vIRGODVOriJXajZdKh1J1L2X/kuIX/QKJFgRe2qfubrJI6DSnACltJktknb0ghvokQ2kzLEq6FriNDI6Nfn16763mwHNlDl6H8lgL9WY8Xwv572Z840UPf162Fo5Qfq4sGfqO/LPUAlalPwMQDuI8d1l9BAfR3PZ3apV5wJH6qqOUD79rf12l6QDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aqEKm5/xrGAXzjS/dk8drbs5qC+MQdmHNEwnvkn9gJ8=;
 b=pejNRtOk8bGSPuEUzly6I7wKZs6hEWC1+2guPV+M76X2rHRAILrezkMRm2U26yH+1VpkzyKSgbWTmTrInOL7M5yjJWuICngQ4VVWZywlCAvmqYj/r82pfHKdRtrqXJ1yi2zWcXY2Y4WmV0tSZS+qcW/2subCeGD1icmLpLXXmXajZKXVdpuRNloQkfi8DDO4G5PLDZNDMEJslUtm+vjGPEsxREPjtzZYKbcJiHs301dMfar12haRynI14iiH1o3UCDqTyqMrHJ3a7J6QthAJXeTLgwHNNHyJe7cY5KcqNXBcfU4/dsTKVyTd3lupbna55/geSgTjo2DdhvsNE7fCfg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GVXPR10MB8002.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5944.19; Wed, 4 Jan 2023 13:51:22 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2957:50e8:8ce6:124a]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2957:50e8:8ce6:124a%9]) with mapi id 15.20.5944.019; Wed, 4 Jan 2023
 13:51:22 +0000
Message-ID: <64f82f52-1125-0f36-db3d-32efcc78fc0b@siemens.com>
Date: Wed, 4 Jan 2023 14:51:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [isar-cip-core][PATCH v2 1/1] change-root-homedir: split root
 home move into own package
Content-Language: en-US
To: Henning Schild <henning.schild@siemens.com>, cip-dev@lists.cip-project.org
Cc: Wang Jing <wangjing@siemens.com>
References: <20230104134039.11897-1-henning.schild@siemens.com>
 <20230104134039.11897-2-henning.schild@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230104134039.11897-2-henning.schild@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0061.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:93::18) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GVXPR10MB8002:EE_
X-MS-Office365-Filtering-Correlation-Id: 79cc771e-c6a2-410d-04e8-08daee5ac3ba
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	+jdpH4AEyAs2qItVRjoZAzWVtfuE8nHFjGLDpBjEWG3fKATlmQIvZQu+ahlkObWILpxmCtBXRnOuFLo/uop4LXY4a/lVXw46H3Y4HUbKq/Jke1abaPz6yPEtHhDqbsUX44mLynnAz+L0o+leNTwXR0KJKpogqYL7HpCykGYLAIbd6L1Gg3/4ORXfP14ON2bQLEy1u/0hlKmGgper15ctyNDnIq+ljAt3VCdArJGZvglwaSptx4TSfH6T2RTajULajs3LBCTJQePGd7caI/rPxxbrfuPB0Mr0VvATWXK/1rkDX5Jam/IvA2IEM1RjnUiNPdx0/IpEFH68HqD4b1D+3cL49J4FWwAPwP0eogyZiQ58Eaayzg3OTmQV2Boz62SjVOOoU+99H/hEebW+Y/7cbAqnNKxlvv6o+APtF7WSz2YMEkkdUllSrO78+7S85Bko8P2mOXAy3AuviKW23fyIyHMzwsJIEM1O6/pM6O93PvS///bjr06q6+UOIZeN3Q2JVi9O44lUO1dR1/YAllKyugX7hDVLrHCCKFNsdTfoL6KIFiLQHg2YFF0K/eDkA7CXHFyVduugAZWQyNH47iMh28azF6YbABTU5nOWM9uLqyv2jsmBzH45ElldMsulq/E69hCC7naIs0Y6Fb4z0mOpgjKHlE3G860n144oIGESzlb3/wwnbwxJtc2zuSmjGa8/83leX697ozIHEslIC+ImPe+F7mCLZJd/Ymn+kAQTHSU=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(136003)(376002)(396003)(346002)(39860400002)(451199015)(83380400001)(31696002)(2906002)(86362001)(38100700002)(82960400001)(44832011)(8936002)(41300700001)(5660300002)(4326008)(478600001)(6506007)(107886003)(53546011)(2616005)(6512007)(8676002)(26005)(186003)(66476007)(66556008)(316002)(66946007)(6486002)(31686004)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?M2hhVmdVVDFONzFjNGVReFdJRjdsLzJHbUwrZndpQXJNTDNCVmY4bzZxVHZF?=
 =?utf-8?B?TmthbWdVcnVydlhqbkhnRHpzRkVLN0huNGZkdVd3cEt6RkhLaE1YUU1INHV0?=
 =?utf-8?B?RlJKVmhGdTNIWHk2amFGdkEwd3lpN1ZWNHdKQjBiMnZIc0V3VnNpRzJyUDB1?=
 =?utf-8?B?TXBaUVpEUnFZRm5WYjR1VWZ6L1NmcEF0N0RiaWNUMmQxUHhleVJPMFBZbnNR?=
 =?utf-8?B?UTdwUG5GTWgxcEdLRmg1M0YvUkhwcjBGM0w4ZktITnZJSGtZVXlRYWl4WlJp?=
 =?utf-8?B?TkhoeURYOEMwRitma2dmRldvRzVOcTBIMmZ1VnNWeng0b2lDZlAzWFJYbU93?=
 =?utf-8?B?eGovSkdOV216KzcyZ2FybHRGeE9GaFdKb0szQXJnZ3RlNUFtajZqdnM4UE95?=
 =?utf-8?B?ckl5SmtLd05rWFpQbGhZemNRQkdldEQ5YXUxS2Z3Nm5sbktGUG9LMHRaWWho?=
 =?utf-8?B?UUpWY0JGL2RhUkRNVUJyMDNPWlpubUpudVNiZHJBRjVhZHlhR0ZxVlU0aGdR?=
 =?utf-8?B?cHIyd3BsNWVWbmh4aGs1RURMZ2hvaTFTbkE1TU83cEZvaW10UVFjNXcvMjls?=
 =?utf-8?B?U1c0a1E0T1V1Y05aK1VyZWM4SVhYa1hPUjN2V04rOTgzSDVtZWVJNHdFMlBu?=
 =?utf-8?B?RGIwaWZ4K0FETzhGQ2lXZ2V6TDc2K1FocUczN0dKL1Y1Nm1STk5oZ3gxM0Fs?=
 =?utf-8?B?eVM3VnJIVGo4VEJzZ3U3TGQ2U1FJYlNneElyTGI3OTdFa2xPZUl5cnIrQ3lr?=
 =?utf-8?B?MTJwbEQ2d1lLcVQ3czFMTGpVK0M2TVkwMzNzMUVUUjR0YTFCU1pQNkF6VkNC?=
 =?utf-8?B?dS96K2FJc25OSmU1NEJuS1UxN3JDd0N2WU1ESXJMbExkTUxlQzlQS1NMN1By?=
 =?utf-8?B?WmxCMzgzZFQ4bU00TnlDQTZ0RGlrR2dOY1hTTHRSdEs2TW5lU3NOQ2wwOTRD?=
 =?utf-8?B?dGh2TGpqTTlWbmpVUHdMZWlSWFlYL0MyYzFsMDYwNFc4TDJzTXRLQy9mK0R1?=
 =?utf-8?B?RjRGTWtEb2ZpYVpkZ0k4VlVPQ3duV0M2dllEdGdOSnc5aHJVY2I0U250Z3BB?=
 =?utf-8?B?bllEbUVadElnd0FBQzZGaHZhcFJ1VWNaOEg1dUMvTDJ3RHlYalBkSCtZZG9K?=
 =?utf-8?B?MysyMWZNeVNwaER3UTJIak9VemI0VVA3UEhNRy9CVXExM2J3K0k4TW9nMG9Y?=
 =?utf-8?B?YUJhd1FYVWRPSVQyaGE4bHVzOHVDK01UV1BjMWFlR29wTzJUNGxLR1RpRWNs?=
 =?utf-8?B?UE44SjBickpmUEcyZU16N1QrT3dCclQ5SFJHS21wTWFncWpkckM2WURnRWxy?=
 =?utf-8?B?a24ybDFON1Y4MUdDQ3VwZ0xodVhjR0w2YTA4TUEycTZRYnpkd2c0aCtvUXlB?=
 =?utf-8?B?YkN6WTNXenljeVRsWlk4RUZOazdVb0dINkZYTHBpWFdTQktGZWFqc21OejBJ?=
 =?utf-8?B?WjFTYmNuZTJ5U2g5eWc2aHZVN3JqdWM2Zk4wKzRKRjlJR2FaamJrcktoSWpl?=
 =?utf-8?B?RzNQTnU3Vm5vQnBRRWR6Q1k5a1JacHUwb0tQUTJTLzgwLzFDMXRTb0FUVCsx?=
 =?utf-8?B?djlBYWQ1WDNMU0RDbm1idVA1REtEdURtSjZhOW0wSms3M3E1UHNDOVZoemJk?=
 =?utf-8?B?clp4VDZRdGF0NlA2azhGcFgwZXg2VnZXdC9DTWlIdU80V0pZak9oVkh2amlp?=
 =?utf-8?B?U1BVeWE1T20rRHlxS3hEMXNQQkx3WEM0Q3g3VTFacUhCZXBaWTUzZzhRQlFW?=
 =?utf-8?B?UmVKdlF2NVJ5cThSWXpKOFh2cUhCVUR1SG1pNVNMU3FoRzlBelQxYWFqMnBO?=
 =?utf-8?B?VDl6dW5PdmIramhDdHZaNzVnd0pkSXZFaXdzT0czUXVYQzcyQTdKWWxTM084?=
 =?utf-8?B?V1Q1Qk9YRURMR2d0bXBXYXBXNFRjRDBpS3NRYVgvRlBVOWdEd1Y3ZE5Eazkv?=
 =?utf-8?B?QlFVem42VFVPcVlYUkFieU5SZU9lUU9NRTlXTFNkUktCc0dVaDcrMWdZMytD?=
 =?utf-8?B?Nmc2MzkzYnVueUpuODBWTEJYdERHdWhDeTNWNDRVS24yMWJ2b01mcERjVnRu?=
 =?utf-8?B?NDRHUHlpVjg4UU5PTVBGa00zVmxDbXNoWXpJeXFYbWFDWk9hRUsrWmdwcTUr?=
 =?utf-8?B?RVlKWXJSQWc3Y2Z3aXorbzlyeC9zYVVkU29aWEEzRCtWdWlxeFlhenRtMWdx?=
 =?utf-8?B?VlE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79cc771e-c6a2-410d-04e8-08daee5ac3ba
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2023 13:51:22.5499
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xePurOc05q+KXnCRCyvcV/KTQNnh/I1FRZa+V23PzB0XHxSpsf1Nfe+ZmKhK0T4z7LMJe3NkvfAExcEKOdupUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB8002
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 04 Jan 2023 13:51:33 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10317

Now it worked!

On 04.01.23 14:40, Henning Schild wrote:
> Changing the homedir of root that way is required by any layer that
> takes ro rootfs pieces from here. Making it its own package allows
> reuse without having to take some other customizations.
> 
> Signed-off-by: Henning Schild <henning.schild@siemens.com>
> ---
>  .../change-root-homedir_0.1.bb                | 15 +++++++++++++
>  .../change-root-homedir/files/postinst        | 21 +++++++++++++++++++
>  recipes-core/customizations/common.inc        |  5 +++--
>  recipes-core/customizations/files/postinst    |  8 -------
>  4 files changed, 39 insertions(+), 10 deletions(-)
>  create mode 100644 recipes-core/change-root-homedir/change-root-homedir_0.1.bb
>  create mode 100644 recipes-core/change-root-homedir/files/postinst
> 
> diff --git a/recipes-core/change-root-homedir/change-root-homedir_0.1.bb b/recipes-core/change-root-homedir/change-root-homedir_0.1.bb
> new file mode 100644
> index 000000000000..79c7e67d0d70
> --- /dev/null
> +++ b/recipes-core/change-root-homedir/change-root-homedir_0.1.bb
> @@ -0,0 +1,15 @@
> +#
> +# CIP Core, generic profile
> +#
> +# Copyright (c) Siemens AG, 2021-2023
> +#
> +# Authors:
> +#  Henning Schild <henning.schild@siemens.com>
> +#
> +# SPDX-License-Identifier: MIT
> +
> +inherit dpkg-raw
> +
> +DESCRIPTION = "Move roots homedir to /home for read-only rootfs"
> +
> +SRC_URI = "file://postinst"
> diff --git a/recipes-core/change-root-homedir/files/postinst b/recipes-core/change-root-homedir/files/postinst
> new file mode 100644
> index 000000000000..918c5ab79aa4
> --- /dev/null
> +++ b/recipes-core/change-root-homedir/files/postinst
> @@ -0,0 +1,21 @@
> +#!/bin/sh
> +#
> +# CIP Core, generic profile
> +#
> +# Copyright (c) Siemens AG, 2019-2023
> +#
> +# Authors:
> +#  Jan Kiszka <jan.kiszka@siemens.com>
> +#
> +# SPDX-License-Identifier: MIT
> +#
> +
> +set -e
> +
> +# needed for read-only rootfs with writable /home
> +if [ ! -L /root ]; then
> +	# usermod --move-home can not be used while the target user
> +	# has running processes, also we keep a symlink here
> +	mv /root /home/
> +	ln -s /home/root /root
> +fi
> diff --git a/recipes-core/customizations/common.inc b/recipes-core/customizations/common.inc
> index 1124ff2d3590..24c862c32e3b 100644
> --- a/recipes-core/customizations/common.inc
> +++ b/recipes-core/customizations/common.inc
> @@ -22,10 +22,11 @@ SRC_URI = " \
>  WIRELESS_FIRMWARE_PACKAGE ?= ""
>  INSTALL_WIRELESS_TOOLS ??= "0"
>  
> -DEPENDS += "sshd-regen-keys"
> +DEPENDS += "sshd-regen-keys change-root-homedir"
>  
>  DEBIAN_DEPENDS = " \
> -    ifupdown, isc-dhcp-client, net-tools, iputils-ping, ssh, sshd-regen-keys \
> +    ifupdown, isc-dhcp-client, net-tools, iputils-ping, ssh, sshd-regen-keys, \
> +    change-root-homedir \
>      ${@(', iw, wireless-regdb, ' + d.getVar('WIRELESS_FIRMWARE_PACKAGE')) \
>  	if d.getVar('INSTALL_WIRELESS_TOOLS') == '1' else ''}"
>  
> diff --git a/recipes-core/customizations/files/postinst b/recipes-core/customizations/files/postinst
> index 7a0b00d98680..7e7ea3692325 100644
> --- a/recipes-core/customizations/files/postinst
> +++ b/recipes-core/customizations/files/postinst
> @@ -21,11 +21,3 @@ fi
>  HOSTNAME=demo
>  echo "$HOSTNAME" > /etc/hostname
>  echo "127.0.0.1 $HOSTNAME" >> /etc/hosts
> -
> -# needed for read-only rootfs with writable /home
> -if [ ! -L /root ]; then
> -	# usermod --move-home can not be used while the target user
> -	# has running processes, also we keep a symlink here
> -	mv /root /home/
> -	ln -s /home/root /root
> -fi

Thanks, applied.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


