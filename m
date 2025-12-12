Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3086D59D7F
	for <webhook@archiver.kernel.org>; Fri, 12 Dec 2025 18:06:56 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.84.26])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.205.1765562810989593583
 for <cip-dev@lists.cip-project.org>;
 Fri, 12 Dec 2025 10:06:51 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=w3B6X8hv;
 spf=pass (domain: siemens.com, ip: 52.101.84.26, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Godz32qWoLomQgQm/cCKfyeqj9o5Bzny20wLuETEYSoPy1PZ8Gpu5ezqYT4eCaMsfgPyAHW7xUjr7dvfhEkHjzBBCvHEn89uZwNgpKQcdMQSoTsm3e7UqVfsRgrkeTnHJkbxtvuj6mdu6CV+GBEHb9zDDK5soUgCFqiFu99/H4txG9nyCbEHomD0YQHYrsGkzbkFwhU2E3j7jeaYmJaU/02MWRMG8mdTxpilefMShq9UPtUtVwRd4vWI6mAR8c9JRg+nXk0CTjqYb9X+xbDcaqyI4fhS2A8x9E5ak0fuW2CmXhOS1pZrFI6OmPXnTBlrQSn8pgcc00dBRUD/vwOK8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vj+5tBva6Lt7//nQQybEXQArqFIym0dyxf0jkKVgNr0=;
 b=TGWNNK27SXoYgfy+TLYO5s3Obh3J8C82lZ7AtaVx09XEffnAsfBzWSpQUWBg6oPAjbqnwVqDdTx9d21ieAaP6brh+GGt/5YTV4p50c1cMzECq5DdbGSfGv3pVsYCemEZs1V0NmeuSYw4Aii3PZkFVgEorC3EwBeRuRnc0+a0DQxRiwmvlpauw6OwjslhS7UzSDtt782vWPMzX6Pi5t8SY+ePyU60qowSmPlEoQpQ6O3jAwUrTqU8Uvge8orAj9tJwAqkfgAA19o8+3fj4+0M+JFHzhT7xERdq6teehzDaSHBUm+hMjzBHQ7sCj1SkUW5uhMgkQuixSMtniP7QtEECA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vj+5tBva6Lt7//nQQybEXQArqFIym0dyxf0jkKVgNr0=;
 b=w3B6X8hvXfG6BNY6r83GNopUJ55HohVJUTX8cRNrUg+bUPKBqa7GnL7TxuwhV5heoNzobYnGYZFAF/axULgiXSFgLrBv96OyG1htcF2O36sYlnjKhd2fL1Yc9WZecpQAGa2TkcymZ936vJdJ/3fGV3pnxtusd1g+gN1EA1sm8wfYShMOFap1mAwcT7c6Cq3mewLnBqGmp3nPR1Xzs4avMhAEWaIESny2bIA2qz7NHLCZhlxFcsvMyfNnwS040BVGnE/UJNveB2Z5YqXYqvGRW0YaR9wY1W7q3h6vobtN9Zwy1p68gXfs8JYVCQhYM5l2/m8vLGjqLj8NkAkbxMAGkw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI1PR10MB7810.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:1cd::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.11; Fri, 12 Dec
 2025 18:06:47 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9412.005; Fri, 12 Dec 2025
 18:06:47 +0000
Message-ID: <84ed76a9-157a-4e77-ac85-6114553ef7a2@siemens.com>
Date: Fri, 12 Dec 2025 19:06:45 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][RFC][PATCH] Remove support for building KernelCI
 images
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>,
 Arisu Tachibana <arisu.tachibana@miraclelinux.com>,
 Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
 Chris Paterson <Chris.Paterson2@renesas.com>
