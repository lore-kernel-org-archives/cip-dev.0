Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCF0BC7EE24
	for <webhook@archiver.kernel.org>; Tue,  6 Jun 2023 12:14:40 +0000 (UTC)
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.217])
 by mx.groups.io with SMTP id smtpd.web10.1213.1686023930228970183
 for <cip-dev@lists.cip-project.org>;
 Mon, 05 Jun 2023 20:58:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@163.com header.s=s110527 header.b=D418jUPi;
 spf=pass (domain: 163.com, ip: 220.181.12.217, mailfrom: baocheng_su@163.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=oZSMG
	bMiHs2Wg3ShYgK41rgUoKuBogXs00Kc8GWxohE=; b=D418jUPiE16PtSlaOlH5w
	kTUKqg4tH5NKaxgE2xRY7QaRsUOhEIhqjj97Fanq2s/s/cZuzDXVb8YakodR72F1
	yi8F2npDo5gj8ZuaVY32somXducYwQ1rvWI9Na6zPen3RfRDu+5kDCe6c+xRfHFq
	eeuVbR2kwBsYEzqozEV+R4=
Received: from debian-on-mac.lan (unknown [116.169.3.110])
	by zwqz-smtp-mta-g0-0 (Coremail) with SMTP id _____wAHtanzrn5kHOJSBg--.9063S2;
	Tue, 06 Jun 2023 11:58:44 +0800 (CST)
From: baocheng_su@163.com
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com,
	felix.moessbauer@siemens.com
Cc: christian.storm@siemens.com,
	quirin.gylstorff@siemens.com,
	baocheng.su@siemens.com
Subject: [isar-cip-core][PATCH v2 0/2] Add recipes for optee-cilent and optee based initramfs fTPM hook
Date: Tue,  6 Jun 2023 11:55:04 +0800
Message-Id: <20230606035506.10354-1-baocheng_su@163.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
X-CM-TRANSID: _____wAHtanzrn5kHOJSBg--.9063S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZF1kZr15JFWkAFyUKF4rZrb_yoW8Xr47pa
	y5CFy5XrZ8Aa4xG39ak3WUZryfJ348Aws5ArnrWr4UA34xGr98JF47KF1UuFZIqr48X3W0
	qF4jqa4Y9F12kFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jbL0OUUUUU=
X-Originating-IP: [116.169.3.110]
X-CM-SenderInfo: pedrux5hqjs2rx6rljoofrz/xtbBFBaGJ1aEIDxU9gAAsP
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 06 Jun 2023 12:14:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11875

From: Su Baocheng <baocheng.su@siemens.com>

This brings the optee-client, mainly the tee-supplicant, then the fTPM
initramfs hook based on the optee & RPMB backed fTPM.

Changes v2:
- Fix the typo
- Document the current status regarding the *tee.ko in the stock debian
  kernel.

Baocheng Su (2):
  Add recipe for optee-client
  initramfs: Add recipe for optee based ftpm hook

 recipes-bsp/optee-client/files/control.tmpl   | 51 +++++++++++++++++++
 recipes-bsp/optee-client/files/rules.tmpl     | 20 ++++++++
 .../optee-client/files/tee-supplicant.service |  9 ++++
 .../optee-client/optee-client_3.20.0.bb       | 47 +++++++++++++++++
 .../initramfs-ms-ftpm-hook/files/ms-ftpm.hook | 38 ++++++++++++++
 .../files/ms-ftpm.script                      | 43 ++++++++++++++++
 .../initramfs-ms-ftpm-hook_0.1.bb             | 30 +++++++++++
 7 files changed, 238 insertions(+)
 create mode 100644 recipes-bsp/optee-client/files/control.tmpl
 create mode 100755 recipes-bsp/optee-client/files/rules.tmpl
 create mode 100644 recipes-bsp/optee-client/files/tee-supplicant.service
 create mode 100644 recipes-bsp/optee-client/optee-client_3.20.0.bb
 create mode 100644 recipes-initramfs/initramfs-ms-ftpm-hook/files/ms-ftpm.hook
 create mode 100644 recipes-initramfs/initramfs-ms-ftpm-hook/files/ms-ftpm.script
 create mode 100644 recipes-initramfs/initramfs-ms-ftpm-hook/initramfs-ms-ftpm-hook_0.1.bb

-- 
2.39.2


