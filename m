Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C579DC7618E
	for <webhook@archiver.kernel.org>; Wed, 26 Apr 2023 09:51:37 +0000 (UTC)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (EUR04-HE1-obe.outbound.protection.outlook.com [40.107.7.58])
 by mx.groups.io with SMTP id smtpd.web10.4111.1682502696519565916
 for <cip-dev@lists.cip-project.org>;
 Wed, 26 Apr 2023 02:51:37 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=aGU5yYiP;
 spf=pass (domain: siemens.com, ip: 40.107.7.58, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FmIp2DxFWFUWCQ/Nh3LCxAoo/suSrvss2d43O+GZWOucyQGQKuek5OfbPeLfB6RYKETRUKPyGJZQLMSrq2bV2E+ELxujiJ1u0QTM+P8uL5kOu19ZPqFbub95zrjX1JZwpLV0mtZiBNe8gMTKOFXkHX+UQb1eBP7MbPnuRUpmZbXU3nzBygnfVklZ8Ey7kYEE78RIhPoxF1+RW/rKrieeYZfsTEO1QjDHPFnuTxcW3y5wYjGzh6r1VSlvoCVyi9Zd4dzW58gFHTztxXjVhcKJy/LtA81F3VDJqZoprTOmuXximYOaS0tD0Qklzq8usRfWS3WIpV4Ti5hda3vepOmOMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FAhuQ7TR69v70qOJ1xju49ZgX0m1Yga95+4ksRr2t2o=;
 b=JVpYExwIPD34sADSChnpUS6Ts6agt3hZiM27j5dqDTDelgi5T6hRbdy1/UT11Kd6H8JNfisenBIXgQFqSY02lKbKHF6WD2jkv8MyVCuhrtI5/bZqGHyB9BLLFEyoPVqtWTRKp34aZp6Aay/2MRvv6I7A2wjPq1VWW46iHienMC4f9TWVfkdBLz5w2lPap6u/nDR19sDdZ5ifAFG9A14NtgOXawwrCP1UXtgGv32TU1TF/r2fXUWvOMPyX9Ei/70rrOUUUC+f5wpGfkdJ8VPKgYkb/+71tKgNbhUHRm2qbVRVzsiAEcIQJm4jGEMNqXdJHlTo3hKQiEUMlXTKAMq5BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FAhuQ7TR69v70qOJ1xju49ZgX0m1Yga95+4ksRr2t2o=;
 b=aGU5yYiPdcPjN/KDPczkyu7TTAWpny/5CWkPjxQoG+IFrxNjEeYwS2oO5LtAcZDy4KrtQvxw4mbZuW8ZRfTQ2MRG+iW/URBFfJpAzxC8Z/8w0nZMJYoprOEmjMDiSckVgwrEGglcc+bA7lcCJLUjThOdw2QXQ8V4N10Dug9zdwIrVx4bvXMdDZEKPluDhE2jU0lDHJlDCyOdUMhTeP/tybDU62f3QiVBGEdvbgugrvGLgDRXukA3yDy6LniiA6gTRajlziUdDoyrnnnN9yKZuwrR7c8tIKHK+wZIlFL9xdik0DFW04ooElceZIBzMyNBnXF8W7RDys1wI+ZurPJ1Hg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI1PR10MB3167.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:12d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.21; Wed, 26 Apr
 2023 09:51:33 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f5ab:5f59:3b47:fc2e]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f5ab:5f59:3b47:fc2e%4]) with mapi id 15.20.6340.019; Wed, 26 Apr 2023
 09:51:33 +0000
Message-ID: <b5dc46c3-904e-0831-1b10-003b5b619d01@siemens.com>
Date: Wed, 26 Apr 2023 11:51:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH] linux-cip: Update to latest releases
Content-Language: en-US
To: Srinuvasan Arjunan <srinuvasan_a@mentor.com>,
 cip-dev@lists.cip-project.org
