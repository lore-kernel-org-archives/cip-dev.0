Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09848C87FCB
	for <webhook@archiver.kernel.org>; Tue,  5 Aug 2025 10:16:25 +0000 (UTC)
Received: from MRWPR03CU001.outbound.protection.outlook.com (MRWPR03CU001.outbound.protection.outlook.com [40.107.130.65])
 by mx.groups.io with SMTP id smtpd.web11.18175.1754388979539956518
 for <cip-dev@lists.cip-project.org>;
 Tue, 05 Aug 2025 03:16:20 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=d26Ba20+;
 spf=pass (domain: siemens.com, ip: 40.107.130.65, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uYyq7Pb03F8xkoUSYyjlXCGVhloYgfpwL1664TLa7gVQzQY1JryA0AnYb/rEp2tv511R5oWXmRmtgCfehH8h76FbXkasmurefIhYdEDexXsJYe36cUVNBanMPL6laGtw2BVs2RwruYyHy+PJdzcfuw2j9D/V+5MZSqT9AwwcHORd5YGBCnD6YmugylenISmBqo2j52cIv2b2LqQBtNYm/uHi7RmPQTP38JFqsf5V0spKxOUdIEvqfWwBw8cECYTesPhEbaXtR1/vIj3DJDaOhe03Tt8iC+YXfijA9ZS/zeXH27HkNLfeG0QwOO9G6u5d+xGs2oyhfifOS2dtR27EmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a0eF7d5nvGTjtuvLlwB+vBO95bSZUuIS+P1htbRHq5k=;
 b=lUJsZXChIY8rb0WczOCFSgReKVJXKsy4a3IcE4470vsA0tLJ0YDXz6fp2psJAwL8taXJ4tVK92xcrCuCjQly3OkbdZ2M+eJ5yvnz3R1w7nfPCgFj6oiRC2tlA8OPTZT9oY7MMinsr/NlOCXeBgv6BWcFaSVuj2nJqQi9SdQDA6yTj0rQWz15kzd8I4YOI2oxa76k9vBjnUlLfIN/chHVp63nI+bmPWG3o9d+hQ8KdzWSZ/TDsboOxCGzibU0pGY2gh7PXwzLZaA7APTJvIo5Gqydncc1GA7alYnq61YbBR7jdOYYNl3AQrGpkE/dtyajvGsAjGQZ6pnnXtb0tJnVBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a0eF7d5nvGTjtuvLlwB+vBO95bSZUuIS+P1htbRHq5k=;
 b=d26Ba20+nwJUwKlt8bed+vRZGsqwhiSg54XVv/k1AoS8I7OHr4nV/5KZURZPaS+BkX1pH8jbWgxfwrnE56vh9kslqmfWB3Lv05/rnx9AnnJySAXBhsOxQACDpAJ4mvf2YKiFaFYG3h3wTNLICnM59rsdS2ilUVAQplHA+i75qAB+ySqMSkrhqXWEVso0qsPr8IMAsUh6ehKyvyt20p15Sdp+m99ffdwqYY9Xia9Jln1kbTPM7XUNUKKHhyBmg2dSNrdLxb96nycr6wgxP21l6yhqtqzuXpE5dLOKiTcwEA3ka8qJKs2Nwu6l43DRwX9HA+y4k+z5RWNkUg2W7m/b9Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DBAPR10MB4076.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:1b5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.18; Tue, 5 Aug
 2025 10:16:15 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.8989.018; Tue, 5 Aug 2025
 10:16:15 +0000
Message-ID: <9de6a768-68af-40b4-b0e7-bdd07b1b8eb9@siemens.com>
Date: Tue, 5 Aug 2025 12:16:11 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH 1/4] Add support for TI AM62Px SK
 platform
To: Sai Sree Kartheek Adivi <s-adivi@ti.com>, cip-dev@lists.cip-project.org,
 vigneshr@ti.com
