Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C10FC61DB9
	for <webhook@archiver.kernel.org>; Fri, 28 Aug 2026 01:51:56 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.179.1787881910566228094
 for <cip-dev@lists.cip-project.org>;
 Thu, 27 Aug 2026 18:51:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key2.smx header.b=JZoALTyw;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.158, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:Cc:
	Subject:Date:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding;
	i=nobuhiro.iwamatsu.x90@mail.toshiba;s=key2.smx;t=1787881900;x=1789091500;bh=
	L32TAb0eG1zT8HpUncKT0CLdnNz3QL8xgNJf7tQ9N94=;b=JZoALTyw4fcJQvv+rQIOax0QE+4zd4
	pqONhPVgtsxnKbR1VzyzthLpu1e0201KPUnCtsCAfDHg4Vqe1gJ8Y0rNxdsfENULeI+yERseZRiiK
	JCVyMohtwgRToNiZyE/m/jBKha4iKNHZOuNpGrtncIENzLtJCIKtHZvZQboxnfz9DoBfeYGKNNXPy
	0XzZnHSI8WDPF8RPbFqx8PizYXXwdR8lGSZKOvjHQf4YOsZ3M6PO34BvTeNRlE0bTGRIcJPEcwSrZ
	hKViI6aTji5rOUXUGqZHFbZzCWiEhx05eS1EZ95Uhtt2pFFkVMh8jfNuXsZecz4vbx37TAR0crau7
	yLdQ==;
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 67S1peZt525968; Fri, 28 Aug 2026 10:51:40 +0900
X-Iguazu-Qid: 2rWh1q7viENyVSqLj7
X-Iguazu-QSIG: v=2; s=1; t=1787881900; q=2rWh1q7viENyVSqLj7; m=JZIK6E74gzmGs1X6/ra4ciWE05f/m4IehYXE3n8hpWc=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4hWLwB60jmz1xnp; Fri, 28 Aug 2026 10:51:38 +0900 (JST)
From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
To: cip-dev@lists.cip-project.org
Cc: pavel@nabladev.com, uli@fpond.eu, claudiu.beznea.uj@bp.renesas.com
Subject: [PATCH 5.10.y-cip 0/2] Fix for module build in ohci-platform.c
Date: Fri, 28 Aug 2026 10:51:35 +0900
X-TSB-HOP2: ON
Message-Id: <1787881897-6475-1-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 28 Aug 2026 01:51:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24042

The commit “22cb10519e8f (”of: Add of_machine_compatible_match()“)”,
which was backported to 5.10.y-cip, causes an error when building the
module in ohci-platform.c.
This fixes an issue with of_machine_compatible_match().

```
[...]
  SORTTAB vmlinux
  SYSMAP  System.map
  MODPOST modules-only.symvers
  OBJCOPY arch/arm64/boot/Image
  GZIP    arch/arm64/boot/Image.gz
ERROR: modpost: "of_machine_compatible_match" [drivers/usb/host/ohci-platform.ko] undefined!
make[1]: *** [scripts/Makefile.modpost:123: modules-only.symvers] Error 1
```

Christophe Leroy (1):
  of: Reimplement of_machine_is_compatible() using
    of_machine_compatible_match()

Michael Ellerman (1):
  of: Change of_machine_is_compatible() to return bool

 drivers/of/base.c  | 22 +---------------------
 include/linux/of.h | 14 +++++++++++++-
 2 files changed, 14 insertions(+), 22 deletions(-)

-- 
2.39.5



