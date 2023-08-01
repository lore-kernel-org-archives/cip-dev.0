Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA758C001DF
	for <webhook@archiver.kernel.org>; Tue,  1 Aug 2023 11:23:09 +0000 (UTC)
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
 by mx.groups.io with SMTP id smtpd.web10.10256.1690888987387037859
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 01 Aug 2023 04:23:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=cgl5sL72;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.180, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1bba2318546so47032655ad.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 01 Aug 2023 04:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1690888986; x=1691493786;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=tATZj+JdGmaZnjKVRMJ/KARrtQ2xxWaHnnAqUOpxgwk=;
        b=cgl5sL72aNiQZeWtOa/8GjMkVakrlElju9NdHwKjjQs7aHRDLqHIOvZYjn4tsALc/s
         ea4LKnzs8QZi19RmpYF7rgQnU2PNyrylaQfEBbK2wzcaTDvSQUqOGLcC1yX0NMX4bVfq
         4dhjTduW94OKXG6QS0ZWLtq9fmr39Mph8MLkfQFw3wArTmk3nmlsunkDu1HQyR0p+n2E
         4ILLqNT7Kwg+iBCQMwN98VD9IQjQgSVMj7pJfz0VCVoV2iy1uMeNF1oNYNAvVuHSCdFf
         xA5LzbWMEF80gj4FlPjam6c6l4s7ZHJsn50djOeGsXPe7PAkKcxvwR4UmQTIze5jZVd8
         0TnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690888986; x=1691493786;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tATZj+JdGmaZnjKVRMJ/KARrtQ2xxWaHnnAqUOpxgwk=;
        b=J2ocQJfZdyJ8lWIrV4ApUnhhxQfoxpUs4QkCpx8CL4hD9iQN76tgDpwd0CrRLX5all
         k2GaDQo4x5ljisVQ1DhV+UFPh9MBP6y2R1G8czab2Jbe+YsokLtjquyvX2M0c+AliPCy
         IDq6iKv7Zcfe1SI4xjsmG8Mx+DzUl4ge5jYQYMZsA9md+fIj34qm26rrFRcrZWtZ92tf
         168GNUry9NXBKrYh8J8bbq19rQkFXUD+6FDqcje3NMGokXOQfO8TMEyVxxDJ+f+/6Pgk
         P22uCtkBMnr9vkM30kqqKfrBllgb5iqbmW+hqNcrwAGvxTPQyewlarcDepy7sRt6BGyk
         dnSQ==
X-Gm-Message-State: ABy/qLaOkPwtZ2Uu+5Veq30HD4qxMUJa4WRdyk+z91wPDnsxE6QJkPjA
	oECjkKhPFtXxio9homY+Av5OO+ucpH6aMZFi02+urg==
X-Google-Smtp-Source: APBJJlF7jlnvqOvlMHk3NLrA1ZdECPcLUZNVhSJmMSKE1o+T+hzZqCVhOx8balVeOG70rQeivfT4bw==
X-Received: by 2002:a17:902:f7ca:b0:1bb:9b48:ea94 with SMTP id h10-20020a170902f7ca00b001bb9b48ea94mr11500482plw.32.1690888986204;
        Tue, 01 Aug 2023 04:23:06 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id v11-20020a170902d68b00b001b53d3d8f3dsm10196385ply.299.2023.08.01.04.23.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 04:23:05 -0700 (PDT)
Message-ID: <64c8eb19.170a0220.53e81.3864@mx.google.com>
Date: Tue, 01 Aug 2023 04:23:05 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-4.4.y-st-rc
X-Kernelci-Kernel: v4.4-st20-1446-g679130ec67b34
X-Kernelci-Report-Type: build
Subject: cip/linux-4.4.y-st-rc build: 14 builds: 0 failed, 14 passed,
 34 warnings (v4.4-st20-1446-g679130ec67b34)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 01 Aug 2023 11:23:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12529

cip/linux-4.4.y-st-rc build: 14 builds: 0 failed, 14 passed, 34 warnings (v=
4.4-st20-1446-g679130ec67b34)

Full Build Summary: https://kernelci.org/build/cip/branch/linux-4.4.y-st-rc=
/kernel/v4.4-st20-1446-g679130ec67b34/

Tree: cip
Branch: linux-4.4.y-st-rc
Git Describe: v4.4-st20-1446-g679130ec67b34
Git Commit: 679130ec67b34c822902926135425ce7f97f9960
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
allnoconfig (i386, gcc-10) =E2=80=94 PASS, 0 errors, 1 warning, 0 section m=
ismatches

Warnings:
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

