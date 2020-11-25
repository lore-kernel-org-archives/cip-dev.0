Return-Path: <SRS0=P/rP=E7=lists.cip-project.org=bounce+64572+5874+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFEF4C5519F
	for <cip-dev@archiver.kernel.org>; Wed, 25 Nov 2020 08:55:43 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0C6E20637
	for <cip-dev@archiver.kernel.org>; Wed, 25 Nov 2020 08:55:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="X8WNcltp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0C6E20637
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5874+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id bqnnYY4521723xIu3df5vTxG; Wed, 25 Nov 2020 00:55:42 -0800
X-Received: from david.siemens.de (david.siemens.de [192.35.17.14])
 by mx.groups.io with SMTP id smtpd.web10.4281.1606294541244954016
 for <cip-dev@lists.cip-project.org>;
 Wed, 25 Nov 2020 00:55:41 -0800
X-Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by david.siemens.de (8.15.2/8.15.2) with ESMTPS id 0AP8td2v002308
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Wed, 25 Nov 2020 09:55:39 +0100
X-Received: from md2dvrtc.fritz.box ([167.87.32.40])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 0AP8tcJU019062;
	Wed, 25 Nov 2020 09:55:39 +0100
From: "Quirin Gylstorff" <quirin.gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org, Jan.Kiszka@siemens.com
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Subject: [cip-dev] [isar-cip-core][PATCH 1/2] start-qemu.sh: Change OVMF binary names
Date: Wed, 25 Nov 2020 09:55:37 +0100
Message-Id: <20201125085538.1561-2-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20201125085538.1561-1-Quirin.Gylstorff@siemens.com>
References: <20201125085538.1561-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: GUxu85jLjIQ00aIEIqwyRsv1x4520388AA=
Content-Type: multipart/mixed; boundary="MBlK5DFw2EdNRnDX2Zj2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1606294542;
 bh=h5IrY8IJwdVAMFR0EHJQEE8iX/joND8NHhTKcOaBCHg=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=X8WNcltppr/9Wl5WOi/rI5ofiU+H0HqGCV2OhxPDeSIshBsijvaQaJgidwQvLoPgeID
 FBY4t/m6HVotC9jygAr83RExTjyTxjDcqakbMfSe1iUL9YpjuVGgWGVDe2zanIaYkq8YV
 vYq66jr0lqO/rk3UvaZnINoSwT+KemZezWs=

--MBlK5DFw2EdNRnDX2Zj2
Content-Transfer-Encoding: 8bit

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Upstream changed the names of the OVMF binaries as
```
The existing 2MB images no longer have sufficient variable space for the
current Secure Boot Forbidden Signature Database.
```

Reference:
https://salsa.debian.org/qemu-team/edk2/-/commit/72d8cee9648dd79852ea976e6a8eac0727c27b7f
https://salsa.debian.org/qemu-team/edk2/-/commit/27f786b5fdd126b09c4e732429cc8a30191b72e6

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 doc/README.secureboot.md | 12 ++++++------
 start-qemu.sh            |  4 ++--
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/doc/README.secureboot.md b/doc/README.secureboot.md
index d79248b..4c4ab41 100644
--- a/doc/README.secureboot.md
+++ b/doc/README.secureboot.md
@@ -78,8 +78,8 @@ Set up a secure boot test environment with [QEMU](https://www.qemu.org/)
 
 ### Debian Snakeoil keys
 
-The build copies the  Debian Snakeoil keys to the directory `./build/tmp/deploy/images/<machine>/OVMF. Y
-u can use them as described in section [Start Image](### Start the image).
+The build copies the  Debian Snakeoil keys to the directory `./build/tmp/deploy/images/<machine>/OVMF. 
+You can use them as described in section [Start Image](### Start the image).
 
 ### Generate Keys
 
@@ -112,8 +112,8 @@ mkdir secureboot-tools
 cp -r keys secureboot-tools
 cp /lib/efitools/x86_64-linux-gnu/KeyTool.efi secureboot-tools
 ```
-2. Copy the file OVMF_VARS.fd (in Debian the file can be found at /usr/share/OVMF/OVMF_VARS.fd)
-to the current directory. OVMF_VARS.fd contains no keys can be instrumented for secureboot.
+2. Copy the file OVMF_VARS_4M.fd (in Debian the file can be found at /usr/share/OVMF/OVMF_VARS_4M.fd)
+to the current directory. OVMF_VARS_4M.fd contains no keys can be instrumented for secureboot.
 3. Start QEMU with the script scripts/start-efishell.sh
 ```
 scripts/start-efishell.sh secureboot-tools
@@ -172,7 +172,7 @@ SECURE_BOOT=y \
 ./start-qemu.sh amd64
 ```
 
-The default `OVMF_VARS.snakeoil.fd` boot to the EFI shell. To boot Linux enter the following command:
+The default `OVMF_VARS.snakeoil_4M.fd` boot to the EFI shell. To boot Linux enter the following command:
 ```
 FS0:\EFI\BOOT\bootx64.efi
 ```
@@ -182,7 +182,7 @@ To change the boot behavior, enter `exit` in the shell to enter the bios and cha
 Start the image with the following command:
 ```
 SECURE_BOOT=y \
-OVMF_CODE=./build/tmp/deploy/images/qemu-amd64/OVMF/OVMF_CODE.secboot.fd \
+OVMF_CODE=./build/tmp/deploy/images/qemu-amd64/OVMF/OVMF_CODE_4M.secboot.fd \
 OVMF_VARS=<path to the modified OVMF_VARS.fd> \
 ./start-qemu.sh amd64
 ```
diff --git a/start-qemu.sh b/start-qemu.sh
index e53cd99..6592ac6 100755
--- a/start-qemu.sh
+++ b/start-qemu.sh
@@ -94,8 +94,8 @@ fi
 shift 1
 
 if [ -n "${SECURE_BOOT}" ]; then
-		ovmf_code=${OVMF_CODE:-./build/tmp/deploy/images/qemu-amd64/OVMF/OVMF_CODE.secboot.fd}
-		ovmf_vars=${OVMF_VARS:-./build/tmp/deploy/images/qemu-amd64/OVMF/OVMF_VARS.snakeoil.fd}
+		ovmf_code=${OVMF_CODE:-./build/tmp/deploy/images/qemu-amd64/OVMF/OVMF_CODE_4M.secboot.fd}
+		ovmf_vars=${OVMF_VARS:-./build/tmp/deploy/images/qemu-amd64/OVMF/OVMF_VARS_4M.snakeoil.fd}
 		QEMU_EXTRA_ARGS=" ${QEMU_EXTRA_ARGS} \
 			-global ICH9-LPC.disable_s3=1 \
 			-global isa-fdc.driveA= "
-- 
2.20.1


--MBlK5DFw2EdNRnDX2Zj2
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5874): https://lists.cip-project.org/g/cip-dev/message=
/5874
Mute This Topic: https://lists.cip-project.org/mt/78496224/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--MBlK5DFw2EdNRnDX2Zj2--
