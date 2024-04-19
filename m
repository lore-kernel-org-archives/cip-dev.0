Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60626C4345F
	for <webhook@archiver.kernel.org>; Fri, 19 Apr 2024 12:24:52 +0000 (UTC)
Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
 by mx.groups.io with SMTP id smtpd.web10.12311.1713498616834829039
 for <cip-dev@lists.cip-project.org>;
 Thu, 18 Apr 2024 20:50:18 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=kumar.rakesh@siemens.com header.s=fm1 header.b=fqEryyGa;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.227, mailfrom: fm-1325885-202404190350132e073891dd6cf7dfa9-mqxmc1@rts-flowmailer.siemens.com)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 202404190350132e073891dd6cf7dfa9
        for <cip-dev@lists.cip-project.org>;
        Fri, 19 Apr 2024 05:50:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=kumar.rakesh@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=ttcqKVyJEEqrv8QG27VZtfSDv6+suyStZXGjzvGsS/g=;
 b=fqEryyGaIlHMIPR36f0s4FjM3RfMOQRAbXZjp1nmYn9t5JFkdZwDS+/hjVhnKCis57ZBZs
 CrPJAe8No/R8pj2qu+gqcG2x07X5/6qXfdgCM+thZvNvErN+xvowdQfUWvWd1fHqAIa0V3/9
 mHTkVb7MjSRZyxfIwPlESpL/Qsyqs=;
From: Rakesh Kumar <kumar.rakesh@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: Rakesh Kumar <kumar.rakesh@siemens.com>
Subject: [isar-cip-core][PATCH v2 0/1] recipes-devtools/secure-boot-secrets: Resolve duplicate Provides in debian/control
Date: Fri, 19 Apr 2024 09:20:00 +0530
Message-Id: <20240419035001.594631-1-kumar.rakesh@siemens.com>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1325885:519-21489:flowmailer
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 19 Apr 2024 12:24:52 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15697

Previously, the debian/control file contained a duplicate Provides line,
    which caused a build failure ad below
    | DEBUG: Executing shell function do_dpkg_source
    | dpkg-source: error: syntax error in secure-boot-custmpk-0.1/debian/control at line 16:
    | duplicate field Provides found

Use DEBIAN_PROVIDES to resolve the duplicate Provides problem to ensure
that the build process completes successfully.

Rakesh Kumar (1):
  recipes-devtools/secure-boot-secrets: Resolve duplicate Provides in
    debian/control

 recipes-devtools/secure-boot-secrets/secure-boot-secrets.inc | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

-- 
2.39.2


