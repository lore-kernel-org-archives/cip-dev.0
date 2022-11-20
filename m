Return-Path: <sven.schultschik@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7FAEC4332F
	for <webhook@archiver.kernel.org>; Sun, 20 Nov 2022 20:49:32 +0000 (UTC)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (EUR04-DB3-obe.outbound.protection.outlook.com [40.107.6.68])
 by mx.groups.io with SMTP id smtpd.web11.22483.1668977365343400805
 for <cip-dev@lists.cip-project.org>;
 Sun, 20 Nov 2022 12:49:26 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=Z0dusIhj;
 spf=pass (domain: siemens.com, ip: 40.107.6.68, mailfrom: sven.schultschik@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hL3BjsB7JLczsH3EMX3KQCXJm2271WWfi3CmLbQlIBXd4ZuQ2hL5uCnxDmigapawrbQIaqwVdLwO+xWv2EMf76UUd2aokuYl7o7tCuXLDmxKRrQkHTOxzMnspeWZSH2LDi6LAhXv75wi2fv9eOyCGXjnxiyqz25UMXiWNuHQOSDnbNGkPNsWGOK7ULeJM3DNqkpEY82yJRtYh7ldzZsncvRA3bNZPqTJ0eGzD79NlsdtT3x4iKsb5YSau2hMonTc+xrD95OAuFEc6inTmn2L+Q9CAJkQs4FdpO7mmV7FbaBsnZV5yrnKO63/YsLOSqO3qZkk5PA9iKmTLTXZO/23qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Wo2Ra39gq/Pw+esZstrP0YXRbmJJKvHTKntf7zcmr4=;
 b=CF90JP/2UQMQmeXi3ERy4zhJZXPDcYE64GYUtNTYV5QvR+epC8C6Sc68+RsFHsD2ce17+BUbws+lw5xXJdEQcbiDMNT6XyhBuRRs/ORU26novfOXRq6bGLfngSYJFQHRamX4hTgOfma94AkLl/cQOHyg+gAdm20ElP/duN4eZdwcvnlWM3vhSqV3Abj5ojJBu5a20wZsSV0iwjZR6mv051uiMRhhQl/mYI0v1KnNGT3yL0nptBj43dpaRGNT/SZaGgQgRK8ZQdS7cg2dOp4GBDbyclEm/uZgE3MSCO0OHeSk3WXFVkqaNzXt8mczeYB93t7hBxx82Y16nTbtZcp6yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Wo2Ra39gq/Pw+esZstrP0YXRbmJJKvHTKntf7zcmr4=;
 b=Z0dusIhjZjSHfqOnXiL/SqWIfmS5nRuRWu1LyIWa5u9OAXuVEauQjFzyufzKJ/4AQAWopPXfRzSp8/GxRqmn06Pu5ChxHVIGKwFa516uqjcY+abIFxuBEOqt4pdxMtLOAv/B/YWxCAg/aa27iHrHq8tXLOszSMcwNx/iec+PqzJD8X9kaeF8hnArApn6FVUOYJP/44PAa9p6MiMyAEhINcqfIHH6Dy/NeWVmSsbQvvqXgVP4FUI/zAygOBqctXv6sR7g5hoqy+XUn2m7bW1w+Y6Xs5K6MmWyLhhSSZaW/tAhfySJDTIL8O+d7FirbXtjH+02rZ4Rh14cwUVVRdZ0vQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:210::11)
 by DU0PR10MB7094.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:42e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.11; Sun, 20 Nov
 2022 20:49:21 +0000
Received: from PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::955a:f715:5319:7933]) by PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::955a:f715:5319:7933%9]) with mapi id 15.20.5834.015; Sun, 20 Nov 2022
 20:49:21 +0000
From: sven.schultschik@siemens.com
To: cip-dev@lists.cip-project.org
CC: jan.kiszka@siemens.com,
	Sven Schultschik <sven.schultschik@siemens.com>
Subject: [isar-cip-core][PATCH 4/8] add u-boot patch for qemu to support RPMB
Date: Sun, 20 Nov 2022 21:47:07 +0100
Message-ID: <20221120204711.5826-5-sven.schultschik@siemens.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221120204711.5826-1-sven.schultschik@siemens.com>
References: <20221120204711.5826-1-sven.schultschik@siemens.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0127.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:94::13) To PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:210::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR10MB5037:EE_|DU0PR10MB7094:EE_
X-MS-Office365-Filtering-Correlation-Id: d726968c-b2b1-4287-74e9-08dacb38b1fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	sb/dP+cBv701FKpg/VRhTf2A8cAnnl3dgUhiflUgUumYCdV0h5mmByMjfsRiGxxE8tJ8iSnMK4BnHZRSVjsEAL2AwuoI/a4HA+sqKyPJHF74YqsaXt+omoqIt+imqvr2hGVt5grRBE4+kw4N7zX6SeQtYkSWp8vPoM+p7QVUFTzy/z47hM2ZRYwS9WYELFwLnEwW2s7gZpp6NLYGih0P0CUWNjF2ik7z9+HijufYQ05CVJYe1hypAH/fEgo/tq7/G1aFEmwvoWAvK/EujUV9Tc7tGHMcFiCL2gZ6IagWxyWscYY8FaWeYoSmsGGtCQRERmhTu2cbxaZnCnnysGCHO01D8vu2lW1vgX22bbeeerdfkOatmxDXTpoUvxYM/NcA6/0UL+iAYxlQR6obuaRM3RV20gHMck7e9nFa8htIw0nab+A0JBUwVdXWbr5rMmt3Lwc0teXeIfXcBGL18jzYfczwLtKX//rPzyl95IUL8/PcobB2HwP8ZA/405WCInJaRjmHhLjVqdEY0vZy/FkGP6vZCXZ8z4znAeTi3BGRLLcF/MGuOT/4JVXpOVrof+WLjoYMb+9vqk6hX3KacsrO+iaDWMda9gQI1gkr1ygIc0CNfrv5mfhk+1MZZ0peTUQH5FkOEJ+jGUshSw8+cHEV6A==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(366004)(396003)(346002)(39860400002)(376002)(451199015)(2906002)(26005)(83380400001)(9686003)(86362001)(4326008)(6512007)(8676002)(66556008)(66476007)(82960400001)(66946007)(38100700002)(36756003)(41300700001)(30864003)(6916009)(8936002)(5660300002)(316002)(107886003)(55236004)(478600001)(186003)(1076003)(6486002)(6666004)(2616005)(6506007)(579004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?wNktTPfl5K9v3ERqBTTz71Zttv4FA6gtJZKB6vLaQwvL4Euh1IhGHO0kGp3i?=
 =?us-ascii?Q?3ZuWrJIdN0URVBEETCbLd3UF7yiwc4Ned/wlRPN27qSlBMYdl/h4WHX8mA5h?=
 =?us-ascii?Q?7oO+nYrxTNbPnNkjzMYpyDlVD+hQQVvmtquRRzffSsaBV1YJ90Wq9NcHgcok?=
 =?us-ascii?Q?vTfV/3dNGATo/jya96yP7DmQwBJkVEdwjX6cv08MIYPlKnm7WHEoN+BCa6ws?=
 =?us-ascii?Q?AW5NUb1oki7VjYTOFClKs50tL/l9dSbT/9qce9do0tm3jhRcZ9QmMbwztNOk?=
 =?us-ascii?Q?nrlSJLtzBge7ZgNAk8TFZ5LpQewzaG/MdkK2BRsEq84RMdnJQSfw//T5c+jF?=
 =?us-ascii?Q?blC6mOwN+dBstiCtPuqMQZORu0loKY+9QwW2irYolKCbwrPTY7mZifk4503n?=
 =?us-ascii?Q?OXHPfilGjKIRTR0bO4Rlq29UtrBz0RbMcDzbXQSSlbP4hz/io+Q7pRN18w95?=
 =?us-ascii?Q?+lmFZsrBKK2MOhjn8B2WMIEvAU6Yxz2kezUsjpp8USlkmYirLic8MKqOGnvI?=
 =?us-ascii?Q?imreY3oGzAQ/jp3MBWcR+3mppSm18i8U7ZeQ7BUur/h69OJZl+VIN0WZidkA?=
 =?us-ascii?Q?p84Gub+15GC3Lvz5XaOIqf4YPE7tXGjCEjnfSjxUmL97mt20zX82SCn5oJsd?=
 =?us-ascii?Q?cvbxsAhWnL4sTHtFgZ9102kGTtocY5wofRgxB6IMA7M6mORXX74T3wzBfQmp?=
 =?us-ascii?Q?Rx58pLWk2IZrn5KJMc8qmlKVisu7xlXjs4x+SFYLQibB+38FbMMCpI7JmxpB?=
 =?us-ascii?Q?2IKwJvZjbqtZ1HuEWVmrwsWYgX/3iYrp+KAj4FwAz6a9MF4ko/yPtOUR3Vxo?=
 =?us-ascii?Q?TKdsf6kna5p+NfpVrXX2c18+H5wZ2g6KtMsIgYkAzV/r9m4zEI1uN/znoPAY?=
 =?us-ascii?Q?casp/htbUUkXxi6Ics/1K4DQK1p3Iczyvpc5yEhEdAvnPB7K6W2d13wYlA1y?=
 =?us-ascii?Q?+OhIzW2Q3aHSZDeU3WHmjQsjgRUTtYVuzb4AxdMYhdrI3wYxjpm8lWDGaaIc?=
 =?us-ascii?Q?CnoBf89et3dT/SAPlkM1qd7uPW4qUaKo+eQAwPAOeFr0JT1ZEAPBCin1zlmb?=
 =?us-ascii?Q?c5V+O8fyiRcUmB8Mwvxez6OmhRqguYhBHluai1MzjaQkup9KHuohi1oJAwyt?=
 =?us-ascii?Q?1jOM4BJN7vZaysEe4cWyMDm9qieREh7O43nxnmjwuvj0Hp48xA4WNs0H57JD?=
 =?us-ascii?Q?u8LVeXbncb0YOsiwye/RDUjlSzOzHL5Z3qtluHsRo+NRmQw/o4rMEQi2NHt0?=
 =?us-ascii?Q?A5GIWrdQK8X5zURT+yIk0FgSvyq0uu2X8sMMbam6nTK1nrF9BhzrJpAoBiFc?=
 =?us-ascii?Q?6VI99MBNZwUz9UheknZR5dr37jOaT8PeAAO1BAmxlHBxgTFDz1Yk9VkUQ/1u?=
 =?us-ascii?Q?mSw1McBcRKStx26LaBRGIHQ//IWXNUwAn0o5FG3y5dKGrFW+P9e1CVKtfpSH?=
 =?us-ascii?Q?hvznvsnw/gmIXR2aTXpb2f2mmA+0MmIG2S0MWAj8ZmhKPeALg8hKWQGGAX2O?=
 =?us-ascii?Q?mMYpGgwNa+bjsmlacvTYemeDpgLICB9e+Q8rsy2XalQD6WnwIisX7Db/7b9V?=
 =?us-ascii?Q?2ylpDkI8caHBt9Q6Yx74mvXzV0Z+TzdR0PfhWOEpAW4Ur6YFSvWVJFAHNOnQ?=
 =?us-ascii?Q?rA=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d726968c-b2b1-4287-74e9-08dacb38b1fc
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2022 20:49:20.8579
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BEwM2I17jhkyDssjUZl5CF8oPR55AwT9LPRrt65F1tFIjKXAA83AjmMcBwZuoMXm2dpafTd9TlZANO+grcn47bMnXPPR8dmE0O57MTGaMC4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7094
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 20 Nov 2022 20:49:32 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10057

