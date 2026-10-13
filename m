Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3415CCC6B0F
	for <webhook@archiver.kernel.org>; Tue, 13 Oct 2026 22:35:43 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.134])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.586.1791930932307677145
 for <cip-dev@lists.cip-project.org>;
 Tue, 13 Oct 2026 15:35:33 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key2.smx header.b=ClSbUAeU;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.134, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:Cc:
	Subject:Date:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding;
	i=nobuhiro.iwamatsu.x90@mail.toshiba;s=key2.smx;t=1791930923;x=1793140523;bh=
	C0BdJkx/7hT8MtkRkm/f2w20WPSJ2RMYIve8jElR0Uo=;b=ClSbUAeUQb8bUEnjIFOZJnPYmZ5WwC
	40FTyAwa8obSmWnqBbEdbsYDyqZJtY5cHhWKDn1eSWWePqEXGoCz990SgrG7bQL/cvjzb4Z8i7bnp
	5/BsL9L6FrlrQyMak0zxfh69IZrgKwK6CxZ5Q6vWeGZUtpJpiuYtCw48IGrX6CJ7eU13fyujzhmIi
	JNipagCNWr45WWkPlt65pxYGVgaQP6vbrayNitIi3t6Qqg2OR//BYLIof5tEY5iDW4ypwr3wJ/sGb
	JPBSXKwwBHCedAZJWJZ4rYCC9Ml9flxmD+rERIFsbKsxOSoAFJ1bm2RWfHnIt4qb4Bxh7elMw4ASb
	Y6aw==;
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 69DMZMvE3813856; Wed, 14 Oct 2026 07:35:22 +0900
X-Iguazu-Qid: 2yAaDenV22hwKqWwxH
X-Iguazu-QSIG: v=2; s=1; t=1791930922; q=2yAaDenV22hwKqWwxH; m=ZSZ1WeB+fl//30/oFAnFmk1IPdt0v5L+1Fd0ewEG8+g=
Received: from imx12-a.toshiba.co.jp (unknown [38.106.60.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4j48L13Yf7zyPQ; Wed, 14 Oct 2026 07:35:21 +0900 (JST)
From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
To: cip-dev@lists.cip-project.org
Cc: pavel@nabladev.com, uli@fpond.eu, john.madieu.xa@bp.renesas.com,
        biju.das.jz@bp.renesas.com
Subject: [PATCH 6.1.y-cip 0/3] Remove duplicate field_get()
Date: Wed, 14 Oct 2026 07:35:16 +0900
X-TSB-HOP2: ON
Message-Id: <1791930919-10628-1-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 13 Oct 2026 22:35:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24451

Hi,


This series fixes the duplication of field_get() introduced by the LTS commit
94cad2c26306 ("bitfield: Add non-constant field_{prep,get}() helpers").

Geert Uytterhoeven (1):
  soc: renesas: rz-sysc: Convert to common field_get() helper

Nobuhiro Iwamatsu (2):
  irqchip/renesas-rzv2h: Remove duplicate field_get()
  PCI: rzg3s-host: Remove duplicate field_get()

 drivers/irqchip/irq-renesas-rzv2h.c      | 2 --
 drivers/pci/controller/pcie-rzg3s-host.c | 2 --
 drivers/soc/renesas/rz-sysc.c            | 3 +--
 3 files changed, 1 insertion(+), 6 deletions(-)

-- 
2.55.0



