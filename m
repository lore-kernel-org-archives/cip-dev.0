Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67EDBC63797
	for <webhook@archiver.kernel.org>; Fri,  3 Feb 2023 10:51:49 +0000 (UTC)
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by mx.groups.io with SMTP id smtpd.web10.7809.1675421506050453089
 for <cip-dev@lists.cip-project.org>;
 Fri, 03 Feb 2023 02:51:47 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=FppqzJMB;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.227, mailfrom: fm-51332-202302031051445cd2a55841043f0538-ghigtr@rts-flowmailer.siemens.com)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 202302031051445cd2a55841043f0538
        for <cip-dev@lists.cip-project.org>;
        Fri, 03 Feb 2023 11:51:44 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=P2sb40VNokf1mozfh8w/LxTUiQlyahu/4yjrYGzlPPE=;
 b=FppqzJMBHeauO0es18/zE2F579MYuoYsbiNjtwCT88wbz4i6UDxB41BaGUXQAEHH8hyOCh
 Bv0C+rqKxCBS4U0NQ+i+pXaYA+2uGoyWfhf5QVmN5Am65ZB0zf2nTP/uOLygEMxvXmCt9xE4
 2Dus/yjWwJ3Sj/EK20Idf9d+mU1+k=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: jan.kiszka@siemens.com,
	felix.moessbauer@siemens.com,
	cip-dev@lists.cip-project.org
Subject: [cip-dev][isar-cip-core][PATCH v3 2/2] conf/distro: Delete debian-sid.list
Date: Fri,  3 Feb 2023 11:51:42 +0100
Message-Id: <20230203105142.367778-3-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20230203105142.367778-1-Quirin.Gylstorff@siemens.com>
References: <20230203105142.367778-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 03 Feb 2023 10:51:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10584

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

As the file is not used delete.

This is done to avoid infecting other layers with the snapshot version.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 conf/distro/debian-sid.list | 2 --
 1 file changed, 2 deletions(-)
 delete mode 100644 conf/distro/debian-sid.list

diff --git a/conf/distro/debian-sid.list b/conf/distro/debian-sid.list
deleted file mode 100644
index 46d34d7..0000000
--- a/conf/distro/debian-sid.list
+++ /dev/null
@@ -1,2 +0,0 @@
-deb	[check-valid-until=no] https://snapshot.debian.org/archive/debian/20220925T001806Z sid main
-deb-src	[check-valid-until=no] https://snapshot.debian.org/archive/debian/20220925T001806Z sid main
-- 
2.39.1


