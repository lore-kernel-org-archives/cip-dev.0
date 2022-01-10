Return-Path: <Amy_Fong@mentor.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B39FDC433FE
	for <webhook@archiver.kernel.org>; Mon, 10 Jan 2022 14:14:10 +0000 (UTC)
Received: from esa1.mentor.iphmx.com (esa1.mentor.iphmx.com [68.232.129.153])
 by mx.groups.io with SMTP id smtpd.web12.31905.1641824050256105828
 for <cip-dev@lists.cip-project.org>;
 Mon, 10 Jan 2022 06:14:10 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: mentor.com, ip: 68.232.129.153, mailfrom: amy_fong@mentor.com)
IronPort-SDR: 
 SGc1EgZzX+u87dXvkbJ5XfLzWd8vAne8ePo0XsSTmnb8r1/OPfzHqDbH/Upj3if1YHArkS52u5
 sOcGzm6LeVAq8cXm99AJrIWWSfNzpUFbTsBgkNY0Ca4f1F8ikC9gmdrtO4javksuWxYNRBI43j
 eYluAbooSOk47cr8wQPJZwye62wMj8ZPVQNnsSIQrO/cf6l9kt5EfgAtujReJe6nJyXb1VmVSi
 tmFx6rOXmEwOH/Si/CO6sXM4CTVF4DT9IveLf+g78/YrnhQ/XTGm14+VsZfjitdwcg8WhbMU8w
 NYqDjtBr31+8WeEHfoWRky5G
X-IronPort-AV: E=Sophos;i="5.88,277,1635235200";
   d="scan'208,223";a="73111062"
Received: from orw-gwy-02-in.mentorg.com ([192.94.38.167])
  by esa1.mentor.iphmx.com with ESMTP; 10 Jan 2022 06:14:10 -0800
IronPort-SDR: 
 ixFGomiJ1G3F1ANOkrsdl2nPLTA5hYDveB31o+FZKtR3j7kMVFirTmj3i4v2cD8tXBBWIoP1s8
 UEnLhhDDVxejkZ4/CkjPuZT6/MXJfTNgh4DddwQlUYmJ37yvUQ6hSaDaB5mbwiu4aMmiaZoQe5
 vhE/ATprD9g6CgDnhIdQYdltpeStdKgb+UdcJf0Cq1quQe2q3IZtpmfqzcA9eMZ/xoNYRoQKYW
 7fmqC8txg4bDBzYwi8pK5MftfaNX0ySFTJhpGrJUr/e19HdbauiVLyO9V9aFWYCfnxAWxpX96d
 JF0=
Date: Mon, 10 Jan 2022 09:14:04 -0500
From: Amy Fong <Amy_Fong@mentor.com>
To: <cip-dev@lists.cip-project.org>
CC: <nobuhiro1.iwamatsu@toshiba.co.jp>, <pavel@denx.de>
Subject: Re: [cip-dev] [PATCH 4.19.y-cip 5/6] Backport netfilter: nf_tables:
 autoload modules from the abort path
Message-ID: <Ydw/LKRB+CVs/O4g@cat>
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
 <cip-dev@lists.cip-project.org>; Mon, 10 Jan 2022 14:14:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7432

From e6cec303e31d347aa44beb37876fa6763cc0430c Mon Sep 17 00:00:00 2001
From: Pablo Neira Ayuso <pablo@netfilter.org>
Date: Thu, 29 Oct 2020 13:50:03 +0100
Subject: [PATCH 5/5] netfilter: nf_tables: missing validation from the abort
 path

If userspace does not include the trailing end of batch message, then
nfnetlink aborts the transaction. This allows to check that ruleset
updates trigger no errors.

After this patch, invoking this command from the prerouting chain:

 # nft -c add rule x y fib saddr . oif type local

fails since oif is not supported there.

This patch fixes the lack of rule validation from the abort/check path
to catch configuration errors such as the one above.

Fixes: a654de8fdc18 ("netfilter: nf_tables: fix chain dependency validation")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
(cherry picked from commit c0391b6ab810381df632677a1dcbbbbd63d05b6d)
---
 include/linux/netfilter/nfnetlink.h |  9 ++++++++-
 net/netfilter/nf_tables_api.c       | 15 ++++++++++-----
 net/netfilter/nfnetlink.c           | 22 ++++++++++++++++++----
 3 files changed, 36 insertions(+), 10 deletions(-)

diff --git a/include/linux/netfilter/nfnetlink.h b/include/linux/netfilter/nfnetlink.h
index 89016d08f6a2..f6267e2883f2 100644
--- a/include/linux/netfilter/nfnetlink.h
+++ b/include/linux/netfilter/nfnetlink.h
@@ -24,6 +24,12 @@ struct nfnl_callback {
 	const u_int16_t attr_count;		/* number of nlattr's */
 };
 
