Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BEDAC5321B
	for <webhook@archiver.kernel.org>; Fri, 24 Jul 2026 12:40:50 +0000 (UTC)
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.18262.1784896843226347003
 for <cip-dev@lists.cip-project.org>;
 Fri, 24 Jul 2026 05:40:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=QggYqf0Y;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.228, mailfrom: fm-51332-2026072412403901231719db000207f7-ymsvue@rts-flowmailer.siemens.com)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 2026072412403901231719db000207f7
        for <cip-dev@lists.cip-project.org>;
        Fri, 24 Jul 2026 14:40:40 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=2L0mEIsNHB5rOBqSZt0rMwdMIIpsDWVur4gMuFI4+4E=;
 b=QggYqf0YaxKjSOGQYb5Dvxq6sgAXFfjLfaLG6lryLrS8wO+cNoOxXi29hEikkpQzRdUfj8
 6pvvlRbDR+NtCePK2Bbhs6Ua3HX3Xzm2OLl3uPekNrBkKMYT9/gZYYnYRFG0zjOURp2cu+i8
 panWgjC7NHdUWARlYKDsVyxr+OYYfAvuhUpmxYfG8db57qJJuZVfxKzGG/zci5r0hXtoc56r
 tzWtZ+0nQ1ifkXu4JBfl2jR4LBQSfyfzI6hgle2/1zRDl4V4ZKXZkN1ciPVzI7nzSwSm+u2R
 ikaeTHPvfQnrYmEcXprHhsV2lZPO/bMM7AtWD0XQJom7jVS//X+KMVLA==;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com,
	felix.moessbauer@siemens.com,
	christoph.steiger@siemens.com,
	clara.kowalsky@siemens.com
Subject: [RFC cip-dev][isar-cip-core][PATCH 00/14] Add recipes for image hardening
Date: Fri, 24 Jul 2026 14:39:02 +0200
Message-ID: <20260724124038.3633611-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 24 Jul 2026 12:40:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23741

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This patch series adds the option to harden the build image according to the guidelines published by CIS.
The patch introduces the following packages:

cip-cis-rules-config: user-facing configuration, stored in .config.json and configurable interactively via Kconfig.
cip-cis-rules: uses the configuration from cip-cis-rules-config to generate a custom Debian package containing the necessary hardening configuration.
cip-cis-validation: an optional package to validate the hardening rules.

Additionally, the kernel configuration is checked against the hardening rules.
This patch set is currently developed and tested for hardening level 2.

Co-Authored-by: Clara Kowalsky <clara.kowalsky@siemens.com>
Co-Authored-by: Felix Moessbauer <felix.moessbauer@siemens.com>
Co-Authored-by: Christoph Steiger <christoph.steiger@siemens.com>

Clara Kowalsky (2):
  Add cip-cis-validation to validate the hardening based on the CIS
    rules
  Add kas file for hardening configuration

