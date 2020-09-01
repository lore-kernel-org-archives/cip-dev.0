Return-Path: <SRS0=1z9+=CK=lists.cip-project.org=bounce+64572+5347+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75981C433E6
	for <cip-dev@archiver.kernel.org>; Tue,  1 Sep 2020 06:13:43 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 484D62098B
	for <cip-dev@archiver.kernel.org>; Tue,  1 Sep 2020 06:13:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="P2Rxqh1C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 484D62098B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5347+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id FlyTYY4521723xUvr6LFrPWO; Mon, 31 Aug 2020 23:13:43 -0700
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.153])
 by mx.groups.io with SMTP id smtpd.web12.7061.1598940822351567354
 for <cip-dev@lists.cip-project.org>;
 Mon, 31 Aug 2020 23:13:42 -0700
X-Received: by mo-csw.securemx.jp (mx-mo-csw1514) id 0816Df0m029914; Tue, 1 Sep 2020 15:13:41 +0900
X-Iguazu-Qid: 34tKBCMUDaGdFiceOf
X-Iguazu-QSIG: v=2; s=0; t=1598940820; q=34tKBCMUDaGdFiceOf; m=2IUeC3WVOkx4RdFWFCxQq1xw92U8IZWSwwtOKo3P/+Q=
X-Received: from imx2.toshiba.co.jp (imx2.toshiba.co.jp [106.186.93.51])
	by relay.securemx.jp (mx-mr1513) id 0816DdAt019574;
	Tue, 1 Sep 2020 15:13:40 +0900
X-Received: from enc03.toshiba.co.jp ([106.186.93.13])
	by imx2.toshiba.co.jp  with ESMTP id 0816DdM3002040;
	Tue, 1 Sep 2020 15:13:39 +0900 (JST)
X-Received: from hop001.toshiba.co.jp ([133.199.164.63])
	by enc03.toshiba.co.jp  with ESMTP id 0816Ddhu027142;
	Tue, 1 Sep 2020 15:13:39 +0900
From: "Nobuhiro Iwamatsu" <nobuhiro1.iwamatsu@toshiba.co.jp>
To: cip-dev@lists.cip-project.org
Cc: chris.paterson2@renesas.com,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: [cip-dev] [linux-cip-ci][PATCH 3/3] lava_templates: Add test script for generated yaml file
Date: Tue,  1 Sep 2020 15:13:14 +0900
X-TSB-HOP: ON
Message-Id: <20200901061314.2749466-3-nobuhiro1.iwamatsu@toshiba.co.jp>
In-Reply-To: <20200901061314.2749466-1-nobuhiro1.iwamatsu@toshiba.co.jp>
References: <20200901061314.2749466-1-nobuhiro1.iwamatsu@toshiba.co.jp>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: wkshm7VkRykhiU2tPpRjinjhx4520388AA=
Content-Type: multipart/mixed; boundary="p2CKLA5NihRFwBvlH0RN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1598940823;
 bh=RJg8uMC3YwXKga8YrqystcT0kEKjNLfCRS8XSxotqdg=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=P2Rxqh1CXIzucd1y+18NSRFKJuE4L8Ow+ElNg63fxeiZuERa8xbGPdTfYhIgoTsLM0v
 9RHwwDajblzmgvMM4UM4khZdfV09yulgFTu6AG7yENjgIpDBnkD7Ny+u3ct0ZR00djswN
 87AkCFN5J42OURSp7eCPxQwPxvmHuHJVrkg=

--p2CKLA5NihRFwBvlH0RN
Content-Transfer-Encoding: 8bit

This will add a script that will output the final YAML generated.
This is used to verify YAML.

```
$ ./lava_templates/show_generated_yaml.sh de0-nano-soc arm \
		deby-buster-ltp ltp-ipc-tests true
```

Signed-off-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
---
 lava_templates/show_generated_yaml.sh | 74 +++++++++++++++++++++++++++
 1 file changed, 74 insertions(+)
 create mode 100755 lava_templates/show_generated_yaml.sh

