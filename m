X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
 by mx.groups.io with SMTP id smtpd.web08.18280.1665569270037460042
 for <cip-dev@lists.cip-project.org>;
 Wed, 12 Oct 2022 03:07:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=felix.moessbauer@siemens.com header.s=fm1 header.b=qaGoMImi;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.226, mailfrom: fm-72506-20221012100747dae08a649a8a181328-fezpyq@rts-flowmailer.siemens.com)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20221012100747dae08a649a8a181328
        for <cip-dev@lists.cip-project.org>;
        Wed, 12 Oct 2022 12:07:47 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=felix.moessbauer@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=rq//Y0q9n2ZrOo7o9/hHzQf6QjtlBull1c6HZxKExQ0=;
 b=qaGoMImiCn76ShOPQfO5DKDavc3lAYI3kWkTV0O6bIftPmidNVH5f9837xPISW64HzBPkK
 euSqo7anNl324tTUejXsD1jgVS/KOHtATcAQ36oI1jmafXxfxV2+5QGsS7POHe1gs1TZkf9o
 viCaWJR5gYupV5SisoiIWvqSyXUK8=;
From: Felix Moessbauer <felix.moessbauer@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: jan.kiszka@siemens.com,
	quirin.gylstorff@siemens.com,
	pluto.svc.chengdu.cn@siemens.com,
	Felix Moessbauer <felix.moessbauer@siemens.com>
Subject: [isar-cip-core][PATCH 1/3] fix: add missing class dependencies in image_uuid
Date: Wed, 12 Oct 2022 12:06:39 +0200
Message-Id: <20221012100641.2986740-2-felix.moessbauer@siemens.com>
In-Reply-To: <20221012100641.2986740-1-felix.moessbauer@siemens.com>
References: <20221012100641.2986740-1-felix.moessbauer@siemens.com>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-72506:519-21489:flowmailer
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

The image_uuid class references tasks and variables from image and
rootfs. By that, the class has to inherit the other classes to ensure
that the components are available, independent of the overall include /
parse order.

Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
---
 classes/image_uuid.bbclass | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/classes/image_uuid.bbclass b/classes/image_uuid.bbclass
index 71cc3ad..277941b 100644
--- a/classes/image_uuid.bbclass
+++ b/classes/image_uuid.bbclass
@@ -10,6 +10,9 @@
 # SPDX-License-Identifier: MIT
 #
 
+inherit rootfs
+inherit image
+
 def generate_image_uuid(d):
     import uuid
 
-- 
2.30.2


