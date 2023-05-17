Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61989C77B7D
	for <webhook@archiver.kernel.org>; Wed, 17 May 2023 14:42:40 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.40])
 by mx.groups.io with SMTP id smtpd.web11.52027.1684334551103400626
 for <cip-dev@lists.cip-project.org>;
 Wed, 17 May 2023 07:42:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=ka4mb6Gj;
 spf=pass (domain: siemens.com, ip: 40.107.22.40, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i5r8EEiZPtl/RueWPSUdQqsjoiauSGDbAO36fCRXPccZngQE0Ny8z4e2d2unjjqPgeBdJZhquKNOUSVNPe2yO5ksHtcAMmd183bMY0rhQqoKE5kuJW/Lu2d+EGSyFipkR5BkuRVHWLunvZI7IemJCMMbDVyptSqzHq3IfLroZty61SfKsJJTp62ZrGED/8fI9L0fwwJdtydGTfRwH4i1N1Wo6dXQiEg0ADUbS/v+v566QTOOglAs6T1Po9yrOdP5ReJy1xqITxu6XbcNZQADwVGiq7xm1jY2XHQSS1RBp7Uhc1SuVcQ8pJA7dDp6gNfyeC0gYXjsYdOnCTrngXmTbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bl91eeK/gIz9ZCbWbGOIDsMx+OTfky8sZwlUSHaXgzY=;
 b=S/kcDesfb/+T80BMGqTymskJhQqP5FVDSb8DMUKIwvsjmYgygJMDAPdu7pF7vW1KYmosDZxJYofh+trLSIJkQjR4og+hUeqdilcQLDQ/+oAwb5EN7ZRHK9fBuxwfVOIZcENkU5uSEB8sP6zL/kpBccqysOdj3XZbFiFUP9mSHQn5kjypDcF7u3MVh/I4UwyT7U/fs62dtWn070hv2LWIDGwVkdJ2U7iNNf4Ib9t6b6GYSobtDWQA25uWjytMUMP/MEm0irbsGy15mW5v2HeYnj7yUGqcpkT335PyhhPYVSqZlfZwcxnOb/ME8yIAQXtGEt5z+DX5LJRwsClK8qEINA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bl91eeK/gIz9ZCbWbGOIDsMx+OTfky8sZwlUSHaXgzY=;
 b=ka4mb6GjVxsUIe8DjPW/xbZ+SH3AW7NeffExyW5zdlr4FNQuaRCg1QH1oP9hlKRFl7ks4raIaWZ2UdbpbWSSAWTeAKB+b554EivYDhD8Ba8oTaVQsnHLDIrBf8UF3N7q1xnpFyRwnC34qOQ9mgIaK1uzQ+0JVLiC1oy+/iBWECpwiQBuiorzg5sh3RrvRH6sr08PE0jwhgo7TJ2X5w3Ir2MQ44/wZdDO57/9kskgn55CXP9h2zaMTYwf0WntYUOFZqeoVCfqbya2rrdF9UN9qwNiEzHDsPkoxxPpNFVn8k8j9c3KYft2KfV40ZT5sJkgrcKZRUy9e8BG3IiFoF5gcA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV1PR10MB6328.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:60::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Wed, 17 May
 2023 14:42:27 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d638:8333:21fb:5f18]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d638:8333:21fb:5f18%6]) with mapi id 15.20.6387.032; Wed, 17 May 2023
 14:42:27 +0000
Message-ID: <a14d7ef0-78bf-13cf-c477-d84529c62c45@siemens.com>
Date: Wed, 17 May 2023 16:42:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [isar-cip-core][PATCH v2] linux: Factor out cip-kernel-config and use
 it for 6.1 mainline as well
Content-Language: en-US
To: cip-dev <cip-dev@lists.cip-project.org>
Cc: Srinuvasan A <srinuvasan.a@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0027.namprd03.prod.outlook.com
 (2603:10b6:610:b0::32) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV1PR10MB6328:EE_
