Return-Path: <yoshitake.kobayashi.x25@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B3A2CD5BAF
	for <webhook@archiver.kernel.org>; Fri, 22 May 2026 04:05:42 +0000 (UTC)
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.8195.1779411993897254100
 for <cip-dev@lists.cip-project.org>;
 Thu, 21 May 2026 18:06:34 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci.org header.s=google header.b=dfHLsiEo;
 spf=pass (domain: kernelci.org, ip: 209.85.222.50, mailfrom: bot@kernelci.org)
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-95d0476492bso4714217241.2
        for <cip-dev@lists.cip-project.org>; Thu, 21 May 2026 18:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1779411993; x=1780016793; darn=lists.cip-project.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0neZsLGzIdcbSizaubx8ZPexvtTYArtg0jAKTeMaIVQ=;
        b=dfHLsiEozucBz8PUycA3bLnPaYJkxIXRDuvS2rR6KIg2AQcMybZW0Uyz3MOJD4I9TH
         QLfvC7QrBY5Y4eK0vpK45stNDxEuioUgx9/OoFglPEya4ujUIUEMK9Ef54Go7FaufeSz
         o7axxj1DEI/F151OiQ8BDDZRfgyM1Fb7ZVjw9vJG+/qy1VL404OizN0jNLYwHhgcn/Wf
         WtytlySadpOB3SMF4crgS9yDXhsQtQNHOcUAd49wpxbw23M62igAW+cswGEuq/3+sWCE
         2R2AzaxKQGg24pDS1XR9eszGrYpUf4fqKgL4gsrJL0XDglpYERUlOQtDKvNyEWeQaMV/
         2kSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779411993; x=1780016793;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0neZsLGzIdcbSizaubx8ZPexvtTYArtg0jAKTeMaIVQ=;
        b=SelX6jNyMovXH99xpg+XZv2+R42dwW5TNN84bYY+0w++OsQLJm83gnofoeUIgJA1CL
         WiQk9bzBsPnHw/pFgs+nC/6eCzuxYehjDkHz1mWVEHoClFtWlS6zx3ohOYpr8bmwiIFA
         0lR8g+5Gr0vIjLrOUyERgfMZ4AFWtMrmbyorXwL+dvTaQIvzL95WfqvxLUIb6F+5ChlC
         gyoFek2fi7N4OFYuxL8W2kjGVGWaO6gGgvVw4kxM8R8eBUXOKlkryAPghSEDMwe240+u
         73qscKHGxHCkifo6lriehciJqVgJ8JzXIUsMKknJsSI/jgs4Iy+VOcwA5aFhb14BXwNZ
         FZ1w==
X-Forwarded-Encrypted: i=1; AFNElJ+9gvxLICrh53FYWG7Ft5ZmE6unkkIicSjZWHIqmHk22VtEOZkox4DLq3RXW2pPSXC6AbthRnMg@lists.cip-project.org
X-Gm-Message-State: AOJu0YxqVOC+A8J4dLUYJVLajI/kNZIlkkmm7ZrDPJkGBER05K2hO1do
	EAI3ZDsMVLl212AH9yNlMHz9HocxBqm2c0+9kgBqIAamq0ifgF31BQ4dbUQQxgxap73etawp0zg
	i+LKn
X-Gm-Gg: Acq92OFF8ZG1fwi4gw8ZtaoXrXo9vZD6viIVWbKtz4aCR9b7dGcs57y8PYn8b5oC4T8
	uKG4Ld25rVtpKTOwmh6TsYusGdgqJjB2pa12+vvJgUrmUdORm40MWdagmYGVVB/70XByvIi6baI
	TxLVha1LJZ3TZUTVlTvW0isum4T9oyfxylYiqbEf74k0Jdih1ykzOtnJ7MYMjk7567yX/URKo6u
	IOU6h5aQFoXcvOfnKjFsw8AYZ2alfKbQElVfnY6bQ87atsIBJ8fewwVX0I99qU1kJ+tm6Nyp2jJ
	Tnj2yN8qy/DIud4t2ZtprAlCXpvabGUvOmWWwPwF/XdPePYzuhprcISGcTkkXjiKxGtHCuQN8hH
	5A1E/Vg8o+DQqoluKuobVRAcObu4L4sQfZ64YOutSWlAEN3UkpcCyBlp9mJzX/GlzdkqM9sVHfy
	CIuXi98Bc4DC/BAspG
X-Received: by 2002:a05:7300:324b:b0:2d2:96e8:1bf5 with SMTP id 5a478bee46e88-30448f3084cmr994975eec.3.1779411544784;
        Thu, 21 May 2026 17:59:04 -0700 (PDT)
Received: from 330cfa3079ca ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3044b704f31sm941885eec.11.2026.05.21.17.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 17:59:04 -0700 (PDT)
MIME-Version: 1.0
Subject: [REGRESSION] cip/linux-6.12.y-cip: (build) "field_get" redefined [-Werror] in sound/usb/mixer_quirks.o (sound...
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: gus@collabora.com, cip-dev@lists.cip-project.org
Reply-To: kernelci@lists.linux.dev
Date: Fri, 22 May 2026 00:59:04 -0000
Message-ID: <177941154371.3955.14567547508285219672@330cfa3079ca>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 22 May 2026 04:05:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22996





Hello,

New build issue found on cip/linux-6.12.y-cip:

---
 "field_get" redefined [-Werror] in sound/usb/mixer_quirks.o (sound/usb/mixer_quirks.c) [logspec:kbuild,kbuild.compiler.error]
---

- dashboard: https://d.kernelci.org/i/maestro:a94ea5d1afc23fcda14671f21b43fc786afb977a
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
- commit HEAD:  d1ef14060e80d140ce53f8b197bb6c38de70d3bf


Please include the KernelCI tag when submitting a fix:

Reported-by: kernelci.org bot <bot@kernelci.org>


Log excerpt:
=====================================================
sound/usb/mixer_quirks.c:3373:9: error: "field_get" redefined [-Werror]
 3373 | #define field_get(_mask, _reg) (((_reg) & (_mask)) >> (ffs(_mask) - 1))
      |         ^~~~~~~~~
In file included from sound/usb/mixer_quirks.c:17:
./include/linux/bitfield.h:308:9: note: this is the location of the previous definition
  308 | #define field_get(mask, reg)                                            \
      |         ^~~~~~~~~
sound/usb/mixer_quirks.c:3374:9: error: "field_prep" redefined [-Werror]
 3374 | #define field_prep(_mask, _val) (((_val) << (ffs(_mask) - 1)) & (_mask))
      |         ^~~~~~~~~~
./include/linux/bitfield.h:288:9: note: this is the location of the previous definition
  288 | #define field_prep(mask, val)                                           \
      |         ^~~~~~~~~~
  CC [M]  fs/autofs/expire.o
  CC [M]  fs/smb/client/readdir.o
  CC [M]  fs/smb/server/transport_ipc.o
  CC [M]  fs/autofs/dev-ioctl.o
cc1: all warnings being treated as errors

=====================================================


# Builds where the incident occurred:

## x86_64_defconfig+kselftest+lab-setup+cip://6.12.y-cip/x86/cip_merged_defconfig on (x86_64):
- compiler: gcc-14
- config: https://files.kernelci.org/kbuild-gcc-14-x86-612-cip-6a0f9c36c876482723f27ef9/.config
- dashboard: https://d.kernelci.org/build/maestro:6a0f9c36c876482723f27ef9


#kernelci issue maestro:a94ea5d1afc23fcda14671f21b43fc786afb977a

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

