Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADA4FC0219D
	for <webhook@archiver.kernel.org>; Thu, 13 Feb 2025 08:14:39 +0000 (UTC)
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
 by mx.groups.io with SMTP id smtpd.web11.5826.1739431328619457737
 for <cip-dev@lists.cip-project.org>;
 Wed, 12 Feb 2025 23:22:08 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@messagingengine.com header.s=fm3 header.b=NCnPkeyW;
 spf=none, err=SPF record not found (domain: linux-m68k.org, ip: 202.12.124.151, mailfrom: fthain@linux-m68k.org)
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.stl.internal (Postfix) with ESMTP id 50DA81140117;
	Thu, 13 Feb 2025 02:22:07 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Thu, 13 Feb 2025 02:22:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
	:feedback-id:from:from:in-reply-to:message-id:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1739431327; x=1739517727; bh=2pmDU7e3MlYtu8haZn4roILPX83I
	3ITd6BRmfCF1ljE=; b=NCnPkeyWuYqnLUVRRM/2BjjO/aut3wdSYbvmE/bmQayy
	37FdRgRAigoARZJ7xuAsS62jXaSBezF08C7lg1BzXU1pnlW+fzGqVV7XZP9FGI0d
	f96YrvtplKc1v0u1OlvS2v/KhHLcxwFHtPjJnxyfazy7maYDMxBI/d3N+nI3Stry
	wNCB+OBBLIj7tFmvXhAcBKCYJr0BkDiQ6wbG2G8oOIdZhJ6HpTZBMdrstTh2TItE
	B0Uzmany2dUSvAmv46dLWfhbheutJnnLy8eHpDtmOwoQQMBtlBMn+E1d+zs2/fsZ
	YhEfa7vW1kDPncNuov1rYsRB5onE7nr8TqUC/KBojw==
X-ME-Sender: <xms:np2tZ7VE47isYrzIy1xBw6QGGEG9Tq2IRZDOlaLOkf9JipiW7sRLGQ>
    <xme:np2tZzn7UH0l30jd-1MfXNMAK5wwzniH2Y38BmCXNMl3wOFbvLtNV_xVPGW-s-idh
    DpiobeQoMBEfjmAuIk>
X-ME-Received: <xmr:np2tZ3aFHBsnU7qT4IFT6IgDMoNny0sP62BJiPO8ih9oNsbReD0CPVe2MLuz7ue_a6e3ioOn98csoepz7X3_a1-ifz7tI2XjhZw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdegieduhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffkffhvfevufestddtjhdttddttdenucfhrhho
    mhephfhinhhnucfvhhgrihhnuceofhhthhgrihhnsehlihhnuhigqdhmieekkhdrohhrgh
    eqnecuggftrfgrthhtvghrnhepiedugfduhffgheekjeekffduueejudevffehiedtledt
    tdekveekuefhvdfftedunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehfthhhrghinheslhhi
    nhhugidqmheikehkrdhorhhgpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpoh
    huthdprhgtphhtthhopehulhhisehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihgr
    mhdrhhhofihlvghtthesohhrrggtlhgvrdgtohhmpdhrtghpthhtohepshgthhhmihhtii
    hmihgtsehgmhgrihhlrdgtohhmpdhrtghpthhtoheptghiphdquggvvheslhhishhtshdr
    tghiphdqphhrohhjvggtthdrohhrghdprhgtphhtthhopehlihhnuhigqdhmieekkheslh
    hishhtshdrlhhinhhugidqmheikehkrdhorhhg
X-ME-Proxy: <xmx:np2tZ2VDuMwqO1as86tX1RYcLSYdV9s3IkjTUrSOeK-WlQoWGS643A>
    <xmx:np2tZ1k0YaoaaF_oWg9h7zQHTdivaPeSTTMacQhMl1inKJM_omimgw>
    <xmx:np2tZzfcXdECzgE-XeZxZkWqk-RfBZHRfJmdJWlOsgD8awvOL9HHrA>
    <xmx:np2tZ_G-IaB2s41_gRrgNti2BExqHuWS_DmJRFo5bkS7FKnGZNUzxA>
    <xmx:n52tZ-DatzZz6JgrFXekduxMVD5a2kLeUJaZ1zBEeoC1Iugn9jz1HQuh>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Feb 2025 02:22:03 -0500 (EST)
Date: Thu, 13 Feb 2025 18:21:56 +1100
Message-ID: <9a7bb5ad805dbb1c8a67186f04500474@linux-m68k.org>
From: Finn Thain <fthain@linux-m68k.org>
To: Ulrich Hecht <uli@kernel.org>
Cc: Liam Howlett <liam.howlett@oracle.com>, Michael Schmitz <schmitzmic@gmail.com>, cip-dev@lists.cip-project.org, linux-m68k@lists.linux-m68k.org
Subject: [PATCH 4.4.y-cip] m68k: Add missing mmap_read_lock() to sys_cacheflush()
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 13 Feb 2025 08:14:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17822

From: Liam Howlett <liam.howlett@oracle.com>

[ Upstream commit f829b4b212a315b912cb23fd10aaf30534bb5ce9 ]

When the superuser flushes the entire cache, the mmap_read_lock() is not
taken, but mmap_read_unlock() is called.  Add the missing
mmap_read_lock() call.

Fixes: cd2567b6850b1648 ("m68k: call find_vma with the mmap_sem held in sys_cacheflush()")
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Link: https://lore.kernel.org/r/20210407200032.764445-1-Liam.Howlett@Oracle.com
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
[ mmap_read_lock() open-coded using down_read() as was done prior to v5.8 ]
Signed-off-by: Finn Thain <fthain@linux-m68k.org>
---
 arch/m68k/kernel/sys_m68k.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/m68k/kernel/sys_m68k.c b/arch/m68k/kernel/sys_m68k.c
index 6363ec83a290..38dcc1a2097d 100644
--- a/arch/m68k/kernel/sys_m68k.c
+++ b/arch/m68k/kernel/sys_m68k.c
@@ -388,6 +388,8 @@ sys_cacheflush (unsigned long addr, int scope, int cache, unsigned long len)
 		ret = -EPERM;
 		if (!capable(CAP_SYS_ADMIN))
 			goto out;
+
+		down_read(&current->mm->mmap_sem);
 	} else {
 		struct vm_area_struct *vma;
 

