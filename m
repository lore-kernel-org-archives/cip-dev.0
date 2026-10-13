Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4548ECC6B12
	for <webhook@archiver.kernel.org>; Tue, 13 Oct 2026 22:35:43 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.131])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.585.1791930932367470196
 for <cip-dev@lists.cip-project.org>;
 Tue, 13 Oct 2026 15:35:33 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key2.smx header.b=CJWrQwb7;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.131, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:Cc:
	Subject:Date:Message-Id:In-Reply-To:References:MIME-Version:Content-Type:
	Content-Transfer-Encoding;i=nobuhiro.iwamatsu.x90@mail.toshiba;s=key2.smx;t=
	1791930924;x=1793140524;bh=PEqysSudPbUbrbQvOyyN1B5bgm8duWQGXVYnV0MNJFw=;b=CJW
	rQwb7pYldgvAb5N57vQKFReg88Xy7p1TAjIZmkFtbdsTZhhLedvz+DhyV+bKqlVPfPMLbvnzQUUj1
	c2QAHQXpL9F1V3us11JU3K4SQwCTdklQDQG1W2p3W9NaRQArAqhnPP+ngAZAmvpAgOX0I9Eao1/PI
	UZkWF+j5yaJguQ8kEK6kDB5l+WjECsUKXk0j7VwH/PLw2MEogFr/eQvYLuGsMQ32p1UJa5/7voygx
	miOq0DNcM6QMvXKp3BaU7QDNS6L2Zq7F47G0g/+fJwexr4g9qiCriG3870UuCxLveyXuiEBXfWnGE
	4WqSTwx1r0TZcjuZwKzvwasZoShU+iA==;
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 69DMZNsF135651; Wed, 14 Oct 2026 07:35:23 +0900
X-Iguazu-Qid: 2rWh1SQBryNd1vGfsP
X-Iguazu-QSIG: v=2; s=1; t=1791930923; q=2rWh1SQBryNd1vGfsP; m=eVuRZKKTnFVclSv4leRzYE0n49ERKNBV/k35CM8WdJA=
Received: from imx12-a.toshiba.co.jp (unknown [38.106.60.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4j48L16Z1zz1xnf; Wed, 14 Oct 2026 07:35:21 +0900 (JST)
From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
To: cip-dev@lists.cip-project.org
Cc: pavel@nabladev.com, uli@fpond.eu, john.madieu.xa@bp.renesas.com,
        biju.das.jz@bp.renesas.com,
        Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
Subject: [PATCH 6.1.y-cip 2/3] PCI: rzg3s-host: Remove duplicate field_get()
Date: Wed, 14 Oct 2026 07:35:18 +0900
X-TSB-HOP2: ON
Message-Id: <1791930919-10628-3-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1791930919-10628-1-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
References: <1791930919-10628-1-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 13 Oct 2026 22:35:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24452

The LTS commit 94cad2c26306 ("bitfield: Add non-constant field_{prep,get}()
helpers") causes a duplicate definition of field_get().
This removes field_get() from pcie-rzg3s-host.c, where the modification
was made.

```
drivers/pci/controller/pcie-rzg3s-host.c:181:9: error: ‘field_prep’ redefined [-Werror]
  181 | #define field_prep(_mask, _val) (((_val) << (ffs(_mask) - 1)) & (_mask))
      |         ^~~~~~~~~~
In file included from drivers/pci/controller/pcie-rzg3s-host.c:12:
./include/linux/bitfield.h:277:9: note: this is the location of the previous definition
  277 | #define field_prep(mask, val)                                           \
      |         ^~~~~~~~~~
```

Fixes: d71d7aba7486 ("PCI: rzg3s-host: Revert generic field helpers, use a local field_prep()")
Cc: John Madieu <john.madieu.xa@bp.renesas.com>
Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
---
 drivers/pci/controller/pcie-rzg3s-host.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/pci/controller/pcie-rzg3s-host.c b/drivers/pci/controller/pcie-rzg3s-host.c
index 45cc2f3782aba3..1b92371292ddeb 100644
--- a/drivers/pci/controller/pcie-rzg3s-host.c
+++ b/drivers/pci/controller/pcie-rzg3s-host.c
@@ -178,8 +178,6 @@
 /* Timeouts experimentally determined */
 #define RZG3S_REQ_ISSUE_TIMEOUT_US		2500
 
-#define field_prep(_mask, _val) (((_val) << (ffs(_mask) - 1)) & (_mask))
-
 /**
  * struct rzg3s_sysc_function - System Controller function descriptor
  * @offset: Register offset from the System Controller base address
-- 
2.55.0



