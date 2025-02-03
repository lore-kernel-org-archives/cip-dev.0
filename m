Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15379C02192
	for <webhook@archiver.kernel.org>; Mon,  3 Feb 2025 17:18:02 +0000 (UTC)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (EUR03-VI1-obe.outbound.protection.outlook.com [40.107.103.83])
 by mx.groups.io with SMTP id smtpd.web11.93385.1738603078260269198
 for <cip-dev@lists.cip-project.org>;
 Mon, 03 Feb 2025 09:17:58 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=lJUaBbQr;
 spf=pass (domain: siemens.com, ip: 40.107.103.83, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=STrZH9AVyPkS6MDqYWrTX4cOZ/l370VaXm5uN3bP2Dn+bGhV5qeBuRJaHmPP1cjN6BMo0hmpPoVyghsLtj4twYE7izrySIckNTJW7VtqbVcyy4O6e06GGZzmAKNp+t/zT0eq/PAIE5WHeRPVl4wciHv3XrrneMbtZZprR8DtpR3BARDSKavB7/rWmSY6wNPtg/vB5OX5pUCOoMv3MoYIvm7LrWWGvK+E9ceSnMmDj4VsYqbZz5pt9X4PYqF8O+XDqLj0v5UjQF9VW9zfwpkFM8ptZxfWZfIbivXWPslGrzxJZQrgZfJ6HyAuyJ8xxXZkk+p5O1BIPcF2lfcpPHZfdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gJk5yhwgrmjzh0gmdUX5WPxHzoQdmHMnleS+v3u25O8=;
 b=UJXSSzEu+sZdD1EuTnQ3e9O54l8KNLlFbyK679f8EY2pqHq4NDawP8pGVIpSIa4FXFSclpwJfmj8dB8+BPg33GJtb9FMJNYMEGLf4X1DZnxgNRiDCDoOI8jSehcksR+zN0oqhwV6W4pTAZc9NmcEjdVNJGyCKp0H8yXFsOFTwDx6lSq0Z96N/cS7vxljh/D/zvL37MGg5a+5qgbvJyslKHs9DO7YAFg/tPz4bz8iEL477KjOMj8s3PcDtiYV5el+R+qyyILhVFz8HYfUsn5hDLT71XwfK2EDOgWgOB0MSCulIkT/l5Hgw8hk23dukCvqseNuiuNS6n61GnDvdQgVXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gJk5yhwgrmjzh0gmdUX5WPxHzoQdmHMnleS+v3u25O8=;
 b=lJUaBbQrgR9EPCtOmmb5Fr3WI+zZ9uyA1mn+OD3NEOERcIW5ym49A2F0X78zTk88PcMGNJ8GkhsKxilDFQHjyvtqAF/EAXbxJzoEPvnETtqAdT8m6I/ElqGy+mRb0iA+gq5MgjxwqOk3oNlnrWrVPEfTUJ22OVFfAOVFTJdXxtrPZ4oJjqfDaOaBawr7cNZ5rwSLewtpjr5MMbrqnIMWrCLknqUhS8KBZdmN7V5wDl9D8RJhtksbKl+7Z5T0Exe/yj8JHuz5qE+/YBNh3flndNon/wxJbK2Lb84I125OgjtNP/uueRRogROH3kMRfb6AkpVmSE8EqDPuVCPuJfgyCg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM8PR10MB4114.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1c9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.9; Mon, 3 Feb
 2025 17:17:54 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.8422.005; Mon, 3 Feb 2025
 17:17:54 +0000
Message-ID: <13624aed-827f-4b4c-930c-b75a38eb2e9c@siemens.com>
Date: Mon, 3 Feb 2025 18:17:37 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][RFC][PATCH 00/10] Provide A/B snapshot support
 for persistent /var
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: Christian Storm <christian.storm@siemens.com>,
 Quirin Gylstorff <quirin.gylstorff@siemens.com>,
 Felix Moessbauer <felix.moessbauer@siemens.com>
