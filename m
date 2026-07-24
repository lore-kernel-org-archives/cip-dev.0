Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C8E0C53219
	for <webhook@archiver.kernel.org>; Fri, 24 Jul 2026 12:40:49 +0000 (UTC)
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.18377.1784896844486526077
 for <cip-dev@lists.cip-project.org>;
 Fri, 24 Jul 2026 05:40:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=aMsC+3Rq;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.227, mailfrom: fm-51332-20260724124041aed687d7f1000207cf-6dg5z0@rts-flowmailer.siemens.com)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20260724124041aed687d7f1000207cf
        for <cip-dev@lists.cip-project.org>;
        Fri, 24 Jul 2026 14:40:41 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=WVpZkzuakeipZkzqTCJOy2JgndUmi19iFyVn8v4h2RI=;
 b=aMsC+3Rqai575FhBsF69cR9Avjezq/7caQU53vDItfN00PoaunK11aPEKXNvDw/GrQjdZV
 XVMh8aerANcJ4F1oEoDCZDDMauJXUIqdpR7HTaiv1CXuCO1CbLeMCme1fE408zrQzKnioSeU
 W8PYv5nRAe+GR6y+mZ5o33djOC31B6gBVAlDwyDXbV4avBDmqsPteNtZIzdAfZoVJS1VOpXg
 hTnjRUJPxQZ7wizzuyko++vlyzcTgCXFsNLXb1OBPZXoj+yjt4k+QI0vQkwkQ422XOZmGi5+
 b9iX45e8CI+3Y0qEz2It8LR+JYyUSRYI9z68IZTrmAsSGLFX0vuEBHHg==;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com,
	felix.moessbauer@siemens.com,
	christoph.steiger@siemens.com,
	clara.kowalsky@siemens.com
Subject: [RFC cip-dev][isar-cip-core][PATCH 03/14] Add cip-cis-rules to apply hardening configuration to the system
Date: Fri, 24 Jul 2026 14:39:05 +0200
Message-ID: <20260724124038.3633611-4-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20260724124038.3633611-1-Quirin.Gylstorff@siemens.com>
References: <20260724124038.3633611-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 24 Jul 2026 12:40:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23745

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This package uses the configuration from `cip-cis-rules-config`
to generate a Debian package containing the selected hardening
rules.

Co-Authored-by: Clara Kowalsky <clara.kowalsky@siemens.com>
Co-Authored-by: Felix Moessbauer <felix.moessbauer@siemens.com>
Co-Authored-by: Christoph Steiger <christoph.steiger@siemens.com>
Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 .../cip-cis-rules/cip-cis-rules_1.0.0.bb      |  19 +
 .../conf.d/cis-2.2.1.3-chrony-ntp-server.conf |   4 +
 .../cis-5.2.10-disable-root-login.cfg         |   2 +
 ...2.11-disable-sshd-permitemptypasswords.cfg |   2 +
 .../cis-5.2.12-disable-sshd-setenv.cfg        |   2 +
 .../cis-5.2.13-sshd-ciphers.cfg               |   2 +
 .../cis-5.2.14-ssh-cry-mac.cfg                |   2 +
 .../cis-5.2.15-ssh-cry-kex.cfg                |   2 +
 .../cis-5.2.16-sshd-idle-timeout.cfg          |   2 +
 .../cis-5.2.17-sshd-login-grace-time.cfg      |   2 +
 .../cis-5.2.18-sshd-limit-access.cfg          |   2 +
 .../cis-5.2.19-ssh-banner.cfg                 |   2 +
 .../cis-5.2.20-enable-ssh-pam.cfg             |   2 +
 ....2.21-disable-ssh-allow-tcp-forwarding.cfg |   2 +
 .../cis-5.2.22-configure-ssh-max-startups.cfg |   2 +
 .../cis-5.2.23-limit-ssh-max-sessions.cfg     |   2 +
 .../cis-5.2.4-sshd-protocol.cfg               |   2 +
 .../cis-5.2.5-sshd-loglevel.cfg               |   2 +
 .../cis-5.2.6-disable-x11-forwarding.cfg      |   2 +
 .../cis-5.2.7-sshd-maxauthtries.cfg           |   2 +
 .../cis-5.2.8-enable-sshd-ignorerhosts.cfg    |   2 +
 ...9-disable-sshd-hostbasedauthentication.cfg |   2 +
 .../cis-5.3.1-enable-pwquality.cfg            |   2 +
 .../cip-cis-rules/configuration/cis-1.1.21.sh |   6 +
 .../cip-cis-rules/configuration/cis-1.5.1.sh  |   8 +
 .../configuration/cis-1.8.1.1.sh              |   7 +
 .../configuration/cis-1.8.1.2.sh              |   7 +
 .../configuration/cis-1.8.1.3.sh              |   7 +
 .../configuration/cis-1.8.1.4.sh              |   8 +
 .../configuration/cis-1.8.1.5.sh              |   8 +
 .../configuration/cis-1.8.1.6.sh              |   8 +
 .../configuration/cis-2.2.1.2.sh              |   9 +
 .../cip-cis-rules/configuration/cis-4.2.3.sh  |   6 +
 .../cip-cis-rules/configuration/cis-4.4.sh    |   9 +
 .../cip-cis-rules/configuration/cis-5.1.2.sh  |   8 +
 .../cip-cis-rules/configuration/cis-5.1.3.sh  |   8 +
 .../cip-cis-rules/configuration/cis-5.1.4.sh  |   8 +
 .../cip-cis-rules/configuration/cis-5.1.5.sh  |   8 +
 .../cip-cis-rules/configuration/cis-5.1.6.sh  |   8 +
 .../cip-cis-rules/configuration/cis-5.1.7.sh  |   8 +
 .../cip-cis-rules/configuration/cis-5.2.1.sh  |   8 +
 .../cip-cis-rules/configuration/cis-5.2.2.sh  |   6 +
 .../cip-cis-rules/configuration/cis-5.2.3.sh  |   6 +
 .../cip-cis-rules/configuration/cis-5.3.2.sh  |  10 +
 .../cip-cis-rules/configuration/cis-5.3.3.sh  |   7 +
 .../configuration/cis-5.4.1.1.sh              |  23 ++
 .../configuration/cis-5.4.1.2.sh              |  17 +
 .../configuration/cis-5.4.1.3.sh              |  17 +
 .../cip-cis-rules/configuration/cis-5.5.sh    |  19 +
 .../cip-cis-rules/configuration/cis-5.6.sh    |   9 +
 .../debian/cip-cis-rules.postinst             |  30 ++
 .../files/cip-cis-rules/debian/control        |  31 ++
 .../files/cip-cis-rules/debian/rules          |  20 ++
 .../debian/scripts/package-enable-configs.py  | 332 ++++++++++++++++++
 .../debian/scripts/rule-packages.json         |  61 ++++
 .../cis-1.1.1.1-disable-freevxfs.conf         |   3 +
 .../modprobe.d/cis-1.1.1.2-disable-jffs2.conf |   3 +
 .../modprobe.d/cis-1.1.1.3-disable-hfs.conf   |   3 +
 .../cis-1.1.1.4-disable-hfsplus.conf          |   3 +
 .../cis-1.1.1.5-disable-squashfs.conf         |   3 +
 .../modprobe.d/cis-1.1.1.6-disable-udf.conf   |   3 +
 .../modprobe.d/cis-1.1.1.7-restrict-fat.conf  |   5 +
 .../cis-1.1.1.8-disable-cramfs.conf           |   3 +
 .../cis-1.1.23-disable-usb-storage.conf       |   3 +
 .../pam-configs/cis-5.3.2-faillock            |   6 +
 .../pam-configs/cis-5.3.2-faillock_notify     |   9 +
 .../pam-configs/cis-5.3.3-pwhistory           |   6 +
 .../pam.d/cis-5.3.4-acc-pam-sha512            |   3 +
 .../cis-1.6.4-restrict-core-dumps.conf        |   3 +
 .../cis-5.3.1-enable-pwquality.conf           |   7 +
 .../cis-5.2.10-disable-root-login.conf        |   3 +
 ....11-disable-sshd-permitemptypasswords.conf |   3 +
 .../cis-5.2.12-disable-sshd-setenv.conf       |   3 +
 .../cis-5.2.13-sshd-ciphers.conf              |   3 +
 .../sshd_config.d/cis-5.2.14-ssh-cry-mac.conf |   3 +
 .../sshd_config.d/cis-5.2.15-ssh-cry-kex.conf |   3 +
 .../cis-5.2.16-sshd-idle-timeout.conf         |   4 +
 .../cis-5.2.17-sshd-login-grace-time.conf     |   3 +
 .../cis-5.2.18-sshd-limit-access.conf         |  10 +
 .../sshd_config.d/cis-5.2.19-ssh-banner.conf  |   3 +
 .../cis-5.2.20-enable-ssh-pam.conf            |   3 +
 ...2.21-disable-ssh-allow-tcp-forwarding.conf |   3 +
 ...cis-5.2.22-configure-ssh-max-startups.conf |   3 +
 .../cis-5.2.23-limit-ssh-max-sessions.conf    |   3 +
 .../cis-5.2.4-sshd-protocol.conf              |   3 +
 .../cis-5.2.5-sshd-loglevel.conf              |   3 +
 .../cis-5.2.6-disable-x11-forwarding.conf     |   3 +
 .../cis-5.2.7-sshd-maxauthtries.conf          |   3 +
 .../cis-5.2.8-enable-sshd-ignorerhosts.conf   |   3 +
 ...-disable-sshd-hostbasedauthentication.conf |   3 +
 .../sudoers.d/cis-1.3.2-pty-sudo              |   3 +
 .../sudoers.d/cis-1.3.3-logfile-sudo          |   3 +
 ...-1.6.2-enable-randomized-vm-placement.conf |   3 +
 .../sysctl.d/cis-1.6.4-suid-dumpable.conf     |   3 +
 .../sysctl.d/cis-3.1.1-disable-ipv6.conf      |   5 +
 ...s-3.2.1-disable-send-packet-redirects.conf |   4 +
 .../cis-3.2.2-disable-ip-forwarding.conf      |   4 +
 ...s-3.3.1-disable-source-routed-packets.conf |   6 +
 .../cis-3.3.2-disable-icmp-redirect.conf      |   6 +
 ...is-3.3.3-disable-secure-icmp-redirect.conf |   4 +
 .../cis-3.3.4-log-martian-packets.conf        |   4 +
 .../cis-3.3.5-ignore-broadcast-requests.conf  |   3 +
 ...6-enable-bad-error-message-protection.conf |   3 +
 ...-3.3.7-enable-source-route-validation.conf |   4 +
 .../cis-3.3.8-enable-tcp-syn-cookies.conf     |   3 +
 ...3.9-disable-ipv6-router-advertisement.conf |   4 +
 106 files changed, 985 insertions(+)
 create mode 100644 recipes-security/cip-cis-rules/cip-cis-rules_1.0.0.bb
 create mode 100644 recipes-security/cip-cis-rules/files/cip-cis-rules/chrony/conf.d/cis-2.2.1.3-chrony-ntp-server.conf
 create mode 100644 recipes-security/cip-cis-rules/files/cip-cis-rules/conf.d-overrides/cis-5.2.10-disable-root-login.cfg
 create mode 100644 recipes-security/cip-cis-rules/files/cip-cis-rules/conf.d-overrides/cis-5.2.11-disable-sshd-permitemptypasswords.cfg
 create mode 100644 recipes-security/cip-cis-rules/files/cip-cis-rules/conf.d-overrides/cis-5.2.12-disable-sshd-setenv.cfg
 create mode 100644 recipes-security/cip-cis-rules/files/cip-cis-rules/conf.d-overrides/cis-5.2.13-sshd-ciphers.cfg
 create mode 100644 recipes-security/cip-cis-rules/files/cip-cis-rules/conf.d-overrides/cis-5.2.14-ssh-cry-mac.cfg
 create mode 100644 recipes-security/cip-cis-rules/files/cip-cis-rules/conf.d-overrides/cis-5.2.15-ssh-cry-kex.cfg
 create mode 100644 recipes-security/cip-cis-rules/files/cip-cis-rules/conf.d-overrides/cis-5.2.16-sshd-idle-timeout.cfg
 create mode 100644 recipes-security/cip-cis-rules/files/cip-cis-rules/conf.d-overrides/cis-5.2.17-sshd-login-grace-time.cfg
 create mode 100644 recipes-security/cip-cis-rules/files/cip-cis-rules/conf.d-overrides/cis-5.2.18-sshd-limit-access.cfg
 create mode 100644 recipes-security/cip-cis-rules/files/cip-cis-rules/conf.d-overrides/cis-5.2.19-ssh-banner.cfg
 create mode 100644 recipes-security/cip-cis-rules/files/cip-cis-rules/conf.d-overrides/cis-5.2.20-enable-ssh-pam.cfg
 create mode 100644 recipes-security/cip-cis-rules/files/cip-cis-rules/conf.d-overrides/cis-5.2.21-disable-ssh-allow-tcp-forwarding.cfg
 create mode 100644 recipes-security/cip-cis-rules/files/cip-cis-rules/conf.d-overrides/cis-5.2.22-configure-ssh-max-startups.cfg
 create mode 100644 recipes-security/cip-cis-rules/files/cip-cis-rules/conf.d-overrides/cis-5.2.23-limit-ssh-max-sessions.cfg
 create mode 100644 recipes-security/cip-cis-rules/files/cip-cis-rules/conf.d-overrides/cis-5.2.4-sshd-protocol.cfg
 create mode 100644 recipes-security/cip-cis-rules/files/cip-cis-rules/conf.d-overrides/cis-5.2.5-sshd-loglevel.cfg
 create mode 100644 recipes-security/cip-cis-rules/files/cip-cis-rules/conf.d-overrides/cis-5.2.6-disable-x11-forwarding.cfg
 create mode 100644 recipes-security/cip-cis-rules/files/cip-cis-rules/conf.d-overrides/cis-5.2.7-sshd-maxauthtries.cfg
 create mode 100644 recipes-security/cip-cis-rules/files/cip-cis-rules/conf.d-overrides/cis-5.2.8-enable-sshd-ignorerhosts.cfg
 create mode 100644 recipes-security/cip-cis-rules/files/cip-cis-rules/conf.d-overrides/cis-5.2.9-disable-sshd-hostbasedauthentication.cfg
 create mode 100644 recipes-security/cip-cis-rules/files/cip-cis-rules/conf.d-overrides/cis-5.3.1-enable-pwquality.cfg
 create mode 100755 recipes-security/cip-cis-rules/files/cip-cis-rules/configuration/cis-1.1.21.sh
 create mode 100755 recipes-security/cip-cis-rules/files/cip-cis-rules/configuration/cis-1.5.1.sh
 create mode 100755 recipes-security/cip-cis-rules/files/cip-cis-rules/configuration/cis-1.8.1.1.sh
 create mode 100755 recipes-security/cip-cis-rules/files/cip-cis-rules/configuration/cis-1.8.1.2.sh
 create mode 100755 recipes-security/cip-cis-rules/files/cip-cis-rules/configuration/cis-1.8.1.3.sh
 create mode 100755 recipes-security/cip-cis-rules/files/cip-cis-rules/configuration/cis-1.8.1.4.sh
 create mode 100755 recipes-security/cip-cis-rules/files/cip-cis-rules/configuration/cis-1.8.1.5.sh
 create mode 100755 recipes-security/cip-cis-rules/files/cip-cis-rules/configuration/cis-1.8.1.6.sh
 create mode 100755 recipes-security/cip-cis-rules/files/cip-cis-rules/configuration/cis-2.2.1.2.sh
 create mode 100755 recipes-security/cip-cis-rules/files/cip-cis-rules/configuration/cis-4.2.3.sh
 create mode 100644 recipes-security/cip-cis-rules/files/cip-cis-rules/configuration/cis-4.4.sh
 create mode 100755 recipes-security/cip-cis-rules/files/cip-cis-rules/configuration/cis-5.1.2.sh
 create mode 100755 recipes-security/cip-cis-rules/files/cip-cis-rules/configuration/cis-5.1.3.sh
 create mode 100755 recipes-security/cip-cis-rules/files/cip-cis-rules/configuration/cis-5.1.4.sh
 create mode 100755 recipes-security/cip-cis-rules/files/cip-cis-rules/configuration/cis-5.1.5.sh
 create mode 100755 recipes-security/cip-cis-rules/files/cip-cis-rules/configuration/cis-5.1.6.sh
 create mode 100755 recipes-security/cip-cis-rules/files/cip-cis-rules/configuration/cis-5.1.7.sh
 create mode 100755 recipes-security/cip-cis-rules/files/cip-cis-rules/configuration/cis-5.2.1.sh
 create mode 100755 recipes-security/cip-cis-rules/files/cip-cis-rules/configuration/cis-5.2.2.sh
 create mode 100755 recipes-security/cip-cis-rules/files/cip-cis-rules/configuration/cis-5.2.3.sh
 create mode 100755 recipes-security/cip-cis-rules/files/cip-cis-rules/configuration/cis-5.3.2.sh
 create mode 100755 recipes-security/cip-cis-rules/files/cip-cis-rules/configuration/cis-5.3.3.sh
 create mode 100755 recipes-security/cip-cis-rules/files/cip-cis-rules/configuration/cis-5.4.1.1.sh
 create mode 100755 recipes-security/cip-cis-rules/files/cip-cis-rules/configuration/cis-5.4.1.2.sh
 create mode 100755 recipes-security/cip-cis-rules/files/cip-cis-rules/configuration/cis-5.4.1.3.sh
 create mode 100755 recipes-security/cip-cis-rules/files/cip-cis-rules/configuration/cis-5.5.sh
 create mode 100644 recipes-security/cip-cis-rules/files/cip-cis-rules/configuration/cis-5.6.sh
 create mode 100755 recipes-security/cip-cis-rules/files/cip-cis-rules/debian/cip-cis-rules.postinst
 create mode 100644 recipes-security/cip-cis-rules/files/cip-cis-rules/debian/control
 create mode 100755 recipes-security/cip-cis-rules/files/cip-cis-rules/debian/rules
 create mode 100644 recipes-security/cip-cis-rules/files/cip-cis-rules/debian/scripts/package-enable-configs.py
 create mode 100644 recipes-security/cip-cis-rules/files/cip-cis-rules/debian/scripts/rule-packages.json
 create mode 100644 recipes-security/cip-cis-rules/files/cip-cis-rules/modprobe.d/cis-1.1.1.1-disable-freevxfs.conf
 create mode 100644 recipes-security/cip-cis-rules/files/cip-cis-rules/modprobe.d/cis-1.1.1.2-disable-jffs2.conf
 create mode 100644 recipes-security/cip-cis-rules/files/cip-cis-rules/modprobe.d/cis-1.1.1.3-disable-hfs.conf
 create mode 100644 recipes-security/cip-cis-rules/files/cip-cis-rules/modprobe.d/cis-1.1.1.4-disable-hfsplus.conf
 create mode 100644 recipes-security/cip-cis-rules/files/cip-cis-rules/modprobe.d/cis-1.1.1.5-disable-squashfs.conf
 create mode 100644 recipes-security/cip-cis-rules/files/cip-cis-rules/modprobe.d/cis-1.1.1.6-disable-udf.conf
 create mode 100644 recipes-security/cip-cis-rules/files/cip-cis-rules/modprobe.d/cis-1.1.1.7-restrict-fat.conf
 create mode 100644 recipes-security/cip-cis-rules/files/cip-cis-rules/modprobe.d/cis-1.1.1.8-disable-cramfs.conf
 create mode 100644 recipes-security/cip-cis-rules/files/cip-cis-rules/modprobe.d/cis-1.1.23-disable-usb-storage.conf
 create mode 100644 recipes-security/cip-cis-rules/files/cip-cis-rules/pam-configs/cis-5.3.2-faillock
 create mode 100644 recipes-security/cip-cis-rules/files/cip-cis-rules/pam-configs/cis-5.3.2-faillock_notify
 create mode 100644 recipes-security/cip-cis-rules/files/cip-cis-rules/pam-configs/cis-5.3.3-pwhistory
 create mode 100644 recipes-security/cip-cis-rules/files/cip-cis-rules/pam.d/cis-5.3.4-acc-pam-sha512
 create mode 100644 recipes-security/cip-cis-rules/files/cip-cis-rules/security/limits.d/cis-1.6.4-restrict-core-dumps.conf
 create mode 100644 recipes-security/cip-cis-rules/files/cip-cis-rules/security/pwquality.conf.d/cis-5.3.1-enable-pwquality.conf
 create mode 100644 recipes-security/cip-cis-rules/files/cip-cis-rules/sshd_config.d/cis-5.2.10-disable-root-login.conf
 create mode 100644 recipes-security/cip-cis-rules/files/cip-cis-rules/sshd_config.d/cis-5.2.11-disable-sshd-permitemptypasswords.conf
 create mode 100644 recipes-security/cip-cis-rules/files/cip-cis-rules/sshd_config.d/cis-5.2.12-disable-sshd-setenv.conf
 create mode 100644 recipes-security/cip-cis-rules/files/cip-cis-rules/sshd_config.d/cis-5.2.13-sshd-ciphers.conf
 create mode 100644 recipes-security/cip-cis-rules/files/cip-cis-rules/sshd_config.d/cis-5.2.14-ssh-cry-mac.conf
 create mode 100644 recipes-security/cip-cis-rules/files/cip-cis-rules/sshd_config.d/cis-5.2.15-ssh-cry-kex.conf
 create mode 100644 recipes-security/cip-cis-rules/files/cip-cis-rules/sshd_config.d/cis-5.2.16-sshd-idle-timeout.conf
 create mode 100644 recipes-security/cip-cis-rules/files/cip-cis-rules/sshd_config.d/cis-5.2.17-sshd-login-grace-time.conf
 create mode 100644 recipes-security/cip-cis-rules/files/cip-cis-rules/sshd_config.d/cis-5.2.18-sshd-limit-access.conf
 create mode 100644 recipes-security/cip-cis-rules/files/cip-cis-rules/sshd_config.d/cis-5.2.19-ssh-banner.conf
 create mode 100644 recipes-security/cip-cis-rules/files/cip-cis-rules/sshd_config.d/cis-5.2.20-enable-ssh-pam.conf
 create mode 100644 recipes-security/cip-cis-rules/files/cip-cis-rules/sshd_config.d/cis-5.2.21-disable-ssh-allow-tcp-forwarding.conf
 create mode 100644 recipes-security/cip-cis-rules/files/cip-cis-rules/sshd_config.d/cis-5.2.22-configure-ssh-max-startups.conf
 create mode 100644 recipes-security/cip-cis-rules/files/cip-cis-rules/sshd_config.d/cis-5.2.23-limit-ssh-max-sessions.conf
 create mode 100644 recipes-security/cip-cis-rules/files/cip-cis-rules/sshd_config.d/cis-5.2.4-sshd-protocol.conf
 create mode 100644 recipes-security/cip-cis-rules/files/cip-cis-rules/sshd_config.d/cis-5.2.5-sshd-loglevel.conf
 create mode 100644 recipes-security/cip-cis-rules/files/cip-cis-rules/sshd_config.d/cis-5.2.6-disable-x11-forwarding.conf
 create mode 100644 recipes-security/cip-cis-rules/files/cip-cis-rules/sshd_config.d/cis-5.2.7-sshd-maxauthtries.conf
 create mode 100644 recipes-security/cip-cis-rules/files/cip-cis-rules/sshd_config.d/cis-5.2.8-enable-sshd-ignorerhosts.conf
 create mode 100644 recipes-security/cip-cis-rules/files/cip-cis-rules/sshd_config.d/cis-5.2.9-disable-sshd-hostbasedauthentication.conf
 create mode 100644 recipes-security/cip-cis-rules/files/cip-cis-rules/sudoers.d/cis-1.3.2-pty-sudo
 create mode 100644 recipes-security/cip-cis-rules/files/cip-cis-rules/sudoers.d/cis-1.3.3-logfile-sudo
 create mode 100644 recipes-security/cip-cis-rules/files/cip-cis-rules/sysctl.d/cis-1.6.2-enable-randomized-vm-placement.conf
 create mode 100644 recipes-security/cip-cis-rules/files/cip-cis-rules/sysctl.d/cis-1.6.4-suid-dumpable.conf
 create mode 100644 recipes-security/cip-cis-rules/files/cip-cis-rules/sysctl.d/cis-3.1.1-disable-ipv6.conf
 create mode 100644 recipes-security/cip-cis-rules/files/cip-cis-rules/sysctl.d/cis-3.2.1-disable-send-packet-redirects.conf
 create mode 100644 recipes-security/cip-cis-rules/files/cip-cis-rules/sysctl.d/cis-3.2.2-disable-ip-forwarding.conf
 create mode 100644 recipes-security/cip-cis-rules/files/cip-cis-rules/sysctl.d/cis-3.3.1-disable-source-routed-packets.conf
 create mode 100644 recipes-security/cip-cis-rules/files/cip-cis-rules/sysctl.d/cis-3.3.2-disable-icmp-redirect.conf
 create mode 100644 recipes-security/cip-cis-rules/files/cip-cis-rules/sysctl.d/cis-3.3.3-disable-secure-icmp-redirect.conf
 create mode 100644 recipes-security/cip-cis-rules/files/cip-cis-rules/sysctl.d/cis-3.3.4-log-martian-packets.conf
 create mode 100644 recipes-security/cip-cis-rules/files/cip-cis-rules/sysctl.d/cis-3.3.5-ignore-broadcast-requests.conf
 create mode 100644 recipes-security/cip-cis-rules/files/cip-cis-rules/sysctl.d/cis-3.3.6-enable-bad-error-message-protection.conf
 create mode 100644 recipes-security/cip-cis-rules/files/cip-cis-rules/sysctl.d/cis-3.3.7-enable-source-route-validation.conf
 create mode 100644 recipes-security/cip-cis-rules/files/cip-cis-rules/sysctl.d/cis-3.3.8-enable-tcp-syn-cookies.conf
 create mode 100644 recipes-security/cip-cis-rules/files/cip-cis-rules/sysctl.d/cis-3.3.9-disable-ipv6-router-advertisement.conf

