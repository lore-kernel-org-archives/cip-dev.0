Return-Path: <Amy_Fong@mentor.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B409BC433F5
	for <webhook@archiver.kernel.org>; Mon, 10 Jan 2022 14:12:15 +0000 (UTC)
Received: from esa3.mentor.iphmx.com (esa3.mentor.iphmx.com [68.232.137.180])
 by mx.groups.io with SMTP id smtpd.web09.32126.1641823934544113482
 for <cip-dev@lists.cip-project.org>;
 Mon, 10 Jan 2022 06:12:14 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: mentor.com, ip: 68.232.137.180, mailfrom: amy_fong@mentor.com)
IronPort-SDR: 
 NmDXk8xl+xnSCPVWTr7CmxBSY6LBEikqzilh5unvmgwVdl9585rjFFbv5M8Sr1jgTBkzp3BYnw
 z1LJHmO6WkVL5+KVQTOf3+meVCxGB6UYxkrH8OnJgkvBDpfuCz5Px29nJJPmS5U7S12ag7c4Oq
 15haHc62kCWe0b5270r7s1SAadOxP7vu2LCB9d/0WOKLIZ/+toPt8JrhFKYlRjugabWxODj4mu
 3sjJk89VRTurf7cLYoy3KfPHnW7olK7VQCATCb6Jip8Z8niXOQPc/5OdcCXSKip2Tq/Ekv9yOd
 GtEUDkbL4wKDDVkUSntoOxcW
X-IronPort-AV: E=Sophos;i="5.88,277,1635235200";
   d="scan'208,223";a="70435092"
Received: from orw-gwy-02-in.mentorg.com ([192.94.38.167])
  by esa3.mentor.iphmx.com with ESMTP; 10 Jan 2022 06:12:14 -0800
IronPort-SDR: 
 CWlXQc8zarJ5cHBr9B9DWm3vDFEN20VAGqb7OqtdWcMYT7ClSXgvlkfqhTyjFdTjyR9CqTmzPT
 emYvq5GGnxDmH3tEIW2PhGSL0ji6oyfvn8gb8h40Ik/eVVDx0vzNh7375xexqCH/22Z2/Z9p4u
 potKPXpUwwdDH1vY+yHh8hxBOLEwtAN7OhEJnXK/r0X+9XlxcNQJVZF6N0LTQwM3pwFJsSF/mS
 TZK948jfPGfLk2/5XRpsjWUuKnrXrwdAeyKflpuvfLkrmPwA7UphRHaet8NdXrT+dpazFd08gr
 Vj0=
Date: Mon, 10 Jan 2022 09:12:08 -0500
From: Amy Fong <Amy_Fong@mentor.com>
To: <cip-dev@lists.cip-project.org>
CC: <nobuhiro1.iwamatsu@toshiba.co.jp>, <pavel@denx.de>
Subject: Re: [cip-dev] [PATCH 4.19.y-cip 2/6] Backport netfilter: nf_tables:
 autoload modules from the abort path
Message-ID: <Ydw+uPNGD/6ms6qi@cat>
References: <16C8EE09FDEB733D.27414@lists.cip-project.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <16C8EE09FDEB733D.27414@lists.cip-project.org>
X-ClientProxiedBy: SVR-ORW-MBX-09.mgc.mentorg.com (147.34.90.209) To
 svr-orw-mbx-04.mgc.mentorg.com (147.34.90.204)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 10 Jan 2022 14:12:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7429

From 185a61df95c18e5111df5ba439b0e60a8a6e40cb Mon Sep 17 00:00:00 2001
From: Pablo Neira Ayuso <pablo@netfilter.org>
Date: Fri, 5 Jul 2019 23:38:46 +0200
Subject: [PATCH 2/5] netfilter: nf_tables: add nft_expr_type_request_module()

This helper function makes sure the family specific extension is loaded.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
(cherry picked from commit b9c04ae7907f09c5e873e7c9a8feea2ce41e15b3)
---
 net/netfilter/nf_tables_api.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 02e577e8fb8a..8ec38de1f7a1 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -2009,6 +2009,19 @@ static const struct nft_expr_type *__nft_expr_type_get(u8 family,
 	return NULL;
 }
 
+#ifdef CONFIG_MODULES
+static int nft_expr_type_request_module(struct net *net, u8 family,
+					struct nlattr *nla)
+{
+	nft_request_module(net, "nft-expr-%u-%.*s", family,
+			   nla_len(nla), (char *)nla_data(nla));
+	if (__nft_expr_type_get(family, nla))
+		return -EAGAIN;
+
+	return 0;
+}
+#endif
+
 static const struct nft_expr_type *nft_expr_type_get(struct net *net,
 						     u8 family,
 						     struct nlattr *nla)
@@ -2025,9 +2038,7 @@ static const struct nft_expr_type *nft_expr_type_get(struct net *net,
 	lockdep_nfnl_nft_mutex_not_held();
 #ifdef CONFIG_MODULES
 	if (type == NULL) {
-		nft_request_module(net, "nft-expr-%u-%.*s", family,
-				   nla_len(nla), (char *)nla_data(nla));
-		if (__nft_expr_type_get(family, nla))
+		if (nft_expr_type_request_module(net, family, nla) == -EAGAIN)
 			return ERR_PTR(-EAGAIN);
 
 		nft_request_module(net, "nft-expr-%.*s",
-- 
2.34.1


