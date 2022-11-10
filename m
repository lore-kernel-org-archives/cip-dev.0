Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E48FC433FE
	for <webhook@archiver.kernel.org>; Thu, 10 Nov 2022 13:46:21 +0000 (UTC)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (EUR04-DB3-obe.outbound.protection.outlook.com [40.107.6.72])
 by mx.groups.io with SMTP id smtpd.web12.7612.1668087968195557954
 for <cip-dev@lists.cip-project.org>;
 Thu, 10 Nov 2022 05:46:08 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=AIA1tVLe;
 spf=pass (domain: siemens.com, ip: 40.107.6.72, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iSIkZCL9Xl4o4ijc3aQmeEFN6GpxtZYwnwk4Z9IViD7d14xutGT3yAV/EWYTaoiFiUpqQIpt4+c/sDsN2Lo4PMLV3+msipaYAf6pLnCkTevQzPFg2swMeT0PRUOs+r4WoFA8NjPvbItKq1opSWiWs+39XdrtiLrIuYReTZzkgebtF52SfE0ADbNoin4eFOOw5fA5KLazNoatPFB6DkH8MlHokpPHKswKC6GfvmSd4O109S5vMDHjiODQoiJ3lCLgHbPvJ6Ew6oCNDfegrkfGyLubRegXOhNELimX5z6/ff4AiyYRy2a9qdfXhmxDKBOkJQYZt+2JYNesLD6By5hfnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I7CxMRwTL35tmmXvt5DGbQfL5Qw87NljIV70hXET4/M=;
 b=l5tp1anoX3GNMQ/DbdR3W3/6Ko/RAUvGYss27V9NpnXfypnWeMm0nzx0pWiL7eQb+AZnRrLdNSbuqcBsE9RM/ylQLrWM/dAUs7icVpDnw7rnfyv26H7A8J/2agTSTiCLMRytVEXnwdx70nj6xqsTLBJ1EvuirRHLNjMY+KVGzY0rRV9mlBSQHN3BQQp5/V6ElW/USyHLhC+/wFQF2hlcOshRrKCg25rx+ZxlIXcp1Levwxs+N91UzQRp0hx8eXvuJbwu79/wG+Zo5JWpAE2hMQW1owQKCVwfAAtGyMViolbMb6DWVrCgY3HfaHgA763ah9D9vRhjwbraFKdfqzCHbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I7CxMRwTL35tmmXvt5DGbQfL5Qw87NljIV70hXET4/M=;
 b=AIA1tVLej1snoXFEgEKVPkG5xk5S2SAnJMvXHrjl9Wp7vg3WU/rn3AKuECPz7P0HOxFNu9mE0CzYFCUhZDs+oXXHlID9q/HKdw/X3RxknVbD0a45fqMkF/kSZq7AW13oaYGDmn8NHXwpqVSzH6nZ6CuCZB0btg47mBrp2wSpYM/M3s/AlMRZZKIWlMKs9tQYWTNHzt7gU4AfZwctU44dheQ6wZ7sqWC/E9C3HWoBXe99PohK0dsGyLCuwcnp+P29yTtI77axXqwpGEZLZwH4eb45iFSO+zcDfn3xW6owIRTw54MqzUX/DFLS8rAh7SMsKyB+jpiTiSar9kv+8tKv7A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB8PR10MB3894.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:163::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27; Thu, 10 Nov
 2022 13:46:05 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5d9b:b9d1:bd69:107b]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5d9b:b9d1:bd69:107b%4]) with mapi id 15.20.5791.025; Thu, 10 Nov 2022
 13:46:05 +0000
Message-ID: <5e2ecc7c-b368-f44e-c418-bd2c9f86b15b@siemens.com>
Date: Thu, 10 Nov 2022 14:46:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [isar-cip-core][PATCH] linux-cip: Update cip-kernels to latest
 one
Content-Language: en-US
To: Srinuvasan A <Srinuvasan_A@mentor.com>, cip-dev@lists.cip-project.org
References: <20221110092037.2342861-1-Srinuvasan_A@mentor.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20221110092037.2342861-1-Srinuvasan_A@mentor.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM6PR02CA0012.eurprd02.prod.outlook.com
 (2603:10a6:20b:6e::25) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB8PR10MB3894:EE_
