Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5567C282DE
	for <webhook@archiver.kernel.org>; Thu, 13 Mar 2025 09:54:09 +0000 (UTC)
Received: from DU2PR03CU002.outbound.protection.outlook.com (DU2PR03CU002.outbound.protection.outlook.com [52.101.66.29])
 by mx.groups.io with SMTP id smtpd.web10.10945.1741859643216862710
 for <cip-dev@lists.cip-project.org>;
 Thu, 13 Mar 2025 02:54:03 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=UjywGqJX;
 spf=pass (domain: siemens.com, ip: 52.101.66.29, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YGWsr9QfDO+2CYGJ61uhyLWNeclPsnoLzMnERwYr6/YvX+zdCDjr3CEKKnpQW0gLDpGRu2RsvauposFzpvzliXhKwGMCwx8SbaD65UT7nS2MHJRX/sZO8xDq9yzbwxnmJqsEoeGljj9R4vTZAK/z2uD1DupbOk/ZnmHqLXZgwe041KF7UBj7zCRMs0oHCJzsVIRuEkuUaVEsSrrHPsoRQTB5bpNTNMMk96I4jnlywK2aRB++BZqsKna9a2GCAyvu/FO3p11xhxyLA4IbCWB1O4eI5IFAHNyxNNSSXAEmpMvx161vD+yJXVLYHTXo4N1XQWAL3dVhTE0nLcFwI4ssaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sQKIKr/eAju+ZTQYmSqv26y7zYhDMTbI+ZYduSmSCUM=;
 b=WTqEP6Fk0vFrF9nsgm/sdC0upXWXKwFh+0m+ih5WTs2pp7+NhWObzOL8pynfmwEqdnx6rJl2HYaKpwzeMG0ts48E5/8aYPN3mne8aUJszfaSl5wM8QopWtqWJs5Zcw1KZ+qo7xmZADHxnwzqZqww+vhyv9y56ZWPLn2QiBJRx1Y19MoBoNqj0ckcpfZAEQGCRcLiQsM/XtVsg7AbEXdjNvznEdU3LOaI+yan63LQbL9+shlfZrlnI6xg7hHi96ZbdKvd9RPpLyRDCa2UxP/KT8chPlt7KEJ4higB4NT0ejyYP0adZQR4t1VZpz8mBa5fHfM58USCt3jteCx5Ae4ysQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sQKIKr/eAju+ZTQYmSqv26y7zYhDMTbI+ZYduSmSCUM=;
 b=UjywGqJXbB39gBIXQI7lKnsyeLw0kmaAxcg5vVdF8b/QGKML4F4y7Tb4llpIMUV3wW9vLVtlAHP8yqky75V53ybq8urUMst8hU7QvpV/QoMpFdBruZlhGeFOAFyG/N7P/UhyL5271G5/6WqIM6tk9/OTlg58qDKPE/VRdfCrYkQCqSWnu0A0LvNxUPkaZb8VWKcAz7L2U8ir9vAN8mbX82dz12R0WLzEK+FO/KdlBYiN+lYKOzcOT0btLJLmTeLakcQ15+svI7Nxcu/ZgSE3oJM+kdGiYE/Jxv6dRS/kBz60puGXOuRGNFC7+G0CHJ7WfsNTDqbyCyQEHKEg2l9arg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB5PR10MB7793.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:4a3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Thu, 13 Mar
 2025 09:53:59 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8511.026; Thu, 13 Mar 2025
 09:53:59 +0000
Message-ID: <fa747ccb-9f57-4da8-907c-65618a94164e@siemens.com>
Date: Thu, 13 Mar 2025 10:53:58 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH] Update isar revision
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0147.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:96::11) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB5PR10MB7793:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a9cbd53-3fc5-42f9-d797-08dd6214fa5e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?cnM2MzVEWVFDQ2VlK0h3SVUvM3BBcEFqdWx2ZGdPWlN5QXdMa2NWZmpWbm9m?=
 =?utf-8?B?Yk93Z3ZPKzIwaUIxRGtZZ0JzMHNXMXVTS1AzRE1yK1RPNUJUOUpXS1A3QTd2?=
 =?utf-8?B?T204N2NUd3JqUlcyemV3RHNiUkJLY3R0VG5PYmhGSWJBMUtRRVcrRFJtK0F2?=
 =?utf-8?B?enBuQXQ2RjkzY25BT1NxUnlrQ3N2OThmbFpZZFBIMDUwSEdVSFVSVS8zWGZ6?=
 =?utf-8?B?cTM1N3ljTTRWZjltUjFyWXBqNlVablR5clE5dHAxZEFuUm0vZkxnamhTWHc3?=
 =?utf-8?B?bStBM1RLK3lxVGVxcUgxQzNxaXZKYnlJOWlJWmtySmx3dEt5Y1VXdXpXMzVT?=
 =?utf-8?B?bnhDTGxFZ2pRbzNTdFo0aEtRNTNLZlZ3c0Eybk02d2taelRGNG05YWhhOU1q?=
 =?utf-8?B?aU9Ha0xqWEJnVDhMWjllMUwweHBxQ3QvU2psdW5WZnNLVTk3TEZiOWJ5eXln?=
 =?utf-8?B?QWZONUJGSGZ5VzhsRmt6YVBEZmtyMlZZcjh5YUdUeWhqMlU0NFlqSURRd08r?=
 =?utf-8?B?Q3I5ZHJDME14UStzeHMrOW9LemtOeERsOVZaY0JkazAxOU96S3ZFVjMrdE9z?=
 =?utf-8?B?N0VvYlZRTWR3WHRTVlk5MTY3SHNRRW9SM3FKb2g4L2JObGZaWlljSDcrUkVV?=
 =?utf-8?B?a05CSVNLL1ZPUXlNY1dHWjVSays4VEh1bmVyNDJ6TXVhYjJYMTdNNDJJU1hE?=
 =?utf-8?B?ang5M1oxSnRnM0l4WS8ybEZnRGRYWTNvR1BXWkdjcC9pSUNyOTdjbWdIc3Fy?=
 =?utf-8?B?REprcG5uMVJjQVRvK3dpWDMwS1djK2xVanUyWjc2bTNoeDNSU1FVSXpWSGR4?=
 =?utf-8?B?dTVSRUNIV0ZyTWlhTVFTemZvcEFWcnc0c0hUalpveG1HRDR5NWVYbnZITjZG?=
 =?utf-8?B?QmJYTWt2UUxBRG12UTNVWWdMOUp2S1FpL0MzV3VuWDNGd2dwSDZpUkFrbDB1?=
 =?utf-8?B?UEhyZm4wUDNndldjY2d4cW4vYi85azlOOU83dEN4K0hyaHF2elk5ZyttZHNJ?=
 =?utf-8?B?UFdiM3lZZ0RBb2NoUTNLcVFUZkw2bmZlemlyRnhxeUtLYWZaemdtUVhqU25n?=
 =?utf-8?B?V2hvUi9OMnhFUXgwY1RnZWt2SXZyUXg4VlE5c0lLcnZsSE5TY1hnTlVJR1ZL?=
 =?utf-8?B?Q2hBamVwVllwVnF4b0NiS21EbzVlWncyVjhtQnBBMnN4VEtZRjhjczZTcUJn?=
 =?utf-8?B?M003QTJKNVR3eFB2bUM1VHZ6blQ3anlNVEVHZEtqWHliK1luVGU0Qi9SRWZk?=
 =?utf-8?B?K3c2WVBrQWRSNmVPVEw1cXlhUm5ZV0F6cEtGbm9PeWJOVUkvMWxVcDF4ejls?=
 =?utf-8?B?cEpiUU1kM1JBMjJxQmQrUjdHa2xRa3J5QU82TXNBVnk3UEZvMWZnT3BIOTNo?=
 =?utf-8?B?OXI0clZ0QzR3UzFGZThsUldONFR0ckFvSTE1Tm50YVRLQzVUekVMaTJ2RUdB?=
 =?utf-8?B?NXMxSVYwTmx3QU5YeUFkOE9VeUVqejV6T0YrRVd5Q2lleVlQM1d3TmNvckVY?=
 =?utf-8?B?QVNUY2ZjWkF3Q2ZUSkNqaW1iM1VOYkM1K0gySVc5WGtDcnNLNHhrU1ZoV0d4?=
 =?utf-8?B?c2NmdVAyK1cxbjltOHljYkpjMy9XRzJNdVB6VEFUSkg4ZmFMRjdkclhKbitI?=
 =?utf-8?B?dHFOQTh5ZUgrUHAzTzh1UCtnTlhHcHhyelZzSUN6eUhFNHhqOFZ2bFhxS1hr?=
 =?utf-8?B?NFM2SnI4bUxVaHhwMVJVR3lYWXlDeHZKY3Frd0QyWjhtUEF6eW95blpmenB0?=
 =?utf-8?B?TnVhLzEzTlJ4WG5aY2pTQXptdit0M214YXZlYU1vcnlpQURaZ1BmL1YvTFFZ?=
 =?utf-8?B?OEY0SC9ROXI5SlVYYXpJM3hCaDZmeXlMZUYwR200bGw5d1ZCZjVTR2tSNUhx?=
 =?utf-8?Q?6k6BzNDM8b4C5?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?amVxOVJ4V1BOQnlWNHh1Qzh5TDVzYlRSMndHcENGdlBFNERrR2RIb1FsT0FW?=
 =?utf-8?B?NHZ3ak9wZ3ltK3dWMEp1bXhGRjVIbTZOZXAzQWJFODExUGdxbC8wL1J2enB2?=
 =?utf-8?B?ajl5SlFVSDhNMG9UbXZjbHA3djIwazhhS0xHR1g2c0hidkwzMmhsRE1FM2xM?=
 =?utf-8?B?MlJIK2R3M2pVT0pxeGdwK2VGUmhOaVhIUnd5TnN6YVptME9sc29oSDJlM2Z1?=
 =?utf-8?B?Y2hNaW44c20yRGhJTmhhR1A3V2dQVlpRbkhlREhWTlo3SFg2SDBmLzZuZWRD?=
 =?utf-8?B?UWZlL0lvN291S2F3VVNVVngrcGZjd1luTnVWUDMvU0R1Rzc1bHhrMGZyT29U?=
 =?utf-8?B?T3ptMWFsMzR2Q3hweWpRUmVnRmNmM292cmdJUFZkK2FlY3VjUklKSVplSXBL?=
 =?utf-8?B?K1AvbGdFU3lrWEdNT1pISENRdms4K1VvUFBpcEZOSzMvYlhlU2pPaEJ3dGFT?=
 =?utf-8?B?dEVQdHViR090M2tjci9kQVFINS9sYzQ2SWE4MnBFRElQelZKZ2RGaHVpK2g2?=
 =?utf-8?B?Q3ZzOUZmWEFadHpxUEFuM25VTEhQeXZtK1R6Zkk0bVR4TUNRZ3VpM2tsaUhz?=
 =?utf-8?B?cVNla3MxQzhEMWJqVXBaLy9kSmgxSTNiQ2dOT2pNRXRDZUtEdWlic3YxM3ZP?=
 =?utf-8?B?ZnkrcW8veHhqZVZaalBDOTFidHltdjlVQjRJbTcwRXI0R09vVm9UcGw2UmRV?=
 =?utf-8?B?eUhSYnNvUmFZUkhBby9SVk4vOXkrRnR6b0VOdVJGT3hGUkxvcWxVQXVyR2RW?=
 =?utf-8?B?aVRPdnIrTHdhNW02SExGMFRQM05YRnZGTEVzaiszNWk2SjZQZU5XdjcwcTZY?=
 =?utf-8?B?RG5qeHByQXpMVFN4UFJFWmMvY3JBOTRQSlF3dmJURC84QWtNZE56NlZtcXRI?=
 =?utf-8?B?TXdIMi9ITGsyRnJoZEh6clVMWFJoOUNqRFJjWHIzb0kzU1RiT1paL21SQjhm?=
 =?utf-8?B?ZHJReXlIclpqTkFHY05kbUtaY0psdEU0WDNqejNDVkxvVWpVVnRKVU9XcEha?=
 =?utf-8?B?SzFpZnE4QjJSOHBvQTh2N1VnMHdhdlF0L3FncG4rRkV1cjVLK2QrRy9Kb0I0?=
 =?utf-8?B?ZTc5eGhXa3Z1SFZFWWJtQWVBU0pJOHVqTUtjODFlb2hoZk40Y01kNDNDeFFa?=
 =?utf-8?B?eldCZ2JHeUJ5MVZ0RURZemRYRFJTN2R5U2pPZDM3NWYxSm9JZ20zR09uc3Vs?=
 =?utf-8?B?bitHeU9ybDQ2OUdVSTl2UFViSGM0b1llZjNnMmlMVllybzVvSGNhdllYN0FM?=
 =?utf-8?B?TWdncERCcFZLN1RIbHF2SVlUOVNYTW1DSHovbElLbFVwV3IzOHdLUkxQRU9L?=
 =?utf-8?B?R1k3YUg2dER5b0ptRWxTbEFhSGlqLzJFSmFwS2ZDZVcwY3VIWHQxaGpicnhH?=
 =?utf-8?B?c2c1NDFyZGhEbXV1K2Y4dnJ0UnJaUVM3VDZTY1R6Tk91NGFSWHA4YnNFWjhQ?=
 =?utf-8?B?RWFtZnNVOHJSUE1tRm9jbUIvNWtYaGRGN2Y5K2ZxeHc0U0Z3b3hnRnRLNVU0?=
 =?utf-8?B?eXI2V2N3di9LaGMxbFhSbGdFYlU0eis1VTh1Y2ZnRDBkMFoxcDd0V2FUcWFw?=
 =?utf-8?B?TnpPV09TcWErN20xNnYyM3Uwak9PWUpnRUZuTlMzeEdUZnVRZ0tnRGcybVV0?=
 =?utf-8?B?UDFXajBlY0FNZDl4V2ZGc09QL3dJUXFKNmhEZXFPbUk3TmhLYUprUnpmNHhR?=
 =?utf-8?B?emNDTFlwVlpEZG1DaE0rRm1mbGxxU2pXc1lmQ3JEalZFZjhEQWU2aU5BZlZG?=
 =?utf-8?B?ZHk0enNGcjJReDZNRUZFYkp4Y2FoL1A4dTl4aGFBVVEzVTV0bEtIVzJnQVgv?=
 =?utf-8?B?V1A0NmVha1JaWDdlQk9HMDNrUEN3eGhPQWoxOU0wdDhoWkRwVUJVMzdaZUs5?=
 =?utf-8?B?TXQ0WEVjTUhTb001TlNrekVncGJNNHkxUzZnTEpoOE9HTmpHclhDZlN5eVNv?=
 =?utf-8?B?OG1qRmNsY1FSdGwvRUF0ZUI5aEQxSEh6RzNwRHRvVVRjWGYvVDJzTmNoK1d4?=
 =?utf-8?B?WGZMbXgvUUNUN2xka2haU29zNjJZNERGeUIzYmZtamtPRHIxVi9lU0s1STFF?=
 =?utf-8?B?L056UnJvd1ZKYVI1ZTNjZUkrTTdjZFFnQ3NYODNUWFhlSHhrdWVWYlRiUHhR?=
 =?utf-8?B?RWtneDMzT2JZOU1HUGNZUW8zV2tma05SbXpGZldCU1oxSUV5ekMrUGN2Yi8x?=
 =?utf-8?B?Nmc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a9cbd53-3fc5-42f9-d797-08dd6214fa5e
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 09:53:59.6844
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zW9JLCqi9obgkWjjTzNYccIGiAVXf4CnuZ6OJuFjgocN9j6GKPT9ptBvH2yBMyqRqR8uv9i4pWrTN8oTilANMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR10MB7793
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 13 Mar 2025 09:54:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18186