X-MS-Office365-Filtering-Correlation-Id: 082eb66d-ec58-4ee8-c694-08db56e4ef3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	RhHkv2nZ12vMk20GzaMyf31McL2dXZY+fgVQ8+AN3IjNYUziHU9q/Q9/t0B15vexqEwj8KVXFKDF+Zgfy0+eO2QTQrLr4sDotSsa9fGsjBcCumQwTor38p2eOH5AgS0sVyogq2YB98QEZgpnYKFzOulPNTUIfRC2642Z4gxDG3tX6Do76groqwt8syU2j/hQR53FDrdw3bH/evDt8GI4VoBlKfKSCSvOTbjt1/FhsXPoDt6d1jgP8jL7jkh08viceyjt0nBozuynH5LOiK6UAE6Ditx5CayDomBwFn0+upt4RysqTJR5w2mHc8QUPQq/k14YriRnCu+1q0gmOh6SDp8P+VL8ZMzxcF6fN1FZYnIwSXaHox3J8nbpCXwEFl4w3575T1lpjj/gGy0mkOzsY1S3zsQ6Inig1wlhehAsrSl6j2zn+eKMfV05q/OucwuFA7TAw/uqQ7+oAjh9vqOavzuTbR2zyB/eYxYEcqdTV7a3uUgg0wUIyOWK/0NpDe1xRbDDmX+j8ciNK+fajXsUU4wx+AgeU/SVN7f9fTS5LXjGSLgVfS+pDY+SmnPw5yhSFVQXojuGLLyWZu/bpPwgVJghBNlBXl1V8MNcCa+rz0MPpEZeSJbtv65L5tCEx7QpGwqFGuJpRlzdqkfuAsC24Q==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(366004)(136003)(346002)(376002)(451199021)(36756003)(86362001)(31696002)(6486002)(316002)(6916009)(4326008)(66946007)(66556008)(478600001)(966005)(66476007)(44832011)(8936002)(8676002)(5660300002)(41300700001)(2906002)(6666004)(38100700002)(82960400001)(6506007)(26005)(6512007)(107886003)(83380400001)(2616005)(186003)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?SWFaY1JZV3FFK2xhK1o4dlFXd3o0alZpMWJVbFdjdWo0dnI5N3hZRWl1TkZm?=
 =?utf-8?B?RlEzekYwVnc4cEpaekN1UmNWQkx2cTNBU3VuMzg0TGZPVU15N2pKbGgrTGlQ?=
 =?utf-8?B?NXI2ZVNmYUk1UDFuSU0yeVoxc01NSzdBUmEyVXR0a3BReE9vSkZtS05TYXBL?=
 =?utf-8?B?MkhQbk9La3pNN0VvR2NyRU9nc1pQelV1eVFoWFBCUXZiRWw3TlhXQUhmQkVX?=
 =?utf-8?B?Z0hTWEh4aGNVcHpHQmVQRVpZaFhYNHF5RUsvcGhMVVoxaG8yUTZUeklRZGth?=
 =?utf-8?B?eTEyMHpKTzViZDFmN0VQK3hUSmxFcDlrSXM2Q1R1RUlsYlpERjgwVmxRaGZW?=
 =?utf-8?B?dVV5WmJJdmljalNsczM0dUFLZ2pVNHVpUXpFNGxZQStLNTVVQmRMeTkzSVMr?=
 =?utf-8?B?SVhUTXdvNWpQV3JhRmFvaVdwSG9KU2hWY2N4QzB2M2sra2tLeVFrRE84M28r?=
 =?utf-8?B?SmxPb1lSUnR5R3U5bjhOejltQ09FQU1IcWl2bUpSWVBKRjJpdFZibGRNc0tG?=
 =?utf-8?B?dFVaVjViQXNtMisxU01GVDd3ODgvNm0zcURNUmlJWGxsNTU1bDdrRWFvWVRZ?=
 =?utf-8?B?bHVZcmsweXhLM0VpazhVcWlMdy9GRjFTNGR4eHdZYTdBcGdVQkwxVDJTQ0pt?=
 =?utf-8?B?SktxWk9oZGdvTlJpb0trQUx1U1JEcklMSGt2VFVkUGZTOFVNbXFMdHl5Y3RF?=
 =?utf-8?B?ekFuT3JxYVJ3L3ZDMlZhcjd1OUR2YXRLbmlBOHkzS0ZGdjV0SG9rWTNVVlBK?=
 =?utf-8?B?ak1zQ2RxTVRQZjB3UlF4TytkQ0wxKzBWZEhURHhJQ2VrUTh2SzJwOXY3eWhY?=
 =?utf-8?B?SWxFL2hVN3JDWG0wZGF0c0JTM0dvYzJ0UHUrcjV5NC9XTFBrRll3dHNkVHdy?=
 =?utf-8?B?cWZZNTJacFYwWHVWRzFiRDRrR1JML3NZTUt5Qkc0YkFLTHdkRWNwU1hRTDc4?=
 =?utf-8?B?S0xUZ0lpQjdwbEFjQW9Ed3V6ZTVrdTVrUHNYYnpRT0dtbDFrb1YzakZFZHR5?=
 =?utf-8?B?Mm5NZTdFYXF2VWwxYjJVS1YweDlsNnF2UzVIZUVXc0poNnhUNHlpOVk2eWVl?=
 =?utf-8?B?MkEyZ1oyRkJGckVQTU9WVGNEU1U4TnpSYW4rV2xCOHMybkVMMER0cnBqeWFR?=
 =?utf-8?B?c3dJRVdyUS9nc0R5SytkSkpxUnkremg0cVllRE9HOVhLSmQyay9SOTdBNmF2?=
 =?utf-8?B?b0diSHRKaHQwdFF1M3lqRTV3QS9yRHZaNDFBSGhWVVF5SndUQ1gralFad1pu?=
 =?utf-8?B?MEFxREllanVxNmluMVFiZCtHM3lhZkFQaWhqMmFGWDkvbTNKYllnakQ0QkZP?=
 =?utf-8?B?UXZpVGZVU2hwWDdkM2Z3RWhEMk9WWE54SzlGZy9pdXkreC9oSHE1c0E3UmVK?=
 =?utf-8?B?ZWJzNmZhcnB5UlpPc25hcGJtV3JkQjJhdXMrVmxtSUd4czZMQnNoZ3QyMUFs?=
 =?utf-8?B?cEw0Vnd4cWMwZUZMVmFOaWhtdWN5SWhKaUpKMDdUYnZ4OXk0SlhpMEtUZy9G?=
 =?utf-8?B?M3J1TzVuTEN4VEEzUGhKYnV4MnlkUStCbHprY1VVWkZza01HQjJiZEFpOXJT?=
 =?utf-8?B?akdiTXpOamcvLzltTHlzdXJwU2hvSFQ0bGF3TlZsVWgrVTF5bldlOEY2NDBj?=
 =?utf-8?B?NzVMT2dxWi9zVDFQSUNQM3RielZPemF4WjRoRmU0T0JLcnk1RFM0YUNLMkhh?=
 =?utf-8?B?N2E1R2NaQ3lmRUFvOWd4WmZBN2R3R3FPL1J3U2JEMkhiTjZIWHhzbUJxOXp3?=
 =?utf-8?B?ZDJ2bmM2ekpNbXVvS2EvdkcxOHI1b01NSmpCbjBYQUprbWdEcWNjZk5wWWsr?=
 =?utf-8?B?S0FPdTJPditoWWNhY0dIRUhmNU9vTTdNOFViYVp3S2VmQkN1RFBjQU55cUdh?=
 =?utf-8?B?cnpTaGI5bUJWUkVFMjcrY0ZaeUVHdkh6WXB3ZFAxWkhOSkpEOFl3VVlCNDNU?=
 =?utf-8?B?bWRXUXA4dGZGekk5UGUzQkhDRDJ4eldHUnE2dlN3VWk0VWxQZEVmZWNVOTNr?=
 =?utf-8?B?djVIZWdqaE45WGNIbkMzUHkwWUlwYXYzaGM0RjNLdmdMeUlEbUhvekdCN1NL?=
 =?utf-8?B?M0lLejE4b2lMV0ZsRFlqRGQxdng1a0lWNjRwZjhBRUpaY3UvQlU2OTVFbjZB?=
 =?utf-8?B?eWxaYXdvNEZxUE0wRmd3WWh3K0MxYStLcTJsOS9wOTlFY2c2TGFvYlhNT1NX?=
 =?utf-8?B?d1E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 082eb66d-ec58-4ee8-c694-08db56e4ef3d
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 14:42:27.2757
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E30jUuUOBgtCQVhsQvgW15GlY+Nfw0atYSK54BKBor/Ej2MZQUYt8a0g7TmbYrSxMbLay6VDAIOFlRLvJncYYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB6328
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 17 May 2023 14:42:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11501

