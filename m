Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAE5EC87FCF
	for <webhook@archiver.kernel.org>; Wed, 13 Aug 2025 10:14:20 +0000 (UTC)
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
 by mx.groups.io with SMTP id smtpd.web11.97381.1755080050998192707
 for <cip-dev@lists.cip-project.org>;
 Wed, 13 Aug 2025 03:14:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm2 header.b=Brx9s695;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.226, mailfrom: fm-51332-202508131014066491eab2d67879c748-s2y7tm@rts-flowmailer.siemens.com)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 202508131014066491eab2d67879c748
        for <cip-dev@lists.cip-project.org>;
        Wed, 13 Aug 2025 12:14:07 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=mxRvMK82KL1zVgX2dT6l8gSkSZObcod+KjesQlvkfSs=;
 b=Brx9s695GpO6FrL8pSKn3WNV+LupvvQ6bNh9f+0LcGQ5+03g9sMLu56gscjoeP8kYUgnE/
 amUverZZhw1OsnxxmSzLr9mMrYu17BUAfmB8+lrVNGLKaq/eSeYKR0gvBx36nDXZRSuJZG5M
 TZQT/Aq0bXwqx6a9I7n0LJ+ILSYpcrFSYM79GC87fGx5+i4Ei4gnldBGwtogPJjooeyK1e0W
 uUIoo3l1Wvi/4aczp9re/aAYYZa0q+QFYcoBCSrPOZgb2/i54IUE8rw07DqWZZqnwk+o2JJA
 VzL6byKrZ4xU/hgbEc1U0XgnWW4e3+4Raz5jXkG1b8oyOpvqpkXwYx8g==;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org
Subject: [PATCH 3/3] Add doc for update to trixie
Date: Wed, 13 Aug 2025 12:13:02 +0200
Message-ID: <20250813101406.1372766-3-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20250813101406.1372766-1-Quirin.Gylstorff@siemens.com>
References: <20250813101406.1372766-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 13 Aug 2025 10:14:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19726

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 doc/update-to-trixie.md | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)
 create mode 100644 doc/update-to-trixie.md

diff --git a/doc/update-to-trixie.md b/doc/update-to-trixie.md
new file mode 100644
index 0000000..64e67ae
--- /dev/null
+++ b/doc/update-to-trixie.md
@@ -0,0 +1,18 @@
+# Update from Debian bookworm to Debian trixie
+
+This document describes the changes necessary to build a Debian trixie image based isar-cip-core.
+With Debian trixie cip-core will no longer build SWUpdate from source but will use SWUpdate
+as provided by Debian trixie.
+
+Updates from a system without signing to signing enabled on are possible with a signed swu.
+
+## SWU signing is now mandatory
+
+In isar-cip-core we use the debian snakeoil keys as signing samples. This keys must not be
+used in production. To generate own keys you can follow the instructions in [README.signing.md](doc/README.signing.md#use-self-signed-certificates).  To enable signing with the
+debian-snakeoil keys set the variable SWU_SIGNED to "1".
+```
+SWU_SIGNED = "1"
+PREFERRED_PROVIDER_swupdate-certificates-key = "swupdate-certificates-key-snakeoil"
+PREFERRED_PROVIDER_swupdate-certificates = "swupdate-certificates-snakeoil"
+```
-- 
2.50.1


