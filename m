Return-Path: <SRS0=HhK2=D5=lists.cip-project.org=bounce+64572+5643+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5D06C5517A
	for <cip-dev@archiver.kernel.org>; Thu, 22 Oct 2020 10:16:22 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7E8A24248
	for <cip-dev@archiver.kernel.org>; Thu, 22 Oct 2020 10:16:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="SFQSj/LS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7E8A24248
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5643+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 7KBWYY4521723x18it65f8FG; Thu, 22 Oct 2020 03:16:21 -0700
X-Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web12.8475.1603361778321978533
 for <cip-dev@lists.cip-project.org>;
 Thu, 22 Oct 2020 03:16:20 -0700
X-IronPort-AV: E=Sophos;i="5.77,404,1596466800"; 
   d="scan'208";a="60507853"
X-Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 22 Oct 2020 19:16:20 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 5FD5240062B1;
	Thu, 22 Oct 2020 19:16:19 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Pavel Machek <pavel@denx.de>,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.19.y-cip 03/13] PCI: endpoint: Protect concurrent access to pci_epf_ops with mutex
Date: Thu, 22 Oct 2020 11:16:04 +0100
Message-Id: <20201022101614.9298-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20201022101614.9298-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20201022101614.9298-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 1nDDqVSlAw8ypyQNRPhDieBkx4520388AA=
Content-Type: multipart/mixed; boundary="VQ2yjWQsQ6AxLetY4OhR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1603361781;
 bh=cgLBfk3LYS1vzkFknuHPF0aqZ2Z9bfSqajlpJr1LDhI=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=SFQSj/LSodyiArIModGLJb0/7eL9uidGUl881i6ze3iy7CHzJ7/6Mgq3FyaR3o4zgzo
 78AvZospI4ImMBHwUnZGyPUmfE0Koo/wkr8dvJmdQTmM1RpPFsUYwu4F9HBdlWyZwwgKz
 FfH0GILnttTHiPcr3d1X5w7Pb9PblIz2G6k=

--VQ2yjWQsQ6AxLetY4OhR

From: Kishon Vijay Abraham I <kishon@ti.com>

commit 07301c982643a432212840a4b648b5d3f5a061fa upstream.

Protect concurrent access to pci_epf_ops with a mutex.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/pci/endpoint/pci-epf-core.c | 11 ++++++++++-
 include/linux/pci-epf.h             |  3 +++
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
index 642f233efcaf..244e00f48c5c 100644
--- a/drivers/pci/endpoint/pci-epf-core.c
+++ b/drivers/pci/endpoint/pci-epf-core.c
@@ -35,7 +35,9 @@ void pci_epf_unbind(struct pci_epf *epf)
 		return;
 	}
 
+	mutex_lock(&epf->lock);
 	epf->driver->ops->unbind(epf);
+	mutex_unlock(&epf->lock);
 	module_put(epf->driver->owner);
 }
 EXPORT_SYMBOL_GPL(pci_epf_unbind);
@@ -49,6 +51,8 @@ EXPORT_SYMBOL_GPL(pci_epf_unbind);
  */
 int pci_epf_bind(struct pci_epf *epf)
 {
+	int ret;
+
 	if (!epf->driver) {
 		dev_WARN(&epf->dev, "epf device not bound to driver\n");
 		return -EINVAL;
@@ -57,7 +61,11 @@ int pci_epf_bind(struct pci_epf *epf)
 	if (!try_module_get(epf->driver->owner))
 		return -EAGAIN;
 
-	return epf->driver->ops->bind(epf);
+	mutex_lock(&epf->lock);
+	ret = epf->driver->ops->bind(epf);
+	mutex_unlock(&epf->lock);
+
+	return ret;
 }
 EXPORT_SYMBOL_GPL(pci_epf_bind);
 
@@ -254,6 +262,7 @@ struct pci_epf *pci_epf_create(const char *name)
 	device_initialize(dev);
 	dev->bus = &pci_epf_bus_type;
 	dev->type = &pci_epf_type;
+	mutex_init(&epf->lock);
 
 	ret = dev_set_name(dev, "%s", name);
 	if (ret) {
diff --git a/include/linux/pci-epf.h b/include/linux/pci-epf.h
index 75aa1003646b..efbc08a153ff 100644
--- a/include/linux/pci-epf.h
+++ b/include/linux/pci-epf.h
@@ -112,6 +112,7 @@ struct pci_epf_bar {
  * @driver: the EPF driver to which this EPF device is bound
  * @list: to add pci_epf as a list of PCI endpoint functions to pci_epc
  * @nb: notifier block to notify EPF of any EPC events (like linkup)
+ * @lock: mutex to protect pci_epf_ops
  */
 struct pci_epf {
 	struct device		dev;
@@ -126,6 +127,8 @@ struct pci_epf {
 	struct pci_epf_driver	*driver;
 	struct list_head	list;
 	struct notifier_block   nb;
+	/* mutex to protect against concurrent access of pci_epf_ops */
+	struct mutex		lock;
 };
 
 /**
-- 
2.17.1


--VQ2yjWQsQ6AxLetY4OhR
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5643): https://lists.cip-project.org/g/cip-dev/message=
/5643
Mute This Topic: https://lists.cip-project.org/mt/77727248/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--VQ2yjWQsQ6AxLetY4OhR--
