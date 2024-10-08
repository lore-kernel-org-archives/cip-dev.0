Return-Path: <arisu.tachibana@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D3D4CEF151
	for <webhook@archiver.kernel.org>; Tue,  8 Oct 2024 10:55:01 +0000 (UTC)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
 by mx.groups.io with SMTP id smtpd.web11.6282.1728384895623030629
 for <cip-dev@lists.cip-project.org>;
 Tue, 08 Oct 2024 03:54:56 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20230601.gappssmtp.com header.s=20230601 header.b=m7CwpjXL;
 spf=pass (domain: miraclelinux.com, ip: 209.85.167.41, mailfrom: arisu.tachibana@miraclelinux.com)
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5399675e14cso6275254e87.3
        for <cip-dev@lists.cip-project.org>; Tue, 08 Oct 2024 03:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20230601.gappssmtp.com; s=20230601; t=1728384894; x=1728989694; darn=lists.cip-project.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mTpuMcj1G9PY4sFAYTzrdAz7SUOwBAGo2I4WbOykLmg=;
        b=m7CwpjXLIimQR6DtQPQ5L9IcfVszU3FGd1pxVxmyzWt9VpD+glHhgy5Y6GXRPTgIar
         5risS+QFtCrCiGYpCnTDV4NgCsby9W8sAOa3ZOWzh4NeaoLIF4ky0a8es1vqdN1ReaMr
         DcbbYWWmB5zRHLMFuF57BVnOYmALK0mY14lp29Ci9tuyTa9zQ8koqgiRhK6a06zFSxOt
         iFnIt89qU6ZTGrTHlCviWpnD9RFlcawdJYvvF/ngd04sTA2RHsbqXGNwNZfdgm0dbGxN
         SttV1HMi5yPyV+/P6H4ASNMIfq/oIEnHjvkzQlOyJsg0xDCPDJD0tR5rVNOcR8Vi55T6
         ubHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728384894; x=1728989694;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mTpuMcj1G9PY4sFAYTzrdAz7SUOwBAGo2I4WbOykLmg=;
        b=p9Xv0F/ZDu0wlVpYrXBtSA8XgTpS7inJbNTPtvzGaU0OXPz3RPBmunqb0LKlKDaJdy
         lj1Je/zwmHXZ85TeyyxOMzusUdtbu7PMlLaIQmCHKT7uxqspjGTK2T8qWfJBZel9tCyl
         Opx49OswjDZGIlCaKywG6d52pjiFEIK/q3fjTtGbc0tq3sknHlFpM3uV4oUzL6tqz+T0
         V1bB48Q7N3FIXL9ue4xFabVE88icdt7BZEv7Fq2iJDsA4o/puTsAwr0MfXJx8oT0iczQ
         Nc4P4XvaxvsQegp438Xo+lc6tHjxNbeQR4Ob7m6tBRcXg6SQ/QSoXrmYNaZ+85P2LRGz
         aAZQ==
X-Gm-Message-State: AOJu0Yzvo9GK5rZaH6W9Poxrwl4fa3tUPqrSg6VEgkDP9CVf0LDhrXpO
	pnyg8Zk7lt2Y+hKzU0FcDbcaY4HQ3MvR/I34myOop/UWHEWmda3jV1wKjnKcwPkR46iNg/dasmB
	rBAVSd/jMs/+GCCt0YXh7LYGGcaCSp5exET6tBOT7IzJo4kq8xA==
X-Google-Smtp-Source: AGHT+IFSBHxLsjdo+ZnQMMVigN+u+1q41ynlpgmEFWtUDcY2LgPpHFWVEpCJ+NuwYzJRyBHSnd3cI6k4RouIhMA1RcU=
X-Received: by 2002:a05:6512:12d1:b0:539:8d9b:b624 with SMTP id
 2adb3069b0e04-539ab9e6eebmr8270579e87.55.1728384893159; Tue, 08 Oct 2024
 03:54:53 -0700 (PDT)
MIME-Version: 1.0
From: Arisu Tachibana <arisu.tachibana@miraclelinux.com>
Date: Tue, 8 Oct 2024 19:54:16 +0900
Message-ID: <CANgtXuOSpY9y9eJJEshNh8kJt-fR2phy1C+P88mZENgaZ-Kcjw@mail.gmail.com>
Subject: IRC meeting
To: cip-dev@lists.cip-project.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 08 Oct 2024 10:55:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17016

Hello

for personal reasons,
I will not attend next IRC meeting.

Thanks,
Arisu

