Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D955C38142
	for <webhook@archiver.kernel.org>; Mon, 23 Jan 2023 07:14:38 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.63])
 by mx.groups.io with SMTP id smtpd.web11.37602.1674458070786682685
 for <cip-dev@lists.cip-project.org>;
 Sun, 22 Jan 2023 23:14:31 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=cZzSw0q9;
 spf=pass (domain: siemens.com, ip: 40.107.21.63, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O3LovlrnBGohBdtsqSjkwbtJAsNHyMFGsiaqsqpAraIXittOhWr8cif76rmAOW64vvMMnzDp3qN+BFLEUFWmI3xyfMClsgdatpU/S+uEnFCdhSL8J+h5/tCdWhk132axGg4Z6r0EZyP7zzVpIEeU582N0gsX2jToevKqI07Wg1V/tFJLOcCgQstiBXmt6eIPSprVFVQUfaOYyVYOYVN8Ceeazk6Oc/CenoKUKVOHXS3nxbp5ITnxOL1ewOYgWRrfdJAZLiYe1jrJoi+tPwiLM8whALqYNNhabbRdBJO8MNmuFIICWI1e3l7b5aGPP76Kili/64k5i28zXI+e2w7lFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4qWaHjnsoPkBJaaVAc3IxcFt9cYP7zKr5t2CyjSzOQI=;
 b=khHL6HajRTPS/hoayKULwvRWLLWvQ2QEujt51zttII1pnzipQdAedKcjSuQe6baZvayxhTywSNR9r1WewhhBpB08rtiiqg8dvalShBAnsrZ/35ir9hEsoqoeZzHkk4m/aZ02D0NphoLke39203GGsmPQPFeED0xwJTC6v2/ZrKzzWJ8U/OA4jyVcHEwvNi91OW9SQvqr/xE7yeuEAwHaXpTXRFxqHwoQKq5NGwrzUjNkKrX+JhfF6jijLrzn0HXFj3mA+fPpg94NHsVU+AcboEpQnP/izwQywrlJgRGon35E1GgQlW/hAjZoFxJrowcc44+J3XqD8ijl/+b+ZTdZHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4qWaHjnsoPkBJaaVAc3IxcFt9cYP7zKr5t2CyjSzOQI=;
 b=cZzSw0q9jJm2AuU9fUEF2FMPBsMU0isEUE2Rg12EFlJS3qgLo+JAG1W+Qh+jFL7Z1F3Ywoh1iH1FvHkpXHFBOxL3zMzAmKAZP9IJ2TNnWXJzbui8MjapGAjntQzktihn8cJSkAcMRA1/1yD60jW2JeWvVCAmwigo9HXqNTclRQeS5pOC6M5DqonWwWl+dRtkiHswxfyPd3WRy3suDcUxXHXUIXZ3khDkPNrUUxbR9V/xtWWpppJKBRjm1T1FGnZI8kaLvk1xeilb749xdXDfgjpOEAmtWKPWUOLZzUVKhsd804KNe5dOKvc9zwbLtrKapp6KqaG8v7ED6QeSa8IaPg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV1PR10MB7600.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:3d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.31; Mon, 23 Jan
 2023 07:14:27 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5%8]) with mapi id 15.20.6002.033; Mon, 23 Jan 2023
 07:14:27 +0000
Message-ID: <cfef84b1-3497-50f3-a236-d381f394670f@siemens.com>
Date: Mon, 23 Jan 2023 08:14:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [isar-cip-core][PATCH] linux-cip: Update cip-kernels to latest
 one
