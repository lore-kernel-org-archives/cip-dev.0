Return-Path: <srinuvasan_a@mentor.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73852C7EE23
	for <webhook@archiver.kernel.org>; Wed, 24 May 2023 09:47:54 +0000 (UTC)
Received: from esa2.mentor.iphmx.com (esa2.mentor.iphmx.com [68.232.141.98])
 by mx.groups.io with SMTP id smtpd.web10.4943.1684921665333352559
 for <cip-dev@lists.cip-project.org>;
 Wed, 24 May 2023 02:47:45 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: mentor.com, ip: 68.232.141.98, mailfrom: srinuvasan_a@mentor.com)
X-IronPort-AV: E=Sophos;i="6.00,188,1681200000"; 
   d="scan'208";a="7054836"
Received: from orw-gwy-01-in.mentorg.com ([192.94.38.165])
  by esa2.mentor.iphmx.com with ESMTP; 24 May 2023 01:47:44 -0800
IronPort-SDR: OGRopsXR2HzIbU0GSTcv4MZTIClzMhvUmlsRlTdqeiNe5M6ckKrt23TLTFSM3DUCOZXUQgI1lg
 ayWkR86rzoMv2MKI4AhKNXR21l4suE5w+DtD4t2XAd4e0qnXFFCQrFKk5RgP5/K0JNXzZahcPj
 w1em3flFetnt4m4vabhZsryTXFkur1NQin8yPusp3+Mmi75/dZQnQWoQMgqzXERfD2RfGlCwAI
 492o9w6MevLBoo8B7f9K3TrrmgoDgiB1MelZfY+O1F3zhs4Eg1m9MdDrdNaHRb/Fz5RH0kTDJ/
 RV8=
From: Srinuvasan Arjunan <srinuvasan_a@mentor.com>
To: <cip-dev@lists.cip-project.org>
CC: <jan.kiszka@siemens.com>, Srinuvasan A <srinuvasan.a@siemens.com>
Subject: [isar-cip-core][PATCH] Drop redundant expand=True parameter from getVar
Date: Wed, 24 May 2023 15:17:24 +0530
Message-ID: <20230524094724.1953389-1-srinuvasan_a@mentor.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: svr-orw-mbx-13.mgc.mentorg.com (147.34.90.213) To
 svr-orw-mbx-13.mgc.mentorg.com (147.34.90.213)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 24 May 2023 09:47:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11632

From: Srinuvasan A <srinuvasan.a@siemens.com>

It is long True by default, but people keep adding new cases of this
redundancy, hence fix this one.

Signed-off-by: Srinuvasan A <srinuvasan.a@siemens.com>
---
 classes/image_uuid.bbclass | 2 +-
 classes/swupdate.bbclass   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/classes/image_uuid.bbclass b/classes/image_uuid.bbclass
index 9ffe14d..f6b631f 100644
--- a/classes/image_uuid.bbclass
+++ b/classes/image_uuid.bbclass
@@ -18,7 +18,7 @@ inherit image
 def generate_image_uuid(d):
     import uuid
 
-    base_hash = d.getVar("BB_TASKHASH", True)
+    base_hash = d.getVar("BB_TASKHASH")
     if base_hash is None:
         return None
     return str(uuid.UUID(base_hash[:32], version=4))
diff --git a/classes/swupdate.bbclass b/classes/swupdate.bbclass
index 9a4d509..1056ab5 100644
--- a/classes/swupdate.bbclass
+++ b/classes/swupdate.bbclass
@@ -67,7 +67,7 @@ python(){
 
 # convert between swupdate compressor name and imagetype extension
 def get_swu_compression_type(d):
-    swu_ct = d.getVar('SWU_COMPRESSION_TYPE', True)
+    swu_ct = d.getVar('SWU_COMPRESSION_TYPE')
     if not swu_ct:
         return ''
     swu_to_image = {'zlib': '.gz', 'zstd': '.zst'}
-- 
2.34.1


