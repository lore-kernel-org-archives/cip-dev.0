Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DC37C0218A
	for <webhook@archiver.kernel.org>; Thu, 30 Jan 2025 05:29:37 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.65.17])
 by mx.groups.io with SMTP id smtpd.web10.9614.1738214970993707136
 for <cip-dev@lists.cip-project.org>;
 Wed, 29 Jan 2025 21:29:31 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=P1CNuSWd;
 spf=pass (domain: siemens.com, ip: 52.101.65.17, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IMaPPXzKAmYpEAlEnvr8+Yv57I/0uQXj5eFhxpaBXIpr2EX6aA9/e1TImq8VxwWJ0SMDWYu6tNPMTer/5V0FACEpQECwnMKDBo7SfufTz6F02/eyXwg7FFTGHNiQ/hC3nXU6VTl5AXSxM8c/6orXOLRtRDAssFqUSlZJ/1TTivUNDzfJPOxIyHiTHu6Orz96eXMPRuBmUTHCD+0HjSRtdpD1YnMFsLD6D6wWAwHuAWhX4xo6Cmyab3hVIEMeFfExH3Zd3YrIpsB0s4YyO877LhotMun0zOFufqq+jgEPWcaaVfLT+UVy3s4akVdEYoqOFuMrIffr5aZU6FIKjRfX5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hgUpVkDl+m55rCFMMWMwTdXYHlYj84fBOnEQgHGVKcM=;
 b=Q2DrEyqazRlCD4ZSpO36gNlwehPpfQI1OtUjvLMGMUM6MhI+85wVtRdNL2eVYDm9XKyNw4bFFkmmlujM4R+eKm3IbL+bzY4/4gLWZKxCe/wrp18J24Pg4qXhoGw0P9PMpeNdIaBVla43oTZTHsuu789dnwJLXo1OGm75OrqGYSabDfswGyX55bpFbPL1NDNV9g/QEHr/9D0WjlU4J0JQoDgYJSzQKyxcFIVl2Xu5FI63Ym/SfAuLY8o7xl+mE6TH5N8ftkzm5W5oqVhqzGfdePjaDwanHDnb4wGGhd64Rg2MmyYWoSPe9wzpjT8uscQ3PSN6ABFGatBTQ1DuBOVkDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hgUpVkDl+m55rCFMMWMwTdXYHlYj84fBOnEQgHGVKcM=;
 b=P1CNuSWd/lvxM9uuyLBFk3J94yVWxTsIKBL3k0MJEtGxOss+r2zBPWYQChr+DfaQzYaNZQzXGNy572DqOcC+8AdkAdwVF/+fyzWYnGmCy7CAPYE2zWiFpjEHhDM/kMtS4d0ySNFaZdjtdynpU3ZEzIkdNKqjJrmcGVJRKQyYT9MTl5pKvNYGcxsxfeUlYJNfZmuM6wHPLiADyK0lPmjcMKt/L2vwg5V2VnzXqELv9M7AbZjUCEXBhDZ/TrrXYZrHlcLEOHPrV022LTwVXvJUI9vz9K5vIpaUjGHLnuMhS1wlt2t2SknylVX6LCCPtnV8UK67hbwdFELc5+gh3rEdbg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB5307.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:337::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.18; Thu, 30 Jan
 2025 05:29:28 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.8422.005; Thu, 30 Jan 2025
 05:29:28 +0000
Message-ID: <38e3b2ea-9dad-4f14-8e73-9dc8f4c05f9d@siemens.com>
Date: Thu, 30 Jan 2025 06:29:27 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH v2 1/3] build x86-uefi with secure
 boot
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 Sai.Sathujoda@toshiba-tsip.com, cip-dev@lists.cip-project.org
References: <20250124132246.64738-1-Quirin.Gylstorff@siemens.com>
 <20250124132246.64738-2-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20250124132246.64738-2-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0413.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d0::14) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB5307:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c7edc38-0c6b-4ea7-33d3-08dd40ef10d1
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?cjR6TTJRTzNkMVlWczFJMWNpNEJ3Ulp2N3IrYSt2K1lseXowZHRpY252N1pD?=
 =?utf-8?B?ZUU0THJIUEN5dTlwbXMxRHMvS1Z2aTQ4bXRrNmVXb3dUS1dnUi8yUWlJa050?=
 =?utf-8?B?enV2REJrS3o4bDc3SWRnRGtzNzFKczNtejB0ajI1TmtVYkZoVlU2U3RPZGE0?=
 =?utf-8?B?L2ttdGx3Wk8zOXhQSjRaOFZieEI2ZGRCUXB1TzRhZ1hIUW1WQUl5emFMckdh?=
 =?utf-8?B?T1N2U3ZDV0NpOHZwcFp2VzNkRWczWGoyYkRkeEVsenVpSTNFbnVIVGFMWGpx?=
 =?utf-8?B?ZTdmWHN5ajRPZlk3NThOV0dDZkFQbUJ6eFFXL2tZd015V3cwSk1XRHVoUXBu?=
 =?utf-8?B?aEppQXE4MjQwQzVOWTU1NS9yUFRGaXJQeXk2S0ltcEljUmVucS9RbU5vREdW?=
 =?utf-8?B?dkZLaysrenh6NTMxV01Zd1hxd3VRRzZrT2s5SDBxOG5KU2JPQlBlZVV4ZnJJ?=
 =?utf-8?B?VDRMdnpXWWNkSk9XRmY2bkw0K2xSRmtuWDE1Nzd6c3dnWTJBZXlSWHFEWmt2?=
 =?utf-8?B?UDRVUXdqcDI1MHlxSHAxMUlTbTJHUU1FQ1VtSm9USmhQVDgrd21kVDNHRFd3?=
 =?utf-8?B?VG00c1VLTGxaSWVPdllXNzNhM1RhN2tVT0hVSExkVGVvajBVL0srWUFFcjBm?=
 =?utf-8?B?dmo3VXFlbEJqNFRoVzdmY1lMbTVZWDBkcnVZSWNCZTdBc2RzTkV2bnplOE1v?=
 =?utf-8?B?ZVpnMEV2ai9waFhhV2dOSTIvZXRUZERRWjlvTUVpQTk2N1E4TmdsSTMwWFJV?=
 =?utf-8?B?dVdJY3E0MXcrM0VEYmFUSWVoc2VBeHhmM01wVTV4V3JOeHJrZ0xzM3JKa2x0?=
 =?utf-8?B?YkM1QjBBTjdpWHRWMWRwYm9xWWtWTVRIZXFjTkkvc3YzZTlPM29TRDZHRUtq?=
 =?utf-8?B?RWd5RmN1cWJLNEUzeGtIbWp4Q21mSHkvSk5KMCs0VlA4WE1Ta3J3ZWgvK2lL?=
 =?utf-8?B?R0UxUXMyUmlVeVBXY1hZZVJPa09QUjhRTHVUOHN3ZTJta01qV3JnRTZRUTNv?=
 =?utf-8?B?RTZHNHR2UnFsYkpBMzRocHFWSTAyZEtvcVNjak00NXg5cVFJZG81NGcyaDRr?=
 =?utf-8?B?aXg3RWZwK0VMc3ZMUG5JKzM2bkZ6UllZTWFGQ3Z0UklkZ1JBNWI5VXhBUm04?=
 =?utf-8?B?Ri9vc2twVTJ5bktUTkVpL0NHcXZUMFM5R2ZOSUNnakJPbmdKWTBHWE9ubFBZ?=
 =?utf-8?B?aUwvMVkyckczaUdmY1NlNHBhcDVZYTdPRm5xNGlYZDNsWndiZFhFMkk5amNR?=
 =?utf-8?B?WHZoNFdXazh3MjlyTVpUb1ZFcjBjRlVVMXFrWGlHZ29lWk9tOGtyTVIyNklM?=
 =?utf-8?B?SHJka3l6TWo3aGtMVXlEWXBNeko1UTNTOVMwQlR1SUk2Tzc3UENxd2QyTFdn?=
 =?utf-8?B?emk4ZDlnY0NZeldKMzBMbkVrek4xSmQ1ejhBM0VVRmtrbDc5RVNLRi9LeVJL?=
 =?utf-8?B?VysrUmxjS1FNQ01qeVlLaWh5M0tyOG93UWpGZXAxYm1STmV3NzZTMkZveEYr?=
 =?utf-8?B?ajZ3TU9jYWlyeGxZNHFqOUdkRjM0Um12a0JjU05UQkNuZlI0UTRTSnVDWUU2?=
 =?utf-8?B?L3MxdlZyOWdQaE1odFV5MUU4a0JndFNRTzZNOGFsbzY1VGNDcmpsbHJXY0I2?=
 =?utf-8?B?VE5xNnpiWDBJejh1UVNPMEVNWm1NSTVnWlVrc2FWS2RsMVVCaGpGWlhleHNC?=
 =?utf-8?B?NUxtbzNOTk81R2tCVmU5NDJ6N1FZL3k3UVFBWGZkSTI2Rm53ZkQ0WmFxU0JD?=
 =?utf-8?B?Z042UHZJTEJvTTFYUzA2V2lYQms1Ti9iRWlmZldpaXA5UFIxNExDRGtWc0xD?=
 =?utf-8?B?VkR0Z3ozVm1aakx2K01NN0VrSHhwZjV5dmJackNYRTNzU0xPY3dTcjNxVi9q?=
 =?utf-8?Q?A7pPN6HIXttZe?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Q3kwM0phRTJqUHZNTllPNC9HTGFZVUlHMmcwSFFvR1F3VENWL21HdkRNRXRz?=
 =?utf-8?B?V0ZoOU9hMUY3SzRkc3ZqWkVPZXZpbEpESnNXSFBVcUtVbmRkekhoQ3B5MmhD?=
 =?utf-8?B?M0ZrZDRxN2U0S1gzSjlsWkNJQ0lXZEo4bmh6QTJoSmlWWEtaUklxVU9DV00w?=
 =?utf-8?B?eFMya0ZSREI0QmpKM2dQWkhmTmdxTUNpSDdSZ2ZlT1gzdjVzSHNHU3NkTjAx?=
 =?utf-8?B?Y0gveU1Hb2JjTUF2aVM2azdBZEE3WkJVcWdNdk5pRFFwTGtqd3JvbGRrMitI?=
 =?utf-8?B?Y0dQbjJTWlJTcEZPTWZpSjlkTktaODhIb0M0eGRPZzBZMzdpVjVLVk1ubm85?=
 =?utf-8?B?TUNpTFNPSUkrVk5UaVNYWSs2dWpoL1owSUE4VFgxSTdmTXQ5aFFvV29NWFlX?=
 =?utf-8?B?ZVhRZFJadjJMSGVkRzlHK2hZaFNlWUYwYzdVUzVxZXBRU2ZqV0dCWUpab1lW?=
 =?utf-8?B?TWhmVEM0MHpjNkUxem5SYU5teHc5NlhnRXhTQWtIV2lYNld3WVE4cXlzWFln?=
 =?utf-8?B?NmZGVGZNaWZDUlp3Q1paN1lSak90RE03aTl5UjhoUlVKZnN4Tm9NM3RHMk1s?=
 =?utf-8?B?Q25Wek1NOXpNMUsraC8yMlFSU3pGdmU1Vi9ZRjdyS01RVDk4cTJZeFVsVWRh?=
 =?utf-8?B?Q1ZMRlN4OTZBYmF2ZjFFV0JTVjl3UWxoRElId2JSek11b3R1aHNYeERKUXhS?=
 =?utf-8?B?WkEzaE1tSytXa0lDbWs3UWpUc1JWNFBQOGtmRjUrRitVMTBGMjhBbGptMEVv?=
 =?utf-8?B?OE1ESlIvckJRNGFUcEp0ZDdobUtYeFluM3ZxYzhjNlJRbmFkT1pNdVV1NnR2?=
 =?utf-8?B?cVROUHlKYUhzaTQ2ZHhYRW5lUkQ0YnRoYzk3RGpLdXNhK1Y1N203MGdGekl3?=
 =?utf-8?B?QUgwSmZrMUNEaXNjMVRCU2RIK25zK0crSU4zL0JVVzJ6aG5mcXljT3cxdVBu?=
 =?utf-8?B?aitiT0dLY3NiVXNOMHU1cFpIenlLYXRrNzA1azZpcG1wNlJpODk0R3ZEQy9i?=
 =?utf-8?B?YTkzWTQ0M08zZmlFb1JpVlE5RGNad1hFSW1RRXhsMFVjaFdkcjhNK3BBdG1M?=
 =?utf-8?B?bW5qcTBzWXpqV3VoTjZWa3BkL1kwdmIzZmVuemV3aG5SZzhISk9wc1VuOUty?=
 =?utf-8?B?ekFFWG5COS9PdkkyRi9lWVBaZFN4ajYwL1MwdXhvRXorQ0RrT25RamUxeU16?=
 =?utf-8?B?cjRHZ0ZIYTB1TXQ4RFcvaVB4ZDdlYnJBUVFFdXZ2bDNjTkMvTmtIcGVsYkhz?=
 =?utf-8?B?eVVqb2VqZVZtbzZhd1RHa3J2dUtwUGxTc0JOendHRmZuWm1VMlpWQ1piaG5Z?=
 =?utf-8?B?ZEVIZ1J6YUxjbEVlZlpFZVc3R29rVnRpUmpkM3B5dW9IRnpIZVpQckVtUGxp?=
 =?utf-8?B?bVdEcEJZcC85MzJWY0hhMzRwL0xFVFZ1UHZNdXVGWG00VCtiUllPd1lsMHo1?=
 =?utf-8?B?ZUd6MU16RGRJZitVM0VxamlQWFhZZ1R4bE0xUW1MWFZoNDRGcWdLZWlVSC9M?=
 =?utf-8?B?RU5KM3VRQTBWbElkLzdxa3phbUhWdHJ6VEQ4c29yMW00NnQ1d1RWTWlkREM1?=
 =?utf-8?B?L3U1MHlXWStiN1JFNlpURmJMT3N5eFVNNlpUY2d6M0poMk55WVNXMkdVelNq?=
 =?utf-8?B?YWV3WmExaTBtWG03S2ZzVkhMNzljOVZHMXRpVEFRa21INFB3N3J1TXd0QldM?=
 =?utf-8?B?NWRTU0h0V05aL0Zha3lOMXhqdEVzWFczRnEwOXBTMEFjTGFoQW1oWTV3dXVF?=
 =?utf-8?B?VTZMRmhNZXlnUHg3MVFFaVBzcERlalV4bEhnU2hRclgzTk5FVEZVL1VwMXZq?=
 =?utf-8?B?WmN0bUNzaEJ4S0JHZkg3VHFReExIK0ZZUGpndzJkdkR5NHUyenozRkJ6bFZG?=
 =?utf-8?B?Tk9JZVQ2K2NBOXlOQW5Od2xNZjJXV1YyalNqUk5LYmx4MHR1dUVDSWtubHRL?=
 =?utf-8?B?MkYvMnQzVnhudmNOMmNrdlFsQUVsYk1MUDIzQlprRW1vZnpkTlhOajdwMWRR?=
 =?utf-8?B?OVhja09uM2hoMUNoc0lzaFExQXZsSTRRQnRJWkpWOXRldWFObUNtS09ERXJK?=
 =?utf-8?B?QXlDTWM4OU9WaU5YQUJrVHhrajg2ZGhYcG9obXFsUVZaSHNiNG5majVpRzFN?=
 =?utf-8?Q?zjsKk9w9lZQWLmQwUanxZk471?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c7edc38-0c6b-4ea7-33d3-08dd40ef10d1
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2025 05:29:28.1286
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QM3QGJfRTke35FLtRsg5XjRbuAKakfaElpdP0+UNHtUG5cBJpbxxGDvIuGyogLklDWLG8govoLy9w3NmefRfvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5307
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 30 Jan 2025 05:29:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17681

On 24.01.25 14:22, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  .gitlab-ci.yml | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index d4bd283..42e247d 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -241,6 +241,16 @@ build:qemu-amd64-secure-boot-encrypt:
>      deploy: disable
>      encrypt: enable
>  
> +build:x86-uefi-secure-boot:
> +  extends:
> +    - .build_base
> +  variables:
> +    target: x86-uefi
> +    extension: security
> +    use_rt: disable
> +    targz: disable
> +    encrypt: disable

Why without encryption? And can't we replace
qemu-amd64-secure-boot-encrypt with this physical target? I'm looking
for ways to avoid building more variants.

BTW, you are dropping "encrypt: disable" in patch 3 again - it's the
default anyway.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