From: Jan Kiszka <jan.kiszka@siemens.com>

This fixes the build of linux-mainline for targets that have
USE_CIP_KERNEL_CONFIG set.

As Srinuvasan A pointed out, squashfs is now set via the 6.1 config in
cip-kernel-config. Therefore drop the obsolete fragment.

Closes: #64
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kas/opt/6.1-mainline.yml                      |  1 -
 recipes-kernel/linux/cip-kernel-config.inc    | 17 +++++++++++++++++
 recipes-kernel/linux/files/squashfs.cfg       |  1 -
 recipes-kernel/linux/linux-cip-common.inc     |  9 ++-------
 recipes-kernel/linux/linux-mainline_6.1.15.bb |  6 ++++--
 5 files changed, 23 insertions(+), 11 deletions(-)
 create mode 100644 recipes-kernel/linux/cip-kernel-config.inc
 delete mode 100644 recipes-kernel/linux/files/squashfs.cfg

diff --git a/kas/opt/6.1-mainline.yml b/kas/opt/6.1-mainline.yml
index 84d12b0b..0dcf3364 100644
--- a/kas/opt/6.1-mainline.yml
+++ b/kas/opt/6.1-mainline.yml
@@ -14,5 +14,4 @@ header:
 
 local_conf_header:
   kernel-version: |
