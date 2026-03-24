Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A0B9F54ACB
	for <webhook@archiver.kernel.org>; Tue, 24 Mar 2026 14:43:18 +0000 (UTC)
Received: from AM0PR83CU005.outbound.protection.outlook.com (AM0PR83CU005.outbound.protection.outlook.com [52.101.69.35])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.21182.1774363389095361973
 for <cip-dev@lists.cip-project.org>;
 Tue, 24 Mar 2026 07:43:10 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=BUjR61IE;
 spf=pass (domain: siemens.com, ip: 52.101.69.35, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MBoe1EGKjLSMzJS/XrVbBh1JOK6O7HQAtDKZ1WllplA65fSz3/9QCBfgPSBKK+6cd5IStbrhRU/BJnbEPvyc4puMdQTZm9XCB04jPfNZU5bCuLq8TPU72EKf+y0B/8XWnhT/jUfnxaGiRlQ5DnrrKzMvilu2HNz5b0bBMontB6HL+euCTE7W8+/YY43Xa12DJrJTYC6/hnk3YD3MPPcYCbcYWKevSfv9u1RAhxObk2M29HWGmyLMlba08cpUO3Xg3XHgfrWDXcrXIOvQvx1oHkRnQYq29Yd4dD33qv66Sj+91ppTMTo8fB0K64gCpiJHXIxpTwQ7uFKBVP8fY+hjCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ep3ueuYR5fG+8NVY9ny2p6yI355rdK5MOBVziIm9fIo=;
 b=t2+qLRzq/t59iUGgngYmhQVatbmOTWs47q3ifG2h/MFPfLdVqG4wNFMpqZeXXrx+UtlH7RgXVWPk+21OTZWgK/lcywe/jIOEALEmaWLOUJV3b0rdkYszWihcKoMgALKB/kEuftC0qWLWPSk6b09ZUicisnUt1MtkVrXaQCAjppkD0bixwUUTCjeKkYL44eRa5ooeuEQuI52HboLUF9tjNW4z3pJaDEptn3rkiGAiDqXDhUfilLTTTuDstrDGtmaM8Vb0q8fA8rjrhHLYV+fTVVu2j30EmE0oLyUtlDhCJCxeaVnqTde8A0PFoi5+lpNf4ryO1ZcOEGqb/sai36FXKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ep3ueuYR5fG+8NVY9ny2p6yI355rdK5MOBVziIm9fIo=;
 b=BUjR61IEfQbFMEhw/paX/U0OqvENMtpbf+/Ogfy3wNwQ15ygUOtxiVoSpgQg4svRdIRU414jN3HadsF7ceOEx+zF329m3Ta0KBXwY/x2XQl76yBzkECtq46AJ9AjQ3YHLNunoGJHUw1b+7hJUCZbIwIZxymiTIQIZ88mAKWhCWoeDuNHxqHP4RjG38ifrmZyLmuwbrRtS5hhhb8BBjjGngcUKogEC7uW0/DsXbUM3oYRZynXgKygSgIWu6FMIz1Y5WD6mAoVhkS5Vcq/XNcIkHlq7/lzHLPD8rOVSMHVuj25eCAORJOu4ukPBYSQx6e9fZOwZsC+RLGzfIMbYVqPOA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI1PR10MB7831.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:1ce::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Tue, 24 Mar
 2026 14:43:05 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%6]) with mapi id 15.20.9723.030; Tue, 24 Mar 2026
 14:43:05 +0000
