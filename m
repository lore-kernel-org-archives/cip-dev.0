Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 385BCC982D0
	for <webhook@archiver.kernel.org>; Thu, 17 Sep 2026 10:04:06 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.84.4])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.35786.1789639439881715627
 for <cip-dev@lists.cip-project.org>;
 Thu, 17 Sep 2026 03:04:00 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=xIAoYTNh;
 spf=pass (domain: siemens.com, ip: 52.101.84.4, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bidp3nV8Fv45uF1mIZ/rZ0aDButMce2PjuLlGq3muOI2lSBiJiZwcOFTq/r+y93fRqKIIzbt3l6YVaZeHYIdXMtIGP10fCh5dGl512foOh8Xp8gAhpwSVfxlJAbpiMdH31BuxXiumM6NhSiP8AVQXEVl0HKL3gIWURPbPZ+nBNLGKTE7kFdkvp0h/OQhZo0XCDpNApEmUvP54dxVTMoyONLBMwl32O1LuUkb+Aov5u/AT9lK6cWPIu3QiG/Ukv2poKIFhZYFrtpSrTNE8GjzQrG8R7Q0TJ2hWG7A8LJiwRF3HfLoDhuVgdTx4fpWFOj8OJdq6qJDPihQotko3YGXdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W+2awR9g5Savnc1ePui+yjwyQdIbcBhRVqwCL1s47AA=;
 b=ZD0a3yo+c40lD0cSQnZA0JwFnJCZRu8YsIdPYzkOKqyM1fTFEd3wxlzGhtlZGIe03bT3yk38VOG0Ee/D6l2Vc0tS5Wn2Pi2pZuEZVPhkrwwdlFRSAyZPf4aGOO2zBQaXcVh6qUwOpv3/KcLloVZnUtpRxPQY2umTXF1qwCo1qbM6pYazws03z265tFiTzMNuD86QMTr5znPlOpy0/vAAMJ2yKSYe+LcIWJgASot09fAI3r+p+rCFehOPdUNK7HP8yW/xXp4g0EhYwznnwu5Wwl7m5oZWRhYJFMcyRM54jvJ1qKBzTwo4+166eRSTNEt1hQMl5BMVX6e57oKKFnXKrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W+2awR9g5Savnc1ePui+yjwyQdIbcBhRVqwCL1s47AA=;
 b=xIAoYTNhdhCUC9VDrl/xKVPfyS973FluODf6IALPzhE8s+c3tWaM/5I65g/ao/zL7ixgUcrqWQmALMLzF/6v+RalnqGKEG3qf/6XoIzPOf0E4HPDmrLrwOcCjdCTy/xp8ehMmeClieGr772q9NXJOEvImDOfMa8Ju0qZQgC/aQX5OUMq9mlD9+kj+wEIRGZ9lP+lYvUbzTLC9AOGTiwI30Frk3Haevl3rpOdax8JJixP1t1UqY1GoblZxkSM5ngYZXPvKAZb6XvRUlaziaM5xqzLbzBMMAJqet9l7vPttjGgLOl+ZYjZnc7hoPhLyEAGrADt5jL/CsCfSTWOb3EKIw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB5196.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:348::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.12; Thu, 17 Sep
 2026 10:03:56 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%2]) with mapi id 15.21.0428.008; Thu, 17 Sep 2026
 10:03:56 +0000
