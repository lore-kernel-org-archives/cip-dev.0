Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E99EC77B7C
	for <webhook@archiver.kernel.org>; Wed, 25 Jun 2025 22:41:24 +0000 (UTC)
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
 by mx.groups.io with SMTP id smtpd.web11.29155.1750891274648291605
 for <cip-dev@lists.cip-project.org>;
 Wed, 25 Jun 2025 15:41:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20230601.gappssmtp.com header.s=20230601 header.b=2rQ9sfNj;
 spf=pass (domain: miraclelinux.com, ip: 209.85.128.177, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-710f39f5cb9so4396307b3.3
        for <cip-dev@lists.cip-project.org>; Wed, 25 Jun 2025 15:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20230601.gappssmtp.com; s=20230601; t=1750891273; x=1751496073; darn=lists.cip-project.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1aazd1ktuaPHm01kZTDbLgy2I0FQ3to3JmxgDL1Wpj0=;
        b=2rQ9sfNjt4BxjrGm9QN2bmxeMZfkW3tGpNe95tSvInmEElcwjVkQL2J9dK/K1yFQJ1
         zohrBS5faiuxG+fhhujTEGPStuXbWvIZEGKN2kp5vPZcMWz2oP4tXK1srJ/KpKPbp44w
         rQ1Jr0TJHTSzVcVM1np2ggbqRrjvmZdbheNcMgy9g7ERWmMOxF60ZNDDprMGFcamrn27
         wc/ofSFt9NQhRXucdM5Rb2tVq7Z2yJ8DCy5wxQOLIWNx0YuPvEC9vf5+MuPcpf2tNTRF
         7GLrHkpgXQq33U9jHE+AtVjA8sKfOylMzvcCgjOO8Emka2eVEm5kJuisSrmC7hKQM2j0
         iA9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750891273; x=1751496073;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1aazd1ktuaPHm01kZTDbLgy2I0FQ3to3JmxgDL1Wpj0=;
        b=iBuRyLXfUbfIqKfyHWnLi+wQRQtmjn2UFRlB08JguMaWjiNN/17YPb/OoFkh0IhopR
         QOGerMWa1KRebwae10IfEUI2rRcikOyUOpkN8JaSfw9RECr8iqq7dHhNXvY/vLvveKbT
         jFUtSMTi+u+ZX5L2TH2g4kWnI6qhOCtej3U9mHvYl28HCDT/AsyAWAYfIK4XPhlD3dX0
         kvyRZQWCmCum4L4hRPs0SVPuDGGstPMYvKmM5pyQovEgpc1TQ5Nx0TC3hSbiInwlOMGK
         U1Cu97m9hL7IvCay9Um/7DcDeLD3dlk/c6VQ7/qeLdZ6Mu5QOHiFmSNJ3LLsxYSyK88z
         VlYQ==
X-Gm-Message-State: AOJu0YwWkcCxda/IZhm2p+0mzxpFTupwZ6MLvLfruWLwQmA+oviZO1JF
	bi5jN9TohGMzJbjOhjakmsSh6MdamHS7UWWlE88fbbokdV4PnF5L7nvHGFOi42QR/s6l4msSccb
	EP5nN4dkLzLa5QGI6VDUfH3bdZtd40fa+fEGDNPEY7f0cZmkpMgZDYCI=
X-Gm-Gg: ASbGncuMtJAGRVO8mc6fo2xvCrQBXJ5YmguTIiSFj4VNPVswfdcWvojE5Te/QnZXRw2
	JvEuW4TCx/EIwBSjIKwTbjPn6chSs7DT3ehOIydiORuwRg+9LTKpN63quD8P1u1XvCr0uYNW9NB
	yyh/S/ZnNnJ4imIZq7BgMuYVn6Ktko+L6jdvkdisyvSVU3m9qjJyMmh/A=
X-Google-Smtp-Source: AGHT+IFZjzAsNR5+zC2tTab+sY2Ctq4r8TInab1zle22B7xlJ8nj8wB337oKv6+oR8xO1LOT0Xcggc+WWr7tc+XsLBE=
X-Received: by 2002:a05:690c:a0a4:10b0:70e:17da:dccc with SMTP id
 00721157ae682-7150864e752mr21652817b3.16.1750891273616; Wed, 25 Jun 2025
 15:41:13 -0700 (PDT)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 26 Jun 2025 07:40:37 +0900
X-Gm-Features: Ac12FXwzW8cznfTg4OjvZa7_qLDu3E7E0AeC087X81Apv0C1qA0bC0Tu641KSAE
Message-ID: <CAODzB9p+928ugyvOsFGo-9xRqi86MkCQZ=UxphUAXyZ6+R35Dw@mail.gmail.com>
Subject: [kernel-cve-report] New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 25 Jun 2025 22:41:24 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19234

Hi!

It's this week's CVE report.

This week reported 1 new CVEs and 0 updated CVEs.

* New CVEs

CVE-2025-38083: net_sched: prio: fix a race in prio_tune()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38083

Introduced by commit 7b8e0b6 ("net: sched: prio: delay destroying
child qdiscs on change") in v5.0-rc1.
Fixed in v6.16-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d35acc1be3480505b5931f17e4ea9b7617fea4d3]
stable/6.12: [e3f6745006dc9423d2b065b90f191cfa11b1b584]
stable/6.6: [46c15c9d0f65c9ba857d63f53264f4b17e8a715f]

* Updated CVEs

No updated CVEs.

Regards,
-- 
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
          :masami.ichikawa@miraclelinux.com

