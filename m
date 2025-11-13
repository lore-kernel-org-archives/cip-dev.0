Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82FBCCD5BC9
	for <webhook@archiver.kernel.org>; Thu, 13 Nov 2025 11:17:37 +0000 (UTC)
Received: from MRWPR03CU001.outbound.protection.outlook.com (MRWPR03CU001.outbound.protection.outlook.com [40.107.130.41])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.21560.1763032656919386394
 for <cip-dev@lists.cip-project.org>;
 Thu, 13 Nov 2025 03:17:37 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=imSEc96e;
 spf=pass (domain: siemens.com, ip: 40.107.130.41, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EXeeO1Ssz84n8F2XbVoPfhre9TC2yERiFmA7vOcV+WlonV8ZQ4ZZ+OzJvPSPa9JXNhaIg2ol9Tm/4gtiufHqeuv9hijlc3GSEWmb4cAF5VNOAPErxfVcnro1PSuyywfY+DSoftfaWU+covclsWUlD0VoFkoU75UyU61EDXeAEUe0IJwFe0K3R1hJYTYdZ55w4FIqyju0y4g3FjxpNyZ1mSccAF2k9rMKzKVSLM8qgqyYABzYYxLZvxDpLFqiMU9k0RImFqcnA5hKQghxl2OV1+VJnLi7hBp+LIGwm/suNH4QDfC7ONLVGu0Tw2Jhg9H/l2d7YxXBhZyuY+V29/oFwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3SSsYP2mda7X3AAEu08ktwhjLTjz6ug2TGYJsvAZSq0=;
 b=PUEsfO34TnmG7dDcHfsx0pBwBoe9brazDBgjUUut2r0eBQp7i88j8WMCGEf01ArepMVEdvNzswdi5rS5rNUQ2Jy/5a/5Aybkr76Yv84pKBnwcJPIiqMoCFmyR/+jSn94g2G5SZI+4jTRmSM8jW2y3H9utc+57O88KQhrG6Ei7UHYkSEOhN1413cwZHpiiPcCjaWRWkGfS11EGe7LzB/FCTNrft3jW9ghh67IHpJ/4oCLkEpLlJ+t5JxhAeOVtkZcgtupnnxBg7qeSH9KaWi4/JV85cOAVSwTCmPFJJO957Oy/jcjxeH3pFQalHg4dYPPgJJ8dvQQOUQx66DEn4yFCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3SSsYP2mda7X3AAEu08ktwhjLTjz6ug2TGYJsvAZSq0=;
 b=imSEc96etb5IDkVA5allsWFlB5mkrFqO4RjxW0N6XGKfzawZ/9YrGWpx6gb7EKIh8vwcZC5scQczdIgtsAzXO5bibXRShr6ZAO7xJHK2y01ILtbMmUXHHI0F5QZg1dBWZkPrjUnpjbBap+wNQSG0lhC8+FSccJTy7fJn2tEAFUUwRkJPx/T9u2t0axBJnUnaxL3Ml150dLmDGRmOBdGSdBFB8wef4SLVZ/GYW+EG70/ashK5Ntd9Mh/ceGp2gXCyaiWYpmgYTDNyTBfZ+r+HNPz6nLZTAT+uWSddhqgSyDlKSF/zsAkba/URJ6j1wfUdrmAFXg6EPtNKIbrZHvb+eA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI0PR10MB8401.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:21c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Thu, 13 Nov
 2025 11:17:32 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9320.013; Thu, 13 Nov 2025
 11:17:32 +0000
Message-ID: <3cecb5d9-d4bf-42c3-a15e-9f5122263916@siemens.com>
Date: Thu, 13 Nov 2025 12:17:31 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH v4 4/5] ti-am62px-sk: Add support
 for secureboot
To: Sai Sree Kartheek Adivi <s-adivi@ti.com>, cip-dev@lists.cip-project.org,
 vigneshr@ti.com
