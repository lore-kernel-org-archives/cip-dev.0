Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1074C3DA45
	for <webhook@archiver.kernel.org>; Fri, 12 Jul 2024 07:39:50 +0000 (UTC)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (EUR02-AM0-obe.outbound.protection.outlook.com [40.107.247.42])
 by mx.groups.io with SMTP id smtpd.web11.2856.1720769987466456818
 for <cip-dev@lists.cip-project.org>;
 Fri, 12 Jul 2024 00:39:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=FN4SttPc;
 spf=pass (domain: siemens.com, ip: 40.107.247.42, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vdt5Y8HiVwIM4lfuInU91ErfS0VFU2yP3fzA22CtfUttVjSUNdW5jva+YJNUgikukvoc26tr4UbKBX04RV1tfF8ZOcL2cwhX+pNG+czFZha23Qk9yEXR23Fyfd+R35qpS64V7mriSqJQwiDlL7dPe7YDmwK0KHxsat8k26pAM8B5X+GQqKebw2ADsklZw3+2St/LJfUr8k9kJhb3l2PJyxJ39Xs/G3KEyt+OC4kvv8ELcZcNlYd1JQ0UyieqP+tW/iGW3AcP7wu90yTJZi5G03IwpBY+oUsR0oxqe7F/RL3voaEEv3Kh1TO9bb0m4EKaH9l0VE9Bf/X6nyaUyAznuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rfVUmvOf+wp/18rGxFJ1I8wLO2aGe7cXqRdncsI1bjU=;
 b=Iaw6eTS/bVSk1mYzNt7gaAXHcJ3OyTZxrdad5ru1r02hz5ai5f2sTnbEABnLYcJcZGYvWjB7D0ewmYi2VPTQkFhe0nYX9Ehm6hHBK+G2vM6pNdB/N2OyC+QRQw9r/UKiTf97oktPtYozRbBInrEQ2oNpAQRgRv7ug6PZSYMobKQj8k0FSj2eC+QiuOVrRpMSyR9/XSPUutveQ3V9j9D3k77gXR4AFoEhYhFzHkq22V9rjRI3toOvzcCEJB8xfMRPC8z+hK+0T9+XMWHFHNwANizqCEhyZAFLyAkpkEJOxSfuR3P8A37+5H4M6trjseHCvdpjWufNa5p4+rHTQnHDjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rfVUmvOf+wp/18rGxFJ1I8wLO2aGe7cXqRdncsI1bjU=;
 b=FN4SttPc5Kqc3VWnVLSzn7YnQ73oUkAosDjfbbdQ5EipBfHmKoW9o7duarL5nOWPsSZ+1/LOtWYepLuV04cDrK7XG91WM6qwitrx9W4KAzfZd/J6EQBSBjMAY/OTO0RxWqnJ1RiZIN/GSYGFIF8/U7o6UBagvLRp0xPVHbMCGd94ILJ8Q+2KhIZ0rucvVQt6X5wa5P2WdwV/pbvyRRPUYtEXf2c/C3PPNPX4TFrTV/J2PkqFdDExTmmxDwI2zR65I83RSPut/ParzHmuoHPPWLXnJTJNnS5qD+71Sp+nF1d8pJp0sraKAlal0vDuVRJ2CCvqeptEGQVsZt0q7H61qg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by DU0PR10MB6129.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3e4::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.23; Fri, 12 Jul
 2024 07:39:43 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3087:c116:dfed:1ca2]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3087:c116:dfed:1ca2%7]) with mapi id 15.20.7762.020; Fri, 12 Jul 2024
 07:39:43 +0000
Message-ID: <f89cdb44-855e-47a2-b455-5a95dd579007@siemens.com>
Date: Fri, 12 Jul 2024 09:39:40 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH v3 2/2] initramfs-overlay-hook:
 Check file system of INITRAMFS_OVERLAY_STORAGE_DEVICE
To: Jan Kiszka <jan.kiszka@siemens.com>,
 Clara Kowalsky <clara.kowalsky@siemens.com>, cip-dev@lists.cip-project.org
References: <20240708124734.591324-1-clara.kowalsky@siemens.com>
 <20240708124734.591324-2-clara.kowalsky@siemens.com>
 <63f09b2e-7e46-4587-851b-b6140c191f96@siemens.com>
