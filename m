Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E82EC83000
	for <webhook@archiver.kernel.org>; Mon, 30 Jun 2025 06:04:36 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.84.2])
 by mx.groups.io with SMTP id smtpd.web10.32744.1751263465668954989
 for <cip-dev@lists.cip-project.org>;
 Sun, 29 Jun 2025 23:04:26 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=p1O1oLST;
 spf=pass (domain: siemens.com, ip: 52.101.84.2, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AOlNjO7hNL9AtGrFDTMtI+uA9e1umr2TFCtj7tEqWgdl1csSuE3QRJZwP1J7IjwXp+oSF5o8gj2aD0BLbQ6CGmrkv/0u3XKYViWkub7OlUorGcPkZi/O0IY0qTu4vo7TEcHan+zmXVDKzmqOEmz+RpF5zzC+vTsFm1RLbqSsSwufmS7XFpG2H3dKgnuj/OYrHdpMfVPUsuI/97bZ6th4IrqpZ6Lg1+JK7Qt5Pb5z2MT6k0WfBYe/4gLadaw95fAiCMz1YKZa+l4j0NiON2Fr9hPXNaRp4NImPjpxaky1Sv8Lgolh4dF0DWfS/Tu46jIgzeUuEf/4z4HDmwBwHvJDdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gqj6aRm2RtAE7F7gVGDoEBX5yTwDZyRyv11YO8kycZo=;
 b=yxVNrFtAp84/FP3DrzgtO2kovTLtWl5YUMY8wPUBXDFcvWEhR4xOrB/8rckw8+acIki+6PNaTG11iPWDOmWSIUiqRmEHGUtf1zas+6zOtKY/FlYCHWa7ojmBrzJ5ewQyIW5pW3MAZNvG163CQ4BbWHmMPvoaBP1Y2VtL+io8rcRBM8As3MUFTYc9ilzYbBpP3myGvXE7+jQRQJTh1YgFrfJ8W+j1Ravj5csGD6xZeJ2T1G7yHZeqpOyJCyMslTJOZDMrbKpR/MeZEDF5GN3Sr0H8pkpyOJ8TO79O7EE3etVNxgfpamJz0snanVZdlp8NzvQg+TyErkd7c5n9jRhiHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gqj6aRm2RtAE7F7gVGDoEBX5yTwDZyRyv11YO8kycZo=;
 b=p1O1oLSTq1sbehm4xpxEfZEUypA8LBzutwFW5PFspaz1lGFXAmY9eON7yiZ7/y9ale+08CR4tAupoOvhii1Vq1JMV6FhrybaKX/klqlmcBUdxJXD8gh2EfxPce5weXDINlBjm+7NXkCuBnz/u7UwlCZw8Psbu4zG809VkuJT65nccdczUCW1toPsWKkXaZvBCs8D0hZhjvGancjP3KhaHqt7CC660Tui9KsFnhCMthBaM3qkon3LpaudCSD1wqTlvEsV921WyKi7dItW+XVR8f7czMjImiTuro2WIF89o+R3MLa5GIdill4Vg9iujqESsRILdZ14GQ4PIlo9VDMbkw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAXPR10MB5159.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:289::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.23; Mon, 30 Jun
 2025 06:04:21 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.8880.021; Mon, 30 Jun 2025
 06:04:21 +0000
Message-ID: <69223d80-4392-4000-8665-2fed17dd40cc@siemens.com>
Date: Mon, 30 Jun 2025 08:04:20 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 1/4] initramfs-crypt-hook: store initial encryption key
 in TPM2
To: Claudius Heine <ch@denx.de>, cip-dev@lists.cip-project.org
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>,
 Heinisch Alexander <alexander.heinisch@siemens.com>,
 Cetin Gokhan <gokhan.cetin@siemens.com>
