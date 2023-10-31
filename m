Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F23CFC4708E
	for <webhook@archiver.kernel.org>; Tue, 31 Oct 2023 08:49:49 +0000 (UTC)
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
 by mx.groups.io with SMTP id smtpd.web11.182061.1698742187197332228
 for <cip-dev@lists.cip-project.org>;
 Tue, 31 Oct 2023 01:49:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=UKmqPSU6;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.225, mailfrom: fm-51332-20231031084943398c9796b06d91c7c3-tlcyyl@rts-flowmailer.siemens.com)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 20231031084943398c9796b06d91c7c3
        for <cip-dev@lists.cip-project.org>;
        Tue, 31 Oct 2023 09:49:44 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=APSt23FRGwnFIZdlrumLoOgb0Jhzlabqgmkie+4ZUzs=;
 b=UKmqPSU6nA+0HnkJsF1qSQcbWddQYNQBEwotxBlk3FrdWOV969lNgybYoNn4EbwK+KLsmN
 5Lv6dBZHqcXo2pmgg5BsB4WhsAaww+FPO786Fo72tb50Ybp0jVELBdDOepcBM+3IcrH8nmS/
 3f0rDVandQJCTVz5ezJtGTw6YyX3g=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org,
	venkata.pyla@toshiba-tsip.com,
	dinesh.kumar@toshiba-tsip.com,
	kazuhiro3.hayashi@toshiba.co.jp
Subject: [cip-dev][isar-cip-core][RFC v2 0/9] cleanup of customizations
Date: Tue, 31 Oct 2023 09:37:34 +0100
Message-ID: <20231031084943.3105056-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 31 Oct 2023 08:49:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13501

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

cleanup the customizations scripts by:
  - Move the ssh configuration from postinst to /etc/ssh/sshd_config.d
  - Move systemd service overrides to files instead of setting it in
    postinst
  - fix formatting
  - fix scripting error in security customizations

Changes v2:
  - Remove explicit installation of libtss2-esys* as it is required by
    tpm2-tools.
  - Add note about used style checker

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
 .../security-customizations.bb                | 22 ++++++++++---
 scripts/deploy-kernelci.py                    | 31 ++++++++++---------
 17 files changed, 86 insertions(+), 76 deletions(-)
 rename recipes-core/customizations/files/{postinst => postinst.tmpl} (62%)
 create mode 100644 recipes-core/customizations/files/ssh-permit-root.conf
 create mode 100644 recipes-core/kernelci-customizations/files/serial-getty-kernelci-override.conf
 create mode 100644 recipes-core/kernelci-customizations/files/ssh-permit-empty-passwords.conf
 create mode 100644 recipes-core/security-customizations/files/ssh-pam-remote.conf
 create mode 100644 recipes-core/security-customizations/files/ssh-remote-session-term.conf

-- 
2.42.0


