Return-Path: <SRS0=xhFG=B7=lists.cip-project.org=bounce+64572+5170+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2B75C433E1
	for <cip-dev@archiver.kernel.org>; Fri, 21 Aug 2020 09:56:04 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72C00207DE
	for <cip-dev@archiver.kernel.org>; Fri, 21 Aug 2020 09:56:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="bpF/HpoZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72C00207DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5170+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id KQI4YY4521723xNCMSqPMQ8E; Fri, 21 Aug 2020 02:56:04 -0700
X-Received: from gecko.sbs.de (gecko.sbs.de [194.138.37.40])
 by mx.groups.io with SMTP id smtpd.web11.130579.1598003762831393641
 for <cip-dev@lists.cip-project.org>;
 Fri, 21 Aug 2020 02:56:03 -0700
X-Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by gecko.sbs.de (8.15.2/8.15.2) with ESMTPS id 07L9u1rd026935
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Fri, 21 Aug 2020 11:56:01 +0200
X-Received: from md2dvrtc.fritz.box ([167.87.58.237])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 07L9u0Qq003248;
	Fri, 21 Aug 2020 11:56:00 +0200
From: "Quirin Gylstorff" <quirin.gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Subject: [cip-dev][isar-cip-core][PATCH v4 1/6] linux-cip: Update revision of kernel config
Date: Fri, 21 Aug 2020 11:55:54 +0200
Message-Id: <20200821095559.28467-2-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20200821095559.28467-1-Quirin.Gylstorff@siemens.com>
References: <20200821095559.28467-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: vl61EhgmqeZrvc8twi4zrWSgx4520388AA=
Content-Type: multipart/mixed; boundary="rUWy4w6RPaRekD0SLCXR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1598003764;
 bh=9liZiGk/YgYsRzj8HYa9lZ64NsHYVvZ6P0yqOoesIdc=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=bpF/HpoZHFcaXsIs9th+2R6cZBS5H4+KSWmCNkJNhrJrcJUIijDc7GA7BWwiBOOrKXi
 a1Fwr8foKLU3tzz/WbXsAyj8tg9PJrZVxUSAHdlDiasKNdhobq6XBj9BxuqpPvAtt+fGC
 /7MnM8ZkXVg3ieiwEyz8rnqDR8ZQMUxR16k=

--rUWy4w6RPaRekD0SLCXR
Content-Transfer-Encoding: 8bit

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Update the kernel configuration to the lasted version to
avoid a qemu runtime error.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 recipes-kernel/linux/linux-cip-common.inc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-kernel/linux/linux-cip-common.inc b/recipes-kernel/linux/linux-cip-common.inc
index d45a3b0..0c76835 100644
--- a/recipes-kernel/linux/linux-cip-common.inc
+++ b/recipes-kernel/linux/linux-cip-common.inc
@@ -26,4 +26,4 @@ SRC_URI += " \
 SRC_URI_append = " ${@conditional("USE_CIP_KERNEL_CONFIG", "1", \
     "git://gitlab.com/cip-project/cip-kernel/cip-kernel-config.git;protocol=https;destsuffix=cip-kernel-config;name=cip-kernel-config", \
     "file://${KERNEL_DEFCONFIG}",d)}"
-SRCREV_cip-kernel-config ?= "db2085219b5f28ed7c3e0fbdf93b7867947958a8"
+SRCREV_cip-kernel-config ?= "ca24d965adf77730caf1cd32bdfcffd69e369502"
-- 
2.20.1


--rUWy4w6RPaRekD0SLCXR
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5170): https://lists.cip-project.org/g/cip-dev/message=
/5170
Mute This Topic: https://lists.cip-project.org/mt/76326083/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--rUWy4w6RPaRekD0SLCXR--
