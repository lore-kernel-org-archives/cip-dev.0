Return-Path: <stephenecker240@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5863EC02180
	for <webhook@archiver.kernel.org>; Wed, 15 Jan 2025 17:50:35 +0000 (UTC)
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
 by mx.groups.io with SMTP id smtpd.web10.28082.1736963427731858774
 for <cip-dev@lists.cip-project.org>;
 Wed, 15 Jan 2025 09:50:27 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=VH+ASWRj;
 spf=pass (domain: gmail.com, ip: 209.85.160.50, mailfrom: stephenecker240@gmail.com)
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-2adc2b6837eso24086fac.1
        for <cip-dev@lists.cip-project.org>; Wed, 15 Jan 2025 09:50:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736963427; x=1737568227; darn=lists.cip-project.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=F2XXiKvOJMaGnEsj7bXYxLgTobqL9i8/apzmzxOvPDY=;
        b=VH+ASWRjYnYXH/7d2lQ3y2EQvxd7JGSnzwtW9hq7RFOQ9M0dtrBS/p/bEwMeTA+Sx+
         yR9jNHtb1VjrefHGepGDBAfSEyvgs4ZZT+vD4yISmTFgPvs6CzqJbGe+oXe1okfDoWc3
         nUFrVEnxG6mEgucYgIpQRYNF2MSIWVm8oGB5KGuSihZ58LgsyFqwFY4GXkj+nKl6v7Sy
         i5mueYtdArWZuMFCgDSNsz+OqAS5SGtUpSW1A5qTPx6AJEPUP6hI/O2fTcrjnrY2V9RA
         WBNGfnMLm0YttrEddy8ojS/nj1YvuvyPG13kipjFnm2S4nm71dVvQkyOs/WyP/frZNa2
         /mmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736963427; x=1737568227;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F2XXiKvOJMaGnEsj7bXYxLgTobqL9i8/apzmzxOvPDY=;
        b=ULq1k9VXWRqd9G/IJAN+i36v+uc/OHFVLH/jO9wWbSdydP1RES5Od21Fs24mzPj08o
         Z2KWJWf2EbuWhw7noBPXw0ungC9Y0Qev4anAhA56TTTG70IWSYq7/eSu8alWr8aX91YW
         0WRFy0LppfX8XtS+e4s9Wkr164Ypsie5LAXk4qr/1zL6V4TmDSxD5aw4Moi45KonB8S3
         Jp4bctYTs+TyKlEMG8tLBNs/bvY7pn70YkDhSsA2T4l/LvKHh5H5Jr73FvTVv3OUyrFP
         pcLhFQUDR2/uHXZx1dG4/0mlc4aIXDCkWKQ4yHA+pwKivrVGJeRMVWv5AqGYGcgSIrCR
         pdQQ==
X-Gm-Message-State: AOJu0Yy20hWh1na2peJoj9Y1dSoobakdtPxC94qE4TX2C4SixqboKL6h
	dHW5iZt2hjm7NJ65NI0f+jllCCOtMrAbDhZNh9dYYVdWjKAp2FHEgh5EKxJ6MVCcYbUkHxSoDQc
	n9kW6FclKyYb7d5oRDvSEqHji6AIWKg==
X-Gm-Gg: ASbGncsNZ5MqLIztUTdm9gSRnEb9qHMDFUuk772Qd/szwULnpWSiWesYSjOY0pI3x01
	0nN15/m8vPqKyW4Yyr3Z7yLO2V9elWVBi7MFQ
X-Google-Smtp-Source: AGHT+IG5DA9TFcEVcL9C7uVgXurz3fBrYP5nSs4aWQF6n/OvWZBUI7Nlr2Z6KW8YHJOJMZ45XX3qIy/r4PhRfP+ibsQ=
X-Received: by 2002:a05:6871:a692:b0:29f:b09d:d93a with SMTP id
 586e51a60fabf-2aa067107famr15803505fac.16.1736963426666; Wed, 15 Jan 2025
 09:50:26 -0800 (PST)
MIME-Version: 1.0
From: Stephen Ecker <stephenecker240@gmail.com>
Date: Wed, 15 Jan 2025 11:50:13 -0600
X-Gm-Features: AbW1kvYnD2v_zcwJw2Do_o0rBwm8fa7b7wabSvRCZHwaKvoOo3AkQr9xzT_-xpI
Message-ID: <CAK9C7GDG1oNhPzrxkc=PQ_wnO7nVLfBeR6SygWkw1WqG385WhA@mail.gmail.com>
Subject: Initramfs: Segfault in klibc using mv with btrfs
To: cip-dev@lists.cip-project.org
Content-Type: multipart/alternative; boundary="00000000000008cfab062bc2502e"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 15 Jan 2025 17:50:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17539

--00000000000008cfab062bc2502e
Content-Type: text/plain; charset="UTF-8"

Note: this is *without* BusyBox.... There may be more conditions in which
this happens:

I have a initramfs on a system with btrfs.  Whenever I attempt to move a
file between sub volumes on the same filesystem, mv Segfaults in the klibc
library.  I have not yet tried with BusyBox, although I'm fairly certain it
also uses klibc.

I worked around it by running mv in a chroot of my rootfs.  This is mostly
just a note in case anyone is tearing their hair out on a bug in their
initramfs scripts.

--00000000000008cfab062bc2502e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Note: this is *without* BusyBox.... There may be more con=
ditions in which this happens:<div dir=3D"auto"><br></div><div dir=3D"auto"=
>I have a initramfs on a system with btrfs.=C2=A0 Whenever I attempt to mov=
e a file between sub volumes on the same filesystem, mv Segfaults in the kl=
ibc library.=C2=A0 I have not yet tried with BusyBox, although I&#39;m fair=
ly certain it also uses klibc.=C2=A0=C2=A0</div><div dir=3D"auto"><br></div=
><div dir=3D"auto">I worked around it by running mv in a chroot of my rootf=
s.=C2=A0 This is mostly just a note in case anyone is tearing their hair ou=
t on a bug in their initramfs scripts.=C2=A0</div></div>

--00000000000008cfab062bc2502e--