+enum nfnl_abort_action {
+	NFNL_ABORT_NONE		= 0,
+	NFNL_ABORT_AUTOLOAD,
+	NFNL_ABORT_VALIDATE,
+};
+
 struct nfnetlink_subsystem {
 	const char *name;
 	__u8 subsys_id;			/* nfnetlink subsystem ID */
@@ -31,7 +37,8 @@ struct nfnetlink_subsystem {
 	const struct nfnl_callback *cb;	/* callback for individual types */
 	struct module *owner;
 	int (*commit)(struct net *net, struct sk_buff *skb);
-	int (*abort)(struct net *net, struct sk_buff *skb, bool autoload);
+	int (*abort)(struct net *net, struct sk_buff *skb,
+		     enum nfnl_abort_action action);
 	void (*cleanup)(struct net *net);
 	bool (*valid_genid)(struct net *net, u32 genid);
 };
diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 54bf2ac44531..e15e574f035d 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -6734,11 +6734,15 @@ static void nf_tables_abort_release(struct nft_trans *trans)
 	kfree(trans);
 }
 
-static int __nf_tables_abort(struct net *net, bool autoload)
+static int __nf_tables_abort(struct net *net, enum nfnl_abort_action action)
 {
 	struct nft_trans *trans, *next;
 	struct nft_trans_elem *te;
 
+	if (action == NFNL_ABORT_VALIDATE &&
+	    nf_tables_validate(net) < 0)
+		return -EAGAIN;
+
 	list_for_each_entry_safe_reverse(trans, next, &net->nft.commit_list,
 					 list) {
 		switch (trans->msg_type) {
@@ -6851,7 +6855,7 @@ static int __nf_tables_abort(struct net *net, bool autoload)
 		nf_tables_abort_release(trans);
 	}
 
-	if (autoload)
+	if (action == NFNL_ABORT_AUTOLOAD)
 		nf_tables_module_autoload(net);
 	else
 		nf_tables_module_autoload_cleanup(net);
@@ -6864,9 +6868,10 @@ static void nf_tables_cleanup(struct net *net)
 	nft_validate_state_update(net, NFT_VALIDATE_SKIP);
 }
 
-static int nf_tables_abort(struct net *net, struct sk_buff *skb, bool autoload)
+static int nf_tables_abort(struct net *net, struct sk_buff *skb,
+			   enum nfnl_abort_action action)
 {
-	int ret = __nf_tables_abort(net, autoload);
+	int ret = __nf_tables_abort(net, action);
 
 	mutex_unlock(&net->nft.commit_mutex);
 
@@ -7472,7 +7477,7 @@ static void __net_exit nf_tables_exit_net(struct net *net)
 {
 	mutex_lock(&net->nft.commit_mutex);
 	if (!list_empty(&net->nft.commit_list))
-		__nf_tables_abort(net, false);
+		__nf_tables_abort(net, NFNL_ABORT_NONE);
 	__nft_release_tables(net);
 	mutex_unlock(&net->nft.commit_mutex);
 	WARN_ON_ONCE(!list_empty(&net->nft.tables));
diff --git a/net/netfilter/nfnetlink.c b/net/netfilter/nfnetlink.c
index 7454f135e19d..4f5dcdf1a39e 100644
--- a/net/netfilter/nfnetlink.c
+++ b/net/netfilter/nfnetlink.c
@@ -314,7 +314,7 @@ static void nfnetlink_rcv_batch(struct sk_buff *skb, struct nlmsghdr *nlh,
 		return netlink_ack(skb, nlh, -EINVAL, NULL);
 replay:
 	status = 0;
-
+replay_abort:
 	skb = netlink_skb_clone(oskb, GFP_KERNEL);
 	if (!skb)
 		return netlink_ack(oskb, nlh, -ENOMEM, NULL);
@@ -478,7 +478,7 @@ static void nfnetlink_rcv_batch(struct sk_buff *skb, struct nlmsghdr *nlh,
 	}
 done:
 	if (status & NFNL_BATCH_REPLAY) {
-		ss->abort(net, oskb, true);
+		ss->abort(net, oskb, NFNL_ABORT_AUTOLOAD);
 		nfnl_err_reset(&err_list);
 		kfree_skb(skb);
 		module_put(ss->owner);
@@ -489,11 +489,25 @@ static void nfnetlink_rcv_batch(struct sk_buff *skb, struct nlmsghdr *nlh,
 			status |= NFNL_BATCH_REPLAY;
 			goto done;
 		} else if (err) {
-			ss->abort(net, oskb, false);
+			ss->abort(net, oskb, NFNL_ABORT_NONE);
 			netlink_ack(oskb, nlmsg_hdr(oskb), err, NULL);
 		}
 	} else {
-		ss->abort(net, oskb, false);
+		enum nfnl_abort_action abort_action;
+
+		if (status & NFNL_BATCH_FAILURE)
+			abort_action = NFNL_ABORT_NONE;
+		else
+			abort_action = NFNL_ABORT_VALIDATE;
+
+		err = ss->abort(net, oskb, abort_action);
+		if (err == -EAGAIN) {
+			nfnl_err_reset(&err_list);
+			kfree_skb(skb);
+			module_put(ss->owner);
+			status |= NFNL_BATCH_FAILURE;
+			goto replay_abort;
+		}
 	}
 	if (ss->cleanup)
 		ss->cleanup(net);
-- 
2.34.1


