Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0FE2C5475B
	for <webhook@archiver.kernel.org>; Fri,  1 Mar 2024 17:18:15 +0000 (UTC)
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
 by mx.groups.io with SMTP id smtpd.web11.29348.1709313495266995524
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 01 Mar 2024 09:18:15 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=hooHDdu1;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.174, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6e58a984ea1so1708177b3a.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 01 Mar 2024 09:18:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1709313494; x=1709918294; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wSLNAh4Cj2SNDkk1PBY+pWovFMi+FWH7IIhvSoLUo+s=;
        b=hooHDdu1XxYJakvQEQv+72oyGTs8XhruLyevZwCltDKk65p84/PSkx1/fHswdUB3Bo
         hOuA2VdRBUqERY2sQzSSs6hgV3owtYF8rMVoIizaTuMnf00GV9Qm0x3GdCpRmgoW0qot
         tOCzywXCouFHFAMDGbR6wBSMm0AW77ZRu5CA+iRkfQxgrLOcywMhWtwAH9ndhjzW4BFt
         hdCpr8BjmHedAWoOBCKMCyIhrSD9x5GHMk22jcao3ZYVg/e+9gWLIT7rn7dpkpscQ25m
         JXCZt9D5IXCZra0axbDH1QDzSEQbAXBfybhauDsKC+BIi4HQYAhpe4R4YIhwHS63IeCl
         QP8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709313494; x=1709918294;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wSLNAh4Cj2SNDkk1PBY+pWovFMi+FWH7IIhvSoLUo+s=;
        b=STE7qvPoOX0Dh5GClwrYA0Bg/bcB2i0WF7W5KrT79vH06tvbrvJDViU8oUOa7sI0UU
         1Ou7CvJfZKRXBMNYbOsEjbNcgoQo5pcSH792oN4P43fZaD1EwwAEF+5iuu2c9MJhwboW
         V9jPZkFpzGfE8WdDPk9+kgTerPRMDTePC8UvndesReN+dm3q6o/pyG34Nd8F/7U+qXZz
         C8nx5s+C2pHRiOe+VJ8neWab3eDZdnWazysWeWlUxu9xMPVVEzslZOvhexJ0t+Bn7IxW
         c/n1AG8VSyzybK/96omBQP/Zr4jsnCekBTrchGnl7BMnRBz1v384UEuCbX0P5cApDUmf
         Fpvg==
X-Gm-Message-State: AOJu0Yy18HN/OqFf5ppIHJEap8eDqVYgbqvBYh2Y6dP9wbFwHZKvYq9m
	4CG6Hvp33QxhmNW710YidHeII6lJSAS9Q4JzBz8G9J2O7IvgIoq2wJndpF7KB0Gw5emfeLb0+LI
	wP+0=
X-Google-Smtp-Source: AGHT+IGhD4c4+Ud0DG7RfiOi4fU07G+b2T3iNUvbtsisOL1H696m0LBnBRKi9r8MgbAkDBXPCHw7Qw==
X-Received: by 2002:a05:6a00:3d42:b0:6e4:eee0:5798 with SMTP id lp2-20020a056a003d4200b006e4eee05798mr2594865pfb.14.1709313493553;
        Fri, 01 Mar 2024 09:18:13 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id i29-20020a056a00005d00b006e5bed8dac0sm1383527pfk.61.2024.03.01.09.18.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 09:18:13 -0800 (PST)
Message-ID: <65e20dd5.050a0220.d318a.5f1c@mx.google.com>
Date: Fri, 01 Mar 2024 09:18:13 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-4.4.y-st-rc
X-Kernelci-Kernel: v4.4-st20-2245-gb01c108f53cc0
X-Kernelci-Report-Type: build
Subject: cip/linux-4.4.y-st-rc build: 14 builds: 0 failed, 14 passed,
 41 warnings (v4.4-st20-2245-gb01c108f53cc0)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 01 Mar 2024 17:18:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15130

cip/linux-4.4.y-st-rc build: 14 builds: 0 failed, 14 passed, 41 warnings (v=
4.4-st20-2245-gb01c108f53cc0)