References: <5a48c2d2-2699-44a2-89ef-c44ef1c9ca38@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <5a48c2d2-2699-44a2-89ef-c44ef1c9ca38@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0016.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c9::6) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI1PR10MB7810:EE_
X-MS-Office365-Filtering-Correlation-Id: 0594ea1e-9ea1-4c06-4644-08de39a936f3
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?cHR4YzJRRDdpSlNFMEtobUZ6bnY1VUhObTlxaW1BT09ZemlmdXRIWERtbnN3?=
 =?utf-8?B?WExFNmtkZHJDcDJDWUNQRllueDhTZVdsN0w0ck9uRlJMTTRJbGc5ZDZLaEhB?=
 =?utf-8?B?REkrM2xpZEhQWUt2MDZwT2RuT1JIVHNGeEd4eUFrbUw3bEF2KzdjcllHS1o4?=
 =?utf-8?B?M1RmYi9WL2Y5OTg0SnRaaEFTZDRENUlyWWJ0V2t6bHRPd0NUaHZNVmdnYWZP?=
 =?utf-8?B?SklCdnUza0sxOEdNSWlhTUQzT0RYdzgrMWFpb1VMLzJOdEhMS0Rvcit1c0Zy?=
 =?utf-8?B?S0sySzVDKzRpTmRIVFRBVlFxd01Jb1A2MElSaHlLbDkxeGhLaGhtSk9oK09m?=
 =?utf-8?B?aTVsZENOczZJb0pnbzNTMTNLV1hicktyMVhjeVgwZ0tCRHVTRXBOdjZBNWJH?=
 =?utf-8?B?d3FCREV1Z3pHUkJiMEVDQ21NQ2hmNW1EUHMvNXM2WTROTXVZUnJTaXJESkRX?=
 =?utf-8?B?VEU2eDU3TTg4bzUyVjJEdVAwZWdkQ2pGSklUaTliNi9LRW5kZEhTK1M3cXoy?=
 =?utf-8?B?ZXhDUm5yODBVaGljeEJTbWVSbkxmRzlua1JPWGgxSDFvMVFnWHh1cFB2dDJ6?=
 =?utf-8?B?bno3NVE4bklKTnhWT09mYUtQZUxWNWV1OFdpRGxlaEtHNExGemJoVWJWbWZ2?=
 =?utf-8?B?TE9YbmdwWkh6V1d6RFI2bkVIOHhSczdBWmtMNmlNTldSTWVOOHc3Z0p6Ym9m?=
 =?utf-8?B?K1BSVXlYaURURTcxZ29mZUkrSWtBQlJ6cnBxUi9vcjNOT21YeGtnSlpYL0tD?=
 =?utf-8?B?RGVCWHY4TVJVTFZKS01ldGFYeXJ0V1VKLzlvZ1VFUjZhNFQ2aEcyRWorL01F?=
 =?utf-8?B?c0kzeVpyaVpobHkzSVpLcWZ5dzJhUlVkK1BUN0FCS1FjcVBMVUhGVEM3ajJO?=
 =?utf-8?B?Z3A3UDRJSXVVN3FKSzNMNzRLM2E1aWhqQ3VvQXhYN3B4U01KWTBKN21RczVV?=
 =?utf-8?B?ZUtCcCtnczdqNGt0VkZFS3hNc3lnOFpGTUdMcXJoMyt0YUk3TFgxRDZweE1s?=
 =?utf-8?B?WnE4b25tVUI3ZmRjOG82dm0yRXdvNlE5cmRLcGdSVm1zWngvYXhLclZKSVo5?=
 =?utf-8?B?cHk4YncxbjFaRm5GRS92enUxME9xSU5ZRkdmd3JYcWIzQ2lrcmJYUXF6Mmts?=
 =?utf-8?B?b3FtSUJ5bVlmV09CWWN4S2JMQTA4N0hJUmhEZHJzWThKN1hXSHRBUHF0NHo1?=
 =?utf-8?B?eXVnbGZNWkk5a3ZsYnBtODdqRGNLK3ZXT0lxZ3FQUmN3Z2N3R0ZxTEdXQnBn?=
 =?utf-8?B?NEEreUhOTHkwSmxndXU4cWNZV0wvdmNDaEhVTkQ3ZWU0UjJLKzlaRkR0ejY2?=
 =?utf-8?B?em1WN0J3d2dmR2hVSnJsdjVMQm9GME5tNlR5L3BlN2VnME5iZXZ0eUloQVhZ?=
 =?utf-8?B?SWdWS1NBQ3VPSkdoUGJWbU9FR0xSdVNROWsrZmt5M2lBSHYrbis5VkNRbFNT?=
 =?utf-8?B?SnpNU0s4V21RdEZidW0xd25BYnJhdThjS3ZDVnZPclFoWEtOZDI4QmRPRnlV?=
 =?utf-8?B?a2ppMHluOUhBMW9YZXJwbVcrb005ZDdnbjMyU1BXTzRCWitlaFVCWkFGVllG?=
 =?utf-8?B?MGhSZVZVUWtQWVlsM0RoRHFqWnp3azA5TVhuWWZEdENtVDNrM3RwcktOZnoy?=
 =?utf-8?B?a1ZXb2w0bTJaK3BIOGNkMStzWnRBMm5mNWxoazBrdm5HMmxMRHhaLzQ1cWVE?=
 =?utf-8?B?WWpmSU85SXJaWVpoMHY1SHNPZDJhY1dUdzlqNVMzNm8wM281YmVIZHFkT0lo?=
 =?utf-8?B?emVvSEp3blI0b3pUdXlXY3l4VWVIZUM1Yllsa2dqK3FLbk9rNlkwS282Y255?=
 =?utf-8?B?U3BvOFkxVzdCYmdPUDFid056Ui9lOVFJWXdFZUdjZWtpNU9DY2FFaWIreitm?=
 =?utf-8?B?YjR2UVVqaTV1d1A4TzF2aVczRTdTZWRHOTBYOVZOczRWUkE9PQ==?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?L240ODNFbGtTWC8wckJKZjVVbzZxRjJVOEtkU2NWaEFPdEYxY0dXTGxnOExi?=
 =?utf-8?B?c2xDbDBKY3BTSklGWG1LQm1STURLQURJTnZvamh4ZXVQSWQ2dVdMOE9Rb0hv?=
 =?utf-8?B?ekF6TkZDT1RzallCNDdsZlpIOFkrVUVnWlVXcnluaWJSUUZ5dVlWcmNMRzl1?=
 =?utf-8?B?NDRISEtISFdqeDdiYW1sY3NwcWRLWllGYXF6M01LWUc3ZWVnZUZUaEZ2OENJ?=
 =?utf-8?B?eU9ndlhzdFloMk5Bb1orT09peXRpdGxLY1NPRVdTR2pGUDdFR3psU2pkQkU4?=
 =?utf-8?B?TC9zQ2UyQmg0WDFGNEEwQWtseGU4ekRpV0N0SjdROGNnTnV0YytVQjd2VGhl?=
 =?utf-8?B?REtXQk82bHMyUG9wUkt5ZGRYSFk5VDd0c2pVN3pSRFhFYjJSZ21rTHNkWHFQ?=
 =?utf-8?B?SlFBaFBUbStwWVhkSENpN2xFSm9ZM3pMNmxGbGEyMXJPVVM0NFUyeGlHRis0?=
 =?utf-8?B?L0ZML1EzK0h5Q2hqZkJrY0hQUUZXUnM3L3FvY044ZzdUWVRTNTY0NGpNbGZF?=
 =?utf-8?B?amZCOS9Mc1FCL2RpaEpmMlFBTFdWZExFb1dPSlpKTEtZdGt1ZTRBMzg2NVJ5?=
 =?utf-8?B?ZHFxQnFubU4xRm9LdExlY0Znejg5NDVzQlBtc1pkVGRZQUtGRjExMFZvVjAr?=
 =?utf-8?B?VGFJMkdRV3hJZ3VlUmI3UWt1N1RyQkhHNENTRlVYVVc2L3l1K2dkQWw1VDM4?=
 =?utf-8?B?TlZiN2lhZTlPQzFIQ1h1dzNaRmVxUjluRi9WR1ZwdWtYR0QvTTN3YS9KMlpH?=
 =?utf-8?B?MEZDYTZYV3dQb09ZV2Q3VHhFUGUzZjU4Z2F3TVJCSnA1WU5lYzhWUExUbzBQ?=
 =?utf-8?B?K0dHbGdBNTlQdzJnS3VqNjNCZVFPaE8vQStSekZzNVFDNSt1NUVXaGFCK290?=
 =?utf-8?B?aEh5N2grYjZEdGdBcWM5TllzR043Z3dxOGJ3K245STBxOXZQblptaTA5Y2R1?=
 =?utf-8?B?WkJpNm1jcFJ5MXN3dWo4TjBuTk5IdU4yQzJORVpDM2JacStIMTQ1c1o4QitN?=
 =?utf-8?B?eUhHck9pTTFrdzhTQXpxblZ0ZkZCZjRLWWVVQ0Z0WmdycG9xYnMxbzVEMXpI?=
 =?utf-8?B?K05tRHRwdnBoMkF2MXprUGVzZVI1b2hPdTBzRVBOOXR2NEVmeDhQUEtST05v?=
 =?utf-8?B?TktOMEpkdE9HMUVXbnBwZ1NoQ2c2blpFQmVPc0s4ZjN4TFFqb0ZuVVNmaGFQ?=
 =?utf-8?B?aDc3RUpBUWFyeHpvSnY4UFlMYTVmSFY2ZUY2Sm5NMnBPaStsQTVnb2oyUlU0?=
 =?utf-8?B?VFNRamt2L2JKd3VyRU9qdnI0RmdkTk9VcW9BazFzKzNYSVZZK2xLUG1YWXRs?=
 =?utf-8?B?S1FRSklXR3BHd0VOUGsvTTlNa3hxVjR6U3pUdkNKZUpDRTl6RlV5TUdHbmln?=
 =?utf-8?B?SHQxV0Vqd1ZFUmdWWkU5bDY4S2ltQzVJeTcwQ3J2MUlyanVaL0xUb2krSmMz?=
 =?utf-8?B?cnZZMHJ4THhXVFlhVVZ0Q1pndGhramprV0g4Tmw1T0s1UzkrWCt4azdFUVRz?=
 =?utf-8?B?T1dEZHNOWFFRTmdZaXVuaUJ4czdVMkRaRG56WWNvSGNScVhGTGtEdXVmSDM4?=
 =?utf-8?B?NkdaazY5UDNwVHNaMU5nc3lZMmVIeE1xcmRiekI0OFdJeWlUZDdEZ1FWbGlq?=
 =?utf-8?B?TEhKMkJUZG9XUEdNNldneW9jOUhLWmhuUVZkb3ozbFl4aTRCZjRCNEl1Ynp2?=
 =?utf-8?B?SlpEVGxJN1ozU280QmY2WEpaNG96cGMzWXJYS1ArWjkzVnBHMExQNDJ5VDVY?=
 =?utf-8?B?L2ljNld3NktybmVxRkEyK053ZGhGR21WNTB1bXBKU3gzRGc5SFQ4VTkvQWZr?=
 =?utf-8?B?VzFPSFNDQmxXbFNHYlBVbVc5N0xUYXNqNW9WSlZKY0puNlBmdmppZkJIeW5x?=
 =?utf-8?B?WGh2djIxd1BlVy9ScEZxR09pVkg3ZExNOHd1YVJNdVBndEdlQk9TSmtBUktk?=
 =?utf-8?B?MXlrQ0JGamh5STNBMDRINHkxR1o5ajRkbHBkN3pZVnpCaTBIcW43S1BJcEZ2?=
 =?utf-8?B?ay80RS93Z04rRzZSaGVrSnFCcnRPblh4QVNwWm9vMVF0SmJwQVBQN2xzMm9O?=
 =?utf-8?B?OTI0NDZCcTBRUFEyZHZFNnpCT0ZvdTR1REw1OEpaUEpjd3VGbHUyTU55TGdk?=
 =?utf-8?B?RWZrTm5nYkFSSllFbHBKTTNtRGpIZWRHQVRGWXIzNCtDU1pHL3BMYUZ0VzBh?=
 =?utf-8?B?WHc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0594ea1e-9ea1-4c06-4644-08de39a936f3
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2025 18:06:46.9971
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LQAg5Oeqc5sVTJ/PLNf72mBEX2x0rgueAssxMnnF8OR70M6nMd+cXLTMKihfKZXQ18xSSV8dDPqCP685r3vmvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB7810
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 12 Dec 2025 18:06:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20989

