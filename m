Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D409BC46CD2
	for <webhook@archiver.kernel.org>; Fri, 22 Dec 2023 02:45:12 +0000 (UTC)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 by mx.groups.io with SMTP id smtpd.web10.10403.1703208995153091296
 for <cip-dev@lists.cip-project.org>;
 Thu, 21 Dec 2023 17:36:35 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@kernel.org header.s=k20201202 header.b=aJNEiX9t;
 spf=pass (domain: kernel.org, ip: 145.40.68.75, mailfrom: uli@kernel.org)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by ams.source.kernel.org (Postfix) with ESMTP id 7DCD3B821E2;
	Fri, 22 Dec 2023 01:36:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7056C433C7;
	Fri, 22 Dec 2023 01:36:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703208991;
	bh=w+yVueYcIUGt2ot5aXMeHNe76XwGA30PUc89khssgKQ=;
	h=From:To:Cc:Subject:Date:From;
	b=aJNEiX9tkhjvDMnf5vrV52fuLXfadAB18r1DG9g1KIoYvix9FqiJgTKA+YvZn4mym
	 iLTGF4oiYMHZ/bUFimOE6UI4y6Fz+kL+V9uCf0+wwww5AAulEMU9irjtt3UG9gDInc
	 ULqnCgqVGdxYM0HOo2pN/Eedcph7mjpuwRrZqDdXStODB/bM9Kl1CJcwUSZzYR6Pxa
	 ehpiXaXyyNOzjRROE0LJtGBLbUJQ8ixkBEA8n1kklcGOI4o2OkgusnqP97vfUhPVoa
	 35ednF9Bi7o8IiSUPq98wmNSpGvBrKcqcfhu0RrqGTM7o1avWv4/03RkzCsCLGDvfd
	 DRnSObWVG063A==
From: uli@kernel.org
To: cip-dev@lists.cip-project.org,
	ahoemig@datus.com
Cc: Ulrich Hecht <uli@kernel.org>
Subject: [PATCH] Revert "md: fix a crash in mempool_free"
Date: Fri, 22 Dec 2023 02:36:24 +0100
Message-Id: <20231222013624.1814544-1-uli@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 22 Dec 2023 02:45:12 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14190

From: Ulrich Hecht <uli@kernel.org>

This reverts commit a8e2077ebc799a5fc55c369d4a4e41ba05534fb6, which is
commit cf06b162f5b6337b688072a1a47941280b8f7110 upstream.

The patch has been applied twice:

779785788a82f md: fix a crash in mempool_free
a8e2077ebc799 md: fix a crash in mempool_free

This reverts the second variant which has been mangled and causes a crash
when using raid1.

Reported-by: Alexander H=C3=B6mig <ahoemig@datus.com>
Fixes: a8e2077ebc79 ("md: fix a crash in mempool_free")
Signed-off-by: Ulrich Hecht <uli@kernel.org>
---

Alexander, could you do us the favor of testing this again to make sure t=
hat
the removal of the rdev_dec_pending() call doesn't cause any issues? Than=
ks.

CU
Uli

 drivers/md/md.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 09e1b21460470..67bfdd95e9d4a 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -736,10 +736,6 @@ static void super_written(struct bio *bio)
=20
 	bio_put(bio);
=20
-	bio_put(bio);
-
-	rdev_dec_pending(rdev, mddev);
-
 	if (atomic_dec_and_test(&mddev->pending_writes))
 		wake_up(&mddev->sb_wait);
 }
--=20
2.39.2


