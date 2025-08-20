Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58D67CA0EFC
	for <webhook@archiver.kernel.org>; Wed, 20 Aug 2025 08:40:20 +0000 (UTC)
Received: from DU2PR03CU002.outbound.protection.outlook.com (DU2PR03CU002.outbound.protection.outlook.com [52.101.65.20])
 by mx.groups.io with SMTP id smtpd.web10.15264.1755679214829835843
 for <cip-dev@lists.cip-project.org>;
 Wed, 20 Aug 2025 01:40:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=TFXQTqaj;
 spf=pass (domain: siemens.com, ip: 52.101.65.20, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i+vjTw3Xqz7GuGL0ihRkkto7komaMeLZFg80gL8VeBjzCMu6TcsalrngYDcbgaCdRvj5BEPE1BWyfT2tH4qi27NbctwNVBM/AHo4ezIrVWl70JGjtNrlcKyxTITTCHNOl0YqNYpoTh2FiY47gIOpvYNS4Lq0F81DyhjfHUF6j/vMI88HTFC6CFjBO7yz2rTAA2eR6Qh02WK2lG2iMVAz+c7lcf15YHoKRugWbZBBLxrxR6ZrkZhTXUDzNj0cC/4HGSiW9h1gE4N9KGjOg3S6c2wi62x72fLJU8ZZ7x0OyLfD86gGI6/JfNP2cBB4vp7NCmP01o6/vUllJRoIgj8OfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=waxg4jI9aG8fmJje0beGK0qGO7w5ESzM5WwokKwobdU=;
 b=t2y/mf6Dt/dVpRQJzwOScX4YfHCqznMNY6AgSxm81+m+DLzqoE7n3pePe/hB+2GRdNHYcQ+qbO8PJ8RgfAUIgZhMN0bdiHSljmanP73wLJUu/uNs9dIzmtmzT2PUJPSntQiyi+UYj5AQ1Dc4NMt3KrOaN6c/GCIZwR2r4kOj03svCtXYH7o0UC0OsYt0/wEkH+AJgbwQ5/IjCmklLVX79xd+BiiNMBR/lbrWZE1uvU5bdYl3WfuEV41J9En8I5uTEKRom5Lx0vKpSfC0BULY4kGIOl0eilq+XMVVSCDJuvE926iydYVgHCReoJIW6+Lx7FXDs6paBaViE6JhbaZSSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=waxg4jI9aG8fmJje0beGK0qGO7w5ESzM5WwokKwobdU=;
 b=TFXQTqajIaoHAgiNHN+akAEUelDJJlYa4JJKoi3dLwR9WJrQNYexWESihFyoYxH9gJ34UBcXkg0vme4+VSltQ8iXIiL8oH7Ogulr8DdwrPzPHqmgDRznwYBH4Rgmk1XNNyQCuK8vYaSJDQyA/DjVLFpJbQceLWNP5Qev/exyoSRcx62mPltN67uTsCkYnZLAkLvVMW3pQ6LO2a7feUp6bNvfuHWH/prXcs7VG04SVpBVdLTm5k678+wpCSFZblKZ1EjeeogxmfoMVqZk3iT0dL54kXuTUAZhxDn6uDePBTqP51ilQowbZXvOsDK0FAm218uOem9Ta0+XetTeUkF1gQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI1PR10MB8110.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:1d7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Wed, 20 Aug
 2025 08:40:09 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.9031.024; Wed, 20 Aug 2025
 08:40:09 +0000
Message-ID: <c476425b-db4c-4815-8b2c-4861e6bac925@siemens.com>
Date: Wed, 20 Aug 2025 10:40:08 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH] opensbi-qemu-riscv64: Update to 1.7
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0344.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ea::7) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI1PR10MB8110:EE_
X-MS-Office365-Filtering-Correlation-Id: c030dbe2-b99d-4ecc-15bb-08dddfc52bb5
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?dFZWaHI2SzV6ZG96Z2Y4Yy9NZUsrQ3VaQ2owMTdqUlJmRC8zclZrUXljZGZt?=
 =?utf-8?B?SFFkRjNOSm5LVWQvYlZ3R3cwejhOaFk0VnZEeXVxa1VYc0J5QVh6MlBJNUZk?=
 =?utf-8?B?Q2ZsOERrbmdKb0RNN2tDVm14SEMyWGV0TVpuQVA3bWh4K0IrbzAxdThsNEJa?=
 =?utf-8?B?YitrRUxtV251Z3ZzbkdxRy9JMzFyanJvaWpZSVVPWE1zVG1sY3FPbFFiUmow?=
 =?utf-8?B?Z0lTRm8rSG0yZ09wUTJGalB2dVdjYm15c0dNUXdraDNvZzg1OEpSREFYTjhR?=
 =?utf-8?B?N050eTNmakk1dFR3Y3Vyay9jQlNUbW1uZFhiWDRtSTI4Z3RqNUJqalVyOHVo?=
 =?utf-8?B?ZmNhZHF5bXdYVmFJVXJEVjBNSEJMbFdGSk5HUGVlOGpwS1pOSnFBU3RqMWZu?=
 =?utf-8?B?RXdzVUJFYUhGd3pWZ01zSDRvbkNKUXlIWGZQd3V6VDhtYnNJYkxWWnphcDhy?=
 =?utf-8?B?VlhoUldLeXo3RFhlWEp3ZkNTek1tSlFFREJQWGNRd1NTUzEzY2J6VW5KMXNB?=
 =?utf-8?B?bUNBL0RMbmpPSGVTSTB1SFZVQlJ6bUZvS3lTa0tZSCtHbWFmYTkxMzhxcGdh?=
 =?utf-8?B?S0lrbmdQekd4OE5FUlZvT3ErTEZvem1sV3lyRnBlS0Y3ei9jRndvY3l1bFhY?=
 =?utf-8?B?bHcvVHpmM05uczFIZms5dnVVaDhiWXRjNDhrOTBYMXlkOUFjUGQzaUplbWEz?=
 =?utf-8?B?N3V4emhFcG9FaWJNcXJjdUVKdldKN3JHZFJQZUpWV2dDcHk0eXk0aDIxVEJj?=
 =?utf-8?B?QjV6QnVvKzE4SFFxR2t5dXdDcjRWOFBUTjFDNUVlbGFNZGJnWC9HLzZFdHNN?=
 =?utf-8?B?WVg0SHJsc0tXNjh5RWQvci9WcVdxRlpQNjkweWhwZXU4WXAzU1NJM0M5UkJz?=
 =?utf-8?B?Z1ErM3FwcmxLdHVWRUFxNXd1SlNBNkpmWHZCa28yYWtEUEZLZFJodXBXZGNO?=
 =?utf-8?B?NnNKZ3FCMTBDb0Q0R0Z2djV4Y2ZIc3JZN3ZUK3FVWVdWT2ZPZUNBVnRqTmVn?=
 =?utf-8?B?bll0ZW5NS1FYRzhaRDllVGN0NDM1V3M0Q3oycWNod1Vzcjk2T0Z3OVZhc1VV?=
 =?utf-8?B?ajZkYzVlQTNRK2ZsNGxwZHhGSTR1RXc4TkFQU0VHZldlK0JlekllOWVJbytI?=
 =?utf-8?B?akUxeXBhbGlKclZ5VHdNbElOMk9pQ0NqcWwxa05Oc1RLZDlKYnhlM3NBbGZB?=
 =?utf-8?B?YlJ3a2U2OVFQWWJKV2hxUCt2V09hUmxVVWVtbHhNb3RSRWpRVFZvQ04wQzAx?=
 =?utf-8?B?a0Q0ZHBZM1FQL1RvWlNZZUpRYTQ5elFmdnBub2xCZEx6TUx5MFUvanhHQktu?=
 =?utf-8?B?RVZOMFZmSzJZbEtnUGpqbW9mQW9wa3JxTzBUU0VsRmJhMTZwcXp5YmJkM25v?=
 =?utf-8?B?ZUtHMkpkbTJsb1VhKzg1V0crTENRcTRSbGFNa0FPRUIya3p0aWd0c3c0K3o1?=
 =?utf-8?B?cXdsaWJQd0drVFdqY3FuRk51MHF1bUFGaVFYMzhzMlo0NHgwdk1pcEk1TTdW?=
 =?utf-8?B?ZXMzTFkva2NyblBzS0ZEV0FZSW9POWZ1ekFuK294Zlk3dTFvK0oxWUpBcnRv?=
 =?utf-8?B?N1k0U3JubUtFVmc0TkNmUHNYWldZTG80djhQNnFycG1ydjlBTys4OWxhWEpX?=
 =?utf-8?B?bmc1dmM2dXlVbkpkdGIxZW1ROUVSbDJhWjdhK3hyTlNldi9xWnFBTVdBbFRq?=
 =?utf-8?B?OFcyMnpCVXZnaHdhL1dqbWx1a1BkNGl1VUNOVFQ0VzJHNkxTVWJNck1pTnBF?=
 =?utf-8?B?d0ZlQ2JIam44Z1p0cGduVWMxaVE3VTFlYlBseUNCdWVOZjZTTkdMb3pWNERI?=
 =?utf-8?B?N2NaQ0s1RXNlcGdsODZIS0JoazBFdTBtWlo4ZkpjeW81ek4zR1JFQkdhT0E2?=
 =?utf-8?B?Y1pUNmtWbHFySU9uYzRmSEdEWFNqZlJGQWkzZGJrZFNPa0xlZk1KbVBBeXFZ?=
 =?utf-8?Q?dYG7l7bbiSM=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?UWVxMjZNMldQSzlXc3R1YUtVc2taQVlrSEJIdWJmbVpwWXRpRzB2TFpxMjJl?=
 =?utf-8?B?UXowMTNxY21lcVBJUU5hMFFpekNqOStkR20wS0RJUnBMc2FsOFJDc2tZNm5N?=
 =?utf-8?B?NVgzVks5c0lHL0Q5Q095QzZWeEVweDY1VjdhRmRrcG0yamVhS0lxSFgyUEVy?=
 =?utf-8?B?cHdRUHZUSmJlNDJRTkxOckkycW45bHNmdkc3aVMxa3NEV043aXFaUDJGaVI1?=
 =?utf-8?B?MWtZcGxhNjlvYlJIQ1lPaDZmY3AvVzJVTG0ydS9SM2xXdVY3U3ZUaTNRZ2lI?=
 =?utf-8?B?MitqR0RKbkpYYUVLQXErcjlONFFPSEt6dkc1bnpGc1BnSlpjc0U3ZVRDWHBD?=
 =?utf-8?B?RHZrR1JGSnRKaDUwYVdab3drYnA5UC9vVEs3SUJxOFpiUld3bEQvM09VWlpU?=
 =?utf-8?B?WUVSdUFkL0RKaEVXbTV2WldTZFRaL0YyNUtvQlZBamxvcERNVXh2S01KcFRp?=
 =?utf-8?B?RkdabFkwdjJzZTVtaXVDWStZMXZRV1RvbWg5bS9qOXgwU3laemQ4eGs3MCsz?=
 =?utf-8?B?eW42ejlDNThkcnBVUW5BM0k1Sk5vaHFVTm1wdldoamRFdnJKRllFVTl6Mm9n?=
 =?utf-8?B?SUdITktaREFzMDJhVSs0SGpGMXY3NVNoRDNhVXg1cUdIaERabTcwVFBPSERi?=
 =?utf-8?B?UmkzSEtLNHBISXNPcWpzd0VuMlJ1YlU0VlBSMmNXbVgxMHZzSE9pWHpEeEdS?=
 =?utf-8?B?Y21WU1k5V3JBcVRGWURkZldhR081bFdZSEx1Y280VVd0cmVuUldlV0V1R1M4?=
 =?utf-8?B?amQxazBWeEVvWHVGUWh1dUtVY0FvSndTSmFRZXFZTlN0TytZK1pOaTJvbHUz?=
 =?utf-8?B?NGN6dTQvVk1BbSs1TXAvbXBTN1FyajhUMGk2KzRZREpST3lvQ2dKUDAzakhI?=
 =?utf-8?B?b1pwcmNUd2thOUh5d3FVK3RGTzE3YWpaWStESVNJelljajlTTzRPelVGTmNz?=
 =?utf-8?B?WkNvVFp1bW05Rzg5VTRWNFE3dGRYNFhOa0t6SmErcFVZRVQraUJCVE1teUNV?=
 =?utf-8?B?Y0hlanoxN3ZTUjVyaDhib1lDQkF4TkZHeFp1YmNEUk1UNmFPSlNSZGR4QVpm?=
 =?utf-8?B?cVAvc2pMb2szMURIT3pvc0hJeXpCdE5Zc2szbjQwRnN3Q1ljSE9uYmhDSXJy?=
 =?utf-8?B?cXA2NDVkZUpNek9JZ0xtT1Rsb3UyRFNmNnBvd3VwUHJoWi81U2FOYUpQOWRk?=
 =?utf-8?B?T3J5dHFLaVMxc1VZODdFT24rNGZ1cGEvTmU0dWgzNWUvRkx3T0w1SjFnK2tQ?=
 =?utf-8?B?WWNHZVF2WkhvVnpZZlFxa3g1UHVQYUhUUEx0R29CYk1DRnVsRUc1RWE0WG5s?=
 =?utf-8?B?dWlURElzZ3NCY3pJd1Q1S0RDYXFWQTU2dmJSTXJOSUxXbUZPdks3aGhUakVX?=
 =?utf-8?B?RWZBTVlialE3dWxHb0x2SURlWGs1NmtVMXZjMElHQ1NhUjJEeUM3dWovcWpK?=
 =?utf-8?B?WjJGOG54WmdMQXlQdjRYSVJIS1Bab0ZZN1dKTUpZODYrTUo5WEllb1hQT2NK?=
 =?utf-8?B?SGsrL3EwTVI5MVQ4VVhPWXJ1ZHlKSzZVcmM0TFczY21DeGh3cy9vZWRhekxR?=
 =?utf-8?B?SHFZajBpdWRYRzB6eTQ5S3ZvRWx4bDhaOFkzMm1LSURyMktqRzdYczZ3NUJ5?=
 =?utf-8?B?TDA3WHNhOXNQV052VmJ6Nk52RVc4WGxXL1hmWDdyelY3WlRDNWhhOGp6RlRt?=
 =?utf-8?B?SjFMYXR5bk4zVHd6emVTdnBhWXl6ZG1RZkxiOVF5NTNpRjlxaStmL2dKbzl3?=
 =?utf-8?B?aTYvbnZrYXBNSVYvbEo2dTIxT2JTZjR3eTZjYXMvcUZGb0JGOFZHWG1yMlpQ?=
 =?utf-8?B?UXJOdmlqTVBaZzhOZitsSG16emNHR3Y5ZUthMURnVFh0V29nbTJpUlJGa0Jv?=
 =?utf-8?B?eXczUmZXcmsvWlBQYjVBcGVIcDlRL2xIV1FWVjArUW5IVHJDWDM2a1Y3a2Zv?=
 =?utf-8?B?ZTJnbHhsdFJwc3d5U2RiUWthbU13eS84cFZ6QngybnZuNlNKVllOKzZ1UGg0?=
 =?utf-8?B?ejlTd1ZlQjJQMFpOTjd6SHNlQlZUaTZ5cGJHNW1MYmNucnF3VEd1ME1HSmFa?=
 =?utf-8?B?Wk16OVZJU2VEbksrSWdVTDdabUc1QS90a1N6WXFTTS9lZHIxTU0vdzlVUmV4?=
 =?utf-8?B?TG4yWGVSQWdhOVFiSHp1L1hNMGpRM1dQc0hhM2ZnbmxjQktuMm50RHBwVTlY?=
 =?utf-8?B?YkE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c030dbe2-b99d-4ecc-15bb-08dddfc52bb5
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 08:40:09.2742
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4zBOJk/ha5Q1yhA6ttEIAABBbdvebKipumZ4qVYmXa/zMcWuOezT9oSQ+nx/FgWDFy1svzI7QodV1DNT+lOklg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB8110
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 20 Aug 2025 08:40:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19793

