Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 342E7C4828F
	for <webhook@archiver.kernel.org>; Fri,  2 Feb 2024 22:06:27 +0000 (UTC)
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
 by mx.groups.io with SMTP id smtpd.web10.5387.1706911585469590642
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 02 Feb 2024 14:06:25 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=aj6Gfy3R;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.177, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1d7354ba334so22479515ad.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 02 Feb 2024 14:06:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1706911584; x=1707516384; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ddZLRtvCw/g89vhju5T2NLu26FhNcAzCPhw5Uy0xh3c=;
        b=aj6Gfy3Ry6VX/Vrx/1O0acwRaSY2UAhPLfLffXROx125ux/gnIBqdIQ7l1SpO2njvU
         kTxS0N2t6UfVg5bKTh1+mrQ2f5HgKrJYfZLEyeyMOGHgyxzjjTUvHuLtspyo3E0EHiHR
         2SRuFU0iYRpE4N50pC3zLRejnWTjOEl7k8DbEQy3V3DIF+aGscjO/R8ifnNXiqkEe4US
         iQZiF2ui1mFzErYBpeqyovndfnVrwwkQnnDkqLSiwOUfgaP/mic2xl01ZoFiQhiRLJ5n
         mFnzUvffhqcSlcdAQOmeQg79646c8jCin/A2b3fPch7rRKbBs+tZNu1RXIf6O9bDREhQ
         r3pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706911584; x=1707516384;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ddZLRtvCw/g89vhju5T2NLu26FhNcAzCPhw5Uy0xh3c=;
        b=wHjxNfAKDLcsBS2Ai15JHvugQ7QzzW+FJYeMwLFHZPZyUOOaR6Y0SURmJP5Jrf8utn
         TIBRiJViPjk200+SQflA//43idTLxQ+AQgZG78G29HAVXMEHyE8WZXnRa2vJ5U9OmhXS
         uv4RbSGXxREXP4YdZ/sCnmg+veihX6uR6gJ5L7bxRRTKBX2Y00L9L3OyFNUumOsDeZkr
         9ZYIPFyMKRCl1xobNrLrT7ln9HDKPgH2qI3HMJoT/AAg/6mWoyWt7RhbM5OhMzWGYnyV
         oa56saqOqAZapAsXPiCFCNIVzGNL9hBG6fo27CIORHFI4X/ZceAdBKb82gKjzZgYVd/2
         PJ9g==
X-Gm-Message-State: AOJu0Yx341ILklxy1zyv7i55BznOxCPTuSGMIprVbSxfkeWoXuEt8V+N
	DG4BPzN52FSEm3H35wYS7l3MSFiptDLIpP7kQFMw3w2Zc3I0ReLNc+sQMiGmShHeUcLlokL3dKk
	6ZZuFiw==
X-Google-Smtp-Source: AGHT+IEWJtYYPpcfegYvtUHopm8dK2fajB6At/Y9dQnkw5QvjRCB+FUyqmtdiHRwZQ1BEH4VtjDYWQ==
X-Received: by 2002:a17:902:f68a:b0:1d8:fb17:a1f2 with SMTP id l10-20020a170902f68a00b001d8fb17a1f2mr13320881plg.34.1706911584453;
        Fri, 02 Feb 2024 14:06:24 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCU80CWWzmjyRjcBSoJp9VCCV3G4YYEGmq83pZ2YvhjMqIWgShWLk3bGraTGhjS3YR0RgeMuGwJoEdz+k+HhMcYi2IkooS4W6c15P8l4JkPP6VspUElqnez96begRi45atXSmGTlIFwuCm0HhfAOX0qJsg==
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id q2-20020a170902e30200b001d92db44c9bsm2106496plc.17.2024.02.02.14.06.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 14:06:23 -0800 (PST)
Message-ID: <65bd675f.170a0220.222f.9350@mx.google.com>
Date: Fri, 02 Feb 2024 14:06:23 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-4.4.y-st
X-Kernelci-Kernel: v4.4-st20-2045-g32c8d563e356f
X-Kernelci-Report-Type: build
Subject: cip/linux-4.4.y-st build: 14 builds: 0 failed, 14 passed,
 25 warnings (v4.4-st20-2045-g32c8d563e356f)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 02 Feb 2024 22:06:27 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14636

cip/linux-4.4.y-st build: 14 builds: 0 failed, 14 passed, 25 warnings (v4.4=
-st20-2045-g32c8d563e356f)

Full Build Summary: https://kernelci.org/build/cip/branch/linux-4.4.y-st/ke=
rnel/v4.4-st20-2045-g32c8d563e356f/

Tree: cip
Branch: linux-4.4.y-st
Git Describe: v4.4-st20-2045-g32c8d563e356f
Git Commit: 32c8d563e356f1b156afc0ba28f0aee7561dd2b6
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

