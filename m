Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AFAAF8FA79
	for <webhook@archiver.kernel.org>; Tue, 21 Apr 2026 13:27:35 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.84.15])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.29303.1776778044753154658
 for <cip-dev@lists.cip-project.org>;
 Tue, 21 Apr 2026 06:27:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=Vsim5LWN;
 spf=pass (domain: siemens.com, ip: 52.101.84.15, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AjTbKSXuxw0pP4Daf2lZsxzZkiDsViFOhmCv/LKjCT0sw4yODt84PdShnGPpkaKH9mY7RLaZT6F3GFYd7hM8bfWHDrDbuW/bKU6EBf0NAxN7ufwieAnPBI9+4PxYDWss693dnn8pAlbq878YIUW35BgA/3MlG1ZWV+eV2O7wD7AdAbgRLdxcgzkE56q0hdGf1ObD1Z92bmEObWUIZgcIObHzOh8uZq8w3PFnWdZqC3LF3a/Hw/SRFaS3WMGbqUjwXzjfdcaqqDmTfFwG6bN3v3uH9TtbI7l7Hh5DNMgXubE7L2UAH7TM5XC5VY6H2CUKIIyACcSpD11qyUdK3PFEpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3P/rv33Yo2mtktBbQl3RBvi9xrSP9K5qy1RLweeT/BA=;
 b=tQMdJ/Wm3BeLtYru/HBgjyhDRyC2+KKySHWazzE8L5s6qTMIm9b+jYGUCP/fzPfY8bVc33JMYg7E++dunXFIRtSW79JQTOWqPUa4fKRb55bwrWBJfVgKicjJqCpp7a5zbsU3NJboTsu+Gk+MdMj1P9SgV6kmaWMbqbICX8yrVCLKryF/tDRr8r6UseG5IvSMdLebtADGyGkRW/PDd6Hazr/1hl9/3QTBLwQBjVVwJNTQX19NqRxkd4e6aziIFDZCJpaOwniqFuX0sBodrK0HxJJJSLcCnyXh177lEo1/EQNhwRvNVRS0vac/WppknzKy1xUrzBdq2r4z4Hbx57PBNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3P/rv33Yo2mtktBbQl3RBvi9xrSP9K5qy1RLweeT/BA=;
 b=Vsim5LWNn7EQQKmtJUFPhnocg62O1MCYGOWDKksficnTa4zGXGbt4R7ItlY5i4XogQFaqS4cNdtWH/n0tJOaQ1nlhd7q6Jvp6KGYzxoHnPgVUkrakScJ6LTwCKTX5laOjojTiYAJ1OUgp7Gc+AkkAyrXrLP5fwLsxFTflbkdIA+T32KPayFz0PBG46SrXS39fmxPRhZR9/esvalF+5k3756Zp0LzWkbG8r5Ywr3zD12wHpgYrMBQ6y6vx/M9w27nrdRwaInN4YlSoH/ozBiIjoYhcJgpoVLJ+FNAfPwlomGDfv1aa9AsOyBdlQJrUbQNiIYYqianYGaG19pOQFuXQQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAWPR10MB7343.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:2ee::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.33; Tue, 21 Apr
 2026 13:27:20 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.20.9818.032; Tue, 21 Apr 2026
 13:27:20 +0000
Message-ID: <a610ab8a-dfb5-471f-b7e6-57638fff52e0@siemens.com>
Date: Tue, 21 Apr 2026 15:27:19 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH] tpm2_functions: verify PCR bank output
 instead of relying on quiet mode
