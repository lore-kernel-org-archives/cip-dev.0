Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FEFBD62040
	for <webhook@archiver.kernel.org>; Tue, 19 Nov 2024 09:04:19 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.131])
 by mx.groups.io with SMTP id smtpd.web11.16741.1732007051269861432
 for <cip-dev@lists.cip-project.org>;
 Tue, 19 Nov 2024 01:04:12 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.s=key2.smx header.b=NV69aAAN;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.131, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:Cc
	:Subject:Date:Message-Id;i=nobuhiro1.iwamatsu@toshiba.co.jp;s=key2.smx;t=
	1732007035;x=1733216635;bh=a0ezc3a3IoWJPMCRgBPumxZ3+/wA2dXZKew85bn275Q=;b=NV6
	9aAANFQmFLoABMlhU4icCdS9ki0emXUcgqmpx0CunJo/JzySYXyOhJNe9cWR9OO6EYw7TxK+utGnW
	+tnAK9kNyFgFwuV56pjVJk7uH75sNVH4v4FdwlE5jzCC99BCs4iWi/3Se9TUlCMjMe8bCDq3xC6RN
	g7uff7oNRQbFg2MNf2lvS+fYN5/cM/DC+X5F330KDSoQomN/dQKsgkB1L1RVxmnKv8n8gYNdzCTHz
	17Fqqm/IRPF5y5gG21pre0wif/gM4Ec14mQIjQ254WXx/nXlQxeZLqmSIYVYwVTjKAKci/TiRQvrs
	7Nw1REkp8FIuyN6W0W0m0ZJ5dCZluXQ==;
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 4AJ93sdO843444; Tue, 19 Nov 2024 18:03:54 +0900
X-Iguazu-Qid: 2rWhPWJ0lyOonAc9Cb
X-Iguazu-QSIG: v=2; s=0; t=1732007034; q=2rWhPWJ0lyOonAc9Cb; m=vutERctM+3IvgvtiI8wIq2xD45yTaatpq/M12t9qCvo=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1123) id 4AJ93qoE1573448
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 19 Nov 2024 18:03:52 +0900
From: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
To: Ulrich Hecht <uli@fpond.eu>
Cc: cip-dev@lists.cip-project.org, pavel@denx.de,
        Hans de Goede <hdegoede@redhat.com>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: [PATCH for 4.4] printk: Export is_console_locked
Date: Tue, 19 Nov 2024 18:03:50 +0900
X-TSB-HOP2: ON
Message-Id: <1732007030-15207-1-git-send-email-nobuhiro1.iwamatsu@toshiba.co.jp>
X-Mailer: git-send-email 2.7.4
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 19 Nov 2024 09:04:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17261

From: Hans de Goede <hdegoede@redhat.com>

commit d48de54a9dab5370edd2e991f78cc7996cf5483e upstream.

This is a preparation patch for adding a number of WARN_CONSOLE_UNLOCKED()
calls to the fbcon code, which may be built as a module (event though
usually it is not).

Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Acked-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Acked-by: Petr Mladek <pmladek@suse.com>
Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Signed-off-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
---
 kernel/printk/printk.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 6d3e1f4961fbb..6d51c94081faf 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2203,6 +2203,7 @@ int is_console_locked(void)
 {
 	return console_locked;
 }
+EXPORT_SYMBOL(is_console_locked);
 
 static void console_cont_flush(char *text, size_t size)
 {
-- 
2.45.2



