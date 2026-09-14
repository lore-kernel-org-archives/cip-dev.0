Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 028E3C88E50
	for <webhook@archiver.kernel.org>; Mon, 14 Sep 2026 06:25:47 +0000 (UTC)
Received: from AM0PR02CU008.outbound.protection.outlook.com (AM0PR02CU008.outbound.protection.outlook.com [52.101.72.64])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.14182.1789367140743077631
 for <cip-dev@lists.cip-project.org>;
 Sun, 13 Sep 2026 23:25:41 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=PYHfW9QG;
 spf=pass (domain: siemens.com, ip: 52.101.72.64, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AqrKq79OTNoXuDygstAEU7DUkL1bADRbpz28h1CtCRox9EX2JqDT/BToisFCJIjglmH//nCjFaqfKwMJnXd5osl18DCkP9mjmBF00J8Nr3czV5AqQ3M053GKlf7RBDSnHvZ1Qg2kjKUkWEcucEBMjr2rSkkJpJDpdqAshaAIIFqKjOcM7v4mGuRah5/Ihiw26oecRfuvO8HQJFUQhIgI0HGcHEag6HDdw2XxcVdkf03w1OonaNa/0ULhEOjLKaaHLMonLKhAq5+ikoOydDVKEx7e1teUfU0FR/BN2aVN3Uc43DOyVsDvICu2+LOBQQg/HOMfIhPgNwjuBkrURKUfvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NsRjcZa9L8Mw1+r81SePlDXcPsv8zjdrmTTj9guQwt8=;
 b=DN2PEYVQNTqJFBZqaV6WUYkLfs9fmJderUcvHKe7R1t7aM2CGIIL7uyxDHm/6HmtiVNg67OvKzcdsvyXX+P64mmjeRBM/v0DBajMxszCfsTgDSIPREl9GZjlU9wp8vNqr7yIxmvXoC4s8zOxxH7X53Na/2FzSF0ebf7ZUtmDXnqhivyZmmn3FA2Cth1r5BTkJIcpd65fhwVe10dREsFF+lvYjetT3AeXN7fqm0n0QHhEdkqRr7CwYzCNK/20xaBj+AVoZLuZdvzymBhRaGZ3ZNkH2CERj2dFCKUOdO05qHWvSZdh7q62qOJ2fSS2mexn7oGnf8S9Ib+UP0YR+GX+4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NsRjcZa9L8Mw1+r81SePlDXcPsv8zjdrmTTj9guQwt8=;
 b=PYHfW9QG0R4vwYJodECLxI2OMgayFJTr1yvqnxIsMH1lBSnBMI8TyL2vz82zTKQY5cp+H1oJdZuQw4+23s8xEb0BK1a/Qy5zdnZUSlK8ygYkXo7iRiDuFbcGszjLMAprxUXMIyotwdQ35n8nMZjlwUVZ3em7NbQrqdiSWkG6jZ4WKvEsutMaXElDHAH/vzQZ8Jk+yjSebl2b5tSS6XBt2mW6R+vbFq9MpDeujmB/p/le5CG3fc1ZR9NHuMybHfPnTvRHzgcuCDdMLuo/rJetyyp0DcFYCnmgEh9K57IaimRzOviLlX/7CewtC7zK3/R7Mp3/rzKX2b55qkfOUpjevw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PA1PR10MB9082.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:444::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 06:25:33 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%2]) with mapi id 15.21.0406.007; Mon, 14 Sep 2026
 06:25:33 +0000
Message-ID: <79da002d-aab8-49b6-a6cd-23b0772ac821@siemens.com>
Date: Mon, 14 Sep 2026 08:25:29 +0200
User-Agent: Mozilla Thunderbird
Subject: [isar-cip-core][PATCH v4 4/7] u-boot: Add patches to enable measured
 boot with fTPM
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
CC: Sai Sree Kartheek Adivi <s-adivi@ti.com>,
 Quirin Gylstorff <quirin.gylstorff@siemens.com>,
 Alexander Heinisch <alexander.heinisch@siemens.com>
