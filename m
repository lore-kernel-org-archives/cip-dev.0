Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F3E3E748FC
	for <webhook@archiver.kernel.org>; Mon,  2 Oct 2023 17:19:36 +0000 (UTC)
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
 by mx.groups.io with SMTP id smtpd.web11.88224.1696267165943221168
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 02 Oct 2023 10:19:26 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=OqGwjuZQ;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.176, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-578d791dd91so2311666a12.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 02 Oct 2023 10:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1696267164; x=1696871964; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=aHnsp3u+K9fCjjNSLbSjNHIrXfsKHsvSYmq/9t5SwFQ=;
        b=OqGwjuZQWO7WC6ukDpmk5BpGkMmBmZ2OrW55fJHDMQM3zhTVkqz38J1Lui4546w7Ni
         y94ijVoN4gD3nmn7HDz00hzAbKazmfaZ89w1ZjBae/S91ttnvL4x2vffro8lMWEfVvBF
         7x4uQd6zBEGNZKqbFfxieFpb+jlrDTex26ftCqxo5WWufhGFcuQZQ13RbQQ4sviHf6H1
         8dopcVlS8GVNOBI9LThiaPqBQ4MEqnr6sHyZClz4/XELthfb9+trCjdRnjBgk/6l0Z6m
         LlV6lqVVtlBivnsZvSQlxBLbk0clnOb39UWG6JRNqDxNbVvLhE/KZPuA0CXYdb1Z1IHp
         VW1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696267164; x=1696871964;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aHnsp3u+K9fCjjNSLbSjNHIrXfsKHsvSYmq/9t5SwFQ=;
        b=DrHpUM+ElkdVR+ZcMMq1edvfnM9WDYT00EZV4KGswOKgTpd9Tv83ZAIWczy1xUixAx
         f8ULCDld6vEyIvpsJ7ocbxP9z5FZwYZNm9IKO1Wftmm0NWRG5CGhA0db+HP07yLSiaVZ
         oQ2ZIqSLX1sDTEIuSodB2Ag1yqR4wjJy7H/fwAKQWefvYEvizcglflyWhprcOotaxqu9
         U7BYqk2H2sjEk9p4rknMflxKYVzM3sU/FrjQRuc9SBodl8Pt0PoJ+o4yvw5tKEwBm1jG
         M53dZeuwL4Z50fwu69RA0AtsfaVcLPJofRSmO5Mx4W8aYtJxgPtdxq8XL2En8fDL4L9s
         5qxA==
X-Gm-Message-State: AOJu0Yx/0pcY9Z9V7ocnhyzU56luUWD3dTpvmosFukBVjqn9p/D6XzTk
	ALqmhRe3fD+l1EYy1+XBxgTw8sLP1USIcmT8nUCd+w==
X-Google-Smtp-Source: AGHT+IHLdfa/QzPxkvUrLJzz9d8fsAwiIzHK4NV596ClSQfgAAl4wQXFJoDeyRhHi3BsfsofKndd9g==
X-Received: by 2002:a05:6a20:5488:b0:134:73f6:5832 with SMTP id i8-20020a056a20548800b0013473f65832mr377920pzk.16.1696267164265;
        Mon, 02 Oct 2023 10:19:24 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id p4-20020a62ab04000000b006887be16675sm4156903pff.205.2023.10.02.10.19.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 10:19:23 -0700 (PDT)
Message-ID: <651afb9b.620a0220.74a8a.8492@mx.google.com>
Date: Mon, 02 Oct 2023 10:19:23 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.4.y-st-rc
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v4.4-st20-1779-g48d33e0df7175
X-Kernelci-Report-Type: build
Subject: cip/linux-4.4.y-st-rc build: 14 builds: 0 failed, 14 passed,
 27 warnings (v4.4-st20-1779-g48d33e0df7175)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 02 Oct 2023 17:19:36 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13260

cip/linux-4.4.y-st-rc build: 14 builds: 0 failed, 14 passed, 27 warnings (v=
4.4-st20-1779-g48d33e0df7175)

Full Build Summary: https://kernelci.org/build/cip/branch/linux-4.4.y-st-rc=
/kernel/v4.4-st20-1779-g48d33e0df7175/

Tree: cip
Branch: linux-4.4.y-st-rc
Git Describe: v4.4-st20-1779-g48d33e0df7175
Git Commit: 48d33e0df7175b69a683cece4408dc61d3daf8dc
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
    i386_defconfig (gcc-10): 4 warnings

x86_64:
    allnoconfig (gcc-10): 3 warnings
    tinyconfig (gcc-10): 2 warnings
    x86_64_defconfig (gcc-10): 7 warnings
    x86_64_defconfig+x86-chromebook (gcc-10): 7 warnings


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
x86_64_defconfig+x86-chromebook (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, =
7 warnings, 0 section mismatches

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

