Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84402C83F12
	for <webhook@archiver.kernel.org>; Mon, 28 Aug 2023 06:57:37 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.75])
 by mx.groups.io with SMTP id smtpd.web10.8364.1693205848354462597
 for <cip-dev@lists.cip-project.org>;
 Sun, 27 Aug 2023 23:57:29 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=Qoj7ehUQ;
 spf=pass (domain: siemens.com, ip: 40.107.20.75, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EtWGGb5qikhOVsehqI3D9bv3YTEzpCZraOnR5UKz3a1Nnux5CcZPsoMKZk5EpLXteSnx+3YxTlDSTUhRQmTuZxIXpB+wl4UcHw6mUivoDJSK7QKCWCIPR8bHwyw6N9x4FD+Zw7YanJHyfsHkdoVJzhmduYz/HCdBboJP5Trt8TSPg+GWz2vSfu4BxJxcQ3/FpB5COWhRI4G1SeVOdD8DrBoKO2jmUu6TGHhVf7HwAfsXTbdnnt+kF8nwG2DcgKLhafKWvY80Rt1PXeLtRV6HWzKXNjEEEWVwfESLPG2Nk8x/w1s8o8kiF7hhTtlHUbqJ99BTlMND+AG0VXD88GAOyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Babkk3eBJDMs4UINjse3eevdcN3u3zo/1X+7rg1E91M=;
 b=Lc2OTGNN8ayFciOQIWebey+rSiBmOP2it+/iLjNZLmJuD+zlItU6qAoQd8FEC4rX4apdIihy1J6NeMM/H76Dnd9JBMSKMWZF1/J7+le3j2PaRv9eoBwXulRO5sKkHJmLw3+e7K3akEloFDX924ujTrGA0TPF+FtVqfzOZYNvY/6SJGa75bVA6OVupT/KP5MJfhpFq78z2n1XpI2ZBo7SmCGqOH5Suw7yvb9NMtRJXqQbRDncwnxFe1tFSOSZIV18EGowlhVWMkLG127+rLPUhvTLLdNKK3k+QDcve7FJofAB/N6FblphL+mB/3Sx2h05c1j3/uVBKJ7rMmVpx89Liw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Babkk3eBJDMs4UINjse3eevdcN3u3zo/1X+7rg1E91M=;
 b=Qoj7ehUQVKL+MWQXeKlMen1HfXJl2KfMA+NvzpBexWRQj1kU54/PA7JjzRXpdtlOPTa8Z1M2TOjsjCtt5fc+GlMv19FVPrd6oP1AX3DSyQueaCL1gQ/kQkN0JMVcoMJVSrPZyGU7J5EIh6SOp6KKQ285wA0eYLXcfltCUKBQIcSowJPi/ZVT6Y5wv+nAJH8VU8tI9m5gISle78kKrRTN9k54/d7HEfqcqcYVKtZ05iIuU0rtzmn22vSc3umo3GFGGd6rvIXHBZlAhZ9ybe3HmWTMNc1RgjOyuAeTYMWuzyrirN3UCikM67lr78751E7dv+qFl2YFh3PQTIyWNCCGIg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB5750.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:313::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Mon, 28 Aug
 2023 06:57:25 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2%3]) with mapi id 15.20.6699.034; Mon, 28 Aug 2023
 06:57:25 +0000