References: <20250722101551.1727649-1-s-adivi@ti.com>
 <20250722101551.1727649-2-s-adivi@ti.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20250722101551.1727649-2-s-adivi@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0444.namprd03.prod.outlook.com
 (2603:10b6:610:10e::12) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DBAPR10MB4076:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fbc3d01-a53c-4d4a-7719-08ddd4091c51
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|376014|1800799024|7053199007|13003099007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?N3M1bTdPKzN2NW5RMEowRXhMREZRUHIxQUU5eStXQ2x3aDhZMG45YmVuMHhy?=
 =?utf-8?B?ak1OMUlWdXpZUzJLMUpVK2RRNjFhbWRXZnRyWUJwNTNiSDgzZGNhcTQyWjFp?=
 =?utf-8?B?L0xkSGJoQ3RBZExBY3NPYlpzS3ZiazlWeTR6VG0yNDBWNEdVQjMyaGFSK0ZY?=
 =?utf-8?B?TFVJUllyNjhwNVlRUjVZNWs3aEFZL20xa1hsSy9qeU1TcmczMGdLZ3ZkbUh3?=
 =?utf-8?B?T3hNNytNOStXQkhFL2xOeC9ydUJ5K0NMemg1aGdVTzhsQ21DSldPVndrRnJ3?=
 =?utf-8?B?cUFVc1dyd2Nhd3czRzNrUGRCMExUdHJ3S0E2MWdJbEJBcGtTNlR6dDdrWTdI?=
 =?utf-8?B?ODdSNzJhakdpbE1xL3hPejN4dXNpeE5aazZ4TVVOcnZsY2d2U3F0YThyMEQv?=
 =?utf-8?B?dmY0V2d2bVEyeERUWXcwN1E0Z2RLajNxTUR6aTVxWkxZdHM4WEdNSTUzdCtH?=
 =?utf-8?B?UVhRL2FYL0o5dkdSSklvR2dNdFlsWHJlTlhYdE9rZVpqODhENHM3YWhEYjF4?=
 =?utf-8?B?T2RScllFbVZMalB6ckhUTHhIYmltcWJGcFNvRmQ5MCtpVUZOaEx4SzdZNzVK?=
 =?utf-8?B?NStXNDhCVEdkSWQ0MU5adm1QZVU1RkE3YWFhcm1vZ2VCcndwdEh3czNLd3pj?=
 =?utf-8?B?Q3NSTDVCR3pHWE96ZDFHbllMRy9oVXQ3T1VoVk8weHQ1NzEzKzVIQTNOS1Bn?=
 =?utf-8?B?VEljYXNjeTBiS0dhM1FvZTdCNHdBL3VWMlRBVUo0VmpQeVgyZmVLNjZkby9H?=
 =?utf-8?B?Y2ViZFZhUW1taWQrOUVCYXZ4SWMrbExSWS9CRVhBbFdCQkU5a3F5RUVXdmkw?=
 =?utf-8?B?bjI4bW4yV3N5YUprYy9lUG1EcSszV3VJNkl4R2Uyc0hjMHp6WWVQU0tEQUVT?=
 =?utf-8?B?MHBXaFc5c1g5VUprYWV6bzVuQVl4QWJtZi9vUllnSm1STEo2YzhNOXh6WEI5?=
 =?utf-8?B?ZFFmNDBvcXUwVFlSMmEzU0h0MWdJMVI0RHg0Q09yRnhMREpNck5USTc1Q2JO?=
 =?utf-8?B?UmMveDNLWURLUWlMdGRzcTF5Y2Vqdm81TEVvaTI5QnF0SGxyaHUrM2JKai8w?=
 =?utf-8?B?NjlpbHRPWVEzcm1jYWtIWmVnYTg5RnNjZ0EvcVQ1TmEzVHBpelhLSEE0SCtn?=
 =?utf-8?B?cGJwUzlCcWdGc2k0Mk4rVUYxemZpN1hwOUFIVFFIOWxrYkUzT29sSUZQbFJF?=
 =?utf-8?B?d0JEU3k2cHBrWDIyQUo2Z2U0R3hHMHZTaExDeFFLTXNlOFNrc3l1T3RLV01u?=
 =?utf-8?B?Qk5oUXR1dUIyUDUvSTlmaFJIU08xeENaTEZPVmlIN0NzWkVONkZld0xSbGww?=
 =?utf-8?B?a0QwZ0ZCSW4xdkttR3Rqb3FxYWdSUHp0WmN0cEV4ZVNqeGcvR21YdEY3MmQw?=
 =?utf-8?B?bHNoVmZTTC9GQ1BQZE11aFhhc1VWMlk3UmFyOGN3bllpTDNneGxQclRFUVBS?=
 =?utf-8?B?UW5LcXRkWExYbHB4V0FxUHgvVG5LNE8wdVlia2hIdGFieTdkZ2xCOEd6WWxU?=
 =?utf-8?B?L21XQkxCMDJnMStUcG1nNWY3SStkdHVRekZXVHM5Qk1pOHdXQXdxVVdWMk10?=
 =?utf-8?B?WnR2RkpVOENYNmdUUUJlL0ZsWGJxdVFKTFY5YVFxVGIrQTRPNDBMemhzeDBu?=
 =?utf-8?B?VFBSMjZzREZzWHVvN2JzQXpZZk1VRmtVbDFaVHo0aDByZ29iYVJYRzBrZ05O?=
 =?utf-8?B?a2hxZ2tOQlJDT0dFYTZlaXZJVFJNeDcxa1RCM1crUWpNd1ZSVlhhcTEwL0JU?=
 =?utf-8?B?RmJ4cUxJdFFteTFKbFY5UUswMkVrWUdZK2tZeEtGWTRVVnhjYmxvRzFKeTFW?=
 =?utf-8?B?SmUyaExLVmd5ejFpTjZZa2R0YjF2NjMrRXBkMFg1MlBIUXZqcGI3RFRXZEZK?=
 =?utf-8?Q?1t9dksU0I9a0f?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?em15bEdmaUlFTGJZWDV1dFo5cmQrS2FDUEFaSUk5eEJRR0hISjlDekE5MzFo?=
 =?utf-8?B?U3BnKzFmbk1HZ3ZlcmVVQXBXamJMN1o2THZBeTVvNEVST3VOdW53T2FVc3Yr?=
 =?utf-8?B?VVNyUmoxTW1XcVNVaTJPUHBaUE9MdFpqd2dvS0ZoNFhHakhCZnQ0WWxPamhz?=
 =?utf-8?B?elFEcElER2tNVXJQOGljeTNMSWZEWTJHVWZwS2c0VVR1UVdZSEZGK01yMktn?=
 =?utf-8?B?dHFTOTBQL0t4cHB0T3FMUTJrcmM5ZHNLTDJnZ0VQSS9xREdpSi9jU1RWYkQz?=
 =?utf-8?B?bnFtQkN1YzJrQUEwYmMzL2cwdld5Wmh2Z0FsV0FPeVBLcVlTL0YzdXJwcjht?=
 =?utf-8?B?aUlPTU1wd0N4bEZBN3ZyaUVpM2NIV1JmWmcvS29SSU9zZXM1ZDNVL0dQYjdp?=
 =?utf-8?B?WnpOOUJmcnlQLzZyQUN5ZDNKUFpHR0NST1RDVFZ0alhZN1FJSlFNZ1lCL3Y2?=
 =?utf-8?B?cHpOZGdPRTdQamZSSmJOeWtzaWVQa2tuT3dJdTRDa0ZyenY1WnBmN3Qxb2Mr?=
 =?utf-8?B?cWRFYk1FZGYvWU9SRTBjUGRMYkYwWXhQOElleUZKOHlQeXVTQU9rZDB1K2xO?=
 =?utf-8?B?SHBCV1VDNGJpVFJQYlNSNjI3eU5QbHJ3KzM1RVhOK1plN1Vha0FQT3NoRFdF?=
 =?utf-8?B?UmRFMkhIelZzYUd4eXhSOFVTejNpN1VOTW03MnBPRDA4NnlzRGxmbmxlVlpk?=
 =?utf-8?B?SDFHcFlVMWg4eWY1ZmFkblNaUjFTb1hpQWxxNW9vQzJlNzYrc3JMd2dRMDdh?=
 =?utf-8?B?Ly9SNTRXWXBPdUVxU2tiVGRMSnlJdTI4c3Njc1prQklnNlZ0dHRwUTdTaGRi?=
 =?utf-8?B?dzk3NFo2dXhpeUFPMlozRGFnbHg0WEZCbjUybGowbnBRNjVacmNJZTdyZ0oy?=
 =?utf-8?B?c2h2akV2aFdtNkpuTC9WWjBYWGhOejUrRi9wWWZkWkQ2aTFOQjZxTmVoQzlS?=
 =?utf-8?B?NWtGMVdmNGxnUk1EUkNCZ0kwcW1JNzNyYW1XR0VsbkIvMHpVSy9maktidkFa?=
 =?utf-8?B?WnpKd0R6YzdtTk5UYWE0dGplWXpXRnhQQVZoMCtiNzZuc2ViMW5pQnBKeUo4?=
 =?utf-8?B?WVRLRFRkdXF2VDBYRVRXY293Y3JCL1Q3WFN0ZzFLaE5JODhTVFg4RlI2OG5y?=
 =?utf-8?B?SmY5cnlvZXNDaFdubGtNTit2TlB4SGpMRTdLYmN1MEdmRSttWHJReUxSTGtq?=
 =?utf-8?B?TUdhVm01b0lXNzdmYUJ0NVFsYlE4VVI5bjVGR2JNeVQ1OHJhOW9yYVB6aC9D?=
 =?utf-8?B?Nk9nMHpMaWNSVlBwbDArZnQ0RGxnb3dMVlJqc2JydWdTUEpuNzFRd1pIbDFG?=
 =?utf-8?B?TGptOVdnL0ZwOXJ2WHUvMFJSdzRRbVFLZXBsd0p1ZGhMK1J1Vlo4MnZzQ3hQ?=
 =?utf-8?B?Y0dOK0I0TXVTMjE0Smw2TExtTGZHQTd4Z2pQTkJXcC94OFZkbzF2OHhsaEtQ?=
 =?utf-8?B?dnJNcUFUcVNuTDZCeWU1dzRlNWt4Qm1wT3c4WmRkQXpwYlNjV2laWDZ6R2Nz?=
 =?utf-8?B?YzlNWFJ3ZjVucUFUQStnM0lCaFZvMkFNL2xyeXQxWGVHMEVRQ3hpSzkvczR5?=
 =?utf-8?B?TGU3cFQzQXM5ZzNRV0RqQ0FHeHU0U3B0Vk8yTldiYzFXQ3VEWE12RGp2eU10?=
 =?utf-8?B?UEcvNENUZjVsaDFReU9yaHBxNHhQT0pmY1I1VUhtVWJFOG80WDd3RFNZaDFo?=
 =?utf-8?B?NFFLeHpQSE5nRXY3R21QR09ia1UvMDVGM05UV0JBMmFuamFWR3BLQ2FiUTdX?=
 =?utf-8?B?ZlBUYWpoRG9vQWx3RGVRQ2NzZnpSaWcyK1lsL1VVWWF4WHIzZ093ck4vVGxF?=
 =?utf-8?B?cmNCbXBIT0htdndLV3crWFNoejZMd2o3UG85a0tBVlFIM2kreWM1MytlRjFs?=
 =?utf-8?B?TDBDTkFLVGpPS3M3UEF0aWlPdENzanVsanNpT3VZMVZXZjRBVkZBdnd2MzFi?=
 =?utf-8?B?U2RrS2x3a2JJV3ZLbEJoNlNuSjhlbU5OOWRzWGZFbXRoVVpZcVZmN1FOVjV4?=
 =?utf-8?B?d3B0UnM5ZThpY2VkSEsrTUl4MTZWOWdzN082VVJyM25zQkMvZFlmbnBtNENL?=
 =?utf-8?B?OWhYWmRHSHZFTFRZd3M4OWhxOHczaThQd3lOVjZyOGRQKzVHM0V4bm5lRnM5?=
 =?utf-8?B?YWY4OFpQUGFwTHJtTk9WN1U3WDlRaHhtNG9EakdOYW15ZjQ0YlpVMXp3Tmhn?=
 =?utf-8?B?WUE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fbc3d01-a53c-4d4a-7719-08ddd4091c51
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2025 10:16:15.3482
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: il5u9DPpqcnNYc9cBFOLrqd+Z7q/UgToZb3wDc35wmAAf8uBJwI2L++WmvkfYZeKG7IXbxm31J1C3G4qYVH9Tg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR10MB4076
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 05 Aug 2025 10:16:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19669

