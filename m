Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.9607.1793361359128903374
 for <cip-dev@lists.cip-project.org>;
 Fri, 30 Oct 2026 04:55:59 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=alexander.heinisch@siemens.com header.s=fm2 header.b=ktJGdqbF;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.225, mailfrom: fm-1330684-20261030115555b8dd88829b000207be-acj7ss@rts-flowmailer.siemens.com)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 20261030115555b8dd88829b000207be
        for <cip-dev@lists.cip-project.org>;
        Fri, 30 Oct 2026 12:55:56 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=alexander.heinisch@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=a60w8F4s1NCanoPEXcpI8wJZiuKoPVLh0Qbm57UKFYE=;
 b=ktJGdqbFISpu2GPPG4SCet0EcR4CH/k54xSuzQQIsrPNLZTTfp4KYJjT2hsBqVzvaZyvgX
 V+f7ww55317zyM78kEJVjwduEgLMnynt31D2Uq8VcI9I03oe4khmG0bRm+To3kpcD3uYVnAo
 2sHiqRoRErOOssVcpkXJwloLU2vZniZq5QgDtILrevJJispP4OTKuzoIJWN7zi7xnAnJwvkd
 YFTl1LrqLieuAnHW1Qv/CMMc3PzUZEjwhrfnZMU0ARpW1y1FHcqg5F4q4hTTQFe8clEjoJTt
 cnC7Jh4yr10xCc6ev8rg6CPai86t0S4yVEmK8qP7VfMk/ziU84WQnuoQ==;
From: alexander.heinisch@siemens.com
To: cip-dev@lists.cip-project.org
Cc: jan.kiszka@siemens.com,
	Alexander Heinisch <alexander.heinisch@siemens.com>
Subject: [isar-cip-core][PATCH v2 3/4] README.signing: Fixing typos.
Date: Fri, 30 Oct 2026 12:55:42 +0100
Message-ID: <20261030115543.111644-4-alexander.heinisch@siemens.com>
In-Reply-To: <20261030115543.111644-1-alexander.heinisch@siemens.com>
References: <20261030115543.111644-1-alexander.heinisch@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1330684:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Fri, 30 Oct 2026 11:56:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24590
Content-Type: text/plain; charset="utf-8"

From: Alexander Heinisch <alexander.heinisch@siemens.com>

Signed-off-by: Alexander Heinisch <alexander.heinisch@siemens.com>
---
 doc/README.signing.md | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/README.signing.md b/doc/README.signing.md
index 327d9815..f9d14efb 100644
--- a/doc/README.signing.md
+++ b/doc/README.signing.md
@@ -17,7 +17,7 @@ testing.
 
 A swu contains the signature of the `sw-description` file with the name `sw-description.sig`.
 This `sw-description.sig` file is created during the swu image build process by calling
-a script call `/usr/bin/sign-swu`. The script is called by class classes/swupdate.bbclass.
+a script called `/usr/bin/sign-swu`. The script is called by class `classes-recipe/swupdate.bbclass`.
 The script has the following call signature:
 
 `sign-swu <unsigned file name> <signature file name>`
-- 
2.47.3

