Return-Path: <arisu.tachibana@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 404A8C05023
	for <webhook@archiver.kernel.org>; Thu, 18 Apr 2024 06:05:01 +0000 (UTC)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
 by mx.groups.io with SMTP id smtpd.web10.6329.1713420296279263860
 for <cip-dev@lists.cip-project.org>;
 Wed, 17 Apr 2024 23:04:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20230601.gappssmtp.com header.s=20230601 header.b=B1xn07VJ;
 spf=pass (domain: miraclelinux.com, ip: 209.85.208.171, mailfrom: arisu.tachibana@miraclelinux.com)
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2db6f5977e1so6567341fa.2
        for <cip-dev@lists.cip-project.org>; Wed, 17 Apr 2024 23:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20230601.gappssmtp.com; s=20230601; t=1713420294; x=1714025094; darn=lists.cip-project.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Ah7IZjU1NIkjkJ/3bSBfPe6X+g5STjodG1biY7bTIF4=;
        b=B1xn07VJEYFI5A1JcrLusvohLO494SHaQqqE8ABm4TTYe20zystqSROcfBxZvR0v1e
         WRh5qp2zdRkUWUFztvN/2q9WQBpnxhfw6uMgepogWtSGghExPUJJyYbZEPmK4cxQ2da4
         uIiwzs46U//M7I+iTgleaC/BOTzdFQB0RbzXKjDz7twC7QEXADIkY4T+f58Xq7J2tpZi
         2TAB84uh4qeIIsvglWK918ZDr0mAWePFypO7d9YhDXmCLF+Ip7kNzsV8wo5lFPHHTzDZ
         RkMpezTuSJ4dcUHYIKgUaI+MKaBsiInRS34t104fUYZs9sTeanBaFE1b0N9gwjxx/26v
         l0AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713420294; x=1714025094;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ah7IZjU1NIkjkJ/3bSBfPe6X+g5STjodG1biY7bTIF4=;
        b=Og3b+TIhyxOYi2Vz4EvFlWNIR8hVG9Vdlgl8vVeIKLOI9RPGl698Q4/k5SU9QInUYT
         5zyyXiAZnjShFNTTTKg4ZPJ16tpnSkPnWgAg4ZY1WsSW708ZafUzaE/lyrQ9xP3GDqBE
         ye38MeXGZplgGRwBHAYARd2B3mzYmYDu8G3/GAVjj6AHjz5knd5oUpVjSFSBifOq9KFw
         /YflyTtX9cQplWEqKEHBbKNarXCDx2Rte1y6EXabn+zEIq5PBwKhigSer2SrEWkkcZcP
         jWHfbSXb4oXqoMZByCqGhmDimpMQgd0Zf62t1+aG7bqKOxqruz76SfMAqXRnmtlcTHwN
         RbvQ==
X-Gm-Message-State: AOJu0YzaUkC+mPOcttXc6fUw6yqwCZlDukPUbVzoNM2oSGZ2LN48QImq
	FoHj8bVPFxllXk7g/KP2I1wzfqcfC6Zhs8SgobSeXvTS9rwbyVcx6PCF8TqB42xlDmkzulpiZnF
	CvGVM4OiFOEVJxwocI5OfF3ERw9Gj3bD6lq9VTPMEcTBFUxYnXg==
X-Google-Smtp-Source: AGHT+IGow917LmQZL3Ajyu+/8T1IodeTgJeFTrIVkuUxfoUIWE/1IxmlvPfaotphECAODil7UzCSKsP81dKFxfrhBS0=
X-Received: by 2002:a2e:a483:0:b0:2d8:5cc7:fa97 with SMTP id
 h3-20020a2ea483000000b002d85cc7fa97mr710532lji.26.1713420293881; Wed, 17 Apr
 2024 23:04:53 -0700 (PDT)
MIME-Version: 1.0
From: Arisu Tachibana <arisu.tachibana@miraclelinux.com>
Date: Thu, 18 Apr 2024 15:04:17 +0900
Message-ID: <CANgtXuNCHPcxu1p9NTs=-8n_Gb3B6i2PEn_3od92c4wQgt+pGg@mail.gmail.com>
Subject: IRC meeting
To: cip-dev@lists.cip-project.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 18 Apr 2024 06:05:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15575

Hello

for personal reasons,
I cannot attend today IRC meeting.

Thanks,
Arisu