References: <20250626-initramfs-crypt-hook-patches-2-v8-0-46f000788686@denx.de>
 <20250626-initramfs-crypt-hook-patches-2-v8-1-46f000788686@denx.de>
 <d2ae69df-f426-4317-840a-10b6e488da3f@siemens.com>
 <DAX4NZUB0TGA.39A4KRN82TL6I@denx.de>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <DAX4NZUB0TGA.39A4KRN82TL6I@denx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0131.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b9::9) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAXPR10MB5159:EE_
X-MS-Office365-Filtering-Correlation-Id: ea1e6097-b146-4335-d9ed-08ddb79bf503
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?SjRKYWJkamNLb2NhZGJRUnUwWFVVL0xyY3VvV3NRREFtWXVKQlVJc2V3S0t5?=
 =?utf-8?B?bFI1eEthSUttYnRobmRUQWtlOHhmK0VsSnhTMTkrQU5Kc3NycnNZdFhSUFBK?=
 =?utf-8?B?MEx2ZHcrdC9pZ2t0YUcxMjVQclRGZm5vQWE5dStXWHJnUDlrdlBDMXBlREh4?=
 =?utf-8?B?YkxYZjQ3azBlbXhJKzhOaU9VNzhFc21sazBSajN0OHZibHJPbEF3TDhqbi9J?=
 =?utf-8?B?aERxVFd5aUFWNTVpYlF6VzVad3ZHUHo2dHphQnc0UVIvZmRhS2lhNEVTN2li?=
 =?utf-8?B?enNiYmxDVnRBTDZHQjhNbU9oN29pMDl4eVZxclFTdktCRkhyQTNzdjdXeVVm?=
 =?utf-8?B?Ri94NXlSYytFODYwK1J6Wk5QZVU0VDkySE9SS2h2YUVDanZXbmlQNXdMWW04?=
 =?utf-8?B?RHFNandKWVQxRVpucnRwS2F2MkJYQzhGOVJYUmFPK1BTdzV0OXBVRVpyUUxa?=
 =?utf-8?B?R0xqWjJVZHdTby9Pc1BGa3Z3NkF5WGc0aU85V05pNngzSW0rUEV5eFBueFI4?=
 =?utf-8?B?UmJwRC9lTjB3V1FnYjAyQ2JlQVE4cFVFUVdSNng0NXVjODM1Ukc1ZEFKb1Vm?=
 =?utf-8?B?WG5BQnlxalBNRzU3Z3M5dGpzYWQ1eFFldlYyNHRSTndOWW5yRHozRHlSMXF4?=
 =?utf-8?B?NW83SnZjb2p4cUU3Q1BTSUpvY1RnZVZYZkdFOWlCRitEcjJ4ZFN0VzA1ZUpP?=
 =?utf-8?B?aERoQVkxbnZaK3JPSnFLUDRqenYvTEh2ZUpIS1VYbmtHSjlpV1lJeGxtdTNT?=
 =?utf-8?B?K08xOHYxVHB3ZFVEZ3Uwbm56ZjYrNXRkb2NaMDNuUFBTZElpQkh6SjFKRGNZ?=
 =?utf-8?B?ekNGUHc3Tm1WOU5lZGdUckFVVmluK1Jyem1NSGt2cnJIdkx4MzdGWVYyeFFi?=
 =?utf-8?B?QnhKVUIxYThxR3E5TmpKd3hWWCt4ME85ejZ4TkhYWnVVYXY5dEpDZTN1Zzc4?=
 =?utf-8?B?VGdhMlhDM0FTK3FWWXZNM1VWdWVBSUlERG95NjlBdnNUcTJ5blZRUEdVVVpH?=
 =?utf-8?B?ZDkxMHBORXhSS05GTElkNnl3WklSOEFZQzZLMUpSWUc0Y0dqbGh6bmthNUZz?=
 =?utf-8?B?dFdrRG95c0JVMnJsbzlKTnhjRm9MMldtWGtQeUMwTTVDTm9IUjFGcFFndlNi?=
 =?utf-8?B?ZWZ1dElGOUxMRzFJN3E2WHBEWUNRa1Irb05aREpOS0NhUjRrNjY5YzYzVXRF?=
 =?utf-8?B?dEV5U2xzYzJUYjkwMkNoMjRSQ2pOdk1ITHJHSU01UEFjZ0F4QzFQUzFCTXV4?=
 =?utf-8?B?RXJsK0tPVFgxSXBoS3ZJRzROMW1rQUxvN2pDNFNuajA1eVVyV3paQVB1aFAr?=
 =?utf-8?B?MlRlSklPZWlvL084OGxQckliT2NSNE9YQi96dmZTM0FJQTladm43YkdyQTcz?=
 =?utf-8?B?YnV2UmtCaVVYKzdQUG43RlpUelkrT1JJYUtOaWJGNktwV28vZUl4OHNhWTJL?=
 =?utf-8?B?ZU5NVXpEN1ZUYkJ1aUZva1Z2N0JZS1ovWXFoelZqbG5OMmhSQVJmTTBjMEJ5?=
 =?utf-8?B?dWtRWVVvY3ExZSt3Z29FMENwdTBhb3h0clByL1hTVlRQWlFhR2QyRkdYdDJY?=
 =?utf-8?B?N2pmM0QwNzNlVkZOMEgzZ3Z3QnN1WnJ6ZDlBd2MxZXBmbjNXcUowMVoremhY?=
 =?utf-8?B?OU9jSFptSlA4dnk0eWhEeUMzMWQ3T3A3cC8zdXBvN1RheWY2c2Q3amprS1FD?=
 =?utf-8?B?SXg4cHRjUXY4cFVrbFVEOTVydGxLN1FpdnZRQmRURVJIaUx5VVN3dUs5b1F0?=
 =?utf-8?B?OFRET0tscDFsM0kyejI3VTFWbnAzYWRlMTE4YXp4eFdWczlOeWNiUHlQSEVO?=
 =?utf-8?Q?ITFKm2+fv6xGUOqKCjurYq9YI+cYdG7HUu3Z8=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?UzlrdEdOeTBRMnNEaGNMK0JTMDROYk1CeWljYkxuMWRxTDdFbWNYNmVsdXBt?=
 =?utf-8?B?cDJBVkNkVnlkVXZzSU1naGJzVEowTDBWVVZRMlFGYXM5dUJVM1RNTFZpWlhX?=
 =?utf-8?B?S01KbWsvakxkUFVoZXFQWC9zSWlJNmhmejlteUk2QVAxVmI1bUVFMlZiajJ2?=
 =?utf-8?B?QzZXVWhqMThTVnJkOGJISGlTMGFKR1p4VjkrVCtBWUIwS1k1bG5hbG1OU2xD?=
 =?utf-8?B?S25FQW1RMXI4WmFRbWFOajJPOE5lNzhMa2RLZzhkOG5zbE0yeEszdDJFaU04?=
 =?utf-8?B?dkE0R2h0dmNBUjZoYzE0WHBrekpaSGtHL3FyUitSakREbEl4dzY5WHh0Q1dH?=
 =?utf-8?B?NzdDT1J3THRtUmtZOUJxbTJXNG1tRGpxMjdFRFVzT0JSZkx0MEtVdHprQjdP?=
 =?utf-8?B?SGZ1NHV4QzI0aEo1b0V0b1ZzWG14SG5mNVZtQ2tLUjh5SWZpcFgwakJCY1FW?=
 =?utf-8?B?aDd6N1VIVGIwYUJKdDJDMDdTVXMrSFU3TzVYZXdpOTRTcDl1OVE1SlVnSncr?=
 =?utf-8?B?ZFpGU1ZMcjdEaGkxWUduVVltV1NhbFJjZ1RQNVg5WlV4U0YzUFJ4ajN2SUVu?=
 =?utf-8?B?V2NLNkxGRUU0QkdzUnVqNFBRSnViaEpnMGtFbXQrUzRYNUovMDNJRWoyWmdG?=
 =?utf-8?B?bHNhU1NISGFpOE5pekx1VTZ1R040US9YcGRkSDE4bzBuRkNZSzc0QWFiUXEr?=
 =?utf-8?B?OWRuZG9wM0pXN1ZwYUJqdnpyMHZ4cnMwQm9RbUc1bmhnRnZPM3gwU1FQYTJm?=
 =?utf-8?B?SFJISXR4cVRQaVVIcWYyenhDZUdRa0N0d1g4aHhnOWRpSXIxMkZnbG04MTVD?=
 =?utf-8?B?a0VVa0ZDZ2FSRGZhY0lEQ1k3R2lWNGFNejdVdHB6a0YxYU5KMEI0aS9sU3FI?=
 =?utf-8?B?elpBZDU1WlFXYnU1RkpkTkNrbDNhbkdvb3FBRDB3UHRsRHJFNEt1UXN5SHAz?=
 =?utf-8?B?LzFWdWFrVS9BRW5sdFJ0dERteDYzc285L21GY0lTY2tEQ3VlZ0hOMW41YTBR?=
 =?utf-8?B?TEdZalkzSjZQRUEwbjBweEViMk82Z3NIRVR2MEszMUR5VHY5Z1M4MHZQTHRI?=
 =?utf-8?B?VlZ5N2dJZUo5VUJ5OTlFdnpDRytHaTNCYkFWcjZrTGtMUE1aQVg0MzU4RUpF?=
 =?utf-8?B?bjRtbUsvN21lYTlvSUxXMFFEZTAyVG5NeTJQd0hMb09zcHhuNldUdmxlMWJs?=
 =?utf-8?B?cVRnUHZoUVZyTU5KdkRzbW9uUHJ0ZzNBUTV3Z05EbGFBMVRxWWdPbEFGeVBZ?=
 =?utf-8?B?eWUxVkJsaFlQZ21pd1hLM211L3A5bEhCUE1XYndjU0xWamw0VlhnSndzeWc1?=
 =?utf-8?B?WXFkWEhIN3E5VXlIWHVSTHVybGJydXpxWWUyejE0R2lrNTJEYTQ5bFQwcjhK?=
 =?utf-8?B?WVZjOXRuZnBpQlFNbzdMME9oajdWalRjc1FBVUwvbWlHenRrVFdnb2hEWXVU?=
 =?utf-8?B?QnVueURRdU1XTzBDSXFhTy9SZTRQbUNObW0zb2g1T3Raa3NUMXhtM1ZRMU95?=
 =?utf-8?B?T0VZN1BKaVZCdCt4aW9Nb2M0SWpHWC9EeG15SzExY0tBN2lYdmN6Zlg3RitB?=
 =?utf-8?B?ME90Yk1LZkYwYzRjQXo4L05XczBRNXpkUmtpSm9oYTlwUUNnZWNJY3owRDY0?=
 =?utf-8?B?OFJOUHpod0tuZzhYSG5PcC9Fd2g0TSthMUtTeFdSU0lhWHpmLzF2cmljenE4?=
 =?utf-8?B?SmJ5SnloakhXOUFyMHAvRUp0TzNJY2djVnJOWXUzUzdSVGdTWUw0OEVEblFx?=
 =?utf-8?B?UmJLQktuK2dSeGpMNGNqL2wrWGVFcERGSm9uSlpyV0xPQVlEYys5K3dzUk9j?=
 =?utf-8?B?Y0J5c0wwcTkyWEVKcHVKc0FGczE1OHYzVWt0dHZ1THZpNnBXeElIWUQ1bW5B?=
 =?utf-8?B?cWJ3dUJpTXY1RHdUK3o0cmpSaElLZXpTV1dpZWV0eGZmM1BtYVVDN2J0c3ht?=
 =?utf-8?B?dVUvdHo1Nm44Wnk2NWN2QUZtT2NnNExNVldjaWdzMHJ1djJqeDArWnFjaFdC?=
 =?utf-8?B?MVh2cUdHUlEzZUt5M0RZUTJDTTFzLzdCYzRlL1o2YVBMKzB1Q2ZNTGhNamtV?=
 =?utf-8?B?eXdXekZCZjRPcWk1bXB6NGFzOHFlQ0dKYTBGVTFiQXVZOTRPbHRhbUwzSnhm?=
 =?utf-8?Q?2fu0qekxx/8z4oOejYrsMddjn?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea1e6097-b146-4335-d9ed-08ddb79bf503
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2025 06:04:21.7141
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hTVKDvF3JOeLYFswBDij1gcV3ID5wFOFID2Wb6dpFH4HwunlS+0M3ml+H+/lR3opm3JW7CvaATcju2jiB6rzuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB5159
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 30 Jun 2025 06:04:36 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19252