To: Sercan Sari <sari.sercan@siemens.com>, cip-dev@lists.cip-project.org
References: <20260421121344.3747040-1-sari.sercan@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260421121344.3747040-1-sari.sercan@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0091.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cb::20) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAWPR10MB7343:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a6413a9-a1d8-4e55-1726-08de9fa9b737
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|376014|55112099003|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: 
	7nJafbGw8Z+O0BDQonUOrDF2pW3SkfLlBE9ChiJfbyD8v3z9ynJ0iF/Hu4TqQy6BqHoNhWCw3WWUvh8dIVhuYPepU81gKnGqf5m2eZoS1GgvLtK+heg/tktcX10JfznKn5bX/NlpfBxP7eDcZuGxmwggXkENU/bzSK8Eq7Ecfi2pV4HEU/25dFnZhOWdrYWObay+s5ZgL43VkonPo8ub9+m468Xk18M6ThzpIJOF4+kBYkm7j86CVZt4z31vf9ojZzPxUkRunM3te//elUs/32w9YsbG7XR5Yxy/WPSZ+69kWjw7jEuSQrkJ7nJra+LYeRNeFbaeao+8bNCgiLKPkVgFpliowl7xD2VZr5o+65RyWXzxIfl6zZzAwV8akqnP+47+FXT5RyXhJ+ApKJFcI4hDzfgRZfcTSG8E8Oxb3lgsGdIf5Hf4ZCpos9g9pb8mMSPMjooV4THZFnu5sODlMjKTNOZN76uuqw1alry6ZijBSX2DGXHM0wRFpYzg4t4FXdr3v1q+rwSbSRv11WvMqdoLfCb+nC4s32V1h14SUMqePDkMvKfTccIqgR5CBed0vMze2diFfbvyB9BAzHdgMINqrnVRPIA4XbGuGpbEetWpRhapodCGcnAM6Wl4JzGbe4SQaui9T/Fz8ELRpsaC4F42S2IeKICwiMW3bh9eY5jem/2Lt9C2dyOQLC2pmcoJ2GDkRwQs2NAZcUanpB5ZHn5cM1AaN+4CYXUGUvU7caY=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(55112099003)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?bi83MURJeGQyODBFbXU3a2FrSW5UV3ZSakNQT1VZeHBvcmRBMlFNR0dUc24z?=
 =?utf-8?B?OGZoamxIZjMxWXM3N3lLZ2d4bC9zMElRMlJ3eGVGSVR6aTR4UytCTnRnYURY?=
 =?utf-8?B?SDY1ZlF1M1dMc1dGaS9mM1V4cEFGZXBSalJidFlGdjZRQmkvNVlZOFoyeTlE?=
 =?utf-8?B?RnFjcDBOZ0hJNDdsa3lNd0FFWEhqc20zTUYxTUF3TU0vRkdYSDJ4MHVUdENz?=
 =?utf-8?B?WjVtTVlZRDJqaGFkMTNhU3hZUCsyS3JaQ2Z5dHUwVVBBRXlzT2VianVtMXNa?=
 =?utf-8?B?U2lMM0FNbDZEV1VTekI5QU5mbzFaNmZZanhOZ2hVdFZKNlNHc2RFcWVQUGlX?=
 =?utf-8?B?VGFueEtiZWw2U2FzQnFDR1hnK0p0NlZyeFBhREl4ZjZ5MnJ3aTFhYzF6SFo4?=
 =?utf-8?B?NVdtRDFuTGlIajhDZEhYSno3Sk5CK2R5TThvckVOckdwWXhTRVVTODJsVXJK?=
 =?utf-8?B?emFEdHVLRFlmOFBXWTBkUnZ4bGhBTnJvZkdPa0pnbkpydW05NitLbXNEWVVP?=
 =?utf-8?B?TWQrRFNTajdaU2JVQndhSEU3amQxN0VzWnI4TU5TTVg2SjA2UHQ1eG5tTDd2?=
 =?utf-8?B?UXR5Uk1NcG1mazRibWdEZnZMdks5N1d5STR6Ylh1bzRZZEdHSEY3Qzc4ZlNZ?=
 =?utf-8?B?dEdoakRGNXRncDRneVhrUjIyWDZaU29Ma0xieW00VTlBNlYyKzY0cUYwMlBl?=
 =?utf-8?B?ZkVndXhZYUd2T3ZOYUk5RnV3cWJmZTJ6QUt3UUE4Vm5KNERtUXdjZHhzOGcx?=
 =?utf-8?B?cTkxZ0ttZkhsaFFuSlhyZ1J3UStnSFN0N0duY0VJd0lsRk9ydFJJVjg4dmli?=
 =?utf-8?B?dUZZUmlmbVlRdTd0VXMzR0J5UnBYN1VocVBsdTg0MUVwZTdGNjhkSGNySm1Y?=
 =?utf-8?B?TlBsMzM4dFByTndiMnVwQlAyUk9oVW43R0JzNzRQV3BuVlhLZjJydUp2TTQ1?=
 =?utf-8?B?Nkp6YWJpZGtFazN1Zis3eS9YaktWdjNaTTlHbHZVNW96SVo1dVVxZmZzVEQr?=
 =?utf-8?B?K083am9oWkhHK0VOVkpTRUtIL3dEV2pqMC9venJuSGNtbERtcnFlTExwVjdq?=
 =?utf-8?B?bTB5L09KUEcrL09ockpUcTM0L0VYdVo2VHV6eHNuN2lGMnFJWnluMEdHR0Z2?=
 =?utf-8?B?ZHJLWTF0cXZFcld1bVlTYm14cmNvRVIxRUoyYmlHQUI4VTRlRWxTTWRrd1BR?=
 =?utf-8?B?eXQ3ZkNhNFRBanQvbDhsS0E2RENRVHZjNkozRWloNTBLOGRrdnZBZWViQWdQ?=
 =?utf-8?B?WXFULzZSSDJDZEErNzY5eHJ5bG9jd3phNFpaY29lVWd4VWhIeElaYkZHSm4z?=
 =?utf-8?B?ZTA1azdMR2tuVVc1QjZRQ1MvdUNQYm1RMlNUSUw0dGlLQ2pmTHIrMTg5Wm5x?=
 =?utf-8?B?UkNMYWJxeVMxczlrQlpUWE82NU5SYjV2bVZNYnFJZmtTQmoxRU9tY1R6K1Rh?=
 =?utf-8?B?WWNjK05za1NzdmJKSCtKSmxhcTJRdWFFSEtTY1diR2lsMVQ5eGNyVlA5NHFt?=
 =?utf-8?B?WnRObzBHc3QrZ1JEQy80QWY0dnkwQ2lqSnkrQTc2ZjdzU0ZDaEF5dXZweGV6?=
 =?utf-8?B?ZEZScFByWGRwc1AzOVNWUDZOSTIzYlhid2JBMlpKV1NsS3ZlR1JQUmFncnlT?=
 =?utf-8?B?RGlHWThIQUN5T2lBS3haSERiT2lXRUQwby9Ockh6ajgyanN4MDRsVyt6K2VD?=
 =?utf-8?B?dFhtMm1Gam4rVmxSSUlqeTRwWTcwK0tmdHNqVmxnaGNaSGx0QmI3R2twZkJM?=
 =?utf-8?B?UmpXSlIxKzFmTDhSTnl3aFZ6cjdRNFdNVm81d2ZSZmpRa2E4dWhCMnpTd2tz?=
 =?utf-8?B?Y09JSE1vUVdOZUxROUc1K3ZHaVRZbW1qemxBMXpBNTBJbWlBK1RhcWEvUVoz?=
 =?utf-8?B?WDZqRHRoQUdRaXZBWnMva1BPREpqK1c4ME1oS0Z5MzNlNDZ0MzVXcVVVZWhE?=
 =?utf-8?B?ZjVEWXRFU2tjQXFBK3A3SElUV1lWcmtRYnkxeHFYY09ObHBiN2FSY0J1QzU2?=
 =?utf-8?B?cnJZYVYxekJsZExkclY1WjFkWm9YSW1FSS9URFhtekdmVU5MTkxta2ZFVjdm?=
 =?utf-8?B?WkQwY0t2WDRnZTkrVGlPY0hlZHJVejNMdFlHcnVyOTFYQmVyUW8ySjFkSGRC?=
 =?utf-8?B?N2ZEY0lXengyb3ZvMXc4WUFzRDdDQTNnRG1tajFvZWFlN3ZSY3ZmQmdZdTZR?=
 =?utf-8?B?OG9UZk1XSWQybFZEaVNlVzFKNFo5cm11U21lK2VJRGlacGw1MkVCVXJMTWFG?=
 =?utf-8?B?L2pGKzd5UnFRa1p5NWNhTUpUeW45Z0xib1hnS2E4K25EOWduSHhxRCsvU2lH?=
 =?utf-8?B?SU5pMnQwa3NmMi9WeHBJM3drU3NSWVR0VXM5RllXeHRaRFU0WHdFUT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a6413a9-a1d8-4e55-1726-08de9fa9b737
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 13:27:20.7299
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QZsOiI/xPsEixKgByY6+s1MqB7dl5H24oVZ8/vzIIJLavqmUKyu/BATmMDbbGpW5jj3FQ2cPZWL49u+LUsLTJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB7343
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 21 Apr 2026 13:27:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22775

