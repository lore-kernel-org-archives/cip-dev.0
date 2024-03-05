Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CCD1C54798
	for <webhook@archiver.kernel.org>; Tue,  5 Mar 2024 12:47:14 +0000 (UTC)
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
 by mx.groups.io with SMTP id smtpd.web11.22026.1709642829767493323
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 05 Mar 2024 04:47:09 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=essMgsVj;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.181, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-5d8b519e438so5228806a12.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 05 Mar 2024 04:47:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1709642829; x=1710247629; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=fbYZo7akJeD6/2tlXYJY9jLhIDlL8twbtIggg0DWFIo=;
        b=essMgsVjnd8Wm5ZkwlgfbkApG/X3T7VymbZ0WiKfKAW5eZ6A9WBPP3wFY/n0K+/gu9
         MYD2CHyol9spuEveitAVe1Cs8/NMA1Boxr6T312Kjw8jLcQCdlUIIDWm70mvNJs8WbGo
         3J/rdQRxj3mNOtt/Rjq+hAWVoIPEBOK+7TUAAhnUrSfRhZ9RBOp4dH9nGeXJsfImrfXi
         H1aozS39Opdr3oXBPXdYH6iyFSWEnvDEJhFYhUwtrffNEsohk93LVntjUiVAXYL295Ij
         vd3959mG6jZQlWgqgpxkfmyFnLF2Q5IcR92QqiCv5Wd66bvZUvkY2Eo05KI46sb2i8Cv
         vkOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709642829; x=1710247629;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fbYZo7akJeD6/2tlXYJY9jLhIDlL8twbtIggg0DWFIo=;
        b=AHweyMUHygLyCTw7sJ1VYa2xJ9kZ+SbY4/evsqwhgtVi8OpUbndkodm1CQ4DuTDw9f
         3JvtwWCyMswwl1gmt89Uka0n8n8ZpGGjlWiG0TPTp2LkAB1103hpzzkh1HPIGQH9drYL
         8zS0/b+AhQ+EmA5zjUsE2waDKeldti86PsTDCDrxbzqaRIlpYs7g6vKLZZRdluhq7SAx
         K4ToBmHtcmNbrrZBGuzMFlbtsMMWyDFrTzo3tp1pGLgXWmKtXqoomOG3L8iPJJPl9vCo
         aUi6Et14spGI2+NF/92Op6hQDN7shpSUMZ/9ymEEBx0LnBfBWE48dd0yH0UhfacvgJqH
         OMGA==
X-Gm-Message-State: AOJu0YyzvgxWgAwOIaD5bwBa7jSxZVg2ZCnEEZJF2ELU+QmJFfUTLy95
	O78PkUt137s/OAqiNWbitm422+haMPE3tE+8QNEPBHVodQbjmkWr2f2OetkMZaCq41++9mnxKP1
	dt8A=
X-Google-Smtp-Source: AGHT+IHwQT3A5Nt2LyLqGt7WmoxyiuiSHCNpZBPWnFiLgr5ntLTfFKhc7MKvy+1EaLEJAWFq0n9fHQ==
X-Received: by 2002:a05:6a20:2451:b0:1a1:50c3:d579 with SMTP id t17-20020a056a20245100b001a150c3d579mr1838724pzc.26.1709642828497;
        Tue, 05 Mar 2024 04:47:08 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id d2-20020a63bd42000000b005dc832ed816sm7924975pgp.59.2024.03.05.04.47.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 04:47:08 -0800 (PST)
Message-ID: <65e7144c.630a0220.741f8.ce53@mx.google.com>
Date: Tue, 05 Mar 2024 04:47:08 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.4.y-st-rc
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v4.4-st20-2247-g140bf69dc64d
X-Kernelci-Report-Type: build
Subject: cip/linux-4.4.y-st-rc build: 14 builds: 0 failed, 14 passed,
 25 warnings (v4.4-st20-2247-g140bf69dc64d)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 05 Mar 2024 12:47:14 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15221

