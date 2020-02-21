Return-Path: <SRS0=SQxA=4J=lists.cip-project.org=cip-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2AC7C35646
	for <cip-dev@archiver.kernel.org>; Fri, 21 Feb 2020 16:52:25 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFB7D24650
	for <cip-dev@archiver.kernel.org>; Fri, 21 Feb 2020 16:52:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFB7D24650
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cip-dev-bounces@lists.cip-project.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id A0D3C87F38;
	Fri, 21 Feb 2020 16:52:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7XxTjsbHTZKg; Fri, 21 Feb 2020 16:52:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id DB0A2879A6;
	Fri, 21 Feb 2020 16:52:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C676FC1D88;
	Fri, 21 Feb 2020 16:52:23 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9E8B1C013E
 for <cip-dev@lists.cip-project.org>; Fri, 21 Feb 2020 16:52:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 9BBF784BCF
 for <cip-dev@lists.cip-project.org>; Fri, 21 Feb 2020 16:52:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rEDVAAXbTT0u for <cip-dev@lists.cip-project.org>;
 Fri, 21 Feb 2020 16:52:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com
 [210.160.252.172])
 by whitealder.osuosl.org (Postfix) with ESMTP id C187D875DC
 for <cip-dev@lists.cip-project.org>; Fri, 21 Feb 2020 16:52:20 +0000 (UTC)
X-IronPort-AV: E=Sophos;i="5.70,468,1574089200"; d="scan'208";a="39726128"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
 by relmlie6.idc.renesas.com with ESMTP; 22 Feb 2020 01:52:20 +0900
Received: from marian-VirtualBox.ree.adwin.renesas.com (unknown
 [10.226.36.164])
 by relmlir6.idc.renesas.com (Postfix) with ESMTP id A95D740A3602;
 Sat, 22 Feb 2020 01:52:19 +0900 (JST)
From: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
To: cip-dev@lists.cip-project.org
Date: Fri, 21 Feb 2020 16:51:55 +0000
Message-Id: <1582303929-5773-9-git-send-email-marian-cristian.rotariu.rb@bp.renesas.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1582303929-5773-1-git-send-email-marian-cristian.rotariu.rb@bp.renesas.com>
References: <1582303929-5773-1-git-send-email-marian-cristian.rotariu.rb@bp.renesas.com>
Subject: [cip-dev] [PATCH v2 4.19.y-cip 08/22] device property: Introduce
	fwnode_find_reference()
X-BeenThere: cip-dev@lists.cip-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: <cip-dev.lists.cip-project.org>
List-Unsubscribe: <https://lists.cip-project.org/mailman/options/cip-dev>,
 <mailto:cip-dev-request@lists.cip-project.org?subject=unsubscribe>
List-Archive: <http://lists.cip-project.org/pipermail/cip-dev/>
List-Post: <mailto:cip-dev@lists.cip-project.org>
List-Help: <mailto:cip-dev-request@lists.cip-project.org?subject=help>
List-Subscribe: <https://lists.cip-project.org/mailman/listinfo/cip-dev>,
 <mailto:cip-dev-request@lists.cip-project.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: cip-dev-bounces@lists.cip-project.org
Sender: "cip-dev" <cip-dev-bounces@lists.cip-project.org>

From: Heikki Krogerus <heikki.krogerus@linux.intel.com>

commit 83b34afb6b79c69f5478a7249451cab858af97d6 upstream.

In most cases the references that the drivers look for don't
have any arguments. This introduces a wrapper function for
fwnode_property_get_reference_args() that looks for
references by using only the name and index.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Tested-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
---
 drivers/base/property.c  | 24 ++++++++++++++++++++++++
 include/linux/property.h |  4 ++++
 2 files changed, 28 insertions(+)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index 240ab52..52be8c8 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -946,6 +946,30 @@ static struct property_set *pset_copy_set(const struct property_set *pset)
 }
 
 /**
+ * fwnode_find_reference - Find named reference to a fwnode_handle
+ * @fwnode: Firmware node where to look for the reference
+ * @name: The name of the reference
+ * @index: Index of the reference
+ *
+ * @index can be used when the named reference holds a table of references.
+ *
+ * Returns pointer to the reference fwnode, or ERR_PTR. Caller is responsible to
+ * call fwnode_handle_put() on the returned fwnode pointer.
+ */
+struct fwnode_handle *fwnode_find_reference(const struct fwnode_handle *fwnode,
+					    const char *name,
+					    unsigned int index)
+{
+	struct fwnode_reference_args args;
+	int ret;
+
+	ret = fwnode_property_get_reference_args(fwnode, name, NULL, 0, index,
+						 &args);
+	return ret ? ERR_PTR(ret) : args.fwnode;
+}
+EXPORT_SYMBOL_GPL(fwnode_find_reference);
+
+/**
  * device_remove_properties - Remove properties from a device object.
  * @dev: Device whose properties to remove.
  *
diff --git a/include/linux/property.h b/include/linux/property.h
index 1a12364..216dcfe 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -78,6 +78,10 @@ int fwnode_property_get_reference_args(const struct fwnode_handle *fwnode,
 				       unsigned int nargs, unsigned int index,
 				       struct fwnode_reference_args *args);
 
+struct fwnode_handle *fwnode_find_reference(const struct fwnode_handle *fwnode,
+					    const char *name,
+					    unsigned int index);
+
 struct fwnode_handle *fwnode_get_parent(const struct fwnode_handle *fwnode);
 struct fwnode_handle *fwnode_get_next_parent(
 	struct fwnode_handle *fwnode);
-- 
2.7.4

_______________________________________________
cip-dev mailing list
cip-dev@lists.cip-project.org
https://lists.cip-project.org/mailman/listinfo/cip-dev