References: <20251113101425.1177129-1-s-adivi@ti.com>
 <20251113101425.1177129-5-s-adivi@ti.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20251113101425.1177129-5-s-adivi@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0039.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:92::10) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI0PR10MB8401:EE_
X-MS-Office365-Filtering-Correlation-Id: 4917760a-1dc1-4c6d-9290-08de22a63d3c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?dGlFNnk5L3NPT1hmVkViY2lpdkhSZlgxc0hiM3p0QTNyeWIyWTRvSVZUTFJL?=
 =?utf-8?B?dXBkaDg4QWNGUHEyYXIrOW1MMW5MQkJZL21ZSUN0dUdibXZ2OEFpK2ZFcHZN?=
 =?utf-8?B?WjZkMGQwdERjUzMzZ2hjWnlwTjhVenVJN0h1TVRLTnNLOS9GK0Jva0dHTGJC?=
 =?utf-8?B?dGtIZ2YwMFJaNHVkeVJMbDd0MnJVSzNWMGM1YjB5NGxzclREcGZscExLcmJG?=
 =?utf-8?B?Rll1NzJRWWpGUTBZdm41SXZ0bkJyaWNVM2NBSWcrWFhkOFZ5dDFwVEFKV2JK?=
 =?utf-8?B?clNXUXpjS3k4ZGVlb3ZIQ0J3MkNQaTZSdG1ueTlPNTBNS2ZMQ2IxTDdoZkVY?=
 =?utf-8?B?NnlnMEp4am5IdWtvT0FCWVVsQUg1SDN3b3RGd2JCaUwrdjZMZzNFeEN2WHFX?=
 =?utf-8?B?a2ExWjVTU0dPNDhrMU1VaUg3V0dDZUcyVXg2NVUwbEs5b0ZSaWFRM3BmTCtZ?=
 =?utf-8?B?QWozem4wSThmUjJCNGR1OTE0RERRcDNkbnE3NFVzZTNIN0ZjdnBsaGlsYVcy?=
 =?utf-8?B?M1lIdmlqcS9rWDNTZ3I2d2dOVW1IMnRJd0QwdFlOeDZGc3Awdld1THN1cDl0?=
 =?utf-8?B?eEpJWTRjNWRnT2ZjK1pON2w0NzVKRFZjYWNXeWJhOGVXZ0ljN1lYTG5hVkRz?=
 =?utf-8?B?bzRTUVVCRCtpb0NwQjhoN3Zld09XSmFTaDZ2RVBFVHVFUXN6aHM3b2lrN3du?=
 =?utf-8?B?Ykw3QTlINis0V0NwNXk1YXNwZzlucjdkc0RzVG9KYWdsTWRJbE1ibkRNNW55?=
 =?utf-8?B?dUgzclBNTTNmdkxycU5pSi94VDcrSXo1RzA0L3I5SWM3UTFIMEw0cVpXZlBw?=
 =?utf-8?B?ZWNjdFFLRW5oZk1IbC9UNG1rd2RRUW0yYlZpQllLdW5NZU5Sb3YzaGg0Z00r?=
 =?utf-8?B?aEhmZ0JIcnVnQW16NkFFbkIzSi9KUThSVzk2Uks4ZVpXbzVQQTBYUFFKTjJi?=
 =?utf-8?B?VUxRUlo4Lzc4ekVydUgxbGxsbURQYnAxTVFuSHhubFU0bDZ1NklDdXdodlRa?=
 =?utf-8?B?d2pJUE03dm53NE1mdDBEVVowdy83M3JiQjlQVHl1Zml4dTNkUXhOcTRhWlNZ?=
 =?utf-8?B?NVJxVmFmUHZFeTNBZjgydXRtYW5ETW15LzhyMTdFNW9zczBtM0ROeTdGSlBX?=
 =?utf-8?B?NVRIYXo4Z1p4bWVJcDR5VGJuYndwTlVqdTM4TjQ0dUMvck93QUYrb2xQWDVL?=
 =?utf-8?B?UHdmWDdQbVhMdnBjOWRRaEREbmtWL0x5anBITFpvVEpGazJLdUZndTZNU085?=
 =?utf-8?B?b05mRFJhczhCNE9QVFNrb0Z3ai9DcDhRUFVEL1lHcTduck54TXB6emdJSVFk?=
 =?utf-8?B?Y3VtWVpWa2VoaHJzWXhkS3RTcDZQelJrWGVBaFBUNWFjeUtrWmljbWxNTnVM?=
 =?utf-8?B?Z3FwMHBYZEYranFFeWY2Z1lrSnd6YXQvTkZIVkZ2RzBRc1NHWTVra1JrSnlY?=
 =?utf-8?B?QVlyZG14SHJmRmtnMkhFaGY0elBRS3ZTMCtRaE5KV2JCR2hGZEJFZXphSjY3?=
 =?utf-8?B?UGtyajBvdktSckNVUlFid0NrRkQwY3RhRmVDVGpHa0pBZUQ5VUh3QjN0aDlP?=
 =?utf-8?B?Yzg4bzR5RHJXUW8xaU9oTjFyZ3BqbWdrazVFc21MU3VzWTlzcDUxN0xMZWNm?=
 =?utf-8?B?VW9zRTNMRWgwcUExN3pJOU5YU0RoWm56NWtNNFgyM3EvRkt3blFYcnV0R2Jh?=
 =?utf-8?B?ZUNUbVBETUJKdk8welg1dmwyOFpXOXpqUFNTV2FvKzZUTm5NQnVIbEtjRkZy?=
 =?utf-8?B?SG01SFN1dlhUU25uZzFuVjN0cU5mVVlnaGtFY3g1VThCdGJXYTNFOU5xVGI0?=
 =?utf-8?B?ME1sa2pPMGZDcUtQc0FrSUpTdzRjMEpjOWxwdWYzNmlxMkVmSTFITUNrTFgw?=
 =?utf-8?B?QmZpNGdKblpkWTNEMitydlNYOGFzSjI2UVlkNUkwSVVXT3grRG44RkN1b3VR?=
 =?utf-8?Q?f7pBkNQlnloVythbdXDPheAFftVFOdAx?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?TitjZU5weklSTE9HYm85RUZPVUVLbjY5WGZkWCtleWdQTG1SVVpHTjFXRUNL?=
 =?utf-8?B?aDAwT2dHQVZZcWEveExOUjg2b1JqZXdPWTFSMERZNE1iTHBnTkM4bGFWM0Nh?=
 =?utf-8?B?N2R1Q3ZCaFc3b3h2Mm1kR3o2RUhsSzdJdHRhNHZzMkR3cjdYWFlqcUlrcEtt?=
 =?utf-8?B?VFFWa2tJdEx2UUFRK29nbys4R1ZzQ2Q4Q0F0emg3Qy9XVGtxMHcxQXI2YUdR?=
 =?utf-8?B?WCtBOFQva2dzOEhTNXNGV2dXVWJlWU1kRXdhdlpwVnZyVC9pZkFnYVFGUmJI?=
 =?utf-8?B?Qm8wZFNxNjBXWjZGdnlQWUJwV0tKTEswMUFyaEtiUzZEV1Z1aFpvaEJtbE1R?=
 =?utf-8?B?OFJldFhXMEdXWjdMQnpKM01vdS9LaDN3ck5tMnZ6UEprb3NGY0RkR014Y2V6?=
 =?utf-8?B?Yzk1NzhDV1RnYUVnWHc1K2R2M1JmdmtROWxCMThpT2kvcHBES3ZFZTNCUUxI?=
 =?utf-8?B?dmJPOTJSZVpQRFc3OStXSzlCVkJDcHgzNEhrY2gvWEo3WlN1M0lJY3ljNytw?=
 =?utf-8?B?RHNYU0R3L081WE1KMi9Ba2NMM2NNR0cyRE91a1NrMUhTRWFZak5TaURsK3RH?=
 =?utf-8?B?ek0xNE40S2oxUjN3RW5OcE1laHc0bmViVEVlUGYzWGZHOWN0NURJZWlROGRS?=
 =?utf-8?B?Ni9ielpjRzdlZTk3MnRRYVFqWmM4SnBKQmZUL1JSODZNanNVdUpTKy9xY0pr?=
 =?utf-8?B?eGprWXRLQUdnVjkrTTZjeWdEeVpoQ1l5eGVwRnhsMTVjWHp1ZFdHTkZRNmlJ?=
 =?utf-8?B?TVJKK3l5RldYcHdRdlpGMXBZNXpBTE41cE1UMWpmcVVBZkIycXVHbWVIZkI2?=
 =?utf-8?B?aHhBbU9BRjl2N3lWUWFsZGp2RzIvdTVmdzJmN2o4TTBrdDBFMjV1N3BTa1hB?=
 =?utf-8?B?WitocW5rR1hEU3pGcllZeWp6SVJlcjhNVWZJOFRhakhCRlZuUXR0UlRFMDdC?=
 =?utf-8?B?cHFvT1pIRHBaRFFNNHh0YVR1ZkcyTjdzZktiOXlVb1k0UXRMWURVZmJRSGFu?=
 =?utf-8?B?N3VNQXg5Z24xSFZEb2s4b0R5VTgwTXlLUEJiV2NZQVN6TEdMNzlBOStNQlNo?=
 =?utf-8?B?bk1HL01zN1IrLzczRGNFcWhINURpaW5NaitFQm9OeEg3Smg0OWlvb0tSNzd0?=
 =?utf-8?B?VFRyNjU4VXQzRWtkR2txVnlVVEdwTTBTZ2ttVjNXeVErQk9xRlh2amIvUnJw?=
 =?utf-8?B?RVFuRXAvdFhQRGN4RUd6bXhxaWJnd1BKVDBXbE9KY05hODUyd05ndjAxNmdT?=
 =?utf-8?B?MlF3ZXNhbFpYSnIrd2c2eWFKWWhYTEUyMjJVcHg0bllFeEV1SlNXTmpSc1Iw?=
 =?utf-8?B?TlEvTUY0Rm9RTlJVNTgrZWhWcGxqbENnL2xKR2ZrZTUyZTBCcURHWUNOUWlW?=
 =?utf-8?B?U0xKS3BvVGNIcERTY0R5R2RIWGF1dEtTL1ZxR1QvQmc4a2NqQkEvdmt4aDBI?=
 =?utf-8?B?eXVJRFhYZCtSc3NNSEdQakZkRXV1UzlPRE9TUWNDaFh1TDY1L3U0TmpPMDZY?=
 =?utf-8?B?ZDZJQjlnb1VuWkg2bXVLMVhFejhrTEZ2SElRY3VraitNY2lDRE1VOHg4NnhJ?=
 =?utf-8?B?VmUraXZiSkpTT1NZUUthS0EyUUF2YzN0aVZheTJ5Z1p5bHVwQ25qUC9mcTBv?=
 =?utf-8?B?TVc3VUtlbEYzQ0FFanowOUc1Z3d5NGZPOGtEanZ0RkxudXN5cEs4ZUZrUTRu?=
 =?utf-8?B?OVlrU3hMNWkwSWMwSkZ6bjdkOTA5cGhnNUxBR3V1UEZ3SWwrc0ZRQnloT2E3?=
 =?utf-8?B?MTRDdHFOSTJYQS8xa1ZVSzBMYWRab2FGWGxHNjVGR0h2bjhRMS84Q0cyd0M1?=
 =?utf-8?B?a2RQNmdLQkpuay9IQ0hmOVdSSDg4bVdMUVpjOThZTGxCeW1JUTdUMXR1VzlX?=
 =?utf-8?B?VDE3cjJpWHB5TVpCcEQvZjQ5cjY2blZXU3llQWdzTTZjd01Jb2QxN0RDNFMz?=
 =?utf-8?B?aE1NYWZROXdzaDZsV2hoanE2MVl4ZnByVC9ZbWE3N2dWNDJRMWdYUWpqSWpZ?=
 =?utf-8?B?dDVNWWVSZStrOUNJR0ppZ1BYU25QWDh2Z1pNa1BUQzJhLzcrM1NicXhpNWJC?=
 =?utf-8?B?L1NRd0FtV2dyZUZOdVp2MDNJMXROUnZaUXJiTG1xeEJvRUUzREQ4M3p5YlE5?=
 =?utf-8?B?cTIyam9yVTdwRDhlVG5lUHdQSjJ2amxvMEJabHhzY3hMbVczNDBOaVMzbkh0?=
 =?utf-8?B?UHc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4917760a-1dc1-4c6d-9290-08de22a63d3c
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 11:17:32.1662
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lhTFoF62dQf0eDgTI09/oIqO7dSWIIZ97B4pZgJZN1vQBd9dVJ8PgBfVeOMLK5eLoZZ5Rt6oa+p7OqYyBY8Vlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR10MB8401
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 13 Nov 2025 11:17:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20532

