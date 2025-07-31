Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F6A9C87FCC
	for <webhook@archiver.kernel.org>; Thu, 31 Jul 2025 12:00:50 +0000 (UTC)
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
 by mx.groups.io with SMTP id smtpd.web10.60289.1753963247833296112
 for <cip-dev@lists.cip-project.org>;
 Thu, 31 Jul 2025 05:00:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm2 header.b=gKPtEl8q;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.228, mailfrom: fm-51332-2025073112004402881ecff5a92aa8c4-0fr5jo@rts-flowmailer.siemens.com)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 2025073112004402881ecff5a92aa8c4
        for <cip-dev@lists.cip-project.org>;
        Thu, 31 Jul 2025 14:00:45 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=b0soEY60UROFVSi146zqVI6o1XEqtxyAix1bOzbrrTQ=;
 b=gKPtEl8qk+bTHpif7pTqwixyy0wvOdDan/lDvtfY10Lt9swTo0z5fZu23X8QASBQD1CqBN
 DEhBLHdUuJb4xDrG45ymUgP9Lmnz1ZdA6m7foBqXHqF1ZmZYEbonyLd5FKDpxXjn7FxUJGKm
 aneCVIscJKKZFQj621ZyA9se+IBBeGnHkzXHsy85vV/QqIwhUAkYpGjk6fShHEQF8FUk9TpZ
 sezrjNneS6Q9RFw+ZmVjjK7DFFsIj8s2CbmFocX2Ij3KQX1CM64n5SAds7onht9l+VeNyJbT
 Fg8gge6UsK5AITnSBCm/2L9FTkyGYlK298sJZNBNJ3I8l+4l+P6fxkUw==;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com,
	gokhan.cetin@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH v3 5/7] cip-core-image: add factory-reset helper
Date: Thu, 31 Jul 2025 13:58:44 +0200
Message-ID: <20250731120043.333345-6-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20250731120043.333345-1-Quirin.Gylstorff@siemens.com>
References: <20250731120043.333345-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 31 Jul 2025 12:00:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19640

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 recipes-core/images/cip-core-image.bb                           | 2 +-
 .../factory-reset-helper/files/set-factory-reset-efivar.sh.tmpl | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/recipes-core/images/cip-core-image.bb b/recipes-core/images/cip-core-image.bb
index 4a9cea9..fb3b185 100644
--- a/recipes-core/images/cip-core-image.bb
+++ b/recipes-core/images/cip-core-image.bb
@@ -14,6 +14,6 @@ require cip-core-image.inc
 DESCRIPTION = "CIP Core image"
 
 IMAGE_INSTALL += "customizations"
-
+IMAGE_INSTALL += "factory-reset-helper"
 CIP_IMAGE_OPTIONS ?= ""
 require ${CIP_IMAGE_OPTIONS}
diff --git a/recipes-support/factory-reset-helper/files/set-factory-reset-efivar.sh.tmpl b/recipes-support/factory-reset-helper/files/set-factory-reset-efivar.sh.tmpl
index f5a2273..3f8699b 100644
--- a/recipes-support/factory-reset-helper/files/set-factory-reset-efivar.sh.tmpl
+++ b/recipes-support/factory-reset-helper/files/set-factory-reset-efivar.sh.tmpl
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/bin/bash
 #
 # CIP Core, generic profile
 #
-- 
2.50.1


