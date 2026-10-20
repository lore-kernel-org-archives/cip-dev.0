Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.6206.1792499394171328212
 for <cip-dev@lists.cip-project.org>;
 Tue, 20 Oct 2026 05:29:54 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=alexander.heinisch@siemens.com header.s=fm2 header.b=cOc+AgXa;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.227, mailfrom: fm-1330684-20261020122952b229b38948000207fb-r9mvgh@rts-flowmailer.siemens.com)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20261020122952b229b38948000207fb
        for <cip-dev@lists.cip-project.org>;
        Tue, 20 Oct 2026 14:29:52 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=alexander.heinisch@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=6mYZW7Hp72eGbMBKlh2gbKgjsCBhRms+D35Twg9yBK0=;
 b=cOc+AgXaLVAQtLj9tP+82GlRyoFIdnj4Y+twLaUN2ozT5t1BZRBEdAZZ+cEfqTPOm5Wz7H
 8WmBXIBE5FGP7Cs86f5pawx39xQehfH/oxTBxyw+0UKnRu0bxe0JWYgZBQ7m1WZAA88xmwja
 fTo8k2Z/+5CLVz2FiII3mgKS+xET/nPLo8DiTIKmW7f5p7Z/ubAUqpB0R4oWlTca5V38T4XS
 vMGSWe1wKUozcyPHJwef6E3QThenexRgpepNsv7KAnHCT3DOar/d0t6tIpLkr2aFBlalqj/d
 18/W8KYB+8Uf+YPILt151fZshj55Kn0tkzsZn/oMvIJ+rsRurIadtqqQ==;
From: alexander.heinisch@siemens.com
To: cip-dev@lists.cip-project.org
Cc: jan.kiszka@siemens.com,
	Alexander Heinisch <alexander.heinisch@siemens.com>
Subject: [isar-cip-core][PATCH 2/2] docs: Removed obsolete IMAGE_INSTALL from README.swupdate.md
Date: Tue, 20 Oct 2026 14:29:32 +0200
Message-ID: <20261020122932.470811-3-alexander.heinisch@siemens.com>
In-Reply-To: <20261020122932.470811-1-alexander.heinisch@siemens.com>
References: <20261020122932.470811-1-alexander.heinisch@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1330684:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Tue, 20 Oct 2026 12:29:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24500
Content-Type: text/plain; charset="utf-8"

From: Alexander Heinisch <alexander.heinisch@siemens.com>

The removed line is already included in recipes-core/images/swupdate.inc

Signed-off-by: Alexander Heinisch <alexander.heinisch@siemens.com>
---
 doc/README.swupdate.md | 1 -
 1 file changed, 1 deletion(-)

diff --git a/doc/README.swupdate.md b/doc/README.swupdate.md
index a335eb65..c1428a7a 100644
--- a/doc/README.swupdate.md
+++ b/doc/README.swupdate.md
@@ -142,7 +142,6 @@ PREFERRED_PROVIDER_swupdate-certificates-key = "swupdate-certificates-key"
 PREFERRED_PROVIDER_swupdate-certificates = "swupdate-certificates"
 PREFERRED_PROVIDER_swupdate-signer = "swupdate-signer-cms"
 SWU_SIGN_KEY  = "<siging key file name>"
-IMAGE_INSTALL += "${@'swupdate-certificates' if bb.utils.to_boolean(d.getVar('SWU_SIGNED')) else ''}"
 ```
 
 The files `<sigining certificate file name>` and `<siging key file name>` need to be stored
-- 
2.47.3

