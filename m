Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F254D17124
	for <webhook@archiver.kernel.org>; Mon, 21 Oct 2024 18:53:19 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.51])
 by mx.groups.io with SMTP id smtpd.web11.361.1729536797760708052
 for <cip-dev@lists.cip-project.org>;
 Mon, 21 Oct 2024 11:53:18 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=LHprHE6R;
 spf=pass (domain: siemens.com, ip: 40.107.22.51, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n9kwTMSceJNzHbp1O7P0cXRaD3mSnvvVFcZ+m9vBjyHoKoJ+Yq9kkDquprY61pxBXBzAX3qJq1alEgtIfD+yrITdZT7LS5QQ5WgSSUau0p6mC7W5LtPdE+fIMfhujGkypnACMpoNadWVFaBsOh5pzKL4awfSpakbc9lz5qUnTq9n15T8r0XNxv8g0WzEYzhy5IZQJiqgApoWjyh7uezeK7NnzPUloQlLTt8U6vCQyIQhGSBUucibK4R9GS66VvP+AvT+cza+byeVHd4wy7kxmKgnZ8JekZ7nf03ixRcmL0zqqYO94prsLrFOwJi7FeFnMv0qy4+eTA1ypwyXfdpyBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=usF3kBRl0172fPuYut52Kd3/YYeLPpfYhwTK/HDrGGk=;
 b=yKHR9dvQ7zYxbDAcbFYbOTRsz0POWhH4ckFn0hb7at87M1wldtz50QtMMQC1pJI1geEaGLaIILVgBCbv+01AL9mYsVQ07Zs2wDaapbJNp6IY/6IzqUEd/y8ZHkepb1kNZAN0vTL4rZZwW9M6KidJTZrfkeSmpAXPFpf0phaYrU3gt6ilN5I0l0HyXxFZAVHyXzjibQ41in+4AiNjmGhIA3GXOrFUJcT+40Zo8DhYrHRYJgZOel5MU9075OYDJGx3CwU+vM/p56GpHvj6swtDSQMK7u9mlh1P9leghTalKd40nwk2jyL9XZu8ejHgS80uI0wggrnKZD3nqwxjy1ARLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=usF3kBRl0172fPuYut52Kd3/YYeLPpfYhwTK/HDrGGk=;
 b=LHprHE6RaL2EKvXI5BOXqzgW3JeZBf6cuCN6gTjEI7nPw+PRggwIC1bjAJ8ao776f4xVn2nkUY04xep5tfOJHoCsul0eJHHqK6WS8wK8+UCZx9DaDbFhVwqFeTHc90BB8i4QtFl1nBeoC+CVct23DqArwVM828TmxdN6xx/5NaEm8VZoVA0JkXNdUPdiSnymPwYHcQO6TaBmrj4zdoBYLHkApOAcW7WEYLfU4Zmvd+WtUCE2BFQewHKIYbXOPSTTUt4vRgDIFciBoh2vIL6A7zjtcsJd7gTm63IMSnkoXEVrZCBFk6L7xWVTpu0Td7pfWAk3lvF4NK6WI9/hGpumCQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GVXPR10MB8988.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1de::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.15; Mon, 21 Oct
 2024 18:53:14 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%3]) with mapi id 15.20.8093.014; Mon, 21 Oct 2024
 18:53:14 +0000
Message-ID: <483b79c2-eb2a-48ab-895b-adf20a100d46@siemens.com>
Date: Mon, 21 Oct 2024 20:53:13 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH] linux-cip: Update to 6.1.112-cip30
To: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
 cip-dev@lists.cip-project.org
