Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3E7DC4167D
	for <webhook@archiver.kernel.org>; Fri, 10 Nov 2023 18:10:27 +0000 (UTC)
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (EUR01-DB5-obe.outbound.protection.outlook.com [40.107.15.77])
 by mx.groups.io with SMTP id smtpd.web11.34787.1699639818147432109
 for <cip-dev@lists.cip-project.org>;
 Fri, 10 Nov 2023 10:10:18 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=lbEja8zR;
 spf=pass (domain: siemens.com, ip: 40.107.15.77, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UyBDacz3IB0DooP+usNrl8TwG6QfOi/HVXfNUIvEssbko/Ryz1M+t3lnDf00eAGYRunLEjsAUXTKE0gOaZW0qD9eLYaW3mJYyNaEbSo/YtZMBhV0prWmkoy7l41xc/ZOOTiuoRSSDVr9elW0lG/ZIwSIkFZeVOTZ/5qHehZ9IrHKZDBukx751o17dnj9RgzHx8+0bByvqBhKtcyuYX5+pHsKpt/t0MoHxAT+U1nBe1sVSY8X9/GPd+4zDCdKjPwjHq8HSXIWEAqaCRSZHNR+qrGh7xiO/Adexi6K3eLeSXVfbeAG2bHu2i6e6/Cl3WbnFZzJcEoiRo/clh39dLYIYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/WtooWXRptMVIgmJlvrPuTVsKIRxIn0y4aqFoASIge0=;
 b=W+3Un59NNi2U7n0udekFHUgLN8orCATKOJaKcoMN9U0MhN7Got1uZA5FLNKJr9R7MvITZGePZO1hQ5RJCxcfZW5m5UOkC4Gv7ksIS7aI/dric57z6Kz/eaCQECqBxO9Ny+lsGqOgcQFiS5AH2FoCaILCheJsDiTP89L8XYoldDavoDqqVqIFNgNv45IxxpJFcgtpsS7mroiV6LhrWr0Wn+QNQZ32BS0ZPgpzmUv4lQZw3mh0lKKY7+MmF3Om3jpLNNqfL6IhA5AfPCU8GzzgtCFB++TJrfPNFjoimFDkQX3WJLodcIJnkFXKQISCjcvVmokyvz/424rCxzzKdAszQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/WtooWXRptMVIgmJlvrPuTVsKIRxIn0y4aqFoASIge0=;
 b=lbEja8zRtVSyaNDzYYJenPKej+KojTe87byGKu4rB4krqBpt2iJ4LEydFuIfQ8kOcjqVXzsDZwJEr7yI3+5TxnlpgNvpy8zMdnl+coYnmMgXdd2diWZFek6gQ4jPtDA2khSnObqlkvt6eB0QmhYoR5c0VsC+LxR/zfzZDag3j1rQKfA7/dcCHvvlx30WSo0rXdqs6/h7burULXyupZwUrjXXdqyApDs5zYcIncg3UwfCU4GK7iNY1Sljdz52V4Owa0fQIXhRb83mGfYSEaoq6M/5wcDbN2ZrwVWtBvRJoLib4Xx85HM77ezU9b/8TJ4XoCXwj5/PVpMw8cjcY3jctQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV2PR10MB6091.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:af::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.18; Fri, 10 Nov
 2023 18:10:15 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761%4]) with mapi id 15.20.6977.018; Fri, 10 Nov 2023
 18:10:13 +0000
