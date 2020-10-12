Return-Path: <SRS0=86in=DT=lists.cip-project.org=bounce+64572+5562+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E418CC433E7
	for <cip-dev@archiver.kernel.org>; Mon, 12 Oct 2020 14:21:07 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9992D2076E
	for <cip-dev@archiver.kernel.org>; Mon, 12 Oct 2020 14:21:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="QIFtBjmQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9992D2076E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5562+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id EUH5YY4521723x3WSYLP3TBT; Mon, 12 Oct 2020 07:21:07 -0700
X-Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web11.41766.1602512424455510129
 for <cip-dev@lists.cip-project.org>;
 Mon, 12 Oct 2020 07:20:39 -0700
X-IronPort-AV: E=Sophos;i="5.77,366,1596466800"; 
   d="scan'208";a="59566889"
X-Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 12 Oct 2020 23:20:38 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id BA32B41D31C7;
	Mon, 12 Oct 2020 23:20:37 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [cip-dev] [RFC PATCH 4.19.y-cip 42/50] arm64: defconfig: Enable R-Car PCIe endpoint driver
Date: Mon, 12 Oct 2020 15:19:25 +0100
Message-Id: <20201012141933.9652-43-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20201012141933.9652-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20201012141933.9652-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: n2iagN13XxyrH6VG1z5IsVPLx4520388AA=
Content-Type: multipart/mixed; boundary="ByoLwxmYmbWndA22mm9k"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1602512467;
 bh=1Eog9i9HdX75cVsfsFXNhTHlV9bDsHQOAA9gadm+uCs=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=QIFtBjmQFYjY+Fi9HHhUtqepw2hokQwvbF/5RqZcqjqepGQnQCEaEg7TC7tJOHiB58o
 HuOOvtSf1Vle/qZLH1qENOHuzSkcSV90PJitALyawgwmvC6+rQMduh/vVECwIBhATpNpc
 syerJQLIuL6hWQhZTwRVOMAE/givpwLjuJ8=

--ByoLwxmYmbWndA22mm9k

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


--ByoLwxmYmbWndA22mm9k
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5562): https://lists.cip-project.org/g/cip-dev/message=
/5562
Mute This Topic: https://lists.cip-project.org/mt/77461724/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--ByoLwxmYmbWndA22mm9k--
