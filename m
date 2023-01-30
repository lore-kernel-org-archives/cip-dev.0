Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 993E1C54EAA
	for <webhook@archiver.kernel.org>; Mon, 30 Jan 2023 15:02:18 +0000 (UTC)
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by mx.groups.io with SMTP id smtpd.web11.43313.1675090929408667946
 for <cip-dev@lists.cip-project.org>;
 Mon, 30 Jan 2023 07:02:10 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=LcG88LAA;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.227, mailfrom: fm-51332-20230130150206efd74f737fcb10f244-bjdp3g@rts-flowmailer.siemens.com)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20230130150206efd74f737fcb10f244
        for <cip-dev@lists.cip-project.org>;
        Mon, 30 Jan 2023 16:02:06 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=W+7Q02x4ft4MkaZ3Qhp0t0ic1iEWJL4jTe3eSPktr0I=;
 b=LcG88LAAHoXtwv4NIXgsxUW82MdELZM2rtUQ1KD+FzzaKW6Y6FiS0qcqLWNt+bQifcY0NK
 T9jukRsMvpPbAS5cVHqjA7xjVDIsc2UmTV7RBdFdvnndzBnNi/3iGdoQHSJ92gxsioyqrvcb
 RpzOt8hVdIiRK8a1S46UjUwFocVno=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com,
	christian.storm@siemens.com
Subject: [cip-dev][isar-cip-core][RFC 1/5] add tpm.cfg to the kernel
Date: Mon, 30 Jan 2023 16:02:00 +0100
Message-Id: <20230130150204.697758-2-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20230130150204.697758-1-Quirin.Gylstorff@siemens.com>
References: <20230130150204.697758-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 30 Jan 2023 15:02:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10508

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This can be drop after the linux-cip configuration was updated.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 recipes-kernel/linux/files/tpm.cfg        | 13 +++++++++++++
 recipes-kernel/linux/linux-cip-common.inc |  2 ++
 2 files changed, 15 insertions(+)
 create mode 100644 recipes-kernel/linux/files/tpm.cfg

diff --git a/recipes-kernel/linux/files/tpm.cfg b/recipes-kernel/linux/files/tpm.cfg
new file mode 100644
index 0000000..22268ae
--- /dev/null
+++ b/recipes-kernel/linux/files/tpm.cfg
@@ -0,0 +1,13 @@
+CONFIG_AS_SHA256_NI=y
+CONFIG_CRYPTO_HMAC=y
+CONFIG_CRYPTO_SHA256_SSSE3=y
+CONFIG_CRYPTO_SHA256=y
+CONFIG_CRYPTO_DRBG_HMAC=y
+CONFIG_CRYPTO_LIB_SHA256=y
+CONFIG_CRYPTO_XTS=y
+CONFIG_SECURITYFS=y
+CONFIG_TCG_TPM=m
+CONFIG_TCG_TIS_CORE=m
+CONFIG_TCG_TIS=m
+CONFIG_TCG_TIS_SPI=m
+CONFIG_TCG_CRB=m
diff --git a/recipes-kernel/linux/linux-cip-common.inc b/recipes-kernel/linux/linux-cip-common.inc
index 9b6cd3b..e4292a6 100644
--- a/recipes-kernel/linux/linux-cip-common.inc
+++ b/recipes-kernel/linux/linux-cip-common.inc
@@ -23,6 +23,8 @@ SRC_URI_append = " ${@ "git://gitlab.com/cip-project/cip-kernel/cip-kernel-confi
     if d.getVar('USE_CIP_KERNEL_CONFIG') == '1' else '' \
     }"
 
+SRC_URI += "file://tpm.cfg"
+
 SRCREV_cip-kernel-config ?= "ce52837418aea714e780e0cbc8afb9515c12cc1b"
 
 S = "${WORKDIR}/linux-cip-${PV}"
-- 
2.39.0