On 22.07.25 12:15, Sai Sree Kartheek Adivi wrote:
> - Add machine conf and and kas yml files for TI AM62Px SK
> - Add new u-boot 2025.01 recipe as support for AM62P is only available
>   from 2025.01
> - Add new recipes for trusted-firmware-a, optee-os
> - Add new initramfs hook to include TI kernel modules in initramfs image
> 
> Signed-off-by: Sai Sree Kartheek Adivi <s-adivi@ti.com>
> ---
>  Kconfig                                       |  5 ++
>  conf/machine/ti-am62px-sk.conf                | 32 +++++++++++++
>  kas/board/ti-am62px-sk.yml                    | 13 ++++++
>  recipes-bsp/optee-os/optee-os-ti-k3_4.6.0.bb  | 24 ++++++++++
>  .../trusted-firmware-a-ti-k3_2.13.bb          | 18 ++++++++
>  ...KASLR-OPTEE-RNG-support-for-K3-devic.patch | 31 +++++++++++++
>  recipes-bsp/u-boot/files/rules-ti-am62px-sk   | 33 +++++++++++++
>  recipes-bsp/u-boot/u-boot-common-2025.01.inc  | 33 +++++++++++++
>  .../u-boot/u-boot-ti-am62px-sk_2025.01.bb     | 46 +++++++++++++++++++
>  .../initramfs-ti-k3-kernel-modules-hook.bb    | 27 +++++++++++
>  wic/ti-am62px-sk.wks                          | 11 +++++
>  11 files changed, 273 insertions(+)
>  create mode 100644 conf/machine/ti-am62px-sk.conf
>  create mode 100644 kas/board/ti-am62px-sk.yml
>  create mode 100644 recipes-bsp/optee-os/optee-os-ti-k3_4.6.0.bb
>  create mode 100644 recipes-bsp/trusted-firmware-a/trusted-firmware-a-ti-k3_2.13.bb
>  create mode 100644 recipes-bsp/u-boot/files/0001-configs-KASLR-OPTEE-RNG-support-for-K3-devic.patch
>  create mode 100644 recipes-bsp/u-boot/files/rules-ti-am62px-sk
>  create mode 100644 recipes-bsp/u-boot/u-boot-common-2025.01.inc
>  create mode 100644 recipes-bsp/u-boot/u-boot-ti-am62px-sk_2025.01.bb
>  create mode 100644 recipes-initramfs/initramfs-ti-k3-kernel-modules-hook/initramfs-ti-k3-kernel-modules-hook.bb
>  create mode 100644 wic/ti-am62px-sk.wks
> 
> diff --git a/Kconfig b/Kconfig
> index e078892..1b7e428 100644
> --- a/Kconfig
> +++ b/Kconfig
> @@ -77,6 +77,10 @@ config TARGET_QEMU_RISCV64
>  	select ARCH_RISCV64
>  	select HAS_SWUPDATE if KERNEL_6_1 || KERNEL_6_12
>  
> +config TARGET_TI_AM62PX_SK
> +	bool "Texas Instruments AM62Px SK"
> +	select ARCH_ARM64

