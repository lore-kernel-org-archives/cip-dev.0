Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA13BC87FC9
	for <webhook@archiver.kernel.org>; Wed, 30 Jul 2025 03:09:46 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.web10.26541.1753844976240681224
 for <cip-dev@lists.cip-project.org>;
 Tue, 29 Jul 2025 20:09:37 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.s=key1.smx header.b=cF7llJiS;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.158, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:Cc
	:Subject:Date:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding;
	i=nobuhiro1.iwamatsu@toshiba.co.jp;s=key1.smx;t=1753844957;x=1755054557;bh=sH
	+DRkuo0xFgqzv8eYBZA0lUFKtn1YDHA+JbdtnsHq4=;b=cF7llJiSNAB3JHformW1yhh8658SjBW9
	S6TSZoq0spIa8HZtylPeUdvUzFEakrESp0/t64g/y7H1R06k6fYqUe3S6h2VO7uNkAx+QigBJTTAd
	evxO+2+ySUyKWLywg2JhCDgLo+x9w+Bt8Vc8aNb0rnCMXlHvfrylglN1SDjwU8YvHj4w5UriPFaCY
	RgwOvTOOljwcga71oubKCbcDla5GMqotjQh7pZ1ekhg705aKGrnZ/hV7AZyBPp7y7uml/GmAk9WDu
	bFNlK3tSZ0d5EXCRwls3Gn4uZR1t+sT+VCuwCuJ8KvoItLTBRG+3ZmZPU+UAmTIe0p6n2GwTgpvi3
	mA==;
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 56U39GRp3867756; Wed, 30 Jul 2025 12:09:16 +0900
X-Iguazu-Qid: 2rWhMjEQMyVbCphmHA
X-Iguazu-QSIG: v=2; s=0; t=1753844956; q=2rWhMjEQMyVbCphmHA; m=zXe2KmBoJiT7YW/mFL81z1R/8cNvlgh6gwbjsz13exY=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1121) id 56U39EF23026312
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 30 Jul 2025 12:09:15 +0900
From: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
To: cip-dev@lists.cip-project.org, uli@fpond.eu
Cc: pavel@denx.de, Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: [PATCH for linux-4.19.y-cip] emulex/benet: Fix build by return mismatch in be_cmd_unlock()
Date: Wed, 30 Jul 2025 12:09:10 +0900
X-TSB-HOP2: ON
Message-Id: <1753844950-3625-1-git-send-email-nobuhiro1.iwamatsu@toshiba.co.jp>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 30 Jul 2025 03:09:46 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19617

be_cmd_unlock() has no return value. However, spin_unlock_bh is called
with return, causing a build error. This removes return and fixes the error.

```
$ make drivers/net/ethernet/emulex/benet/be_cmds.o
  CALL    scripts/checksyscalls.sh
  DESCEND  objtool
  CC      drivers/net/ethernet/emulex/benet/be_cmds.o
In file included from ./include/linux/spinlock.h:317,
                 from ./include/linux/seqlock.h:36,
                 from ./include/linux/time.h:6,
                 from ./include/linux/stat.h:19,
                 from ./include/linux/module.h:10,
                 from drivers/net/ethernet/emulex/benet/be_cmds.c:18:
drivers/net/ethernet/emulex/benet/be_cmds.c: In function ‘be_cmd_unlock’:
./include/linux/spinlock_rt.h:113:9: error: expected expression before ‘do’
  113 |         do {                                            \
      |         ^~
drivers/net/ethernet/emulex/benet/be_cmds.c:883:24: note: in expansion of macro ‘spin_unlock_bh’
  883 |                 return spin_unlock_bh(&adapter->mcc_lock);
      |                        ^~~~~~~~~~~~~~
./include/linux/spinlock_rt.h:113:9: error: ‘return’ with a value, in function returning void [-Werror=return-type]
  113 |         do {                                            \
      |         ^~
drivers/net/ethernet/emulex/benet/be_cmds.c:883:24: note: in expansion of macro ‘spin_unlock_bh’
  883 |                 return spin_unlock_bh(&adapter->mcc_lock);
      |                        ^~~~~~~~~~~~~~
drivers/net/ethernet/emulex/benet/be_cmds.c:880:13: note: declared here
  880 | static void be_cmd_unlock(struct be_adapter *adapter)
      |             ^~~~~~~~~~~~~
cc1: some warnings being treated as errors
make[1]: *** [scripts/Makefile.build:304: drivers/net/ethernet/emulex/benet/be_cmds.o] Error 1
make: *** [Makefile:1719: drivers/net/ethernet/emulex/benet/be_cmds.o] Error 2
```

Fixes: 3ec3ccba308945d3f65a1adb0889aab016f1f12b ("be2net: fix sleeping while atomic bugs in be_ndo_bridge_getlink")
Signed-off-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
---
 drivers/net/ethernet/emulex/benet/be_cmds.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/emulex/benet/be_cmds.c b/drivers/net/ethernet/emulex/benet/be_cmds.c
index 7d0d0ca754290..bdd0e8f003266 100644
--- a/drivers/net/ethernet/emulex/benet/be_cmds.c
+++ b/drivers/net/ethernet/emulex/benet/be_cmds.c
@@ -880,7 +880,7 @@ static int be_cmd_lock(struct be_adapter *adapter)
 static void be_cmd_unlock(struct be_adapter *adapter)
 {
 	if (use_mcc(adapter))
-		return spin_unlock_bh(&adapter->mcc_lock);
+		spin_unlock_bh(&adapter->mcc_lock);
 	else
 		return mutex_unlock(&adapter->mbox_lock);
 }
-- 
2.39.5



