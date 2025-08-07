Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A122C87FCF
	for <webhook@archiver.kernel.org>; Thu,  7 Aug 2025 10:29:49 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.84.3])
 by mx.groups.io with SMTP id smtpd.web10.48079.1754562579316882089
 for <cip-dev@lists.cip-project.org>;
 Thu, 07 Aug 2025 03:29:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=CB3bk04a;
 spf=pass (domain: siemens.com, ip: 52.101.84.3, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UHSm4/WeilaGkDaFhlB3zo+DHrLE6BaJSuBRvbVTUNaopToRCQNFOmqKtB+F837a99uGEPcklDjycgWseU2MAlCnw7AoIhlZiBYddAzELfrTr5vmPDW9QA5Br3MW0OsquXF1D4jkIA8yl2lrtIbA6lnVGaAo8Fw/tRytBUjjfXpwRTZ1v9CRVAygLuHBZfuWb9BdQaiFA1dleDsZuNGOZCYP6j67gpJodv6qT8EfYvzNoMrGpgOVt5htbNVWHGvKGBb5yjdvdsPu4KD1ZmMGy/CMCejKBagnrLpEPZKhyYbfyH1Ru6WO+e6KEEitdS9M/h5OVME806gLJ8TmvF9yww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IMoGrYIFSq/299LrLC+Cmvz1gGzoWnTRpZiHl06bYEI=;
 b=aMiPFJgi9SwdcCUnV9a6DfjDs1P8+fpg+n+qf1Smen89K3697SPJlay4evNa2Ta7ts/E3sbM+RQSh8HHli6pZ9LxXvMjyZg/eEVE3wTq08VBj/tkXyvXFsPgXP2Oq6gEFrmaDvpT64kF8F6ch3dTmuZooNt9+shZWaDJl96S3tAJV+XulQJBYT1Rokb6i3B6EejcNHn26SP/sKES1lZiE7BSEt5ijcHAjyAmNYANBkQRqqAnlFj9XJbmmxQUZZVHUhtDIou9MNXez5LmqhTfUte77MNDSa2m78eqlDFkCJYDZ4054TKNgUpCgXjkqetTIBrGR9C/4da/I8upKD0oZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IMoGrYIFSq/299LrLC+Cmvz1gGzoWnTRpZiHl06bYEI=;
 b=CB3bk04aEqJ4LzBP0PANIcpcj4dCb1+gs7PYYggdspg73yrBCeA4K0z05j9mzK6AFjt+iuJr3dI4VAUPc8rH7sOe1drmypwJJT2uAziCVUO44Z/xH3ZPz2qIpzHC82rld0semt+InJqcirDn8OJY3g345Cury723rT1J4aleegGRJ5CwGgOuwEA91wHLJnUGV97NHaG2yGHnGJrYbiRB3I45MHtQWFj3nuEIt6/dawN+goO74zji9fyObTEbKl86JcIM6vh5Q9Yf4wXCQ57zGu77sxVW8psF04fQyAcqkEootkfYBW1kW5AO85iyCfNvLRmfDdSuAolGZCqcVBCxrQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB6619.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3d3::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.14; Thu, 7 Aug
 2025 10:29:35 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.9009.013; Thu, 7 Aug 2025
 10:29:35 +0000
Message-ID: <bacfa48b-4b2d-41fc-8e8f-ebc0e3727170@siemens.com>
Date: Thu, 7 Aug 2025 12:29:28 +0200
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
X-ClientProxiedBy: SI1PR02CA0024.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::12) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB6619:EE_
X-MS-Office365-Filtering-Correlation-Id: a158ea2e-c455-4adc-a8d3-08ddd59d4ddd
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?V1FqckFBaFVueW1FTE9QUmNOeWN2Mzl3Mk81SmRuc0hPNTQ1UG9Ua2VZc28w?=
 =?utf-8?B?cnpSUjROWGJnejRFYnAwSVVYUnBCZCtWaXNLOGJrYko4VWlncHloT0F5cEhM?=
 =?utf-8?B?eXV1dThqZzVLNXNONk5ha2FUeHc2U1k1cVI4WUhlV2NVcEprUUhtLzA4ZWk2?=
 =?utf-8?B?Wnp0R3Nad2l0eEwrSTNBK0dXWGkvaG5YQlNkQWt5WFV5ZzNHc2lnNWdkdlZk?=
 =?utf-8?B?TTN5QmJOalA4MWowMUd4V3FXZDROTmZyVmdSeXljVWlxSGNmRTQ2cDF5TWdI?=
 =?utf-8?B?UE53Sm5ZRHFRYytKSlFDVEhuS2c0N1JIL0ZBZ3U1T0x1dWNZa28rVzZpMWI5?=
 =?utf-8?B?TTRpMUNZbnNIYmpPeU9HVmxudjdzYzVsdXhlM2wzVVFpRmYwM3JhTFF0cGJU?=
 =?utf-8?B?L280WURmakFOb0k2bDlqQWVuL3VlWXJtZmd3RC9oTEg2T0d4ejhOSkYxMSsx?=
 =?utf-8?B?NXpVeUVWTGJWVkN5WldFb1NQbm5PNysvSXMwNFZOeHdYZGRKY1hpYXRZNkRX?=
 =?utf-8?B?NHIrYlVPUTlyMVRHQ09JcTRVSXNkQlFTMmMxQmJ4UVordGlyV2tiZjhXSkNh?=
 =?utf-8?B?cmNvRGorSmc2T0M0TWFyWlczQWlRZS8wMjR6Qmt5WWhqYzlsSWpEd0NTSFlt?=
 =?utf-8?B?RnF6NXl2SEtlSzkySDR4aEZDeEhvVEVwWUtUSC9uZlhDVk55Z3NXbkMzZ3BD?=
 =?utf-8?B?NjhSU3RJVC9GM2g5WkpVTHJtQVZnU1RjY25XaVRSVkMwT210ajcwREJSc29a?=
 =?utf-8?B?blJiUDZEcHN0eDg3K1lxWkJJNk11ZEh1dHcvUkxZZmZpaUxMc1BIZmw2a0tz?=
 =?utf-8?B?UUp3STIxcFpIWUNYOWRLWHNIVWIvSnpqZzZVdklRV3Nzd3I4TzMwQkdsRndK?=
 =?utf-8?B?dFljYklGYzRYNUFSa2tsQkRVcFg1aDByVEJGQWVUbDBDeGRGUVRxbTNBRDRP?=
 =?utf-8?B?ZGVXSkYzMDd5VGt3MDdjYStTTHd6UE9ZMUpLeEdYa1NGK2srQXBjR0tmT2No?=
 =?utf-8?B?cVpBK3V0NmdHcG05ZmNEeXFuUHYxRjNZQmxEVVJ4WG4xUE41Y0I0bi9JQWZn?=
 =?utf-8?B?aXFIZ2ZWckdEdHkrMmNlWXVUZ1Bkd1pwVmZCYnQ0VDY4V2RtVXY0aDZ1RDl1?=
 =?utf-8?B?N2JYVU8vcXAzaU05c1V4cE9MWHAvTnljUUdXM0ovVlRsZEUvc3V1YUJva0wv?=
 =?utf-8?B?b0hqQXlwd1F0RmI3YVdCaHNEcWVaOUhaNTFLR1UwOThVNGxGcEtHUjltZjhV?=
 =?utf-8?B?VTZ0NnFseWQzNStRRjhsZVZDZVBEVnVoditnODh2VXUrTU5PdVpkK0RjdGo3?=
 =?utf-8?B?eWJ0dnVPL04vdzhyZWVuOXV2UDF4WnpuNUxtekpyQnFjMWRxemRZTkJsdm9h?=
 =?utf-8?B?QXlYSllLZmY5VVcvbzhPSlB0UE1nNGEwbGpjdFF1UHNtTkZtNkVBd202QmFU?=
 =?utf-8?B?M0RrZmsvTUc0aVNmclM0OWU5S0NpdkI0Ly9RYldyQ3B0R0JXZTRlQXdpRmJv?=
 =?utf-8?B?VHRMb3NIUzNXZHplNEliYWVPOS9TTnZjcnVqMXpqdjBESElwOG9qVEdEWTJp?=
 =?utf-8?B?TDQxSHpNY0pSa2hwZklTYldvNlY3ZGlyd3FvUEg3TFM5M0Q4cGV2eEdFd3ls?=
 =?utf-8?B?N3QrVXNxNkVhQ1hZdGpwUFN2Mys5cFcvL25USkhaZ2VQakUwbDJOcFlZSmR2?=
 =?utf-8?B?clRLMSthWHhMaFdjOXBrSCtpYXdrQ3J1bDNIZlRHQ0RBRnU3L01BaDh1MkpO?=
 =?utf-8?B?UmRDL2xQWkU0Y091Znp0ZXBkWEg5MFVkUU5URUhkWEhGNGIwWkZ3VDMrbmh4?=
 =?utf-8?Q?S7mS11URrS7OwHIacGHvwsg1fWFg5Zn5qEMKw=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Z3Z2dUdCWndpa290aFFqNFZZcmFhYmc5QTlOTllZeWxZWldGcHJUVWE4bkhK?=
 =?utf-8?B?NmN2dkNRVlJneGFoSkM5TjB5bk01RXNjaTZOZ2VXbEJ4RnI0SEJYcUpiVVor?=
 =?utf-8?B?aHhRYThaWXZTVDNHMy8wWndWOW80WUFYQU4yVmIrRXBIekVQZHV5cjczT0F0?=
 =?utf-8?B?c1oxL3gwRmVKdSt6WVFOb08wQUN5UmJZN1FsNmpJL005ZFV1aXZDdjV1RXhN?=
 =?utf-8?B?aVA1MW9lckVySXdxK3NGd1E3a3Vvd1BGbXM4T0tSWWlJbDc3MkJMZURGV2lT?=
 =?utf-8?B?YUNENHF5OW14UnF4bkg2aGdqb3NUN3RrT1BjeWpTVlZlaldUcXh1b2RqNkVw?=
 =?utf-8?B?VG1LRmJqUndKbHI5NkYwRG9zYVFhZkNPaFNHendnWmZDY2VSUDd6MW5qdEVS?=
 =?utf-8?B?WGFoRVBYYUU0L0ZUNGJSRFo2dkdFMnhkZG11dEF1ZzQxTXFjdnh2RnNlV1RV?=
 =?utf-8?B?K2RyYnZPSEpTTnY2ZWtxZTJScklOdmt0SVU4a2lxUFVhOFd2NnovSE9VMHNp?=
 =?utf-8?B?cVFWaXY2UHZlVXdabEZWTE0xMVlZa2w2czFkc1ZucEpTT2V6M2ExcDNSa2Q4?=
 =?utf-8?B?TWg2Z3h6Znl2LzZMV0lCaG1CNnJ2VVRnM1phM3g0WUd1YlJPS3R1anBGTllS?=
 =?utf-8?B?aUFPcm4ydWVhVFJkazNWcTUzZDFrSnZZZVd0aXhTbU5zMjUvUTNjUFNrVDZk?=
 =?utf-8?B?UzZLQ2VtTU0yaUtSWlZ0bjNkOTJNdDhuZk0raEpFNzI4VXl2czRlQXROejlk?=
 =?utf-8?B?Qk1zd3pEQnBwYU92S1l3MmFTMHcwbjI1dnRlbTcvdGg2WjRkMFNveHMxQ1Js?=
 =?utf-8?B?Ry9yNXNZV2dEcy8xdXgrWlJuYWJuSEQ3WDQrbGhxZzFKVkVudFU3SUpTdkJT?=
 =?utf-8?B?eVRaYkpteTVyWWY5dlJHVzlTOUFWU1U4bTlEUnp6WGVaNnNYWjY1dVF3M2Nv?=
 =?utf-8?B?MmRKd1kvMmRkSlc1U2dUaXNwWThsdlkrMkJDY2Z4RmEwMXkrV2FGT0pCdTdU?=
 =?utf-8?B?eWQ0aVB1Q0x4bFVRUVg1NWxvTWNKcXcwb3BPT0xYREgwaTBKM05kazZkR2NR?=
 =?utf-8?B?VjNBblZhb2pOVE5UR3BjWFU2M1JDdVJmL1pMQkVZZUN2YUJ5dkJyOElVbnJh?=
 =?utf-8?B?R2x1aU1qeHErSW1UTGNKWGFLWTRJMm1pTFdlT0pleTRCYkhTT3laTndZSmRr?=
 =?utf-8?B?ejFkK0VFMUxMeUFiajN2UHpCNThnT0M3OUVCbmdhWWFRN0kyUE5DMjNzOVN3?=
 =?utf-8?B?T0NPKzVBMnFNMUVpREM4Z09Yb1ZVVW9DUHhCSkJLM2pNSHhiMFlJei9zMDdL?=
 =?utf-8?B?bGszZkJnR3FRanp5SGluSnBzN3h0b2xNZ081bWNVM3c4UDRaNjdPSW0vTk0w?=
 =?utf-8?B?N1RoM3NhMjczam9qVFl5SjcwNjd1eXRsUGZnWjBhM04yaXc0T0NYTktoTmRa?=
 =?utf-8?B?K2hieHdoR3VyZUxheHcvSUdtbFZyamJtajFybGFyRENxM252U1FDNkc3ZG5Z?=
 =?utf-8?B?TlYwUGNvTVUxNW8xVGRmTGVjVHh6RnVpWjg2NHg4RmJPR25OeFJyWDl6azg2?=
 =?utf-8?B?dXN2RXFHRDZXaVZlUTR0eWY3bmhhK3NGNUFQaTNSUEdDdzlHUUJ2NUY0Q1Vo?=
 =?utf-8?B?TGFQM084cWxiaU9tS0VCSkZLdEcwb3RCK3RreFBoRjh6YUh5MldxRlNWZStG?=
 =?utf-8?B?K3RWQ2xua3N5NDNmT3JtSTBkYkxGOVkxYnF6L3dLZXpSZG1TdzFjeW4zd0ZJ?=
 =?utf-8?B?S0dWOTZqcGptTUQ1eUI4cjBTSTU3U05Nb29rd3c2Vks1eEc4ZVVEd0xNam1u?=
 =?utf-8?B?K1lFTm5Sang3cWljMWhhbmZnSmluTEMzNDFtYTdzazc1cVFlbHZnaFlZR3pI?=
 =?utf-8?B?QWJsWEpHUWNWYXlObjBVR0xyQkRPVldiZDhXU0JXUXNyNUl3UzNtUWxkV0F1?=
 =?utf-8?B?M2JNcS83Z1hoLzFtQlRsUFJLQ08rTHNJUmRtc2x4Rkw0RVp1cmJ0RTFEd084?=
 =?utf-8?B?VnBLVkp6bVVSamd6b0E2aUsva3E1d2RscDYrREZYcGhjRWRRaFppK0pudzhi?=
 =?utf-8?B?d3ZGSWE3OUM5a2gweGFoa2lReThGTVZwdTY0U0t1bUxlTXg0UlFzS2Nsc09H?=
 =?utf-8?B?YnhsUTNocmcxemd1YkdWVFZ3U3U2YmEyNmlIRFFyZlpuVXpVY0tuT2E0M1ZW?=
 =?utf-8?B?THc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a158ea2e-c455-4adc-a8d3-08ddd59d4ddd
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2025 10:29:35.2742
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 19mfkEvn6j1sh7VejoLb0bCAVMz4ySfzfVn/wr6KF+qeHqWXE4juZcj3WUcfdDl1VTHmQbu6LB6raxAoSdyqPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB6619
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 07 Aug 2025 10:29:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19708

On 22.07.25 12:15, Sai Sree Kartheek Adivi wrote:
> - Add machine conf and and kas yml files for TI AM62Px SK
> - Add new u-boot 2025.01 recipe as support for AM62P is only available
>   from 2025.01
> - Add new recipes for trusted-firmware-a, optee-os
> - Add new initramfs hook to include TI kernel modules in initramfs image
> 
> Signed-off-by: Sai Sree Kartheek Adivi <s-adivi@ti.com>

...

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

I was just reminded that git.ti.com had several availability issues in
the recent past (see also
https://github.com/siemens/meta-iot2050/issues/614). Are those resolved
now, or will we face them in our CI as well with these fetches? Should
we think about caching downloads then? Or do you have some fallback
mirrors at hand?

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

