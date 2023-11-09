Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 729DBC4167D
	for <webhook@archiver.kernel.org>; Thu,  9 Nov 2023 10:32:04 +0000 (UTC)
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
 by mx.groups.io with SMTP id smtpd.web10.118556.1699525924145625825
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 09 Nov 2023 02:32:04 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=TGTIW0Ng;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.181, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-5bd6ac9833fso582718a12.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 09 Nov 2023 02:32:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1699525923; x=1700130723; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=LnzgEzBWMUc7ncQt6Ia8AXAOUfl8Zfs+2J9kqWmSVqw=;
        b=TGTIW0NgWm3Zzd1xzlIMQ+fVK0QKCxTgs2QHAdow49n4EhuHmKJWdL99b3Spk3NW/v
         6y0611tiLRiNFjbRr4aaretcE3Y+LKKXJGMPHG/h+gzUrBq8ihszjHweQmgcVJE0XugE
         uimlStHl2dd5U+sI5ItpgRagj6qdp/K+jpZWuREJXE5kFx10kmq/2OzJhNqLQ13JxQBL
         EnsWgIuqGTQ1M2NIi+lxsim5WmnUmhCq+vOeOvpHR2g2L1DnrA14pwQjS8Qi2Z5NZftw
         MBqoul0OxS8iFUJtWUv+DPNba9cBIpt5q1TglcgH0m7nbL8ig5jxIBO9/CCHR7GoJQdL
         Dgjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699525923; x=1700130723;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LnzgEzBWMUc7ncQt6Ia8AXAOUfl8Zfs+2J9kqWmSVqw=;
        b=t+MfHnEuS9NtwVd64/w37jxvj/yUhesF/+duJgoMzXuB9BfYskkj6NhDIcQJWAwWzI
         HBaW5pWoqhxWEYmWpWqDQ/ddUI7w3wuEsiIjs4xcmKqrHhOaGB1cdivQYXJ9n4uTvjxn
         UuJloa+OMnyj4C+XYW2mSKHiqK3+teP6i1x+lrrRCkL5BkNiT1sXYp6NgMHU03NhJd4i
         YKa7FRAburI5csKbS2LVFAI8ys+UML1Ki5dNd2gLShqE4GpDtXjCm/JoLgEe33NxieqB
         gMBBZ6xt1ZxqaWRpjE+uECOlfDF+o8Ut2O4T95Q1TjyKjOQr4ra2gfbcXVX/ywVZ7uu8
         tqbw==
X-Gm-Message-State: AOJu0Yya8hbApdMzRkQMAlqRh201Nygrelr3Wkcdr598CpW6+qNhxL/+
	cD48nWNvafBB6vsim5MumlQkHqvY3mzOH52GN7fNKQ==
X-Google-Smtp-Source: AGHT+IEr8lQJPbV6/MqvGGAXxsASfbvxNtH07wwzfI08EfUhF8Lr+Q9+aeoi8IcSrJuLALw3rtt8+Q==
X-Received: by 2002:a05:6a20:1589:b0:181:ed8b:4823 with SMTP id h9-20020a056a20158900b00181ed8b4823mr5328343pzj.43.1699525923093;
        Thu, 09 Nov 2023 02:32:03 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id b4-20020a170902d50400b001cc29ffcd96sm3214521plg.192.2023.11.09.02.32.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 02:32:02 -0800 (PST)
Message-ID: <654cb522.170a0220.25842.98e2@mx.google.com>
Date: Thu, 09 Nov 2023 02:32:02 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v4.4-st20-1873-g923c12c3034a
X-Kernelci-Report-Type: build
X-Kernelci-Branch: linux-4.4.y-st
X-Kernelci-Tree: cip
Subject: cip/linux-4.4.y-st build: 14 builds: 2 failed, 12 passed,
 21 warnings (v4.4-st20-1873-g923c12c3034a)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 09 Nov 2023 10:32:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13546

cip/linux-4.4.y-st build: 14 builds: 2 failed, 12 passed, 21 warnings (v4.4=
-st20-1873-g923c12c3034a)

Full Build Summary: https://kernelci.org/build/cip/branch/linux-4.4.y-st/ke=
rnel/v4.4-st20-1873-g923c12c3034a/

Tree: cip
Branch: linux-4.4.y-st
Git Describe: v4.4-st20-1873-g923c12c3034a
Git Commit: 923c12c3034a722a05be4d57d05334cb7bc3c27e
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
Built: 4 unique architectures

Build Failures Detected:

arm64:
    defconfig+arm64-chromebook: (gcc-10) FAIL

x86_64:
    x86_64_defconfig+x86-board: (gcc-10) FAIL

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
    x86_64_defconfig+x86-board (gcc-10): 3 warnings


Warnings summary:

    7    arch/x86/kernel/process.c:456: Warning: no instruction mnemonic su=
ffix given and no register operands; using default for `btr'
    4    arch/x86/entry/entry_64.S:487: Warning: no instruction mnemonic su=
ffix given and no register operands; using default for `btr'
    2    ld: warning: creating DT_TEXTREL in a PIE
    2    drivers/net/ethernet/apm/xgene/xgene_enet_main.c:32:36: warning: a=
rray =E2=80=98xgene_enet_acpi_match=E2=80=99 assumed to have one element
    2    WARNING: vmlinux.o (.discard.retpoline_safe): unexpected non-alloc=
atable section.
    2    WARNING: vmlinux.o (.discard.nospec): unexpected non-allocatable s=
ection.
    1    ld: arch/x86/boot/compressed/head_64.o: warning: relocation in rea=
d-only section `.head.text'
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
defconfig+arm64-chromebook (arm64, gcc-10) =E2=80=94 FAIL, 0 errors, 1 warn=
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
x86_64_defconfig+x86-board (x86_64, gcc-10) =E2=80=94 FAIL, 0 errors, 3 war=
nings, 0 section mismatches

Warnings:
    arch/x86/entry/entry_64.S:487: Warning: no instruction mnemonic suffix =
given and no register operands; using default for `btr'
    arch/x86/kernel/process.c:456: Warning: no instruction mnemonic suffix =
given and no register operands; using default for `btr'
    arch/x86/kernel/process.c:456: Warning: no instruction mnemonic suffix =
given and no register operands; using default for `btr'

---
For more info write to <info@kernelci.org>

