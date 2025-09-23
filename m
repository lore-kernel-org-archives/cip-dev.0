Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFF04CAC5AC
	for <webhook@archiver.kernel.org>; Tue, 23 Sep 2025 16:39:41 +0000 (UTC)
Received: from GVXPR05CU001.outbound.protection.outlook.com (GVXPR05CU001.outbound.protection.outlook.com [52.101.83.52])
 by mx.groups.io with SMTP id smtpd.web11.2335.1758645579445869201
 for <cip-dev@lists.cip-project.org>;
 Tue, 23 Sep 2025 09:39:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=NENwxLKr;
 spf=pass (domain: siemens.com, ip: 52.101.83.52, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K9SK9fQ7KHb/9KeOocY+LR2w4y5WhlMTdRFq9iPWWx661B5+iFpIKJ7PjHncFL1pnAB+Ay1iZYT+23mh2543t/m3/aumirnVAAGdWt/BM++/yCvX/e6QbCM7omnWV7hsDkA96ybcMzdnvKHjYasuX6ag/QaBvr+mksMImWsjrTGg7dogVnUSh0VlopWmxAWA02ds2EWolXE0c1hUbzwRW6Y0IjDH8yqpXIoQtZI4b+x3DxADqQ2Uuun/1kopzV1ltMVbjS+78VYWXA+GiPXXFMyCRjmR8Lmi4gU9GEXFF7lgpVsK2wp8UeBJjk9zGAKlAecU6JcKm4hO4ROhdXqMvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Xhrkq5CjY/HhfDNzMInCeVFGHi9s8OcZCfZQFGfGME=;
 b=JMR255ASjgyyWk0yKMfrq23F+HTx0/OxXmgJGuj8Q8whh8mVNL4h6BSJb2NTWeQtM5cNIWrLyBMMVarA6UyjEHBa2G24oHy7RMX+yHl2b2QXb6kFyMX4m+mRqdvAu2ussxfC/UV2jzcQazUYRIF8VPZXA06iX0tpxox627aeCSPgMi3jJIJJMt+rXjlG/f/Bw91//UKw6Q61rk9bUZjLGQBqW4bAji8ODIN/Nj1wO+uj9C57YymSuW7OflFDXSniDLLMVql3UWa4wPTlxuEx/pxJND3H0wTI7lffD/73p3vXc3IYzzcGTt64zg/cYoP/tcv8P9GHxfjVqeSmdCdkeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Xhrkq5CjY/HhfDNzMInCeVFGHi9s8OcZCfZQFGfGME=;
 b=NENwxLKrLZjWcLWnxcKjYcdPWx7j3nvjfE5uiE3tTHAMKisQ9RFvNmM/GcJB0rEBpt4Vxgc/gXseSPJ6A6FUnDutgSDhdjHfPNeFJf+MB20gpmX+VGVL8xOnC9d43wPW/oe1JjV8CPOBlG2Q6ZNr1wFWXSCWzd6G+Hbz20OqezVUoEorDuQey0zwLJo6BhS4D3pytZiNF8obkLIlXHYf6PzhhZT7KjC7EmuVeGgZj13rU/pJeIo6NXl81RxoCkLxg+oQrFHnVrC5xpyRvogsbarlgGVYQETZmhHbASCXfMgxJffcH/CLWPM7f619eBM5pTQMzUWcUu3VF4gMtpAukA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM7PR10MB3908.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:14e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Tue, 23 Sep
 2025 16:39:35 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9137.018; Tue, 23 Sep 2025
 16:39:35 +0000
Message-ID: <ae662cab-4a95-44ea-95a4-e1297490b7a9@siemens.com>
Date: Tue, 23 Sep 2025 18:39:31 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH v7 2/7] Factory-reset-helper file
 is incompatible with encrypt-partitions
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org
References: <20250923115319.335608-1-Quirin.Gylstorff@siemens.com>
 <20250923115319.335608-3-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20250923115319.335608-3-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR11CA0024.namprd11.prod.outlook.com
 (2603:10b6:610:54::34) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM7PR10MB3908:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fb04b57-d052-4fa3-2129-08ddfabfc78b
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?UjZSM3ZrQ3RRek50SWxpaHBDQlZieExyVkh1dmovTncvWlFCV2U0MGgvUm10?=
 =?utf-8?B?bU1zY1BLaGZQaWVCUVBuT3JBdldDZFZhRUdIYnQ1UWgrdHhYY3RXaFQyajdM?=
 =?utf-8?B?S0M3NGZrZXByMXdFcWlkQ1Fsd3BZdnhPTmc1NnZPd3dpWldDYTlzeFppaml0?=
 =?utf-8?B?RDdaZ0xISFJkZWZ6c2hLK2tIUWY5b2MrSGlna01Mdm1aM3h2WTgrcy9CbkxH?=
 =?utf-8?B?cmhoSXV4eHhUN0VkM2QrMWdSaUxXOXl4NnpIMnUrRHpQbU96c1lZMjBEWVJM?=
 =?utf-8?B?MFdzN3IyQks4Q1BrenJJTHJNRms0SkVIWXJTNnllNlNBanFRYVNDVVR4T3RD?=
 =?utf-8?B?WHg4TTcrWU1neVZ2SUpzVmtreTBhRldXLzgwQVZ5ZmQvRndVSmZ4c1hPVCtU?=
 =?utf-8?B?WVgvc1IvcEVwTWU4TDRIcy9nTnI1ekNHWlNuOVNUN1NhVlJyVXpWeFdYR3ZY?=
 =?utf-8?B?N2d1VXdtVVl4YmZ4bDY1RDNNKzJIeHhOQXBZWlZSWWZGMG5wWldNMzB0UVhQ?=
 =?utf-8?B?SWJnbGJFeS9ZOVh1M0xNRzlIRXdrbkJNT0JaQ2tsYzBVcExlZEZ2VGxmMEVa?=
 =?utf-8?B?MDRoMnEzRUpBYUJyM1N4cSsyalRoVkh1c3YvbTc0UzNuNW4rZEgrbk5ZNDFD?=
 =?utf-8?B?YUtXMHl5c0tjVXVpMzhnY3NiR0NSZFY0SXpJWE45TzBqaGFVSXFLTDFndjJm?=
 =?utf-8?B?MTFqNEJ1UHpISWNsRnZnSm1hU3NYWXNSWjZhOE1yc1phelhnZXRXbzFad2Zh?=
 =?utf-8?B?VytZdXl5bkUrUVkzUWg5L21mdnNuWHl4NUQxVWl3R01vTzFOSGQwb2hSRHdu?=
 =?utf-8?B?TnZvaUtrTU13VUFTZVl4S1RxeHluQmRLZk9jVnk2MEFrdkVLM3lzZ0N2cmNl?=
 =?utf-8?B?MDRwMjlyMVR2cDhuNkozTzdBQ3ZpREZhbWZjUHczMzM2S0pMemtNUUI4M0dC?=
 =?utf-8?B?U1BhT1BXOFY5Ymo0YzB0UWlwREpnY3pvRWlTcHRoTVJrRzJaMmh3QUsyVmFX?=
 =?utf-8?B?U2RPWFFtb2VEWmQ3UFFSK0ZRWTFXSWhWdU9JOVRsODhWeXc3dWd0eUdnRTAz?=
 =?utf-8?B?QmhKeUdJYXlDRGVBRTYvbXV4VWFZN0l3Y2RNQVZCenpxZGRVRnozWWJuTWsr?=
 =?utf-8?B?ZVRhTGxacExSTVplWmR4ME9EQjlZaVVDbC9CQVNUYzYxOUdIS2M3N1lxaHMz?=
 =?utf-8?B?NWxoQ1VyMUhFRzBLLzFLYlNOdnBCcDMwbTN4ZUE5Mml3RGlIYXB1RzJ4d0lB?=
 =?utf-8?B?QzBGc2QxMEtGeFdjcDRESGhpL2tvNDZFWDBFWmQyUFFsblpsRkdCRm1VNzht?=
 =?utf-8?B?em9kbjVKTmcvNVdpMlNTTE5kazM3TUpvRnFYWHlXbTRxUThQcUZpSHNPc3FD?=
 =?utf-8?B?NlpuZGZOWk16emNjbmdRZkhvUytWcG5hdldmL2Nsa2pLWnFLWnZXUVFnTExJ?=
 =?utf-8?B?ZHFxMmFDVVIzWm9SQjgwN291ZVpSOWN4V3VhOHEwL3k2SWhZaUR5NXRqa0ZI?=
 =?utf-8?B?L0FiODhsTVc1WE1FZUIwZUtYckNCd096WjhwYjdTNGdkWkdyTjlZRGxWUmZz?=
 =?utf-8?B?WFo2czcyMnVRTzRuYy9mdC9JN0JMSFdRTkpOeHBxc3p2QU82TkFic2VkVEgw?=
 =?utf-8?B?RExpMmgvbjk1Vk9jNWd3djd0VHorRFN2amZyS2ZqZUpjOXp3NW93d0VmenJS?=
 =?utf-8?B?OXoyVGxReGlKVVJxNW9yUmVzZzE4ZVUvUFBNZlV3SG1MdWpUQmF1bkhLeElL?=
 =?utf-8?B?VXpSek90RUNLK2lJb0kvS3Y2NmNEVUR1V1ZaRElhNFhFMUszNEFnNFB0dTZU?=
 =?utf-8?B?NHljTnByS21xMkJ2NVJSb0FBY1JtcWZsYWF1NjZubTlTVE1xanhqWHFqYVRm?=
 =?utf-8?Q?vCempPgBsb/hr?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?YzgwK0VmbGwzbnVib3NzM0JtUUw0ejZSM0dwVVdESlRNNE5kZzBUUGFQaXdp?=
 =?utf-8?B?dlhqN0hLd2UxTllET1FKNFF6UmdZdkdzY0RkTkcybng0UHIvVjZ0OUQ0Mzkr?=
 =?utf-8?B?VzcwSFRXcElVc0RCaU9HQWN5YmxoUy9BVGI4ZmVCNWtFZWNOMjRVQk1HQlVY?=
 =?utf-8?B?a0FDM2FsU05pNW5kWEVOendweC9uV2VBNmtsY1VWN1lueFpZenAydFpWVmlL?=
 =?utf-8?B?b3BXQnZFT3JFU0JBYmQxakJyV052d1A2Um05d1BuUk1vSXNHNU9VZmZQSXY2?=
 =?utf-8?B?MTJhMWRGQXE1c05hei93Um1hK0NuTzA3SlFOYnpkcnEwNHZTNWlpZTBlcEdk?=
 =?utf-8?B?ZVdKYmNNYWZ2NStSTW5UakkrYzJCeVFWaCttRFJFOXd1VTVLN2x4NW1xUVJz?=
 =?utf-8?B?azlrMGJhemJCN1JwZC94NG9vZ2dzWmVpd0IrZVBlSlowU2RSQStVS0JBaWNy?=
 =?utf-8?B?aExvd3d1c0ZEYXNESnJObzYvRHlqdnZkWWs0ZFQ1MWlMazNwamZUVURqVzR2?=
 =?utf-8?B?L284VWpMSm9XdVpFc201U25HWkNrM0hjRjA5ODZHVnBUbnJrMzIwQlVsQ0M4?=
 =?utf-8?B?WVBUYkN3T0hpdkUzODdWeGNoUVhTU3JXVXN4K25PdDhwYzZGYjBZWENZZmdp?=
 =?utf-8?B?bng5Zk9tRGg1THNvTXNaYkFYKzRIRHplK0tOYW9Qd3ZOczJ4bElLb2NhWXdZ?=
 =?utf-8?B?TUNQTys1L2w2UDB2R21IVVdNcCt5Q0FsMkt0MWRBNCs0MlptME1odzArOU1Q?=
 =?utf-8?B?MkJoRlJCYWtORFM1a3pFQjMxWGk1QkZrWlJYbU1EQzhLTVdCK0NLemowZklu?=
 =?utf-8?B?Q2hhbWlqZFZDM3ZVSlRLc3hqN25vN3dhd0tPMWtISUlmVnlucnJQWWFUUVZ1?=
 =?utf-8?B?SEMrZVdKaFFOQUtSUUEyY2FuZGFVQnczNE5Mb0c4QkZoUGE4V2ErN3R3QzEv?=
 =?utf-8?B?YWUvamdDcytxOWgveGdIUDVwb1hvWGoxcGliMjFvU09MSS9XdWlIK1lwUi9s?=
 =?utf-8?B?aTc4anpXemQ0Y083dGFxRjJrUGlhSmZlbDgybHNaWG5uMjNwd3BCMEhZQ3BG?=
 =?utf-8?B?dzlHUkZFZGNid2lCdUF1aDhkS3NlK2dPQ2NMazVBQVFDTGhyNWJGSlpOQ1gw?=
 =?utf-8?B?RXFqZHRsYkF4T0RCUkNyckI4QmF1b2k3b1Qxa2ZLTkRlL2t1YTlCdExDUytp?=
 =?utf-8?B?OWs4Y2k3cUxBbEdubEFaQWo5VURhM0NYQUttWVBZd0UvQ3AzaXBRY2t0Ym5T?=
 =?utf-8?B?NmdYOFhTTmhyK09YbUlGK1Rqbi9BeEgvUlVoZ25PR0tzRnB6MDhhU3RRR0Nk?=
 =?utf-8?B?YXlHa1JDbnlvZmt2ZjRvWnIyeGVEa05VQlRoNzhqS1VVcGpsaGtsNzdsT29y?=
 =?utf-8?B?TkMzak41VmVNZExhZ21oRHZ2Q3FXeStvSEU1Q2JFQjVmOEhxdEVIRVlWYXBx?=
 =?utf-8?B?V29PbUJKeWdIVXJPMkdMd2tlZk9BRmZyQkRqODZmUEtDZ3pXRWxwUWVhRlNF?=
 =?utf-8?B?ZUhubGZ1OXdwbmhzK3R3Y0RFZEoxRkdDeXA0NEpLRlpmNDNJaTRBRzB2cnB4?=
 =?utf-8?B?NGdRWGI1Q1hmUlU4SWJkZ3IybS9sWCt3Ry9RTWpGdWhnaFJhL0dNRDhJUzU2?=
 =?utf-8?B?eDhqUWh3UmhkU3ljU3Rhb0Qrb2V1enMvK1RnWXppZFFrdHNXM1pQQURpVzB5?=
 =?utf-8?B?TDYybDBlYWJyaEViSlVTL1YraUdSeHQ4YTZKMEJudWpCOEtwaU9jVGpnT2xC?=
 =?utf-8?B?QkFqMGpGeCtuVjNUME9nMVZNaHNQWEFHenNQYXIyN01OYmswZTRyb2F0Mmtx?=
 =?utf-8?B?MkJHcVg4dU9XY1NDU1RtM3IxckdRaG5BNEZYYmkrTWRKL0wxTXphNHQvYTAv?=
 =?utf-8?B?OThaamZEUWNrY1VnWEF3S1hxRXJHWmR3SFZScklkWSt1L05aUUlJMUoyK1gv?=
 =?utf-8?B?WW5WVHJrQlFxYVhBWE9LNlRERWpWYUN3SlFWUklya1dLc2lVSlA4aHZ4aXVy?=
 =?utf-8?B?aUxoS0pFYmpEMGkrd3dGVGtFRS82OXRLMWZlKzhMZHp4U00zSDlkZE1QK0Iv?=
 =?utf-8?B?RHpHNU8xNjBlRFdKOEZPT1EyeStGS3NldXdPTUJsa0tRbHVMMDBmaHdreDBw?=
 =?utf-8?B?K3VRcDduN0Mvd1N2Z2t2ZWFjZ1hoc0E4dzJiNTF2V2tUd3psaStHNUF4Yld1?=
 =?utf-8?B?dHc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fb04b57-d052-4fa3-2129-08ddfabfc78b
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 16:39:35.1450
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xsjhTQa4lrZ9kZkDQpx6lNt3lLiDTvT+XvdbjA+Jw0tN/BHePRvTQgu9zt+fjSTqw5MyOsG+1Jt5nnL70AkY+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3908
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 23 Sep 2025 16:39:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20116

