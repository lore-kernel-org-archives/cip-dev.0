Return-Path: <theflamefire89@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1B27C6FD1C
	for <webhook@archiver.kernel.org>; Fri, 24 Mar 2023 17:18:45 +0000 (UTC)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
 by mx.groups.io with SMTP id smtpd.web10.2688.1679678320990569979
 for <cip-dev@lists.cip-project.org>;
 Fri, 24 Mar 2023 10:18:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=A3GRw9Sb;
 spf=pass (domain: gmail.com, ip: 209.85.128.52, mailfrom: theflamefire89@gmail.com)
Received: by mail-wm1-f52.google.com with SMTP id s13so1562507wmr.4
        for <cip-dev@lists.cip-project.org>; Fri, 24 Mar 2023 10:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679678319;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f1rgbf1nN6IXvclcq60zzZ83i7TOhjFvAGymV/bBlkA=;
        b=A3GRw9SbIQscWeT5+le5wXhMN5qz019FbeITALoJQtLQ1JynqyJm/ukbmZuGWFAaVH
         7O1nTSpesSmyPFzdPyupVNl/wnoSzmptMBVmcRUbpdPFMRrRBA0D2bX3SJqzhAnrf+TX
         DZPtw+dBXlolaSNK1g1F4VwVwWH1QTQVCDsLOtIponNK04VQTGJhn5Pa4MqcxWLc9iAf
         flXxl0UVxNp+GcjrYSo59mVyoJAEBnmUwlj7W9Xsxuytd6XWZ3mjLv5WGhNGiW113oxm
         2q0SXsFpHWqA60ODWNsIy43TROstGyU7dVXP9sx7HLoMUfhtGH2QbSV+Aq0zhcG5w3HU
         8oWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679678319;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f1rgbf1nN6IXvclcq60zzZ83i7TOhjFvAGymV/bBlkA=;
        b=H4sCO+NazKoZc1EOk4W+zlxWW07g2UN6k1BYqLkxRI0RuFJyziKh2HWs/l+Flr4rga
         zka/bIKwmtAEcoSbg1gcvjC2xNogs7oTT6gR4j9simyDp91Unbm7U+F4HGDSch/k3CMl
         1zNV5egdoYfQtYelUemhETMbjn7XVu9vPjcbRtB17CmjP1E/paMx2LEGX0FJkxXn+ahD
         YOlcy+zPwLXr5owfuWtXFfMiN4150pGFkQBYGCuomWurHpaCXcme3+5W2zx6nPs7CzqY
         +QXfr0Hf30Z1xN47OiCmhBlSz065L3uUM/25NiSgGyY6fQiAKLqnKNzplRGfMnrZJ2dv
         xDrA==
X-Gm-Message-State: AO0yUKUWa8uaExkn/kD1bTOTGPw+MoemZYaEV7+nQmul6gK41E7cMKzQ
	DTY9r48niOSzOs0oQLjDIyGtx1VrNlY=
X-Google-Smtp-Source: AK7set9ARAujKWfmVHBeK6CO+3TuuSbmafTFpiHgdlnLK1ugc7R00McYO46/335TebRz1OYn4JiQQg==
X-Received: by 2002:a05:600c:2312:b0:3dc:4fd7:31e9 with SMTP id 18-20020a05600c231200b003dc4fd731e9mr3512327wmo.7.1679678319366;
        Fri, 24 Mar 2023 10:18:39 -0700 (PDT)
Received: from alex-Mint.fritz.box (p200300f6af150c00d964c2cc0a52faf5.dip0.t-ipconnect.de. [2003:f6:af15:c00:d964:c2cc:a52:faf5])
        by smtp.googlemail.com with ESMTPSA id k22-20020a05600c1c9600b003eda46d6792sm340662wms.32.2023.03.24.10.18.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 10:18:38 -0700 (PDT)
From: Alexander Grund <theflamefire89@gmail.com>
To: cip-dev@lists.cip-project.org
Cc: uli+cip@fpond.eu
Subject: [PATCH 4.4 3/3] ALSA: control: use counting semaphore as write lock for ELEM_WRITE operation
Date: Fri, 24 Mar 2023 18:18:12 +0100
Message-Id: <20230324171812.221086-4-theflamefire89@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230324171812.221086-1-theflamefire89@gmail.com>
References: <20230324171812.221086-1-theflamefire89@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 24 Mar 2023 17:18:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11119

From: Takashi Sakamoto <o-takashi@sakamocchi.jp>

In ALSA control interface, applications can execute two types of request
for value of members on each element; ELEM_READ and ELEM_WRITE. In ALSA
control core, these two requests are handled within read lock of a
counting semaphore, therefore several processes can run to execute these
two requests at the same time. This has an issue because ELEM_WRITE
requests have an effect to change state of the target element. Concurrent
access should be controlled for each of ELEM_READ/ELEM_WRITE case.

This commit uses the counting semaphore as write lock for ELEM_WRITE
requests, while use it as read lock for ELEM_READ requests. The state of
a target element is maintained exclusively between ELEM_WRITE/ELEM_READ
operations.

There's a concern. If the counting semaphore is acquired for read lock
in implementations of 'struct snd_kcontrol.put()' in each driver, this
commit shall cause dead lock. As of v4.13-rc5, 'snd-mixer-oss.ko',
'snd-emu10k1.ko' and 'snd-soc-sst-atom-hifi2-platform.ko' includes codes
for read locks, but these are not in a call graph from
'struct snd_kcontrol.put(). Therefore, this commit is safe.

In current implementation, the same solution is applied for the other
operations to element; e.g. ELEM_LOCK and ELEM_UNLOCK. There's another
discussion about an overhead to maintain concurrent access to an element
during operating the other elements on the same card instance, because the
lock primitive is originally implemented to maintain a list of elements on
the card instance. There's a substantial difference between
per-element-list lock and per-element lock.

Here, let me investigate another idea to add per-element lock to maintain
the concurrent accesses with inquiry/change requests to an element. It's
not so frequent for applications to operate members on elements, while
adding a new lock primitive to structure increases memory footprint for
all of element sets somehow. Experimentally, inquiry operation is more
frequent than change operation and usage of counting semaphore for the
inquiry operation brings no blocking to the other inquiry operations. Thus
the overhead is not so critical for usual applications. For the above
reasons, in this commit, the per-element lock is not introduced.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Alexander Grund <theflamefire89@gmail.com>
---
 sound/core/control.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/core/control.c b/sound/core/control.c
index 3ca81e85a1492..04b939df3768b 100644
--- a/sound/core/control.c
+++ b/sound/core/control.c
@@ -963,9 +963,9 @@ static int snd_ctl_elem_write_user(struct snd_ctl_file *file,
 	snd_power_lock(card);
 	result = snd_power_wait(card, SNDRV_CTL_POWER_D0);
 	if (result >= 0) {
-		down_read(&card->controls_rwsem);
+		down_write(&card->controls_rwsem);
 		result = snd_ctl_elem_write(card, file, control);
-		up_read(&card->controls_rwsem);
+		up_write(&card->controls_rwsem);
 	}
 	snd_power_unlock(card);
 	if (result >= 0)
-- 
2.40.0


