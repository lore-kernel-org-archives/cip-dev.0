Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DA80CA0FFD
	for <webhook@archiver.kernel.org>; Mon,  1 Sep 2025 09:33:09 +0000 (UTC)
Received: from DUZPR83CU001.outbound.protection.outlook.com (DUZPR83CU001.outbound.protection.outlook.com [52.101.66.29])
 by mx.groups.io with SMTP id smtpd.web11.47297.1756719185703442965
 for <cip-dev@lists.cip-project.org>;
 Mon, 01 Sep 2025 02:33:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=NrbPl0Pa;
 spf=pass (domain: siemens.com, ip: 52.101.66.29, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EPLDZzsJV9QJbIsNIVqN2e4i/YH9WQlvCyda2g2V84VZ1ZAWOM6EjullolKrWUezSOjsiwe13vGHOMCCCbF+fW4Ah341HIEpePucmVxuNe4xCrOJeFW6nhSgDPIO0NkUEqKUyqEmaFGqZpkh1mSKwt63y57HL9Mh9wSe4yq4SlaPdBA8NOEkBwBQPdbL6XalF6mU5ft/rhtCUJElObkLP+Lmn8xMi/FM0RRaPf+X8bGdGvxY0bVdlmGTBludpwA3Ob2z3M8hwQRO8oTlOvfRru3l62pZR6O6TdSgPFXerN62mVGFCJ6p7FdbxwHulcoy9jdc+a7uSca4YjA/0vzeVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Of4c7F3h/XvkamrIxYHq4DTd+3mwHjLlmRJZzCcsOk=;
 b=beLhDQpuRy5Mx/EgQfKWdode13wXAzgrBop0qJoss9J39l3uMfbKVtB/WoZFxrMRve/odP+EB7JIeRkrxmO4MteBIQM046NaQGFcD6xLlb8kZiBYttCiNMiDMeWka9AMOBV4aTYRp0JhrkL0aDF/1EdFd125ETKbZciSp33xQ8+hl5LpAbua95CFQj+ItdO7IYHH58cjQYQ8R8MVT0fLDG2faopM+Mf48Fe6V9yq40ZwfEqln7wqSXeDm/Qz5smEOBHQdPaWq6I2fWuXgMlEcFfr0WNG5QjATuwODA1OOtnDgqlZmRjCOo9YME/ltJYGtraBe37kr2eWam75pyaoyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Of4c7F3h/XvkamrIxYHq4DTd+3mwHjLlmRJZzCcsOk=;
 b=NrbPl0Paz5I3WobBYQL4qFdluDvXb/am2CBSKVGy0ChYN7vo7loAeRNDXfIaMyLQZcESEjauUyikQmnx49RyJNlUTGLMKMYg1zi+kS14VOG1L78zmt/boHEZs8fI/4WAldQVEczQcZ61+lx3avF1o6H+X4BX58pRZ98sYsADdbGk02F9B/ouL5zaARcDfDqqCXuTtW++sZiil8iiFixNSMihVohGmLbhbPfq5rSAZ5GuaS6+Lp/0BfSEYwOdb713yH/UDzEIOodr+N+NO23R27zIwBcoCkEsqccwlHuskg/+SFPOAYbH4KFioAN7M7moRJF24Bj6J8F6WeJ8wKtHgA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PA1PR10MB8872.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:453::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.26; Mon, 1 Sep
 2025 09:33:02 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.9073.021; Mon, 1 Sep 2025
 09:33:02 +0000
Message-ID: <7daa0b69-64c1-425d-b090-e6b694ea4cc3@siemens.com>
Date: Mon, 1 Sep 2025 11:32:57 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH v4 2/7] Add factory-reset
 initramfs hook