On 23.09.25 13:52, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> The partition which contains the reset-marker is encrypted and therefore
> a factory reset cannot be detected. Print an error if this incompatible
> combination is selected.
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  .../factory-reset-helper/factory-reset-helper-file_0.1.bb    | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/recipes-support/factory-reset-helper/factory-reset-helper-file_0.1.bb b/recipes-support/factory-reset-helper/factory-reset-helper-file_0.1.bb
> index 8d82663..14870ce 100644
> --- a/recipes-support/factory-reset-helper/factory-reset-helper-file_0.1.bb
> +++ b/recipes-support/factory-reset-helper/factory-reset-helper-file_0.1.bb
> @@ -17,3 +17,8 @@ FACTORY_RESET_MARKER_STORAGE_DEVICE ?= "/dev/disk/by-partlabel/var"
>  FACTORY_RESET_TYPE = "file"
>  
>  DEBIAN_DEPENDS .= ", coreutils, util-linux, e2fsprogs, bsdextrautils"
> +
> +python __anonymous() {
> +    if "encrypt-partitions" in d.getVar('OVERRIDES'):
> +        bb.error("This recipe is incompatible with encrypt-partitions")
> +}

Needs more work, namely filtering if the recipe is actually used, not 
only parsed:

https://gitlab.com/cip-project/cip-core/isar-cip-core/-/jobs/11460474025
https://gitlab.com/cip-project/cip-core/isar-cip-core/-/pipelines/2057638499

I'm pulling the series out again. v8 could then also add CI support for 
the enabled case.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

