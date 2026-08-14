Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBDE1C5CFC1
	for <webhook@archiver.kernel.org>; Fri, 14 Aug 2026 13:01:46 +0000 (UTC)
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.12239.1786712503256736533
 for <cip-dev@lists.cip-project.org>;
 Fri, 14 Aug 2026 06:01:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm2 header.b=gu4wKnKK;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.226, mailfrom: fm-294854-20260814130139aca2d1194c0002075f-ca_h84@rts-flowmailer.siemens.com)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20260814130139aca2d1194c0002075f
        for <cip-dev@lists.cip-project.org>;
        Fri, 14 Aug 2026 15:01:40 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=psW6ckyKXF8WcxUIyt9OVMhjiVCByxVCdXTUieu9z44=;
 b=gu4wKnKKS/UlKtASiaCiFOuJQEn+7BYOOS/BiPj6zOaM0uXu0bYsDP+/v88vB/plj13otO
 DCMUgalTEaPrbP4AK8Id65xDX75VqCK6cYjBaIIrVL1Sn45FR8dfcnaLpDMObYYAq1BkuZCs
 v8p7z5SNrBNQ5Sp14DIs9bnyxtbinq2ENdvWdfyaXBsegghVDFNkjovnX4M1iOr4EYBRS6jG
 FspGHFChq7lbwYVUovo0+sl4I4za4oxdgH5dZxkWf5eAl6NPbKewED0pQ/9JUrErbaGnbD6L
 S5nUuTP3WWUf0d0TO7pZ4wDZJh5XSF/SY7/5aP01o1qpixFZDEDTkSrQ==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: Sai Sree Kartheek Adivi <s-adivi@ti.com>,
	Sven Bauer <svenbauer@siemens.com>,
	Benedikt Niedermayr <benedikt.niedermayr@siemens.com>
Subject: [isar-cip-core][PATCH 0/4] OP-TEE and fTPM updates
Date: Fri, 14 Aug 2026 15:01:35 +0200
Message-ID: <cover.1786712498.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 14 Aug 2026 13:01:46 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23939

This is bumping the version of our OP-TEE integration, primarily to
refresh the optee_ftpm feed so that recently published CVEs [1] and [2]
can be addressed. The updates take place for both qemu-arm64 and the
ti-k3 (used for AM62Px SK).

While firmware is not a delivery CIP has committed to maintain, we know
some downstream consumers of the bits we have here. Furthermore, the
current TPM provider to optee_ftpm imposes certain challenges on
integrators that became specifically visible in the light of these two
CVEs. We therefore think it is more efficient to share common bits here,
rather than waiting for the ecosystem to improve further first.

For further details on fTPM updates, see also [3] and [4].

Jan

[1] https://www.cve.org/CVERecord?id=CVE-2026-6726
[2] https://www.cve.org/CVERecord?id=CVE-2026-6727
[3] https://github.com/OP-TEE/optee_ftpm/issues/29
[4] https://github.com/OP-TEE/optee_ftpm/pull/25

Jan Kiszka (4):
  optee: Update to 4.10.0
  optee-ftpm: Factor out common recipe bits of qemu-arm64 and ti-k3
    targets
  optee-ftpm: Update to TPM reference implementation V184
  optee-ftpm: Apply security fixes for V184

 ...1-Address-improper-object-slot-reuse.patch |   95 +
 ...PM-2.0-Reference-Implementation-v184.patch | 3885 +++++++++++++++++
 ...EP-timing-side-channel-vulnerability.patch |   46 +
 ...002-Disable-command-TPM2_CertifyX509.patch |   29 +
 .../optee-ftpm-qemu-arm64_4.10+V184.bb        |   17 +
 ...ftpm-qemu-arm64_4.8+v1.62r1-48-ge9fc7b8.bb |   32 -
 .../optee-ftpm/optee-ftpm-ti-k3_4.10+V184.bb  |   15 +
 ...ptee-ftpm-ti-k3_4.8+v1.62r1-48-ge9fc7b8.bb |   30 -
 .../optee-ftpm/optee-ftpm_4.10+V184.inc       |   31 +
 ...4.8.0.bb => optee-os-qemu-arm64_4.10.0.bb} |    0
 ...8.0.inc => optee-os-qemu-arm64_4.10.0.inc} |    2 +-
 ...=> optee-os-tadevkit-qemu-arm64_4.10.0.bb} |    0
 ...0.bb => optee-os-tadevkit-ti-k3_4.10.0.bb} |    0
 ...i-k3_4.8.0.bb => optee-os-ti-k3_4.10.0.bb} |    0
 ...k3_4.8.0.inc => optee-os-ti-k3_4.10.0.inc} |    2 +-
 15 files changed, 4120 insertions(+), 64 deletions(-)
 create mode 100644 recipes-bsp/optee-ftpm/files/0001-Address-improper-object-slot-reuse.patch
 create mode 100644 recipes-bsp/optee-ftpm/files/0001-Update-to-TPM-2.0-Reference-Implementation-v184.patch
 create mode 100644 recipes-bsp/optee-ftpm/files/0002-Address-RSA-OAEP-timing-side-channel-vulnerability.patch
 create mode 100644 recipes-bsp/optee-ftpm/files/0002-Disable-command-TPM2_CertifyX509.patch
 create mode 100644 recipes-bsp/optee-ftpm/optee-ftpm-qemu-arm64_4.10+V184.bb
 delete mode 100644 recipes-bsp/optee-ftpm/optee-ftpm-qemu-arm64_4.8+v1.62r1-48-ge9fc7b8.bb
 create mode 100644 recipes-bsp/optee-ftpm/optee-ftpm-ti-k3_4.10+V184.bb
 delete mode 100644 recipes-bsp/optee-ftpm/optee-ftpm-ti-k3_4.8+v1.62r1-48-ge9fc7b8.bb
 create mode 100644 recipes-bsp/optee-ftpm/optee-ftpm_4.10+V184.inc
 rename recipes-bsp/optee-os/{optee-os-qemu-arm64_4.8.0.bb => optee-os-qemu-arm64_4.10.0.bb} (100%)
 rename recipes-bsp/optee-os/{optee-os-qemu-arm64_4.8.0.inc => optee-os-qemu-arm64_4.10.0.inc} (78%)
 rename recipes-bsp/optee-os/{optee-os-tadevkit-qemu-arm64_4.8.0.bb => optee-os-tadevkit-qemu-arm64_4.10.0.bb} (100%)
 rename recipes-bsp/optee-os/{optee-os-tadevkit-ti-k3_4.8.0.bb => optee-os-tadevkit-ti-k3_4.10.0.bb} (100%)
 rename recipes-bsp/optee-os/{optee-os-ti-k3_4.8.0.bb => optee-os-ti-k3_4.10.0.bb} (100%)
 rename recipes-bsp/optee-os/{optee-os-ti-k3_4.8.0.inc => optee-os-ti-k3_4.10.0.inc} (90%)

-- 
2.47.3


