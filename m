Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1483CC79F99
	for <webhook@archiver.kernel.org>; Tue,  8 Sep 2026 16:41:50 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com (AS8PR04CU009.outbound.protection.outlook.com [52.101.70.8])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.12312.1788885705958243177
 for <cip-dev@lists.cip-project.org>;
 Tue, 08 Sep 2026 09:41:46 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=Hx2nhRmD;
 spf=pass (domain: siemens.com, ip: 52.101.70.8, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xhpEoufc9dNrE/5SD75Vq3kbIY63B5/PJFi4TEd8Pn+yDbj0LRjRThACOvKE54HOqQXIH+mcf0IOEGN5qh7CmoYEO7iUIeHV/Ua9C7+H/TYmRUqcFoUw6ZFj4zne+geTy+sNWa1YsvmfiPgr5XUwrKrClbcIHQvYnOcLcOcR5ojQuTY9QI5ATUS8njlDIty7Uf6GrgYhqbhW0eNo1mO2TVO/uUWEBOTO+JZKU0z5G1iFrvGljV9Z/5MpvJJLKMyreadBq3Fjh9Jr2iMe2WRun3hZ52p2c3+SxGr3YL6AXIWbDga0wlcrHW/4az8q2wl77bla1aCg/70oGkgw9OaSJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pSoUxdg3Oa3zNLIXny+5l56UaD0JgjP10HkDZvn2UVs=;
 b=VZHqoEiHuIKu7EUMrRtsVeSwB7nVBNBE8yBQUCA3o4hH1HIsheuyrX4hkzWR1Poevy7/JKF8PAONqZqMvXrn3ssO8FVVxWKGzgVXQCb9Ktt4VpRg3ERqTAxPsdznmwlSSJ2nbrg8Gh+qgUCxiGxU+e2AKMrbkVSdVBF9Gn/sPmZ8DWzMSQhQRjSoOg01rDDTEaspMHIy6Fq+e4tqXJKAjbpcreFcW/iNofgYnjlYId/NI6wb1gzPB0HDRdT322yM1PRnw3yXAdq9u6T4vMhB5oufyB1O9ddaKGre1SIS77OP9aaPAuJhS54bH1mtbt2muD8cGj7X7gfKBHg7BBNwsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pSoUxdg3Oa3zNLIXny+5l56UaD0JgjP10HkDZvn2UVs=;
 b=Hx2nhRmD7Xw9FPvvOZDarKVThhQNzuzzBtEKmQcNPGFmCDJ8EZZLVWDqrshRMZxBS+bYW0udOWEddaW6kfHn50jneFOKJQoqlfU1T6grITnJzErIwSgUynOS/OBjgFlA+vIroQ1jpKZ/vEEKCvWBwdEfHZRspjtKAaVU5LION9S9XKb5OKqCpk/bBidkHUAf1O0/NiL0VJVT9wgWnHbAe51N3hcu+jzTKQHZxkpPVBpkAyciSJVtqRqQEpg6VT/4neLRPVqhgnnrp/vDGlDYeoTtkMpL9lDZy388/0+ms6w0kRwHpvyp2QOZ8EX9WmhXBWMJh6PraRJbHxHXM0SrXQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by BESPR10MB709813.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:b10:12f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Tue, 8 Sep
 2026 16:41:41 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%2]) with mapi id 15.21.0382.014; Tue, 8 Sep 2026
 16:41:40 +0000
Message-ID: <19b6fb2c-7728-4847-86b0-adcd0c4892cf@siemens.com>
Date: Tue, 8 Sep 2026 18:41:39 +0200
User-Agent: Mozilla Thunderbird
Subject: [isar-cip-core][PATCH v3 4/7] u-boot: Add patches to enable measured
 boot with fTPM
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
CC: Sai Sree Kartheek Adivi <s-adivi@ti.com>,
 Quirin Gylstorff <quirin.gylstorff@siemens.com>,
 Alexander Heinisch <alexander.heinisch@siemens.com>
References: <cover.1787757655.git.jan.kiszka@siemens.com>
 <57645a54176e23d9c73df2be994f85fc2028cb53.1787757655.git.jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <57645a54176e23d9c73df2be994f85fc2028cb53.1787757655.git.jan.kiszka@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR2P281CA0126.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::20) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|BESPR10MB709813:EE_
