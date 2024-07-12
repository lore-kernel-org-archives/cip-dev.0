Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BF8EC2BD09
	for <webhook@archiver.kernel.org>; Fri, 12 Jul 2024 07:21:50 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.49])
 by mx.groups.io with SMTP id smtpd.web10.2594.1720768902274035596
 for <cip-dev@lists.cip-project.org>;
 Fri, 12 Jul 2024 00:21:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=Vehx/jNo;
 spf=pass (domain: siemens.com, ip: 40.107.22.49, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v0Cv8TqgdiDbQZwiHyoyfC9XUd1EDf3wztbNKzuesbCmnDDE4mVL43bUzSlq0su3E31fYBWnk3sudFvKk+N5ulEEtLJqpahX0IH+I8mZJkbTY3oKEVDzgg7FObXC1cdthyWS6WCttjFVo9RNVaXp2Qrkc8lxGHNt6Wl155pfmac5EZhYYEeV4Bq9PK28LMIFuiHVX9fLrT9vhtdgpirYXOpdlc2imu199GL8jznuM0BS077MjSRdblqwYHtaZcX+PF/iS6Y2r/sG3PbgmIyB29EECWaj89OGzEPuBEaTlWG7+LxSfiB0uJNHnTsJvkRcohCC9Mdf5kxpG93tu19LWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E02eS84c24oks4DNiBMwCJPYdT6+yIZ6BvOk3dYxcuA=;
 b=bzficD0j+3oFV9CPoANF0X/ie4qzD2Hi0udRlnZZLWoSSduPfHj/Jk0ulPf0dmRhPFrx+f6hgxuwOHlnbpmwZTNF1mpeYTFf0dfDaMcuTVDgVpNOAHYXXR7X3srh++JOzu1DtPTu3gt8chy9j96NtUpbR/dyOZ/AiOk4e85x5zwriqOGsX0Ft3uCQs0XsrheFJIVxnAhmMvDb+odqkZJBHymq6GlWZRCP9MyUqDx9woeT8M3F2O98NRmQkYNaFTMI52xVK6egTK8zffr5DBGRJcOYUDUZeicLLGYU3A4r6c3BOh//7PwtU6cQvc+OMnQw6N/3c4SzH7fb24rY7h2GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E02eS84c24oks4DNiBMwCJPYdT6+yIZ6BvOk3dYxcuA=;
 b=Vehx/jNoSAqtZT+y32XhgQCAJluIKJgbrEQSgZoXV/0j1ZjZSFpi0dISYi/7x7VEo7hdCtN3DjlFxa2OtgvbM3qJ73aBztUsOOKmvYSryEe8scwKzr/xaJP4CjGJdcSjijjTljUNqBkQAOzKNLtHi/apU0OWpGmbhaetM9CJSbmgJTvaDzG/c//Qu8hEQwNflp6rQF2wajNm22uXnMdRAGyCfKkl0cFSBHwExfr8uGb8WNxUSmnCTVjFpQ+5bK/GgGjdrcqEV8m4jfDQeRnohbBTX/jYLxCj8wiaxfLpXxHjZWtIyH+KN7ys30XjiwdbWzmDewJSwv245ne+xQDxbg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:76::15)
 by DU0PR10MB6226.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3ed::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.23; Fri, 12 Jul
 2024 07:21:38 +0000
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286]) by GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286%4]) with mapi id 15.20.7762.020; Fri, 12 Jul 2024
 07:21:38 +0000
Message-ID: <226aa2bb-c090-4eb8-bbb8-9d6991701f21@siemens.com>
Date: Fri, 12 Jul 2024 09:21:36 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH v3 1/2] initramfs-overlay-hook:
 Add INITRAMFS_OVERLAY_MOUNT_OPTION
