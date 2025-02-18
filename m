Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4A84C02198
	for <webhook@archiver.kernel.org>; Tue, 18 Feb 2025 10:54:50 +0000 (UTC)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (EUR02-AM0-obe.outbound.protection.outlook.com [40.107.247.62])
 by mx.groups.io with SMTP id smtpd.web11.16736.1739876084920218794
 for <cip-dev@lists.cip-project.org>;
 Tue, 18 Feb 2025 02:54:45 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=ZaqnsL7f;
 spf=pass (domain: siemens.com, ip: 40.107.247.62, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WWyTxQ9U/n0skrWnKFs06Msm0EqOeOSJFguS9UVYEcNpouOHeSteYgTHe85bOW0G0heHttryW70FKgg+KbeOXOr6FdoK2tcmwHOk6C38hz46eM9KCi3/sIa2uknFAoH7FvUP3xbQMGOW+QIK6y0eOokzp9wJCxak0k0qoho72VwPgsfMmC07enkeTtIn/kKjiMOOWZ0PKnL3pAWwm62i0c7vv0DSKzZKqbMTPOYz6dfkavaxIThECfozoG19h8uX5Xjigusfbwg84HlOlm19Xqkfpb+r9rkj/3yR83YdBGVlDIrjUtVy0Dpu27QYoe9VGGtr+XuBVNIA9v6yaOV7cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u12gE84P6QBmfwSDd20CEGI0UpM5FOBkxFd1jyiJiDM=;
 b=II48oZ9AZrxEVRsnt/vms1JTIuj/QSmMy9ey+3uDAZy7kh6Phg15ilYf5d4wlNIjWH4z/rhTcInbPPtVK/1rD0cgBzNYGTWvGSDEBP6n6nCAoOUzcgQhb0yQaDgAaCQxRszLDY8ioz6JnHEfkDUYQBjeV/LCwOsgIqBEFNpvfyyqA9ixMzT07Jf+OsSi/RjxQt4GK4T3sTOKBR2gpXQaCNPBUKb8ooaAYYpSLAkx5+jJ52m7RcqtKXrW4jq05qHLdkIv17QD2ovMvNiS77sbptoPWUFQJ/R1kHwC89M9QhsOZMDU/y30Gw9yajIllxLDt7QTTqpyJ7nVhHvk/M9t3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u12gE84P6QBmfwSDd20CEGI0UpM5FOBkxFd1jyiJiDM=;
 b=ZaqnsL7fdNlU/nUh6H+VXGIFnUYJcvB0TfIALwcBmlDCqIMzVKguXJjnJH0LT/X5BzypyetnLfA66VHyWY9XkGo16OXfgxuwp3EKeedUXdXIrTc64dLo9LxbKvggEzztQQSjHtfExxSqAyuDQYuQu84ZZJp5GVCOfQUdrMc+rW3nZ7VlCRcwa2ZrI5x6zXqbUeDwpmC48a5NFxdx8cVYHygOR4MPFvuvqqVakCh4OIdBp63K+UR7txVsoISPRA+u9S0/dYIE/z3+0qR04o9GtgcyVJF5VYmuEb1OZK3bXUZRBGLUcA+Ncqz8PchDrdfCM9bSYHWeVySkgOLBKvpE8Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI1PR10MB3551.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:13f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Tue, 18 Feb
 2025 10:54:41 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8466.009; Tue, 18 Feb 2025
 10:54:41 +0000
Message-ID: <401f9f4a-fb2d-4f93-aa32-ff3c7c8636cc@siemens.com>
Date: Tue, 18 Feb 2025 11:54:40 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH v3] Update isar revision
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0134.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:97::18) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI1PR10MB3551:EE_
X-MS-Office365-Filtering-Correlation-Id: 449606c6-105b-467b-3c74-08dd500aa5ac
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?ck40b0h1Z1UweHorRG5yU3JvRFRCVlVKSTdZNVZXWGI4OUFETWg4V0cwdlpa?=
 =?utf-8?B?dk5scElEQ3hsSkEyRUZUbWJrclJhV2Q4ZXBEVm8wcm5sQ202T29yOC9FeG5r?=
 =?utf-8?B?dHRwTnloS2JYcGh5Q3VMVFIwOVdlLzlBcjFtc0Z5YXpHaVM2U2RRNDhsRVo5?=
 =?utf-8?B?TWdFcko4MFRUdVZvbC96QVpIU0l0T1JEa3RXdys2ZXFZaDhoY1JmWTE1OVJr?=
 =?utf-8?B?TnNoUjcyMVBYZjBOM2hXcGJodUJ6SjhsRzEwZ3QvQ3hsdkJzNVJsaU9IZUdv?=
 =?utf-8?B?c2twdVpEREFpbWcvQ0d5cUdXY3lHMlY3Y3Y5a3M0Y0hHVnp2dlRZUEJ3cnpS?=
 =?utf-8?B?eFR5NFZyMncweEw3ZFI1OUxmWE42YkpQQm4yRkR6S0YzOFNpR0NOTHBGdFQ4?=
 =?utf-8?B?YnFiUWRKd1hicXNnTEJxeVBIekRMdnJTR1V6WHRMTjZuWCs0TFdnbklxamQ2?=
 =?utf-8?B?UFVaL3M2NzJLeXBLTmMwRGZETm5JMlBlb1VtRkl6cGEvdDBtR1BvUkJTeWpo?=
 =?utf-8?B?VzVUd0I4bUNFWW9hckw2YURnRlIxK3RLVU1ZS3d0Wk1BK3F6YytVQzNGUm1k?=
 =?utf-8?B?ZFBhUnF3U21ITzJjS2pkSmRYbGlYbUJqT2hSZ1lsM1FGalN2eG5yTWxvNXlW?=
 =?utf-8?B?THRkb2xjT091b0Nla240aHFyMGcrNGZGaU1hQWJTYWhPb2hLQkZHWGpVNGpN?=
 =?utf-8?B?RlF3SlBiVEZwbVBkZ0s5cC9WZUt1dGpoaEVVVmNURnFoQUhKTDBRMlBFRUdD?=
 =?utf-8?B?UW1YMm42V0k3TGt0eHFjNVI4ZU8wNjlVWXFEcGdsRmZSTlRRQ1JrMW9ab2pu?=
 =?utf-8?B?RDB6VHJ4ZEZHekkrMUlkUmM5dk9USkU2SjY3c0pyVmRydFNzZFlQRUorb1VW?=
 =?utf-8?B?RHN4eUNKOHNjT0tYdWc1RloxeDVXVTd1cU5SS0EzdUJlcmx5a3lwWUQralRP?=
 =?utf-8?B?cnBqZFZqTVEzdHBBSXNoWWhOUENiL1EwKzZManZMV0R6NDhFZnJUcFRkTXFZ?=
 =?utf-8?B?N2w2WXJ0T3ZPZzRWRDhTVG0zZks4bWNGS2g0dkFSK2V0cWxlTXVIdThmZVcx?=
 =?utf-8?B?RkN3V01UOUpQVjJQU0JqOXZNa2RsVFcxQ21ueFdFTmtNTHIvZHRNc2NSSUhj?=
 =?utf-8?B?a0s2a29ja3V0bGdKNVlRRVJPLzRHMEFjUkxYY1NXcEYyN0hjSzVTRHdCVjFP?=
 =?utf-8?B?V2RzT3AyVUVXQk1KcGZNWFFPeW1sQXJEQlVaczFoWEdVVkEycXMyQlBMLzVY?=
 =?utf-8?B?VFhJRlNKUUx1SmRzOUZDRnhFRENjL0RWQmh5YzRWK0NXM2RXaHhsRzVpcno0?=
 =?utf-8?B?aXZ0MmwyR3hScyt1aDEzUFZaODNDMUxndDFFMlo1bDNXdlJ2bmMvK2RLRmxO?=
 =?utf-8?B?Zit2NmZUREFqZVBLUnpMZmJmR04ybDY3WG0zRlVjcnkxYkJOQzZNVUt6SXpI?=
 =?utf-8?B?aDdXakgwdEIyWjlaOFNmbEh4eHBBYitlYng5UnJzeFVzS0lzTVBNQW5FWnd4?=
 =?utf-8?B?ZVY2OUZ0WDVzNDQybHVueEdLQ3phQS94d3JXZkNuY1Q2S092OWFkeEVSNDZy?=
 =?utf-8?B?Nzd4MDM4M29xenVRek1rTVRyLy90OVVuWG9keXNEQ2tUbDhYMjZkUnpUOFdW?=
 =?utf-8?B?RnYySlJuQTRnNUIyOVFzaW5ybnowdFFRRCtMS29zRmZFdDlhSzJod1VJWkJl?=
 =?utf-8?B?QkQ5SGpVa3V6R09HZWdpZU9oQ29CWjlybXY2VTF0SEJuQktGa0xsVGVLZzNT?=
 =?utf-8?B?QmViQS9wZUVyeTltTHlRVlZvYm04NllEalZxOXRJMEc1SWRFU0Z5dzBucC9v?=
 =?utf-8?B?V2k3N1pLa2RFR1pVeTZXUT09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ODJ0TDNCTFRvOE5sVzZJY1l4b2pka0p6MFF5aEFlQWsvbEViSGFqcnB3T2lJ?=
 =?utf-8?B?NzB5VUs2V1IzeG9EZW04Wk1rMHJjS2l2VWtKd0ZwVngyQnBqRFV1Y2JhQ2x5?=
 =?utf-8?B?YlIwQTZYT1FEOEVJalcrS3daTlhzMVdJUzZPVFNUVS9nWm5kOWxFYmEyL0tN?=
 =?utf-8?B?SEpyMzZPcFl1am82UDBRWXI1MjNmRG9lUnN3b0gycWV6SlZFanExOFcyelJW?=
 =?utf-8?B?eGVlcng4VWJkYm5QUExZVzRIZVYvVDFHRVRQOXV3NXBSemVKc3NRS1RNays0?=
 =?utf-8?B?TGh5SU1NNlFCNEU1dGtEVE1wVENkWW9Ic1gvTkZ6Nm10OFI2enYvb0llUUNn?=
 =?utf-8?B?WHloWEFKTFY1SjRheUtZU2pSd1FYWVZFMmVwWlFId2tDTWoyaEtha28vUk8r?=
 =?utf-8?B?UHlKbzdlSHA3K2N3UVQ0MEVDZFgrN0MrSmZOQkFPaHI0UDE4TmQ2VjYwc0Fq?=
 =?utf-8?B?ZzlYcm9NWWdUbFV1bkdyNVVsanhidnlOeTdRK3lNdGd5dWpQZWtjU0RyeEVy?=
 =?utf-8?B?eGRzcGxGdHRvVkl1UEZMVmk3SzhHVDZndS9vbEh2NlZEcHJ5RUV4cnZSRW1z?=
 =?utf-8?B?Yzk2a1pYY3NzVU9JNHIyQ1hlZEJDbkFJYVFYMUt0MGw2MktJaHhGZFBKRk92?=
 =?utf-8?B?VjhpNUN1VDh2Mm8wTEVqWGV6NkVqMWRHVmJYcDd6NkxDd2V0N01YYWpibzRh?=
 =?utf-8?B?NmhzT1NKd0phMFJPWHVRYmRHSmh4eVZ0WWNiVXJCRmdtTGRxTTBBVXMyTzY5?=
 =?utf-8?B?M1djdEJKRG1FdW9DeUtmZmcyeE5JK0krNUpnZXZvVDJ0bHBUTytIWTlhR0FU?=
 =?utf-8?B?ZWRYVWgvSi9tNmVJbVdldnNZcVBiTDRrbVU0bjlrVTVwN3JPcUtoenV1aEM5?=
 =?utf-8?B?Tk1xek1PQ1JNZEN6Zmg5M1hQZElON0lQMmRlRXlPQ2gvLzZaY0FOYVkvNlor?=
 =?utf-8?B?RGNLSmdrTFR1WGJIV3FQQWR4UGo0OUJMUlViYlIwQzZuVzVZY09LRmNXWlJX?=
 =?utf-8?B?UEJOSjBub3I4dUE4OS84eVRFNWpuQVR1WXp5TUt0bHlaMWlRK0RpbW9tTzFj?=
 =?utf-8?B?YksweTZqUnRqNU00eEFlcWhlb2N6aEZpeXc0eU9WTEpoZ0ZMOVRuaGxIVlh6?=
 =?utf-8?B?aVNnempPUXN3ZGV3Zy8zUnZlR1VURHdBbEE2NnNIbUFxY1V3ZVliRWFuY1Jw?=
 =?utf-8?B?OTNVN2hCVnN6TnRtR0x5QWpWYkJCVzZ1T1FpWk9tSTV4Mmtac1hlck5WSk9L?=
 =?utf-8?B?M1BlNEpoTzd4Q2dwdFJpVVJaWUFlSFlZTWErVS9GL1ltbWxEdmJqVlp2K0NE?=
 =?utf-8?B?Uit2Q0ltaVdPQ3VPeTdwK0ZrREdHVkx0TWNxMEVFR3haQkRKVjZ6R2JvQVhy?=
 =?utf-8?B?WTBsWEdVYWlsdnhPSEJINkd0Wkdxc3RTcFY3QjMxY05QZGRJNSt5d095NHpY?=
 =?utf-8?B?TFhoZVh6blAxUFE4WjlWeXJ6YjRLWm5TeDdqS3F6M2p5aTVJVG56YkV3VHhX?=
 =?utf-8?B?dklBU0FYakZmUXRqTnRBMHo2eFZjcEVQbDNRVWUvNnFjRHhpV2FLUHZxVkFs?=
 =?utf-8?B?RDl5VUVnK1dYWXh6eTZGUVNqSDFsQ2tQVmFFU3lMdFN4SlY1S0NsSWQxemdS?=
 =?utf-8?B?QWJyWE1FNHVIKzZqZnpoVjJyT0pTdHNRM3BaSEdhU2lPajNUdHd4WmtVTEFD?=
 =?utf-8?B?WDZzclQwQ0ErUG1yQis1NWlhdW1TVWVaZDB2bEpySjkyVy9YQnV5Y3FFaGhn?=
 =?utf-8?B?dC82UmJrUmNnaGZDckVHSlVNdy9LeWhGRStpYlZWMEdPeVB1RDZBem02ek50?=
 =?utf-8?B?Q2x4RFlETDBhN0JBaFgwalJGQmR6TVI2SE9OS2JGV1Z0cUxEclBKTDlqakwr?=
 =?utf-8?B?bm1ud3hxak1yL2EyaVBkYW5CMmlCeHVpRVJveDhhbkZ6UWNIYmF5dVdsRWhW?=
 =?utf-8?B?QTBrOG5ra3o3U1RmSzR5S2F1NzJ6WHhzYWVYMkhKN0pGUFJBUEdLWnBmTWRR?=
 =?utf-8?B?Z214b09jWUtZVk9nRDAwZXpaWlFpbzJneFkzZ2hrM3BaSDhNVDd4aXJlMGtV?=
 =?utf-8?B?cHNrdkloRk1mMHBVTGJEd1hweU9mZ0x5L0d4M0dNdDFWWGVCbmdpd05icVhN?=
 =?utf-8?B?Q3B4VHBUSy9VS1JwUGtOS2gzcjRlNy9VcERTbkhQOTZWelFKeUFZcFhtR0gr?=
 =?utf-8?B?Mnc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 449606c6-105b-467b-3c74-08dd500aa5ac
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 10:54:41.7215
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H78A8Ath+VXFS8CY2C0odXyfPJAFP1aZ1WyNSMLfRg1iOfHjAoPu2gMfvbEGUGTyQyC3QaF921afpv9bdLSAaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3551
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 18 Feb 2025 10:54:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17864

