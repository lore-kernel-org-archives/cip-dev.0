Return-Path: <s-adivi@ti.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AEBAD35692
	for <webhook@archiver.kernel.org>; Wed, 28 Jan 2026 08:18:11 +0000 (UTC)
Received: from BL2PR02CU003.outbound.protection.outlook.com (BL2PR02CU003.outbound.protection.outlook.com [52.101.52.61])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.8558.1769588282808793227
 for <cip-dev@lists.cip-project.org>;
 Wed, 28 Jan 2026 00:18:03 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@ti.com header.s=selector1 header.b=Og2qyQMf;
 spf=permerror, err=parse error for token &{10 18 spf.protection.outlook.com}: limit exceeded (domain: ti.com, ip: 52.101.52.61, mailfrom: s-adivi@ti.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uSdBqkvtGoVb+taHHaKd47SjjV+Y1STokJyZWZ3yXWmw7cy+lnnEMMc6Sm1zoXjmxiZ0E+hoOAWQByrFPU+LmhG62cwY1XfN9nLMWUOK4kFfsDZOCnNYVKMKWYOwWExsB3ltuKefnrvAix9DICL9/pte7nLwYP/U5FglfgeINHWOP4mUz1FjP56NsemmvyHrbwsgaoAVdCKGFhB2lpGPjt6A0eQSz9309WEHyI6tgDD6DI8rO40ciEgS9JcXXhqwM5zdgu/bUcfCO70SwUshpnDTRIJXNkLlZP/KSTz0/L/B7gTMnKlRcHPaFX6l8lsv5AW9CGfl7/V/OueYSxkreQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xd3lMij/+J3EldAc6GzKJjdLZ3pRslPLiNKVzsmfLis=;
 b=Ws5IAl6Xy+31hT2J3CG/J1U2FX06oHuJFE3SjOQj5wgo65cZ19isbm4az/EQi9KtVXHP8EZOfA3p/2BEnFFbvWhluVJZOb3SYk7fF4bBYGwt3mDw09/P8c1K81giA7Ly9dlXvPPIG+DiD2mGTtdnhabby4JPEnTqb6hP/H1MySGmqxOZcEEF2HLyZv5CRY4u3jVwB6t2KjVqutCNAKB4bmOaX9XrwZnlIbqKKNN7zY2Klkn+hB/24vZoQZedDjQ49fz1OYvIiHqwA7zFZyAqvXzB+MdjdOdYul8krSNOuG79JWwoULjunw+cRmMv7Ri13qdTomGhSsm3lrcIUUOxtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=renesas.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xd3lMij/+J3EldAc6GzKJjdLZ3pRslPLiNKVzsmfLis=;
 b=Og2qyQMfEfhVzCprnrq1JaN1VEtuEjbhQjg+7zJcElXTey99AAR3Gb0rMrYJsDwKYzt1grH6c0+FOleTEWSdJfcEmuafd7tdEl6RNLV43LearmTJnh8Ib2AtowGxrxdoe3PrT3SjMV4m8bNn+qQXuU9l9Py27st4ieLtMj9po+Y=
Received: from CH2PR14CA0016.namprd14.prod.outlook.com (2603:10b6:610:60::26)
 by IA1PR10MB6265.namprd10.prod.outlook.com (2603:10b6:208:3a3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Wed, 28 Jan
 2026 08:17:59 +0000
Received: from CH2PEPF00000145.namprd02.prod.outlook.com
 (2603:10b6:610:60:cafe::37) by CH2PR14CA0016.outlook.office365.com
 (2603:10b6:610:60::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.7 via Frontend Transport; Wed,
 28 Jan 2026 08:17:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 CH2PEPF00000145.mail.protection.outlook.com (10.167.244.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Wed, 28 Jan 2026 08:17:59 +0000
Received: from DLEE201.ent.ti.com (157.170.170.76) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 28 Jan
 2026 02:17:59 -0600
Received: from DLEE209.ent.ti.com (157.170.170.98) by DLEE201.ent.ti.com
 (157.170.170.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 28 Jan
 2026 02:17:58 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE209.ent.ti.com
 (157.170.170.98) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 28 Jan 2026 02:17:58 -0600
Received: from [172.24.233.239] (uda0498651.dhcp.ti.com [172.24.233.239])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 60S8Hu4D1621871;
	Wed, 28 Jan 2026 02:17:57 -0600
Message-ID: <ae120bfd-6efb-4ab4-b0fe-0c8964a2fbd2@ti.com>
Date: Wed, 28 Jan 2026 13:47:56 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12.y-cip] dmaengine: ti: k3-udma: Enable second resource
 range for BCDMA and PKTDMA
To: Pavel Machek <pavel@nabladev.com>
CC: <cip-dev@lists.cip-project.org>, <nobuhiro.iwamatsu.x90@mail.toshiba>,
	<chris.paterson2@renesas.com>, <vigneshr@ti.com>
References: <20260127075639.1259440-1-s-adivi@ti.com>
 <aXicChQlaiaAq7w3@duo.ucw.cz>
Content-Language: en-US
From: Sai Sree Kartheek Adivi <s-adivi@ti.com>
In-Reply-To: <aXicChQlaiaAq7w3@duo.ucw.cz>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000145:EE_|IA1PR10MB6265:EE_
X-MS-Office365-Filtering-Correlation-Id: bdabd890-8b7d-4746-17de-08de5e45bfb6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?Szk0dVhXK09yQ3MrSTQvTDF3bDhPQUdIZ0lSRFlGdk5QYmJmU2x0RTZZeHVs?=
 =?utf-8?B?aWtiTXM0YUdGZmVOOThpZEVnYUd6TFRTTkhnYTAycXc4K0NpZEozdGtvMTJs?=
 =?utf-8?B?VGFnRWR4QmJrcVpISVRKcVRGRE0zWWlXUFdIRVl1UkwxNzBlUlFHTHpVZk9U?=
 =?utf-8?B?UW1xcExjY3FDWnBJMWV1YmFrazAwLzg2ZnZxa2cyamMxdXN1SWRzSlZCdlE1?=
 =?utf-8?B?UzBZSllTZDVDSjhyU25zL2M1eGJRSG9EaFZNSktCN1BFRjg0QnBzSUtwR3NO?=
 =?utf-8?B?cXFLVDV2eitoZXh3MGNKS3FtVkRGajZjdFpYVHBsTzd3Y0tFRlJVRUx5emxu?=
 =?utf-8?B?TmpHZURQRGVLNmpGNSs5ZWFZeitSdWRPbUxuRWtwWGczL2dkRkVlK2kvSXVq?=
 =?utf-8?B?NUhvY1hoa0tVWFFaOS81SEJGWTBXblBHa29tUE5TUWd2STRGb2dIV1NxVEY3?=
 =?utf-8?B?V1J6UitqV0gzMWI5UFhHeVVNTzJiUXV5cUZPNXQ4cFVkK2lLd09URGozZXFq?=
 =?utf-8?B?U3FvdllTaWRiZ01CV3lQeCtBN1I2TzIyaGp4akIza0JLUVorT3BtbThlWGpX?=
 =?utf-8?B?em0yZFBpcjhYT2praFAzWnhYMk9GN0E5QnEyelhpVTI4WXFhLzFIcXlRTnJ3?=
 =?utf-8?B?aVNBSVEwVjVWUTdlekIvQ1hoZ0dGTVlJbkhkcEtEZ05zSUJKVXBKTVd1a0NK?=
 =?utf-8?B?NFJUc2ZYUGZMT3EzQUd4YTgvb1JJOGxjeE01c2xRMUVLSFFCK3hzV0RlR1cz?=
 =?utf-8?B?OHpJa2QrdG4zUkxWMTliYzcvTGdVWHk0NHE3M3JzeEwyNTFQM2QyMXFNK2dF?=
 =?utf-8?B?a1BRc2xINzR4MjFSZGJyUmdNaEdsb2VxSzFxZGw0L0ZuRFNHWW9EaTFVM1ht?=
 =?utf-8?B?SkFMb1gxdGRSSVl6N05KeFB3SloxYm0zR3VPSW9XdHZRd3dlMVNHTEFlTmho?=
 =?utf-8?B?dzBNOExmRHVxdTQ3WEpmZDB5ejR5L3JYTFRENUJjQVR4N2xzL1F3MWpmZFdj?=
 =?utf-8?B?SlNJZ3hNNU83RUNmWEVmSnArbWVQSC9QNjNOeUJTSzJDb3VlV2FrS2JRSDVv?=
 =?utf-8?B?ODBOb1lsVlVXTFY4Si81YnNuY2NHQW1oTTlsR2Z2d0kyZndnQThtcEk1dE02?=
 =?utf-8?B?c2J6Wm4wMnlvd0NrdEQrT2oxYUZkV2JNTEh6cytidkNpZkhNZVg4U3JPYjEr?=
 =?utf-8?B?Z3dPbEVKUDUvQlFoK0JxTG95dGFwUXlUajJPWUpvTDlsbkV1M2xRU3lOamNF?=
 =?utf-8?B?ZmFNcWkwdFBER3dMZ2grUlZMMmRxOU81WWtnVmppTEt1Nk1YVWdBSWU0TTBT?=
 =?utf-8?B?dzNzQ3hOWE1QSzJTZnhXWmpZN2I3Nm5BUm5KTnRsQnJ3TytKMFBHRktUOFlH?=
 =?utf-8?B?WUNqUGU0RE5RM1hFeTIyMEVmYTRMT1licHA1UG9qdHNDMWpJRE5CWXJGQkZM?=
 =?utf-8?B?RVVqcW83NWJOT3k5bnFWdEhwODJCRmtjM3BLc0J1eXFvbUQzNklHSkVOVnhm?=
 =?utf-8?B?VHF1bTMzM1QyWHFydUwrc0VwKzZjWVN5Rm5kRlpCMERoN2ZrcVk2YVVmYW0v?=
 =?utf-8?B?Vkl3MkJlL1FkR2pZdzFGQmZQQnJRRXpaNENJRDhqWmF6aFd4Q2hQcE5ISnZV?=
 =?utf-8?B?ZnJ4aUl4V2pHUWphMEU2RDMrSTZkZmFLanQzQjZFaXR3amhZQkZsdDFXY1dW?=
 =?utf-8?B?RGVpM25lc2ExemlUQWhKdUxBcVhyVlhPUGV0SlZIYmxHZkhMVWJHN3RSR0x4?=
 =?utf-8?B?eTE0U0VFYk1ZV3hHVWpHRjVTL0xJSFZYKzQ3VDVic2V2MFJFaGswd3ByckdL?=
 =?utf-8?B?QlZOS0VIMWg4WVY0eVpXdjNROVY5RmVIQXNSRmpraDJGU3BvYmpWdDFwcWVq?=
 =?utf-8?B?R0NCYlZzeEw3aGE5Z3VYRDMzemlhY1NnMzZXZFFUUTJOclZkMzRFQk1YWS9p?=
 =?utf-8?B?UVBkWHhDMHpFK0RXa3pROEhaSGthelBQWWlhbXRuSGRBYm9yVEh4alNXUTlj?=
 =?utf-8?B?akZoWnBZSk9lSWtlMW94QmlEOGYyWkk0RnRkMjB5SmNPL0Nsd2RabW1Fa3ZN?=
 =?utf-8?B?YjJyWE1PWXM2UCtSK1VNWnVoaElzSWUzQktDakNFSkw0NWNxWEg1R1MvM2Yv?=
 =?utf-8?B?QUxPTWh4VkxKb1U4SDBNTy9UY1JPcERWaVNjSHR1ODMrS3JXaXk4VFdQT0di?=
 =?utf-8?B?UmtlQ1ZsWmltSW95Z1JnTERYdWpEb0lBMmVDd1dRNk5GeEt2ZkxNOERLRTdK?=
 =?utf-8?Q?2eGexNWe+0MVm9yLmmDAoMnrSSo4Ch5M9g1nkODpAc=3D?=
X-Forefront-Antispam-Report: 
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 08:17:59.4383
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bdabd890-8b7d-4746-17de-08de5e45bfb6
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	CH2PEPF00000145.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6265
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 28 Jan 2026 08:18:11 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21733


On 27/01/26 16:35, Pavel Machek wrote:
> Hi!
>
> Patch looks good, even if I'd like less code duplication.
>
> But patch can't be applied as is: it is missing "upstream commit xxx"
> marking at [1] and your sign-off at [2].
>
> Plus, -stable might be better place for this patch. We currently don't
> have am62p specific patches in the tree, so this affects 6.12-stable,
> too, and should be fixed there AFAICT.

Thanks for the feedback. Posted on stable tree.
https://lore.kernel.org/all/20260127191105.1961020-1-s-adivi@ti.com/

- Kartheek

>
> Best regards,
> 								Pavel
>
>> From: Siddharth Vadapalli <s-vadapalli@ti.com>
> [1]
>
>> The SoC DMA resources for UDMA, BCDMA and PKTDMA can be described via a
>> combination of up to two resource ranges. The first resource range handles
>> the default partitioning wherein all resources belonging to that range are
>> allocated to a single entity and form a continuous range. For use-cases
>> where the resources are shared across multiple entities and require to be
>> described via discontinuous ranges, a second resource range is required.
>>
>> Currently, udma_setup_resources() supports handling resources that belong
>> to the second range. Extend bcdma_setup_resources() and
>> pktdma_setup_resources() to support the same.
>>
>> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
>> Acked-by: Peter Ujfalusi <peter.ujfalusi@gmail.com>
>> Link: https://lore.kernel.org/r/20250205121805.316792-1-s-vadapalli@ti.com
>> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> [2]
>
>> ---
>>
>> Hi,
>>
>> This patch is upstreamed at [1]. This is required for ethernet to be
>> functional on TI AM62P SoC.
>>
>> Thanks,
>> Kartheek
>>
>> [1] v6.14-rc1-24-g566beb347ede
>> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/drivers/dma/ti/k3-udma.c?id=566beb347eded7a860511164a7a163bc882dc4d0
>>
>>   drivers/dma/ti/k3-udma.c | 36 ++++++++++++++++++++++++++++++++++++
>>   1 file changed, 36 insertions(+)
>>
>> diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
>> index 38b54719587c..e877cd50898b 100644
>> --- a/drivers/dma/ti/k3-udma.c
>> +++ b/drivers/dma/ti/k3-udma.c
>> @@ -4876,6 +4876,12 @@ static int bcdma_setup_resources(struct udma_dev *ud)
>>   				irq_res.desc[i].start = rm_res->desc[i].start +
>>   							oes->bcdma_bchan_ring;
>>   				irq_res.desc[i].num = rm_res->desc[i].num;
>> +
>> +				if (rm_res->desc[i].num_sec) {
>> +					irq_res.desc[i].start_sec = rm_res->desc[i].start_sec +
>> +									oes->bcdma_bchan_ring;
>> +					irq_res.desc[i].num_sec = rm_res->desc[i].num_sec;
>> +				}
>>   			}
>>   		}
>>   	} else {
>> @@ -4899,6 +4905,15 @@ static int bcdma_setup_resources(struct udma_dev *ud)
>>   				irq_res.desc[i + 1].start = rm_res->desc[j].start +
>>   							oes->bcdma_tchan_ring;
>>   				irq_res.desc[i + 1].num = rm_res->desc[j].num;
>> +
>> +				if (rm_res->desc[j].num_sec) {
>> +					irq_res.desc[i].start_sec = rm_res->desc[j].start_sec +
>> +									oes->bcdma_tchan_data;
>> +					irq_res.desc[i].num_sec = rm_res->desc[j].num_sec;
>> +					irq_res.desc[i + 1].start_sec = rm_res->desc[j].start_sec +
>> +									oes->bcdma_tchan_ring;
>> +					irq_res.desc[i + 1].num_sec = rm_res->desc[j].num_sec;
>> +				}
>>   			}
>>   		}
>>   	}
>> @@ -4919,6 +4934,15 @@ static int bcdma_setup_resources(struct udma_dev *ud)
>>   				irq_res.desc[i + 1].start = rm_res->desc[j].start +
>>   							oes->bcdma_rchan_ring;
>>   				irq_res.desc[i + 1].num = rm_res->desc[j].num;
>> +
>> +				if (rm_res->desc[j].num_sec) {
>> +					irq_res.desc[i].start_sec = rm_res->desc[j].start_sec +
>> +									oes->bcdma_rchan_data;
>> +					irq_res.desc[i].num_sec = rm_res->desc[j].num_sec;
>> +					irq_res.desc[i + 1].start_sec = rm_res->desc[j].start_sec +
>> +									oes->bcdma_rchan_ring;
>> +					irq_res.desc[i + 1].num_sec = rm_res->desc[j].num_sec;
>> +				}
>>   			}
>>   		}
>>   	}
>> @@ -5053,6 +5077,12 @@ static int pktdma_setup_resources(struct udma_dev *ud)
>>   			irq_res.desc[i].start = rm_res->desc[i].start +
>>   						oes->pktdma_tchan_flow;
>>   			irq_res.desc[i].num = rm_res->desc[i].num;
>> +
>> +			if (rm_res->desc[i].num_sec) {
>> +				irq_res.desc[i].start_sec = rm_res->desc[i].start_sec +
>> +								oes->pktdma_tchan_flow;
>> +				irq_res.desc[i].num_sec = rm_res->desc[i].num_sec;
>> +			}
>>   		}
>>   	}
>>   	rm_res = tisci_rm->rm_ranges[RM_RANGE_RFLOW];
>> @@ -5064,6 +5094,12 @@ static int pktdma_setup_resources(struct udma_dev *ud)
>>   			irq_res.desc[i].start = rm_res->desc[j].start +
>>   						oes->pktdma_rchan_flow;
>>   			irq_res.desc[i].num = rm_res->desc[j].num;
>> +
>> +			if (rm_res->desc[j].num_sec) {
>> +				irq_res.desc[i].start_sec = rm_res->desc[j].start_sec +
>> +								oes->pktdma_rchan_flow;
>> +				irq_res.desc[i].num_sec = rm_res->desc[j].num_sec;
>> +			}
>>   		}
>>   	}
>>   	ret = ti_sci_inta_msi_domain_alloc_irqs(ud->dev, &irq_res);