To: Quirin Gylstorff <quirin.gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org, gokhan.cetin@siemens.com
References: <20250828110712.392641-1-Quirin.Gylstorff@siemens.com>
 <20250828110712.392641-3-Quirin.Gylstorff@siemens.com>
 <ccd932f7-27e7-48fa-b0b6-5e19881a8f8b@siemens.com>
 <37ffa0d6-9591-467f-922f-4201358e9d48@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <37ffa0d6-9591-467f-922f-4201358e9d48@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH5P223CA0017.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:610:1f3::13) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PA1PR10MB8872:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a7b05e5-80fa-472e-616f-08dde93a8c06
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?dndlREc1V3hvTkl6UW8rMnNJajlxMm5heFVKSWJqd0R0Z3ppOTVmSjAweXVI?=
 =?utf-8?B?NjM3UVVySEtFRkhBWmhoOWpsVm5VQnN0dU5HMmdQdTNHb1gwb1F1eEtNK1NO?=
 =?utf-8?B?Skh0TWZTYXVvdkNTVU8rMWQ4S3UzdEx4akMveHJ6d2pLWVlHRjdtYVJGSXRH?=
 =?utf-8?B?RzRDWVBDbGhucVFGY2lwS2tKRDJaS2dwWWtOay9CS2ZlWHZPN2J4c0dia2N6?=
 =?utf-8?B?cTRRTmovK0xkcmJSMVRBR3AwV1RiTjNHcm9BWWFwOEdNRk1DRmdJSFNoTDJY?=
 =?utf-8?B?RDJlbTV3dHVXTEtDR2hQM3k3RFJqY3NnSHhiWThCdTZlODZBODh4ZFJRajI0?=
 =?utf-8?B?andSWmc3K3kzUGpwSTRyNUtsKy91N3p1emlzVnBCUUk2bGJaWlpSNE9IVFVQ?=
 =?utf-8?B?WFBzdGZZdFBGMDIzRmEzaDM2Zm1OVmdIdFpoekIwZ0I3TVBwWWJwbmZWMmFt?=
 =?utf-8?B?ZmhYZDRmajg5b1dVZmdCTFNHaWNDUHk1N1pQcEhWY0R0VkNFM0pvemRGM21B?=
 =?utf-8?B?Y0IxeGsrVFpGcWQrLytSVVAvUDJCVU1GSnNrNVNBSHpFNXkraG05cmxTWkhM?=
 =?utf-8?B?dGREWEZZS1BXS3hJR1ZFQ29vYUk1MDIxOGhleWlQa0ZDTlBRN3FZbU1yb1Vv?=
 =?utf-8?B?Qm5rTmlLN2kxSTRTaXhSeEdqeVBWTW5RVlMwZytQRW5UUlROTmdnSy9FMDhj?=
 =?utf-8?B?UjQ3ODIwODNaZC83M2hCYmFGOUZhNXVOL1BTbXIzYUdKVVVyOXdGTWZYQ2VJ?=
 =?utf-8?B?VTVEbmlaU1FwV29QeVE1UmJuYm93SGZUY1p3b053Uk4xc3k1ZVVqRVBXMFly?=
 =?utf-8?B?YXYvZGJvUVdxZ2JjQmMxcW9SaXpVaTlZWTlmUzIyZUpJaU9sdFZsNjRobGxs?=
 =?utf-8?B?aTU0RXZ4VjJDLzhwd1drYzU2cEVqcS9SR2UwaFpuakZBcElXYzh4anRqRjhs?=
 =?utf-8?B?aVgyelJqekVnaGoxRUJhUUpUeWVQSVFhZHAwYjlMQ3E0UVJ5ZHFvcnRSaElz?=
 =?utf-8?B?V2t3Nnd3amFoSnI4UktFZWI1dnZFWXhhZEVCcEVJRlVicFB5c2t3S2pUd3Q4?=
 =?utf-8?B?RXpQMU1FRnMwSG95Y3Y5SW5xQmZadjB3NUszNHZTbVY2K0RJN294ZjNDQ2tn?=
 =?utf-8?B?N2xFMDZDbEkyQ2hBOVRaNjRvM3hoeStTVmM5TWNBZWszdGhIUkRGTEFRUTI4?=
 =?utf-8?B?bS9qM0FzdGh6d3ZMV3RZbUZ5eTVhZCsrR2s3Wnc5WHArSzAyT0Y2Z2dDbHo3?=
 =?utf-8?B?VXAzY044Sm43bFY1eGNQOXQ0QUpsdFRHUEQ5dlJQUG9rLzc2LzhYMDdJNFYy?=
 =?utf-8?B?R1FjU2RuOGlVOTlERFhHRXpmejZLTVVFdXNaV0Nqd0JJU1pVRDlQR25rRUN0?=
 =?utf-8?B?d0NBbE41bkVvem1IZnVoSmNUSkRMNzhndUJJNWNHWTFia0RsQ1pNRUI5eC9Z?=
 =?utf-8?B?YisvbWo5cFN6em81MUMwYms1NFRJYjB6Q09zWm5WKzhrNE5PVHNEQlNwWkVO?=
 =?utf-8?B?OUh6SExkTTY4SU5vYUpiNmoxZlYzUGJwYVNCTVBnaTBibEJwMmFDdG9IMTlV?=
 =?utf-8?B?MmlUWituU01PeXJ4VnlXcE8wV1pnbTloZmdmeWNSTDhkL3dBTW4xMWdJNjZ1?=
 =?utf-8?B?eGFiU2FrNnNHako4Wkx2Vi84NDdFZ2pVTTl6cElCTVVGWVhXNTJ1aExOdWVv?=
 =?utf-8?B?WXBkUHJOWUNmYTFub0ZXMENGVWZTYytscG9JYzVPMmROZm9zM0I4N1d6aEZ1?=
 =?utf-8?B?Y3NTVUp5K2U1a1VieTNNM0ZETVNpNmpuYSswREFqUk9MV2hxY2UxbTBoQlhv?=
 =?utf-8?B?aUxLSlRWbm55OGlPZW1oZ3U2L0ZZdmhvU2F4cHRGampra2pPaG82NjRXbE02?=
 =?utf-8?B?WU1RRkl4RFVrT0o4ekxuSStGemZvamNMN1RUQ3dNTldIZUYyejZLSUNjbWIz?=
 =?utf-8?Q?5KFC8+YI/lY=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?S2txZEJETXFsMDFzOEdRUHRBdHNkWWJjYUFvS1ZtdnRvd0tJSkZCMmJsSkQw?=
 =?utf-8?B?czkwQndRUUkrNEI3YmdldDJURjNET1R0YXVvampyQXY2ZXdydUU2dGRnUTBu?=
 =?utf-8?B?cFBrVGFYb3AwMXFjNDJraFN0ZE1uMTBSS3lBMXJXOG0yMnNmTk03bmpUVDlk?=
 =?utf-8?B?cHpDQ1IwbUE0UWZrTEtmb2MwalJiaGVKeTdrSzIxNGFlcmJZaHZoWDlnUEJG?=
 =?utf-8?B?eTdFdlZybWs2d2xLZ3BmQXFJa3kvY0hRYXBFcENlOHQyMW1ObVgzMU5xcHNi?=
 =?utf-8?B?cmJaU1RSWVpVaU1HNnA2aW5yV2JjZHdBR2xOTTJhZzlCUFlCazM3VFVoZlF2?=
 =?utf-8?B?ZDhQSWZMTUNObFZZTjEvZ0o0anZzRE9oQXYrejZBQ2JZR0pyczAxRkdYSXlk?=
 =?utf-8?B?VjArQmVFbnczQ0xJdmlXUy9uZlNFTG4zdHdTZDFRZE5LVzY4NlhOek1VbWpQ?=
 =?utf-8?B?NFpHdnpOZGJYdXFHcEpZWWx3TnRuNm1QbjFaRkVoZkFjZEpocVNUOEwwdEhl?=
 =?utf-8?B?bStFSjJna3ZsaXF0UTJacFF3WDdlYnZ6aWRqZUZ6ZVlzTEx0V1NJb1lYZjY5?=
 =?utf-8?B?UTdRU08zY2dtdmx5cngzdXZhcVlBNlNGeXQvSmMxd3NydDVjcGNULzZCb1dv?=
 =?utf-8?B?MjlScm1vS3FKVDJaeVp6c0oxblNGaGNIZ0c0QzBuZHh2WDNJUWI3SkFIVFBi?=
 =?utf-8?B?NEZwOS8rU3d6UVZHbSs0WlNRNitNQnc1WVVWWjkwQXprSkEyNXd1d25RZ3Ni?=
 =?utf-8?B?bWYrSllLWEpOQzNkbWI3ME83cGFES1IrVjVUUEdGMjAzSVA1Y1lqbXhiSGc2?=
 =?utf-8?B?bFlFcjBNNXNreEswTW5DNXh6SW5INVRTNzByakNIL2tMZjFLK2xuT2JPOTVS?=
 =?utf-8?B?WDN6ZW9rQ0xzcjZQYkJQUzZOd2x6ZHY4VUVIdUtHdWEvbDY2WXh4TmRHUHdx?=
 =?utf-8?B?VTVraGVpNUgyTzZJLy9uaHVERms5bmFILzFzKzRTdTZTc00rb1h5SWh0NG1X?=
 =?utf-8?B?THZINlZWMHVhRVZaV2lXR3pJV0M2dnNnSCtkZFRlMTdvT3lKWkxWUmN3bURG?=
 =?utf-8?B?R2dpVWZEczdhS2R5Q1RJSjlZazBTNmZleFhEQmhsS3poZTFUOVkxWWhPQmQz?=
 =?utf-8?B?WDBEWnZLcDQ2aUsvM3JSVFBZMDRSVXRpaktwMHZaa0lYL0xPNER3L3NuOS9n?=
 =?utf-8?B?dVIvRnlqS0JISEN5WHlYSGtUaWg0MUt3VStERFBDZXo0eGNGZ21PN08zVjE4?=
 =?utf-8?B?TWx3QXR4NEtWMlhBYmduVklZaGIyaStsdXFpTG94MXVLSUFHQWY1eE1nd3M4?=
 =?utf-8?B?Z3V4SWxiTUNHeE1uZDE3cWlpRXdUclRqTzlTdmNwdVUzYlZDZEtoZ044WGY0?=
 =?utf-8?B?bUlBNEI1VUZNQUtQU2xtejIwSVlWNytWM0FFZHVla0hJTlBBK25jY2VUUXBC?=
 =?utf-8?B?R1BHZmFuUXU0Ym56cHkzT29qeDhIQ2dKbGNZVGpnazZUMVNEKzliM0wwZzhz?=
 =?utf-8?B?cHhSRnIyV1JIREJ5SjJtUFdHditXOW1WNElzWEdqOXdJM0VaY0h5bkpSRzF0?=
 =?utf-8?B?Y0lVRGVjRDBKUFhhQ0lqeGluQnlCdzJBZVF1VUcxRjlLd1hXbEFHZ2xDRmlH?=
 =?utf-8?B?ckxRTVdQMWxMWkpNZ0haS2dQeXdtWTBBZHNqeFNaQzM3UmpoT1RTM2RZUDRF?=
 =?utf-8?B?aW03eUVFb2RZQ2ZlMno0bk9JdCt3dFdoSjhIcDIxNUIrb0RySTdpWllYOElB?=
 =?utf-8?B?dXNSMGI3WFBDZ3hFeDdMZHpMRGFDVkFCUnJmQ3ZRbkNVNCswSmFmaVhVWEZv?=
 =?utf-8?B?VW1nUGRTT1lmSDBvUWFROUlhZnAwN2R0c3FYUTBhcVVtSGdIT2VMRzZZUVJ4?=
 =?utf-8?B?UVlDZDViNjFWajFsVitDRi9sZkduZnd2dWxsT2s1cGd5aWUySjBkNjlWN2l5?=
 =?utf-8?B?eERMbTBiYlVwamI1MkhVRGF6TThxUDhVUlFEclNsNEtHMmNNRk1NTWRwTUNI?=
 =?utf-8?B?ekVEdVF5T1p1ZmZ1bGdMRW5vaE1kTWExVHBpNzlkeDdRQ3lSZVd2M2oyMmdj?=
 =?utf-8?B?c0tRd2hHMHIrZWtROTFkc2ltbG1DV3JZYXE5U01Pa3JvQVNtZkFXSzlXSy9F?=
 =?utf-8?B?Mld1MWVGY3RncVFNRWhQbnN2SjIyeTJ3L0E2cUI0ZDRSU1R2ZUF4QkRYS0RK?=
 =?utf-8?B?Umc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a7b05e5-80fa-472e-616f-08dde93a8c06
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2025 09:33:02.6897
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZwRT2gZRJIycqiYMXTySz8g7kv+kYjcq+bvpv+pTsif80jn4SwF+clLuP1FqROYcbNhihHxKRhrO04/NkTi0Qg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR10MB8872
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 01 Sep 2025 09:33:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19991

