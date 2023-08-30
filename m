Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BCB2C6FA8F
	for <webhook@archiver.kernel.org>; Wed, 30 Aug 2023 11:07:22 +0000 (UTC)
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
 by mx.groups.io with SMTP id smtpd.web10.11260.1693393635749562029
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 30 Aug 2023 04:07:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=jREzACnQ;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.175, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1bf7423ef3eso33596615ad.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 30 Aug 2023 04:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1693393634; x=1693998434; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=EGHkPxOKvpxMl/UvHtg1XTb0i9PiBYejpWmspf2WGVU=;
        b=jREzACnQW+eiluClIQeGgd7bIBysHT5eBGFes2j9NqIYu8s8e+wImrtXIvGTTxmE+N
         79+s+NI+VBnRvNtYWNaUA5Ioq3S8MBBoHtT6IwgUyNUqO7g3jYGTPRwZ0+mc8y4lQa3M
         jAjqh3T1KF8l9qNfrfgT9y++rl8muy00Bd8GIBSGgQ7QbuTaWEhXcvf6J18bcdqTkh4q
         wscpe4pOx4lMnAobye9Aq/ti6ia8JSTTpe2ktDh4MKGW+3Gif46TgdFem/E79D42/LgJ
         ON0kb36I269VWPs7GdP2XjOCrVMREIUGNTNDx5nXwsDb8e4I0T+lgksQ9tTPBBlgY3w0
         dXRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693393634; x=1693998434;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EGHkPxOKvpxMl/UvHtg1XTb0i9PiBYejpWmspf2WGVU=;
        b=J5h+qs69ZFLuFQ33oTFIk6y+89DHYqneKVSEqOIU1Q1J6uCSK8MTTMdIW2JxY6T37V
         7L+ApyfPO+nZvdjaighz7j8VvNQHTcOf6AuuZscmPvgZ/yqdrUwJLTzuWgA2QjAaNFfg
         OiOaflaQ8V9ZinwO911xgjKAhc5hXDvcNNPl380uZxS0XfR7F3UvazZBQcyYY/9CC5hG
         x12+DruQeYJU8ijYnDA8gCP+1UznCXLdEmzACPYp3s9pW5FqpWFqAVOZBFpdsRn6hiuY
         8fuM/Uhjbx+bn6w0HFoeLcL8RupM32c7DxiNwmfQS86f+b6ESA/M9ZyPpZyeodNH+y6e
         BBRw==
X-Gm-Message-State: AOJu0Yz1g0pTSI54JVS6Gv+86QoNepjAUqzwuQWn0EBAy7n3QskH6J9P
	J5BPXIkPLD6ndpMihU73CUopbW3yMdP41K1/sIM=
X-Google-Smtp-Source: AGHT+IHBf/d+YbRXYQvGwf2avBCWtoBGaGN+YhtXjyCt6jbrEsEw2gE/ypoyBNZoDALrSYJMWbLUrw==
X-Received: by 2002:a17:902:d345:b0:1bc:7a4b:5c68 with SMTP id l5-20020a170902d34500b001bc7a4b5c68mr1803827plk.39.1693393634438;
        Wed, 30 Aug 2023 04:07:14 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id v11-20020a170902d68b00b001bdc2d10753sm10802846ply.215.2023.08.30.04.07.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 04:07:13 -0700 (PDT)
Message-ID: <64ef22e1.170a0220.ab4cc.275e@mx.google.com>
Date: Wed, 30 Aug 2023 04:07:13 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.4.y-st-rc
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v4.4-st20-1637-g14a3f1aaa7ff
Subject: cip/linux-4.4.y-st-rc build: 14 builds: 4 failed, 10 passed, 8 errors,
 25 warnings (v4.4-st20-1637-g14a3f1aaa7ff)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 30 Aug 2023 11:07:22 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12913

cip/linux-4.4.y-st-rc build: 14 builds: 4 failed, 10 passed, 8 errors, 25 w=
arnings (v4.4-st20-1637-g14a3f1aaa7ff)

Full Build Summary: https://kernelci.org/build/cip/branch/linux-4.4.y-st-rc=
/kernel/v4.4-st20-1637-g14a3f1aaa7ff/

Tree: cip
Branch: linux-4.4.y-st-rc
Git Describe: v4.4-st20-1637-g14a3f1aaa7ff
Git Commit: 14a3f1aaa7ffa564efe6fc57b356c803aa88cd81
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
Built: 4 unique architectures

Build Failures Detected:

arm:
    omap2plus_defconfig: (gcc-10) FAIL

i386:
    i386_defconfig: (gcc-10) FAIL

