X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
 by mx.groups.io with SMTP id smtpd.web10.3089.1664599663386215878
 for <cip-dev@lists.cip-project.org>;
 Fri, 30 Sep 2022 21:47:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=felix.moessbauer@siemens.com header.s=fm1 header.b=MnQGq0Zg;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.226, mailfrom: fm-72506-2022100104473991ada33322bb76f9a8-z1vy3m@rts-flowmailer.siemens.com)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 2022100104473991ada33322bb76f9a8
        for <cip-dev@lists.cip-project.org>;
        Sat, 01 Oct 2022 06:47:40 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=felix.moessbauer@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=ijL3yqBsiPWYb8LDVt2sszdYyXtARY+5yk2/YbntGDI=;
 b=MnQGq0Zgr7iJbSEYnUnvMlY928bSegtpEaqu/qR2C9t0t3jwqNkdb1hPIqZdN/I+/SoWC9
 OroLx0YfD/Uo/YkCOR/W/rrYButCvOJnAIVPr/KaopJ22dFjrungBahRxcX/bffOWEi6zb7C
 EXiAl4XQP0ZXUyhbtze2RUhqkjKjY=;
From: Felix Moessbauer <felix.moessbauer@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: quirin.gylstorff@siemens.com,
	Felix Moessbauer <felix.moessbauer@siemens.com>
Subject: [isar-cip-core][PATCH 1/1] layer.conf: fix sstate cacheability issue
Date: Sat,  1 Oct 2022 06:47:12 +0200
Message-Id: <20221001044712.441683-1-felix.moessbauer@siemens.com>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-72506:519-21489:flowmailer
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

The LAYERDIR_cip-core contains an absolute path to the layer
at the current location on the fs.
This breaks sstate caching in case the layer is checked out at a
different location on the next build (which is common in CI).

By setting the vardepvalue to a fixed string, this issue is solved.

Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
---
 conf/layer.conf | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/conf/layer.conf b/conf/layer.conf
index cc0543a..891a0ca 100644
--- a/conf/layer.conf
+++ b/conf/layer.conf
@@ -21,3 +21,5 @@ BBFILE_PRIORITY_cip-core = "6"
 LAYERSERIES_COMPAT_cip-core = "next"
 
 LAYERDIR_cip-core = "${LAYERDIR}"
+LAYERDIR_cip-core[vardepvalue] = "isar-cip-core"
+
-- 
2.30.2


