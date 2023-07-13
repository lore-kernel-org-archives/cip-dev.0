Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DACCAC001B0
	for <webhook@archiver.kernel.org>; Thu, 13 Jul 2023 17:07:11 +0000 (UTC)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (EUR04-VI1-obe.outbound.protection.outlook.com [40.107.8.79])
 by mx.groups.io with SMTP id smtpd.web11.2385.1689268029729200875
 for <cip-dev@lists.cip-project.org>;
 Thu, 13 Jul 2023 10:07:10 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=RDX8aoby;
 spf=pass (domain: siemens.com, ip: 40.107.8.79, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TLPI5x6Dbc/W5w0p1TGgyOFg9tKE/stLf10L3YwylijVr9swl9pyan2liA5SYIUHrQGH0A/niyspCECj7byEB4EhhLNPMu+GxNkPwOs9cPDTO/fD3cqRh5fdftipugkP4atPp0D9gII6+qjANi55wvjThW225XkYe9VK+cIPo65AxjOnlN4C2hkiRaRZHYLPxLOwK5cVMlznPlGxFGOHjyCHPEVGnSUOZpP8lnjsLej0asSFeWJqZ/bWbE6L4p8s1QuSlSAROAQSmoHPrq/doMhII7n0zSsyIRcsc1KIbetvm8NmO0I30yyLO0KVcs4sruu218m5edd3T6dcMlp6rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t2zgPhyIB1dEMNgHDFLL45MkyJKmTsyFav4pv2psjsY=;
 b=IsA8v/PS2hT1PwKjdcLMLPv7czi3Upw8QdO+YJBwfjsboCFQ5pbyMKyRWrq4f1Bsd8UOjRR87f0nGZA3wZQ7kA50As1l09UABvI3dFIrgAheenCsmq1xZQ144l/sFdVbkcg14+065JBcsRxcU0+90eMwfE+ZPwBz1oGMWITm5U0mgMfoCt2oTK6z2bwvCXo973P/YCIzrJ5sEpesvLAAktmcRFDH/mlLmk0zOSZGhhaUHPd4rLZ7LdGb3weW068n72rlXZI1BRAc7cnpzHALLpH4jGp274TX2gkdAxvnxMSvFytIb9hmR+fr1zcK5+jw9BSQTo2myopyXifj76g9Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t2zgPhyIB1dEMNgHDFLL45MkyJKmTsyFav4pv2psjsY=;
 b=RDX8aobyM7dVSsYkoZCVc7/DElNgIJSyVoPoP/mWBa6iVPbL42GI/EKU0+K6Jd6pV84afbDSwFpKy30dwuXyrU/tg2WuW7VM+cIor5fHOaVxb6WhCYhTGvjmMBJxB3f8LveNQYBLDbMsLjTZQdsamUiN1py3i9h79qpFEEtRYD7FPHVKciHC1NYx6cTenDFTXLKLKCYV2oDQBTQ3DayGfz1XS4bnV5uUsPyk6gpO4Lgo/H6S5SU4H78U6V6XzuVN+7lZEpiwCI/k/7ucSmXIXuGLs618KQW99mikFivasGReM/pe4qIIO9Gtx4v4mVHtdq8twpVKgAN7sThhLydErA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB6177.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3e8::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.24; Thu, 13 Jul
 2023 17:07:06 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f964:e0e9:199:9246]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f964:e0e9:199:9246%6]) with mapi id 15.20.6565.028; Thu, 13 Jul 2023
 17:07:06 +0000
Message-ID: <dd74be31-e7b5-6794-4b5b-8298bc97fa5a@siemens.com>
Date: Thu, 13 Jul 2023 19:06:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [cip-dev][isar-cip-core][RFC 3/3] swupdate: Enable signed updates
Content-Language: en-US
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org
References: <20230713164055.2786350-1-Quirin.Gylstorff@siemens.com>
 <20230713164055.2786350-4-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230713164055.2786350-4-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0129.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:94::17) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB6177:EE_