Same questions as for the ZCU102 target apply here as well: Please
encode your kernel and possibly also distro version requirements in Kconfig.

> +
>  endchoice
>  
>  config KAS_INCLUDE_BOARD
> @@ -89,6 +93,7 @@ config KAS_INCLUDE_BOARD
>  	default "kas/board/bbb.yml" if TARGET_BBB
>  	default "kas/board/iwg20m.yml" if TARGET_IWG20D
>  	default "kas/board/qemu-riscv64.yml" if TARGET_QEMU_RISCV64
> +	default "kas/board/ti-am62px-sk.yml" if TARGET_TI_AM62PX_SK
>  
>  comment "Kernel options"
>  
> diff --git a/conf/machine/ti-am62px-sk.conf b/conf/machine/ti-am62px-sk.conf
> new file mode 100644
> index 0000000..a520002
> --- /dev/null
> +++ b/conf/machine/ti-am62px-sk.conf
> @@ -0,0 +1,32 @@
> +#
> +# Copyright (c) Texas Instruments Incorporated, 2025
> +#
> +# Authors:
> +#  Sai Sree Kartheek Adivi <s-adivi@ti.com>
> +#
> +# SPDX-License-Identifier: MIT
> +#
> +
> +DISTRO_ARCH = "arm64"
> +DTB_FILES = "k3-am62p5-sk.dtb"
> +
> +IMAGE_FSTYPES ?= "wic"
> +WKS_FILE ?= "ti-am62px-sk.wks"
> +
> +IMAGER_INSTALL:wic += "${SYSTEMD_BOOTLOADER_INSTALL} u-boot-ti-am62px-sk"
> +IMAGER_BUILD_DEPS += "u-boot-ti-am62px-sk"
> +
> +IMAGE_INSTALL += "u-boot-script initramfs-ti-k3-kernel-modules-hook"
> +IMAGE_PREINSTALL += "firmware-ti-connectivity"
> +
> +IMAGE_BOOT_FILES = " \
> +    /usr/lib/u-boot/${MACHINE}/u-boot.img;u-boot.img \
> +    /usr/lib/u-boot/${MACHINE}/tispl.bin;tispl.bin \
> +    /usr/lib/u-boot/${MACHINE}/tiboot3-am62px-hs-fs-evm.bin;tiboot3.bin"
> +
> +USE_CIP_KERNEL_CONFIG = "1"
> +KERNEL_DEFCONFIG = "cip-kernel-config/${KERNEL_DEFCONFIG_VERSION}/arm64/ti_defconfig"
> +
> +WDOG_TIMEOUT = "0"
> +
> +PREFERRED_PROVIDER_u-boot-${MACHINE} = "u-boot-ti-am62px-sk"
> diff --git a/kas/board/ti-am62px-sk.yml b/kas/board/ti-am62px-sk.yml
> new file mode 100644
> index 0000000..53e08be
> --- /dev/null
> +++ b/kas/board/ti-am62px-sk.yml
> @@ -0,0 +1,13 @@
> +#
> +# Copyright (c) Texas Instruments Incorporated, 2025
> +#
> +# Authors:
> +#  Sai Sree Kartheek Adivi <s-adivi@ti.com>
> +#
> +# SPDX-License-Identifier: MIT
> +#
> +
> +header:
> +  version: 1

