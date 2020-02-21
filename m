Return-Path: <SRS0=SQxA=4J=lists.cip-project.org=cip-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5949C35658
	for <cip-dev@archiver.kernel.org>; Fri, 21 Feb 2020 16:52:25 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4B1624656
	for <cip-dev@archiver.kernel.org>; Fri, 21 Feb 2020 16:52:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4B1624656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cip-dev-bounces@lists.cip-project.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id A26A8875E2;
	Fri, 21 Feb 2020 16:52:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9mLdnSpJk38h; Fri, 21 Feb 2020 16:52:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id AA0D48761C;
	Fri, 21 Feb 2020 16:52:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A6AE8C013E;
	Fri, 21 Feb 2020 16:52:23 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 29BCAC013E
 for <cip-dev@lists.cip-project.org>; Fri, 21 Feb 2020 16:52:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 12133875E2
 for <cip-dev@lists.cip-project.org>; Fri, 21 Feb 2020 16:52:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9N4P44oq93gP for <cip-dev@lists.cip-project.org>;
 Fri, 21 Feb 2020 16:52:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com
 [210.160.252.172])
 by whitealder.osuosl.org (Postfix) with ESMTP id 5802F84BCF
 for <cip-dev@lists.cip-project.org>; Fri, 21 Feb 2020 16:52:18 +0000 (UTC)
X-IronPort-AV: E=Sophos;i="5.70,468,1574089200"; d="scan'208";a="39726121"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
 by relmlie6.idc.renesas.com with ESMTP; 22 Feb 2020 01:52:18 +0900
Received: from marian-VirtualBox.ree.adwin.renesas.com (unknown
 [10.226.36.164])
 by relmlir6.idc.renesas.com (Postfix) with ESMTP id 3E80C40A3602;
 Sat, 22 Feb 2020 01:52:17 +0900 (JST)
From: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
To: cip-dev@lists.cip-project.org
Date: Fri, 21 Feb 2020 16:51:53 +0000
Message-Id: <1582303929-5773-7-git-send-email-marian-cristian.rotariu.rb@bp.renesas.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1582303929-5773-1-git-send-email-marian-cristian.rotariu.rb@bp.renesas.com>
References: <1582303929-5773-1-git-send-email-marian-cristian.rotariu.rb@bp.renesas.com>
Subject: [cip-dev] [PATCH v2 4.19.y-cip 06/22] device connection: Prepare
	support for firmware described connections
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

commit 80e04837a40f6f1c8e93437be3f772c967a41d2f upstream.

When the connections are defined in firmware, struct
device_connection will have the fwnode member pointing to
the device node (struct fwnode_handle) of the requested
device. The endpoint member for the device names will not be
used at all in that case.

Acked-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Reviewed-by: Jun Li <jun.li@nxp.com>
Tested-by: Jun Li <jun.li@nxp.com>
Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
---
 drivers/base/devcon.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/base/devcon.c b/drivers/base/devcon.c
index d427e80..858b8d2 100644
--- a/drivers/base/devcon.c
+++ b/drivers/base/devcon.c
@@ -75,12 +75,36 @@ static struct bus_type *generic_match_buses[] = {
 	NULL,
 };
 
+static int device_fwnode_match(struct device *dev, void *fwnode)
+{
+	return dev_fwnode(dev) == fwnode;
+}
+
+static void *device_connection_fwnode_match(struct device_connection *con)
+{
+	struct bus_type *bus;
+	struct device *dev;
+
+	for (bus = generic_match_buses[0]; bus; bus++) {
+		dev = bus_find_device(bus, NULL, (void *)con->fwnode,
+				      device_fwnode_match);
+		if (dev && !strncmp(dev_name(dev), con->id, strlen(con->id)))
+			return dev;
+
+		put_device(dev);
+	}
+	return NULL;
+}
+
 /* This tries to find the device from the most common bus types by name. */
 static void *generic_match(struct device_connection *con, int ep, void *data)
 {
 	struct bus_type *bus;
 	struct device *dev;
 
+	if (con->fwnode)
+		return device_connection_fwnode_match(con);
+
 	for (bus = generic_match_buses[0]; bus; bus++) {
 		dev = bus_find_device_by_name(bus, NULL, con->endpoint[ep]);
 		if (dev)
-- 
2.7.4

_______________________________________________
cip-dev mailing list
cip-dev@lists.cip-project.org
https://lists.cip-project.org/mailman/listinfo/cip-dev
