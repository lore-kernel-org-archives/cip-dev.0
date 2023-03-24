Return-Path: <theflamefire89@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01989C6FD20
	for <webhook@archiver.kernel.org>; Fri, 24 Mar 2023 17:18:36 +0000 (UTC)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
 by mx.groups.io with SMTP id smtpd.web10.2677.1679678311312449049
 for <cip-dev@lists.cip-project.org>;
 Fri, 24 Mar 2023 10:18:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=lKI/NY+Y;
 spf=pass (domain: gmail.com, ip: 209.85.221.50, mailfrom: theflamefire89@gmail.com)
Received: by mail-wr1-f50.google.com with SMTP id l27so2557255wrb.2
        for <cip-dev@lists.cip-project.org>; Fri, 24 Mar 2023 10:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679678310;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KiL/nkcgYQctU4eoYckQ02ZdcgsEqIcmTN6DNpbHCrQ=;
        b=lKI/NY+YYrjx3pYzhTPl7e39ERnxNWC2jjihgg+t9NChSHJij7o+mBizHIsy4yuEMK
         5kBfBDm3SxnklYGPywh/fl0XsKR7JwyLQ6j1aJKJS69WMBPztYQmUueWVne1FjSe9EuZ
         HDSQI2r+uJ15ad7VT/VKvQFO0tAFLD7Fz1m7w00j5vIxDcuNarQE/TrXmVfeZ1Ig1PSa
         qOQxe82pt2Q6ngM5NJoIl5DW6KJmwCcnNsqnrRcWdDX0O95FKucCuTPRaOdCCTlVhy1k
         5/i+pTdzAhuMvcOIFobXtSLKCGUJZDl3lbxNRlGB4mZplROgpqCIUzqeZRvlRosZUjeP
         Gtfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679678310;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KiL/nkcgYQctU4eoYckQ02ZdcgsEqIcmTN6DNpbHCrQ=;
        b=o0tZJsTC0wPZp/0Yaeh0sIHKUsWG/UW33KgAqDa3hdaJYWaoAsTQHxe4RP0tQ44Xvc
         u+jWTnf/vaaixeCD7hl57goEnu2ywdzDcNeEDpDDI8FaKUA6ZctzKQf2nxBpeLi9OIgd
         kbw9mOxCJj91NaTB/LevP989VKxCzWhXPQNVwQl0LHjHQd9AcFSoReG1xJQ5yslAV30q
         HCiZQIGcJBE5XTo21vXk4k3BhdZv806iB2Y5iHdbFj/pEKOcDkd7jj2SMcVoMCwKxjvq
         B02HmANUNMs+AMTqpF4rq3KX+5aj2SqyrXjVQ9NNQjUrwaacoX7GtoAwkzAeOQ57yGs0
         gMbg==
X-Gm-Message-State: AAQBX9fPmSt8kXUXbyiBiSfK4pNm7mT3iFb1Fs0PQnpl3a8yT/t/9hFf
	fd8NYLjREP2ua6X4dvOV9pqYn0PswXs=
X-Google-Smtp-Source: AKy350YH+5l0r0N52pnxcR9wqRQdN8bTaNvMHIF0HvpyEPPvKDMaPoh7eKkO3QfKreLApuWAjtcIbA==
X-Received: by 2002:a5d:6290:0:b0:2da:53e3:57cf with SMTP id k16-20020a5d6290000000b002da53e357cfmr2949253wru.71.1679678309675;
        Fri, 24 Mar 2023 10:18:29 -0700 (PDT)
Received: from alex-Mint.fritz.box (p200300f6af150c00d964c2cc0a52faf5.dip0.t-ipconnect.de. [2003:f6:af15:c00:d964:c2cc:a52:faf5])
        by smtp.googlemail.com with ESMTPSA id k22-20020a05600c1c9600b003eda46d6792sm340662wms.32.2023.03.24.10.18.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 10:18:29 -0700 (PDT)
From: Alexander Grund <theflamefire89@gmail.com>
To: cip-dev@lists.cip-project.org
Cc: uli+cip@fpond.eu
Subject: [PATCH 4.4 0/3] ALSA: control: Fix locking around snd_ctl_elem_read/write
Date: Fri, 24 Mar 2023 18:18:09 +0100
Message-Id: <20230324171812.221086-1-theflamefire89@gmail.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 24 Mar 2023 17:18:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11116

I found a bug in v4.4-st38 caused by e8064dec769e6 "ALSA: pcm: Move rwsem lock inside snd_ctl_elem_read to prevent UAF"
The most serious part is a `down_write` call before calling `snd_ctl_elem_write` which will do a `down_read` on the same mutex causing a deadlock.
I fix this by taking missing commits from 4.14.y, especially "ALSA: control: code refactoring for ELEM_READ/ELEM_WRITE operations"
which moves the locking out of those 2 functions such that the bug fixed
by the above commit is actually introduced so that it can be fixed
avoiding the deadlock.
This also requires a follow-up commit to fix a bug introduced in a
condition by that commit.
The final commit replaces `down_read` by `down_write` in `snd_ctl_elem_write_user`
similar to what e8064dec769e6 does in control_compat.c so that this use
is uniform (and correct).


Richard Fitzgerald (1):
  ALSA: control: Fix memory corruption risk in snd_ctl_elem_read

Takashi Sakamoto (2):
  ALSA: control: code refactoring for ELEM_READ/ELEM_WRITE operations
  ALSA: control: use counting semaphore as write lock for ELEM_WRITE
    operation

 sound/core/control.c | 78 +++++++++++++++++++++-----------------------
 1 file changed, 38 insertions(+), 40 deletions(-)

-- 
2.40.0


