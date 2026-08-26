Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0384FC5DF97
	for <webhook@archiver.kernel.org>; Wed, 26 Aug 2026 05:42:07 +0000 (UTC)
Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.6176.1787722924430281834
 for <cip-dev@lists.cip-project.org>;
 Tue, 25 Aug 2026 22:42:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm2 header.b=UE2yRnaV;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.225, mailfrom: fm-294854-202608260542027a213128b000020749-__35pk@rts-flowmailer.siemens.com)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 202608260542027a213128b000020749
        for <cip-dev@lists.cip-project.org>;
        Wed, 26 Aug 2026 07:42:02 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=iJ9SZiQ6gj5ciqq8QuyIQbZthsiT6jDOHiBRSmuYOgw=;
 b=UE2yRnaV5c31VZDlulqMmk9qOQ/cytV5CvDkyqe0Ueclij5/JUKqbaz4ALw+JmgHA0lskv
 ENbm9mQ5EI5yjhk5GlIotwVM+leYTEPa/CozYD+9dGGcTo6HI0Zlk5exZzQ6A5GVBO1mOA+F
 /xf5R+82dloqDW5ut4L7yLY5qxc2cQGwwQjsxZ/+LnNv+WNF4AACYcEVjLuMsOYiLxVtkrUV
 RkUJLFt+t7oRIFWgblIp72n3KCofK8ugwDdAu7WDEc/rEOkPoH9VkpB549TOLQBaxwJch7P/
 DWrOPg/Uyw8OE9wKcUzYEO3IBojc7iwls4/rOmtW9GJx6C2n60lxVfUw==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: Sai Sree Kartheek Adivi <s-adivi@ti.com>,
	Quirin Gylstorff <quirin.gylstorff@siemens.com>,
	Alexander Heinisch <alexander.heinisch@siemens.com>
Subject: [isar-cip-core][PATCH 4/7] u-boot: Add patches to enable measured boot with fTPM
Date: Wed, 26 Aug 2026 07:41:42 +0200
Message-ID: <d4aee62fc0361a0c4b7c2072ab1d12853185c7d5.1787722904.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1787722904.git.jan.kiszka@siemens.com>
References: <cover.1787722904.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 26 Aug 2026 05:42:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24010

From: Jan Kiszka <jan.kiszka@siemens.com>

U-Boot was so far not enumerating the fTPM device, and that caused the
PCRs to stay zero. systemd-cryptenroll was complaining already, just not
loud enough.

With these extra patches (currently under review upstream), we are
getting a TPM right before the EFI loader starts, and we get valid PCR
content as well.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 ...ement-Fix-compilation-for-non-sandbo.patch |  43 +++++
 ...-out-service-enumeration-and-binding.patch |  95 +++++++++++
 ...pport-for-enumerating-services-that-.patch | 155 ++++++++++++++++++
 ...-warn-about-TEE_ERROR_STORAGE_NOT_AV.patch |  33 ++++
 ...to-optee-after-a-successful-mmc_init.patch |  41 +++++
 ...-MMC-Device-not-found-a-debug-output.patch |  50 ++++++
 recipes-bsp/u-boot/u-boot-common-2026.01.inc  |   6 +
 7 files changed, 423 insertions(+)
 create mode 100644 recipes-bsp/u-boot/files/0001-test-boot-measurement-Fix-compilation-for-non-sandbo.patch
 create mode 100644 recipes-bsp/u-boot/files/0002-tee-optee-Factor-out-service-enumeration-and-binding.patch
 create mode 100644 recipes-bsp/u-boot/files/0003-tee-optee-Add-support-for-enumerating-services-that-.patch
 create mode 100644 recipes-bsp/u-boot/files/0004-tee-optee-Do-not-warn-about-TEE_ERROR_STORAGE_NOT_AV.patch
 create mode 100644 recipes-bsp/u-boot/files/0005-mmc-Call-back-to-optee-after-a-successful-mmc_init.patch
 create mode 100644 recipes-bsp/u-boot/files/0006-mmc-Make-MMC-Device-not-found-a-debug-output.patch

