Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44376C4167B
	for <webhook@archiver.kernel.org>; Mon, 11 Dec 2023 06:42:51 +0000 (UTC)
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
 by mx.groups.io with SMTP id smtpd.web11.2822.1702276963193437899
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sun, 10 Dec 2023 22:42:43 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=wJld0/MO;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.175, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6cebbf51742so2706484b3a.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Sun, 10 Dec 2023 22:42:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1702276962; x=1702881762; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=whJn08Vsdr/G+5Wcs6ajjb3cR1nn/O5M8gabp2DAGB4=;
        b=wJld0/MOUR4JsrR09WIIQ8CpukmclxdOnn3kYaWaqjubqFqAJVmD4LbRvue/LypRVI
         OX0wIpxlpJdc/K664kDEpwHCQvLipg00/n6a2e+z619Bxd9BlQuS81ff2ROIUiUPjdt+
         2KTxjFQo3Yjwjbw6GlJYMMn2JxsQ+OeE9zTdbrz6unDZF7VMbpIqddqaMy6bDNBaY7Zn
         URDii4FVa1igF4kgvrxhOzCxcFX87IZ4w7NTWru1zmxNDksiSWMlhyestXsiW3jL9j2L
         LDDuMhmD6xuhiIeuPI2Js2EoOVFPQSvZI3NCjpgBt1FmKNF1K4aqIWJ0e8lqdJihTAeg
         Ew3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702276962; x=1702881762;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=whJn08Vsdr/G+5Wcs6ajjb3cR1nn/O5M8gabp2DAGB4=;
        b=oUDQOlD2N1ZU0zM7qoLtr1eRcJfFq2mtewjJeLsWN1r1O2TJL6bhRO8N68ilFfMu9P
         Q3uNcsoRwWqYrxbrleFhVzvkgFmF37YSPpkn8ds61XqH6QZBrQLmlOi7IVD5cgVwM4vX
         E43G62zXgKSV9cJZ/M+gpWrohD5cduT6CMbcqonlqTVDN1kk85lolFsfXwa1LQr6iscZ
         6oNCcZ6ediFd/COAg4xXAyIs6uZivspAtEBhcFwOjhjCIHWcB06d69RHl9BFJZYlC5f0
         kB472JtuibfJG9XuptCPNXY34cSBZWiRFWJbbNXY0jPJ9Q49AouQn1mY7bIkO9PL1azo
         nitg==
X-Gm-Message-State: AOJu0YwmKRm1mCexWLqFQJh0pNfairkA1B1nopxCzsI2pnx/SlcUJuqv
	VhoZwEOrpHHac1U6H6cTubkuIR0T8bQQvLjgJfrrtQ==
X-Google-Smtp-Source: AGHT+IFYV0jIvwRt1TlOSsEpHYUAWkPxJ54CkuKdX2wFEw5WeD4shlFamMXifa2OizxwJ+CqBwvxSw==
X-Received: by 2002:a05:6a00:2303:b0:6ce:945d:80eb with SMTP id h3-20020a056a00230300b006ce945d80ebmr6394651pfh.2.1702276962110;
        Sun, 10 Dec 2023 22:42:42 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id p20-20020a056a000a1400b006cde06a7b66sm5706369pfh.172.2023.12.10.22.42.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Dec 2023 22:42:41 -0800 (PST)
Message-ID: <6576af61.050a0220.71a42.f9ab@mx.google.com>
Date: Sun, 10 Dec 2023 22:42:41 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.4.y-st
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v4.4-st20-1988-gdf21aeeacf3cd
Subject: cip/linux-4.4.y-st build: 14 builds: 0 failed, 14 passed,
 25 warnings (v4.4-st20-1988-gdf21aeeacf3cd)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 11 Dec 2023 06:42:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13993

cip/linux-4.4.y-st build: 14 builds: 0 failed, 14 passed, 25 warnings (v4.4=
-st20-1988-gdf21aeeacf3cd)

Full Build Summary: https://kernelci.org/build/cip/branch/linux-4.4.y-st/ke=
rnel/v4.4-st20-1988-gdf21aeeacf3cd/

Tree: cip
Branch: linux-4.4.y-st
Git Describe: v4.4-st20-1988-gdf21aeeacf3cd
Git Commit: df21aeeacf3cd115619050fa97b2f131485aeaa8
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
tinyconfig (x86_64, gcc-10) =E2=80=94 PASS, 0 errors, 2 warnings, 0 section=
 mismatches

Warnings:
    arch/x86/entry/entry_64.S:487: Warning: no instruction mnemonic suffix =
given and no register operands; using default for `btr'
    arch/x86/kernel/process.c:456: Warning: no instruction mnemonic suffix =
given and no register operands; using default for `btr'

---------------------------------------------------------------------------=
-----
tinyconfig (i386, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section m=
ismatches

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

