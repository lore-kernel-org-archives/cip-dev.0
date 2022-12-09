Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29629C4708D
	for <webhook@archiver.kernel.org>; Fri,  9 Dec 2022 14:58:34 +0000 (UTC)
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by mx.groups.io with SMTP id smtpd.web10.3360.1670597912221226893
 for <cip-dev@lists.cip-project.org>;
 Fri, 09 Dec 2022 06:58:33 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=a4/kHEhn;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.227, mailfrom: fm-51332-20221209145829e4486d7441bdb2eb98-hlbrsj@rts-flowmailer.siemens.com)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20221209145829e4486d7441bdb2eb98
        for <cip-dev@lists.cip-project.org>;
        Fri, 09 Dec 2022 15:58:29 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=S+RK0Q8U3bsbeJPY73uqbWnAW2mgGas1DMAULZya7nU=;
 b=a4/kHEhnsB2DSp3lPo0POMB1MwtEYF24/sXlQV6LvzXxdpAmMl/BXNVi1ffn258WmTt3Fk
 ly3jOervQ6t7wCoTY/lnStLaCAHJwnDLanvbYvSVCppslab2Tm6Myg5YeBIBsZ4tv3bpJ9iu
 gBxdGCw9CEOfpE+22F22EXrnGnEPg=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	felix.moessbauer@siemens.com,
	jan.kiszka@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH v2 2/4] swupdate-handler-roundrobin: Increase revision for configfilecheck
Date: Fri,  9 Dec 2022 15:58:25 +0100
Message-Id: <20221209145827.1309521-3-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20221209145827.1309521-1-Quirin.Gylstorff@siemens.com>
References: <20221209145827.1309521-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 09 Dec 2022 14:58:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10172

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This new revision allows use to check if an update is already installed.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 .../swupdate-handler-roundrobin_0.1.bb                          | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-core/swupdate-handler-roundrobin/swupdate-handler-roundrobin_0.1.bb b/recipes-core/swupdate-handler-roundrobin/swupdate-handler-roundrobin_0.1.bb
index 5801113..b39278e 100644
--- a/recipes-core/swupdate-handler-roundrobin/swupdate-handler-roundrobin_0.1.bb
+++ b/recipes-core/swupdate-handler-roundrobin/swupdate-handler-roundrobin_0.1.bb
@@ -13,7 +13,7 @@ inherit dpkg-raw
 PROVIDES = "swupdate-handlers"
 
 SRC_URI += "git://gitlab.com/cip-project/cip-sw-updates/swupdate-handler-roundrobin.git;protocol=https;destsuffix=swupdate-handler-roundrobin;name=swupdate-handler-roundrobin;nobranch=1"
-SRCREV_swupdate-handler-roundrobin ?= "bf73f04b1eec0b8714d3a1b56bfcd1431c58ba10"
+SRCREV_swupdate-handler-roundrobin ?= "bb35127231ec08a67f79a7584ccfc0cada88cc4e"
 
 SWUPDATE_LUASCRIPT = "swupdate-handler-roundrobin/swupdate_handlers_roundrobin.lua"
 
-- 
2.35.1