Message-ID: <856c8f37-2180-4a63-9f04-e761d267fae8@siemens.com>
Date: Thu, 17 Sep 2026 12:03:55 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH] linux-cip: Update to 4.19.325-cip136[-rt50],
 5.10.268-cip77, 6.1.187-cip60
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0625.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:294::23) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB5196:EE_
X-MS-Office365-Filtering-Correlation-Id: 03a9ba53-937d-417a-7408-08df14a2fc7b
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|376014|23010399003|1800799024|56012099006|11063799006|10067099003|55112099003|18002099003;
X-Microsoft-Antispam-Message-Info: 
	lxEXDFEtXABaJ3ka/vwVpe/+cF8deSGfvFKv0jQXaqfsMWWsp53qNtWrA0iGqPqJwaVyClXCZxnKKc/cPMSJk6FKmuWE7xL75joufTM1phAYn0w8rGOpGVTVp4wyDVhgQwgx1Us52Z9+pKu+9nTPkBOR7GfiYvqN4YU3ZpdV8JhxlHdn/1ZSmEWWBDIK9yaOP4Gkng521CCF30ktHeiLP27OFEVZqxXWjOyNr1bFGJ+lCEJM8kAQTzSzN6x5E4f3VvdsQNZtnRp1a3KYWh7YEI/FcJ0VAzt9aAAF9u7D+fr6bHcVwHNviHejEmtJLBIHlNbG87a9c0/tABJZ3H5yw/oFY5E8nKof4sV8hzaE7FqIPGpagYotrDnM+xN6pDbbGQUE9HODLuXmdqK/19vsHSHYYyTFEea1hKqcvVsGodLs67GK7w8R2OIS8S5uEc79O2G+qsW7hKl+Kl1JE6y5A//o3PryVqnTevwkftrm8efXiN1x31Dci8qTVfvW/svf8Ottu7duUziFnSJFm4rFu1TvDtSbxNfz3UMocZugC/FnSQ6xDpyNBXyCt6zVyH5ZbSjRWvQH9lNeJrp4jC7GdTI9pDFJeK5UaUm7cMxsBYpCKbDFAzw9KWpo/JhDfqGkZb4Hq81ESJU7PhMERihUpZdSIuEzYcxm2TLuoVZG5PU=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(56012099006)(11063799006)(10067099003)(55112099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?S0J3U0VqbzV0c3FwdkMyRjRJK24yd2RIZTRTSUZxbit2OFFjUDNka2ROZ0c2?=
 =?utf-8?B?cS81Sk8rWmVtc1hqbXdKOEFQUVFERnFZYyswTUNINSs5cHFpN292dUdSSXhP?=
 =?utf-8?B?UWpKd3JNa1Q3UlJweEZ0RTVHd3NhdnhVWTlmQTlXWUFBbS9yamM2SlBZQk44?=
 =?utf-8?B?WUoxQ0ZWQ0JkODQxTXRyY0JNY1NrZWJLeHhGRkJ2SVo4Y09TK0VGK1ZyaXR4?=
 =?utf-8?B?RC9tdnhxY3NuSkJiR2tCVkMzdjN0YXlCVWU0bmJ2MGRDZHlhTEtBVlhpZUVU?=
 =?utf-8?B?UlM2VUZEVE5HTVRiK2RaQi94UFlyTHprUGxmRFlQQS9kYW1HU2tsaEp6dUZh?=
 =?utf-8?B?YUk3cUFUSW83Uk5lYzlXdU5NV1QxNzZ3RmN0TFUzTjNCMlBxL1AvckFvejEx?=
 =?utf-8?B?bFZWbWgwcnNNRlVldnNTRHVsWGV6OWdVVjY1UDVvTHlCbjNmSWpkZEJQZ1VZ?=
 =?utf-8?B?RUFCTjZ3b2NUT2FBYVZXV2RUcDJUUEhESjF4ekN5ejdTd0xaZXA5TmxUUG1t?=
 =?utf-8?B?NmVzVllGNHpmblE4VElsSmp2ckdoeWlaWElNSlBzY1pybFIwVnYvMnpSVU4z?=
 =?utf-8?B?RlhHZHFXeHZjNjNlb0JRZk1pWGt6dTdMM2JMTDBIZEJJK0NGeGYrajlxVWhq?=
 =?utf-8?B?c2FyZHo4dFVkaHhVTUV1cEh6elBZb2tlYzk0M0wvNE90YTZ1cGZhb3VCTkMw?=
 =?utf-8?B?T0ZSSjNWYlRnZHVJTlZiaWgvT2VxTUUvVXAreDB5N0U4WlVnc0JwVzdJVksy?=
 =?utf-8?B?azdJN3lCUkpuRzdveTdyYWN6WlJUUmhHbVlBUVdrb3FPcGpMZFQ5K1pqUFNW?=
 =?utf-8?B?OFFIc2diVjBFVVVYbU1hUWF1SlRoQ2QrdE9NQkNtczFXM0VTRHpmNkFjcktk?=
 =?utf-8?B?QStzRloyeWJuWWtWL3hCR1FZV0ZWVmRKTlRrU3NsTk9Id0NET0NuRHVIY1kv?=
 =?utf-8?B?bkxqQTI3elROU0hnR1piS0YzK08waEYyMWUxOHF1Njg4cDlybVM3YlFoc3FS?=
 =?utf-8?B?dDVuSE1OaDZndlNGdHlJNkxWTnM5QXM3NC9sUThvSmtHUS9Ra0VyWHBycTFC?=
 =?utf-8?B?bTNEVVRYUmcvMFRIaTJnb0ZUVm90d0VPUytLRThjc05kZTE2VXpVVHRZbFdW?=
 =?utf-8?B?ekN1SWFTb2hVcGw5WmNSWGkzQjhRRTh1K3R4TGRDU3dyTnRMN25RalU3MmhC?=
 =?utf-8?B?eERKOExBc3gwREdDaFEyZXJDTDRjakpCWGxNSlIvTFpzLzJxc1Q1YTBqQkVR?=
 =?utf-8?B?K1lyeDNlM0NXOEZySll1aHNHWkZTL25USW81RjdOeDlFZXlDRy92UTFvZDhZ?=
 =?utf-8?B?bnprb0xvSVBrTHRzMjBpbmxZRDVCWWpwV043UmVBSUFCd0lXTXAvOWFtZVdy?=
 =?utf-8?B?M0V6NStFYzlmd2paQ1JOWGxicVhLTDJDaGkvQkE3MUNsZ0NPMXhIc3hxaWZD?=
 =?utf-8?B?VGltUWdqcWpNem9DdlN4RVBXSTFYY1Y0U2tkSW44MCtETERhZU1JZi9VY1Bj?=
 =?utf-8?B?SFBTTTFwU0wzaUFEOFVoYTc4emlwYmdJSDZjU1VIM0tPOUxWdXgrMkhRQUJn?=
 =?utf-8?B?dUF1VVQwVnVtQ3ZtbXFQWHN5dFJEM2RDQUYyYUxienJadnNRRVpRQ3h5WDZ3?=
 =?utf-8?B?OSszUEkxUlJCZ3Evc1BVWWpiNmVNVGhhOTFpRnJFR3BKZ2NnaEpLSEdQcERP?=
 =?utf-8?B?cUlqSm9jTkZubGNCViswQ3B3T0dNVUtDN3JJS0ZTaDRGV0dvUTZjU2ZFRkJt?=
 =?utf-8?B?NEhlN0krUjdrSTBtRk1acnFZYndnRGhXcDFZSWFPckswZWcyaHp2ZGxVVmFu?=
 =?utf-8?B?c0MvaDgwYmw2TFNhcmt2aWxITllZRjIzR0ZFbUxqQTU2WVh0YTRjVURKOExH?=
 =?utf-8?B?RFNLcmdmRTBYbXFCUnFYVUtuWW1rSmtKNWFFVkkrWHVwS3R3YnpaNnJyckxo?=
 =?utf-8?B?NGYrdEZTT25obVVVK1hYdkg1dDVjQWI5WitSdDJFRG1uaDI1RjdpMVB3T3lM?=
 =?utf-8?B?MXJGTVVUY3ZjYnFhMWo2anU4eElYRjJGU2d1MkNvai9FN0U5SUhFVkxOUklh?=
 =?utf-8?B?ZlhVY2g0aDcrbzNyTWFKSWJpZVBpVFFHSFdyYm5lY1ZaRVNRK2JoaG5GSXQz?=
 =?utf-8?B?ZFRZNjZ1cjFVT0VpT1gxdjB3aDE0WkVVWUE2YW1QOWxvdWttM1Y2MExDaStZ?=
 =?utf-8?B?cjFZSXVNNElnWWcrUXljQlRJL2c3aGVsWkZhTzNRbmRjNmM2YlZoQml2Z3Nu?=
 =?utf-8?B?SVZ4L0dXSVBaMnFieC9hVmhYaVJHTVdmVm5OZmxMMUhLTWo1bmZ1eStDWG95?=
 =?utf-8?B?MlRPRngydjRELy9NWkZuY3RHUkN3VXozUjUveEpZNGZNMisrUnBBdz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03a9ba53-937d-417a-7408-08df14a2fc7b
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 10:03:56.4646
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eWFxKIWOuqUp1/q7U2Wgq+AU767ZgiNpVs8jkY9i6yWwYduDZiTYZgz9rBk43GTsENEy315X84Rkg1EE7PF3nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5196
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 17 Sep 2026 10:04:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24220

