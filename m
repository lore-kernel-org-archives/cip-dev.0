Return-Path: <theflamefire89@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2A82C76195
	for <webhook@archiver.kernel.org>; Fri, 24 Mar 2023 17:18:45 +0000 (UTC)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
 by mx.groups.io with SMTP id smtpd.web10.2683.1679678319157811799
 for <cip-dev@lists.cip-project.org>;
 Fri, 24 Mar 2023 10:18:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=kWERMfaH;
 spf=pass (domain: gmail.com, ip: 209.85.128.48, mailfrom: theflamefire89@gmail.com)
Received: by mail-wm1-f48.google.com with SMTP id bg16-20020a05600c3c9000b003eb34e21bdfso3642253wmb.0
        for <cip-dev@lists.cip-project.org>; Fri, 24 Mar 2023 10:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679678317;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vvJBQTcO1qDmdJsJeQoY7Ecsv4DcspIdbB4amlE6qcU=;
        b=kWERMfaHrc+XcIzlqMwTFAJh5qq+8+Atg9mOnYD+TYLnzznOtgINWvWlUmkTw2VfM/
         M6L8f8xYIpkYNE1Mox0ExfcZ+foJ5QkKRWEQSYGHf4iK7RLtEz6e7HDfd7qcqNpWSkf7
         1w2VJ9aYjS5DPqguBljtfD3d5LNE6tSwo9W2UEGIidy0lIfGtLZQQFPA+UV3QX+a0ars
         OO0z3F7S4ubYhoXdq+TOaxO9bLg5OVkTLxeuz8mIaai9LjltImYfcbwE+BODajgaJTk7
         4K2ZeOECytWTqQv1VaVoWbMntYaX+3Qe8+k50w3w+ZxA161/tFXrQcS1RtU6gWtgRWse
         n/QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679678317;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vvJBQTcO1qDmdJsJeQoY7Ecsv4DcspIdbB4amlE6qcU=;
        b=L5nQhcRl4gXKlzSsi3OYS8RMiYDOc81wpnROeQJCVyB0L+Bc5uxLN6uZ8rNVa7dGzO
         b3a4ZxFaSUFhkAAdIZ8IUT6cM79zDLpnIdoy14VvqZfTfrhNdsjFplwhRrdUsDCkLzaw
         9dZnR1rvHw4H7bjFQqztnop4yanogGi4X2VfPdYcR3VInLQvzeba4rXAUiN27GCLMXLE
         sEiUtOI3rUioyIv2e1sE7+fRFtGA4o1jSaDv907C2HQwrpkhIdfdp1sjU0KTWzPAxgxF
         aChZ3eWWkqiL9GD7pcYHGzoHeCEG1nsoe0F0ilNYenE4oZ7KS5ALWfINY3yjZyBkhFzX
         Qxrw==
X-Gm-Message-State: AO0yUKVQ4i26uNtJYq+bFU1hC6oR/Xj+y/aIL6KZBcQ4Wn+KqyyLD2G7
	m+6ybssLLV6ezZUghuWqpBCh3z9j7To=
X-Google-Smtp-Source: AK7set9gnHvejJwb1oQEo6F8SCBILMaFszPCQE6WTtj5IKWik5OCP9qS8jimVSf/AAkuP4AgAR4eMA==
X-Received: by 2002:a1c:ed0e:0:b0:3dc:55d9:ec8 with SMTP id l14-20020a1ced0e000000b003dc55d90ec8mr2864895wmh.41.1679678317581;
        Fri, 24 Mar 2023 10:18:37 -0700 (PDT)
Received: from alex-Mint.fritz.box (p200300f6af150c00d964c2cc0a52faf5.dip0.t-ipconnect.de. [2003:f6:af15:c00:d964:c2cc:a52:faf5])
        by smtp.googlemail.com with ESMTPSA id k22-20020a05600c1c9600b003eda46d6792sm340662wms.32.2023.03.24.10.18.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 10:18:37 -0700 (PDT)
From: Alexander Grund <theflamefire89@gmail.com>
To: cip-dev@lists.cip-project.org
Cc: uli+cip@fpond.eu
Subject: [PATCH 4.4 2/3] ALSA: control: Fix memory corruption risk in snd_ctl_elem_read
Date: Fri, 24 Mar 2023 18:18:11 +0100
Message-Id: <20230324171812.221086-3-theflamefire89@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230324171812.221086-1-theflamefire89@gmail.com>
References: <20230324171812.221086-1-theflamefire89@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 24 Mar 2023 17:18:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11118

From: Richard Fitzgerald <rf@opensource.cirrus.com>

commit 5a23699a39abc5328921a81b89383d088f6ba9cc upstream.

The patch "ALSA: control: code refactoring for ELEM_READ/ELEM_WRITE
operations" introduced a potential for kernel memory corruption due
to an incorrect if statement allowing non-readable controls to fall
through and call the get function. For TLV controls a driver can omit
SNDRV_CTL_ELEM_ACCESS_READ to ensure that only the TLV get function
can be called. Instead the normal get() can be invoked unexpectedly
and as the driver expects that this will only be called for controls
<= 512 bytes, potentially try to copy >512 bytes into the 512 byte
return array, so corrupting kernel memory.

The problem is an attempt to refactor the snd_ctl_elem_read function
to invert the logic so that it conditionally aborted if the control
is unreadable instead of conditionally executing. But the if statement
wasn't inverted correctly.

The correct inversion of

    if (a && !b)

is
    if (!a || b)

Fixes: becf9e5d553c2 ("ALSA: control: code refactoring for ELEM_READ/ELEM_WRITE operations")
Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Signed-off-by: Alexander Grund <theflamefire89@gmail.com>
---
 sound/core/control.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/core/control.c b/sound/core/control.c
index a042a30d6a728..3ca81e85a1492 100644
--- a/sound/core/control.c
+++ b/sound/core/control.c
@@ -884,7 +884,7 @@ static int snd_ctl_elem_read(struct snd_card *card,
 
 	index_offset = snd_ctl_get_ioff(kctl, &control->id);
 	vd = &kctl->vd[index_offset];
-	if (!(vd->access & SNDRV_CTL_ELEM_ACCESS_READ) && kctl->get == NULL)
+	if (!(vd->access & SNDRV_CTL_ELEM_ACCESS_READ) || kctl->get == NULL)
 		return -EPERM;
 
 	snd_ctl_build_ioff(&control->id, kctl, index_offset);
-- 
2.40.0


