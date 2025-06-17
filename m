Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08E71C7114A
	for <webhook@archiver.kernel.org>; Tue, 17 Jun 2025 06:51:49 +0000 (UTC)
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
 by mx.groups.io with SMTP id smtpd.web10.11796.1750139945591166212
 for <cip-dev@lists.cip-project.org>;
 Mon, 16 Jun 2025 22:59:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=plsLOGAg;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.219.182, mailfrom: bot@kernelci.org)
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e819aa98e7aso4676826276.2
        for <cip-dev@lists.cip-project.org>; Mon, 16 Jun 2025 22:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1750139945; x=1750744745; darn=lists.cip-project.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:reply-to
         :from:mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bRdkQolzRp7/TbSUPFwhi9X0iyXEJHu3pqYSp0uazqE=;
        b=plsLOGAgWk4sP6X6VDN3M/j1niQSnoLGd8SLEN4Za/3ZClUCUtH4NuAElrUVgocp0r
         OZGDAM9S+moGCh47G62k76ZB0/HeLsGbpX1VXH0gWc+NCiH4ZKqIO4lsC7ayl6TsI+RC
         rVJxUkaX8ZCSUsC9qKqxxdkFUfmj6eUAx+U5SQOUwx9a9xtdc7MZ8W9I/ZiHixmUiKVA
         TD0vLBapkGhnmfFnrb5Aq4GkVfq7GUqkB1mup02xSqvcTY/V4gsh//imdtcs6GR/xVR7
         +huvw5CG3SwvSO1lUYxS+RDo/KsW40ptCmScppsODm0YMbxDWMc7IvEDZ/nUXpps80uE
         3S6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750139945; x=1750744745;
        h=content-transfer-encoding:cc:to:subject:message-id:date:reply-to
         :from:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bRdkQolzRp7/TbSUPFwhi9X0iyXEJHu3pqYSp0uazqE=;
        b=Ojrii+czffDK/h5fZBNapgBXeSmfgxzVEUzWvB5XJYmdiPftvmFdmj766YevLPoPK8
         R8tp2uglBGFeUBzwMC+EWhyhPh3mRNlPuPC/dSqnSYJhgQN6iTQH0w1gZnCw1Z2AGakj
         WlDD70ZyWlGQ543JCRl70pPhs5j56BlMAiszkF5ATXg7STnsCG+lpi2WZsnPfd8r3A2l
         6s9zHnsMqwdAAdizeC62e7RK3cuImSqPqQu4dOHjyzdn3WYfDotTJ7EzBq+IME9ilhVZ
         xnpLOaNPeU+Ydcsiq9iP/sXMhtp1UTxUpKHzhgveDBgDOwVBm5fc0/gi6IrPrINpoofL
         sSpA==
X-Forwarded-Encrypted: i=1; AJvYcCU9RlJsujGd4f5JzBssH4En/vRQWMU4SZNQZ4dCVtbdqVDjGiiyfZbI+ofnB4rwXuYmRenJshym@lists.cip-project.org
X-Gm-Message-State: AOJu0YzEej4chyWZMcu7gpjMtusPsZlbOBTjMpGdSIbwRBB6HT/qups6
	5WEpqpek9XMWZbWzs8qcyum9Z5z7zGgZ5s26yZd9+XdBvm7oURBYwQrx3apAzauaeL64xZZeDnY
	ZTOdFQwNi7u2JLUISMh/QLQv0AhPsoMkxLlioW2eraw==
X-Gm-Gg: ASbGncsNpeP5uvz+UcTx3w/N7VP3gqa1YKGL3PrNbz9pbSvIymaeCommPesGFksizod
	Lbij0s4fBHXf8U9VI5f49V6dKzIeODH1i5kHduI6kpviASIJWKv4vMye4Hts6XXMa+jaXw46KyA
	VIgFljPh2mAfZB0mUQfaESy75Lwuk6OJhAtfdfYeNtIkk/tOMyC2X1
