Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAA3FC0218C
	for <webhook@archiver.kernel.org>; Fri, 24 Jan 2025 08:07:10 +0000 (UTC)
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by mx.groups.io with SMTP id smtpd.web10.6953.1737706022430105957
 for <cip-dev@lists.cip-project.org>;
 Fri, 24 Jan 2025 00:07:03 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm2 header.b=GRLS2T30;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.227, mailfrom: fm-51332-20250124080659e9d31452d60e2de3c4-qzglk8@rts-flowmailer.siemens.com)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20250124080659e9d31452d60e2de3c4
        for <cip-dev@lists.cip-project.org>;
        Fri, 24 Jan 2025 09:07:00 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=wKC7B7qDVKZ8RmZEkdbYUTqEUFDRGk1St3+KEs2Icxk=;
 b=GRLS2T30XdD0Re6uK3yNe89VLuY7nkKciCR0TS29fAiWd1mUvSDl5tUsclaoUIbCybkBkY
 MGLMCw+BLMgTiMkUkuV8gXvNHJi9PP1+nwpsvDHszha7EMEulf0jWxlkQwP2nZeMcp16y5C6
 hI8Eqgb9kiWsa8sx/ZPiu5PGYKMxjs8q0/M62W5CHFXObvJP/CYtNIAajmUHuJjPsglww71m
 v5STOsFNeUtanQsQkvpuu5IkIdAZ5lXJUDt8n9SqONwb7eBC5bUkm4IOe7+zlRh/XvPMJ8bE
 yO6GxCKxRByc24NxllyMiyfz/tr0V87YjRwPPw8tV+VLznYIQHpbMjSQ==;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: Sai.Sathujoda@toshiba-tsip.com,
	jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org
Subject: [cip-dev][isar-cip-core][PATCH 0/3] Security testing with MTDA
Date: Fri, 24 Jan 2025 09:06:24 +0100
Message-ID: <20250124080659.469424-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 24 Jan 2025 08:07:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17617

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This patch set builds an image to test IEC on the mcom device with
secure-boot and disk encryption enable.

Quirin Gylstorff (3):
  build x86-uefi with secure boot
  x86-uefi: disable watchdog for testing on mcom
  customizations-security: add curl to download LAVA overlay

 .gitlab-ci.yml                                    | 12 ++++++++++++
 kas/opt/disable-watchdog.yml                      | 15 +++++++++++++++
 .../security-customizations.bb                    |  2 +-
 3 files changed, 28 insertions(+), 1 deletion(-)
 create mode 100644 kas/opt/disable-watchdog.yml

-- 
2.47.0


