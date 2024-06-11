Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E482C25B76
	for <webhook@archiver.kernel.org>; Tue, 11 Jun 2024 11:57:06 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.83])
 by mx.groups.io with SMTP id smtpd.web11.7609.1718107016162460889
 for <cip-dev@lists.cip-project.org>;
 Tue, 11 Jun 2024 04:56:56 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=dEKSK9vE;
 spf=pass (domain: siemens.com, ip: 40.107.22.83, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LRggVOukjxOsKXHgUxzHCfzzhIT1Da93E4RU7C5oiSm1MswBBV4+J8EAEofpQLZE32nt8qqvWVlG1zrrqCTwOLWfPjzYuRBoAEvKpw64vwB38qI5JZD4Z9MIkB1EZqs9kCqX2oUjX981nWZLco7yZ4n+aQGUDCkFE/SuHECAHaSYdedgANg8IbK1/PJymtvlcsRCBUvIHE8OTD4DtKt+tmKelhmYIp/Ec8MXS8J2r+vRdDk6fNLnApLOQ/ctlhc069Oyl6SV7h01KBN3EoTAr/tQeaxda9YtHt3PA207dWe7ZcWf2t2xpeLREl2hZ+QZclKEKAFjOWGEJtVinG0x5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M0i1vaK+Ax5/muOBoln8VrV0xXcJv8e8lRAVL/rW5Fw=;
 b=Gv8O0eXfepOeKrO4w9WwRa/nZfJvVqjsUCCsJqkV94/+AjTNGVU2W81V2+fGTQyrFcIgNrcs9J5C4iXcakyt3ni4QLNAiEmq0g/aM/A/rbCuAUVTUZmxcCERpJjGqU2WYfTuf0rmcJwpvi6AMIMDxj8/QSiFbhc0qUgVfOZvccVpp8Mk0+YD9dwFg3LaJQ3/Nz6rjjQUxqxQIYrdzO0bD4JyLyAoCbpGv6qBVDOz0btLHlH92SUqe+GluONYH0t/giwYIPyRyeic0Je59CwN9ld9mY3+rPy76Vf4Jl6OH/giSPypYGbk7lpN5LdwtyyEFwPsric9tJO3KGlbeXAW2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M0i1vaK+Ax5/muOBoln8VrV0xXcJv8e8lRAVL/rW5Fw=;
 b=dEKSK9vEs7qjvR2JGNQYpKIF6ShA8zu/8p7trBXdCpqIeVG0oJjLPXQJEH96+yKEN4ZsqEOwU2jRYMxysX2k1Ldy2o1f8BFevtAGUP1D5UK1TXyrakoX+RihOwf+eT9dpKlkGMnBSUCqzAjGQu0xKdaPCf9IFHXf98wBl8tO+CqV+gXhpsrJCoUb/rXo/RHoZQwtzMnXsOYt99vfmJfdsxqiHlaoFW2Le8/PLgCxjZs28xeiX311Nhe+XGns3qeMICbMFkUpGp4iVv4vlyucMzZDm4MC+VW0ecEQzvoVIgUlOj8Hwv9LDbnJS8UvHVWhJRRprDgc0WrtZuAKHxIS3A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM7PR10MB3189.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:108::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Tue, 11 Jun
 2024 11:56:48 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.7633.037; Tue, 11 Jun 2024
 11:56:52 +0000
Message-ID: <4dc23394-7dfd-4f30-944d-90959696e39c@siemens.com>
Date: Tue, 11 Jun 2024 13:56:50 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH v3] wic/plugins/efibootguard*:
 Take --size and --fixed-size into account
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org
References: <20240508135539.2780114-1-Quirin.Gylstorff@siemens.com>
 <7272b70c-efff-4708-8c24-7aa67732d924@siemens.com>
 <1a70b36f-8ef7-47e1-a3b7-e89a2eb079b0@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <1a70b36f-8ef7-47e1-a3b7-e89a2eb079b0@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR5P281CA0050.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f0::6) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM7PR10MB3189:EE_