References: <1729498634-13298-1-git-send-email-nobuhiro1.iwamatsu@toshiba.co.jp>
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <1729498634-13298-1-git-send-email-nobuhiro1.iwamatsu@toshiba.co.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0330.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:eb::8) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GVXPR10MB8988:EE_
X-MS-Office365-Filtering-Correlation-Id: 8951d38a-31b5-414e-7d15-08dcf2019e18
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?VTkwdEZTSTNvNUhTZ09IbVgrTjViMFdJaUd0N29IbWhzS284VGlnOU5UYjlF?=
 =?utf-8?B?K0xhNCsreHZ3dFZKSk1vZ3RwSW5YbGJETUJpSjVQd3phWTAyYnZST0Q1bmRx?=
 =?utf-8?B?MWg1MS84WVZ4Z0hrYU5qVGtYZituUDkva0lyMGRMSlBoRUpOTC9UVzJ2NDBP?=
 =?utf-8?B?Tjk5SnBzMGFJTytyZklUQWRJVzR3UEpzT2h2d2doUkQwankvVnVtdkV4Nkor?=
 =?utf-8?B?NUwrZ2psN240Y1BVZmVOcWxCTnI4MlRFY3RsU2Y4azBnREhxUVNNNytITnp1?=
 =?utf-8?B?UHBqYm1lVDhMeUlOWEQxbkd1VEdMUE9EMjhMM3dxWllWbjk4Nkh1TVE0aXdC?=
 =?utf-8?B?RHcxSDREa1hQdkwrbXRmeUsweU9CUDU2MmtXRVI5WUVuMzI3Y1h0MEdoTU41?=
 =?utf-8?B?c0RFem14bWNyS0lxWjUrMEo5bXk2MlBrejgzcGVSYXM5UmFFNUkxaVU5NTJw?=
 =?utf-8?B?T0pYaFVSVlIrZEJNZjJncXBFVzlqeGNHc0o5TlZMSHM5UVpUZnBDKzE0VjR4?=
 =?utf-8?B?T1VCS3JwZlpoZHJXRnhzU3pVRzBMSDRwR0w3TEw3a1dkZFRheFEwbjAwNThw?=
 =?utf-8?B?b0pnV1cxVUZSQmVNdVBYVzhMczBoUzVMRUtjQ3dSSDVSNC85L05pVUFaT2dj?=
 =?utf-8?B?eWtwNFFUSVpNSHA5UlZhQllIRTFiTDFhdkFzS0ozV21TYzh6bDNHU3lleXNX?=
 =?utf-8?B?WXRCclEzUFRGNzUxV2MwNEhqY0lJczF1NGVkZ2xMSCtVdFZDNlplejRUVlJO?=
 =?utf-8?B?akNQcHdDelVRSitnRFhHRzZSVitmRWhKd2ZBaVN0UGV6YkE0WHpnb2pOWU1h?=
 =?utf-8?B?blBDcUJiTWtvRzN2UUtqRnpIZ0dsSWV4VU56RGhWdmZ4S094REJLazY3dnZG?=
 =?utf-8?B?ZDVKUWQ0QThmWWY4bE93TWxPMS9zeEp3QStVY1RXUzNjUEVBZUtRSElFQVpt?=
 =?utf-8?B?UEJxeEZkaHU0MW0xQnQ5bGFDT2FCektTTU9laFUxZFlWNms3KzNiUVA3OFBW?=
 =?utf-8?B?Uk1Vd2dDekZEQ0ozT3dQQ1hQbFpRZGgybmgwQmxTaFFyYy9LMmNzWUd4ckFp?=
 =?utf-8?B?UmhuVzMva2VaQ211eHBmN1lGeGwvdWR3ZHY0cjFRMElmcnFjZEFmQlg3Y1Rj?=
 =?utf-8?B?NWlTZzNBOTEwaVc5TTJFakJTcE5GNSsvWSsvUzF6d3FtSmZxVTBoMVkreVN0?=
 =?utf-8?B?eTBSb2tzT04xQlFHMGkydUlrWXVaQTVnSEF2OUNKTW0vMm5zN013eUllNVgr?=
 =?utf-8?B?RUxWaldOTUQwMTBwQVFyWEFyY0MzWVd5OGdGYnRFWUxvRWNQVUZTb25MT3My?=
 =?utf-8?B?bU51Ti96MWxxNWVGOVNIQ1JSQ0lGekRla1VkeVN1Z0J2YTJIV3pLZjhPbVo1?=
 =?utf-8?B?S1Ntb3paNDVubDcydGg0cVRjQ0VzUTlZMVREaXkrdzNMcXFMUjQwaTl5VTRU?=
 =?utf-8?B?UUlMbkZkbmh4cktrWlBtQS9QL2plS1hFZ2gzaDE3MlFueXplREpjT2lkUmt6?=
 =?utf-8?B?cXdUYmd2bEI4andMWjUraFIrTGRvNjRLK1hhVWN0ZzZCSkxXS1VoZHFUQXJW?=
 =?utf-8?B?cm5lTmg4U2h1UGVUWlNGVHRaUnQ1Q1h4SHZDOXZPeWZtRmFmRG1YNCtEN3pH?=
 =?utf-8?B?OE9tMTFvRGFZakE1L2Fnb1JZMVVoMWNDSnRZVm1kcWlHVnN1WG9Gak94UGlw?=
 =?utf-8?B?YlBsMmhJZXFpZFVvWS9WK3l6QnJQMGVDTkNGWG1zWUdJRE4vV3RMelN3N2xp?=
 =?utf-8?Q?rQDuyO9ZHahl2Z2ZeeGBMGlev84rYYVxKAjmVwO?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?R0xnS2Vsemc5d3NsTlJmc2I4Y1ltNCsvQ0RoUnd6dVAzWFA2cUhVL1dTQ0Jy?=
 =?utf-8?B?K2N0TWFrVm0zK1liVDBtaG1rYXN4VitLM2RTMXd3Zk9aM3dDRlZ0MkdYa1V3?=
 =?utf-8?B?RjBGWDYwSXRGbWNER2Vxdk95VlB4ZlJjRStEdEVVSFlVZkNXT29LQmxOUU4z?=
 =?utf-8?B?QTRhVVdyb2FibzNsam9RV1JFc2dMSVE3dW1GQlVMR2FLL3ZJTDZjbWU0RVBT?=
 =?utf-8?B?a21LSiszWE1oelU2NTBGOGkrMkRGeTVFcVMxejJJckZVNWdyYVh0cHFMeUw0?=
 =?utf-8?B?MFlHRjhsTDgrSGhLb0pzQytNNlcyY1FtQ0kzMEFyM1pINDJ4VDVmZnl4Rm41?=
 =?utf-8?B?MFBTanQwYnJLWTZ5MllJZ2ZQczBSL0NzSTFjZSszaENLZWVOMjFDcXNCMUYw?=
 =?utf-8?B?VGw5M2U3SWRSVWplL01LZEFyZ1VBT1pGOWVISm5CTHQ5VVFlVUx0cWZVTm5z?=
 =?utf-8?B?ZWlSMmx1MUpmRGprZk9YT1l6NjFaOEM3L3lhQjlQVi9lcnIya1BwTmcxZ3dJ?=
 =?utf-8?B?UVVFeUE2cjExbjdrZGttcnVJZjlEWnc4WVN1enY5VFdJZUNLd0Uwa0xwV0R3?=
 =?utf-8?B?SXdYY1kwUDZJQ2tPK24ra05ON0ZLeG5jdTBzVVhXZlJkajlEL2RvV3Vtdnpu?=
 =?utf-8?B?V1dqMklsZmg4cFluS0x4ZDA4S1JkMUtNUXR6V3FPNHhiT2QwWURBa2l5eHRI?=
 =?utf-8?B?M1NtWm12L2drZkNPck1MQkZlWDBjOG9IcVMyRWNwVEtkMkRpdkcybGx1TUtJ?=
 =?utf-8?B?NUFDQWcvUjJjczdwMDJqbnhOd1R1SGpoTUQvdTJmM05UMk1DK1lQVXZKSHcr?=
 =?utf-8?B?Z0IremJoMUxtU3NvYjdheVBIc1FsNUQ1cndHWnpLOVdCY0VWcGFwTlgyWVlq?=
 =?utf-8?B?ZHh3a1ZXdGFkRnc1R3NUZDRKc2gwcVY2SFdBWDFGdWh0dncwWHdESHdETDcy?=
 =?utf-8?B?UWswanlQQWhPRlBML2htUGdtazJubnd5cSs0clhGckNMQ1lRb3hlK0lSYUlz?=
 =?utf-8?B?UnpUYzM2b1Y3bEhkWkR4SEZlQVcxZTEwR1FnMHFVOU1XaVhTSzBGV3EzRUdV?=
 =?utf-8?B?UHlIYUtuQXg4cXM1c0RFd3prOE9YZ0JpdklGWUZjSUQxL2FWMk5qWFlpbklh?=
 =?utf-8?B?eEozOHgyZE5HUWg0ZVpkZUQvZ3E5dWdJc0R3bE15VFROQWFJYVdoa2YwYndZ?=
 =?utf-8?B?dnRzb0FkT1hkQldxS3hGQ1lOSUREWW9GdWFMNXRRUXBpZXEvZ0M0VDZKM3JS?=
 =?utf-8?B?dkRCQjF6MUNEQVp5dk14ekpOMzdsN09nSmlFU3ZWSjQzYmd3RTM5MU15SzYy?=
 =?utf-8?B?b2pkNE5DUEJiYXRiTWpic2w0SjBnNWNvSWhQWDU4Qk1LRDczTXVNTnBXcVNk?=
 =?utf-8?B?OWpRYlEvNWJFNTJOTlpYd3ltSWdkbHVUenNXcklmWkNLSGxoYXhDUi9jR25J?=
 =?utf-8?B?NUoxUDl0S1hYeUhTajh4TVpudTRzRUprZWxweDFsWE1IdkRHUDlQMVBBMXBN?=
 =?utf-8?B?cGZ3UkhiVkJQOFU2UnFvQU55V292RzhkTXhZMHJFL3pLMDhoYy8yeUtTRnVj?=
 =?utf-8?B?U3JOeEYrSnU0bkRMRmkwODlHUXRaY25ZbUJQczF1Rm5xaTFQVmtCVTBXS0Rv?=
 =?utf-8?B?VzlCYjI0dUdudFNhb2RjVUZPa2tjQTFyZVpvMnhNVXYwN2ZwSFRyWGxHTG9l?=
 =?utf-8?B?K0NIV1ZQWTBaL0t3SXFXdVNEek9ERjErODZsWm4wVnZySVJJU3hISUhXVWV1?=
 =?utf-8?B?Q0tkZ0x3MWYvSm5KeGhad3ZkQW1MV0RqaEVHZDFyWktUY2lnUU05d0NGcXhZ?=
 =?utf-8?B?eEJzaDVJY2VzVkdFSTd1Yzk2bUtmOVFjMFVNQ2Yra1FZSVQxQ01iTjBFdDhr?=
 =?utf-8?B?RHZTTDJTN0JLOUZJSHdIWEExUUQ2eXd5R3dZTkcrak0vK09Ddk5iSllHdDRx?=
 =?utf-8?B?ODVQbStPaW9BcFBvYXFBcnYxWWhCOG16WDVCQnJrN1loQ2U3OFNyMGpLa1Zq?=
 =?utf-8?B?TmRGL0NwcTVFTlhBVUVHaVhFZXhlOENQRmd0OWFVUFEvaVQ3TXpJRnE3MHNP?=
 =?utf-8?B?anEvZStBd200NkZqMHRSMU9GM1I2Z1NqWi85WGZJZVRyRmt6TklJblBTekxh?=
 =?utf-8?B?U3lReUx2dCs0VytBWTVteHZWUVBlOWV1TUQ0UmpKd0c4OEtvWVBjQjJvbVlB?=
 =?utf-8?B?UUE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8951d38a-31b5-414e-7d15-08dcf2019e18
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 18:53:14.2430
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x+8SnMr1EJtkx90l2S/BclPrGCfdYpqyv7mXDPoYMIaNmvsiF1wN3bf8kjfXddgCb+a64hjVYB9inzcCfVojDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB8988
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 21 Oct 2024 18:53:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17058