On 13.11.25 11:14, Sai Sree Kartheek Adivi wrote:
> - Add wks file for use with secureboot
> - Update Kconfig to enable secureboot
> 

Strictly spoken, only patch 5 fully enables secure boot by select'ing
FTPM_STMM.

Jan

> Signed-off-by: Sai Sree Kartheek Adivi <s-adivi@ti.com>
> ---
>  Kconfig                                       |  1 +
>  ...i-am62px-sk-efibootguard-secureboot.wks.in | 23 +++++++++++++++++++
>  2 files changed, 24 insertions(+)
>  create mode 100644 wic/ti-am62px-sk-efibootguard-secureboot.wks.in
> 
> diff --git a/Kconfig b/Kconfig
> index d322a94..c02ac94 100644
> --- a/Kconfig
> +++ b/Kconfig
> @@ -104,6 +104,7 @@ config TARGET_TI_AM62PX_SK
>  	bool "Texas Instruments AM62Px SK"
>  	select ARCH_ARM64
>  	select HAS_SWUPDATE
> +	select HAS_SECURE_BOOT
>  
>  endchoice
>  
> diff --git a/wic/ti-am62px-sk-efibootguard-secureboot.wks.in b/wic/ti-am62px-sk-efibootguard-secureboot.wks.in
> new file mode 100644
> index 0000000..52fcb09
> --- /dev/null
> +++ b/wic/ti-am62px-sk-efibootguard-secureboot.wks.in
> @@ -0,0 +1,23 @@
> +#
> +# Copyright (c) Texas Instruments Incorporated, 2025
> +#
> +# Authors:
> +#  Sai Sree Kartheek Adivi <s-adivi@ti.com>
> +#
> +# SPDX-License-Identifier: MIT
> +#
> +
> +# Boot partition containing Bootloader binaries
> +part /boot/firmware --source bootimg-partition --fstype=vfat --label firmware --active --align 1024 --size 16M --overhead-factor 1 --extra-space 0 --use-uuid --part-type E3C9E316-0B5C-4DB8-817D-F92DF00215AE
> +
> +include ebg-signed-sysparts.inc
> +
> +# ABROOTFS partitions
> +part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.verity" --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_A}" --part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4 --part-name systema
> +part --source empty --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}" --part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4 --part-name systemb
> +
> +# var and optional home are extra partitions
> +part /var --fstype=ext4 --label var --align 1024 --fixed-size 512M --fsuuid 96be3374-4258-11ee-be56-0242ac120002 --uuid 423f0a2e-b9b3-4615-85be-2a4261fa32d9
> +${WIC_HOME_PARTITION}
> +
> +bootloader --ptable gpt --source hybrid-boot --timeout=0 --append "rootwait rw console=ttyS2,115200n8"


-- 
Siemens AG, Foundational Technologies
Linux Expert Center