X-MS-Office365-Filtering-Correlation-Id: 035f8466-977d-4852-c8ac-08dc8a0d9576
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?bE0rcCtiQmNYemttRjhJQW5NVE5aRVpyVWdJbXBNM2ZmelpOeHFzVitTa01O?=
 =?utf-8?B?dHJqVWpQQ25zcUs4aHF0R0FvSjVpUWljWkk1eno4S0d4RVJyWEptQ25RK0pa?=
 =?utf-8?B?ckRXSXdySTEyTWlLWmNGNGdNc056ZithMjZDRkgyazc5THRTWDFSc1lQRFBD?=
 =?utf-8?B?dG5CaC9FdjBrMEptbU5JTEhDdUNkTlkzbHVYTW8zVEx3TmRLQ2syYU5TWDZ4?=
 =?utf-8?B?WDBBWWxDU2xJZjBPV0EwWjdEQzFFNVFxMUhDaEpmWGFjd0hIU1ZTMTBlbHd0?=
 =?utf-8?B?VktSVEpiMXpoK2Q3THl3VTBVbS92ZVQ2V2hWS2t0SnNaNlZCd0U2M2VaKzI5?=
 =?utf-8?B?UlJGZmpMK3BBYmVhZXo0YlRTUHJYaEdHSWtDN3Ezb3FtVHNoby9XMCtQSFRM?=
 =?utf-8?B?ZVcyVGlEQkdPbitlWmU5NFJHeVZZcTBGRXY0VFRkMHJMOVFWb0JtRHFUVHR2?=
 =?utf-8?B?WjBabG5vbE96MXZycjBxU0k0VFI1TW1DSEZhU25YNmU1TVV4amM5S0h1empy?=
 =?utf-8?B?TmdMZklzN1lEMnNuVlZqWmtuNVUwM3RvZzRSUm5hQ05QTGRRMkQ2bTZoWXVl?=
 =?utf-8?B?a1FsbGZkR3NPZ3d1VHBjeVQ4NUUxU3k3Wk0zUU5NV1dFbFBHckhSbm1JZFQr?=
 =?utf-8?B?SWd5ck9YWUYrVWNDVTF4Z3Ixc0lMUG1OeHRYK0dqY2dWMFNpaldwZ2c5SXov?=
 =?utf-8?B?bTZzY0x3VEI1ckRnaFVZMW5ZdGNWOXVaMzFVK0c0Vk82cEh0SURaZDl6Mjc4?=
 =?utf-8?B?RVRhaEttN1BTRHVnTFVBejBYajBJMW9jSGIrbEJzUkV3T3lZQ3NOOHdHZUxt?=
 =?utf-8?B?VksvSkl4YVJLYkE1V1dObHBCTFlRMEE5ekVrektiYTVadkM5NzN2MkJ2SmY0?=
 =?utf-8?B?ZXFoOUZtZlpwdWRTZEhFcXdzb0grL2o2L2RybUdCVWZqT3NJbUgwVkFPVkRq?=
 =?utf-8?B?b25zOU1KMEhOYjhJZjZFWlkyTXF5MWhyYlhManJYS3liWUhNQjVxck8zMjRT?=
 =?utf-8?B?Y2N0OU5qeDl2ejNPV2lKQzJKbmJvNnMrMGlEd2hMVVJsZ2QvWU1NOWJWbjJy?=
 =?utf-8?B?RGNCZGhzU0RVVEtKSDN4SEZ4OVJzYU5iam5UZEpDVDFZY1NtTmtmaGdGbVFT?=
 =?utf-8?B?MktjY1RTV1FhdlQ5RlNJTmJOUFQ0Qnp6STJ6Q1FEQ3M0clNIV0o1NGp4RjNn?=
 =?utf-8?B?bFp5WnZxc3VVM0N5cEdwUXBuMFFtVDB3RmZ4VHFZNW1Ha2piOXpjMmo0Sk01?=
 =?utf-8?B?RER3ajhCTmdMblRJckhuaWhpck1QWUYycko1amFka0JGOUJ0clV4cXMzRlRp?=
 =?utf-8?B?WE1YYlRyTTVPS0FtUDdnK1VxUTZvbWY0c0Vzbjh4VnJiUmw2ZERQcFhRcHAy?=
 =?utf-8?B?N25DVm1rVXc3ZHJRQ3NEU1pJSnVvc2N1UWFXVFU2OVREeVZzenN5d0FXSEc0?=
 =?utf-8?B?WUZ3VU13cjhJSmRkNS9qSDZvejkvRXlpeGU4cCtGbXMxK0FNNllGVGVGdkdy?=
 =?utf-8?B?Q1FpbWZIb2ZCTTRHMThDbm9UZ3pPSWZ6ZGpKYzBVaDk4SFRiZVpUUVVLeWlh?=
 =?utf-8?B?cnZDbCtibTBTcE9FWm9jUkkrR2YzTHZyNm9VbUlDN3dTWCtwL1U1NGpoVXho?=
 =?utf-8?B?TnQxZzIwanRibDBua1hQUjVsb0RJZUxxWUpFa1JKUFN1N2szVkJ6VlhwK0NE?=
 =?utf-8?B?VlZXc1UyV3BwT0V2NDhKSkpqUko3cmtuRGd5QlM3ZUtqSGNBbHF5M1FIR0RJ?=
 =?utf-8?Q?aSL0GFyIbmORrkNx5zJrIKIg1ud6mBU7FrsYITY?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?aVIwOGk5elV1M3BWN1pmbmV2TnhIZkY0SGtvZUh5VnYrRGZwanFCRi9kVjBU?=
 =?utf-8?B?Nms4TWoreG82emQ2QUVEb2xOd1VCZmNwM0VMTUw0Uk9DSlRvM2JiZnh1OTI2?=
 =?utf-8?B?a1owdFEyMVI4ai9IL0Y4bTZYK0lRNVFMMFQvSENrbHBRWTRWeHFmUkRlVytT?=
 =?utf-8?B?NGpOMXhIQTdRM1ZhZS85UDVEWkFicVIwVjJqdUc5WjhRYVc1TWZjSFJWSGlz?=
 =?utf-8?B?cTdrVWhLaW5zRnBoSXVaSjg4bVI4V1A4RHZnRXZxaTNiU3JNVzFtREovUnRn?=
 =?utf-8?B?MXliYi9EYnMxUE9LT01MZlp0Nmt4MmFrMFBUdnEwRmhiMXh4WjRuOE5zY2I2?=
 =?utf-8?B?QTFjQ0JHMVRYUTBHQURRRXhIeVlpV2hMNkZFaEFlVDNNRkJyZE1lWkljSEpU?=
 =?utf-8?B?YWNoWHRFSVNsclFoQlYyMkZ1b0xxQUx2cGlraWxlSCt6bndaTHE1OWVNempU?=
 =?utf-8?B?R3J5NzE0a3hIMDYxRXhoSUt3bGVRWUptVVpRenVpUHZQVG5jQjMxaHZGLzZ4?=
 =?utf-8?B?TlVYQ25ObnB2b1lVMnppajdnc0h4LytuSEdGbjhhWW1KV1EzbWorb01pTzd3?=
 =?utf-8?B?MStzRVE5UGtScnZ0bkJ4cnIxbVZncmNVckp2OWpTMmgwV1VUZ3Z6ei93U2hs?=
 =?utf-8?B?VzN0djVZVENZbVVVVEg2MTA3OHlyQTFLTTBLZFJ1d0hmeVBCajFqSlU3Tzk0?=
 =?utf-8?B?Nm9YSW8zZjQwa0x3N044Y1U3aG9pTzNvRUxiS0QvS2tSM2dUaDRBN2tnaDhr?=
 =?utf-8?B?Q043c01SRzduK2VDaFV2Rms5cGVvY3JucmVSTCtGMGZ0dkZhMUVxM1I1bkhz?=
 =?utf-8?B?K2Z3MzNnU0pKVWNWSGRxVVp3YllLeTlLVmlmdEpXU1lNMG1qRHdydWlxdktK?=
 =?utf-8?B?MkFYZVZhcmp2bEpodnlaU0Fwcy9LVk1hVU5TcGRtOWpwNVorZysvS2RqSDZv?=
 =?utf-8?B?Zk1IRjRrOGVVb2o3ME8wNXYyTnlBeGhabkx6dUN3RnNFZGxodXV2MkZ0bGtp?=
 =?utf-8?B?ZlhXRWk4VHBmOERRZ0xjMTB6aW5ab1RBd1JkbW5wZzF3OHRwMlFPaFExbFJ0?=
 =?utf-8?B?bys4WjBNR3M0QWwyUUd2RElDNXVaVVlVelBIMlFIWDlKOHpEWG92akdKclRl?=
 =?utf-8?B?S21zMGxqNjliYjhTdHpmNzV5YnE4N0tDNmt2aFk1cEF4UVc1dExIOHEwY2t5?=
 =?utf-8?B?K1RxdUdNNzJKRTNhbFIwYXMxTlUyRktES2xYTCtNRWlWMHBqbmRMREJISWNm?=
 =?utf-8?B?Y3NPZHQxR2lnQjF6K3Y4akc5b0RZTXZaWmNYS1F2Qjk2Qk9LL28wQXA1V0d3?=
 =?utf-8?B?SjRjcTBEK1ZsRmxNbnB1OHFLQnlEdXRyaDJiUjlUaXEyMFBZSk01TGYzdVdo?=
 =?utf-8?B?TlNwVUhKbUhnbUxWNTVjRzF3d0VSNWNmdER5dTFmbkhXNHY2YmhMQk0zU3RH?=
 =?utf-8?B?RnNQS2dkK1dtakgvTjF5TWYyUEdDUnQzNG4wNjdWcGxORmpEZlYvY2g1cklK?=
 =?utf-8?B?YzFTSmlPYXhLQXdDeWpRUkhIZHc2QkpwSkczbGdmSEM5SXFyUCtjNTYrcTdF?=
 =?utf-8?B?Tlg4ZFNDdE1JSkFDVU1vWnlIZmVTY0hxdG9wUW9GaXFsYXozYi95TWt6U28v?=
 =?utf-8?B?RWQwZS9qVVRVUG5OdzZQUjgyTTZQUTJMTXVvT0VYTksrYlh4NkQ2eU5rQ0g4?=
 =?utf-8?B?a0w3eFhIN3JMMzdjU2VLSTBBOHNhTHNiRCtHZ0xvdjhaWFFIVEdCNkpmWVY5?=
 =?utf-8?B?V2pCVUdYVWlBa3hkQlZ0TDFJNmN5NlY3YkpIVUhtT2dvWUhWandZRXlhenAr?=
 =?utf-8?B?S0tPdTJzRG5DUkZSdDZYb0hQaHpyd1RjdFVPVlA5aFN2OGFkZ3lycURtSkVP?=
 =?utf-8?B?YjZMc0dsTnFFSHNhY0FTRkU4RWxBcTA2NFJ3MkZBaGZlTnE5dTJzNThXdDZI?=
 =?utf-8?B?R0FRSWg4MVNFcjBmbW45VWl0SDZXanlEWHJrNUI2bTVqQnJIMk1Uc09iaEdt?=
 =?utf-8?B?TE8rZGxPS3l4QktNeVBZZElMVE1kOGFNa0lEakUrMGVnV3h1eTBYYWlaK29H?=
 =?utf-8?B?alZTYVo0TWlQeHFZSTZ3VFpzK1VWZFR3SEs4RGV6S3U2Z2tPMG4yTFhCSzFY?=
 =?utf-8?B?bVVTb0gzY0lVU1ZiR1ViMFJ0aDlxQndHbVlCeXFyUCtPSkJzbkFVZUpKdU9p?=
 =?utf-8?B?L3c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 035f8466-977d-4852-c8ac-08dc8a0d9576
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2024 11:56:52.8945
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 50+DCW3UUgbYABcuR0XOE2In2CThr/rRdgYFAL7iJBSQwHe57BDZgj2jrJJJ8vWsgaGVo4ql5odpPBODnbHpRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3189
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 11 Jun 2024 11:57:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16190

