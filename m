Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 764D1C531F9
	for <webhook@archiver.kernel.org>; Fri, 24 Jul 2026 12:40:49 +0000 (UTC)
Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.18374.1784896843302050819
 for <cip-dev@lists.cip-project.org>;
 Fri, 24 Jul 2026 05:40:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=ZlTtA4l4;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.225, mailfrom: fm-51332-202607241240402ee43f5303000207c8-4p3cch@rts-flowmailer.siemens.com)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 202607241240402ee43f5303000207c8
        for <cip-dev@lists.cip-project.org>;
        Fri, 24 Jul 2026 14:40:41 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=bgr7xMs0iLd93R2Nm/6snOyAHkKmGkOCMsfUYKaCwUA=;
 b=ZlTtA4l4OiHOeGto/mRzXMxToU/vBIQ/ec96OWHC539g6zhhMDKzirw5LKHj1b2aq8BJvs
 8uImH+LsnNZ/1avW8xLT0z8Sb7/j6RBM4yJWFPXRINYh9PyPUEXThZj7QLGuuzGx6XAz9DKn
 Yl0QPXZ2TI1+WUTudBjPt/dQMc1fbJviMPu3HxTKLy7fDDewRaleCrYkNRvTFOeF0rQVmCTx
 Gof6DsuRB/k0qcVXtR6nj674GUINnBMr6vFfwUYJiFs4LGifcSJQTRlaLekT4z8W3ohVTMkx
 EHtM3IsqXr90wK5OWLonvGI765sxb0inBmCBT/+P8xD4fIBHFU0JBd2A==;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com,
	felix.moessbauer@siemens.com,
	christoph.steiger@siemens.com,
	clara.kowalsky@siemens.com
Subject: [RFC cip-dev][isar-cip-core][PATCH 02/14] Add cip-cis-rules-config to configure the hardening according to CIS
Date: Fri, 24 Jul 2026 14:39:04 +0200
Message-ID: <20260724124038.3633611-3-Quirin.Gylstorff@siemens.com>
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
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23738

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

The `cip-cis-rules-config` recipe allows to create a use-case specific
hardening configuration based on the CIS hardening rules.

To tailor a hardening config the command `bitbake -c menuconfig cip-cis-rules`
can be used to generate the hardening config interactively.

After the package build the generated config can be found at
`${DEPLOYDIR_HARDENING}/${CIP_CIS_HARDENING_CONFIG}`.

The package also provides a kernel config snippet
`${DEPLOYDIR_HARDENING}/${CIP_CIS_HARDENING_KCONFIG}`, which can be used
to apply kernel hardening during compile instead of a runtime
configuration.

Co-Authored-by: Clara Kowalsky <clara.kowalsky@siemens.com>
Co-Authored-by: Felix Moessbauer <felix.moessbauer@siemens.com>
Co-Authored-by: Christoph Steiger <christoph.steiger@siemens.com>
Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 .../cip-cis-rules-config.bb                   |   65 +
 .../cip-cis-rules-config/files/.config.json   | 1759 ++++++++++
 .../cip-cis-rules-config/files/Kconfig        | 2831 +++++++++++++++++
 .../files/scripts/config.schema.json          |  124 +
 .../files/scripts/gen-kernel-config.py        |  164 +
 .../files/scripts/select-hardenings.py        |  618 ++++
 .../cis-hardening/cis-hardening-to-kconfig.py |  348 ++
 7 files changed, 5909 insertions(+)
 create mode 100644 recipes-security/cip-cis-rules-config/cip-cis-rules-config.bb
 create mode 100644 recipes-security/cip-cis-rules-config/files/.config.json
 create mode 100644 recipes-security/cip-cis-rules-config/files/Kconfig
 create mode 100644 recipes-security/cip-cis-rules-config/files/scripts/config.schema.json
 create mode 100755 recipes-security/cip-cis-rules-config/files/scripts/gen-kernel-config.py
 create mode 100755 recipes-security/cip-cis-rules-config/files/scripts/select-hardenings.py
 create mode 100755 scripts/cis-hardening/cis-hardening-to-kconfig.py