We rather want 14 here.

> +
> +machine: ti-am62px-sk
> diff --git a/recipes-bsp/optee-os/optee-os-ti-k3_4.6.0.bb b/recipes-bsp/optee-os/optee-os-ti-k3_4.6.0.bb

Intentionally not (yet) 4.7.0?

> new file mode 100644
> index 0000000..437b6fd
> --- /dev/null
> +++ b/recipes-bsp/optee-os/optee-os-ti-k3_4.6.0.bb
> @@ -0,0 +1,24 @@
> +#
> +# Copyright (c) Texas Instruments Incorporated, 2025
> +#
> +# SPDX-License-Identifier: MIT
> +
> +require recipes-bsp/optee-os/optee-os-custom.inc
> +
> +SRC_URI += "https://github.com/OP-TEE/optee_os/archive/${PV}.tar.gz;downloadfilename=optee_os-${PV}.tar.gz"
> +SRC_URI[sha256sum] = "0c947c6972bf50c483cb993af01041d4094b1e03711c7246cdde6ba2ffc351fe"
> +
> +S = "${WORKDIR}/optee_os-${PV}"
> +
> +DEBIAN_BUILD_DEPENDS += ", python3-cryptography:native"
> +
> +OPTEE_PLATFORM = "k3-am62x"
> +OPTEE_EXTRA_BUILDARGS = " \
> +    TEE_IMPL_VERSION=${PV} \
> +    CFG_ARM64_core=y \
> +    CFG_USER_TA_TARGETS=ta_arm64 \
> +    CFG_TEE_CORE_LOG_LEVEL=1"
> +
> +OPTEE_BINARIES = "tee-raw.bin"
> +
> +COMPATIBLE_MACHINE = "ti-am62px-sk"
> diff --git a/recipes-bsp/trusted-firmware-a/trusted-firmware-a-ti-k3_2.13.bb b/recipes-bsp/trusted-firmware-a/trusted-firmware-a-ti-k3_2.13.bb
> new file mode 100644
> index 0000000..eca70d8
> --- /dev/null
> +++ b/recipes-bsp/trusted-firmware-a/trusted-firmware-a-ti-k3_2.13.bb
> @@ -0,0 +1,18 @@
> +#
> +# Copyright (c) Texas Instruments Incorporated, 2025
> +#
> +# SPDX-License-Identifier: MIT
> +
> +require recipes-bsp/trusted-firmware-a/trusted-firmware-a-custom.inc
> +
> +SRC_URI += "https://github.com/ARM-software/arm-trusted-firmware/archive/v${PV}.tar.gz;downloadfilename=arm-trusted-firmware-${PV}.tar.gz"
> +SRC_URI[sha256sum] = "68333c8be57830e7430d7dd39064826729923d86d6bb7af38d713d4e9d15dcf9"
> +
> +S = "${WORKDIR}/arm-trusted-firmware-${PV}"
> +
> +TF_A_NAME = "ti-k3"
> +TF_A_PLATFORM = "k3"
> +TF_A_EXTRA_BUILDARGS = "CFG_ARM64=y TARGET_BOARD=lite SPD=opteed K3_PM_SYSTEM_SUSPEND=1"
> +TF_A_BINARIES = "lite/release/bl31.bin"
> +
> +COMPATIBLE_MACHINE = "ti-am62px-sk"
> diff --git a/recipes-bsp/u-boot/files/0001-configs-KASLR-OPTEE-RNG-support-for-K3-devic.patch b/recipes-bsp/u-boot/files/0001-configs-KASLR-OPTEE-RNG-support-for-K3-devic.patch
> new file mode 100644
> index 0000000..3b55aaf
> --- /dev/null
> +++ b/recipes-bsp/u-boot/files/0001-configs-KASLR-OPTEE-RNG-support-for-K3-devic.patch
> @@ -0,0 +1,31 @@
> +From 69a862c40c976a534ca79153c04d69ef3544ca57 Mon Sep 17 00:00:00 2001
> +From: Gokul Praveen <g-praveen@ti.com>
> +Date: Mon, 5 May 2025 15:32:53 +0530
> +Subject: [PATCH 1/1] configs: KASLR OPTEE RNG support for
> + K3 devices
> +
> +Add KASLR OPTEE RNG support across K3 devices by enabling the required
> +configs.
> +