On 10.12.25 09:40, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> We are solely using the KernelCI-provided rootfs images by now and do
> not plan to change that.
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
> 
> Please give feedback if we are on the same page.
> 

If I don't hear any feedback at all, I will interpret this as
confirmation and apply this patch.

Jan

>  .gitlab-ci.yml                                | 29 ----------
>  kas/opt/kernelci.yml                          | 19 -------
>  .../images/cip-core-image-kernelci.bb         | 16 ------
>  .../kernelci-customizations/files/dmesg.sh    | 23 --------
>  .../kernelci-customizations/files/postinst    | 23 --------
>  .../files/serial-getty-kernelci-override.conf |  3 -
>  .../files/ssh-permit-empty-passwords.conf     |  1 -
>  .../kernelci-customizations.bb                | 33 -----------
>  scripts/deploy-kernelci.py                    | 56 -------------------
>  9 files changed, 203 deletions(-)
>  delete mode 100644 kas/opt/kernelci.yml
>  delete mode 100644 recipes-core/images/cip-core-image-kernelci.bb
>  delete mode 100644 recipes-core/kernelci-customizations/files/dmesg.sh
>  delete mode 100644 recipes-core/kernelci-customizations/files/postinst
>  delete mode 100644 recipes-core/kernelci-customizations/files/serial-getty-kernelci-override.conf
>  delete mode 100644 recipes-core/kernelci-customizations/files/ssh-permit-empty-passwords.conf
>  delete mode 100644 recipes-core/kernelci-customizations/kernelci-customizations.bb
>  delete mode 100755 scripts/deploy-kernelci.py
> 
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index 2714a374..3a202536 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -20,7 +20,6 @@ variables:
>    encrypt: disable
>    dtb: none
>    deploy: disable
> -  deploy_kernelci: disable
>    build_updates: disable
>    swupdate_version: default
>    test_function: swupdate
> @@ -93,7 +92,6 @@ default:
>            done;
>            scripts/deploy-cip-core.sh ${release} ${target} ${extension} ${no_kernel} ${dtb} ${CI_COMMIT_REF_SLUG} swus;
>        fi
> -    - if [ "${deploy_kernelci}" = "enable" ]; then scripts/deploy-kernelci.py ${release} ${target} ${extension} ${dtb}; fi
>  
>  # base image
>  build:x86-uefi-base:
> @@ -135,15 +133,6 @@ build:qemu-amd64-base:
>      separate_home_partition: enable
>      deploy: enable
>  
> -build:qemu-amd64-base-kernelci:
> -  extends:
> -    - .build_base
> -  variables:
> -    target: qemu-amd64
> -    extension: kernelci
> -    use_rt: disable
> -    #deploy_kernelci: enable
> -
>  build:qemu-arm64-base:
>    extends:
>      - .build_base
> @@ -156,15 +145,6 @@ build:qemu-arm64-base:
>      separate_home_partition: enable
>      deploy: enable
>  
> -build:qemu-arm64-base-kernelci:
> -  extends:
> -    - .build_base
> -  variables:
> -    target: qemu-arm64
> -    extension: kernelci
> -    use_rt: disable
> -    #deploy_kernelci: enable
> -
>  build:qemu-arm-base:
>    extends:
>      - .build_base
> @@ -177,15 +157,6 @@ build:qemu-arm-base:
>      separate_home_partition: enable
>      deploy: enable
>  
> -build:qemu-arm-base-kernelci:
> -  extends:
> -    - .build_base
> -  variables:
> -    target: qemu-arm
> -    extension: kernelci
> -    use_rt: disable
> -    #deploy_kernelci: enable
> -
>  build:qemu-riscv64:
>    extends:
>      - .build_base
> diff --git a/kas/opt/kernelci.yml b/kas/opt/kernelci.yml
> deleted file mode 100644
> index 517e7410..00000000
> --- a/kas/opt/kernelci.yml
> +++ /dev/null
> @@ -1,19 +0,0 @@
> -#
> -# CIP Core, generic profile
> -#
> -# Copyright (c) Toshiba Corporation, 2020
> -# Copyright (c) Cybertrust Japan Co., Ltd., 2021
> -#
> -# Authors:
> -#  Venkata Pyla <venkata.pyla@toshiba-tsip.com>
> -#  Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>
> -#
> -# SPDX-License-Identifier: MIT
> -#
> -
> -header:
> -  version: 14
> -  includes:
> -    - kas/opt/targz.yml
> -
> -target: cip-core-image-kernelci
> diff --git a/recipes-core/images/cip-core-image-kernelci.bb b/recipes-core/images/cip-core-image-kernelci.bb
> deleted file mode 100644
> index 849c0761..00000000
> --- a/recipes-core/images/cip-core-image-kernelci.bb
> +++ /dev/null
> @@ -1,16 +0,0 @@
> -#
> -# A reference image for KernelCI
> -#
> -# Copyright (c) Cybertrust Japan Co., Ltd., 2021
> -#
> -# Authors:
> -#  Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>
> -#
> -# SPDX-License-Identifier: MIT
> -#
> -
> -require cip-core-image.inc
> -
> -DESCRIPTION = "CIP Core image for KernelCI"
> -
> -IMAGE_INSTALL += "kernelci-customizations"
> diff --git a/recipes-core/kernelci-customizations/files/dmesg.sh b/recipes-core/kernelci-customizations/files/dmesg.sh
> deleted file mode 100644
> index 3b096e10..00000000
> --- a/recipes-core/kernelci-customizations/files/dmesg.sh
> +++ /dev/null
> @@ -1,23 +0,0 @@
> -#!/bin/sh
> -
> -set -e
> -
> -if [ "$KERNELCI_LAVA" = "y" ]; then
> -    alias test-result='lava-test-case'
> -else
> -    alias test-result='echo'
> -fi
> -
> -for level in crit alert emerg; do
> -    dmesg --level=$level --notime -x -k > dmesg.$level
> -    test -s dmesg.$level && res=fail || res=pass
> -    count=$(cat dmesg.$level | wc -l)
> -    cat dmesg.$level
> -    test-result \
> -        $level \
> -        --result $res \
> -        --measurement $count \
> -        --units lines
> -done
> -
> -exit 0
> diff --git a/recipes-core/kernelci-customizations/files/postinst b/recipes-core/kernelci-customizations/files/postinst
> deleted file mode 100644
> index 08544a4d..00000000
> --- a/recipes-core/kernelci-customizations/files/postinst
> +++ /dev/null
> @@ -1,23 +0,0 @@
> -#!/bin/sh
> -#
> -# CIP Core, generic profile
> -#
> -# Copyright (c) Siemens AG, 2019
> -# Copyright (c) Cybertrust Japan Co., Ltd., 2021
> -#
> -# Authors:
> -#  Jan Kiszka <jan.kiszka@siemens.com>
> -#  Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>
> -#
> -# SPDX-License-Identifier: MIT
> -#
> -
> -echo "CIP Core Demo & Test Image" > /etc/issue
> -
> -# permit root login without password
> -passwd root -d
> -
> -# set the profile for KernelCI
> -echo "PS1='\$(pwd) # '" > /root/.profile
> -echo "cd /" >> /root/.profile
> -
> diff --git a/recipes-core/kernelci-customizations/files/serial-getty-kernelci-override.conf b/recipes-core/kernelci-customizations/files/serial-getty-kernelci-override.conf
> deleted file mode 100644
> index a1472c5d..00000000
> --- a/recipes-core/kernelci-customizations/files/serial-getty-kernelci-override.conf
> +++ /dev/null
> @@ -1,3 +0,0 @@
> -[Service]
> -ExecStart=
> -ExecStart=-/sbin/agetty --autologin root --keep-baud 115200,38400,9600 %I $TERM
> diff --git a/recipes-core/kernelci-customizations/files/ssh-permit-empty-passwords.conf b/recipes-core/kernelci-customizations/files/ssh-permit-empty-passwords.conf
> deleted file mode 100644
> index 04e75ab6..00000000
> --- a/recipes-core/kernelci-customizations/files/ssh-permit-empty-passwords.conf
> +++ /dev/null
> @@ -1 +0,0 @@
> -PermitEmptyPasswords yes
> diff --git a/recipes-core/kernelci-customizations/kernelci-customizations.bb b/recipes-core/kernelci-customizations/kernelci-customizations.bb
> deleted file mode 100644
> index 3a99884b..00000000
> --- a/recipes-core/kernelci-customizations/kernelci-customizations.bb
> +++ /dev/null
> @@ -1,33 +0,0 @@
> -#
> -# CIP Core, generic profile
> -#
> -# Copyright (c) Siemens AG, 2019
> -# Copyright (c) Cybertrust Japan Co., Ltd., 2021
> -#
> -# Authors:
> -#  Jan Kiszka <jan.kiszka@siemens.com>
> -#  Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>
> -#
> -# SPDX-License-Identifier: MIT
> -#
> -
> -inherit dpkg-raw
> -
> -DESCRIPTION = "CIP Core KernelCI image customizations"
> -
> -DEPENDS += "customizations"
> -DEBIAN_DEPENDS += "customizations"
> -
> -SRC_URI = "file://postinst \
> -           file://dmesg.sh \
> -           file://serial-getty-kernelci-override.conf \
> -           file://ssh-permit-empty-passwords.conf"
> -
> -do_install[cleandirs] = "${D}/opt/kernelci/ \
> -                         ${D}/etc/systemd/system/serial-getty@.service.d/ \
> -                         ${D}/etc/ssh/sshd_config.d/"
> -do_install() {
> -  install -v -m 744 ${WORKDIR}/dmesg.sh ${D}/opt/kernelci/
> -  install -v -m 644 ${WORKDIR}/serial-getty-kernelci-override.conf ${D}/etc/systemd/system/serial-getty@.service.d/serial-getty-kernelci-override.conf
> -  install -v -m 600 ${WORKDIR}/ssh-permit-empty-passwords.conf ${D}/etc/ssh/sshd_config.d/ssh-permit-empty-passwords.conf
> -}
> diff --git a/scripts/deploy-kernelci.py b/scripts/deploy-kernelci.py
> deleted file mode 100755
> index 62f3f010..00000000
> --- a/scripts/deploy-kernelci.py
> +++ /dev/null
> @@ -1,56 +0,0 @@
> -#!/usr/bin/env python3
> -# -*- coding: utf-8 -*-
> -
> -import requests
> -import os
> -import sys
> -import time
> -from urllib.parse import urljoin
> -
> -cdate = time.strftime("%Y%m%d")
> -api = "https://api.kernelci.org/upload"
> -token = os.getenv("KERNELCI_TOKEN")
> -
> -release = sys.argv[1]
> -target = sys.argv[2]
> -extension = sys.argv[3]
> -
> -rootfs_filename = "cip-core-image-kernelci-cip-core-"+release+"-"+target+".tar.gz"
> -initrd_filename = "cip-core-image-kernelci-cip-core-"+release+"-"+target+"-initrd.img"
> -initrd_gz_filename = "cip-core-image-kernelci-cip-core-"+release+"-"+target+"-initrd.img.gz"
> -
> -input_dir = "build/tmp/deploy/images/"+target
> -upload_path = "/images/rootfs/cip/"+cdate+"/"+target+"/"
> -upload_path_latest = "/images/rootfs/cip/latest/"+target+"/"
> -rootfs = input_dir+"/"+rootfs_filename
> -initrd = input_dir+"/"+initrd_filename
> -
> -
> -def upload_file(api, token, path, input_file, input_filename):
> -    headers = {
> -        'Authorization': token,
> -    }
> -    data = {
> -        'path': path,
> -    }
> -    files = {
> -        'file': (input_filename, open(input_file, 'rb').read()),
> -    }
> -    url = urljoin(api, 'upload')
> -    resp = requests.post(url, headers=headers, data=data, files=files)
> -    resp.raise_for_status()
> -
> -
> -if os.path.exists(rootfs) and os.path.exists(initrd):
> -    print("uploading rootfs to KernelCI")
> -    upload_file(api, token, upload_path, rootfs, rootfs_filename)
> -    print("uploading initrd to KernelCI")
> -    upload_file(api, token, upload_path, initrd, initrd_gz_filename)
> -    print("uploaded to: https://storage.kernelci.org"+upload_path)
> -
> -    # Upload latest
> -    print("uploading rootfs to KernelCI CIP latest")
> -    upload_file(api, token, upload_path_latest, rootfs, rootfs_filename)
> -    print("uploading initrd to KernelCI CIP latest")
> -    upload_file(api, token, upload_path_latest, initrd, initrd_gz_filename)
> -    print("uploaded to: https://storage.kernelci.org"+upload_path_latest)

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