Message-ID: <ff38d8da-c721-4e5f-9dc0-35cfcba542a4@siemens.com>
Date: Fri, 10 Nov 2023 19:10:11 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [isar-cip-core][PATCH] linux-cip: Update to latest versions
Content-Language: en-US
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0183.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ab::12) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV2PR10MB6091:EE_
X-MS-Office365-Filtering-Correlation-Id: 16a4ed06-c663-4922-6023-08dbe2184921
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	2aGQT4N7oXwc7B4HEG+ZrmfIYB95JirwlfbTTinN4zTFRIo663xnPbSqAClHPZ5qLAG4uViqpV7IKjAKGT0hAY/YkSwYqcV7OFcULHx458BB76DjYP3zGdkX0UMP0be8oGkeQ3+0po4YlUtUUYsY5ygW+KwnMjbPf/YWpv4WDOvfK70g3ssa09Ry+pCHEBZDfWCWWuhrUsKMKyYWqWO1Ljm10h+uimNgyygdPdeggK+k+hNwRkLe9b8M7oSSK0A/cPcPZGiyS6R39/aRGsuBSd8Tfp3eicYTa82f6g5TOkIydKgQBGSn6bRez33MXx2Tgz06QIOnquuVTcZIqzHKGeanL46AvkOTKA+pigR+4GERdkHxPNAhcJz4H9zDP2+B2V0gUJH1Yso8JTwJ2icynFe8bVjqngD6h+a/+wYfzZeC8t1vXcAEqU3y0LT+BIrDq+R6bXk0Z2eGQ5TtxwhtqBGwJ8fqG5Sxq3JedAfVNBIpDcPa1Rkcu4eKcWYG7vwckZY5MhvxmpxHaP/52b3yJp2cMi/BeolAMRxQ1wWBJMhEqRQrYNtw7+f1kO1R3oak3U/aiOA52kfyx7K1zK4oSDAzeg50pZgtvOgQJRInOdVE1fQ2ZqZSl10P0TZLGoJjbFm/SQOm91mu0Au3BSQUEA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(136003)(39860400002)(366004)(396003)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(82960400001)(38100700002)(26005)(66476007)(41300700001)(478600001)(6916009)(66556008)(66946007)(316002)(83380400001)(31686004)(6486002)(8676002)(31696002)(8936002)(44832011)(2906002)(2616005)(86362001)(36756003)(5660300002)(6512007)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?QmlvN1dOOXIrR3ltMmRYZEx0M2JKMHRMYVd6a01US1JDVTZ4cjZSOFVTVjRv?=
 =?utf-8?B?OUF5WEhhYk5pM2lYN1pWTTJ2akpZRHdaWVRHZis1TGdJd2FSeG1pNGRBOXlV?=
 =?utf-8?B?RHJLRGthd0hvVEdTNjhwWW5jdUMvdU9nSU43TERPSDJ2eU9lUVVHQVFMemZu?=
 =?utf-8?B?cUxja1Fad1UxUE1MbjVxN2htQlU1ZW5WL0tBNnNLN1hiV1dBNnlLUTB2QVMv?=
 =?utf-8?B?WjJ0cXJOUkRCMDVIVTZYQjR4Si8xQXFsS2Q4M1RvSFlwRXViYVN4S1U4QzhK?=
 =?utf-8?B?TE4rZnd2MnNpNkZJQmM4ZEVWZzZYRERIeER4RnE5akNKdlJLdW5va212Uy91?=
 =?utf-8?B?clhEN1ZLOFNPaENBZGNHd3pyZExjaW5JejJ0RytTYy9NNWpaUEsyZGRpclNz?=
 =?utf-8?B?VlZab2xpeHF6YVlmdUpiR1N0dmlPZFVnci95eUdsdFJpczl1T1ljd2xoYUJj?=
 =?utf-8?B?dHFsSmx5UEZ3N2hiMGFXZFlMSDVLM1RSb1BTbDM1SGtNUWZnOVg4NjZ1aU4z?=
 =?utf-8?B?RUxzYjcxMHNneUU0VXR2VTIxdWN5WXY0N2NSVHdDQVZUSGZueXpwY3FESURt?=
 =?utf-8?B?STBXT2NnZ3RHOTdjdG1RYVcrV3pTQVFJeUVDeEhpUmhqcjQ5N2VZbmt0TEc2?=
 =?utf-8?B?UFlOd2IzN05tRVdxSkptVkRpRFNWTndXWm1KZmoyUVJkMGNZRGNIWnNPVENB?=
 =?utf-8?B?cFlNdFJUQWVTbjRmSVo1Q0srYmN2U1ZXVThCU2lHL0k2NDB0OFp5UWRsbDJk?=
 =?utf-8?B?Y1VIeEhsQXYzZDFaRUxzcUFPWEFlY2pybVJGRjFXOFU4RlpjR01Vd0tmZlBz?=
 =?utf-8?B?ZEJTR2IzUmo2V05HOXhmdzBnRERsbWI3TDFHQkxUUXpqc0R0eFNVMXlITXlN?=
 =?utf-8?B?cFBRYUFsRmdxb1ZDRURzcERDOXczSkxWWVovZWw0WDRaSk92ZUk4UDByeUxt?=
 =?utf-8?B?cnBMN3M1cnppUCtIenlzYUd3VGY2bDVSK085Q25VbCtRV3pMLzYwL3cwSTlH?=
 =?utf-8?B?VjNQR2poN3Rjd2RhQXBiTnVtY1A5UHF2bWZTVjV2VzhyVkMxMDZZUzRQSDQ2?=
 =?utf-8?B?Wno4N2lncFdJeTJ6NlJaK0VUcDlFSllBODZQWmNHTEtPSjBjSTFWUk1zQml0?=
 =?utf-8?B?cUV3ZUljc1QvcHl6TGx0bjJFY2wwVjN2TkxUcFBxeGlPSm5veGpFaEhHZ0lq?=
 =?utf-8?B?N0kzSUVkaDBQbG1aY3FhSVdMUWNoaUpYZGhBL1RPZXdpSVQycit1NW5VTDVl?=
 =?utf-8?B?V3MzelBoSUliNUU4cXFNUi81QlkwM05oYmtRWEd4QlEreUtxeFRuVXZmS09C?=
 =?utf-8?B?MEgwMHhNTm1QZzlhcU84cmJPNk91TUhSeDNTVTZvcFFaM1dTdHhMYi9rTjRM?=
 =?utf-8?B?cEJ6U051b3hldlBnTEV4VmdIS1hxOGlzNGNPVklyZUdzYTNSVTBya3A2Qms2?=
 =?utf-8?B?OWtCS1VRdU9TRE94OFlTUkk1TzhLQ0krd1R2SVJsNjVZTk5LSVd1anFuMmhI?=
 =?utf-8?B?YUpCTjNBSVozdXRtUWJDTDJ4dGh1ZW1MY1VWdVpOdXR2Z1dNQ2dpbEdmZGRp?=
 =?utf-8?B?K0RhY1pNSDV6S0J6YnFTSHhIVnNXRmhlMFpwSjArbGhFY0RVWTZPK0NVV0dx?=
 =?utf-8?B?d1B4dG15SVdFSjRQc1F3OHFDRVUvQlY0MzF3TW1QYXEzMk9zTFUvczdaQWc3?=
 =?utf-8?B?M3I5MVV0VitkZ0FUVkNuM3JaWGpyWXp3UkFTOWUxQkdhWkN1V2M3dmlFaU9Y?=
 =?utf-8?B?QkdreWlCWDNPWDJCd1BGeXZ2NW9pTktYV3ZTVnFzTUcrVDdIRjVSaXpNU1Nr?=
 =?utf-8?B?cVdqU3hhVktjdVNFQUZBeWxjYmxVWFBWYktrT1R4R1FPNUY3eDdURHV1bEV6?=
 =?utf-8?B?YW85U2RzTWJPZlU3R1orVkF0b0FhQXpOTm04TVFQV1FQUmUxNEV6cU5GZE1T?=
 =?utf-8?B?bUJmVlpUYWFkajFCaUJEelprTkVFamVVd0hyeXhGTjhSTFJKZll0MmpvTEtp?=
 =?utf-8?B?bUt6U2sraHBHOCswOTFtZDFCeXB1V1RTallvQXdPYm5ETkM3azIxdlJyZWdw?=
 =?utf-8?B?a2xQNU5EZllZMWtqMFRiVFh4aC9JNGhSdENYemlFZ2ZvTndNYkUrV3RiZHNH?=
 =?utf-8?B?ZVFrTnllRWhERDRzT09Da0RVTUY0cGZ6MnhCeU1TRDlsYnc1VlJVY3RtSHZl?=
 =?utf-8?B?TEE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16a4ed06-c663-4922-6023-08dbe2184921
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2023 18:10:13.8272
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3kj2kIbSXAKqp81emAiEAtpqusm93pjvr7Tcs/MARL5a/mIVQ3XjfATix8h8pDzK8nOTIqWruHiyabp3HZ8riA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB6091
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 10 Nov 2023 18:10:27 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13568