Content-Language: en-US
To: Srinuvasan A <srinuvasan_a@mentor.com>, cip-dev@lists.cip-project.org
Cc: Srinuvasan A <srinuvasan.a@siemens.com>
References: <20230123071033.2859114-1-srinuvasan_a@mentor.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230123071033.2859114-1-srinuvasan_a@mentor.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0152.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::19) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV1PR10MB7600:EE_
X-MS-Office365-Filtering-Correlation-Id: fb669d17-9991-4257-932e-08dafd117659
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	usAf4Y3BK/bXAOcC12LIdlBk0bamHd/2wNFRujKcBP8c8QeYNQTCRIlDAK6nekmzpJfFcNlT+26WUwuaQiVbKfcaqaU6p1cxxg0lZ9HUmoMQXBUPfbh8/pB0Mc3EX1+fUIdDRMYPQy/+Em85Ywqur4j1L8iv91Tjdcualq+DyGZP98zjY7x2TSp+MUBsG+knhArDjti6lSb+hZeTs7038szl2s19qkYd0VL7Kr/PFE98sMEvh7mqzgUTTmlJMIuIdzQoddUHFdcDVd3KyF9x9OOAAWQ4jOxSqVIJHtwMuDfq/XQOXYLdk9YZKLZG1aywvYIPD8Kh1GPJxOeOv6qFtRMVN46vSUvnI6zdBPnm9okw0P025pFRD06WnqiASstaXinTm/tUyFjcoQ6ASPCYVEnn0Hel0lpDWj2wv1kjd19KZOthzUsMpxcHI5Q1PZzrD3gHCbzNyl7pV64E+RPPiWb+Tz85kAZJy4fZsLH2uMqbF8avx0a7Zui+ViMgKXn9fxMuW89FbtONRoeC4tEBpzlLHjnoSCDu49KIHo8BYo9hndiTEQTLKV5T8LOjhSztoers3YmLWBvRFYtIjVGmrJUtenk5MeeP9YWwt3VpawEr0qaTMGWffQGngRlxdDk7WLy+Tho23k2j/s97HrQaDdLVyXC6cwt5gZE3jJMDZKMLfscXN11cUHqsHMSXWX1H1oRnUQjuycilEsjKw2J+oF6C1EJxXsDVUYnK7o8hllU=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(346002)(366004)(39860400002)(376002)(451199015)(31696002)(2906002)(15650500001)(44832011)(6666004)(107886003)(83380400001)(6506007)(36756003)(5660300002)(8936002)(31686004)(38100700002)(478600001)(2616005)(53546011)(186003)(6512007)(6486002)(86362001)(316002)(41300700001)(66556008)(8676002)(66476007)(82960400001)(66946007)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?cU1vVFFHSnl2czF0Q1VOUmplczJkV2JxMmNBUEZiYVZLUXpGRWtOTk5sbUtL?=
 =?utf-8?B?WHM0bGRTNi9xN1ZHOXRRQXBlRlBVcnJCVndYZW9IZjdVM2FHUWs4QVZJN1RJ?=
 =?utf-8?B?b2dWL290K2VmN0NTWEhwM3pwS0FmdlBsL2lqd1V3bHI5dGlneUJMb2Fkc0po?=
 =?utf-8?B?RnF0UTFHZTBjYXMzYmV0dTczZjFjeDhURHNXZDZXcEVsZ1lKbW9qQUk5VFlV?=
 =?utf-8?B?ckhaL3NlNk53L3BtVmQ5dXdhMENMcnRWTnlheHQwYzM1WCtCWGNUY2xvY1F2?=
 =?utf-8?B?YXMvbXNIVk5nbXp1ZjNZcEl6NDVHTDRSUUFOUnVaamVPc1lGYVczSWEzMWtZ?=
 =?utf-8?B?QzZYc1pnc0RpZlcyYllHWU5wb2VDSUtLdUtYTFNjNDFmdVg0Y09CWUhLRnAz?=
 =?utf-8?B?aTV4Qlp3QWhIakcwaWRrVkVNVkpUbW1ESXFRM1YyZFlMNTBSMXdpU01XWE1W?=
 =?utf-8?B?SEk1dHFVZjUzckpuRW1QSzNpYkNNTThCRDlCY25Hak1xR0NhU29JcnhKTUNx?=
 =?utf-8?B?M1lKbmlGaXNyVHdQNWljMGJScXJYOGlMN1RBMDNUTTRLMTdVSG5IcElWTFRs?=
 =?utf-8?B?d2JsYndhNlVleVNueUZNVWQ2eVJzSW05aHFRM002bGRWMXFIREhVRzRBc09u?=
 =?utf-8?B?UjFxd09sNXBOemV4bjZiSngyRWdDK2t1ZTBObzAwZ2V5STcvSG9wdEtBUS85?=
 =?utf-8?B?ZUk4OWc5VGpUQjQ2bnVtaG9UYk1ZQmVTOXpqZ0hZK3VCZHdzVmdub2RWd2Qw?=
 =?utf-8?B?M0Mvd1p1aUhhelJ3RHdMUVlDSS9VaFdRRUZtVytneUlvbkhjdk5jbU84alI2?=
 =?utf-8?B?Y05WMG82dThiQWFNV2tRN1IzRXViNXNVR3FUNFZ1RVNpYkxXVEJxQjZ6TTJ5?=
 =?utf-8?B?NEJGTzRvNjArd21IYld4V3pnczJna3oxKzQvVkF1RGhaam1hTlphNVlQZzdo?=
 =?utf-8?B?YnM3OE5PeS8wQmx1bTZGVnVlZVFTVXJFdFlpVnp0UWExbDNlTEkyOGpmS3FE?=
 =?utf-8?B?NUJWb1JMQitzMlBZazlHRWFORlRTWDBFMUdHUkFnSXZCTTBUTFVxKzhWeE9k?=
 =?utf-8?B?RzBKVW1aSUIyTnV0Z3c0UlhPczVWYnVsaHF5WG5BNWdmOHlRU1RJaVd4SExq?=
 =?utf-8?B?QXk4M3Z4L0w4Ymd1S2RCR2lVV0NsNElNQy9mT0tLd3NNTHd0YU9jU0crQ3Bo?=
 =?utf-8?B?SDl2RGIxUW83NlpLeDQ2RzVkUEJSUzNzbzMyV3pJWUdqU3c5aTVKNHNWN0xQ?=
 =?utf-8?B?ZWs0QjRhbkhMZ3crVEUzb0lqSFVWTysrdnZHVEhRNUN0bmZack53cTNMMlVX?=
 =?utf-8?B?N0lwbmw0anNmalJnN0lDaDE3MmlzZWdlWmIrNmZJWjNwNUVlcU9FNmZMR2Iy?=
 =?utf-8?B?QkZGbVhqclVhalFOYlhCeWlza052a0xsYVo3bC9WUnlkYlBjTlljN3BGdk9S?=
 =?utf-8?B?b21iMVY2bHAwalJEWG5rQzE5Q3pnZ1dXUXo2MmxpdCtGNVk5aDBvUEpqM3VR?=
 =?utf-8?B?cjRLUFF5Wm1ESmRvTnVqTWI3NG9wZkw3RU5FeHJZUjZpeGwwR0QrTU5KYTRl?=
 =?utf-8?B?R1JmUElML0dSaVhiRlROTUJVOEJjQTBTRjBXK1NYQzJnZ2p6V2tlQnNjdVFk?=
 =?utf-8?B?SVZpRUJhbUVuc0hGbmpKbW5FbHlKdEIwbk5lQzJrZGxzWmE2S2pDMUZVdW5T?=
 =?utf-8?B?OUZnVTBkVVZscGZqWFRDTEh4OGtDdk1sODlNa1F4TllVKzZaNDNhY25Ga1la?=
 =?utf-8?B?RTF3anNoOFRRalN3eko2N2lETk1nZkJFUWxZeXZqVER6Q2ZpNWkyK2hCTHBZ?=
 =?utf-8?B?d1hjM3kzLzNYN0k5NXI0bmlHR1dFekZDOEV5Mm1IMFA0dG53clVuNG05QU5k?=
 =?utf-8?B?QWFjclZFdmc3ekxrUFRHSUdtcUZhMi9ISkQ4OTAzUjdMZnp5K25BcmZWQmpm?=
 =?utf-8?B?czRFM1ZpeE9Md3NXb2tLdkswWFpVQ2tLOUZyTk5xaThFam9SY2JXdHpLaVlV?=
 =?utf-8?B?czl4WXF3QUNjVDZISVVZV3R3NXRHUWV0dWZpaytuOW5JVkJtcGtKcWo2RHdn?=
 =?utf-8?B?dm1UYUs5ZVRuZkZBY2xBNk9seitCL1MxVmYyeGFHUjZqQnBWZnRrSXpkeWtT?=
 =?utf-8?B?Z2dIZEpQaktKUlNtOWYyb0UxZ0lRV0cwZDNSM2FDaDdOelFicDJHNU94RjVI?=
 =?utf-8?B?YUg0N1lOOFNrMWEyQXlQbE5ucUdGbFVJVnB5TjRzc0NseDRETEpjbDV2VTlU?=
 =?utf-8?B?dWhEMnVhMUkzdmZuZzRHaVAxLzB3PT0=?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb669d17-9991-4257-932e-08dafd117659
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2023 07:14:27.1011
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rHbCDx2UrWTVs9lIfiLaH/vb3mdh20dOOU/YWbZiHY092GDVG4yow4ZQrj4BvAD12mHtso+qgF1FeUy72ho02w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB7600
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 23 Jan 2023 07:14:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10460