X-MS-Office365-Filtering-Correlation-Id: 6032b84e-9b7d-4083-90c5-08df0dc80f0b
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|10067099003|6133799003|3023799007|5023799004|55112099003|22082099003|18002099003|11063799006|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info: 
	5x3QJz/hH0CmM91P5NqcNX1nw2Jg5VpoPcTZbOQzqbZdiVJfAOEAyIszApZCARUur0W4PvfmARh9rbZ8L6Xfv9x0nJB9SVzTVnaEEzl4ptKUP/kV+YXsVymaxcGGiyPrwkKq6N9OF70/9xRUFUnQ175lJCCHjaT0gttjSUSwyymI72EHZEDlbtuC3lKu1St59/7zUK9TRu4Bu989FvSObXiU5xE0hXkL00BNwmHixlCvucQhzVvz7aiYlAEOcwa6pi0KT++j4X7W3e8WfYddWNaDT+QCR7VBNZFLBvGI1RG9iusLrdWna+Cmfds5jyAuaBUAkD68B+ORdffBmenzB1tcS8id0HViZv+kkIYftV4A5J4B0mbsckdCZJ6a1gJeEnjqpMb2eSFFGR+uiuouPl556Aimv1fmRRJnSHUt3TCT1J9NU7tRM6dfmUSbzdRBQwHDjcOGOo4rHK+sIDJw8T2ZqURPaiVk4OIunStGoVqH9ZMZiE0A52lwwRmgThW58m0JlX4imll+N8bgQEr2qBNLnT27GAbCu7EUOQ5iXzeVRjx+SDRXd3Rxjm3gE9BWnBwEIFvDnGMufibWKKoAnR7W4cG4P21xGqpTZSULsHo9XQpOCqvpu9MCDZEJSEiHX4zNpV++ezxlY35ieUfZ1XuyvbLaq/3vvwPjLS8gHoA=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(10067099003)(6133799003)(3023799007)(5023799004)(55112099003)(22082099003)(18002099003)(11063799006)(56012099006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?epLs8XyzzbmT52fHj/7P4ve8nf2b9+kx4IeKQFGqLRrpL6K2Mr6q38J8Q9mQ?=
 =?us-ascii?Q?uAjEC4toWsZjGMpUxvHd9LaURYiAAUoQ3+5CpidWrnY9UPMieVfQ1glAsNvs?=
 =?us-ascii?Q?zjxr0JlPJmHtAkbm/TAPoj766DdmFArq+FgldQ7touyr/P23OCCXXZ4WE1Vk?=
 =?us-ascii?Q?l16RW7x1zF5pnDKp9TF6C3kb0wS2JgV7k0lzpubTc5W0hRpVzSGGT+uHDcck?=
 =?us-ascii?Q?DkH/q82lUH6gfBgErPAqFYPVxQvAc0YzZVk2a+qXwq6cQtpVB6b2TXR1/D+y?=
 =?us-ascii?Q?m5qive+vQjOTSqAD/pVtSbxFIUuS/jCYaeL5V1h3KjJLEHb/oCZhzLH83fSp?=
 =?us-ascii?Q?vvzsCufwWkzBuPQK9oQs3tNSBvPvQeBADKQsPoNttomBJCaqZ/kHarE4ptTb?=
 =?us-ascii?Q?Cej071obSjm3R3yuW9jgEEGap4eIho3YwwkP//PsWyTc1fQJh2HgqOeTQhkU?=
 =?us-ascii?Q?xVP8e4KADtw5QhD67PgHfvNeqWQce4zp+WDkuH4EMS3so5ijnqeYsKFEkDqp?=
 =?us-ascii?Q?obJF5lzjUodau40Q3YV3ylpmfBJxErefA5yfflqv/97jeUwoXE51PDgrtTew?=
 =?us-ascii?Q?ujClAr8V3/alnHPFBX9JSX5VdyH0lMqcfSdvr3ZvAQuD553Gm6S7icGF+XLb?=
 =?us-ascii?Q?o1bbm7BVIamUjmvTU0d+we+Y/fTDeg32gjJlZQp14R2l6h/mRiUj8CRqj2/e?=
 =?us-ascii?Q?tVmftNO3rEhm73NCu5c9VphkG2wolahhiojDTcnRQ59z0mY+yLNl7KgrVplG?=
 =?us-ascii?Q?R58/aQEEjt7/NB9N716P2B1JPvK2d7b36BiUT4lsCtmf6khWDHmbSj+tejep?=
 =?us-ascii?Q?doG7I4xO9VZf/uYUUoIcCp3Rk5ZSylkHPdvQIKrGYXptFfYsgoSpFAeAmrBy?=
 =?us-ascii?Q?Llxh3hHQVHkCJYgf3tt9bR8jFFyD4C1DgB6F+ke4AfBA/jjEFLutxU+wm8Wn?=
 =?us-ascii?Q?Mm6VT6X80fSLdiDlekZ+MiDv0TVzuKylSPZ5X9Z1NYSrk0H8KJ3TNuBdST+6?=
 =?us-ascii?Q?DpzcF7cdZWZ2GLK9MccHZ8PYAi7FoQb9N9d4y0QzzcjqbSXJqcD2j3mn1j8K?=
 =?us-ascii?Q?k/6QFW0Hfm96ajJtVCpcSCx4qk5wrWr7ds2bf5Xt7lMKnie7Qftvg3/23zEY?=
 =?us-ascii?Q?I9WhSXwM3mVd8Q+gQPBWYypjpQbRyOd8BEsc114HC5ng0MaybUFURZUPJpQA?=
 =?us-ascii?Q?InWPEoYbnbWf24VCSJ+OpTE6A4eebIht286vBA4+TrZIAOO8HYhbcrmrE6YN?=
 =?us-ascii?Q?6xv9+XBnzYCur0+AVFoqQYnvc/+sh7c+krd8oRXvNUjPUny3LpiLmgmcKPr4?=
 =?us-ascii?Q?D1b25VztC9p7cLxMaOoE+L1hlLnG1FsyTA6jqXX/pKX3/usfXlJS+3u/C+Tc?=
 =?us-ascii?Q?gqM84egSoxU/8hsC8jBK8RBaL/67adFmkzUtYm/ydaW4/w55PLaERL12QMQ7?=
 =?us-ascii?Q?szgjrAmBdh1jth9ndZkXJp3hYdXuVcih0407C5P3Y4ka59Ddsfuh4934QLjb?=
 =?us-ascii?Q?i3RTIKrlYvaRQEYeqHRpOq2pd+J5SPuH2wCAF4UP6jCUR4nvVULvgmGgVHnz?=
 =?us-ascii?Q?sJmbvSZhcvcDHnATiSUgfU4R0SCr7iuDG/6LYD76vhZkI0AV1eyLOslOug3Y?=
 =?us-ascii?Q?XS8wO1geClPsY/G7EX5L9szAt6zVlKCjD6LUed8QjKeuMh4PFnGHZIzNNIEc?=
 =?us-ascii?Q?UTUN91QkOfiG8fhACYTTn8wRoCLZdJzIgO36NDNdLccWirzgISXAsZQ6YrPd?=
 =?us-ascii?Q?ItpgG+CgoQ=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6032b84e-9b7d-4083-90c5-08df0dc80f0b
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 16:41:40.9043
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yuCpw00/9vS2DbH0M7KP3J4pND5jEl/ezzrbXPTAJA3i4IlQg3DoYBAEzDFXH27+stXnDORUXUFxGpuGEhEtbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BESPR10MB709813
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 08 Sep 2026 16:41:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24103

From: Jan Kiszka <jan.kiszka@siemens.com>

U-Boot was so far not enumerating the fTPM device, and that caused the
PCRs to stay zero. systemd-cryptenroll was complaining already, just not
loud enough.

With these extra patches (currently under review upstream), we are
getting a TPM right before the EFI loader starts, and we get valid PCR
content as well.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

Partial update of this series to include patches sent as v3 to u-boot:
https://lore.kernel.org/u-boot/cover.1788879818.git.jan.kiszka@siemens.com/

 ...ement-Fix-compilation-for-non-sandbo.patch |  43 +++++
 ...-out-service-enumeration-and-binding.patch |  95 +++++++++++
 ...pport-for-enumerating-services-that-.patch | 156 ++++++++++++++++++
 ...-warn-about-TEE_ERROR_STORAGE_NOT_AV.patch |  33 ++++
 ...to-optee-after-a-successful-mmc_init.patch |  41 +++++
 ...-MMC-Device-not-found-a-debug-output.patch |  50 ++++++
 recipes-bsp/u-boot/u-boot-common-2026.01.inc  |   6 +
 7 files changed, 424 insertions(+)
 create mode 100644 recipes-bsp/u-boot/files/0001-test-boot-measurement-Fix=
-compilation-for-non-sandbo.patch
 create mode 100644 recipes-bsp/u-boot/files/0002-tee-optee-Factor-out-serv=
ice-enumeration-and-binding.patch
 create mode 100644 recipes-bsp/u-boot/files/0003-tee-optee-Add-support-for=
-enumerating-services-that-.patch
 create mode 100644 recipes-bsp/u-boot/files/0004-tee-optee-Do-not-warn-abo=
ut-TEE_ERROR_STORAGE_NOT_AV.patch
 create mode 100644 recipes-bsp/u-boot/files/0005-mmc-Call-back-to-optee-af=
ter-a-successful-mmc_init.patch
 create mode 100644 recipes-bsp/u-boot/files/0006-mmc-Make-MMC-Device-not-f=
ound-a-debug-output.patch

diff --git a/recipes-bsp/u-boot/files/0001-test-boot-measurement-Fix-compil=
ation-for-non-sandbo.patch b/recipes-bsp/u-boot/files/0001-test-boot-measur=
ement-Fix-compilation-for-non-sandbo.patch
new file mode 100644
index 00000000..5d7bf886
--- /dev/null
+++ b/recipes-bsp/u-boot/files/0001-test-boot-measurement-Fix-compilation-f=
or-non-sandbo.patch
@@ -0,0 +1,43 @@
+From bb19b017d4d389b4ba9a08e35e4e19d39f552c5d Mon Sep 17 00:00:00 2001
+From: Jan Kiszka <jan.kiszka@siemens.com>
+Date: Thu, 20 Aug 2026 17:57:08 +0200
+Subject: [PATCH 1/6] test: boot: measurement: Fix compilation for non-sand=
box
+ builds
+MIME-Version: 1.0
+Content-Type: text/plain; charset=3DUTF-8
+Content-Transfer-Encoding: 8bit
+
+asm/io.h provides map_to_sysmem() only for the sandbox. Other targets
+fail the build with
+
+../test/boot/measurement.c: In function =E2=80=98measure=E2=80=99:
+../test/boot/measurement.c:30:33: error: implicit declaration of function =
=E2=80=98map_to_sysmem=E2=80=99; did you mean =E2=80=98map_physmem=E2=80=99=
? [-Wimplicit-function-declaration]
+   30 |         images.os.image_start =3D map_to_sysmem(kernel);
+      |                                 ^~~~~~~~~~~~~
+      |                                 map_physmem
+
+Use the proper header that will pull asm/io.h only where needed.
+
+Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
+---
+ test/boot/measurement.c | 2 +-
+ 1 file changed, 1 insertion(+), 1 deletion(-)
+
+diff --git a/test/boot/measurement.c b/test/boot/measurement.c
+index 71f503f1567..85a01f1fec8 100644
+--- a/test/boot/measurement.c
++++ b/test/boot/measurement.c
+@@ -9,9 +9,9 @@
+ #include <bootm.h>
+ #include <env.h>
+ #include <malloc.h>
++#include <mapmem.h>
+ #include <test/test.h>
+ #include <test/ut.h>
+-#include <asm/io.h>
+=20
+ #define MEASUREMENT_TEST(_name, _flags)	\
+ 	UNIT_TEST(_name, _flags, measurement)
+--=20
+2.47.3
+
diff --git a/recipes-bsp/u-boot/files/0002-tee-optee-Factor-out-service-enu=
meration-and-binding.patch b/recipes-bsp/u-boot/files/0002-tee-optee-Factor=
-out-service-enumeration-and-binding.patch
new file mode 100644
index 00000000..94a7790e
--- /dev/null
+++ b/recipes-bsp/u-boot/files/0002-tee-optee-Factor-out-service-enumeratio=
n-and-binding.patch
@@ -0,0 +1,95 @@
+From ae8bbc61b5e795a7d6c559a2518ffde029fbcf68 Mon Sep 17 00:00:00 2001
+From: Jan Kiszka <jan.kiszka@siemens.com>
+Date: Sun, 23 Aug 2026 20:25:03 +0200
+Subject: [PATCH 2/6] tee: optee: Factor out service enumeration and bindin=
g
+ functions
+
+This already avoids code duplication between the different enumeration
+commands. It will furthermore allow to implement a third one for
+services with RPMB needs.
+
+Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
+---
+ drivers/tee/optee/core.c          | 33 +++++++++++++++++--------------
+ drivers/tee/optee/optee_private.h |  3 +++
+ 2 files changed, 21 insertions(+), 15 deletions(-)
+
+diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
+index 5fc0505c788..1893ae25137 100644
+--- a/drivers/tee/optee/core.c
++++ b/drivers/tee/optee/core.c
+@@ -156,7 +156,7 @@ static int enum_services(struct udevice *dev, struct t=
ee_shm **shm, size_t *coun
+ 	return ret;
+ }
+=20
+-static int open_enum_session(struct udevice *dev, u32 *tee_sess)
++int optee_open_enum_session(struct udevice *dev, u32 *tee_sess)
+ {
+ 	const struct tee_optee_ta_uuid pta_uuid =3D PTA_DEVICE_ENUM;
+ 	struct tee_open_session_arg arg =3D { };
+@@ -176,31 +176,34 @@ static int open_enum_session(struct udevice *dev, u3=
2 *tee_sess)
+ 	return 0;
+ }
+=20
+-static int bind_service_drivers(struct udevice *dev)
++int optee_bind_services(struct udevice *dev, u32 tee_sess,
++			unsigned int pta_cmd)
+ {
+ 	struct tee_shm *service_list =3D NULL;
+ 	size_t service_count;
+-	u32 tee_sess;
+-	int ret, ret2;
+-
+-	ret =3D open_enum_session(dev, &tee_sess);
+-	if (ret)
+-		return ret;
++	int ret;
+=20
+ 	ret =3D enum_services(dev, &service_list, &service_count, tee_sess,
+-			    PTA_CMD_GET_DEVICES);
++			    pta_cmd);
+ 	if (!ret && service_count)
+ 		ret =3D bind_service_list(dev, service_list, service_count);
+=20
+ 	tee_shm_free(service_list);
+-	service_list =3D NULL;
+=20
+-	ret2 =3D enum_services(dev, &service_list, &service_count, tee_sess,
+-			     PTA_CMD_GET_DEVICES_SUPP);
+-	if (!ret2 && service_count)
+-		ret2 =3D bind_service_list(dev, service_list, service_count);
++	return ret;
++}
++
++static int bind_service_drivers(struct udevice *dev)
++{
++	u32 tee_sess;
++	int ret, ret2;
+=20
+-	tee_shm_free(service_list);
++	ret =3D optee_open_enum_session(dev, &tee_sess);
++	if (ret)
++		return ret;
++
++	ret =3D optee_bind_services(dev, tee_sess, PTA_CMD_GET_DEVICES);
++	ret2 =3D optee_bind_services(dev, tee_sess, PTA_CMD_GET_DEVICES_SUPP);
+=20
+ 	tee_close_session(dev, tee_sess);
+=20
+diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/optee_p=
rivate.h
+index 1f07a27ee4b..25b6b3c3218 100644
+--- a/drivers/tee/optee/optee_private.h
++++ b/drivers/tee/optee/optee_private.h
+@@ -27,6 +27,9 @@ struct optee_msg_arg;
+=20
+ void optee_suppl_cmd(struct udevice *dev, struct tee_shm *shm_arg,
+ 		     void **page_list);
++int optee_open_enum_session(struct udevice *dev, u32 *tee_sess);
++int optee_bind_services(struct udevice *dev, u32 tee_sess,
++			unsigned int pta_cmd);
+=20
+ #ifdef CONFIG_SUPPORT_EMMC_RPMB
+ /**
+--=20
+2.47.3
+
diff --git a/recipes-bsp/u-boot/files/0003-tee-optee-Add-support-for-enumer=
ating-services-that-.patch b/recipes-bsp/u-boot/files/0003-tee-optee-Add-su=
pport-for-enumerating-services-that-.patch
new file mode 100644
index 00000000..76c6cb27
--- /dev/null
+++ b/recipes-bsp/u-boot/files/0003-tee-optee-Add-support-for-enumerating-s=
ervices-that-.patch
@@ -0,0 +1,156 @@
+From f31e6747312ddffc3e3d9f27643dc247cdf3ead1 Mon Sep 17 00:00:00 2001
+From: Jan Kiszka <jan.kiszka@siemens.com>
+Date: Fri, 21 Aug 2026 08:39:26 +0200
+Subject: [PATCH 3/6] tee: optee: Add support for enumerating services that
+ only need RPMB
+
+Up to OP-TEE 4.4.0, all services that needed a supplicant where returned
+by PTA_CMD_GET_DEVICES_SUPP. Since then, services that only need a
+supplicant for the purpose of accessing the RPMB are only enumerated by
+the new, separate PTA_CMD_GET_DEVICES_RPMB. U-Boot so far lacks support
+for that, thus no longer finds such services, e.g. fTPM.
+
+Perform the separate enumeration during probe but, as that may fail if
+the MMC is not probed yet, also provide a callback to trigger a retry
+when another MMC device becomes available.
+
+Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
+---
+ drivers/tee/optee/core.c          | 22 +++++++---------------
+ drivers/tee/optee/optee_private.h | 21 +++++++++++++++++++++
+ drivers/tee/optee/rpmb.c          | 20 ++++++++++++++++++++
+ include/tee/optee.h               |  6 ++++++
+ 4 files changed, 54 insertions(+), 15 deletions(-)
+
+diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
+index 1893ae25137..6127ca431f2 100644
+--- a/drivers/tee/optee/core.c
++++ b/drivers/tee/optee/core.c
+@@ -27,19 +27,6 @@
+  */
+ #define PTA_DEVICE_ENUM		{ 0x7011a688, 0xddde, 0x4053, \
+ 				  { 0xa5, 0xa9, 0x7b, 0x3c, 0x4d, 0xdf, 0x13, 0xb8 } }
+-/*
+- * PTA_CMD_GET_DEVICES - List services without supplicant dependencies
+- *
+- * [out]    memref[0]: List of the UUIDs of service enumerated by OP-TEE
+- */
+-#define PTA_CMD_GET_DEVICES		0x0
+-
+-/*
+- * PTA_CMD_GET_DEVICES_SUPP - List services depending on tee supplicant
+- *
+- * [out]    memref[0]: List of the UUIDs of service enumerated by OP-TEE
+- */
+-#define PTA_CMD_GET_DEVICES_SUPP	0x1
+=20
+ typedef void (optee_invoke_fn)(unsigned long, unsigned long, unsigned lon=
g,
+ 			       unsigned long, unsigned long, unsigned long,
+@@ -195,8 +182,8 @@ int optee_bind_services(struct udevice *dev, u32 tee_s=
ess,
+=20
+ static int bind_service_drivers(struct udevice *dev)
+ {
++	int ret, ret2, ret3 =3D 0;
+ 	u32 tee_sess;
+-	int ret, ret2;
+=20
+ 	ret =3D optee_open_enum_session(dev, &tee_sess);
+ 	if (ret)
+@@ -204,13 +191,18 @@ static int bind_service_drivers(struct udevice *dev)
+=20
+ 	ret =3D optee_bind_services(dev, tee_sess, PTA_CMD_GET_DEVICES);
+ 	ret2 =3D optee_bind_services(dev, tee_sess, PTA_CMD_GET_DEVICES_SUPP);
++	if (CONFIG_IS_ENABLED(SUPPORT_EMMC_RPMB))
++		ret3 =3D optee_bind_services(dev, tee_sess,
++					   PTA_CMD_GET_DEVICES_RPMB);
+=20
+ 	tee_close_session(dev, tee_sess);
+=20
+ 	if (ret)
+ 		return ret;
++	if (ret2)
++		return ret2;
+=20
+-	return ret2;
++	return ret3;
+ }
+=20
+ /**
+diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/optee_p=
rivate.h
+index 25b6b3c3218..daff3e04493 100644
+--- a/drivers/tee/optee/optee_private.h
++++ b/drivers/tee/optee/optee_private.h
+@@ -9,6 +9,27 @@
+ #include <tee.h>
+ #include <log.h>
+=20
++/*
++ * PTA_CMD_GET_DEVICES - List services without supplicant dependencies
++ *
++ * [out]    memref[0]: List of the UUIDs of service enumerated by OP-TEE
++ */
++#define PTA_CMD_GET_DEVICES		0x0
++
++/*
++ * PTA_CMD_GET_DEVICES_SUPP - List services depending on tee supplicant
++ *
++ * [out]    memref[0]: List of the UUIDs of service enumerated by OP-TEE
++ */
++#define PTA_CMD_GET_DEVICES_SUPP	0x1
++
++/*
++ * PTA_CMD_GET_DEVICES_RPMB - List services only depending on RPMB suppor=
t
++ *
++ * [out]    memref[0]: List of the UUIDs of service enumerated by OP-TEE
++ */
++#define PTA_CMD_GET_DEVICES_RPMB	0x2
++
+ /**
+  * struct optee_private - OP-TEE driver private data
+  * @rpmb_mmc:		mmc device for the RPMB partition
+diff --git a/drivers/tee/optee/rpmb.c b/drivers/tee/optee/rpmb.c
+index bacced6af6c..7ae6045511b 100644
+--- a/drivers/tee/optee/rpmb.c
++++ b/drivers/tee/optee/rpmb.c
+@@ -191,3 +191,23 @@ void optee_suppl_rpmb_release(struct udevice *dev)
+ {
+ 	release_mmc(dev_get_priv(dev));
+ }
++
++void optee_rpmb_available(void)
++{
++	struct udevice *dev;
++	struct uclass *uc;
++	u32 tee_sess;
++
++	uclass_id_foreach_dev(UCLASS_TEE, dev, uc) {
++		if (strcmp(dev->driver->name, "optee") !=3D 0 ||
++		    !device_active(dev))
++			continue;
++
++		if (optee_open_enum_session(dev, &tee_sess) !=3D 0)
++			continue;
++
++		optee_bind_services(dev, tee_sess, PTA_CMD_GET_DEVICES_RPMB);
++
++		tee_close_session(dev, tee_sess);
++	}
++}
+diff --git a/include/tee/optee.h b/include/tee/optee.h
+index 77729450bb6..f503f367c0f 100644
+--- a/include/tee/optee.h
++++ b/include/tee/optee.h
+@@ -65,4 +65,10 @@ static inline int optee_copy_fdt_nodes(void *new_blob)
+ }
+ #endif
+=20
++#if defined(CONFIG_OPTEE) && defined(CONFIG_SUPPORT_EMMC_RPMB)
++void optee_rpmb_available(void);
++#else
++static inline void optee_rpmb_available(void) {}
++#endif
++
+ #endif /* _OPTEE_H */
+--=20
+2.47.3
+
diff --git a/recipes-bsp/u-boot/files/0004-tee-optee-Do-not-warn-about-TEE_=
ERROR_STORAGE_NOT_AV.patch b/recipes-bsp/u-boot/files/0004-tee-optee-Do-not=
-warn-about-TEE_ERROR_STORAGE_NOT_AV.patch
new file mode 100644
index 00000000..6ca9e0eb
--- /dev/null
+++ b/recipes-bsp/u-boot/files/0004-tee-optee-Do-not-warn-about-TEE_ERROR_S=
TORAGE_NOT_AV.patch
@@ -0,0 +1,33 @@
+From ae4196ebbfc089828aea826422c16b58ff417aac Mon Sep 17 00:00:00 2001
+From: Jan Kiszka <jan.kiszka@siemens.com>
+Date: Fri, 21 Aug 2026 09:02:23 +0200
+Subject: [PATCH 4/6] tee: optee: Do not warn about
+ TEE_ERROR_STORAGE_NOT_AVAILABLE
+
+This is a transitional error that is resolved once an RPMB becomes
+available. Keep it as debug output only.
+
+Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
+---
+ drivers/tee/optee/core.c | 5 ++++-
+ 1 file changed, 4 insertions(+), 1 deletion(-)
+
+diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
+index 6127ca431f2..720f59a680f 100644
+--- a/drivers/tee/optee/core.c
++++ b/drivers/tee/optee/core.c
+@@ -106,7 +106,10 @@ static int __enum_services(struct udevice *dev, struc=
t tee_shm *shm, size_t *shm
+=20
+ 	ret =3D tee_invoke_func(dev, &arg, 1, &param);
+ 	if (ret || (arg.ret && arg.ret !=3D TEE_ERROR_SHORT_BUFFER)) {
+-		dev_err(dev, "Enumeration command 0x%x failed: 0x%x\n", pta_cmd, arg.re=
t);
++		if (arg.ret !=3D TEE_ERROR_STORAGE_NOT_AVAILABLE)
++			dev_err(dev, "Enumeration command 0x%x failed: 0x%x\n", pta_cmd, arg.r=
et);
++		else
++			dev_dbg(dev, "Enumeration command 0x%x failed due to unavailable stora=
ge\n", pta_cmd);
+ 		return -EINVAL;
+ 	}
+=20
+--=20
+2.47.3
+
diff --git a/recipes-bsp/u-boot/files/0005-mmc-Call-back-to-optee-after-a-s=
uccessful-mmc_init.patch b/recipes-bsp/u-boot/files/0005-mmc-Call-back-to-o=
ptee-after-a-successful-mmc_init.patch
new file mode 100644
index 00000000..b5d372ce
--- /dev/null
+++ b/recipes-bsp/u-boot/files/0005-mmc-Call-back-to-optee-after-a-successf=
ul-mmc_init.patch
@@ -0,0 +1,41 @@
+From 66aa7421ad9e58cf82bf99db12ccfbedee555864 Mon Sep 17 00:00:00 2001
+From: Jan Kiszka <jan.kiszka@siemens.com>
+Date: Fri, 21 Aug 2026 08:49:05 +0200
+Subject: [PATCH 5/6] mmc: Call back to optee after a successful mmc_init
+
+This is needed to that OP-TEE can re-enumerate services which need RPMB
+access that may have become available now.
+
+Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
+---
+CC: Peng Fan <peng.fan@nxp.com>
+CC: Jaehoon Chung <jh80.chung@samsung.com>
+---
+ drivers/mmc/mmc.c | 4 ++++
+ 1 file changed, 4 insertions(+)
+
+diff --git a/drivers/mmc/mmc.c b/drivers/mmc/mmc.c
+index bf82c515600..51551135978 100644
+--- a/drivers/mmc/mmc.c
++++ b/drivers/mmc/mmc.c
+@@ -27,6 +27,7 @@
+ #include <linux/list.h>
+ #include <linux/printk.h>
+ #include <div64.h>
++#include <tee/optee.h>
+ #include "mmc_private.h"
+=20
+ #define DEFAULT_CMD6_TIMEOUT_MS  500
+@@ -3147,6 +3148,9 @@ int mmc_init(struct mmc *mmc)
+ 				mmc->cfg->name);
+ 	}
+=20
++	if (CONFIG_IS_ENABLED(OPTEE) && mmc->capacity_rpmb > 0)
++		optee_rpmb_available();
++
+ 	return err;
+ }
+=20
+--=20
+2.47.3
+
diff --git a/recipes-bsp/u-boot/files/0006-mmc-Make-MMC-Device-not-found-a-=
debug-output.patch b/recipes-bsp/u-boot/files/0006-mmc-Make-MMC-Device-not-=
found-a-debug-output.patch
new file mode 100644
index 00000000..e3e132d5
--- /dev/null
+++ b/recipes-bsp/u-boot/files/0006-mmc-Make-MMC-Device-not-found-a-debug-o=
utput.patch
@@ -0,0 +1,50 @@
+From 5add160c9b83a019af1c879f5a693e1a6a5131ec Mon Sep 17 00:00:00 2001
+From: Jan Kiszka <jan.kiszka@siemens.com>
+Date: Fri, 21 Aug 2026 11:00:09 +0200
+Subject: [PATCH 6/6] mmc: Make "MMC Device not found" a debug output
+
+Callers of find_mmc_device are generally processing and informing about
+errors already, e.g.
+
+=3D> mmc dev 2
+MMC Device 2 not found
+no mmc device at slot 2
+
+Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
+---
+CC: Peng Fan <peng.fan@nxp.com>
+CC: Jaehoon Chung <jh80.chung@samsung.com>
+---
+ drivers/mmc/mmc-uclass.c | 2 +-
+ drivers/mmc/mmc_legacy.c | 2 +-
+ 2 files changed, 2 insertions(+), 2 deletions(-)
+
+diff --git a/drivers/mmc/mmc-uclass.c b/drivers/mmc/mmc-uclass.c
+index 2f4dc5bd887..fe0ca88a72c 100644
+--- a/drivers/mmc/mmc-uclass.c
++++ b/drivers/mmc/mmc-uclass.c
+@@ -315,7 +315,7 @@ struct mmc *find_mmc_device(int dev_num)
+=20
+ 	if (ret) {
+ #if !defined(CONFIG_XPL_BUILD) || defined(CONFIG_SPL_LIBCOMMON_SUPPORT)
+-		printf("MMC Device %d not found\n", dev_num);
++		debug("MMC Device %d not found\n", dev_num);
+ #endif
+ 		return NULL;
+ 	}
+diff --git a/drivers/mmc/mmc_legacy.c b/drivers/mmc/mmc_legacy.c
+index 8f8ba34be71..2a4a8a83fb3 100644
+--- a/drivers/mmc/mmc_legacy.c
++++ b/drivers/mmc/mmc_legacy.c
+@@ -45,7 +45,7 @@ struct mmc *find_mmc_device(int dev_num)
+ 	}
+=20
+ #if !defined(CONFIG_XPL_BUILD) || defined(CONFIG_SPL_LIBCOMMON_SUPPORT)
+-	printf("MMC Device %d not found\n", dev_num);
++	debug("MMC Device %d not found\n", dev_num);
+ #endif
+=20
+ 	return NULL;
+--=20
+2.47.3
+
diff --git a/recipes-bsp/u-boot/u-boot-common-2026.01.inc b/recipes-bsp/u-b=
oot/u-boot-common-2026.01.inc
index 850847fd..0c864a82 100644
--- a/recipes-bsp/u-boot/u-boot-common-2026.01.inc
+++ b/recipes-bsp/u-boot/u-boot-common-2026.01.inc
@@ -26,6 +26,12 @@ SRC_URI +=3D " \
     file://0001-riscv-create-a-custom-CPU-implementation-for-PolarFi.patch=
 \
     file://0002-riscv-mpfs-move-SoC-level-options-to-the-CPU-Kconfig.patch=
 \
     file://0003-riscv-Add-support-for-BeagleV-Fire.patch \
+    file://0001-test-boot-measurement-Fix-compilation-for-non-sandbo.patch=
 \
+    file://0002-tee-optee-Factor-out-service-enumeration-and-binding.patch=
 \
+    file://0003-tee-optee-Add-support-for-enumerating-services-that-.patch=
 \
+    file://0004-tee-optee-Do-not-warn-about-TEE_ERROR_STORAGE_NOT_AV.patch=
 \
+    file://0005-mmc-Call-back-to-optee-after-a-successful-mmc_init.patch \
+    file://0006-mmc-Make-MMC-Device-not-found-a-debug-output.patch \
     file://rules.tmpl;subdir=3Ddebian"
 SRC_URI[sha256sum] =3D "b60d5865cefdbc75da8da4156c56c458e00de75a49b80c1a2e=
58a96e30ad0d54"
=20
--=20
2.47.3