Content-Language: en-US, de-DE
From: Gylstorff Quirin <quirin.gylstorff@siemens.com>
Autocrypt: addr=quirin.gylstorff@siemens.com; keydata=
 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
 XSdq0hnpafc1V+voPJq3LMxUvLNrwg==
In-Reply-To: <63f09b2e-7e46-4587-851b-b6140c191f96@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0083.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1e::18) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|DU0PR10MB6129:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ba71738-dfaf-47ab-1c33-08dca245cbd4
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?dzJEQnV2U0pTdkx0ZExIclk4cUc4MTE2c0g0aXNGK3VUWGswMk0yMitFL0hp?=
 =?utf-8?B?NThISDFPMDVJdGlpRWExbDFIK3NzcW5NelNYR1hta0VHUzJ2L25vV1BzREZZ?=
 =?utf-8?B?OGRlNlNTaTZUUW43eWdqZ3JaajQ2T0grUDdiRU1wWG9MejNKYW5iUGhGVy9C?=
 =?utf-8?B?RnJ1Smk4a1RrekI1NzRRaGhMQUhZYkhsbnJQK3lzcXN0bjhKSUJ6VHRNdEpK?=
 =?utf-8?B?bEJNQk9jRWRnMEsrYlQyWlBBK2J0RzcvbldwdFhkNHVIeXNjeThZNVdvR2w0?=
 =?utf-8?B?OG1KbHRJSFVZQllBZUhMUExyZE9Mb1JURHpNbENiUmJXL1lMRUdUcGtQbkNa?=
 =?utf-8?B?WFFyODFUMWs5dHZoTTBma1MrQ3JjdWhFYVhFamZjejlNaEwwQ3RuSTc0Zk5V?=
 =?utf-8?B?VW1xNXFUcllIZFFVN0VaZHo1S1cxVWRyLzlhZ1dRYmM3ckpMQ3ZtV01HMHBR?=
 =?utf-8?B?TTZFUmFRVGZHMHJvTlA5ZmVvT0ZrSll2T0M0N1V2b3JWM3BtQ1FUVTg1WWFq?=
 =?utf-8?B?TXdkdTNHSTF1Z0FjTFhMdURLaFA4bG93SnAxRlcxVkJVSFFNSFlSd3d6cGcy?=
 =?utf-8?B?Zjh6b3VwdXJOc2taMXZNeGRjMjNPNU9qdjhKRGRHbmxBdW43RXZoTnBManQy?=
 =?utf-8?B?dlBsTmNSYWdIZGFuekU1ZUZEd3dyYmZYSHROYzVQSmw0VEJ6Rk9tS2ZqSFNK?=
 =?utf-8?B?YW5EdHpjRExMQlJDUlZzYzZEQUxkS0g5eHE2Snc5M1JSWmxlZUJJMEtJWGRy?=
 =?utf-8?B?bk16L0MvQ2M3WHp4S3dkb1FxWGRXWGdCK28yMjhjS0ZlbGUzRGkzeG1WMUpR?=
 =?utf-8?B?dlllUEZhL1ZQWnFjZ0YrZW5XbWM5OWdtK0N0K0NFT1B4bCtoMjVkaDFzYWJN?=
 =?utf-8?B?NHBETWtkT0pMWGhaU3ROKzJYdW1xMXN3anFyOFp6Qzg4TU51YmpOOWJKb3pS?=
 =?utf-8?B?Zlh2THdpR24xZTh2T0xqVHVmTXdjSyswdE0rdmNUKzNUc1RwV0RlS2cvcXhj?=
 =?utf-8?B?UllVcGdMU2FQWC9QUDBLYkpYbjlTK2lVMTdXRFN4OC95QXBuM0k2WlhvbG1z?=
 =?utf-8?B?cEFiVlNoQ2MzaEExNlluckdHU3QwQVV2ZTRhNEVNL1pvbHJyNDRSUWFkOW1z?=
 =?utf-8?B?UzhhMkV5ZVIvWnF3OElFdVNtUFVQK2ZUUFJ0SzEwZVJuVTVwc1FJemcreEpV?=
 =?utf-8?B?cnBWTk85QUdpMmN4NUVhbHdKL1VvZEtpNUhlRnNZTGl3dTlxRFdZNmM5L3J1?=
 =?utf-8?B?bWc4d0VBTXdUZ0xFWlIvRzVVSlV1cW9TVSs3cG1OVWJ5Q0RpSm9pT2tUZEpT?=
 =?utf-8?B?N0ppQUE3SDErN3VnVFNDVlNvVnlteU1KTTYwZWRWb2lKMmhRV2NvbUNKWGd2?=
 =?utf-8?B?bVY2Z28rMmVTYUU1TUhCM2RCVEsrcGlyYi9zVHY1Rzl0NVVQT0N5MnYyV3Z5?=
 =?utf-8?B?eEtnSGlJcHNVTDZSK2s0NTQ1Y1kzd0VrRkR5QTdQb2pGMDd2cmZlNVZBL2xU?=
 =?utf-8?B?MkVoUnZpOUxqNnhsSHRuQkJ6RUZ2SWZkVEpjVVRJdnViQ2lXSFpNQTFrM3Ay?=
 =?utf-8?B?NEh0MDkxK1kyNmpvdzFRa0NCbXdqNWJkZDE2MEh5alhyYzR2UUtBdnhmS0Jp?=
 =?utf-8?B?T1AzY0hxV0xlK1k2RXhDOUx1Mm96YjRMNEUvcUVjTHlERm1xRm82dHpNTVY1?=
 =?utf-8?B?N3ptRGlMSnpQbHFrazY5VFZBT3kxSTZteHdGZzl1ZXgzU1hod215eEdHVEdP?=
 =?utf-8?B?L2NoUEhMTmhqOHc0aHdWV0VzejJJTk1GMWdSR1Z6bXIzL2R1S01uMDFWc1F3?=
 =?utf-8?B?aDFSWitDWEptY2xtSmJ0UT09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Vks4UmtVc2FuYm5mUWJGUE1FRmkyMk5nWUpXQTZWZVRZaUJKbGRNNzhVMmtm?=
 =?utf-8?B?My84VUVaVWllSjVTVXVkWG9uSFRrQ0NSNDJrbFZlcXppT25FbmlFZEhqcVBU?=
 =?utf-8?B?UTBsOHdSb2RyNSt6VGU4S3dSbldidVpxSW12VG0wQmliUGNoQVlWQUowdGg4?=
 =?utf-8?B?TWNzY3M3cVZud1B6VkdMYmFUMXBmcEZiNkJVOXh6ekwwMWRtQmpWZjZOSlZk?=
 =?utf-8?B?d09sSE9IQjhjNzM3elJyU3RUUERxT2Z3TzlVWW8vOVVpODVQdFpGTG1hTnRi?=
 =?utf-8?B?aXIzNnR6blpqbVVIYWlvTHFvd1JyWmxkOS9HTFA5bEwxZlk0dTdCWkFINm9V?=
 =?utf-8?B?UHlDdnh0aG1MLzYvNXluT1pMYldPY21USWVLTVJNMlAvRU9rQitGeDBsUGNs?=
 =?utf-8?B?WmdSakYrMExTeXpRdk9yUGJwU0ZPWnhhQWEwS3lTWFhac3pqR0p0MWhPeG5o?=
 =?utf-8?B?akhpVkxPaGdPNDN6YVZPV1MvT2VLelBZc2ZxMVlkZkp5dkhwMEhDZDJ4U3ZY?=
 =?utf-8?B?ME9KSmVtN0ErVG1aOG1QNTRNSUJLd2FQU3ErZmVLN1l4YkxJYmdWT1dWdTFE?=
 =?utf-8?B?YVFqenFya04zWDRkQWh6SUd2RXlRWkVPcmRZaTZJWCtna3VQOUFJYTVoSnU3?=
 =?utf-8?B?V3U2eFdMMnFMeklvUjFITFQxeWVSMzRnWitiUERLaUdOQ2lscFlBTlI3VGhV?=
 =?utf-8?B?VDQ2ZWU3MUJPVEV3OUEwYitIODl5c21LaEpFSVR1aURuOTFsYmN2L3FYWHNm?=
 =?utf-8?B?VjUwaVd5dEZYYmpES3VpZC9acnIxKzM0Sjc3bCtjdTh3NldLZ3FFVDR1TzM3?=
 =?utf-8?B?THFHYlkyV2N1Z3gwSWFKZ2M2WTJWNm5JV3NzVWFkZnhaNlV5bFhSUC9maElS?=
 =?utf-8?B?VW9TMll5T2FYNWZqK0tyWDZZalhtSkpITGZ1eFJQZXJwVzN5TnhEb2U0WThP?=
 =?utf-8?B?VWQzS2paanJEdkpQT3MxWVhaQzMwbWZhUDZOUzRoWWRVVmltOGZnMW9TdGhI?=
 =?utf-8?B?MERWLy9uRGp5SWxvWldEVW83OTVuM25RVG5xSzlxNE9yQ2hSL1RyeFVQUmN0?=
 =?utf-8?B?eG1wS1RidGNFdzNYb3JmK09vMzgwMWhkK2ZHTW1FcnpvMzYwZU0yMnFYb3Nk?=
 =?utf-8?B?aTlFbE5LeWh3NDZ2b3BBczFPK2NiRE8rVWdNOGZDMTFtOVMxM1lnZ2JlZ0tX?=
 =?utf-8?B?eUdwQzRHQ21xTlU5KzRZVitlRHJzZGlZVXI0NEdrZjlBMHBKMWU0bitYNzVW?=
 =?utf-8?B?WHd1TXlYL2Y5LytLbE5xV2JrMytUN3lzM0N5QlQrQjdrSjRyR2oyRFJIMmRm?=
 =?utf-8?B?M2pxRGM2VVRWQmhuWGY3Z3l5Q2JQeC9qVzBNWHlDaS9uek5QVHJPREJwL1hZ?=
 =?utf-8?B?NjYxNzdRTndVbkVUbHdSSDlDZWQ2SFppWGdIVGI5UWJFWnZyTkxpZW1kOWJF?=
 =?utf-8?B?YmlkYmsvVC94RHV2YUI5Mk1pRzBsdFBRNXNpWWt0UUpFZ2pTSjJVdFRwaHBz?=
 =?utf-8?B?Yld1VnZSVmZzNUdCN3dtSWg0ckhCa1BiTVc4MnZtb3BzV1FNVHVpeStoUUR0?=
 =?utf-8?B?MUVXRkhqNjVwNjFEYXdCcUJiaDF6b2hXWUdKZllpc3p1NFRxQUZIWWZEdlE4?=
 =?utf-8?B?U3J0aEhVRjl0c1dQcU0zQTNDZkVXTWhYYm9IUzd4TmYxbVZGUFdrNC9TZ3JW?=
 =?utf-8?B?K29nSHhhQm80NG54MXJXQWxpblIwZWFwNGliRUNmZVI0enhRZHlxWkFCMW9p?=
 =?utf-8?B?UHJFc05TS1MwcC93dXl6N1JhQ2xWaU04VkpkbVR3dVBQbGFjVnBkYTdOT09X?=
 =?utf-8?B?Y3ZMLzhiZUI0S3pYSml4eHlQa3ZTTHVwZCsxM01jUEprTE1hYW1NNmhDY1BL?=
 =?utf-8?B?MTc0cHRua1dmRkNtR3dZenJzOFg5TjNpN1JUMVlsdEdLYlo0UFMvcXpqUW5E?=
 =?utf-8?B?YkpFcVc3cUc5NkFUa21tNnUzOXdXWHB1a3EyRm93OHlMdHJDb2hMbVlWVnNp?=
 =?utf-8?B?QncrS1ZTcmdvUnpTVFNteG1LdGNIYjY3U2xtdHhWT0hKNVNYNDNVUTdDSEl2?=
 =?utf-8?B?bzZUOE5YL1pNQUsrMkFnb2dna3dkcnBDbm9PRjRmM2hXT3lYY0JCL3pKWEFh?=
 =?utf-8?B?RW1MYTNtdXEzUHM0ZlZGU0hGdytYampXMDlUNFNQRDZRdW1qTmc5cnBicSt3?=
 =?utf-8?B?emc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ba71738-dfaf-47ab-1c33-08dca245cbd4
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2024 07:39:43.6978
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K9P2ZsCzWYYy32eR9QkPJP2yJeZjR0OKi5IGY7J/16nBLpD8VA5KA1vaXlj6Zqn8JL+pRo2NHkt8g9axnnv1b3SlfikYuEsD9136Ta50ofQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6129
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 12 Jul 2024 07:39:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16455