Message-ID: <5acac95d-24d4-4f6b-8b1d-f89a3146b751@siemens.com>
Date: Tue, 24 Mar 2026 15:43:05 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH] wic: efibootguard: Add SPDX identifiers for
 plugin sources
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0330.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:39a::24) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI1PR10MB7831:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ad2cd1b-4ba3-41be-9f91-08de89b3a887
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|1800799024|366016|55112099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: 
	fHXCSstDBqPVPUBKIYXxsPKkhMl44vAWCTb8sd6LG7c3+qyduhzAWBqZQ9JG8xbCaKP1KNUf4sWMp8McwgNkiC65MDdykg1X74hY4gGo+a7CQ215a1oP8LOv+I8uY6Dg05Jsu7xA3ksDVlxsPUn16BRRhG+ylk1tU0N6uhjp16MX9sfHD47oxpZjZoNbc/plMTOvTZZfuUUR5oc8Vm/MeIueH81gl5r7VKHXNRqIYZ28/Go9f+vW+MCYEjlcFHBxHuo3iQqgrBt+IIoU3mZG0GQaEaNr4J5JQPOyY1DRRyMT7EZKjqn6BwB8qlHDKf0W/BFMER7gbLUk6Mr4ZQZoWYZiu1K9/YzMJnP+OjzQAHjjGHmj6+gy/E2R16Vk8SHrgx3ClwKHZsmC4h6DhIgBrkQ9Zi71e66eNKnc2X1taIU9fzNxrFdvBMerTDjOBLkuEvenr3LB08k7TL2li9D5eteDNidus8+PF4EwrDAPIWHj0F6GjL0q4qHuevquMTfy217bft64dt6ymG14Kt0I/mRflW4l0tU6tDOXFxetzBOe4MGPN1J5eoBPkEranSC89qdGlMvWewGByHKzmawjKh06FLwsCswI5ZElvL0U3PlTnKUxm8qPRhYrPKzpfUGzvhA7xWXj80PAgPvYNW58UKx6K2CvnEHFYbfOiJpBUbEVcriupecYSDvGZvlgKD2TWhSAtTXTvaa0cKdgPctYoGMzlOrzcuDVUkmeal636Po=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(55112099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?UENqMFNFY3o4Tzd1QWdrR08wNWRwVGhSN2VmNm9jNnpkVlB2QXNFTU16T2sv?=
 =?utf-8?B?eU9oWWhRajBIQTNRODRGeUVpTFBUbHp2RGNVYWxFZVVkN0h1R1Y5WGJacXRm?=
 =?utf-8?B?QmJTS25oMmhhSXN3aGFMa1AxYWg4ZmZyVTE4SW84VUJjWHdOb1ZqQkJyV21J?=
 =?utf-8?B?N2M1VWRnUExNSkhqbTFSTkMxNDdwRUV4d2tZYlEzWm9IQXcwQTNqYUMzM2tp?=
 =?utf-8?B?SWVWMWRRY0FiTXFtc2ZuaHdYMUNSaXhrbHNyUlEvME9ITHp2VWc0L04vMk5r?=
 =?utf-8?B?d1JoREhaWlpJaitPWUJEbHI2YTBIVFhockVWeWtYalBQYTkzbkR2TEpkNndz?=
 =?utf-8?B?Z1VvMFkrVURJTnl5cC9oY3lwM2FWeVN3MEZoQzZPNUVYT25yaEJpNGE0Z3o2?=
 =?utf-8?B?Nk1QYmJkN3FZYjlPR3BydU03bUhnb1B5QS9vcGw1UXFwQUk4SVhWSVhuTmJG?=
 =?utf-8?B?WG5TSHliTmF4WmpRY2hxYjIyL255OW85aWZESkRHNFRyS05uU0IwYjdYNUFU?=
 =?utf-8?B?LzdJNmkwL0RaRWZRaDB1bElEQzd4VGwyek1nOXBGK2tRSnplaU5tOTl5REdi?=
 =?utf-8?B?N1ZqYWdyejFzUGE2QUFPK1ZHejVmRndtLy9TZk9hNm0vVlIzRmR3T05ObVFM?=
 =?utf-8?B?ZEF5WVFaNXRjdE9hSEZ4b2g5STJBb2dUakRLdzQzb0dlSmp6enk0MFhHV3RC?=
 =?utf-8?B?VHo1TGx5VitaWjIvUm1BZ1JQcjZ0blhLS09JZWVNREYrWFhhNHFYQkZ6dE9V?=
 =?utf-8?B?Qy9aZEJFck52RGhGL1VUQXBXMTdzUk5ZL1NhNFpHRUkxUHlZaWFGWW5kZEQ1?=
 =?utf-8?B?MUdoVWtLdi9oVnc5Qnc5VmwrNW1WRjB5b1Q2dmJHN3ZBeURkVzBGUFh2UTcr?=
 =?utf-8?B?UDByclcrL2hRKzhhVjhkTjVQTk5xY2Y4QXlBemFmWnUxM2RCRjBob2dEV3Na?=
 =?utf-8?B?UmpXSWFUaXJOUFJlb1dJeVl1Y2NHbjR3NFRKamoyVTNkN0k5ZG9xcUdhb25C?=
 =?utf-8?B?eFdtUFBrZHc0N0lZdDVoZGJZd0lsMUl2T2tIYXE1OFZkMTNLZmNDKzRMTm05?=
 =?utf-8?B?TDNEV0w2OVh6L3h2TXllenZFeXBnLzEvWEgxM3hndlJIdWM1MEdBNGJFbnhP?=
 =?utf-8?B?ZFJOOTB6RzdmNUt4OUgyUDVTRnNjMU5GZjRjNjNmWTVhT2doYWFBTGJOY0Ex?=
 =?utf-8?B?dUI4bDZXSXFzUW1rb2RBSElucGExLzh4OE1BaUNxcFRtOHFSc0kzaTlRLzlT?=
 =?utf-8?B?QTlZS0hxU0Y3YURHLzVUQ25UTWhLaHFCanBYaTZhUE8rVi9jdVdFVklGVEZx?=
 =?utf-8?B?aFpGdm9NSVlGUEZkS3hOcUJTTW1wVkdRZGM4R3A5MkIvQ3grRWg3WXJ2TkVy?=
 =?utf-8?B?cDg0OStaNUJMWkdNZkxrbEE5d0dtTUN0UkkxWXRrVkZCVmlPeTZwSysza0Fq?=
 =?utf-8?B?L25BZENCaE04Y3NBbUhVME9wa1djY1Y1TzFrRnJXbzQ3R3R0WU4yQTNERHZL?=
 =?utf-8?B?cko4ZUxETWtsK2JLSW1FT1dLNWVUdGNzcGdQYlZHZmRuOUxMNWcvaHdWVVo3?=
 =?utf-8?B?Yk1oTWdNSWpCYnpGSkxXKzRUQjdqdWtHcVMrNE5CUWdudEZ6U1pOL1lIVkVB?=
 =?utf-8?B?cURoSmlZZWY5UHRmQnFqeFlBaVlXRXB0blB3cTQzdDVDQnZJUlRPK012cC9j?=
 =?utf-8?B?QUovSWtqK0Q1Y2ZrczE4ZFhEZ0x3RHBXUEdUTThPOTFYb2YwZ2xDWG5nR1V6?=
 =?utf-8?B?Z2lwb1FQblk1VnphOFdKc0hwOHRnVjRGWjN1WHUxQnBFMUIzYXc3dmkyU01V?=
 =?utf-8?B?R3VQbmQvRDMxQXJLUWIwa2dBelI3Y25mRXh0a1FGUVQ1dUMwaUxsTHNZQmVV?=
 =?utf-8?B?RTNQdDFEZjUramxURWdBVUd0TWVjNHd4ZkdmbU9WSTN3SEdlUFRsc0RFWEVv?=
 =?utf-8?B?SVRQT2VqZEFBS2tscmIyTzJsVktzODF5YmdYVzJhR1lYNUdtMzVNbno3U2s0?=
 =?utf-8?B?Yyt3QjFuc05YR3RaK29kREhhNGsrY3JHN20yWm1QWnpQSEk5bFNtS3BMb2lM?=
 =?utf-8?B?ZERZUW1acWJIY24rWlkvOGVDR2tOY1RsS2hlZ2w4M2VuNlRiY3JWSXczZFF2?=
 =?utf-8?B?L1B6azJyM2NsaWlJT0l2R0dRVGhxNXNic3dUZXFYd0w2allHdkFvZk05Mldl?=
 =?utf-8?B?VGFoN3V3UGRidE9pU2lpUEh0Z2tRczFFeVNBWnJpN3VSK0FiNVJ4YmkvRXhX?=
 =?utf-8?B?ZEFOTUdRS0lqbEtuQXhrai9XT0lReTJsQWhyZjZXNlB3RzVKZ3BWL3I4Zi9R?=
 =?utf-8?B?OHJDUEtxZnBORzllZ1ZwQitQbExWZENBVS9oRzBqWnFvZEg4SFowdz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ad2cd1b-4ba3-41be-9f91-08de89b3a887
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 14:43:05.4239
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s3oXXSvza7nVvv9ygSIq4jDkATOptMgDqTzFaYy5dDzIfPXGu/7wbeDY4nMvFPuNJULUmkH71nYDxWP31XezpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB7831
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 24 Mar 2026 14:43:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22555

From: Jan Kiszka <jan.kiszka@siemens.com>

Both refer to the GPLv2 license in their header, and that without the
"any later version" option.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 scripts/lib/wic/plugins/source/efibootguard-boot.py | 2 ++
 scripts/lib/wic/plugins/source/efibootguard-efi.py  | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/scripts/lib/wic/plugins/source/efibootguard-boot.py b/scripts/lib/wic/plugins/source/efibootguard-boot.py
index 5206f864..ca97d7d7 100644
--- a/scripts/lib/wic/plugins/source/efibootguard-boot.py
+++ b/scripts/lib/wic/plugins/source/efibootguard-boot.py
@@ -1,6 +1,8 @@
 # ex:ts=4:sw=4:sts=4:et
 # -*- tab-width: 4; c-basic-offset: 4; indent-tabs-mode: nil -*-
 #
+# SPDX-License-Identifier: GPL-2.0-only
+#
 # Copyright (c) 2014, Intel Corporation.
 # Copyright (c) 2018, Siemens AG.
 # All rights reserved.
diff --git a/scripts/lib/wic/plugins/source/efibootguard-efi.py b/scripts/lib/wic/plugins/source/efibootguard-efi.py
index cce948e5..f84c61a7 100644
--- a/scripts/lib/wic/plugins/source/efibootguard-efi.py
+++ b/scripts/lib/wic/plugins/source/efibootguard-efi.py
@@ -1,6 +1,8 @@
 # ex:ts=4:sw=4:sts=4:et
 # -*- tab-width: 4; c-basic-offset: 4; indent-tabs-mode: nil -*-
 #
+# SPDX-License-Identifier: GPL-2.0-only
+#
 # Copyright (c) 2014, Intel Corporation.
 # Copyright (c) 2018, Siemens AG.
 # All rights reserved.
-- 
2.47.3

