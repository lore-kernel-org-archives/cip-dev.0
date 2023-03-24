Return-Path: <theflamefire89@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1B73C76196
	for <webhook@archiver.kernel.org>; Fri, 24 Mar 2023 17:18:45 +0000 (UTC)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
 by mx.groups.io with SMTP id smtpd.web10.2681.1679678317352753385
 for <cip-dev@lists.cip-project.org>;
 Fri, 24 Mar 2023 10:18:37 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=j8QFHIGn;
 spf=pass (domain: gmail.com, ip: 209.85.221.54, mailfrom: theflamefire89@gmail.com)
Received: by mail-wr1-f54.google.com with SMTP id h17so2531071wrt.8
        for <cip-dev@lists.cip-project.org>; Fri, 24 Mar 2023 10:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679678316;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o2l1eB1PcN679Kcv7LS9Zuc1IPxKvG4ruJNIe6Hy0OA=;
        b=j8QFHIGnF/epo1aoqsHoUy9rebBkB/T0HPFSYlFLqWCTaDskF5aIRI+90f7ywx0YPg
         sIW7DHGZjaoJbIqFck1Y3L1cz5MOkrO6FWaFcLnRo7TJdmnj0GGP7Rb5ak0Y2ZqpRN/1
         y19UArxqWs2pytCPpMGxT7f9x1aaBdSWHRNltOUi310opmapR19jBWGN8PYatTG7DmUu
         u/SqfPbnSWfqy0PEkBczxFGqZZwLwRqErg9ka/e3+oUotgZ/XvyyKVIwWIYA8YwdWesm
         zIOKk7OngjZ793hxfMhh/pJ7kimP0mMztMI9/Yfx4KEoBiZHFDlujCBi9Ow+pyEsdXKp
         qGIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679678316;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o2l1eB1PcN679Kcv7LS9Zuc1IPxKvG4ruJNIe6Hy0OA=;
        b=R+6bvaxEch9kcMdpwYDhdDevj3EgORh1+b5SZ2BcR2b3BtmDIqburGdI7IlSN2A9Tr
         fb9bcsX6RPDmkgfm1iis5DfqmUgA65MQIxpjtYocjGBhqcpjDr9euIQZbLcX9s8Y7u7u
         JvMWV7i5GjTHi2tdqBrEUpIkq6qweWU4OCmAsxPSEU8HeAjxpSwYCXbddkYG8cgAvocV
         sjWH+3phMdIUhlH2JEP8WAhnueqPswe0aLndzmMACeDT4ugGrmBKCUF3xvZWiOeT3KUk
         dhy9LMKDDreivfYo9jr9u/jWOoEOPscx8P/yQL7rw6Jd7SPfYoWI0xpCXA9VbIpzS1Ml
         ng3g==
X-Gm-Message-State: AAQBX9cXwD58s2yX40QQaThnEG23LdmHpxQgaoImrUNp9srymkJCf6T6
	gW4dgARGwD36uMRbDldKkyHXMy1DNUE=
X-Google-Smtp-Source: AKy350ZY9PDhViuEEnBnAiQvc2jp8j/A7mZQbCj4dd8desoDw8HU5Dt8jlKY08kLILPPBkaSGBSY3Q==
X-Received: by 2002:a5d:674e:0:b0:2c7:dad:5630 with SMTP id l14-20020a5d674e000000b002c70dad5630mr2844494wrw.27.1679678315763;
        Fri, 24 Mar 2023 10:18:35 -0700 (PDT)
Received: from alex-Mint.fritz.box (p200300f6af150c00d964c2cc0a52faf5.dip0.t-ipconnect.de. [2003:f6:af15:c00:d964:c2cc:a52:faf5])
        by smtp.googlemail.com with ESMTPSA id k22-20020a05600c1c9600b003eda46d6792sm340662wms.32.2023.03.24.10.18.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 10:18:35 -0700 (PDT)
