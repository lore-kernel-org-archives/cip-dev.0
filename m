Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9095C36002
	for <webhook@archiver.kernel.org>; Wed,  9 Apr 2025 14:00:43 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.69])
 by mx.groups.io with SMTP id smtpd.web10.9239.1744207241867395784
 for <cip-dev@lists.cip-project.org>;
 Wed, 09 Apr 2025 07:00:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=AHqnqOmn;
 spf=pass (domain: siemens.com, ip: 40.107.20.69, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uz3rfSLJFtQfdvWZ4Ov1szaRzqzU8vxfk8PLRQpQf1ERdRIrroIYNXojwAYSEMhkwwr0OLobOnbhcMa2gXJ881/yy/GTyQErjh0Zo6GMrALADnktaSqqnjYWa7Ug5cQCYLG19EV5RdaVcK94nvvokSych6yQYZ8aT+Cc5fhA8ebxXEuf2bZqnwEvglxkQeBcNIOuwslxMaxKEEcmvlJZTI8CXr7qYbmAbspSSKDtPKMvolSPo97XsVWgXiHThjoIvFCMqqSNgxhnjTlbAaslidkso+CjX3hLAmmA6wfsx7txwROko/bdlafdAv8jFJv47smOWgpEvpdGP2ihm83t0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q1oGQ/ASeNtqzo4F4xQEijHoHST48f9CODvTSpfR/AU=;
 b=R7vF2/J2xbTugZWEimjmDdyeebg5SpIBXaThHXOqfZQ0wI+qxuJpHXL53aw4E0Fe4Pg4giNtozGhrp+VhkCFJISfN8rojkWP42uIEoQduXtpvvUGhe7HcEOoy0VcZsIicgBVd7RGzaU6oSCl/OtnZPDrnoRK0RrifarTFhsO5Ghu/04SKDzvyHKODkXTNfZcC48/ZKDolkEZduhP9bQTnK8JImK2UgrKvR6a6llkJLsgAaAC3M6zBAm9TDGpHm53paICSk9TV5HpnKD/QkLNQYQ7CPdB9IG5Aw6NsXpea5kOP5OYRBXb3nlzkDbLwqqQih1DkyC1AiZPA7+EIuqsDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q1oGQ/ASeNtqzo4F4xQEijHoHST48f9CODvTSpfR/AU=;
 b=AHqnqOmnAolz8WwRSFdB2Xq7WRKyP+buNaMgqMlFoMha9COMk+OxBgrYTYdtKF2z9Z2/w9s2BEmOUxu43f0mQFmGoUynxSfh5B1s7xMEjDL+CbCxqalqmn7O+UOLA8h4noWGA/nO+lYRovGAIqCKbRsfoX9mULLVtP57NlzMugSArEhGZITH+lYDBU/U5O/FO92Wp9D5/ImOk1CVfQfnYoRrVY2Jw/CWPg9G56caiJwrrX9mfMmIA0THkwB3PxubLCJHdfD+4Jb+lbdbfP2kcm/Wp+iLBOgMoflMTD4BMiYsWREmeY29wkzenKVNyX4O5lhJMHgPjOceSiEcn3KWCw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GVXPR10MB8615.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1e8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.35; Wed, 9 Apr
 2025 14:00:39 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8606.029; Wed, 9 Apr 2025
 14:00:39 +0000
Message-ID: <87dfff5a-e208-4072-a256-3d4e8456f299@siemens.com>
Date: Wed, 9 Apr 2025 16:00:35 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH] swupdate.bbclass: fix forgotten whitespace
 in assignment