x86_64:
    x86_64_defconfig: (gcc-10) FAIL
    x86_64_defconfig+x86-chromebook: (gcc-10) FAIL

Errors and Warnings Detected:

arm64:
    defconfig (gcc-10): 1 warning
    defconfig+arm64-chromebook (gcc-10): 1 warning

arm:
    imx_v6_v7_defconfig (gcc-10): 1 warning
    omap2plus_defconfig (gcc-10): 2 errors, 1 warning

i386:
    allnoconfig (gcc-10): 1 warning
    i386_defconfig (gcc-10): 2 errors, 2 warnings
    tinyconfig (gcc-10): 1 warning

x86_64:
    allnoconfig (gcc-10): 4 warnings
    tinyconfig (gcc-10): 3 warnings
    x86_64_defconfig (gcc-10): 2 errors, 5 warnings
    x86_64_defconfig+x86-chromebook (gcc-10): 2 errors, 5 warnings

Errors summary:

    4    kernel/trace/trace_events.c:424:4: error: implicit declaration of =
function =E2=80=98trace_buffered_event_enable=E2=80=99 [-Werror=3Dimplicit-=
function-declaration]
    4    kernel/trace/trace_events.c:390:4: error: implicit declaration of =
function =E2=80=98trace_buffered_event_disable=E2=80=99 [-Werror=3Dimplicit=
-function-declaration]

Warnings summary:

    7    arch/x86/kernel/process.c:456: Warning: no instruction mnemonic su=
ffix given and no register operands; using default for `btr'
    7    arch/x86/kernel/cpu/amd.c:753: warning: "MSR_AMD64_DE_CFG" redefin=
ed
    4    cc1: some warnings being treated as errors
    4    arch/x86/entry/entry_64.S:487: Warning: no instruction mnemonic su=
ffix given and no register operands; using default for `btr'
    2    drivers/net/ethernet/apm/xgene/xgene_enet_main.c:32:36: warning: a=
rray =E2=80=98xgene_enet_acpi_match=E2=80=99 assumed to have one element
    1    drivers/usb/gadget/function/f_ncm.c:1565:19: warning: assignment t=
o =E2=80=98struct config_group *=E2=80=99 from =E2=80=98int=E2=80=99 makes =
pointer from integer without a cast [-Wint-conversion]

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D

Detailed per-defconfig build reports:

