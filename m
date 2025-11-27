Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB9F8CFD2F6
	for <webhook@archiver.kernel.org>; Thu, 27 Nov 2025 06:47:54 +0000 (UTC)
Received: from DUZPR83CU001.outbound.protection.outlook.com (DUZPR83CU001.outbound.protection.outlook.com [52.101.66.58])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.12936.1764226065498733847
 for <cip-dev@lists.cip-project.org>;
 Wed, 26 Nov 2025 22:47:45 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=rrdwHCx/;
 spf=pass (domain: siemens.com, ip: 52.101.66.58, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A175LURLIgMoqPkA3Q3/ez2Hyxkaa9A2ai9UzcXoDs0EceXNI9LwEJ5ZH2Ns4GnoqbWLJ4/KAuNjjNIQjPtety/qvIyYe5RolV582dZqTkuxDY/wLtqkdSRD8DscLwGxIupnvpVCsa38ZVygeYoLShH0vkgH5IQOTPRrS8d2RcZs/SGHbGX7ZBgU55sXuZNfWoore+u/HDgArUw43yqxlklaT4NXJdhf/SUZYw3bW7cOudaonb6Uw2apvPA9+qKCIuQs79Nx/2bfACl4VymdyA9UZnTVzGiBwIuq535tyHhohOVDhIqe0nsaUOwU94o07u9HTQGX6lXaIP7M/vASJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yasc83qXYalxT139aGlLQ7CsfqPOBS14Cl8XrIWDhbo=;
 b=aNM6vuKxbc6LbGOiI0qp5F/1W3pEGSFvSiX+adqTKPf4yTMtO/EVhSNexA0dMm6laLFPIpnZcfXLhkS/aAmvPo7AEUUA/BdLcx34wZRRWmXoMeMc7MxGu03cxQZ4o8Qq5DAdGW6NxZ65cL92P/t7OLZU5atXoMbLo6dAOX0KUEYqwMdtIww3Vh78M6QXf+LwQ4maT0oZNSPVP00zfINlOhVQIgf4y9l1jUPsbmc6e1mwHLqhOL/qf2d9N2BNnwtn1L9IsAwFmE3n96nhbP1c1UAPggflpxzqMJkeMxZF4t/O5D4wJhrHOR1mRgNtjfJ+2OiOiRD7AtFQCAr6AykI5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yasc83qXYalxT139aGlLQ7CsfqPOBS14Cl8XrIWDhbo=;
 b=rrdwHCx/D5qb7AJPdN8y2HW9XaONi0MfU4rk+SiGq9XMGVZC+pdd5lK5T/1o5GmQCobTFNPPkmQN0Kp1clFpvlNd9lfskNMH0M0PxBA4q4DHyJw7wQYM9SbVUDXVT7Qn4rCI3ZroD7/mo4fThmURWH02vBSxbub1QkqABXzGqs9T5wrJO4eljX+KziuwODfXjMyW+k/0hcdlm10SNyzfyh54vOPaotUKMp1ULSEx+2t0l4vtQtF+IDV1jYIsneMNbfyzCMQeHR7BLEWtfWs1E0SvLqa4uAQMt6q9dyU6pwrOymrItIO8/taV3bfY7Yi0lFG/yFP/+qcf0X0vDwJUfg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB7208.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:618::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.13; Thu, 27 Nov
 2025 06:47:42 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9366.012; Thu, 27 Nov 2025
 06:47:42 +0000
Message-ID: <d0eb107e-2a98-435c-9f72-58db303e00fd@siemens.com>
Date: Thu, 27 Nov 2025 07:47:40 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH 2/2] u-boot-ti-am62px-sk:
 ti-extra.cfg: Remove redundant configs
To: Sai Sree Kartheek Adivi <s-adivi@ti.com>, cip-dev@lists.cip-project.org,
 vigneshr@ti.com
References: <20251127063738.435868-1-s-adivi@ti.com>
 <20251127063738.435868-2-s-adivi@ti.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20251127063738.435868-2-s-adivi@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0111.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9c::15) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB7208:EE_
