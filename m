Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB2A5C004D4
	for <webhook@archiver.kernel.org>; Thu, 19 Jan 2023 15:10:31 +0000 (UTC)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
 by mx.groups.io with SMTP id smtpd.web10.47472.1674140999829806030
 for <cip-dev@lists.cip-project.org>;
 Thu, 19 Jan 2023 07:10:00 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=TjcnCssR;
 spf=pass (domain: gmail.com, ip: 209.85.128.52, mailfrom: error27@gmail.com)
Received: by mail-wm1-f52.google.com with SMTP id l41-20020a05600c1d2900b003daf986faaeso1487052wms.3
        for <cip-dev@lists.cip-project.org>; Thu, 19 Jan 2023 07:09:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UAyoS/l0ukb8nWYy7RZDQQ8DiM08SBtHt1L84CqYlRc=;
        b=TjcnCssRgj+EfEZEr5WV0hvoRM0b5BzKvluALWmMw0IpLVZH4dq15+EwYLmr5tlijq
         l5EmfwjYhZS3Oq6zL6xfjTFis8ERb45I4R/9H13MJHD/gr2T+5n91U4uvLzTEW4pJzix
         JtsvGq6lWCS/hzzAhCBmBTNt11hG9TJUs+5hhEIdyl4pFn5onTF2nRnVlh7VN9rk/7Nz
         JW7e6tNuP8f88EWly/1YpgtBWbppvG8ACYd23xql5Ab5Fq7TO6LYyPplp56Rg1SRl5/Y
         /9rGjHbJOdHvf4+XKeb0648rqOhY+9EXZr55eW5iZtvg3TxMWK69lb5lDIqiW+yjKB+X
         V8WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UAyoS/l0ukb8nWYy7RZDQQ8DiM08SBtHt1L84CqYlRc=;
        b=2JFqqRam4evzBjLClKdyV5aB7KAc2p7wjIJWeJEmC9bXqGsErHUCRlrXgm96DFW2m4
         Svu6HmIRlfupmBx0GnCHVSnFEimO1H/Vjr7Y8gMmG5n+8HMQmXUzjYTVaE/KzoNpP2Mr
         h0LcdOnXzdcx3OycPn5gT6gE3YO71AqXMOgBMlFXJD6EEOZFIC36WwjkxGS4TOL/qo2X
         CCns+JVWt4XU1PFpzmf9PwX+NCy2ZJv2VYnFGrDV0YHCb0gMFKUDALAdtgiW2OF+q5fB
         1ILnVlKxcGRTlGrxD9yzK0sWrJ0Xy7CvKqr0A/Ta5HRpg8LGnN7ko0LfItamtghtJy1J
         dGAw==
X-Gm-Message-State: AFqh2kqbP9FOXxG4edhGDMVESl1kc9xSZNAPOETsLtoCDTmOJAjFI1eK
	rnXjy/vQcgYlky6rAHQ9b8c=
X-Google-Smtp-Source: AMrXdXsp0JKlPpH8FShIRP0LvtpChF3J/qGgB+aSM3orEEx/A6n7DvN+mte7plsHtFaCM4K21rzXog==
X-Received: by 2002:a05:600c:3549:b0:3da:acb1:2f09 with SMTP id i9-20020a05600c354900b003daacb12f09mr6758658wmq.19.1674140998132;
        Thu, 19 Jan 2023 07:09:58 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id k9-20020a5d6d49000000b002bc8130cca7sm25982573wri.23.2023.01.19.07.09.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 07:09:57 -0800 (PST)
Date: Thu, 19 Jan 2023 18:09:54 +0300
From: Dan Carpenter <error27@gmail.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, nvdimm@lists.linux.dev,
	linux-acpi@vger.kernel.org, kernel-janitors@vger.kernel.org,
	cip-dev <cip-dev@lists.cip-project.org>,
	Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: [PATCH v2] ACPI: NFIT: prevent underflow in acpi_nfit_ctl()
Message-ID: <Y8ldQn1v4r5i5WLX@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 19 Jan 2023 15:10:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10448

The concern here would be that "family" is negative and we pass a
negative value to test_bit() resulting in an out of bounds read
and potentially a crash.

This patch is based on static analysis and not on testing.

Fixes: 9a7e3d7f0568 ("ACPI: NFIT: Fix input validation of bus-family")
Signed-off-by: Dan Carpenter <error27@gmail.com>
---
v2: add missing close parens ) in subject

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

