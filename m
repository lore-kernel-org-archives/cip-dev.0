Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FFDDC25B48
	for <webhook@archiver.kernel.org>; Mon, 23 Oct 2023 15:02:52 +0000 (UTC)
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
 by mx.groups.io with SMTP id smtpd.web10.122854.1698073368604972890
 for <cip-dev@lists.cip-project.org>;
 Mon, 23 Oct 2023 08:02:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=ATs596H3;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.225, mailfrom: fm-51332-2023102315024528695dc0144e55b95b-j7say5@rts-flowmailer.siemens.com)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 2023102315024528695dc0144e55b95b
        for <cip-dev@lists.cip-project.org>;
        Mon, 23 Oct 2023 17:02:45 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=g1dM/cmFh5xyMw5lmme0VLhN/nPPiwxSVXh33Nq+UIM=;
 b=ATs596H3JNkVhE+hpEBcr8/Mh/dhs13Xb46jMpEUXPk8W3FR7br5K2252oJ+mvQwo2j0h3
 vl6p4vu/gQ+VPXMgVykgvxHOpQmVfX6CpJ7yTGwGh89OaG4DlKLV8D8InyOhN+o2WmmcCIsP
 dlngyZlNzGdowBr89P9HnZM2jW6rA=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org,
	venkata.pyla@toshiba-tsip.com,
	dinesh.kumar@toshiba-tsip.com,
	kazuhiro3.hayashi@toshiba.co.jp
Subject: [cip-dev][isar-cip-core][RFC 0/9] cleanup of customizations
Date: Mon, 23 Oct 2023 16:59:58 +0200
Message-ID: <20231023150243.3990309-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 23 Oct 2023 15:02:52 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13436

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

cleanup the customizations scripts by:
  - Move the ssh configuration from postinst to /etc/ssh/sshd_config.d
  - Move systemd service overrides to files instead of setting it in
    postinst
  - fix formatting
  - fix scripting error in security customizations

Quirin Gylstorff (9):
  scripts/deploy-kernelci: Format python code and remove unused import
  customizations: Add variable to set the HOSTNAME
  customizations: Move ssh configuration from postinst to sshd_config.d
  security-customizations: Add dependency to customizations
  security-customizations: Fix shell error
  security-customizations: Extract sshd config from postinst to files
  cip-core-image-security: Move packages to security-customization
  customization-kernelci: Add dependency to customizations
  kas/opt/reproducible.yml: Move SOURCE_DATE_EPOCH to layer.conf

 conf/layer.conf                               |  2 ++
 kas/opt/reproducible.yml                      |  1 -
 kas/opt/security.yml                          |  2 ++
 recipes-core/customizations/common.inc        |  6 +++-
 recipes-core/customizations/customizations.bb | 10 ++++++
 .../files/{postinst => postinst.tmpl}         |  8 ++---
 .../customizations/files/ssh-permit-root.conf |  1 +
 .../images/cip-core-image-security.bb         | 12 +------
 .../kernelci-customizations/files/postinst    | 11 -------
 .../files/serial-getty-kernelci-override.conf |  3 ++
 .../files/ssh-permit-empty-passwords.conf     |  2 ++
 .../kernelci-customizations.bb                | 18 ++++++++---
 .../security-customizations/files/postinst    | 24 ++------------
 .../files/ssh-pam-remote.conf                 |  4 +++
 .../files/ssh-remote-session-term.conf        |  5 +++
 .../security-customizations.bb                | 25 ++++++++++++---
 scripts/deploy-kernelci.py                    | 31 ++++++++++---------
 17 files changed, 89 insertions(+), 76 deletions(-)
 rename recipes-core/customizations/files/{postinst => postinst.tmpl} (62%)
 create mode 100644 recipes-core/customizations/files/ssh-permit-root.conf
 create mode 100644 recipes-core/kernelci-customizations/files/serial-getty-kernelci-override.conf
 create mode 100644 recipes-core/kernelci-customizations/files/ssh-permit-empty-passwords.conf
 create mode 100644 recipes-core/security-customizations/files/ssh-pam-remote.conf
 create mode 100644 recipes-core/security-customizations/files/ssh-remote-session-term.conf

-- 
2.42.0