On 21.04.26 14:13, Sercan Sari wrote:
> tpm2_pcrread --quiet can return 0 when the configured PCR bank
> is not usable on the device. This causes tpm2_check_device() 
> to incorrectly select the TPM device, encryption failures 
> when encryption is optional.
> 
> remove --quiet and verify actual PCR data is present in the output
> via grep. If the bank is not available, the device is correctly
> skipped and optional encryption exits gracefully.
> 
> Signed-off-by: Sercan Sari <sari.sercan@siemens.com>
> ---
>  recipes-initramfs/initramfs-crypt-hook/files/tpm2_functions | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/recipes-initramfs/initramfs-crypt-hook/files/tpm2_functions b/recipes-initramfs/initramfs-crypt-hook/files/tpm2_functions
> index 54d43f3..1c6bbff 100644
> --- a/recipes-initramfs/initramfs-crypt-hook/files/tpm2_functions
> +++ b/recipes-initramfs/initramfs-crypt-hook/files/tpm2_functions
> @@ -11,7 +11,8 @@
>  # SPDX-License-Identifier: MIT
>  
>  tpm2_check_device() {
> -	tpm2_pcrread -T device:"$1" "$pcr_bank_hash_type":7 --quiet 2>/dev/null &&
> +	tpm2_pcrread -T device:"$1" "$pcr_bank_hash_type":7 2>/dev/null \
> +		| grep -qv "$pcr_bank_hash_type" &&
>  		tpm2_testparms -T device:"$1" "$tpm_key_algorithm" --quiet 2>/dev/null
>  }
>  

Hmm, nasty. Is this unexpected behaviour of the tpm-tools limited to
specific versions of it? Did you report an issue upstream about this?

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