From: Sven Schultschik <sven.schultschik@siemens.com>

Qemu itself is missing a implemented emulation of an RPBM (replay protected=
 memory) which is part of an emmc. Therefore currently a u-boot patch, whic=
h adds a RPMB emulation, is needed which breaks the u-boot hardware support=
. The patch is only included into the qemu u-boot recipes and can be remove=
d if there is an official qemu rpmb emulation, which currently does not hav=
e any ETA.

Signed-off-by: Sven Schultschik <sven.schultschik@siemens.com>
---
 ...hack.-Breaks-proper-hardware-support.patch | 1375 +++++++++++++++++
 recipes-bsp/u-boot/u-boot-qemu-common.inc     |    3 +
 2 files changed, 1378 insertions(+)
 create mode 100644 recipes-bsp/u-boot/files/0002-rpmb-emulation-hack.-Brea=
ks-proper-hardware-support.patch

diff --git a/recipes-bsp/u-boot/files/0002-rpmb-emulation-hack.-Breaks-prop=
er-hardware-support.patch b/recipes-bsp/u-boot/files/0002-rpmb-emulation-ha=
ck.-Breaks-proper-hardware-support.patch
new file mode 100644
index 0000000..26266b5
--- /dev/null
+++ b/recipes-bsp/u-boot/files/0002-rpmb-emulation-hack.-Breaks-proper-hard=
ware-support.patch
@@ -0,0 +1,1375 @@
+From a4179f663673dbfa48f79761acc3ff781ee9b2b8 Mon Sep 17 00:00:00 2001
+From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
+Date: Thu, 12 Nov 2020 09:44:54 +0200
+Subject: [PATCH] irpmb patch hack
+
+Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
+---
+ arch/arm/include/asm/gpio.h   |   3 +-
+ arch/arm/include/asm/ioctl.h  |   1 +
+ configs/qemu_tfa_mm_defconfig |  53 ++++
+ drivers/tee/optee/Makefile    |   1 +
+ drivers/tee/optee/hmac_sha2.c | 126 ++++++++
+ drivers/tee/optee/hmac_sha2.h |  74 +++++
+ drivers/tee/optee/rpmb.c      |  27 +-
+ drivers/tee/optee/rpmb.h      |   1 +
+ drivers/tee/optee/rpmb_emu.c  | 563 ++++++++++++++++++++++++++++++++++
+ drivers/tee/optee/rpmb_emu.h  | 141 +++++++++
+ drivers/tee/optee/sha2.c      | 249 +++++++++++++++
+ drivers/tee/optee/sha2.h      |  75 +++++
+ 12 files changed, 1292 insertions(+), 22 deletions(-)
+ create mode 100644 arch/arm/include/asm/ioctl.h
+ create mode 100644 configs/qemu_tfa_mm_defconfig
+ create mode 100644 drivers/tee/optee/hmac_sha2.c
+ create mode 100644 drivers/tee/optee/hmac_sha2.h
+ create mode 100644 drivers/tee/optee/rpmb.h
+ create mode 100644 drivers/tee/optee/rpmb_emu.c
+ create mode 100644 drivers/tee/optee/rpmb_emu.h
+ create mode 100644 drivers/tee/optee/sha2.c
+ create mode 100644 drivers/tee/optee/sha2.h
+
+diff --git a/arch/arm/include/asm/ioctl.h b/arch/arm/include/asm/ioctl.h
+new file mode 100644
+index 000000000000..b279fe06dfe5
+--- /dev/null
++++ b/arch/arm/include/asm/ioctl.h
+@@ -0,0 +1 @@
++#include <asm-generic/ioctl.h>
+diff --git a/drivers/tee/optee/Makefile b/drivers/tee/optee/Makefile
+index 928d3f80027f..28108536d231 100644
+--- a/drivers/tee/optee/Makefile
++++ b/drivers/tee/optee/Makefile
+@@ -3,3 +3,4 @@
+ obj-y +=3D core.o
+ obj-y +=3D supplicant.o
+ obj-$(CONFIG_SUPPORT_EMMC_RPMB) +=3D rpmb.o
++obj-y +=3D sha2.o hmac_sha2.o rpmb_emu.o rpmb.o
+diff --git a/drivers/tee/optee/hmac_sha2.c b/drivers/tee/optee/hmac_sha2.c
+new file mode 100644
+index 000000000000..61b24b128f1d
+--- /dev/null
++++ b/drivers/tee/optee/hmac_sha2.c
+@@ -0,0 +1,126 @@
++/*
++ * HMAC-SHA-224/256/384/512 implementation
++ * Last update: 06/15/2005
++ * Issue date:  06/15/2005
++ *
++ * Copyright (C) 2005 Olivier Gay <olivier.gay@a3.epfl.ch>
++ * All rights reserved.
++ *
++ * Copyright (c) 2016, Linaro Limited
++ * All rights reserved.
++ *
++ * Redistribution and use in source and binary forms, with or without
++ * modification, are permitted provided that the following conditions
++ * are met:
++ * 1. Redistributions of source code must retain the above copyright
++ *    notice, this list of conditions and the following disclaimer.
++ * 2. Redistributions in binary form must reproduce the above copyright
++ *    notice, this list of conditions and the following disclaimer in the
++ *    documentation and/or other materials provided with the distribution=
.
++ * 3. Neither the name of the project nor the names of its contributors
++ *    may be used to endorse or promote products derived from this softwa=
re
++ *    without specific prior written permission.
++ *
++ * THIS SOFTWARE IS PROVIDED BY THE PROJECT AND CONTRIBUTORS ``AS IS'' AN=
D
++ * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
++ * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PUR=
POSE
++ * ARE DISCLAIMED.  IN NO EVENT SHALL THE PROJECT OR CONTRIBUTORS BE LIAB=
LE
++ * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUEN=
TIAL
++ * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOOD=
S
++ * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
++ * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, ST=
RICT
++ * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY =
WAY
++ * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
++ * SUCH DAMAGE.
++ */
++
++#include <string.h>
++
++#include "hmac_sha2.h"
++
++/* HMAC-SHA-256 functions */
++
++void hmac_sha256_init(hmac_sha256_ctx *ctx, const unsigned char *key,
++                      unsigned int key_size)
++{
++    unsigned int fill =3D 0;
++    unsigned int num =3D 0;
++    const unsigned char *key_used =3D NULL;
++    unsigned char key_temp[SHA256_DIGEST_SIZE] =3D { 0 };
++    int i =3D 0;
++
++    if (key_size =3D=3D SHA256_BLOCK_SIZE) {
++        key_used =3D key;
++        num =3D SHA256_BLOCK_SIZE;
++    } else {
++        if (key_size > SHA256_BLOCK_SIZE){
++            num =3D SHA256_DIGEST_SIZE;
++            sha256(key, key_size, key_temp);
++            key_used =3D key_temp;
++        } else { /* key_size > SHA256_BLOCK_SIZE */
++            key_used =3D key;
++            num =3D key_size;
++        }
++        fill =3D SHA256_BLOCK_SIZE - num;
++
++        memset(ctx->block_ipad + num, 0x36, fill);
++        memset(ctx->block_opad + num, 0x5c, fill);
++    }
++
++    for (i =3D 0; i < (int) num; i++) {
++        ctx->block_ipad[i] =3D key_used[i] ^ 0x36;
++        ctx->block_opad[i] =3D key_used[i] ^ 0x5c;
++    }
++
++    sha256_init(&ctx->ctx_inside);
++    sha256_update_tee(&ctx->ctx_inside, ctx->block_ipad, SHA256_BLOCK_SIZ=
E);
++
++    sha256_init(&ctx->ctx_outside);
++    sha256_update_tee(&ctx->ctx_outside, ctx->block_opad,
++                  SHA256_BLOCK_SIZE);
++
++    /* for hmac_reinit */
++    memcpy(&ctx->ctx_inside_reinit, &ctx->ctx_inside,
++           sizeof(sha256_ctx));
++    memcpy(&ctx->ctx_outside_reinit, &ctx->ctx_outside,
++           sizeof(sha256_ctx));
++}
++
++void hmac_sha256_reinit(hmac_sha256_ctx *ctx)
++{
++    memcpy(&ctx->ctx_inside, &ctx->ctx_inside_reinit,
++           sizeof(sha256_ctx));
++    memcpy(&ctx->ctx_outside, &ctx->ctx_outside_reinit,
++           sizeof(sha256_ctx));
++}
++
++void hmac_sha256_update(hmac_sha256_ctx *ctx, const unsigned char *messag=
e,
++                        unsigned int message_len)
++{
++    sha256_update_tee(&ctx->ctx_inside, message, message_len);
++}
++
++void hmac_sha256_final(hmac_sha256_ctx *ctx, unsigned char *mac,
++                       unsigned int mac_size)
++{
++    unsigned char digest_inside[SHA256_DIGEST_SIZE] =3D { 0 };
++    unsigned char mac_temp[SHA256_DIGEST_SIZE] =3D { 0 };
++
++    sha256_final(&ctx->ctx_inside, digest_inside);
++    sha256_update_tee(&ctx->ctx_outside, digest_inside, SHA256_DIGEST_SIZ=
E);
++    sha256_final(&ctx->ctx_outside, mac_temp);
++    memcpy(mac, mac_temp, mac_size);
++}
++
++void hmac_sha256(const unsigned char *key, unsigned int key_size,
++          const unsigned char *message, unsigned int message_len,
++          unsigned char *mac, unsigned mac_size)
++{
++    hmac_sha256_ctx ctx;
++
++    memset(&ctx, 0, sizeof(ctx));
++
++    hmac_sha256_init(&ctx, key, key_size);
++    hmac_sha256_update(&ctx, message, message_len);
++    hmac_sha256_final(&ctx, mac, mac_size);
++}
+diff --git a/drivers/tee/optee/hmac_sha2.h b/drivers/tee/optee/hmac_sha2.h
+new file mode 100644
+index 000000000000..1044524d75c5
+--- /dev/null
++++ b/drivers/tee/optee/hmac_sha2.h
+@@ -0,0 +1,74 @@
++/*
++ * HMAC-SHA-224/256/384/512 implementation
++ * Last update: 06/15/2005
++ * Issue date:  06/15/2005
++ *
++ * Copyright (C) 2005 Olivier Gay <olivier.gay@a3.epfl.ch>
++ * All rights reserved.
++ *
++ * Copyright (c) 2016, Linaro Limited
++ * All rights reserved.
++ *
++ * Redistribution and use in source and binary forms, with or without
++ * modification, are permitted provided that the following conditions
++ * are met:
++ * 1. Redistributions of source code must retain the above copyright
++ *    notice, this list of conditions and the following disclaimer.
++ * 2. Redistributions in binary form must reproduce the above copyright
++ *    notice, this list of conditions and the following disclaimer in the
++ *    documentation and/or other materials provided with the distribution=
.
++ * 3. Neither the name of the project nor the names of its contributors
++ *    may be used to endorse or promote products derived from this softwa=
re
++ *    without specific prior written permission.
++ *
++ * THIS SOFTWARE IS PROVIDED BY THE PROJECT AND CONTRIBUTORS ``AS IS'' AN=
D
++ * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
++ * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PUR=
POSE
++ * ARE DISCLAIMED.  IN NO EVENT SHALL THE PROJECT OR CONTRIBUTORS BE LIAB=
LE
++ * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUEN=
TIAL
++ * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOOD=
S
++ * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
++ * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, ST=
RICT
++ * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY =
WAY
++ * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
++ * SUCH DAMAGE.
++ */
++
++#ifndef HMAC_SHA2_H
++#define HMAC_SHA2_H
++
++#include "sha2.h"
++
++#ifdef __cplusplus
++extern "C" {
++#endif
++
++typedef struct {
++    sha256_ctx ctx_inside;
++    sha256_ctx ctx_outside;
++
++    /* for hmac_reinit */
++    sha256_ctx ctx_inside_reinit;
++    sha256_ctx ctx_outside_reinit;
++
++    unsigned char block_ipad[SHA256_BLOCK_SIZE];
++    unsigned char block_opad[SHA256_BLOCK_SIZE];
++} hmac_sha256_ctx;
++
++void hmac_sha256_init(hmac_sha256_ctx *ctx, const unsigned char *key,
++                      unsigned int key_size);
++void hmac_sha256_reinit(hmac_sha256_ctx *ctx);
++void hmac_sha256_update(hmac_sha256_ctx *ctx, const unsigned char *messag=
e,
++                        unsigned int message_len);
++void hmac_sha256_final(hmac_sha256_ctx *ctx, unsigned char *mac,
++                       unsigned int mac_size);
++void hmac_sha256(const unsigned char *key, unsigned int key_size,
++                 const unsigned char *message, unsigned int message_len,
++                 unsigned char *mac, unsigned mac_size);
++
++#ifdef __cplusplus
++}
++#endif
++
++#endif /* !HMAC_SHA2_H */
++
+diff --git a/drivers/tee/optee/rpmb.c b/drivers/tee/optee/rpmb.c
+index 0804fc963cf5..275f2112f102 100644
+--- a/drivers/tee/optee/rpmb.c
++++ b/drivers/tee/optee/rpmb.c
+@@ -12,35 +12,15 @@
+=20
+ #include "optee_msg.h"
+ #include "optee_private.h"
++#include "rpmb_emu.h"
+=20
+ /*
+  * Request and response definitions must be in sync with the secure side =
of
+  * OP-TEE.
+  */
+=20
+-/* Request */
+-struct rpmb_req {
+-	u16 cmd;
+-#define RPMB_CMD_DATA_REQ      0x00
+-#define RPMB_CMD_GET_DEV_INFO  0x01
+-	u16 dev_id;
+-	u16 block_count;
+-	/* Optional data frames (rpmb_data_frame) follow */
+-};
+-
+ #define RPMB_REQ_DATA(req) ((void *)((struct rpmb_req *)(req) + 1))
+=20
+-/* Response to device info request */
+-struct rpmb_dev_info {
+-	u8 cid[16];
+-	u8 rpmb_size_mult;	/* EXT CSD-slice 168: RPMB Size */
+-	u8 rel_wr_sec_c;	/* EXT CSD-slice 222: Reliable Write Sector */
+-				/*                    Count */
+-	u8 ret_code;
+-#define RPMB_CMD_GET_DEV_INFO_RET_OK     0x00
+-#define RPMB_CMD_GET_DEV_INFO_RET_ERROR  0x01
+-};
+-
+ static void release_mmc(struct optee_private *priv)
+ {
+ 	int rc;
+@@ -175,8 +155,13 @@ void optee_suppl_cmd_rpmb(struct udevice *dev, struct=
 optee_msg_arg *arg)
+ 	rsp_buf =3D (u8 *)rsp_shm->addr + arg->params[1].u.rmem.offs;
+ 	rsp_size =3D arg->params[1].u.rmem.size;
+=20
++#ifdef EMU
+ 	arg->ret =3D rpmb_process_request(dev_get_priv(dev), req_buf, req_size,
+ 					rsp_buf, rsp_size);
++#else
++	arg->ret =3D rpmb_process_request_emu(req_buf, req_size, rsp_buf,
++					    rsp_size);
++#endif
+ }
+=20
+ void optee_suppl_rpmb_release(struct udevice *dev)
+diff --git a/drivers/tee/optee/rpmb.h b/drivers/tee/optee/rpmb.h
+new file mode 100644
+index 000000000000..8b137891791f
+--- /dev/null
++++ b/drivers/tee/optee/rpmb.h
+@@ -0,0 +1 @@
++
+diff --git a/drivers/tee/optee/rpmb_emu.c b/drivers/tee/optee/rpmb_emu.c
+new file mode 100644
+index 000000000000..629f36ee6b29
+--- /dev/null
++++ b/drivers/tee/optee/rpmb_emu.c
+@@ -0,0 +1,563 @@
++// SPDX-License-Identifier: BSD-2-Clause
++/*
++ * Copyright (c) 2020 Linaro Limited
++ */
++
++#include <common.h>
++#include <dm.h>
++#include <hexdump.h>
++#include <log.h>
++#include <tee.h>
++#include <mmc.h>
++#include <dm/device_compat.h>
++
++#include "optee_msg.h"
++#include "optee_private.h"
++#include "sha2.h"
++#include "hmac_sha2.h"
++#include "rpmb_emu.h"
++
++static struct rpmb_emu rpmb_emu =3D {
++	.size =3D EMU_RPMB_SIZE_BYTES
++};
++
++static struct rpmb_emu *mem_for_fd(int fd)
++{
++	static int sfd =3D -1;
++
++	if (sfd =3D=3D -1)
++		sfd =3D fd;
++	if (sfd !=3D fd) {
++		printf("Emulating more than 1 RPMB partition is not supported\n");
++		return NULL;
++	}
++
++	return &rpmb_emu;
++}
++
++#if (DEBUGLEVEL >=3D TRACE_FLOW)
++static void dump_blocks(size_t startblk, size_t numblk, uint8_t *ptr,
++			bool to_mmc)
++{
++	char msg[100] =3D { 0 };
++	size_t i =3D 0;
++
++	for (i =3D 0; i < numblk; i++) {
++		snprintf(msg, sizeof(msg), "%s MMC block %zu",
++			 to_mmc ? "Write" : "Read", startblk + i);
++		//print_hex_dump_bytes("", DUMP_PREFIX_OFFSET, ptr, 256);
++		ptr +=3D 256;
++	}
++}
++#else
++static void dump_blocks(size_t startblk, size_t numblk, uint8_t *ptr,
++			bool to_mmc)
++{
++	(void)startblk;
++	(void)numblk;
++	(void)ptr;
++	(void)to_mmc;
++}
++#endif
++
++#define CUC(x) ((const unsigned char *)(x))
++static void hmac_update_frm(hmac_sha256_ctx *ctx, struct rpmb_data_frame =
*frm)
++{
++	hmac_sha256_update(ctx, CUC(frm->data), 256);
++	hmac_sha256_update(ctx, CUC(frm->nonce), 16);
++	hmac_sha256_update(ctx, CUC(&frm->write_counter), 4);
++	hmac_sha256_update(ctx, CUC(&frm->address), 2);
++	hmac_sha256_update(ctx, CUC(&frm->block_count), 2);
++	hmac_sha256_update(ctx, CUC(&frm->op_result), 2);
++	hmac_sha256_update(ctx, CUC(&frm->msg_type), 2);
++}
++
++static bool is_hmac_valid(struct rpmb_emu *mem, struct rpmb_data_frame *f=
rm,
++		   size_t nfrm)
++{
++	uint8_t mac[32] =3D { 0 };
++	size_t i =3D 0;
++	hmac_sha256_ctx ctx;
++
++	memset(&ctx, 0, sizeof(ctx));
++
++	if (!mem->key_set) {
++		printf("Cannot check MAC (key not set)\n");
++		return false;
++	}
++
++	hmac_sha256_init(&ctx, mem->key, sizeof(mem->key));
++	for (i =3D 0; i < nfrm; i++, frm++)
++		hmac_update_frm(&ctx, frm);
++	frm--;
++	hmac_sha256_final(&ctx, mac, 32);
++
++	if (memcmp(mac, frm->key_mac, 32)) {
++		printf("Invalid MAC\n");
++		return false;
++	}
++	return true;
++}
++
++static uint16_t gen_msb1st_result(uint8_t byte)
++{
++	return (uint16_t)byte << 8;
++}
++
++static uint16_t compute_hmac(struct rpmb_emu *mem, struct rpmb_data_frame=
 *frm,
++			     size_t nfrm)
++{
++	size_t i =3D 0;
++	hmac_sha256_ctx ctx;
++
++	memset(&ctx, 0, sizeof(ctx));
++
++	if (!mem->key_set) {
++		printf("Cannot compute MAC (key not set)\n");
++		return gen_msb1st_result(RPMB_RESULT_AUTH_KEY_NOT_PROGRAMMED);
++	}
++
++	hmac_sha256_init(&ctx, mem->key, sizeof(mem->key));
++	for (i =3D 0; i < nfrm; i++, frm++)
++		hmac_update_frm(&ctx, frm);
++	frm--;
++	hmac_sha256_final(&ctx, frm->key_mac, 32);
++
++	return gen_msb1st_result(RPMB_RESULT_OK);
++}
++
++static uint16_t ioctl_emu_mem_transfer(struct rpmb_emu *mem,
++				       struct rpmb_data_frame *frm,
++				       size_t nfrm, int to_mmc)
++{
++	size_t start =3D mem->last_op.address * 256;
++	size_t size =3D nfrm * 256;
++	size_t i =3D 0;
++	uint8_t *memptr =3D NULL;
++
++	if (start > mem->size || start + size > mem->size) {
++		printf("Transfer bounds exceeed emulated memory\n");
++		return gen_msb1st_result(RPMB_RESULT_ADDRESS_FAILURE);
++	}
++	if (to_mmc && !is_hmac_valid(mem, frm, nfrm))
++		return gen_msb1st_result(RPMB_RESULT_AUTH_FAILURE);
++
++	//printf("Transferring %zu 256-byte data block%s %s MMC (block offset=3D=
%zu)",
++	     //nfrm, (nfrm > 1) ? "s" : "", to_mmc ? "to" : "from", start / 256)=
;
++	for (i =3D 0; i < nfrm; i++) {
++		memptr =3D mem->buf + start + i * 256;
++		if (to_mmc) {
++			memcpy(memptr, frm[i].data, 256);
++			mem->write_counter++;
++			frm[i].write_counter =3D htonl(mem->write_counter);
++			frm[i].msg_type =3D
++				htons(RPMB_MSG_TYPE_RESP_AUTH_DATA_WRITE);
++		} else {
++			memcpy(frm[i].data, memptr, 256);
++			frm[i].msg_type =3D
++				htons(RPMB_MSG_TYPE_RESP_AUTH_DATA_READ);
++			frm[i].address =3D htons(mem->last_op.address);
++			frm[i].block_count =3D nfrm;
++			memcpy(frm[i].nonce, mem->nonce, 16);
++		}
++		frm[i].op_result =3D gen_msb1st_result(RPMB_RESULT_OK);
++	}
++	dump_blocks(mem->last_op.address, nfrm, mem->buf + start, to_mmc);
++
++	if (!to_mmc)
++		compute_hmac(mem, frm, nfrm);
++
++	return gen_msb1st_result(RPMB_RESULT_OK);
++}
++
++static void ioctl_emu_get_write_result(struct rpmb_emu *mem,
++				       struct rpmb_data_frame *frm)
++{
++	frm->msg_type =3D	htons(RPMB_MSG_TYPE_RESP_AUTH_DATA_WRITE);
++	frm->op_result =3D mem->last_op.op_result;
++	frm->address =3D htons(mem->last_op.address);
++	frm->write_counter =3D htonl(mem->write_counter);
++	compute_hmac(mem, frm, 1);
++}
++
++static uint16_t ioctl_emu_setkey(struct rpmb_emu *mem,
++				 struct rpmb_data_frame *frm)
++{
++	if (mem->key_set) {
++		printf("Key already set\n");
++		return gen_msb1st_result(RPMB_RESULT_GENERAL_FAILURE);
++	}
++	print_hex_dump_bytes("Setting Key:", DUMP_PREFIX_OFFSET, frm->key_mac,
++			     32);
++	memcpy(mem->key, frm->key_mac, 32);
++	mem->key_set =3D true;
++
++	return gen_msb1st_result(RPMB_RESULT_OK);
++}
++
++static void ioctl_emu_get_keyprog_result(struct rpmb_emu *mem,
++					 struct rpmb_data_frame *frm)
++{
++	frm->msg_type =3D
++		htons(RPMB_MSG_TYPE_RESP_AUTH_KEY_PROGRAM);
++	frm->op_result =3D mem->last_op.op_result;
++}
++
++static void ioctl_emu_read_ctr(struct rpmb_emu *mem,
++			       struct rpmb_data_frame *frm)
++{
++	printf("Reading counter\n");
++	frm->msg_type =3D htons(RPMB_MSG_TYPE_RESP_WRITE_COUNTER_VAL_READ);
++	frm->write_counter =3D htonl(mem->write_counter);
++	memcpy(frm->nonce, mem->nonce, 16);
++	frm->op_result =3D compute_hmac(mem, frm, 1);
++}
++
++static uint32_t read_cid(uint16_t dev_id, uint8_t *cid)
++{
++	/* Taken from an actual eMMC chip */
++	static const uint8_t test_cid[] =3D {
++		/* MID (Manufacturer ID): Micron */
++		0xfe,
++		/* CBX (Device/BGA): BGA */
++		0x01,
++		/* OID (OEM/Application ID) */
++		0x4e,
++		/* PNM (Product name) "MMC04G" */
++		0x4d, 0x4d, 0x43, 0x30, 0x34, 0x47,
++		/* PRV (Product revision): 4.2 */
++		0x42,
++		/* PSN (Product serial number) */
++		0xc8, 0xf6, 0x55, 0x2a,
++		/*
++		 * MDT (Manufacturing date):
++		 * June, 2014
++		 */
++		0x61,
++		/* (CRC7 (0xA) << 1) | 0x1 */
++		0x15
++	};
++
++	(void)dev_id;
++	memcpy(cid, test_cid, sizeof(test_cid));
++
++	return TEE_SUCCESS;
++}
++
++static void ioctl_emu_set_ext_csd(uint8_t *ext_csd)
++{
++	ext_csd[168] =3D EMU_RPMB_SIZE_MULT;
++	ext_csd[222] =3D EMU_RPMB_REL_WR_SEC_C;
++}
++
++/* A crude emulation of the MMC ioctls we need for RPMB */
++static int ioctl_emu(int fd, unsigned long request, ...)
++{
++	struct mmc_ioc_cmd *cmd =3D NULL;
++	struct rpmb_data_frame *frm =3D NULL;
++	uint16_t msg_type =3D 0;
++	struct rpmb_emu *mem =3D mem_for_fd(fd);
++	va_list ap;
++
++	if (request !=3D MMC_IOC_CMD) {
++		printf("Unsupported ioctl: 0x%lx\n", request);
++		return -1;
++	}
++	if (!mem)
++		return -1;
++
++	va_start(ap, request);
++	cmd =3D va_arg(ap, struct mmc_ioc_cmd *);
++	va_end(ap);
++
++	switch (cmd->opcode) {
++	case MMC_SEND_EXT_CSD:
++		ioctl_emu_set_ext_csd((uint8_t *)(uintptr_t)cmd->data_ptr);
++		break;
++
++	case MMC_WRITE_MULTIPLE_BLOCK:
++		frm =3D (struct rpmb_data_frame *)(uintptr_t)cmd->data_ptr;
++		msg_type =3D ntohs(frm->msg_type);
++
++		switch (msg_type) {
++		case RPMB_MSG_TYPE_REQ_AUTH_KEY_PROGRAM:
++			mem->last_op.msg_type =3D msg_type;
++			mem->last_op.op_result =3D ioctl_emu_setkey(mem, frm);
++			break;
++
++		case RPMB_MSG_TYPE_REQ_AUTH_DATA_WRITE:
++			mem->last_op.msg_type =3D msg_type;
++			mem->last_op.address =3D ntohs(frm->address);
++			mem->last_op.op_result =3D
++					ioctl_emu_mem_transfer(mem, frm,
++							       cmd->blocks, 1);
++			break;
++
++		case RPMB_MSG_TYPE_REQ_WRITE_COUNTER_VAL_READ:
++		case RPMB_MSG_TYPE_REQ_AUTH_DATA_READ:
++			memcpy(mem->nonce, frm->nonce, 16);
++			mem->last_op.msg_type =3D msg_type;
++			mem->last_op.address =3D ntohs(frm->address);
++			break;
++		default:
++			break;
++		}
++		break;
++
++	case MMC_READ_MULTIPLE_BLOCK:
++		frm =3D (struct rpmb_data_frame *)(uintptr_t)cmd->data_ptr;
++		msg_type =3D ntohs(frm->msg_type);
++
++		switch (mem->last_op.msg_type) {
++		case RPMB_MSG_TYPE_REQ_AUTH_KEY_PROGRAM:
++			ioctl_emu_get_keyprog_result(mem, frm);
++			break;
++
++		case RPMB_MSG_TYPE_REQ_AUTH_DATA_WRITE:
++			ioctl_emu_get_write_result(mem, frm);
++			break;
++
++		case RPMB_MSG_TYPE_REQ_WRITE_COUNTER_VAL_READ:
++			ioctl_emu_read_ctr(mem, frm);
++			break;
++
++		case RPMB_MSG_TYPE_REQ_AUTH_DATA_READ:
++			ioctl_emu_mem_transfer(mem, frm, cmd->blocks, 0);
++			break;
++
++		default:
++			printf("Unexpected\n");
++			break;
++		}
++		break;
++
++	default:
++		printf("Unsupported ioctl opcode 0x%08x\n", cmd->opcode);
++		return -1;
++	}
++
++	return 0;
++}
++
++static int mmc_rpmb_fd(uint16_t dev_id)
++{
++	(void)dev_id;
++
++	/* Any value !=3D -1 will do in test mode */
++	return 0;
++}
++
++static int mmc_fd(uint16_t dev_id)
++{
++	(void)dev_id;
++
++	return 0;
++}
++
++static void close_mmc_fd(int fd)
++{
++	(void)fd;
++}
++
++/*
++ * Extended CSD Register is 512 bytes and defines device properties
++ * and selected modes.
++ */
++static uint32_t read_ext_csd(int fd, uint8_t *ext_csd)
++{
++	int st =3D 0;
++	struct mmc_ioc_cmd cmd =3D {
++		.blksz =3D 512,
++		.blocks =3D 1,
++		.flags =3D MMC_RSP_R1 | MMC_CMD_ADTC,
++		.opcode =3D MMC_SEND_EXT_CSD,
++	};
++
++	mmc_ioc_cmd_set_data(cmd, ext_csd);
++
++	st =3D IOCTL(fd, MMC_IOC_CMD, &cmd);
++	if (st < 0)
++		return TEE_ERROR_GENERIC;
++
++	return TEE_SUCCESS;
++}
++
++static uint32_t rpmb_data_req(int fd, struct rpmb_data_frame *req_frm,
++			      size_t req_nfrm, struct rpmb_data_frame *rsp_frm,
++			      size_t rsp_nfrm)
++{
++	int st =3D 0;
++	size_t i =3D 0;
++	uint16_t msg_type =3D ntohs(req_frm->msg_type);
++	struct mmc_ioc_cmd cmd =3D {
++		.blksz =3D 512,
++		.blocks =3D req_nfrm,
++		.data_ptr =3D (uintptr_t)req_frm,
++		.flags =3D MMC_RSP_R1 | MMC_CMD_ADTC,
++		.opcode =3D MMC_WRITE_MULTIPLE_BLOCK,
++		.write_flag =3D 1,
++	};
++
++	for (i =3D 1; i < req_nfrm; i++) {
++		if (req_frm[i].msg_type !=3D msg_type) {
++			printf("All request frames shall be of the same type\n");
++			return TEE_ERROR_BAD_PARAMETERS;
++		}
++	}
++
++	//printf("Req: %zu frame(s) of type 0x%04x", req_nfrm, msg_type);
++	//printf("Rsp: %zu frame(s)", rsp_nfrm);
++
++	switch(msg_type) {
++	case RPMB_MSG_TYPE_REQ_AUTH_KEY_PROGRAM:
++	case RPMB_MSG_TYPE_REQ_AUTH_DATA_WRITE:
++		if (rsp_nfrm !=3D 1) {
++			printf("Expected only one response frame\n");
++			return TEE_ERROR_BAD_PARAMETERS;
++		}
++
++		/* Send write request frame(s) */
++		cmd.write_flag |=3D MMC_CMD23_ARG_REL_WR;
++		/*
++		 * Black magic: tested on a HiKey board with a HardKernel eMMC
++		 * module. When postsleep values are zero, the kernel logs
++		 * random errors: "mmc_blk_ioctl_cmd: Card Status=3D0x00000E00"
++		 * and ioctl() fails.
++		 */
++		cmd.postsleep_min_us =3D 20000;
++		cmd.postsleep_max_us =3D 50000;
++		st =3D IOCTL(fd, MMC_IOC_CMD, &cmd);
++		if (st < 0)
++			return TEE_ERROR_GENERIC;
++		cmd.postsleep_min_us =3D 0;
++		cmd.postsleep_max_us =3D 0;
++
++		/* Send result request frame */
++		memset(rsp_frm, 0, 1);
++		rsp_frm->msg_type =3D htons(RPMB_MSG_TYPE_REQ_RESULT_READ);
++		cmd.data_ptr =3D (uintptr_t)rsp_frm;
++		cmd.write_flag &=3D ~MMC_CMD23_ARG_REL_WR;
++		st =3D IOCTL(fd, MMC_IOC_CMD, &cmd);
++		if (st < 0)
++			return TEE_ERROR_GENERIC;
++
++		/* Read response frame */
++		cmd.opcode =3D MMC_READ_MULTIPLE_BLOCK;
++		cmd.write_flag =3D 0;
++		cmd.blocks =3D rsp_nfrm;
++		st =3D IOCTL(fd, MMC_IOC_CMD, &cmd);
++		if (st < 0)
++			return TEE_ERROR_GENERIC;
++		break;
++
++	case RPMB_MSG_TYPE_REQ_WRITE_COUNTER_VAL_READ:
++		if (rsp_nfrm !=3D 1) {
++			printf("Expected only one response frame\n");
++			return TEE_ERROR_BAD_PARAMETERS;
++		}
++//#if __GNUC__ > 6
++		//__attribute__((fallthrough));
++//#endif
++
++	case RPMB_MSG_TYPE_REQ_AUTH_DATA_READ:
++		if (req_nfrm !=3D 1) {
++			printf("Expected only one request frame\n");
++			return TEE_ERROR_BAD_PARAMETERS;
++		}
++
++		/* Send request frame */
++		st =3D IOCTL(fd, MMC_IOC_CMD, &cmd);
++		if (st < 0)
++			return TEE_ERROR_GENERIC;
++
++		/* Read response frames */
++		cmd.data_ptr =3D (uintptr_t)rsp_frm;
++		cmd.opcode =3D MMC_READ_MULTIPLE_BLOCK;
++		cmd.write_flag =3D 0;
++		cmd.blocks =3D rsp_nfrm;
++		st =3D IOCTL(fd, MMC_IOC_CMD, &cmd);
++		if (st < 0)
++			return TEE_ERROR_GENERIC;
++		break;
++
++	default:
++		printf("Unsupported message type: %d", msg_type);
++		return TEE_ERROR_GENERIC;
++	}
++
++	return TEE_SUCCESS;
++}
++
++static uint32_t rpmb_get_dev_info(uint16_t dev_id, struct rpmb_dev_info *=
info)
++{
++	int fd =3D 0;
++	uint32_t res =3D 0;
++	uint8_t ext_csd[512] =3D { 0 };
++
++	res =3D read_cid(dev_id, info->cid);
++	if (res !=3D TEE_SUCCESS)
++		return res;
++
++	fd =3D mmc_fd(dev_id);
++	if (fd < 0)
++		return TEE_ERROR_BAD_PARAMETERS;
++
++	res =3D read_ext_csd(fd, ext_csd);
++	if (res !=3D TEE_SUCCESS)
++		goto err;
++
++	info->rel_wr_sec_c =3D ext_csd[222];
++	info->rpmb_size_mult =3D ext_csd[168];
++	info->ret_code =3D RPMB_CMD_GET_DEV_INFO_RET_OK;
++
++err:
++	close_mmc_fd(fd);
++	return res;
++}
++
++
++/*
++ * req is one struct rpmb_req followed by one or more struct rpmb_data_fr=
ame
++ * rsp is either one struct rpmb_dev_info or one or more struct rpmb_data=
_frame
++ */
++uint32_t rpmb_process_request_emu(void *req, size_t req_size,
++				  void *rsp, size_t rsp_size)
++{
++	struct rpmb_req *sreq =3D req;
++	size_t req_nfrm =3D 0;
++	size_t rsp_nfrm =3D 0;
++	uint32_t res =3D 0;
++	int fd =3D 0;
++
++	if (req_size < sizeof(*sreq))
++		return TEE_ERROR_BAD_PARAMETERS;
++
++	switch (sreq->cmd) {
++	case RPMB_CMD_DATA_REQ:
++		req_nfrm =3D (req_size - sizeof(struct rpmb_req)) / 512;
++		rsp_nfrm =3D rsp_size / 512;
++		fd =3D mmc_rpmb_fd(sreq->dev_id);
++		if (fd < 0)
++			return TEE_ERROR_BAD_PARAMETERS;
++		res =3D rpmb_data_req(fd, RPMB_REQ_DATA(req), req_nfrm, rsp,
++				    rsp_nfrm);
++		break;
++
++	case RPMB_CMD_GET_DEV_INFO:
++		if (req_size !=3D sizeof(struct rpmb_req) ||
++		    rsp_size !=3D sizeof(struct rpmb_dev_info)) {
++			printf("Invalid req/rsp size");
++			return TEE_ERROR_BAD_PARAMETERS;
++		}
++		res =3D rpmb_get_dev_info(sreq->dev_id,
++					(struct rpmb_dev_info *)rsp);
++		break;
++
++	default:
++		printf("Unsupported RPMB command: %d", sreq->cmd);
++		res =3D TEE_ERROR_BAD_PARAMETERS;
++		break;
++	}
++
++	return res;
++}
+diff --git a/drivers/tee/optee/rpmb_emu.h b/drivers/tee/optee/rpmb_emu.h
+new file mode 100644
+index 000000000000..3471eecf63b5
+--- /dev/null
++++ b/drivers/tee/optee/rpmb_emu.h
+@@ -0,0 +1,141 @@
++#include <linux/ioctl.h>
++
++/* mmc_ioc_cmd.opcode */
++#define MMC_SEND_EXT_CSD                 8
++#define MMC_READ_MULTIPLE_BLOCK         18
++#define MMC_WRITE_MULTIPLE_BLOCK        25
++
++#define IOCTL(fd, request, ...) ioctl_emu((fd), (request), ##__VA_ARGS__)
++#define mmc_ioc_cmd_set_data(ic, ptr) ic.data_ptr =3D (__u64)(unsigned lo=
ng) ptr
++#define MMC_CMD23_ARG_REL_WR    (1 << 31) /* CMD23 reliable write */
++
++/* Emulated rel_wr_sec_c value (reliable write size, *256 bytes) */
++#define EMU_RPMB_REL_WR_SEC_C	1
++/* Emulated rpmb_size_mult value (RPMB size, *128 kB) */
++#define EMU_RPMB_SIZE_MULT	2
++
++#define EMU_RPMB_SIZE_BYTES	(EMU_RPMB_SIZE_MULT * 128 * 1024)
++
++struct mmc_ioc_cmd {
++	/* Implies direction of data.  true =3D write, false =3D read */
++	int write_flag;
++
++	/* Application-specific command.  true =3D precede with CMD55 */
++	int is_acmd;
++
++	uint32_t opcode;
++	uint32_t arg;
++	uint32_t response[4];  /* CMD response */
++	unsigned int flags;
++	unsigned int blksz;
++	unsigned int blocks;
++
++	/*
++	 * Sleep at least postsleep_min_us useconds, and at most
++	 * postsleep_max_us useconds *after* issuing command.  Needed for
++	 * some read commands for which cards have no other way of indicating
++	 * they're ready for the next command (i.e. there is no equivalent of
++	 * a "busy" indicator for read operations).
++	 */
++	unsigned int postsleep_min_us;
++	unsigned int postsleep_max_us;
++
++	/*
++	 * Override driver-computed timeouts.  Note the difference in units!
++	 */
++	unsigned int data_timeout_ns;
++	unsigned int cmd_timeout_ms;
++
++	/*
++	 * For 64-bit machines, the next member, ``__u64 data_ptr``, wants to
++	 * be 8-byte aligned.  Make sure this struct is the same size when
++	 * built for 32-bit.
++	 */
++	uint32_t __pad;
++
++	/* DAT buffer */
++	uint32_t data_ptr;
++};
++#define MMC_BLOCK_MAJOR		179
++#define MMC_IOC_CMD _IOWR(MMC_BLOCK_MAJOR, 0, struct mmc_ioc_cmd)
++
++/* Request */
++struct rpmb_req {
++	uint16_t cmd;
++#define RPMB_CMD_DATA_REQ      0x00
++#define RPMB_CMD_GET_DEV_INFO  0x01
++	uint16_t dev_id;
++	uint16_t block_count;
++	/* Optional data frames (rpmb_data_frame) follow */
++};
++#define RPMB_REQ_DATA(req) ((void *)((struct rpmb_req *)(req) + 1))
++
++/* Response to device info request */
++struct rpmb_dev_info {
++	uint8_t cid[16];
++	uint8_t rpmb_size_mult;	/* EXT CSD-slice 168: RPMB Size */
++	uint8_t rel_wr_sec_c;	/* EXT CSD-slice 222: Reliable Write Sector */
++				/*                    Count */
++	uint8_t ret_code;
++#define RPMB_CMD_GET_DEV_INFO_RET_OK     0x00
++#define RPMB_CMD_GET_DEV_INFO_RET_ERROR  0x01
++};
++/* mmc_ioc_cmd.flags */
++#define MMC_RSP_PRESENT (1 << 0)
++#define MMC_RSP_136     (1 << 1)        /* 136 bit response */
++#define MMC_RSP_CRC     (1 << 2)        /* Expect valid CRC */
++#define MMC_RSP_OPCODE  (1 << 4)        /* Response contains opcode */
++
++#define MMC_RSP_R1      (MMC_RSP_PRESENT|MMC_RSP_CRC|MMC_RSP_OPCODE)
++
++#define MMC_CMD_ADTC    (1 << 5)        /* Addressed data transfer comman=
d */
++
++
++/* Emulated eMMC device state */
++struct rpmb_emu {
++	uint8_t buf[EMU_RPMB_SIZE_BYTES];
++	size_t size;
++	uint8_t key[32];
++	bool key_set;
++	uint8_t nonce[16];
++	uint32_t write_counter;
++	struct {
++		uint16_t msg_type;
++		uint16_t op_result;
++		uint16_t address;
++	} last_op;
++};
++
++/*
++ * This structure is shared with OP-TEE and the MMC ioctl layer.
++ * It is the "data frame for RPMB access" defined by JEDEC, minus the
++ * start and stop bits.
++ */
++struct rpmb_data_frame {
++	uint8_t stuff_bytes[196];
++	uint8_t key_mac[32];
++	uint8_t data[256];
++	uint8_t nonce[16];
++	uint32_t write_counter;
++	uint16_t address;
++	uint16_t block_count;
++	uint16_t op_result;
++#define RPMB_RESULT_OK				0x00
++#define RPMB_RESULT_GENERAL_FAILURE		0x01
++#define RPMB_RESULT_AUTH_FAILURE		0x02
++#define RPMB_RESULT_ADDRESS_FAILURE		0x04
++#define RPMB_RESULT_AUTH_KEY_NOT_PROGRAMMED	0x07
++	uint16_t msg_type;
++#define RPMB_MSG_TYPE_REQ_AUTH_KEY_PROGRAM		0x0001
++#define RPMB_MSG_TYPE_REQ_WRITE_COUNTER_VAL_READ	0x0002
++#define RPMB_MSG_TYPE_REQ_AUTH_DATA_WRITE		0x0003
++#define RPMB_MSG_TYPE_REQ_AUTH_DATA_READ		0x0004
++#define RPMB_MSG_TYPE_REQ_RESULT_READ			0x0005
++#define RPMB_MSG_TYPE_RESP_AUTH_KEY_PROGRAM		0x0100
++#define RPMB_MSG_TYPE_RESP_WRITE_COUNTER_VAL_READ	0x0200
++#define RPMB_MSG_TYPE_RESP_AUTH_DATA_WRITE		0x0300
++#define RPMB_MSG_TYPE_RESP_AUTH_DATA_READ		0x0400
++};
++
++uint32_t rpmb_process_request_emu(void *req, size_t req_size,
++                                  void *rsp, size_t rsp_size);
+diff --git a/drivers/tee/optee/sha2.c b/drivers/tee/optee/sha2.c
+new file mode 100644
+index 000000000000..a9acd7244947
+--- /dev/null
++++ b/drivers/tee/optee/sha2.c
+@@ -0,0 +1,249 @@
++/*
++ * FIPS 180-2 SHA-224/256/384/512 implementation
++ * Last update: 02/02/2007
++ * Issue date:  04/30/2005
++ *
++ * Copyright (C) 2005, 2007 Olivier Gay <olivier.gay@a3.epfl.ch>
++ * All rights reserved.
++ *
++ * Copyright (c) 2016, Linaro Limited
++ * All rights reserved.
++ *
++ * Redistribution and use in source and binary forms, with or without
++ * modification, are permitted provided that the following conditions
++ * are met:
++ * 1. Redistributions of source code must retain the above copyright
++ *    notice, this list of conditions and the following disclaimer.
++ * 2. Redistributions in binary form must reproduce the above copyright
++ *    notice, this list of conditions and the following disclaimer in the
++ *    documentation and/or other materials provided with the distribution=
.
++ * 3. Neither the name of the project nor the names of its contributors
++ *    may be used to endorse or promote products derived from this softwa=
re
++ *    without specific prior written permission.
++ *
++ * THIS SOFTWARE IS PROVIDED BY THE PROJECT AND CONTRIBUTORS ``AS IS'' AN=
D
++ * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
++ * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PUR=
POSE
++ * ARE DISCLAIMED.  IN NO EVENT SHALL THE PROJECT OR CONTRIBUTORS BE LIAB=
LE
++ * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUEN=
TIAL
++ * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOOD=
S
++ * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
++ * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, ST=
RICT
++ * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY =
WAY
++ * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
++ * SUCH DAMAGE.
++ */
++
++#include <string.h>
++#include "sha2.h"
++
++#define SHFR(x, n)    (x >> n)
++#define ROTR(x, n)   ((x >> n) | (x << ((sizeof(x) << 3) - n)))
++#define ROTL(x, n)   ((x << n) | (x >> ((sizeof(x) << 3) - n)))
++#define CH(x, y, z)  ((x & y) ^ (~x & z))
++#define MAJ(x, y, z) ((x & y) ^ (x & z) ^ (y & z))
++
++#define SHA256_F1(x) (ROTR(x,  2) ^ ROTR(x, 13) ^ ROTR(x, 22))
++#define SHA256_F2(x) (ROTR(x,  6) ^ ROTR(x, 11) ^ ROTR(x, 25))
++#define SHA256_F3(x) (ROTR(x,  7) ^ ROTR(x, 18) ^ SHFR(x,  3))
++#define SHA256_F4(x) (ROTR(x, 17) ^ ROTR(x, 19) ^ SHFR(x, 10))
++
++#define UNPACK32(x, str)                      \
++{                                             \
++    *((str) + 3) =3D (uint8) ((x)      );       \
++    *((str) + 2) =3D (uint8) ((x) >>  8);       \
++    *((str) + 1) =3D (uint8) ((x) >> 16);       \
++    *((str) + 0) =3D (uint8) ((x) >> 24);       \
++}
++
++#define PACK32(str, x)                        \
++{                                             \
++    *(x) =3D   ((uint32) *((str) + 3)      )    \
++           | ((uint32) *((str) + 2) <<  8)    \
++           | ((uint32) *((str) + 1) << 16)    \
++           | ((uint32) *((str) + 0) << 24);   \
++}
++
++#define UNPACK64(x, str)                      \
++{                                             \
++    *((str) + 7) =3D (uint8) ((x)      );       \
++    *((str) + 6) =3D (uint8) ((x) >>  8);       \
++    *((str) + 5) =3D (uint8) ((x) >> 16);       \
++    *((str) + 4) =3D (uint8) ((x) >> 24);       \
++    *((str) + 3) =3D (uint8) ((x) >> 32);       \
++    *((str) + 2) =3D (uint8) ((x) >> 40);       \
++    *((str) + 1) =3D (uint8) ((x) >> 48);       \
++    *((str) + 0) =3D (uint8) ((x) >> 56);       \
++}
++
++#define PACK64(str, x)                        \
++{                                             \
++    *(x) =3D   ((uint64) *((str) + 7)      )    \
++           | ((uint64) *((str) + 6) <<  8)    \
++           | ((uint64) *((str) + 5) << 16)    \
++           | ((uint64) *((str) + 4) << 24)    \
++           | ((uint64) *((str) + 3) << 32)    \
++           | ((uint64) *((str) + 2) << 40)    \
++           | ((uint64) *((str) + 1) << 48)    \
++           | ((uint64) *((str) + 0) << 56);   \
++}
++
++#define SHA256_SCR(i)                         \
++{                                             \
++    w[i] =3D  SHA256_F4(w[i -  2]) + w[i -  7]  \
++          + SHA256_F3(w[i - 15]) + w[i - 16]; \
++}
++
++uint32 sha256_h0[8] =3D
++            {0x6a09e667, 0xbb67ae85, 0x3c6ef372, 0xa54ff53a,
++             0x510e527f, 0x9b05688c, 0x1f83d9ab, 0x5be0cd19};
++
++uint32 sha256_k[64] =3D
++            {0x428a2f98, 0x71374491, 0xb5c0fbcf, 0xe9b5dba5,
++             0x3956c25b, 0x59f111f1, 0x923f82a4, 0xab1c5ed5,
++             0xd807aa98, 0x12835b01, 0x243185be, 0x550c7dc3,
++             0x72be5d74, 0x80deb1fe, 0x9bdc06a7, 0xc19bf174,
++             0xe49b69c1, 0xefbe4786, 0x0fc19dc6, 0x240ca1cc,
++             0x2de92c6f, 0x4a7484aa, 0x5cb0a9dc, 0x76f988da,
++             0x983e5152, 0xa831c66d, 0xb00327c8, 0xbf597fc7,
++             0xc6e00bf3, 0xd5a79147, 0x06ca6351, 0x14292967,
++             0x27b70a85, 0x2e1b2138, 0x4d2c6dfc, 0x53380d13,
++             0x650a7354, 0x766a0abb, 0x81c2c92e, 0x92722c85,
++             0xa2bfe8a1, 0xa81a664b, 0xc24b8b70, 0xc76c51a3,
++             0xd192e819, 0xd6990624, 0xf40e3585, 0x106aa070,
++             0x19a4c116, 0x1e376c08, 0x2748774c, 0x34b0bcb5,
++             0x391c0cb3, 0x4ed8aa4a, 0x5b9cca4f, 0x682e6ff3,
++             0x748f82ee, 0x78a5636f, 0x84c87814, 0x8cc70208,
++             0x90befffa, 0xa4506ceb, 0xbef9a3f7, 0xc67178f2};
++
++/* SHA-256 functions */
++
++static void sha256_transf(sha256_ctx *ctx, const unsigned char *message,
++                          unsigned int block_nb)
++{
++    uint32 w[64] =3D { 0 };
++    uint32 wv[8] =3D { 0 };
++    uint32 t1 =3D 0;
++    uint32 t2 =3D 0;
++    const unsigned char *sub_block =3D NULL;
++    int i =3D 0;
++    int j =3D 0;
++
++    for (i =3D 0; i < (int) block_nb; i++) {
++        sub_block =3D message + (i << 6);
++
++        for (j =3D 0; j < 16; j++) {
++            PACK32(&sub_block[j << 2], &w[j]);
++        }
++
++        for (j =3D 16; j < 64; j++) {
++            SHA256_SCR(j);
++        }
++
++        for (j =3D 0; j < 8; j++) {
++            wv[j] =3D ctx->h[j];
++        }
++
++        for (j =3D 0; j < 64; j++) {
++            t1 =3D wv[7] + SHA256_F2(wv[4]) + CH(wv[4], wv[5], wv[6])
++                + sha256_k[j] + w[j];
++            t2 =3D SHA256_F1(wv[0]) + MAJ(wv[0], wv[1], wv[2]);
++            wv[7] =3D wv[6];
++            wv[6] =3D wv[5];
++            wv[5] =3D wv[4];
++            wv[4] =3D wv[3] + t1;
++            wv[3] =3D wv[2];
++            wv[2] =3D wv[1];
++            wv[1] =3D wv[0];
++            wv[0] =3D t1 + t2;
++        }
++
++        for (j =3D 0; j < 8; j++) {
++            ctx->h[j] +=3D wv[j];
++        }
++    }
++}
++
++void sha256(const unsigned char *message, unsigned int len,
++	    unsigned char *digest)
++{
++    sha256_ctx ctx;
++
++    memset(&ctx, 0, sizeof(ctx));
++
++    sha256_init(&ctx);
++    sha256_update_tee(&ctx, message, len);
++    sha256_final(&ctx, digest);
++}
++
++void sha256_init(sha256_ctx *ctx)
++{
++    int i =3D 0;
++
++    for (i =3D 0; i < 8; i++) {
++        ctx->h[i] =3D sha256_h0[i];
++    }
++
++    ctx->len =3D 0;
++    ctx->tot_len =3D 0;
++}
++
++void sha256_update_tee(sha256_ctx *ctx, const unsigned char *message,
++                   unsigned int len)
++{
++    unsigned int block_nb =3D 0;
++    unsigned int new_len =3D 0;
++    unsigned int rem_len =3D 0;
++    unsigned int tmp_len =3D 0;
++    const unsigned char *shifted_message =3D NULL;
++
++    tmp_len =3D SHA256_BLOCK_SIZE - ctx->len;
++    rem_len =3D len < tmp_len ? len : tmp_len;
++
++    memcpy(&ctx->block[ctx->len], message, rem_len);
++
++    if (ctx->len + len < SHA256_BLOCK_SIZE) {
++        ctx->len +=3D len;
++        return;
++    }
++
++    new_len =3D len - rem_len;
++    block_nb =3D new_len / SHA256_BLOCK_SIZE;
++
++    shifted_message =3D message + rem_len;
++
++    sha256_transf(ctx, ctx->block, 1);
++    sha256_transf(ctx, shifted_message, block_nb);
++
++    rem_len =3D new_len % SHA256_BLOCK_SIZE;
++
++    memcpy(ctx->block, &shifted_message[block_nb << 6],
++           rem_len);
++
++    ctx->len =3D rem_len;
++    ctx->tot_len +=3D (block_nb + 1) << 6;
++}
++
++void sha256_final(sha256_ctx *ctx, unsigned char *digest)
++{
++    unsigned int block_nb =3D 0;
++    unsigned int pm_len =3D 0;
++    unsigned int len_b =3D 0;
++    int i =3D 0;
++
++    block_nb =3D (1 + ((SHA256_BLOCK_SIZE - 9)
++                     < (ctx->len % SHA256_BLOCK_SIZE)));
++
++    len_b =3D (ctx->tot_len + ctx->len) << 3;
++    pm_len =3D block_nb << 6;
++
++    memset(ctx->block + ctx->len, 0, pm_len - ctx->len);
++    ctx->block[ctx->len] =3D 0x80;
++    UNPACK32(len_b, ctx->block + pm_len - 4);
++
++    sha256_transf(ctx, ctx->block, block_nb);
++
++    for (i =3D 0 ; i < 8; i++) {
++        UNPACK32(ctx->h[i], &digest[i << 2]);
++    }
++}
+diff --git a/drivers/tee/optee/sha2.h b/drivers/tee/optee/sha2.h
+new file mode 100644
+index 000000000000..4ce0f3cd5231
+--- /dev/null
++++ b/drivers/tee/optee/sha2.h
+@@ -0,0 +1,75 @@
++/*
++ * FIPS 180-2 SHA-224/256/384/512 implementation
++ * Last update: 02/02/2007
++ * Issue date:  04/30/2005
++ *
++ * Copyright (C) 2005, 2007 Olivier Gay <olivier.gay@a3.epfl.ch>
++ * All rights reserved.
++ *
++ * Copyright (c) 2016, Linaro Limited
++ * All rights reserved.
++ *
++ * Redistribution and use in source and binary forms, with or without
++ * modification, are permitted provided that the following conditions
++ * are met:
++ * 1. Redistributions of source code must retain the above copyright
++ *    notice, this list of conditions and the following disclaimer.
++ * 2. Redistributions in binary form must reproduce the above copyright
++ *    notice, this list of conditions and the following disclaimer in the
++ *    documentation and/or other materials provided with the distribution=
.
++ * 3. Neither the name of the project nor the names of its contributors
++ *    may be used to endorse or promote products derived from this softwa=
re
++ *    without specific prior written permission.
++ *
++ * THIS SOFTWARE IS PROVIDED BY THE PROJECT AND CONTRIBUTORS ``AS IS'' AN=
D
++ * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
++ * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PUR=
POSE
++ * ARE DISCLAIMED.  IN NO EVENT SHALL THE PROJECT OR CONTRIBUTORS BE LIAB=
LE
++ * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUEN=
TIAL
++ * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOOD=
S
++ * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
++ * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, ST=
RICT
++ * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY =
WAY
++ * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
++ * SUCH DAMAGE.
++ */
++
++#ifndef SHA2_H
++#define SHA2_H
++
++#define SHA256_DIGEST_SIZE ( 256 / 8)
++#define SHA256_BLOCK_SIZE  ( 512 / 8)
++
++#ifndef SHA2_TYPES
++#define SHA2_TYPES
++typedef unsigned char uint8;
++typedef unsigned int  uint32;
++typedef unsigned long long uint64;
++#endif
++
++#ifdef __cplusplus
++extern "C" {
++#endif
++
++typedef struct {
++    unsigned int tot_len;
++    unsigned int len;
++    unsigned char block[2 * SHA256_BLOCK_SIZE];
++    uint32 h[8];
++} sha256_ctx;
++
++typedef sha256_ctx sha224_ctx;
++
++void sha256_init(sha256_ctx * ctx);
++void sha256_update_tee(sha256_ctx *ctx, const unsigned char *message,
++                   unsigned int len);
++void sha256_final(sha256_ctx *ctx, unsigned char *digest);
++void sha256(const unsigned char *message, unsigned int len,
++            unsigned char *digest);
++
++#ifdef __cplusplus
++}
++#endif
++
++#endif /* !SHA2_H */
++
+--=20
+2.29.2
+
diff --git a/recipes-bsp/u-boot/u-boot-qemu-common.inc b/recipes-bsp/u-boot=
/u-boot-qemu-common.inc
index 802fc50..6e7158b 100644
--- a/recipes-bsp/u-boot/u-boot-qemu-common.inc
+++ b/recipes-bsp/u-boot/u-boot-qemu-common.inc
@@ -13,6 +13,9 @@ require recipes-bsp/u-boot/u-boot-common.inc
=20
 U_BOOT_BIN =3D "u-boot.bin"
=20
+SRC_URI_append_secureboot =3D " \
+    file://0002-rpmb-emulation-hack.-Breaks-proper-hardware-support.patch;=
patch=3D1"
+
 DEPENDS_append_secureboot =3D " optee-os-${MACHINE}"
=20
 do_deploy[dirs] =3D "${DEPLOY_DIR_IMAGE}"
--=20
2.30.2