References: <cover.1738229957.git.jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <cover.1738229957.git.jan.kiszka@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0047.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4a::10) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM8PR10MB4114:EE_
X-MS-Office365-Filtering-Correlation-Id: 11da39e0-1c10-440f-917d-08dd4476b1e6
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?dFlNeGswSk8xdklLTFkyNWhHOEJqekt5cDBUTzdibStUcitYcWdyTDgvM256?=
 =?utf-8?B?Y1RWaEFHZ1ZFV1puU0ZmU2NlemkvUFdMZ1I0QkZmWGZSY2twUll5RVM2ZWRL?=
 =?utf-8?B?UWVTZERlZ3BrSEpjRHN3c2NPemZucGlLWDhHVGEwME9NcnR5dFdkQTBqV2tW?=
 =?utf-8?B?QkgzL3M1bnFEUkVzdDlxQ0pRSkl0VThNYWVEb0hNajVQazE2TEIxaW1lMFhB?=
 =?utf-8?B?TFpJZ2VRcVcrbGY4MHNzekROK04vV0VDMWNtN2RCaWVocCtqZU5LRW5UdGZs?=
 =?utf-8?B?bURhenpiNUVnWU43T0VCWFNVSFB6dUJObUhOUzZxSng2TCtYa1VSODRiTXRC?=
 =?utf-8?B?cDNkM2ZjT1N2WVJhTUNSSGc5eTRSQXM1NTBKendmUFpieFZmUWp1bVJVVUZ6?=
 =?utf-8?B?Y093VVRDa3ZZWFloQUVuM2lJUWhNMHMwbWxCNjFUZDJMZVI1OTFSMDhWOFBX?=
 =?utf-8?B?dkViOEE3cFJMYUFkOEpnRkJrUlJJYlo2OCtIdFdYTHh2Y2Y3M21CT1FYb0xJ?=
 =?utf-8?B?TVJ4YnNmVTZCY1k4MFlIdGJWYnI0MGNmMU03YTYxeTBKWVhxMEVQUUtTWU5M?=
 =?utf-8?B?bzJOQ21vcWhEekRWU2UvcWxIRjArWi9xczRsUmZOQXpmRkNWcUJuSXRsK3RD?=
 =?utf-8?B?ZTZ4SHlkMFlUbzhJQkl3WWRKZmErMDhGbXM5Y2pZMkpQUjd3Yys4ekNHdXlH?=
 =?utf-8?B?dEExOWY3MVo5WCtoMGhMckNHNDU2QzM5Qks2QjJaM05BV1E4SG93RWxqM1E3?=
 =?utf-8?B?SmxVNnluSEh6YW9OczMxSkJlalM1ZDdob05EMHd6cjRJOG5lZXZYRmJTK3ll?=
 =?utf-8?B?bnNGdEYzV0lxaWk2UkhMSU1lQUUvT3ZtSXBRU3lqVG1kK3dHVndtWmlUYU9v?=
 =?utf-8?B?RDdlVW5tdEttcmJNRm1aZkNuTHYwK0RFWndTRVhYMzl6SlErWEpzRmJjNmI1?=
 =?utf-8?B?b1B0a3ZpSm9YOXFYd2VvTDlKaXpuODhzeEhNOUZLM2xkdkVSeE9jN1ErdUEx?=
 =?utf-8?B?Y3ZwKzBhL0V0N1NCUFczUzhxUjZLZGxnbHNmR0lCNzVmNGpQNGZHVGxSMEQw?=
 =?utf-8?B?RWtsZUlDT0pQQ29nblNkeWxjaVBYTkpmb29YN2owN0FnaWZMWlFLaktiamlM?=
 =?utf-8?B?bFhPR2hVWjMxczhXZVd2elIvckkzK3Q1elE1ejR0VjNCUktlRm9EcHZkM3JQ?=
 =?utf-8?B?SzBkWmJoNmNYNlFQdENiUHZkTUd0K3dMRHJwUllma2lWZkwvd3pmTXp0SGNW?=
 =?utf-8?B?ZGN4cTlZV2N1T1phSmNIQjJJNGlhL1ZuVU11KzJjbGE2TmxWRFFMZWdaMUhr?=
 =?utf-8?B?VFgvRmhJWW9DUlI3N0dlb2M4cXNQQ0E4ZjZtNlZBWUtjaDdraVZiTVd4aGh5?=
 =?utf-8?B?emwweXdzZCt5NXphWlA5SmM2eC9SbWlnV0g5dzdYdTVmU2s1aW4xeE1aV3p4?=
 =?utf-8?B?emNkUkNlT21zaytEbU9sMXFQaTZtdmpRMTFlaHplblBmUEc0bUtpZGE5Qjgr?=
 =?utf-8?B?U0ZrUTJndXJNeWE5d0g0Y1VHK3VHdlJsOW50cSs4U2FUZmFwL245VnNEUkd4?=
 =?utf-8?B?NU0zblp4VHdLeGtWL2lBQzZRMkFZcEtsMFpyMTI5UGNIWnZKRnBQTWxyVHlo?=
 =?utf-8?B?dzNMdFArWURiUFREbEZKcUFVYVQyWDY5TGdVa3lqZkdXc1hpeHZ6OWRCdVhy?=
 =?utf-8?B?VzhuakQ0RW5RNitwc2VUTWNNL01PUFFhZ0g3WTRBZUhEZkZZbGkzUmRON2F6?=
 =?utf-8?B?THV2T1Nxd09hK2hLcUE2bGkyZjJxbVhOcmdRcDluZTVGam1uQWRad0d4UllB?=
 =?utf-8?B?TXlva3poSFM2Vk5weWJSZmNIWmo1c0htcGkxeDVzT2xiWmlFTzByOXBETlky?=
 =?utf-8?Q?xUTgbzFcx+3Ch?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?MEgrank4TlFnSkpjNkcxblBETkszTktFbUdQUW9XNk5WUUJHYm1HZWRaNlZB?=
 =?utf-8?B?UktpaGJXV1hDMUtBUVdFMmgwUWMvc1cydGwxZXBCT3llbSs0aUQ5Vm9zR0lm?=
 =?utf-8?B?Y0Y0MHN2NGN2M0U0V1E2SHRWSjdIeGg1KzA1RlhtOTFETjl2TUs5VXp6cUhM?=
 =?utf-8?B?ejFhRlQ3WkxGeVgxUEpDZlhGVk9qbE1wbXdHV2crRjVpeUZiZklWNFpoKzJr?=
 =?utf-8?B?V1YyaFFEakd3REJpV3hOTEVlSEswc1JpN1FnUUNWQ2k3bkJoTGIzSU02WXhz?=
 =?utf-8?B?OWlWWWF0Q0xZclF2dlhGSWFmWFNpejVnaDNnUzRkQjF3ME5BMFVQV1I0dW9k?=
 =?utf-8?B?R2xSaGtKVXdqNm5RMU5IZklUQU5GdmpkclEvRFBVdkdRQk5pa292dk04eStN?=
 =?utf-8?B?RWdHSEIvWlA3UUFxOEp1TEZKeFgyMHk3Sml0TUhHVW1GYWNLWEJPQm1RcjNL?=
 =?utf-8?B?UUpJM2ZNVEluM2t1WExYcGpXbm1vOGhUMFRIZ0hleVI1ZVZFUlIwOXk3bWI5?=
 =?utf-8?B?ZXF4YkFIeHkwVXEwV01vdlo5SEdTZHR3d1U5U0R2N0RhTlQzelRwRlpEQm5M?=
 =?utf-8?B?cDc1b3p0cDFpZ25IWnZkeFZFSFhid1JXWEpkVWFHY0pBNzltWVZWNU9IN2I4?=
 =?utf-8?B?NTZUY3pFdjJYdTVucE11U3FzSnpnRVZ0cW05WGlOcXpmd0F3c2k0KzRMWnlm?=
 =?utf-8?B?eFN6b09xK205eHRwL3hYU1NiY0h1TGptNGpEeldxRmEyaWIraDZ4UGdUUTI5?=
 =?utf-8?B?amhvdEJMUU94TU14TkFzWVJ4ZWZhUU5zeHhPckNpUDNLWTRMTDA5VkRDWE5a?=
 =?utf-8?B?Sm5nZ1JmMm5QQ01rT1dvRWdpU0JMZmFuK010QjErR0NsSnNtZW1uWFBuNldN?=
 =?utf-8?B?V1d2cDI2SklIK0J2WEhJRFlPb05RVHg3TnJGWTcrYnRpRDUxM1A2WFVHN1o4?=
 =?utf-8?B?NUdNdllhT1lWZVNyN0l0MjA1N1h2NlBpa0pXUW9aOFVCUm9Jd0J2V1I4ejk5?=
 =?utf-8?B?OXdUY3p6L05QZDFZZlphL1MxS1Qrd3dOYmhUL2ZnM1NKcUZJVWZvSmtsOWJ3?=
 =?utf-8?B?VU9VenlBQ1JzWG5lU0xFQ3ZNSHNWK0psT21LbCsxR0RFU3Y3djlVK05ZdTQ5?=
 =?utf-8?B?ekRNMTV6WXczQnYxZUk1TWppME9pSzB6VmdkWG9WNzlma2dIa2hsNWQxR0Rw?=
 =?utf-8?B?d3ZqTndFblVEeThqellpTWRYTm9WMzlDckFMMitnTndCa2U5My9ZZHM0TCtB?=
 =?utf-8?B?ODlZeUdnRzBIYzhqdUtkSXVCeTZXQVZYakhkd2NqaGdKdUordVh2b3BsQmNE?=
 =?utf-8?B?eDZNYmM0Yk81Z3d1eGkrZVZqNGRWMElkSEJWWTFZYjNkUFVuVzlSLzYvZU5q?=
 =?utf-8?B?TCtaaXJ1NUFYby9yLzlBZW5ZUHQydTBEQ3k0Q3BhcFFvaHRiZTd4YUE5ZHcr?=
 =?utf-8?B?dTJiVzVvejlQeXRWYnVWbnZJd3RzNnVwKzR5Tm9BM2hhUkZEaFkzRjNTUzJD?=
 =?utf-8?B?amQwOThRczJld1RZNTVqT0VieVV2b3RSOUI0dFcyeGlLV09ZYmlYUHd2cmZO?=
 =?utf-8?B?NlphYkpKejZZN1BpU1RwYllHOXFwbXdxdHVMNjFVVVhDNFlzSTJpWGhERkNH?=
 =?utf-8?B?a3dINWVCWnNBUXluZHE1cERmcFk1TERYTnBFK3ZRZVp2MVdKMEtlZGlYUjZW?=
 =?utf-8?B?Vi8yRU94SXZISnB1TUo2T3ZTc3RGQmlLcFpINHE2a1lDYzRLQWZ4allDQ0Uw?=
 =?utf-8?B?eHJiayttVnhCQ0M5S1AyS20wUUpsdHBic0xOYy94cTJpNEJuQk5tU0dkRlRa?=
 =?utf-8?B?ZDIzaCtLVG4vd2I1Z0cvU1hLSTZZbnN0ZWJIcGh6NGI0Q2xFbkJpU2RVM2gx?=
 =?utf-8?B?TGR2WHIzTzhMMkM0WERyS0JZNGJ0WGRJM2JDZ0Y5ZWg3QkIvN05tNE0xLzUy?=
 =?utf-8?B?U0pqN1MzVVhTbENvc3BKMjZYN2YzSTA5YWNJVVpkeHFxZ2lBNjdYcTFseHpL?=
 =?utf-8?B?WnI3YjJRWGlMd0JXQWk1bE1WYjYzVm5ZRzlFTmdLZzR6RVVhWDBSVWZmZVlj?=
 =?utf-8?B?MTY1cGpNeDJHS3dHZkxkTUQwVUlsaDl6VFJ6K2NRNVFsZ2ZJVE4rZGxDVHZi?=
 =?utf-8?Q?WNMEII2E7Wk7EImZ6ZQK/P4Ls?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11da39e0-1c10-440f-917d-08dd4476b1e6
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2025 17:17:54.0715
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0H7WWobYbKEonjhp2DuV6cKhoD+ENsAWxzOLYy6EYT/rJFezMyNrs6vLy1kxtiJwN4HequBrjx1aMHGk8lrnzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR10MB4114
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 03 Feb 2025 17:18:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17733