That's 7d4136397715d2c08161a32a873c052dd1bb8b6c in upstream, right?

> +Signed-off-by: Gokul Praveen <g-praveen@ti.com>
> +---
> + arch/arm/Kconfig | 3 +++
> + 1 file changed, 3 insertions(+)
> +
> +diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> +index 7282c4123b0..cd27e5a5422 100644
> +--- a/arch/arm/Kconfig
> ++++ b/arch/arm/Kconfig
> +@@ -805,6 +805,9 @@ config ARCH_K3
> + 	select REGEX
> + 	select FIT_SIGNATURE if ARM64
> + 	imply TI_SECURE_DEVICE
> ++	imply DM_RNG
> ++	imply TEE
> ++	imply OPTEE
> + 
> + config ARCH_OMAP2PLUS
> + 	bool "TI OMAP2+"
> +-- 
> +2.34.1
> +
> diff --git a/recipes-bsp/u-boot/files/rules-ti-am62px-sk b/recipes-bsp/u-boot/files/rules-ti-am62px-sk
> new file mode 100644
> index 0000000..dc53b07
> --- /dev/null
> +++ b/recipes-bsp/u-boot/files/rules-ti-am62px-sk
> @@ -0,0 +1,33 @@
> +#!/usr/bin/make -f
> +#
> +# Debian rules for custom U-Boot build for ti-am62p-sk
> +#
> +# Copyright (c) Texas Instruments Incorporated, 2025
> +#
> +# SPDX-License-Identifier: MIT
> +
> +ifneq ($(DEB_BUILD_GNU_TYPE),$(DEB_HOST_GNU_TYPE))
> +export CROSS_COMPILE=$(DEB_HOST_GNU_TYPE)-
> +SET_CROSS_BUILD_TOOLS=CROSS_BUILD_TOOLS=y
> +endif
> +
> +override_dh_auto_build:
> +	$(MAKE) $(PARALLEL_MAKE) ARCH=arm am62px_evm_r5_defconfig
> +	$(MAKE) $(PARALLEL_MAKE) ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf-
> +
> +	$(MAKE) $(PARALLEL_MAKE) am62px_evm_a53_defconfig
> +	$(MAKE) $(PARALLEL_MAKE) BL31=/usr/lib/trusted-firmware-a/ti-k3/bl31.bin \
> +		TEE=/usr/lib/optee-os/ti-k3/tee-raw.bin
> +	$(MAKE) $(PARALLEL_MAKE) u-boot-initial-env
> +	$(MAKE) $(PARALLEL_MAKE) $(SET_CROSS_BUILD_TOOLS) NO_SDL=1 tools-only envtools
> +
> +override_dh_auto_install:
> +	mv tools/env/lib.a tools/env/libubootenv.a
> +
> +override_dh_auto_test:
> +
> +override_dh_strip:
> +	dh_strip -X libubootenv.a
> +
> +%:
> +	dh $@ --parallel
> diff --git a/recipes-bsp/u-boot/u-boot-common-2025.01.inc b/recipes-bsp/u-boot/u-boot-common-2025.01.inc
> new file mode 100644
> index 0000000..14bdef9
> --- /dev/null
> +++ b/recipes-bsp/u-boot/u-boot-common-2025.01.inc