From: Jan Kiszka <jan.kiszka@siemens.com>

Housekeeping.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 recipes-bsp/opensbi/opensbi-qemu-riscv64_1.2.bb | 10 ----------
 recipes-bsp/opensbi/opensbi-qemu-riscv64_1.7.bb | 10 ++++++++++
 2 files changed, 10 insertions(+), 10 deletions(-)
 delete mode 100644 recipes-bsp/opensbi/opensbi-qemu-riscv64_1.2.bb
 create mode 100644 recipes-bsp/opensbi/opensbi-qemu-riscv64_1.7.bb

diff --git a/recipes-bsp/opensbi/opensbi-qemu-riscv64_1.2.bb b/recipes-bsp/opensbi/opensbi-qemu-riscv64_1.2.bb
deleted file mode 100644
index 007fa673..00000000
--- a/recipes-bsp/opensbi/opensbi-qemu-riscv64_1.2.bb
+++ /dev/null
@@ -1,10 +0,0 @@
-#
-# Copyright (c) Siemens AG, 2023
-#
-# SPDX-License-Identifier: MIT
-
-include opensbi.inc
-
-SRC_URI += "file://qemu-riscv64-rules"
-
-SRC_URI[opensbi.sha256sum] = "8fcbce598a73acc2c7f7d5607d46b9d5107d3ecbede8f68f42631dcfc25ef2b2"
diff --git a/recipes-bsp/opensbi/opensbi-qemu-riscv64_1.7.bb b/recipes-bsp/opensbi/opensbi-qemu-riscv64_1.7.bb
new file mode 100644
index 00000000..260d1390
--- /dev/null
+++ b/recipes-bsp/opensbi/opensbi-qemu-riscv64_1.7.bb
@@ -0,0 +1,10 @@
+#
+# Copyright (c) Siemens AG, 2023-2025
+#
+# SPDX-License-Identifier: MIT
+
+include opensbi.inc
+
+SRC_URI += "file://qemu-riscv64-rules"
+
+SRC_URI[opensbi.sha256sum] = "2cf856a4e5e2e052948ddb54ba48232b1f698b7f52e0374fc7d17d51e8c8f7ce"
-- 
2.43.0