Full Build Summary: https://kernelci.org/build/cip/branch/linux-4.4.y-st-rc=
/kernel/v4.4-st20-2245-gb01c108f53cc0/

Tree: cip
Branch: linux-4.4.y-st-rc
Git Describe: v4.4-st20-2245-gb01c108f53cc0
Git Commit: b01c108f53cc00abfe18491837bb94881ee164b8
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
Built: 4 unique architectures

Warnings Detected:

arm64:
    defconfig (gcc-10): 2 warnings
    defconfig+arm64-chromebook (gcc-10): 2 warnings

arm:
    imx_v6_v7_defconfig (gcc-10): 2 warnings
    multi_v5_defconfig (gcc-10): 1 warning
    multi_v7_defconfig (gcc-10): 2 warnings
    omap2plus_defconfig (gcc-10): 2 warnings
    vexpress_defconfig (gcc-10): 1 warning

i386:
    i386_defconfig (gcc-10): 6 warnings

x86_64:
    allnoconfig (gcc-10): 3 warnings
    tinyconfig (gcc-10): 2 warnings
    x86_64_defconfig (gcc-10): 9 warnings
    x86_64_defconfig+x86-board (gcc-10): 9 warnings


Warnings summary:

    10   net/ipv4/xfrm4_policy.c:268:10: warning: initialization of =E2=80=
=98void (*)(struct dst_ops *)=E2=80=99 from incompatible pointer type =E2=
=80=98int (*)(struct dst_ops *)=E2=80=99 [-Wincompatible-pointer-types]
    7    arch/x86/kernel/process.c:456: Warning: no instruction mnemonic su=
ffix given and no register operands; using default for `btr'
    6    net/ipv6/xfrm6_policy.c:284:10: warning: initialization of =E2=80=
=98void (*)(struct dst_ops *)=E2=80=99 from incompatible pointer type =E2=
=80=98int (*)(struct dst_ops *)=E2=80=99 [-Wincompatible-pointer-types]
    4    arch/x86/entry/entry_64.S:487: Warning: no instruction mnemonic su=
ffix given and no register operands; using default for `btr'
    3    ld: warning: creating DT_TEXTREL in a PIE
    3    WARNING: vmlinux.o (.discard.retpoline_safe): unexpected non-alloc=
atable section.
    3    WARNING: vmlinux.o (.discard.nospec): unexpected non-allocatable s=
ection.
    2    ld: arch/x86/boot/compressed/head_64.o: warning: relocation in rea=
d-only section `.head.text'
    2    drivers/net/ethernet/apm/xgene/xgene_enet_main.c:32:36: warning: a=
rray =E2=80=98xgene_enet_acpi_match=E2=80=99 assumed to have one element
    1    ld: arch/x86/boot/compressed/head_32.o: warning: relocation in rea=
d-only section `.head.text'

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D

Detailed per-defconfig build reports:

