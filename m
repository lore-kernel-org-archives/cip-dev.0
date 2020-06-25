Return-Path: <SRS0=TTuD=AG=lists.cip-project.org=bounce+64572+4821+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0A58C433E0
	for <cip-dev@archiver.kernel.org>; Thu, 25 Jun 2020 13:23:30 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 812702076E
	for <cip-dev@archiver.kernel.org>; Thu, 25 Jun 2020 13:23:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="Zp0C8ANt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 812702076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4821+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id vEQXYY4521723xmAJXUw76u6; Thu, 25 Jun 2020 06:23:30 -0700
X-Received: from lizzard.sbs.de (lizzard.sbs.de [194.138.37.39])
 by mx.groups.io with SMTP id smtpd.web12.10373.1593091407281445266
 for <cip-dev@lists.cip-project.org>;
 Thu, 25 Jun 2020 06:23:27 -0700
X-Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by lizzard.sbs.de (8.15.2/8.15.2) with ESMTPS id 05PDNP0N010530
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Thu, 25 Jun 2020 15:23:25 +0200
X-Received: from md2dvrtc.ad001.siemens.net ([167.87.6.122])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 05PDNPL4005095;
	Thu, 25 Jun 2020 15:23:25 +0200
From: "Quirin Gylstorff" <quirin.gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org, Jan.Kiszka@siemens.com
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Subject: [cip-dev] [cip-kernel-config PATCH] ipc227e: Add missing options to mount fat
Date: Thu, 25 Jun 2020 15:23:25 +0200
Message-Id: <20200625132325.16774-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 4A2yRjRafqw070xoGPKuCL3Ux4520388AA=
Content-Type: multipart/mixed; boundary="sUtpYeRbCj1CGuo9qyMI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1593091410;
 bh=B5wAGY7pFsogfJXID/f+MGtjy9A+9YXfvD9ctkRsxc8=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=Zp0C8ANtaRmCJnX/YBLxKLhgvtzHCu6I7+fM3lvKHZZjO6hvJPUepVJyvddmu7B6yW5
 sPWtSQCuBsp1JrK/xtFScg5fgMx8EBGHwl30aVaxocRn0WQB1AbWL8CQGN5ZFi4wBoq83
 aGuNbDNBl+NyrP5SfjP1eF4IXboG2Z4aO8o=

--sUtpYeRbCj1CGuo9qyMI
Content-Transfer-Encoding: 8bit

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

To install a swupdate package into a system with a A/B partition
scheme and EFI it is necessary to access a FAT partition.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 4.19.y-cip/x86/siemens_ipc227e_defconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/4.19.y-cip/x86/siemens_ipc227e_defconfig b/4.19.y-cip/x86/siemens_ipc227e_defconfig
index 0bbd649..273d20e 100644
--- a/4.19.y-cip/x86/siemens_ipc227e_defconfig
+++ b/4.19.y-cip/x86/siemens_ipc227e_defconfig
@@ -404,6 +404,10 @@ CONFIG_NFSD=y
 CONFIG_NFSD_V3_ACL=y
 CONFIG_NFSD_V4=y
 CONFIG_NLS_DEFAULT="utf8"
+CONFIG_NLS_ASCII=y
+CONFIG_NLS_CODEPAGE_437=y
+CONFIG_NLS_ISO8859_1=y
+CONFIG_NLS_UTF8=y
 CONFIG_PERSISTENT_KEYRINGS=y
 CONFIG_ENCRYPTED_KEYS=m
 CONFIG_SECURITY_DMESG_RESTRICT=y
-- 
2.20.1


--sUtpYeRbCj1CGuo9qyMI
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4821): https://lists.cip-project.org/g/cip-dev/message=
/4821
Mute This Topic: https://lists.cip-project.org/mt/75102506/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--sUtpYeRbCj1CGuo9qyMI--
