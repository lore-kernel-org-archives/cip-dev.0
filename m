Return-Path: <Amy_Fong@mentor.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEA86C433F5
	for <webhook@archiver.kernel.org>; Mon, 10 Jan 2022 14:13:40 +0000 (UTC)
Received: from esa3.mentor.iphmx.com (esa3.mentor.iphmx.com [68.232.137.180])
 by mx.groups.io with SMTP id smtpd.web09.32146.1641824019576647439
 for <cip-dev@lists.cip-project.org>;
 Mon, 10 Jan 2022 06:13:39 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: mentor.com, ip: 68.232.137.180, mailfrom: amy_fong@mentor.com)
IronPort-SDR: 
 36UaYAsKLq2xTmOSTWn9J2GefEq/KTkms4Lw7J4zY/ig9w13H+nlB5Ejqmu6ihRSTmyHgemk39
 SRd+nLOGNmKYNRVP3SxrRpWTmTMwyXHYQxLfOcfFqi8qOaw9dPVCEQg6efLkM/5cwkPAQZdbe0
 uP3H7o9eQIPUbE5GLt9YB3jL92yu7ilbmBhWtMXqk3zI4EdQ/5qq0ACpeDdadsXHbeqCoRzf9y
 5vxZsYL2gJ2Fi13IsaknsXZ4sfg7ttifD7sy/jg757/m7ybz5iSqmpIKJGf6Sod+Qwse0zKunz
 wX+zRBZpLP1NLAbPsAAmr3YM
X-IronPort-AV: E=Sophos;i="5.88,277,1635235200";
   d="scan'208,223";a="70435156"
Received: from orw-gwy-02-in.mentorg.com ([192.94.38.167])
  by esa3.mentor.iphmx.com with ESMTP; 10 Jan 2022 06:13:39 -0800
IronPort-SDR: 
 p+QmfFtQerbc7QLLYmPTH0qV9hKnB4QuCyTIZr3mqPtmrOlkt6RrBFnDcERAN3iqXgMd1aZK1L
 n+7xDMrBCs4zriCLE2oCVMshx2bRGn0Y14D1ftSBlCeQUIDdJIdhirRPWFMK9fMzFnRrTfhOb6
 vGdfwg2FCf4c5SwofvfS4eLOqGnRgtBIjGhWWN/B+4cDyFzfOfQ1m3XyhwBQouVkIjJoQjbqVR
 2VWaBb0F6MDwOqFaGreMsPjolI8uf6866HyTIOjWc0J/UKLvTyXNxRvupjGat7inP0UfiEuWYx
 sZQ=
Date: Mon, 10 Jan 2022 09:13:30 -0500
From: Amy Fong <Amy_Fong@mentor.com>
To: <cip-dev@lists.cip-project.org>
CC: <nobuhiro1.iwamatsu@toshiba.co.jp>, <pavel@denx.de>
Subject: Re: [cip-dev] [PATCH 4.19.y-cip 4/6] Backport netfilter: nf_tables:
 autoload modules from the abort path
Message-ID: <Ydw/CgF+a4djv3j8@cat>
References: <16C8EE09FDEB733D.27414@lists.cip-project.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <16C8EE09FDEB733D.27414@lists.cip-project.org>
X-ClientProxiedBy: SVR-ORW-MBX-07.mgc.mentorg.com (147.34.90.207) To
 svr-orw-mbx-04.mgc.mentorg.com (147.34.90.204)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 10 Jan 2022 14:13:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7431

From 791580bd2a8b75daddc0d110582198ab0ac854b2 Mon Sep 17 00:00:00 2001
From: Florian Westphal <fw@strlen.de>
Date: Thu, 5 Mar 2020 11:15:36 +0100
Subject: [PATCH 4/5] netfilter: nf_tables: fix infinite loop when expr is not
 available

nft will loop forever if the kernel doesn't support an expression:

1. nft_expr_type_get() appends the family specific name to the module list.
2. -EAGAIN is returned to nfnetlink, nfnetlink calls abort path.
3. abort path sets ->done to true and calls request_module for the
   expression.
4. nfnetlink replays the batch, we end up in nft_expr_type_get() again.
5. nft_expr_type_get attempts to append family-specific name. This
   one already exists on the list, so we continue
6. nft_expr_type_get adds the generic expression name to the module
   list. -EAGAIN is returned, nfnetlink calls abort path.
7. abort path encounters the family-specific expression which
   has 'done' set, so it gets removed.
8. abort path requests the generic expression name, sets done to true.
9. batch is replayed.

If the expression could not be loaded, then we will end up back at 1),
because the family-specific name got removed and the cycle starts again.

Note that userspace can SIGKILL the nft process to stop the cycle, but
the desired behaviour is to return an error after the generic expr name
fails to load the expression.

Fixes: eb014de4fd418 ("netfilter: nf_tables: autoload modules from the abort path")
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
(cherry picked from commit 1d305ba40eb8081ff21eeb8ca6ba5c70fd920934)
---
 net/netfilter/nf_tables_api.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 6329d23c8b35..54bf2ac44531 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -6698,13 +6698,8 @@ static void nf_tables_module_autoload(struct net *net)
 	list_splice_init(&net->nft.module_list, &module_list);
 	mutex_unlock(&net->nft.commit_mutex);
 	list_for_each_entry_safe(req, next, &module_list, list) {
-		if (req->done) {
-			list_del(&req->list);
-			kfree(req);
-		} else {
-			request_module("%s", req->module);
-			req->done = true;
-		}
+		request_module("%s", req->module);
+		req->done = true;
 	}
 	mutex_lock(&net->nft.commit_mutex);
 	list_splice(&module_list, &net->nft.module_list);
@@ -7481,6 +7476,7 @@ static void __net_exit nf_tables_exit_net(struct net *net)
 	__nft_release_tables(net);
 	mutex_unlock(&net->nft.commit_mutex);
 	WARN_ON_ONCE(!list_empty(&net->nft.tables));
+	WARN_ON_ONCE(!list_empty(&net->nft.module_list));
 }
 
 static struct pernet_operations nf_tables_net_ops = {
-- 
2.34.1


