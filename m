Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D214AC004D4
	for <webhook@archiver.kernel.org>; Thu, 19 Jan 2023 15:08:41 +0000 (UTC)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
 by mx.groups.io with SMTP id smtpd.web11.47125.1674139639237129465
 for <cip-dev@lists.cip-project.org>;
 Thu, 19 Jan 2023 06:47:19 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=Rlcd0foP;
 spf=pass (domain: gmail.com, ip: 209.85.128.45, mailfrom: error27@gmail.com)
Received: by mail-wm1-f45.google.com with SMTP id l8so1719997wms.3
        for <cip-dev@lists.cip-project.org>; Thu, 19 Jan 2023 06:47:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qBdr6CvRTXDqztxS8w8Amt28GJOv4Ri8se7UX3qldf0=;
        b=Rlcd0foPpo0HC2tQTapxWVA6Ga1i1tUz28R8lL0TO+0CW7/5yQ/iTNRPP5QXdzNB+F
         a2iGNJPcx8F5Z8PVuvDxPTj8masQbhp7gvXiJzQMtnxRDEo6UbacI2Y3eQfve8AJ0bvl
         n1tPyYjwvqAiuhlu4qxddnhyWosapw5WFH5beG1V8NP7oISxZq47UfLuD+9hzzQAIQ0d
         gpkCrYz99hwXb/ZJ5R/Gom6BVOrlA2QW97Euu9fw+pOkhFqFNLI7ID+s/qxdijlj81a0
         2JvkmJD5k0OJCJpUgHeqjdQ4g62xtIaMFgoHOvxzdAWAIO1VQanrTfXJy9wrzPVxxgC6
         tneg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qBdr6CvRTXDqztxS8w8Amt28GJOv4Ri8se7UX3qldf0=;
        b=SbxJJxVmk/Qqml/dysULVeBDUZP+GdWcAbtt67k5jMbDxMRwtE7ryMd/dBr5ZRsEBf
         i3+8eQ40yUmRKGlKOHtIe+JGTVlpq7G9d5MiGyHLa8exzlnLmNk6CgtKEg3AcWx+Bo3+
         VtGG02NI6F/Wvsbao0MGktY0+fNQMzYGEcxNpU5ikQzwz20fZYaLfTZu92DRq+xcTCR3
         PcznX9ujOAPQUS3iIfiljtpxG/g+MLX9b8GEE/HGJCPz77hOUTUTJVU/AT3ee4hiqdhA
         M8hfDfDwdt87YH2Xn/JXdDK9OHriePPDeSttB+mUQXCJUKw0M0jWAP77QOEd+YHXBg/N
         fsvw==
X-Gm-Message-State: AFqh2kqF+jDXYLpzGmMbbMtKgcTl+D/xj3QxhfxXPTXwTLL+BKMkA9E9
	ZOLDr1dowa7NPiJSS9NoafM=
X-Google-Smtp-Source: AMrXdXuPPvS8OnQHS/sRBKiM2PpTV40PNEhTNVTm09fiDdyyeEKvLn+CGTf+7kiDD3MI/en4rrwx+w==
X-Received: by 2002:a05:600c:1d8e:b0:3d9:efe8:a42d with SMTP id p14-20020a05600c1d8e00b003d9efe8a42dmr10503656wms.21.1674139637594;
        Thu, 19 Jan 2023 06:47:17 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id p18-20020a05600c359200b003db040f0d5esm5471979wmq.33.2023.01.19.06.47.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 06:47:17 -0800 (PST)
Date: Thu, 19 Jan 2023 17:47:13 +0300
From: Dan Carpenter <error27@gmail.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, nvdimm@lists.linux.dev,
	linux-acpi@vger.kernel.org, kernel-janitors@vger.kernel.org,
	cip-dev <cip-dev@lists.cip-project.org>,
	Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: [PATCH] ACPI: NFIT: prevent underflow in acpi_nfit_ctl(
Message-ID: <Y8lX8bKPN6ObNN2i@kili>
MIME-Version: 1.0
X-Mailer: git-send-email haha only kidding
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 19 Jan 2023 15:08:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10446

The concern here would be that "family" is negative and we pass a
negative value to test_bit() resulting in an out of bounds read
and potentially a crash.

This patch is based on static analysis and not on testing.

Fixes: 9a7e3d7f0568 ("ACPI: NFIT: Fix input validation of bus-family")
Signed-off-by: Dan Carpenter <error27@gmail.com>
---
Another idea would be that we could change test_bit() to not accept
bits higher than INT_MAX.

 drivers/acpi/nfit/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
index f1cc5ec6a3b6..da0739f04c98 100644
--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -446,10 +446,10 @@ int acpi_nfit_ctl(struct nvdimm_bus_descriptor *nd_desc, struct nvdimm *nvdimm,
 	const char *cmd_name, *dimm_name;
 	unsigned long cmd_mask, dsm_mask;
 	u32 offset, fw_status = 0;
+	unsigned int family = 0;
 	acpi_handle handle;
 	const guid_t *guid;
 	int func, rc, i;
-	int family = 0;
 
 	if (cmd_rc)
 		*cmd_rc = -EINVAL;
-- 
2.35.1


