Return-Path: <srinuvasan.a@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99651E6C60D
	for <webhook@archiver.kernel.org>; Tue,  3 Dec 2024 06:52:52 +0000 (UTC)
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
 by mx.groups.io with SMTP id smtpd.web10.13569.1733208765827089809
 for <cip-dev@lists.cip-project.org>;
 Mon, 02 Dec 2024 22:52:46 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=srinuvasan.a@siemens.com header.s=fm2 header.b=GwpaByEQ;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.228, mailfrom: fm-1324425-20241203065242744bf40281f5b76c7a-qg6yic@rts-flowmailer.siemens.com)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20241203065242744bf40281f5b76c7a
        for <cip-dev@lists.cip-project.org>;
        Tue, 03 Dec 2024 07:52:42 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=srinuvasan.a@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=Gpty66mdX5Zgr72EyyUiYKwtHZz+w6dimq66N4kXnSs=;
 b=GwpaByEQwyM0HGymSyL9LR/QjBW/Y7h3YfJgrnSlzaPKeGAxoG9rcboSTdObHeVGb1dlCS
 oDeI52andXBXz10y4O4BPPb16eQ5NqP25WLWabzflcJM0ZQrYMGtA6T2ObaA7qCA3RxDjh0O
 aoTCPvdq7ejvuglYCrqN5LyrZ0Uu5X4KFNqC2zumNhBjBiNsc42Z+/S9p4BPop7jA7tfQOWR
 d3ACmQdzQJptE8VfAgYeLKXTfu+WM4pPqUl9yVDXKJTlkQG9NLD0yadhWCW6VpOEic7vDdK8
 mV6huRDb33RmkkVtWFGJkxt4PuLZsQS7bGjX19Ut6p4HzbP9ZpfE9Isg==;
From: srinuvasan.a@siemens.com
To: cip-dev@lists.cip-project.org
Cc: jan.kiszka@siemens.com,
	srinuvasan <srinuvasan.a@siemens.com>
Subject: [isar-cip-core][PATCH] recipes-initramfs: remove redundant initramfs-tools DEBIAN_DEPENDS
Date: Tue,  3 Dec 2024 12:30:34 +0530
Message-Id: <20241203070034.1124199-1-srinuvasan.a@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1324425:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 03 Dec 2024 06:52:52 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17321

From: srinuvasan <srinuvasan.a@siemens.com>

With the inclusion of hook.inc in the initramfs recipes, the initramfs-tools
defined in the DEBIAN_DEPENDS, hence no need to add it externally in the recipes,
just cleaned that.

Signed-off-by: srinuvasan <srinuvasan.a@siemens.com>
---
 .../initramfs-overlay-hook/initramfs-overlay-hook_0.2.bb        | 2 +-
 .../initramfs-verity-hook/initramfs-verity-hook_0.2.bb          | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0.2.bb b/recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0.2.bb
index e6ac1e9..a9e4ca2 100644
--- a/recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0.2.bb
+++ b/recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0.2.bb
@@ -40,7 +40,7 @@ TEMPLATE_VARS += " INITRAMFS_OVERLAY_STORAGE_PATH \
     INITRAMFS_OVERLAY_MOUNT_OPTION \
     INITRAMFS_OVERLAY_RECOVERY_SCRIPT"
 
-DEBIAN_DEPENDS = "initramfs-tools, awk, coreutils, util-linux"
+DEBIAN_DEPENDS .= ", awk, coreutils, util-linux"
 
 HOOK_ADD_MODULES = "overlay"
 HOOK_ADD_EXECS = "mountpoint awk e2fsck mke2fs"
diff --git a/recipes-initramfs/initramfs-verity-hook/initramfs-verity-hook_0.2.bb b/recipes-initramfs/initramfs-verity-hook/initramfs-verity-hook_0.2.bb
index d8f62bb..a6c4666 100644
--- a/recipes-initramfs/initramfs-verity-hook/initramfs-verity-hook_0.2.bb
+++ b/recipes-initramfs/initramfs-verity-hook/initramfs-verity-hook_0.2.bb
@@ -21,7 +21,7 @@ VERITY_BEHAVIOR_ON_CORRUPTION ?= "--restart-on-corruption"
 TEMPLATE_FILES += "local-top-complete.tmpl"
 TEMPLATE_VARS += "VERITY_BEHAVIOR_ON_CORRUPTION"
 
-DEBIAN_DEPENDS = "initramfs-tools, cryptsetup"
+DEBIAN_DEPENDS .= ", cryptsetup"
 DEBIAN_CONFLICTS = "initramfs-abrootfs-hook"
 
 HOOK_ADD_MODULES = "dm_mod dm_verity"
-- 
2.39.5