From: Jan Kiszka <jan.kiszka@siemens.com>

Allows to drop the local patch.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 ...op-no-longer-needed-and-now-broken-r.patch | 32 -------------------
 kas-cip.yml                                   |  6 +---
 2 files changed, 1 insertion(+), 37 deletions(-)
 delete mode 100644 isar-patches/0001-sbuild-chroot-Drop-no-longer-needed-and-now-broken-r.patch

diff --git a/isar-patches/0001-sbuild-chroot-Drop-no-longer-needed-and-now-broken-r.patch b/isar-patches/0001-sbuild-chroot-Drop-no-longer-needed-and-now-broken-r.patch
deleted file mode 100644
index fc4f6bd6..00000000
--- a/isar-patches/0001-sbuild-chroot-Drop-no-longer-needed-and-now-broken-r.patch
+++ /dev/null
@@ -1,32 +0,0 @@
-From 5dc3f7d755b5adf447b419816002076bed21b8e1 Mon Sep 17 00:00:00 2001
-From: Jan Kiszka <jan.kiszka@siemens.com>
-Date: Mon, 24 Feb 2025 21:25:49 +0100
-Subject: [PATCH] sbuild-chroot: Drop no longer needed and now broken riscv64
- special case
-
-This was forgotten while cleaning up for trixie in 735dc16c1e. However,
-it continued to work - until these days. Fix the riscv64 build by simply
-dropping the obsolete package list.
-
-Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
----
- meta/recipes-devtools/sbuild-chroot/sbuild-chroot-host.bb | 6 ------
- 1 file changed, 6 deletions(-)
-
-diff --git a/meta/recipes-devtools/sbuild-chroot/sbuild-chroot-host.bb b/meta/recipes-devtools/sbuild-chroot/sbuild-chroot-host.bb
-index 255d6937..3f0888d8 100644
---- a/meta/recipes-devtools/sbuild-chroot/sbuild-chroot-host.bb
-+++ b/meta/recipes-devtools/sbuild-chroot/sbuild-chroot-host.bb
-@@ -18,9 +18,3 @@ SBUILD_CHROOT_PREINSTALL ?= " \
-     crossbuild-essential-${DISTRO_ARCH} \
-     apt-utils \
-     "
--
--SBUILD_CHROOT_PREINSTALL:riscv64 ?= " \
--    ${SBUILD_CHROOT_PREINSTALL_COMMON} \
--    gcc-riscv64-linux-gnu \
--    g++-riscv64-linux-gnu \
--    dpkg-cross"
--- 
-2.43.0
-
diff --git a/kas-cip.yml b/kas-cip.yml
index 16e54d63..cffc4f16 100644
--- a/kas-cip.yml
+++ b/kas-cip.yml
@@ -22,13 +22,9 @@ repos:
 
   isar:
     url: https://github.com/ilbers/isar.git
-    commit: b5f7aef4e4fd26d852f8b09e545d5ade551224df
+    commit: d46adc844a74ba55c4b9521b7d7da9b5a47b489e
     layers:
       meta:
-    patches:
-      01:
-        path: isar-patches/0001-sbuild-chroot-Drop-no-longer-needed-and-now-broken-r.patch
-        repo: cip-core
 
 bblayers_conf_header:
   standard: |
-- 
2.43.0


-- 
Siemens AG, Foundational Technologies
Linux Expert Center

