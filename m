Return-Path: <yoshitake.kobayashi.x25@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75CB1C5DF66
	for <webhook@archiver.kernel.org>; Sun, 16 Aug 2026 07:48:01 +0000 (UTC)
Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.18416.1786626139318832266
 for <cip-dev@lists.cip-project.org>;
 Thu, 13 Aug 2026 06:02:20 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=gouravsingh@siemens.com header.s=fm2 header.b=hA2WgT8D;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.227, mailfrom: fm-1333022-2026081312520836ee808fdd000207fd-xteids@rts-flowmailer.siemens.com)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 2026081312520836ee808fdd000207fd
        for <cip-dev@lists.cip-project.org>;
        Thu, 13 Aug 2026 14:52:09 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=gouravsingh@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=LvkbKli23ISvXdFkSBbKFfG942bQKH2/lNZs/9370UQ=;
 b=hA2WgT8DiP8ukteaVxYPYevcC0DxZZVRnX9tYR5FaDBKKa3agkTKqcW4I6vdHKiz+ohGPu
 i2GmpIT5gpZzpY6QB0P4e5EcdEZuc4j0d1s9HISoF+WyuMR+EZg6EFI0guxzF3OiH9Rkifoe
 +sEufUZhOqMsLMqaMPkjyV3950TBtryobymSGPtP3Mfoh85uYbqlkD4MNIUI7BGfMkeUxXtV
 UMG/cTHr94CES1jFNegnyF6+psQYw7OIxkS2yYMvVoMw00fz9TiG7zMYsvl4+mAUJqDyvpZU
 L6NCfbtGUq3MnqAMHBKI26fw4uoU1QVrdxI3Fzkd4e40QBRt0wwD7PIQ==;
From: Gourav Singh <gouravsingh@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: jan.kiszka@siemens.com,
	Gourav Singh <gouravsingh@siemens.com>
Subject: [isar-cip-core][PATCH] recipes-core: ltp: add python3 and jq runtime dependencies
Date: Thu, 13 Aug 2026 18:21:57 +0530
Message-Id: <20260813125157.877874-1-gouravsingh@siemens.com>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1333022:519-21489:flowmailer
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 16 Aug 2026 07:48:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23945

Ensure ltp-full runtime includes tools needed by the bundled kirk runner
and report parsing/inspection workflow.

- python3: required to execute /opt/ltp/kirk.
- jq: required for parsing/inspection of JSON reports produced by kirk.

This avoids manual package installation on targets and makes LTP/kirk usage
reproducible.

Debian buster compatibility is preserved: buster provides Python 3.7, while
kirk requires Python >= 3.6.

Signed-off-by: Gourav Singh <gouravsingh@siemens.com>
---
 recipes-core/ltp/files/debian/control.tmpl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-core/ltp/files/debian/control.tmpl b/recipes-core/ltp/files/debian/control.tmpl
index a7d0087..039c6d0 100644
--- a/recipes-core/ltp/files/debian/control.tmpl
+++ b/recipes-core/ltp/files/debian/control.tmpl
@@ -11,7 +11,7 @@ Homepage: https://linux-test-project.github.io/

 Package: ltp-full
 Architecture: any
-Depends: ${shlibs:Depends}, ${misc:Depends}
+Depends: ${shlibs:Depends}, ${misc:Depends}, python3, jq
 Description: A collection of tools for testing the Linux kernel
  The Linux Test Project is a joint project started by SGI,
  developed and maintained by IBM, Cisco, Fujitsu, SUSE,
--
2.39.5