X-MS-Office365-Filtering-Correlation-Id: b16b6ad5-640a-451b-b3aa-08db83c395f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	4qy4Cp54VPaoWsrRTRIRiSeBv6GhorjFCLEeXMPtu79VZ7MmzW53EJZFiBn6pRoX6AYp2dXggrhsdJvk8XGaMQ3O9BCJjofnDYHtlN/CKdBQysIUZmVOyi0IK1+NgiSv68M+ihFQcPQUlP50Pw32cvkpzyGi0gipY+cRQ545hOn7RINtz4HawI6j0RPRddj15IIzdxE7lfPhEbbYYAHZvCrrsSLZ7tJpFWEeiehI8mCtC8Q0VXojYm19vkVNFlGA35sj1MnOCZ0GQ6/XsXNTEMgjGHmiOwR7h4FWJUOhE4vaH44qz4v9oiNc29cGBT/mo1MEDk/8K7C3IvJBqQmy86uehsglohHT8wVE439Y7amBZcXtgEcFVb8+tXx5l6QRZArfLApRVP1ymt/OBUqIcLXgeFgxgwxaWJcdsf2SG+4NQx4PExaA0xDHgUsF4O67ONPVpEtVFIMzGsKWVqI/wei9qUf9sIyVsCtH259/JpS/E+RbeVzP9WpIjHFCVNMGI0+9ee9nnOKxY8fgIqE9xVP0AZd8XqcLnGtOydKRg34/vNBeMF3zmTka4HZTDKVeP4LuR5B5Y/l/l//9EMzRAmznBFa8zdFRwznAxE/Oexi0Wcl+kajqBARwOfqbLRPPO7LVmqXJizwQGDLMjD3h7A==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(376002)(39860400002)(396003)(136003)(451199021)(44832011)(15650500001)(2906002)(41300700001)(2616005)(36756003)(6506007)(5660300002)(186003)(53546011)(8936002)(8676002)(31696002)(86362001)(6666004)(478600001)(82960400001)(38100700002)(31686004)(316002)(6512007)(83380400001)(66946007)(6486002)(66476007)(66556008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Y0djZ3RQVnZDK096TUM5Uk85RC9nSXdCbk10Sm51VzY5OGdqNWNmeWp0a05W?=
 =?utf-8?B?UkZJNE50cGlUd3YxbFlUWWNLM1lWcmlVWm9mUTFvby9zYzY3ME5PcFNJaXlx?=
 =?utf-8?B?NHNaa3htb3MyZk9KdWhBYXRTcVRUVDU0VnFvK3ZJbWtHcHZKV3prWkpZQnZY?=
 =?utf-8?B?Mk80YzVmbFJvU053ZVRBOFpKczY2NGxxRm9CTG1Caml4dUFZUi8wWHV0SUd0?=
 =?utf-8?B?Y1lTNVl2WjNERWhDRmEvZ3o0Lyt2NUpTQW11WGUwMEdoaHBSbEV3cFFtN3N5?=
 =?utf-8?B?bVRSOFVzcnl6M3drUXg2cUNRSlViMUZ2SWo2aHltMDBndndUYzZPZ1VMeGtq?=
 =?utf-8?B?RWZQYUVOK1JwaHBNWk1RN294WlFJbDh0ZDlnZ1lJWmlSZWxPcEZMc1U2am9H?=
 =?utf-8?B?YTE4QTcyZjBKaC9vVXJEY0FGbi9VcUlnc1d5M29WYVRqWkt3cVdBbUNDa0NF?=
 =?utf-8?B?SnBTL0docFdVbHp6UXBDOEhnTmdKbGoyUHordVB0MGpRNHpWN0h3QnYwMDVO?=
 =?utf-8?B?N2NNZ1dGenJmVkRGM05uQlkyOVJqSmlObjlQUXk5T2JGQ0xZVkFZaTBSTnhB?=
 =?utf-8?B?Y09LcE9sckdTam42bHdudGM0QmtoWldzdzAzZDV2c1pSL1NDRjRHWW02aFZm?=
 =?utf-8?B?R0ZGK2pEV05yM3M3Wmt1NHJIVGNOaDZ0MEMvaWZGcVAvQ1NoODR4YXZkRElW?=
 =?utf-8?B?YmhCaWYyL3FDM1pCeW5Ba1p0VE5NU3dINlNJTlNKdDBJQTJoYTQrejArWmJK?=
 =?utf-8?B?RVFPczAyYmFOQ2JHWjRTTmw5eklLZUYydmFNODFUT29rY1lIS3RxeWptVWg0?=
 =?utf-8?B?c3BleUhoYzREMHNnblo1ZjdVbW15bGlsNVpuSGJnMzU5NE81TTNneW9QeXlY?=
 =?utf-8?B?MHJSQ29ZVjMwV2wrR1ZqbmRQTmRhM2RFSEpjQ09BQVErdFZVODVWNWxtVFox?=
 =?utf-8?B?MWFvWTN0a0JOS01EVlViaHUxMm9jcjA1M3hYblVuMFNBQjNOYUJLNVZPNVhR?=
 =?utf-8?B?dWNrVEVhYURhTWFiSnU5cDVQNXRoUUpnb2gyOFpwZHJHMzRUcEttalhETWZh?=
 =?utf-8?B?b1RubGRKOUVKQ3E0cjhqUE5RQS9kd0ZtZm96QmFUZHppK3gzMk1Udko0OXd2?=
 =?utf-8?B?eHpXazQ4ZkZHd3dRUG9SK2d5alhRWDRWQ3NVY29aY0UzVEtNWmcwTyt6OUIz?=
 =?utf-8?B?ajJPMFVJN2NMc0doZDlPNW9BQXpkdmEwUy9RTW5lY0g0S1Mvcmt2WEpGcSsv?=
 =?utf-8?B?Ti9tRHpCUjd6ckpmR29VRnNpNDJiMHRCWXh4eDJ2R0tMTUpDcnp3bkllYWVR?=
 =?utf-8?B?bWxkYzBSRURUc0s1cEdlc3dNS0tjRjhDVkxNeWI3enFPWHhjSGNMaTlyS3lQ?=
 =?utf-8?B?VGxsRHQyN0wwSzhEWmg5Z2xCRkllNmV6bGsyMit4VW9Bc0kvejEzNVVLKzR0?=
 =?utf-8?B?UmdYc2dXTUlnK0R3dTZUWnNBVk1QbCtvcDVlcmJPa05vcmE3MTVQYllKS1V5?=
 =?utf-8?B?dVZqNTg2QmEwT2piWVY0R3p6RXY4cWcxbDNCTlNmVUFPYnJuSVBZQTY0ZVNk?=
 =?utf-8?B?SW5NYndVMkR2YWRlZ1FJTlpQNitSY2NoSEF0Yk90SUlEZ1dhbHBKRTZxSEN5?=
 =?utf-8?B?ZE4rY04yRFh6aUVqV1hnKzFrT3p6VjFiSUdhM1NkNXB1U3pUTUxJNGpsTWxV?=
 =?utf-8?B?V1NuVllTZUdyWFpwTDVJcGpoQ2lVNDduNkxFUU9ob25ha3FNd3NqNkszSHNQ?=
 =?utf-8?B?ZEZhdFlPY2NpZElsMDI5UmllUXJWTkpGYlNnaXFCTHMrbGJxVjB6ZGN5WWlk?=
 =?utf-8?B?OFM1WUJXVGxLUTZRRTRqZjE0NGJlZDFBc3ZLKzgrYnZzTkNRU3JCcDJTU2tL?=
 =?utf-8?B?WW9xWFJweERhcFBOZUtHMURGVWw3emdHWVZqOUxySFVvNEo4ZE5KWW9mSmVE?=
 =?utf-8?B?Y05IbWU3alNYSjBTUHdXTjJlbWxFYXR6cXMyazZpOUJjdnZrOTVWVzRyL3hj?=
 =?utf-8?B?dEtnVnkxUklzZUVRcHJMUW1BTmRaZlVHZDFUaCtPWGRudFJsWklLNHYxQXVG?=
 =?utf-8?B?R0tnN2tieE1aelA0dVRvY09hMmxySU91ZmRiOGI2MVpWaDJZU1hRb2FnVG5x?=
 =?utf-8?B?dlUzSnNvNnMzRWs5bWh3eE1zVGdWVFFDYTZHN205MHNRQm85QnZzb0F5U3Zz?=
 =?utf-8?B?M0FFR2x0RVo1dUlqSm5FYkdBTXdNNC81RGMwTm0xbzkrbFdUL0FkVFVKa25t?=
 =?utf-8?B?c3dJR3c0NjFCTkhybXNOTFlJeVl3PT0=?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b16b6ad5-640a-451b-b3aa-08db83c395f6
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 17:07:06.1825
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0C4dXTJsYoKj3P0A/B5NypyknTVtf/SkBsz4y4YdAJbyvzFPkta67uOIhxUtxeeeZeam8H7AVGIx8FGbRNM9jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6177
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 13 Jul 2023 17:07:11 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12339