diff --git a/recipes-bsp/u-boot/files/0001-test-boot-measurement-Fix-compilation-for-non-sandbo.patch b/recipes-bsp/u-boot/files/0001-test-boot-measurement-Fix-compilation-for-non-sandbo.patch
new file mode 100644
index 00000000..c5b920b1
--- /dev/null
+++ b/recipes-bsp/u-boot/files/0001-test-boot-measurement-Fix-compilation-for-non-sandbo.patch
@@ -0,0 +1,43 @@
+From 1d9a066892b73d65129cb899c6ed611eb3d1c3bc Mon Sep 17 00:00:00 2001
+From: Jan Kiszka <jan.kiszka@siemens.com>
+Date: Thu, 20 Aug 2026 17:30:54 +0200
+Subject: [PATCH 1/6] test: boot: measurement: Fix compilation for non-sandbox
+ builds
+MIME-Version: 1.0
+Content-Type: text/plain; charset=UTF-8
+Content-Transfer-Encoding: 8bit
+
+asm/io.h provides map_to_sysmem() only for the sandbox. Other targets
+fail the build with
+
+../test/boot/measurement.c: In function ‘measure’:
+../test/boot/measurement.c:30:33: error: implicit declaration of function ‘map_to_sysmem’; did you mean ‘map_physmem’? [-Wimplicit-function-declaration]
+   30 |         images.os.image_start = map_to_sysmem(kernel);
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
+ 
+ #define MEASUREMENT_TEST(_name, _flags)	\
+ 	UNIT_TEST(_name, _flags, measurement)
+-- 
+2.47.3
+
diff --git a/recipes-bsp/u-boot/files/0002-tee-optee-Factor-out-service-enumeration-and-binding.patch b/recipes-bsp/u-boot/files/0002-tee-optee-Factor-out-service-enumeration-and-binding.patch
new file mode 100644
index 00000000..b7aef59c
--- /dev/null
+++ b/recipes-bsp/u-boot/files/0002-tee-optee-Factor-out-service-enumeration-and-binding.patch
@@ -0,0 +1,95 @@
+From 70c9bcf676e253ed8c86699237c74e41c86eb34a Mon Sep 17 00:00:00 2001
+From: Jan Kiszka <jan.kiszka@siemens.com>
+Date: Sun, 23 Aug 2026 20:25:03 +0200
+Subject: [PATCH 2/6] tee: optee: Factor out service enumeration and binding
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
+index 4d67c948ec1..2871760a7b7 100644
+--- a/drivers/tee/optee/core.c
++++ b/drivers/tee/optee/core.c
+@@ -156,7 +156,7 @@ static int enum_services(struct udevice *dev, struct tee_shm **shm, size_t *coun
+ 	return ret;
+ }
+ 
+-static int open_enum_session(struct udevice *dev, u32 *tee_sess)
++int optee_open_enum_session(struct udevice *dev, u32 *tee_sess)
+ {
+ 	const struct tee_optee_ta_uuid pta_uuid = PTA_DEVICE_ENUM;
+ 	struct tee_open_session_arg arg = { };
+@@ -176,31 +176,34 @@ static int open_enum_session(struct udevice *dev, u32 *tee_sess)
+ 	return 0;
+ }
+ 
+-static int bind_service_drivers(struct udevice *dev)
++int optee_bind_services(struct udevice *dev, u32 tee_sess,
++			unsigned int pta_cmd)
+ {
+ 	struct tee_shm *service_list = NULL;
+ 	size_t service_count;
+-	u32 tee_sess;
+-	int ret, ret2;
+-
+-	ret = open_enum_session(dev, &tee_sess);
+-	if (ret)
+-		return ret;
++	int ret;
+ 
+ 	ret = enum_services(dev, &service_list, &service_count, tee_sess,
+-			    PTA_CMD_GET_DEVICES);
++			    pta_cmd);
+ 	if (!ret && service_count)
+ 		ret = bind_service_list(dev, service_list, service_count);
+ 
+ 	tee_shm_free(service_list);
+-	service_list = NULL;
+ 
+-	ret2 = enum_services(dev, &service_list, &service_count, tee_sess,
+-			     PTA_CMD_GET_DEVICES_SUPP);
+-	if (!ret2 && service_count)
+-		ret2 = bind_service_list(dev, service_list, service_count);
++	return ret;
++}
++
++static int bind_service_drivers(struct udevice *dev)
++{
++	u32 tee_sess;
++	int ret, ret2;
+ 
+-	tee_shm_free(service_list);
++	ret = optee_open_enum_session(dev, &tee_sess);
++	if (ret)
++		return ret;
++
++	ret = optee_bind_services(dev, tee_sess, PTA_CMD_GET_DEVICES);
++	ret2 = optee_bind_services(dev, tee_sess, PTA_CMD_GET_DEVICES_SUPP);
+ 
+ 	tee_close_session(dev, tee_sess);
+ 
+diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/optee_private.h
+index 1f07a27ee4b..25b6b3c3218 100644
+--- a/drivers/tee/optee/optee_private.h
++++ b/drivers/tee/optee/optee_private.h
+@@ -27,6 +27,9 @@ struct optee_msg_arg;
+ 
+ void optee_suppl_cmd(struct udevice *dev, struct tee_shm *shm_arg,
+ 		     void **page_list);
++int optee_open_enum_session(struct udevice *dev, u32 *tee_sess);
++int optee_bind_services(struct udevice *dev, u32 tee_sess,
++			unsigned int pta_cmd);
+ 
+ #ifdef CONFIG_SUPPORT_EMMC_RPMB
+ /**
+-- 
+2.47.3
+
diff --git a/recipes-bsp/u-boot/files/0003-tee-optee-Add-support-for-enumerating-services-that-.patch b/recipes-bsp/u-boot/files/0003-tee-optee-Add-support-for-enumerating-services-that-.patch
new file mode 100644
index 00000000..a037303d
--- /dev/null
+++ b/recipes-bsp/u-boot/files/0003-tee-optee-Add-support-for-enumerating-services-that-.patch
@@ -0,0 +1,155 @@
+From 1794934500e5580309f4a8cb064bd035cb9b23d4 Mon Sep 17 00:00:00 2001
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
+ drivers/tee/optee/rpmb.c          | 19 +++++++++++++++++++
+ include/tee/optee.h               |  6 ++++++
+ 4 files changed, 53 insertions(+), 15 deletions(-)
+
+diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
+index 2871760a7b7..ed8f2b6ec74 100644
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
+ 
+ typedef void (optee_invoke_fn)(unsigned long, unsigned long, unsigned long,
+ 			       unsigned long, unsigned long, unsigned long,
+@@ -195,8 +182,8 @@ int optee_bind_services(struct udevice *dev, u32 tee_sess,
+ 
+ static int bind_service_drivers(struct udevice *dev)
+ {
++	int ret, ret2, ret3 = 0;
+ 	u32 tee_sess;
+-	int ret, ret2;
+ 
+ 	ret = optee_open_enum_session(dev, &tee_sess);
+ 	if (ret)
+@@ -204,13 +191,18 @@ static int bind_service_drivers(struct udevice *dev)
+ 
+ 	ret = optee_bind_services(dev, tee_sess, PTA_CMD_GET_DEVICES);
+ 	ret2 = optee_bind_services(dev, tee_sess, PTA_CMD_GET_DEVICES_SUPP);
++	if (CONFIG_IS_ENABLED(SUPPORT_EMMC_RPMB))
++		ret3 = optee_bind_services(dev, tee_sess,
++					   PTA_CMD_GET_DEVICES_RPMB);
+ 
+ 	tee_close_session(dev, tee_sess);
+ 
+ 	if (ret)
+ 		return ret;
++	if (ret2)
++		return ret2;
+ 
+-	return ret2;
++	return ret3;
+ }
+ 
+ /**
+diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/optee_private.h
+index 25b6b3c3218..daff3e04493 100644
+--- a/drivers/tee/optee/optee_private.h
++++ b/drivers/tee/optee/optee_private.h
+@@ -9,6 +9,27 @@
+ #include <tee.h>
+ #include <log.h>
+ 
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
++ * PTA_CMD_GET_DEVICES_RPMB - List services only depending on RPMB support
++ *
++ * [out]    memref[0]: List of the UUIDs of service enumerated by OP-TEE
++ */
++#define PTA_CMD_GET_DEVICES_RPMB	0x2
++
+ /**
+  * struct optee_private - OP-TEE driver private data
+  * @rpmb_mmc:		mmc device for the RPMB partition
+diff --git a/drivers/tee/optee/rpmb.c b/drivers/tee/optee/rpmb.c
+index bacced6af6c..f7312d7171c 100644
+--- a/drivers/tee/optee/rpmb.c
++++ b/drivers/tee/optee/rpmb.c
+@@ -191,3 +191,22 @@ void optee_suppl_rpmb_release(struct udevice *dev)
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
++		if (strcmp(dev->driver->name, "optee") != 0)
++			continue;
++
++		if (optee_open_enum_session(dev, &tee_sess) != 0)
++			continue;
++
++		optee_bind_services(dev, tee_sess, PTA_CMD_GET_DEVICES_RPMB);
++
++		tee_close_session(dev, tee_sess);
++	}
++}
+diff --git a/include/tee/optee.h b/include/tee/optee.h
+index d1194493780..755533b2c0b 100644
+--- a/include/tee/optee.h
++++ b/include/tee/optee.h
+@@ -74,4 +74,10 @@ static inline bool is_optee_smc_api(void)
+ }
+ #endif
+ 
++#if defined(CONFIG_OPTEE) && defined(CONFIG_SUPPORT_EMMC_RPMB)
++void optee_rpmb_available(void);
++#else
++static inline void optee_rpmb_available(void) {}
++#endif
++
+ #endif /* _OPTEE_H */
+-- 
+2.47.3
+
diff --git a/recipes-bsp/u-boot/files/0004-tee-optee-Do-not-warn-about-TEE_ERROR_STORAGE_NOT_AV.patch b/recipes-bsp/u-boot/files/0004-tee-optee-Do-not-warn-about-TEE_ERROR_STORAGE_NOT_AV.patch
new file mode 100644
index 00000000..41291e21
--- /dev/null
+++ b/recipes-bsp/u-boot/files/0004-tee-optee-Do-not-warn-about-TEE_ERROR_STORAGE_NOT_AV.patch
@@ -0,0 +1,33 @@
+From 13fc430cf440cdbc490bce630031ca49e81e1e13 Mon Sep 17 00:00:00 2001
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
+index ed8f2b6ec74..d3b5811afb8 100644
+--- a/drivers/tee/optee/core.c
++++ b/drivers/tee/optee/core.c
+@@ -106,7 +106,10 @@ static int __enum_services(struct udevice *dev, struct tee_shm *shm, size_t *shm
+ 
+ 	ret = tee_invoke_func(dev, &arg, 1, &param);
+ 	if (ret || (arg.ret && arg.ret != TEE_ERROR_SHORT_BUFFER)) {
+-		dev_err(dev, "Enumeration command 0x%x failed: 0x%x\n", pta_cmd, arg.ret);
++		if (arg.ret != TEE_ERROR_STORAGE_NOT_AVAILABLE)
++			dev_err(dev, "Enumeration command 0x%x failed: 0x%x\n", pta_cmd, arg.ret);
++		else
++			dev_dbg(dev, "Enumeration command 0x%x failed due to unavailable storage\n", pta_cmd);
+ 		return -EINVAL;
+ 	}
+ 
+-- 
+2.47.3
+
diff --git a/recipes-bsp/u-boot/files/0005-mmc-Call-back-to-optee-after-a-successful-mmc_init.patch b/recipes-bsp/u-boot/files/0005-mmc-Call-back-to-optee-after-a-successful-mmc_init.patch
new file mode 100644
index 00000000..8976582c
--- /dev/null
+++ b/recipes-bsp/u-boot/files/0005-mmc-Call-back-to-optee-after-a-successful-mmc_init.patch
@@ -0,0 +1,41 @@
+From ddef88ae1677f4c9b793252483f23eae900b89d1 Mon Sep 17 00:00:00 2001
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
+index 670e92ee12b..2463e50cd3c 100644
+--- a/drivers/mmc/mmc.c
++++ b/drivers/mmc/mmc.c
+@@ -27,6 +27,7 @@
+ #include <linux/list.h>
+ #include <linux/printk.h>
+ #include <div64.h>
++#include <tee/optee.h>
+ #include "mmc_private.h"
+ 
+ #define DEFAULT_CMD6_TIMEOUT_MS  500
+@@ -3168,6 +3169,9 @@ int mmc_init(struct mmc *mmc)
+ 				mmc->cfg->name);
+ 	}
+ 
++	if (CONFIG_IS_ENABLED(OPTEE) && mmc->capacity_rpmb > 0)
++		optee_rpmb_available();
++
+ 	return err;
+ }
+ 
+-- 
+2.47.3
+
diff --git a/recipes-bsp/u-boot/files/0006-mmc-Make-MMC-Device-not-found-a-debug-output.patch b/recipes-bsp/u-boot/files/0006-mmc-Make-MMC-Device-not-found-a-debug-output.patch
new file mode 100644
index 00000000..a1533d47
--- /dev/null
+++ b/recipes-bsp/u-boot/files/0006-mmc-Make-MMC-Device-not-found-a-debug-output.patch
@@ -0,0 +1,50 @@
+From 57a99d87a25d42f68f26697b81fafefcae29abad Mon Sep 17 00:00:00 2001
+From: Jan Kiszka <jan.kiszka@siemens.com>
+Date: Fri, 21 Aug 2026 11:00:09 +0200
+Subject: [PATCH 6/6] mmc: Make "MMC Device not found" a debug output
+
+Callers of find_mmc_device are generally processing and informing about
+errors already, e.g.
+
+=> mmc dev 2
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
+index 698530088fe..ec16899f92e 100644
+--- a/drivers/mmc/mmc-uclass.c
++++ b/drivers/mmc/mmc-uclass.c
+@@ -319,7 +319,7 @@ struct mmc *find_mmc_device(int dev_num)
+ 
+ 	if (ret) {
+ #if !defined(CONFIG_XPL_BUILD) || defined(CONFIG_SPL_LIBCOMMON_SUPPORT)
+-		printf("MMC Device %d not found\n", dev_num);
++		dev_dbg(dev, "MMC Device %d not found\n", dev_num);
+ #endif
+ 		return NULL;
+ 	}
+diff --git a/drivers/mmc/mmc_legacy.c b/drivers/mmc/mmc_legacy.c
+index 8f8ba34be71..573521842f6 100644
+--- a/drivers/mmc/mmc_legacy.c
++++ b/drivers/mmc/mmc_legacy.c
+@@ -45,7 +45,7 @@ struct mmc *find_mmc_device(int dev_num)
+ 	}
+ 
+ #if !defined(CONFIG_XPL_BUILD) || defined(CONFIG_SPL_LIBCOMMON_SUPPORT)
+-	printf("MMC Device %d not found\n", dev_num);
++	dev_dbg(dev, "MMC Device %d not found\n", dev_num);
+ #endif
+ 
+ 	return NULL;
+-- 
+2.47.3
+
diff --git a/recipes-bsp/u-boot/u-boot-common-2026.01.inc b/recipes-bsp/u-boot/u-boot-common-2026.01.inc
index 850847fd..0c864a82 100644
--- a/recipes-bsp/u-boot/u-boot-common-2026.01.inc
+++ b/recipes-bsp/u-boot/u-boot-common-2026.01.inc
@@ -26,6 +26,12 @@ SRC_URI += " \
     file://0001-riscv-create-a-custom-CPU-implementation-for-PolarFi.patch \
     file://0002-riscv-mpfs-move-SoC-level-options-to-the-CPU-Kconfig.patch \
     file://0003-riscv-Add-support-for-BeagleV-Fire.patch \
+    file://0001-test-boot-measurement-Fix-compilation-for-non-sandbo.patch \
+    file://0002-tee-optee-Factor-out-service-enumeration-and-binding.patch \
+    file://0003-tee-optee-Add-support-for-enumerating-services-that-.patch \
+    file://0004-tee-optee-Do-not-warn-about-TEE_ERROR_STORAGE_NOT_AV.patch \
+    file://0005-mmc-Call-back-to-optee-after-a-successful-mmc_init.patch \
+    file://0006-mmc-Make-MMC-Device-not-found-a-debug-output.patch \
     file://rules.tmpl;subdir=debian"
 SRC_URI[sha256sum] = "b60d5865cefdbc75da8da4156c56c458e00de75a49b80c1a2e58a96e30ad0d54"
 
-- 
2.47.3


