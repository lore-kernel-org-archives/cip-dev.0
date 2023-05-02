Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70A68C77B7E
	for <webhook@archiver.kernel.org>; Tue,  2 May 2023 13:09:00 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.78])
 by mx.groups.io with SMTP id smtpd.web11.128061.1683032930613369836
 for <cip-dev@lists.cip-project.org>;
 Tue, 02 May 2023 06:08:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=cVfuyvEg;
 spf=pass (domain: siemens.com, ip: 40.107.22.78, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bs2XYzvaFPj0hoJBn0bbBXEt3Ku6Zqd7rVqvDk7+aI9twggSYpjQjr500h2gI2BijaSwpzzLpXf87koe5JLWAKBA+gaD2B2qHA9hP+WShkkC968cIFSO1lX+9ucZtOpUAhwffCs+1n6ykEq/9dBD2dZs2or+k4XAE5i0Wn8LFp79qo2Lt8sb7SIBtl/oLPADJhF/JDbk72+QZ1ZBK8Z3xUwM+T8+HsNtHRwn/6exHDwyIRFIwz28iZOogOza9gM9JCdZy96fCeTZwJwku1Ez4X3p60ihsDOHIfg5ibacz00BT3seN1IHCpmeJ1TFPfK0CU/w8pLwddnbmBajBw+P1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9LQwDfXzLnP4Im7tvIiPfWb8/q4hvMh3pg/hd6zEYOY=;
 b=neXCvSexA1n9XqEeBTJHDnXi3yuJ0ve7hUYF8UnlZNRdZslrx7EpKwH+7ZPa/JDYz68brbPDatShaoad1I4eNY4AFuigYgyZsJPTNAWSoqW1mjqFyzMKW7SlFqKnJF4oVwVLmeIrTO7YFiUiO7xi7OQGzrGnKATs+V4KFEOofdMFgITJ8cd/tWRTYTvuLDNKR4+f7BgKmtBzT+RCt//JMytWr/vvxXRvI3gCQN9UKk7cg4u/7E6gbvmKpSpoSIbTwnryMzopR6aeSGL+x216U3SH2zWJaxOoarynkKV6PdHtsQdK5brTcbB0D4ESVVbz2tURmzE6qjam8RWhggDSNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9LQwDfXzLnP4Im7tvIiPfWb8/q4hvMh3pg/hd6zEYOY=;
 b=cVfuyvEgVVakvxx1IC96P07umD96BvbHNF9jIAwuscjmgBcMjFzAvg8DGttiNxSqeUn/FC42D+/Wlu0aYebgoaiBfm9zkXIALkJeUzI8TILws2HQHgc4/QsclQmENU3Ww2eAT0VtfdzeBlPjDLmH3ms/gtMIncoc++DUaZ9IyLVJVgNvI7/c+1121lRIxN01baZuDA6LeGQ8P3UkWUz1nczjxp97TH6HaL8IzZ/mKwVw4rDiiVem5Kzq2IYP5Tx6W8Kj61OySN++u7lmdAG0r2ExZhS71ZNVWB3XmI34vDtCwaeL6R4XQy1rCUyFxBIxGJbEMxQbLxiX9CS2D+/5uQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS1PR10MB5579.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:477::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.30; Tue, 2 May
 2023 13:08:48 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f5ab:5f59:3b47:fc2e]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f5ab:5f59:3b47:fc2e%4]) with mapi id 15.20.6340.031; Tue, 2 May 2023
 13:08:47 +0000
Message-ID: <033e4165-3402-4536-72e0-6de65c20716d@siemens.com>
Date: Tue, 2 May 2023 15:08:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [isar-cip-core][PATCH] Update RISC-V snapshot
Content-Language: en-US
To: cip-dev <cip-dev@lists.cip-project.org>
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM3PR05CA0097.eurprd05.prod.outlook.com
 (2603:10a6:207:1::23) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS1PR10MB5579:EE_