On 13.07.23 18:40, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> With this change SWUpdate requires signed binaries to update
> the system. An update without the correct signature will lead to the
> following error message:
> ```
> Error: SWUpdate is built for signed images, provide a public key file.
> ```
> 
> If unsigned binaries are wanted readd the Build option
> ```
> DEB_BUILD_PROFILES += "pkg.swupdate.nosigning"
> ```
> to a swupdate_%.bbappend recipe
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  conf/distro/cip-core-common.inc                | 1 +
>  kas/opt/swupdate.yml                           | 2 ++
>  recipes-core/customizations/files/swupdate.cfg | 1 +
>  recipes-core/images/swupdate.inc               | 4 ++++
>  recipes-core/swupdate/swupdate_2023.05.bb      | 3 +--
>  5 files changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/conf/distro/cip-core-common.inc b/conf/distro/cip-core-common.inc
> index 5d3ce10..a3d959f 100644
> --- a/conf/distro/cip-core-common.inc
> +++ b/conf/distro/cip-core-common.inc
> @@ -14,3 +14,4 @@ KERNEL_NAME ?= "cip"
>  WKS_FILE ?= "${MACHINE}.wks"
>  
>  CIP_IMAGE_OPTIONS ?= ""
> +

Stray whitespace change.

> diff --git a/kas/opt/swupdate.yml b/kas/opt/swupdate.yml
> index b0293ce..0e30e89 100644
> --- a/kas/opt/swupdate.yml
> +++ b/kas/opt/swupdate.yml
> @@ -28,3 +28,5 @@ local_conf_header:
>      INITRAMFS_INSTALL:append = " initramfs-squashfs-hook"
>      ABROOTFS_PART_UUID_A ?= "fedcba98-7654-3210-cafe-5e0710000001"
>      ABROOTFS_PART_UUID_B ?= "fedcba98-7654-3210-cafe-5e0710000002"
> +    PREFERRED_PROVIDER_swupdate-certificates-key ??= "swupdate-certificates-key-snakeoil"
> +    PREFERRED_PROVIDER_swupdate-certificates ??= "swupdate-certificates-snakeoil"
> diff --git a/recipes-core/customizations/files/swupdate.cfg b/recipes-core/customizations/files/swupdate.cfg
> index 9ee47c7..3e2b45c 100644
> --- a/recipes-core/customizations/files/swupdate.cfg
> +++ b/recipes-core/customizations/files/swupdate.cfg
> @@ -1,4 +1,5 @@
>  globals :
>  {
>      bootloader = "ebg";
> +    public-key-file = "/usr/share/swupdate-signing/swupdate-sign.crt"
>  };
> diff --git a/recipes-core/images/swupdate.inc b/recipes-core/images/swupdate.inc
> index 6a01abb..6b7da60 100644
> --- a/recipes-core/images/swupdate.inc
> +++ b/recipes-core/images/swupdate.inc
> @@ -12,6 +12,10 @@
>  inherit image_uuid
>  inherit read-only-rootfs
>  
> +SWU_SIGNED = "1"