-    KERNEL_DEFCONFIG = ""
     KERNEL_NAME = "mainline"
diff --git a/recipes-kernel/linux/cip-kernel-config.inc b/recipes-kernel/linux/cip-kernel-config.inc
new file mode 100644
index 00000000..329b9f7e
--- /dev/null
+++ b/recipes-kernel/linux/cip-kernel-config.inc
@@ -0,0 +1,17 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2022-2023
+#
+# Authors:
+#  Jan Kiszka <jan.kiszka@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+SRC_URI:append = " ${@ \
+    'git://gitlab.com/cip-project/cip-kernel/cip-kernel-config.git;protocol=https;branch=master;destsuffix=cip-kernel-config;name=cip-kernel-config' \
+    if d.getVar('USE_CIP_KERNEL_CONFIG') == '1' else '' \
+    }"
+
+SRCREV_cip-kernel-config ?= "d1efa37258380c7f4f39a8dee1bdb4d85f1c0199"
diff --git a/recipes-kernel/linux/files/squashfs.cfg b/recipes-kernel/linux/files/squashfs.cfg
deleted file mode 100644
index 7a89d006..00000000
--- a/recipes-kernel/linux/files/squashfs.cfg
+++ /dev/null
@@ -1 +0,0 @@
-CONFIG_SQUASHFS=y
diff --git a/recipes-kernel/linux/linux-cip-common.inc b/recipes-kernel/linux/linux-cip-common.inc
index a700d30e..c0f076a9 100644
--- a/recipes-kernel/linux/linux-cip-common.inc
+++ b/recipes-kernel/linux/linux-cip-common.inc
@@ -1,7 +1,7 @@
 #
 # CIP Core, generic profile
 #
-# Copyright (c) Siemens AG, 2022
+# Copyright (c) Siemens AG, 2022-2023
 #
 # Authors:
 #  Jan Kiszka <jan.kiszka@siemens.com>
@@ -14,15 +14,10 @@ FILESEXTRAPATHS:prepend := "${FILE_DIRNAME}/files:"
 KERNEL_DEFCONFIG ?= "${MACHINE}_defconfig"
 
 require recipes-kernel/linux/linux-custom.inc
+require recipes-kernel/linux/cip-kernel-config.inc
 
 SRC_URI += " \
     https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/snapshot/linux-cip-${PV}.tar.gz \
     "
 
-SRC_URI:append = " ${@ "git://gitlab.com/cip-project/cip-kernel/cip-kernel-config.git;protocol=https;branch=master;destsuffix=cip-kernel-config;name=cip-kernel-config" \
-    if d.getVar('USE_CIP_KERNEL_CONFIG') == '1' else '' \
-    }"
-
-SRCREV_cip-kernel-config ?= "d1efa37258380c7f4f39a8dee1bdb4d85f1c0199"
-
 S = "${WORKDIR}/linux-cip-${PV}"
diff --git a/recipes-kernel/linux/linux-mainline_6.1.15.bb b/recipes-kernel/linux/linux-mainline_6.1.15.bb
index f6cd7b8b..9b45f28e 100644
--- a/recipes-kernel/linux/linux-mainline_6.1.15.bb
+++ b/recipes-kernel/linux/linux-mainline_6.1.15.bb
@@ -5,12 +5,14 @@
 # SPDX-License-Identifier: MIT
 
 require recipes-kernel/linux/linux-custom.inc
+require recipes-kernel/linux/cip-kernel-config.inc
 
 ARCHIVE_VERSION = "${@ d.getVar('PV')[:-2] if d.getVar('PV').endswith('.0') else d.getVar('PV') }"
 
+KERNEL_DEFCONFIG_VERSION ?= "6.1.y-cip"
+
 SRC_URI += " \
-    https://cdn.kernel.org/pub/linux/kernel/v6.x/linux-${ARCHIVE_VERSION}.tar.xz \
-    file://squashfs.cfg"
+    https://cdn.kernel.org/pub/linux/kernel/v6.x/linux-${ARCHIVE_VERSION}.tar.xz"
 
 SRC_URI[sha256sum] = "2c16dfe2168a2e64ac0d55a12d625ebfb963818bb48b60c1868c7c460644c4fd"
 
-- 
2.35.3