On 30.01.25 10:39, Jan Kiszka wrote:
> This is a first attempt to provide a pattern and reusable recipes for
> saving and rolling back the persistent data during A/B updates. The
> obvious approach is using a filesystem that supports snapshots and
> linking those to the rootfs revision that is being booted. As first
> implementation, we are using btrfs. While the current implementation is
> built around btrfs, the concept should not. It may even work with
> device mapper snapshots.
> 
> That said, the devil is always in the details. And even this "simple",
> btrfs-only implementation took some rounds to find a logic that neither
> piles up obsolete snapshots or deletes them prematurely. Still, careful
> review is highly welcome, specifically of patch 3.
> 
> As we are currently having split /var and /home partitions, this does
> not cover anything in home directories. However, this will automatically
> change when [1] is addressed.
> 
> Jan
> 
> [1] https://gitlab.com/cip-project/cip-core/isar-cip-core/-/issues/123
> 
> Jan Kiszka (10):
>   initramfs-crypt-hook: Add support for btrfs
>   initramfs-crypt-hook: Bump revision
>   initramfs: Add hook for managing /var in A/B fashion
>   initramfs-overlay-hook: Optimize variable initialization
>   initramfs-overlay-hook: Tune the parameter documentation
>   initramfs-overlay-hook: Add awareness for abvar hook
>   initramfs-overlay-hook: Bump revision
>   swupdate: Make var filesystem type configurable for update images
>   swupdate: Activate abvar initramfs hook when VAR_FS_TYPE is set to
>     btrfs
>   Enable A/B snapshot for /var on x86 and qemu-arm64
> 
>  classes/swupdate.bbclass                      |  1 +
>  conf/machine/qemu-amd64.conf                  |  5 +-
>  conf/machine/qemu-arm64.conf                  |  5 +-
>  conf/machine/x86-uefi.conf                    |  5 +-
>  kas/opt/ebg-swu.yml                           |  6 +-
>  kas/opt/swupdate.yml                          |  1 +
>  .../cip-core-initramfs/cip-core-initramfs.bb  |  3 +-
>  .../files/local-bottom.tmpl                   | 86 +++++++++++++++++++
>  .../initramfs-abvar-hook_0.1.bb               | 31 +++++++
>  .../files/local-top-complete                  |  7 ++
>  ...ook_0.5.bb => initramfs-crypt-hook_0.6.bb} |  6 ++
>  .../files/local-bottom.tmpl                   | 10 ++-
>  ...k_0.2.bb => initramfs-overlay-hook_0.3.bb} |  8 +-
>  wic/bbb-efibootguard.wks.in                   |  2 +-
>  wic/hihope-rzg2m-efibootguard.wks.in          |  2 +-
>  wic/qemu-arm64-efibootguard-secureboot.wks.in |  2 +-
>  wic/qemu-arm64-efibootguard.wks.in            |  2 +-
>  wic/qemu-riscv64-efibootguard.wks.in          |  2 +-
>  wic/x86-uefi-efibootguard-secureboot.wks.in   |  2 +-
>  wic/x86-uefi-efibootguard.wks.in              |  2 +-
>  20 files changed, 168 insertions(+), 20 deletions(-)
>  create mode 100644 recipes-initramfs/initramfs-abvar-hook/files/local-bottom.tmpl
>  create mode 100644 recipes-initramfs/initramfs-abvar-hook/initramfs-abvar-hook_0.1.bb
>  rename recipes-initramfs/initramfs-crypt-hook/{initramfs-crypt-hook_0.5.bb => initramfs-crypt-hook_0.6.bb} (93%)
>  rename recipes-initramfs/initramfs-overlay-hook/{initramfs-overlay-hook_0.2.bb => initramfs-overlay-hook_0.3.bb} (87%)
> 

Patch 1 and 2 look ready enough to me now while the rest needs a bit
more time. Therefore, I will keep the first two in next and push the
others into a wip/abvar staging branch so that we can move forward with
other pending patches.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