On 21.10.24 10:17, Nobuhiro Iwamatsu wrote:
> Signed-off-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
> ---
>  .../{linux-cip_6.1.111-cip29.bb => linux-cip_6.1.112-cip30.bb}  | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>  rename recipes-kernel/linux/{linux-cip_6.1.111-cip29.bb => linux-cip_6.1.112-cip30.bb} (59%)
> 
> diff --git a/recipes-kernel/linux/linux-cip_6.1.111-cip29.bb b/recipes-kernel/linux/linux-cip_6.1.112-cip30.bb
> similarity index 59%
> rename from recipes-kernel/linux/linux-cip_6.1.111-cip29.bb
> rename to recipes-kernel/linux/linux-cip_6.1.112-cip30.bb
> index b4db33a..870e060 100644
> --- a/recipes-kernel/linux/linux-cip_6.1.111-cip29.bb
> +++ b/recipes-kernel/linux/linux-cip_6.1.112-cip30.bb
> @@ -7,4 +7,4 @@
>  
>  require linux-cip-common.inc
>  
> -SRC_URI[sha256sum] = "1aa412d9eaa31c566568537cfd9149cb1b12449d937f93b693c97a425b47b89d"
> +SRC_URI[sha256sum] = "70681787bee6c1057d002b440e3682656306aacc723ebffeebda1bf41da47882"

Thanks, applied (likely as last patch before the release).

Jan

-- 
Siemens AG, Technology
Linux Expert Center

