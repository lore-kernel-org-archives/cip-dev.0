Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8C8EC41513
	for <webhook@archiver.kernel.org>; Tue, 28 May 2024 14:49:12 +0000 (UTC)
Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
 by mx.groups.io with SMTP id smtpd.web11.24272.1716907747565521513
 for <cip-dev@lists.cip-project.org>;
 Tue, 28 May 2024 07:49:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm2 header.b=WgRNJH4W;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.225, mailfrom: fm-51332-2024052814490455f2a7dcc39076bfe1-lj3e3f@rts-flowmailer.siemens.com)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 2024052814490455f2a7dcc39076bfe1
        for <cip-dev@lists.cip-project.org>;
        Tue, 28 May 2024 16:49:04 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=pXq7iYi0xJsenvlsb+dxZD+ktBj0fwalyB5OoKtAcvo=;
 b=WgRNJH4WWqgRpqzoF/Cq7yXS0mo/iutYYF+WRlNhDFCiSgU8fdz3maydPzQBr+muac+Dry
 +yOt3I+uoHprKBmKSA4aIkcBHPlIGQRZ+ZZLcf4XRKrtBVzzPhqGPXD6oDONwTc9xS3B5Z1t
 +/NbCCMUjkfNrkLx+bPg4De9SDc0Y=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH 0/3] Clean up security config
Date: Tue, 28 May 2024 16:42:42 +0200
Message-ID: <20240528144903.922587-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 28 May 2024 14:49:12 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15967

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Move security related recipes to the folder recipes-security.
Use systemd as the fail2ban backend.
Remove the tpm2-abrmd

Quirin Gylstorff (3):
  Move security-customizations to recipes-security
  Add fail2ban-config
  Remove tpm2-abrmd

 .../images/cip-core-image-security.bb         |  4 +---
 .../fail2ban-config/fail2ban-config.bb        | 23 +++++++++++++++++++
 .../files/systemd-defaults.conf               | 11 +++++++++
 .../security-customizations/files/postinst    |  0
 .../files/ssh-pam-remote.conf                 |  0
 .../files/ssh-remote-session-term.conf        |  0
 .../security-customizations.bb                |  0
 7 files changed, 35 insertions(+), 3 deletions(-)
 create mode 100644 recipes-security/fail2ban-config/fail2ban-config.bb
 create mode 100644 recipes-security/fail2ban-config/files/systemd-defaults.conf
 rename {recipes-core => recipes-security}/security-customizations/files/postinst (100%)
 rename {recipes-core => recipes-security}/security-customizations/files/ssh-pam-remote.conf (100%)
 rename {recipes-core => recipes-security}/security-customizations/files/ssh-remote-session-term.conf (100%)
 rename {recipes-core => recipes-security}/security-customizations/security-customizations.bb (100%)

-- 
2.43.0