To: Clara Kowalsky <clara.kowalsky@siemens.com>, cip-dev@lists.cip-project.org
Cc: quirin.gylstorff@siemens.com
References: <20240708124734.591324-1-clara.kowalsky@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20240708124734.591324-1-clara.kowalsky@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0150.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b8::16) To GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:76::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR10MB6186:EE_|DU0PR10MB6226:EE_
X-MS-Office365-Filtering-Correlation-Id: ab8bdb9d-f4b6-47e6-7d2a-08dca24344d0
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?NDdtS0NHU1lxVGVreFhERFZ3ZHFFU1NZU3dRVHUwYzdzcHZmcVQ1TUZvUjgw?=
 =?utf-8?B?SndPcEkxeFZxWHl6bjhCYjRVdnZlc0xzaUxsSkRDRjM4SGw3Vk04cFQzemtE?=
 =?utf-8?B?VVVSNW5wZGh3aGlMMmJROXpzR1oyUnl4MnlNN2VyK0xlTjRxWmM0R3pHak44?=
 =?utf-8?B?VWZrRDNvaS9ZYVo2TlYyVVZia3lzQys0S3lld0JNbWxDUHNaTnV5UDMwYkRn?=
 =?utf-8?B?c2xnVDdxWm9EMURvZngvUlRlSlFYclJFVjNjaTMwdFZFL2RscElyWmJZVU02?=
 =?utf-8?B?bG05K2g4RnVybXNrYmJwNU4rbjFYY0phVGwvNFpYTm8vQlUrcGtQSFhCenJ6?=
 =?utf-8?B?NWxaZGVKUEhOZFA4Yjh0QWdINmxyZ0UxWlZxTG91ZmMrdGozWUFid0pUazZT?=
 =?utf-8?B?UFgzdVhqcFlwd3QxeGc1RVZvUndzVjhhSy81cldxMjFWR3E2cGpIZUxpOUtO?=
 =?utf-8?B?blVhdE1YejBhMEc2YnhxdC9RUUYxSlhoUkNnbHprTHNvaEViWFVVa0FldTdR?=
 =?utf-8?B?TEtreXBrTG9zNnJqWWMvMVY1a21uUUtoVnRBaFlLT3J0OExyM1lBdnFOQjFZ?=
 =?utf-8?B?T2FQajBTbjRFRVZVVkpNcmdrbktpdUI1NGMrdWMrWXNyL2xiamkyamNCamZi?=
 =?utf-8?B?Tk9uVzR5aHlLSjkxSnV6VXBUQlVxRTEyU3hxZkhQeDVuZjdjZ2M4ZC9XYTBm?=
 =?utf-8?B?bGVsajhOR0lpVVRuRVRyS1duUTdQVkZaTkRqTDc2QzlYL2dRYWM2TXdCYTEw?=
 =?utf-8?B?WWl0Smh6N0F5bXFYdmg0ZUJDVWhGdmZhY2lEYUdkZEtJVjNCc1d1V0cyM3hY?=
 =?utf-8?B?OVRTZVhoVzlLUWRSbU5YK0EwZjRBWm1SeTVmeUYvNzVyWFdmblBZMS9MUjhQ?=
 =?utf-8?B?VWY1VUFKQk1DOGp5Zm1FenlSN2IwaC9XRkpaN3RYRFAzeW51V1JoSk9lZHFQ?=
 =?utf-8?B?bjNITzMvaXFQclJrZzNCcU9FZ1lhcWZwK3BoVVRjRUtvV3ArOG80WUd3eWpC?=
 =?utf-8?B?NEVuVWdBSW1MbWUxU1h1SFZyUldmaHluNDg2Q3dwSFJQMjcyYk5FMHpJSlhX?=
 =?utf-8?B?Vm8yOE9HdGFqc05oYmpiUDgzdVJQUXJXREwzMGVDdis5SWU4K0YyZDlpR0Zu?=
 =?utf-8?B?UjhYZDhQMW95Nm0xcTMwVHFiNEpPeGdSQTkvbDdicHVKK3JQT0gvVGIwU3pt?=
 =?utf-8?B?UXlzVEl6bG44ZWQ2L3phTDdiZUJYdXdnZmE2a1J3Mko1TUNTbEF1MlV3Nktz?=
 =?utf-8?B?V2NvRlhWdEdUeElCV2M0ZDZ4aVdzcllZV1J2QXdBeWhSZGVPcWpFYW03cE1p?=
 =?utf-8?B?VENHWmNGaVdLRUl1MGdibkFyT1FTd01lcVRnZXd5UFBXOFFwODF3RXNmUm1H?=
 =?utf-8?B?SDVzM0drT292R3JVSS9PUzFzaFNSZnVOdkczZUVwYU9sN0JwSTZpN3RuN01v?=
 =?utf-8?B?enl4MlFjQU9lQVBDdlVTdm10MHhYcVg1RWlra3FHTW42VU9HQ1FXSi9uM1Fn?=
 =?utf-8?B?TnZPZmtsVnZMVDZkNGQ2YnIwY0RBRnR0ZVI1QUdGWUxzZ2d3KzB1aldXcUxD?=
 =?utf-8?B?Q3dNWk5ZR0tDRG1LL3Baend0KzB4RDdNN0JYUVp1aU5LSjd1TVlwTUtRVzZS?=
 =?utf-8?B?UCt1bmM2QWdmVWw4cjdmdzV1d2NEVzV2aXNETW80U3pxcFk1TjR4NHJhY3lW?=
 =?utf-8?B?Q0taSitCZkxlM3hVb3pPM3orTG5lZmNkS0tVTFduQUVNRG4vRjExZkpIL1d4?=
 =?utf-8?B?OG5VdzdJM0dJeUtqUlpYOEpoTTQyY3B2MFVSRnplS2MwSDA4dCtQSEcxUHMr?=
 =?utf-8?B?R2xWZnp5MFR3WXo2SWlwZz09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ZUFsTVU3QXlSMVhEY3JFWHNLeGlTQjMwbUw0N0tMeEhveUFkQzVMUlBPaHd5?=
 =?utf-8?B?NjFFd0F4UlJIT2hWYStzZDRZRlloeE4yeUFCV3liWU1Ba0tHdUZtL2xidGdy?=
 =?utf-8?B?amVRR1JKbXhOS3hyY0UxcDFqaEowNmVQdW41eFNDTFZUSzQ1VWVXeHc2TjNa?=
 =?utf-8?B?YTRNRWQzZ0RVcW9aUjBqeEQwemJwS3lvSjRWTWNkWnNzVWpFQnVTaUxlcmlz?=
 =?utf-8?B?YytPQ09uYmpLWVVXMDF6clM1bWxsT2VjTzBjam9pTWZ5MDc1Znd0azgzaXlu?=
 =?utf-8?B?S3J6SjZLZElvbzd6Q1MwYTJGVGxPbTdYcDNUWHpUMVNycnhGaXM5amQvc1gr?=
 =?utf-8?B?L044RDErK2lWSXByL2dlTXA4TWZVblRiNC92ZWx1RVZYN0NUcFVPcTZKRGpP?=
 =?utf-8?B?SWthQ1dnNy9qdTBmTHY5WlVVY0pzbytMUDZOekNBaTlTYW1yZVV4MU5ERWNw?=
 =?utf-8?B?MlUrdGUzSGUxY1c4cjhrMWNuVVhMdW4xa0tXdGFYbnJ6RTUrS2ZuZWgzT25E?=
 =?utf-8?B?U05UMVVXUHZKV2pFWHgxMHFXNDZNU3BtTkgxSGNnNE5rTEg2bGNrMXU4ZXRP?=
 =?utf-8?B?Ym9RcTNsUGZhRHV0UVNBQWVkM0E5Wi9ha0s1WVAyS09NMjJNNG5rbWVxamJT?=
 =?utf-8?B?MEJjbGxnUEtuTllnTG4ySGwrUmNLOFVWbGdqNmZkTUV4c2ZWVElEUy9mMWVK?=
 =?utf-8?B?bW55eHFZRGtwODkwc1lneTZHbUNJRWlWL1hFUEp3dHZiM2c5UmcyRHBuOTI4?=
 =?utf-8?B?eDhCamNpM1VCODBDMW9oQU9XcjQ2RmVrcStsSE1mTGJHVkR4QmVCWUVQSDJw?=
 =?utf-8?B?L1NIWXhZZTBRcjNzaTdzTGVLVndrMTJqWE1LaUJVWnJKeStxV3F6MzA4TGp2?=
 =?utf-8?B?UGdtZVN6L3A2Y09PRWhML3BxdXc0a212R2hSS3VNM0Q5S1dUa2kvUVFzNmVa?=
 =?utf-8?B?R3lQZ1FENUl6YmVLQlVaMUd0Z2V2anQvVGN1N0N6TXBYODRTOU9OSE01UHJN?=
 =?utf-8?B?UHN1K1pEWmtNQWd1WTFIWmhkMWdlNmh3bnR5UW11VWtwak5YVVo3WWlEUkYy?=
 =?utf-8?B?em10OUx3a2JVOTVFeXN1NUttdkg3bUpRM2ZpOUxISHhIb2x6VnF4OStGQlY1?=
 =?utf-8?B?UlUxMytNTEJNT0pLKzU2RmdHOVhZN2d0MzhlWUVQbEhCd1RKejk2Y3Bmd1F2?=
 =?utf-8?B?NE9OeEE2S1IrOVBDRjRGSmJrcDhHM3BvVzduZDk0WGY1SElVTkVPL0RRVlpy?=
 =?utf-8?B?cDd3a0g0MThkWFhLMlpmMGJQcHdsdVJNY3NkbHdJQkZML2VvYVByNVFpU20y?=
 =?utf-8?B?QWRBZEUzck9sdDZ2MmJZVWEvSXpIZjJtTmJLR1pGeVJiNFNjZ205UHFrd0VP?=
 =?utf-8?B?cmVWS2lnbmh0Y3ZNR0xqMngvRHVNak1NdHk1WTJyV1Zvc2JEcG1oZmZGTFY0?=
 =?utf-8?B?RE80OVFnVHpHamZJcm9oNHdQV29kU3NrRWZSeTdOeWg0a1VyN3NrcU5GdEly?=
 =?utf-8?B?ZDNIVi9iN080VTc1aVpoWUFCWTYyTkI3MmtVTGwvNFVLZWFtMXJNY0FsV0cv?=
 =?utf-8?B?Uy91eTl4WEFValhDWnZsTHZmZVMrY2RkSmNtcm9GcmFSSmI3TWxkWWh4elU1?=
 =?utf-8?B?bGRwNlhncWhZZm1aQWRveUpDdUl2VUJKaFZIYkRHRURNVHQ0V1hvL1NXbjFo?=
 =?utf-8?B?bVU3TitkSDVpU2pVUUF3aTVJVjVSa1FmYkI2a1pMQk9YbFd3eGxNRWs1Mnh6?=
 =?utf-8?B?ejRUd2wzazVBR0JBYmh1WG44c01jbjZleW81dGJuME9CRjRZUGp2dlhsRzBD?=
 =?utf-8?B?djlKRDV3NGVnS1l2cFgwWlNQdE4wZ0liMzczdldiUE50TnFDcHRxcEdpMWRr?=
 =?utf-8?B?aUppWW9VMnhrUlNrbEFGTTd2WUhwUkZ2c3JtclVmOFc3eE00SmtLRlVUYVRZ?=
 =?utf-8?B?N0ZMZG9aWWtYb09XMDdyTzdjb0twSjVvb2NsbStkNnB1NVI2bkdzSWYybklF?=
 =?utf-8?B?UUdJMVFVaXFEZXFZUEt1NFZKR0ZQclNuZGJJSm81STJGVkRUNmhoWUFzZnZ5?=
 =?utf-8?B?M3NyWkp2MVdoUDRoZVNpdnhYZmVlK0pkVkRkRjVtS1ZQLytjN2VPOWtZU3h2?=
 =?utf-8?B?eE1QVWVpSDdMbmhRN0ljWnlJYm1wNmx5d2xaOUdRMkVqZUZ3Nkc5RDc4VWlH?=
 =?utf-8?B?bmc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab8bdb9d-f4b6-47e6-7d2a-08dca24344d0
