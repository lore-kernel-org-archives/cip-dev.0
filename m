Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7B19C5DF7D
	for <webhook@archiver.kernel.org>; Wed, 19 Aug 2026 02:13:02 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.134])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.24076.1787105581690195087
 for <cip-dev@lists.cip-project.org>;
 Tue, 18 Aug 2026 19:13:02 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key2.smx header.b=VAWxWTVg;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.134, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:Cc:
	Subject:Date:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding;
	i=nobuhiro.iwamatsu.x90@mail.toshiba;s=key2.smx;t=1787105579;x=1788315179;bh=
	iFlnetn2V/mi3iVQZo6kbwAOJ/vW3XTngZaaXrzUta8=;b=VAWxWTVgSzbXPNAYz58fM3ZvhQ5+HA
	QxwU+1nLMy5rNLsjynmR3aBJhNjupK49iZay6a9lQTsBS6oCo+2tEp/7F5D0BBZ9OTI/f0UQRQM7L
	V4W2jNXOd+8vel5uBHXPM+5XySg59ziOONAuJdOdSgnxr6SznVr9DJCIj9thnwIPhrvaQIJY1fvU7
	I35XjtP89Z4iTzseupAZ3GVPy+1Ryuc/a6247aKS7uvY+cQMz9x9T5lSOyoZjKyRrokY5QIuHIriC
	L3FJAjmbgzYQJW3VXfA4Gyb38xdd6Yiy86Fe9SALDf1s1XhGLty73gSG4NpIma6568Yql5PtZKrIN
	Ww/Q==;
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 67J2CxC91130934; Wed, 19 Aug 2026 11:12:59 +0900
X-Iguazu-Qid: 2yAbG25DVCLLIAEldb
X-Iguazu-QSIG: v=2; s=1; t=1787105579; q=2yAbG25DVCLLIAEldb; m=m/iLvA3rJYitnf8Uda0Igxh4EVu/9NNeXV7xWl9YLmQ=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4hPqpy4VbFz1xnh; Wed, 19 Aug 2026 11:12:58 +0900 (JST)
From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
To: cip-dev@lists.cip-project.org
Cc: pavel@nabladev.com, claudiu.beznea.uj@bp.renesas.com
Subject: [PATCH 6.1.y-cip 0/2]  Fix for module build in ohci-platform.c
Date: Wed, 19 Aug 2026 11:12:55 +0900
X-TSB-HOP2: ON
Message-Id: <1787105577-3655-1-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 19 Aug 2026 02:13:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23947

The commit “3c134b7b41d (”of: Add of_machine_compatible_match()“)”,
which was backported to 6.1.y-cip, causes an error when building the
module in ohci-platform.c.
This fixes an issue with of_machine_compatible_match().

```
[...]
  OBJCOPY modules.builtin.modinfo
  GEN     modules.builtin
  GEN     .vmlinux.objs
  MODPOST Module.symvers
ERROR: modpost: "of_machine_compatible_match" [drivers/usb/host/ohci-platform.ko] undefined!
make[5]: *** [../scripts/Makefile.modpost:127: Module.symvers] Error 1
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
2.51.0



