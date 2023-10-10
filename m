Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20D08CD80D5
	for <webhook@archiver.kernel.org>; Tue, 10 Oct 2023 13:41:59 +0000 (UTC)
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (EUR01-VE1-obe.outbound.protection.outlook.com [40.107.14.41])
 by mx.groups.io with SMTP id smtpd.web10.91848.1696945311556969137
 for <cip-dev@lists.cip-project.org>;
 Tue, 10 Oct 2023 06:41:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=y+fuYWA9;
 spf=pass (domain: siemens.com, ip: 40.107.14.41, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RQ5pEzJwkj6aEJ5JFwKDkjNThO1rzzJYF5a0tIIyopgEDPpa8HGuBXjHn8fJHY5TYAtQsvePJWHrUp2g9PTftVA9xWkcAmYIYU3sMxTK7lR7aUcMs1/XSVPP+3bTMd04AMGb4D1qjXewReFRFIxrgC9v2bE5OazzqOslf5F7ewwbzyottmcT3Bzx/PQs+C9IN48F8f3O4s8UuWV+/Tm935lLhPdSqbWhlGunhhA70FdaGTwOAUwMnlxi84u/T9+Xr37yet2msebJSjuFQiy2/QHVKBL3OuaMWVfFNpBG4PI5bIsneHZJ0m/8WtXogo3zN7mGyhj/t6dgY3eNNKrzvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9j+Hbae8PHfOnDA/n3emidRxXLX+dNbN/yooLp2j3Pw=;
 b=b4QK+CS1wrNx47VNEpzC/OAm3EvMQKgBDAXzQIoGcMeRuiad5HANlizHzBA4K01z+mqijh1twrjZmtMSY+YQRKP60T4CC4VSwAsvdlFARyVCbsAGth+wYhabutLxdq/2QLhqTJv0Tv2De0opzt/Y7Xax8A66FrmoQTGtFMFZre0FpWGFFwy8hlFLBIwQgWJuXaHiRQ53V6bJarFsIicz9U9l2z5jEHxl+xNgZna4OhV7gjC0PyKoi2CAbYEUwDXOTRvylryKPKGitH4IYTxGQxUgT1bYFfLUrpAkhLrGdKt9IeBT+VQ2ROT2hbVWx4eSswmKmTxAoBuhVZDTHxvZCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9j+Hbae8PHfOnDA/n3emidRxXLX+dNbN/yooLp2j3Pw=;
 b=y+fuYWA9DAI/ybB2x3rABqjYWvZLHX8SQ+DyHVmaxixCCcmnJVJa4kazvevqJm8CLb0xfbtD9wPpyTxs4I2bxVvsQiWofi8EK2daJeCj26weKdFzbD1zJ6Q35p/9WehqdKWS1cIYouvL+AXyHNPmU94hd5EhPoFTL+Mj9ZvP+clixpz4dqrdbO0GvoETFbj15mrsZR2h5Cs59CdG6ij9guIJE4xuRw33U9CYTIDJ34BvGLSf/GNLjQz+8XAS3dnYDxoZMcvhpQlZ17VxlDscsxt2yoH6wboZRTTmzq3ley8hZxWE03oo5hRPO1nS5poB5wO0PkTCWuBfqM52gJpakw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB4PR10MB7062.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3f2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.36; Tue, 10 Oct
 2023 13:41:47 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2a90:96cb:b3f:6e5]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2a90:96cb:b3f:6e5%2]) with mapi id 15.20.6863.032; Tue, 10 Oct 2023
 13:41:47 +0000
Message-ID: <25e789f4-ee0c-43c4-be21-b952c124d5be@siemens.com>
Date: Tue, 10 Oct 2023 15:41:42 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH v2] wic: Rename wic/simatic-ipc227e.wks to
 wic/x86_64-generic.wks