---------------------------------------------------------------------------=
-----
allnoconfig (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 3 warnings, 0 sectio=
n mismatches

Warnings:
    arch/x86/entry/entry_64.S:487: Warning: no instruction mnemonic suffix =
given and no register operands; using default for `btr'
    arch/x86/kernel/process.c:456: Warning: no instruction mnemonic suffix =
given and no register operands; using default for `btr'
    arch/x86/kernel/process.c:456: Warning: no instruction mnemonic suffix =
given and no register operands; using default for `btr'

---------------------------------------------------------------------------=
-----
allnoconfig (i386, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section =
mismatches

---------------------------------------------------------------------------=
-----
defconfig (arm64, gcc-10) =E2=80=94 PASS, 0 errors, 2 warnings, 0 section m=
ismatches

Warnings:
    net/ipv4/xfrm4_policy.c:268:10: warning: initialization of =E2=80=98voi=
d (*)(struct dst_ops *)=E2=80=99 from incompatible pointer type =E2=80=98in=
t (*)(struct dst_ops *)=E2=80=99 [-Wincompatible-pointer-types]
    drivers/net/ethernet/apm/xgene/xgene_enet_main.c:32:36: warning: array =
=E2=80=98xgene_enet_acpi_match=E2=80=99 assumed to have one element

---------------------------------------------------------------------------=
-----
defconfig+arm64-chromebook (arm64, gcc-10) =E2=80=94 PASS, 0 errors, 2 warn=
ings, 0 section mismatches

Warnings:
    net/ipv4/xfrm4_policy.c:268:10: warning: initialization of =E2=80=98voi=
d (*)(struct dst_ops *)=E2=80=99 from incompatible pointer type =E2=80=98in=
t (*)(struct dst_ops *)=E2=80=99 [-Wincompatible-pointer-types]
    drivers/net/ethernet/apm/xgene/xgene_enet_main.c:32:36: warning: array =
=E2=80=98xgene_enet_acpi_match=E2=80=99 assumed to have one element

---------------------------------------------------------------------------=
-----
i386_defconfig (i386, gcc-10) =E2=80=94 PASS, 0 errors, 6 warnings, 0 secti=
on mismatches

Warnings:
    net/ipv4/xfrm4_policy.c:268:10: warning: initialization of =E2=80=98voi=
d (*)(struct dst_ops *)=E2=80=99 from incompatible pointer type =E2=80=98in=
t (*)(struct dst_ops *)=E2=80=99 [-Wincompatible-pointer-types]
    net/ipv6/xfrm6_policy.c:284:10: warning: initialization of =E2=80=98voi=
d (*)(struct dst_ops *)=E2=80=99 from incompatible pointer type =E2=80=98in=
t (*)(struct dst_ops *)=E2=80=99 [-Wincompatible-pointer-types]
    WARNING: vmlinux.o (.discard.nospec): unexpected non-allocatable sectio=
n.
    WARNING: vmlinux.o (.discard.retpoline_safe): unexpected non-allocatabl=
e section.
    ld: arch/x86/boot/compressed/head_32.o: warning: relocation in read-onl=
y section `.head.text'
    ld: warning: creating DT_TEXTREL in a PIE

---------------------------------------------------------------------------=
-----
imx_v6_v7_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 2 warnings, 0 s=
ection mismatches

Warnings:
    net/ipv6/xfrm6_policy.c:284:10: warning: initialization of =E2=80=98voi=
d (*)(struct dst_ops *)=E2=80=99 from incompatible pointer type =E2=80=98in=
t (*)(struct dst_ops *)=E2=80=99 [-Wincompatible-pointer-types]
    net/ipv4/xfrm4_policy.c:268:10: warning: initialization of =E2=80=98voi=
d (*)(struct dst_ops *)=E2=80=99 from incompatible pointer type =E2=80=98in=
t (*)(struct dst_ops *)=E2=80=99 [-Wincompatible-pointer-types]

---------------------------------------------------------------------------=
-----
multi_v5_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sec=
tion mismatches

Warnings:
    net/ipv4/xfrm4_policy.c:268:10: warning: initialization of =E2=80=98voi=
d (*)(struct dst_ops *)=E2=80=99 from incompatible pointer type =E2=80=98in=
t (*)(struct dst_ops *)=E2=80=99 [-Wincompatible-pointer-types]

---------------------------------------------------------------------------=
-----
multi_v7_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 2 warnings, 0 se=
ction mismatches

Warnings:
    net/ipv6/xfrm6_policy.c:284:10: warning: initialization of =E2=80=98voi=
d (*)(struct dst_ops *)=E2=80=99 from incompatible pointer type =E2=80=98in=
t (*)(struct dst_ops *)=E2=80=99 [-Wincompatible-pointer-types]
    net/ipv4/xfrm4_policy.c:268:10: warning: initialization of =E2=80=98voi=
d (*)(struct dst_ops *)=E2=80=99 from incompatible pointer type =E2=80=98in=
t (*)(struct dst_ops *)=E2=80=99 [-Wincompatible-pointer-types]

---------------------------------------------------------------------------=
-----
omap2plus_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 2 warnings, 0 s=
ection mismatches

Warnings:
    net/ipv4/xfrm4_policy.c:268:10: warning: initialization of =E2=80=98voi=
d (*)(struct dst_ops *)=E2=80=99 from incompatible pointer type =E2=80=98in=
t (*)(struct dst_ops *)=E2=80=99 [-Wincompatible-pointer-types]
    net/ipv6/xfrm6_policy.c:284:10: warning: initialization of =E2=80=98voi=
d (*)(struct dst_ops *)=E2=80=99 from incompatible pointer type =E2=80=98in=
t (*)(struct dst_ops *)=E2=80=99 [-Wincompatible-pointer-types]

---------------------------------------------------------------------------=
-----
tinyconfig (i386, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section m=
ismatches

---------------------------------------------------------------------------=
-----
tinyconfig (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 2 warnings, 0 section=
 mismatches

Warnings:
    arch/x86/entry/entry_64.S:487: Warning: no instruction mnemonic suffix =
given and no register operands; using default for `btr'
    arch/x86/kernel/process.c:456: Warning: no instruction mnemonic suffix =
given and no register operands; using default for `btr'

---------------------------------------------------------------------------=
-----
vexpress_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 sec=
tion mismatches

Warnings:
    net/ipv4/xfrm4_policy.c:268:10: warning: initialization of =E2=80=98voi=
d (*)(struct dst_ops *)=E2=80=99 from incompatible pointer type =E2=80=98in=
t (*)(struct dst_ops *)=E2=80=99 [-Wincompatible-pointer-types]

---------------------------------------------------------------------------=
-----
x86_64_defconfig (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 9 warnings, 0 s=
ection mismatches

Warnings:
    arch/x86/entry/entry_64.S:487: Warning: no instruction mnemonic suffix =
given and no register operands; using default for `btr'
    arch/x86/kernel/process.c:456: Warning: no instruction mnemonic suffix =
given and no register operands; using default for `btr'
    arch/x86/kernel/process.c:456: Warning: no instruction mnemonic suffix =
given and no register operands; using default for `btr'
    net/ipv6/xfrm6_policy.c:284:10: warning: initialization of =E2=80=98voi=
d (*)(struct dst_ops *)=E2=80=99 from incompatible pointer type =E2=80=98in=
t (*)(struct dst_ops *)=E2=80=99 [-Wincompatible-pointer-types]
    net/ipv4/xfrm4_policy.c:268:10: warning: initialization of =E2=80=98voi=
d (*)(struct dst_ops *)=E2=80=99 from incompatible pointer type =E2=80=98in=
t (*)(struct dst_ops *)=E2=80=99 [-Wincompatible-pointer-types]
    WARNING: vmlinux.o (.discard.nospec): unexpected non-allocatable sectio=
n.
    WARNING: vmlinux.o (.discard.retpoline_safe): unexpected non-allocatabl=
e section.
    ld: arch/x86/boot/compressed/head_64.o: warning: relocation in read-onl=
y section `.head.text'
    ld: warning: creating DT_TEXTREL in a PIE

---------------------------------------------------------------------------=
-----
x86_64_defconfig+x86-board (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 9 war=
nings, 0 section mismatches

Warnings:
    arch/x86/entry/entry_64.S:487: Warning: no instruction mnemonic suffix =
given and no register operands; using default for `btr'
    arch/x86/kernel/process.c:456: Warning: no instruction mnemonic suffix =
given and no register operands; using default for `btr'
    arch/x86/kernel/process.c:456: Warning: no instruction mnemonic suffix =
given and no register operands; using default for `btr'
    net/ipv4/xfrm4_policy.c:268:10: warning: initialization of =E2=80=98voi=
d (*)(struct dst_ops *)=E2=80=99 from incompatible pointer type =E2=80=98in=
t (*)(struct dst_ops *)=E2=80=99 [-Wincompatible-pointer-types]
    net/ipv6/xfrm6_policy.c:284:10: warning: initialization of =E2=80=98voi=
d (*)(struct dst_ops *)=E2=80=99 from incompatible pointer type =E2=80=98in=
t (*)(struct dst_ops *)=E2=80=99 [-Wincompatible-pointer-types]
    WARNING: vmlinux.o (.discard.nospec): unexpected non-allocatable sectio=
n.
    WARNING: vmlinux.o (.discard.retpoline_safe): unexpected non-allocatabl=
e section.
    ld: arch/x86/boot/compressed/head_64.o: warning: relocation in read-onl=
y section `.head.text'
    ld: warning: creating DT_TEXTREL in a PIE

---
For more info write to <info@kernelci.org>