From: Jan Kiszka <jan.kiszka@siemens.com>

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 ....325-cip134-rt49.bb => linux-cip-rt_4.19.325-cip136-rt50.bb} | 2 +-
 ...inux-cip_4.19.325-cip135.bb => linux-cip_4.19.325-cip136.bb} | 2 +-
 ...{linux-cip_5.10.263-cip76.bb => linux-cip_5.10.268-cip77.bb} | 2 +-
 .../{linux-cip_6.1.182-cip59.bb => linux-cip_6.1.187-cip60.bb}  | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)
 rename recipes-kernel/linux/{linux-cip-rt_4.19.325-cip134-rt49.bb => linux-cip-rt_4.19.325-cip136-rt50.bb} (68%)
 rename recipes-kernel/linux/{linux-cip_4.19.325-cip135.bb => linux-cip_4.19.325-cip136.bb} (68%)
 rename recipes-kernel/linux/{linux-cip_5.10.263-cip76.bb => linux-cip_5.10.268-cip77.bb} (68%)
 rename recipes-kernel/linux/{linux-cip_6.1.182-cip59.bb => linux-cip_6.1.187-cip60.bb} (59%)

diff --git a/recipes-kernel/linux/linux-cip-rt_4.19.325-cip134-rt49.bb b/recipes-kernel/linux/linux-cip-rt_4.19.325-cip136-rt50.bb
similarity index 68%
rename from recipes-kernel/linux/linux-cip-rt_4.19.325-cip134-rt49.bb
rename to recipes-kernel/linux/linux-cip-rt_4.19.325-cip136-rt50.bb
index c22fabc0..6b54d1d8 100644
--- a/recipes-kernel/linux/linux-cip-rt_4.19.325-cip134-rt49.bb
+++ b/recipes-kernel/linux/linux-cip-rt_4.19.325-cip136-rt50.bb
@@ -11,4 +11,4 @@
 
 require linux-cip-release.inc
 