cip/linux-4.4.y-st-rc build: 14 builds: 0 failed, 14 passed, 25 warnings (v=
4.4-st20-2247-g140bf69dc64d)

Full Build Summary: https://kernelci.org/build/cip/branch/linux-4.4.y-st-rc=
/kernel/v4.4-st20-2247-g140bf69dc64d/

Tree: cip
Branch: linux-4.4.y-st-rc
Git Describe: v4.4-st20-2247-g140bf69dc64d
Git Commit: 140bf69dc64d0cace758052e3af9e9cc3e90a09f
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
Built: 4 unique architectures

Warnings Detected:

arm64:
    defconfig (gcc-10): 1 warning
    defconfig+arm64-chromebook (gcc-10): 1 warning

arm:

i386:
    i386_defconfig (gcc-10): 4 warnings

x86_64:
    allnoconfig (gcc-10): 3 warnings
    tinyconfig (gcc-10): 2 warnings
    x86_64_defconfig (gcc-10): 7 warnings
    x86_64_defconfig+x86-board (gcc-10): 7 warnings


Warnings summary:

    7    arch/x86/kernel/process.c:456: Warning: no instruction mnemonic su=
ffix given and no register operands; using default for `btr'
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
i386_defconfig (i386, gcc-10) =E2=80=94 PASS, 0 errors, 4 warnings, 0 secti=
on mismatches

Warnings:
    WARNING: vmlinux.o (.discard.nospec): unexpected non-allocatable sectio=
n.
    WARNING: vmlinux.o (.discard.retpoline_safe): unexpected non-allocatabl=
e section.
    ld: arch/x86/boot/compressed/head_32.o: warning: relocation in read-onl=
y section `.head.text'
    ld: warning: creating DT_TEXTREL in a PIE

---------------------------------------------------------------------------=
-----
imx_v6_v7_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 s=
ection mismatches

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
omap2plus_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 s=
ection mismatches

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
vexpress_defconfig (arm, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 se=
ction mismatches

---------------------------------------------------------------------------=
-----
x86_64_defconfig (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 7 warnings, 0 s=
ection mismatches

Warnings:
    arch/x86/entry/entry_64.S:487: Warning: no instruction mnemonic suffix =
given and no register operands; using default for `btr'
    arch/x86/kernel/process.c:456: Warning: no instruction mnemonic suffix =
given and no register operands; using default for `btr'
    arch/x86/kernel/process.c:456: Warning: no instruction mnemonic suffix =
given and no register operands; using default for `btr'
    WARNING: vmlinux.o (.discard.nospec): unexpected non-allocatable sectio=
n.
    WARNING: vmlinux.o (.discard.retpoline_safe): unexpected non-allocatabl=
e section.
    ld: arch/x86/boot/compressed/head_64.o: warning: relocation in read-onl=
y section `.head.text'
    ld: warning: creating DT_TEXTREL in a PIE

---------------------------------------------------------------------------=
-----
x86_64_defconfig+x86-board (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 7 war=
nings, 0 section mismatches

Warnings:
    arch/x86/entry/entry_64.S:487: Warning: no instruction mnemonic suffix =
given and no register operands; using default for `btr'
    arch/x86/kernel/process.c:456: Warning: no instruction mnemonic suffix =
given and no register operands; using default for `btr'
    arch/x86/kernel/process.c:456: Warning: no instruction mnemonic suffix =
given and no register operands; using default for `btr'
    WARNING: vmlinux.o (.discard.nospec): unexpected non-allocatable sectio=
n.
    WARNING: vmlinux.o (.discard.retpoline_safe): unexpected non-allocatabl=
e section.
    ld: arch/x86/boot/compressed/head_64.o: warning: relocation in read-onl=
y section `.head.text'
    ld: warning: creating DT_TEXTREL in a PIE

---
For more info write to <info@kernelci.org>