Cc: Srinuvasan A <srinuvasan.a@siemens.com>
References: <20230425094304.3212474-1-srinuvasan_a@mentor.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230425094304.3212474-1-srinuvasan_a@mentor.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0032.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::13) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI1PR10MB3167:EE_
X-MS-Office365-Filtering-Correlation-Id: bea2263f-6d0e-4427-8c95-08db463bd12d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	WITTCtVoMocmICOnKWli2Q6g4o4cSIoXdlbXZZiUjrxx9KBS6JnmQOYpP+6yhxowj/2Im0qUqiRUi9raBdTR7Yoj5YY+nzI3NsUNza3I+Z2XIj0KoXIvMydYwoIJcxwA6uoRpmwLgqp3kEqXNv5tXGBJ1jTvxBsjqbjKstW7288IMOqM9qjglYGPh0oxg2jOLZC3g9NVyQLk+9CO8uOuHYdffDH1LoO6GW8KdSjhPHupFHq3ZHdRKsFkGb8IFjWcPWdnyFQV7ve3SxDUEtSI9KsGA2Q/LMwVB33JAsKcEeaOvZ20kpclhJ7GhEeMV6U3NBm7pPt0F3LDSBwIIpOvS32zQORqbtkfJwuU31zlbjw/k9cIGAjgNHYWuFiuBfn05PVIXP8h3I3P4RkZ67QXTpe+9HDtSNVPHj/T8jcYgCvJs9XhnkvkGP577/HB4RFZ9wBeMWZihJK+9z8yP8M2QfohoPJ8RPEogRV/Lbmbjg0jcqn4s5kUUqZ3eI72J9mJRyzUyELa5T4dMN2cNg4UGHQNhszgwyOXieToE2YclYWnyOPU9tWwvIpx1aPQCTI1p6dB+qS5JLbRPy5o5pDHpN3/03EKBFSfSaceccjGIsX1/yITXmw7QUUfB/lIO4abbsShZKq/+WsAwTlNGBTqyw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(366004)(346002)(39860400002)(376002)(451199021)(83380400001)(107886003)(31686004)(2616005)(186003)(26005)(53546011)(6506007)(6512007)(66476007)(66946007)(66556008)(82960400001)(86362001)(38100700002)(2906002)(44832011)(31696002)(4326008)(41300700001)(316002)(478600001)(8676002)(8936002)(5660300002)(36756003)(6486002)(6666004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?dk4xbEVqejU0a21WYy9tZHBBZkNMcXVnMUVBMG5uYWFTTEdHTk96ZU8vMkFq?=
 =?utf-8?B?ZGJBcC9TNWdIR2NjT3BSTlp4dnk3cUF3cDZZSFJVaXlEdFgySXlwZlU3OW0y?=
 =?utf-8?B?d1ZuR0xNZGFRVDE1ZmxnejdjTkl4YzhQVm5tK3dDcFFqYTgwcGZHVmhFNTE2?=
 =?utf-8?B?TjUwNUNMZWdkYjFuYWlxTGZRelAzNkVBdktrUDRjVTZtbURQQUhFV3lVWHQv?=
 =?utf-8?B?UGkrTFpXRGllclNjeEdLSEVVZzFqUkhNdlhIaGxVZ2FtcDhDU2ZmV1JEeHNP?=
 =?utf-8?B?blI0Z1RQSHZkOVpxbHl3Mkw0UE5YaGR6NmhsS1RCekh4MjFIM3dhNWMralU1?=
 =?utf-8?B?SlpNWHhMdWZRU1ZQZXFUeGNGRDZGcDR4ZnBNeGUwdnY4TDlsRVFUeEF3U042?=
 =?utf-8?B?TG04YktzS2RtRGIvdWpVcnlYQmZOM2lBNUdOaGpMUGtSZVBzRlhIc2lsclFN?=
 =?utf-8?B?VFUrd2Z5czZlcmxMWVVNQjQ4dWxwZGpnNjIvdkc2NjRCMW5tR2FVTUVGc2Zo?=
 =?utf-8?B?K1Fhb1h2SHhFM3daYmFMMklyZUl6b3ZZRmFvaVIvM1pLVk8vQk41elNDZFly?=
 =?utf-8?B?TTZGQ0VnaGNhczY2SkpLSnNSb3R5d3B2SXVXWXhsbjJ6bnpQbHEwbXNaWndw?=
 =?utf-8?B?OUpMTHpPWE1ocTFvajRJVy9rTnVBU2FzcHdmbzRFOThIMjQrdXVyRHlBQngy?=
 =?utf-8?B?WVdWYXNnalU4TVlOQjlqMGtRbkRKRkNWSkRXYVdzdi8yNU1RMzlCN1JhWlJC?=
 =?utf-8?B?VUh5UE1UQnVCcmFhQUQxOHBSSWMvTkErYXJkOWppQ2kveXVwdGxOVU94aGRS?=
 =?utf-8?B?ZVRBWWxjNWZaMGwrUm8rUDdRZkFsdkJBVnBRMStMVWVmOTB4MHYvSk1QeEdQ?=
 =?utf-8?B?TjloSEtJSkltemxlUnlmN3ZxTldSVGhROWtOY0Y3VDFsbjlqS1dRS2FZTWh5?=
 =?utf-8?B?WTYrUVlScmhVTk9RT3dSVEFIMkNVNDZXSDJxcGdEUGZFY29xTmYvb2Z6bVZ2?=
 =?utf-8?B?RmVMSlBwVk81Tmh4eU1QdGVwbjlMRDIyUmUxOERUL0tibnI5WjNsdlNSK2Nw?=
 =?utf-8?B?TzVnZEcrdHNlOUdnZ2krZTRDY1I5UmtMS2UxSXMxMkRsMnJQL3o5NExhcHlB?=
 =?utf-8?B?c3RhR3pGRGdXRlh5Z2ZZU3MxUXhyRkx3NDYzWE9xZ1MzSHhqTFpoTXBQNElw?=
 =?utf-8?B?SEZsRmRrZHRHR29ONzJ4UVVxekRSNnE2VjlYMFFPajZxakpVMTRmN1FyWFRl?=
 =?utf-8?B?ajEyUnBVeWIwM3l2UmJIZHlFZkVGbWhRaTh1WHY5ZDFhVjhHUjYzVEUrcFlT?=
 =?utf-8?B?MWxMM2hrUndvd1NqVG14b3huSDF5UzV1U1RoM1RnalpkcnVuOTBDYmowRkYy?=
 =?utf-8?B?d3JicG5mc1RGeStWZm1TR1lycHVtaTkwc0ZKcXcxTWZxU1k3K2Q1YWZkNDNI?=
 =?utf-8?B?VXhOeEZkT0lURVhuUFoxb29yb1B5b2xEaXZSYmNyd211UlVRMHZpWTRFYStp?=
 =?utf-8?B?M3BUblJtQVluTUUySEIrNmRyRG5nNmd2TVR2SmE0S1NpenRGTDZXZGVJZ3d5?=
 =?utf-8?B?RWZCNnhxSmFoRUozaVR6Q0FpajJBM21sakx6VDQzOERadFMxZDZZUCtJZDV1?=
 =?utf-8?B?d3BQL0VRWU13dnlCeTFPLzY2dDB0R0JIUnBrd1JFa0ppVWdZdHFRcHEwZzVi?=
 =?utf-8?B?ellPaDN1K2x1WkJCanNtZGNOdGdKbTBhcERxcXEzaWdLOHo1Q01oTmxwbk5T?=
 =?utf-8?B?QVZSV1FSNlZVdnFxaDRpOGZYSU1MbGFVWFhCaE1kZDB2WWphVUdPTUdIajRI?=
 =?utf-8?B?emhmWXVESE9teWVWN2xrLzA5eU4yQWpxSUI0MFphVlVsRlgzQ200b3paK2x0?=
 =?utf-8?B?NC8xSWlEcEg3clVDK0tkMytoSmk0TGd2NE85T2VWSmo5K1NJRHZjSy9sa1ps?=
 =?utf-8?B?OXFKMWRvTE1EMVg5MmFqMHVlbzIxbU5FdVAzRlh5L1dsY0s4clhRZ0JNWlBN?=
 =?utf-8?B?aW9wa0tCS0dUeTdmZXAvaUtnc3dsSlpoZi93TEFhT3lpN094c2FWcnE4NTll?=
 =?utf-8?B?K1FnRk1LcGNnSkNXdUNrUC8yNUtpYU5nZlBzSTFtSmdHV0JWVGlUQXVqU2Iv?=
 =?utf-8?Q?Iugaw6pllP7lB5cdJMtwWCB8e?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bea2263f-6d0e-4427-8c95-08db463bd12d
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2023 09:51:33.0694
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iRA5Yu9uoFLpnGA4tHLTmgn3P9PP2IBIO68O/F53HDIlMJUT9KOx6drpw48ZKya7VoRbJ4Zp+wPf89tZ8seCeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3167
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 26 Apr 2023 09:51:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11351

On 25.04.23 11:43, Srinuvasan Arjunan wrote:
> From: Srinuvasan A <srinuvasan.a@siemens.com>
> 
> Signed-off-by: Srinuvasan A <srinuvasan.a@siemens.com>
> ---
>  ...{linux-cip_4.19.279-cip95.bb => linux-cip_4.19.280-cip96.bb} | 2 +-
>  ...{linux-cip_5.10.176-cip30.bb => linux-cip_5.10.177-cip31.bb} | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>  rename recipes-kernel/linux/{linux-cip_4.19.279-cip95.bb => linux-cip_4.19.280-cip96.bb} (72%)
>  rename recipes-kernel/linux/{linux-cip_5.10.176-cip30.bb => linux-cip_5.10.177-cip31.bb} (72%)
> 
> diff --git a/recipes-kernel/linux/linux-cip_4.19.279-cip95.bb b/recipes-kernel/linux/linux-cip_4.19.280-cip96.bb
> similarity index 72%
> rename from recipes-kernel/linux/linux-cip_4.19.279-cip95.bb
> rename to recipes-kernel/linux/linux-cip_4.19.280-cip96.bb
> index 802a855..0a1af14 100644
> --- a/recipes-kernel/linux/linux-cip_4.19.279-cip95.bb
> +++ b/recipes-kernel/linux/linux-cip_4.19.280-cip96.bb
> @@ -13,4 +13,4 @@ require linux-cip-common.inc
>  
>  KERNEL_DEFCONFIG_VERSION ?= "4.19.y-cip"
>  
> -SRC_URI[sha256sum] = "fb5808626317e464408203562941d287fc49f747f3af1c1a34c125229a5efa43"
> +SRC_URI[sha256sum] = "30f092e20799b9797376ee40d14995fd31a68773dff0b4913d4bbe5848cab5f6"
> diff --git a/recipes-kernel/linux/linux-cip_5.10.176-cip30.bb b/recipes-kernel/linux/linux-cip_5.10.177-cip31.bb
> similarity index 72%
> rename from recipes-kernel/linux/linux-cip_5.10.176-cip30.bb
> rename to recipes-kernel/linux/linux-cip_5.10.177-cip31.bb
> index 6f740f5..08bc8ad 100644
> --- a/recipes-kernel/linux/linux-cip_5.10.176-cip30.bb
> +++ b/recipes-kernel/linux/linux-cip_5.10.177-cip31.bb
> @@ -13,4 +13,4 @@ require linux-cip-common.inc
>  
>  KERNEL_DEFCONFIG_VERSION ?= "5.10.y-cip"
>  
> -SRC_URI[sha256sum] = "722931b6291d1c796d571ff2e1bf4393734928edb6af7df7138ca0379d9a27c9"
> +SRC_URI[sha256sum] = "7a53197c1bd26c3c2dbcea0d93d287900dc3e0d92199ef13702e5bf78ae97f56"

Thanks, applied.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


