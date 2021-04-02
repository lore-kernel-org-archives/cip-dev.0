Return-Path: <SRS0=QBl9=I7=lists.cip-project.org=bounce+64572+6339+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F589C433ED
	for <cip-dev@archiver.kernel.org>; Fri,  2 Apr 2021 00:53:55 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 961D5610A5
	for <cip-dev@archiver.kernel.org>; Fri,  2 Apr 2021 00:53:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 961D5610A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6339+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id vxG9YY4521723xGFftmX39eS; Thu, 01 Apr 2021 17:53:54 -0700
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.155])
 by mx.groups.io with SMTP id smtpd.web10.9788.1617324832163589756
 for <cip-dev@lists.cip-project.org>;
 Thu, 01 Apr 2021 17:53:53 -0700
X-Received: by mo-csw.securemx.jp (mx-mo-csw1516) id 1320roQS030669; Fri, 2 Apr 2021 09:53:50 +0900
X-Iguazu-Qid: 34tKV5jqeADD4qNN3Y
X-Iguazu-QSIG: v=2; s=0; t=1617324830; q=34tKV5jqeADD4qNN3Y; m=kR7ClBJJKO9IlDvRzjyxvZdWFmAR/4uR2n9j43/TT1k=
X-Received: from imx12-a.toshiba.co.jp (imx12-a.toshiba.co.jp [61.202.160.135])
	by relay.securemx.jp (mx-mr1510) id 1320rn5u038809
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 2 Apr 2021 09:53:49 +0900
X-Received: from enc02.toshiba.co.jp (enc02.toshiba.co.jp [61.202.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by imx12-a.toshiba.co.jp (Postfix) with ESMTPS id 7714C1000F5;
	Fri,  2 Apr 2021 09:53:49 +0900 (JST)
X-Received: from hop101.toshiba.co.jp ([133.199.85.107])
	by enc02.toshiba.co.jp  with ESMTP id 1320rnSC022541;
	Fri, 2 Apr 2021 09:53:49 +0900
From: "Nobuhiro Iwamatsu" <nobuhiro1.iwamatsu@toshiba.co.jp>
To: jan.kiszka@siemens.com
Cc: cip-dev@lists.cip-project.org,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: [cip-dev] [PATCH] kas: Add opt/targz-img.yml
Date: Fri,  2 Apr 2021 09:53:46 +0900
X-TSB-HOP: ON
Message-Id: <20210402005346.372098-1-nobuhiro1.iwamatsu@toshiba.co.jp>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: pMfhdpBUCHayrAEAOI3v08Uyx4520388AA=
Content-Type: multipart/mixed; boundary="Q0utwEr93C21WIp588Ft"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1617324834;
 bh=YpBA9E9NAW2q/goavDR9fzCVV3ZGf0ef2cJhzXWfOHE=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=tnWdTjIH+fZCG51L7cpezxhg/kzkJ1s1CdzJWEmgaM6bJzpXs0x3IpQHEHq0Bx4wcPe
 TroQtwwAMwRHYuz0peR6ZZO/8EEJd5vEQ4M/HY2yZlqk8dyguOPTQivAuYX5ooAV0iRYk
 A8Qic9qoBhUvE0kYt3uHOt+P+0l88RLOp7w=

--Q0utwEr93C21WIp588Ft
Content-Transfer-Encoding: 8bit

This provides the function to specify 'targz-img' for IMAGE_TYPE. This is
used when creating a tar.gz image that does not support wic.

Signed-off-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
---
 .gitlab-ci.yml        |  3 +++
 kas/opt/targz-img.yml | 20 ++++++++++++++++++++
 2 files changed, 23 insertions(+)
 create mode 100644 kas/opt/targz-img.yml

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index d14c72f..8802af1 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -6,6 +6,7 @@ variables:
   extention: base
   use_rt: enable
   wic_targz: enable
+  targz: disable
   dtb: none
   deploy: enable
 
@@ -30,6 +31,7 @@ default:
     - if [ "${use_rt}" = "enable" ]; then base_yaml="${base_yaml}:kas/opt/rt.yml"; fi;
     - if [ "${extention}" != "base" ]; then base_yaml="${base_yaml}:kas/opt/${extention}.yml"; fi;
     - if [ "${wic_targz}" = "enable" ]; then base_yaml="${base_yaml}:kas/opt/wic-targz-img.yml"; fi;
+    - if [ "${targz}" = "enable" ]; then base_yaml="${base_yaml}:kas/opt/targz-img.yml"; fi;
     - kas build ${base_yaml}
     - if [ "${deploy}" = "enable" ]; then scripts/deploy-cip-core.sh ${release} ${target} ${extention} ${dtb}; fi
 
@@ -69,6 +71,7 @@ build:qemu-amd64-base:
     extention: security
     use_rt: disable
     wic_targz: disable
+    targz: enable
     deploy: disable
 
 # test
diff --git a/kas/opt/targz-img.yml b/kas/opt/targz-img.yml
new file mode 100644
index 0000000..43c545e
--- /dev/null
+++ b/kas/opt/targz-img.yml
@@ -0,0 +1,20 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2019
+#
+# Authors:
+#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+header:
+  version: 10
+
+# lava uses nfs to deploy the image. For this we need a tarball instead of
+# full image
+
+local_conf_header:
+  image-type: |
+    IMAGE_TYPE = "targz-img"
-- 
2.30.0.rc2


--Q0utwEr93C21WIp588Ft
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6339): https://lists.cip-project.org/g/cip-dev/message=
/6339
Mute This Topic: https://lists.cip-project.org/mt/81792957/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--Q0utwEr93C21WIp588Ft--