Why not 2025.07?

> @@ -0,0 +1,33 @@
> +#
> +# Copyright (c) 2025 Texas Instruments Incorporated - http://www.ti.com
> +#
> +# SPDX-License-Identifier: MIT
> +
> +require recipes-bsp/u-boot/u-boot-custom.inc
> +
> +FILESPATH:append := ":${FILE_DIRNAME}/files"
> +
> +SRC_URI += " \
> +    https://ftp.denx.de/pub/u-boot/u-boot-${PV}.tar.bz2 \
> +    file://rules.tmpl;subdir=debian"
> +SRC_URI[sha256sum] = "cdef7d507c93f1bbd9f015ea9bc21fa074268481405501945abc6f854d5b686f"
> +
> +SRC_URI:append:secureboot = " \
> +    file://secure-boot.cfg"
> +
> +S = "${WORKDIR}/u-boot-${PV}"
> +
> +DEBIAN_BUILD_DEPENDS += ", libssl-dev:native, libssl-dev:${DISTRO_ARCH}, \
> +        libgnutls28-dev:native, libgnutls28-dev:${DISTRO_ARCH}, yamllint:native"
> +
> +DEBIAN_BUILD_DEPENDS:append:secureboot = ", \
> +    openssl, efivar, secure-boot-secrets, python3-openssl:native"
> +DEBIAN_BUILD_DEPENDS:append:secureboot:buster   = ", pesign"
> +DEBIAN_BUILD_DEPENDS:append:secureboot:bullseye = ", pesign"
> +DEBIAN_BUILD_DEPENDS:append:secureboot:bookworm = ", pesign"
> +DEPENDS:append:secureboot = " secure-boot-secrets"
> +
> +do_prepare_build:append:secureboot() {
> +    sed -ni '/### Secure boot config/q;p' ${S}/configs/${U_BOOT_CONFIG}
> +    cat ${WORKDIR}/secure-boot.cfg >> ${S}/configs/${U_BOOT_CONFIG}
> +}
> diff --git a/recipes-bsp/u-boot/u-boot-ti-am62px-sk_2025.01.bb b/recipes-bsp/u-boot/u-boot-ti-am62px-sk_2025.01.bb
> new file mode 100644
> index 0000000..b9dbdf8
> --- /dev/null
> +++ b/recipes-bsp/u-boot/u-boot-ti-am62px-sk_2025.01.bb
> @@ -0,0 +1,46 @@
> +#
> +# Copyright (c) 2025 Texas Instruments Incorporated - http://www.ti.com
> +#
> +# SPDX-License-Identifier: MIT
> +
> +require u-boot-common-${PV}.inc
> +
> +TI_FIRMWARE_SRCREV = "9ee2fedb1fb4815f54310dd872d34faf9948c7c1"
> +
> +SRC_URI += " \
> +    https://git.ti.com/cgit/processor-firmware/ti-linux-firmware/plain/ti-sysfw/ti-fs-firmware-am62px-hs-fs-cert.bin?id=${TI_FIRMWARE_SRCREV};downloadfilename=ti-fs-firmware-am62px-hs-fs-cert.bin;name=sysfw-cert \
> +    https://git.ti.com/cgit/processor-firmware/ti-linux-firmware/plain/ti-sysfw/ti-fs-firmware-am62px-hs-fs-enc.bin?id=${TI_FIRMWARE_SRCREV};downloadfilename=ti-fs-firmware-am62px-hs-fs-enc.bin;name=sysfw-enc \
> +    https://git.ti.com/cgit/processor-firmware/ti-linux-firmware/plain/ti-sysfw/ti-fs-stub-firmware-am62px-hs-cert.bin?id=${TI_FIRMWARE_SRCREV};downloadfilename=ti-fs-stub-firmware-am62px-hs-cert.bin;name=sysfw-stub-cert \
> +    https://git.ti.com/cgit/processor-firmware/ti-linux-firmware/plain/ti-sysfw/ti-fs-stub-firmware-am62px-hs-enc.bin?id=${TI_FIRMWARE_SRCREV};downloadfilename=ti-fs-stub-firmware-am62px-hs-enc.bin;name=sysfw-stub-enc \
> +    https://git.ti.com/cgit/processor-firmware/ti-linux-firmware/plain/ti-dm/am62pxx/ipc_echo_testb_mcu1_0_release_strip.xer5f?id=${TI_FIRMWARE_SRCREV};downloadfilename=ipc_echo_testb_mcu1_0_release_strip.xer5f;name=dm \
> +    file://0001-configs-KASLR-OPTEE-RNG-support-for-K3-devic.patch \
> +    file://rules-${MACHINE}"
> +
> +SRC_URI[dm.sha256sum] = "3435b8b5be80a3fe8775f60b1239dd909a2a75958569727491ca9691fecc820d"
> +SRC_URI[sysfw-cert.sha256sum] = "3565f0dd48470e6ae36a7a90fb2eb2e2e0949b9702271e3b944b98a208a01a69"
> +SRC_URI[sysfw-enc.sha256sum] = "61c52ea82d5b0eddfb236619d685d660ab1afc18d10aa4794b03a1c1a679baf7"
> +SRC_URI[sysfw-stub-cert.sha256sum] = "a0c9181646c1832eb5bdfdf243634fe03df1c0bad01653b041149768a39d35f9"
> +SRC_URI[sysfw-stub-enc.sha256sum] = "d96af397494c460cd3bbd6cf925c6f559a9c43b572cfdd58961b5c8900124144"
> +
> +S = "${WORKDIR}/u-boot-${PV}"
> +
> +COMPATIBLE_MACHINE = "ti-am62px-sk"
> +
> +U_BOOT_CONFIG = "am62px_evm_a53_defconfig"
> +
> +U_BOOT_BIN_INSTALL = "tiboot3-am62px-hs-fs-evm.bin tispl.bin u-boot.img"
> +
> +DEPENDS += "trusted-firmware-a-ti-k3 optee-os-ti-k3"
> +DEBIAN_BUILD_DEPENDS =. "gcc-arm-linux-gnueabihf, \
> +    libssl-dev:native, libssl-dev, grub-common, \
> +    swig, python3-dev:native, python3-setuptools, python3-pyelftools, \
> +    python3-jsonschema:native, python3-yaml:native, \
> +    trusted-firmware-a-ti-k3, optee-os-ti-k3,"
> +
> +do_prepare_build:append() {
> +    mkdir -p ${S}/ti-sysfw
> +    cp ${WORKDIR}/ti-fs-*firmware-am62px-hs*.bin ${S}/ti-sysfw
> +    mkdir -p ${S}/ti-dm/am62pxx
> +    cp ${WORKDIR}/ipc_echo_testb_mcu1_0_release_strip.xer5f ${S}/ti-dm/am62pxx
> +    cp ${WORKDIR}/rules-${MACHINE} ${S}/debian/rules
> +}
> diff --git a/recipes-initramfs/initramfs-ti-k3-kernel-modules-hook/initramfs-ti-k3-kernel-modules-hook.bb b/recipes-initramfs/initramfs-ti-k3-kernel-modules-hook/initramfs-ti-k3-kernel-modules-hook.bb
> new file mode 100644
> index 0000000..75e7f92
> --- /dev/null
> +++ b/recipes-initramfs/initramfs-ti-k3-kernel-modules-hook/initramfs-ti-k3-kernel-modules-hook.bb
> @@ -0,0 +1,27 @@
> +#
> +# Copyright (c) Texas Instruments Incorporated, 2025
> +#
> +# SPDX-License-Identifier: MIT
> +#
> +
> +require recipes-initramfs/initramfs-hook/hook.inc
> +
> +HOOK_ADD_MODULES = " \
> +    snd-soc-davinci-mcasp \
> +    snd-soc-ti-udma \
> +    ti-eqep \
> +    ti-ecap-capture \
> +    mcrc \
> +    sa2ul \
> +    icss_iep \
> +    icssg \
> +    icssg-prueth \
> +    ti_k3_common.ko \
> +    ti_k3_dsp_remoteproc.ko \
> +    ti_k3_m4_remoteproc \
> +    ti_k3_r5_remoteproc \
> +    rpmsg_char \
> +    rpmsg_ctrl \
> +    rtc-ti-k3 \
> +    pruss \

Why are those modules if they are boot-essential? And what do we really
need? I doubt that we need them all...

> +"
> diff --git a/wic/ti-am62px-sk.wks b/wic/ti-am62px-sk.wks
> new file mode 100644
> index 0000000..8663607
> --- /dev/null
> +++ b/wic/ti-am62px-sk.wks
> @@ -0,0 +1,11 @@
> +#
> +# Copyright (c) Texas Instruments Incorporated, 2023-2024
> +#
> +# SPDX-License-Identifier: MIT
> +
> +part /boot/firmware --source bootimg-partition --fstype=vfat --label firmware --active --align 1024 --size 16M --overhead-factor 1 --extra-space 0 --use-uuid --part-type E3C9E316-0B5C-4DB8-817D-F92DF00215AE
> +part /boot --source bootimg-efi-isar --sourceparams "loader=systemd-boot" --label efi --part-type EF00 --align 1024 --use-uuid
> +
> +part / --source rootfs --fstype ext4 --mkfs-extraopts "-T default" --label platform --align 1024 --use-uuid --exclude-path boot/
> +
> +bootloader --ptable gpt --source hybrid-boot --timeout=0 --append "rootwait rw"

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