From: Jan Kiszka <jan.kiszka@siemens.com>

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 ...ip-rt_6.1.54-cip6-rt3.bb => linux-cip-rt_6.1.59-cip8-rt4.bb} | 2 +-
 ...inux-cip_4.19.295-cip103.bb => linux-cip_4.19.297-cip104.bb} | 2 +-
 .../{linux-cip_4.4.302-cip80.bb => linux-cip_4.4.302-cip81.bb}  | 2 +-
 ...{linux-cip_5.10.194-cip39.bb => linux-cip_5.10.200-cip40.bb} | 2 +-
 .../{linux-cip_6.1.58-cip7.bb => linux-cip_6.1.59-cip8.bb}      | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)
 rename recipes-kernel/linux/{linux-cip-rt_6.1.54-cip6-rt3.bb => linux-cip-rt_6.1.59-cip8-rt4.bb} (59%)
 rename recipes-kernel/linux/{linux-cip_4.19.295-cip103.bb => linux-cip_4.19.297-cip104.bb} (68%)
 rename recipes-kernel/linux/{linux-cip_4.4.302-cip80.bb => linux-cip_4.4.302-cip81.bb} (68%)
 rename recipes-kernel/linux/{linux-cip_5.10.194-cip39.bb => linux-cip_5.10.200-cip40.bb} (68%)
 rename recipes-kernel/linux/{linux-cip_6.1.58-cip7.bb => linux-cip_6.1.59-cip8.bb} (59%)

