Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B70F0C00A5A
	for <webhook@archiver.kernel.org>; Thu, 19 Jan 2023 15:08:51 +0000 (UTC)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
 by mx.groups.io with SMTP id smtpd.web11.47425.1674140340379379768
 for <cip-dev@lists.cip-project.org>;
 Thu, 19 Jan 2023 06:59:00 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=E4CL3cMJ;
 spf=pass (domain: gmail.com, ip: 209.85.221.54, mailfrom: error27@gmail.com)
Received: by mail-wr1-f54.google.com with SMTP id r9so2140267wrw.4
        for <cip-dev@lists.cip-project.org>; Thu, 19 Jan 2023 06:59:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zeSo479aaLA6kL8tn8UanXNmZTCXn/cBCHHp7Ac4Plk=;
        b=E4CL3cMJbTQn/4jCGD2NErULuFbcMqGoU8lOD63wkMHbFNR6PJHfCg5BRodSR/HqAO
         pNwPdMjVqLz6Iq6gwz+jxUqHC2hYmkqkpigWOlkdo2EDFbVM77iDV8VUhByACPKd51yC
         8WHmaSdijIPtA6ScYtqbUCDzglt29f6/D7rai/yXCxqImbymVWnWVaMUcY0veLRXBKEi
         ZARnXKhL/r+zvPasKLYsV9ciywDimmObL45SI7RMFZ26jW1FlP5Id35Qe07LzZ25VM8f
         WGwAhzfRWCCd1o4aS74WTxP+grnzvOb+TElrPqH8nwT5jPdOJeKiVZFGK1YVfmNhWSdy
         GWuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zeSo479aaLA6kL8tn8UanXNmZTCXn/cBCHHp7Ac4Plk=;
        b=zYXjAlgSQSxYnLm2nYERrnh8jPatWwK7SO0BR6I2kH5bJTkXjZzhRSwSV7qhRrcxJm
         kFdA6iK4KcH4MLsNM/rhYZKya7HTGWhBSlMbyR/l4pDaR8aURuLV7rtAbukaJPfrrRaT
         tvpA658HlQ4PNvDcMyX4AtCvF3954XeDMA4PZJy9vzh7Ejw3TiVDe25GcIU4f4vUX9LI
         PZVxIx7mE9Gqn/dhr+WS4ET9Xe8GisBOF7htperqgOgT3+IWjdHWBR5yqe+mvSQPiJG0
         wlwWyxsrixRZR6X+prz0x2c2Dk8Re2B8RIo8TFzD2OR4/qWUX5+akI4fbazlHsFS7Qoz
         9HlA==
X-Gm-Message-State: AFqh2kpYDV7w63S1O8F1FztwPtN6llSHLGO+2tJiPylqbo20oP+9LBiv
	5J6b0Yzh17OAExfS19qGWao=
X-Google-Smtp-Source: AMrXdXtwuzhrzGcAP0ov6XDynEGu+oSos0PCiHvnjev/qU6pqPnvDrhGA79w15wZzDKDu2lNMJNG1g==
X-Received: by 2002:a5d:4e0d:0:b0:2bd:e03b:1203 with SMTP id p13-20020a5d4e0d000000b002bde03b1203mr18890930wrt.57.1674140338771;
        Thu, 19 Jan 2023 06:58:58 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id t10-20020a5d534a000000b00272c0767b4asm34444067wrv.109.2023.01.19.06.58.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 06:58:58 -0800 (PST)
Date: Thu, 19 Jan 2023 17:58:54 +0300
From: Dan Carpenter <error27@gmail.com>
To: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>, Rander Wang <rander.wang@intel.com>,
	sound-open-firmware@alsa-project.org, alsa-devel@alsa-project.org,
	kernel-janitors@vger.kernel.org,
	cip-dev <cip-dev@lists.cip-project.org>,
	Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: [PATCH] ASoC: SOF: ipc4-mtrace: prevent underflow in sof_ipc4_priority_mask_dfs_write()
Message-ID: <Y8laruWOEwOC/dx9@kili>
MIME-Version: 1.0
X-Mailer: git-send-email haha only kidding
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 19 Jan 2023 15:08:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10447

The "id" comes from the user.  Change the type to unsigned to prevent
an array underflow.

Fixes: f4ea22f7aa75 ("ASoC: SOF: ipc4: Add support for mtrace log extraction")
Signed-off-by: Dan Carpenter <error27@gmail.com>
---
 sound/soc/sof/ipc4-mtrace.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/sound/soc/sof/ipc4-mtrace.c b/sound/soc/sof/ipc4-mtrace.c
index 70dea8ae706e..0ec6ef681012 100644
--- a/sound/soc/sof/ipc4-mtrace.c
+++ b/sound/soc/sof/ipc4-mtrace.c
@@ -344,9 +344,10 @@ static ssize_t sof_ipc4_priority_mask_dfs_write(struct file *file,
 						size_t count, loff_t *ppos)
 {
 	struct sof_mtrace_priv *priv = file->private_data;
-	int id, ret;
+	unsigned int id;
 	char *buf;
 	u32 mask;
+	int ret;
 
 	/*
 	 * To update Nth mask entry, write:
@@ -357,9 +358,9 @@ static ssize_t sof_ipc4_priority_mask_dfs_write(struct file *file,
 	if (IS_ERR(buf))
 		return PTR_ERR(buf);
 
-	ret = sscanf(buf, "%d,0x%x", &id, &mask);
+	ret = sscanf(buf, "%u,0x%x", &id, &mask);
 	if (ret != 2) {
-		ret = sscanf(buf, "%d,%x", &id, &mask);
+		ret = sscanf(buf, "%u,%x", &id, &mask);
 		if (ret != 2) {
 			ret = -EINVAL;
 			goto out;
-- 
2.35.1


