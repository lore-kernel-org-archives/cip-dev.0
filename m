Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E9C0CD68F9
	for <webhook@archiver.kernel.org>; Tue, 10 Oct 2023 07:53:36 +0000 (UTC)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (EUR03-AM7-obe.outbound.protection.outlook.com [40.107.105.47])
 by mx.groups.io with SMTP id smtpd.web11.85655.1696924414914648857
 for <cip-dev@lists.cip-project.org>;
 Tue, 10 Oct 2023 00:53:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=X08W0c46;
 spf=pass (domain: siemens.com, ip: 40.107.105.47, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c7T98Hrh4JlrOpUDoBADBn5SkYSjaj84f7SWeaUq5bFi2kcNxwoL+qLOPho3hVpQB0x41NzIl/d4Z01x8tK2CY5zc5ke2ZlH/TmVl6mtod7xPyAirylFmn5iFSG+LcBGC/++ejNgqvcozK/TA8v+BPLq8eZi4LSxp+1svIRaPbEgEYnWiIGn8Gf1jwkObgi0pujFrb/PDm/aANpttynVatCmt6a1KMjmkWIWtFIylqc4PdCMZbdVyTEIcbVGspujWThLN6txkM0aK2UeWv3VsEQACrpLHzTomUSSuuubGze0SFSLhpD9hpAgk/13ckjC3Rm31vNoQZNhUaJ4BDrTYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FE6rtAGCZlkeyMnh6mHkyx4P+XiKN6vnpUwwvPMaTlo=;
 b=Mj1FUzzbjePxtwzeZWjO5/lVRG6+avJkHqNR+zpWoU/cEUetNNbKBNhyIih6j3VuWu1dYhzpzuAVZyN28Ixbur2db1LhGh42LNYTTRuZuT5B2N7AUBTE0qv85eazYxbmL2kORd/reJVZspWvbwu/jhbxPBBb0sIZ+kzNfDNncjdgzmLBQNqD5CQNEkqjqDav6HyJtyq+2DYCvcde77NYKpyEAeKoQPEM4ORYPXPnrQBFFGmTz2wlUCmi637rtskZLL0HpS1cfI0MUv0tCXLnw9bm+e8AuY0E9q+Wt6qj8UwZfldvSHXAf55K4wlIt/mg/8z18wBaBFBc8eTAnylqRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FE6rtAGCZlkeyMnh6mHkyx4P+XiKN6vnpUwwvPMaTlo=;
 b=X08W0c46tdEilSUzIuSQmxYCoutZSzCIFZcY+M5vR7JvUJ07BqrHMk1Y8x5/35jKzzYukvxRqVWcloRoc3td407YiEgyLVGHGjulGjWYEpNvY/SIYTD0ehZIQqKHmVUcIqbWoGmjKzuJboXHS89Rp3qqW5NxI6WXjoO6nAmJ7k5Q/j9xHGf7vZJnon0YaJM9eDKTNtENpjSz+pwdmAR0S/wAJv1SKvrKqo0tN1GvfL3H4Pzdq4uESvqKqPuPKTc0asbttmpHdklA5trVC0O1gg6eWZiBnPNjHQwg2/p9NXgQL8RfmVSalbHZufItxEfhG9Z+8mz1Z3/k3h2jRq0hUw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAVPR10MB6839.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:323::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.41; Tue, 10 Oct
 2023 07:53:32 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2a90:96cb:b3f:6e5]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2a90:96cb:b3f:6e5%2]) with mapi id 15.20.6863.032; Tue, 10 Oct 2023
 07:53:30 +0000
Message-ID: <ba24174a-fdcd-4738-816e-78e0ad61d999@siemens.com>
Date: Tue, 10 Oct 2023 09:53:21 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] simatic-ipc227e: conf: Add WKS_FILE as
 x86_64-generic.wks
Content-Language: en-US
To: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Cc: cip-dev@lists.cip-project.org
References: <20231010075014.3761016-1-nobuhiro1.iwamatsu@toshiba.co.jp>
 <20231010075014.3761016-2-nobuhiro1.iwamatsu@toshiba.co.jp>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20231010075014.3761016-2-nobuhiro1.iwamatsu@toshiba.co.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR18CA0014.namprd18.prod.outlook.com
 (2603:10b6:610:4f::24) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAVPR10MB6839:EE_
