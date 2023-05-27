Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6223C77B7E
	for <webhook@archiver.kernel.org>; Sat, 27 May 2023 16:47:41 +0000 (UTC)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (EUR03-AM7-obe.outbound.protection.outlook.com [40.107.105.70])
 by mx.groups.io with SMTP id smtpd.web11.13755.1685206056120677297
 for <cip-dev@lists.cip-project.org>;
 Sat, 27 May 2023 09:47:36 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=clWL8Db7;
 spf=pass (domain: siemens.com, ip: 40.107.105.70, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WeTjdrO7IKvYM0KBSuwJlnGxeqi8gxKcL9xAcNUkXf2r2fhiCKflnPjFXl/nNzPPovaqIvHeluXkcjbWUxTARa+DwcOlsl1oWGrBx2r7J3lKOGpAhGl/ZkzPFtPPZ9/YHB2vPmG1NDDDuN7EMJWISNCyffqzhezfNwoFEdqJsLbsYKLTAq7q/dVEjuO0wfQN8EME25F21ptAm7tDubpXwy5wUIuuRVfTdvUbJFzoLDO+DK7WmO/cDmZPfI4aFUmmRTRHSjHl2KhU4QWcQEvVRrOfhiun4Rd74CgJYd8gw3+nX3kG/YFTzuCi4piQyij9D19lGGEZBaUOfJFyzBuQUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mIl27Zs1dnvubWDbIN4SWY5eYUErYoAmZqwv+R/au0M=;
 b=NNuDDOtSyptp3sX6KiUCFdDyjg/kdjdzKxVDRqV7JwKAaiz0AOlnRLNxsJ16IFeqRk1lkVuIHwp+GQ/TCvBsEnToIle7W4T917832RR2UEZBlXl+yYdU5pbtqOwdQRWt9KJflVFEhI7zbzpBxSLNNe6RV1Rq8gPJ0ex8W2DK9QMZg4RrmH/JkpzmhRVBDdqpWxwANCkN1RabJTspcNP2jfq22Ejwo0T6p7KhGiVVgQf3fZmFs3pdriMcKluDFPBmQr3Q5behrJjfNrw/lmBsCfENO7rWMfsyeXH0G272wsoRsBYaoljvxwq1PPAtCWiV0nihVBTJux6+VMfM9NNRIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mIl27Zs1dnvubWDbIN4SWY5eYUErYoAmZqwv+R/au0M=;
 b=clWL8Db7xPzaElK7zVoY3IMwfON/hW8kIW87o1porzWSSPkvFR2n8MbEdgVpG0NtZ3CpS1yYYCKm/30r+AnRTtKheUDdgghLqq8R76IBJVgyvI9dGQrsbyr86Wae5YhiM83hVYK7xK6mRn1GmDXDuHlsWGZQzsOBGvAW3Zp3SMDejfNszu1sSXPnOZQ2zc2zJOl5ZRIAg6EeViDESpE+wRZV5yPTbbB8U3Ef35IywWPt7rGAGqJpDT2nRwSd6eZVRTUrLH1vySkoHDa8iejOCASs2M8CaFekBXK9HlAykWvWSfiMGHLm0+pnj4CPU2QoG6Ja5bHsBhklsZ+D6EOZ5w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAXPR10MB5589.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:241::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.18; Sat, 27 May
 2023 16:47:32 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d638:8333:21fb:5f18]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d638:8333:21fb:5f18%7]) with mapi id 15.20.6433.018; Sat, 27 May 2023
 16:47:32 +0000
Message-ID: <46e8b3a2-128f-c63a-cbfc-6d38a1792a35@siemens.com>
Date: Sat, 27 May 2023 18:47:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [isar-cip-core][PATCH] squashfs: Fix vardeps for SQUASHFS_THREADS and
 SQUASHFS_MEMLIMIT