X-MS-Office365-Filtering-Correlation-Id: f7ea1588-acc3-41f5-5803-08db4b0e5da1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	7hYAO30U+PBKwZf56D8gY2H2hIL3FOrSF0LRZGI4g02lHThiaMbwA0+KrXuDV2pWEDIUzFmpJ4Fqs7f8VdlpCjAnm/sXI9DZaFhdEHLL8op4cPgyeZOvvwJpTiBMJ+iC8aE6B37tItEWlcN8MsugmzixhbJFHSFB62QN1vGLnCh3D0mupR0jq10a3SVa7Y8W3avrU9wLU/g25y2pnLNdeT7dr5f+dm9sXzqDG3Bm9LT020LNoylcieMjJPuvpptonMi9f+Gb/Tczh3m8Puq5UG0kRpbGz3L0ReHCcG95oyNFkQcHaqfxPVgHHxdyAcLUjeJXYcImfwp509kUvqtDXRyYkfFJAejGZd2BLf5nS4j5SETa358p0BQ1NnhJ7h8CKQtIRkGyeGehvn9fm8kEUfsQv448dz7xsAzGNLtPb4xWXm1asLZqEMa533hWmU2gwJmHhl/pPDkG204cptplT6cIjUcjrikQvlf2J4O5WeD5/+SzoeW+lt131WMB2rt48kGwTbL3Iq7fJquVcF4vs7RRUVVu6yidmueTBUgWUODbhbRXXEQPYWc5qf/Vb1EhJd5t2mlgRkwl32LzVUXVHP6JsK/FSboYLo0AZ0x3kSLXMYB6zyI0KnAQ52nzyECgYjes+ZX/VXUr5pTymKR0K3u6M1CjOu5xIbOHRhnIi6LO1O6sNZHMzIGJn5R9QXqJ
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(376002)(366004)(39860400002)(396003)(451199021)(2616005)(83380400001)(107886003)(478600001)(31686004)(186003)(4326008)(6916009)(66476007)(66556008)(66946007)(966005)(6666004)(6486002)(6512007)(6506007)(26005)(316002)(8936002)(8676002)(5660300002)(41300700001)(82960400001)(44832011)(2906002)(38100700002)(86362001)(31696002)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?NUs5RklLQTQxaE9VaVRmZHAva0pzSC9rdldOblB3TjViOFc4YmZEUWpMOGto?=
 =?utf-8?B?U3ZNK1BOWjZJUVJPUGlzQzZGM1Ezd1YzUzVDbkdLU3Z2dWV3cWgvMlRIV0FD?=
 =?utf-8?B?UlV6QU03d2pPWm5UNkRpUGNzU093aWJLQ04yRGd0MFRaQlA5c2w2TlJBWjcw?=
 =?utf-8?B?RFpHak9TNnVsVXBDZU0yNW5zaEJSU29BR2xQNSs0OUdjM3djVHhMbGVNRlhM?=
 =?utf-8?B?SGhuV1MvTXgzRk9FU1RZdzB2ZVBQZ1ZwSFlBVUFMdWpkRFhQVDhKK1laNTJY?=
 =?utf-8?B?MVQyay9YcE96bklRNHNwd0RXbURLS3NVb2sxTGNJb0RvUEM0NEg1aGlnUEVX?=
 =?utf-8?B?UmZRWnpWRStQUldIUWNuUGRqNHJRQ0huNXBILzVrNnVjODl4Nlk5ektFWHR0?=
 =?utf-8?B?ZUZtSjVkRjFBdS9YTTAxSElZYUQ5SllnYnVjbWxMVWs4TGhraXhzek9rMHlH?=
 =?utf-8?B?THBMaFlKazdYN3hvWm5VV0U4bGhZNUVyOFFZYTBhNWtZVDdVYjVRVGY3dHFw?=
 =?utf-8?B?MmFab2ZlS1lPOWcyUHVzWVEzUUZjVVBoQjRsWEwzeDhkMHlDQ0JWVEpzOWJr?=
 =?utf-8?B?YlVYcCtnM3docEVGanNSUW5MVjdKUm9tK1VONnZQM3F5K2dIK1JFNWdUeWwy?=
 =?utf-8?B?Y0Q0TEgvNHA5TjU5WWxtaGs2di9OVkhicUZYeU5NcnVFbHM2bU1NNWtEZFdl?=
 =?utf-8?B?RWJNdmZVSFJTR3FZUUFKWDJ1ZUp5QnVtWkZhTWh6UVhmOGdqOUpWL3FJWDZF?=
 =?utf-8?B?M2tyZmp0MjAveFdXSUdabTIzelZOVjdqcTRoVVdYUUpxNU9mN0ZhT2NsZDla?=
 =?utf-8?B?aUFPcFRvQ21SUmlENTZNRmtWbGFJaHNQNDl6KzFDT0pYSFdmL1ZSVjFzdTND?=
 =?utf-8?B?cGQ5TWcwd2xERjdQL2JKRWo4NWdteU5najQxS09rUG9HcHZsbnkzT2R4S2sv?=
 =?utf-8?B?M1l0Snd5OWJxYzk0eVVsbFN6Y0ZwRERiamROT204NHpsVUpiS29xMm91ODB3?=
 =?utf-8?B?dWtoZ2NnMUEyL2pZQkF5M0ljN0ZDdStjVjcwUVU4WTJwUEl6MjErMVo0aHNK?=
 =?utf-8?B?TjVsZTkrdmRUL2ZpSDVuWFFRZEZYWXozb2pvQ1VxTnpxTkR6K3pnZi9sMytm?=
 =?utf-8?B?Y1JVNTlEOGMvOVdXRVJPejkzNVRSdVFKUmlLM3NLei9JbXUxS2o4U2loTWtN?=
 =?utf-8?B?N3FhSy9OT3BZd0YzblkwTm1EbG1vV1NwbWRveVRxRDNMdUtrYVRmNmRrSnBt?=
 =?utf-8?B?ZDBwa2NOY0FNMFlYWVVRdEpXeVpPWThzcFhnTFdLZVNRcHJqQmRMdUpvMjBJ?=
 =?utf-8?B?MnhFb3JYYUdvVi9Ya2RONjdVb3lIQmM4RTJ6eDlPaExjQzFmZWxHWkZuSjFP?=
 =?utf-8?B?ck9KckdBRnRsZGtJT3lCY3hsaTB4dWpkYWV0K1pDT2JhNWlRWVJRNjF4WHQw?=
 =?utf-8?B?Rm9BejY1Z1ZBL2p6eFVIVVUydWdDYzFlYllHano1ZjZjMVl1VzhIUWN0STM0?=
 =?utf-8?B?TlRSUE1KaGxDUDM3c3VyR2FFT0dpTDkxK3pLYkx3Z2xpRndTNThqa002dVdj?=
 =?utf-8?B?NHNOK2xoUGNWVnVnZ0FoWTY4VzZnaWJ6RGFJM0lrOEVPdnM4MWhPOG9rUkFi?=
 =?utf-8?B?LzBlWHFHekVDYldHc2ZJbTFVSWVnbFJ1aHBVWmFpbUp3Vmcvc0Jlazl1Tndr?=
 =?utf-8?B?SU9ET09LOVRzR1N6ODlxVW5xQ3k2MDg4NzEvZUZOY1MvR25pRHYzNSsxTVl6?=
 =?utf-8?B?Q2RZeWowVFBCZ2V4aFVEenRKS2V3QnpvcnVwSXFiUTlkZzFRVC95emxjTlNK?=
 =?utf-8?B?cFNqZUJWOUxNMEFLekZtczBWTTBOK3lEMjdyd3locFZiTDVFZ3dzbkFyM01K?=
 =?utf-8?B?WDBWd2lkcGYzVVFXNy9jZjR2alBmTzhWOTR4bUVRZ0dMOEZVa0NZRWJUSDVU?=
 =?utf-8?B?UmpNSGVtMkQwSTluUk5IUHIrTlJ6TDVyL2FJaXpaZEw4UUFiMTIzZ3RJZFRH?=
 =?utf-8?B?YVpGa0RQVmo4NlI0dXdJcm9GK29XRVVxVDFONGhEM3pMc0M1SjlEaTBtOS9p?=
 =?utf-8?B?YWp4S3hsdEtnS0krUkpNTUZYSDkzQmd2T1RvdHo2NXg5dDhiZWEyOWZYUVAz?=
 =?utf-8?Q?rVutGlwL2f8Hz2PTxJ1N6e9Vu?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7ea1588-acc3-41f5-5803-08db4b0e5da1
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2023 13:08:47.7987
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8QwVmLQhL2bxLzaWKdBSrYn64UnXRammL/DDdFmZm9Vxt5Lp71Tpg9VLoqnrmaUPZ9/l4AyjbMTFevlhXsbwQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR10MB5579
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 02 May 2023 13:09:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11375

