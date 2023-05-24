Return-Path: <ch@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A5C3C77B73
	for <webhook@archiver.kernel.org>; Wed, 24 May 2023 08:27:44 +0000 (UTC)
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by mx.groups.io with SMTP id smtpd.web10.4127.1684916859382239797
 for <cip-dev@lists.cip-project.org>;
 Wed, 24 May 2023 01:27:40 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@denx.de header.s=phobos-20191101 header.b=F8XbpFoJ;
 spf=pass (domain: denx.de, ip: 85.214.62.61, mailfrom: ch@denx.de)
Received: from localhost (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: ch@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 03FD785F72;
	Wed, 24 May 2023 10:27:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1684916857;
	bh=hH8HzTSFW7+ce7OdJWIiCOHzcGdcyMOg71YnJKJ82Pw=;
	h=From:To:Cc:Subject:Date:From;
	b=F8XbpFoJIVV+kZPmOe17mzi+achyDOphRpk7ceNMO+OpJKjD46e71FQLO+I7RzwqQ
	 BkXgUIEzpm089uZxDFJt2ySPd59e9P0LiGXP8tERPo7FTCdyqqTgDe+cpklZW9W4TD
	 ymN5JFXRT6eMf22unxE3YXYvMlY/dQU0D+IJsTR0OeRANz9IL4oklu6h8BhQ+Xb7lY
	 +w+/bQIgN9uDNsv120XeeZbR02yHJhRLyrsGe88n3p7FzwVFqj5Ev/UdnHpLuskvk2
	 meXWS6ipxJsmiLKrTYtIs8S07uT5Lf2oB1y+DTXeKuiVXFK1kaNVko6fo+gSdOgodh
	 0AnJKMDY8Qw8Q==
From: Claudius Heine <ch@denx.de>
To: cip-dev@lists.cip-project.org
Cc: Claudius Heine <ch@denx.de>
Subject: [cip-kernel-config][PATCH 0/2] Siemens IPC127e - 4.19 and 6.1 cfg
Date: Wed, 24 May 2023 10:27:23 +0200
Message-Id: <20230524082725.41558-1-ch@denx.de>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 24 May 2023 08:27:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11629

Hi,

since the 5.10 Siemens IPC127e patch was merged as I submitted it, here
are the configs for 4.19 and 6.1.

They are the same as before, copies of the IPC227e with WDAT_WDT added.

cheers,
Claudius

Claudius Heine (2):
  4.19.y-cip/x86: add Siemens IPC127e defconfig
  6.1.y-cip/x86: add Siemens IPC127e defconfig

 4.19.y-cip/x86/siemens_ipc127e.sources   |  9135 +++++++++++++++++
 4.19.y-cip/x86/siemens_ipc127e_defconfig |   456 +
 6.1.y-cip/x86/siemens_ipc127e.sources    | 10961 +++++++++++++++++++++
 6.1.y-cip/x86/siemens_ipc127e_defconfig  |   425 +
 4 files changed, 20977 insertions(+)
 create mode 100644 4.19.y-cip/x86/siemens_ipc127e.sources
 create mode 100644 4.19.y-cip/x86/siemens_ipc127e_defconfig
 create mode 100644 6.1.y-cip/x86/siemens_ipc127e.sources
 create mode 100644 6.1.y-cip/x86/siemens_ipc127e_defconfig

--=20
2.40.1


