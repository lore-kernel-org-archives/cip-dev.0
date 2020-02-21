Return-Path: <SRS0=SQxA=4J=lists.cip-project.org=cip-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78DEDC35659
	for <cip-dev@archiver.kernel.org>; Fri, 21 Feb 2020 16:52:26 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5881D24650
	for <cip-dev@archiver.kernel.org>; Fri, 21 Feb 2020 16:52:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5881D24650
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cip-dev-bounces@lists.cip-project.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 3EFA5875E2;
	Fri, 21 Feb 2020 16:52:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tQgRyZ3365Bd; Fri, 21 Feb 2020 16:52:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 2E5EB84BCF;
	Fri, 21 Feb 2020 16:52:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 163D1C013E;
	Fri, 21 Feb 2020 16:52:24 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4D192C013E
 for <cip-dev@lists.cip-project.org>; Fri, 21 Feb 2020 16:52:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 3C6CB8761D
 for <cip-dev@lists.cip-project.org>; Fri, 21 Feb 2020 16:52:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IDI-l5SLers1 for <cip-dev@lists.cip-project.org>;
 Fri, 21 Feb 2020 16:52:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com
 [210.160.252.172])
 by whitealder.osuosl.org (Postfix) with ESMTP id 8CD21875CD
 for <cip-dev@lists.cip-project.org>; Fri, 21 Feb 2020 16:52:19 +0000 (UTC)
X-IronPort-AV: E=Sophos;i="5.70,468,1574089200"; d="scan'208";a="39726125"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
 by relmlie6.idc.renesas.com with ESMTP; 22 Feb 2020 01:52:19 +0900
Received: from marian-VirtualBox.ree.adwin.renesas.com (unknown
 [10.226.36.164])
 by relmlir6.idc.renesas.com (Postfix) with ESMTP id 73FB940A3605;
 Sat, 22 Feb 2020 01:52:18 +0900 (JST)
From: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
To: cip-dev@lists.cip-project.org
Date: Fri, 21 Feb 2020 16:51:54 +0000
Message-Id: <1582303929-5773-8-git-send-email-marian-cristian.rotariu.rb@bp.renesas.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1582303929-5773-1-git-send-email-marian-cristian.rotariu.rb@bp.renesas.com>
References: <1582303929-5773-1-git-send-email-marian-cristian.rotariu.rb@bp.renesas.com>
Subject: [cip-dev] [PATCH v2 4.19.y-cip 07/22] device connection: Find
	device connections also from device graphs
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

commit 637e9e52b185e5b10372366bd6db97f27cf3f202 upstream.

If connections between devices are described in OF graph or
ACPI device graph, we can find them by using the
fwnode_graph_*() functions.

Acked-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Reviewed-by: Jun Li <jun.li@nxp.com>
Tested-by: Jun Li <jun.li@nxp.com>
Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
---
 drivers/base/devcon.c | 38 +++++++++++++++++++++++++++++++++++---
 1 file changed, 35 insertions(+), 3 deletions(-)

diff --git a/drivers/base/devcon.c b/drivers/base/devcon.c
index 858b8d2..04db9ae 100644
--- a/drivers/base/devcon.c
+++ b/drivers/base/devcon.c
@@ -7,10 +7,37 @@
  */
 
 #include <linux/device.h>
+#include <linux/property.h>
 
 static DEFINE_MUTEX(devcon_lock);
 static LIST_HEAD(devcon_list);
 
+typedef void *(*devcon_match_fn_t)(struct device_connection *con, int ep,
+				   void *data);
+
+static void *
+fwnode_graph_devcon_match(struct fwnode_handle *fwnode, const char *con_id,
+			  void *data, devcon_match_fn_t match)
+{
+	struct device_connection con = { .id = con_id };
+	struct fwnode_handle *ep;
+	void *ret;
+
+	fwnode_graph_for_each_endpoint(fwnode, ep) {
+		con.fwnode = fwnode_graph_get_remote_port_parent(ep);
+		if (!fwnode_device_is_available(con.fwnode))
+			continue;
+
+		ret = match(&con, -1, data);
+		fwnode_handle_put(con.fwnode);
+		if (ret) {
+			fwnode_handle_put(ep);
+			return ret;
+		}
+	}
+	return NULL;
+}
+
 /**
  * device_connection_find_match - Find physical connection to a device
  * @dev: Device with the connection
@@ -23,10 +50,9 @@ static LIST_HEAD(devcon_list);
  * caller is expecting to be returned.
  */
 void *device_connection_find_match(struct device *dev, const char *con_id,
-			       void *data,
-			       void *(*match)(struct device_connection *con,
-					      int ep, void *data))
+				   void *data, devcon_match_fn_t match)
 {
+	struct fwnode_handle *fwnode = dev_fwnode(dev);
 	const char *devname = dev_name(dev);
 	struct device_connection *con;
 	void *ret = NULL;
@@ -35,6 +61,12 @@ void *device_connection_find_match(struct device *dev, const char *con_id,
 	if (!match)
 		return NULL;
 
+	if (fwnode) {
+		ret = fwnode_graph_devcon_match(fwnode, con_id, data, match);
+		if (ret)
+			return ret;
+	}
+
 	mutex_lock(&devcon_lock);
 
 	list_for_each_entry(con, &devcon_list, list) {
-- 
2.7.4

_______________________________________________
cip-dev mailing list
cip-dev@lists.cip-project.org
https://lists.cip-project.org/mailman/listinfo/cip-dev
