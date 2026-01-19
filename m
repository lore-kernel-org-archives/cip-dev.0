Return-Path: <srinuvasan.a@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E147CA5FEF
	for <webhook@archiver.kernel.org>; Mon, 19 Jan 2026 06:18:48 +0000 (UTC)
Received: from mta-65-228.siemens.flowmailer.net (mta-65-228.siemens.flowmailer.net [185.136.65.228])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.30367.1768803518176914784
 for <cip-dev@lists.cip-project.org>;
 Sun, 18 Jan 2026 22:18:38 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=srinuvasan.a@siemens.com header.s=fm1 header.b=Fb1yDyfZ;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.228, mailfrom: fm-1324425-20260119061836445083b2610002079c-kqeaxe@rts-flowmailer.siemens.com)
Received: by mta-65-228.siemens.flowmailer.net with ESMTPSA id 20260119061836445083b2610002079c
        for <cip-dev@lists.cip-project.org>;
        Mon, 19 Jan 2026 07:18:36 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=srinuvasan.a@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=sTg9DXp/bnp9+cZGtTVGtiGzJqw4kRFsLyv1zG8/52M=;
 b=Fb1yDyfZu/N+Heg82V11+tvZFHS6thMz4EaLyQL69ekv5HTVsKXd1KznEUoSTp35har9Z+
 28utrdu8HD6/h+t5t6DHwcsPDhFJvmxuEDuSbBD0/8n2VOiCdW8RYsOTuzOSRc+jM1n95Dpd
 9IIa2GEHKoXh8uJUeq8wRiHPrQITwhwHvCl0uVxaduAfBzv52cqJn1xVCjuOCT0HqxzjONYe
 8tEv+7CHfQ+sjRpGJq+6uM9L45DlgfNihJL8/b0Awpv2mfw9kJl2TRvcQyZJ/GQK79SsFtGN
 lidZFrVxkCr4IWL5+wIICywGw2CFakTHk4bt/jNkThD3RpvUvwyi71ew==;
From: srinuvasan.a@siemens.com
To: cip-dev@lists.cip-project.org
Cc: jan.kiszka@siemens.com,
	felix.moessbauer@siemens.com,
	srinuvasan <srinuvasan.a@siemens.com>
Subject: [isar-cip-core][PATCH 2/2] recipes-core/swupdate: generate reproducible source tarballs
Date: Mon, 19 Jan 2026 11:48:51 +0530
Message-Id: <20260119061851.120592-2-srinuvasan.a@siemens.com>
In-Reply-To: <20260119061851.120592-1-srinuvasan.a@siemens.com>
References: <20260119061851.120592-1-srinuvasan.a@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1324425:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 19 Jan 2026 06:18:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21644

From: srinuvasan <srinuvasan.a@siemens.com>

Apply additional options to the tar command used to generate
reproducible source tarballs: (1) use numeric and null [GU]IDs,
-clamp-mtime for file modification times to never be later than
SOURCE_DATE_EPOCH (preserving mtimes for files not modified by
the recipe) and --sort=name for consistent ordering within the
archive.

Ref: https://github.com/ilbers/isar/commit/f19a4f955111a409b00da98285b9baca8112dd46

Signed-off-by: srinuvasan <srinuvasan.a@siemens.com>
---
 recipes-core/swupdate/swupdate_2022.12+dsfg-4-cip.bb | 2 +-
 recipes-core/swupdate/swupdate_2023.12.bb            | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/recipes-core/swupdate/swupdate_2022.12+dsfg-4-cip.bb b/recipes-core/swupdate/swupdate_2022.12+dsfg-4-cip.bb
index fcccc2c..3a73c89 100644
--- a/recipes-core/swupdate/swupdate_2022.12+dsfg-4-cip.bb
+++ b/recipes-core/swupdate/swupdate_2022.12+dsfg-4-cip.bb
@@ -37,5 +37,5 @@ CHANGELOG_V ?= "${PV}-${SRCREV}"
 do_prepare_build() {
     deb_add_changelog
     cd ${WORKDIR}
-    tar cJf ${PN}_${PV}.orig.tar.xz --exclude=.git --exclude=debian ${P}
+    tar cJf ${PN}_${PV}.orig.tar.xz ${TAR_REPRO_OPTS} ${P}
 }
diff --git a/recipes-core/swupdate/swupdate_2023.12.bb b/recipes-core/swupdate/swupdate_2023.12.bb
index cc01a98..6822153 100644
--- a/recipes-core/swupdate/swupdate_2023.12.bb
+++ b/recipes-core/swupdate/swupdate_2023.12.bb
@@ -50,5 +50,5 @@ CHANGELOG_V ?= "${PV}+cip-${SRCREV}"
 do_prepare_build() {
     deb_add_changelog
     cd ${WORKDIR}
-    tar cJf ${PN}_${PV}+cip.orig.tar.xz --exclude=.git --exclude=debian ${P}
+    tar cJf ${PN}_${PV}+cip.orig.tar.xz ${TAR_REPRO_OPTS} ${P}
 }
-- 
2.39.5


