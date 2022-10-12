X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by mx.groups.io with SMTP id smtpd.web08.18276.1665569257811425568
 for <cip-dev@lists.cip-project.org>;
 Wed, 12 Oct 2022 03:07:38 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=felix.moessbauer@siemens.com header.s=fm1 header.b=KnEDXil+;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.227, mailfrom: fm-72506-20221012100734e971e405ca091fa104-_glz_s@rts-flowmailer.siemens.com)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20221012100734e971e405ca091fa104
        for <cip-dev@lists.cip-project.org>;
        Wed, 12 Oct 2022 12:07:35 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=felix.moessbauer@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=u1sq2IOet0EHRw5gKJbsyQ58dNy4VZcSV+i+4uX21hI=;
 b=KnEDXil+nI1u2QKszSCEgYMcWQu6DzK6hQhL4MOHxyyaf+OTgaz62/X0sB0G+v5O5pKAEO
 CuR+F6s3tT+UIP/Wk99DUloPkR6ErNiTq8eVSUoVgzK+nJuS68o/dX2POryEMir1X3N1EmJc
 ppeWXXOoGK1nCHTfXRV6nBV6+uw+U=;
From: Felix Moessbauer <felix.moessbauer@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: jan.kiszka@siemens.com,
	quirin.gylstorff@siemens.com,
	pluto.svc.chengdu.cn@siemens.com,
	Felix Moessbauer <felix.moessbauer@siemens.com>
Subject: [isar-cip-core][PATCH 0/3] Simplify integration of swupdate into downstream layers
Date: Wed, 12 Oct 2022 12:06:38 +0200
Message-Id: <20221012100641.2986740-1-felix.moessbauer@siemens.com>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-72506:519-21489:flowmailer
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

This series simplifies the integration of the swupdate infrastructure
into downstream layers and especially for debian stock kernels.

Best regards,
Felix Moessbauer

Felix Moessbauer (3):
  fix: add missing class dependencies in image_uuid
  fix: add squashfs hook to enforce load of module
  activate nodoc profile for swupdate build

 classes/image_uuid.bbclass                    |  3 +++
 kas/opt/ebg-swu.yml                           |  2 +-
 .../swupdate/swupdate_2021.11-1+debian-gbp.bb |  4 +++
 .../files/squashfs.hook                       | 25 +++++++++++++++++++
 .../initramfs-squashfs-hook_0.1.bb            | 24 ++++++++++++++++++
 5 files changed, 57 insertions(+), 1 deletion(-)
 create mode 100644 recipes-initramfs/initramfs-squashfs-hook/files/squashfs.hook
 create mode 100644 recipes-initramfs/initramfs-squashfs-hook/initramfs-squashfs-hook_0.1.bb

-- 
2.30.2


