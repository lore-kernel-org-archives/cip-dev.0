Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3D5EE7849A
	for <webhook@archiver.kernel.org>; Mon,  2 Oct 2023 12:46:51 +0000 (UTC)
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
 by mx.groups.io with SMTP id smtpd.web10.80675.1696250809283875316
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 02 Oct 2023 05:46:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=yFmKNa91;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.169, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-694f75deb1aso483745b3a.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 02 Oct 2023 05:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1696250808; x=1696855608; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=a1IlJ8hXcJH0IU1aZTO/MRAV0SkuLq+A1hckRhRHk+M=;
        b=yFmKNa91cipOnMAmpGXYk5VU0lLxyTbFgfN8f3pxSKdn0k1eJyZXyzB5SLzuIf5Ksz
         zYGntCHp8xBBTpuKsmzV3Onb6OvocPc8bmf1CcEX6O27z23yGW+m7PnJHAEdt+d/f3Eo
         rauJrcdsDVxHxJ0RTgJn5qILuhVAcLLrGFX/2BcRSbE5/ofOmQ1OqafGpljRlAH0Hwgl
         ZFT5anqgzpkc43hOxLsuzD0NllrfFXGNKhnoVIxT2YB+IeFanh/VQTqkvuPFSwkuZJHL
         iXCQWcA5R+/LLtqI8w7MF8gEWHdywJrNbuCqRHoM5AKaBcBsGdhGlP4+RMKd37x1QfHG
         u4oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696250808; x=1696855608;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a1IlJ8hXcJH0IU1aZTO/MRAV0SkuLq+A1hckRhRHk+M=;
        b=QBsgyGy7trJ765S37CRptZXwt6USLyTdadafEAqb23LjCU4w0iuzJqy6d2tJqPRSv2
         BX/+EZ6Kk4qOFfuKAalpe7DDDlxD9Wq91rgq0NrFL78+QBphbUBoyk4dCI9ygwyAl3wi
         fKndTYPM7C2wJ7Pej9dXBV5PvPJhGaPWh1dlnpmZ9zDoKTcgQpsT9XVY/1dD/eY3r6Be
         Yv4JBh10J7AXG8NOcB3sr3AC4icUYhKmadMHE1HWQvyCSsvorbL1pai6RfJvy1JMOsVw
         FuQi5jUptKgjobey13+WZ/aKvIYB6rfr3APwe2JplOGIRZWtLF4WnvvR+RZSAtrC4fTT
         DinQ==
X-Gm-Message-State: AOJu0YyUb0ZWnXlWb4iZD0y/PtrErX5ewOrKcs11TfSj2J1XsvB6vfeM
	PH9O6R9Zwf9O6uvPY+AHoD3fsBnmvNy4jBK35VyFzw==
X-Google-Smtp-Source: AGHT+IG1a/PO1magbbZ+w615UEeCiBefM0JOuJL3dyS5LrVrQJL4hx8v0sfV3zdVKISfS2sgpH1ksQ==
X-Received: by 2002:a05:6a20:8416:b0:f0:50c4:4c43 with SMTP id c22-20020a056a20841600b000f050c44c43mr18604448pzd.5.1696250807888;
        Mon, 02 Oct 2023 05:46:47 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id n9-20020a639709000000b00565e2ad12e5sm13304095pge.91.2023.10.02.05.46.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 05:46:47 -0700 (PDT)
Message-ID: <651abbb7.630a0220.91aa1.6955@mx.google.com>
Date: Mon, 02 Oct 2023 05:46:47 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.4.y-st-rc
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v4.4-st20-1779-gb2bbf3465ae43
X-Kernelci-Report-Type: build
Subject: cip/linux-4.4.y-st-rc build: 14 builds: 4 failed, 10 passed, 4 errors,
 21 warnings (v4.4-st20-1779-gb2bbf3465ae43)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 02 Oct 2023 12:46:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13258

cip/linux-4.4.y-st-rc build: 14 builds: 4 failed, 10 passed, 4 errors, 21 w=
arnings (v4.4-st20-1779-gb2bbf3465ae43)

Full Build Summary: https://kernelci.org/build/cip/branch/linux-4.4.y-st-rc=
/kernel/v4.4-st20-1779-gb2bbf3465ae43/

Tree: cip
Branch: linux-4.4.y-st-rc
Git Describe: v4.4-st20-1779-gb2bbf3465ae43
Git Commit: b2bbf3465ae436ac9d3867f699bfd54a6e3f8aa6
Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
Built: 4 unique architectures

Build Failures Detected:

arm:
    imx_v6_v7_defconfig: (gcc-10) FAIL
    multi_v5_defconfig: (gcc-10) FAIL

x86_64:
    x86_64_defconfig: (gcc-10) FAIL
    x86_64_defconfig+x86-chromebook: (gcc-10) FAIL