X-MS-Office365-Filtering-Correlation-Id: 9cb74281-f55f-4c87-c872-08dac321e9f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	xjeMs5T6tVuAbQONOKa1bn4140RZx4aN23YqvPMxU4Fiy51M754aJ5MIogdBQA+vLLPiko+bkFMUvDf2rBJz2AlepVAAk30QBCUSFKsY7c6Iv9ILGuczd+ibBvbmt+pF9pUnlYOP5KayXOeIc19mZS+oQZ2fa2Ei5cp4o0RV7G6iPNd30v6s7aZqDp1XXuyK9UE4Lo2W1VzPTv+whWVJx+eInZvOeiH2/HB9tY6i5yHu9rd2lHsSvTpNQJ0CN3XZedKEMGR6aS0Po4mGLx6k7dDfYxtgpr5EYl6LaX/JXmmFG3yWwzmod42JxEn6IJwFRAg7IefdVv3s7nF708dYJSOxRm069luP7aMKRXDMD5HvvA5YSpxKHpgs9h8Hr+MWC/mIrh7I7DH6TpJIScv8ydG4ZtOpr+6YsWyqkoRfYd/Ss141DSzOLYLKq+nG7RtBzKgAJbmsH8F4lV+9PUUFNXrahfJsLV2lWSpRhhx43NSuGIVsU1ANlOITtJEeCX+Dj2x0ppMju8NLY7hQMMNBOfYzgYgHEJRps/IgtQRSEa6bXuXw92KC2AWQRcJVwjtRIFPSdrC7rP8rF3MScFcruBl/8DAUXai6ATPGJXnTehgDMkvTlVUuZ9aS9TWW2xgxsW0oLpM5Wj5bJYeUY1Na1aXZXpKjLdFGQihFKzhIXYZTdCR+SzpBGE+K9KzrWy31LM7C9RbmRUniPy2C8cpBtrevstnOxZsPPTUqtCLx0qp1aH4HBefOueiLoeIAisy3gYnsSCp+HnetaP9TJ7YjMXa2qlAVeCyYBpcG8ix9PKE=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(396003)(346002)(366004)(376002)(451199015)(36756003)(8676002)(86362001)(186003)(82960400001)(2616005)(8936002)(41300700001)(44832011)(83380400001)(31696002)(5660300002)(15650500001)(2906002)(6512007)(478600001)(31686004)(26005)(6486002)(316002)(53546011)(66476007)(38100700002)(6506007)(66946007)(66556008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ZzhnVUlDak12YUxqZ0pCUFg0U29Qc3dKSUxKZlBvOU8yL0tVWTl1cjZCNFh6?=
 =?utf-8?B?NUJpL0JQaElNYUg2OTdiMDQ3TU1lQzV1b2daSG9wcEhFb0RVTE4xR2tuQ2Rq?=
 =?utf-8?B?RmJmU1hneXVGZ2laUUtQOEdKZTA0RHN0MEd1WXpHUlpEZGYwaDA5SEFGWUtY?=
 =?utf-8?B?aXFZUHpqQmhLREtDLzY1Mll2VmoxVmlIQkNSVytXN3lLeUhNWXVIOWJER0hM?=
 =?utf-8?B?OWUyMVNOZFkwMGtWM0Z3L0x6SG1kS3pCaEhOZzZhNFRVMXFlUThjS2ozT2N1?=
 =?utf-8?B?WklKYmhvRFlsa2JmbGJwN3J2LzNmekxMNnF1dkkybVNMRFp5T0s5WUZDeUxF?=
 =?utf-8?B?QkV1TUxKdzA1ZVU5QkhuZU9DSnJ0WWtSY21lMlU1bGxRNmNjcDJLdlduVk80?=
 =?utf-8?B?ZTVTb3JLb3ZuTzQ2cU0xZHNoQkxPS0xZUkY4Tm90RFMrM096azZiVGdaYTJi?=
 =?utf-8?B?VkdWVkh3aEFUZVduV3hydnJxR1IwQjFWR1pYcURMWE90WXFLSzNMOHBUaFVh?=
 =?utf-8?B?d1A1MTQzOFJFUDMybVZwczdZNXYyYmZBYWN3UEdwaWpJWUdkSVE0MXp1Tm5v?=
 =?utf-8?B?aUNHWFZnNkpCdEllQkc5V29mSTdsQkZLOG03ZDdjZzdYaGl4NElPOFp4amF1?=
 =?utf-8?B?L1BERDZ3aGVST0pEWFBOOUFLQ2NaOWUveW5ZMTFNc2J4UWZXQndUdUhobFBx?=
 =?utf-8?B?VWN4aTRtRlhqcS9NSnBvWHczajdCV3AzYkFjcVlYYzllSTZyakZ0VVNUOWJI?=
 =?utf-8?B?c2N0d25IdXZVMHJ2VGhMQytxNkZoNUU3UEtUclkxb1A5eTlQWG5xK09GRitY?=
 =?utf-8?B?SkgzYnNJc0hQU0kydHNMaXVhWW0wYVVLTDNwdzliVnRWMllLU3FMRUlud255?=
 =?utf-8?B?OWozYzhoblhjeFFpdmxVVGxza3MzRjhkbHNEMWowSnI3ZzkrY0E3QTZkRyt5?=
 =?utf-8?B?Rm1rRzhlck9ORStGQjVyR2tOamNNLy9zZ1hTSTlYUmZ2dHRWdWdmYWRieFVD?=
 =?utf-8?B?d3dJTWVuSDJqbE5VaUNoWnpmc2pDVWFUUDdtU0c4aUx1WDkyd2ZwT3NZamN6?=
 =?utf-8?B?M2hNdXZ4RWViUFE3NXN4WmhpTStpdC9EU2hvbks3N29vUjZOWHJiVEc1eFVk?=
 =?utf-8?B?NEFFTUVNaWRTbWRRTVZ3eVRWVm05Tlg5UkE5MUlXY2IxakdQcVRHU2dBSG1Z?=
 =?utf-8?B?bHhzeDJPOXlOOHZYTnE3VFVxVldYcjF1ZnhIYzducWowV0VERTBNRzh3aXFI?=
 =?utf-8?B?WDlzdytpQ0FPOThSbGhOZ2djcDNnUXBPQXM2Vm5KUFlGeUNub3k4aHNjOWEz?=
 =?utf-8?B?ZTdxSFVHU0xNUEFMQmRhVGVVcFo2NDJ2TnBlb2VVSGlOc3QvWmR0N21GQW45?=
 =?utf-8?B?K3VhMHhGZ3M4UUZBN2VsaFJDSjdkVEd2M2VBSVIxMmRQSlo0RHdObkx3SUtn?=
 =?utf-8?B?NVpHM0EyUmxSc3BQaUhzZ3JQVWFrZ1dqY01VUER0c3crSGlDZ1ByNGxIdFVh?=
 =?utf-8?B?MjF5UnlLN3NUb0ZFVGpTNmxDSnl4WDRkUUE2NXZZQTdXOVluN2JKMFJtTFk3?=
 =?utf-8?B?R2NTSUUwQkRDaDkvWlM2S0E0WXNzVmlYWWlvMnNXTWlCcGF1dXY1K1loN0x4?=
 =?utf-8?B?Ylh0YmpzRk9SWWE3MmltOHNZMkV5Tzk3b1Nab3NXRnNpZzFDS2dDRzZXa25Q?=
 =?utf-8?B?U3l2aEc5eEZ1VU1tZHJNZnd2RWpQTUpiQ3hqT0xXV1dPajZFZlNkRXRCVS96?=
 =?utf-8?B?elF5eHY2WkpnSTBTSjI2RzdpZm1HT04wT0pFZXR5TTd0elNRRHNGMjBEbGxO?=
 =?utf-8?B?cEVhdUpWZWo2NXEvRS95OXRpeGxheDBRSm9Ua2lPdzRzNU1NM0p6UmxIc0RL?=
 =?utf-8?B?QmptaDRYY290dGIweWhwWXMzeEVSNzRmbE5wekFxTHBKanVoUkVKY2dINEo4?=
 =?utf-8?B?UDRLY0RDUGNKckw3a1RIemlaalNPV3k1QnFyOGtOMkVLTklqYy9wM1RobUlw?=
 =?utf-8?B?Wmw2UEMrYVJpT1NkQm5VZVJKQzNlTVVMZFh1eTdXVmI1WmNiWEJ2KzJHTnN4?=
 =?utf-8?B?ZlMxSHd1alFCbEtZbzRxMFJoSVRTaGZxRDMwcjY3eEdOa3JCTm5pdkROWTVZ?=
 =?utf-8?B?alJCaGlkeVRrZExrLzVwYlNwL2xyazZGeTM2Rm00MXpqcUY3blphT2w1anlL?=
 =?utf-8?B?RXc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cb74281-f55f-4c87-c872-08dac321e9f8
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2022 13:46:05.4328
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ztHkVj71UWZGpw9IwnS2W2EPZlVnA4JI5ybSa1IKDRul8Bu/jDOGUFQa+V8tiLwLOUmxZMZpW6SDloFxUX4oxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3894
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 10 Nov 2022 13:46:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10004

On 10.11.22 10:20, Srinuvasan A wrote:
> From: Srinuvasan A <srinuvasan_a@mentor.com>
> 
> Update cip-kernels to 4.19.264-cip84, 5.10.153-cip19 and 5.10.153-cip19-rt8.
> 
> Signed-off-by: Srinuvasan A <srinuvasan_a@mentor.com>
> ---
>  ...10.145-cip17-rt7.bb => linux-cip-rt_5.10.153-cip19-rt8.bb} | 4 ++--
>  ...inux-cip_4.19.259-cip82.bb => linux-cip_4.19.264-cip84.bb} | 2 +-
>  ...inux-cip_5.10.145-cip17.bb => linux-cip_5.10.153-cip19.bb} | 2 +-
>  3 files changed, 4 insertions(+), 4 deletions(-)
>  rename recipes-kernel/linux/{linux-cip-rt_5.10.145-cip17-rt7.bb => linux-cip-rt_5.10.153-cip19-rt8.bb} (60%)
>  rename recipes-kernel/linux/{linux-cip_4.19.259-cip82.bb => linux-cip_4.19.264-cip84.bb} (72%)
>  rename recipes-kernel/linux/{linux-cip_5.10.145-cip17.bb => linux-cip_5.10.153-cip19.bb} (72%)
> 
> diff --git a/recipes-kernel/linux/linux-cip-rt_5.10.145-cip17-rt7.bb b/recipes-kernel/linux/linux-cip-rt_5.10.153-cip19-rt8.bb
> similarity index 60%
> rename from recipes-kernel/linux/linux-cip-rt_5.10.145-cip17-rt7.bb
> rename to recipes-kernel/linux/linux-cip-rt_5.10.153-cip19-rt8.bb
> index 0cb2a1d..bee0661 100644
> --- a/recipes-kernel/linux/linux-cip-rt_5.10.145-cip17-rt7.bb
> +++ b/recipes-kernel/linux/linux-cip-rt_5.10.153-cip19-rt8.bb
> @@ -1,7 +1,7 @@
>  #
>  # CIP Core, generic profile
>  #
> -# Copyright (c) Siemens AG, 2021
> +# Copyright (c) Siemens AG, 2021-2022
>  #
>  # Authors:
>  #  Jan Kiszka <jan.kiszka@siemens.com>
> @@ -13,4 +13,4 @@ require linux-cip-rt-common.inc
>  
>  KERNEL_DEFCONFIG_VERSION ?= "5.10.y-cip"
>  
> -SRC_URI[sha256sum] = "a5598f7f673b3ef819d6ed24f08d539eecb6febd11673a1d4752a1c05d4ee289"
> +SRC_URI[sha256sum] = "075a95f357008133f999a037e0827f0d55fd1264b421b45548d9ab1be30df726"
> diff --git a/recipes-kernel/linux/linux-cip_4.19.259-cip82.bb b/recipes-kernel/linux/linux-cip_4.19.264-cip84.bb
> similarity index 72%
> rename from recipes-kernel/linux/linux-cip_4.19.259-cip82.bb
> rename to recipes-kernel/linux/linux-cip_4.19.264-cip84.bb
> index d728e2b..860fa84 100644
> --- a/recipes-kernel/linux/linux-cip_4.19.259-cip82.bb
> +++ b/recipes-kernel/linux/linux-cip_4.19.264-cip84.bb
> @@ -13,4 +13,4 @@ require linux-cip-common.inc
>  
>  KERNEL_DEFCONFIG_VERSION ?= "4.19.y-cip"
>  
> -SRC_URI[sha256sum] = "b29e7d90959b29c67a0afa4432937fcc51138b519d33f24ff2ce976fbd958ffd"
> +SRC_URI[sha256sum] = "2176f15e9126499e9336fdd8ac1b560d41ca2d42f96b2492fbce7e8ccf7ba31f"
> diff --git a/recipes-kernel/linux/linux-cip_5.10.145-cip17.bb b/recipes-kernel/linux/linux-cip_5.10.153-cip19.bb
> similarity index 72%
> rename from recipes-kernel/linux/linux-cip_5.10.145-cip17.bb
> rename to recipes-kernel/linux/linux-cip_5.10.153-cip19.bb
> index b4bf6b7..317dfb6 100644
> --- a/recipes-kernel/linux/linux-cip_5.10.145-cip17.bb
> +++ b/recipes-kernel/linux/linux-cip_5.10.153-cip19.bb
> @@ -13,4 +13,4 @@ require linux-cip-common.inc
>  
>  KERNEL_DEFCONFIG_VERSION ?= "5.10.y-cip"
>  
> -SRC_URI[sha256sum] = "4594c147bdc493c7c286688542bbe65e550fb7bd58e0649ec587a2fe893ec0ee"
> +SRC_URI[sha256sum] = "95bd235f131a1ab37a58dff85d4498bcc93bb189b04723923febd52d8566687b"

Hehe, I had written the exact same patch today but you were faster in
posting - taking yours.

Thanks,
Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


