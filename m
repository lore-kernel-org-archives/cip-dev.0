Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66170C00A5A
	for <webhook@archiver.kernel.org>; Wed, 18 Jan 2023 00:29:30 +0000 (UTC)
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
 by mx.groups.io with SMTP id smtpd.web11.3890.1674001767622885479
 for <cip-dev@lists.cip-project.org>;
 Tue, 17 Jan 2023 16:29:28 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20210112.gappssmtp.com header.s=20210112 header.b=OMYCyqvb;
 spf=pass (domain: miraclelinux.com, ip: 209.85.160.49, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-12c8312131fso33903214fac.4
        for <cip-dev@lists.cip-project.org>; Tue, 17 Jan 2023 16:29:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20210112.gappssmtp.com; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FFfuY+2uY+EVd4vPIGOY5KOSKb4/pvgUUBfkH+gQ8YM=;
        b=OMYCyqvbkFvp0PxprgmGrNo3AYYehmprcLkEgFm4TY611cTunCER+s87c649WpG2+N
         D81cc53GpUyGI+ye7ZmVYTRBPuayc5FAOlxLhiVPC/swBDyPmcW3iVJqnM2P7uHwnwnc
         488vMNcpAJdCNpDo7jUAMgGUc2Hp903HZ2g4wDZBKrVZmsT/pHH9lgLh6jM2TnlcM+WO
         Hs9Up9yAmBeU0VHRuTb4BKlvMM+toIFmnDV177Y5xnAIkUzbb90qSCIjyRYDiDJ1PKJN
         qi1QYYVrityKPkkpZb90TI1IMtzygHQ2X5Sxv+yOXdNdoKjHhysp/wsYjIm5cm7oE7LF
         AsWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FFfuY+2uY+EVd4vPIGOY5KOSKb4/pvgUUBfkH+gQ8YM=;
        b=yy8H3z36RDdhLKmEvuGkbNiBSiz2BkZXc0ox0Hl4FcE8vli9T7H11w0TzR+2XkIXSn
         XQsxWG/tCU90lz5D2yimULh1WzF00u8qtRlqZUMaBuhTAbIpQMJEO2bhc1D6Czcu0JU4
         7m25NBhaZAvr1yVRwd3DqfW2S9eqKSI9QyCyDffk6MEaDKs/POZZOT9J45IZssVhifkD
         8bEYBaUFYKyCLJye4CT2eweFzp6m0zIBIz2s8/GvN+XAkbnROT5NOYjk3DgkxsqBc8wv
         M92XE7Eq3z+VX6+M2cKH0GUUNP/wsT2zXNqiXDyPq91iIqCBnLkqb2oFF9qmumErqMEA
         PU2A==
X-Gm-Message-State: AFqh2ko64Wlc2LcZg/fr0HrN3dx2oGgaL8O1NHnWFbyveiSuSvof8vGF
	0YOfyzEgd/cIsEpPEbUxuer7POeDzyfSRa6JWXg1MF538h9iTxFz
X-Google-Smtp-Source: AMrXdXuClQVFbqEX71fWW1V4jSJQxf/BSgq8zlACFhowSVhi5PgDATfwgxzmdqw49yWwfqXqBqGAAdIx1MhbZoJFCLw=
X-Received: by 2002:a05:6870:4513:b0:15b:8f97:237 with SMTP id
 e19-20020a056870451300b0015b8f970237mr407465oao.58.1674001766264; Tue, 17 Jan
 2023 16:29:26 -0800 (PST)
MIME-Version: 1.0
References: <Y8af6jlANakoFq/f@duo.ucw.cz>
In-Reply-To: <Y8af6jlANakoFq/f@duo.ucw.cz>
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Wed, 18 Jan 2023 09:28:49 +0900
Message-ID: <CAODzB9pYxaec7OjHFF5hiEL_65SqtfO+qfYUK5J_AAdW-YPDhg@mail.gmail.com>
Subject: Re: [cip-dev] Good and bad ideas w.r.t. kernel and security
To: cip-dev@lists.cip-project.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 18 Jan 2023 00:29:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10377

HI.

On Tue, Jan 17, 2023 at 10:17 PM Pavel Machek <pavel@denx.de> wrote:
>
> Good and bad ideas w.r.t. kernel and security
>
> Kernel tries to provide many security guarantees at different
> levels. Still, some things are easier to guarantee than others, and
> some security barriers are really important, while others... not so
> much.
>
> Kernel should be secure against remote attackers.
>
>     And it reasonably is, when not, we get it fixed with high priority.
>
> Kernel should protect itself and other users against local, non-priviledged users.
>
>     Tries, but attack surface is big.
>     People don't care about DoS attacks much.
>     => Running untrusted code is a bad idea. Forkbomb is few characters in sh.
>
> Fast, out-of-order CPUs leak user data via timing side-channels. Those
> CPUs should not process sensitive data. JITs can be used to extract the data.
>
>     We can try to work around the problems and apply vendor-provided
>     workarounds, but there are likely more problems in future. Similar
>     bugs are hidden in CPU microarchitectures, and in particular
>     Spectre workarounds are whack-a-mole and thus incomplete.
>
>     Hyperthreading makes those attacks easier.
>     => Use suitable CPUs to process sensitive data.
>
>     BPF is in-kernel JIT
>     => Don't use BPF, make sure it is disabled on your configurations.
>
> Filesystems are complex, robustness against malformed filesystems is hard.
>
>     Some filesystems try to be robust against filesystems corruption,
>     and some don't even try. Some perform checks during mount, but
>     that means that malicious device can work around them.
>
>     => Don't mount untrusted filesystems. If you have to, use simple and
>     common filesystem. VFAT might be good choice.
>
> Kernel should protect itself against local users with CAP_XX.
>
>     Yes, there's capability system, and in theory capabilities should be separated.
>     => Don't rely on that. Noone else does.
>
> Some systems try to protect themselves against people with physical access.
>
>     Laws of physics says it is impossible, but people can still try to
>     make it more costly for the "attacker".
>     => Please don't rely on that.
>
> Coredumps are useful for debugging, but random processes leaving files in cwd
> may not be welcome
>
>     Consider disabling coredumps, perhaps with RLIMIT_CORE=0.
>
>     Consider putting all coredumps into single directory with /proc/sys/kernel/core_pattern.
>
> Kernel config options for hardened kernel
>
> Investigate:
>
> CONFIG_X86_IOPL_IOPERM=y
>
> https://timesys.com/security/securing-your-linux-configuration-kernel-hardening/
>
> RETPOLINE=Y
> DEVMEM=is not set
> PAGE_POISONING=Y , enable withpage_poison=1
> GCC_PLUGIN_STACKLEAK=Y
> DEBUG_BUGVERBOSE=is not set , kind of security by obscurity, but may make attackers work harder; will also make your own debugging harder, so..
> ARCH_HAS_ELF_RANDOMIZE=Y
> INIT_ON_FREE_DEFAULT_ON=Y
> INIT_ON_ALLOC_DEFAULT_ON=Y
> DEBUG_VIRTUAL=Y
>
>

Yes. Disabling  features to reduce attack surface, and/or enabling
features to prevent/mitigate future attack in configuration file is
important.
Security hardened makes less debugalability but production systems
should prioritize security first.

kconfig-hardened-check tool is helpful to check kernel configuration.

https://github.com/a13xp0p0v/kconfig-hardened-check

> --
> DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
>
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#10374): https://lists.cip-project.org/g/cip-dev/message/10374
> Mute This Topic: https://lists.cip-project.org/mt/96329245/4520416
> Group Owner: cip-dev+owner@lists.cip-project.org
> Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129101/4520416/1465703922/xyzzy [masami.ichikawa@miraclelinux.com]
> -=-=-=-=-=-=-=-=-=-=-=-
>

Regards,
-- 
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
          :masami.ichikawa@miraclelinux.com