References: <cover.1787757655.git.jan.kiszka@siemens.com>
 <57645a54176e23d9c73df2be994f85fc2028cb53.1787757655.git.jan.kiszka@siemens.com>
 <19b6fb2c-7728-4847-86b0-adcd0c4892cf@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <19b6fb2c-7728-4847-86b0-adcd0c4892cf@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR4P281CA0080.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cd::15) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PA1PR10MB9082:EE_
X-MS-Office365-Filtering-Correlation-Id: 58febeda-276f-40e5-57fe-08df1228fb34
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|6133799003|55112099003|22082099003|18002099003|3023799007|11063799006|4143699003|5023799004|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: 
	tFL4qTsF48FLJQrBbxO6Tkx/xaH8i0fHH2h8jpDdEfhvCNEGBvdadHdPzeCCRamL6+R9xCivqoD+5yhTrksvhyfUUnhMsqtwX+2vA07se0ZWDDFi20wylLqlKRXNSnM/aJaN8lxfFER4/aWfSN51FrKxbannzUTIiSfNJXOYqtGInM/hBp0qjZF84vhox6wTfUq+ve3EJbnXoYvBBD7x68LLMQ+Hi2f8RxvrEnUJ57NVRpYdvPT6Y55xllg5xBFVaMfpJg5U8gOQ+yIT6slKW+IpJTUM4fz6FpyjEDQOQcHWXLmdeDPh2LZf9JYtNwXeGwMe3BywoBL8SpfPcMg6sv6esRC4u8iO4V4D9Ig0g1SO/x08Cao4wiSOOIluxrvI8h+NKoNewxuEWvGrUVjuwdDCmC2rDymndj1yGderNPYXnAfrRb1oGdWxQFvFXE+l4MiR2ff2YVuahyWkwJ1mZX9o9CcCQ/IodAoo1YydhdtAawTdjf+gMsZZK2B688ZYIh1Jboe38NDZZdP6O5pCfTfGSxsuNzT8rpdGQHIabXXfflJDW+ZhpgIzfbtm5S55VBO+uTRJu45F0P9Is8X9URlEa+hQnidhF3rN9DecQD8n5qdb3CBmrEJMINna2fOZtJw8hfThxaRA5e7xH8Vs6AdNw7/tl4srQ5iSVwS4VPo=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(6133799003)(55112099003)(22082099003)(18002099003)(3023799007)(11063799006)(4143699003)(5023799004)(10067099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?nBBNhU2k02nLIKFKicLaT1vD7oUGjjl0MHIDYwWkznlPzW9XMuOPIA74KQ/U?=
 =?us-ascii?Q?ksuExB/nc98jKQbcKzRNsUO097VYg2CM5uvobOBAJNFeUnEVaGPwT1mzC/vk?=
 =?us-ascii?Q?SLhCMMt72R5cHcs7L2fTrSTyvrdVqjg/eTBztJ2uPOJ3z5vztNAi7/Bznt3K?=
 =?us-ascii?Q?MkFWe55EAVLJiLvwJen8yRC8z4M1DwJ0LBTc9HWJHBVtQftcCSnWI19RjgCj?=
 =?us-ascii?Q?IEBEyBzqMonvznzEW+kZV6+4YUrdKXeJqSN998uW7cjipcRamuwyHo/n4BhG?=
 =?us-ascii?Q?m8oYoi43LaJDY1GPbQ+g21DoKCAG/qAjVYsP6CmJRj/Ibk44p6h4PUTsJLyv?=
 =?us-ascii?Q?BhTm+DvlH66hstnmBd5VWqY7b78j1t5UiOQeT+E5RbcShfLeEXsrD3qwMLiC?=
 =?us-ascii?Q?z9CpecXfhrP3QPsZG5waXpNOJCNM6knF496ScTlamiJ2wj+v6Mp3TKBth9Ac?=
 =?us-ascii?Q?uAz9zwxScvDXV8+HZN+tvKp1KZ2wvACkQdNAGsKUp1cVegQG0JDi7xNYdV6R?=
 =?us-ascii?Q?L1qbdB2/WdGJYyNeisvhuwgD9VMkTNAuglqD20hwv3KFvtpZYP4+xiP9tDYI?=
 =?us-ascii?Q?+sjcXgFtagU2ZxPaWG0rE6dp4fYZKSQO5r4Y5agzTuDHUwBj4VKlpM+ohbzJ?=
 =?us-ascii?Q?EERK63lrO0Dkj4Pr0yC54PYIl2q+khICrUc/KCiteLySWLOYGZXfljJ7WpjS?=
 =?us-ascii?Q?UMpERHJFMz3ZMcqXfmAxyyp45M4eEugLKu1xE1BgqqRTQ+/k/XMOrGYsUl59?=
 =?us-ascii?Q?SC3dMuKtwB5nn1FYsWBf8eGehuurcAZI42iZN+/uILOndlIYBIWfidVkBhRS?=
 =?us-ascii?Q?Et6g6Gd9UUVPeK4Daa774FxkeffeRB0P07PdmhDeHVNV58EiNb9nbloNQKUA?=
 =?us-ascii?Q?BCAAC1iiBlJ0NP92HRRoqRYvLhVkUZuqhfXunc9+NiEZigomF8wLBweB3lRE?=
 =?us-ascii?Q?zSIThTt9GBT+x8baFCdHeUYlmkt+aF+5E8hg1kFD7zgVrx2JuU3Om5WuxMLy?=
 =?us-ascii?Q?3hQGfImyAROSc1s74z4F09CJyzh8vu6Nss7upB4SIwiZbY0Ib8wTpDLvGyl5?=
 =?us-ascii?Q?gHiM/N5KvI2WBFVyyjS+Oo1m6bML756YzTnit4zB8ztpwWf8ZrU7b52zeWIK?=
 =?us-ascii?Q?KXQNllRm6BmUQ4BCP34/dD4wfkPHINe6kWIjLqkHuqGpOVh/B3sVnzKYWbUI?=
 =?us-ascii?Q?2LyPdbn5e7l0TGrNu6inlEktYL53+/TzBdnHndwMnVKEG/FvcwUKRVSM1vLo?=
 =?us-ascii?Q?0jP+H0+tvXUwV+aIQl9s7er4UuUDTzxyfi28dC+bDqjAIu8AGwAuakZDTSMp?=
 =?us-ascii?Q?twg67rodqdKi0EowLvXprpquxsgxHDyZ8jdlXf1Q5S42Veh47LKgFjF2h5OK?=
 =?us-ascii?Q?WZUihBm711WiRdYgCoHxHVUwJCIVIWE2E1tG7bW8c+0Y0/MIYQSqHbxZhQK+?=
 =?us-ascii?Q?G9N3k6/j80jS6X9TcOixiHMeu+39y0puZ8K89E+LOVfBAf4r64Rby2TsG25u?=
 =?us-ascii?Q?nOosi5OhUndqknjF9kXPn8v3KVJoyp6RwvJIvpihj0JwUdt9zmVTC3ASWi88?=
 =?us-ascii?Q?bYya5+5RMviQcZ08311ig7xS2X04i7XkajPyjKFrHs5ZyeNUkAeqpm/7Pb/C?=
 =?us-ascii?Q?rtiEem+Bb1v47JweIvn5yL/ANMhKZfmSLVki5ZVqBSTVLtIie3SKc7frIlAC?=
 =?us-ascii?Q?hRXdVDqe70q+9Nz32nbKGswePz0UINepyMJtBoEqpQa8pooLfk8osrVrmgqQ?=
 =?us-ascii?Q?KgOcWrgKrA=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58febeda-276f-40e5-57fe-08df1228fb34
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 06:25:33.6930
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GGjyvrwfQ1EmP9eIyw7Hou/Lx5ks9R5RvcjyvpRJwv0XztGKTYTFc4TAPWUSGcAp9Y+4F0NVcyJSu61aTBGpPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR10MB9082
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 14 Sep 2026 06:25:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24167

From: Jan Kiszka <jan.kiszka@siemens.com>

U-Boot was so far not enumerating the fTPM device, and that caused the
PCRs to stay zero. systemd-cryptenroll was complaining already, just not
loud enough.

With these extra patches (currently under review upstream), we are
getting a TPM right before the EFI loader starts, and we get valid PCR
content as well.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

Another partial update, avoiding a duplicate registration issue with the=20
fTPM. Hopefully the last one.

 ...ement-Fix-compilation-for-non-sandbo.patch |  43 +++++
 ...-out-service-enumeration-and-binding.patch |  96 +++++++++++
 ...-optee-Avoid-binding-a-service-twice.patch |  42 +++++
 ...pport-for-enumerating-services-that-.patch | 156 ++++++++++++++++++
 ...-warn-about-TEE_ERROR_STORAGE_NOT_AV.patch |  34 ++++
 ...to-optee-after-a-successful-mmc_init.patch |  43 +++++
 ...-MMC-Device-not-found-a-debug-output.patch |  52 ++++++
 recipes-bsp/u-boot/u-boot-common-2026.01.inc  |   7 +
 8 files changed, 473 insertions(+)
 create mode 100644 recipes-bsp/u-boot/files/0001-test-boot-measurement-Fix=
-compilation-for-non-sandbo.patch
 create mode 100644 recipes-bsp/u-boot/files/0002-tee-optee-Factor-out-serv=
ice-enumeration-and-binding.patch
 create mode 100644 recipes-bsp/u-boot/files/0003-tee-optee-Avoid-binding-a=
-service-twice.patch
 create mode 100644 recipes-bsp/u-boot/files/0004-tee-optee-Add-support-for=
-enumerating-services-that-.patch
 create mode 100644 recipes-bsp/u-boot/files/0005-tee-optee-Do-not-warn-abo=
ut-TEE_ERROR_STORAGE_NOT_AV.patch
 create mode 100644 recipes-bsp/u-boot/files/0006-mmc-Call-back-to-optee-af=
ter-a-successful-mmc_init.patch
 create mode 100644 recipes-bsp/u-boot/files/0007-mmc-Make-MMC-Device-not-f=
ound-a-debug-output.patch

diff --git a/recipes-bsp/u-boot/files/0001-test-boot-measurement-Fix-compil=
ation-for-non-sandbo.patch b/recipes-bsp/u-boot/files/0001-test-boot-measur=
ement-Fix-compilation-for-non-sandbo.patch
new file mode 100644
index 00000000..aaa21aa8
--- /dev/null
+++ b/recipes-bsp/u-boot/files/0001-test-boot-measurement-Fix-compilation-f=
or-non-sandbo.patch
@@ -0,0 +1,43 @@
+From bb19b017d4d389b4ba9a08e35e4e19d39f552c5d Mon Sep 17 00:00:00 2001
+From: Jan Kiszka <jan.kiszka@siemens.com>
+Date: Thu, 20 Aug 2026 17:57:08 +0200
+Subject: [PATCH 1/7] test: boot: measurement: Fix compilation for non-sand=
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
index 00000000..807dbf94
--- /dev/null
+++ b/recipes-bsp/u-boot/files/0002-tee-optee-Factor-out-service-enumeratio=
n-and-binding.patch
@@ -0,0 +1,96 @@
+From fb3993d9059fc531a13702378a8a416fe2455c12 Mon Sep 17 00:00:00 2001
+From: Jan Kiszka <jan.kiszka@siemens.com>
+Date: Sun, 23 Aug 2026 20:25:03 +0200
+Subject: [PATCH 2/7] tee: optee: Factor out service enumeration and bindin=
g
+ functions
+
+This already avoids code duplication between the different enumeration
+commands. It will furthermore allow to implement a third one for
+services with RPMB needs.
+
+Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
+Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
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
diff --git a/recipes-bsp/u-boot/files/0003-tee-optee-Avoid-binding-a-servic=
e-twice.patch b/recipes-bsp/u-boot/files/0003-tee-optee-Avoid-binding-a-ser=
vice-twice.patch
new file mode 100644
index 00000000..9c0aefc1
--- /dev/null
+++ b/recipes-bsp/u-boot/files/0003-tee-optee-Avoid-binding-a-service-twice=
.patch
@@ -0,0 +1,42 @@
+From 7807c02e3295a7e13cb386c31266f440baac10c3 Mon Sep 17 00:00:00 2001
+From: Jan Kiszka <jan.kiszka@siemens.com>
+Date: Thu, 10 Sep 2026 07:58:33 +0200
+Subject: [PATCH 3/7] tee: optee: Avoid binding a service twice
+
+In case optee_bind_services is invoked more than once successfully, make
+sure that already bound services are not rebound, creating multiple
+instances of themselves. When introducing RPMB-driven service scanning
+this scenario could pop up.
+
+Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
+---
+ drivers/tee/optee/core.c | 6 ++++++
+ 1 file changed, 6 insertions(+)
+
+diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
+index 1893ae25137..8920f348137 100644
+--- a/drivers/tee/optee/core.c
++++ b/drivers/tee/optee/core.c
+@@ -83,6 +83,7 @@ static int bind_service_list(struct udevice *dev, struct=
 tee_shm *service_list,
+ {
+ 	const struct tee_optee_ta_uuid *service_uuid =3D (const void *)service_l=
ist->addr;
+ 	struct optee_service *service;
++	struct udevice *service_dev;
+ 	size_t idx;
+ 	int ret;
+=20
+@@ -91,6 +92,11 @@ static int bind_service_list(struct udevice *dev, struc=
t tee_shm *service_list,
+ 		if (!service)
+ 			continue;
+=20
++		ret =3D device_find_child_by_name(dev, service->driver_name,
++						&service_dev);
++		if (!ret && dev_get_flags(service_dev) & DM_FLAG_BOUND)
++			continue;
++
+ 		ret =3D device_bind_driver_to_node(dev, service->driver_name, service->=
driver_name,
+ 						 dev_ofnode(dev), NULL);
+ 		if (ret) {
+--=20
+2.47.3
+
diff --git a/recipes-bsp/u-boot/files/0004-tee-optee-Add-support-for-enumer=
ating-services-that-.patch b/recipes-bsp/u-boot/files/0004-tee-optee-Add-su=
pport-for-enumerating-services-that-.patch
new file mode 100644
index 00000000..d0625469
--- /dev/null
+++ b/recipes-bsp/u-boot/files/0004-tee-optee-Add-support-for-enumerating-s=
ervices-that-.patch
@@ -0,0 +1,156 @@
+From 4880f93eac7cce03d6330bea2d651b5829b01088 Mon Sep 17 00:00:00 2001
+From: Jan Kiszka <jan.kiszka@siemens.com>
+Date: Fri, 21 Aug 2026 08:39:26 +0200
+Subject: [PATCH 4/7] tee: optee: Add support for enumerating services that
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
+index 8920f348137..e5dbbf00410 100644
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
+@@ -201,8 +188,8 @@ int optee_bind_services(struct udevice *dev, u32 tee_s=
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
+@@ -210,13 +197,18 @@ static int bind_service_drivers(struct udevice *dev)
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
diff --git a/recipes-bsp/u-boot/files/0005-tee-optee-Do-not-warn-about-TEE_=
ERROR_STORAGE_NOT_AV.patch b/recipes-bsp/u-boot/files/0005-tee-optee-Do-not=
-warn-about-TEE_ERROR_STORAGE_NOT_AV.patch
new file mode 100644
index 00000000..451dbdd1
--- /dev/null
+++ b/recipes-bsp/u-boot/files/0005-tee-optee-Do-not-warn-about-TEE_ERROR_S=
TORAGE_NOT_AV.patch
@@ -0,0 +1,34 @@
+From 9c5619a48894f01010b3af306f722727072b5873 Mon Sep 17 00:00:00 2001
+From: Jan Kiszka <jan.kiszka@siemens.com>
+Date: Fri, 21 Aug 2026 09:02:23 +0200
+Subject: [PATCH 5/7] tee: optee: Do not warn about
+ TEE_ERROR_STORAGE_NOT_AVAILABLE
+
+This is a transitional error that is resolved once an RPMB becomes
+available. Keep it as debug output only.
+
+Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
+Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
+---
+ drivers/tee/optee/core.c | 5 ++++-
+ 1 file changed, 4 insertions(+), 1 deletion(-)
+
+diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
+index e5dbbf00410..9bedc4e427d 100644
+--- a/drivers/tee/optee/core.c
++++ b/drivers/tee/optee/core.c
+@@ -112,7 +112,10 @@ static int __enum_services(struct udevice *dev, struc=
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
diff --git a/recipes-bsp/u-boot/files/0006-mmc-Call-back-to-optee-after-a-s=
uccessful-mmc_init.patch b/recipes-bsp/u-boot/files/0006-mmc-Call-back-to-o=
ptee-after-a-successful-mmc_init.patch
new file mode 100644
index 00000000..d9941551
--- /dev/null
+++ b/recipes-bsp/u-boot/files/0006-mmc-Call-back-to-optee-after-a-successf=
ul-mmc_init.patch
@@ -0,0 +1,43 @@
+From 5344b42a1bbb74cead765f335c2ae07f4bdb1280 Mon Sep 17 00:00:00 2001
+From: Jan Kiszka <jan.kiszka@siemens.com>
+Date: Fri, 21 Aug 2026 08:49:05 +0200
+Subject: [PATCH 6/7] mmc: Call back to optee after a successful mmc_init
+
+This is needed to that OP-TEE can re-enumerate services which need RPMB
+access that may have become available now.
+
+Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
+Reviewed-by: Peng Fan <peng.fan@nxp.com>
+Reviewed-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
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
diff --git a/recipes-bsp/u-boot/files/0007-mmc-Make-MMC-Device-not-found-a-=
debug-output.patch b/recipes-bsp/u-boot/files/0007-mmc-Make-MMC-Device-not-=
found-a-debug-output.patch
new file mode 100644
index 00000000..f52714d5
--- /dev/null
+++ b/recipes-bsp/u-boot/files/0007-mmc-Make-MMC-Device-not-found-a-debug-o=
utput.patch
@@ -0,0 +1,52 @@
+From 0a2e835c8c90a01fe1a6663c183dd9d643456e9c Mon Sep 17 00:00:00 2001
+From: Jan Kiszka <jan.kiszka@siemens.com>
+Date: Fri, 21 Aug 2026 11:00:09 +0200
+Subject: [PATCH 7/7] mmc: Make "MMC Device not found" a debug output
+
+Callers of find_mmc_device are generally processing and informing about
+errors already, e.g.
+
+=3D> mmc dev 2
+MMC Device 2 not found
+no mmc device at slot 2
+
+Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
+Reviewed-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
+
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
index 850847fd..9038dc78 100644
--- a/recipes-bsp/u-boot/u-boot-common-2026.01.inc
+++ b/recipes-bsp/u-boot/u-boot-common-2026.01.inc
@@ -26,6 +26,13 @@ SRC_URI +=3D " \
     file://0001-riscv-create-a-custom-CPU-implementation-for-PolarFi.patch=
 \
     file://0002-riscv-mpfs-move-SoC-level-options-to-the-CPU-Kconfig.patch=
 \
     file://0003-riscv-Add-support-for-BeagleV-Fire.patch \
+    file://0001-test-boot-measurement-Fix-compilation-for-non-sandbo.patch=
 \
+    file://0002-tee-optee-Factor-out-service-enumeration-and-binding.patch=
 \
+    file://0003-tee-optee-Avoid-binding-a-service-twice.patch \
+    file://0004-tee-optee-Add-support-for-enumerating-services-that-.patch=
 \
+    file://0005-tee-optee-Do-not-warn-about-TEE_ERROR_STORAGE_NOT_AV.patch=
 \
+    file://0006-mmc-Call-back-to-optee-after-a-successful-mmc_init.patch \
+    file://0007-mmc-Make-MMC-Device-not-found-a-debug-output.patch \
     file://rules.tmpl;subdir=3Ddebian"
 SRC_URI[sha256sum] =3D "b60d5865cefdbc75da8da4156c56c458e00de75a49b80c1a2e=
58a96e30ad0d54"
=20
--=20
2.47.3


