Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F7B4C001B0
	for <webhook@archiver.kernel.org>; Wed, 16 Aug 2023 13:53:59 +0000 (UTC)
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
 by mx.groups.io with SMTP id smtpd.web11.161095.1692194037954253418
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 16 Aug 2023 06:53:58 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=X7WT5qQL;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.172, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1bc34b32785so42078325ad.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 16 Aug 2023 06:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1692194037; x=1692798837;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=AW4+LdwJPuj7MxR1l6yIvHd0PjbyJCB82Tor+SxuaZY=;
        b=X7WT5qQLFGRSMJsIW0LigRCnVJZq6ZF3cbFzwHJTZdMCoi5TpAy9M0zRrA3LjoMJV3
         hydT1yzBcn0Q6ZzgnLfG5WtwdYMxQhZFqzc0FB1yxp2iectZp6wDEQgLyS7zY0e/Frsf
         hxAak2am7mvhAOS3V6uEQNS+U4IfnSNZ71XZaZ3mJaqk2ZlWb+Gr54+yb23KGcQNL/rh
         P1gSQfzeUz4f206m0rsMha3sMZZ0SFwxBeJFbqeWNDEJsVPbDVcEVK4LR8XQMINwrZE/
         8eJbXlsa+9kNrxdd+gVWT5szyk68sCsy2GhezBOQO7wI74csmKOu7MdSj0vJnUwUIgmg
         8eOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692194037; x=1692798837;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AW4+LdwJPuj7MxR1l6yIvHd0PjbyJCB82Tor+SxuaZY=;
        b=lte2A37MaKDZN64z9wcwjW9k5LfIo7jxj12/VKF85TUJfxW3egm5bhkvXBfcvslAU8
         EG9xLpbptEgSYFNuYTL2KF9ZtJ7/p917J7Xf3VlqlYr5alt2b8RyV12hydYGPgTx+9dd
         P6rDJb24IRDqMPFWpYbIrCLdEoYWtFCHUsOpNllrvaJJlqTPMPOwLSyOeDUvW5GY26nm
         +ARmcbdLr+YXO9+lsh7OgFew/lx6vL/ZsJ8s9qBGwFHK+L2FZPSCA0UKYrt45qhWesLD
         +sEfEyVqO7m8ies7WWictxPhwA3UElSgOUGrfh3MXkiMphrSM1htgME7IzlpLIJQZoO4
         zzLQ==
X-Gm-Message-State: AOJu0YxBA6cO8JeCcMC7iHAX8CXy440QIciO91xd6WX92hIr0eWZ8Q9m
	fU5l8G8o5ZSPTkhfh00qA33wyfZ4a4gQOU7kUz2cxg==
X-Google-Smtp-Source: AGHT+IHHR4dy9lbZQX25uXEVuCRE7kbCduRrOfJPwYGGPTg/JUDEUO8htnhliOwOdvRBfgwyMOy0dw==
X-Received: by 2002:a17:902:7e83:b0:1bc:8748:8bbf with SMTP id z3-20020a1709027e8300b001bc87488bbfmr1584333pla.52.1692194036923;
        Wed, 16 Aug 2023 06:53:56 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id 13-20020a170902c20d00b001bbb8d5166bsm13170943pll.123.2023.08.16.06.53.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 06:53:56 -0700 (PDT)
Message-ID: <64dcd4f4.170a0220.aa29a.8c17@mx.google.com>
Date: Wed, 16 Aug 2023 06:53:56 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v4.4-st20-2312-g74888f4b13f0
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-4.4.y-st-rt
Subject: cip/linux-4.4.y-st-rt build: 14 builds: 0 failed, 14 passed,
 34 warnings (v4.4-st20-2312-g74888f4b13f0)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 16 Aug 2023 13:53:59 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12680

cip/linux-4.4.y-st-rt build: 14 builds: 0 failed, 14 passed, 34 warnings (v=
4.4-st20-2312-g74888f4b13f0)

Full Build Summary: https://kernelci.org/build/cip/branch/linux-4.4.y-st-rt=
/kernel/v4.4-st20-2312-g74888f4b13f0/

Tree: cip
Branch: linux-4.4.y-st-rt
Git Describe: v4.4-st20-2312-g74888f4b13f0
Git Commit: 74888f4b13f0cb22c1c00a5622e0cf2dbebe60ea
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
Built: 4 unique architectures

Warnings Detected:

arm64:
    defconfig (gcc-10): 1 warning
    defconfig+arm64-chromebook (gcc-10): 1 warning

arm:
    imx_v6_v7_defconfig (gcc-10): 1 warning
    omap2plus_defconfig (gcc-10): 1 warning

i386:
    allnoconfig (gcc-10): 1 warning
    i386_defconfig (gcc-10): 5 warnings
    tinyconfig (gcc-10): 1 warning