From: Alexander Grund <theflamefire89@gmail.com>
To: cip-dev@lists.cip-project.org
Cc: uli+cip@fpond.eu
Subject: [PATCH 4.4 1/3] ALSA: control: code refactoring for ELEM_READ/ELEM_WRITE operations
Date: Fri, 24 Mar 2023 18:18:10 +0100
Message-Id: <20230324171812.221086-2-theflamefire89@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230324171812.221086-1-theflamefire89@gmail.com>
References: <20230324171812.221086-1-theflamefire89@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 24 Mar 2023 17:18:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11117

From: Takashi Sakamoto <o-takashi@sakamocchi.jp>

ALSA control core handles ELEM_READ/ELEM_WRITE requests within lock
acquisition of a counting semaphore. The lock is acquired in helper
functions in the end of call path before calling implementations of each
driver.

ioctl(2) with SNDRV_CTL_ELEM_READ
...
->snd_ctl_ioctl()
  ->snd_ctl_elem_read_user()
    ->snd_ctl_elem_read()
      ->down_read(controls_rwsem)
      ->snd_ctl_find_id()
      ->struct snd_kcontrol.get()
      ->up_read(controls_rwsem)

ioctl(2) with SNDRV_CTL_ELEM_WRITE
...
->snd_ctl_ioctl()
  ->snd_ctl_elem_write_user()
    ->snd_ctl_elem_write()
      ->down_read(controls_rwsem)
      ->snd_ctl_find_id()
      ->struct snd_kcontrol.put()
      ->up_read(controls_rwsem)

This commit moves the lock acquisition to middle of the call graph to
simplify the helper functions. As a result:

ioctl(2) with SNDRV_CTL_ELEM_READ
...
->snd_ctl_ioctl()
  ->snd_ctl_elem_read_user()
    ->down_read(controls_rwsem)
    ->snd_ctl_elem_read()
      ->snd_ctl_find_id()
      ->struct snd_kcontrol.get()
    ->up_read(controls_rwsem)

ioctl(2) with SNDRV_CTL_ELEM_WRITE
...
->snd_ctl_ioctl()
  ->snd_ctl_elem_write_user()
    ->down_read(controls_rwsem)
    ->snd_ctl_elem_write()
      ->snd_ctl_find_id()
      ->struct snd_kcontrol.put()
    ->up_read(controls_rwsem)

Change-Id: I6b39209aaf08afcbeca7c759b77bc96c67db4c77
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Signed-off-by: Takashi Iwai <tiwai@suse.de>

Fixes: e8064dec769e6 "ALSA: pcm: Move rwsem lock inside snd_ctl_elem_read to prevent UAF"
Signed-off-by: Alexander Grund <theflamefire89@gmail.com>
---
 sound/core/control.c | 78 +++++++++++++++++++++-----------------------
 1 file changed, 38 insertions(+), 40 deletions(-)

