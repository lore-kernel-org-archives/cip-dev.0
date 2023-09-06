Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CEDDEE14A8
	for <webhook@archiver.kernel.org>; Wed,  6 Sep 2023 16:01:11 +0000 (UTC)
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
 by mx.groups.io with SMTP id smtpd.web11.2512.1694016069841908135
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 06 Sep 2023 09:01:10 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=POPHPm+Z;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.178, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1bf092a16c9so29842545ad.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 06 Sep 2023 09:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1694016069; x=1694620869; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=fw0DzUPoSbUkxD3zA3Kv50du8etd3MqocgjTJNZ+ii8=;
        b=POPHPm+ZnW9I23ZcHIu85bTKScBqxVnfUpKBK1mpOBUvNH5W/im3n+uhFRzoj2RcOz
         AyO94wIwGpJnZy/MgGbA/R3HkUTM4UbjQkSRmh/X60ttdkErVXqR3CK0gRt9PzpfzM0d
         cWZ4r5Izi7x/3Tjvv9XtwbXyHOAGT9lDCEM+AjpP1KiVG1w44TA5Y6kG2h8S6rmgl2Zm
         M2Dn3JXoR0Ui7LTqIQUiUO7GKQAhMLVmfZTE8Eg4T8IOMNRpBKq3vkzWZhAX8us0SQ8S
         vmqXaz3vyi2Mcc7s/nOuMBYa8hY/pCMjuTYU26W34NvgiPVDzcvccdDjeFComHi6Utap
         Rvrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694016069; x=1694620869;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fw0DzUPoSbUkxD3zA3Kv50du8etd3MqocgjTJNZ+ii8=;
        b=RjgcRpE7u83lWYzMplW28IR6qUbkCTrABsJA4r07By3xAhSakgNIyE1WfVAUF0xOCd
         rpNcxerasiY76u07XfI3YThoAGity8DQ351s3YUm5DOBYQ+MZ2pFYa7XeDZhAo0lROsK
         J8LKrlyG1LcPW3ORtX6gdlGhOLepsCaEeRLOMLuthLjtZgX9AWZOS1b+zMZnBkuRq8KS
         ixF2nrf9l8Bm87cLdgR/ZiPbrDW7pm/OrMRP/HkDfX/VNN5paz9m2zWby09Vt1X8Lp+c
         A4vdE2fkqHRV7TQiBWlKY0558RE8EkU8O7ULXYY03dLMK8cZUcQzTxl/OIm0oJ/R4RCe
         qizA==
X-Gm-Message-State: AOJu0Yz9gwblg1LopoAc/VLzn4vrsT9IiP9B7dDUQpkLEkbRDenDQAKS
	pPyiFfn7tYkT9nHbSS7GPoXfRScgSm1eFJ8odu7odA==
X-Google-Smtp-Source: AGHT+IEm190OgxAIIKwn/orRWbeYojrjntrmQ2j9DkN7qJJo5SJXXndQjhgYnGjfv1oNwAWAl6ZRag==
X-Received: by 2002:a17:902:d349:b0:1c3:693d:9dc7 with SMTP id l9-20020a170902d34900b001c3693d9dc7mr843960plk.62.1694016068896;
        Wed, 06 Sep 2023 09:01:08 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id jk6-20020a170903330600b001bbb8d5166bsm11279091plb.123.2023.09.06.09.01.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 09:01:07 -0700 (PDT)
Message-ID: <64f8a243.170a0220.66b30.8247@mx.google.com>
Date: Wed, 06 Sep 2023 09:01:07 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.4.y-st
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v4.4-st20-1638-gdc4a7f7fb55c
Subject: cip/linux-4.4.y-st build: 14 builds: 0 failed, 14 passed,
 27 warnings (v4.4-st20-1638-gdc4a7f7fb55c)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 06 Sep 2023 16:01:11 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12994

cip/linux-4.4.y-st build: 14 builds: 0 failed, 14 passed, 27 warnings (v4.4=
-st20-1638-gdc4a7f7fb55c)

Full Build Summary: https://kernelci.org/build/cip/branch/linux-4.4.y-st/ke=
rnel/v4.4-st20-1638-gdc4a7f7fb55c/

Tree: cip
Branch: linux-4.4.y-st
Git Describe: v4.4-st20-1638-gdc4a7f7fb55c
Git Commit: dc4a7f7fb55c24f25db88faf1beacc8125660b8e
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