diff --git a/recipes-kernel/linux/linux-cip-rt_6.1.54-cip6-rt3.bb b/recipes-kernel/linux/linux-cip-rt_6.1.59-cip8-rt4.bb
similarity index 59%
rename from recipes-kernel/linux/linux-cip-rt_6.1.54-cip6-rt3.bb
rename to recipes-kernel/linux/linux-cip-rt_6.1.59-cip8-rt4.bb
index 0738ba00..6385b023 100644
--- a/recipes-kernel/linux/linux-cip-rt_6.1.54-cip6-rt3.bb
+++ b/recipes-kernel/linux/linux-cip-rt_6.1.59-cip8-rt4.bb
@@ -7,4 +7,4 @@
 
 require linux-cip-common.inc
 
-SRC_URI[sha256sum] = "8b578b83e7cd18c4649162d0c734e6af5c080f429f8636817ee402e195a4bdfb"
+SRC_URI[sha256sum] = "8c8a68cf3bcbd6fcb126fbf9ec2c70dc125cbde9de5d864c0c36195449354f59"
diff --git a/recipes-kernel/linux/linux-cip_4.19.295-cip103.bb b/recipes-kernel/linux/linux-cip_4.19.297-cip104.bb
similarity index 68%
rename from recipes-kernel/linux/linux-cip_4.19.295-cip103.bb
rename to recipes-kernel/linux/linux-cip_4.19.297-cip104.bb
index 366d301b..fafffe21 100644
--- a/recipes-kernel/linux/linux-cip_4.19.295-cip103.bb
+++ b/recipes-kernel/linux/linux-cip_4.19.297-cip104.bb
@@ -11,4 +11,4 @@
 
 require linux-cip-common.inc
 
-SRC_URI[sha256sum] = "5b746623483df76fbe83800a3854631d2311cf5679f2207b1999fdc0e73c34f6"
+SRC_URI[sha256sum] = "264b20398fcd0f65ea27f16a7625314de1ec790904626a4cdc2dc44dbdeb973a"
diff --git a/recipes-kernel/linux/linux-cip_4.4.302-cip80.bb b/recipes-kernel/linux/linux-cip_4.4.302-cip81.bb
similarity index 68%
rename from recipes-kernel/linux/linux-cip_4.4.302-cip80.bb
rename to recipes-kernel/linux/linux-cip_4.4.302-cip81.bb
index 7ceb68d4..cf538e99 100644
--- a/recipes-kernel/linux/linux-cip_4.4.302-cip80.bb
+++ b/recipes-kernel/linux/linux-cip_4.4.302-cip81.bb
@@ -11,4 +11,4 @@
 
 require linux-cip-common.inc
 
-SRC_URI[sha256sum] = "f0276dee4e4154003cf73bd9c515e437d1d5f79d6517d54689ad997d7c10ccb9"
+SRC_URI[sha256sum] = "bf7dd204035e2924f877c879683605e00d31ec2f38a0ef03d764d05263404c34"
diff --git a/recipes-kernel/linux/linux-cip_5.10.194-cip39.bb b/recipes-kernel/linux/linux-cip_5.10.200-cip40.bb
similarity index 68%
rename from recipes-kernel/linux/linux-cip_5.10.194-cip39.bb
rename to recipes-kernel/linux/linux-cip_5.10.200-cip40.bb
index 82f7e15c..20c1d178 100644
--- a/recipes-kernel/linux/linux-cip_5.10.194-cip39.bb
+++ b/recipes-kernel/linux/linux-cip_5.10.200-cip40.bb
@@ -11,4 +11,4 @@
 
 require linux-cip-common.inc
 
-SRC_URI[sha256sum] = "39fa92032d1c5abfd6cc2a04d3dd4a5ab52df7b92a18bb63a3f4424e3c2d9c8b"
+SRC_URI[sha256sum] = "bf0d4f4a745fedde8797c4c5803a23d07fd6142b515f9b15486838d3431a0849"
diff --git a/recipes-kernel/linux/linux-cip_6.1.58-cip7.bb b/recipes-kernel/linux/linux-cip_6.1.59-cip8.bb
similarity index 59%
rename from recipes-kernel/linux/linux-cip_6.1.58-cip7.bb
rename to recipes-kernel/linux/linux-cip_6.1.59-cip8.bb
index 823ebab9..b8396d8d 100644
--- a/recipes-kernel/linux/linux-cip_6.1.58-cip7.bb
+++ b/recipes-kernel/linux/linux-cip_6.1.59-cip8.bb
@@ -7,4 +7,4 @@
 
 require linux-cip-common.inc
 
-SRC_URI[sha256sum] = "a83dcfe35b65485f9f433e0259dc3863ee5948ee425f15268069a60472d3c53d"
+SRC_URI[sha256sum] = "bb6e346dfd61f2ad36fbbcc3401cb5da6519ca1c9e0222096e86fab7c203bbb9"
-- 
2.35.3