Content-Language: en-US
To: cip-dev <cip-dev@lists.cip-project.org>
Cc: "Moessbauer, Felix (T CED SES-DE)" <felix.moessbauer@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0124.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:97::13) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAXPR10MB5589:EE_
X-MS-Office365-Filtering-Correlation-Id: e5d2ae6a-986f-40d1-c751-08db5ed21074
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	gWVX+SAz31KuVwwbBJ5j9KT1DljLACE5Pthzgn5Qu/WwAz6vvVe/8OzLr9OqaVA+/0a9Z7A3TlALmg4Ps7NYHm3t2H0Mthha2/yzE5+nX3+465QyJ+I3WXzmskLcOPjlSTgMAelEB75gsIRPL7eXJnXt/En0f3Xs28RaKBXzxlkliCZ9DxRAO9dCpSVJ7laXkb/bKdvRSnhYd3E+M6U4Yzz/A9xQN/HFy9L9XKo9gzQubT4P+h09CJSKOKkb34MyOvPzp5s14j3Ya2ggzZ8BL/jkOgkzBsklgOVrJqepCjr3gJRJAlLd20KJL22GJENlmCbMYD89DP1/6iBk8RV1qe5ntq6FChBY/vairNCJutJ+4ebjF3psFnokTGAIURSZpQjXkjyTuB4Y2v4yDT7EtQ5bV4b3iJW7yLVsH5Eo/SUT5N3laWMb4qJ6iblOumcXwEvCnDV3HSgrz20loEyc47QIejRvh+5srctpuRY1BSppAr4P4wBP9x88CqEOwc95qOmKvSt/sYx+zDzZTWE+AjzBLAQtjkwxvKVuz8viKT87H2Utf4iQK7vwA3+52qORejxUw4WvhO5X/dW9TkLqHRcxgZYcxUq+CI+BIM+9PqxAqB1rgA3L54UJuYl53iFq+ZNR4+j4NR9Vm4wwolytSoXFdwiO0VHndRvcLYE6g6VOJpq0nGQgNWByL7Z+rg9pLiAkfNchaAEutos5tRMmPQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(396003)(346002)(39860400002)(366004)(451199021)(5660300002)(6666004)(8676002)(8936002)(82960400001)(38100700002)(2616005)(31696002)(83380400001)(86362001)(6512007)(6506007)(6486002)(107886003)(26005)(186003)(478600001)(66476007)(4326008)(6916009)(66556008)(41300700001)(44832011)(36756003)(316002)(66946007)(2906002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?bzc5b2xOM2FzbnhUMmZPK3JHUk5FTkI3ckFSUFN3VFZXZmFkSHAyQ2ZtYUNk?=
 =?utf-8?B?bnRPMVFVeHlDQTJpRDJCc0ZiWDJMdm05Vjl2Q0xpWFFOMEhQTnZkK2ZBUVlD?=
 =?utf-8?B?eUFuRXVPM1FWUHYrUE9Tem81T3l0dGQ1VXB4ZHFuVE5YekRZdTQ1ZjZkbTJ4?=
 =?utf-8?B?LzUrWDI5V2ZXZmNiek5QSlRHcmlpZ05UTERLOURWQlFmaVlNMjNURHorUTBv?=
 =?utf-8?B?TUFzRXNWU2pLUllHM25nMDhrTjBGeTlJNjI2ckhDbDhWVFFvN3B6K3lhcEtm?=
 =?utf-8?B?eVYxUWRmOU9zOEt3K0d4RkM4a3loamZ0bG0za3BaVjEzU2NIb1FScThZdW9N?=
 =?utf-8?B?YmxHSWtRNTdCTGZpbUtiUjBKVGcrdUpQQytEWStkTGprZXdyOHdlMnZRY1FB?=
 =?utf-8?B?cXpZQjg3V3FBK1QvUDZMY1g4RlJ3aW9BR1p0TC9rRXBuM1pUK3RsNTJ4Z2tH?=
 =?utf-8?B?SVk3R055bXN1bVZtNnFRTERjbi9kUk02RFdnZXhWNElSVmgxTGt3QThDMnFD?=
 =?utf-8?B?a0F2L1o1UWpuTytxVmNYRkhoWTI4K2lwOEc0WEZ6bXRwbjY3aEFHdmhlM1Rv?=
 =?utf-8?B?U2dWenV4OFBKeTAvZGh2d0NFNFNCODYwWisvRGV3cFI0YmE5ckl5OGRNcFBl?=
 =?utf-8?B?VksyQWtmZkMzWEF5RHNxVjNodUZ0RW11cXR5alU4WFlQOUNVL1JvbUxaejZC?=
 =?utf-8?B?bU5lMXhpWFRSTElrendxd0dkTVRxcHUyOEtkNUw1UmhOeWU2RHEwUUI3Uyt2?=
 =?utf-8?B?TStKUFl1dkYwcGdhYUdLNVArd3VPb2V5REhyeEYwWUtFYi9adDA2VUtibHZ1?=
 =?utf-8?B?VHhqVVZwRlJGeUdOb21hZm1DOEZwTmRaT1NMT0dpNmFuSkZSNnZHdWplQWtv?=
 =?utf-8?B?bXJqR1REUzVsWEtqeC9ua1p5MmFpMHlJRmlHQjIzS2lDL2E5bGJ6UnB5a2l5?=
 =?utf-8?B?bzR5VnB5bGdaSkVTc3U4U29Nb2hjUEhDZStHbUVIeGdlUkZxOXhoYnNiankz?=
 =?utf-8?B?TGllU0JZanZmNk5yN2pDS2d3dUdIT2xXQ1E3OEJlcjRkUlBiK1BVN2pMSHhM?=
 =?utf-8?B?bjhNcHpXYWZIekVwbHE4MWdweFNnVGN4SWkwTXpYOWJGcWorQ1JBUnN2ZzNx?=
 =?utf-8?B?cjZiQ0Z1a3E4VVNXb1M1bCtIcndnZ0FPdGE0VEgrbTUzdWlvMmhNNDVwQUVK?=
 =?utf-8?B?WlpXeHdoeXlKUFVvVGk1ajFuSVE1L3pvNWFOemJoUlZpRUkwN0QzSW1HMlJ4?=
 =?utf-8?B?NDlxbjNzcWIvQmtKUGlWRVlvTGl2ejE5VUhQZ1Z4VEhhbno0WTB6ekw1QVlq?=
 =?utf-8?B?aENqNTQ3cmRQYzBhTHgycVVzSVIycml4WjZlK3pPT2JTbitqN2Z1OWV0Wm5r?=
 =?utf-8?B?YzRhZ3pVdGZSbmgydUxxdHdLOGdmaVVlbzlBQVFZZEJNaVo2c2VYUXVmejI2?=
 =?utf-8?B?cFVFK2hGeWlUVjZ2a0NQWVlQblIxTGpIQkNBS2NJNFpyMW4yRi9qUnc1TXVG?=
 =?utf-8?B?NHBLT00xckZHb1BIbzU2TlU4Qis2MjBWMjJxNXpVNGVaalZRdS9KL25PWkdx?=
 =?utf-8?B?b0NPL3RTeXRhZ1h3UHQxamJXNUJ1MEVzMzJORDB4dzBRNkpQZ3BndE4rUVQ0?=
 =?utf-8?B?V2R2YTU0dGM3dFU0dkNTMGNmVmY2YnZDS1lMNW1mZTBMVjB1ZTAwSkd1WVNR?=
 =?utf-8?B?ZHRmeitaczhpV3RoNitNNzFqY2VyM3NTWGFnUlhnZHNNb1ZnTHpzekNVYVZL?=
 =?utf-8?B?OVViTFhrNURMd092blpPenRnV0VBbEdPRzAwaW1XTnFUNXZQUkxycGFjeGx2?=
 =?utf-8?B?bVNPd0htaEorVTg0UnNnZVZZa2JLd0pQa3RCOWhrWUtLZmdZL2pyN2tPZlM1?=
 =?utf-8?B?WFJMZjJQVHZUUlVHKy9wZ0R2TjNETUFKdGgzR0R2Y0RxeS9UVU1CMU1QVWJ0?=
 =?utf-8?B?WEgwazdMQXFuWkdML3B2NjJ5NFcwcHRuc2s5UnFHVnNabWRYeWlqTnNiMHJV?=
 =?utf-8?B?UFZHdjlzc2VkeVBpaFV6di9NNW5QUW5OVkg5MFRwelUvTGdjbzc2RXdtYm1H?=
 =?utf-8?B?VVhjSzVaYjZOTU9WM0xqZnZHQ0NBYkIxTnBYY1Ztd1hOYzI0SVQxY3Rkb01O?=
 =?utf-8?Q?HUUUQ2r42ASPCSLEmdi+Lxbpj?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5d2ae6a-986f-40d1-c751-08db5ed21074
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2023 16:47:31.8180
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TMrfnD3kuZGR4+hwHHV4HGh1uvtRIBmsMeF1cF5fiebdnt/U4GZZ+t3SpGrhMDu59o3+Yg1wY+f+WGt0I55quw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB5589
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 27 May 2023 16:47:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11664

From: Jan Kiszka <jan.kiszka@siemens.com>

While SQUASHFS_DEFAULTS was decoupled from its potentially unstable
inputs, SQUASHFS_THREADS and SQUASHFS_MEMLIMIT, the consumer of
SQUASHFS_DEFAULTS was not. Rework this moving the vardepsexclude to
IMAGE_CMD:squashfs. This also obsoletes the related vardepvalue and
vardepsexclude for SQUASHFS_THREADS and SQUASHFS_MEMLIMIT.

As we are now expecting only generation limits via that ignored
variable, rename it to SQUASHFS_CREATION_LIMITS and deny overwriting.
Only SQUASHFS_THREADS and SQUASHFS_MEMLIMIT are supposed to be tuned
to the build environment - if at all.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 classes/squashfs.bbclass | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/classes/squashfs.bbclass b/classes/squashfs.bbclass
index b14768c2..1f2a7595 100644
--- a/classes/squashfs.bbclass
+++ b/classes/squashfs.bbclass
@@ -1,7 +1,7 @@
 #
 # CIP Core, generic profile
 #
-# Copyright (c) Siemens AG, 2021-2022
+# Copyright (c) Siemens AG, 2021-2023
 #
 # Authors:
 #  Quirin Gylstorff <quirin.gylstorff@siemens.com>
@@ -16,11 +16,9 @@ SQUASHFS_CONTENT ?= "${PP_ROOTFS}"
 SQUASHFS_CREATION_ARGS ?= ""
 
 SQUASHFS_THREADS ?= "${@oe.utils.cpu_count(at_least=2)}"
-SQUASHFS_THREADS[vardepvalue] = "1"
 # default according to mksquasfs docs
 SQUASHFS_MEMLIMIT ?= "7982M"
-SQUASHFS_DEFAULTS ?= "-mem ${SQUASHFS_MEMLIMIT} -processors ${SQUASHFS_THREADS}"
-SQUASHFS_DEFAULTS[vardepsexclude] += "SQUASHFS_MEMLIMIT SQUASHFS_THREADS"
+SQUASHFS_CREATION_LIMITS = "-mem ${SQUASHFS_MEMLIMIT} -processors ${SQUASHFS_THREADS}"
 
 python __anonymous() {
     exclude_directories = d.getVar('SQUASHFS_EXCLUDE_DIRS').split()
@@ -35,8 +33,9 @@ python __anonymous() {
 }
 
 IMAGE_CMD:squashfs[depends] = "${PN}:do_transform_template"
+IMAGE_CMD:squashfs[vardepsexclude] += "SQUASHFS_CREATION_LIMITS"
 IMAGE_CMD:squashfs() {
     ${SUDO_CHROOT} /bin/mksquashfs \
         '${SQUASHFS_CONTENT}' '${IMAGE_FILE_CHROOT}' \
-        -noappend ${SQUASHFS_DEFAULTS} ${SQUASHFS_CREATION_ARGS}
+        -noappend ${SQUASHFS_CREATION_LIMITS} ${SQUASHFS_CREATION_ARGS}
 }
-- 
2.35.3

