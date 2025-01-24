Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44644C02181
	for <webhook@archiver.kernel.org>; Fri, 24 Jan 2025 13:22:53 +0000 (UTC)
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by mx.groups.io with SMTP id smtpd.web11.11678.1737724970363913637
 for <cip-dev@lists.cip-project.org>;
 Fri, 24 Jan 2025 05:22:51 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm2 header.b=ce5JHKDZ;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.227, mailfrom: fm-51332-202501241322489520572730c19214bf-netaph@rts-flowmailer.siemens.com)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 202501241322489520572730c19214bf
        for <cip-dev@lists.cip-project.org>;
        Fri, 24 Jan 2025 14:22:48 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=hVg+W+mNL6/nBnedKkg4uiAPGnBQ/mlwnpxjlj2+KEg=;
 b=ce5JHKDZUTXqiFogJHEnLf7pplDcAiAu33DRpiq569gVlyCN9wrddG12Th2/9Vkf5bFHIQ
 On+DFCul8dS+fEbeZfEBmBJg65TBbvkDDH8LEZajxVgaDPWCdVi3LbuW4C1FXF0iWbV2GRw9
 JN9S/06AKUngV3iFkZdxrLnZmVIzB6OtztZ/JTlVvPBPAVHymI+YKtJjDg5bcAmGKj9991uj
 V3z1i0k5WKIwlaahjBcHnfEdSv9Dp5Qp/ewqhne2ZSvWXOL2ku6zQsJ9zNyLcekdNwNVh332
 9uf00q8Ke2ddbG5rvu4FXsyPl1BGjd6uNcU3iGZlVDyK2qd2oPBccthA==;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: Sai.Sathujoda@toshiba-tsip.com,
	jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org
Subject: [cip-dev][isar-cip-core][PATCH v2 3/3] customizations-security: add curl to download LAVA overlay
Date: Fri, 24 Jan 2025 14:22:21 +0100
Message-ID: <20250124132246.64738-4-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20250124132246.64738-1-Quirin.Gylstorff@siemens.com>
References: <20250124132246.64738-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 24 Jan 2025 13:22:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17658

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Lava generates an directory, in LAVA called overlay, which contains
all scripts and tests of the test stage. The Device-under-test
needs to be instrumented with with this overlay.  LAVA provides the
possibility to download the overlay via http or NFS. We use curl
to download to the overlay from a http server.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 .gitlab-ci.yml   | 3 ++-
 kas/opt/test.yml | 3 +++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 686ce48..d63ef2e 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -65,6 +65,7 @@ default:
     - if [ "${release}" = "trixie" ]; then base_yaml="${base_yaml}:kas/opt/trixie.yml"; fi
     - if [ "${encrypt}" = "enable" ]; then base_yaml="${base_yaml}:kas/opt/encrypt-data.yml"; fi
     - if [ "${watchdog}" = "disable" ]; then base_yaml="${base_yaml}:kas/opt/disable-watchdog.yml"; fi
+    - if [ "${test}" = "enable" ]; then base_yaml="${base_yaml}:kas/opt/test.yml"; fi
     - if [ "${swupdate_version}" = "2022.12" ]; then base_yaml="${base_yaml}:kas/opt/swupdate-2022.12.yaml"; fi
     - echo "Building ${base_yaml}"
     - kas build ${base_yaml}
@@ -250,8 +251,8 @@ build:x86-uefi-secure-boot:
     extension: security
     use_rt: disable
     targz: disable
-    encrypt: disable
     watchdog: disable
+    test: enable
 
 build:qemu-amd64-swupdate:
   extends:
diff --git a/kas/opt/test.yml b/kas/opt/test.yml
index 4a60ad4..b23f437 100644
--- a/kas/opt/test.yml
+++ b/kas/opt/test.yml
@@ -17,3 +17,6 @@ local_conf_header:
     IMAGE_PREINSTALL += "rt-tests stress-ng"
     DESCRIPTION:append = " with test packages"
     IMAGE_FULLNAME:append = "-test"
+  lava-testing-add-curl: |
+    IMAGE_PREINSTALL += "curl"
+
-- 
2.47.0