x86_64:
    allnoconfig (gcc-10): 4 warnings
    tinyconfig (gcc-10): 3 warnings
    x86_64_defconfig (gcc-10): 8 warnings
    x86_64_defconfig+x86-chromebook (gcc-10): 8 warnings


Warnings summary:

    7    arch/x86/kernel/process.c:456: Warning: no instruction mnemonic su=
ffix given and no register operands; using default for `btr'
    7    arch/x86/kernel/cpu/amd.c:753: warning: "MSR_AMD64_DE_CFG" redefin=
ed
    4    arch/x86/entry/entry_64.S:487: Warning: no instruction mnemonic su=
ffix given and no register operands; using default for `btr'
    3    ld: warning: creating DT_TEXTREL in a PIE
    3    WARNING: vmlinux.o (.discard.retpoline_safe): unexpected non-alloc=
atable section.
    3    WARNING: vmlinux.o (.discard.nospec): unexpected non-allocatable s=
ection.
    2    ld: arch/x86/boot/compressed/head_64.o: warning: relocation in rea=
d-only section `.head.text'
    2    drivers/usb/gadget/function/f_ncm.c:1565:19: warning: assignment t=
o =E2=80=98struct config_group *=E2=80=99 from =E2=80=98int=E2=80=99 makes =
pointer from integer without a cast [-Wint-conversion]
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
i386_defconfig (i386, gcc-10) =E2=80=94 PASS, 0 errors, 5 warnings, 0 secti=
on mismatches

Warnings:
    arch/x86/kernel/cpu/amd.c:753: warning: "MSR_AMD64_DE_CFG" redefined
    WARNING: vmlinux.o (.discard.nospec): unexpected non-allocatable sectio=
n.
    WARNING: vmlinux.o (.discard.retpoline_safe): unexpected non-allocatabl=
e section.
    ld: arch/x86/boot/compressed/head_32.o: warning: relocation in read-onl=
y section `.head.text'
    ld: warning: creating DT_TEXTREL in a PIE

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
omap2plus_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 se=
ction mismatches

Warnings:
    drivers/usb/gadget/function/f_ncm.c:1565:19: warning: assignment to =E2=
=80=98struct config_group *=E2=80=99 from =E2=80=98int=E2=80=99 makes point=
er from integer without a cast [-Wint-conversion]

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
tinyconfig (i386, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 section mi=
smatches

Warnings:
    arch/x86/kernel/cpu/amd.c:753: warning: "MSR_AMD64_DE_CFG" redefined

---------------------------------------------------------------------------=
-----
vexpress_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 se=
ction mismatches

---------------------------------------------------------------------------=
-----
x86_64_defconfig (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 8 warnings, 0 s=
ection mismatches

Warnings:
    arch/x86/entry/entry_64.S:487: Warning: no instruction mnemonic suffix =
given and no register operands; using default for `btr'
    arch/x86/kernel/process.c:456: Warning: no instruction mnemonic suffix =
given and no register operands; using default for `btr'
    arch/x86/kernel/process.c:456: Warning: no instruction mnemonic suffix =
given and no register operands; using default for `btr'
    arch/x86/kernel/cpu/amd.c:753: warning: "MSR_AMD64_DE_CFG" redefined
    WARNING: vmlinux.o (.discard.nospec): unexpected non-allocatable sectio=
n.
    WARNING: vmlinux.o (.discard.retpoline_safe): unexpected non-allocatabl=
e section.
    ld: arch/x86/boot/compressed/head_64.o: warning: relocation in read-onl=
y section `.head.text'
    ld: warning: creating DT_TEXTREL in a PIE

---------------------------------------------------------------------------=
-----
x86_64_defconfig+x86-chromebook (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, =
8 warnings, 0 section mismatches

Warnings:
    arch/x86/entry/entry_64.S:487: Warning: no instruction mnemonic suffix =
given and no register operands; using default for `btr'
    arch/x86/kernel/process.c:456: Warning: no instruction mnemonic suffix =
given and no register operands; using default for `btr'
    arch/x86/kernel/process.c:456: Warning: no instruction mnemonic suffix =
given and no register operands; using default for `btr'
    arch/x86/kernel/cpu/amd.c:753: warning: "MSR_AMD64_DE_CFG" redefined
    WARNING: vmlinux.o (.discard.nospec): unexpected non-allocatable sectio=
n.
    WARNING: vmlinux.o (.discard.retpoline_safe): unexpected non-allocatabl=
e section.
    ld: arch/x86/boot/compressed/head_64.o: warning: relocation in read-onl=
y section `.head.text'
    ld: warning: creating DT_TEXTREL in a PIE

---
For more info write to <info@kernelci.org>

