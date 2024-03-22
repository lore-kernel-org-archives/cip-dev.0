Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDC68C54E71
	for <webhook@archiver.kernel.org>; Fri, 22 Mar 2024 10:06:19 +0000 (UTC)
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
 by mx.groups.io with SMTP id smtpd.web10.9305.1711101968829621960
 for <cip-dev@lists.cip-project.org>;
 Fri, 22 Mar 2024 03:06:10 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=j8E8i9gu;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.226, mailfrom: fm-51332-2024032210060988466ad6147c5770fe-otue2v@rts-flowmailer.siemens.com)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 2024032210060988466ad6147c5770fe
        for <cip-dev@lists.cip-project.org>;
        Fri, 22 Mar 2024 11:06:09 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=vKG0QWWeocWNrOMY/O6gIN+Kmj6q0BWXuIYB8sqm+Xg=;
 b=j8E8i9gub1B5lBy+sFxO6fL7O17pDvjot2CVeaEuOWi3gq+JPVvHgAms93klCBslhhCv4h
 esKDyZM6/wQWkJccNLaKv1CKwM3hBTie9r0AYpgds7ARU0XHh6YpQpemf8IMWPOxvFeE/J9l
 7ukeFZ131tpm4ZdLrLDeEwjByW9pY=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org,
	johnxw@amazon.com
Subject: [cip-dev][isar-cip-core][PATCH v2 12/13] README.tpm2.encryption: Add section to switch from clevis to systemd
Date: Fri, 22 Mar 2024 11:05:22 +0100
Message-ID: <20240322100605.4129226-13-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20240322100605.4129226-1-Quirin.Gylstorff@siemens.com>
References: <20240322100605.4129226-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 22 Mar 2024 10:06:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15406

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 doc/README.tpm2.encryption.md | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/doc/README.tpm2.encryption.md b/doc/README.tpm2.encryption.md
index cb3f640..69a18dd 100644
--- a/doc/README.tpm2.encryption.md
+++ b/doc/README.tpm2.encryption.md
@@ -48,3 +48,23 @@ Each entry uses the schema `<partition-label>:<mountpoint>:<reencrypt or format>
 
 The variable `CRYPT_CREATE_FILE_SYSTEM_CMD` contains the command to create a new file system on a newly
 encrypted partition. The Default (`mke2fs -t ext4`) creates an ext4 partition.
+
+# Convert clevis based encryption to systemd-cryptenroll
+## Prerequisites
+The following packages are necessary to convert a clevis based encryption to a systemd-cryptenroll
+based encryption:
+ - clevis-luks
+ - clevis-tpm2
+ - cryptsetup
+ - jq
+
+## steps to convert clevis to systemd
+The following script shows how to enroll a systemd-tpm2 token with a existinng clevis based encryption:
+```bash
+export device=/dev/sda6
+export keyslot=$(sudo cryptsetup luksDump "$device" --dump-json-metadata | jq -c '.tokens.[] | select( .type == "clevis") | .keyslots | first' | head -n1)
+if [ -n "$keyslot" ]; then
+  export PASSWORD=$(clevis luks pass -d "$device" -s"$keyslot")
+  systemd-cryptenroll --tpm2-device="$tpm_device" --tpm2-pcrs=7 "$device"
+fi
+```
-- 
2.43.0


