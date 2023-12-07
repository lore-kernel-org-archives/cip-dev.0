Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99F80C4167B
	for <webhook@archiver.kernel.org>; Thu,  7 Dec 2023 06:48:34 +0000 (UTC)
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
 by mx.groups.io with SMTP id smtpd.web10.78313.1701931714054038233
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 06 Dec 2023 22:48:34 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=SMgjzTKS;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.179, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1d03fb57b69so4236445ad.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 06 Dec 2023 22:48:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1701931713; x=1702536513; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=QNDlaL/cQjMMVzGHegI+RrHg+31PIeytdCe//epHTOw=;
        b=SMgjzTKSGQlPoAlXMj0BW9oAmAiGezP9RMRJSGNO00HjxfufJdtIvf5Wyuz/7Y2i3w
         6m+uquOYHhUKe7ltNpySDfVdRzSs6dbBIKua1DxiyIr03Vl9T+k8tQIGjjRabqsoV/z/
         bR00pt82NEcweld6/9lmMldESImjYYyESU0nZ/QwVCQgk44337EHpysdT4/+IkeXyCF9
         9vrBbEP0Ej2GRPbm6+iEdlqzumFviLRX/wWDM/NJaln9YXVr/+wBl0HbL9h7WKOnot0K
         1gvXRs+EAUmvfLr54QHrU0/0Q0ydNM0I7zetYTDpVWzjUR1W3PK2f22s67eqfc2HdYjc
         tgrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701931713; x=1702536513;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QNDlaL/cQjMMVzGHegI+RrHg+31PIeytdCe//epHTOw=;
        b=saNmGoObUEIUUH5PeFu5QIyy9Ey0nvI4NQn+f8resJYOa8YWYL2b607pQalr6qKkXs
         BpY7+oZ1Ym4rReUqmHVnfTI5aj/Y+sgW4mAKibJ6CFOCR1xLblqN9wrnJAsry48j3dtc
         VeTYIbV+aW5s1MwGD0U2EQlWIZ1T4ekNcqRU7goY7fNrlQYg+wkpWTeiwlyKMi6agjjL
         ugJwCsY0mOASbtFCFtLshndpSYLSiolkWtij+1wBlPXyC6fGvWY5XmIoCJF0UdpGBVTL
         xOiXEo+vnxUeIzSDTUFar+fR9ZGEYy3oiO9yXu3DkZztZMsFPgzxHvp4+d4EgFYerayO
         eQtQ==
X-Gm-Message-State: AOJu0YyW5LR4GHDcDPt2Se2w6y/RUYdKa4jyI4EiOnXSUYQ/HyyseV0T
	t4N4OXOccpGoC8sLi9Nf+O3KoAOa0dgs8oMpEN7bcw==
X-Google-Smtp-Source: AGHT+IHuYY9oPVSUeYjkdWjcsw9rvqEL8L2dNOvWTV2YE3Sy/edlmshfcdGU6fvJsPkkdw+aWG35rw==
X-Received: by 2002:a17:902:bd0c:b0:1d0:a7b7:74d6 with SMTP id p12-20020a170902bd0c00b001d0a7b774d6mr1588377pls.110.1701931713031;
        Wed, 06 Dec 2023 22:48:33 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id w13-20020a170902a70d00b001d060bb0582sm564673plq.165.2023.12.06.22.48.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 22:48:32 -0800 (PST)
Message-ID: <65716ac0.170a0220.1a4c2.15e1@mx.google.com>
Date: Wed, 06 Dec 2023 22:48:32 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.4.y-st-rc
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v4.4-st20-1987-g9e48fc479c400
Subject: cip/linux-4.4.y-st-rc build: 14 builds: 0 failed, 14 passed,
 25 warnings (v4.4-st20-1987-g9e48fc479c400)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 07 Dec 2023 06:48:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13807

cip/linux-4.4.y-st-rc build: 14 builds: 0 failed, 14 passed, 25 warnings (v=
4.4-st20-1987-g9e48fc479c400)

Full Build Summary: https://kernelci.org/build/cip/branch/linux-4.4.y-st-rc=
/kernel/v4.4-st20-1987-g9e48fc479c400/

Tree: cip
Branch: linux-4.4.y-st-rc
Git Describe: v4.4-st20-1987-g9e48fc479c400
Git Commit: 9e48fc479c40013a21ec5c14b702b67ac153fb38
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
allnoconfig (i386, gcc-10) =E2=80=94 PASS, 0 errors, 0 warnings, 0 section =
mismatches

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

