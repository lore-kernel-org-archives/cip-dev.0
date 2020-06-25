Return-Path: <SRS0=MVZy=AG=lists.cip-project.org=bounce+64572+4828+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF955C433E5
	for <cip-dev@archiver.kernel.org>; Thu, 25 Jun 2020 14:10:22 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCF162065F
	for <cip-dev@archiver.kernel.org>; Thu, 25 Jun 2020 14:10:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="j4Ui9XST"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCF162065F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4828+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 0ItkYY4521723x4nGkXY7u0p; Thu, 25 Jun 2020 07:10:22 -0700
X-Received: from david.siemens.de (david.siemens.de [192.35.17.14])
 by mx.groups.io with SMTP id smtpd.web11.11425.1593094221016138583
 for <cip-dev@lists.cip-project.org>;
 Thu, 25 Jun 2020 07:10:21 -0700
X-Received: from mail1.sbs.de (mail1.sbs.de [192.129.41.35])
	by david.siemens.de (8.15.2/8.15.2) with ESMTPS id 05PEAJNt021321
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Thu, 25 Jun 2020 16:10:19 +0200
X-Received: from md2dvrtc.ad001.siemens.net ([167.87.6.122])
	by mail1.sbs.de (8.15.2/8.15.2) with ESMTP id 05PEAFXZ000356;
	Thu, 25 Jun 2020 16:10:19 +0200
From: "Quirin Gylstorff" <quirin.gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org, Jan.Kiszka@siemens.com
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Subject: [cip-dev] [isar-cip-core RFC 6/7] swupdate: Add luahandler for secureboot
Date: Thu, 25 Jun 2020 16:10:14 +0200
Message-Id: <20200625141015.31719-7-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20200625141015.31719-1-Quirin.Gylstorff@siemens.com>
References: <20200625141015.31719-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: ZjBKrP6ecAvvmeGOa161N0jdx4520388AA=
Content-Type: multipart/mixed; boundary="I3GscHJplM7Z9LhAfn5O"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1593094222;
 bh=vWJJhftvgjiyE7TBJP3YIIWuznCmOV40wyuROcaH8eg=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=j4Ui9XST8Tx/P4XDZbdNgWaBFHBjMzPAi1toCrzAKblmHNB/Sv9JC1O/i1DDtZ5oNwH
 o2PgcIhrJwFYYcHbZdCCGPVNDBvO1ASzONvmWUxaBPzsRKsRDXSim891BTm2S9Vo6nYGp
 OHkN3+cF9GpLRPvlDqxEM7/vxgFVWB2iSbE=

--I3GscHJplM7Z9LhAfn5O
Content-Transfer-Encoding: 8bit

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 recipes-core/swupdate/files/swupdate_handlers.lua | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/recipes-core/swupdate/files/swupdate_handlers.lua b/recipes-core/swupdate/files/swupdate_handlers.lua
index c9b9962..f2ecc54 100644
--- a/recipes-core/swupdate/files/swupdate_handlers.lua
+++ b/recipes-core/swupdate/files/swupdate_handlers.lua
@@ -311,8 +311,12 @@ function handler_roundrobin(image)
         if rootparam and rootdevice then break end
     end
     if not rootdevice then
-      swupdate.error("Cannot determine current root device.")
-      return 1
+        -- Use findmnt to get the rootdev
+      rootdevice = io.popen('findmnt -nl / -o PARTUUID'):read("*l")
+      if not rootdevice then
+        swupdate.error("Cannot determine current root device.")
+        return 1
+      end
     end
     swupdate.info(string.format("Current root device is: %s", rootdevice))
 
-- 
2.20.1


--I3GscHJplM7Z9LhAfn5O
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4828): https://lists.cip-project.org/g/cip-dev/message=
/4828
Mute This Topic: https://lists.cip-project.org/mt/75103454/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--I3GscHJplM7Z9LhAfn5O--
