Return-Path: <SRS0=DbCI=GX=lists.cip-project.org=bounce+64572+6114+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F78EC43381
	for <cip-dev@archiver.kernel.org>; Wed, 20 Jan 2021 08:34:52 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 060AB2251D
	for <cip-dev@archiver.kernel.org>; Wed, 20 Jan 2021 08:34:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 060AB2251D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6114+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id yH4uYY4521723xtaiOa7EnJU; Wed, 20 Jan 2021 00:34:50 -0800
X-Received: from lizzard.sbs.de (lizzard.sbs.de [194.138.37.39])
 by mx.groups.io with SMTP id smtpd.web12.25408.1611131687014197741
 for <cip-dev@lists.cip-project.org>;
 Wed, 20 Jan 2021 00:34:47 -0800
X-Received: from mail1.sbs.de (mail1.sbs.de [192.129.41.35])
	by lizzard.sbs.de (8.15.2/8.15.2) with ESMTPS id 10K8YjYc004563
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Wed, 20 Jan 2021 09:34:45 +0100
X-Received: from md2dvrtc.ad001.siemens.net ([139.22.114.182])
	by mail1.sbs.de (8.15.2/8.15.2) with ESMTP id 10K8YhY7009837;
	Wed, 20 Jan 2021 09:34:44 +0100
From: "Quirin Gylstorff" <quirin.gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Subject: [cip-dev][isar-cip-core][PATCH v3 2/4] swupdate: use libubootenv
Date: Wed, 20 Jan 2021 09:34:41 +0100
Message-Id: <20210120083443.8105-3-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20210120083443.8105-1-Quirin.Gylstorff@siemens.com>
References: <20210120083443.8105-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: AqAKtkwvBHdYvS9vPXSeuGrmx4520388AA=
Content-Type: multipart/mixed; boundary="DxeLT4CrxydWczFSr5Xo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1611131690;
 bh=znfhCtwkFr4yPAvXoilZ5ZVSdP22SuUvuNh08bOg/ZE=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=lYCGluRg2NUVQdjQL4ocibQ37LwEju9M3JYVBTAlJf4jgnpWSRnTk7XBAYwXJFHfQN3
 4SPHAjJsyMOrALDba5tvIxxbyDUL2lSBngn/9qY7MjP4/qt3xa47ISv8b0oJM2N3kwJHA
 SK+2TgVrLtZq3/IcNzdIcH1NMsOJUnngKv0=

--DxeLT4CrxydWczFSr5Xo
Content-Transfer-Encoding: 8bit

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

libubootenv provides hardware independent access to u-boot environments.
This change conflicts with u-boot tools < 10.2019.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 classes/swupdate-config.bbclass | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/classes/swupdate-config.bbclass b/classes/swupdate-config.bbclass
index 208d240..dd0317f 100644
--- a/classes/swupdate-config.bbclass
+++ b/classes/swupdate-config.bbclass
@@ -46,8 +46,8 @@ KFEATURE_ubi[KCONFIG_SNIPPETS] = "file://swupdate_defconfig_ubi.snippet"
 KFEATURE_DEPS[ubi] = "mtd"
 
 KFEATURE_u-boot = ""
-KFEATURE_u-boot[BUILD_DEB_DEPENDS] = "u-boot-${MACHINE}-dev"
-KFEATURE_u-boot[DEBIAN_DEPENDS] = "u-boot-tools"
+KFEATURE_u-boot[BUILD_DEB_DEPENDS] = "libubootenv-dev"
+KFEATURE_u-boot[DEBIAN_DEPENDS] = "libubootenv-tool, u-boot-tools"
 KFEATURE_u-boot[DEPENDS] = "${U_BOOT}"
 KFEATURE_u-boot[KCONFIG_SNIPPETS] = "file://swupdate_defconfig_u-boot.snippet"
 
-- 
2.20.1


--DxeLT4CrxydWczFSr5Xo
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6114): https://lists.cip-project.org/g/cip-dev/message=
/6114
Mute This Topic: https://lists.cip-project.org/mt/79974652/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--DxeLT4CrxydWczFSr5Xo--