X-MS-Office365-Filtering-Correlation-Id: ba18d97b-17f1-4443-653f-08de2d80dcef
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?elhObXcxbTRYWTJQQUN5b0cxKzhZa1ZtOXd4RCs4UUxkZ3lORXJKTGhTalZX?=
 =?utf-8?B?Q3FXc3JVUk5LWHEyemc1V2ExUDdmTTJCeDJZTmxPclJiajFrV1BWZ2MzeDI4?=
 =?utf-8?B?RTZmRUxQcDg4WGRka05DQkhST0cwTTlWNzM4TU0xNFFnVkR4NGpvc1hyU3BK?=
 =?utf-8?B?cnBTOC8vMzhQYmZEZ0dnTExSMzRlN0dGd0U4YXZabVRCS05tSk5sbmZUQUg1?=
 =?utf-8?B?QmVnUTRDUWl4VkN5VUIwN0FhSEpTN2lZZDI2bklnaG5yK1pxNXBaV2RlNjIv?=
 =?utf-8?B?anh4YW5KQVFZa3RlVXhocXdJL0JDUkdFY3dtaExrOGp2SFlSRmZsbEJWNTZL?=
 =?utf-8?B?Qklha3I1Qk4rRjNoN2o3TkpLanA4T29PK2Jsb010ME9jM2l2dmRCN3dCTVZV?=
 =?utf-8?B?UHl4cXAydGpMRjMyeU9ENC9SMVl1UEhkZm5PVE9EM2NiYm5XcCszNFE5amd0?=
 =?utf-8?B?VHJPMy90dkJtdFJmeHdXbER5aVBEbUhETk1OREVtSTVRVUZCTDNmbk5yaDRD?=
 =?utf-8?B?L3RueGwrWkQySEROUElJWnY5blNibDdRS1BTbmp6Q2VJZjZ3Q0ZsV05vaHNS?=
 =?utf-8?B?cFgxR2JSNi9nWmY2N0lCTk5hVk5QeVYwRkRaR3dRRU02N0JjNTY0SU9UcDY2?=
 =?utf-8?B?eU5PcEJickhuWENjOUNQeEo3d0tqdytuRFFDY3l4TzBUUklud21qREk3NWxv?=
 =?utf-8?B?bXZBYlp4ajlUYmFJZy9TZkJCd1E2aEJPcm9wM3ZNdHFZeVUwZW1yS3Z1OFZh?=
 =?utf-8?B?YldzcWJJbUFJVC85VGpMOFROanpVNFlzaUZGdWw0Z0o1VUNmMDdCVkxIanB6?=
 =?utf-8?B?a1lPQjN5Z0JoRkxBNWoxN3VuU3FEZ2pRODQrRmhnRitrYStKMVVHL2drZ3ZG?=
 =?utf-8?B?VldUOHdqM1lZQndDeHI0RGVBNVBZSUFTY3Rjc1RaTUJrTHVuTThEeUd4MDcw?=
 =?utf-8?B?YURTSCt5MlhIMnBuQnJUdVdBYTUyeS9CclJaM00vYmtCSzJoQXgwMEN0MHpa?=
 =?utf-8?B?dWZFS2crNnhWcm5ndUVjeXJpYTBJMkRIeFNyYlYxRURGOU4vRmxKZHFxVEFI?=
 =?utf-8?B?MkVxbnNod1ZIOFFBZFZlWC9qVkFmWGc5VnJXSmVOSmRtZnR0VG1ZL1YxNVMv?=
 =?utf-8?B?RXdRWWF0aHF1bmx4OExkRDR2TERFZEdNQkR1Vk16dnFwWmswTjVvV1JFUlli?=
 =?utf-8?B?V0FtbGNQWjdQa2kvOEZHZ0Y5N0lwOE1LeW9qODJnVDlGRkVOV3FQWEF6U0Rn?=
 =?utf-8?B?bEF0T0hRdHAxdExqZHV5M1FSeFNKVEZjWnUvOFQ1MW5JY0RlK0JSV0VZMWN0?=
 =?utf-8?B?RDBmdktHTVhPdDVlRkJkaFZIcjREejJoeXJCeU5JbUxtSUc3ZzJzYWJzWkd5?=
 =?utf-8?B?N1ZiV3A3dEFNeHlaY0orTVpVMDMzSzNJWmVHRk9SbkV3T0VSclVFZ2hyeGJG?=
 =?utf-8?B?YXd0OVhLVmRUR0dGd3RrbFdDbitGZzI3MkVjemV5VUlTbFpYb2lFQVVpVjgv?=
 =?utf-8?B?MFJXU0psYzN3b1NGUUdhL2hGa3hlOE9rbkVBeVBPaGtmcTd5WDRsMkNVY1RS?=
 =?utf-8?B?Ukw1d1BLcVJ3L0UyZVF1aFVvMTdEUllaSFFqNE52T1pTZktZcmcyVlJKUSt5?=
 =?utf-8?B?TWcxQ0tZOXVvTktaREFJaURrY1dmRmU3VytTQ1F1MnFKTWRxOVNscE1kMFUx?=
 =?utf-8?B?b2N1OUNkd2x0L0ViRFdyYm1KVUh0RnAwZGpyem53aDlZQ0hzMk1vTXJMSkZB?=
 =?utf-8?B?NGIwL2RZZ0pnZHg5cSs5QU9JQ1Jyb0NXT0ZOVXhpMjdiNHRqK00yUDJYSktz?=
 =?utf-8?B?K3RCOUtrcmk2VEZCaFVJYVZTWVA5TFlzN2ZsbXVaKzBVZVk3M2ZxRVduT0hQ?=
 =?utf-8?B?bTg4dG55c1NXVTMxQWNFYTFDWEFqMU04SGRMblBabGtnZlV1b0xicVg3M1VG?=
 =?utf-8?Q?+RdTIbPf0Fn6yUBH58Hm7P61TRfpGjNH?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?MXlwOFlDRDZYWG9ManlIOGEvTWVRVGtYME9aRjJiTkJEZCtXdU1KandzaHI5?=
 =?utf-8?B?WHVFa0R4YXRxTnByNDY4WFJRcUU5ZGpocytPRC9tM0ZFQUpVQnp5VzhnWXlF?=
 =?utf-8?B?MGFCL1Y4RlNhK296b1ZjQXpmR05CcnhQNUNWN2RubjgwRks0anBYemdSaE4v?=
 =?utf-8?B?ZnEyQlRGMFhxY0pXOFp1NVRWakhqc0tnTXZScFpRVktXaVFpbzFLVTVYdWZ6?=
 =?utf-8?B?SWQrcU9sbnplVFlnelozUVczMWVQdEdKMzVuSFlhUWo1UTliQ2tzVk9lVjlp?=
 =?utf-8?B?TkxzT1czZEtqbDVBNUY2dlQvZ0pmU0xnZHkxYkEzemdjNkNFekFJNThFUkNB?=
 =?utf-8?B?QVpoZXZ4TnNpZWtUTjRmbVpwNmVPKyt1VUZibER3Vi90VkJQeVk2bGxiWFdo?=
 =?utf-8?B?RFZDdzJ4QzhORGZiRFg1ZFNQMm95RXYwcUlsT1p1bHBHYWN2OU1LZ2MwWmFh?=
 =?utf-8?B?cHJCVUpTVGRIaXdVZEJyUkdGcEtLTGc1eE12WlJKdmJUbnBzRldEdDM0ajEv?=
 =?utf-8?B?a0xRYU4xNy9VbzNPR1p6c3VQVHVBR0lHaW1XaHJUZVBFOExWckx0bklqMGx5?=
 =?utf-8?B?OVdVYVc3UkwyaXJ5NGtsQUx1YzVWNmFyMmtqVTVWOTBDbjZ5MWNmNDdCaUkw?=
 =?utf-8?B?TjdveEVjdGNjMlRjZGxWb0c2RGJ6akFPb2JZdzFDaTYzbTRqUE0xdHZrZVF3?=
 =?utf-8?B?WGQrTFJMdmRpWGVKTVJnN1BFVFErVWFYSlYrK0h5MG5ydVhSaGdtZUJyc1Qx?=
 =?utf-8?B?V2dOV1JQdzArUGl2Y2swdTRuYnZNVmVSb2RONm52aEc3b2xaWlBNeHRiOG1h?=
 =?utf-8?B?ajlncjF1YXNGNkxLZHJLQlE0bHZ3eDdPRFRKa0hPUWVxS29ScXNYRTk1VUl6?=
 =?utf-8?B?a3BydWV1ZmZMTHFrOXNkWStkdjVPR29qbHVYSHJpWU9CdWw5MnluOXVadVhh?=
 =?utf-8?B?UG5KanUxR0tNU3Z0bVIzOGpvdjl1aW0xSE1ObWl3Z3JPZ3VaNm1JWmR5NGtR?=
 =?utf-8?B?UWpmSWVrTkxJUndJUlpYbC9CRHNEQmt1Nzh5SCtZQjh3WlZiRXRxaldVN05z?=
 =?utf-8?B?ZS8xR2t3eXhGV1BUYTRsRmhrWWZVclRpSkVWVTl6WWN6RHUrM2hjaFgydGsr?=
 =?utf-8?B?dlVwY21FVDBEaG5kMFpXendqUDFyci9FbGkxclp2b21iUUxjR0VEcEhWL3ZR?=
 =?utf-8?B?UnZsZ1JtNk93RmhUVE5ETDlYV3J0WHVzVFI2Uk1CNStTM1ZTL1R1cWFNU1Vw?=
 =?utf-8?B?SkV1UHMzK0ZIQzJQc0s5dWVmK0VJc2NScGZQTEw1OHQ4UXFNU2VHT2J5QTRJ?=
 =?utf-8?B?WDZwRnpSOG5UNXRnVzBFSFczVGlDUXpSUVJVaTVFelJ5NlV2VXlGZW1tNmVJ?=
 =?utf-8?B?UmUxNTg3NnVpQTkzNzN2UTVzRU1WSzBFQk5Kb0d4LzlJYjA0b29EYVBoc0VJ?=
 =?utf-8?B?NEtFeS9JbTYva2EwY1pnenkzMzJzUnozOFp6aHpRckRRMHpyNXhTK1VKcFk0?=
 =?utf-8?B?Mi95V1BsTElFL1FIamU1Skw1cWxCZGg1QVI0ZWdMMW5CV3BRZFA5SjZhbjhm?=
 =?utf-8?B?QzNhTnB2VU1Ud0NXaEVPcFZ0Wnh3Zk1BN1l6L3ZtVVRFOTQ5WHhiNUNLem5q?=
 =?utf-8?B?MGhsczVuSUUwZHlzdTBCZjhGVFdoSHhLbmRlQWFiN1ZycGpmVEhlc29YY0lZ?=
 =?utf-8?B?VFBaalVFWjlyRDFSWlR3UkJFQk9FWWxQZVlHV3NhL2NtVjFtMGFIVWFPOXlI?=
 =?utf-8?B?ZXVrTlM1YmdLQWk2ejhEL29HU1BZYmlORi85ZXc1dStNOVF6N1ltTXZlTnYv?=
 =?utf-8?B?U2ZURUxRN0JBMkdHNW1CdmhJak9NTTRLOU1uSXdSQmE5TVVacHZTdVR2eDJk?=
 =?utf-8?B?dERpQ2twZkZMQTNBSURnb2pxbTlKZUxlSGRtSkFrL0s2bkU0VHRKV08vMlBh?=
 =?utf-8?B?Ykw5YXc1RDhtanhZSW5UYXFjS1BuVmJQbExOUUxGOVhsMFphMnp2ZXg0VG8x?=
 =?utf-8?B?WStNb0YyVThwL3dQS3JQRnlNRi8xZVJieUpQbmFKbWJjV2dpYkxaR1NjTzNj?=
 =?utf-8?B?eUhDa3V0eGFNT2RncDlIbTRKNlR0cmtkS1BjNHEzWVZ3VThNR2hsUkpKVG9t?=
 =?utf-8?Q?w+2UCKXy85J0jcYpCo4CHYFbQ?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba18d97b-17f1-4443-653f-08de2d80dcef
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2025 06:47:41.9795
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OcdmX1EkxQ6RnrOpIfyaW9J19Ws1kvzRwJRqF8omJnXSGmk4qSTW3AJeQbwnsbn4mGf5XfFQvG1/46YCSZ6pPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7208
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 27 Nov 2025 06:47:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20738