On 7/12/24 9:23 AM, Jan Kiszka wrote:
> On 08.07.24 14:47, Clara Kowalsky wrote:
>> In case of ext*, this detects and fixes file system errors in the
>> partition device before doing the partition mount.
>> If the partition turns out to be broken, the factory state is recovered.
>>
>> Signed-off-by: Clara Kowalsky <clara.kowalsky@siemens.com>
>> ---
>>   .../initramfs-overlay-hook/files/overlay.hook | 11 +++++++++--
>>   .../files/overlay.script.tmpl                 | 19 ++++++++++++++++++-
>>   .../files/overlay_recovery_action.script      | 17 +++++++++++++++++
>>   .../initramfs-overlay-hook_0.1.bb             |  8 +++++++-
>>   4 files changed, 51 insertions(+), 4 deletions(-)
>>   create mode 100644 recipes-initramfs/initramfs-overlay-hook/files/overlay_recovery_action.script
>>
>> diff --git a/recipes-initramfs/initramfs-overlay-hook/files/overlay.hook b/recipes-initramfs/initramfs-overlay-hook/files/overlay.hook
>> index 8b00ecf..6f634c5 100644
>> --- a/recipes-initramfs/initramfs-overlay-hook/files/overlay.hook
>> +++ b/recipes-initramfs/initramfs-overlay-hook/files/overlay.hook
>> @@ -22,6 +22,13 @@ esac
>>   
>>   . /usr/share/initramfs-tools/hook-functions
>>   
>> +hook_error() {
>> +    echo "(ERROR): $1" >&2
>> +    exit 1
>> +}
>> +
>>   manual_add_modules overlay
>> -copy_exec /usr/bin/mountpoint
>> -copy_exec /usr/bin/awk
>> +copy_exec /usr/bin/mountpoint || hook_error "/usr/bin/mountpoint not found"
>> +copy_exec /usr/bin/awk || hook_error "/usr/bin/awk not found"
>> +copy_exec /usr/sbin/e2fsck || hook_error "/usr/sbin/e2fsck not found"
>> +copy_exec /usr/sbin/mke2fs || hook_error "/usr/sbin/mke2fs not found"
>> diff --git a/recipes-initramfs/initramfs-overlay-hook/files/overlay.script.tmpl b/recipes-initramfs/initramfs-overlay-hook/files/overlay.script.tmpl
>> index 42eb59c..6120615 100644
>> --- a/recipes-initramfs/initramfs-overlay-hook/files/overlay.script.tmpl
>> +++ b/recipes-initramfs/initramfs-overlay-hook/files/overlay.script.tmpl
>> @@ -16,6 +16,11 @@ prereqs()
>>   	echo "$PREREQ"
>>   }
>>   
>> +recover_partition_from_fsck_failure()
>> +{
>> +	true
>> +}
>> +
>>   case $1 in
>>   # get pre-requisites
>>   prereqs)
>> @@ -24,7 +29,13 @@ prereqs)
>>   	;;
>>   esac
>>   
>> +ovl_recovery_script="/scripts/${INITRAMFS_OVERLAY_RECOVERY_SCRIPT}"
>> +
>>   . /scripts/functions
>> +# shellcheck source=/scripts/${INITRAMFS_OVERLAY_RECOVERY_SCRIPT}
>> +if [ -e "$ovl_recovery_script" ]; then
>> +	. "$ovl_recovery_script"
>> +fi
>>   
>>   
>>   ovl_partition_device="${INITRAMFS_OVERLAY_STORAGE_DEVICE}"
>> @@ -34,9 +45,15 @@ ovl_mount_option="${INITRAMFS_OVERLAY_MOUNT_OPTION}"
>>   
>>   root_mount_storage=${rootmnt}${ovl_storage_path}
>>   storage_mount_point="$(echo "${ovl_storage_path}" | awk -F/ '{print FS$2}' )"
>> +partition_fstype=$(get_fstype "${ovl_partition_device}")
>>   
>>   if ! mountpoint -q "${rootmnt}${storage_mount_point}"; then
>> -	if ! mount -t $(get_fstype ${ovl_partition_device}) \
>> +	if [ "$partition_fstype" = "ext*" ]; then
>> +		if ! e2fsck -p -f "$ovl_partition_device"; then
>> +			recover_partition_from_fsck_failure "$ovl_partition_device" "$partition_fstype"
>> +		fi
>> +	fi
>> +	if ! mount -t ${partition_fstype} \
>>   		 -o ${ovl_mount_option} \
>>   		 ${ovl_partition_device} \
>>   		 ${rootmnt}${storage_mount_point}; then
>> diff --git a/recipes-initramfs/initramfs-overlay-hook/files/overlay_recovery_action.script b/recipes-initramfs/initramfs-overlay-hook/files/overlay_recovery_action.script
>> new file mode 100644
>> index 0000000..a05e4c3
>> --- /dev/null
>> +++ b/recipes-initramfs/initramfs-overlay-hook/files/overlay_recovery_action.script
>> @@ -0,0 +1,17 @@
>> +#!/bin/sh
>> +#
>> +# CIP Core, generic profile
>> +#
>> +# Copyright (c) Siemens AG, 2024
>> +#
>> +# Authors:
>> +#  Clara Kowalsky <clara.kowalsky@siemens.com>
>> +#
>> +
>> +recover_partition_from_fsck_failure()
>> +{
>> +    ovl_partition_device="$1"
>> +    partition_fstype="$2"
>> +
>> +    mke2fs -t "$partition_fstype" "$ovl_partition_device"
>> +}
> 
> Why do we need to put the recover logic into a function? If the script
> itself is the interface, we can save a lot of boilerplate and can also
> avoid that sourcing with the shellcheck annotation.