diff --git a/recipes-security/cip-cis-rules-config/cip-cis-rules-config.bb b/recipes-security/cip-cis-rules-config/cip-cis-rules-config.bb
new file mode 100644
index 0000000..0336568
--- /dev/null
+++ b/recipes-security/cip-cis-rules-config/cip-cis-rules-config.bb
@@ -0,0 +1,65 @@
+inherit dpkg-raw
+
+MAINTAINER = "Christoph Steiger <christoph.steiger@siemens.com>"
+DESCRIPTION = "Configuration files for CIS hardening"
+
+PROVIDES := "${PN}"
+DEBIAN_PROVIDES := "${PN}"
+
+PN .= "-${MACHINE}"
+
+S = "${WORKDIR}/${BPN}"
+
+DEPLOYDIR_HARDENING = "${WORKDIR}/deploy-hardening"
+SSTATETASKS += "do_deploy_hardening"
+
+HARDENING_CFG ?= ".config.json"
+
+SRC_URI += "file://${HARDENING_CFG} \
+    file://scripts \
+    file://Kconfig \
+    "
+
+do_check_config() {
+    if [ ! -s "${WORKDIR}/${HARDENING_CFG}" ]; then
+        bbfatal "Hardening configuration is missing. Please run 'bitbake cip-cis-rules-config -c menuconfig' and include the generated ${WORKDIR}/${HARDENING_CFG} in your SRC_URI and HARDENING_CFG."
+    fi
+}
+
+addtask check_config after do_unpack before do_generate_kernel_config
+
+do_deploy_hardening[cleandirs] += "${DEPLOYDIR_HARDENING}"
+do_deploy_hardening[sstate-inputdirs] = "${DEPLOYDIR_HARDENING}"
+do_deploy_hardening[sstate-outputdirs] = "${DEPLOY_DIR_IMAGE}"
+do_deploy_hardening() {
+    cp "${WORKDIR}/${HARDENING_CFG}" "${DEPLOYDIR_HARDENING}/${CIP_CIS_HARDENING_CONFIG}"
+    cp "${WORKDIR}/hardening.cfg" "${DEPLOYDIR_HARDENING}/${CIP_CIS_HARDENING_KCONFIG}"
+}
+
+python do_deploy_hardening_setscene () {
+    sstate_setscene(d)
+}
+addtask deploy_hardening_setscene
+
+addtask deploy_hardening after do_dpkg_build before do_deploy_deb
+
+do_generate_kernel_config() {
+    "${WORKDIR}/scripts/gen-kernel-config.py" --config "${WORKDIR}/${HARDENING_CFG}" --output "${WORKDIR}/hardening.cfg"
+}
+
+addtask generate_kernel_config after do_unpack before do_install
+
+do_install[cleandirs] = "${D}/usr/share/cip-cis-rules"
+do_install() {
+    install -v -m 644 "${WORKDIR}/${HARDENING_CFG}" "${D}/usr/share/cip-cis-rules/.config.json"
+    install -v -m 644 "${WORKDIR}/hardening.cfg" "${D}/usr/share/cip-cis-rules/hardening.cfg"
+}
+
+do_menuconfig[nostamp] = "1"
+python do_menuconfig() {
+    outdir = d.getVar('WORKDIR')
+    config = d.getVar('HARDENING_CFG')
+    termcmd = '{0}/scripts/select-hardenings.py --output {0}/{1} {0}/Kconfig'
+    oe_terminal(termcmd.format(outdir, config), "CIS Hardening Config", d)
+}
+addtask menuconfig after do_unpack
diff --git a/recipes-security/cip-cis-rules-config/files/.config.json b/recipes-security/cip-cis-rules-config/files/.config.json
new file mode 100644
index 0000000..1db2691
--- /dev/null
+++ b/recipes-security/cip-cis-rules-config/files/.config.json
@@ -0,0 +1,1759 @@
+{
+  "level": 2,
+  "rules": [
+    {
+      "rule": {
+        "name": "1.1.10",
+        "description": "var tmp noexec",
+        "level": 3,
+        "apply": false
+      }
+    },
+    {
+      "rule": {
+        "name": "1.1.11",
+        "description": "var log partition",
+        "level": 3,
+        "apply": false
+      }
+    },
+    {
+      "rule": {
+        "name": "1.1.11.1",
+        "description": "var log noexec",
+        "level": 3,
+        "apply": false
+      }
+    },
+    {
+      "rule": {
+        "name": "1.1.11.2",
+        "description": "var log nosuid",
+        "level": 2,
+        "apply": false,
+        "justification": "Not applicable: no separate /var/log partition is configured."
+      }
+    },
+    {
+      "rule": {
+        "name": "1.1.11.3",
+        "description": "var log nodev",
+        "level": 2,
+        "apply": false,
+        "justification": "Not applicable: no separate /var/log partition is configured."
+      }
+    },
+    {
+      "rule": {
+        "name": "1.1.12",
+        "description": "var log audit partition",
+        "level": 4,
+        "apply": false
+      }
+    },
+    {
+      "rule": {
+        "name": "1.1.12.1",
+        "description": "var log audit noexec",
+        "level": 3,
+        "apply": false
+      }
+    },
+    {
+      "rule": {
+        "name": "1.1.12.2",
+        "description": "var log audit nosuid",
+        "level": 2,
+        "apply": false,
+        "justification": "Not applicable: no separate /var/log/audit partition is configured."
+      }
+    },
+    {
+      "rule": {
+        "name": "1.1.12.3",
+        "description": "var log audit nodev",
+        "level": 2,
+        "apply": false,
+        "justification": "Not applicable: no separate /var/log/audit partition is configured."
+      }
+    },
+    {
+      "rule": {
+        "name": "1.1.13",
+        "description": "home partition",
+        "level": 3,
+        "apply": false
+      }
+    },
+    {
+      "rule": {
+        "name": "1.1.14",
+        "description": "home nodev",
+        "level": 2,
+        "apply": false,
+        "justification": "Not applicable: no separate /home partition is configured."
+      }
+    },
+    {
+      "rule": {
+        "name": "1.1.14.1",
+        "description": "home nosuid",
+        "level": 2,
+        "apply": false,
+        "justification": "Not applicable: no separate /home partition is configured."
+      }
+    },
+    {
+      "rule": {
+        "name": "1.1.15",
+        "description": "run shm nodev",
+        "level": 2,
+        "apply": true
+      }
+    },
+    {
+      "rule": {
+        "name": "1.1.16",
+        "description": "run shm nosuid",
+        "level": 2,
+        "apply": true
+      }
+    },
+    {
+      "rule": {
+        "name": "1.1.17",
+        "description": "run shm noexec",
+        "level": 3,
+        "apply": false
+      }
+    },
+    {
+      "rule": {
+        "name": "1.1.18",
+        "description": "removable device nodev",
+        "level": 2,
+        "apply": true
+      }
+    },
+    {
+      "rule": {
+        "name": "1.1.19",
+        "description": "removable device nosuid",
+        "level": 2,
+        "apply": true
+      }
+    },
+    {
+      "rule": {
+        "name": "1.1.1.1",
+        "description": "disable freevxfs",
+        "level": 2,
+        "apply": true
+      }
+    },
+    {
+      "rule": {
+        "name": "1.1.1.2",
+        "description": "disable jffs2",
+        "level": 2,
+        "apply": true
+      }
+    },
+    {
+      "rule": {
+        "name": "1.1.1.3",
+        "description": "disable hfs",
+        "level": 2,
+        "apply": true
+      }
+    },
+    {
+      "rule": {
+        "name": "1.1.1.4",
+        "description": "disable hfsplus",
+        "level": 2,
+        "apply": true
+      }
+    },
+    {
+      "rule": {
+        "name": "1.1.1.5",
+        "description": "disable squashfs",
+        "level": 2,
+        "apply": true
+      }
+    },
+    {
+      "rule": {
+        "name": "1.1.1.6",
+        "description": "disable udf",
+        "level": 2,
+        "apply": true
+      }
+    },
+    {
+      "rule": {
+        "name": "1.1.1.7",
+        "description": "restrict fat",
+        "level": 5,
+        "apply": false
+      }
+    },
+    {
+      "rule": {
+        "name": "1.1.1.8",
+        "description": "disable cramfs",
+        "level": 2,
+        "apply": true
+      }
+    },
+    {
+      "rule": {
+        "name": "1.1.2",
+        "description": "tmp partition",
+        "level": 3,
+        "apply": false
+      }
+    },
+    {
+      "rule": {
+        "name": "1.1.20",
+        "description": "removable device noexec",
+        "level": 2,
+        "apply": true
+      }
+    },
+    {
+      "rule": {
+        "name": "1.1.21",
+        "description": "sticky bit world writable folder",
+        "level": 2,
+        "apply": true
+      }
+    },
+    {
+      "rule": {
+        "name": "1.1.22",
+        "description": "disable automounting",
+        "level": 2,
+        "apply": true
+      }
+    },
+    {
+      "rule": {
+        "name": "1.1.23",
+        "description": "disable usb storage",
+        "level": 2,
+        "apply": true
+      }
+    },
+    {
+      "rule": {
+        "name": "1.1.3",
+        "description": "tmp nodev",
+        "level": 2,
+        "apply": true
+      }
+    },
+    {
+      "rule": {
+        "name": "1.1.4",
+        "description": "tmp nosuid",
+        "level": 2,
+        "apply": true
+      }
+    },
+    {
+      "rule": {
+        "name": "1.1.5",
+        "description": "tmp noexec",
+        "level": 3,
+        "apply": false
+      }
+    },
+    {
+      "rule": {
+        "name": "1.1.6",
+        "description": "var partition",
+        "level": 3,
+        "apply": false
+      }
+    },
+    {
+      "rule": {
+        "name": "1.1.6.1",
+        "description": "var nodev",
+        "level": 2,
+        "apply": false,
+        "justification": "Not applicable: no separate /var partition is configured."
+      }
+    },
+    {
+      "rule": {
+        "name": "1.1.6.2",
+        "description": "var nosuid",
+        "level": 2,
+        "apply": false,
+        "justification": "Not applicable: no separate /var partition is configured."
+      }
+    },
+    {
+      "rule": {
+        "name": "1.1.7",
+        "description": "var tmp partition",
+        "level": 3,
+        "apply": false
+      }
+    },
+    {
+      "rule": {
+        "name": "1.1.8",
+        "description": "var tmp nodev",
+        "level": 2,
+        "apply": false,
+        "justification": "Not applicable: no separate /var/tmp partition is configured."
+      }
+    },
+    {
+      "rule": {
+        "name": "1.1.9",
+        "description": "var tmp nosuid",
+        "level": 2,
+        "apply": false,
+        "justification": "Not applicable: no separate /var/tmp partition is configured."
+      }
+    },
+    {
+      "rule": {
+        "name": "1.3.1",
+        "description": "install sudo",
+        "level": 2,
+        "apply": true
+      }
+    },
+    {
+      "rule": {
+        "name": "1.3.2",
+        "description": "pty sudo",
+        "level": 2,
+        "apply": true
+      }
+    },
+    {
+      "rule": {
+        "name": "1.3.3",
+        "description": "logfile sudo",
+        "level": 2,
+        "apply": true
+      }
+    },
+    {
+      "rule": {
+        "name": "1.4.1",
+        "description": "install tripwire",
+        "level": 4,
+        "apply": false
+      }
+    },
+    {
+      "rule": {
+        "name": "1.4.2",
+        "description": "tripwire cron",
+        "level": 4,
+        "apply": false
+      }
+    },
+    {
+      "rule": {
+        "name": "1.5.1",
+        "description": "bootloader ownership",
+        "level": 1,
+        "apply": false,
+        "justification": "Not applicable: the GRUB bootloader is not used."
+      }
+    },
+    {
+      "rule": {
+        "name": "1.5.2",
+        "description": "bootloader password",
+        "level": 3,
+        "apply": false
+      }
+    },
+    {
+      "rule": {
+        "name": "1.5.3",
+        "description": "root password",
+        "level": 3,
+        "apply": false
+      }
+    },
+    {
+      "rule": {
+        "name": "1.6.1",
+        "description": "enable nx support",
+        "level": 2,
+        "apply": true
+      }
+    },
+    {
+      "rule": {
+        "name": "1.6.2",
+        "description": "enable randomized vm placement",
+        "level": 2,
+        "apply": true
+      }
+    },
+    {
+      "rule": {
+        "name": "1.6.3",
+        "description": "disable prelink",
+        "level": 2,
+        "apply": true
+      }
+    },
+    {
+      "rule": {
+        "name": "1.6.3.1",
+        "description": "disable apport",
+        "level": 2,
+        "apply": true
+      }
+    },
+    {
+      "rule": {
+        "name": "1.6.4",
+        "description": "restrict core dumps",
+        "level": 2,
+        "apply": true
+      }
+    },
+    {
+      "rule": {
+        "name": "1.7.1.1",
+        "description": "install apparmor",
+        "level": 3,
+        "apply": false
+      }
+    },
+    {
+      "rule": {
+        "name": "1.7.1.2",
+        "description": "enable apparmor",
+        "level": 3,
+        "apply": false
+      }
+    },
+    {
+      "rule": {
+        "name": "1.7.1.3",
+        "description": "enforce or complain apparmor",
+        "level": 3,
+        "apply": false
+      }
+    },
+    {
+      "rule": {
+        "name": "1.7.1.4",
+        "description": "enforcing apparmor",
+        "level": 3,
+        "apply": false
+      }
+    },
+    {
+      "rule": {
+        "name": "1.8.1.1",
+        "description": "remove os info motd",
+        "level": 3,
+        "apply": false
+      }
+    },
+    {
+      "rule": {
+        "name": "1.8.1.2",
+        "description": "remove os info issue",
+        "level": 3,
+        "apply": false
+      }
+    },
+    {
+      "rule": {
+        "name": "1.8.1.3",
+        "description": "remove os info issue net",
+        "level": 3,
+        "apply": false
+      }
+    },
+    {
+      "rule": {
+        "name": "1.8.1.4",
+        "description": "motd perms",
+        "level": 3,
+        "apply": false
+      }
+    },
+    {
+      "rule": {
+        "name": "1.8.1.5",
+        "description": "etc issue perms",
+        "level": 3,
+        "apply": false
+      }
+    },
+    {
+      "rule": {
+        "name": "1.8.1.6",
+        "description": "etc issue net perms",
+        "level": 3,
+        "apply": false
+      }
+    },
+    {
+      "rule": {
+        "name": "1.8.2",
+        "description": "graphical warning banners",
+        "level": 3,
+        "apply": false
+      }
+    },
+    {
+      "rule": {
+        "name": "2.1.1",
+        "description": "disable xinetd",
+        "level": 3,
+        "apply": false
+      }
+    },
+    {
+      "rule": {
+        "name": "2.1.2",
+        "description": "disable bsd inetd",
+        "level": 3,
+        "apply": false
+      }
+    },
+    {
+      "rule": {
+        "name": "2.2.10",
+        "description": "disable http server",
+        "level": 3,
+        "apply": false
+      }
+    },
+    {
+      "rule": {
+        "name": "2.2.11",
+        "description": "disable imap pop",
+        "level": 3,
+        "apply": false
+      }
+    },
+    {
+      "rule": {
+        "name": "2.2.12",
+        "description": "disable samba",
+        "level": 3,
+        "apply": false
+      }
+    },
+    {
+      "rule": {
+        "name": "2.2.13",
+        "description": "disable http proxy",
+        "level": 3,
+        "apply": false
+      }
+    },
+    {
+      "rule": {
+        "name": "2.2.14",
+        "description": "disable snmp server",
+        "level": 3,
+        "apply": false
+      }
+    },
+    {
+      "rule": {
+        "name": "2.2.15",
+        "description": "mta localhost",
+        "level": 3,
+        "apply": false
+      }
+    },
+    {
+      "rule": {
+        "name": "2.2.16",
+        "description": "disable rsync",
+        "level": 3,
+        "apply": false
+      }
+    },
+    {
+      "rule": {
+        "name": "2.2.17",
+        "description": "disable nis",
+        "level": 3,
+        "apply": false
+      }
+    },
+    {
+      "rule": {
+        "name": "2.2.1.1",
+        "description": "use time sync",
+        "level": 3,
+        "apply": false
+      }
+    },
+    {
+      "rule": {
+        "name": "2.2.1.2",
+        "description": "configure systemd-timesyncd",
+        "level": 4,
+        "apply": false
+      }
+    },
+    {
+      "rule": {
+        "name": "2.2.1.3",
+        "description": "configure chrony",
+        "level": 3,
+        "apply": false
+      }
+    },
+    {
+      "rule": {
+        "name": "2.2.1.4",
+        "description": "configure ntp",
+        "level": 3,
+        "apply": false
+      }
+    },
+    {
+      "rule": {
+        "name": "2.2.2",
+        "description": "disable xwindow system",
+        "level": 3,
+        "apply": false
+      }
+    },
+    {
+      "rule": {
+        "name": "2.2.3",
+        "description": "disable avahi server",
+        "level": 3,
+        "apply": false
+      }
+    },
+    {
+      "rule": {
+        "name": "2.2.4",
+        "description": "disable print server",
+        "level": 3,
+        "apply": false
+      }
+    },
+    {
+      "rule": {
+        "name": "2.2.5",
+        "description": "disable dhcp",
+        "level": 3,
+        "apply": false
+      }
+    },
+    {
+      "rule": {
+        "name": "2.2.6",
+        "description": "disable ldap",
+        "level": 3,
+        "apply": false
+      }
+    },
+    {
+      "rule": {
+        "name": "2.2.7",
+        "description": "disable nfs rpc",
+        "level": 3,
+        "apply": false
+      }
+    },
+    {
+      "rule": {
+        "name": "2.2.8",
+        "description": "disable dns server",
+        "level": 3,
+        "apply": false
+      }
+    },
+    {
+      "rule": {
+        "name": "2.2.9",
+        "description": "disable ftp",
+        "level": 3,
+        "apply": false
+      }
+    },
+    {
+      "rule": {
+        "name": "2.3.1",
+        "description": "disable nis",
+        "level": 3,
+        "apply": false
+      }
+    },
+    {
+      "rule": {
+        "name": "2.3.2",
+        "description": "disable rsh client",
+        "level": 2,
+        "apply": true
+      }
+    },
+    {
+      "rule": {
+        "name": "2.3.3",
+        "description": "disable talk client",
+        "level": 2,
+        "apply": true
+      }
+    },
+    {
+      "rule": {
+        "name": "2.3.4",
+        "description": "disable telnet client",
+        "level": 2,
+        "apply": true
+      }
+    },
+    {
+      "rule": {
+        "name": "2.3.5",
+        "description": "disable ldap client",
+        "level": 2,
+        "apply": true
+      }
+    },
+    {
+      "rule": {
+        "name": "3.1.1",
+        "description": "disable ipv6",
+        "level": 2,
+        "apply": true
+      }
+    },
+    {
+      "rule": {
+        "name": "3.1.2",
+        "description": "disable wireless",
+        "level": 3,
+        "apply": false
+      }
+    },
+    {
+      "rule": {
+        "name": "3.2.1",
+        "description": "disable send packet redirects",
+        "level": 2,
+        "apply": true
+      }
+    },
+    {
+      "rule": {
+        "name": "3.2.2",
+        "description": "disable ip forwarding",
+        "level": 3,
+        "apply": false
+      }
+    },
+    {
+      "rule": {
+        "name": "3.3.1",
+        "description": "disable source routed packets",
+        "level": 2,
+        "apply": true
+      }
+    },
+    {
+      "rule": {
+        "name": "3.3.2",
+        "description": "disable icmp redirect",
+        "level": 2,
+        "apply": true
+      }
+    },
+    {
+      "rule": {
+        "name": "3.3.3",
+        "description": "disable secure icmp redirect",
+        "level": 2,
+        "apply": true
+      }
+    },
+    {
+      "rule": {
+        "name": "3.3.4",
+        "description": "log martian packets",
+        "level": 2,
+        "apply": true
+      }
+    },
+    {
+      "rule": {
+        "name": "3.3.5",
+        "description": "ignore broadcast requests",
+        "level": 2,
+        "apply": true
+      }
+    },
+    {
+      "rule": {
+        "name": "3.3.6",
+        "description": "enable bad error message protection",
+        "level": 2,
+        "apply": true
+      }
+    },
+    {
+      "rule": {
+        "name": "3.3.7",
+        "description": "enable source route validation",
+        "level": 2,
+        "apply": true
+      }
+    },
+    {
+      "rule": {
+        "name": "3.3.8",
+        "description": "enable tcp syn cookies",
+        "level": 2,
+        "apply": true
+      }
+    },
+    {
+      "rule": {
+        "name": "3.3.9",
+        "description": "disable ipv6 router advertisement",
+        "level": 2,
+        "apply": true
+      }
+    },
+    {
+      "rule": {
+        "name": "3.5.1.1",
+        "description": "enable firewall",
+        "level": 2,
+        "apply": true
+      }
+    },
+    {
+      "rule": {
+        "name": "3.5.4.1.1",
+        "description": "net fw default policy drop",
+        "level": 2,
+        "apply": true
+      }
+    },
+    {
+      "rule": {
+        "name": "4.1.10",
+        "description": "record failed access file",
+        "level": 4,
+        "apply": false
+      }
+    },
+    {
+      "rule": {
+        "name": "4.1.11",
+        "description": "record privileged commands",
+        "level": 4,
+        "apply": false
+      }
+    },
+    {
+      "rule": {
+        "name": "4.1.12",
+        "description": "record successful mount",
+        "level": 4,
+        "apply": false
+      }
+    },
+    {
+      "rule": {
+        "name": "4.1.13",
+        "description": "record file deletions",
+        "level": 4,
+        "apply": false
+      }
+    },
+    {
+      "rule": {
+        "name": "4.1.14",
+        "description": "record sudoers edit",
+        "level": 4,
+        "apply": false
+      }
+    },
+    {
+      "rule": {
+        "name": "4.1.15",
+        "description": "record sudo usage",
+        "level": 4,
+        "apply": false
+      }
+    },
+    {
+      "rule": {
+        "name": "4.1.16",
+        "description": "record kernel modules",
+        "level": 4,
+        "apply": false
+      }
+    },
+    {
+      "rule": {
+        "name": "4.1.17",
+        "description": "freeze auditd conf",
+        "level": 4,
+        "apply": false
+      }
+    },
+    {
+      "rule": {
+        "name": "4.1.1.1",
+        "description": "install auditd",
+        "level": 4,
+        "apply": false
+      }
+    },
+    {
+      "rule": {
+        "name": "4.1.1.2",
+        "description": "enable auditd",
+        "level": 4,
+        "apply": false
+      }
+    },
+    {
+      "rule": {
+        "name": "4.1.1.3",
+        "description": "audit bootloader",
+        "level": 4,
+        "apply": false
+      }
+    },
+    {
+      "rule": {
+        "name": "4.1.1.4",
+        "description": "audit backlog limit",
+        "level": 4,
+        "apply": false
+      }
+    },
+    {
+      "rule": {
+        "name": "4.1.2.1",
+        "description": "audit log storage",
+        "level": 4,
+        "apply": false
+      }
+    },
+    {
+      "rule": {
+        "name": "4.1.2.2",
+        "description": "halt when audit log full",
+        "level": 4,
+        "apply": false
+      }
+    },
+    {
+      "rule": {
+        "name": "4.1.2.3",
+        "description": "keep all audit logs",
+        "level": 4,
+        "apply": false
+      }
+    },
+    {
+      "rule": {
+        "name": "4.1.3",
+        "description": "record date time edit",
+        "level": 4,
+        "apply": false
+      }
+    },
+    {
+      "rule": {
+        "name": "4.1.4",
+        "description": "record user group edit",
+        "level": 4,
+        "apply": false
+      }
+    },
+    {
+      "rule": {
+        "name": "4.1.5",
+        "description": "record network edit",
+        "level": 4,
+        "apply": false
+      }
+    },
+    {
+      "rule": {
+        "name": "4.1.6",
+        "description": "record mac edit",
+        "level": 4,
+        "apply": false
+      }
+    },
+    {
+      "rule": {
+        "name": "4.1.7",
+        "description": "record login logout",
+        "level": 4,
+        "apply": false
+      }
+    },
+    {
+      "rule": {
+        "name": "4.1.8",
+        "description": "record session init",
+        "level": 4,
+        "apply": false
+      }
+    },
+    {
+      "rule": {
+        "name": "4.1.9",
+        "description": "record dac edit",
+        "level": 4,
+        "apply": false
+      }
+    },
+    {
+      "rule": {
+        "name": "4.2.1.1",
+        "description": "install syslog-ng",
+        "level": 3,
+        "apply": false
+      }
+    },
+    {
+      "rule": {
+        "name": "4.2.1.2",
+        "description": "enable syslog-ng",
+        "level": 3,
+        "apply": false
+      }
+    },
+    {
+      "rule": {
+        "name": "4.2.1.3",
+        "description": "configure syslog-ng",
+        "level": 3,
+        "apply": false
+      }
+    },
+    {
+      "rule": {
+        "name": "4.2.1.4",
+        "description": "syslog ng logfiles perm",
+        "level": 3,
+        "apply": false
+      }
+    },
+    {
+      "rule": {
+        "name": "4.2.1.5",
+        "description": "syslog-ng remote host",
+        "level": 3,
+        "apply": false
+      }
+    },
+    {
+      "rule": {
+        "name": "4.2.1.6",
+        "description": "remote syslog-ng acl",
+        "level": 3,
+        "apply": false
+      }
+    },
+    {
+      "rule": {
+        "name": "4.2.2.1",
+        "description": "journald logs",
+        "level": 3,
+        "apply": false
+      }
+    },
+    {
+      "rule": {
+        "name": "4.2.2.2",
+        "description": "journald compress",
+        "level": 3,
+        "apply": false
+      }
+    },
+    {
+      "rule": {
+        "name": "4.2.2.3",
+        "description": "journald write persistent",
+        "level": 3,
+        "apply": false
+      }
+    },
+    {
+      "rule": {
+        "name": "4.2.3",
+        "description": "logs permissions",
+        "level": 2,
+        "apply": true
+      }
+    },
+    {
+      "rule": {
+        "name": "4.4",
+        "description": "logrotate permissions",
+        "level": 3,
+        "apply": false
+      }
+    },
+    {
+      "rule": {
+        "name": "5.1.1",
+        "description": "enable cron",
+        "level": 3,
+        "apply": false
+      }
+    },
+    {
+      "rule": {
+        "name": "5.1.2",
+        "description": "crontab perm ownership",
+        "level": 1,
+        "apply": false,
+        "justification": "Not applicable: cron is not used on this system."
+      }
+    },
+    {
+      "rule": {
+        "name": "5.1.3",
+        "description": "cron hourly perm ownership",
+        "level": 1,
+        "apply": false,
+        "justification": "Not applicable: cron is not used on this system."
+      }
+    },
+    {
+      "rule": {
+        "name": "5.1.4",
+        "description": "cron daily perm ownership",
+        "level": 1,
+        "apply": false,
+        "justification": "Not applicable: cron is not used on this system."
+      }
+    },
+    {
+      "rule": {
+        "name": "5.1.5",
+        "description": "cron weekly perm ownership",
+        "level": 1,
+        "apply": false,
+        "justification": "Not applicable: cron is not used on this system."
+      }
+    },
+    {
+      "rule": {
+        "name": "5.1.6",
+        "description": "cron monthly perm ownership",
+        "level": 1,
+        "apply": false,
+        "justification": "Not applicable: cron is not used on this system."
+      }
+    },
+    {
+      "rule": {
+        "name": "5.1.7",
+        "description": "cron d perm ownership",
+        "level": 1,
+        "apply": false,
+        "justification": "Not applicable: cron is not used on this system."
+      }
+    },
+    {
+      "rule": {
+        "name": "5.1.8",
+        "description": "cron users",
+        "level": 2,
+        "apply": false,
+        "justification": "Not applicable: cron is not used on this system."
+      }
+    },
+    {
+      "rule": {
+        "name": "5.2.1",
+        "description": "sshd conf perm ownership",
+        "level": 1,
+        "apply": true
+      }
+    },
+    {
+      "rule": {
+        "name": "5.2.10",
+        "description": "disable root login",
+        "level": 3,
+        "apply": false
+      }
+    },
+    {
+      "rule": {
+        "name": "5.2.11",
+        "description": "disable sshd permitemptypasswords",
+        "level": 2,
+        "apply": true
+      }
+    },
+    {
+      "rule": {
+        "name": "5.2.12",
+        "description": "disable sshd setenv",
+        "level": 2,
+        "apply": true
+      }
+    },
+    {
+      "rule": {
+        "name": "5.2.13",
+        "description": "sshd ciphers",
+        "level": 2,
+        "apply": true
+      }
+    },
+    {
+      "rule": {
+        "name": "5.2.14",
+        "description": "ssh cry mac",
+        "level": 2,
+        "apply": true
+      }
+    },
+    {
+      "rule": {
+        "name": "5.2.15",
+        "description": "ssh cry kex",
+        "level": 2,
+        "apply": true
+      }
+    },
+    {
+      "rule": {
+        "name": "5.2.16",
+        "description": "sshd idle timeout",
+        "level": 3,
+        "apply": false
+      }
+    },
+    {
+      "rule": {
+        "name": "5.2.17",
+        "description": "sshd login grace time",
+        "level": 3,
+        "apply": false
+      }
+    },
+    {
+      "rule": {
+        "name": "5.2.18",
+        "description": "sshd limit access",
+        "level": 3,
+        "apply": false
+      }
+    },
+    {
+      "rule": {
+        "name": "5.2.19",
+        "description": "ssh banner",
+        "level": 3,
+        "apply": false
+      }
+    },
+    {
+      "rule": {
+        "name": "5.2.2",
+        "description": "ssh host private keys perm ownership",
+        "level": 1,
+        "apply": true
+      }
+    },
+    {
+      "rule": {
+        "name": "5.2.20",
+        "description": "enable ssh pam",
+        "level": 3,
+        "apply": false
+      }
+    },
+    {
+      "rule": {
+        "name": "5.2.21",
+        "description": "disable ssh allow tcp forwarding",
+        "level": 3,
+        "apply": false
+      }
+    },
+    {
+      "rule": {
+        "name": "5.2.22",
+        "description": "configure ssh max startups",
+        "level": 3,
+        "apply": false
+      }
+    },
+    {
+      "rule": {
+        "name": "5.2.23",
+        "description": "limit ssh max sessions",
+        "level": 3,
+        "apply": false
+      }
+    },
+    {
+      "rule": {
+        "name": "5.2.3",
+        "description": "ssh host public keys perm ownership",
+        "level": 1,
+        "apply": true
+      }
+    },
+    {
+      "rule": {
+        "name": "5.2.4",
+        "description": "sshd protocol",
+        "level": 2,
+        "apply": true
+      }
+    },
+    {
+      "rule": {
+        "name": "5.2.5",
+        "description": "sshd loglevel",
+        "level": 2,
+        "apply": true
+      }
+    },
+    {
+      "rule": {
+        "name": "5.2.6",
+        "description": "disable x11 forwarding",
+        "level": 2,
+        "apply": true
+      }
+    },
+    {
+      "rule": {
+        "name": "5.2.7",
+        "description": "sshd maxauthtries",
+        "level": 2,
+        "apply": true
+      }
+    },
+    {
+      "rule": {
+        "name": "5.2.8",
+        "description": "enable sshd ignorerhosts",
+        "level": 2,
+        "apply": true
+      }
+    },
+    {
+      "rule": {
+        "name": "5.2.9",
+        "description": "disable sshd hostbasedauthentication",
+        "level": 2,
+        "apply": true
+      }
+    },
+    {
+      "rule": {
+        "name": "5.3.1",
+        "description": "enable pwquality",
+        "level": 2,
+        "apply": true
+      }
+    },
+    {
+      "rule": {
+        "name": "5.3.2",
+        "description": "enable lockout failed password",
+        "level": 3,
+        "apply": false
+      }
+    },
+    {
+      "rule": {
+        "name": "5.3.3",
+        "description": "limit password reuse",
+        "level": 3,
+        "apply": false
+      }
+    },
+    {
+      "rule": {
+        "name": "5.3.4",
+        "description": "acc pam sha512",
+        "level": 2,
+        "apply": true
+      }
+    },
+    {
+      "rule": {
+        "name": "5.4.1.1",
+        "description": "set password exp days",
+        "level": 3,
+        "apply": false
+      }
+    },
+    {
+      "rule": {
+        "name": "5.4.1.2",
+        "description": "set password min days change",
+        "level": 3,
+        "apply": false
+      }
+    },
+    {
+      "rule": {
+        "name": "5.4.1.3",
+        "description": "set password exp warning days",
+        "level": 3,
+        "apply": false
+      }
+    },
+    {
+      "rule": {
+        "name": "5.4.1.4",
+        "description": "lock inactive user account",
+        "level": 3,
+        "apply": false
+      }
+    },
+    {
+      "rule": {
+        "name": "5.4.1.5",
+        "description": "last password change past",
+        "level": 3,
+        "apply": false
+      }
+    },
+    {
+      "rule": {
+        "name": "5.4.2",
+        "description": "disable system accounts",
+        "level": 3,
+        "apply": false
+      }
+    },
+    {
+      "rule": {
+        "name": "5.4.3",
+        "description": "default root group",
+        "level": 2,
+        "apply": true
+      }
+    },
+    {
+      "rule": {
+        "name": "5.4.4",
+        "description": "default umask",
+        "level": 3,
+        "apply": false
+      }
+    },
+    {
+      "rule": {
+        "name": "5.4.5",
+        "description": "default timeout",
+        "level": 5,
+        "apply": false
+      }
+    },
+    {
+      "rule": {
+        "name": "5.5",
+        "description": "secure tty",
+        "level": 3,
+        "apply": false
+      }
+    },
+    {
+      "rule": {
+        "name": "5.6",
+        "description": "restrict su",
+        "level": 3,
+        "apply": false
+      }
+    },
+    {
+      "rule": {
+        "name": "6.1.10",
+        "description": "find world writable file",
+        "level": 3,
+        "apply": false
+      }
+    },
+    {
+      "rule": {
+        "name": "6.1.11",
+        "description": "find unowned files",
+        "level": 2,
+        "apply": true
+      }
+    },
+    {
+      "rule": {
+        "name": "6.1.12",
+        "description": "find ungrouped files",
+        "level": 2,
+        "apply": true
+      }
+    },
+    {
+      "rule": {
+        "name": "6.1.13",
+        "description": "find suid files",
+        "level": 2,
+        "apply": true
+      }
+    },
+    {
+      "rule": {
+        "name": "6.1.14",
+        "description": "find sgid files",
+        "level": 2,
+        "apply": true
+      }
+    },
+    {
+      "rule": {
+        "name": "6.1.2",
+        "description": "etc passwd permissions",
+        "level": 1,
+        "apply": true
+      }
+    },
+    {
+      "rule": {
+        "name": "6.1.3",
+        "description": "etc gshadow- permissions",
+        "level": 1,
+        "apply": true
+      }
+    },
+    {
+      "rule": {
+        "name": "6.1.4",
+        "description": "etc shadow permissions",
+        "level": 1,
+        "apply": true
+      }
+    },
+    {
+      "rule": {
+        "name": "6.1.5",
+        "description": "etc group permissions",
+        "level": 1,
+        "apply": true
+      }
+    },
+    {
+      "rule": {
+        "name": "6.1.6",
+        "description": "etc passwd- permissions",
+        "level": 1,
+        "apply": true
+      }
+    },
+    {
+      "rule": {
+        "name": "6.1.7",
+        "description": "etc shadow- permissions",
+        "level": 1,
+        "apply": true
+      }
+    },
+    {
+      "rule": {
+        "name": "6.1.8",
+        "description": "etc group- permissions",
+        "level": 1,
+        "apply": true
+      }
+    },
+    {
+      "rule": {
+        "name": "6.1.9",
+        "description": "etc gshadow permissions",
+        "level": 1,
+        "apply": true
+      }
+    },
+    {
+      "rule": {
+        "name": "6.2.1",
+        "description": "remove empty password field",
+        "level": 1,
+        "apply": true
+      }
+    },
+    {
+      "rule": {
+        "name": "6.2.10",
+        "description": "check user dot file perm",
+        "level": 2,
+        "apply": true
+      }
+    },
+    {
+      "rule": {
+        "name": "6.2.11",
+        "description": "find user forward files",
+        "level": 2,
+        "apply": true
+      }
+    },
+    {
+      "rule": {
+        "name": "6.2.12",
+        "description": "find user netrc files",
+        "level": 2,
+        "apply": true
+      }
+    },
+    {
+      "rule": {
+        "name": "6.2.13",
+        "description": "set perm on user netrc",
+        "level": 2,
+        "apply": true
+      }
+    },
+    {
+      "rule": {
+        "name": "6.2.14",
+        "description": "find user rhosts files",
+        "level": 2,
+        "apply": true
+      }
+    },
+    {
+      "rule": {
+        "name": "6.2.15",
+        "description": "find passwd group inconsistencies",
+        "level": 2,
+        "apply": true
+      }
+    },
+    {
+      "rule": {
+        "name": "6.2.16",
+        "description": "check duplicate uid",
+        "level": 2,
+        "apply": true
+      }
+    },
+    {
+      "rule": {
+        "name": "6.2.17",
+        "description": "check duplicate gid",
+        "level": 2,
+        "apply": true
+      }
+    },
+    {
+      "rule": {
+        "name": "6.2.18",
+        "description": "check duplicate username",
+        "level": 1,
+        "apply": true
+      }
+    },
+    {
+      "rule": {
+        "name": "6.2.19",
+        "description": "check duplicate groupname",
+        "level": 1,
+        "apply": true
+      }
+    },
+    {
+      "rule": {
+        "name": "6.2.2",
+        "description": "remove legacy passwd entries",
+        "level": 1,
+        "apply": true
+      }
+    },
+    {
+      "rule": {
+        "name": "6.2.20",
+        "description": "shadow group empty",
+        "level": 1,
+        "apply": true
+      }
+    },
+    {
+      "rule": {
+        "name": "6.2.3",
+        "description": "users homedir exist",
+        "level": 2,
+        "apply": true
+      }
+    },
+    {
+      "rule": {
+        "name": "6.2.4",
+        "description": "remove legacy shadow entries",
+        "level": 1,
+        "apply": true
+      }
+    },
+    {
+      "rule": {
+        "name": "6.2.5",
+        "description": "remove legacy group entries",
+        "level": 1,
+        "apply": true
+      }
+    },
+    {
+      "rule": {
+        "name": "6.2.6",
+        "description": "find 0 uid non root account",
+        "level": 2,
+        "apply": true
+      }
+    },
+    {
+      "rule": {
+        "name": "6.2.7",
+        "description": "sanitize root path",
+        "level": 2,
+        "apply": true
+      }
+    },
+    {
+      "rule": {
+        "name": "6.2.8",
+        "description": "check user dir perm",
+        "level": 2,
+        "apply": true
+      }
+    },
+    {
+      "rule": {
+        "name": "6.2.9",
+        "description": "users homedir ownership",
+        "level": 2,
+        "apply": true
+      }
+    }
+  ]
+}
\ No newline at end of file
diff --git a/recipes-security/cip-cis-rules-config/files/Kconfig b/recipes-security/cip-cis-rules-config/files/Kconfig
new file mode 100644
index 0000000..b4bb056
--- /dev/null
+++ b/recipes-security/cip-cis-rules-config/files/Kconfig
@@ -0,0 +1,2831 @@
+menu "Default hardening level"
+
+choice
+	prompt "Hardening level"
+	default CIS_LEVEL_1
+
+config CIS_LEVEL_1
+	bool "Level 1"
+
+config CIS_LEVEL_2
+	bool "Level 2"
+
+config CIS_LEVEL_3
+	bool "Level 3"
+
+config CIS_LEVEL_4
+	bool "Level 4"
+
+config CIS_LEVEL_5
+	bool "Level 5"
+
+endchoice
+
+endmenu
+
+menu "Partitioning layout"
+
+config CIP_HOME_PART
+	bool "Separate /home partition"
+	default n
+	help
+	  Enable this if you have a separate /home partition
+
+config CIP_VAR_PART
+	bool "Separate /var partition"
+	default n
+	help
+	  Enable this if you have a separate /var partition
+
+config CIP_VAR_TMP_PART
+	bool "Separate /var/tmp partition"
+	depends on CIP_VAR_PART
+	default n
+	help
+	  Enable this if you have a separate /var/tmp partition
+
+config CIP_VAR_LOG_PART
+	bool "Separate /var/log partition"
+	depends on CIP_VAR_PART
+	default n
+	help
+	  Enable this if you have a separate /var/log partition
+
+config CIP_VAR_LOG_AUDIT_PART
+	bool "Separate /var/log/audit partition"
+	depends on CIP_VAR_PART && CIP_VAR_LOG_PART
+	default n
+	help
+	  Enable this if you have a separate /var/log/audit partition
+
+endmenu
+
+menu "Additional options"
+config CIP_GRUB_BOOTLOADER
+	bool "GRUB Bootloader"
+	default n
+	help
+	  Enable this if you use the GRUB bootloader
+
+config CIP_CRON
+	bool "CRON"
+	default n
+	help
+	  Enable this if you use CRON
+
+endmenu
+
+menu "1 Initial Setup"
+
+menu "1.1 Filesystem Configuration"
+
+config CIS_1_1_1_1
+	bool "1.1.1.1 - disable freevxfs (2)"
+	default y if CIS_LEVEL_2 || CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5
+	help
+	  Disable mounting of freevxfs filesystems.
+
+config CIS_1_1_1_1_JUSTIFICATION
+	string "justification to enable freevxfs (2)"
+	depends on !CIS_1_1_1_1 && (CIS_LEVEL_2 || CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5)
+	help
+	  Provide a reason for enabling mounting of freevxfs filesystems for the current hardening level.
+
+config CIS_1_1_1_2
+	bool "1.1.1.2 - disable jffs2 (2)"
+	default y if CIS_LEVEL_2 || CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5
+	help
+	  Disable mounting of jffs2 filesystems.
+
+config CIS_1_1_1_2_JUSTIFICATION
+	string "justification to enable jffs2 (2)"
+	depends on !CIS_1_1_1_2 && (CIS_LEVEL_2 || CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5)
+	help
+	  Provide a reason for enabling mounting of jffs2 filesystems for the current hardening level.
+
+config CIS_1_1_1_3
+	bool "1.1.1.3 - disable hfs (2)"
+	default y if CIS_LEVEL_2 || CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5
+	help
+	  Disable mounting of hfs filesystems.
+
+config CIS_1_1_1_3_JUSTIFICATION
+	string "justification to enable hfs (2)"
+	depends on !CIS_1_1_1_3 && (CIS_LEVEL_2 || CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5)
+	help
+	  Provide a reason for enabling mounting of hfs filesystems for the current hardening level.
+
+config CIS_1_1_1_4
+	bool "1.1.1.4 - disable hfsplus (2)"
+	default y if CIS_LEVEL_2 || CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5
+	help
+	  Disable mounting of hfsplus filesystems.
+
+config CIS_1_1_1_4_JUSTIFICATION
+	string "justification to enable hfsplus (2)"
+	depends on !CIS_1_1_1_4 && (CIS_LEVEL_2 || CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5)
+	help
+	  Provide a reason for enabling mounting of hfsplus filesystems for the current hardening level.
+
+config CIS_1_1_1_5
+	bool "1.1.1.5 - disable squashfs (2)"
+	default y if CIS_LEVEL_2 || CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5
+	help
+	  Disable mounting of squashfs filesytems.
+
+config CIS_1_1_1_5_JUSTIFICATION
+	string "justification to enable squashfs (2)"
+	depends on !CIS_1_1_1_5 && (CIS_LEVEL_2 || CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5)
+	help
+	  Provide a reason for enabling mounting of squashfs filesytems for the current hardening level.
+
+config CIS_1_1_1_6
+	bool "1.1.1.6 - disable udf (2)"
+	default y if CIS_LEVEL_2 || CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5
+	help
+	  Disable mounting of udf filesystems.
+
+config CIS_1_1_1_6_JUSTIFICATION
+	string "justification to enable udf (2)"
+	depends on !CIS_1_1_1_6 && (CIS_LEVEL_2 || CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5)
+	help
+	  Provide a reason for enabling mounting of udf filesystems for the current hardening level.
+
+config CIS_1_1_1_7
+	bool "1.1.1.7 - restrict fat (5)"
+	default y if CIS_LEVEL_5
+	help
+	  Limit mounting of FAT filesystems.
+
+config CIS_1_1_1_7_JUSTIFICATION
+	string "justification to enable fat (5)"
+	depends on !CIS_1_1_1_7 && (CIS_LEVEL_5)
+	help
+	  Provide a reason for enabling mounting of FAT filesystems for the current hardening level.
+
+config CIS_1_1_1_8
+	bool "1.1.1.8 - disable cramfs (2)"
+	default y if CIS_LEVEL_2 || CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5
+	help
+	  Disable mounting of cramfs filesystems.
+
+config CIS_1_1_1_8_JUSTIFICATION
+	string "justification to enable cramfs (2)"
+	depends on !CIS_1_1_1_8 && (CIS_LEVEL_2 || CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5)
+	help
+	  Provide a reason for enabling mounting of cramfs filesystems for the current hardening level.
+
+config CIS_1_1_2
+	bool "1.1.2 - tmp partition (3)"
+	default y if CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5
+	help
+	  Ensure /tmp is configured (Scored)
+
+config CIS_1_1_2_JUSTIFICATION
+	string "justification to enable tmp partition (3)"
+	depends on !CIS_1_1_2 && (CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5)
+	help
+	  Provide a reason for enabling /tmp is configured (Scored) for the current hardening level.
+
+config CIS_1_1_3
+	bool "1.1.3 - tmp nodev (2)"
+	default y if CIS_LEVEL_2 || CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5
+	help
+	  /tmp partition with nodev option.
+
+config CIS_1_1_3_JUSTIFICATION
+	string "justification to enable tmp nodev (2)"
+	depends on !CIS_1_1_3 && (CIS_LEVEL_2 || CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5)
+	help
+	  Provide a reason for enabling /tmp partition with nodev option for the current hardening level.
+
+config CIS_1_1_4
+	bool "1.1.4 - tmp nosuid (2)"
+	default y if CIS_LEVEL_2 || CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5
+	help
+	  /tmp partition with nosuid option.
+
+config CIS_1_1_4_JUSTIFICATION
+	string "justification to enable tmp nosuid (2)"
+	depends on !CIS_1_1_4 && (CIS_LEVEL_2 || CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5)
+	help
+	  Provide a reason for enabling /tmp partition with nosuid option for the current hardening level.
+
+config CIS_1_1_5
+	bool "1.1.5 - tmp noexec (3)"
+	default y if CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5
+	help
+	  /tmp partition with noexec option.
+
+config CIS_1_1_5_JUSTIFICATION
+	string "justification to enable tmp noexec (3)"
+	depends on !CIS_1_1_5 && (CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5)
+	help
+	  Provide a reason for enabling /tmp partition with noexec option for the current hardening level.
+
+config CIS_1_1_6
+	bool "1.1.6 - var partition (3)"
+	default y if (CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5) && CIP_VAR_PART
+	help
+	  /var on a separate partition.
+
+config CIS_1_1_6_JUSTIFICATION
+	string "justification to enable var partition (3)"
+	depends on !CIS_1_1_6 && (CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5)
+	default "Not applicable: no separate /var partition is configured." if !CIP_VAR_PART
+	help
+	  Provide a reason for enabling /var on a separate partition for the current hardening level.
+
+config CIS_1_1_6_1
+	bool "1.1.6.1 - var nodev (2)"
+	default y if (CIS_LEVEL_2 || CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5) && CIP_VAR_PART
+	help
+	  /var partition with nodev option.
+
+config CIS_1_1_6_1_JUSTIFICATION
+	string "justification to enable var nodev (2)"
+	depends on !CIS_1_1_6_1 && (CIS_LEVEL_2 || CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5)
+	default "Not applicable: no separate /var partition is configured." if !CIP_VAR_PART
+	help
+	  Provide a reason for enabling /var partition with nodev option for the current hardening level.
+
+config CIS_1_1_6_2
+	bool "1.1.6.2 - var nosuid (2)"
+	default y if (CIS_LEVEL_2 || CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5) && CIP_VAR_PART
+	help
+	  /var partition with nosuid option.
+
+config CIS_1_1_6_2_JUSTIFICATION
+	string "justification to enable var nosuid (2)"
+	depends on !CIS_1_1_6_2 && (CIS_LEVEL_2 || CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5)
+	default "Not applicable: no separate /var partition is configured." if !CIP_VAR_PART
+	help
+	  Provide a reason for enabling /var partition with nosuid option for the current hardening level.
+
+config CIS_1_1_7
+	bool "1.1.7 - var tmp partition (3)"
+	default y if (CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5) && CIP_VAR_TMP_PART
+	help
+	  /var/tmp on a separate partition.
+
+config CIS_1_1_7_JUSTIFICATION
+	string "justification to enable var tmp partition (3)"
+	depends on !CIS_1_1_7 && (CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5)
+	default "Not applicable: no separate /var/tmp partition is configured." if !CIP_VAR_TMP_PART
+	help
+	  Provide a reason for enabling /var/tmp on a separate partition for the current hardening level.
+
+config CIS_1_1_8
+	bool "1.1.8 - var tmp nodev (2)"
+	default y if (CIS_LEVEL_2 || CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5) && CIP_VAR_TMP_PART
+	help
+	  /var/tmp partition with nodev option.
+
+config CIS_1_1_8_JUSTIFICATION
+	string "justification to enable var tmp nodev (2)"
+	depends on !CIS_1_1_8 && (CIS_LEVEL_2 || CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5)
+	default "Not applicable: no separate /var/tmp partition is configured." if !CIP_VAR_TMP_PART
+	help
+	  Provide a reason for enabling /var/tmp partition with nodev option for the current hardening level.
+
+config CIS_1_1_9
+	bool "1.1.9 - var tmp nosuid (2)"
+	default y if (CIS_LEVEL_2 || CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5) && CIP_VAR_TMP_PART
+	help
+	  /var/tmp partition with nosuid option.
+
+config CIS_1_1_9_JUSTIFICATION
+	string "justification to enable var tmp nosuid (2)"
+	depends on !CIS_1_1_9 && (CIS_LEVEL_2 || CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5)
+	default "Not applicable: no separate /var/tmp partition is configured." if !CIP_VAR_TMP_PART
+	help
+	  Provide a reason for enabling /var/tmp partition with nosuid option for the current hardening level.
+
+config CIS_1_1_10
+	bool "1.1.10 - var tmp noexec (3)"
+	default y if (CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5) && CIP_VAR_TMP_PART
+	help
+	  /var/tmp partition with noexec option.
+
+config CIS_1_1_10_JUSTIFICATION
+	string "justification to enable var tmp noexec (3)"
+	depends on !CIS_1_1_10 && (CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5)
+	default "Not applicable: no separate /var/tmp partition is configured." if !CIP_VAR_TMP_PART
+	help
+	  Provide a reason for enabling /var/tmp partition with noexec option for the current hardening level.
+
+config CIS_1_1_11
+	bool "1.1.11 - var log partition (3)"
+	default y if (CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5) && CIP_VAR_LOG_PART
+	help
+	  /var/log on separate partition.
+
+config CIS_1_1_11_JUSTIFICATION
+	string "justification to enable var log partition (3)"
+	depends on !CIS_1_1_11 && (CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5)
+	default "Not applicable: no separate /var/log partition is configured." if !CIP_VAR_LOG_PART
+	help
+	  Provide a reason for enabling /var/log on separate partition for the current hardening level.
+
+config CIS_1_1_11_1
+	bool "1.1.11.1 - var log noexec (3)"
+	default y if (CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5) && CIP_VAR_LOG_PART
+	help
+	  /var/log partition with noexec option.
+
+config CIS_1_1_11_1_JUSTIFICATION
+	string "justification to enable var log noexec (3)"
+	depends on !CIS_1_1_11_1 && (CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5)
+	default "Not applicable: no separate /var/log partition is configured." if !CIP_VAR_LOG_PART
+	help
+	  Provide a reason for enabling /var/log partition with noexec option for the current hardening level.
+
+config CIS_1_1_11_2
+	bool "1.1.11.2 - var log nosuid (2)"
+	default y if (CIS_LEVEL_2 || CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5) && CIP_VAR_LOG_PART
+	help
+	  /var/log partition with nosuid option.
+
+config CIS_1_1_11_2_JUSTIFICATION
+	string "justification to enable var log nosuid (2)"
+	depends on !CIS_1_1_11_2 && (CIS_LEVEL_2 || CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5)
+	default "Not applicable: no separate /var/log partition is configured." if !CIP_VAR_LOG_PART
+	help
+	  Provide a reason for enabling /var/log partition with nosuid option for the current hardening level.
+
+config CIS_1_1_11_3
+	bool "1.1.11.3 - var log nodev (2)"
+	default y if (CIS_LEVEL_2 || CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5) && CIP_VAR_LOG_PART
+	help
+	  /var/log partition with nodev option.
+
+config CIS_1_1_11_3_JUSTIFICATION
+	string "justification to enable var log nodev (2)"
+	depends on !CIS_1_1_11_3 && (CIS_LEVEL_2 || CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5)
+	default "Not applicable: no separate /var/log partition is configured." if !CIP_VAR_LOG_PART
+	help
+	  Provide a reason for enabling /var/log partition with nodev option for the current hardening level.
+
+config CIS_1_1_12
+	bool "1.1.12 - var log audit partition (4)"
+	default y if (CIS_LEVEL_4 || CIS_LEVEL_5) && CIP_VAR_LOG_AUDIT_PART
+	help
+	  /var/log/audit on a separate partition.
+
+config CIS_1_1_12_JUSTIFICATION
+	string "justification to enable var log audit partition (4)"
+	depends on !CIS_1_1_12 && (CIS_LEVEL_4 || CIS_LEVEL_5)
+	default "Not applicable: no separate /var/log/audit partition is configured." if !CIP_VAR_LOG_AUDIT_PART
+	help
+	  Provide a reason for enabling /var/log/audit on a separate partition for the current hardening level.
+
+config CIS_1_1_12_1
+	bool "1.1.12.1 - var log audit noexec (3)"
+	default y if (CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5) && CIP_VAR_LOG_AUDIT_PART
+	help
+	  /var/log/audit partition with noexec option.
+
+config CIS_1_1_12_1_JUSTIFICATION
+	string "justification to enable var log audit noexec (3)"
+	depends on !CIS_1_1_12_1 && (CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5)
+	default "Not applicable: no separate /var/log/audit partition is configured." if !CIP_VAR_LOG_AUDIT_PART
+	help
+	  Provide a reason for enabling /var/log/audit partition with noexec option for the current hardening level.
+
+config CIS_1_1_12_2
+	bool "1.1.12.2 - var log audit nosuid (2)"
+	default y if (CIS_LEVEL_2 || CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5) && CIP_VAR_LOG_AUDIT_PART
+	help
+	  /var/log/audit partition with nosuid option.
+
+config CIS_1_1_12_2_JUSTIFICATION
+	string "justification to enable var log audit nosuid (2)"
+	depends on !CIS_1_1_12_2 && (CIS_LEVEL_2 || CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5)
+	default "Not applicable: no separate /var/log/audit partition is configured." if !CIP_VAR_LOG_AUDIT_PART
+	help
+	  Provide a reason for enabling /var/log/audit partition with nosuid option for the current hardening level.
+
+config CIS_1_1_12_3
+	bool "1.1.12.3 - var log audit nodev (2)"
+	default y if (CIS_LEVEL_2 || CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5) && CIP_VAR_LOG_AUDIT_PART
+	help
+	  /var/log/audit partition with nodev option.
+
+config CIS_1_1_12_3_JUSTIFICATION
+	string "justification to enable var log audit nodev (2)"
+	depends on !CIS_1_1_12_3 && (CIS_LEVEL_2 || CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5)
+	default "Not applicable: no separate /var/log/audit partition is configured." if !CIP_VAR_LOG_AUDIT_PART
+	help
+	  Provide a reason for enabling /var/log/audit partition with nodev option for the current hardening level.
+
+config CIS_1_1_13
+	bool "1.1.13 - home partition (3)"
+	default y if (CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5) && CIP_HOME_PART
+	help
+	  /home on a separate partition.
+
+config CIS_1_1_13_JUSTIFICATION
+	string "justification to enable home partition (3)"
+	depends on !CIS_1_1_13 && (CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5)
+	default "Not applicable: no separate /home partition is configured." if !CIP_HOME_PART
+	help
+	  Provide a reason for enabling /home on a separate partition for the current hardening level.
+
+config CIS_1_1_14
+	bool "1.1.14 - home nodev (2)"
+	default y if (CIS_LEVEL_2 || CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5) && CIP_HOME_PART
+	help
+	  /home partition with nodev option.
+
+config CIS_1_1_14_JUSTIFICATION
+	string "justification to enable home nodev (2)"
+	depends on !CIS_1_1_14 && (CIS_LEVEL_2 || CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5)
+	default "Not applicable: no separate /home partition is configured." if !CIP_HOME_PART
+	help
+	  Provide a reason for enabling /home partition with nodev option for the current hardening level.
+
+config CIS_1_1_14_1
+	bool "1.1.14.1 - home nosuid (2)"
+	default y if (CIS_LEVEL_2 || CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5) && CIP_HOME_PART
+	help
+	  /home partition with nosuid option.
+
+config CIS_1_1_14_1_JUSTIFICATION
+	string "justification to enable home nosuid (2)"
+	depends on !CIS_1_1_14_1 && (CIS_LEVEL_2 || CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5)
+	default "Not applicable: no separate /home partition is configured." if !CIP_HOME_PART
+	help
+	  Provide a reason for enabling /home partition with nosuid option for the current hardening level.
+
+config CIS_1_1_15
+	bool "1.1.15 - run shm nodev (2)"
+	default y if CIS_LEVEL_2 || CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5
+	help
+	  /run/shm with nodev option.
+
+config CIS_1_1_15_JUSTIFICATION
+	string "justification to enable run shm nodev (2)"
+	depends on !CIS_1_1_15 && (CIS_LEVEL_2 || CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5)
+	help
+	  Provide a reason for enabling /run/shm with nodev option for the current hardening level.
+
+config CIS_1_1_16
+	bool "1.1.16 - run shm nosuid (2)"
+	default y if CIS_LEVEL_2 || CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5
+	help
+	  /run/shm with nosuid option.
+
+config CIS_1_1_16_JUSTIFICATION
+	string "justification to enable run shm nosuid (2)"
+	depends on !CIS_1_1_16 && (CIS_LEVEL_2 || CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5)
+	help
+	  Provide a reason for enabling /run/shm with nosuid option for the current hardening level.
+
+config CIS_1_1_17
+	bool "1.1.17 - run shm noexec (3)"
+	default y if CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5
+	help
+	  /run/shm with noexec option.
+
+config CIS_1_1_17_JUSTIFICATION
+	string "justification to enable run shm noexec (3)"
+	depends on !CIS_1_1_17 && (CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5)
+	help
+	  Provide a reason for enabling /run/shm with noexec option for the current hardening level.
+
+config CIS_1_1_18
+	bool "1.1.18 - removable device nodev (2)"
+	default y if CIS_LEVEL_2 || CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5
+	help
+	  nodev option for removable media partitions.
+
+config CIS_1_1_18_JUSTIFICATION
+	string "justification to enable removable device nodev (2)"
+	depends on !CIS_1_1_18 && (CIS_LEVEL_2 || CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5)
+	help
+	  Provide a reason for enabling nodev option for removable media partitions for the current hardening level.
+
+config CIS_1_1_19
+	bool "1.1.19 - removable device nosuid (2)"
+	default y if CIS_LEVEL_2 || CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5
+	help
+	  nosuid option for removable media partitions.
+
+config CIS_1_1_19_JUSTIFICATION
+	string "justification to enable removable device nosuid (2)"
+	depends on !CIS_1_1_19 && (CIS_LEVEL_2 || CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5)
+	help
+	  Provide a reason for enabling nosuid option for removable media partitions for the current hardening level.
+
+config CIS_1_1_20
+	bool "1.1.20 - removable device noexec (2)"
+	default y if CIS_LEVEL_2 || CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5
+	help
+	  noexec option for removable media partitions.
+
+config CIS_1_1_20_JUSTIFICATION
+	string "justification to enable removable device noexec (2)"
+	depends on !CIS_1_1_20 && (CIS_LEVEL_2 || CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5)
+	help
+	  Provide a reason for enabling noexec option for removable media partitions for the current hardening level.
+
+config CIS_1_1_21
+	bool "1.1.21 - sticky bit world writable folder (2)"
+	default y if CIS_LEVEL_2 || CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5
+	help
+	  Set sticky bit on world writable directories to prevent users from deleting or renaming files that are not owned by them.
+
+config CIS_1_1_21_JUSTIFICATION
+	string "justification to enable sticky bit world writable folder (2)"
+	depends on !CIS_1_1_21 && (CIS_LEVEL_2 || CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5)
+	help
+	  Provide a reason for enabling sticky bit on world writable directories to prevent users from deleting or renaming files that are not owned by them for the current hardening level.
+
+config CIS_1_1_22
+	bool "1.1.22 - disable automounting (2)"
+	default y if CIS_LEVEL_2 || CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5
+	help
+	  Disable automounting of devices.
+
+config CIS_1_1_22_JUSTIFICATION
+	string "justification to enable automounting (2)"
+	depends on !CIS_1_1_22 && (CIS_LEVEL_2 || CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5)
+	help
+	  Provide a reason for enabling automounting of devices for the current hardening level.
+
+config CIS_1_1_23
+	bool "1.1.23 - disable usb storage (2)"
+	default y if CIS_LEVEL_2 || CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5
+	help
+	  Disable USB storage.
+
+config CIS_1_1_23_JUSTIFICATION
+	string "justification to enable usb storage (2)"
+	depends on !CIS_1_1_23 && (CIS_LEVEL_2 || CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5)
+	help
+	  Provide a reason for enabling USB storage for the current hardening level.
+
+endmenu
+
+menu "1.3 Filesystem Integrity Checking"
+
+config CIS_1_3_1
+	bool "1.3.1 - install sudo (2)"
+	default y if CIS_LEVEL_2 || CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5
+	help
+	  Install sudo to permit users to execute command as superuser or as another user.
+
+config CIS_1_3_1_JUSTIFICATION
+	string "justification to enable sudo (2)"
+	depends on !CIS_1_3_1 && (CIS_LEVEL_2 || CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5)
+	help
+	  Provide a reason for enabling sudo to permit users to execute command as superuser or as another user for the current hardening level.
+
+config CIS_1_3_2
+	bool "1.3.2 - pty sudo (2)"
+	default y if CIS_LEVEL_2 || CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5
+	help
+	  Ensure sudo can only be run from a pseudo pty.
+
+config CIS_1_3_2_JUSTIFICATION
+	string "justification to enable pty sudo (2)"
+	depends on !CIS_1_3_2 && (CIS_LEVEL_2 || CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5)
+	help
+	  Provide a reason for enabling sudo can only be run from a pseudo pty for the current hardening level.
+
+config CIS_1_3_3
+	bool "1.3.3 - logfile sudo (2)"
+	default y if CIS_LEVEL_2 || CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5
+	help
+	  Ensure sudo log files exists.
+
+config CIS_1_3_3_JUSTIFICATION
+	string "justification to enable logfile sudo (2)"
+	depends on !CIS_1_3_3 && (CIS_LEVEL_2 || CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5)
+	help
+	  Provide a reason for enabling sudo log files exists for the current hardening level.
+
+endmenu
+
+menu "1.4 Secure Boot Settings"
+
+config CIS_1_4_1
+	bool "1.4.1 - install tripwire (4)"
+	default y if CIS_LEVEL_4 || CIS_LEVEL_5
+	help
+	  Ensure tripwire package is installed.
+
+config CIS_1_4_1_JUSTIFICATION
+	string "justification to enable tripwire (4)"
+	depends on !CIS_1_4_1 && (CIS_LEVEL_4 || CIS_LEVEL_5)
+	help
+	  Provide a reason for enabling tripwire package is installed for the current hardening level.
+
+config CIS_1_4_2
+	bool "1.4.2 - tripwire cron (4)"
+	default y if CIS_LEVEL_4 || CIS_LEVEL_5
+	help
+	  Implemet periodic execution of file integrity.
+
+config CIS_1_4_2_JUSTIFICATION
+	string "justification to enable tripwire cron (4)"
+	depends on !CIS_1_4_2 && (CIS_LEVEL_4 || CIS_LEVEL_5)
+	help
+	  Provide a reason for enabling periodic execution of file integrity for the current hardening level.
+
+endmenu
+
+menu "1.5 Additional Process Hardening"
+
+config CIS_1_5_1
+	bool "1.5.1 - bootloader ownership (1)"
+	default y if (CIS_LEVEL_1 || CIS_LEVEL_2 || CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5) && CIP_GRUB_BOOTLOADER
+	help
+	  User and group root owner of grub bootloader config.
+
+config CIS_1_5_1_JUSTIFICATION
+	string "justification to enable bootloader ownership (1)"
+	depends on !CIS_1_5_1 && (CIS_LEVEL_1 || CIS_LEVEL_2 || CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5)
+	default "Not applicable: the GRUB bootloader is not used." if !CIP_GRUB_BOOTLOADER
+	help
+	  Provide a reason for enabling User and group root owner of grub bootloader config for the current hardening level.
+
+config CIS_1_5_2
+	bool "1.5.2 - bootloader password (3)"
+	default y if CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5
+	help
+	  Setting bootloader password to secure boot parameters.
+
+config CIS_1_5_2_JUSTIFICATION
+	string "justification to enable bootloader password (3)"
+	depends on !CIS_1_5_2 && (CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5)
+	help
+	  Provide a reason for enabling Setting bootloader password to secure boot parameters for the current hardening level.
+
+config CIS_1_5_3
+	bool "1.5.3 - root password (3)"
+	default y if CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5
+	help
+	  Root password for single user mode.
+
+config CIS_1_5_3_JUSTIFICATION
+	string "justification to enable root password (3)"
+	depends on !CIS_1_5_3 && (CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5)
+	help
+	  Provide a reason for enabling Root password for single user mode for the current hardening level.
+
+endmenu
+
+menu "1.6 Mandatory Access Control"
+
+config CIS_1_6_1
+	bool "1.6.1 - enable nx support (2)"
+	default y if CIS_LEVEL_2 || CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5
+	help
+	  Enable NoExecute/ExecuteDisable to prevent buffer overflow attacks.
+
+config CIS_1_6_1_JUSTIFICATION
+	string "justification to enable nx support (2)"
+	depends on !CIS_1_6_1 && (CIS_LEVEL_2 || CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5)
+	help
+	  Provide a reason for enabling NoExecute/ExecuteDisable to prevent buffer overflow attacks for the current hardening level.
+
+config CIS_1_6_2
+	bool "1.6.2 - enable randomized vm placement (2)"
+	default y if CIS_LEVEL_2 || CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5
+	help
+	  Enable Randomized Virtual Memory Region Placement to prevent memory page exploits.
+
+config CIS_1_6_2_JUSTIFICATION
+	string "justification to enable randomized vm placement (2)"
+	depends on !CIS_1_6_2 && (CIS_LEVEL_2 || CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5)
+	help
+	  Provide a reason for enabling Randomized Virtual Memory Region Placement to prevent memory page exploits for the current hardening level.
+
+config CIS_1_6_3
+	bool "1.6.3 - disable prelink (2)"
+	default y if CIS_LEVEL_2 || CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5
+	help
+	  Disable prelink to prevent libraries compromission.
+
+config CIS_1_6_3_JUSTIFICATION
+	string "justification to enable prelink (2)"
+	depends on !CIS_1_6_3 && (CIS_LEVEL_2 || CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5)
+	help
+	  Provide a reason for enabling prelink to prevent libraries compromission for the current hardening level.
+
+config CIS_1_6_3_1
+	bool "1.6.3.1 - disable apport (2)"
+	default y if CIS_LEVEL_2 || CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5
+	help
+	  Disable apport to avoid confidential data leaks.
+
+config CIS_1_6_3_1_JUSTIFICATION
+	string "justification to enable apport (2)"
+	depends on !CIS_1_6_3_1 && (CIS_LEVEL_2 || CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5)
+	help
+	  Provide a reason for enabling apport to avoid confidential data leaks for the current hardening level.
+
+config CIS_1_6_4
+	bool "1.6.4 - restrict core dumps (2)"
+	default y if CIS_LEVEL_2 || CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5
+	help
+	  Restrict core dumps.
+
+config CIS_1_6_4_JUSTIFICATION
+	string "justification to enable core dumps (2)"
+	depends on !CIS_1_6_4 && (CIS_LEVEL_2 || CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5)
+	help
+	  Provide a reason for enabling core dumps for the current hardening level.
+
+endmenu
+
+menu "1.7 CLI Warning Banners"
+
+config CIS_1_7_1_1
+	bool "1.7.1.1 - install apparmor (3)"
+	default y if CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5
+	help
+	  Install AppArmor.
+
+config CIS_1_7_1_1_JUSTIFICATION
+	string "justification to enable apparmor (3)"
+	depends on !CIS_1_7_1_1 && (CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5)
+	help
+	  Provide a reason for enabling AppArmor for the current hardening level.
+
+config CIS_1_7_1_2
+	bool "1.7.1.2 - enable apparmor (3)"
+	default y if CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5
+	help
+	  Activate AppArmor to enforce permissions control.
+
+config CIS_1_7_1_2_JUSTIFICATION
+	string "justification to enable apparmor (3)"
+	depends on !CIS_1_7_1_2 && (CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5)
+	help
+	  Provide a reason for enabling AppArmor to enforce permissions control for the current hardening level.
+
+config CIS_1_7_1_3
+	bool "1.7.1.3 - enforce or complain apparmor (3)"
+	default y if CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5
+	help
+	  Enforce or complain AppArmor profiles.
+
+config CIS_1_7_1_3_JUSTIFICATION
+	string "justification to enable or complain apparmor (3)"
+	depends on !CIS_1_7_1_3 && (CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5)
+	help
+	  Provide a reason for enabling or complain AppArmor profiles for the current hardening level.
+
+config CIS_1_7_1_4
+	bool "1.7.1.4 - enforcing apparmor (3)"
+	default y if CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5
+	help
+	  Enforce Apparmor profiles.
+
+config CIS_1_7_1_4_JUSTIFICATION
+	string "justification to enable enforcing apparmor (3)"
+	depends on !CIS_1_7_1_4 && (CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5)
+	help
+	  Provide a reason for enabling Apparmor profiles for the current hardening level.
+
+endmenu
+
+menu "1.8 Gnome Display Manager"
+
+config CIS_1_8_1_1
+	bool "1.8.1.1 - remove os info motd (3)"
+	default y if CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5
+	help
+	  Remove OS information from motd
+
+config CIS_1_8_1_1_JUSTIFICATION
+	string "justification to enable os info motd (3)"
+	depends on !CIS_1_8_1_1 && (CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5)
+	help
+	  Provide a reason for enabling OS information from motd for the current hardening level.
+
+config CIS_1_8_1_2
+	bool "1.8.1.2 - remove os info issue (3)"
+	default y if CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5
+	help
+	  Remove OS information from Login Warning Banners.
+
+config CIS_1_8_1_2_JUSTIFICATION
+	string "justification to enable os info issue (3)"
+	depends on !CIS_1_8_1_2 && (CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5)
+	help
+	  Provide a reason for enabling OS information from Login Warning Banners for the current hardening level.
+
+config CIS_1_8_1_3
+	bool "1.8.1.3 - remove os info issue net (3)"
+	default y if CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5
+	help
+	  Remove OS information from remote Login Warning Banners.
+
+config CIS_1_8_1_3_JUSTIFICATION
+	string "justification to enable os info issue net (3)"
+	depends on !CIS_1_8_1_3 && (CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5)
+	help
+	  Provide a reason for enabling OS information from remote Login Warning Banners for the current hardening level.
+
+config CIS_1_8_1_4
+	bool "1.8.1.4 - motd perms (3)"
+	default y if CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5
+	help
+	  Checking root ownership and 644 permissions on banner files: /etc/motd|issue|issue.net .
+
+config CIS_1_8_1_4_JUSTIFICATION
+	string "justification to enable motd perms (3)"
+	depends on !CIS_1_8_1_4 && (CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5)
+	help
+	  Provide a reason for enabling root ownership and 644 permissions on banner files: /etc/motd|issue|issue.net  for the current hardening level.
+
+config CIS_1_8_1_5
+	bool "1.8.1.5 - etc issue perms (3)"
+	default y if CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5
+	help
+	  Checking root ownership and 644 permissions on banner files: /etc/motd|issue|issue.net .
+
+config CIS_1_8_1_5_JUSTIFICATION
+	string "justification to enable etc issue perms (3)"
+	depends on !CIS_1_8_1_5 && (CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5)
+	help
+	  Provide a reason for enabling root ownership and 644 permissions on banner files: /etc/motd|issue|issue.net  for the current hardening level.
+
+config CIS_1_8_1_6
+	bool "1.8.1.6 - etc issue net perms (3)"
+	default y if CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5
+	help
+	  Checking root ownership and 644 permissions on banner files: /etc/motd|issue|issue.net .
+
+config CIS_1_8_1_6_JUSTIFICATION
+	string "justification to enable etc issue net perms (3)"
+	depends on !CIS_1_8_1_6 && (CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5)
+	help
+	  Provide a reason for enabling root ownership and 644 permissions on banner files: /etc/motd|issue|issue.net  for the current hardening level.
+
+config CIS_1_8_2
+	bool "1.8.2 - graphical warning banners (3)"
+	default y if CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5
+	help
+	  Set graphical warning banner.
+
+config CIS_1_8_2_JUSTIFICATION
+	string "justification to enable graphical warning banners (3)"
+	depends on !CIS_1_8_2 && (CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5)
+	help
+	  Provide a reason for enabling graphical warning banner for the current hardening level.
+
+endmenu
+
+endmenu
+
+menu "2 Services"
+
+menu "2.1 Time Synchronization"
+
+config CIS_2_1_1
+	bool "2.1.1 - disable xinetd (3)"
+	default y if CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5
+	help
+	  Ensure xinetd is not enabled.
+
+config CIS_2_1_1_JUSTIFICATION
+	string "justification to enable xinetd (3)"
+	depends on !CIS_2_1_1 && (CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5)
+	help
+	  Provide a reason for enabling xinetd is not enabled for the current hardening level.
+
+config CIS_2_1_2
+	bool "2.1.2 - disable bsd inetd (3)"
+	default y if CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5
+	help
+	  Ensure bsd-inetd is not enabled.
+
+config CIS_2_1_2_JUSTIFICATION
+	string "justification to enable bsd inetd (3)"
+	depends on !CIS_2_1_2 && (CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5)
+	help
+	  Provide a reason for enabling bsd-inetd is not enabled for the current hardening level.
+
+endmenu
+
+menu "2.2 Special Purpose Services"
+
+config CIS_2_2_1_1
+	bool "2.2.1.1 - use time sync (3)"
+	default y if CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5
+	help
+	  Ensure a single time synchronization is in use
+
+config CIS_2_2_1_1_JUSTIFICATION
+	string "justification to enable time sync (3)"
+	depends on !CIS_2_2_1_1 && (CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5)
+	help
+	  Provide a reason for enabling a single time synchronization is in use for the current hardening level.
+
+config CIS_2_2_1_2
+	bool "2.2.1.2 - configure systemd-timesyncd (4)"
+	default y if CIS_LEVEL_4 || CIS_LEVEL_5
+	help
+	  Configure systemd-timesyncd.
+
+config CIS_2_2_1_2_JUSTIFICATION
+	string "justification to enable systemd-timesyncd (4)"
+	depends on !CIS_2_2_1_2 && (CIS_LEVEL_4 || CIS_LEVEL_5)
+	help
+	  Provide a reason for enabling systemd-timesyncd for the current hardening level.
+
+config CIS_2_2_1_3
+	bool "2.2.1.3 - configure chrony (3)"
+	default y if CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5
+	help
+	  Configure Network Time Protocol (ntp). Check restrict parameters and ntp daemon runs ad unprivileged user.
+
+config CIS_2_2_1_3_JUSTIFICATION
+	string "justification to enable chrony (3)"
+	depends on !CIS_2_2_1_3 && (CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5)
+	help
+	  Provide a reason for enabling Network Time Protocol (ntp). Check restrict parameters and ntp daemon runs ad unprivileged user for the current hardening level.
+
+config CIS_2_2_1_4
+	bool "2.2.1.4 - configure ntp (3)"
+	default y if CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5
+	help
+	  Configure Network Time Protocol (ntp). Check restrict parameters and ntp daemon runs ad unprivileged user.
+
+config CIS_2_2_1_4_JUSTIFICATION
+	string "justification to enable ntp (3)"
+	depends on !CIS_2_2_1_4 && (CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5)
+	help
+	  Provide a reason for enabling Network Time Protocol (ntp). Check restrict parameters and ntp daemon runs ad unprivileged user for the current hardening level.
+
+config CIS_2_2_2
+	bool "2.2.2 - disable xwindow system (3)"
+	default y if CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5
+	help
+	  Ensure the X Window system is not installed.
+
+config CIS_2_2_2_JUSTIFICATION
+	string "justification to enable xwindow system (3)"
+	depends on !CIS_2_2_2 && (CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5)
+	help
+	  Provide a reason for enabling the X Window system is not installed for the current hardening level.
+
+config CIS_2_2_3
+	bool "2.2.3 - disable avahi server (3)"
+	default y if CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5
+	help
+	  Ensure Avahi server is not enabled.
+
+config CIS_2_2_3_JUSTIFICATION
+	string "justification to enable avahi server (3)"
+	depends on !CIS_2_2_3 && (CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5)
+	help
+	  Provide a reason for enabling Avahi server is not enabled for the current hardening level.
+
+config CIS_2_2_4
+	bool "2.2.4 - disable print server (3)"
+	default y if CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5
+	help
+	  Ensure print server (Common Unix Print System) is not enabled.
+
+config CIS_2_2_4_JUSTIFICATION
+	string "justification to enable print server (3)"
+	depends on !CIS_2_2_4 && (CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5)
+	help
+	  Provide a reason for enabling print server (Common Unix Print System) is not enabled for the current hardening level.
+
+config CIS_2_2_5
+	bool "2.2.5 - disable dhcp (3)"
+	default y if CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5
+	help
+	  Ensure DHCP server is not enabled.
+
+config CIS_2_2_5_JUSTIFICATION
+	string "justification to enable dhcp (3)"
+	depends on !CIS_2_2_5 && (CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5)
+	help
+	  Provide a reason for enabling DHCP server is not enabled for the current hardening level.
+
+config CIS_2_2_6
+	bool "2.2.6 - disable ldap (3)"
+	default y if CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5
+	help
+	  Ensure LDAP is not enabled.
+
+config CIS_2_2_6_JUSTIFICATION
+	string "justification to enable ldap (3)"
+	depends on !CIS_2_2_6 && (CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5)
+	help
+	  Provide a reason for enabling LDAP is not enabled for the current hardening level.
+
+config CIS_2_2_7
+	bool "2.2.7 - disable nfs rpc (3)"
+	default y if CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5
+	help
+	  Ensure Network File System (nfs) and RPC are not enabled.
+
+config CIS_2_2_7_JUSTIFICATION
+	string "justification to enable nfs rpc (3)"
+	depends on !CIS_2_2_7 && (CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5)
+	help
+	  Provide a reason for enabling Network File System (nfs) and RPC are not enabled for the current hardening level.
+
+config CIS_2_2_8
+	bool "2.2.8 - disable dns server (3)"
+	default y if CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5
+	help
+	  Ensure Domain Name System (dns) server is not enabled.
+
+config CIS_2_2_8_JUSTIFICATION
+	string "justification to enable dns server (3)"
+	depends on !CIS_2_2_8 && (CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5)
+	help
+	  Provide a reason for enabling Domain Name System (dns) server is not enabled for the current hardening level.
+
+config CIS_2_2_9
+	bool "2.2.9 - disable ftp (3)"
+	default y if CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5
+	help
+	  Ensure File Transfer Protocol (ftp) is not enabled.
+
+config CIS_2_2_9_JUSTIFICATION
+	string "justification to enable ftp (3)"
+	depends on !CIS_2_2_9 && (CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5)
+	help
+	  Provide a reason for enabling File Transfer Protocol (ftp) is not enabled for the current hardening level.
+
+config CIS_2_2_10
+	bool "2.2.10 - disable http server (3)"
+	default y if CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5
+	help
+	  Ensure HTTP server is not enabled.
+
+config CIS_2_2_10_JUSTIFICATION
+	string "justification to enable http server (3)"
+	depends on !CIS_2_2_10 && (CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5)
+	help
+	  Provide a reason for enabling HTTP server is not enabled for the current hardening level.
+
+config CIS_2_2_11
+	bool "2.2.11 - disable imap pop (3)"
+	default y if CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5
+	help
+	  Ensure IMAP and POP servers are not installed
+
+config CIS_2_2_11_JUSTIFICATION
+	string "justification to enable imap pop (3)"
+	depends on !CIS_2_2_11 && (CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5)
+	help
+	  Provide a reason for enabling IMAP and POP servers are not installed for the current hardening level.
+
+config CIS_2_2_12
+	bool "2.2.12 - disable samba (3)"
+	default y if CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5
+	help
+	  Ensure Samba is not enabled.
+
+config CIS_2_2_12_JUSTIFICATION
+	string "justification to enable samba (3)"
+	depends on !CIS_2_2_12 && (CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5)
+	help
+	  Provide a reason for enabling Samba is not enabled for the current hardening level.
+
+config CIS_2_2_13
+	bool "2.2.13 - disable http proxy (3)"
+	default y if CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5
+	help
+	  Ensure HTTP-proxy is not enabled.
+
+config CIS_2_2_13_JUSTIFICATION
+	string "justification to enable http proxy (3)"
+	depends on !CIS_2_2_13 && (CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5)
+	help
+	  Provide a reason for enabling HTTP-proxy is not enabled for the current hardening level.
+
+config CIS_2_2_14
+	bool "2.2.14 - disable snmp server (3)"
+	default y if CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5
+	help
+	  Enure SNMP server is not enabled.
+
+config CIS_2_2_14_JUSTIFICATION
+	string "justification to enable snmp server (3)"
+	depends on !CIS_2_2_14 && (CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5)
+	help
+	  Provide a reason for enabling Enure SNMP server is not enabled for the current hardening level.
+
+config CIS_2_2_15
+	bool "2.2.15 - mta localhost (3)"
+	default y if CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5
+	help
+	  Configure Mail Transfert Agent for Local-Only Mode.
+
+config CIS_2_2_15_JUSTIFICATION
+	string "justification to enable mta localhost (3)"
+	depends on !CIS_2_2_15 && (CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5)
+	help
+	  Provide a reason for enabling Mail Transfert Agent for Local-Only Mode for the current hardening level.
+
+config CIS_2_2_16
+	bool "2.2.16 - disable rsync (3)"
+	default y if CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5
+	help
+	  Ensure rsync service is not enabled.
+
+config CIS_2_2_16_JUSTIFICATION
+	string "justification to enable rsync (3)"
+	depends on !CIS_2_2_16 && (CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5)
+	help
+	  Provide a reason for enabling rsync service is not enabled for the current hardening level.
+
+config CIS_2_2_17
+	bool "2.2.17 - disable nis (3)"
+	default y if CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5
+	help
+	  Disable NIS Server.
+
+config CIS_2_2_17_JUSTIFICATION
+	string "justification to enable nis (3)"
+	depends on !CIS_2_2_17 && (CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5)
+	help
+	  Provide a reason for enabling NIS Server for the current hardening level.
+
+endmenu
+
+menu "2.3 Service Clients"
+
+config CIS_2_3_1
+	bool "2.3.1 - disable nis (3)"
+	default y if CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5
+	help
+	  Ensure that Network Information Service is not installed. Recommended alternative : LDAP.
+
+config CIS_2_3_1_JUSTIFICATION
+	string "justification to enable nis (3)"
+	depends on !CIS_2_3_1 && (CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5)
+	help
+	  Provide a reason for enabling that Network Information Service is not installed. Recommended alternative : LDAP for the current hardening level.
+
+config CIS_2_3_2
+	bool "2.3.2 - disable rsh client (2)"
+	default y if CIS_LEVEL_2 || CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5
+	help
+	  Ensure rsh client is not installed, Recommended alternative : ssh.
+
+config CIS_2_3_2_JUSTIFICATION
+	string "justification to enable rsh client (2)"
+	depends on !CIS_2_3_2 && (CIS_LEVEL_2 || CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5)
+	help
+	  Provide a reason for enabling rsh client is not installed, Recommended alternative : ssh for the current hardening level.
+
+config CIS_2_3_3
+	bool "2.3.3 - disable talk client (2)"
+	default y if CIS_LEVEL_2 || CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5
+	help
+	  Ensure talk client is not installed.
+
+config CIS_2_3_3_JUSTIFICATION
+	string "justification to enable talk client (2)"
+	depends on !CIS_2_3_3 && (CIS_LEVEL_2 || CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5)
+	help
+	  Provide a reason for enabling talk client is not installed for the current hardening level.
+
+config CIS_2_3_4
+	bool "2.3.4 - disable telnet client (2)"
+	default y if CIS_LEVEL_2 || CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5
+	help
+	  Ensure telnet client is not installed.
+
+config CIS_2_3_4_JUSTIFICATION
+	string "justification to enable telnet client (2)"
+	depends on !CIS_2_3_4 && (CIS_LEVEL_2 || CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5)
+	help
+	  Provide a reason for enabling telnet client is not installed for the current hardening level.
+
+config CIS_2_3_5
+	bool "2.3.5 - disable ldap client (2)"
+	default y if CIS_LEVEL_2 || CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5
+	help
+	  Ensure ldap client is not installed.
+
+config CIS_2_3_5_JUSTIFICATION
+	string "justification to enable ldap client (2)"
+	depends on !CIS_2_3_5 && (CIS_LEVEL_2 || CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5)
+	help
+	  Provide a reason for enabling ldap client is not installed for the current hardening level.
+
+endmenu
+
+endmenu
+
+menu "3 Network Configuration"
+
+menu "3.1 Protocols and Devices"
+
+config CIS_3_1_1
+	bool "3.1.1 - disable ipv6 (2)"
+	default y if CIS_LEVEL_2 || CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5
+	help
+	  Disable IPv6.
+
+config CIS_3_1_1_JUSTIFICATION
+	string "justification to enable ipv6 (2)"
+	depends on !CIS_3_1_1 && (CIS_LEVEL_2 || CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5)
+	help
+	  Provide a reason for enabling IPv6 for the current hardening level.
+
+config CIS_3_1_2
+	bool "3.1.2 - disable wireless (3)"
+	default y if CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5
+	help
+	  Deactivate wireless interfaces.
+
+config CIS_3_1_2_JUSTIFICATION
+	string "justification to enable wireless (3)"
+	depends on !CIS_3_1_2 && (CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5)
+	help
+	  Provide a reason for enabling wireless interfaces for the current hardening level.
+
+endmenu
+
+menu "3.2 Parameters (Host Only)"
+
+config CIS_3_2_1
+	bool "3.2.1 - disable send packet redirects (2)"
+	default y if CIS_LEVEL_2 || CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5
+	help
+	  Disable send packet redirects to prevent malicious ICMP corruption.
+
+config CIS_3_2_1_JUSTIFICATION
+	string "justification to enable send packet redirects (2)"
+	depends on !CIS_3_2_1 && (CIS_LEVEL_2 || CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5)
+	help
+	  Provide a reason for enabling send packet redirects to prevent malicious ICMP corruption for the current hardening level.
+
+config CIS_3_2_2
+	bool "3.2.2 - disable ip forwarding (3)"
+	default y if CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5
+	help
+	  Disable IP forwarding.
+
+config CIS_3_2_2_JUSTIFICATION
+	string "justification to enable ip forwarding (3)"
+	depends on !CIS_3_2_2 && (CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5)
+	help
+	  Provide a reason for enabling IP forwarding for the current hardening level.
+
+endmenu
+
+menu "3.3 Parameters (Host and Router)"
+
+config CIS_3_3_1
+	bool "3.3.1 - disable source routed packets (2)"
+	default y if CIS_LEVEL_2 || CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5
+	help
+	  Disable source routed packet acceptance.
+
+config CIS_3_3_1_JUSTIFICATION
+	string "justification to enable source routed packets (2)"
+	depends on !CIS_3_3_1 && (CIS_LEVEL_2 || CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5)
+	help
+	  Provide a reason for enabling source routed packet acceptance for the current hardening level.
+
+config CIS_3_3_2
+	bool "3.3.2 - disable icmp redirect (2)"
+	default y if CIS_LEVEL_2 || CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5
+	help
+	  Disable ICMP redirect acceptance to prevent routing table corruption.
+
+config CIS_3_3_2_JUSTIFICATION
+	string "justification to enable icmp redirect (2)"
+	depends on !CIS_3_3_2 && (CIS_LEVEL_2 || CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5)
+	help
+	  Provide a reason for enabling ICMP redirect acceptance to prevent routing table corruption for the current hardening level.
+
+config CIS_3_3_3
+	bool "3.3.3 - disable secure icmp redirect (2)"
+	default y if CIS_LEVEL_2 || CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5
+	help
+	  Disable secure ICMP redirect acceptance to prevent routing tables corruptions.
+
+config CIS_3_3_3_JUSTIFICATION
+	string "justification to enable secure icmp redirect (2)"
+	depends on !CIS_3_3_3 && (CIS_LEVEL_2 || CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5)
+	help
+	  Provide a reason for enabling secure ICMP redirect acceptance to prevent routing tables corruptions for the current hardening level.
+
+config CIS_3_3_4
+	bool "3.3.4 - log martian packets (2)"
+	default y if CIS_LEVEL_2 || CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5
+	help
+	  Log suspicious packets, like spoofed packets.
+
+config CIS_3_3_4_JUSTIFICATION
+	string "justification to enable martian packets (2)"
+	depends on !CIS_3_3_4 && (CIS_LEVEL_2 || CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5)
+	help
+	  Provide a reason for enabling suspicious packets, like spoofed packets for the current hardening level.
+
+config CIS_3_3_5
+	bool "3.3.5 - ignore broadcast requests (2)"
+	default y if CIS_LEVEL_2 || CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5
+	help
+	  Ignore broadcast requests to prevent attacks such as Smurf attack.
+
+config CIS_3_3_5_JUSTIFICATION
+	string "justification to enable ignore broadcast requests (2)"
+	depends on !CIS_3_3_5 && (CIS_LEVEL_2 || CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5)
+	help
+	  Provide a reason for enabling Ignore broadcast requests to prevent attacks such as Smurf attack for the current hardening level.
+
+config CIS_3_3_6
+	bool "3.3.6 - enable bad error message protection (2)"
+	default y if CIS_LEVEL_2 || CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5
+	help
+	  Enable bad error message protection to prevent logfiles fillup.
+
+config CIS_3_3_6_JUSTIFICATION
+	string "justification to enable bad error message protection (2)"
+	depends on !CIS_3_3_6 && (CIS_LEVEL_2 || CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5)
+	help
+	  Provide a reason for enabling bad error message protection to prevent logfiles fillup for the current hardening level.
+
+config CIS_3_3_7
+	bool "3.3.7 - enable source route validation (2)"
+	default y if CIS_LEVEL_2 || CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5
+	help
+	  Enable RFC-recommended source route validation.
+
+config CIS_3_3_7_JUSTIFICATION
+	string "justification to enable source route validation (2)"
+	depends on !CIS_3_3_7 && (CIS_LEVEL_2 || CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5)
+	help
+	  Provide a reason for enabling RFC-recommended source route validation for the current hardening level.
+
+config CIS_3_3_8
+	bool "3.3.8 - enable tcp syn cookies (2)"
+	default y if CIS_LEVEL_2 || CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5
+	help
+	  Enable TCP-SYN cookie to prevent TCP-SYN flood attack.
+
+config CIS_3_3_8_JUSTIFICATION
+	string "justification to enable tcp syn cookies (2)"
+	depends on !CIS_3_3_8 && (CIS_LEVEL_2 || CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5)
+	help
+	  Provide a reason for enabling TCP-SYN cookie to prevent TCP-SYN flood attack for the current hardening level.
+
+config CIS_3_3_9
+	bool "3.3.9 - disable ipv6 router advertisement (2)"
+	default y if CIS_LEVEL_2 || CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5
+	help
+	  Disable IPv6 router advertisements.
+
+config CIS_3_3_9_JUSTIFICATION
+	string "justification to enable ipv6 router advertisement (2)"
+	depends on !CIS_3_3_9 && (CIS_LEVEL_2 || CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5)
+	help
+	  Provide a reason for enabling IPv6 router advertisements for the current hardening level.
+
+endmenu
+
+menu "3.5 Firewall"
+
+config CIS_3_5_1_1
+	bool "3.5.1.1 - enable firewall (2)"
+	default y if CIS_LEVEL_2 || CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5
+	help
+	  Ensure firewall is active (either nftables or iptables is installed, does not check for its configuration).
+
+config CIS_3_5_1_1_JUSTIFICATION
+	string "justification to enable firewall (2)"
+	depends on !CIS_3_5_1_1 && (CIS_LEVEL_2 || CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5)
+	help
+	  Provide a reason for enabling firewall is active (either nftables or iptables is installed, does not check for its configuration) for the current hardening level.
+
+config CIS_3_5_4_1_1
+	bool "3.5.4.1.1 - net fw default policy drop (2)"
+	default y if CIS_LEVEL_2 || CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5
+	help
+	  Check iptables firewall default policy for DROP on INPUT and FORWARD.
+
+config CIS_3_5_4_1_1_JUSTIFICATION
+	string "justification to enable net fw default policy drop (2)"
+	depends on !CIS_3_5_4_1_1 && (CIS_LEVEL_2 || CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5)
+	help
+	  Provide a reason for enabling iptables firewall default policy for DROP on INPUT and FORWARD for the current hardening level.
+
+endmenu
+
+endmenu
+
+menu "4 Logging and Auditing"
+
+menu "4.1 System Accounting (auditd)"
+
+config CIS_4_1_1_1
+	bool "4.1.1.1 - install auditd (4)"
+	default y if CIS_LEVEL_4 || CIS_LEVEL_5
+	help
+	  Install auditd.
+
+config CIS_4_1_1_1_JUSTIFICATION
+	string "justification to enable auditd (4)"
+	depends on !CIS_4_1_1_1 && (CIS_LEVEL_4 || CIS_LEVEL_5)
+	help
+	  Provide a reason for enabling auditd for the current hardening level.
+
+config CIS_4_1_1_2
+	bool "4.1.1.2 - enable auditd (4)"
+	default y if CIS_LEVEL_4 || CIS_LEVEL_5
+	help
+	  Ensure auditd service is installed and running.
+
+config CIS_4_1_1_2_JUSTIFICATION
+	string "justification to enable auditd (4)"
+	depends on !CIS_4_1_1_2 && (CIS_LEVEL_4 || CIS_LEVEL_5)
+	help
+	  Provide a reason for enabling auditd service is installed and running for the current hardening level.
+
+config CIS_4_1_1_3
+	bool "4.1.1.3 - audit bootloader (4)"
+	default y if CIS_LEVEL_4 || CIS_LEVEL_5
+	help
+	  Enable auditing for processes that start prior to auditd.
+
+config CIS_4_1_1_3_JUSTIFICATION
+	string "justification to enable audit bootloader (4)"
+	depends on !CIS_4_1_1_3 && (CIS_LEVEL_4 || CIS_LEVEL_5)
+	help
+	  Provide a reason for enabling auditing for processes that start prior to auditd for the current hardening level.
+
+config CIS_4_1_1_4
+	bool "4.1.1.4 - audit backlog limit (4)"
+	default y if CIS_LEVEL_4 || CIS_LEVEL_5
+	help
+	  Configure audit_backlog_limit to be sufficient.
+
+config CIS_4_1_1_4_JUSTIFICATION
+	string "justification to enable audit backlog limit (4)"
+	depends on !CIS_4_1_1_4 && (CIS_LEVEL_4 || CIS_LEVEL_5)
+	help
+	  Provide a reason for enabling audit_backlog_limit to be sufficient for the current hardening level.
+
+config CIS_4_1_2_1
+	bool "4.1.2.1 - audit log storage (4)"
+	default y if CIS_LEVEL_4 || CIS_LEVEL_5
+	help
+	  Configure audit log storage size.
+
+config CIS_4_1_2_1_JUSTIFICATION
+	string "justification to enable audit log storage (4)"
+	depends on !CIS_4_1_2_1 && (CIS_LEVEL_4 || CIS_LEVEL_5)
+	help
+	  Provide a reason for enabling audit log storage size for the current hardening level.
+
+config CIS_4_1_2_2
+	bool "4.1.2.2 - halt when audit log full (4)"
+	default y if CIS_LEVEL_4 || CIS_LEVEL_5
+	help
+	  Disable system on audit log full.
+
+config CIS_4_1_2_2_JUSTIFICATION
+	string "justification to enable when audit log full (4)"
+	depends on !CIS_4_1_2_2 && (CIS_LEVEL_4 || CIS_LEVEL_5)
+	help
+	  Provide a reason for enabling system on audit log full for the current hardening level.
+
+config CIS_4_1_2_3
+	bool "4.1.2.3 - keep all audit logs (4)"
+	default y if CIS_LEVEL_4 || CIS_LEVEL_5
+	help
+	  Keep all auditing information.
+
+config CIS_4_1_2_3_JUSTIFICATION
+	string "justification to enable all audit logs (4)"
+	depends on !CIS_4_1_2_3 && (CIS_LEVEL_4 || CIS_LEVEL_5)
+	help
+	  Provide a reason for enabling all auditing information for the current hardening level.
+
+config CIS_4_1_3
+	bool "4.1.3 - record date time edit (4)"
+	default y if CIS_LEVEL_4 || CIS_LEVEL_5
+	help
+	  Record events that modify date and time information.
+
+config CIS_4_1_3_JUSTIFICATION
+	string "justification to enable date time edit (4)"
+	depends on !CIS_4_1_3 && (CIS_LEVEL_4 || CIS_LEVEL_5)
+	help
+	  Provide a reason for enabling events that modify date and time information for the current hardening level.
+
+config CIS_4_1_4
+	bool "4.1.4 - record user group edit (4)"
+	default y if CIS_LEVEL_4 || CIS_LEVEL_5
+	help
+	  Record events that modify user/group information.
+
+config CIS_4_1_4_JUSTIFICATION
+	string "justification to enable user group edit (4)"
+	depends on !CIS_4_1_4 && (CIS_LEVEL_4 || CIS_LEVEL_5)
+	help
+	  Provide a reason for enabling events that modify user/group information for the current hardening level.
+
+config CIS_4_1_5
+	bool "4.1.5 - record network edit (4)"
+	default y if CIS_LEVEL_4 || CIS_LEVEL_5
+	help
+	  Record events that modify the system's network environment.
+
+config CIS_4_1_5_JUSTIFICATION
+	string "justification to enable network edit (4)"
+	depends on !CIS_4_1_5 && (CIS_LEVEL_4 || CIS_LEVEL_5)
+	help
+	  Provide a reason for enabling events that modify the system's network environment for the current hardening level.
+
+config CIS_4_1_6
+	bool "4.1.6 - record mac edit (4)"
+	default y if CIS_LEVEL_4 || CIS_LEVEL_5
+	help
+	  Record events that modify the system's mandatory access controls (MAC).
+
+config CIS_4_1_6_JUSTIFICATION
+	string "justification to enable mac edit (4)"
+	depends on !CIS_4_1_6 && (CIS_LEVEL_4 || CIS_LEVEL_5)
+	help
+	  Provide a reason for enabling events that modify the system's mandatory access controls (MAC) for the current hardening level.
+
+config CIS_4_1_7
+	bool "4.1.7 - record login logout (4)"
+	default y if CIS_LEVEL_4 || CIS_LEVEL_5
+	help
+	  Collect login and logout events.
+
+config CIS_4_1_7_JUSTIFICATION
+	string "justification to enable login logout (4)"
+	depends on !CIS_4_1_7 && (CIS_LEVEL_4 || CIS_LEVEL_5)
+	help
+	  Provide a reason for enabling login and logout events for the current hardening level.
+
+config CIS_4_1_8
+	bool "4.1.8 - record session init (4)"
+	default y if CIS_LEVEL_4 || CIS_LEVEL_5
+	help
+	  Collec sessions initiation information.
+
+config CIS_4_1_8_JUSTIFICATION
+	string "justification to enable session init (4)"
+	depends on !CIS_4_1_8 && (CIS_LEVEL_4 || CIS_LEVEL_5)
+	help
+	  Provide a reason for enabling Collec sessions initiation information for the current hardening level.
+
+config CIS_4_1_9
+	bool "4.1.9 - record dac edit (4)"
+	default y if CIS_LEVEL_4 || CIS_LEVEL_5
+	help
+	  Collect discretionary access control (DAC) permission modification events.
+
+config CIS_4_1_9_JUSTIFICATION
+	string "justification to enable dac edit (4)"
+	depends on !CIS_4_1_9 && (CIS_LEVEL_4 || CIS_LEVEL_5)
+	help
+	  Provide a reason for enabling discretionary access control (DAC) permission modification events for the current hardening level.
+
+config CIS_4_1_10
+	bool "4.1.10 - record failed access file (4)"
+	default y if CIS_LEVEL_4 || CIS_LEVEL_5
+	help
+	  Collect unsuccessful unauthorized access attemps to files.
+
+config CIS_4_1_10_JUSTIFICATION
+	string "justification to enable failed access file (4)"
+	depends on !CIS_4_1_10 && (CIS_LEVEL_4 || CIS_LEVEL_5)
+	help
+	  Provide a reason for enabling unsuccessful unauthorized access attemps to files for the current hardening level.
+
+config CIS_4_1_11
+	bool "4.1.11 - record privileged commands (4)"
+	default y if CIS_LEVEL_4 || CIS_LEVEL_5
+	help
+	  Collect use of privileged commands.
+
+config CIS_4_1_11_JUSTIFICATION
+	string "justification to enable privileged commands (4)"
+	depends on !CIS_4_1_11 && (CIS_LEVEL_4 || CIS_LEVEL_5)
+	help
+	  Provide a reason for enabling use of privileged commands for the current hardening level.
+
+config CIS_4_1_12
+	bool "4.1.12 - record successful mount (4)"
+	default y if CIS_LEVEL_4 || CIS_LEVEL_5
+	help
+	  Collect sucessfull file system mounts.
+
+config CIS_4_1_12_JUSTIFICATION
+	string "justification to enable successful mount (4)"
+	depends on !CIS_4_1_12 && (CIS_LEVEL_4 || CIS_LEVEL_5)
+	help
+	  Provide a reason for enabling sucessfull file system mounts for the current hardening level.
+
+config CIS_4_1_13
+	bool "4.1.13 - record file deletions (4)"
+	default y if CIS_LEVEL_4 || CIS_LEVEL_5
+	help
+	  Collects file deletion events by users.
+
+config CIS_4_1_13_JUSTIFICATION
+	string "justification to enable file deletions (4)"
+	depends on !CIS_4_1_13 && (CIS_LEVEL_4 || CIS_LEVEL_5)
+	help
+	  Provide a reason for enabling Collects file deletion events by users for the current hardening level.
+
+config CIS_4_1_14
+	bool "4.1.14 - record sudoers edit (4)"
+	default y if CIS_LEVEL_4 || CIS_LEVEL_5
+	help
+	  Collect changes to system administration scopre.
+
+config CIS_4_1_14_JUSTIFICATION
+	string "justification to enable sudoers edit (4)"
+	depends on !CIS_4_1_14 && (CIS_LEVEL_4 || CIS_LEVEL_5)
+	help
+	  Provide a reason for enabling changes to system administration scopre for the current hardening level.
+
+config CIS_4_1_15
+	bool "4.1.15 - record sudo usage (4)"
+	default y if CIS_LEVEL_4 || CIS_LEVEL_5
+	help
+	  Collect system administration actions (sudolog).
+
+config CIS_4_1_15_JUSTIFICATION
+	string "justification to enable sudo usage (4)"
+	depends on !CIS_4_1_15 && (CIS_LEVEL_4 || CIS_LEVEL_5)
+	help
+	  Provide a reason for enabling system administration actions (sudolog) for the current hardening level.
+
+config CIS_4_1_16
+	bool "4.1.16 - record kernel modules (4)"
+	default y if CIS_LEVEL_4 || CIS_LEVEL_5
+	help
+	  Collect kernel module loading and unloading.
+
+config CIS_4_1_16_JUSTIFICATION
+	string "justification to enable kernel modules (4)"
+	depends on !CIS_4_1_16 && (CIS_LEVEL_4 || CIS_LEVEL_5)
+	help
+	  Provide a reason for enabling kernel module loading and unloading for the current hardening level.
+
+config CIS_4_1_17
+	bool "4.1.17 - freeze auditd conf (4)"
+	default y if CIS_LEVEL_4 || CIS_LEVEL_5
+	help
+	  Make the audit configuration immutable.
+
+config CIS_4_1_17_JUSTIFICATION
+	string "justification to enable auditd conf (4)"
+	depends on !CIS_4_1_17 && (CIS_LEVEL_4 || CIS_LEVEL_5)
+	help
+	  Provide a reason for enabling the audit configuration immutable for the current hardening level.
+
+endmenu
+
+menu "4.2 Logging"
+
+config CIS_4_2_1_1
+	bool "4.2.1.1 - install syslog-ng (3)"
+	default y if CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5
+	help
+	  Install syslog-ng to manage logs
+
+config CIS_4_2_1_1_JUSTIFICATION
+	string "justification to enable syslog-ng (3)"
+	depends on !CIS_4_2_1_1 && (CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5)
+	help
+	  Provide a reason for enabling syslog-ng to manage logs for the current hardening level.
+
+config CIS_4_2_1_2
+	bool "4.2.1.2 - enable syslog-ng (3)"
+	default y if CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5
+	help
+	  Ensure syslog-ng service is activated.
+
+config CIS_4_2_1_2_JUSTIFICATION
+	string "justification to enable syslog-ng (3)"
+	depends on !CIS_4_2_1_2 && (CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5)
+	help
+	  Provide a reason for enabling syslog-ng service is activated for the current hardening level.
+
+config CIS_4_2_1_3
+	bool "4.2.1.3 - configure syslog-ng (3)"
+	default y if CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5
+	help
+	  Configure /etc/syslog-ng/syslog-ng.conf .
+
+config CIS_4_2_1_3_JUSTIFICATION
+	string "justification to enable syslog-ng (3)"
+	depends on !CIS_4_2_1_3 && (CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5)
+	help
+	  Provide a reason for enabling /etc/syslog-ng/syslog-ng.conf  for the current hardening level.
+
+config CIS_4_2_1_4
+	bool "4.2.1.4 - syslog ng logfiles perm (3)"
+	default y if CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5
+	help
+	  Create and set permissions on syslog-ng logfiles.
+
+config CIS_4_2_1_4_JUSTIFICATION
+	string "justification to enable syslog ng logfiles perm (3)"
+	depends on !CIS_4_2_1_4 && (CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5)
+	help
+	  Provide a reason for enabling and set permissions on syslog-ng logfiles for the current hardening level.
+
+config CIS_4_2_1_5
+	bool "4.2.1.5 - syslog-ng remote host (3)"
+	default y if CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5
+	help
+	  Configure syslog-ng to send logs to a remote log host.
+
+config CIS_4_2_1_5_JUSTIFICATION
+	string "justification to enable syslog-ng remote host (3)"
+	depends on !CIS_4_2_1_5 && (CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5)
+	help
+	  Provide a reason for enabling syslog-ng to send logs to a remote log host for the current hardening level.
+
+config CIS_4_2_1_6
+	bool "4.2.1.6 - remote syslog-ng acl (3)"
+	default y if CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5
+	help
+	  Configure syslog to accept remote syslog messages only on designated log hosts.
+
+config CIS_4_2_1_6_JUSTIFICATION
+	string "justification to enable remote syslog-ng acl (3)"
+	depends on !CIS_4_2_1_6 && (CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5)
+	help
+	  Provide a reason for enabling syslog to accept remote syslog messages only on designated log hosts for the current hardening level.
+
+config CIS_4_2_2_1
+	bool "4.2.2.1 - journald logs (3)"
+	default y if CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5
+	help
+	  Configure journald to send logs to syslog-ng.
+
+config CIS_4_2_2_1_JUSTIFICATION
+	string "justification to enable journald logs (3)"
+	depends on !CIS_4_2_2_1 && (CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5)
+	help
+	  Provide a reason for enabling journald to send logs to syslog-ng for the current hardening level.
+
+config CIS_4_2_2_2
+	bool "4.2.2.2 - journald compress (3)"
+	default y if CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5
+	help
+	  Configure journald to send logs to syslog-ng.
+
+config CIS_4_2_2_2_JUSTIFICATION
+	string "justification to enable journald compress (3)"
+	depends on !CIS_4_2_2_2 && (CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5)
+	help
+	  Provide a reason for enabling journald to send logs to syslog-ng for the current hardening level.
+
+config CIS_4_2_2_3
+	bool "4.2.2.3 - journald write persistent (3)"
+	default y if CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5
+	help
+	  Configure journald to write to a persistent location.
+
+config CIS_4_2_2_3_JUSTIFICATION
+	string "justification to enable journald write persistent (3)"
+	depends on !CIS_4_2_2_3 && (CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5)
+	help
+	  Provide a reason for enabling journald to write to a persistent location for the current hardening level.
+
+config CIS_4_2_3
+	bool "4.2.3 - logs permissions (2)"
+	default y if CIS_LEVEL_2 || CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5
+	help
+	  Check permissions on logs (other has no permissions on any files and group does not have write or execute permissions on any file)
+
+config CIS_4_2_3_JUSTIFICATION
+	string "justification to enable logs permissions (2)"
+	depends on !CIS_4_2_3 && (CIS_LEVEL_2 || CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5)
+	help
+	  Provide a reason for enabling permissions on logs (other has no permissions on any files and group does not have write or execute permissions on any file) for the current hardening level.
+
+endmenu
+
+menu "4.4 Ensure logrotate assigns appropriate permissions"
+
+config CIS_4_4
+	bool "4.4 - logrotate permissions (3)"
+	default y if CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5
+	help
+	  Configure logrotate to assign appropriate permissions.
+
+config CIS_4_4_JUSTIFICATION
+	string "justification to enable logrotate permissions (3)"
+	depends on !CIS_4_4 && (CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5)
+	help
+	  Provide a reason for enabling logrotate to assign appropriate permissions for the current hardening level.
+
+endmenu
+
+endmenu
+
+menu "5 Access and Auth"
+
+menu "5.1 Time-based Job Schedulers"
+
+config CIS_5_1_1
+	bool "5.1.1 - enable cron (3)"
+	default y if CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5
+	help
+	  Cron package is installed and enabled.
+
+config CIS_5_1_1_JUSTIFICATION
+	string "justification to enable cron (3)"
+	depends on !CIS_5_1_1 && (CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5)
+	help
+	  Provide a reason for enabling Cron package is installed and enabled for the current hardening level.
+
+config CIS_5_1_2
+	bool "5.1.2 - crontab perm ownership (1)"
+	default y if (CIS_LEVEL_1 || CIS_LEVEL_2 || CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5) && CIP_CRON
+	help
+	  User/Group set to root and permissions to 600 on /etc/crontab .
+
+config CIS_5_1_2_JUSTIFICATION
+	string "justification to enable crontab perm ownership (1)"
+	depends on !CIS_5_1_2 && (CIS_LEVEL_1 || CIS_LEVEL_2 || CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5)
+	default "Not applicable: cron is not used on this system." if !CIP_CRON
+	help
+	  Provide a reason for enabling User/Group set to root and permissions to 600 on /etc/crontab  for the current hardening level.
+
+config CIS_5_1_3
+	bool "5.1.3 - cron hourly perm ownership (1)"
+	default y if (CIS_LEVEL_1 || CIS_LEVEL_2 || CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5) && CIP_CRON
+	help
+	  User/Group set to root and permissions to 700 on /etc/cron.hourly .
+
+config CIS_5_1_3_JUSTIFICATION
+	string "justification to enable cron hourly perm ownership (1)"
+	depends on !CIS_5_1_3 && (CIS_LEVEL_1 || CIS_LEVEL_2 || CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5)
+	default "Not applicable: cron is not used on this system." if !CIP_CRON
+	help
+	  Provide a reason for enabling User/Group set to root and permissions to 700 on /etc/cron.hourly  for the current hardening level.
+
+config CIS_5_1_4
+	bool "5.1.4 - cron daily perm ownership (1)"
+	default y if (CIS_LEVEL_1 || CIS_LEVEL_2 || CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5) && CIP_CRON
+	help
+	  User/group set to root and permissions to 700 on /etc/cron.daily .
+
+config CIS_5_1_4_JUSTIFICATION
+	string "justification to enable cron daily perm ownership (1)"
+	depends on !CIS_5_1_4 && (CIS_LEVEL_1 || CIS_LEVEL_2 || CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5)
+	default "Not applicable: cron is not used on this system." if !CIP_CRON
+	help
+	  Provide a reason for enabling User/group set to root and permissions to 700 on /etc/cron.daily  for the current hardening level.
+
+config CIS_5_1_5
+	bool "5.1.5 - cron weekly perm ownership (1)"
+	default y if (CIS_LEVEL_1 || CIS_LEVEL_2 || CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5) && CIP_CRON
+	help
+	  User/group set to root and permissions to 700 on /etc/cron.weekly .
+
+config CIS_5_1_5_JUSTIFICATION
+	string "justification to enable cron weekly perm ownership (1)"
+	depends on !CIS_5_1_5 && (CIS_LEVEL_1 || CIS_LEVEL_2 || CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5)
+	default "Not applicable: cron is not used on this system." if !CIP_CRON
+	help
+	  Provide a reason for enabling User/group set to root and permissions to 700 on /etc/cron.weekly  for the current hardening level.
+
+config CIS_5_1_6
+	bool "5.1.6 - cron monthly perm ownership (1)"
+	default y if (CIS_LEVEL_1 || CIS_LEVEL_2 || CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5) && CIP_CRON
+	help
+	  User/group set to root and permissions to 700 on /etc/cron.monthly .
+
+config CIS_5_1_6_JUSTIFICATION
+	string "justification to enable cron monthly perm ownership (1)"
+	depends on !CIS_5_1_6 && (CIS_LEVEL_1 || CIS_LEVEL_2 || CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5)
+	default "Not applicable: cron is not used on this system." if !CIP_CRON
+	help
+	  Provide a reason for enabling User/group set to root and permissions to 700 on /etc/cron.monthly  for the current hardening level.
+
+config CIS_5_1_7
+	bool "5.1.7 - cron d perm ownership (1)"
+	default y if (CIS_LEVEL_1 || CIS_LEVEL_2 || CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5) && CIP_CRON
+	help
+	  User/group set to root and permissions to 700 on /etc/cron.d .
+
+config CIS_5_1_7_JUSTIFICATION
+	string "justification to enable cron d perm ownership (1)"
+	depends on !CIS_5_1_7 && (CIS_LEVEL_1 || CIS_LEVEL_2 || CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5)
+	default "Not applicable: cron is not used on this system." if !CIP_CRON
+	help
+	  Provide a reason for enabling User/group set to root and permissions to 700 on /etc/cron.d  for the current hardening level.
+
+config CIS_5_1_8
+	bool "5.1.8 - cron users (2)"
+	default y if (CIS_LEVEL_2 || CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5) && CIP_CRON
+	help
+	  Restrict at/cron to authorized users.
+
+config CIS_5_1_8_JUSTIFICATION
+	string "justification to enable cron users (2)"
+	depends on !CIS_5_1_8 && (CIS_LEVEL_2 || CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5)
+	default "Not applicable: cron is not used on this system." if !CIP_CRON
+	help
+	  Provide a reason for enabling at/cron to authorized users for the current hardening level.
+
+endmenu
+
+menu "5.2 SSH Server"
+
+config CIS_5_2_1
+	bool "5.2.1 - sshd conf perm ownership (1)"
+	default y if CIS_LEVEL_1 || CIS_LEVEL_2 || CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5
+	help
+	  Checking permissions and ownership to root 600 for sshd_config.
+
+config CIS_5_2_1_JUSTIFICATION
+	string "justification to enable sshd conf perm ownership (1)"
+	depends on !CIS_5_2_1 && (CIS_LEVEL_1 || CIS_LEVEL_2 || CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5)
+	help
+	  Provide a reason for enabling permissions and ownership to root 600 for sshd_config for the current hardening level.
+
+config CIS_5_2_2
+	bool "5.2.2 - ssh host private keys perm ownership (1)"
+	default y if CIS_LEVEL_1 || CIS_LEVEL_2 || CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5
+	help
+	  Checking permissions and ownership to root 600 for ssh private keys. 
+
+config CIS_5_2_2_JUSTIFICATION
+	string "justification to enable ssh host private keys perm ownership (1)"
+	depends on !CIS_5_2_2 && (CIS_LEVEL_1 || CIS_LEVEL_2 || CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5)
+	help
+	  Provide a reason for enabling permissions and ownership to root 600 for ssh private keys.  for the current hardening level.
+
+config CIS_5_2_3
+	bool "5.2.3 - ssh host public keys perm ownership (1)"
+	default y if CIS_LEVEL_1 || CIS_LEVEL_2 || CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5
+	help
+	  Checking permissions and ownership to root 644 for ssh public keys. 
+
+config CIS_5_2_3_JUSTIFICATION
+	string "justification to enable ssh host public keys perm ownership (1)"
+	depends on !CIS_5_2_3 && (CIS_LEVEL_1 || CIS_LEVEL_2 || CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5)
+	help
+	  Provide a reason for enabling permissions and ownership to root 644 for ssh public keys.  for the current hardening level.
+
+config CIS_5_2_4
+	bool "5.2.4 - sshd protocol (2)"
+	default y if CIS_LEVEL_2 || CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5
+	help
+	  Set secure shell (SSH) protocol to 2.
+
+config CIS_5_2_4_JUSTIFICATION
+	string "justification to enable sshd protocol (2)"
+	depends on !CIS_5_2_4 && (CIS_LEVEL_2 || CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5)
+	help
+	  Provide a reason for enabling secure shell (SSH) protocol to 2 for the current hardening level.
+
+config CIS_5_2_5
+	bool "5.2.5 - sshd loglevel (2)"
+	default y if CIS_LEVEL_2 || CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5
+	help
+	  Set LogLevel to INFO for SSH.
+
+config CIS_5_2_5_JUSTIFICATION
+	string "justification to enable sshd loglevel (2)"
+	depends on !CIS_5_2_5 && (CIS_LEVEL_2 || CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5)
+	help
+	  Provide a reason for enabling LogLevel to INFO for SSH for the current hardening level.
+
+config CIS_5_2_6
+	bool "5.2.6 - disable x11 forwarding (2)"
+	default y if CIS_LEVEL_2 || CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5
+	help
+	  Disable SSH X11 forwarding.
+
+config CIS_5_2_6_JUSTIFICATION
+	string "justification to enable x11 forwarding (2)"
+	depends on !CIS_5_2_6 && (CIS_LEVEL_2 || CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5)
+	help
+	  Provide a reason for enabling SSH X11 forwarding for the current hardening level.
+
+config CIS_5_2_7
+	bool "5.2.7 - sshd maxauthtries (2)"
+	default y if CIS_LEVEL_2 || CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5
+	help
+	  Set SSH MaxAuthTries to 4.
+
+config CIS_5_2_7_JUSTIFICATION
+	string "justification to enable sshd maxauthtries (2)"
+	depends on !CIS_5_2_7 && (CIS_LEVEL_2 || CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5)
+	help
+	  Provide a reason for enabling SSH MaxAuthTries to 4 for the current hardening level.
+
+config CIS_5_2_8
+	bool "5.2.8 - enable sshd ignorerhosts (2)"
+	default y if CIS_LEVEL_2 || CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5
+	help
+	  Set SSH IgnoreRhosts to Yes.
+
+config CIS_5_2_8_JUSTIFICATION
+	string "justification to enable sshd ignorerhosts (2)"
+	depends on !CIS_5_2_8 && (CIS_LEVEL_2 || CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5)
+	help
+	  Provide a reason for enabling SSH IgnoreRhosts to Yes for the current hardening level.
+
+config CIS_5_2_9
+	bool "5.2.9 - disable sshd hostbasedauthentication (2)"
+	default y if CIS_LEVEL_2 || CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5
+	help
+	  Set SSH HostbasedAUthentication to No.
+
+config CIS_5_2_9_JUSTIFICATION
+	string "justification to enable sshd hostbasedauthentication (2)"
+	depends on !CIS_5_2_9 && (CIS_LEVEL_2 || CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5)
+	help
+	  Provide a reason for enabling SSH HostbasedAUthentication to No for the current hardening level.
+
+config CIS_5_2_10
+	bool "5.2.10 - disable root login (3)"
+	default y if CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5
+	help
+	  Disable SSH Root Login.
+
+config CIS_5_2_10_JUSTIFICATION
+	string "justification to enable root login (3)"
+	depends on !CIS_5_2_10 && (CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5)
+	help
+	  Provide a reason for enabling SSH Root Login for the current hardening level.
+
+config CIS_5_2_11
+	bool "5.2.11 - disable sshd permitemptypasswords (2)"
+	default y if CIS_LEVEL_2 || CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5
+	help
+	  Set SSH PermitEmptyPasswords to No in order to disallow SSH login to accounts with empty password strigs.
+
+config CIS_5_2_11_JUSTIFICATION
+	string "justification to enable sshd permitemptypasswords (2)"
+	depends on !CIS_5_2_11 && (CIS_LEVEL_2 || CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5)
+	help
+	  Provide a reason for enabling SSH PermitEmptyPasswords to No in order to disallow SSH login to accounts with empty password strigs for the current hardening level.
+
+config CIS_5_2_12
+	bool "5.2.12 - disable sshd setenv (2)"
+	default y if CIS_LEVEL_2 || CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5
+	help
+	  Do not allow users to set environment options.
+
+config CIS_5_2_12_JUSTIFICATION
+	string "justification to enable sshd setenv (2)"
+	depends on !CIS_5_2_12 && (CIS_LEVEL_2 || CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5)
+	help
+	  Provide a reason for enabling users to set environment options for the current hardening level.
+
+config CIS_5_2_13
+	bool "5.2.13 - sshd ciphers (2)"
+	default y if CIS_LEVEL_2 || CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5
+	help
+	  Use only approved ciphers in counter mode (ctr) or Galois counter mode (gcm).
+
+config CIS_5_2_13_JUSTIFICATION
+	string "justification to enable sshd ciphers (2)"
+	depends on !CIS_5_2_13 && (CIS_LEVEL_2 || CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5)
+	help
+	  Provide a reason for enabling only approved ciphers in counter mode (ctr) or Galois counter mode (gcm) for the current hardening level.
+
+config CIS_5_2_14
+	bool "5.2.14 - ssh cry mac (2)"
+	default y if CIS_LEVEL_2 || CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5
+	help
+	  Checking Message Authentication Code ciphers for preferred UMAC and SHA-256|512 with Encrypt-Then-Mac (etm) setting.
+
+config CIS_5_2_14_JUSTIFICATION
+	string "justification to enable ssh cry mac (2)"
+	depends on !CIS_5_2_14 && (CIS_LEVEL_2 || CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5)
+	help
+	  Provide a reason for enabling Message Authentication Code ciphers for preferred UMAC and SHA-256|512 with Encrypt-Then-Mac (etm) setting for the current hardening level.
+
+config CIS_5_2_15
+	bool "5.2.15 - ssh cry kex (2)"
+	default y if CIS_LEVEL_2 || CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5
+	help
+	  Checking key exchange ciphers.
+
+config CIS_5_2_15_JUSTIFICATION
+	string "justification to enable ssh cry kex (2)"
+	depends on !CIS_5_2_15 && (CIS_LEVEL_2 || CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5)
+	help
+	  Provide a reason for enabling key exchange ciphers for the current hardening level.
+
+config CIS_5_2_16
+	bool "5.2.16 - sshd idle timeout (3)"
+	default y if CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5
+	help
+	  Set Idle Timeout Interval for user login.
+
+config CIS_5_2_16_JUSTIFICATION
+	string "justification to enable sshd idle timeout (3)"
+	depends on !CIS_5_2_16 && (CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5)
+	help
+	  Provide a reason for enabling Idle Timeout Interval for user login for the current hardening level.
+
+config CIS_5_2_17
+	bool "5.2.17 - sshd login grace time (3)"
+	default y if CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5
+	help
+	  Set Login Grace Time for user login.
+
+config CIS_5_2_17_JUSTIFICATION
+	string "justification to enable sshd login grace time (3)"
+	depends on !CIS_5_2_17 && (CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5)
+	help
+	  Provide a reason for enabling Login Grace Time for user login for the current hardening level.
+
+config CIS_5_2_18
+	bool "5.2.18 - sshd limit access (3)"
+	default y if CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5
+	help
+	  Limite access via SSH by (dis)allowing specific users or groups.
+
+config CIS_5_2_18_JUSTIFICATION
+	string "justification to enable sshd limit access (3)"
+	depends on !CIS_5_2_18 && (CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5)
+	help
+	  Provide a reason for enabling Limite access via SSH by (dis)allowing specific users or groups for the current hardening level.
+
+config CIS_5_2_19
+	bool "5.2.19 - ssh banner (3)"
+	default y if CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5
+	help
+	  Set ssh banner.
+
+config CIS_5_2_19_JUSTIFICATION
+	string "justification to enable ssh banner (3)"
+	depends on !CIS_5_2_19 && (CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5)
+	help
+	  Provide a reason for enabling ssh banner for the current hardening level.
+
+config CIS_5_2_20
+	bool "5.2.20 - enable ssh pam (3)"
+	default y if CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5
+	help
+	  Enable SSH PAM.
+
+config CIS_5_2_20_JUSTIFICATION
+	string "justification to enable ssh pam (3)"
+	depends on !CIS_5_2_20 && (CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5)
+	help
+	  Provide a reason for enabling SSH PAM for the current hardening level.
+
+config CIS_5_2_21
+	bool "5.2.21 - disable ssh allow tcp forwarding (3)"
+	default y if CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5
+	help
+	  Disable SSH AllowTCPForwarding.
+
+config CIS_5_2_21_JUSTIFICATION
+	string "justification to enable ssh allow tcp forwarding (3)"
+	depends on !CIS_5_2_21 && (CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5)
+	help
+	  Provide a reason for enabling SSH AllowTCPForwarding for the current hardening level.
+
+config CIS_5_2_22
+	bool "5.2.22 - configure ssh max startups (3)"
+	default y if CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5
+	help
+	  Configure SSHMaxStartups.
+
+config CIS_5_2_22_JUSTIFICATION
+	string "justification to enable ssh max startups (3)"
+	depends on !CIS_5_2_22 && (CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5)
+	help
+	  Provide a reason for enabling SSHMaxStartups for the current hardening level.
+
+config CIS_5_2_23
+	bool "5.2.23 - limit ssh max sessions (3)"
+	default y if CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5
+	help
+	  Limit SSH MaxSessions.
+
+config CIS_5_2_23_JUSTIFICATION
+	string "justification to enable ssh max sessions (3)"
+	depends on !CIS_5_2_23 && (CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5)
+	help
+	  Provide a reason for enabling SSH MaxSessions for the current hardening level.
+
+endmenu
+
+menu "5.3 Privilege Escalation"
+
+config CIS_5_3_1
+	bool "5.3.1 - enable pwquality (2)"
+	default y if CIS_LEVEL_2 || CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5
+	help
+	  Set password creation requirement parameters using pam.cracklib.
+
+config CIS_5_3_1_JUSTIFICATION
+	string "justification to enable pwquality (2)"
+	depends on !CIS_5_3_1 && (CIS_LEVEL_2 || CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5)
+	help
+	  Provide a reason for enabling password creation requirement parameters using pam.cracklib for the current hardening level.
+
+config CIS_5_3_2
+	bool "5.3.2 - enable lockout failed password (3)"
+	default y if CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5
+	help
+	  Ensure pam_faillock module is enabled
+
+config CIS_5_3_2_JUSTIFICATION
+	string "justification to enable lockout failed password (3)"
+	depends on !CIS_5_3_2 && (CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5)
+	help
+	  Provide a reason for enabling pam_faillock module is enabled for the current hardening level.
+
+config CIS_5_3_3
+	bool "5.3.3 - limit password reuse (3)"
+	default y if CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5
+	help
+	  Limit password reuse.
+
+config CIS_5_3_3_JUSTIFICATION
+	string "justification to enable password reuse (3)"
+	depends on !CIS_5_3_3 && (CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5)
+	help
+	  Provide a reason for enabling password reuse for the current hardening level.
+
+config CIS_5_3_4
+	bool "5.3.4 - acc pam sha512 (2)"
+	default y if CIS_LEVEL_2 || CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5
+	help
+	  Check that the algorithm declared in PAM for password changes is sha512 (or yescrypt for Debian 11+)
+
+config CIS_5_3_4_JUSTIFICATION
+	string "justification to enable acc pam sha512 (2)"
+	depends on !CIS_5_3_4 && (CIS_LEVEL_2 || CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5)
+	help
+	  Provide a reason for enabling that the algorithm declared in PAM for password changes is sha512 (or yescrypt for Debian 11+) for the current hardening level.
+
+endmenu
+
+menu "5.4 PAM"
+
+config CIS_5_4_1_1
+	bool "5.4.1.1 - set password exp days (3)"
+	default y if CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5
+	help
+	  Set password expiration days.
+
+config CIS_5_4_1_1_JUSTIFICATION
+	string "justification to enable password exp days (3)"
+	depends on !CIS_5_4_1_1 && (CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5)
+	help
+	  Provide a reason for enabling password expiration days for the current hardening level.
+
+config CIS_5_4_1_2
+	bool "5.4.1.2 - set password min days change (3)"
+	default y if CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5
+	help
+	  Set password change minimum number of days.
+
+config CIS_5_4_1_2_JUSTIFICATION
+	string "justification to enable password min days change (3)"
+	depends on !CIS_5_4_1_2 && (CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5)
+	help
+	  Provide a reason for enabling password change minimum number of days for the current hardening level.
+
+config CIS_5_4_1_3
+	bool "5.4.1.3 - set password exp warning days (3)"
+	default y if CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5
+	help
+	  Set password expiration warning days.
+
+config CIS_5_4_1_3_JUSTIFICATION
+	string "justification to enable password exp warning days (3)"
+	depends on !CIS_5_4_1_3 && (CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5)
+	help
+	  Provide a reason for enabling password expiration warning days for the current hardening level.
+
+config CIS_5_4_1_4
+	bool "5.4.1.4 - lock inactive user account (3)"
+	default y if CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5
+	help
+	  Lock inactive user accounts.
+
+config CIS_5_4_1_4_JUSTIFICATION
+	string "justification to enable inactive user account (3)"
+	depends on !CIS_5_4_1_4 && (CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5)
+	help
+	  Provide a reason for enabling inactive user accounts for the current hardening level.
+
+config CIS_5_4_1_5
+	bool "5.4.1.5 - last password change past (3)"
+	default y if CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5
+	help
+	  Check that user last password change date is in the past.
+
+config CIS_5_4_1_5_JUSTIFICATION
+	string "justification to enable last password change past (3)"
+	depends on !CIS_5_4_1_5 && (CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5)
+	help
+	  Provide a reason for enabling that user last password change date is in the past for the current hardening level.
+
+config CIS_5_4_2
+	bool "5.4.2 - disable system accounts (3)"
+	default y if CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5
+	help
+	  Disable system accounts, preventing them from interactive login.
+
+config CIS_5_4_2_JUSTIFICATION
+	string "justification to enable system accounts (3)"
+	depends on !CIS_5_4_2 && (CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5)
+	help
+	  Provide a reason for enabling system accounts, preventing them from interactive login for the current hardening level.
+
+config CIS_5_4_3
+	bool "5.4.3 - default root group (2)"
+	default y if CIS_LEVEL_2 || CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5
+	help
+	  Set default group for root account to 0.
+
+config CIS_5_4_3_JUSTIFICATION
+	string "justification to enable default root group (2)"
+	depends on !CIS_5_4_3 && (CIS_LEVEL_2 || CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5)
+	help
+	  Provide a reason for enabling default group for root account to 0 for the current hardening level.
+
+config CIS_5_4_4
+	bool "5.4.4 - default umask (3)"
+	default y if CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5
+	help
+	  Set default mask for users to 077.
+
+config CIS_5_4_4_JUSTIFICATION
+	string "justification to enable default umask (3)"
+	depends on !CIS_5_4_4 && (CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5)
+	help
+	  Provide a reason for enabling default mask for users to 077 for the current hardening level.
+
+config CIS_5_4_5
+	bool "5.4.5 - default timeout (5)"
+	default y if CIS_LEVEL_5
+	help
+	  Timeout 600 seconds on tty.
+
+config CIS_5_4_5_JUSTIFICATION
+	string "justification to enable default timeout (5)"
+	depends on !CIS_5_4_5 && (CIS_LEVEL_5)
+	help
+	  Provide a reason for enabling Timeout 600 seconds on tty for the current hardening level.
+
+endmenu
+
+menu "5.5 User Accounts and Environment"
+
+config CIS_5_5
+	bool "5.5 - secure tty (3)"
+	default y if CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5
+	help
+	  Restrict root login to system console.
+
+config CIS_5_5_JUSTIFICATION
+	string "justification to enable secure tty (3)"
+	depends on !CIS_5_5 && (CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5)
+	help
+	  Provide a reason for enabling root login to system console for the current hardening level.
+
+endmenu
+
+menu "5.6 Restrict Access to su"
+
+config CIS_5_6
+	bool "5.6 - restrict su (3)"
+	default y if CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5
+	help
+	  Restrict access to su command.
+
+config CIS_5_6_JUSTIFICATION
+	string "justification to enable su (3)"
+	depends on !CIS_5_6 && (CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5)
+	help
+	  Provide a reason for enabling access to su command for the current hardening level.
+
+endmenu
+
+endmenu
+
+menu "6 System Maintenance"
+
+menu "6.1 System File Permissions"
+
+config CIS_6_1_2
+	bool "6.1.2 - etc passwd permissions (1)"
+	default y if CIS_LEVEL_1 || CIS_LEVEL_2 || CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5
+	help
+	  Check 644 permissions and root:root ownership on /etc/passwd
+
+config CIS_6_1_2_JUSTIFICATION
+	string "justification to enable etc passwd permissions (1)"
+	depends on !CIS_6_1_2 && (CIS_LEVEL_1 || CIS_LEVEL_2 || CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5)
+	help
+	  Provide a reason for enabling 644 permissions and root:root ownership on /etc/passwd for the current hardening level.
+
+config CIS_6_1_3
+	bool "6.1.3 - etc gshadow- permissions (1)"
+	default y if CIS_LEVEL_1 || CIS_LEVEL_2 || CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5
+	help
+	  Check 640 permissions and root:root ownership on /etc/gshadow-
+
+config CIS_6_1_3_JUSTIFICATION
+	string "justification to enable etc gshadow- permissions (1)"
+	depends on !CIS_6_1_3 && (CIS_LEVEL_1 || CIS_LEVEL_2 || CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5)
+	help
+	  Provide a reason for enabling 640 permissions and root:root ownership on /etc/gshadow- for the current hardening level.
+
+config CIS_6_1_4
+	bool "6.1.4 - etc shadow permissions (1)"
+	default y if CIS_LEVEL_1 || CIS_LEVEL_2 || CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5
+	help
+	  Check 640 permissions and root:root ownership on /etc/shadow
+
+config CIS_6_1_4_JUSTIFICATION
+	string "justification to enable etc shadow permissions (1)"
+	depends on !CIS_6_1_4 && (CIS_LEVEL_1 || CIS_LEVEL_2 || CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5)
+	help
+	  Provide a reason for enabling 640 permissions and root:root ownership on /etc/shadow for the current hardening level.
+
+config CIS_6_1_5
+	bool "6.1.5 - etc group permissions (1)"
+	default y if CIS_LEVEL_1 || CIS_LEVEL_2 || CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5
+	help
+	  Check 644 permissions and root:root ownership on /etc/group
+
+config CIS_6_1_5_JUSTIFICATION
+	string "justification to enable etc group permissions (1)"
+	depends on !CIS_6_1_5 && (CIS_LEVEL_1 || CIS_LEVEL_2 || CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5)
+	help
+	  Provide a reason for enabling 644 permissions and root:root ownership on /etc/group for the current hardening level.
+
+config CIS_6_1_6
+	bool "6.1.6 - etc passwd- permissions (1)"
+	default y if CIS_LEVEL_1 || CIS_LEVEL_2 || CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5
+	help
+	  Check 600 permissions and root:root ownership on /etc/passwd-
+
+config CIS_6_1_6_JUSTIFICATION
+	string "justification to enable etc passwd- permissions (1)"
+	depends on !CIS_6_1_6 && (CIS_LEVEL_1 || CIS_LEVEL_2 || CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5)
+	help
+	  Provide a reason for enabling 600 permissions and root:root ownership on /etc/passwd- for the current hardening level.
+
+config CIS_6_1_7
+	bool "6.1.7 - etc shadow- permissions (1)"
+	default y if CIS_LEVEL_1 || CIS_LEVEL_2 || CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5
+	help
+	  Check 600 permissions and root:shadow ownership on /etc/shadow-
+
+config CIS_6_1_7_JUSTIFICATION
+	string "justification to enable etc shadow- permissions (1)"
+	depends on !CIS_6_1_7 && (CIS_LEVEL_1 || CIS_LEVEL_2 || CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5)
+	help
+	  Provide a reason for enabling 600 permissions and root:shadow ownership on /etc/shadow- for the current hardening level.
+
+config CIS_6_1_8
+	bool "6.1.8 - etc group- permissions (1)"
+	default y if CIS_LEVEL_1 || CIS_LEVEL_2 || CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5
+	help
+	  Check 600 permissions and root:root ownership on /etc/group-
+
+config CIS_6_1_8_JUSTIFICATION
+	string "justification to enable etc group- permissions (1)"
+	depends on !CIS_6_1_8 && (CIS_LEVEL_1 || CIS_LEVEL_2 || CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5)
+	help
+	  Provide a reason for enabling 600 permissions and root:root ownership on /etc/group- for the current hardening level.
+
+config CIS_6_1_9
+	bool "6.1.9 - etc gshadow permissions (1)"
+	default y if CIS_LEVEL_1 || CIS_LEVEL_2 || CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5
+	help
+	  Check 640 permissions and root:root ownership on /etc/gshadow
+
+config CIS_6_1_9_JUSTIFICATION
+	string "justification to enable etc gshadow permissions (1)"
+	depends on !CIS_6_1_9 && (CIS_LEVEL_1 || CIS_LEVEL_2 || CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5)
+	help
+	  Provide a reason for enabling 640 permissions and root:root ownership on /etc/gshadow for the current hardening level.
+
+config CIS_6_1_10
+	bool "6.1.10 - find world writable file (3)"
+	default y if CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5
+	help
+	  Ensure no world writable files exist
+
+config CIS_6_1_10_JUSTIFICATION
+	string "justification to enable world writable file (3)"
+	depends on !CIS_6_1_10 && (CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5)
+	help
+	  Provide a reason for enabling no world writable files exist for the current hardening level.
+
+config CIS_6_1_11
+	bool "6.1.11 - find unowned files (2)"
+	default y if CIS_LEVEL_2 || CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5
+	help
+	  Ensure no unowned files or directories exist.
+
+config CIS_6_1_11_JUSTIFICATION
+	string "justification to enable unowned files (2)"
+	depends on !CIS_6_1_11 && (CIS_LEVEL_2 || CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5)
+	help
+	  Provide a reason for enabling no unowned files or directories exist for the current hardening level.
+
+config CIS_6_1_12
+	bool "6.1.12 - find ungrouped files (2)"
+	default y if CIS_LEVEL_2 || CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5
+	help
+	  Ensure no ungrouped files or directories exist
+
+config CIS_6_1_12_JUSTIFICATION
+	string "justification to enable ungrouped files (2)"
+	depends on !CIS_6_1_12 && (CIS_LEVEL_2 || CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5)
+	help
+	  Provide a reason for enabling no ungrouped files or directories exist for the current hardening level.
+
+config CIS_6_1_13
+	bool "6.1.13 - find suid files (2)"
+	default y if CIS_LEVEL_2 || CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5
+	help
+	  Find SUID system executables.
+
+config CIS_6_1_13_JUSTIFICATION
+	string "justification to enable suid files (2)"
+	depends on !CIS_6_1_13 && (CIS_LEVEL_2 || CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5)
+	help
+	  Provide a reason for enabling SUID system executables for the current hardening level.
+
+config CIS_6_1_14
+	bool "6.1.14 - find sgid files (2)"
+	default y if CIS_LEVEL_2 || CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5
+	help
+	  Find SGID system executables.
+
+config CIS_6_1_14_JUSTIFICATION
+	string "justification to enable sgid files (2)"
+	depends on !CIS_6_1_14 && (CIS_LEVEL_2 || CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5)
+	help
+	  Provide a reason for enabling SGID system executables for the current hardening level.
+
+endmenu
+
+menu "6.2 Local User and Group Settings"
+
+config CIS_6_2_1
+	bool "6.2.1 - remove empty password field (1)"
+	default y if CIS_LEVEL_1 || CIS_LEVEL_2 || CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5
+	help
+	  Ensure password fields are not empty in /etc/shadow.
+
+config CIS_6_2_1_JUSTIFICATION
+	string "justification to enable empty password field (1)"
+	depends on !CIS_6_2_1 && (CIS_LEVEL_1 || CIS_LEVEL_2 || CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5)
+	help
+	  Provide a reason for enabling password fields are not empty in /etc/shadow for the current hardening level.
+
+config CIS_6_2_2
+	bool "6.2.2 - remove legacy passwd entries (1)"
+	default y if CIS_LEVEL_1 || CIS_LEVEL_2 || CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5
+	help
+	  Verify no legacy + entries exist in /etc/password file.
+
+config CIS_6_2_2_JUSTIFICATION
+	string "justification to enable legacy passwd entries (1)"
+	depends on !CIS_6_2_2 && (CIS_LEVEL_1 || CIS_LEVEL_2 || CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5)
+	help
+	  Provide a reason for enabling no legacy + entries exist in /etc/password file for the current hardening level.
+
+config CIS_6_2_3
+	bool "6.2.3 - users homedir exist (2)"
+	default y if CIS_LEVEL_2 || CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5
+	help
+	  Users are assigned valid home directories.
+
+config CIS_6_2_3_JUSTIFICATION
+	string "justification to enable users homedir exist (2)"
+	depends on !CIS_6_2_3 && (CIS_LEVEL_2 || CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5)
+	help
+	  Provide a reason for enabling Users are assigned valid home directories for the current hardening level.
+
+config CIS_6_2_4
+	bool "6.2.4 - remove legacy shadow entries (1)"
+	default y if CIS_LEVEL_1 || CIS_LEVEL_2 || CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5
+	help
+	  Verify no legacy + entries exist in /etc/shadow file.
+
+config CIS_6_2_4_JUSTIFICATION
+	string "justification to enable legacy shadow entries (1)"
+	depends on !CIS_6_2_4 && (CIS_LEVEL_1 || CIS_LEVEL_2 || CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5)
+	help
+	  Provide a reason for enabling no legacy + entries exist in /etc/shadow file for the current hardening level.
+
+config CIS_6_2_5
+	bool "6.2.5 - remove legacy group entries (1)"
+	default y if CIS_LEVEL_1 || CIS_LEVEL_2 || CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5
+	help
+	  Verify no legacy + entries exist in /etc/group file.
+
+config CIS_6_2_5_JUSTIFICATION
+	string "justification to enable legacy group entries (1)"
+	depends on !CIS_6_2_5 && (CIS_LEVEL_1 || CIS_LEVEL_2 || CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5)
+	help
+	  Provide a reason for enabling no legacy + entries exist in /etc/group file for the current hardening level.
+
+config CIS_6_2_6
+	bool "6.2.6 - find 0 uid non root account (2)"
+	default y if CIS_LEVEL_2 || CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5
+	help
+	  Verify root is the only UID 0 account.
+
+config CIS_6_2_6_JUSTIFICATION
+	string "justification to enable 0 uid non root account (2)"
+	depends on !CIS_6_2_6 && (CIS_LEVEL_2 || CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5)
+	help
+	  Provide a reason for enabling root is the only UID 0 account for the current hardening level.
+
+config CIS_6_2_7
+	bool "6.2.7 - sanitize root path (2)"
+	default y if CIS_LEVEL_2 || CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5
+	help
+	  Ensure root path integrity.
+
+config CIS_6_2_7_JUSTIFICATION
+	string "justification to enable sanitize root path (2)"
+	depends on !CIS_6_2_7 && (CIS_LEVEL_2 || CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5)
+	help
+	  Provide a reason for enabling root path integrity for the current hardening level.
+
+config CIS_6_2_8
+	bool "6.2.8 - check user dir perm (2)"
+	default y if CIS_LEVEL_2 || CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5
+	help
+	  Check permissions on user home directories.
+
+config CIS_6_2_8_JUSTIFICATION
+	string "justification to enable user dir perm (2)"
+	depends on !CIS_6_2_8 && (CIS_LEVEL_2 || CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5)
+	help
+	  Provide a reason for enabling permissions on user home directories for the current hardening level.
+
+config CIS_6_2_9
+	bool "6.2.9 - users homedir ownership (2)"
+	default y if CIS_LEVEL_2 || CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5
+	help
+	  Ensure users own their home directories
+
+config CIS_6_2_9_JUSTIFICATION
+	string "justification to enable users homedir ownership (2)"
+	depends on !CIS_6_2_9 && (CIS_LEVEL_2 || CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5)
+	help
+	  Provide a reason for enabling users own their home directories for the current hardening level.
+
+config CIS_6_2_10
+	bool "6.2.10 - check user dot file perm (2)"
+	default y if CIS_LEVEL_2 || CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5
+	help
+	  Check user dot file permissions.
+
+config CIS_6_2_10_JUSTIFICATION
+	string "justification to enable user dot file perm (2)"
+	depends on !CIS_6_2_10 && (CIS_LEVEL_2 || CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5)
+	help
+	  Provide a reason for enabling user dot file permissions for the current hardening level.
+
+config CIS_6_2_11
+	bool "6.2.11 - find user forward files (2)"
+	default y if CIS_LEVEL_2 || CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5
+	help
+	  There is no user .forward files.
+
+config CIS_6_2_11_JUSTIFICATION
+	string "justification to enable user forward files (2)"
+	depends on !CIS_6_2_11 && (CIS_LEVEL_2 || CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5)
+	help
+	  Provide a reason for enabling There is no user .forward files for the current hardening level.
+
+config CIS_6_2_12
+	bool "6.2.12 - find user netrc files (2)"
+	default y if CIS_LEVEL_2 || CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5
+	help
+	  There is no user .netrc files.
+
+config CIS_6_2_12_JUSTIFICATION
+	string "justification to enable user netrc files (2)"
+	depends on !CIS_6_2_12 && (CIS_LEVEL_2 || CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5)
+	help
+	  Provide a reason for enabling There is no user .netrc files for the current hardening level.
+
+config CIS_6_2_13
+	bool "6.2.13 - set perm on user netrc (2)"
+	default y if CIS_LEVEL_2 || CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5
+	help
+	  Ensure users' .netrc Files are not group or world accessible
+
+config CIS_6_2_13_JUSTIFICATION
+	string "justification to enable perm on user netrc (2)"
+	depends on !CIS_6_2_13 && (CIS_LEVEL_2 || CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5)
+	help
+	  Provide a reason for enabling users' .netrc Files are not group or world accessible for the current hardening level.
+
+config CIS_6_2_14
+	bool "6.2.14 - find user rhosts files (2)"
+	default y if CIS_LEVEL_2 || CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5
+	help
+	  No user's .rhosts file.
+
+config CIS_6_2_14_JUSTIFICATION
+	string "justification to enable user rhosts files (2)"
+	depends on !CIS_6_2_14 && (CIS_LEVEL_2 || CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5)
+	help
+	  Provide a reason for enabling No user's .rhosts file for the current hardening level.
+
+config CIS_6_2_15
+	bool "6.2.15 - find passwd group inconsistencies (2)"
+	default y if CIS_LEVEL_2 || CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5
+	help
+	  There is no group in /etc/passwd that is not in /etc/group.
+
+config CIS_6_2_15_JUSTIFICATION
+	string "justification to enable passwd group inconsistencies (2)"
+	depends on !CIS_6_2_15 && (CIS_LEVEL_2 || CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5)
+	help
+	  Provide a reason for enabling There is no group in /etc/passwd that is not in /etc/group for the current hardening level.
+
+config CIS_6_2_16
+	bool "6.2.16 - check duplicate uid (2)"
+	default y if CIS_LEVEL_2 || CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5
+	help
+	  Ensure no duplicate UIDs exist
+
+config CIS_6_2_16_JUSTIFICATION
+	string "justification to enable duplicate uid (2)"
+	depends on !CIS_6_2_16 && (CIS_LEVEL_2 || CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5)
+	help
+	  Provide a reason for enabling no duplicate UIDs exist for the current hardening level.
+
+config CIS_6_2_17
+	bool "6.2.17 - check duplicate gid (2)"
+	default y if CIS_LEVEL_2 || CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5
+	help
+	  Ensure no duplicate GIDs exist
+
+config CIS_6_2_17_JUSTIFICATION
+	string "justification to enable duplicate gid (2)"
+	depends on !CIS_6_2_17 && (CIS_LEVEL_2 || CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5)
+	help
+	  Provide a reason for enabling no duplicate GIDs exist for the current hardening level.
+
+config CIS_6_2_18
+	bool "6.2.18 - check duplicate username (1)"
+	default y if CIS_LEVEL_1 || CIS_LEVEL_2 || CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5
+	help
+	  There is no duplicate usernames.
+
+config CIS_6_2_18_JUSTIFICATION
+	string "justification to enable duplicate username (1)"
+	depends on !CIS_6_2_18 && (CIS_LEVEL_1 || CIS_LEVEL_2 || CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5)
+	help
+	  Provide a reason for enabling There is no duplicate usernames for the current hardening level.
+
+config CIS_6_2_19
+	bool "6.2.19 - check duplicate groupname (1)"
+	default y if CIS_LEVEL_1 || CIS_LEVEL_2 || CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5
+	help
+	  There is no duplicate group names.
+
+config CIS_6_2_19_JUSTIFICATION
+	string "justification to enable duplicate groupname (1)"
+	depends on !CIS_6_2_19 && (CIS_LEVEL_1 || CIS_LEVEL_2 || CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5)
+	help
+	  Provide a reason for enabling There is no duplicate group names for the current hardening level.
+
+config CIS_6_2_20
+	bool "6.2.20 - shadow group empty (1)"
+	default y if CIS_LEVEL_1 || CIS_LEVEL_2 || CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5
+	help
+	  There is no user in shadow group (that can read /etc/shadow file).
+
+config CIS_6_2_20_JUSTIFICATION
+	string "justification to enable shadow group empty (1)"
+	depends on !CIS_6_2_20 && (CIS_LEVEL_1 || CIS_LEVEL_2 || CIS_LEVEL_3 || CIS_LEVEL_4 || CIS_LEVEL_5)
+	help
+	  Provide a reason for enabling There is no user in shadow group (that can read /etc/shadow file) for the current hardening level.
+
+endmenu
+
+endmenu
+
diff --git a/recipes-security/cip-cis-rules-config/files/scripts/config.schema.json b/recipes-security/cip-cis-rules-config/files/scripts/config.schema.json
new file mode 100644
index 0000000..74b020a
--- /dev/null
+++ b/recipes-security/cip-cis-rules-config/files/scripts/config.schema.json
@@ -0,0 +1,124 @@
+{
+  "$schema": "https://json-schema.org/draft/2020-12/schema",
+  "$id": "config.schema.json",
+  "title": "CIP CIS Hardening Rules",
+  "description": "Schema for the config.json file produced by select-hardenings.py",
+  "type": "object",
+  "required": ["level", "rules"],
+  "additionalProperties": false,
+  "properties": {
+    "level": {
+      "type": "integer",
+      "description": "The selected CIS hardening level",
+      "enum": [1, 2, 3, 4, 5]
+    },
+    "rules": {
+      "type": "array",
+      "minItems": 1,
+      "items": { "$ref": "#/$defs/ruleWrapper" }
+    }
+  },
+  "$comment": "For each possible selected level L, when the selected level == L every rule whose minimum level is <= L must carry a justification if it is not applied (apply == false).",
+  "allOf": [
+    { "$ref": "#/$defs/requireJustificationL1" },
+    { "$ref": "#/$defs/requireJustificationL2" },
+    { "$ref": "#/$defs/requireJustificationL3" },
+    { "$ref": "#/$defs/requireJustificationL4" },
+    { "$ref": "#/$defs/requireJustificationL5" }
+  ],
+  "$defs": {
+    "ruleWrapper": {
+      "type": "object",
+      "required": ["rule"],
+      "additionalProperties": false,
+      "properties": {
+        "rule": {
+          "type": "object",
+          "required": ["name", "description", "level", "apply"],
+          "additionalProperties": false,
+          "properties": {
+            "name": {
+              "type": "string",
+              "description": "CIS rule identifier, e.g. '1.1.1.1'",
+              "pattern": "^[0-9]+(\\.[0-9]+)*$"
+            },
+            "description": {
+              "type": "string",
+              "description": "Short description of the hardening rule",
+              "minLength": 1
+            },
+            "level": {
+              "type": "integer",
+              "description": "Minimum CIS hardening level at which this rule is required",
+              "enum": [1, 2, 3, 4, 5]
+            },
+            "apply": {
+              "type": "boolean",
+              "description": "Whether the rule is currently enabled in the configuration"
+            },
+            "justification": {
+              "type": "string",
+              "description": "Reason for not applying a rule that is required by the selected hardening level",
+              "minLength": 1
+            },
+            "value": {
+              "type": "string",
+              "description": "Optional parameter value for rules that require site-specific configuration (e.g. group names)",
+              "minLength": 1
+            }
+          }
+        }
+      }
+    },
+    "requireJustificationL1": {
+      "if": { "required": ["level"], "properties": { "level": { "const": 1 } } },
+      "then": { "properties": { "rules": { "items": { "properties": { "rule": {
+        "if": {
+          "required": ["level", "apply"],
+          "properties": { "level": { "enum": [1] }, "apply": { "const": false } }
+        },
+        "then": { "required": ["justification"] }
+      } } } } } }
+    },
+    "requireJustificationL2": {
+      "if": { "required": ["level"], "properties": { "level": { "const": 2 } } },
+      "then": { "properties": { "rules": { "items": { "properties": { "rule": {
+        "if": {
+          "required": ["level", "apply"],
+          "properties": { "level": { "enum": [1, 2] }, "apply": { "const": false } }
+        },
+        "then": { "required": ["justification"] }
+      } } } } } }
+    },
+    "requireJustificationL3": {
+      "if": { "required": ["level"], "properties": { "level": { "const": 3 } } },
+      "then": { "properties": { "rules": { "items": { "properties": { "rule": {
+        "if": {
+          "required": ["level", "apply"],
+          "properties": { "level": { "enum": [1, 2, 3] }, "apply": { "const": false } }
+        },
+        "then": { "required": ["justification"] }
+      } } } } } }
+    },
+    "requireJustificationL4": {
+      "if": { "required": ["level"], "properties": { "level": { "const": 4 } } },
+      "then": { "properties": { "rules": { "items": { "properties": { "rule": {
+        "if": {
+          "required": ["level", "apply"],
+          "properties": { "level": { "enum": [1, 2, 3, 4] }, "apply": { "const": false } }
+        },
+        "then": { "required": ["justification"] }
+      } } } } } }
+    },
+    "requireJustificationL5": {
+      "if": { "required": ["level"], "properties": { "level": { "const": 5 } } },
+      "then": { "properties": { "rules": { "items": { "properties": { "rule": {
+        "if": {
+          "required": ["level", "apply"],
+          "properties": { "level": { "enum": [1, 2, 3, 4, 5] }, "apply": { "const": false } }
+        },
+        "then": { "required": ["justification"] }
+      } } } } } }
+    }
+  }
+}
diff --git a/recipes-security/cip-cis-rules-config/files/scripts/gen-kernel-config.py b/recipes-security/cip-cis-rules-config/files/scripts/gen-kernel-config.py
new file mode 100755
index 0000000..7099782
--- /dev/null
+++ b/recipes-security/cip-cis-rules-config/files/scripts/gen-kernel-config.py
@@ -0,0 +1,164 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: MIT
+"""
+Generate a Linux kernel config fragment for enabled CIS hardening rules
+from .config.json.
+
+Each rule maps kernel CONFIG symbols to explicit targets:
+    - y: built-in
+    - n: disabled (rendered as "# CONFIG_FOO is not set")
+
+The fragment can be dropped into a kernel build tree (e.g. via
+KCONFIG_ALLCONFIG or merge_config.sh) to enforce kernel option values at
+compile time.
+
+Usage:
+    python3 gen-kernel-config.py \\
+        --config generator/.config.json \\
+        --output hardening.cfg
+"""
+
+import json
+import logging
+import argparse
+from pathlib import Path
+import sys
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
+# ---------------------------------------------------------------------------
+# Mapping of CIS rule IDs to kernel CONFIG symbols and their target values.
+# A rule may map to more than one symbol (e.g. FAT covers three options).
+# ---------------------------------------------------------------------------
+RULE_KERNEL_OPTIONS: dict[str, dict] = {
+    "1.1.1.1": {
+        "description": "Disable Veritas VxFS filesystem",
+        "configs": {"CONFIG_VXFS_FS": "n"},
+    },
+    "1.1.1.2": {
+        "description": "Disable JFFS2 filesystem",
+        "configs": {"CONFIG_JFFS2_FS": "n"},
+    },
+    "1.1.1.3": {
+        "description": "Disable HFS filesystem",
+        "configs": {"CONFIG_HFS_FS": "n"},
+    },
+    "1.1.1.4": {
+        "description": "Disable HFS+ filesystem",
+        "configs": {"CONFIG_HFSPLUS_FS": "n"},
+    },
+    "1.1.1.5": {
+        "description": "Disable SquashFS filesystem",
+        "configs": {"CONFIG_SQUASHFS": "n"},
+    },
+    "1.1.1.6": {
+        "description": "Disable UDF filesystem",
+        "configs": {"CONFIG_UDF_FS": "n"},
+    },
+    "1.1.1.7": {
+        "description": "Disable FAT filesystems (FAT, MSDOS, VFAT)",
+        "configs": {
+            "CONFIG_FAT_FS": "n",
+            "CONFIG_MSDOS_FS": "n",
+            "CONFIG_VFAT_FS": "n",
+        },
+    },
+    "1.1.1.8": {
+        "description": "Disable cramfs filesystem",
+        "configs": {"CONFIG_CRAMFS": "n"},
+    },
+    "1.1.23": {
+        "description": "Disable USB storage",
+        "configs": {"CONFIG_USB_STORAGE": "n"},
+    },
+}
+
+
+def setup_parser():
+    parser = argparse.ArgumentParser(
+        description="Generate a kernel config fragment for "
+                    "enabled CIS hardening rules."
+    )
+    parser.add_argument(
+        "--config",
+        type=Path,
+        required=True,
+        metavar="FILE",
+        help="Path to generator/.config.json",
+    )
+    parser.add_argument(
+        "--output",
+        type=Path,
+        required=True,
+        metavar="FILE",
+        help="Output kernel config fragment path",
+    )
+    return parser
+
+
+def main():
+    parser = setup_parser()
+    args = parser.parse_args()
+
+    logging.basicConfig(
+        level=logging.INFO,
+        format="%(levelname)s: %(message)s",
+    )
+
+    config = load_json(args.config, logger)
+    enabled_rules = get_enabled_rules(config)
+
+    active = [
+        (rule_id, RULE_KERNEL_OPTIONS[rule_id])
+        for rule_id in sorted(RULE_KERNEL_OPTIONS)
+        if rule_id in enabled_rules
+    ]
+
+    args.output.parent.mkdir(parents=True, exist_ok=True)
+    with args.output.open("w") as f:
+        f.write(
+            "# CIS hardening kernel config fragment\n"
+            "# Generated by generator/gen-kernel-config.py - do not edit.\n"
+            "# Values: y=built-in, n=disabled\n"
+            "\n"
+        )
+
+        for rule_id, entry in active:
+            f.write(f"# CIS {rule_id}: {entry['description']}\n")
+            for symbol, value in entry["configs"].items():
+                if value == "n":
+                    f.write(f"# {symbol} is not set\n")
+                else:
+                    f.write(f"{symbol}={value}\n")
+            f.write("\n")
+
+    logger.info(
+        f"Generated {args.output} with {len(active)} rule(s) "
+        f"({sum(len(e['configs']) for _, e in active)} CONFIG symbols)."
+    )
+    if not active:
+        logger.info("  No kernel-relevant rules are currently enabled.")
+
+
+if __name__ == "__main__":
+    main()
diff --git a/recipes-security/cip-cis-rules-config/files/scripts/select-hardenings.py b/recipes-security/cip-cis-rules-config/files/scripts/select-hardenings.py
new file mode 100755
index 0000000..e4425cc
--- /dev/null
+++ b/recipes-security/cip-cis-rules-config/files/scripts/select-hardenings.py
@@ -0,0 +1,618 @@
+#!/usr/bin/env python3
+#
+# Based on the kas menu plugin
+# Copyright (c) Siemens AG, 2021-2023
+# Copyright (c) 2011-2019, Ulf Magnusson <ulfalizer@gmail.com>
+# SPDX-License-Identifier: MIT
+#
+
+import argparse
+import json
+import logging
+import pathlib
+import re
+import sys
+import traceback
+
+from kconfiglib import (
+    Kconfig,
+    Symbol,
+    Choice,
+    expr_value,
+    TYPE_TO_STR,
+    MENU,
+    COMMENT,
+    STRING,
+    BOOL,
+    INT,
+    HEX,
+    UNKNOWN,
+)
+
+from snack import (
+    SnackScreen,
+    EntryWindow,
+    ButtonChoiceWindow,
+    ButtonBar,
+    Listbox,
+    GridFormHelp,
+)
+
+logger = logging.getLogger(__name__)
+
+
+class Menuconfig:
+    def __init__(self, kconf):
+        self.kconf = kconf
+        self.screen = None
+
+    @staticmethod
+    def value_str(sym):
+        if sym.type in (STRING, INT, HEX):
+            return f"({sym.str_value})"
+
+        if sym.choice and sym.visibility == 2:
+            return "(*)" if sym.choice.selection is sym else "( )"
+
+        tri_val_str = (" ", None, "*")[sym.tri_value]
+
+        if len(sym.assignable) == 1:
+            return f"-{tri_val_str}-"
+
+        if sym.type == BOOL:
+            return f"[{tri_val_str}]"
+
+        raise RuntimeError()
+
+    @staticmethod
+    def node_str(node, indent):
+        if not node.prompt:
+            return ""
+
+        prompt, prompt_cond = node.prompt
+        if not expr_value(prompt_cond):
+            return ""
+
+        if node.item == MENU:
+            return f"    {indent * ' '}{prompt}  --->"
+
+        if type(node.item) is Choice:
+            return f"    {indent * ' '}{prompt}"
+
+        if node.item == COMMENT:
+            return f"    {indent * ' '}*** {prompt} ***"
+
+        sym = node.item
+
+        if sym.type == UNKNOWN:
+            return ""
+
+        res = f"{Menuconfig.value_str(sym):3} {indent * ' '}{prompt}"
+
+        if node.is_menuconfig:
+            res += f"  ---{'>' if sym.tri_value > 0 else '-'}"
+
+        return res
+
+    @staticmethod
+    def menu_node_strings(node, indent):
+        items = []
+
+        while node:
+            string = Menuconfig.node_str(node, indent)
+            if string:
+                items.append((string, node))
+
+            if (
+                node.list
+                and node.item != MENU
+                and (type(node.item) is Choice or not node.is_menuconfig)
+            ):
+                items.extend(Menuconfig.menu_node_strings(node.list, indent + 2))
+
+            node = node.next
+
+        return items
+
+    def show_menu(self, title, top_node, is_submenu=False):
+        selection = 0
+
+        while True:
+            items = Menuconfig.menu_node_strings(top_node, 0)
+
+            height = len(items)
+            window_width = 60
+
+            scroll = 0
+            if height > self.screen.height - 13:
+                height = self.screen.height - 13
+                scroll = 1
+
+            buttons = [
+                ("Save & Exit", "save", "S"),
+                (" Exit ", "exit", "E"),
+                (" Help ", "help", "h"),
+            ]
+            if is_submenu:
+                buttons.insert(0, (" Return ", "return", "ESC"))
+            buttonbar = ButtonBar(self.screen, buttons)
+            if not is_submenu:
+                buttonbar.hotkeys["ESC"] = "exit"
+            listbox = Listbox(height, width=window_width, scroll=scroll, returnExit=1)
+            count = 0
+            for string, _ in items:
+                listbox.append(string, count)
+                if selection == count:
+                    listbox.setCurrent(count)
+                count += 1
+
+            grid = GridFormHelp(self.screen, title, None, 1, 2)
+            grid.add(listbox, 0, 0, padding=(0, 0, 0, 1))
+            grid.add(buttonbar, 0, 1, growx=1)
+            grid.addHotKey(" ")
+
+            # Snapshot the active CIS level so we can detect level changes
+            # caused by the user action below and re-derive rule defaults.
+            level_before = _selected_level(self.kconf)
+
+            rc = grid.runOnce()
+
+            action = buttonbar.buttonPressed(rc)
+            if action and action != "help":
+                return action
+
+            if count == 0:
+                continue
+
+            selection = listbox.current()
+            _, selected_node = items[selection]
+            sym = selected_node.item
+
+            if action == "help":
+                prompt, _ = selected_node.prompt
+                if selected_node.help:
+                    help_text = selected_node.help
+                else:
+                    help_text = "No help available."
+                ButtonChoiceWindow(
+                    screen=self.screen,
+                    title=f"Help on '{prompt}'",
+                    text=help_text,
+                    width=window_width,
+                    buttons=["  Ok  "],
+                )
+                continue
+
+            show_submenu = False
+
+            if type(sym) is Symbol:
+                if rc == " ":
+                    if sym.type == BOOL:
+                        sym.set_value("n" if sym.tri_value > 0 else "y")
+                else:
+                    if selected_node.is_menuconfig:
+                        show_submenu = True
+                    elif sym.type in (STRING, INT, HEX):
+                        action, values = EntryWindow(
+                            screen=self.screen,
+                            title=sym.name,
+                            text=f"Enter a {TYPE_TO_STR[sym.type]} value:",
+                            prompts=[("", sym.str_value)],
+                            width=80,
+                            entryWidth=80,
+                            buttons=[("  Ok  ", "Ok"), ("Cancel", "", "ESC")],
+                        )
+                        if action == "Ok":
+                            self.kconf.warnings = []
+                            val = values[0]
+                            if sym.type == HEX and not val.startswith("0x"):
+                                val = "0x" + val
+                            sym.set_value(val)
+                            sym.str_value
+                            if len(self.kconf.warnings) > 0:
+                                ButtonChoiceWindow(
+                                    screen=self.screen,
+                                    title="Invalid entry",
+                                    text="\n".join(self.kconf.warnings),
+                                    width=window_width,
+                                    buttons=["  Ok  "],
+                                )
+                                self.kconf.warnings = []
+            elif selected_node.is_menuconfig and type(sym) is not Choice:
+                show_submenu = True
+
+            if show_submenu:
+                submenu_title, _ = selected_node.prompt
+                action = self.show_menu(
+                    submenu_title, selected_node.list, is_submenu=True
+                )
+                if action != "return":
+                    return action
+
+            # If the user just switched CIS_LEVEL_N, drop any user overrides
+            # on rule symbols so the new level's `default y if CIS_LEVEL_…`
+            # clauses take effect and every rule required by the new level
+            # is enabled by default.  Justifications and the level symbols
+            # themselves are preserved.
+            level_after = _selected_level(self.kconf)
+            if (
+                level_before is not None
+                and level_after is not None
+                and level_after != level_before
+            ):
+                cleared = _reset_rule_overrides(self.kconf)
+                ButtonChoiceWindow(
+                    screen=self.screen,
+                    title="Hardening level changed",
+                    text=(
+                        f"Switched from level {level_before} to level "
+                        f"{level_after}.\n\n"
+                        f"All rule selections were reset to the level "
+                        f"{level_after} defaults ({cleared} prior override"
+                        f"{'s' if cleared != 1 else ''} discarded).\n\n"
+                        "Per-rule justifications were kept."
+                    ),
+                    width=window_width,
+                    buttons=["  Ok  "],
+                )
+
+    def show(self):
+        self.screen = SnackScreen()
+
+        action = self.show_menu(self.kconf.mainmenu_text, self.kconf.top_node.list)
+
+        self.screen.finish()
+        return action
+
+
+def _collect_level_numbers(expr):
+    """Return the set of integer level numbers for all CIS_LEVEL_N symbols in a kconfiglib expr."""
+    from kconfiglib import Symbol as _Symbol
+
+    levels = set()
+    if isinstance(expr, _Symbol):
+        m = re.match(r"^CIS_LEVEL_(\d+)$", expr.name)
+        if m:
+            levels.add(int(m.group(1)))
+    elif isinstance(expr, tuple):
+        for sub in expr[1:]:
+            levels |= _collect_level_numbers(sub)
+    return levels
+
+
+_LEVEL_RE = re.compile(r"^CIS_LEVEL_(\d+)$")
+
+
+def _selected_level(kconf):
+    """Return the integer N of the currently selected CIS_LEVEL_N choice, or None."""
+    for n in range(1, 6):
+        sym = kconf.syms.get(f"CIS_LEVEL_{n}")
+        if sym is not None and sym.tri_value == 2:
+            return n
+    return None
+
+
+def _reset_rule_overrides(kconf):
+    """Clear user-set values on every CIS_<id> rule symbol so that the
+    Kconfig ``default y if CIS_LEVEL_N || …`` clauses take effect again.
+
+    This is invoked whenever the user picks a different CIS_LEVEL_N in the
+    menu so that switching level immediately enables the rules required by
+    the newly-selected level (and disables any that the old level required
+    but the new one does not).
+
+    CIS_LEVEL_N symbols themselves and the *_JUSTIFICATION string symbols
+    are intentionally left alone:
+
+      * resetting the level symbols would re-trigger us recursively;
+      * justifications belong to the operator, not the level, and would be
+        lost on every level change.
+
+    Site-specific string symbols (e.g. ``CIS_2_2_1_3_SERVER``,
+    ``CIS_5_2_18_GROUPS``, ``CIS_5_3_3_REMEMBER``) are likewise preserved
+    so the operator does not lose typed-in values when bumping levels.
+
+    Returns the number of rule symbols whose override was cleared.
+    """
+    cleared = 0
+    for name, sym in kconf.syms.items():
+        if not name.startswith("CIS_"):
+            continue
+        if _LEVEL_RE.match(name):
+            continue
+        if name.endswith("_JUSTIFICATION"):
+            continue
+        # Preserve user-supplied site-specific values (e.g. NTP server,
+        # SSH allowed groups, password-history depth) — these are not
+        # tied to a particular hardening level.
+        if sym.type == STRING:
+            continue
+        # ``user_value`` is None iff the symbol has no explicit user override.
+        if getattr(sym, "user_value", None) is not None:
+            sym.unset_value()
+            cleared += 1
+    return cleared
+
+
+def _find_value_symbol(kconf, rule_sym_name):
+    """Return the user-tunable string symbol associated with rule
+    *rule_sym_name* (e.g. ``CIS_5_3_3``), or ``None`` if the rule has no
+    site-specific parameter.
+
+    The convention is that a rule ``CIS_<id>`` may have one companion
+    string symbol named ``CIS_<id>_<SUFFIX>`` (e.g. ``CIS_5_3_3_REMEMBER``,
+    ``CIS_2_2_1_3_SERVER``, ``CIS_5_2_18_GROUPS``) whose value is
+    substituted for ``@@VALUE@@`` in the rule's snippet.  The
+    ``_JUSTIFICATION`` companion symbol is excluded — it is operator
+    bookkeeping, not a snippet value.
+    """
+    prefix = rule_sym_name + "_"
+    for name, sym in kconf.syms.items():
+        if (
+            name.startswith(prefix)
+            and not name.endswith("_JUSTIFICATION")
+            and sym.type == STRING
+        ):
+            return sym
+    return None
+
+
+_SCHEMA_PATH = pathlib.Path(__file__).parent / "config.schema.json"
+
+
+def _validate_json(rules):
+    """Validate *rules* against config.schema.json.
+
+    Requires the ``jsonschema`` package.  Raises ``ImportError`` when the
+    package is not installed, or ``jsonschema.ValidationError`` when the
+    data does not conform to the schema.
+    """
+    try:
+        import jsonschema
+    except ImportError as exc:
+        raise ImportError(
+            "jsonschema is required for schema validation: "
+            "install it with 'pip install jsonschema'"
+        ) from exc
+
+    with open(_SCHEMA_PATH) as f:
+        schema = json.load(f)
+
+    jsonschema.validate(instance=rules, schema=schema)
+
+
+def save_as_json(kconf, path):
+    """Export the current Kconfig selection state to a JSON file.
+
+    The output is an object with two keys:
+
+    * ``level`` — the currently selected CIS hardening level (1–5)
+    * ``rules`` — list of rule objects::
+
+          {"rule": {"name": "1.1.1.1", "description": "...", "level": 2,
+                    "apply": true, "justification": "..."}}
+
+    The ``justification`` key is only present when the corresponding
+    ``CIS_<ID>_JUSTIFICATION`` symbol has a non-empty string value.
+
+    After writing, the file is validated against config.schema.json located
+    in the same directory as this script.  A ``jsonschema.ValidationError``
+    is raised if the output does not conform to the schema.
+    """
+    selected_level = _selected_level(kconf)
+
+    rules = []
+    for name, sym in sorted(kconf.syms.items()):
+        if (
+            not name.startswith("CIS_")
+            or name.startswith("CIS_LEVEL_")
+            or name.endswith("_JUSTIFICATION")
+            or sym.type != BOOL
+            or not sym.nodes
+        ):
+            continue
+
+        node = sym.nodes[0]
+        if not node.prompt:
+            continue
+        prompt_text = node.prompt[0]
+
+        # Parse "1.1.1.1 - disable freevxfs (2)" -> cis_number, description
+        m = re.match(r"^([\d.]+)\s*-\s*(.+?)(?:\s*\(\d+\))?$", prompt_text)
+        cis_number = m.group(1).strip() if m else name
+        description = m.group(2).strip() if m else prompt_text
+
+        # Minimum level from the first `default y if` condition
+        level = None
+        for _val, cond in sym.defaults:
+            nums = _collect_level_numbers(cond)
+            if nums:
+                level = min(nums)
+                break
+
+        if level is None:
+            logger.warning(
+                "save_as_json: could not determine CIS level for symbol '%s', skipping",
+                name,
+            )
+            continue
+
+        rule = {
+            "name": cis_number,
+            "description": description,
+            "level": level,
+            "apply": sym.tri_value == 2,
+        }
+
+        # justification: only when the symbol exists and has a non-empty value
+        just_sym = kconf.syms.get(name + "_JUSTIFICATION")
+        if just_sym and just_sym.str_value:
+            rule["justification"] = just_sym.str_value
+
+        # value: only when the rule has a companion string symbol with a
+        # non-empty value — used for snippets containing @@VALUE@@.
+        val_sym = _find_value_symbol(kconf, name)
+        if val_sym and val_sym.str_value:
+            rule["value"] = val_sym.str_value
+
+        rules.append({"rule": rule})
+
+    if selected_level is None:
+        raise ValueError(
+            "save_as_json: no CIS level selected — set one of the CIS_LEVEL_N symbols"
+        )
+
+    output = {
+        "level": selected_level,
+        "rules": rules,
+    }
+
+    with open(path, "w") as f:
+        json.dump(output, f, indent=2)
+
+    _validate_json(output)
+
+
+def load_config_json(kconf, path):
+    """Load a previously saved JSON config file and apply it to *kconf*.
+
+    The file is validated against config.schema.json before any symbols are
+    touched.  The following is applied from the file:
+
+    * ``level`` — sets the matching ``CIS_LEVEL_N`` choice symbol to ``y``.
+    * For each rule in ``rules``:
+
+      - The corresponding ``CIS_<id>`` bool symbol is set to ``y`` or ``n``
+        according to the ``apply`` field.
+      - When a non-empty ``justification`` value is present, it is written to
+        the matching ``CIS_<id>_JUSTIFICATION`` string symbol.
+      - Unknown rule names (no matching symbol in *kconf*) are logged as
+        warnings and skipped.
+
+    Raises ``FileNotFoundError`` when *path* does not exist,
+    ``jsonschema.ValidationError`` when the file fails schema validation, and
+    ``json.JSONDecodeError`` when the file is not valid JSON.
+    """
+    with open(path) as f:
+        data = json.load(f)
+
+    _validate_json(data)
+
+    # Apply selected level
+    level_sym = kconf.syms.get(f"CIS_LEVEL_{data['level']}")
+    if level_sym is not None:
+        level_sym.set_value("y")
+    else:
+        raise ValueError(
+            f"load_config_json: unknown CIS level '{data['level']}' in '{path}'"
+        )
+
+    # Apply rules
+    for entry in data["rules"]:
+        rule = entry["rule"]
+        # "1.1.1.1" -> "CIS_1_1_1_1"
+        sym_name = "CIS_" + rule["name"].replace(".", "_")
+
+        sym = kconf.syms.get(sym_name)
+        if sym is None:
+            logger.warning("load_config_json: unknown rule '%s', skipping", sym_name)
+            continue
+
+        sym.set_value("y" if rule["apply"] else "n")
+
+        justification = rule.get("justification")
+        if justification:
+            just_sym = kconf.syms.get(sym_name + "_JUSTIFICATION")
+            if just_sym is not None:
+                just_sym.set_value(justification)
+            else:
+                logger.warning(
+                    "load_config_json: no JUSTIFICATION symbol for '%s', skipping",
+                    sym_name,
+                )
+
+        value = rule.get("value")
+        if value:
+            val_sym = _find_value_symbol(kconf, sym_name)
+            if val_sym is not None:
+                val_sym.set_value(value)
+            else:
+                logger.warning(
+                    "load_config_json: no value symbol for '%s', skipping",
+                    sym_name,
+                )
+
+    logger.info(
+        "Loaded level %d and %d rules from %s", data["level"], len(data["rules"]), path
+    )
+
+
+def setup_parser():
+    parser = argparse.ArgumentParser(
+        prog="select-hardenings",
+        description="Interactive menu for selecting CIS hardening rules",
+    )
+    parser.add_argument("kconfig", help="Kconfig file", nargs="?", default="Kconfig")
+    parser.add_argument(
+        "--output", help="Output .config.json file", default=".config.json"
+    )
+    parser.add_argument("--level", help="set the hardening level", default="1")
+    parser.add_argument(
+        "--non-interactive",
+        help="skip the menu-config and generate a configuration for the given level",
+        action="store_true",
+    )
+    return parser
+
+
+def main():
+    parser = setup_parser()
+    args = parser.parse_args()
+
+    logging.basicConfig(
+        level=logging.INFO,
+        format="%(levelname)s: %(message)s",
+    )
+
+    kconf = Kconfig(args.kconfig, warn=False)
+    json_path = args.output
+    try:
+        load_config_json(kconf, json_path)
+    except FileNotFoundError:
+        logger.warning("no configuration found")
+
+    save_config = False
+    if not args.non_interactive:
+        menu = Menuconfig(kconf)
+        action = menu.show()
+        if action != "exit":
+            save_config = True
+    else:
+        save_config = True
+        try:
+            requested_level = int(args.level)
+        except (TypeError, ValueError):
+            logger.error("Invalid hardening level '%s'. Valid levels: 1-5.", args.level)
+            sys.exit(1)
+        if _selected_level(kconf) != requested_level:
+            level_sym = kconf.syms.get(f"CIS_LEVEL_{requested_level}")
+            if level_sym is None:
+                logger.error("Unknown hardening level '%s'. Valid levels: 1-5.", args.level)
+                sys.exit(1)
+            level_sym.set_value("y")
+
+    if save_config:
+        kconf.write_config(args.output)
+        try:
+            save_as_json(kconf, json_path)
+            logger.info("Hardening rules written to: %s", json_path)
+        except Exception:
+            error_path = json_path + ".error"
+            with open(error_path, "w") as f:
+                traceback.print_exc(file=f)
+            logger.error("save_as_json failed — details in %s", error_path)
+            sys.exit(1)
+
+
+if __name__ == "__main__":
+    main()
diff --git a/scripts/cis-hardening/cis-hardening-to-kconfig.py b/scripts/cis-hardening/cis-hardening-to-kconfig.py
new file mode 100755
index 0000000..7296333
--- /dev/null
+++ b/scripts/cis-hardening/cis-hardening-to-kconfig.py
@@ -0,0 +1,348 @@
+#!/usr/bin/env python3
+#
+# SPDX-License-Identifier: MIT
+#
+
+import argparse
+from pathlib import Path
+import re
+
+SECTIONS = {
+    "1 Initial Setup": {
+        "1.1 Filesystem Configuration": {},
+        "1.2 Software Updates": {},
+        "1.3 Filesystem Integrity Checking": {},
+        "1.4 Secure Boot Settings": {},
+        "1.5 Additional Process Hardening": {},
+        "1.6 Mandatory Access Control": {},
+        "1.7 CLI Warning Banners": {},
+        "1.8 Gnome Display Manager": {},
+    },
+    "2 Services": {
+        "2.1 Time Synchronization": {},
+        "2.2 Special Purpose Services": {},
+        "2.3 Service Clients": {},
+    },
+    "3 Network Configuration": {
+        "3.1 Protocols and Devices": {},
+        "3.2 Parameters (Host Only)": {},
+        "3.3 Parameters (Host and Router)": {},
+        "3.5 Firewall": {},
+    },
+    "4 Logging and Auditing": {
+        "4.1 System Accounting (auditd)": {},
+        "4.2 Logging": {},
+        "4.4 Ensure logrotate assigns appropriate permissions": {},
+    },
+    "5 Access and Auth": {
+        "5.1 Time-based Job Schedulers": {},
+        "5.2 SSH Server": {},
+        "5.3 Privilege Escalation": {},
+        "5.4 PAM": {},
+        "5.5 User Accounts and Environment": {},
+        "5.6 Restrict Access to su": {}
+    },
+    "6 System Maintenance": {
+        "6.1 System File Permissions": {},
+        "6.2 Local User and Group Settings": {},
+    },
+}
+
+# Maps ID of a rule and the additional Kconfig dependencies that it requires
+SPECIAL_RULES = {
+    "1.1.6": "CIP_VAR_PART",
+    "1.1.6.1": "CIP_VAR_PART",
+    "1.1.6.2": "CIP_VAR_PART",
+    "1.1.7": "CIP_VAR_TMP_PART",
+    "1.1.8": "CIP_VAR_TMP_PART",
+    "1.1.9": "CIP_VAR_TMP_PART",
+    "1.1.10": "CIP_VAR_TMP_PART",
+    "1.1.11": "CIP_VAR_LOG_PART",
+    "1.1.11.1": "CIP_VAR_LOG_PART",
+    "1.1.11.2": "CIP_VAR_LOG_PART",
+    "1.1.11.3": "CIP_VAR_LOG_PART",
+    "1.1.12": "CIP_VAR_LOG_AUDIT_PART",
+    "1.1.12.1": "CIP_VAR_LOG_AUDIT_PART",
+    "1.1.12.2": "CIP_VAR_LOG_AUDIT_PART",
+    "1.1.12.3": "CIP_VAR_LOG_AUDIT_PART",
+    "1.1.13": "CIP_HOME_PART",
+    "1.1.14": "CIP_HOME_PART",
+    "1.1.14.1": "CIP_HOME_PART",
+    "1.5.1": "CIP_GRUB_BOOTLOADER",
+    "5.1.2": "CIP_CRON",
+    "5.1.3": "CIP_CRON",
+    "5.1.4": "CIP_CRON",
+    "5.1.5": "CIP_CRON",
+    "5.1.6": "CIP_CRON",
+    "5.1.7": "CIP_CRON",
+    "5.1.8": "CIP_CRON",
+}
+
+SPECIAL_RULE_JUSTIFICATIONS = {
+    "CIP_VAR_PART": "Not applicable: no separate /var partition is configured.",
+    "CIP_VAR_TMP_PART": "Not applicable: no separate /var/tmp partition is configured.",
+    "CIP_VAR_LOG_PART": "Not applicable: no separate /var/log partition is configured.",
+    "CIP_VAR_LOG_AUDIT_PART": "Not applicable: no separate /var/log/audit partition is configured.",
+    "CIP_HOME_PART": "Not applicable: no separate /home partition is configured.",
+    "CIP_GRUB_BOOTLOADER": "Not applicable: the GRUB bootloader is not used.",
+    "CIP_CRON": "Not applicable: cron is not used on this system.",
+}
+
+
+class Rule:
+    def __init__(self, rule: Path):
+        if "_" not in rule.name:
+            raise ValueError(
+                f"Rule filename '{rule.name}' does not match expected '<id>_<name>' format"
+            )
+        id, name = rule.name.split("_", 1)
+        self.id = [int(i) for i in id.split(".")]
+        self.name = name.split(".")[0].replace("_", " ")
+        self.description = None
+        self.hardening_level = 5
+        with open(rule, "r") as f:
+            for line in f:
+                line = line.strip()
+                if line.startswith("DESCRIPTION="):
+                    self.description = line.split("=", 1)[1].strip('"')
+                elif line.startswith("HARDENING_LEVEL="):
+                    raw = line.split("=", 1)[1].strip()
+                    try:
+                        self.hardening_level = int(raw)
+                    except ValueError:
+                        raise ValueError(
+                            f"Rule '{rule.name}' has non-integer HARDENING_LEVEL={raw!r}"
+                        )
+
+
+def setup_parser():
+    parser = argparse.ArgumentParser(
+        prog="cis-hardening-to-kconfig",
+        description="Convert the OVH CIS hardening rules to a KConfig",
+    )
+    parser.add_argument("rules-dir", type=Path)
+    return parser
+
+
+def rule_to_kconfig_entry(r: Rule, parent_symbol: str, levels: list[int]) -> str:
+    id_str = "_".join(str(i) for i in r.id)
+    id_dotted = ".".join(str(i) for i in r.id)
+    symbol = f"CIS_{id_str}"
+    applicable = [l for l in levels if l >= r.hardening_level]
+    default_cond = " || ".join(f"CIS_LEVEL_{l}" for l in applicable)
+    additional_cond = SPECIAL_RULES.get(id_dotted)
+    if additional_cond:
+        default_cond = f"({default_cond}) && {additional_cond}"
+    lines = [
+        f"config {symbol}",
+        f'\tbool "{id_dotted} - {r.name} ({r.hardening_level})"',
+        f"\tdefault y if {default_cond}",
+    ]
+    if r.description:
+        lines.append(f"\thelp")
+        lines.append(f"\t  {r.description}")
+    return "\n".join(lines) + "\n"
+
+
+def transform_prompt(bool_prompt):
+    """
+    Turn the bool prompt into a justification string prompt.
+    e.g. "1.1.1.1 - disable freevxfs (2)"
+      -> "justification to enable freevxfs (2)"
+    We strip the leading number and dash, remove leading verb, keep the rest.
+    """
+    # Remove the CIS rule number prefix  "X.X.X - "
+    m = re.match(r"^[\d.]+ - (.+)$", bool_prompt)
+    if m:
+        rest = m.group(1)
+    else:
+        rest = bool_prompt
+
+    # Drop leading verb ("disable", "enable", "install", "restrict", etc.)
+    rest_stripped = re.sub(
+        r"^(disable|enable|install|restrict|configure|use|set|remove|find|check|limit|lock|freeze|enforce|log|record|halt|keep|make|update)\s+",
+        "",
+        rest,
+        flags=re.IGNORECASE,
+    )
+
+    return f"justification to enable {rest_stripped}"
+
+
+def transform_help(help_text):
+    """
+    Build a generic justification help line from the parent help text.
+    Strip leading verb (same list as transform_prompt) before composing.
+    """
+    # Strip trailing period
+    stripped = help_text.rstrip(".")
+    # Drop leading verb
+    stripped = re.sub(
+        r"^(disable|enable|install|restrict|configure|use|set|remove|find|check|"
+        r"limit|lock|freeze|enforce|log|record|halt|keep|make|update|collect|"
+        r"ensure|verify|deactivate|activate|implement|implemet|create|"
+        r"checking|allow|disallow|do not allow)\s+",
+        "",
+        stripped,
+        flags=re.IGNORECASE,
+    )
+    return f"Provide a reason for enabling {stripped} for the current hardening level."
+
+
+def rule_to_justification_entry(r: Rule, parent_symbol: str, levels: list[int]) -> str:
+    id_str = "_".join(str(i) for i in r.id)
+    id_dotted = ".".join(str(i) for i in r.id)
+    symbol = f"CIS_{id_str}_JUSTIFICATION"
+    applicable = [l for l in levels if l >= r.hardening_level]
+    level_cond = " || ".join(f"CIS_LEVEL_{l}" for l in applicable)
+    additional_cond = SPECIAL_RULES.get(id_dotted)
+    depends_cond = f"!CIS_{id_str} && ({level_cond})"
+    prompt = transform_prompt(f"{id_dotted} - {r.name} ({r.hardening_level})")
+    lines = [
+        f"config {symbol}",
+        f'\tstring "{prompt}"',
+        f"\tdepends on {depends_cond}",
+    ]
+    if additional_cond:
+        preset = SPECIAL_RULE_JUSTIFICATIONS.get(additional_cond)
+        if preset:
+            lines.append(f'\tdefault "{preset}" if !{additional_cond}')
+    help_text = transform_help(r.description) if r.description else None
+    if r.description:
+        lines.append("\thelp")
+        lines.append(f"\t  {help_text}")
+    return "\n".join(lines) + "\n"
+
+
+def section_symbol(section_key: str) -> str:
+    num = section_key.split(" ", 1)[0]
+    return "CIS_SEC_" + num.replace(".", "_")
+
+
+def generate_kconfig(rules: list[Rule]) -> str:
+    # Collect all hardening levels used
+    levels = sorted({r.hardening_level for r in rules if r.hardening_level is not None})
+    if not levels:
+        raise ValueError("No rules with a hardening level found; cannot generate Kconfig")
+
+    # Build lookup: subsection number -> list of rules
+    subsection_rules: dict[str, list[Rule]] = {}
+    for rule in rules:
+        key = ".".join(str(i) for i in rule.id[:2])
+        subsection_rules.setdefault(key, []).append(rule)
+
+    output = []
+
+    # Hardening level selection
+    output.append('menu "Default hardening level"')
+    output.append("")
+    output.append("choice")
+    output.append('\tprompt "Hardening level"')
+    output.append(f"\tdefault CIS_LEVEL_{levels[0]}")
+    output.append("")
+
+    for level in levels:
+        output.append(f"config CIS_LEVEL_{level}")
+        output.append(f'\tbool "Level {level}"')
+        output.append("")
+
+    output.append("endchoice")
+    output.append("")
+    output.append("endmenu")
+    output.append("")
+
+    # Other special rule menus
+    output.append('menu "Partitioning layout"')
+    output.append("")
+    output.append("config CIP_HOME_PART")
+    output.append('\tbool "Separate /home partition"')
+    output.append("\tdefault n")
+    output.append("\thelp")
+    output.append("\t  Enable this if you have a separate /home partition")
+    output.append("")
+    output.append("config CIP_VAR_PART")
+    output.append('\tbool "Separate /var partition"')
+    output.append("\tdefault n")
+    output.append("\thelp")
+    output.append("\t  Enable this if you have a separate /var partition")
+    output.append("")
+    output.append("config CIP_VAR_TMP_PART")
+    output.append('\tbool "Separate /var/tmp partition"')
+    output.append("\tdepends on CIP_VAR_PART")
+    output.append("\tdefault n")
+    output.append("\thelp")
+    output.append("\t  Enable this if you have a separate /var/tmp partition")
+    output.append("")
+    output.append("config CIP_VAR_LOG_PART")
+    output.append('\tbool "Separate /var/log partition"')
+    output.append("\tdepends on CIP_VAR_PART")
+    output.append("\tdefault n")
+    output.append("\thelp")
+    output.append("\t  Enable this if you have a separate /var/log partition")
+    output.append("")
+    output.append("config CIP_VAR_LOG_AUDIT_PART")
+    output.append('\tbool "Separate /var/log/audit partition"')
+    output.append("\tdepends on CIP_VAR_PART && CIP_VAR_LOG_PART")
+    output.append("\tdefault n")
+    output.append("\thelp")
+    output.append("\t  Enable this if you have a separate /var/log/audit partition")
+    output.append("")
+    output.append("endmenu")
+    output.append("")
+    output.append('menu "Additional options"')
+    output.append("config CIP_GRUB_BOOTLOADER")
+    output.append('\tbool "GRUB Bootloader"')
+    output.append("\tdefault n")
+    output.append("\thelp")
+    output.append("\t  Enable this if you use the GRUB bootloader")
+    output.append("")
+    output.append("config CIP_CRON")
+    output.append('\tbool "CRON"')
+    output.append("\tdefault n")
+    output.append("\thelp")
+    output.append("\t  Enable this if you use CRON")
+    output.append("")
+    output.append("endmenu")
+    output.append("")
+
+    for section_key, subsections in SECTIONS.items():
+        output.append(f'menu "{section_key}"')
+        output.append("")
+
+        for subsection_key in subsections:
+            sub_num = subsection_key.split(" ", 1)[0]
+            matching = subsection_rules.get(sub_num, [])
+            if not matching:
+                continue
+
+            output.append(f'menu "{subsection_key}"')
+            output.append("")
+
+            for rule in matching:
+                output.append(rule_to_kconfig_entry(rule, None, levels))
+                output.append(rule_to_justification_entry(rule, None, levels))
+
+            output.append("endmenu")
+            output.append("")
+
+        output.append("endmenu")
+        output.append("")
+
+    return "\n".join(output)
+
+
+def main():
+    parser = setup_parser()
+    args = parser.parse_args()
+    rulesdir: Path = getattr(args, "rules-dir")
+
+    rules = sorted(
+        (Rule(f) for f in rulesdir.iterdir() if f.is_file() and "_" in f.name),
+        key=lambda r: r.id,
+    )
+
+    print(generate_kconfig(rules))
+
+
+if __name__ == "__main__":
+    main()
-- 
2.53.0