X-MS-Office365-Filtering-Correlation-Id: a33f35c8-ce1a-4a84-c313-08dbc965febd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	h9q4aJxSsKHa5Dm/toXOznoeAbR67G51rsUoPpyn2ivPhL1jvAnrIke6jrYwEjd73K5/9oYBVTKTD0hWMkbcCQJoUSWGj9ePQaZU3gjLASvslSYV285FL88di689YSoGRtku7/kPqSLOAONszile4loHvH7Ob7md51lXgs5zIflp4zW4xH+Pw87iE/CwlSuoKh9uVsdGrZ4Jvh825qeWr+2HmlWY+4cM0i4DMqDwKgqIVghQQh8BvaKw98Gc3SYcJW9R6H1WWeqlSHH29b4C2IRlJBGC4KKbhwDVy6nXvY02V+WS7t6sBV0bCqSAfsdnC/weYgju6oBF7CIKI2hm9Abz/Nds2UaUg8EDK8mQGQWCUjW+qoXWIuBdkuCtXW81UQEmjuwUEvxhBmEKKsvG+P+YoeGWH1FU0IPEJ7juUTGmidZD/Cfw/q/V1jM+pFh4u7wHLRwW9T/019lTbJM7H+ET1v1p0l+r8sp6H9JNEktxdoYSQklgDjiCWOoWGw8VMsdcD4lLxcC7paGRW9M9Nkl83pZmfyy82iMINyQjQvU6Je8NQuwFKAo3MYClB+w+tvkD75z/Ix8itBti4Sj6H85MutUIn3Q+JtZQLeCYq7zLCMdjEWLe6dLGHib6egh2N6jpEItAwVxBq0bHq1X9u+g3XQdmfM/6EB6DA6iq3sw=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(396003)(346002)(376002)(136003)(230922051799003)(186009)(451199024)(64100799003)(1800799009)(44832011)(2616005)(26005)(66946007)(66556008)(66476007)(6916009)(316002)(5660300002)(8936002)(4326008)(41300700001)(6486002)(6506007)(53546011)(8676002)(6512007)(2906002)(6666004)(82960400001)(478600001)(36756003)(38100700002)(31696002)(86362001)(31686004)(41533002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?bUZpbUt1UFN2eHd3QmVJV1ZTeGFCbm1mMVlWTkVzRTZtdS9qczBBRWlIenRB?=
 =?utf-8?B?cTJzZTBDOVAzQXJUODU0QzJXaS9LVlpRc1ZtSWxGUkpOb2R4cTVad1ZGVHkz?=
 =?utf-8?B?b09QQmtaY2FKQStqcUxmalFwRmdLTDA5MVFwWERYc242cTZkMUxYaHZnc1Fp?=
 =?utf-8?B?Nkc2SjhoNkIwRlQ0Y0xmaUdQd1l0MXhRNW1BUzhVUU42WHA5WnBCTzhtVzg2?=
 =?utf-8?B?SElzazIzdUc5ZTNmdytRK2VyNVpQNHFDdDNTandxVzNUU3ZWVlZyNkZJSXBi?=
 =?utf-8?B?cmZMN1R3QTRTNkp2OFpIT1ErRjdCeFBCQ09MeUs4UXg1WWwxL3Zyc0F6cGJh?=
 =?utf-8?B?QysvR3NuWTBIOG9ITjJ4RWxKc0UxaFNrd0VKZjlqcm16WXpxakhybXZPRnd5?=
 =?utf-8?B?TkRaNnIwWm8yRThaazF1Rk10Z08xaDZHU010M2VpZ2xNald2azFsSWxUelRj?=
 =?utf-8?B?S3NZOHFwRC9yMEtCNE9YU3hsNHh4ZVBSbGx3UzMrZDVnWkZRN1VtNG5lWlZ6?=
 =?utf-8?B?dWJDZkduOE9yZzlTSmhRVXFsUGZxcSsvdnRoMFNRMjJ0T2VYWER6K0FpU2J1?=
 =?utf-8?B?bnRwNlNCSWxJVlpJMWVoL29BUVo1bi9ieWhZTjZ1c251V2J0WTJxdldXM1Rr?=
 =?utf-8?B?K0xiSHJOS1J1WWNCQ2ZNVVY5dnFsOXhOVktMQ1RFSUNxbVpienRtTk9zRlgy?=
 =?utf-8?B?NGlCbzNsRmpjKzUxamxRSXlKeU5FSGxleERGcWxYMCswLzF6VlhTY3k0akV6?=
 =?utf-8?B?ZWlMOWJYbmYxbUEvSWxuM0p1aDhwaU1NUnd4THNYZnp3Wk9KaXRNam1rRFkz?=
 =?utf-8?B?WVNPMjJnajhTZXpac01yZ2tvalIxK0cwL0JPRVEzemh1NTRzN0k0QzNNZlBl?=
 =?utf-8?B?RUNpcjkzRENuZGplRGErb2hCYi9ySEg3S2N5azVBanVYUnVlMGRNR3FvUEhs?=
 =?utf-8?B?Vm9JTXF6U3c0VFgyUWtEY1REdC9CR25hbGMvZURGQmtJQ1VONEJjdk5YYkNj?=
 =?utf-8?B?Q1ZPS0VGeHNWNWNrQnU0KytFVFlLeVJpVXIxMmNudXROalFSS2dLQklqZEs0?=
 =?utf-8?B?T1lGWTRFOWZmTVJWMjlrQjM3NENyVFdQS1BiNklsMGc4SUhlVVNkN1FBcDQy?=
 =?utf-8?B?YVV4Q0RUZzZCNWlYcCtDMElmVThaR2xrY3crZmJzQkJyVmRuTUptZXNNeGJ1?=
 =?utf-8?B?TnVseTNVMklkSnFjdjdkWjEwN1JjN3NGYUtIaDRwUC85YTBFT0RaYVZpKzZQ?=
 =?utf-8?B?bDQvNDhZNzVVNTQ1dmoyYjU3SThjVElMZjEvS2pOTWFGRDJCbWlQc1g1WG0v?=
 =?utf-8?B?cjFvRlNCU0F1UkdYVGYwT2pLUzJYMkRPVFd3V2p2RWRISXlVdFp0aVFJY0Jy?=
 =?utf-8?B?ZERLdTVYdXNTR1RkWkVvLzJoRnBLeGt5SFhISGxhbHRHSTlTL1ZTR2hZdEdM?=
 =?utf-8?B?azNGWFN3UHplYnh4bC8rYU96cndQd0w5b25PdjRKTUMyK3NkSFhRaFZOdk1z?=
 =?utf-8?B?VWE4K1hYLzdWNURMalpxaWljS2doMThoZFM4WnZyN1llVEcvbGUzVHc0WkQ0?=
 =?utf-8?B?OEk2TjNLdThJS3RFZ3hOT0NWMk1qQnZkTTd3UmlDVHZGSFRGNzRUYnRXK0dO?=
 =?utf-8?B?S0N2bjJrbmw4MnhzbWdYMVBNbGwrQ1FYekhqQ3o1bDZ5dXdEOUtYSG1NRmFz?=
 =?utf-8?B?Tk9mKzExNkpwRWJMWW84TFBxK2RZQUl6UWU1SWxTcEZPMHFmdFE3bkc3ME9G?=
 =?utf-8?B?emU4QkRWNVhQRThzdlFHeFdldVM1ZC9nSUI2ZzIrWW12WjV2UVR3QnFnT0FQ?=
 =?utf-8?B?YUthOHpMZHpQaHlKVkNKU3NwVWFuRHpjZnoyMXhwS3kzYVk4UzBnZWpCTGFo?=
 =?utf-8?B?Z0l2R3JtdHJGdmQrVzVaeUZkMkt1SldmMExzcUZVV3g3c2lRdXg0OCsvdkU3?=
 =?utf-8?B?eDl6SW92L2dLQjFwV0VRaU5qMFNiVm9FdVYyT2xtdXY0ZXVYNUV5aktsRDVV?=
 =?utf-8?B?NlZHWWVldUVZL054ZjFaZVJnWEVDR3JXMmZqTVJWcENmcHlMdWptMHpUQkt0?=
 =?utf-8?B?TWdiMHR2VmtJSTdpWkhiS0diYmFCT1pKMnowRk50MW9BbnlEVHk1dDNtMUVp?=
 =?utf-8?B?bm5uSDlwenpmUmxDK1djeWxXNTk3eVduMkZVV1Z4VDQ2YnVUVUdkYWIweHpM?=
 =?utf-8?B?Znc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a33f35c8-ce1a-4a84-c313-08dbc965febd
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 07:53:30.7696
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qB4XRqBCZuyusqBx1UAi19vPRibQY4yZCXX6NIIZO5xzfmQirShtfFOD7R3i4l/s3YN38JvkNiSp+AzTDH34RA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB6839
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 10 Oct 2023 07:53:36 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13341

On 10.10.23 09:50, Nobuhiro Iwamatsu wrote:
> wic/simatic-ipc227e.wks has been changed to wic/x86_64-generic.wks. This
> is set in the WKS_FILE variable.
> This file format is different from conf/distro/cip-core-common.inc, so we need
> to set WKS_FILE as x86_64-generic.wks in simatic-ipc227e.conf.
> Add WKS_FILE to simatic-ipc227e.conf.
> 
> Signed-off-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
> ---
>  conf/machine/simatic-ipc227e.conf | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/conf/machine/simatic-ipc227e.conf b/conf/machine/simatic-ipc227e.conf
> index a624fcd..8bb3e80 100644
> --- a/conf/machine/simatic-ipc227e.conf
> +++ b/conf/machine/simatic-ipc227e.conf
> @@ -9,6 +9,7 @@
>  DISTRO_ARCH = "amd64"
>  
>  IMAGE_FSTYPES ?= "wic"
> +WKS_FILE ?= "x86_64-generic.wks"
>  IMAGER_INSTALL += "${GRUB_BOOTLOADER_INSTALL}"
>  USE_CIP_KERNEL_CONFIG = "1"
>  KERNEL_DEFCONFIG = "cip-kernel-config/${KERNEL_DEFCONFIG_VERSION}/x86/siemens_ipc227e_defconfig"

Patch 1 and 2 need to be merged, or we have a build breakage after patch
1, don't we?

Jan

-- 
Siemens AG, Technology
Linux Expert Center