I suggested the function to allow an way to overwrite the recovery logic
in case another behavior is required by downstream.

You would call the script directly?

Quirin

> 
>> diff --git a/recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0.1.bb b/recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0.1.bb
>> index 955748f..7097130 100644
>> --- a/recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0.1.bb
>> +++ b/recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0.1.bb
>> @@ -12,9 +12,12 @@
>>   
>>   inherit dpkg-raw
>>   
>> +INITRAMFS_OVERLAY_RECOVERY_SCRIPT ??= "overlay_recovery_action.script"
>> +
>>   SRC_URI += " \
>>       file://overlay.hook \
>>       file://overlay.script.tmpl \
>> +    file://${INITRAMFS_OVERLAY_RECOVERY_SCRIPT} \
>>       "
>>   
>>   # The variable INITRAMFS_OVERLAY_PATHS contains the directories which are
>> @@ -35,7 +38,8 @@ TEMPLATE_FILES = "overlay.script.tmpl"
>>   TEMPLATE_VARS += " INITRAMFS_OVERLAY_STORAGE_PATH \
>>       INITRAMFS_OVERLAY_PATHS \
>>       INITRAMFS_OVERLAY_STORAGE_DEVICE \
>> -    INITRAMFS_OVERLAY_MOUNT_OPTION"
>> +    INITRAMFS_OVERLAY_MOUNT_OPTION \
>> +    INITRAMFS_OVERLAY_RECOVERY_SCRIPT"
>>   
>>   DEBIAN_DEPENDS = "initramfs-tools, awk, coreutils, util-linux"
>>   
>> @@ -48,4 +52,6 @@ do_install() {
>>           "${D}/usr/share/initramfs-tools/hooks/overlay"
>>       install -m 0755 "${WORKDIR}/overlay.script" \
>>           "${D}/usr/share/initramfs-tools/scripts/local-bottom/overlay"
>> +    install -m 0755 "${WORKDIR}/${INITRAMFS_OVERLAY_RECOVERY_SCRIPT}" \
>> +        "${D}/usr/share/initramfs-tools/scripts"
>>   }
> 
> Jan
> 

