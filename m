Return-Path: <theflamefire89@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09DA9C74A5B
	for <webhook@archiver.kernel.org>; Thu, 23 Mar 2023 19:31:12 +0000 (UTC)
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
 by mx.groups.io with SMTP id smtpd.web11.82703.1679599865971476227
 for <cip-dev@lists.cip-project.org>;
 Thu, 23 Mar 2023 12:31:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=dNIko4YS;
 spf=pass (domain: gmail.com, ip: 209.85.215.171, mailfrom: theflamefire89@gmail.com)
Received: by mail-pg1-f171.google.com with SMTP id x37so13226215pga.1
        for <cip-dev@lists.cip-project.org>; Thu, 23 Mar 2023 12:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679599865;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SGGUP66K1KV+FHjsn5qlN49/pkRCncbVQZDsDyYvwJ8=;
        b=dNIko4YSGK9vQMaHc/5MV9Nn6w1/4tAqnl3SxWok3D6M3qfjhVZd8tOIC4u94k4AmB
         Aor2jItLFanpxuC4ZSdM/m8q47cttqRScySMbZTcz4kyZRhBTJYXfO42jiQ9VX1B3b30
         1/quSl7K6hg3+TOZTvXfRMXHi43gutrz+RjH/VBdiQJOLllXFM+BDNC6/pUHJKMHI6ft
         FdtGVxGTvTiMqw0dGDQ25RN6yKlKVTaq6i6VL8rSBq+51i2euRs+KAQJ/GRs3Yr5v1wF
         4zh0gVkUmo2aBAHkJwQ3+Z3Riqz3C57e0S2443Ej07+Q+0R1YPMfek6tfTMETvKkSC18
         rZgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679599865;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SGGUP66K1KV+FHjsn5qlN49/pkRCncbVQZDsDyYvwJ8=;
        b=MXuNHrnlcXXYhydBRrp28ZreOV8wx8guGmqgXSFldjGNXRPY5E7olByY7B0q6Oxkzo
         pELjphmeaybKQZ5byXMxLtMift3s59ptbnCMXJb+aMav8Ll6Rms7XTXowDjJqTRUt69Q
         KDWpmOjWy7t2rBokOf1tbTiW+nP+Qe5x4aLog+Tsh7fhfhGKf46nE+oqpz55+6Fws7jo
         GEOQ/OPheQ2hsV+qVNM0UNtCL1CBHGaCYQ4QKXgAdRRHrEmjFCMeUTMjTBiSNTl7aEf6
         lPzZo2q6zEnig8MuSLhotBZ2L07DNxqUKVbc5FDttRAJPK4NgqE8/gQf/dehSie65Hli
         9Fig==
X-Gm-Message-State: AO0yUKVR7s1pCY2eFWf9EMSxddu7n0i/6ESYCVRUc4ciSvRMVRyVfTik
	pv50v/FCEqb9bLW5EAE+M3Jo1oybpoZbtgdo3F1/eKRtoTo=
X-Google-Smtp-Source: AK7set96b5dGg49y5hGDV5eXUHPF9IaKM4j21xPof247BSfRDFdvxQ+b1W1dSXJWbjwvNIsdfG4nWCUzeaFfstbFsCY=
X-Received: by 2002:a65:420c:0:b0:50a:592b:25ba with SMTP id
 c12-20020a65420c000000b0050a592b25bamr2243237pgq.3.1679599865280; Thu, 23 Mar
 2023 12:31:05 -0700 (PDT)
MIME-Version: 1.0
From: Alexander Grund <theflamefire89@gmail.com>
Date: Thu, 23 Mar 2023 20:30:54 +0100
Message-ID: <CAJr5db__37kx6LZ3bHv6L5LRzV3Nzii_jHO6VGk4a7207z4jVg@mail.gmail.com>
Subject: ALSA: pcm: Broken commit in v4.4-st38
To: cip-dev@lists.cip-project.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 23 Mar 2023 19:31:12 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11103

Hi,
I found a bug in v4.4-st38 caused by
e8064dec769e6e0822e179107d0b5b3d2e03e181 "ALSA: pcm: Move rwsem lock
inside snd_ctl_elem_read to prevent UAF"

1) It introduces down_read/up_read around a call to snd_ctl_elem_read
however that is superflous: snd_ctl_elem_read already does that, so
the commit 56b88b50565c referenced by the above is already included
2) down_write/up_write around snd_ctl_elem_write causes a deadlock
because snd_ctl_elem_write does a down_read at the start. The latter
is probably (another) bug likely caused by missing upstream commit
becf9e5d553c2389d857a3c178ce80fdb34a02e1 "ALSA: control: code
refactoring for ELEM_READ/ELEM_WRITE operations " which removes that
lock. Maybe that should be included here too, it also removes the
locking in snd_ctl_elem_read which means 1) is no longer superflous

Best,
Alexander Grund