diff --git a/lava_templates/show_generated_yaml.sh b/lava_templates/show_generated_yaml.sh
new file mode 100755
index 0000000..e383765
--- /dev/null
+++ b/lava_templates/show_generated_yaml.sh
@@ -0,0 +1,74 @@
+#!/bin/bash
+# Copyright (C) 2020, Renesas Electronics Europe GmbH, Chris Paterson <chris.paterson2@renesas.com>
+# Copyright (C) 2020, Toshiba Nobuhiro Iwamtasu <nobuhiro1.iwamatsu@toshibac.co.jp>
+#
+
+set -e
+
+# $1: OS type
+# $2: Test name
+create_job_definition () {
+	local base_os="$1"
+	local testname="$2"
+
+	local dtb_url="$AWS_URL_DOWN/$DTB"
+	local kernel_url="$AWS_URL_DOWN/$KERNEL"
+	local modules_url="$AWS_URL_DOWN/$MODULES"
+
+	local commit_ref=$(echo "${CI_COMMIT_REF_NAME}" | sed 's/\//-/g')
+
+	if $USE_DTB; then
+		local job_name="${commit_ref}_${VERSION}_${BUILD_ARCH}_${CONFIG}_${DTB_NAME}_${testname}"
+	else
+		local job_name="${commit_ref}_${VERSION}_${BUILD_ARCH}_${CONFIG}_${testname}"
+	fi
+
+	local job_definition="$TMP_DIR/${INDEX}_${job_name}.yaml"
+	INDEX=$((INDEX+1))
+
+	cat ${TEMPLATE_DIR}/header_base.yaml > "${job_definition}"
+	if [ "${DEVICE}" = "qemu" ] ; then
+		local device_name="${DEVICE}_${BUILD_ARCH}"
+		cat ${TEMPLATE_DIR}/context_${device_name}.yaml >> "${job_definition}"
+	else
+		local device_name="${DEVICE}"
+	fi
+
+	cat ${TEMPLATE_DIR}/timeouts_"${testname}".yaml \
+	    ${TEMPLATE_DIR}/action_"${base_os}"_"${device_name}".yaml \
+	    ${TEMPLATE_DIR}/boot_"${base_os}"_"${device_name}".yaml \
+	    ${TEMPLATE_DIR}/test_"${testname}".yaml \
+	    >> "${job_definition}"
+
+	sed -i "s|DEVICE_NAME|${DEVICE}|g" "$job_definition"
+	sed -i "s|JOB_NAME|$job_name|g" "$job_definition"
+	if $USE_MODULES; then
+		sed -i "/DTB_URL/ a \    modules:\n      url: $modules_url\n      compression: gz" "$job_definition"
+	fi
+	if $USE_DTB; then
+		sed -i "s|DTB_URL|$dtb_url|g" "$job_definition"
+	fi
+	sed -i "s|KERNEL_URL|$kernel_url|g" "$job_definition"
+
+	echo ${job_definition}
+	cat ${job_definition}
+}
+
+SCRIPT_DIR=$(cd $(dirname $0);pwd)
+
+TEMPLATE_DIR="${SCRIPT_DIR}"
+TMP_DIR="/tmp/"
+AWS_URL_DOWN="exmample.org"
+KERNEL="zImage"
+DTB="foo.dtb"
+MODULES="bar.tar.gz"
+VERSION="4.19.1-1"
+CI_COMMIT_REF_NAME="a/b/c/d"
+CONFIG="testconfig"
+DTB_NAME="test-dtb"
+INDEX="1"
+DEVICE=$1
+BUILD_ARCH=$2
+USE_DTB=$5
+
+create_job_definition $3 $4
-- 
2.27.0


--p2CKLA5NihRFwBvlH0RN
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5347): https://lists.cip-project.org/g/cip-dev/message=
/5347
Mute This Topic: https://lists.cip-project.org/mt/76551108/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--p2CKLA5NihRFwBvlH0RN--