From: Jan Kiszka <jan.kiszka@siemens.com>

Time to move to a fresher building version.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

Build & run succeeded locally, just CI is constantly stumbling over 
snapshot.d.o.

 conf/distro/cip-debian-sid-ports-snapshot.list | 4 ++--
 conf/distro/cip-debian-sid-snapshot.list       | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/conf/distro/cip-debian-sid-ports-snapshot.list b/conf/distro/cip-debian-sid-ports-snapshot.list
index 77e0d9bb..bd08a742 100644
--- a/conf/distro/cip-debian-sid-ports-snapshot.list
+++ b/conf/distro/cip-debian-sid-ports-snapshot.list
@@ -1,2 +1,2 @@
-deb	[check-valid-until=no trusted=yes] https://snapshot.debian.org/archive/debian-ports/20220925T001806Z sid main
-deb-src	[check-valid-until=no trusted=yes] https://snapshot.debian.org/archive/debian/20220925T001806Z sid main
+deb	[check-valid-until=no trusted=yes] https://snapshot.debian.org/archive/debian-ports/20230430T091331Z sid main
+deb-src	[check-valid-until=no trusted=yes] https://snapshot.debian.org/archive/debian/20230430T091331Z sid main
diff --git a/conf/distro/cip-debian-sid-snapshot.list b/conf/distro/cip-debian-sid-snapshot.list
index 1e68c238..87e0b95b 100644
--- a/conf/distro/cip-debian-sid-snapshot.list
+++ b/conf/distro/cip-debian-sid-snapshot.list
@@ -1,2 +1,2 @@
-deb	[check-valid-until=no trusted=yes] https://snapshot.debian.org/archive/debian/20220925T001806Z sid main
-deb-src	[check-valid-until=no trusted=yes] https://snapshot.debian.org/archive/debian/20220925T001806Z sid main
+deb	[check-valid-until=no trusted=yes] https://snapshot.debian.org/archive/debian/20230430T091331Z sid main
+deb-src	[check-valid-until=no trusted=yes] https://snapshot.debian.org/archive/debian/20230430T091331Z sid main
-- 
2.35.3