On 01.09.25 11:29, Quirin Gylstorff wrote:
> 
> 
> On 8/31/25 15:10, Jan Kiszka wrote:
>> On 28.08.25 13:06, Quirin Gylstorff wrote:
>>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>>
>>> This allows to reset the device back to first boot by
>>> formatting the persistent partitions.
>>>
>>> The reset occurs if a file defined by the variable
>>> INITRAMFS_FACTORY_RESET_MARKER
>>> exists in the device INITRAMFS_FACTORY_RESET_MARKER_DEVICE.
>>>
>>> In case of disk encryption it will invalidate the keys
>>> stored in the TPM.
>>
>> I wonder if this needs some finer control: We only clear the TPM in case
>> that :encrypt-partitions override is set. What if a user if this
>> infrastructure would clearing also in other cases? And what if only the
>> encryption key should be wiped from the TPM?
>>
>> I'm a little bit concerned about what "factory reset" may imply for
>> users. In some cases, it may actually mean to wipe anything that made
>> the device "unique". In others, it may be needed to return to the state
>> that was programmed in the factory, and that may include bits in the TPM
>> that should be kept in such a case.
> 
> Ok this would be more of a data-reset functionality, then a factory-
> reset. I can add that functionality as a separate option or in a
> separate MR. It needs a separate script as it requires a change in the
> ordering.

It really depends; If the TPM is leaving the device manufacturer's
factory blank, then this here is fine. If not, this tool may not produce
the desired result.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