diff --git a/sound/core/control.c b/sound/core/control.c
index 43c8eac250b8a..a042a30d6a728 100644
--- a/sound/core/control.c
+++ b/sound/core/control.c
@@ -877,24 +877,18 @@ static int snd_ctl_elem_read(struct snd_card *card,
 	struct snd_kcontrol *kctl;
 	struct snd_kcontrol_volatile *vd;
 	unsigned int index_offset;
-	int result;
 
-	down_read(&card->controls_rwsem);
 	kctl = snd_ctl_find_id(card, &control->id);
-	if (kctl == NULL) {
-		result = -ENOENT;
-	} else {
-		index_offset = snd_ctl_get_ioff(kctl, &control->id);
-		vd = &kctl->vd[index_offset];
-		if ((vd->access & SNDRV_CTL_ELEM_ACCESS_READ) &&
-		    kctl->get != NULL) {
-			snd_ctl_build_ioff(&control->id, kctl, index_offset);
-			result = kctl->get(kctl, control);
-		} else
-			result = -EPERM;
-	}
-	up_read(&card->controls_rwsem);
-	return result;
+	if (kctl == NULL)
+		return -ENOENT;
+
+	index_offset = snd_ctl_get_ioff(kctl, &control->id);
+	vd = &kctl->vd[index_offset];
+	if (!(vd->access & SNDRV_CTL_ELEM_ACCESS_READ) && kctl->get == NULL)
+		return -EPERM;
+
+	snd_ctl_build_ioff(&control->id, kctl, index_offset);
+	return kctl->get(kctl, control);
 }
 
 static int snd_ctl_elem_read_user(struct snd_card *card,
@@ -909,8 +903,11 @@ static int snd_ctl_elem_read_user(struct snd_card *card,
 
 	snd_power_lock(card);
 	result = snd_power_wait(card, SNDRV_CTL_POWER_D0);
-	if (result >= 0)
+	if (result >= 0) {
+		down_read(&card->controls_rwsem);
 		result = snd_ctl_elem_read(card, control);
+		up_read(&card->controls_rwsem);
+	}
 	snd_power_unlock(card);
 	if (result >= 0)
 		if (copy_to_user(_control, control, sizeof(*control)))
@@ -927,30 +924,28 @@ static int snd_ctl_elem_write(struct snd_card *card, struct snd_ctl_file *file,
 	unsigned int index_offset;
 	int result;
 
-	down_read(&card->controls_rwsem);
 	kctl = snd_ctl_find_id(card, &control->id);
-	if (kctl == NULL) {
-		result = -ENOENT;
-	} else {
-		index_offset = snd_ctl_get_ioff(kctl, &control->id);
-		vd = &kctl->vd[index_offset];
-		if (!(vd->access & SNDRV_CTL_ELEM_ACCESS_WRITE) ||
-		    kctl->put == NULL ||
-		    (file && vd->owner && vd->owner != file)) {
-			result = -EPERM;
-		} else {
-			snd_ctl_build_ioff(&control->id, kctl, index_offset);
-			result = kctl->put(kctl, control);
-		}
-		if (result > 0) {
-			struct snd_ctl_elem_id id = control->id;
-			up_read(&card->controls_rwsem);
-			snd_ctl_notify(card, SNDRV_CTL_EVENT_MASK_VALUE, &id);
-			return 0;
-		}
+	if (kctl == NULL)
+		return -ENOENT;
+
+	index_offset = snd_ctl_get_ioff(kctl, &control->id);
+	vd = &kctl->vd[index_offset];
+	if (!(vd->access & SNDRV_CTL_ELEM_ACCESS_WRITE) || kctl->put == NULL ||
+	    (file && vd->owner && vd->owner != file)) {
+		return -EPERM;
 	}
-	up_read(&card->controls_rwsem);
-	return result;
+
+	snd_ctl_build_ioff(&control->id, kctl, index_offset);
+	result = kctl->put(kctl, control);
+	if (result < 0)
+		return result;
+
+	if (result > 0) {
+		struct snd_ctl_elem_id id = control->id;
+		snd_ctl_notify(card, SNDRV_CTL_EVENT_MASK_VALUE, &id);
+	}
+
+	return 0;
 }
 
 static int snd_ctl_elem_write_user(struct snd_ctl_file *file,
@@ -967,8 +962,11 @@ static int snd_ctl_elem_write_user(struct snd_ctl_file *file,
 	card = file->card;
 	snd_power_lock(card);
 	result = snd_power_wait(card, SNDRV_CTL_POWER_D0);
-	if (result >= 0)
+	if (result >= 0) {
+		down_read(&card->controls_rwsem);
 		result = snd_ctl_elem_write(card, file, control);
+		up_read(&card->controls_rwsem);
+	}
 	snd_power_unlock(card);
 	if (result >= 0)
 		if (copy_to_user(_control, control, sizeof(*control)))
-- 
2.40.0