-SRC_URI[sha256sum] = "8118ee6205bea222967d0b453b2512ba783c96fcd27b95823b0167fde7c5d2b6"
+SRC_URI[sha256sum] = "424e3e7f2f6e1282021ddf61ceed8cd71332e33fbaf42868784fe22a780fd82b"
diff --git a/recipes-kernel/linux/linux-cip_4.19.325-cip135.bb b/recipes-kernel/linux/linux-cip_4.19.325-cip136.bb
similarity index 68%
rename from recipes-kernel/linux/linux-cip_4.19.325-cip135.bb
rename to recipes-kernel/linux/linux-cip_4.19.325-cip136.bb
index 4ac075ef..9fb5905a 100644
--- a/recipes-kernel/linux/linux-cip_4.19.325-cip135.bb
+++ b/recipes-kernel/linux/linux-cip_4.19.325-cip136.bb
@@ -11,4 +11,4 @@
 
 require linux-cip-release.inc
 
-SRC_URI[sha256sum] = "6e3e5003854bd28e7f3b4880ab5f779e4e31ac7d4770f2fd1035a9b51c0d53e9"
+SRC_URI[sha256sum] = "9e753afd86e574a8e67cdadbb8cc43ee8337521cd5afaef931c4c217fb2bbeb2"
diff --git a/recipes-kernel/linux/linux-cip_5.10.263-cip76.bb b/recipes-kernel/linux/linux-cip_5.10.268-cip77.bb
similarity index 68%
rename from recipes-kernel/linux/linux-cip_5.10.263-cip76.bb
rename to recipes-kernel/linux/linux-cip_5.10.268-cip77.bb
index a5fd834b..e7207d36 100644
--- a/recipes-kernel/linux/linux-cip_5.10.263-cip76.bb
+++ b/recipes-kernel/linux/linux-cip_5.10.268-cip77.bb
@@ -11,4 +11,4 @@
 
 require linux-cip-release.inc
 
-SRC_URI[sha256sum] = "bd235da3e82d643c4ef0bc71a6d21a11c6ad1c6e644ff625c72ba74daeeb96eb"
+SRC_URI[sha256sum] = "7151537fafb9f395ba41a8ce86b8236b0d2dab9834e9c66b1a12b442aea41ee7"
diff --git a/recipes-kernel/linux/linux-cip_6.1.182-cip59.bb b/recipes-kernel/linux/linux-cip_6.1.187-cip60.bb
similarity index 59%
rename from recipes-kernel/linux/linux-cip_6.1.182-cip59.bb
rename to recipes-kernel/linux/linux-cip_6.1.187-cip60.bb
index 28391df4..d6120def 100644
--- a/recipes-kernel/linux/linux-cip_6.1.182-cip59.bb
+++ b/recipes-kernel/linux/linux-cip_6.1.187-cip60.bb
@@ -7,4 +7,4 @@
 
 require linux-cip-release.inc
 
-SRC_URI[sha256sum] = "d69fded945b0e9e905e3301918802ffbade6d8f3342c571accfe12a066370005"
+SRC_URI[sha256sum] = "b11ba859c202d5feadd8905f93902a2df6a1434c2fff9eb8eb310b8cf969bd74"
-- 
2.47.3