On 23.01.23 08:10, Srinuvasan A wrote:
> From: Srinuvasan A <srinuvasan.a@siemens.com>
> 
> Update cip-kernels to latest one.
> 
> Signed-off-by: Srinuvasan A <srinuvasan.a@siemens.com>
> ---
>  ....265-cip85-rt27.bb => linux-cip-rt_4.19.269-cip88-rt28.bb} | 4 ++--
>  ...inux-cip_4.19.269-cip88.bb => linux-cip_4.19.270-cip89.bb} | 4 ++--
>  ...inux-cip_5.10.161-cip23.bb => linux-cip_5.10.162-cip24.bb} | 4 ++--
>  3 files changed, 6 insertions(+), 6 deletions(-)
>  rename recipes-kernel/linux/{linux-cip-rt_4.19.265-cip85-rt27.bb => linux-cip-rt_4.19.269-cip88-rt28.bb} (60%)
>  rename recipes-kernel/linux/{linux-cip_4.19.269-cip88.bb => linux-cip_4.19.270-cip89.bb} (60%)
>  rename recipes-kernel/linux/{linux-cip_5.10.161-cip23.bb => linux-cip_5.10.162-cip24.bb} (60%)
> 
> diff --git a/recipes-kernel/linux/linux-cip-rt_4.19.265-cip85-rt27.bb b/recipes-kernel/linux/linux-cip-rt_4.19.269-cip88-rt28.bb
> similarity index 60%
> rename from recipes-kernel/linux/linux-cip-rt_4.19.265-cip85-rt27.bb
> rename to recipes-kernel/linux/linux-cip-rt_4.19.269-cip88-rt28.bb
> index 3747cf2..9ea66f5 100644
> --- a/recipes-kernel/linux/linux-cip-rt_4.19.265-cip85-rt27.bb
> +++ b/recipes-kernel/linux/linux-cip-rt_4.19.269-cip88-rt28.bb
> @@ -1,7 +1,7 @@
>  #
>  # CIP Core, generic profile
>  #
> -# Copyright (c) Siemens AG, 2019 - 2022
> +# Copyright (c) Siemens AG, 2019 - 2023
>  #
>  # Authors:
>  #  Jan Kiszka <jan.kiszka@siemens.com>
> @@ -13,4 +13,4 @@ require linux-cip-rt-common.inc
>  
>  KERNEL_DEFCONFIG_VERSION ?= "4.19.y-cip"
>  
> -SRC_URI[sha256sum] = "5d93f08f6a4371e90eced62207a14e58c3751b3acbfdf76f20bbf237f12dd547"
> +SRC_URI[sha256sum] = "da6d67e1de1bf314d0938ec2f2a87b91128a1df6a12262e649933078b36d7c23"
> diff --git a/recipes-kernel/linux/linux-cip_4.19.269-cip88.bb b/recipes-kernel/linux/linux-cip_4.19.270-cip89.bb
> similarity index 60%
> rename from recipes-kernel/linux/linux-cip_4.19.269-cip88.bb
> rename to recipes-kernel/linux/linux-cip_4.19.270-cip89.bb
> index 8957c37..ca64a76 100644
> --- a/recipes-kernel/linux/linux-cip_4.19.269-cip88.bb
> +++ b/recipes-kernel/linux/linux-cip_4.19.270-cip89.bb
> @@ -1,7 +1,7 @@
>  #
>  # CIP Core, generic profile
>  #
> -# Copyright (c) Siemens AG, 2019-2022
> +# Copyright (c) Siemens AG, 2019-2023
>  #
>  # Authors:
>  #  Jan Kiszka <jan.kiszka@siemens.com>
> @@ -13,4 +13,4 @@ require linux-cip-common.inc
>  
>  KERNEL_DEFCONFIG_VERSION ?= "4.19.y-cip"
>  
> -SRC_URI[sha256sum] = "45280ef125d1a4dcd7a94b5ae66e4401d999abedf7f8bf9be9ff8e22ff42b192"
> +SRC_URI[sha256sum] = "e91ca34303d01ed9e366f4d0a171f96eef61242623e20bf3e175a8ce10f0a386"
> diff --git a/recipes-kernel/linux/linux-cip_5.10.161-cip23.bb b/recipes-kernel/linux/linux-cip_5.10.162-cip24.bb
> similarity index 60%
> rename from recipes-kernel/linux/linux-cip_5.10.161-cip23.bb
> rename to recipes-kernel/linux/linux-cip_5.10.162-cip24.bb
> index 81c39da..566caf6 100644
> --- a/recipes-kernel/linux/linux-cip_5.10.161-cip23.bb
> +++ b/recipes-kernel/linux/linux-cip_5.10.162-cip24.bb
> @@ -1,7 +1,7 @@
>  #
>  # CIP Core, generic profile
>  #
> -# Copyright (c) Siemens AG, 2021-2022
> +# Copyright (c) Siemens AG, 2021-2023
>  #
>  # Authors:
>  #  Jan Kiszka <jan.kiszka@siemens.com>
> @@ -13,4 +13,4 @@ require linux-cip-common.inc
>  
>  KERNEL_DEFCONFIG_VERSION ?= "5.10.y-cip"
>  
> -SRC_URI[sha256sum] = "a622173fa0a2104b1c3aa51012cb32a1c3eede559b7b6026106de287a46003c8"
> +SRC_URI[sha256sum] = "fb0edc3c18e47d2b6974cb0880a0afb5c3fa08f50ee87dfdf24349405ea5f8ae"

Thanks, applied.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


