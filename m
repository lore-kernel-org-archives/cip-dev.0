Return-Path: <sai.sathujoda@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A61AC36001
	for <webhook@archiver.kernel.org>; Wed, 19 Mar 2025 09:28:00 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.web11.3786.1742376476916245371
 for <cip-dev@lists.cip-project.org>;
 Wed, 19 Mar 2025 02:27:57 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.152, mailfrom: sai.sathujoda@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 52J9RsRE153621; Wed, 19 Mar 2025 18:27:55 +0900
X-Iguazu-Qid: 2yAbaKzOgqtug8Q1P1
X-Iguazu-QSIG: v=2; s=0; t=1742376474; q=2yAbaKzOgqtug8Q1P1; m=NENGq+yAEekjQjSqgiSf+2ofvimhVbxijcKEUTVhlV4=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1801) id 52J9RrSU547813
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 19 Mar 2025 18:27:54 +0900
From: Sai.Sathujoda@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>,
        dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core v1 1/2] tests/templates: Move smp option from templates to test job submit script
Date: Wed, 19 Mar 2025 14:54:38 +0530
X-TSB-HOP2: ON
Message-Id: <20250319092440.1328092-1-Sai.Sathujoda@toshiba-tsip.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 19 Mar 2025 09:27:51.0451 (UTC) FILETIME=[2FB3D6B0:01DB98B1]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 19 Mar 2025 09:28:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18246

From: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>

Signed-off-by: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>
---
 tests/templates/IEC_template.yml             | 2 +-
 tests/templates/secureboot_negative_test.yml | 2 +-
 tests/templates/secureboot_template.yml      | 2 +-
 tests/templates/swupdate_negative_test.yml   | 2 +-
 tests/templates/swupdate_template.yml        | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/tests/templates/IEC_template.yml b/tests/templates/IEC_template.yml
index a196bb5..3c33773 100644
--- a/tests/templates/IEC_template.yml
+++ b/tests/templates/IEC_template.yml
@@ -34,7 +34,7 @@ actions:
     to: tmpfs
     images:
       system:
-        image_arg: '-drive file={system},discard=unmap,if=none,id=disk,format=raw -m 1G -serial mon:stdio -smp 4
+        image_arg: '-drive file={system},discard=unmap,if=none,id=disk,format=raw -m 1G -serial mon:stdio
                     -nographic -netdev user,id=net,hostfwd=tcp:127.0.0.1:22222-:22 -chardev socket,id=chrtpm,path=/tmp/qemu-swtpm.sock
                     -tpmdev emulator,id=tpm0,chardev=chrtpm #imageargs#'
         url: #project_url#/#branch#/#architecture#/cip-core-image-security-cip-core-#distribution#-#architecture#.wic.xz
diff --git a/tests/templates/secureboot_negative_test.yml b/tests/templates/secureboot_negative_test.yml
index 568b5b6..2fcdbfa 100644
--- a/tests/templates/secureboot_negative_test.yml
+++ b/tests/templates/secureboot_negative_test.yml
@@ -51,7 +51,7 @@ actions:
     to: tmpfs
     images:
       system:
-        image_arg: '-drive file={system},discard=unmap,if=none,id=disk,format=raw -m 1G -serial mon:stdio -smp 4
+        image_arg: '-drive file={system},discard=unmap,if=none,id=disk,format=raw -m 1G -serial mon:stdio
                     -nographic -netdev user,id=net,hostfwd=tcp:127.0.0.1:22222-:22 -chardev socket,id=chrtpm,path=/tmp/qemu-swtpm.sock
                     -tpmdev emulator,id=tpm0,chardev=chrtpm #imageargs#'
         url: downloads://cip-core-image-security-cip-core-#distribution#-#architecture#.wic
diff --git a/tests/templates/secureboot_template.yml b/tests/templates/secureboot_template.yml
index 1b8e882..e29b64a 100644
--- a/tests/templates/secureboot_template.yml
+++ b/tests/templates/secureboot_template.yml
@@ -34,7 +34,7 @@ actions:
     to: tmpfs
     images:
       system:
-        image_arg: '-drive file={system},discard=unmap,if=none,id=disk,format=raw -m 1G -serial mon:stdio -smp 4
+        image_arg: '-drive file={system},discard=unmap,if=none,id=disk,format=raw -m 1G -serial mon:stdio
                     -nographic -netdev user,id=net,hostfwd=tcp:127.0.0.1:22222-:22 -chardev socket,id=chrtpm,path=/tmp/qemu-swtpm.sock
                     -tpmdev emulator,id=tpm0,chardev=chrtpm #imageargs#'
         url: #project_url#/#branch#/#architecture#/cip-core-image-security-cip-core-#distribution#-#architecture#.wic.xz
diff --git a/tests/templates/swupdate_negative_test.yml b/tests/templates/swupdate_negative_test.yml
index 42297a8..bb79b07 100644
--- a/tests/templates/swupdate_negative_test.yml
+++ b/tests/templates/swupdate_negative_test.yml
@@ -42,7 +42,7 @@ actions:
     to: tmpfs
     images:
       system:
-        image_arg: '-drive file={system},discard=unmap,if=none,id=disk,format=raw -m 1G -serial mon:stdio -smp 4
+        image_arg: '-drive file={system},discard=unmap,if=none,id=disk,format=raw -m 1G -serial mon:stdio
                     -nographic -netdev user,id=net,hostfwd=tcp:127.0.0.1:22222-:22 -chardev socket,id=chrtpm,path=/tmp/qemu-swtpm.sock
                     -tpmdev emulator,id=tpm0,chardev=chrtpm #imageargs#'
         url: #project_url#/#branch#/#architecture#/cip-core-image-security-cip-core-#distribution#-#architecture#.wic.xz
diff --git a/tests/templates/swupdate_template.yml b/tests/templates/swupdate_template.yml
index 67bee03..e1f71a9 100644
--- a/tests/templates/swupdate_template.yml
+++ b/tests/templates/swupdate_template.yml
@@ -34,7 +34,7 @@ actions:
     to: tmpfs
     images:
       system:
-        image_arg: '-drive file={system},discard=unmap,if=none,id=disk,format=raw -m 1G -serial mon:stdio -smp 4
+        image_arg: '-drive file={system},discard=unmap,if=none,id=disk,format=raw -m 1G -serial mon:stdio
                     -nographic -netdev user,id=net,hostfwd=tcp:127.0.0.1:22222-:22 -chardev socket,id=chrtpm,path=/tmp/qemu-swtpm.sock
                     -tpmdev emulator,id=tpm0,chardev=chrtpm #imageargs#'
         url: #project_url#/#branch#/#architecture#/cip-core-image-security-cip-core-#distribution#-#architecture#.wic.xz
-- 
2.30.2