X-MS-Exchange-CrossTenant-AuthSource: GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2024 07:21:38.2298
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2iolGopjmphrsM87XqWGFCN0jK48iqAILzaiAeEtbZ1E7L+5XzbJqPqoTdvBjM7h+zSPMSYp1wfCR4+FP+ItMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6226
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 12 Jul 2024 07:21:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16453

On 08.07.24 14:47, Clara Kowalsky wrote:
> This allows to set options for the mount of the overlay storage device.
> For security reasons, the mount options nodev, nosuid and noexec are
> set.
> As /var is not intended to support devices, nodev is set to ensure that
> users cannot create a block or character special devices in /var.
> Since /var is only intended for variable files such as logs, nosuid is
> set to ensure that users cannot create setuid files in /var.
> Noexec is set to ensure that users cannot run executable binaries.
> 
> Signed-off-by: Clara Kowalsky <clara.kowalsky@siemens.com>
> ---
>  .../initramfs-overlay-hook/files/overlay.script.tmpl          | 2 ++
>  .../initramfs-overlay-hook/initramfs-overlay-hook_0.1.bb      | 4 +++-
>  2 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/recipes-initramfs/initramfs-overlay-hook/files/overlay.script.tmpl b/recipes-initramfs/initramfs-overlay-hook/files/overlay.script.tmpl
> index 2563dfd..42eb59c 100644
> --- a/recipes-initramfs/initramfs-overlay-hook/files/overlay.script.tmpl
> +++ b/recipes-initramfs/initramfs-overlay-hook/files/overlay.script.tmpl
> @@ -30,12 +30,14 @@ esac
>  ovl_partition_device="${INITRAMFS_OVERLAY_STORAGE_DEVICE}"
>  ovl_storage_path="${INITRAMFS_OVERLAY_STORAGE_PATH}"
>  ovl_lower_dirs="${INITRAMFS_OVERLAY_PATHS}"
> +ovl_mount_option="${INITRAMFS_OVERLAY_MOUNT_OPTION}"
>  
>  root_mount_storage=${rootmnt}${ovl_storage_path}
>  storage_mount_point="$(echo "${ovl_storage_path}" | awk -F/ '{print FS$2}' )"
>  
>  if ! mountpoint -q "${rootmnt}${storage_mount_point}"; then
>  	if ! mount -t $(get_fstype ${ovl_partition_device}) \
> +		 -o ${ovl_mount_option} \
>  		 ${ovl_partition_device} \
>  		 ${rootmnt}${storage_mount_point}; then
>  		panic "Can't mount ${storage_mount_point} partition - overlay will not work!"
> diff --git a/recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0.1.bb b/recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0.1.bb
> index 2694766..955748f 100644
> --- a/recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0.1.bb
> +++ b/recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0.1.bb
> @@ -29,11 +29,13 @@ INITRAMFS_OVERLAY_STORAGE_PATH ??= "/var/local"
>  
>  # override this to switch to UUID or PARTUUID based mounts
>  INITRAMFS_OVERLAY_STORAGE_DEVICE ??= "/dev/disk/by-label/var"
> +INITRAMFS_OVERLAY_MOUNT_OPTION ??= "defaults,nodev,nosuid,noexec"
>  
>  TEMPLATE_FILES = "overlay.script.tmpl"
>  TEMPLATE_VARS += " INITRAMFS_OVERLAY_STORAGE_PATH \
>      INITRAMFS_OVERLAY_PATHS \
> -    INITRAMFS_OVERLAY_STORAGE_DEVICE"
> +    INITRAMFS_OVERLAY_STORAGE_DEVICE \
> +    INITRAMFS_OVERLAY_MOUNT_OPTION"
>  
>  DEBIAN_DEPENDS = "initramfs-tools, awk, coreutils, util-linux"
>  

Thanks, applied.

Jan

-- 
Siemens AG, Technology
Linux Expert Center