X-Google-Smtp-Source: AGHT+IEKeJccV08dueWXi9EoE2i1w3FJefLijJj67XI9EuLayWuAVJHe+vl36sFuBdv/VIlXgPQ2zZU6sL4jl3jc4v4=
X-Received: by 2002:a05:6902:2386:b0:e82:b04f:4b5c with SMTP id
 3f1490d57ef6-e82b04f4dd6mr1053609276.5.1750139944712; Mon, 16 Jun 2025
 22:59:04 -0700 (PDT)
Received: from 415818378487 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 16 Jun 2025 22:59:03 -0700
MIME-Version: 1.0
from: KernelCI bot <bot@kernelci.org>
Reply-To: kernelci@lists.linux.dev
Date: Mon, 16 Jun 2025 22:59:03 -0700
X-Gm-Features: AX0GCFuLz9oVc7HviLKv-q8bEjBJw82SuEgUcfH41N5Vx3agJDlzxWQIFjewATs
Message-ID: <CACo-S-1nNp_6XxFOL4cfFG5D7Njf9mMUHR9+XGvZvFzZ5LY2XA@mail.gmail.com>
Subject: [REGRESSION] cip/linux-5.10.y-cip: (build) in vmlinux (Makefile:1227) [logspec:kbuild,kbuild.other]
To: kernelci-results@groups.io
Cc: gus@collabora.com, cip-dev@lists.cip-project.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 17 Jun 2025 06:51:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19115

Hello,

New build issue found on cip/linux-5.10.y-cip:

---
 in vmlinux (Makefile:1227) [logspec:kbuild,kbuild.other]
---

- dashboard: https://d.kernelci.org/i/maestro:8e25661d7d247bba8b1fb281e07f1=
058a6767767
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
- commit HEAD:  65fb4abcfb5dd50e63101c206c32c3fe87733380


Log excerpt:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
.lds
kernel/trace/trace_events_synth.c: In function =E2=80=98synth_event_reg=E2=
=80=99:
kernel/trace/trace_events_synth.c:847:9: warning: ISO C90 forbids
mixed declarations and code [-Wdeclaration-after-statement]
In file included from ./include/linux/kernel.h:15,
net/ipv4/inet_hashtables.c: In function =E2=80=98inet_ehash_locks_alloc=E2=
=80=99:
./include/linux/minmax.h:20:35: warning: comparison of distinct
pointer types lacks a cast
./include/linux/minmax.h:26:18: note: in expansion of macro =E2=80=98__type=
check=E2=80=99
./include/linux/minmax.h:36:31: note: in expansion of macro =E2=80=98__safe=
_cmp=E2=80=99
./include/linux/minmax.h:52:25: note: in expansion of macro =E2=80=98__care=
ful_cmp=E2=80=99
net/ipv4/inet_hashtables.c:946:19: note: in expansion of macro =E2=80=98max=
=E2=80=99
FAILED unresolved symbol filp_close

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D


# Builds where the incident occurred:

## cros://chromeos-5.10/x86_64/chromeos-amd-stoneyridge.flavour.config+lab-=
setup+x86-board+CONFIG_MODULE_COMPRESS=3Dn+CONFIG_MODULE_COMPRESS_NONE=3Dy
on (x86_64):
- compiler: gcc-12
- dashboard: https://d.kernelci.org/build/maestro:6850f855dba9af5ad63ee637

## cros://chromeos-5.10/x86_64/chromeos-intel-pineview.flavour.config+lab-s=
etup+x86-board+CONFIG_MODULE_COMPRESS=3Dn+CONFIG_MODULE_COMPRESS_NONE=3Dy
on (x86_64):
- compiler: gcc-12
- dashboard: https://d.kernelci.org/build/maestro:6850f858dba9af5ad63ee63a


#kernelci issue maestro:8e25661d7d247bba8b1fb281e07f1058a6767767

Reported-by: kernelci.org bot <bot@kernelci.org>

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