To: Gokhan Cetin <gokhan.cetin@siemens.com>, cip-dev@lists.cip-project.org
Cc: quirin.gylstorff@siemens.com
References: <20250408192718.1530180-1-gokhan.cetin@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20250408192718.1530180-1-gokhan.cetin@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1P222CA0021.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:2c7::26) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GVXPR10MB8615:EE_
X-MS-Office365-Filtering-Correlation-Id: 83174c79-9fc0-45f2-9e44-08dd776ee886
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?QlJtK3VrdzNXL0kzamVzUjFiM2lvUlh4Rk9qemFLR1FuZmNyTE9zMEhYc1ll?=
 =?utf-8?B?M0lGVi9ITTNRK2lsdGREcThWc0d4Q2hSWFp4WmhIcnZYdzFMUm1SYUplcVdt?=
 =?utf-8?B?azlDU0o3S1ZCeDF1RE05T285cWRkZU93WERTclRNOU9zc3p4RE4yRjhvYWxO?=
 =?utf-8?B?MWg1VVJRWGRCazd1NUJRQTRlYzlaZFZxTS9TQzNOOTAxN3F2c2lrVmgwZTA4?=
 =?utf-8?B?UUNyVzZDRjJIalM1T3JWcWtra1Q2UkFITldNYmtCd0I4ZThOM214d3J2bVJ3?=
 =?utf-8?B?eit4eGV5ZkJTVUZobERrazhZTkkxOGsyOFRveXZGeldsSTZ6T2cxM1gyb0VH?=
 =?utf-8?B?WHdSU1lqdjMzM3UvY0V2UHd0ZzZFVm4rTEJ1RnpWMmNjcndsMDBINVFiVlJT?=
 =?utf-8?B?NnIxU3JQTDFmNnFoamRLenlIOWo0NytMejA4Y1NlS0VGblZ0OXRQeHg3dkli?=
 =?utf-8?B?T1Njb1NjTHE4cjV1NS9xekNpek15Uk43aXA0cFFsUXdaMWNtaWI2T3d1RSts?=
 =?utf-8?B?ektjWWxIdHZ1SkRkYVVialZabWZKQXo4ZTFJcWF1RlNJUkNTOG05WE03Q0Zy?=
 =?utf-8?B?NnNZU2FHdWQrdWcrU1RURDN3RDFTZER1UFU4L1NSOUQ2bUprUW1tLzN4ZzJC?=
 =?utf-8?B?UElyeE1qRGN0c3JScmg1S09MVlVoSjZjbitDWmlucjVrdFRvK3RmbWM0dVdS?=
 =?utf-8?B?N3htSTZ3Q1JEQ3pkMEJERXhlTzhlUmltWktaSlJ0QnRnbnpwMzFVS0oyck9j?=
 =?utf-8?B?RFZJM3RDSkkzeElJNENOOHUxVGFMYzdnTEtVS0tDS1l3TDVSZkZpTElXYyt6?=
 =?utf-8?B?SWJZdTdlNEFrN0NnU0NPbU51L1FrVDIrR0lzQ3BZak9EVUFTeFRVQUdtRWVR?=
 =?utf-8?B?Wk42SWVseE1WVWNFQVFPYzlqTDU3bm16RHE4NjErWlkreWJ3QmtEYXNYL0tY?=
 =?utf-8?B?M1pEZmkwR2pxMGNYLzFRYmpCRzlpMGwrV1JFK2hmNlVNc0pDcm5pOU1jRXpz?=
 =?utf-8?B?UURHZ0pEVG9XaTFsNklCaERxUXo5WkNNM0c4TCtPSldlK2xRNDJrM0xwcWk5?=
 =?utf-8?B?YzR1OUdjaS8yWXV3N1dqY3lsNGo1bzhPdFM1NjRJNFZ0bitKVktWZmNlc3FJ?=
 =?utf-8?B?QzlRR1NGajRmeTRuNFFpYXd6WWJwT0VoeUxuc0FlTVlSR2EycjJHWThSUmRw?=
 =?utf-8?B?bGpTK1FMZWViYnRHVHJNM0pKdUNIakNPTHdvcWRlQkg2bnJ0TXdHZ1lTTlkx?=
 =?utf-8?B?ODZpYThINWZlMWhqTDQxWTRMb2lrMmxIYTg3Y2YzTUN0bTkzTU1ET2NiNmdX?=
 =?utf-8?B?aHhyTlVmSkpoYlQyMHFVMTM3YWtjaE9ncFFPMllRZ3BDWWRhUlpLcWVJSGEv?=
 =?utf-8?B?V083V3lXVC8xdC85NUFVSnBJaXV0L210bUNpVlRtNFM3QnljbCtEZ1lBcWRz?=
 =?utf-8?B?L2ZUeUdiZzUrNVF2ZEtrc010MUkzOEtlSnFwdmVVZWFIZ1NBSlRGa1ZzRmxp?=
 =?utf-8?B?ZG0wOUg2ZGdRNS9DQ3dVUUlmSHlEVzhXbWNLbEVHUmZXcG5iYktCb2FkL3d3?=
 =?utf-8?B?b082UGkyNWtYYU5MUCs3STVYM2p1dXlZRkdpRk1JZ1phaGdUbERKeXRwd1VX?=
 =?utf-8?B?b1dDaEd4M1BLMUZZTzFqZm5rQ2tIVXFlT01Za3ArU3ZOMDdiYmZWYmlHcDBZ?=
 =?utf-8?B?SW56enUvbksweWJUZFB2UjJFZlladHI3OW9IOHRBOHJPdkg0VTNmVWtGSDFD?=
 =?utf-8?B?SUgxWG9qRzcvSU5WbTRBUEFiNm93dzFmbG9TTG03Z1JVajEvUzBleTlBSnBC?=
 =?utf-8?B?LzY3QlNlaTJubnZZUkVpOFdQVExEaHBEU240VFRhZFd3eHAzdXZTbFVRNE9z?=
 =?utf-8?Q?FILb2TbrdTU1L?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?dVRuWmZSOGM2MHY0Y0svUk1YbVlzdVQ2NVRLT0tjcWlEZWV1b3lPU3RJSkYy?=
 =?utf-8?B?aSt0M1hpcHBzL1VWRVlLYVNtK2hIWlhyd0FIY0M2MVdyTnlWNzZBbUlyUVBy?=
 =?utf-8?B?TE5mbFliRG9FN0owSmVENmNUa2tmYzJ3ZWc3REtJZmd3R0twbHh4RGUyWDh3?=
 =?utf-8?B?Uk9OMHpxb2FlVXZYVWhOT2FKT1FUZFl4WDZrakFVWkxYTWhSN05lald5bnJp?=
 =?utf-8?B?R2tJTE95ZE5aK0JYT09aSGZudEM3a2hXN2x4OVBJVUsvVlJCTThzeUQ1NFUy?=
 =?utf-8?B?ODBqcDV5Uk1vKzRMRzB6bXNRMjlPeWpoMlFnQ2VsYmR0dDFjdk9sVUhqL0x0?=
 =?utf-8?B?b053NGh3U3BhdG92eHltUndrU0I3dXBwWUdUcmNoTG9SOUpTUk9xblNLaEtt?=
 =?utf-8?B?WmMwbVJ4WHVGbysyZVBpdUY5aFBjYU14RjVISlMxVVNvYUJpem9Za05taUZ1?=
 =?utf-8?B?bURpZm42Q3Q3YkwxRXlqdVFvTU1jUXVhcHdhV1RSamt4ZlRSdkhiS2tZYzV2?=
 =?utf-8?B?cHMvZ1hKeVh2bWhyemFNZlh5NWtuc2d6dVA2MFFaOFhySTR0MmErUXpralh1?=
 =?utf-8?B?MnFOajUwclFpWnl3d3EvdmZJOFRpSytyMm9nSS9PcHVYVzFhRk9jbmNOYkhq?=
 =?utf-8?B?Sjg4aEZEMCt0SE4zYU9wRUpZbEFieFdHdW9aWjZZbWhLUlJsRXRHaGRvQ3h0?=
 =?utf-8?B?ZEcxQXhQWFcyS25PWDNmUElTVlRrVzlwK1BwaC9ydHhOM2pScnBqS2l0MnF5?=
 =?utf-8?B?bWVtMjNpQ2VRWFE5MHpmaDkwdFZFbmdxcGFJajIwODNJdGQ4R05GSnNoL2dU?=
 =?utf-8?B?WUxwdnUwMzFLK0RzUjVDNXU3R1RBRlp0MVVXZ0h4eU4xUGpQeUZYRUM0OWpu?=
 =?utf-8?B?dytVbmNlUk93U3d3clVGSHBPUmYwRkFJbTFBM0dEM08rWWRjK0szN3VnZ2dO?=
 =?utf-8?B?VVRjTlgrc3AwWlpkaHdxaUc1VVNweExSSnFYQ0w0bUorNWNZTDZWYWE4Rzdy?=
 =?utf-8?B?WkI3UUtWNGhhWEhWZ0Rtem5LY0NVcno5dWVXclJHaFI0c1dlN3RYZUpVeVFP?=
 =?utf-8?B?ekdkeDhicS9LZWhyMlFBMkliWjJQVkhhN2pSVlVYNXhONlNzT2x2THJ6cm8y?=
 =?utf-8?B?RkxxT1o2dnV3NHpmSmplT3prdHo0UW5INFV1VllmSXUwemZVYUZ6SDltSmhC?=
 =?utf-8?B?RmRIWHI2MnlMa0dvVkVUUlRvcHZYR1YrSGlCRldzSDVib2YxUWdrOW14RTc5?=
 =?utf-8?B?S1A2QWQ2RHNuTXVXYnBZc0o3Zk80SUhLK0pZVjdVWFZOZnliZ2cza2p4UCsz?=
 =?utf-8?B?RWVtd1hLVENCV1FndG5LMEtHQlBLQlh3TXdCSVdWaWl6VnV6NXFSU1FDOE0r?=
 =?utf-8?B?TjJ1U3JoZ1RLeTlJNlI4UGVXSTArOFdwQlgreHMycmUzMjU2Ujd6VW1ySEdi?=
 =?utf-8?B?NTVGdDdBU3VuNThzYzBTandXbXI5QTZFckdxUXRPdFpuSGRQVGZVSXlGWnFQ?=
 =?utf-8?B?S0FUbzJzQkVKaW1OM3Y3UEs2UlhSK1hsNVV1bmQ3Zk1HVTBPcjVRekkwRXZF?=
 =?utf-8?B?akhpT1gxWExSeVRXdHVHRUhsak8xQjAwUENybDIyZmlwK05yZmlQc0FDRTdI?=
 =?utf-8?B?VzJETk9nTWY0OEl6bmRPQXE4MTMyM1ZpMUFJODFuUGs2YzJiR1ZodE1LUERM?=
 =?utf-8?B?ZG5MUVh6U1NsdHVLK3QvNnlsbis2Zzd5dUJ5YW9JbWxDUHNFZU1vRCtuVzVT?=
 =?utf-8?B?SE9nMmZYVFJ1c3J3V0pEbU1IMVcraWpOZW1VUlBpNWVvZDUxeGl0c2NMVEJK?=
 =?utf-8?B?UlpvVnRtK3grOUhwMkcxczdjVmowOForYzVCNEQwR0d3N0h2dVdiNXBnU2J6?=
 =?utf-8?B?UnUwQjJLRDlCQTIrU1BZOUl5aFI3RXZLWWpMREFudTZlbk5acktwSDY0S0Zy?=
 =?utf-8?B?V2JVUE1qZzFoQUV1VzFaMGZockhkMk5jRFhmRTFNMTFnTTd1UG8veEJQcFV2?=
 =?utf-8?B?TTlqVC8wNllkOVlXRXJsSDV3RnFKZ1I5Y1drbVluckdzOFRha1o0UEdVOE9r?=
 =?utf-8?B?RUJTcDFkUndyRzNBTVJCRkNPY2JvL2R0NXM4Nm9IYzNHNU1WZ1NIQVpTMzRM?=
 =?utf-8?B?M0hpenNsZkFQVEhyOEhJWWFpdDM2cndxVHVKT2tPRW5XSm1OMzMydEFHMmlE?=
 =?utf-8?B?NGc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83174c79-9fc0-45f2-9e44-08dd776ee886
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2025 14:00:39.0318
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FUQDuKrY0SqW3PM/Mg29oMZsjj8VYnL5pB2/R35MUlSKCnclT/681UyPtErq0r3XU1PxaU1EGpfmFUSzojyoHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB8615
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 09 Apr 2025 14:00:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18498

On 08.04.25 21:27, Gokhan Cetin wrote:
> Fixes `file_size: command not found` error in do_image_swu.
> 
> Signed-off-by: Gokhan Cetin <gokhan.cetin@siemens.com>
> ---
>  classes/swupdate.bbclass | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/classes/swupdate.bbclass b/classes/swupdate.bbclass
> index 61e4fe1..b0b05d5 100644
> --- a/classes/swupdate.bbclass
> +++ b/classes/swupdate.bbclass
> @@ -251,7 +251,7 @@ IMAGE_CMD:swu() {
>              # check if swu_files are less than 4GBytes.
>              # This avoids the limit of cpio
>              for swu_file in $swu_files; do
> -                file_size =$(stat -c %s "$swu_file")
> +                file_size=$(stat -c %s "$swu_file")
>                  if [ "$file_size" -ge 4294967295 ] ; then
>                      echo "The size of '$swu_file': '$file_size' is greater" \
>                            "than the limit of the swu format of 4294967295" \

Thanks, applied.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