Content-Language: en-US
To: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Cc: cip-dev@lists.cip-project.org
References: <20231010080305.3762206-1-nobuhiro1.iwamatsu@toshiba.co.jp>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20231010080305.3762206-1-nobuhiro1.iwamatsu@toshiba.co.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0067.namprd03.prod.outlook.com
 (2603:10b6:610:cc::12) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB4PR10MB7062:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ccc8776-b94a-4706-2a6d-08dbc996a62d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	kZzmRdCGEoXYGInf+7lECEkiOrw2pYxA8Mc0OOfF+BBy8yYNZuh4EJCJ4TigF1m8j9W6oGzsHgv6bGMp006/5HibAORKf9oci5u8ixeC/v7CNIhNxgDAGPBzzRWcF/sVfYHcGq/KolAcUTJrUL2ciPYZFZyxkUkNbeJ7KYWCw4+DjQp/xYSd6Yz8Muo5sVQtI/+3Iogd9LTewWB1FuILcoHvNBbD/oezjRSPGYLVnIAmevukD4S0sr4Gog4gehkdOLTcN8MM/VnfdS9BfU4ei3ldXruIGuOXHPCxGwFTK3vNScR7S623Mw8yP1sip0VFEV0Zb2dpECV/Tk6tpXaUXDVTxVByKRdWGDog/2mG7V+OSQC6nfe2GfkzBZFCN5HP17l39SdzYKavz9AiPQcxVi2GAVEZNEYZjzYAmHNCvpf6JCovv7fRwqUy+VWZJUuasggSHd/1Q9x7TEVO6hqkqrna5Tcb87hLhKRnUdZKfZcixAKk0R1946T8DPipJwhx6CYB7pRGIF3RPjJ4y1OoQA4eUIchmkxiOg3ZTgq+GZRXIawvm/a4xSx1HZasXRmeFD7Y1YqoAfzjwWNvnp4uef34tPqwLBxlp9tooo56hrYAShNbtMZlc9H+uIudIE6sxjo91qWRpHGJdXVevDKTi/85bt9rgTV5JtMpjossnTY=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(39860400002)(376002)(366004)(396003)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(6512007)(316002)(6506007)(2616005)(26005)(6916009)(66946007)(66476007)(66556008)(41300700001)(4326008)(44832011)(6666004)(8936002)(2906002)(478600001)(6486002)(5660300002)(53546011)(36756003)(38100700002)(82960400001)(31696002)(86362001)(31686004)(8676002)(41533002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Z25ZN3lsZCt3eHphc3VTdlFmODA1cXVGNm5WMkUxTml1QnZKelVKRHZaUFBl?=
 =?utf-8?B?Z0dreWlONFlkbkxjK0Z3OGhsbHF0Q0t2Ry9WcW9hR09EMDJScHFiYk9DK0xH?=
 =?utf-8?B?ci9rU0QyZzJKVkdRYXExUG0zWmZRVWlhdU4zK2xaTkZLcVVZTUdNcmpMTlNi?=
 =?utf-8?B?MXZFUzNtNWJuZEdWMFpGWHg5dFd6ODMwRDFvV1FBeldyUDNCVTZUUktkbVhU?=
 =?utf-8?B?dE02NllsRjAwbm5PNkgwYUxKb2Y1S3ZxaE8weTc0RlFoeGVmcVhod01Id1lG?=
 =?utf-8?B?NXlIVkFUd1luVERxYmY0RE9HOGFQTHkrUk5vMHZCNUdXUDgrenVELzJKZ1lE?=
 =?utf-8?B?Qis0eUVUUnVYdWZZSSt5SW9RSWdlTFZ3czYvOGhkdjFubmJ1cXVZYWEzd0N5?=
 =?utf-8?B?elRCSWI1VFBldVFXeCtPbFFROEhoTjVEdEFZNmhpQzlZamZ6NldCRUdldzZB?=
 =?utf-8?B?Tklqc2ViVWZWRlYwSjlyMVN6elJrV2pNRFFiTFYyRXlzUThDYjdXU2g1cFJo?=
 =?utf-8?B?UDlmOVJuZjc1cTlUTlFDeEs0SEo0aThRanZHSW1WNld0bS8yL290RVNaaUxO?=
 =?utf-8?B?UEltZkpDNlpvWUZjbHJnbEVkNUpiMHBoUVBVRWlHMVo3YktUdHNRUWsvS3dI?=
 =?utf-8?B?dXdQK28wMzk4eExqaEVBb1UrTjRPVXJYQ3FaUU9UZ1dkUVg4enpNQm5SZ3pD?=
 =?utf-8?B?S2pramlUNWVIWTFSMEs3d0lBWjU2WHFnS1BNaGs0TVFONktXdE15WXd0ZTNH?=
 =?utf-8?B?MzUxQjhBWTJDNWNMK2pYV0h3V25meWdwRjU5djZXTzdXcjZsdlFVVTF0RTlP?=
 =?utf-8?B?Ti9PV09oeExGV2Y4a0pyL085Q3VZZnE0M3hBYTQzazNHZ0U3bTdRMnNiek5S?=
 =?utf-8?B?TVVIRG1UaUVKWU5FU2p2bTNpM1VnanRTUWhYS0VGcTVFYVpUL1ZmQnlXYVJM?=
 =?utf-8?B?anh5LzFOSURXMjNWTHB5VGpNU3FjOHlEQXdyMDY4aytwdzA0TC9QNUFwM3hE?=
 =?utf-8?B?VmZqNS8wK1pHZi9PTVdvdU5ZbTZ1eS9FbTVvaDJCcFZIUzdRZnAwZEkyT2xo?=
 =?utf-8?B?WHBqMnZGd0Y4ZWdpRzZzRVdoNkZWbmF6Q1FkTVBsOE43ZXJrcWlYR3VWbWxn?=
 =?utf-8?B?UWFoMDdseWR2NFpkOVJabHUxeTZ3aDA3SEhVajVFd2NaVmZIQzRkZFdoMVo0?=
 =?utf-8?B?UkNTRmZQWC9SbGxQdXFVeFFKc01BNDFLU2NwWUp4aEh3elE4SStzdFUvSU9y?=
 =?utf-8?B?M24rWEJLeTlpRDNhMUxpRUk5N2d1cUxRZE5BVTNtNi9zOWhzZERyemNmbzVL?=
 =?utf-8?B?VWpUSVVNbEdvUVZ6bUN2VXlZVEwxS3ZySUJ5Tkp5UlhDa0dXN3NzK3FNMXhT?=
 =?utf-8?B?VThjam9GclgzcndFVStURjU2bnM4dmxhaFFSeitaTHlTVEZKdmQyZjBVZkN1?=
 =?utf-8?B?N3orbWFDZ0ZoV0VqejBiVXJBSFVabkp4ajgvZis5V3R1UjE0LzI3dlNSZk5F?=
 =?utf-8?B?SHFrMW5tMXRWYXdKa3FyckNZVTBLRlp4L0pWTXNSUERoS2M3OHlLWnBsaXNt?=
 =?utf-8?B?aUVRbXlFUVFKV2tvUlpuWVFqRUJlZXNiNmo3NHRnZGlEdHVYeU84RE8wclpK?=
 =?utf-8?B?N2QwcHh2OTNyU21IeDJ6bWpJT1RycXlzNW12dXhGUkM0VWZQL052RTVrejl2?=
 =?utf-8?B?TjZVYWtZK0NyV2hLcUs1TTVrZTRadlhxQit6WXloRy9YZ0IwamI5b3dKdXA2?=
 =?utf-8?B?K3F1WWFoSHVGZ2FzbE9nbm5RVjh0NUp6TmJVeGt2SndDYm5jYTNoMTIvb3hD?=
 =?utf-8?B?SU93bk1URE50emNwS2JwWlNuakR4a3ZERzk4RlJPLzRRU2U5LzBIaGxjUHpP?=
 =?utf-8?B?UDZsdThmTFdZc0duU3NlMFpLOGg2Y3Jicm9kZFdsQjdpdll4VHh2V1FVYlJh?=
 =?utf-8?B?ZU5meVhwMEFJKzR3eTFXdHBxd1N1eDdyWS95bkpoVzJNWjQwc1E1bWc5cUlv?=
 =?utf-8?B?T1N4aVdjaW1ZdUl1Y1R4bGt0cERjSmxpSkVTR0Y0MUswYjN6blowWlRwNUhT?=
 =?utf-8?B?UFQ2cFNNZjh2YTJUL1JhOVN3RnhaQkxFb1c4am5UdmRwalRlNDdVYVV0a2Ft?=
 =?utf-8?B?OW00VjdLVGJjYkR4TFQzRlZaZUtYSWlHY0E1MHhNN3dJOGVPUmsrSVJjMUVI?=
 =?utf-8?B?RGc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ccc8776-b94a-4706-2a6d-08dbc996a62d
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 13:41:47.5992
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ah1A6nlVWNN1axWVoVvuoQdHLAIHAtplNIH4S6ak33ZYgQnwBV/N9ggL0G6UvW+mTQySmcWIFTBwPrSiW8ATwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR10MB7062
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 10 Oct 2023 13:41:59 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13373

On 10.10.23 10:03, Nobuhiro Iwamatsu wrote:
> Currently wic/simatic-ipc227e.wks has generic settings for x86_64. It is
> also available for other x86_64 reference HWs.
> Therefore, change this to wic/x86_64-generic.wks as the generic file name.
> 
> Signed-off-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
> ---
> v2: Merge patch:'simatic-ipc227e: conf: Add WKS_FILE as x86_64-generic.wks'
> 
> ---
>  conf/machine/simatic-ipc227e.conf               | 1 +
>  wic/{simatic-ipc227e.wks => x86_64-generic.wks} | 0
>  2 files changed, 1 insertion(+)
>  rename wic/{simatic-ipc227e.wks => x86_64-generic.wks} (100%)
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
> diff --git a/wic/simatic-ipc227e.wks b/wic/x86_64-generic.wks
> similarity index 100%
> rename from wic/simatic-ipc227e.wks
> rename to wic/x86_64-generic.wks

Thanks, applied.

Jan

-- 
Siemens AG, Technology
Linux Expert Center