---------------------------------------------------------------------------=
-----
allnoconfig (i386, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 section m=
ismatches

Warnings:
    arch/x86/kernel/cpu/amd.c:753: warning: "MSR_AMD64_DE_CFG" redefined

---------------------------------------------------------------------------=
-----
allnoconfig (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 4 warnings, 0 sectio=
n mismatches

Warnings:
    arch/x86/entry/entry_64.S:487: Warning: no instruction mnemonic suffix =
given and no register operands; using default for `btr'
    arch/x86/kernel/process.c:456: Warning: no instruction mnemonic suffix =
given and no register operands; using default for `btr'
    arch/x86/kernel/process.c:456: Warning: no instruction mnemonic suffix =
given and no register operands; using default for `btr'
    arch/x86/kernel/cpu/amd.c:753: warning: "MSR_AMD64_DE_CFG" redefined

---------------------------------------------------------------------------=
-----
defconfig (arm64, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 section mi=
smatches

Warnings:
    drivers/net/ethernet/apm/xgene/xgene_enet_main.c:32:36: warning: array =
=E2=80=98xgene_enet_acpi_match=E2=80=99 assumed to have one element

---------------------------------------------------------------------------=
-----
defconfig+arm64-chromebook (arm64, gcc-10) =E2=80=94 PASS, 0 errors, 1 warn=
ing, 0 section mismatches

Warnings:
    drivers/net/ethernet/apm/xgene/xgene_enet_main.c:32:36: warning: array =
=E2=80=98xgene_enet_acpi_match=E2=80=99 assumed to have one element

---------------------------------------------------------------------------=
-----
i386_defconfig (i386, gcc-10) =E2=80=94 FAIL, 2 errors, 2 warnings, 0 secti=
on mismatches

Errors:
    kernel/trace/trace_events.c:390:4: error: implicit declaration of funct=
ion =E2=80=98trace_buffered_event_disable=E2=80=99 [-Werror=3Dimplicit-func=
tion-declaration]
    kernel/trace/trace_events.c:424:4: error: implicit declaration of funct=
ion =E2=80=98trace_buffered_event_enable=E2=80=99 [-Werror=3Dimplicit-funct=
ion-declaration]

Warnings:
    arch/x86/kernel/cpu/amd.c:753: warning: "MSR_AMD64_DE_CFG" redefined
    cc1: some warnings being treated as errors

---------------------------------------------------------------------------=
-----
imx_v6_v7_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 se=
ction mismatches

Warnings:
    drivers/usb/gadget/function/f_ncm.c:1565:19: warning: assignment to =E2=
=80=98struct config_group *=E2=80=99 from =E2=80=98int=E2=80=99 makes point=
er from integer without a cast [-Wint-conversion]

---------------------------------------------------------------------------=
-----
multi_v5_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 se=
ction mismatches

---------------------------------------------------------------------------=
-----
multi_v7_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 se=
ction mismatches

---------------------------------------------------------------------------=
-----
omap2plus_defconfig (arm, gcc-10) =E2=80=94 FAIL, 2 errors, 1 warning, 0 se=
ction mismatches

Errors:
    kernel/trace/trace_events.c:390:4: error: implicit declaration of funct=
ion =E2=80=98trace_buffered_event_disable=E2=80=99 [-Werror=3Dimplicit-func=
tion-declaration]
    kernel/trace/trace_events.c:424:4: error: implicit declaration of funct=
ion =E2=80=98trace_buffered_event_enable=E2=80=99 [-Werror=3Dimplicit-funct=
ion-declaration]

Warnings:
    cc1: some warnings being treated as errors

---------------------------------------------------------------------------=
-----
tinyconfig (i386, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 section mi=
smatches

Warnings:
    arch/x86/kernel/cpu/amd.c:753: warning: "MSR_AMD64_DE_CFG" redefined

---------------------------------------------------------------------------=
-----
tinyconfig (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 3 warnings, 0 section=
 mismatches

Warnings:
    arch/x86/entry/entry_64.S:487: Warning: no instruction mnemonic suffix =
given and no register operands; using default for `btr'
    arch/x86/kernel/process.c:456: Warning: no instruction mnemonic suffix =
given and no register operands; using default for `btr'
    arch/x86/kernel/cpu/amd.c:753: warning: "MSR_AMD64_DE_CFG" redefined

---------------------------------------------------------------------------=
-----
vexpress_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 se=
ction mismatches

---------------------------------------------------------------------------=
-----
x86_64_defconfig (x86_64, gcc-10) =E2=80=94 FAIL, 2 errors, 5 warnings, 0 s=
ection mismatches

Errors:
    kernel/trace/trace_events.c:390:4: error: implicit declaration of funct=
ion =E2=80=98trace_buffered_event_disable=E2=80=99 [-Werror=3Dimplicit-func=
tion-declaration]
    kernel/trace/trace_events.c:424:4: error: implicit declaration of funct=
ion =E2=80=98trace_buffered_event_enable=E2=80=99 [-Werror=3Dimplicit-funct=
ion-declaration]

Warnings:
    arch/x86/entry/entry_64.S:487: Warning: no instruction mnemonic suffix =
given and no register operands; using default for `btr'
    arch/x86/kernel/process.c:456: Warning: no instruction mnemonic suffix =
given and no register operands; using default for `btr'
    arch/x86/kernel/process.c:456: Warning: no instruction mnemonic suffix =
given and no register operands; using default for `btr'
    arch/x86/kernel/cpu/amd.c:753: warning: "MSR_AMD64_DE_CFG" redefined
    cc1: some warnings being treated as errors

---------------------------------------------------------------------------=
-----
x86_64_defconfig+x86-chromebook (x86_64, gcc-10) =E2=80=94 FAIL, 2 errors, =
5 warnings, 0 section mismatches

Errors:
    kernel/trace/trace_events.c:390:4: error: implicit declaration of funct=
ion =E2=80=98trace_buffered_event_disable=E2=80=99 [-Werror=3Dimplicit-func=
tion-declaration]
    kernel/trace/trace_events.c:424:4: error: implicit declaration of funct=
ion =E2=80=98trace_buffered_event_enable=E2=80=99 [-Werror=3Dimplicit-funct=
ion-declaration]

Warnings:
    arch/x86/entry/entry_64.S:487: Warning: no instruction mnemonic suffix =
given and no register operands; using default for `btr'
    arch/x86/kernel/process.c:456: Warning: no instruction mnemonic suffix =
given and no register operands; using default for `btr'
    arch/x86/kernel/process.c:456: Warning: no instruction mnemonic suffix =
given and no register operands; using default for `btr'
    arch/x86/kernel/cpu/amd.c:753: warning: "MSR_AMD64_DE_CFG" redefined
    cc1: some warnings being treated as errors

---
For more info write to <info@kernelci.org>