Shouldn't this be a weak assignment?

> +SWU_SIGNATURE_TYPE = "cms"
> +IMAGE_INSTALL += " swupdate-certificates"

...and this installation depend on SWU_SIGNED?

> +
>  IMAGE_INSTALL += " swupdate"
>  
>  IMAGE_INSTALL += " swupdate-handler-roundrobin"
> diff --git a/recipes-core/swupdate/swupdate_2023.05.bb b/recipes-core/swupdate/swupdate_2023.05.bb
> index 26c0e67..d744173 100644
> --- a/recipes-core/swupdate/swupdate_2023.05.bb
> +++ b/recipes-core/swupdate/swupdate_2023.05.bb
> @@ -31,8 +31,7 @@ SRC_URI += "file://0001-d-rules-Add-option-for-suricatta_lua.patch \
>              file://0003-d-patches-Add-patch-to-add-the-build-version-to-swup.patch \
>              file://0004-d-rules-Add-option-to-enable-suricatta_wfx.patch"
>  
> -# deactivate signing and hardware compability for simple a/b rootfs update
> -DEB_BUILD_PROFILES += "pkg.swupdate.nosigning"
> +# deactivate hardware compability for simple a/b rootfs update
>  DEB_BUILD_PROFILES += "pkg.swupdate.nohwcompat"
>  
>  # suricatta wfx requires suricatta lua and the dependency

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