Please explain here briefly why these are redundant (there are multiple
reasons).

On 27.11.25 07:37, Sai Sree Kartheek Adivi wrote:
> Signed-off-by: Sai Sree Kartheek Adivi <s-adivi@ti.com>
> ---
>  recipes-bsp/u-boot/files/ti-extra.cfg | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/recipes-bsp/u-boot/files/ti-extra.cfg b/recipes-bsp/u-boot/files/ti-extra.cfg
> index faff390..c10d046 100644
> --- a/recipes-bsp/u-boot/files/ti-extra.cfg
> +++ b/recipes-bsp/u-boot/files/ti-extra.cfg
> @@ -1,19 +1,14 @@
>  ### FTPM + RPMB + StandaloneMM setup
> -CONFIG_TEE=y
> -CONFIG_OPTEE=y
>  CONFIG_OPTEE_SERVICE_DISCOVERY=y
>  CONFIG_TPM=y
>  CONFIG_TPM_V2=y
>  CONFIG_CMD_TPM=y
>  CONFIG_TPM2_FTPM_TEE=y
> -CONFIG_CMD_OPTEE_RPMB=y
>  CONFIG_SUPPORT_EMMC_RPMB=y
> -CONFIG_EFI_MM_COMM_TEE=y
>  CONFIG_MEASURED_BOOT=y
>  CONFIG_CMD_NVEDIT_EFI=y
>  CONFIG_CMD_MMC_RPMB=y
>  CONFIG_EFI_TCG2_PROTOCOL=n
> -CONFIG_BOOTCOMMAND="setenv pair_rpmb_key 'setenv -e -nv -bs -rt pairing 1; setenv -e pairing'; run pair_rpmb_key; bootefi bootmgr"
>  
>  # workaround for v2025.07
>  CONFIG_USB_STORAGE=y

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