On 27.06.25 09:12, Claudius Heine wrote:
> Hi Jan,
> 
> On Thu Jun 26, 2025 at 6:32 PM CEST, Jan Kiszka wrote:
>> On 26.06.25 11:09, Claudius Heine wrote:
>>> cryptsetup and systemd-cryptenroll do not currently support encrypting
>>> partitions directly with keys stored in the TPM. For that reason a
>>> temporary random password is used for the initial encryption, which will
>>> get removed once the TPM2 token is added to the partition.
>>>
>>> However this process does not allow continuing with the encryption
>>> process in case of power failure.
>>>
>>> For that reason store the initial encryption password in the TPM,
>>> protected via measured boot based on the TPM2-PCR:7 register, which is
>>> the default for `systemd-cryptenroll` and load it if it exists.
>>>
>>> Signed-off-by: Claudius Heine <ch@denx.de>
>>> ---
>>>  .../initramfs-crypt-hook/files/local-top-complete  | 56 ++++++++++++++++++++--
>>>  .../initramfs-crypt-hook_0.8.bb                    | 13 ++---
>>>  2 files changed, 60 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
>>> index 2b4bed02484bface7b0370e6ef1b9953e8ae4eff..9e7525117a03debdf2c526ab742e9428372cd0cf 100644
>>> --- a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
>>> +++ b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
>>> @@ -216,6 +216,54 @@ if [ ! -e "$tpm_device" ]; then
>>>  	panic "No tpm device exists or supports pcr_hash '$pcr_bank_hash_type' or '$tpm_key_algorithm' - cannot create a encrypted device!"
>>>  fi
>>>  
>>> +export TPM2TOOLS_TCTI="device:${tpm_device}"
>>> +TPM2_HANDLE="0x81080001"
>>
>> Is this address something we may want to or have to make configurable to
>> avoid collisions?
> 
> Maybe, but it might also be good to get to learn about any conflicts, so
> that we can choose an address that is very likely conflict free.
> 
> `0x81000001` is used by systemd as the SRK handle, which is not
> configurable.
> 
> For this temporary 'storage key', I selected a non-reserved handle [1].
> 
> So currently I would say that this would be premature optimization. If
> downstream encounters an issue, making this configurable is a easy fix.
> But it will also be good to know about those conflicts, and maybe find a
> better address...
> 

We could at least pull this value out of the script and carry it as
variable in the recipe, also for documentation purposes. But let's do
that on top.

> regards,
> Claudius
> 
> [1] https://trustedcomputinggroup.org/wp-content/uploads/Registry-of-Reserved-TPM-2.0-Handles-and-Localities-Version-1.2-Revision-1.00_pub.pdf
> 

Ok, that choice has a reasonable chance to not collide immediately.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