diff --git a/recipes-security/cip-cis-rules/cip-cis-rules_1.0.0.bb b/recipes-security/cip-cis-rules/cip-cis-rules_1.0.0.bb
new file mode 100644
index 0000000..6a1d9de
--- /dev/null
+++ b/recipes-security/cip-cis-rules/cip-cis-rules_1.0.0.bb
@@ -0,0 +1,19 @@
+DESCRIPTION = "CIS rule overrides for CIP based images"
+MAINTAINER = "Felix Moessbauer <felix.moessbauer@siemens.com>"
+
+SRC_URI = "\
+    file://${BPN} \
+"
+
+S = "${WORKDIR}/${BPN}"
+
+DPKG_ARCH = "all"
+PROVIDES = "${BPN}"
+
+DEPENDS = "cip-cis-rules-config"
+
+inherit dpkg
+
+do_prepare_build() {
+    deb_add_changelog
+}
diff --git a/recipes-security/cip-cis-rules/files/cip-cis-rules/chrony/conf.d/cis-2.2.1.3-chrony-ntp-server.conf b/recipes-security/cip-cis-rules/files/cip-cis-rules/chrony/conf.d/cis-2.2.1.3-chrony-ntp-server.conf
new file mode 100644
index 0000000..48a7e61
--- /dev/null
+++ b/recipes-security/cip-cis-rules/files/cip-cis-rules/chrony/conf.d/cis-2.2.1.3-chrony-ntp-server.conf
@@ -0,0 +1,4 @@
+# CIS 2.2.1.3 - Configure chrony NTP server
+# This file is managed by cip-cis-rules.
+# The pool address below is substituted from the value configured in .config.json.
+pool @@VALUE@@ iburst
diff --git a/recipes-security/cip-cis-rules/files/cip-cis-rules/conf.d-overrides/cis-5.2.10-disable-root-login.cfg b/recipes-security/cip-cis-rules/files/cip-cis-rules/conf.d-overrides/cis-5.2.10-disable-root-login.cfg
new file mode 100644
index 0000000..dec1dcf
--- /dev/null
+++ b/recipes-security/cip-cis-rules/files/cip-cis-rules/conf.d-overrides/cis-5.2.10-disable-root-login.cfg
@@ -0,0 +1,2 @@
+# Re-point OVH audit at the CIS dropin instead of /etc/ssh/sshd_config
+FILE='/etc/ssh/sshd_config.d/cis-5.2.10-disable-root-login.conf'
diff --git a/recipes-security/cip-cis-rules/files/cip-cis-rules/conf.d-overrides/cis-5.2.11-disable-sshd-permitemptypasswords.cfg b/recipes-security/cip-cis-rules/files/cip-cis-rules/conf.d-overrides/cis-5.2.11-disable-sshd-permitemptypasswords.cfg
new file mode 100644
index 0000000..b29d597
--- /dev/null
+++ b/recipes-security/cip-cis-rules/files/cip-cis-rules/conf.d-overrides/cis-5.2.11-disable-sshd-permitemptypasswords.cfg
@@ -0,0 +1,2 @@
+# Re-point OVH audit at the CIS dropin instead of /etc/ssh/sshd_config
+FILE='/etc/ssh/sshd_config.d/cis-5.2.11-disable-sshd-permitemptypasswords.conf'
diff --git a/recipes-security/cip-cis-rules/files/cip-cis-rules/conf.d-overrides/cis-5.2.12-disable-sshd-setenv.cfg b/recipes-security/cip-cis-rules/files/cip-cis-rules/conf.d-overrides/cis-5.2.12-disable-sshd-setenv.cfg
new file mode 100644
index 0000000..63a4219
--- /dev/null
+++ b/recipes-security/cip-cis-rules/files/cip-cis-rules/conf.d-overrides/cis-5.2.12-disable-sshd-setenv.cfg
@@ -0,0 +1,2 @@
+# Re-point OVH audit at the CIS dropin instead of /etc/ssh/sshd_config
+FILE='/etc/ssh/sshd_config.d/cis-5.2.12-disable-sshd-setenv.conf'
diff --git a/recipes-security/cip-cis-rules/files/cip-cis-rules/conf.d-overrides/cis-5.2.13-sshd-ciphers.cfg b/recipes-security/cip-cis-rules/files/cip-cis-rules/conf.d-overrides/cis-5.2.13-sshd-ciphers.cfg
new file mode 100644
index 0000000..955afa2
--- /dev/null
+++ b/recipes-security/cip-cis-rules/files/cip-cis-rules/conf.d-overrides/cis-5.2.13-sshd-ciphers.cfg
@@ -0,0 +1,2 @@
+# Re-point OVH audit at the CIS dropin instead of /etc/ssh/sshd_config
+FILE='/etc/ssh/sshd_config.d/cis-5.2.13-sshd-ciphers.conf'
diff --git a/recipes-security/cip-cis-rules/files/cip-cis-rules/conf.d-overrides/cis-5.2.14-ssh-cry-mac.cfg b/recipes-security/cip-cis-rules/files/cip-cis-rules/conf.d-overrides/cis-5.2.14-ssh-cry-mac.cfg
new file mode 100644
index 0000000..e007883
--- /dev/null
+++ b/recipes-security/cip-cis-rules/files/cip-cis-rules/conf.d-overrides/cis-5.2.14-ssh-cry-mac.cfg
@@ -0,0 +1,2 @@
+# Re-point OVH audit at the CIS dropin instead of /etc/ssh/sshd_config
+FILE='/etc/ssh/sshd_config.d/cis-5.2.14-ssh-cry-mac.conf'
diff --git a/recipes-security/cip-cis-rules/files/cip-cis-rules/conf.d-overrides/cis-5.2.15-ssh-cry-kex.cfg b/recipes-security/cip-cis-rules/files/cip-cis-rules/conf.d-overrides/cis-5.2.15-ssh-cry-kex.cfg
new file mode 100644
index 0000000..eb5e2d2
--- /dev/null
+++ b/recipes-security/cip-cis-rules/files/cip-cis-rules/conf.d-overrides/cis-5.2.15-ssh-cry-kex.cfg
@@ -0,0 +1,2 @@
+# Re-point OVH audit at the CIS dropin instead of /etc/ssh/sshd_config
+FILE='/etc/ssh/sshd_config.d/cis-5.2.15-ssh-cry-kex.conf'
diff --git a/recipes-security/cip-cis-rules/files/cip-cis-rules/conf.d-overrides/cis-5.2.16-sshd-idle-timeout.cfg b/recipes-security/cip-cis-rules/files/cip-cis-rules/conf.d-overrides/cis-5.2.16-sshd-idle-timeout.cfg
new file mode 100644
index 0000000..4bb45a2
--- /dev/null
+++ b/recipes-security/cip-cis-rules/files/cip-cis-rules/conf.d-overrides/cis-5.2.16-sshd-idle-timeout.cfg
@@ -0,0 +1,2 @@
+# Re-point OVH audit at the CIS dropin instead of /etc/ssh/sshd_config
+FILE='/etc/ssh/sshd_config.d/cis-5.2.16-sshd-idle-timeout.conf'
diff --git a/recipes-security/cip-cis-rules/files/cip-cis-rules/conf.d-overrides/cis-5.2.17-sshd-login-grace-time.cfg b/recipes-security/cip-cis-rules/files/cip-cis-rules/conf.d-overrides/cis-5.2.17-sshd-login-grace-time.cfg
new file mode 100644
index 0000000..e615a7f
--- /dev/null
+++ b/recipes-security/cip-cis-rules/files/cip-cis-rules/conf.d-overrides/cis-5.2.17-sshd-login-grace-time.cfg
@@ -0,0 +1,2 @@
+# Re-point OVH audit at the CIS dropin instead of /etc/ssh/sshd_config
+FILE='/etc/ssh/sshd_config.d/cis-5.2.17-sshd-login-grace-time.conf'
diff --git a/recipes-security/cip-cis-rules/files/cip-cis-rules/conf.d-overrides/cis-5.2.18-sshd-limit-access.cfg b/recipes-security/cip-cis-rules/files/cip-cis-rules/conf.d-overrides/cis-5.2.18-sshd-limit-access.cfg
new file mode 100644
index 0000000..7075e28
--- /dev/null
+++ b/recipes-security/cip-cis-rules/files/cip-cis-rules/conf.d-overrides/cis-5.2.18-sshd-limit-access.cfg
@@ -0,0 +1,2 @@
+# Re-point OVH audit at the CIS dropin instead of /etc/ssh/sshd_config
+FILE='/etc/ssh/sshd_config.d/cis-5.2.18-sshd-limit-access.conf'
diff --git a/recipes-security/cip-cis-rules/files/cip-cis-rules/conf.d-overrides/cis-5.2.19-ssh-banner.cfg b/recipes-security/cip-cis-rules/files/cip-cis-rules/conf.d-overrides/cis-5.2.19-ssh-banner.cfg
new file mode 100644
index 0000000..a9bbc05
--- /dev/null
+++ b/recipes-security/cip-cis-rules/files/cip-cis-rules/conf.d-overrides/cis-5.2.19-ssh-banner.cfg
@@ -0,0 +1,2 @@
+# Re-point OVH audit at the CIS dropin instead of /etc/ssh/sshd_config
+FILE='/etc/ssh/sshd_config.d/cis-5.2.19-ssh-banner.conf'
diff --git a/recipes-security/cip-cis-rules/files/cip-cis-rules/conf.d-overrides/cis-5.2.20-enable-ssh-pam.cfg b/recipes-security/cip-cis-rules/files/cip-cis-rules/conf.d-overrides/cis-5.2.20-enable-ssh-pam.cfg
new file mode 100644
index 0000000..1f980f6
--- /dev/null
+++ b/recipes-security/cip-cis-rules/files/cip-cis-rules/conf.d-overrides/cis-5.2.20-enable-ssh-pam.cfg
@@ -0,0 +1,2 @@
+# Re-point OVH audit at the CIS dropin instead of /etc/ssh/sshd_config
+FILE='/etc/ssh/sshd_config.d/cis-5.2.20-enable-ssh-pam.conf'
diff --git a/recipes-security/cip-cis-rules/files/cip-cis-rules/conf.d-overrides/cis-5.2.21-disable-ssh-allow-tcp-forwarding.cfg b/recipes-security/cip-cis-rules/files/cip-cis-rules/conf.d-overrides/cis-5.2.21-disable-ssh-allow-tcp-forwarding.cfg
new file mode 100644
index 0000000..e1aaab2
--- /dev/null
+++ b/recipes-security/cip-cis-rules/files/cip-cis-rules/conf.d-overrides/cis-5.2.21-disable-ssh-allow-tcp-forwarding.cfg
@@ -0,0 +1,2 @@
+# Re-point OVH audit at the CIS dropin instead of /etc/ssh/sshd_config
+FILE='/etc/ssh/sshd_config.d/cis-5.2.21-disable-ssh-allow-tcp-forwarding.conf'
diff --git a/recipes-security/cip-cis-rules/files/cip-cis-rules/conf.d-overrides/cis-5.2.22-configure-ssh-max-startups.cfg b/recipes-security/cip-cis-rules/files/cip-cis-rules/conf.d-overrides/cis-5.2.22-configure-ssh-max-startups.cfg
new file mode 100644
index 0000000..0804269
--- /dev/null
+++ b/recipes-security/cip-cis-rules/files/cip-cis-rules/conf.d-overrides/cis-5.2.22-configure-ssh-max-startups.cfg
@@ -0,0 +1,2 @@
+# Re-point OVH audit at the CIS dropin instead of /etc/ssh/sshd_config
+FILE='/etc/ssh/sshd_config.d/cis-5.2.22-configure-ssh-max-startups.conf'
diff --git a/recipes-security/cip-cis-rules/files/cip-cis-rules/conf.d-overrides/cis-5.2.23-limit-ssh-max-sessions.cfg b/recipes-security/cip-cis-rules/files/cip-cis-rules/conf.d-overrides/cis-5.2.23-limit-ssh-max-sessions.cfg
new file mode 100644
index 0000000..f6f7ebc
--- /dev/null
+++ b/recipes-security/cip-cis-rules/files/cip-cis-rules/conf.d-overrides/cis-5.2.23-limit-ssh-max-sessions.cfg
@@ -0,0 +1,2 @@
+# Re-point OVH audit at the CIS dropin instead of /etc/ssh/sshd_config
+FILE='/etc/ssh/sshd_config.d/cis-5.2.23-limit-ssh-max-sessions.conf'
diff --git a/recipes-security/cip-cis-rules/files/cip-cis-rules/conf.d-overrides/cis-5.2.4-sshd-protocol.cfg b/recipes-security/cip-cis-rules/files/cip-cis-rules/conf.d-overrides/cis-5.2.4-sshd-protocol.cfg
new file mode 100644
index 0000000..0c5cbd2
--- /dev/null
+++ b/recipes-security/cip-cis-rules/files/cip-cis-rules/conf.d-overrides/cis-5.2.4-sshd-protocol.cfg
@@ -0,0 +1,2 @@
+# Re-point OVH audit at the CIS dropin instead of /etc/ssh/sshd_config
+FILE='/etc/ssh/sshd_config.d/cis-5.2.4-sshd-protocol.conf'
diff --git a/recipes-security/cip-cis-rules/files/cip-cis-rules/conf.d-overrides/cis-5.2.5-sshd-loglevel.cfg b/recipes-security/cip-cis-rules/files/cip-cis-rules/conf.d-overrides/cis-5.2.5-sshd-loglevel.cfg
new file mode 100644
index 0000000..ddd9bb3
--- /dev/null
+++ b/recipes-security/cip-cis-rules/files/cip-cis-rules/conf.d-overrides/cis-5.2.5-sshd-loglevel.cfg
@@ -0,0 +1,2 @@
+# Re-point OVH audit at the CIS dropin instead of /etc/ssh/sshd_config
+FILE='/etc/ssh/sshd_config.d/cis-5.2.5-sshd-loglevel.conf'
diff --git a/recipes-security/cip-cis-rules/files/cip-cis-rules/conf.d-overrides/cis-5.2.6-disable-x11-forwarding.cfg b/recipes-security/cip-cis-rules/files/cip-cis-rules/conf.d-overrides/cis-5.2.6-disable-x11-forwarding.cfg
new file mode 100644
index 0000000..b7fba5c
--- /dev/null
+++ b/recipes-security/cip-cis-rules/files/cip-cis-rules/conf.d-overrides/cis-5.2.6-disable-x11-forwarding.cfg
@@ -0,0 +1,2 @@
+# Re-point OVH audit at the CIS dropin instead of /etc/ssh/sshd_config
+FILE='/etc/ssh/sshd_config.d/cis-5.2.6-disable-x11-forwarding.conf'
diff --git a/recipes-security/cip-cis-rules/files/cip-cis-rules/conf.d-overrides/cis-5.2.7-sshd-maxauthtries.cfg b/recipes-security/cip-cis-rules/files/cip-cis-rules/conf.d-overrides/cis-5.2.7-sshd-maxauthtries.cfg
new file mode 100644
index 0000000..c27cfde
--- /dev/null
+++ b/recipes-security/cip-cis-rules/files/cip-cis-rules/conf.d-overrides/cis-5.2.7-sshd-maxauthtries.cfg
@@ -0,0 +1,2 @@
+# Re-point OVH audit at the CIS dropin instead of /etc/ssh/sshd_config
+FILE='/etc/ssh/sshd_config.d/cis-5.2.7-sshd-maxauthtries.conf'
diff --git a/recipes-security/cip-cis-rules/files/cip-cis-rules/conf.d-overrides/cis-5.2.8-enable-sshd-ignorerhosts.cfg b/recipes-security/cip-cis-rules/files/cip-cis-rules/conf.d-overrides/cis-5.2.8-enable-sshd-ignorerhosts.cfg
new file mode 100644
index 0000000..253c2fc
--- /dev/null
+++ b/recipes-security/cip-cis-rules/files/cip-cis-rules/conf.d-overrides/cis-5.2.8-enable-sshd-ignorerhosts.cfg
@@ -0,0 +1,2 @@
+# Re-point OVH audit at the CIS dropin instead of /etc/ssh/sshd_config
+FILE='/etc/ssh/sshd_config.d/cis-5.2.8-enable-sshd-ignorerhosts.conf'
diff --git a/recipes-security/cip-cis-rules/files/cip-cis-rules/conf.d-overrides/cis-5.2.9-disable-sshd-hostbasedauthentication.cfg b/recipes-security/cip-cis-rules/files/cip-cis-rules/conf.d-overrides/cis-5.2.9-disable-sshd-hostbasedauthentication.cfg
new file mode 100644
index 0000000..d8dbaf7
--- /dev/null
+++ b/recipes-security/cip-cis-rules/files/cip-cis-rules/conf.d-overrides/cis-5.2.9-disable-sshd-hostbasedauthentication.cfg
@@ -0,0 +1,2 @@
+# Re-point OVH audit at the CIS dropin instead of /etc/ssh/sshd_config
+FILE='/etc/ssh/sshd_config.d/cis-5.2.9-disable-sshd-hostbasedauthentication.conf'
diff --git a/recipes-security/cip-cis-rules/files/cip-cis-rules/conf.d-overrides/cis-5.3.1-enable-pwquality.cfg b/recipes-security/cip-cis-rules/files/cip-cis-rules/conf.d-overrides/cis-5.3.1-enable-pwquality.cfg
new file mode 100644
index 0000000..f80b427
--- /dev/null
+++ b/recipes-security/cip-cis-rules/files/cip-cis-rules/conf.d-overrides/cis-5.3.1-enable-pwquality.cfg
@@ -0,0 +1,2 @@
+# Re-point OVH audit at the CIS dropin instead of /etc/security/pwquality.conf
+FILE_QUALITY='/etc/security/pwquality.conf.d/cis-5.3.1-enable-pwquality.conf'
diff --git a/recipes-security/cip-cis-rules/files/cip-cis-rules/configuration/cis-1.1.21.sh b/recipes-security/cip-cis-rules/files/cip-cis-rules/configuration/cis-1.1.21.sh
new file mode 100755
index 0000000..8cfefbc
--- /dev/null
+++ b/recipes-security/cip-cis-rules/files/cip-cis-rules/configuration/cis-1.1.21.sh
@@ -0,0 +1,6 @@
+#!/bin/sh
+# SPDX-License-Identifier: MIT
+# CIS 1.1.21 — set sticky bit on world-writable directories.
+# Idempotent: skips directories that already have the sticky bit.
+
+find / -xdev -type d -perm -0002 ! -perm -1000 -exec chmod a+t {} + 2>/dev/null || true
diff --git a/recipes-security/cip-cis-rules/files/cip-cis-rules/configuration/cis-1.5.1.sh b/recipes-security/cip-cis-rules/files/cip-cis-rules/configuration/cis-1.5.1.sh
new file mode 100755
index 0000000..a734d34
--- /dev/null
+++ b/recipes-security/cip-cis-rules/files/cip-cis-rules/configuration/cis-1.5.1.sh
@@ -0,0 +1,8 @@
+#!/bin/sh
+# SPDX-License-Identifier: MIT
+# CIS 1.5.1 — bootloader config ownership and permissions.
+
+if [ -f /boot/grub/grub.cfg ]; then
+    chown root:root /boot/grub/grub.cfg || true
+    chmod og-rwx /boot/grub/grub.cfg || true
+fi
diff --git a/recipes-security/cip-cis-rules/files/cip-cis-rules/configuration/cis-1.8.1.1.sh b/recipes-security/cip-cis-rules/files/cip-cis-rules/configuration/cis-1.8.1.1.sh
new file mode 100755
index 0000000..5a99fa9
--- /dev/null
+++ b/recipes-security/cip-cis-rules/files/cip-cis-rules/configuration/cis-1.8.1.1.sh
@@ -0,0 +1,7 @@
+#!/bin/sh
+# SPDX-License-Identifier: MIT
+# CIS 1.8.1.1 — remove OS information from /etc/motd.
+
+if [ -f /etc/motd ]; then
+    : > /etc/motd || true
+fi
diff --git a/recipes-security/cip-cis-rules/files/cip-cis-rules/configuration/cis-1.8.1.2.sh b/recipes-security/cip-cis-rules/files/cip-cis-rules/configuration/cis-1.8.1.2.sh
new file mode 100755
index 0000000..b7520de
--- /dev/null
+++ b/recipes-security/cip-cis-rules/files/cip-cis-rules/configuration/cis-1.8.1.2.sh
@@ -0,0 +1,7 @@
+#!/bin/sh
+# SPDX-License-Identifier: MIT
+# CIS 1.8.1.2 — remove OS information from /etc/issue.
+
+if [ -f /etc/issue ]; then
+    : > /etc/issue || true
+fi
diff --git a/recipes-security/cip-cis-rules/files/cip-cis-rules/configuration/cis-1.8.1.3.sh b/recipes-security/cip-cis-rules/files/cip-cis-rules/configuration/cis-1.8.1.3.sh
new file mode 100755
index 0000000..5ff7b7e
--- /dev/null
+++ b/recipes-security/cip-cis-rules/files/cip-cis-rules/configuration/cis-1.8.1.3.sh
@@ -0,0 +1,7 @@
+#!/bin/sh
+# SPDX-License-Identifier: MIT
+# CIS 1.8.1.3 — remove OS information from /etc/issue.net.
+
+if [ -f /etc/issue.net ]; then
+    : > /etc/issue.net || true
+fi
diff --git a/recipes-security/cip-cis-rules/files/cip-cis-rules/configuration/cis-1.8.1.4.sh b/recipes-security/cip-cis-rules/files/cip-cis-rules/configuration/cis-1.8.1.4.sh
new file mode 100755
index 0000000..31cf2e9
--- /dev/null
+++ b/recipes-security/cip-cis-rules/files/cip-cis-rules/configuration/cis-1.8.1.4.sh
@@ -0,0 +1,8 @@
+#!/bin/sh
+# SPDX-License-Identifier: MIT
+# CIS 1.8.1.4 — /etc/motd ownership and permissions.
+
+if [ -f /etc/motd ]; then
+    chown root:root /etc/motd || true
+    chmod 0644 /etc/motd || true
+fi
diff --git a/recipes-security/cip-cis-rules/files/cip-cis-rules/configuration/cis-1.8.1.5.sh b/recipes-security/cip-cis-rules/files/cip-cis-rules/configuration/cis-1.8.1.5.sh
new file mode 100755
index 0000000..80c4fc7
--- /dev/null
+++ b/recipes-security/cip-cis-rules/files/cip-cis-rules/configuration/cis-1.8.1.5.sh
@@ -0,0 +1,8 @@
+#!/bin/sh
+# SPDX-License-Identifier: MIT
+# CIS 1.8.1.5 — /etc/issue ownership and permissions.
+
+if [ -f /etc/issue ]; then
+    chown root:root /etc/issue || true
+    chmod 0644 /etc/issue || true
+fi
diff --git a/recipes-security/cip-cis-rules/files/cip-cis-rules/configuration/cis-1.8.1.6.sh b/recipes-security/cip-cis-rules/files/cip-cis-rules/configuration/cis-1.8.1.6.sh
new file mode 100755
index 0000000..f7bea0e
--- /dev/null
+++ b/recipes-security/cip-cis-rules/files/cip-cis-rules/configuration/cis-1.8.1.6.sh
@@ -0,0 +1,8 @@
+#!/bin/sh
+# SPDX-License-Identifier: MIT
+# CIS 1.8.1.6 — /etc/issue.net ownership and permissions.
+
+if [ -f /etc/issue.net ]; then
+    chown root:root /etc/issue.net || true
+    chmod 0644 /etc/issue.net || true
+fi
diff --git a/recipes-security/cip-cis-rules/files/cip-cis-rules/configuration/cis-2.2.1.2.sh b/recipes-security/cip-cis-rules/files/cip-cis-rules/configuration/cis-2.2.1.2.sh
new file mode 100755
index 0000000..9fc5376
--- /dev/null
+++ b/recipes-security/cip-cis-rules/files/cip-cis-rules/configuration/cis-2.2.1.2.sh
@@ -0,0 +1,9 @@
+#!/bin/sh
+# SPDX-License-Identifier: MIT
+# CIS 2.2.1.2 — enable systemd-timesyncd service.
+# systemd-timesyncd is owned by another package; we only enable it.
+
+if [ -d /run/systemd/system ] && command -v systemctl >/dev/null 2>&1; then
+    deb-systemd-helper enable systemd-timesyncd.service >/dev/null || true
+    deb-systemd-invoke start systemd-timesyncd.service >/dev/null || true
+fi
diff --git a/recipes-security/cip-cis-rules/files/cip-cis-rules/configuration/cis-4.2.3.sh b/recipes-security/cip-cis-rules/files/cip-cis-rules/configuration/cis-4.2.3.sh
new file mode 100755
index 0000000..df0f774
--- /dev/null
+++ b/recipes-security/cip-cis-rules/files/cip-cis-rules/configuration/cis-4.2.3.sh
@@ -0,0 +1,6 @@
+#!/bin/sh
+# SPDX-License-Identifier: MIT
+# CIS 4.2.3 — tighten permissions on existing log files.
+# Idempotent: only matches files still missing the desired tightness.
+
+find /var/log -type f -perm /0027 -exec chmod g-wx,o-rwx {} + 2>/dev/null || true
diff --git a/recipes-security/cip-cis-rules/files/cip-cis-rules/configuration/cis-4.4.sh b/recipes-security/cip-cis-rules/files/cip-cis-rules/configuration/cis-4.4.sh
new file mode 100644
index 0000000..b3bb1dc
--- /dev/null
+++ b/recipes-security/cip-cis-rules/files/cip-cis-rules/configuration/cis-4.4.sh
@@ -0,0 +1,9 @@
+#!/bin/sh
+# SPDX-License-Identifier: MIT
+# CIS 4.4 - Ensure logrotate assigns appropriate permissions
+# Idempotent: only rewrites /etc/logrotate.conf when its content differs from
+# the desired list.
+
+if [ -f /etc/logrotate.conf ]; then
+    sed -i 's/^create$/create 0640/g' /etc/logrotate.conf
+fi
diff --git a/recipes-security/cip-cis-rules/files/cip-cis-rules/configuration/cis-5.1.2.sh b/recipes-security/cip-cis-rules/files/cip-cis-rules/configuration/cis-5.1.2.sh
new file mode 100755
index 0000000..68e9fd1
--- /dev/null
+++ b/recipes-security/cip-cis-rules/files/cip-cis-rules/configuration/cis-5.1.2.sh
@@ -0,0 +1,8 @@
+#!/bin/sh
+# SPDX-License-Identifier: MIT
+# CIS 5.1.2 — /etc/crontab ownership and permissions.
+
+if [ -f /etc/crontab ]; then
+    chown root:root /etc/crontab || true
+    chmod og-rwx /etc/crontab || true
+fi
diff --git a/recipes-security/cip-cis-rules/files/cip-cis-rules/configuration/cis-5.1.3.sh b/recipes-security/cip-cis-rules/files/cip-cis-rules/configuration/cis-5.1.3.sh
new file mode 100755
index 0000000..6113198
--- /dev/null
+++ b/recipes-security/cip-cis-rules/files/cip-cis-rules/configuration/cis-5.1.3.sh
@@ -0,0 +1,8 @@
+#!/bin/sh
+# SPDX-License-Identifier: MIT
+# CIS 5.1.3 — /etc/cron.hourly ownership and permissions.
+
+if [ -d /etc/cron.hourly ]; then
+    chown root:root /etc/cron.hourly || true
+    chmod og-rwx /etc/cron.hourly || true
+fi
diff --git a/recipes-security/cip-cis-rules/files/cip-cis-rules/configuration/cis-5.1.4.sh b/recipes-security/cip-cis-rules/files/cip-cis-rules/configuration/cis-5.1.4.sh
new file mode 100755
index 0000000..427b8b0
--- /dev/null
+++ b/recipes-security/cip-cis-rules/files/cip-cis-rules/configuration/cis-5.1.4.sh
@@ -0,0 +1,8 @@
+#!/bin/sh
+# SPDX-License-Identifier: MIT
+# CIS 5.1.4 — /etc/cron.daily ownership and permissions.
+
+if [ -d /etc/cron.daily ]; then
+    chown root:root /etc/cron.daily || true
+    chmod og-rwx /etc/cron.daily || true
+fi
diff --git a/recipes-security/cip-cis-rules/files/cip-cis-rules/configuration/cis-5.1.5.sh b/recipes-security/cip-cis-rules/files/cip-cis-rules/configuration/cis-5.1.5.sh
new file mode 100755
index 0000000..014ef9a
--- /dev/null
+++ b/recipes-security/cip-cis-rules/files/cip-cis-rules/configuration/cis-5.1.5.sh
@@ -0,0 +1,8 @@
+#!/bin/sh
+# SPDX-License-Identifier: MIT
+# CIS 5.1.5 — /etc/cron.weekly ownership and permissions.
+
+if [ -d /etc/cron.weekly ]; then
+    chown root:root /etc/cron.weekly || true
+    chmod og-rwx /etc/cron.weekly || true
+fi
diff --git a/recipes-security/cip-cis-rules/files/cip-cis-rules/configuration/cis-5.1.6.sh b/recipes-security/cip-cis-rules/files/cip-cis-rules/configuration/cis-5.1.6.sh
new file mode 100755
index 0000000..3ee2efe
--- /dev/null
+++ b/recipes-security/cip-cis-rules/files/cip-cis-rules/configuration/cis-5.1.6.sh
@@ -0,0 +1,8 @@
+#!/bin/sh
+# SPDX-License-Identifier: MIT
+# CIS 5.1.6 — /etc/cron.monthly ownership and permissions.
+
+if [ -d /etc/cron.monthly ]; then
+    chown root:root /etc/cron.monthly || true
+    chmod og-rwx /etc/cron.monthly || true
+fi
diff --git a/recipes-security/cip-cis-rules/files/cip-cis-rules/configuration/cis-5.1.7.sh b/recipes-security/cip-cis-rules/files/cip-cis-rules/configuration/cis-5.1.7.sh
new file mode 100755
index 0000000..3b2d874
--- /dev/null
+++ b/recipes-security/cip-cis-rules/files/cip-cis-rules/configuration/cis-5.1.7.sh
@@ -0,0 +1,8 @@
+#!/bin/sh
+# SPDX-License-Identifier: MIT
+# CIS 5.1.7 — /etc/cron.d ownership and permissions.
+
+if [ -d /etc/cron.d ]; then
+    chown root:root /etc/cron.d || true
+    chmod og-rwx /etc/cron.d || true
+fi
diff --git a/recipes-security/cip-cis-rules/files/cip-cis-rules/configuration/cis-5.2.1.sh b/recipes-security/cip-cis-rules/files/cip-cis-rules/configuration/cis-5.2.1.sh
new file mode 100755
index 0000000..b24dd9c
--- /dev/null
+++ b/recipes-security/cip-cis-rules/files/cip-cis-rules/configuration/cis-5.2.1.sh
@@ -0,0 +1,8 @@
+#!/bin/sh
+# SPDX-License-Identifier: MIT
+# CIS 5.2.1 — sshd_config ownership and permissions.
+
+if [ -f /etc/ssh/sshd_config ]; then
+    chown root:root /etc/ssh/sshd_config || true
+    chmod og-rwx /etc/ssh/sshd_config || true
+fi
diff --git a/recipes-security/cip-cis-rules/files/cip-cis-rules/configuration/cis-5.2.2.sh b/recipes-security/cip-cis-rules/files/cip-cis-rules/configuration/cis-5.2.2.sh
new file mode 100755
index 0000000..70daf08
--- /dev/null
+++ b/recipes-security/cip-cis-rules/files/cip-cis-rules/configuration/cis-5.2.2.sh
@@ -0,0 +1,6 @@
+#!/bin/sh
+# SPDX-License-Identifier: MIT
+# CIS 5.2.2 — SSH host private key permissions.
+# Host keys may not exist yet if generated on first boot — skip silently.
+
+find /etc/ssh -maxdepth 1 -name '*_key' -exec chmod 0600 {} + 2>/dev/null || true
diff --git a/recipes-security/cip-cis-rules/files/cip-cis-rules/configuration/cis-5.2.3.sh b/recipes-security/cip-cis-rules/files/cip-cis-rules/configuration/cis-5.2.3.sh
new file mode 100755
index 0000000..de30625
--- /dev/null
+++ b/recipes-security/cip-cis-rules/files/cip-cis-rules/configuration/cis-5.2.3.sh
@@ -0,0 +1,6 @@
+#!/bin/sh
+# SPDX-License-Identifier: MIT
+# CIS 5.2.3 — SSH host public key permissions.
+# Host keys may not exist yet if generated on first boot — skip silently.
+
+find /etc/ssh -maxdepth 1 -name '*.pub' -exec chmod 0644 {} + 2>/dev/null || true
diff --git a/recipes-security/cip-cis-rules/files/cip-cis-rules/configuration/cis-5.3.2.sh b/recipes-security/cip-cis-rules/files/cip-cis-rules/configuration/cis-5.3.2.sh
new file mode 100755
index 0000000..d19bfea
--- /dev/null
+++ b/recipes-security/cip-cis-rules/files/cip-cis-rules/configuration/cis-5.3.2.sh
@@ -0,0 +1,10 @@
+#!/bin/sh
+# SPDX-License-Identifier: MIT
+# CIS 5.3.2 — enable PAM faillock account lockout.
+# Profile files were unpacked by dpkg into /usr/share/pam-configs/.
+# Run pam-auth-update in package mode to (re)derive the PAM stack.
+# Portable across libpam-runtime 1.3.x (bullseye) and 1.4+ (bookworm/trixie).
+
+if command -v pam-auth-update >/dev/null 2>&1; then
+    pam-auth-update --package || true
+fi
diff --git a/recipes-security/cip-cis-rules/files/cip-cis-rules/configuration/cis-5.3.3.sh b/recipes-security/cip-cis-rules/files/cip-cis-rules/configuration/cis-5.3.3.sh
new file mode 100755
index 0000000..7ebfc38
--- /dev/null
+++ b/recipes-security/cip-cis-rules/files/cip-cis-rules/configuration/cis-5.3.3.sh
@@ -0,0 +1,7 @@
+#!/bin/sh
+# SPDX-License-Identifier: MIT
+# CIS 5.3.3 — enable PAM password history reuse prevention.
+
+if command -v pam-auth-update >/dev/null 2>&1; then
+    pam-auth-update --package || true
+fi
diff --git a/recipes-security/cip-cis-rules/files/cip-cis-rules/configuration/cis-5.4.1.1.sh b/recipes-security/cip-cis-rules/files/cip-cis-rules/configuration/cis-5.4.1.1.sh
new file mode 100755
index 0000000..879b2f3
--- /dev/null
+++ b/recipes-security/cip-cis-rules/files/cip-cis-rules/configuration/cis-5.4.1.1.sh
@@ -0,0 +1,23 @@
+#!/bin/sh
+# SPDX-License-Identifier: MIT
+# CIS 5.4.1.1 — set PASS_MAX_DAYS in /etc/login.defs.
+#
+# /etc/login.defs is a conffile of the `login` package and shadow upstream
+# does NOT support a /etc/login.defs.d/ drop-in directory.  As a hardening
+# *configuration package* we therefore have to edit the file in place.
+# The original is preserved as /etc/login.defs.cip-cis.bak (once).
+# See README.Debian.
+
+key=PASS_MAX_DAYS
+value=@@VALUE@@
+
+if [ -f /etc/login.defs ]; then
+    if [ ! -f /etc/login.defs.cip-cis.bak ]; then
+        cp -a /etc/login.defs /etc/login.defs.cip-cis.bak || true
+    fi
+    if grep -qE "^[[:space:]]*${key}([[:space:]]|\$)" /etc/login.defs; then
+        sed -i -E "s|^[[:space:]]*${key}[[:space:]].*|${key}   ${value}|" /etc/login.defs || true
+    else
+        printf '%s\n' "${key}   ${value}" >> /etc/login.defs || true
+    fi
+fi
diff --git a/recipes-security/cip-cis-rules/files/cip-cis-rules/configuration/cis-5.4.1.2.sh b/recipes-security/cip-cis-rules/files/cip-cis-rules/configuration/cis-5.4.1.2.sh
new file mode 100755
index 0000000..09022e2
--- /dev/null
+++ b/recipes-security/cip-cis-rules/files/cip-cis-rules/configuration/cis-5.4.1.2.sh
@@ -0,0 +1,17 @@
+#!/bin/sh
+# SPDX-License-Identifier: MIT
+# CIS 5.4.1.2 — set PASS_MIN_DAYS in /etc/login.defs.  See README.Debian.
+
+key=PASS_MIN_DAYS
+value=@@VALUE@@
+
+if [ -f /etc/login.defs ]; then
+    if [ ! -f /etc/login.defs.cip-cis.bak ]; then
+        cp -a /etc/login.defs /etc/login.defs.cip-cis.bak || true
+    fi
+    if grep -qE "^[[:space:]]*${key}([[:space:]]|\$)" /etc/login.defs; then
+        sed -i -E "s|^[[:space:]]*${key}[[:space:]].*|${key}   ${value}|" /etc/login.defs || true
+    else
+        printf '%s\n' "${key}   ${value}" >> /etc/login.defs || true
+    fi
+fi
diff --git a/recipes-security/cip-cis-rules/files/cip-cis-rules/configuration/cis-5.4.1.3.sh b/recipes-security/cip-cis-rules/files/cip-cis-rules/configuration/cis-5.4.1.3.sh
new file mode 100755
index 0000000..f635fb7
--- /dev/null
+++ b/recipes-security/cip-cis-rules/files/cip-cis-rules/configuration/cis-5.4.1.3.sh
@@ -0,0 +1,17 @@
+#!/bin/sh
+# SPDX-License-Identifier: MIT
+# CIS 5.4.1.3 — set PASS_WARN_AGE in /etc/login.defs.  See README.Debian.
+
+key=PASS_WARN_AGE
+value=@@VALUE@@
+
+if [ -f /etc/login.defs ]; then
+    if [ ! -f /etc/login.defs.cip-cis.bak ]; then
+        cp -a /etc/login.defs /etc/login.defs.cip-cis.bak || true
+    fi
+    if grep -qE "^[[:space:]]*${key}([[:space:]]|\$)" /etc/login.defs; then
+        sed -i -E "s|^[[:space:]]*${key}[[:space:]].*|${key}   ${value}|" /etc/login.defs || true
+    else
+        printf '%s\n' "${key}   ${value}" >> /etc/login.defs || true
+    fi
+fi
diff --git a/recipes-security/cip-cis-rules/files/cip-cis-rules/configuration/cis-5.5.sh b/recipes-security/cip-cis-rules/files/cip-cis-rules/configuration/cis-5.5.sh
new file mode 100755
index 0000000..fdf8827
--- /dev/null
+++ b/recipes-security/cip-cis-rules/files/cip-cis-rules/configuration/cis-5.5.sh
@@ -0,0 +1,19 @@
+#!/bin/sh
+# SPDX-License-Identifier: MIT
+# CIS 5.5 — restrict root login to console ttys.
+# Idempotent: only rewrites /etc/securetty when its content differs from
+# the desired list.  The original is preserved as /etc/securetty.dpkg-old.
+
+desired='console
+tty1'
+
+current=
+[ -f /etc/securetty ] && current=$(cat /etc/securetty 2>/dev/null)
+
+if [ "$current" != "$desired" ]; then
+    if [ -f /etc/securetty ] && [ ! -f /etc/securetty.dpkg-old ]; then
+        cp -a /etc/securetty /etc/securetty.dpkg-old || true
+    fi
+    printf 'console\ntty1\n' > /etc/securetty || true
+    chmod 0600 /etc/securetty || true
+fi
diff --git a/recipes-security/cip-cis-rules/files/cip-cis-rules/configuration/cis-5.6.sh b/recipes-security/cip-cis-rules/files/cip-cis-rules/configuration/cis-5.6.sh
new file mode 100644
index 0000000..5db277c
--- /dev/null
+++ b/recipes-security/cip-cis-rules/files/cip-cis-rules/configuration/cis-5.6.sh
@@ -0,0 +1,9 @@
+#!/bin/sh
+# SPDX-License-Identifier: MIT
+# CIS 5.6 - restrict su to root
+# Idempotent: only rewrites /etc/pam.d/su when its content differs from
+# the desired list.
+
+if [ -f /etc/pam.d/su ]; then
+    sed -i 's/^#\s*\(auth.*required.*pam_wheel\.so\)/\1/g' /etc/pam.d/su
+fi
diff --git a/recipes-security/cip-cis-rules/files/cip-cis-rules/debian/cip-cis-rules.postinst b/recipes-security/cip-cis-rules/files/cip-cis-rules/debian/cip-cis-rules.postinst
new file mode 100755
index 0000000..29aa8e5
--- /dev/null
+++ b/recipes-security/cip-cis-rules/files/cip-cis-rules/debian/cip-cis-rules.postinst
@@ -0,0 +1,30 @@
+#!/bin/sh
+# SPDX-License-Identifier: MIT
+
+set -e
+
+CIP_CIS_CONF_DIR=/usr/share/cip-cis-rules/configuration
+
+case "$1" in
+    configure)
+        if [ -d "$CIP_CIS_CONF_DIR" ]; then
+            for script in "$CIP_CIS_CONF_DIR"/*.sh; do
+                [ -r "$script" ] || continue
+                if ! sh "$script"; then
+                    echo "cip-cis-rules: $(basename "$script") failed" >&2
+                    exit 1
+                fi
+            done
+        fi
+        ;;
+    abort-upgrade|abort-remove|abort-deconfigure)
+        ;;
+    *)
+        echo "postinst called with unknown argument '$1'" >&2
+        exit 1
+        ;;
+esac
+
+#DEBHELPER#
+
+exit 0
diff --git a/recipes-security/cip-cis-rules/files/cip-cis-rules/debian/control b/recipes-security/cip-cis-rules/files/cip-cis-rules/debian/control
new file mode 100644
index 0000000..1ff29de
--- /dev/null
+++ b/recipes-security/cip-cis-rules/files/cip-cis-rules/debian/control
@@ -0,0 +1,31 @@
+Source: cip-cis-rules
+Section: admin
+Priority: optional
+Maintainer: cip-dev <cip-dev@lists.cip-project.org>
+Build-Depends:
+ debhelper-compat (= 13),
+ python3:any (>= 3.9~),
+ cip-cis-rules-config,
+Standards-Version: 4.6.2
+Homepage: https://www.cip-project.org/
+Rules-Requires-Root: no
+
+Package: cip-cis-rules
+Architecture: all
+Multi-Arch: foreign
+Pre-Depends:
+ init-system-helpers,
+ libpam-runtime,
+Depends:
+ ${misc:Depends},
+Description: CIS hardening configuration files for CIP
+ Provides configuration file snippets implementing CIS benchmark hardening
+ rules for CIP (Civil Infrastructure Platform) systems. The set of installed
+ rules and their required package dependencies and conflicts are determined
+ at build time from the generator/.config.json rule selection.
+ .
+ Note: this is a *configuration package*. By design its maintainer scripts
+ may adjust state owned by other packages (e.g. PAM stack registration via
+ pam-auth-update, /etc/login.defs password ageing parameters, sshd_config
+ file permissions). See /usr/share/doc/cip-cis-rules/README.Debian for the
+ full list of cross-package interactions and how they are reverted on purge.
diff --git a/recipes-security/cip-cis-rules/files/cip-cis-rules/debian/rules b/recipes-security/cip-cis-rules/files/cip-cis-rules/debian/rules
new file mode 100755
index 0000000..7a916b9
--- /dev/null
+++ b/recipes-security/cip-cis-rules/files/cip-cis-rules/debian/rules
@@ -0,0 +1,20 @@
+#!/usr/bin/make -f
+# SPDX-License-Identifier: MIT
+PACKAGE	       := cip-cis-rules
+CONFIG_JSON    := /usr/share/cip-cis-rules/.config.json
+RULE_PKG_JSON  := debian/scripts/rule-packages.json
+SUBSTVARS      := debian/$(PACKAGE).substvars
+DESTDIR        := debian/$(PACKAGE)
+
+%:
+	dh $@
+
+# Copy enabled config snippets into the main package staging tree.
+# Install the rule-selection config and kernel fragment into the dev package
+# so that build systems and validation tools can consume them.
+override_dh_auto_install:
+	python3 debian/scripts/package-enable-configs.py \
+		--config $(CONFIG_JSON) \
+		--snippets-dir . \
+		--output-dir $(DESTDIR)
+	dh_auto_install
diff --git a/recipes-security/cip-cis-rules/files/cip-cis-rules/debian/scripts/package-enable-configs.py b/recipes-security/cip-cis-rules/files/cip-cis-rules/debian/scripts/package-enable-configs.py
new file mode 100644
index 0000000..293599c
--- /dev/null
+++ b/recipes-security/cip-cis-rules/files/cip-cis-rules/debian/scripts/package-enable-configs.py
@@ -0,0 +1,332 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: MIT
+"""
+Package enabled CIS hardening configuration snippets into a partial root directory
+for Debian package creation.
+
+This script:
+1. Parses a .config.json file to find rules with apply=true
+2. Maps rule names to generated config file snippets  
+3. Copies enabled config files to the correct locations in a partial root directory
+4. Creates the directory structure that dpkg-raw expects for package building
+
+Usage:
+    python3 package-enabled-configs.py \\
+        --config /path/to/.config.json \\
+        --snippets-dir /path/to/cis-config-snippets \\
+        --output-dir /path/to/partial/root
+"""
+
+import argparse
+import logging
+import json
+import re
+import sys
+from pathlib import Path
+from typing import Dict, List, Set
+
+logger = logging.getLogger(__name__)
+
+
+def load_json(path: Path, logger: logging.Logger) -> dict:
+    """Load a JSON file. On error, log to stderr and exit with status 1."""
+    try:
+        with Path(path).open() as f:
+            return json.load(f)
+    except (json.JSONDecodeError, OSError) as exc:
+        logger.error(f"Error loading file '{path}': {exc}")
+        sys.exit(1)
+
+
+def get_enabled_rules(config: dict) -> set[str]:
+    """Return the set of rule names where rule.apply is true and the name is non-empty."""
+    enabled: set[str] = set()
+    for entry in config.get("rules", []):
+        rule = entry.get("rule", {}) if isinstance(entry, dict) else {}
+        if rule.get("apply", False) and rule.get("name"):
+            enabled.add(rule["name"])
+    return enabled
+
+
+# ---------------------------------------------------------------------------
+# Dynamic rule discovery
+# Discovers config files based on CIS rule IDs encoded in filenames
+# ---------------------------------------------------------------------------
+
+# ---------------------------------------------------------------------------
+# Destination path prefix overrides
+# By default snippets are placed under etc/ in the output root.
+# Entries here map a source subdirectory prefix to a different destination
+# prefix.  Keys are Path parts (as strings) relative to snippets_dir.
+# ---------------------------------------------------------------------------
+DEST_PREFIX_OVERRIDES: Dict[str, str] = {
+    "pam-configs": "usr/share/pam-configs",
+    "chrony": "etc/chrony",
+    "configuration": "usr/share/cip-cis-rules/configuration",
+    "conf.d-overrides": "usr/share/cip-cis-rules/conf.d-overrides",
+    "sshd_config.d": "etc/ssh/sshd_config.d",
+}
+
+# ---------------------------------------------------------------------------
+# Per-source-prefix file mode overrides.
+# By default snippets are written with the umask default (typically 0644).
+# Some destinations are rejected by the consuming tool unless mode is set
+# explicitly; in particular sudo refuses to read /etc/sudoers.d/* unless
+# mode is <= 0440 and owner is root.
+# Keys are the first component of the source path (relative to snippets_dir).
+# ---------------------------------------------------------------------------
+DEST_MODE_OVERRIDES: Dict[str, int] = {
+    "sudoers.d": 0o440,
+    "configuration": 0o755,
+}
+
+
+def dest_mode(source_rel: "Path") -> "int | None":
+    """
+    Return the explicit file mode for the destination of ``source_rel``,
+    or ``None`` if no override applies (caller should leave the file at the
+    umask default).
+    """
+    parts = source_rel.parts
+    first = parts[0] if parts else ""
+    return DEST_MODE_OVERRIDES.get(first)
+
+
+def dest_rel_path(source_rel: "Path") -> "Path":
+    """
+    Return the destination path relative to the output root for a given
+    source-relative path.
+
+    The first component of source_rel is matched against DEST_PREFIX_OVERRIDES.
+    If found the first component is replaced with the mapped prefix.
+    Otherwise 'etc' is prepended (legacy behaviour).
+    """
+    parts = source_rel.parts
+    first = parts[0] if parts else ""
+    if first in DEST_PREFIX_OVERRIDES:
+        rest = parts[1:]
+        if not rest:
+            raise ValueError(
+                f"dest_rel_path: snippet '{source_rel}' sits at snippets root "
+                f"with a prefix-override key as its name — cannot determine destination"
+            )
+        return Path(DEST_PREFIX_OVERRIDES[first]) / Path(*rest)
+    return Path("etc") / source_rel
+
+
+def discover_rule_files(
+    snippets_dir: Path, logger: logging.Logger
+) -> Dict[str, List[Path]]:
+    """
+    Dynamically discover config files by scanning snippets directory.
+
+    Looks for files matching pattern: cis-X.Y.Z-* or cis-X.Y.Z.W-* (dot-separated rule ID)
+
+    Returns a mapping of rule_id -> list of file paths relative to snippets_dir.
+    """
+    # Pattern to match CIS rule IDs in filenames (dot-separated)
+    pattern = re.compile(r"cis-(\d+)\.(\d+)\.(\d+)(?:\.(\d+))?")
+
+    rule_files: Dict[str, List[Path]] = {}
+
+    # Recursively find all files in snippets directory
+    for file_path in snippets_dir.rglob("*"):
+        if not file_path.is_file():
+            continue
+
+        filename = file_path.name
+
+        # Try to match pattern
+        match = pattern.search(filename)
+        if match:
+            groups = match.groups()
+
+            # Build rule ID (X.Y.Z or X.Y.Z.W format)
+            if groups[3]:  # 4-part rule ID
+                rule_id = f"{groups[0]}.{groups[1]}.{groups[2]}.{groups[3]}"
+            else:  # 3-part rule ID
+                rule_id = f"{groups[0]}.{groups[1]}.{groups[2]}"
+
+            # Get relative path from snippets_dir
+            rel_path = file_path.relative_to(snippets_dir)
+
+            # Add to mapping
+            if rule_id not in rule_files:
+                rule_files[rule_id] = []
+            rule_files[rule_id].append(rel_path)
+
+            logger.debug(f"Discovered rule {rule_id}: {rel_path}")
+
+    logger.info(f"Discovered {len(rule_files)} rules with config files")
+    return rule_files
+
+
+def get_rule_values(config: dict) -> Dict[str, str]:
+    """Extract the optional value field for each rule."""
+    values = {}
+    for rule_entry in config.get("rules", []):
+        rule = rule_entry.get("rule", {})
+        name = rule.get("name", "")
+        value = rule.get("value")
+        if name and value is not None:
+            values[name] = value
+    return values
+
+
+def package_configs(
+    enabled_rules: Set[str],
+    rule_files: Dict[str, List[Path]],
+    rule_values: Dict[str, str],
+    snippets_dir: Path,
+    output_dir: Path,
+    logger: logging.Logger,
+) -> int:
+    """
+    Copy enabled config snippets to the partial root directory structure.
+    Returns the number of errors encountered.
+    """
+    errors = 0
+    processed_files = 0
+
+    for rule_name in sorted(enabled_rules):
+        if rule_name not in rule_files:
+            logger.debug(f"SKIP {rule_name}: no config files found for this rule")
+            continue
+
+        file_paths = rule_files[rule_name]
+
+        for source_rel in file_paths:
+            source_path = snippets_dir / source_rel
+            # Use new dest_rel_path function to determine destination
+            dest_rel = dest_rel_path(source_rel)
+            dest_path = output_dir / dest_rel
+
+            if not source_path.exists():
+                logger.error(f"{rule_name}: config file '{source_path}' not found")
+                errors += 1
+                continue
+
+            logger.debug(f"copy {rule_name}: {source_rel} → {dest_rel}")
+
+            # Create destination directory
+            dest_path.parent.mkdir(parents=True, exist_ok=True)
+            # Read source, substitute @@VALUE@@ if a value is configured
+            content = source_path.read_text()
+            if "@@VALUE@@" in content:
+                value = rule_values.get(rule_name)
+                if value is None:
+                    logger.error(
+                        f"{rule_name}: snippet contains @@VALUE@@ but no "
+                        f"'value' field is set in .config.json"
+                    )
+                    errors += 1
+                    continue
+                content = content.replace("@@VALUE@@", value)
+                logger.debug(f"substituted @@VALUE@@={value!r} in {source_rel}")
+            dest_path.write_text(content)
+            mode = dest_mode(source_rel)
+            if mode is not None:
+                dest_path.chmod(mode)
+                logger.debug(f"set mode {mode:#o} on {dest_rel}")
+
+            processed_files += 1
+
+    skipped_rules = len(enabled_rules) - len(
+        [r for r in enabled_rules if r in rule_files]
+    )
+    logger.debug(
+        f"Summary: {processed_files} config files processed, "
+        f"{skipped_rules} rules skipped (no config files found)"
+    )
+
+    return errors
+
+
+def setup_parser() -> argparse.ArgumentParser:
+    parser = argparse.ArgumentParser(
+        prog="package-enabled-configs",
+        description=(
+            "Package enabled CIS hardening configuration snippets into a partial "
+            "root directory for Debian package creation."
+        ),
+    )
+    parser.add_argument(
+        "--config",
+        type=Path,
+        required=True,
+        metavar="FILE",
+        help="Path to .config.json file containing rule selections",
+    )
+    parser.add_argument(
+        "--snippets-dir",
+        type=Path,
+        required=True,
+        metavar="DIR",
+        help="Directory containing generated config file snippets",
+    )
+    parser.add_argument(
+        "--output-dir",
+        type=Path,
+        required=True,
+        metavar="DIR",
+        help="Output directory for partial root filesystem structure",
+    )
+    return parser
+
+
+def main() -> None:
+    parser = setup_parser()
+    args = parser.parse_args()
+
+    logging.basicConfig(
+        level=logging.INFO,
+        format="%(levelname)s: %(message)s",
+    )
+
+    # Validate inputs
+    if not args.config.is_file():
+        logger.error(f"config file '{args.config}' does not exist")
+        sys.exit(1)
+
+    if not args.snippets_dir.is_dir():
+        logger.error(f"snippets directory '{args.snippets_dir}' does not exist")
+        sys.exit(1)
+
+    args.output_dir.mkdir(parents=True, exist_ok=True)
+
+    # Discover available config files
+    logger.debug(f"Discovering config files in: {args.snippets_dir}")
+    rule_files = discover_rule_files(args.snippets_dir, logger)
+
+    # Load configuration and get enabled rules
+    config = load_json(args.config, logger)
+    enabled_rules = get_enabled_rules(config)
+    rule_values = get_rule_values(config)
+
+    logger.debug(f"Loaded configuration from: {args.config}")
+    logger.info(f"Found {len(enabled_rules)} enabled rules")
+    if enabled_rules:
+        implementable_rules = enabled_rules & set(rule_files.keys())
+        logger.debug(f"Rules with config files available: {len(implementable_rules)}")
+
+    if not enabled_rules:
+        logger.error("No rules are enabled (apply=true) in the configuration")
+        sys.exit(1)
+
+    # Package the configs
+    errors = package_configs(
+        enabled_rules,
+        rule_files,
+        rule_values,
+        args.snippets_dir,
+        args.output_dir,
+        logger,
+    )
+
+    if errors:
+        logger.error(f"{errors} error(s) occurred during packaging")
+        sys.exit(1)
+
+
+if __name__ == "__main__":
+    main()
diff --git a/recipes-security/cip-cis-rules/files/cip-cis-rules/debian/scripts/rule-packages.json b/recipes-security/cip-cis-rules/files/cip-cis-rules/debian/scripts/rule-packages.json
new file mode 100644
index 0000000..cb991b4
--- /dev/null
+++ b/recipes-security/cip-cis-rules/files/cip-cis-rules/debian/scripts/rule-packages.json
@@ -0,0 +1,61 @@
+{
+  "comment": "Maps CIS rule IDs to Debian packages they require (installs) or conflict with (conflicts).",
+  "rules": {
+    "1.3.1": { "installs": ["sudo"] },
+    "1.4.1": { "installs": ["tripwire"] },
+    "1.4.2": { "installs": ["tripwire"] },
+    "1.7.1.1": { "installs": ["apparmor", "apparmor-utils"] },
+    "1.7.1.2": { "installs": ["apparmor"] },
+    "1.7.1.3": { "installs": ["apparmor", "apparmor-utils"] },
+    "1.7.1.4": { "installs": ["apparmor", "apparmor-utils"] },
+    "2.1.1":  { "conflicts": ["xinetd"] },
+    "2.1.2":  { "conflicts": ["openbsd-inetd"] },
+    "2.2.1.2": { "installs": ["systemd-timesyncd"] },
+    "2.2.1.3": { "installs": ["chrony"] },
+    "2.2.2":  { "conflicts": ["xserver-xorg-core"] },
+    "2.2.3":  { "conflicts": ["avahi-daemon"] },
+    "2.2.4":  { "conflicts": ["cups"] },
+    "2.2.5":  { "conflicts": ["isc-dhcp-server"] },
+    "2.2.6":  { "conflicts": ["slapd"] },
+    "2.2.7":  { "conflicts": ["nfs-kernel-server", "rpcbind"] },
+    "2.2.8":  { "conflicts": ["bind9"] },
+    "2.2.9":  { "conflicts": ["vsftpd"] },
+    "2.2.10": { "conflicts": ["apache2"] },
+    "2.2.11": { "conflicts": ["dovecot-imapd"] },
+    "2.2.12": { "conflicts": ["samba"] },
+    "2.2.13": { "conflicts": ["squid"] },
+    "2.2.14": { "conflicts": ["snmpd"] },
+    "2.2.16": { "conflicts": ["rsync"] },
+    "2.2.17": { "conflicts": ["nis"] },
+    "2.3.1":  { "conflicts": ["nis"] },
+    "2.3.2":  { "conflicts": ["rsh-client"] },
+    "2.3.3":  { "conflicts": ["talk"] },
+    "2.3.4":  { "conflicts": ["telnet"] },
+    "2.3.5":  { "conflicts": ["ldap-utils"] },
+    "3.5.1.1": { "installs": ["nftables"] },
+    "4.1.1.1": { "installs": ["auditd"] },
+    "4.1.1.2": { "installs": ["auditd"] },
+    "4.1.1.3": { "installs": ["auditd"] },
+    "4.1.1.4": { "installs": ["auditd"] },
+    "4.1.2.1": { "installs": ["auditd"] },
+    "4.1.2.2": { "installs": ["auditd"] },
+    "4.1.2.3": { "installs": ["auditd"] },
+    "4.1.3":   { "installs": ["auditd"] },
+    "4.1.4":   { "installs": ["auditd"] },
+    "4.1.5":   { "installs": ["auditd"] },
+    "4.1.6":   { "installs": ["auditd"] },
+    "4.1.7":   { "installs": ["auditd"] },
+    "4.1.8":   { "installs": ["auditd"] },
+    "4.1.9":   { "installs": ["auditd"] },
+    "4.1.10":  { "installs": ["auditd"] },
+    "4.1.11":  { "installs": ["auditd"] },
+    "4.1.12":  { "installs": ["auditd"] },
+    "4.1.13":  { "installs": ["auditd"] },
+    "4.1.14":  { "installs": ["auditd"] },
+    "4.1.15":  { "installs": ["auditd"] },
+    "4.1.16":  { "installs": ["auditd"] },
+    "4.1.17":  { "installs": ["auditd"] },
+    "5.3.2":   {},
+    "5.3.3":   {}
+  }
+}
diff --git a/recipes-security/cip-cis-rules/files/cip-cis-rules/modprobe.d/cis-1.1.1.1-disable-freevxfs.conf b/recipes-security/cip-cis-rules/files/cip-cis-rules/modprobe.d/cis-1.1.1.1-disable-freevxfs.conf
new file mode 100644
index 0000000..5c76c8e
--- /dev/null
+++ b/recipes-security/cip-cis-rules/files/cip-cis-rules/modprobe.d/cis-1.1.1.1-disable-freevxfs.conf
@@ -0,0 +1,3 @@
+# CIS Rule 1.1.1.1 - Disable mounting of freevxfs filesystems.
+# Generated from ovh/debian-cis bin/hardening/disable_freevxfs.sh
+install freevxfs /bin/true
diff --git a/recipes-security/cip-cis-rules/files/cip-cis-rules/modprobe.d/cis-1.1.1.2-disable-jffs2.conf b/recipes-security/cip-cis-rules/files/cip-cis-rules/modprobe.d/cis-1.1.1.2-disable-jffs2.conf
new file mode 100644
index 0000000..034c4f2
--- /dev/null
+++ b/recipes-security/cip-cis-rules/files/cip-cis-rules/modprobe.d/cis-1.1.1.2-disable-jffs2.conf
@@ -0,0 +1,3 @@
+# CIS Rule 1.1.1.2 - Disable mounting of jffs2 filesystems.
+# Generated from ovh/debian-cis bin/hardening/disable_jffs2.sh
+install jffs2 /bin/true
diff --git a/recipes-security/cip-cis-rules/files/cip-cis-rules/modprobe.d/cis-1.1.1.3-disable-hfs.conf b/recipes-security/cip-cis-rules/files/cip-cis-rules/modprobe.d/cis-1.1.1.3-disable-hfs.conf
new file mode 100644
index 0000000..9ad518a
--- /dev/null
+++ b/recipes-security/cip-cis-rules/files/cip-cis-rules/modprobe.d/cis-1.1.1.3-disable-hfs.conf
@@ -0,0 +1,3 @@
+# CIS Rule 1.1.1.3 - Disable mounting of hfs filesystems.
+# Generated from ovh/debian-cis bin/hardening/disable_hfs.sh
+install hfs /bin/true
diff --git a/recipes-security/cip-cis-rules/files/cip-cis-rules/modprobe.d/cis-1.1.1.4-disable-hfsplus.conf b/recipes-security/cip-cis-rules/files/cip-cis-rules/modprobe.d/cis-1.1.1.4-disable-hfsplus.conf
new file mode 100644
index 0000000..150e22a
--- /dev/null
+++ b/recipes-security/cip-cis-rules/files/cip-cis-rules/modprobe.d/cis-1.1.1.4-disable-hfsplus.conf
@@ -0,0 +1,3 @@
+# CIS Rule 1.1.1.4 - Disable mounting of hfsplus filesystems.
+# Generated from ovh/debian-cis bin/hardening/disable_hfsplus.sh
+install hfsplus /bin/true
diff --git a/recipes-security/cip-cis-rules/files/cip-cis-rules/modprobe.d/cis-1.1.1.5-disable-squashfs.conf b/recipes-security/cip-cis-rules/files/cip-cis-rules/modprobe.d/cis-1.1.1.5-disable-squashfs.conf
new file mode 100644
index 0000000..d469029
--- /dev/null
+++ b/recipes-security/cip-cis-rules/files/cip-cis-rules/modprobe.d/cis-1.1.1.5-disable-squashfs.conf
@@ -0,0 +1,3 @@
+# CIS Rule 1.1.1.5 - Disable mounting of squashfs filesystems.
+# Generated from ovh/debian-cis bin/hardening/disable_squashfs.sh
+install squashfs /bin/true
diff --git a/recipes-security/cip-cis-rules/files/cip-cis-rules/modprobe.d/cis-1.1.1.6-disable-udf.conf b/recipes-security/cip-cis-rules/files/cip-cis-rules/modprobe.d/cis-1.1.1.6-disable-udf.conf
new file mode 100644
index 0000000..a2dfa43
--- /dev/null
+++ b/recipes-security/cip-cis-rules/files/cip-cis-rules/modprobe.d/cis-1.1.1.6-disable-udf.conf
@@ -0,0 +1,3 @@
+# CIS Rule 1.1.1.6 - Disable mounting of udf filesystems.
+# Generated from ovh/debian-cis bin/hardening/disable_udf.sh
+install udf /bin/true
diff --git a/recipes-security/cip-cis-rules/files/cip-cis-rules/modprobe.d/cis-1.1.1.7-restrict-fat.conf b/recipes-security/cip-cis-rules/files/cip-cis-rules/modprobe.d/cis-1.1.1.7-restrict-fat.conf
new file mode 100644
index 0000000..cdc9cb6
--- /dev/null
+++ b/recipes-security/cip-cis-rules/files/cip-cis-rules/modprobe.d/cis-1.1.1.7-restrict-fat.conf
@@ -0,0 +1,5 @@
+# CIS Rule 1.1.1.7 - Limit mounting of FAT filesystems.
+# Generated from ovh/debian-cis bin/hardening/restrict_fat.sh
+install fat /bin/true
+install vfat /bin/true
+install msdos /bin/true
diff --git a/recipes-security/cip-cis-rules/files/cip-cis-rules/modprobe.d/cis-1.1.1.8-disable-cramfs.conf b/recipes-security/cip-cis-rules/files/cip-cis-rules/modprobe.d/cis-1.1.1.8-disable-cramfs.conf
new file mode 100644
index 0000000..57badf5
--- /dev/null
+++ b/recipes-security/cip-cis-rules/files/cip-cis-rules/modprobe.d/cis-1.1.1.8-disable-cramfs.conf
@@ -0,0 +1,3 @@
+# CIS Rule 1.1.1.8 - Disable mounting of cramfs filesystems.
+# Generated from ovh/debian-cis bin/hardening/disable_cramfs.sh
+install cramfs /bin/true
diff --git a/recipes-security/cip-cis-rules/files/cip-cis-rules/modprobe.d/cis-1.1.23-disable-usb-storage.conf b/recipes-security/cip-cis-rules/files/cip-cis-rules/modprobe.d/cis-1.1.23-disable-usb-storage.conf
new file mode 100644
index 0000000..3fa82af
--- /dev/null
+++ b/recipes-security/cip-cis-rules/files/cip-cis-rules/modprobe.d/cis-1.1.23-disable-usb-storage.conf
@@ -0,0 +1,3 @@
+# CIS Rule 1.1.23 - Disable USB storage.
+# Generated from ovh/debian-cis bin/hardening/disable_usb_storage.sh
+install usb-storage /bin/true
diff --git a/recipes-security/cip-cis-rules/files/cip-cis-rules/pam-configs/cis-5.3.2-faillock b/recipes-security/cip-cis-rules/files/cip-cis-rules/pam-configs/cis-5.3.2-faillock
new file mode 100644
index 0000000..35385b5
--- /dev/null
+++ b/recipes-security/cip-cis-rules/files/cip-cis-rules/pam-configs/cis-5.3.2-faillock
@@ -0,0 +1,6 @@
+Name: Enable pam_faillock to deny access
+Default: yes
+Priority: 0
+Auth-Type: Primary
+Auth:
+	[default=die] pam_faillock.so authfail
diff --git a/recipes-security/cip-cis-rules/files/cip-cis-rules/pam-configs/cis-5.3.2-faillock_notify b/recipes-security/cip-cis-rules/files/cip-cis-rules/pam-configs/cis-5.3.2-faillock_notify
new file mode 100644
index 0000000..94ce16a
--- /dev/null
+++ b/recipes-security/cip-cis-rules/files/cip-cis-rules/pam-configs/cis-5.3.2-faillock_notify
@@ -0,0 +1,9 @@
+Name: Notify of failed login attempts and reset count upon success
+Default: yes
+Priority: 1024
+Auth-Type: Primary
+Auth:
+	requisite         pam_faillock.so preauth
+Account-Type: Primary
+Account:
+	required pam_faillock.so
diff --git a/recipes-security/cip-cis-rules/files/cip-cis-rules/pam-configs/cis-5.3.3-pwhistory b/recipes-security/cip-cis-rules/files/cip-cis-rules/pam-configs/cis-5.3.3-pwhistory
new file mode 100644
index 0000000..9f36b6c
--- /dev/null
+++ b/recipes-security/cip-cis-rules/files/cip-cis-rules/pam-configs/cis-5.3.3-pwhistory
@@ -0,0 +1,6 @@
+Name: pwhistory password history checking
+Default: yes
+Priority: 1024
+Password-Type: Primary
+Password:
+	requisite pam_pwhistory.so remember=@@VALUE@@ enforce_for_root try_first_pass use_authtok
diff --git a/recipes-security/cip-cis-rules/files/cip-cis-rules/pam.d/cis-5.3.4-acc-pam-sha512 b/recipes-security/cip-cis-rules/files/cip-cis-rules/pam.d/cis-5.3.4-acc-pam-sha512
new file mode 100644
index 0000000..ac30db2
--- /dev/null
+++ b/recipes-security/cip-cis-rules/files/cip-cis-rules/pam.d/cis-5.3.4-acc-pam-sha512
@@ -0,0 +1,3 @@
+# CIS Rule 5.3.4 - Check that the algorithm declared in PAM for password changes is sha512 (or yescrypt for Debian 11+)
+# Generated from ovh/debian-cis bin/hardening/acc_pam_sha512.sh
+password [success=1 default=ignore] pam_unix.so yescrypt
diff --git a/recipes-security/cip-cis-rules/files/cip-cis-rules/security/limits.d/cis-1.6.4-restrict-core-dumps.conf b/recipes-security/cip-cis-rules/files/cip-cis-rules/security/limits.d/cis-1.6.4-restrict-core-dumps.conf
new file mode 100644
index 0000000..8ab5822
--- /dev/null
+++ b/recipes-security/cip-cis-rules/files/cip-cis-rules/security/limits.d/cis-1.6.4-restrict-core-dumps.conf
@@ -0,0 +1,3 @@
+# CIS Rule 1.6.4 - Restrict core dumps.
+# Generated from ovh/debian-cis bin/hardening/restrict_core_dumps.sh
+* hard core 0
diff --git a/recipes-security/cip-cis-rules/files/cip-cis-rules/security/pwquality.conf.d/cis-5.3.1-enable-pwquality.conf b/recipes-security/cip-cis-rules/files/cip-cis-rules/security/pwquality.conf.d/cis-5.3.1-enable-pwquality.conf
new file mode 100644
index 0000000..3aadc9d
--- /dev/null
+++ b/recipes-security/cip-cis-rules/files/cip-cis-rules/security/pwquality.conf.d/cis-5.3.1-enable-pwquality.conf
@@ -0,0 +1,7 @@
+# CIS Rule 5.3.1 - Set password creation requirement parameters using pam.cracklib.
+# Generated from ovh/debian-cis bin/hardening/enable_pwquality.sh
+minlen = 14
+dcredit = -1
+ucredit = -1
+ocredit = -1
+lcredit = -1
diff --git a/recipes-security/cip-cis-rules/files/cip-cis-rules/sshd_config.d/cis-5.2.10-disable-root-login.conf b/recipes-security/cip-cis-rules/files/cip-cis-rules/sshd_config.d/cis-5.2.10-disable-root-login.conf
new file mode 100644
index 0000000..cb6b031
--- /dev/null
+++ b/recipes-security/cip-cis-rules/files/cip-cis-rules/sshd_config.d/cis-5.2.10-disable-root-login.conf
@@ -0,0 +1,3 @@
+# CIS Rule 5.2.10 - Disable SSH Root Login.
+# Generated from ovh/debian-cis bin/hardening/disable_root_login.sh
+PermitRootLogin no
diff --git a/recipes-security/cip-cis-rules/files/cip-cis-rules/sshd_config.d/cis-5.2.11-disable-sshd-permitemptypasswords.conf b/recipes-security/cip-cis-rules/files/cip-cis-rules/sshd_config.d/cis-5.2.11-disable-sshd-permitemptypasswords.conf
new file mode 100644
index 0000000..fdd08de
--- /dev/null
+++ b/recipes-security/cip-cis-rules/files/cip-cis-rules/sshd_config.d/cis-5.2.11-disable-sshd-permitemptypasswords.conf
@@ -0,0 +1,3 @@
+# CIS Rule 5.2.11 - Set SSH PermitEmptyPasswords to No in order to disallow SSH login to accounts with empty password strings.
+# Generated from ovh/debian-cis bin/hardening/disable_sshd_permitemptypasswords.sh
+PermitEmptyPasswords no
diff --git a/recipes-security/cip-cis-rules/files/cip-cis-rules/sshd_config.d/cis-5.2.12-disable-sshd-setenv.conf b/recipes-security/cip-cis-rules/files/cip-cis-rules/sshd_config.d/cis-5.2.12-disable-sshd-setenv.conf
new file mode 100644
index 0000000..3f3e154
--- /dev/null
+++ b/recipes-security/cip-cis-rules/files/cip-cis-rules/sshd_config.d/cis-5.2.12-disable-sshd-setenv.conf
@@ -0,0 +1,3 @@
+# CIS Rule 5.2.12 - Do not allow users to set environment options.
+# Generated from ovh/debian-cis bin/hardening/disable_sshd_setenv.sh
+PermitUserEnvironment no
diff --git a/recipes-security/cip-cis-rules/files/cip-cis-rules/sshd_config.d/cis-5.2.13-sshd-ciphers.conf b/recipes-security/cip-cis-rules/files/cip-cis-rules/sshd_config.d/cis-5.2.13-sshd-ciphers.conf
new file mode 100644
index 0000000..6144598
--- /dev/null
+++ b/recipes-security/cip-cis-rules/files/cip-cis-rules/sshd_config.d/cis-5.2.13-sshd-ciphers.conf
@@ -0,0 +1,3 @@
+# CIS Rule 5.2.13 - Use only approved ciphers in counter mode (ctr) or Galois counter mode (gcm).
+# Generated from ovh/debian-cis bin/hardening/sshd_ciphers.sh
+Ciphers chacha20-poly1305@openssh.com,aes256-gcm@openssh.com,aes128-gcm@openssh.com,aes256-ctr,aes192-ctr,aes128-ctr
diff --git a/recipes-security/cip-cis-rules/files/cip-cis-rules/sshd_config.d/cis-5.2.14-ssh-cry-mac.conf b/recipes-security/cip-cis-rules/files/cip-cis-rules/sshd_config.d/cis-5.2.14-ssh-cry-mac.conf
new file mode 100644
index 0000000..eac6939
--- /dev/null
+++ b/recipes-security/cip-cis-rules/files/cip-cis-rules/sshd_config.d/cis-5.2.14-ssh-cry-mac.conf
@@ -0,0 +1,3 @@
+# CIS Rule 5.2.14 - Checking Message Authentication Code ciphers for preferred UMAC and SHA-256|512 with Encrypt-Then-Mac (etm) setting.
+# Generated from ovh/debian-cis bin/hardening/ssh_cry_mac.sh
+MACs hmac-sha2-512-etm@openssh.com,hmac-sha2-256-etm@openssh.com,hmac-sha2-512,hmac-sha2-256
diff --git a/recipes-security/cip-cis-rules/files/cip-cis-rules/sshd_config.d/cis-5.2.15-ssh-cry-kex.conf b/recipes-security/cip-cis-rules/files/cip-cis-rules/sshd_config.d/cis-5.2.15-ssh-cry-kex.conf
new file mode 100644
index 0000000..1b8f6a5
--- /dev/null
+++ b/recipes-security/cip-cis-rules/files/cip-cis-rules/sshd_config.d/cis-5.2.15-ssh-cry-kex.conf
@@ -0,0 +1,3 @@
+# CIS Rule 5.2.15 - Checking key exchange ciphers.
+# Generated from ovh/debian-cis bin/hardening/ssh_cry_kex.sh
+KexAlgorithms curve25519-sha256,curve25519-sha256@libssh.org,diffie-hellman-group14-sha256,diffie-hellman-group16-sha512,diffie-hellman-group18-sha512,ecdh-sha2-nistp521,ecdh-sha2-nistp384,ecdh-sha2-nistp256,diffie-hellman-group-exchange-sha256
diff --git a/recipes-security/cip-cis-rules/files/cip-cis-rules/sshd_config.d/cis-5.2.16-sshd-idle-timeout.conf b/recipes-security/cip-cis-rules/files/cip-cis-rules/sshd_config.d/cis-5.2.16-sshd-idle-timeout.conf
new file mode 100644
index 0000000..5039421
--- /dev/null
+++ b/recipes-security/cip-cis-rules/files/cip-cis-rules/sshd_config.d/cis-5.2.16-sshd-idle-timeout.conf
@@ -0,0 +1,4 @@
+# CIS Rule 5.2.16 - Set Idle Timeout Interval for user login.
+# Generated from ovh/debian-cis bin/hardening/sshd_idle_timeout.sh
+ClientAliveInterval 300
+ClientAliveCountMax 0
diff --git a/recipes-security/cip-cis-rules/files/cip-cis-rules/sshd_config.d/cis-5.2.17-sshd-login-grace-time.conf b/recipes-security/cip-cis-rules/files/cip-cis-rules/sshd_config.d/cis-5.2.17-sshd-login-grace-time.conf
new file mode 100644
index 0000000..6bd6404
--- /dev/null
+++ b/recipes-security/cip-cis-rules/files/cip-cis-rules/sshd_config.d/cis-5.2.17-sshd-login-grace-time.conf
@@ -0,0 +1,3 @@
+# CIS Rule 5.2.17 - Set Login Grace Time for user login.
+# Generated from ovh/debian-cis bin/hardening/sshd_login_grace_time.sh
+LoginGraceTime 60
diff --git a/recipes-security/cip-cis-rules/files/cip-cis-rules/sshd_config.d/cis-5.2.18-sshd-limit-access.conf b/recipes-security/cip-cis-rules/files/cip-cis-rules/sshd_config.d/cis-5.2.18-sshd-limit-access.conf
new file mode 100644
index 0000000..129651b
--- /dev/null
+++ b/recipes-security/cip-cis-rules/files/cip-cis-rules/sshd_config.d/cis-5.2.18-sshd-limit-access.conf
@@ -0,0 +1,10 @@
+# CIS Rule 5.2.18 - Limit access via SSH by (dis)allowing specific users or groups.
+# Generated from ovh/debian-cis bin/hardening/sshd_limit_access.sh
+#
+# The group name is set via CIS_5_2_18_GROUPS in Kconfig (default: sshusers).
+# Create the group and add users to it in your image recipe:
+#
+#   groupadd sshusers
+#   usermod -aG sshusers <username>
+#
+AllowGroups @@VALUE@@
diff --git a/recipes-security/cip-cis-rules/files/cip-cis-rules/sshd_config.d/cis-5.2.19-ssh-banner.conf b/recipes-security/cip-cis-rules/files/cip-cis-rules/sshd_config.d/cis-5.2.19-ssh-banner.conf
new file mode 100644
index 0000000..422a04d
--- /dev/null
+++ b/recipes-security/cip-cis-rules/files/cip-cis-rules/sshd_config.d/cis-5.2.19-ssh-banner.conf
@@ -0,0 +1,3 @@
+# CIS Rule 5.2.19 - Set ssh banner.
+# Generated from ovh/debian-cis bin/hardening/ssh_banner.sh
+Banner /etc/issue.net
diff --git a/recipes-security/cip-cis-rules/files/cip-cis-rules/sshd_config.d/cis-5.2.20-enable-ssh-pam.conf b/recipes-security/cip-cis-rules/files/cip-cis-rules/sshd_config.d/cis-5.2.20-enable-ssh-pam.conf
new file mode 100644
index 0000000..f77d12a
--- /dev/null
+++ b/recipes-security/cip-cis-rules/files/cip-cis-rules/sshd_config.d/cis-5.2.20-enable-ssh-pam.conf
@@ -0,0 +1,3 @@
+# CIS Rule 5.2.20 - Enable SSH PAM.
+# Generated from ovh/debian-cis bin/hardening/enable_ssh_pam.sh
+usepam yes
diff --git a/recipes-security/cip-cis-rules/files/cip-cis-rules/sshd_config.d/cis-5.2.21-disable-ssh-allow-tcp-forwarding.conf b/recipes-security/cip-cis-rules/files/cip-cis-rules/sshd_config.d/cis-5.2.21-disable-ssh-allow-tcp-forwarding.conf
new file mode 100644
index 0000000..72bf37f
--- /dev/null
+++ b/recipes-security/cip-cis-rules/files/cip-cis-rules/sshd_config.d/cis-5.2.21-disable-ssh-allow-tcp-forwarding.conf
@@ -0,0 +1,3 @@
+# CIS Rule 5.2.21 - Disable SSH AllowTCPForwarding.
+# Generated from ovh/debian-cis bin/hardening/disable_ssh_allow_tcp_forwarding.sh
+AllowTCPForwarding no
diff --git a/recipes-security/cip-cis-rules/files/cip-cis-rules/sshd_config.d/cis-5.2.22-configure-ssh-max-startups.conf b/recipes-security/cip-cis-rules/files/cip-cis-rules/sshd_config.d/cis-5.2.22-configure-ssh-max-startups.conf
new file mode 100644
index 0000000..488de29
--- /dev/null
+++ b/recipes-security/cip-cis-rules/files/cip-cis-rules/sshd_config.d/cis-5.2.22-configure-ssh-max-startups.conf
@@ -0,0 +1,3 @@
+# CIS Rule 5.2.22 - Configure SSHMaxStartups.
+# Generated from ovh/debian-cis bin/hardening/configure_ssh_max_startups.sh
+maxstartups 10:30:60
diff --git a/recipes-security/cip-cis-rules/files/cip-cis-rules/sshd_config.d/cis-5.2.23-limit-ssh-max-sessions.conf b/recipes-security/cip-cis-rules/files/cip-cis-rules/sshd_config.d/cis-5.2.23-limit-ssh-max-sessions.conf
new file mode 100644
index 0000000..b3d04ce
--- /dev/null
+++ b/recipes-security/cip-cis-rules/files/cip-cis-rules/sshd_config.d/cis-5.2.23-limit-ssh-max-sessions.conf
@@ -0,0 +1,3 @@
+# CIS Rule 5.2.23 - Limit SSH MaxSessions.
+# Generated from ovh/debian-cis bin/hardening/limit_ssh_max_sessions.sh
+maxsessions 10
diff --git a/recipes-security/cip-cis-rules/files/cip-cis-rules/sshd_config.d/cis-5.2.4-sshd-protocol.conf b/recipes-security/cip-cis-rules/files/cip-cis-rules/sshd_config.d/cis-5.2.4-sshd-protocol.conf
new file mode 100644
index 0000000..38709b9
--- /dev/null
+++ b/recipes-security/cip-cis-rules/files/cip-cis-rules/sshd_config.d/cis-5.2.4-sshd-protocol.conf
@@ -0,0 +1,3 @@
+# CIS Rule 5.2.4 - Set secure shell (SSH) protocol to 2.
+# Generated from ovh/debian-cis bin/hardening/sshd_protocol.sh
+Protocol 2
diff --git a/recipes-security/cip-cis-rules/files/cip-cis-rules/sshd_config.d/cis-5.2.5-sshd-loglevel.conf b/recipes-security/cip-cis-rules/files/cip-cis-rules/sshd_config.d/cis-5.2.5-sshd-loglevel.conf
new file mode 100644
index 0000000..75e5cfb
--- /dev/null
+++ b/recipes-security/cip-cis-rules/files/cip-cis-rules/sshd_config.d/cis-5.2.5-sshd-loglevel.conf
@@ -0,0 +1,3 @@
+# CIS Rule 5.2.5 - Set LogLevel to VERBOSE for SSH.
+# Generated from ovh/debian-cis bin/hardening/sshd_loglevel.sh
+LogLevel VERBOSE
diff --git a/recipes-security/cip-cis-rules/files/cip-cis-rules/sshd_config.d/cis-5.2.6-disable-x11-forwarding.conf b/recipes-security/cip-cis-rules/files/cip-cis-rules/sshd_config.d/cis-5.2.6-disable-x11-forwarding.conf
new file mode 100644
index 0000000..86f6161
--- /dev/null
+++ b/recipes-security/cip-cis-rules/files/cip-cis-rules/sshd_config.d/cis-5.2.6-disable-x11-forwarding.conf
@@ -0,0 +1,3 @@
+# CIS Rule 5.2.6 - Disable SSH X11 forwarding.
+# Generated from ovh/debian-cis bin/hardening/disable_x11_forwarding.sh
+X11Forwarding no
diff --git a/recipes-security/cip-cis-rules/files/cip-cis-rules/sshd_config.d/cis-5.2.7-sshd-maxauthtries.conf b/recipes-security/cip-cis-rules/files/cip-cis-rules/sshd_config.d/cis-5.2.7-sshd-maxauthtries.conf
new file mode 100644
index 0000000..c347cc6
--- /dev/null
+++ b/recipes-security/cip-cis-rules/files/cip-cis-rules/sshd_config.d/cis-5.2.7-sshd-maxauthtries.conf
@@ -0,0 +1,3 @@
+# CIS Rule 5.2.7 - Set SSH MaxAuthTries to 4.
+# Generated from ovh/debian-cis bin/hardening/sshd_maxauthtries.sh
+MaxAuthTries 4
diff --git a/recipes-security/cip-cis-rules/files/cip-cis-rules/sshd_config.d/cis-5.2.8-enable-sshd-ignorerhosts.conf b/recipes-security/cip-cis-rules/files/cip-cis-rules/sshd_config.d/cis-5.2.8-enable-sshd-ignorerhosts.conf
new file mode 100644
index 0000000..79971d7
--- /dev/null
+++ b/recipes-security/cip-cis-rules/files/cip-cis-rules/sshd_config.d/cis-5.2.8-enable-sshd-ignorerhosts.conf
@@ -0,0 +1,3 @@
+# CIS Rule 5.2.8 - Set SSH IgnoreRhosts to Yes.
+# Generated from ovh/debian-cis bin/hardening/enable_sshd_ignorerhosts.sh
+IgnoreRhosts yes
diff --git a/recipes-security/cip-cis-rules/files/cip-cis-rules/sshd_config.d/cis-5.2.9-disable-sshd-hostbasedauthentication.conf b/recipes-security/cip-cis-rules/files/cip-cis-rules/sshd_config.d/cis-5.2.9-disable-sshd-hostbasedauthentication.conf
new file mode 100644
index 0000000..d10a05b
--- /dev/null
+++ b/recipes-security/cip-cis-rules/files/cip-cis-rules/sshd_config.d/cis-5.2.9-disable-sshd-hostbasedauthentication.conf
@@ -0,0 +1,3 @@
+# CIS Rule 5.2.9 - Set SSH HostbasedAuthentication to No.
+# Generated from ovh/debian-cis bin/hardening/disable_sshd_hostbasedauthentication.sh
+HostbasedAuthentication no
diff --git a/recipes-security/cip-cis-rules/files/cip-cis-rules/sudoers.d/cis-1.3.2-pty-sudo b/recipes-security/cip-cis-rules/files/cip-cis-rules/sudoers.d/cis-1.3.2-pty-sudo
new file mode 100644
index 0000000..f8e3300
--- /dev/null
+++ b/recipes-security/cip-cis-rules/files/cip-cis-rules/sudoers.d/cis-1.3.2-pty-sudo
@@ -0,0 +1,3 @@
+# CIS Rule 1.3.2 - Ensure sudo can only be run from a pseudo pty.
+# Generated from ovh/debian-cis bin/hardening/pty_sudo.sh
+Defaults use_pty
diff --git a/recipes-security/cip-cis-rules/files/cip-cis-rules/sudoers.d/cis-1.3.3-logfile-sudo b/recipes-security/cip-cis-rules/files/cip-cis-rules/sudoers.d/cis-1.3.3-logfile-sudo
new file mode 100644
index 0000000..0e3cb4e
--- /dev/null
+++ b/recipes-security/cip-cis-rules/files/cip-cis-rules/sudoers.d/cis-1.3.3-logfile-sudo
@@ -0,0 +1,3 @@
+# CIS Rule 1.3.3 - Ensure sudo log files exists.
+# Generated from ovh/debian-cis bin/hardening/logfile_sudo.sh
+Defaults logfile="/var/log/sudo.log"
diff --git a/recipes-security/cip-cis-rules/files/cip-cis-rules/sysctl.d/cis-1.6.2-enable-randomized-vm-placement.conf b/recipes-security/cip-cis-rules/files/cip-cis-rules/sysctl.d/cis-1.6.2-enable-randomized-vm-placement.conf
new file mode 100644
index 0000000..4b50c7e
--- /dev/null
+++ b/recipes-security/cip-cis-rules/files/cip-cis-rules/sysctl.d/cis-1.6.2-enable-randomized-vm-placement.conf
@@ -0,0 +1,3 @@
+# CIS Rule 1.6.2 - Enable Randomized Virtual Memory Region Placement to prevent memory page exploits.
+# Generated from ovh/debian-cis bin/hardening/enable_randomized_vm_placement.sh
+kernel.randomize_va_space = 2
diff --git a/recipes-security/cip-cis-rules/files/cip-cis-rules/sysctl.d/cis-1.6.4-suid-dumpable.conf b/recipes-security/cip-cis-rules/files/cip-cis-rules/sysctl.d/cis-1.6.4-suid-dumpable.conf
new file mode 100644
index 0000000..985658a
--- /dev/null
+++ b/recipes-security/cip-cis-rules/files/cip-cis-rules/sysctl.d/cis-1.6.4-suid-dumpable.conf
@@ -0,0 +1,3 @@
+# CIS Rule 1.6.4 - Restrict core dumps
+# Generated from ovh/debian-cis bin/hardening/restrict_core_dumps.sh
+fs.suid_dumpable = 0
diff --git a/recipes-security/cip-cis-rules/files/cip-cis-rules/sysctl.d/cis-3.1.1-disable-ipv6.conf b/recipes-security/cip-cis-rules/files/cip-cis-rules/sysctl.d/cis-3.1.1-disable-ipv6.conf
new file mode 100644
index 0000000..01ac99b
--- /dev/null
+++ b/recipes-security/cip-cis-rules/files/cip-cis-rules/sysctl.d/cis-3.1.1-disable-ipv6.conf
@@ -0,0 +1,5 @@
+# CIS Rule 3.1.1 - Disable IPv6.
+# Generated from ovh/debian-cis bin/hardening/disable_ipv6.sh
+net.ipv6.conf.all.disable_ipv6 = 1
+net.ipv6.conf.default.disable_ipv6 = 1
+net.ipv6.conf.lo.disable_ipv6 = 1
diff --git a/recipes-security/cip-cis-rules/files/cip-cis-rules/sysctl.d/cis-3.2.1-disable-send-packet-redirects.conf b/recipes-security/cip-cis-rules/files/cip-cis-rules/sysctl.d/cis-3.2.1-disable-send-packet-redirects.conf
new file mode 100644
index 0000000..63926dc
--- /dev/null
+++ b/recipes-security/cip-cis-rules/files/cip-cis-rules/sysctl.d/cis-3.2.1-disable-send-packet-redirects.conf
@@ -0,0 +1,4 @@
+# CIS Rule 3.2.1 - Disable send packet redirects to prevent malicious ICMP corruption.
+# Generated from ovh/debian-cis bin/hardening/disable_send_packet_redirects.sh
+net.ipv4.conf.all.send_redirects = 0
+net.ipv4.conf.default.send_redirects = 0
diff --git a/recipes-security/cip-cis-rules/files/cip-cis-rules/sysctl.d/cis-3.2.2-disable-ip-forwarding.conf b/recipes-security/cip-cis-rules/files/cip-cis-rules/sysctl.d/cis-3.2.2-disable-ip-forwarding.conf
new file mode 100644
index 0000000..c998e16
--- /dev/null
+++ b/recipes-security/cip-cis-rules/files/cip-cis-rules/sysctl.d/cis-3.2.2-disable-ip-forwarding.conf
@@ -0,0 +1,4 @@
+# CIS Rule 3.2.2 - Disable IP forwarding.
+# Generated from ovh/debian-cis bin/hardening/disable_ip_forwarding.sh
+net.ipv4.ip_forward = 0
+net.ipv6.conf.all.forwarding = 0
diff --git a/recipes-security/cip-cis-rules/files/cip-cis-rules/sysctl.d/cis-3.3.1-disable-source-routed-packets.conf b/recipes-security/cip-cis-rules/files/cip-cis-rules/sysctl.d/cis-3.3.1-disable-source-routed-packets.conf
new file mode 100644
index 0000000..4a31e5d
--- /dev/null
+++ b/recipes-security/cip-cis-rules/files/cip-cis-rules/sysctl.d/cis-3.3.1-disable-source-routed-packets.conf
@@ -0,0 +1,6 @@
+# CIS Rule 3.3.1 - Disable source routed packet acceptance.
+# Generated from ovh/debian-cis bin/hardening/disable_source_routed_packets.sh
+net.ipv4.conf.all.accept_source_route = 0
+net.ipv4.conf.default.accept_source_route = 0
+net.ipv6.conf.all.accept_source_route = 0
+net.ipv6.conf.default.accept_source_route = 0
diff --git a/recipes-security/cip-cis-rules/files/cip-cis-rules/sysctl.d/cis-3.3.2-disable-icmp-redirect.conf b/recipes-security/cip-cis-rules/files/cip-cis-rules/sysctl.d/cis-3.3.2-disable-icmp-redirect.conf
new file mode 100644
index 0000000..9ff0384
--- /dev/null
+++ b/recipes-security/cip-cis-rules/files/cip-cis-rules/sysctl.d/cis-3.3.2-disable-icmp-redirect.conf
@@ -0,0 +1,6 @@
+# CIS Rule 3.3.2 - Disable ICMP redirect acceptance to prevent routing table corruption.
+# Generated from ovh/debian-cis bin/hardening/disable_icmp_redirect.sh
+net.ipv4.conf.all.accept_redirects = 0
+net.ipv4.conf.default.accept_redirects = 0
+net.ipv6.conf.all.accept_redirects = 0
+net.ipv6.conf.default.accept_redirects = 0
diff --git a/recipes-security/cip-cis-rules/files/cip-cis-rules/sysctl.d/cis-3.3.3-disable-secure-icmp-redirect.conf b/recipes-security/cip-cis-rules/files/cip-cis-rules/sysctl.d/cis-3.3.3-disable-secure-icmp-redirect.conf
new file mode 100644
index 0000000..ce56d4b
--- /dev/null
+++ b/recipes-security/cip-cis-rules/files/cip-cis-rules/sysctl.d/cis-3.3.3-disable-secure-icmp-redirect.conf
@@ -0,0 +1,4 @@
+# CIS Rule 3.3.3 - Disable secure ICMP redirect acceptance to prevent routing tables corruptions.
+# Generated from ovh/debian-cis bin/hardening/disable_secure_icmp_redirect.sh
+net.ipv4.conf.all.secure_redirects = 0
+net.ipv4.conf.default.secure_redirects = 0
diff --git a/recipes-security/cip-cis-rules/files/cip-cis-rules/sysctl.d/cis-3.3.4-log-martian-packets.conf b/recipes-security/cip-cis-rules/files/cip-cis-rules/sysctl.d/cis-3.3.4-log-martian-packets.conf
new file mode 100644
index 0000000..c13115e
--- /dev/null
+++ b/recipes-security/cip-cis-rules/files/cip-cis-rules/sysctl.d/cis-3.3.4-log-martian-packets.conf
@@ -0,0 +1,4 @@
+# CIS Rule 3.3.4 - Log suspicious packets, like spoofed packets.
+# Generated from ovh/debian-cis bin/hardening/log_martian_packets.sh
+net.ipv4.conf.all.log_martians = 1
+net.ipv4.conf.default.log_martians = 1
diff --git a/recipes-security/cip-cis-rules/files/cip-cis-rules/sysctl.d/cis-3.3.5-ignore-broadcast-requests.conf b/recipes-security/cip-cis-rules/files/cip-cis-rules/sysctl.d/cis-3.3.5-ignore-broadcast-requests.conf
new file mode 100644
index 0000000..7ded5d3
--- /dev/null
+++ b/recipes-security/cip-cis-rules/files/cip-cis-rules/sysctl.d/cis-3.3.5-ignore-broadcast-requests.conf
@@ -0,0 +1,3 @@
+# CIS Rule 3.3.5 - Ignore broadcast requests to prevent attacks such as Smurf attack.
+# Generated from ovh/debian-cis bin/hardening/ignore_broadcast_requests.sh
+net.ipv4.icmp_echo_ignore_broadcasts = 1
diff --git a/recipes-security/cip-cis-rules/files/cip-cis-rules/sysctl.d/cis-3.3.6-enable-bad-error-message-protection.conf b/recipes-security/cip-cis-rules/files/cip-cis-rules/sysctl.d/cis-3.3.6-enable-bad-error-message-protection.conf
new file mode 100644
index 0000000..322eac7
--- /dev/null
+++ b/recipes-security/cip-cis-rules/files/cip-cis-rules/sysctl.d/cis-3.3.6-enable-bad-error-message-protection.conf
@@ -0,0 +1,3 @@
+# CIS Rule 3.3.6 - Enable bad error message protection to prevent logfiles fillup.
+# Generated from ovh/debian-cis bin/hardening/enable_bad_error_message_protection.sh
+net.ipv4.icmp_ignore_bogus_error_responses = 1
diff --git a/recipes-security/cip-cis-rules/files/cip-cis-rules/sysctl.d/cis-3.3.7-enable-source-route-validation.conf b/recipes-security/cip-cis-rules/files/cip-cis-rules/sysctl.d/cis-3.3.7-enable-source-route-validation.conf
new file mode 100644
index 0000000..bba434a
--- /dev/null
+++ b/recipes-security/cip-cis-rules/files/cip-cis-rules/sysctl.d/cis-3.3.7-enable-source-route-validation.conf
@@ -0,0 +1,4 @@
+# CIS Rule 3.3.7 - Enable RFC-recommended source route validation.
+# Generated from ovh/debian-cis bin/hardening/enable_source_route_validation.sh
+net.ipv4.conf.all.rp_filter = 1
+net.ipv4.conf.default.rp_filter = 1
diff --git a/recipes-security/cip-cis-rules/files/cip-cis-rules/sysctl.d/cis-3.3.8-enable-tcp-syn-cookies.conf b/recipes-security/cip-cis-rules/files/cip-cis-rules/sysctl.d/cis-3.3.8-enable-tcp-syn-cookies.conf
new file mode 100644
index 0000000..126404d
--- /dev/null
+++ b/recipes-security/cip-cis-rules/files/cip-cis-rules/sysctl.d/cis-3.3.8-enable-tcp-syn-cookies.conf
@@ -0,0 +1,3 @@
+# CIS Rule 3.3.8 - Enable TCP-SYN cookie to prevent TCP-SYN flood attack.
+# Generated from ovh/debian-cis bin/hardening/enable_tcp_syn_cookies.sh
+net.ipv4.tcp_syncookies = 1
diff --git a/recipes-security/cip-cis-rules/files/cip-cis-rules/sysctl.d/cis-3.3.9-disable-ipv6-router-advertisement.conf b/recipes-security/cip-cis-rules/files/cip-cis-rules/sysctl.d/cis-3.3.9-disable-ipv6-router-advertisement.conf
new file mode 100644
index 0000000..a8e0a4f
--- /dev/null
+++ b/recipes-security/cip-cis-rules/files/cip-cis-rules/sysctl.d/cis-3.3.9-disable-ipv6-router-advertisement.conf
@@ -0,0 +1,4 @@
+# CIS Rule 3.3.9 - Disable IPv6 router advertisements.
+# Generated from ovh/debian-cis bin/hardening/disable_ipv6_router_advertisement.sh
+net.ipv6.conf.all.accept_ra = 0
+net.ipv6.conf.default.accept_ra = 0
-- 
2.53.0