On 08.05.24 21:56, Jan Kiszka wrote:
> On 08.05.24 19:31, Jan Kiszka wrote:
>> On 08.05.24 15:55, Quirin Gylstorff wrote:
>>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>>
>>> This fixes the issue that wic arguments --size and --fixed-size
>>> are not correctly interpreted.
>>>
>>> This fixes issue #104.
>>>
>>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>> ---
>>> Changes v3:
>>>  - remove unnecesary setting of FAT-Size(-F) and sector size(-S 512)
>>>    the sector size default is 512 and as FAT size should be caluclate
>>>    according to the partition size.
>>> Changes v2:
>>>  - replace size calculation with part.prepare_rootfs_msdos
>>>
>>>  .../wic/plugins/source/efibootguard-boot.py   | 34 ++++---------------
>>>  .../wic/plugins/source/efibootguard-efi.py    | 30 ++--------------
>>>  2 files changed, 9 insertions(+), 55 deletions(-)
>>>
>>> diff --git a/scripts/lib/wic/plugins/source/efibootguard-boot.py b/scripts/lib/wic/plugins/source/efibootguard-boot.py
>>> index 4e3aefb..2b06fd1 100644
>>> --- a/scripts/lib/wic/plugins/source/efibootguard-boot.py
>>> +++ b/scripts/lib/wic/plugins/source/efibootguard-boot.py
>>> @@ -136,40 +136,20 @@ class EfibootguardBootPlugin(SourcePlugin):
>>>                  msger.error("file %s not found in directory %s",
>>>                              boot_file, kernel_dir)
>>>                  exit(1)
>>> -        cls._create_img(part_rootfs_dir, part, cr_workdir)
>>> +        cls._create_img(part_rootfs_dir, part, cr_workdir,
>>> +                        native_sysroot, oe_builddir)
>>>  
>>>      @classmethod
>>> -    def _create_img(cls, part_rootfs_dir, part, cr_workdir):
>>> -            # Write label as utf-16le to EFILABEL file
>>> +    def _create_img(cls, part_rootfs_dir, part, cr_workdir,
>>> +                    native_sysroot, oe_builddir):
>>> +        # Write label as utf-16le to EFILABEL file
>>>          with open("%s/EFILABEL" % part_rootfs_dir, 'wb') as filedescriptor:
>>>              filedescriptor.write(part.label.upper().encode("utf-16le"))
>>>  
>>> -        du_cmd = "du --apparent-size -ks %s" % part_rootfs_dir
>>> -        blocks = int(exec_cmd(du_cmd).split()[0])
>>> -
>>> -        extra_blocks = part.get_extra_block_count(blocks)
>>> -        if extra_blocks < BOOTDD_EXTRA_SPACE:
>>> -            extra_blocks = BOOTDD_EXTRA_SPACE
>>> -
>>> -        blocks += extra_blocks
>>> -        blocks = blocks + (16 - (blocks % 16))
>>> -
>>> -        msger.debug("Added %d extra blocks to %s to get to %d total blocks",
>>> -                    extra_blocks, part.mountpoint, blocks)
>>> -
>>> -        # dosfs image, created by mkdosfs
>>>          bootimg = "%s/%s.%s.img" % (cr_workdir, part.label, part.lineno)
>>>  
>>> -        dosfs_cmd = "mkdosfs -F 16 -S 512 -n %s -C %s %d -i %s" % \
>>> -            (part.label.upper(), bootimg, blocks, part.fsuuid)
>>> -        exec_cmd(dosfs_cmd)
>>> -
>>> -        mcopy_cmd = "mcopy -v -i %s -s %s/* ::/" % (bootimg, part_rootfs_dir)
>>> -        exec_cmd(mcopy_cmd, True)
>>> -
>>> -        chmod_cmd = "chmod 644 %s" % bootimg
>>> -        exec_cmd(chmod_cmd)
>>> -
>>> +        part.prepare_rootfs_msdos(bootimg, cr_workdir, oe_builddir,
>>> +                                  part_rootfs_dir, native_sysroot, None)
>>>          du_cmd = "du -Lbks %s" % bootimg
>>>          bootimg_size = int(exec_cmd(du_cmd).split()[0])
>>>  
>>> diff --git a/scripts/lib/wic/plugins/source/efibootguard-efi.py b/scripts/lib/wic/plugins/source/efibootguard-efi.py
>>> index e82e990..48f7523 100644
>>> --- a/scripts/lib/wic/plugins/source/efibootguard-efi.py
>>> +++ b/scripts/lib/wic/plugins/source/efibootguard-efi.py
>>> @@ -100,35 +100,9 @@ class EfibootguardEFIPlugin(SourcePlugin):
>>>                                                 name)
>>>          exec_cmd(cp_to_deploy_cmd, True)
>>>  
>>> -        du_cmd = "du --apparent-size -ks %s" % part_rootfs_dir
>>> -        blocks = int(exec_cmd(du_cmd).split()[0])
>>> -
>>> -        extra_blocks = part.get_extra_block_count(blocks)
>>> -        if extra_blocks < BOOTDD_EXTRA_SPACE:
>>> -            extra_blocks = BOOTDD_EXTRA_SPACE
>>> -        blocks += extra_blocks
>>> -        blocks = blocks + (16 - (blocks % 16))
>>> -
>>> -        msger.debug("Added %d extra blocks to %s to get to %d total blocks",
>>> -                    extra_blocks, part.mountpoint, blocks)
>>> -
>>> -        # dosfs image, created by mkdosfs
>>>          efi_part_image = "%s/%s.%s.img" % (cr_workdir, part.label, part.lineno)
>>> -
>>> -        dosfs_cmd = "mkdosfs -S 512 -n %s -C %s %d -i %s" % \
>>> -            (part.label.upper(), efi_part_image, blocks, part.fsuuid)
>>> -        exec_cmd(dosfs_cmd)
>>> -
>>> -        # mtools for buster have problems with resursive mcopy.
>>> -        # Therefore, create the target dir via mmd first.
>>> -        mmd_cmd = "mmd -i %s ::/EFI ::/EFI/BOOT" % (efi_part_image)
>>> -        exec_cmd(mmd_cmd, True)
>>> -        mcopy_cmd = "mcopy -v -i %s -s %s/EFI/BOOT/* ::/EFI/BOOT" % \
>>> -            (efi_part_image, part_rootfs_dir)
>>> -        exec_cmd(mcopy_cmd, True)
>>> -
>>> -        chmod_cmd = "chmod 644 %s" % efi_part_image
>>> -        exec_cmd(chmod_cmd)
>>> +        part.prepare_rootfs_msdos(efi_part_image, cr_workdir, oe_builddir,
>>> +                                  part_rootfs_dir, native_sysroot, None)
>>>  
>>>          du_cmd = "du -Lbks %s" % efi_part_image
>>>          efi_part_image_size = int(exec_cmd(du_cmd).split()[0])
>>
>> Thanks, applied.
>>
> 
> ...and taken out again - there seems to be some regression with the
> security image:
> 
> https://gitlab.com/cip-project/cip-core/isar-cip-core/-/jobs/6810329484
> 

Did I miss some follow-up for this patch? Or did this rather fall
through the cracks?

Jan

-- 
Siemens AG, Technology
Linux Expert Center


