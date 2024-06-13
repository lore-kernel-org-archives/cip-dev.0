Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E371C27C4F
	for <webhook@archiver.kernel.org>; Thu, 13 Jun 2024 09:16:41 +0000 (UTC)
Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
 by mx.groups.io with SMTP id smtpd.web11.3965.1718270199772358175
 for <cip-dev@lists.cip-project.org>;
 Thu, 13 Jun 2024 02:16:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm2 header.b=UgZDfv3a;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.225, mailfrom: fm-51332-2024061309163796315b8287e3d424e3-nyxowr@rts-flowmailer.siemens.com)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 2024061309163796315b8287e3d424e3
        for <cip-dev@lists.cip-project.org>;
        Thu, 13 Jun 2024 11:16:37 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=r00BKmYRaG9mh+idAZUG3Qi4JdNiaB67rXPDjIq9/7k=;
 b=UgZDfv3a8Wf3USjw/rJO3XtnUSv2HjlfkDGmU+vqcnYQyZvhsdlevfk7gW8rvx6r4asdLX
 e1L94uJ0nx9tpQFAalZdYmwy+folgiL88BfvW1UH1TK7SCd1N0XT65yMHL8/YRp+Do9a+tBZ
 VqL4NoWOEuFJMAf0kv2aFPQqdQfpM=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org
Subject: [cip-dev][isar-cip-core][PATCH v4 2/2] wic/ebg*sysparts.inc increase the size of the boot partitions
Date: Thu, 13 Jun 2024 11:16:19 +0200
Message-ID: <20240613091636.1156475-3-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20240613091636.1156475-1-Quirin.Gylstorff@siemens.com>
References: <20240613091636.1156475-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 13 Jun 2024 09:16:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16196

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This fixes a build error with the following error message:

```
 INFO: sign with script /usr/bin/sign_secure_image.sh
 ERROR: _exec_cmd: export PATH=//sbin://usr/sbin://usr/bin://usr/bin/None://bin:None:$PATH;mcopy -i /tmp/cip-core-image-security-cip-core-bookworm-qemu-arm64.wic/tmp.wic.yo_hrfgu/BOOT0.2.img -s /tmp/cip-core-image-security-cip-core-bookworm-qemu-arm64.wic/tmp.wic.yo_hrfgu/disk/BOOT0.2/* ::/ returned '1' instead of 0
 output: Disk full
```

This error occurs as the unfied kernel image can be greater than 31MB.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 wic/ebg-signed-sysparts.inc | 6 +++---
 wic/ebg-sysparts.inc        | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/wic/ebg-signed-sysparts.inc b/wic/ebg-signed-sysparts.inc
index be63cd7..9292eee 100644
--- a/wic/ebg-signed-sysparts.inc
+++ b/wic/ebg-signed-sysparts.inc
@@ -1,8 +1,8 @@
 # default partition layout EFI Boot Guard usage, signed version
 
 # EFI partition containing efibootguard bootloader binary
-part --source efibootguard-efi  --size 16M --extra-space 0 --overhead-factor 1 --label efi   --align 1024 --part-type=EF00 --active --sourceparams "signwith=/usr/bin/sign_secure_image.sh" --fsuuid 0x4321dcba --uuid d1360f76-b09a-4bcc-b923-8195088cbe02
+part --source efibootguard-efi  --size 16M --label efi   --align 1024 --part-type=EF00 --active --sourceparams "signwith=/usr/bin/sign_secure_image.sh" --fsuuid 0x4321dcba --uuid d1360f76-b09a-4bcc-b923-8195088cbe02
 
 # EFI Boot Guard environment/config partitions plus Kernel files
-part --source efibootguard-boot --size 32M --extra-space 0 --overhead-factor 1 --label BOOT0 --align 1024 --part-type=0700 --sourceparams "revision=2,signwith=/usr/bin/sign_secure_image.sh" --fsuuid 0x4321dcbb --uuid f870258b-706f-4a66-8d58-b5a75ce61b8b
-part --source efibootguard-boot --size 32M --extra-space 0 --overhead-factor 1 --label BOOT1 --align 1024 --part-type=0700 --sourceparams "revision=1,signwith=/usr/bin/sign_secure_image.sh" --fsuuid 0x4321dcbc --uuid 6e41f2a7-e3eb-403f-8637-b111e4482ee9
+part --source efibootguard-boot --fixed-size 64M --label BOOT0 --align 1024 --part-type=0700 --sourceparams "revision=2,signwith=/usr/bin/sign_secure_image.sh" --fsuuid 0x4321dcbb --uuid f870258b-706f-4a66-8d58-b5a75ce61b8b
+part --source efibootguard-boot --fixed-size 64M --label BOOT1 --align 1024 --part-type=0700 --sourceparams "revision=1,signwith=/usr/bin/sign_secure_image.sh" --fsuuid 0x4321dcbc --uuid 6e41f2a7-e3eb-403f-8637-b111e4482ee9
diff --git a/wic/ebg-sysparts.inc b/wic/ebg-sysparts.inc
index 121dc73..ab6c817 100644
--- a/wic/ebg-sysparts.inc
+++ b/wic/ebg-sysparts.inc
@@ -1,8 +1,8 @@
 # default partition layout EFI Boot Guard usage
 
 # EFI partition containing efibootguard bootloader binary
-part --source efibootguard-efi  --size 16M --extra-space 0 --overhead-factor 1 --label efi   --align 1024 --part-type=EF00 --active --fsuuid 0x4321dcba --uuid c19e7e9f-bacf-49a6-b43d-2fc18d2a8d03
+part --source efibootguard-efi  --fixed-size 16M --label efi   --align 1024 --part-type=EF00 --active --fsuuid 0x4321dcba --uuid c19e7e9f-bacf-49a6-b43d-2fc18d2a8d03
 
 # EFI Boot Guard environment/config partitions plus Kernel files
-part --source efibootguard-boot --size 32M --extra-space 0 --overhead-factor 1 --label BOOT0 --align 1024 --part-type=0700 --sourceparams "revision=2" --fsuuid 0x4321dcbb --uuid e8567692-2dfa-459a-be15-f6e5ddcc8f49
-part --source efibootguard-boot --size 32M --extra-space 0 --overhead-factor 1 --label BOOT1 --align 1024 --part-type=0700 --sourceparams "revision=1" --fsuuid 0x4321dcbc --uuid 94b2174d-c792-4e8e-8a34-b506e2927937
+part --source efibootguard-boot --fixed-size 64M --label BOOT0 --align 1024 --part-type=0700 --sourceparams "revision=2" --fsuuid 0x4321dcbb --uuid e8567692-2dfa-459a-be15-f6e5ddcc8f49
+part --source efibootguard-boot --fixed-size 64M --label BOOT1 --align 1024 --part-type=0700 --sourceparams "revision=1" --fsuuid 0x4321dcbc --uuid 94b2174d-c792-4e8e-8a34-b506e2927937
-- 
2.43.0