Message-ID: <4a398064-9dd2-49b3-8b7f-8969ee381134@siemens.com>
Date: Mon, 28 Aug 2023 08:57:22 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core v2 0/2] Fix reproducible issues due to
Content-Language: en-US
To: venkata.pyla@toshiba-tsip.com, cip-dev@lists.cip-project.org
Cc: dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
References: <177DF6549CC2A4D6.6662@lists.cip-project.org>
 <20230824104119.5464-1-venkata.pyla@toshiba-tsip.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230824104119.5464-1-venkata.pyla@toshiba-tsip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0134.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:97::18) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB5750:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ea07136-b29f-44b2-a56f-08dba7940922
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	/OwqsMpJV+rKU5ZwahLCiSP87Ev9R2sbBwzl9xEMBuNtl44ktihAxbZdmXgEhQyCAeNHa+uQ0I/C29bKQkCm+FHpgJFb4jKKndbnHbbSf+EkLHGy5M4irwEHK+EyFwfrMWgcrojj1hmmE1vhheDWKo+ZSm9VqWkFAT1F6JeEo9WhNed50pCU1g2uBdBB3BFbpc+Hcgh2lo4Be9qdt3kUWflSf1fcDqKpFaKOtDUcAHsUFoknjvKgDTQcd6cy40YN2FysDcHsaPW2+OQn/xtmtwVOVIMyjDHc/r8zQCfIHNLce6OzeW5lo3lceEpEvo+jLY6HS3YWK9OTWj2i5lUxjI5fmI9t154ULFrQPy3TmAb1fvLG8upGyBQlFs84j1oUJex3k/Tul1Patb/bzTmhcyi2Zfh8nf7GeMKqEnPynBfMHgbO49j6GV9kqWyYBuwJaRVl/WKbLwaM1vwP+baB/dBWT6XWIPRQHLhE0S/wgBH4QLfJBW4xrRxb7C0jUyYRsIpgqlN7437t2zWuTeduBl6DP9nZYgAEJP+WT2ytqkp7Do3+df5c5wodyBtp3rPlsjoUJCZdxElnn3MY7aXd3pCCiW3SqRxwjfdXBeGcgGQ6lR4SnMljQJMxuZAANK6P858JThm+vsnHS/AxDcT4zw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(346002)(39860400002)(396003)(366004)(186009)(1800799009)(451199024)(5660300002)(6506007)(6486002)(6666004)(478600001)(53546011)(83380400001)(2906002)(26005)(66556008)(6512007)(44832011)(4326008)(41300700001)(316002)(66946007)(8676002)(66476007)(8936002)(36756003)(2616005)(82960400001)(38100700002)(31696002)(86362001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?UUdSMFpGK2Y3SldYODRDTWJtMjZnUGQ2TVdyK0pvc3dOY3RSenkyeklkbEFK?=
 =?utf-8?B?K0tRTmNueGRmSUNLK3l3WWp2aGR0QUhma0RucFR4TExVNm8rbGxzUDdvcXBW?=
 =?utf-8?B?ZHZ5NXBWZE1VbXMrcjFLUEhkeUNXZEtGdVE2R2Mzcm5xYnNrOUg5Vk83aUhI?=
 =?utf-8?B?b2RkVEt5TVpLMWV2Y3RTQyt1M2g1Vk9nZFEwVExUdkNXaEgzVzJyTDVUSHBN?=
 =?utf-8?B?Mld4dG5RTTU3RlZ1dG1VY21jdURMTDE0ZjVoZm5XRVhWUUwyOUh6K3gvOE50?=
 =?utf-8?B?YUE2SjdubmIrMWZKUEJZWFRPS0ZETW4yOXdwVzZFZWJwWVpPRXJCK2JqenhM?=
 =?utf-8?B?M0pUOFJoc1hQRzNOcTZKNnZJbkhvVkZGL2FXNU1UUU9JWnV4eWpNVFlxV0g0?=
 =?utf-8?B?TEdrWlFPNVF4N3ZNV2lGVzE2NGwrRzdqemV1YTFVaCtvQ1IvMnJYQ3dmZjl6?=
 =?utf-8?B?QWVjZjRrSkZVamk1VkhnUWhQaVJVUnVNeDhpNUlkakt3bE4vSTZVd0VtYmxq?=
 =?utf-8?B?VmwycWxyYnE5cjRpU2JmaENLbVNwOWRBUXdPS1h4bXIyd2RDUm1TbUpBOHpZ?=
 =?utf-8?B?VmlGL2d4U00rZHJ2ZXhFZDFRdVVnc3FZWmthQnZRZ1NvZk9VTFZPbTFnRUp3?=
 =?utf-8?B?V2RmaU1iZEpSd1VjOC9WNzRtb1lhdmwxZFdFWlNWU0RhKzZmZC8xNTRmMDhk?=
 =?utf-8?B?WlZVWDNvTFdEQXRHK2VRbVVoUWdmek4zeTN3RlcrWVhpU3p1cDRCM0x5cnB3?=
 =?utf-8?B?clJXdDR0MGdKV0doeHNZTU5HR1hLZTFXZXcyMWV6NDVsdWx3dTZXZE9DL055?=
 =?utf-8?B?bTBOdGZBam1NM1cyc2pkczJhVHRmbjJML3hwa2o3WFlPeWJra0pWdURobmhk?=
 =?utf-8?B?OFVaOFlyMC8yTlhtamVtb1o3b2M5TjJGLzhNTE9lZEN3NGZDYk94YUNsTWw3?=
 =?utf-8?B?WUlNR2JBMnJnQndmSnJhVjQ0cVA0dHZOZy9kSzN1d3drNHNQSGV2WGJYSXpv?=
 =?utf-8?B?eFBxMkxxVUFKRXJibkhreXhwbjFUVTlEMWtXNXNUNGg1MXZFcGtNZzJJNGxa?=
 =?utf-8?B?cmovY0twaFpadzBpYXJIaFdnQTdJWnFyRFRYV05odXdHb3AzVUcrOE9QSEdi?=
 =?utf-8?B?MmJaeXpvOGI3RVFUdXlXMGRlUG56VlNpbW9oenFVUWZvaDRvU2RHeUZaODl4?=
 =?utf-8?B?dGx5QS9DS2UzSFFoUXg4RmUvMk9nY1lzcnV0RzEwSG1XTkVjaHpOdjdnakxN?=
 =?utf-8?B?U1JKRGNNeS8yb2ZNY0dHL0tmaHM4ZDNLQjJKV2w4TmZKcGVjazE0elNzVHNK?=
 =?utf-8?B?bHJ2ejVxQjlVRXJGdTVvZEtBK0ZmT0xseVZxNGtOZUFVYjNxZStzcVVRcUZH?=
 =?utf-8?B?QVlkRVRNU1R0NDJhUnNocVVvWnJ3MU15UHNmOHhhK1dUMkQwTDJwTS9UdmFY?=
 =?utf-8?B?R3F5SDZ1cEN6SlZUajFHYytDZEJvakJiL284T0dqbDFKZ1NuOUFZa0tONjkw?=
 =?utf-8?B?WlRNZGRvTzhWL0NOZFdKY3RTWFFaVStaeHNqUlVuQVVONzR1emNlQ2RzeFZY?=
 =?utf-8?B?NTIwZldVbllDdTJGWFlQZm9Tc1RlL1FKbVJIaVNoWEU1VHROZFZRREI0N1pr?=
 =?utf-8?B?cGM1ZWJqamJuR2lIeUU2RTl3Sk9xWFRiOFYrdG9za252OFk2K3hnU0Nyamhq?=
 =?utf-8?B?a2xtRUdackVTbzVIenIydlRvNkNHRDRJM29ON2lQWVJ1UGJlYXpuSHU3OEZ6?=
 =?utf-8?B?ejBWWis0U0NoUTZjeUd0R1hzdUllTVFHSjNkVU5hUXhQSXJPdnJ5RWhuOGNw?=
 =?utf-8?B?TzJRR3JLVHdZdk82bVdjOGRxL0hERC91d0lET3JpNHZRNHpFV2ZqdHFwei9J?=
 =?utf-8?B?enl6RnV0UEZUenhidHRRMnlPbmZmaWQ4RFgwbkpNak40bjZKbDRhMjZJd3lQ?=
 =?utf-8?B?RjUySFBERFM2ZVRjUXR3RTA0VW9DTzZHWTE1K2pvUzgwMm81NzVEaUlWaVFs?=
 =?utf-8?B?VllZQnRVM0p4STRYR0lVKzBWbVdUUEpseWpRUE5kU1AwSFdIWFRDSjQxVTla?=
 =?utf-8?B?clV5aTdtR1lMUGZINVozVnV6MkJuaUQvVm1qOFhRT0pOaEIycDNXcUJrUzhH?=
 =?utf-8?Q?4hYbjEI0EowFmFlAccqwTSyRb?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ea07136-b29f-44b2-a56f-08dba7940922
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2023 06:57:25.4733
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O/VPGDOtIMFEef6UfbJzcOaWrcmZsGKauDfMXRQuthBl9sKmaDAX2VuqQcuaQ9dFSiNNRYoYgqJkNEObnX2t3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5750
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 28 Aug 2023 06:57:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12878

On 24.08.23 12:41, venkata.pyla@toshiba-tsip.com wrote:
> From: venkata pyla <venkata.pyla@toshiba-tsip.com>
> 
> Hi,
> 
> This series patch fixes the reproducible issues due to filesystem UUID's
> are not constant.
> 
> Change from v2:
>  - Remove "--invariant" option and instead pass the filesystem UUID to
>    the mkdosfs.
>  - Fix filesystem UUID's for the home and var partitions.
> 
> venkata pyla (2):
>   ebg-sysparts: Add filesystem UUID's to fat images
>   qemu*.wks.in: Add filessystem UUID for reproducible builds
> 
>  scripts/lib/wic/plugins/source/efibootguard-boot.py | 4 ++--
>  scripts/lib/wic/plugins/source/efibootguard-efi.py  | 4 ++--
>  wic/ebg-sysparts.inc                                | 6 +++---
>  wic/qemu-amd64-efibootguard-secureboot.wks.in       | 4 ++--
>  wic/qemu-arm64-efibootguard-secureboot.wks.in       | 4 ++--
>  wic/qemu-arm64-efibootguard.wks.in                  | 4 ++--
>  wic/x86-efibootguard.wks.in                         | 4 ++--
>  7 files changed, 15 insertions(+), 15 deletions(-)
> 

Thanks, both applied. I just dropped unneeded quotes from the wks files
and added some missing fsuuid assignments (bbb, hihope-rzg2m, qemu-riscv).

Jan

-- 
Siemens AG, Technology
Linux Expert Center


