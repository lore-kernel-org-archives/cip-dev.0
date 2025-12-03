Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2B18D1CDA5
	for <webhook@archiver.kernel.org>; Wed,  3 Dec 2025 22:26:50 +0000 (UTC)
Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.28676.1764800803887034063
 for <cip-dev@lists.cip-project.org>;
 Wed, 03 Dec 2025 14:26:44 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20230601.gappssmtp.com header.s=20230601 header.b=CsQ3ZmfW;
 spf=pass (domain: miraclelinux.com, ip: 74.125.224.52, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-640daf41b19so578969d50.0
        for <cip-dev@lists.cip-project.org>; Wed, 03 Dec 2025 14:26:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20230601.gappssmtp.com; s=20230601; t=1764800803; x=1765405603; darn=lists.cip-project.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5rVGy9k/X24dckifr9lCaCLJrwTmFsNsXiXbHmc5ozY=;
        b=CsQ3ZmfWBN1iVAi+sEt+Z1wcMjvysejNBkh9A7hnvIbv6vYLnPGL17AZ28SPQCmHLH
         oNIkI8+e9OjDEjF2pEE09wMHTV/cGCwTbqnJvwOIC9xcDP7lfQubp5sMehuCwX6O7yzq
         spv8wqud7Ptq3MgP4nW1afMLqksn3Cr9p45KPbKD56rAN6wuAl9tP4TZe/uA3c1e1O8P
         KMDcxE2/qdni7HxP+R9ssUIdQTLr7hkjuFatD6kniAqahyy+nGZkWBTTozli7aqVf7ge
         Gu97V4qHopv+p7KErlJP4oNQ5LLTVkexH9t/zmaYwLT4iQViMyQlQt9YSVT7zDDZF/Oz
         2iTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764800803; x=1765405603;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5rVGy9k/X24dckifr9lCaCLJrwTmFsNsXiXbHmc5ozY=;
        b=wxvrLVTd2om7iZbMBG+1lMj1i4Ye1DbZYWRhfCB0iceflk6CKhoZMlcWTwxURrJ7g+
         V5yu04eAmg1WypoMUgewQyqh/lGKnr2zcx7qTRKK82mONCxb7IcdwbCK8NCl6SfnQE00
         iZ5t279aJ0pPFjP6VoP4QkY8ucX9haB0r2kjg6rJ7y63KjixytJpa+zVdKZR82ksrnIk
         TrsvlMWMR0dEiEQKW2cpCMneKwR77Fd86OhVNGuX9dC1ai+9ZV6k/l0AICt8X3r0fqZz
         x0zxre/RlPo5zwti1v5i8ppPBdlFAOhh9yb0QnTzR5DdWavzkoBkRr1+A2rOg3H2ZsXi
         uzuQ==
X-Gm-Message-State: AOJu0YyvAdq67iWCa2fnduUb9QjPtuaK4ltSJlwoabmMHpmyWDQXz/YR
	qLF7yO4LQ3diXZDhvYe40S6zo2tOGVnCD7ZSDsGcod/0Va+STXpi3MeOlndj1uiSoQiA80vL8UO
	0dXqRGuuPRgVbHTKYzMfVkDknUrQnBhnX3hXWRwhCuEKF3SR5vDGFgPY=
X-Gm-Gg: ASbGncsKqWK3YHqJ4mieTOyufdIOJwr0UI3g4c8Yu6Mt/7grLXWiPxqlG6zp7wEvmaA
	XEzKsLmUJPcILdMO/rLdBElrHenzQNVxbiOIhYvmTDnTIEWFu1/2m8voIXUbIdYVEM6xD9cFVxK
	FmdPI5fTlpncr1sJdNDjlTNwgOWqn6Iis7ejVpTqg+76vo2SJAspQVeV+P/vIVxCBox85qvqiIv
	+ODBFQM119CeYLnLJi4e14m2tQX1A==
X-Google-Smtp-Source: AGHT+IGp+d5/5wz9EToDwsAs/sZclicv/3NwWlUaKwP8eiCjiuP/3xnrNPYJW837KWIxXj/+vx2XUyD54y5qXOV5L3U=
X-Received: by 2002:a05:690e:4141:b0:640:d1cc:2be7 with SMTP id
 956f58d0204a3-6443d747c84mr859499d50.30.1764800802673; Wed, 03 Dec 2025
 14:26:42 -0800 (PST)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 4 Dec 2025 07:26:06 +0900
X-Gm-Features: AWmQ_bn0a3c8PlCbnz9sJEKDmhcoOOShLHZhiml7t1j0NfKqFUyXzx0yU3jJVBc
Message-ID: <CAODzB9oSpw+SSGjG6dpJ_JqOXk4Y_xBJKOHghkDc9VgiErcUTw@mail.gmail.com>
Subject: [kernel-cve-report] New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 03 Dec 2025 22:26:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20838

Hi!

It's this week's CVE report.

This week reported 0 new CVEs and 2 updated CVEs.

* New CVEs

No new CVE.

* Updated CVEs

CVE-2025-38627: f2fs: compress: fix UAF of f2fs_inode_info in f2fs_free_dic

stable/6.6 was fixed.

Fixed status
stable/6.6: [5d604d40cd3232b09cb339941ef958e49283ed0a]

CVE-2025-38643: wifi: cfg80211: Add missing lock in cfg80211_check_and_end_cac()

stable/6.6 was fixed.

Fixed status
stable/6.6: [b3d24038eb775f2f7a1dfef58d8e1dc444a12820]


Regards,
-- 
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
          :masami.ichikawa@miraclelinux.com