Quirin Gylstorff (12):
  isar: Update for sstate fixes
  Add cip-cis-rules-config to configure the hardening according to CIS
  Add cip-cis-rules to apply hardening configuration to the system
  Add github.com/ovh/debian-cis for the hardening validation
  Apply hardening configuration to the kernel
  Add kernel hardening to cip kernel build
  Add class for validating the CIS options in the kernel config
  Add class cis-hardening for post rootfs generation fixups
  Integrate cis-hardening into cip-core-image
  layer.conf: use variables to control path of hardening config
  Add Kconfig option to select cis-validation
  Add doc/README.cis-hardening.md

 Kconfig                                       |   10 +
 README.md                                     |    1 +
 classes-recipe/cis-hardening.bbclass          |   31 +
 .../cis-kernel-hardening-validation.bbclass   |  110 +
 conf/layer.conf                               |    3 +
 doc/README.cis-hardening.md                   |  183 ++
 kas-cip.yml                                   |    2 +-
 kas/opt/cis-validation.yml                    |   19 +
 recipes-core/images/cip-core-image.inc        |    4 +
 recipes-kernel/linux/kernel-hardening.inc     |   16 +
 recipes-kernel/linux/linux-cip-common.inc     |    1 +
 .../cip-cis-rules-config.bb                   |   65 +
 .../cip-cis-rules-config/files/.config.json   | 1759 ++++++++++
 .../cip-cis-rules-config/files/Kconfig        | 2831 +++++++++++++++++
 .../files/scripts/config.schema.json          |  124 +
 .../files/scripts/gen-kernel-config.py        |  164 +
 .../files/scripts/select-hardenings.py        |  618 ++++
 .../cip-cis-rules/cip-cis-rules_1.0.0.bb      |   19 +
 .../conf.d/cis-2.2.1.3-chrony-ntp-server.conf |    4 +
 .../cis-5.2.10-disable-root-login.cfg         |    2 +
 ...2.11-disable-sshd-permitemptypasswords.cfg |    2 +
 .../cis-5.2.12-disable-sshd-setenv.cfg        |    2 +
 .../cis-5.2.13-sshd-ciphers.cfg               |    2 +
 .../cis-5.2.14-ssh-cry-mac.cfg                |    2 +
 .../cis-5.2.15-ssh-cry-kex.cfg                |    2 +
 .../cis-5.2.16-sshd-idle-timeout.cfg          |    2 +
 .../cis-5.2.17-sshd-login-grace-time.cfg      |    2 +
 .../cis-5.2.18-sshd-limit-access.cfg          |    2 +
 .../cis-5.2.19-ssh-banner.cfg                 |    2 +
 .../cis-5.2.20-enable-ssh-pam.cfg             |    2 +
 ....2.21-disable-ssh-allow-tcp-forwarding.cfg |    2 +
 .../cis-5.2.22-configure-ssh-max-startups.cfg |    2 +
 .../cis-5.2.23-limit-ssh-max-sessions.cfg     |    2 +
 .../cis-5.2.4-sshd-protocol.cfg               |    2 +
 .../cis-5.2.5-sshd-loglevel.cfg               |    2 +
 .../cis-5.2.6-disable-x11-forwarding.cfg      |    2 +
 .../cis-5.2.7-sshd-maxauthtries.cfg           |    2 +
 .../cis-5.2.8-enable-sshd-ignorerhosts.cfg    |    2 +
 ...9-disable-sshd-hostbasedauthentication.cfg |    2 +
 .../cis-5.3.1-enable-pwquality.cfg            |    2 +
 .../cip-cis-rules/configuration/cis-1.1.21.sh |    6 +
 .../cip-cis-rules/configuration/cis-1.5.1.sh  |    8 +
 .../configuration/cis-1.8.1.1.sh              |    7 +
 .../configuration/cis-1.8.1.2.sh              |    7 +
 .../configuration/cis-1.8.1.3.sh              |    7 +
 .../configuration/cis-1.8.1.4.sh              |    8 +
 .../configuration/cis-1.8.1.5.sh              |    8 +
 .../configuration/cis-1.8.1.6.sh              |    8 +
 .../configuration/cis-2.2.1.2.sh              |    9 +
 .../cip-cis-rules/configuration/cis-4.2.3.sh  |    6 +
 .../cip-cis-rules/configuration/cis-4.4.sh    |    9 +
 .../cip-cis-rules/configuration/cis-5.1.2.sh  |    8 +
 .../cip-cis-rules/configuration/cis-5.1.3.sh  |    8 +
 .../cip-cis-rules/configuration/cis-5.1.4.sh  |    8 +
 .../cip-cis-rules/configuration/cis-5.1.5.sh  |    8 +
 .../cip-cis-rules/configuration/cis-5.1.6.sh  |    8 +
 .../cip-cis-rules/configuration/cis-5.1.7.sh  |    8 +
 .../cip-cis-rules/configuration/cis-5.2.1.sh  |    8 +
 .../cip-cis-rules/configuration/cis-5.2.2.sh  |    6 +
 .../cip-cis-rules/configuration/cis-5.2.3.sh  |    6 +
 .../cip-cis-rules/configuration/cis-5.3.2.sh  |   10 +
 .../cip-cis-rules/configuration/cis-5.3.3.sh  |    7 +
 .../configuration/cis-5.4.1.1.sh              |   23 +
 .../configuration/cis-5.4.1.2.sh              |   17 +
 .../configuration/cis-5.4.1.3.sh              |   17 +
 .../cip-cis-rules/configuration/cis-5.5.sh    |   19 +
 .../cip-cis-rules/configuration/cis-5.6.sh    |    9 +
 .../debian/cip-cis-rules.postinst             |   30 +
 .../files/cip-cis-rules/debian/control        |   31 +
 .../files/cip-cis-rules/debian/rules          |   20 +
 .../debian/scripts/package-enable-configs.py  |  332 ++
 .../debian/scripts/rule-packages.json         |   61 +
 .../cis-1.1.1.1-disable-freevxfs.conf         |    3 +
 .../modprobe.d/cis-1.1.1.2-disable-jffs2.conf |    3 +
 .../modprobe.d/cis-1.1.1.3-disable-hfs.conf   |    3 +
 .../cis-1.1.1.4-disable-hfsplus.conf          |    3 +
 .../cis-1.1.1.5-disable-squashfs.conf         |    3 +
 .../modprobe.d/cis-1.1.1.6-disable-udf.conf   |    3 +
 .../modprobe.d/cis-1.1.1.7-restrict-fat.conf  |    5 +
 .../cis-1.1.1.8-disable-cramfs.conf           |    3 +
 .../cis-1.1.23-disable-usb-storage.conf       |    3 +
 .../pam-configs/cis-5.3.2-faillock            |    6 +
 .../pam-configs/cis-5.3.2-faillock_notify     |    9 +
 .../pam-configs/cis-5.3.3-pwhistory           |    6 +
 .../pam.d/cis-5.3.4-acc-pam-sha512            |    3 +
 .../cis-1.6.4-restrict-core-dumps.conf        |    3 +
 .../cis-5.3.1-enable-pwquality.conf           |    7 +
 .../cis-5.2.10-disable-root-login.conf        |    3 +
 ....11-disable-sshd-permitemptypasswords.conf |    3 +
 .../cis-5.2.12-disable-sshd-setenv.conf       |    3 +
 .../cis-5.2.13-sshd-ciphers.conf              |    3 +
 .../sshd_config.d/cis-5.2.14-ssh-cry-mac.conf |    3 +
 .../sshd_config.d/cis-5.2.15-ssh-cry-kex.conf |    3 +
 .../cis-5.2.16-sshd-idle-timeout.conf         |    4 +
 .../cis-5.2.17-sshd-login-grace-time.conf     |    3 +
 .../cis-5.2.18-sshd-limit-access.conf         |   10 +
 .../sshd_config.d/cis-5.2.19-ssh-banner.conf  |    3 +
 .../cis-5.2.20-enable-ssh-pam.conf            |    3 +
 ...2.21-disable-ssh-allow-tcp-forwarding.conf |    3 +
 ...cis-5.2.22-configure-ssh-max-startups.conf |    3 +
 .../cis-5.2.23-limit-ssh-max-sessions.conf    |    3 +
 .../cis-5.2.4-sshd-protocol.conf              |    3 +
 .../cis-5.2.5-sshd-loglevel.conf              |    3 +
 .../cis-5.2.6-disable-x11-forwarding.conf     |    3 +
 .../cis-5.2.7-sshd-maxauthtries.conf          |    3 +
 .../cis-5.2.8-enable-sshd-ignorerhosts.conf   |    3 +
 ...-disable-sshd-hostbasedauthentication.conf |    3 +
 .../sudoers.d/cis-1.3.2-pty-sudo              |    3 +
 .../sudoers.d/cis-1.3.3-logfile-sudo          |    3 +
 ...-1.6.2-enable-randomized-vm-placement.conf |    3 +
 .../sysctl.d/cis-1.6.4-suid-dumpable.conf     |    3 +
 .../sysctl.d/cis-3.1.1-disable-ipv6.conf      |    5 +
 ...s-3.2.1-disable-send-packet-redirects.conf |    4 +
 .../cis-3.2.2-disable-ip-forwarding.conf      |    4 +
 ...s-3.3.1-disable-source-routed-packets.conf |    6 +
 .../cis-3.3.2-disable-icmp-redirect.conf      |    6 +
 ...is-3.3.3-disable-secure-icmp-redirect.conf |    4 +
 .../cis-3.3.4-log-martian-packets.conf        |    4 +
 .../cis-3.3.5-ignore-broadcast-requests.conf  |    3 +
 ...6-enable-bad-error-message-protection.conf |    3 +
 ...-3.3.7-enable-source-route-validation.conf |    4 +
 .../cis-3.3.8-enable-tcp-syn-cookies.conf     |    3 +
 ...3.9-disable-ipv6-router-advertisement.conf |    4 +
 .../cip-cis-validation_1.0.bb                 |   44 +
 .../files/cip-cis-validation.service          |   11 +
 .../files/cip-cis-validation.target           |    8 +
 .../files/cip-cis-validation.timer            |    9 +
 .../files/cip-cis-validation.tmpl             |   63 +
 .../files/generate-overrides.py               |  100 +
 .../cip-cis-validation/files/postinst         |   46 +
 .../cis-hardening/cis-hardening_4.1-6.bb      |    6 +
 .../cis-hardening/cis-hardening-to-kconfig.py |  348 ++
 132 files changed, 7560 insertions(+), 1 deletion(-)
 create mode 100644 classes-recipe/cis-hardening.bbclass
 create mode 100644 classes-recipe/cis-kernel-hardening-validation.bbclass
 create mode 100644 doc/README.cis-hardening.md
 create mode 100644 kas/opt/cis-validation.yml
 create mode 100644 recipes-kernel/linux/kernel-hardening.inc
 create mode 100644 recipes-security/cip-cis-rules-config/cip-cis-rules-config.bb
 create mode 100644 recipes-security/cip-cis-rules-config/files/.config.json
 create mode 100644 recipes-security/cip-cis-rules-config/files/Kconfig
 create mode 100644 recipes-security/cip-cis-rules-config/files/scripts/config.schema.json
 create mode 100755 recipes-security/cip-cis-rules-config/files/scripts/gen-kernel-config.py
 create mode 100755 recipes-security/cip-cis-rules-config/files/scripts/select-hardenings.py
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
 create mode 100644 recipes-security/cip-cis-validation/cip-cis-validation_1.0.bb
 create mode 100644 recipes-security/cip-cis-validation/files/cip-cis-validation.service
 create mode 100644 recipes-security/cip-cis-validation/files/cip-cis-validation.target
 create mode 100644 recipes-security/cip-cis-validation/files/cip-cis-validation.timer
 create mode 100644 recipes-security/cip-cis-validation/files/cip-cis-validation.tmpl
 create mode 100755 recipes-security/cip-cis-validation/files/generate-overrides.py
 create mode 100644 recipes-security/cip-cis-validation/files/postinst
 create mode 100644 recipes-security/cis-hardening/cis-hardening_4.1-6.bb
 create mode 100755 scripts/cis-hardening/cis-hardening-to-kconfig.py

-- 
2.53.0