From: Jan Kiszka <jan.kiszka@siemens.com>

This brings our squashfs class from isar upstream. So, drop it here.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

Changes in v3:
 - update isar further to address, among other things, a kernel build 
   regression

 classes/squashfs.bbclass | 51 ----------------------------------------
 kas-cip.yml              |  4 ++--
 2 files changed, 2 insertions(+), 53 deletions(-)
 delete mode 100644 classes/squashfs.bbclass

diff --git a/classes/squashfs.bbclass b/classes/squashfs.bbclass
deleted file mode 100644
index 829625a1..00000000
--- a/classes/squashfs.bbclass
+++ /dev/null
@@ -1,51 +0,0 @@
-#
-# CIP Core, generic profile
-#
-# Copyright (c) Siemens AG, 2021-2023
-#
-# Authors:
-#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
-#
-# SPDX-License-Identifier: MIT
-#
-
-def get_free_mem():
-    try:
-        with open('/proc/meminfo') as meminfo:
-            lines = meminfo.readlines()
-            for line in lines:
-                if line.startswith('MemAvailable:'):
-                    return int(line.split()[1]) * 1024
-    except FileNotFoundError:
-        pass
-    return 4*1024*1024*1024  # 4G
-
-IMAGER_INSTALL:squashfs += "squashfs-tools"
-
-SQUASHFS_EXCLUDE_DIRS ?= ""
-SQUASHFS_CONTENT ?= "${PP_ROOTFS}"
-SQUASHFS_CREATION_ARGS ?= ""
-
-SQUASHFS_THREADS ?= "${@oe.utils.cpu_count(at_least=2)}"
-SQUASHFS_MEMLIMIT ?= "${@int(get_free_mem() * 3/4)}"
-SQUASHFS_CREATION_LIMITS = "-mem ${SQUASHFS_MEMLIMIT} -processors ${SQUASHFS_THREADS}"
-
-python __anonymous() {
-    exclude_directories = d.getVar('SQUASHFS_EXCLUDE_DIRS').split()
-    if len(exclude_directories) == 0:
-        return
-    # Use wildcard to exclude only content of the directory.
-    # This allows to use the directory as a mount point.
-    args = " -wildcards"
-    for dir in exclude_directories:
-        args += " -e '{dir}/*' ".format(dir=dir)
-    d.appendVar('SQUASHFS_CREATION_ARGS', args)
-}
-
-IMAGE_CMD:squashfs[depends] = "${PN}:do_transform_template"
-IMAGE_CMD:squashfs[vardepsexclude] += "SQUASHFS_CREATION_LIMITS"
-IMAGE_CMD:squashfs() {
-    ${SUDO_CHROOT} /bin/mksquashfs \
-        '${SQUASHFS_CONTENT}' '${IMAGE_FILE_CHROOT}' \
-        -noappend ${SQUASHFS_CREATION_LIMITS} ${SQUASHFS_CREATION_ARGS}
-}
diff --git a/kas-cip.yml b/kas-cip.yml
index 1c868afc..1a0f6946 100644
--- a/kas-cip.yml
+++ b/kas-cip.yml
@@ -1,7 +1,7 @@
 #
 # CIP Core, generic profile
 #
-# Copyright (c) Siemens AG, 2019-2024
+# Copyright (c) Siemens AG, 2019-2025
 #
 # Authors:
 #  Jan Kiszka <jan.kiszka@siemens.com>
@@ -22,7 +22,7 @@ repos:
 
   isar:
     url: https://github.com/ilbers/isar.git
-    commit: 37cb017a0e63f9cc26c5ff1805190a95cd0cfad9
+    commit: b5f7aef4e4fd26d852f8b09e545d5ade551224df
     layers:
       meta:
 
-- 
2.43.0

