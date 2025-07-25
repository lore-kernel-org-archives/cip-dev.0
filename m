Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D0D6C87FCA
	for <webhook@archiver.kernel.org>; Fri, 25 Jul 2025 06:58:53 +0000 (UTC)
Received: from MRWPR03CU001.outbound.protection.outlook.com (MRWPR03CU001.outbound.protection.outlook.com [40.107.130.3])
 by mx.groups.io with SMTP id smtpd.web10.13710.1753426731374789705
 for <cip-dev@lists.cip-project.org>;
 Thu, 24 Jul 2025 23:58:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=asUZMiYk;
 spf=pass (domain: siemens.com, ip: 40.107.130.3, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kE8VRQ8/oUnOMBjoitZrNBrNvYTfC8YQ/mGndw2hv7Br3QjTeBqdx3RBkHTGFM6ZV4yQWgK1uwH/ExQORaDqhPE5QjGvoGI5n+SWgDXRxZhQzBZzc8+7zeis49pa9sIVigpPGsRG1ydhTYcUPBxqEwoJUnm651r1vXmbPqJ8ZKmBRRzEYzl6buahI7zOPYupLdW0u0XNgRoZOv5446F2l29idy6lL4zOq60RL4iQI70LevnaiT6O+FUd0b/RHPklBf2vYi8Qc8jfnLDluQq6ATIgxxNfohipohm6nv9pPU5E3WMKiObh94NUAfWXIRUBsdw0/afKUY98ng/tog8MjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PSzvfJ0XLZNTcpxLjA2fUnu7Zmb/cGksKq+QZA0DV3E=;
 b=GdeqU3sXYg1FOWGhlB562aXEGg7BXDj34tQEjQ9ahjJy3trVazNuFBp4Z8qRk+vmhITdUTjM1k3t9/7t099hAKZqgCY/KnqCbyzY/+2X69xE3CbAg4kzhLEMtRvG7rKME/zaUeH8IPDQ0XKeTXyIUbgyyw/idv4uiWbApU97oINfWzuTo6u6+MpOvhiZtzPb1xoFzO5RsxQSUSmyKdo+BDrw9eGas0VoxvmHISo+ojLi3y7y0GBRklgkIzUiw6jJSi5m/CzhoZ8z3CQ7rjw4k6GurpGeeRgEzVVCA30x0Q+47verP5cZ2BlbOB/LTGqykQvmfHGdxf9Fj5vWdnsI8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PSzvfJ0XLZNTcpxLjA2fUnu7Zmb/cGksKq+QZA0DV3E=;
 b=asUZMiYku676iHdeKKSTPPdXSjqiEC2HtqNM8KsWu0JuNUIoFJImNFcZ7cp0wFOYv0QcWxsR+o7WiUmwemhnvYqZmWZcDP5e8vXRh0x722Oo9mcZr7NRw4COCIB+9Mb8aXPcLSMuju4EBi50ah0DuOwCZ9jaJcCg4OsUakIdK9YcwxzRLIKlo0y8Hzqcb94hYsbTkoigd0t4+B02vo7JLlyqY8WusedJxHgT6+p7t53rn/sySj4nRAV6mp3FbKSGnk8TPuKjrdqG1JnvWUfCpCMSXQV1YUO3Zphn2I5U266UQHADi3zq/3Q5zWRUEJnOjO2Z1XeGVtmw/0uyqZ89Fw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PA4PR10MB7939.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:26c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Fri, 25 Jul
 2025 06:58:45 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.8964.023; Fri, 25 Jul 2025
 06:58:45 +0000
Message-ID: <d413c4a4-f672-4005-92ac-bb991ede978e@siemens.com>
Date: Fri, 25 Jul 2025 08:58:43 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>,
 Quirin Gylstorff <quirin.gylstorff@siemens.com>
Subject: [isar-cip-core][PATCH] Switch bullseye-backports to snapshot.d.o
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0132.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9f::24) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PA4PR10MB7939:EE_
X-MS-Office365-Filtering-Correlation-Id: e371f2b6-160b-4876-9b82-08ddcb48b2ba
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|10070799003|366016|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?cFp4ZDBGYW1oeTNvWXl4VmlvK2xmdE1EalJZU1ZPRjBJSDN3T0N2SjNLd1Ft?=
 =?utf-8?B?R0I5WXk3MXlUT05EODhIZHdvQU9aa05hcHc2QVIxbWF2TVFJK3NtZFJxOGlj?=
 =?utf-8?B?aWpjYmoxb0ZrcDFsYnVKR2xucFhtdUJUVHdBNEF6eEYxZmMyb0U0WlplOUI5?=
 =?utf-8?B?R0lzQjYvdk5SajczSVgvYTVMK0lNSWRac0Z6Snc0OTNLT3N2bjZxSThPWW13?=
 =?utf-8?B?MkpPcE1jbUQ0dkpKS3d1a1BsRUNhYXZ5ckpPNU5TM0hRek1BL2lzbW85QTkz?=
 =?utf-8?B?WkE2cFo2cFAxMWU4K0MyUVExMklOYmhsUmxjR3FIQmtaUkUxem15MjZuRHdu?=
 =?utf-8?B?bFBCaElmVE1LTUFaSEh6L09aRWFvZzhzdHRORVZwcFlBMnNVZW1WbXFnLzBW?=
 =?utf-8?B?ZG1YeWJBY3Z1cThUaFl3L0tZN3o4K3B1UmM3V3crVW1nRk1vcDhTdTg5NWVp?=
 =?utf-8?B?WUsybWhOTDI0MWl2Zm9ZYmZnNXpoMTBkdlIxR05HS0lpSkloV1dTSkZTMXdK?=
 =?utf-8?B?aDg0WTJvWkl4eWRuWTZsYVhSZDhsdW5mS010OFo2bk5tZHM1c0JPeSt5THph?=
 =?utf-8?B?ZnNYVk5hMVU5OXh1d1R0K3BPNDRyaThoWVJFelJHYW1OajIzU0UvZi81MFg4?=
 =?utf-8?B?eW9CakJKSE1ZSklncXdGUUxaUHJhREQ3Rk0rYTQ3bUpuaFhwbWU2c2VwWS8y?=
 =?utf-8?B?ZW9FNitKeENlZW9Cc09yd2E3Z0RMWCtqRHExZHhnV0tTSVQrOFFoWWtjb3NU?=
 =?utf-8?B?dnhpekJRaS81Q0U2UmN2MW1nK0s4c3h3K3R4L2phYlMzWk93Rmo5cjNOYVY2?=
 =?utf-8?B?RDQ4dFpxUDhDVXY1ZytOcjRQVStWN1FLM3pSeE5FcWVkLzFjeUNnelRmditF?=
 =?utf-8?B?TzFDRVRESE1CaWVQc1oxVVAvWmI0WFhzM2haaHl3dGdvQTVxUUJPYkZ0dGgz?=
 =?utf-8?B?RVNpWjJkbXQ3MzJ0TzZNRVlYNVZKUWxCVFNlL0xhVUNRSXlDWkQ3RnRQb0ZX?=
 =?utf-8?B?Y21HOThsNUhQd1FPQmFNY2V5aDRkOUFWUEpmZ2RUMDVTNTlZUlEyczkwZWdq?=
 =?utf-8?B?aXZvRk1BUkprL0c3d3NLTmM3U1prUVJWNUJqYzJXWTFTcmIxL0lkclM4MGI3?=
 =?utf-8?B?TWVjNDZnL2Foc09GTGplNDR5NC81cXZIYjM4NEV0ajJESkFNUUdqM2QreFBu?=
 =?utf-8?B?RkwzV3p1RjVocEIyZFQ5aW53Ty9vTUw3eGxyMWZPdnF3czRxWXNmQ2RxUDhx?=
 =?utf-8?B?VEVqV2N4bXFNbUlpOXNZQVB4b1RBUFd5VDRqMHZJZXAyd0IrUTJyN09TVmVH?=
 =?utf-8?B?M1A1TXYxdzhkVWRkS2ZwM1VrWnNON0FvR2NOQkpYS1hxUkxObS9aOFp2S3BC?=
 =?utf-8?B?dTd3SVA5SGEwN21GOWFCaGc5amRUTUFOTVovSTdWWUZLT2o4dlF6QnduSVV3?=
 =?utf-8?B?WFM2cVZ3djA1KyswWDFTWCtaVE5IbTgyUnpueUI4Mmx1MU5VMnRXZUFFMzY0?=
 =?utf-8?B?YTlNWHRXN05PeGdHVnZkZmxoSEpFQkJSc1crWExOcWx3RWUwS0kzWElBRE56?=
 =?utf-8?B?REpZVmZxdWxPendCZHVranVOWVY2eVlheDNUTUZCc1NjSzFvYngvKzBFY01K?=
 =?utf-8?B?Z0hnSEFsbTYyUXViSGtWQkg0QVJOVFBuV2xWWFgydnM2bjdISEp4ckFoUGJX?=
 =?utf-8?B?V1p0bHpHY0dYUG9jS0doYlNXaFhyN0NLMDJ3d3lhSDBEYWNpNGN5R2RZZnNU?=
 =?utf-8?B?UllUdm5Bd0JOb2lkeWttVStadEN0eWQyUHFuUGVLdGxud0RwVlRrV1dwTlFy?=
 =?utf-8?Q?JmoPTdp/aiQcR7Mil1eo9ye/1b3afPPOoKyBU=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?TUgyT0VYb1hHVHVBQ1pyNkcyeks5R01mQXlyaFRTY3hPQ1Q1U2I4NGdGNnlw?=
 =?utf-8?B?djVGWE1NTkl2WnZDRFNZVkdQVGxMNklWVEQ4TW1GSEREQXpwTlhmK25lNWw0?=
 =?utf-8?B?QW55c1ZXeDYxOG55dTRQSmptY3NHTFI2UFVMOUhUWngvOFVoeHIyUmJRT2Vz?=
 =?utf-8?B?RG9UU0ZhVUlBRVljb0ZZZ3R6V3hrR0hSVkN3SFowYldvOFE4NW9uMGZBMXpW?=
 =?utf-8?B?WVVUYSt5RFp5ZkFOVTZrUzAzR3o5bEFsUmhzdkZ1TnJrS0VhR0g2b3VZbjgr?=
 =?utf-8?B?Q0FWQXhxNWF3ZTNJMU5nRDMyN2R3bVdXMEl3U2V4S3BlL3lGejk1Nm5DcXdy?=
 =?utf-8?B?SXIzT04xaUVHSy9jYUM3WDFyUjREaXYybXhsNEwvd1lqdm4rSWZrcjhNQkRD?=
 =?utf-8?B?SjZpOWNvN1NubVNNejRjNGZtc1A4VTZ6SUJFTnZqODgrRmpQMWczaTZuQVJG?=
 =?utf-8?B?Tk5aWCsxMmxVbmN0TERsTU1rRld1MHFzWGgyOU1FcGlYR25aUFJNb0ZEVi9H?=
 =?utf-8?B?eXVRb2tZMnEzdjMyQUJkMEdYUytnZzcvVUc5VWNXbzl0bkRJR1hkR25QTnVj?=
 =?utf-8?B?bWIxVktFczJWSDBteXNFaGZZWkVFaDlMYVp5ZXVTZW16ekxpc2YwejEwek5x?=
 =?utf-8?B?Q3dNUDBKUG1kOGd3bmRka3piUnBIcmhPaUdhbGV4L3F2eE4rakxLWnRxWDNH?=
 =?utf-8?B?SkkwdVdQUVJmSmErVW12d2wyaEcwZVZacTFJVXNzdHFqUFJtaG4rUTgxbC9I?=
 =?utf-8?B?Q2FUcCtOS0trdWFGN1o2M0VWVW5DNGo0Wi8rbUNWVmdnaTFaT3BKYjM4dGR6?=
 =?utf-8?B?STFUdHQ4U2t2WkdxY0dhclR2NXZDRUFtNTRQNnR4bWRVVmFSZHVVNkVFM25C?=
 =?utf-8?B?cThuZjh3S2dpeHRFRzcvSVJUMXY0cVpCd1FQU0Z5ZENiMUhNY2d1bnNXR21n?=
 =?utf-8?B?bUw2OEduT2t3RXlULzFrcjlsL01QVUREMmx0RlVzUTNwUXlxWU5Bb0VQdjcv?=
 =?utf-8?B?cGFkemlBSFhjdzlRY0oxYVZJTWpHa2xQS2hCY0VaNFBueHA5clBvMVViK1pZ?=
 =?utf-8?B?RCtnZEVwUG10WXRKZ0lVRW11RHNZVjBGR0VnUnd0ZmZoR3MyQUpnekJ5YjN4?=
 =?utf-8?B?T0xSaEpadlpnV1FzNkcza3VxVVRsV01PMDZaWHh5Y05mS2JHeFVOa0k3NEc4?=
 =?utf-8?B?Mm9PV29WeWhPYkU2eVZPSnh6T3VmVlkybXZvMTVQOURGY1psY2Z6SG5WdWFN?=
 =?utf-8?B?OEowZ201SU9zZTR0NzN4bHBkVzNjRDFZbGRGUjBRcWNzSndINENnUDc5UDdS?=
 =?utf-8?B?NVErQ3VzWEZIQmQ5ZzNvK1I5dERBdFV6VXJCb00rUkIyeUxNdmc5TUt5WVdU?=
 =?utf-8?B?OFR1Q3UvRjUrMm5uUmJ1L09WTy9vZnlSYWJFU3BEZVh4NUJsVy9jV3pieWVB?=
 =?utf-8?B?ZE9iQ3dDOXZSRVBidHJwUlVBRGp3MkVuOFNuK2dkbkU4MkEreU9CTkNxZHBS?=
 =?utf-8?B?RVQ4M3VPUytwTlhYRnoxSDI2RzdwWVpXM3RyOG4xRlhEdFFRby80NTFvRVJV?=
 =?utf-8?B?MXpjdTRHVG5tbUo5MzJIbWVMeDN5TDgvQTMvTEVkVVBQdkZXbFA5Ymt5VnR2?=
 =?utf-8?B?QVRDVkhQQ0UxWERSY3RXdFE5a2xZb2Juc0FSOVhiTUZlUVhJSTBLZXBUcGRv?=
 =?utf-8?B?WFlzcVU0MURYZXBrNjkzejVaZmVmWlI4RG9rUHBiUFEwYjhIMjFUM3d0ZHFV?=
 =?utf-8?B?QXpmM3ZRZXphSmJLVVJERTRWTERkSnc2UGd4QVBNZHBFUjNRUWEzUkhUSk1x?=
 =?utf-8?B?SUF1QlZubDFPUTRINjlwcnV4cEZSbHJVT1dpaVhBbm9seTVSTmZYblVvL2gv?=
 =?utf-8?B?NWw4K1VLTGQ4ZnQ2dHhFM0hLeHI0OWxEeXg0cHdPb1pHeGxhT1lBckJGYkgz?=
 =?utf-8?B?eFVJcGFSZUNTOGRqVzNYaCtRQlQrZTJpQzd3Z0xhcDF3d3p2UllTQ0NnbVU4?=
 =?utf-8?B?a25rUDVEbUJCampvZ2pMb2RUazVjU1BsSm5Vd3M0aXcrWTFZOFlEci9rTTFw?=
 =?utf-8?B?aEVtdjNrNzZjYjhyTjZsVDBzZXgzSlB0Vlk5ZzJ6MHZWa08vVi9Ta0tZeElj?=
 =?utf-8?B?b0x0ZE50VHVSb1J6cXdQUzhzQWVxQ2RFQjZjbnQwQnNpWmFTZitmUmIvRUht?=
 =?utf-8?Q?+YMNh35F2ZlcTniWvR6z7zPs9WwD2VN+Gi0aVwFL6Dis?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e371f2b6-160b-4876-9b82-08ddcb48b2ba
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2025 06:58:45.6505
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vi53h7DtBB0ziqeAK5hNpZSQiaBXdv8bnoJHVU35Yx8NmBa+YXWOlin7fqyU7KAW6ipovVydRIinHVosKr3/Ig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR10MB7939
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 25 Jul 2025 06:58:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19590

From: Jan Kiszka <jan.kiszka@siemens.com>

This unbreaks the build but does not address the maintenance question
for the used packages yet (dh-nodejs, libwolfssl-dev, libwolfssl35).

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

Seems the longer this release takes, the more of such fallouts surface...

 conf/distro/debian-bullseye-backports.list | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/conf/distro/debian-bullseye-backports.list b/conf/distro/debian-bullseye-backports.list
index f1461ab8..45b049f0 100644
--- a/conf/distro/debian-bullseye-backports.list
+++ b/conf/distro/debian-bullseye-backports.list
@@ -1 +1 @@
-deb http://deb.debian.org/debian bullseye-backports main contrib non-free
+deb [check-valid-until=no trusted=yes] https://snapshot.debian.org/archive/debian/20250721T000000Z bullseye-backports main contrib non-free
-- 
2.43.0