Errors and Warnings Detected:

arm64:
    defconfig (gcc-10): 1 warning
    defconfig+arm64-chromebook (gcc-10): 1 warning

arm:
    imx_v6_v7_defconfig (gcc-10): 1 error, 1 warning
    multi_v5_defconfig (gcc-10): 1 error
    omap2plus_defconfig (gcc-10): 1 warning

i386:
    i386_defconfig (gcc-10): 4 warnings

x86_64:
    allnoconfig (gcc-10): 3 warnings
    tinyconfig (gcc-10): 2 warnings
    x86_64_defconfig (gcc-10): 1 error, 4 warnings
    x86_64_defconfig+x86-chromebook (gcc-10): 1 error, 4 warnings

Errors summary:

    2    sound/core/pcm_compat.c:345:9: error: implicit declaration of func=
tion =E2=80=98fixup_unreferenced_params=E2=80=99 [-Werror=3Dimplicit-functi=
on-declaration]
    2    fs/udf/inode.c:894:3: error: label =E2=80=98out_free=E2=80=99 used=
 but not defined

Warnings summary:

    7    arch/x86/kernel/process.c:456: Warning: no instruction mnemonic su=
ffix given and no register operands; using default for `btr'
    4    arch/x86/entry/entry_64.S:487: Warning: no instruction mnemonic su=
ffix given and no register operands; using default for `btr'
    2    drivers/usb/gadget/function/f_ncm.c:1565:19: warning: assignment t=
o =E2=80=98struct config_group *=E2=80=99 from =E2=80=98int=E2=80=99 makes =
pointer from integer without a cast [-Wint-conversion]
    2    drivers/net/ethernet/apm/xgene/xgene_enet_main.c:32:36: warning: a=
rray =E2=80=98xgene_enet_acpi_match=E2=80=99 assumed to have one element
    2    cc1: some warnings being treated as errors
    1    ld: warning: creating DT_TEXTREL in a PIE
    1    ld: arch/x86/boot/compressed/head_32.o: warning: relocation in rea=
d-only section `.head.text'
    1    WARNING: vmlinux.o (.discard.retpoline_safe): unexpected non-alloc=
atable section.
    1    WARNING: vmlinux.o (.discard.nospec): unexpected non-allocatable s=
ection.

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
imx_v6_v7_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 1 warning, 0 sec=
tion mismatches

Errors:
    fs/udf/inode.c:894:3: error: label =E2=80=98out_free=E2=80=99 used but =
not defined

Warnings:
    drivers/usb/gadget/function/f_ncm.c:1565:19: warning: assignment to =E2=
=80=98struct config_group *=E2=80=99 from =E2=80=98int=E2=80=99 makes point=
er from integer without a cast [-Wint-conversion]

---------------------------------------------------------------------------=
-----
multi_v5_defconfig (arm, gcc-10) =E2=80=94 FAIL, 1 error, 0 warnings, 0 sec=
tion mismatches

Errors:
    fs/udf/inode.c:894:3: error: label =E2=80=98out_free=E2=80=99 used but =
not defined

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
x86_64_defconfig (x86_64, gcc-10) =E2=80=94 FAIL, 1 error, 4 warnings, 0 se=
ction mismatches

Errors:
    sound/core/pcm_compat.c:345:9: error: implicit declaration of function =
=E2=80=98fixup_unreferenced_params=E2=80=99 [-Werror=3Dimplicit-function-de=
claration]

Warnings:
    arch/x86/entry/entry_64.S:487: Warning: no instruction mnemonic suffix =
given and no register operands; using default for `btr'
    arch/x86/kernel/process.c:456: Warning: no instruction mnemonic suffix =
given and no register operands; using default for `btr'
    arch/x86/kernel/process.c:456: Warning: no instruction mnemonic suffix =
given and no register operands; using default for `btr'
    cc1: some warnings being treated as errors

---------------------------------------------------------------------------=
-----
x86_64_defconfig+x86-chromebook (x86_64, gcc-10) =E2=80=94 FAIL, 1 error, 4=
 warnings, 0 section mismatches

Errors:
    sound/core/pcm_compat.c:345:9: error: implicit declaration of function =
=E2=80=98fixup_unreferenced_params=E2=80=99 [-Werror=3Dimplicit-function-de=
claration]

Warnings:
    arch/x86/entry/entry_64.S:487: Warning: no instruction mnemonic suffix =
given and no register operands; using default for `btr'
    arch/x86/kernel/process.c:456: Warning: no instruction mnemonic suffix =
given and no register operands; using default for `btr'
    arch/x86/kernel/process.c:456: Warning: no instruction mnemonic suffix =
given and no register operands; using default for `btr'
    cc1: some warnings being treated as errors

---
For more info write to <info@kernelci.org>

