Return-Path: <SRS0=cr5o=KF=lists.cip-project.org=bounce+64572+6440+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F4D7C43460
	for <cip-dev@archiver.kernel.org>; Mon, 10 May 2021 01:34:39 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18ABF613DB
	for <cip-dev@archiver.kernel.org>; Mon, 10 May 2021 01:34:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18ABF613DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6440+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id VIViYY4521723xtb0fpPIOWF; Sun, 09 May 2021 18:34:38 -0700
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.154])
 by mx.groups.io with SMTP id smtpd.web09.26234.1620610475255567638
 for <cip-dev@lists.cip-project.org>;
 Sun, 09 May 2021 18:34:36 -0700
X-Received: by mo-csw.securemx.jp (mx-mo-csw1515) id 14A1YX3i021655; Mon, 10 May 2021 10:34:33 +0900
X-Iguazu-Qid: 34trpShQInaxOoKQI9
X-Iguazu-QSIG: v=2; s=0; t=1620610472; q=34trpShQInaxOoKQI9; m=scNI4WGGNXv8PS/DRwRugRotA0Jo8mbGCpHqTM0qvJE=
X-Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1513) id 14A1YVNE003760
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 10 May 2021 10:34:32 +0900
X-Received: from enc01.toshiba.co.jp (enc01.toshiba.co.jp [106.186.93.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by imx2-a.toshiba.co.jp (Postfix) with ESMTPS id E67CC1000C7;
	Mon, 10 May 2021 10:34:31 +0900 (JST)
X-Received: from hop001.toshiba.co.jp ([133.199.164.63])
	by enc01.toshiba.co.jp  with ESMTP id 14A1YVmZ001808;
	Mon, 10 May 2021 10:34:31 +0900
From: "Nobuhiro Iwamatsu" <nobuhiro1.iwamatsu@toshiba.co.jp>
To: jan.kiszka@siemens.com
Cc: cip-dev@lists.cip-project.org,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: [cip-dev] [PATCH 4/4] .gitlab-ci.yml: Add build:qemu-amd64-test target
Date: Mon, 10 May 2021 10:34:23 +0900
X-TSB-HOP: ON
Message-Id: <20210510013423.65527-4-nobuhiro1.iwamatsu@toshiba.co.jp>
In-Reply-To: <20210510013423.65527-1-nobuhiro1.iwamatsu@toshiba.co.jp>
References: <20210510013423.65527-1-nobuhiro1.iwamatsu@toshiba.co.jp>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: jPyWX93kun15hffSG1n9CdxXx4520388AA=
Content-Type: multipart/mixed; boundary="Lsua0107XKQcMUlHPTWJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1620610478;
 bh=6/JqxKN0jCrrF/uA+ZaNDybNcszgpc9ZKulqtOd3CZU=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=xO/ddlIRNsAErxIACJSZh2vULDQsr4gCXQMDTLxBcw4dHKgrLFTk0eNDu6YjjOpdSyF
 3UhhF6kxsZKQ6FbPQPAhAzGyDRspU+yz9fH0Xnd+XTasIbzzCTmcm0/8SDL8bVmXCqnc/
 HZ/Ank9PtmDWPzLhFodyiRbIYlcU44VjoFA=

--Lsua0107XKQcMUlHPTWJ
Content-Transfer-Encoding: 8bit

This adds a target for the test image for QEMU/amd64 architecture.

Signed-off-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
---
 .gitlab-ci.yml | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 64c7b20..84c1257 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -125,6 +125,15 @@ build:hihope-rzg2m-test:
     extention: test
     dtb: renesas/r8a774a1-hihope-rzg2m-ex.dtb
 
+build:qemu-amd64-test:
+  extends:
+    - .build_base
+  variables:
+    target:  qemu-amd64
+    extention: test
+    wic_targz: disable
+    targz: enable
+
 build:qemu-arm64-test:
   extends:
     - .build_base
-- 
2.31.1


--Lsua0107XKQcMUlHPTWJ
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6440): https://lists.cip-project.org/g/cip-dev/message=
/6440
Mute This Topic: https://lists.cip-project.org/mt/82710740/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--Lsua0107XKQcMUlHPTWJ--
