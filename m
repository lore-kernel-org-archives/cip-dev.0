Return-Path: <SRS0=OCCK=D6=lists.cip-project.org=bounce+64572+5663+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73674C4363A
	for <cip-dev@archiver.kernel.org>; Fri, 23 Oct 2020 16:58:17 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A891B206BE
	for <cip-dev@archiver.kernel.org>; Fri, 23 Oct 2020 16:58:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="ltvhkHVw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A891B206BE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5663+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id kZnAYY4521723xoIGHNo8y9q; Fri, 23 Oct 2020 09:58:16 -0700
X-Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web10.12445.1603472289888512488
 for <cip-dev@lists.cip-project.org>;
 Fri, 23 Oct 2020 09:58:15 -0700
X-IronPort-AV: E=Sophos;i="5.77,409,1596466800"; 
   d="scan'208";a="60634053"
X-Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 24 Oct 2020 01:58:15 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 317C8400C9EE;
	Sat, 24 Oct 2020 01:58:14 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.19.y-cip 5/6] arm64: defconfig: Enable R-Car PCIe endpoint driver
Date: Fri, 23 Oct 2020 17:58:04 +0100
Message-Id: <20201023165805.1910-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20201023165805.1910-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20201023165805.1910-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: f8yUHBCWcyPypoXZDHikkTFKx4520388AA=
Content-Type: multipart/mixed; boundary="wWCHsX6eqaE5Rbwe7BRI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1603472296;
 bh=dZyIhNgITjFisr+HY5JvBwAr+7EXaw9udP7nDHGGq4s=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=ltvhkHVwGSxFhs1Tp2sRpNzCxixEeho5QrF9ATPwcdy3m6z93A42yHNHQJUpX8kJd25
 EHal9BTK5YS8bxQk5sggkmYe1EK32ZYJ6p6i9sGfSXQ4+9CeBgw593JTybi+h7pewUuji
 hxOHft1sjwaKcIdBNzGw+0H9a+j83hVo8h0=

--wWCHsX6eqaE5Rbwe7BRI

commit cd8bc7d4eb6608afe78ac51422ef94b7824f1646 upstream.

Enable R-Car PCIe endpoint driver on RZ/G2E board, including enabling
endpoint configurations CONFIG_PCI_ENDPOINT, CONFIG_PCI_ENDPOINT_CONFIGFS,
CONFIG_PCI_EPF_TEST and CONFIG_PCI_ENDPOINT_TEST required to use and test
the driver.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Link: https://lore.kernel.org/r/20200811140357.564-1-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
[PL: Manually applied changes to defconfig file]
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 arch/arm64/configs/defconfig | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index ace1b58f3ff5..c8cc683d6e97 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -78,6 +78,7 @@ CONFIG_HOTPLUG_PCI_ACPI=y
 CONFIG_PCI_AARDVARK=y
 CONFIG_PCI_TEGRA=y
 CONFIG_PCIE_RCAR_HOST=y
+CONFIG_PCIE_RCAR_EP=y
 CONFIG_PCI_HOST_GENERIC=y
 CONFIG_PCI_XGENE=y
 CONFIG_PCI_HOST_THUNDER_PEM=y
@@ -88,6 +89,9 @@ CONFIG_PCI_HISI=y
 CONFIG_PCIE_QCOM=y
 CONFIG_PCIE_ARMADA_8K=y
 CONFIG_PCIE_KIRIN=y
+CONFIG_PCI_ENDPOINT=y
+CONFIG_PCI_ENDPOINT_CONFIGFS=y
+CONFIG_PCI_EPF_TEST=m
 CONFIG_PCIE_HISI_STB=y
 CONFIG_ARM64_VA_BITS_48=y
 CONFIG_SCHED_MC=y
@@ -194,6 +198,7 @@ CONFIG_BLK_DEV_NBD=m
 CONFIG_VIRTIO_BLK=y
 CONFIG_BLK_DEV_NVME=m
 CONFIG_SRAM=y
+CONFIG_PCI_ENDPOINT_TEST=m
 CONFIG_EEPROM_AT25=m
 # CONFIG_SCSI_PROC_FS is not set
 CONFIG_BLK_DEV_SD=y
-- 
2.17.1


--wWCHsX6eqaE5Rbwe7BRI
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5663): https://lists.cip-project.org/g/cip-dev/message=
/5663
Mute This Topic: https://lists.cip-project.org/mt/77756298/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--wWCHsX6eqaE5Rbwe7BRI--
