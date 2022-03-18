X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
 by mx.groups.io with SMTP id smtpd.web11.11704.1647619766362061868
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 18 Mar 2022 09:09:26 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=5lvaZejd;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.171, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f171.google.com with SMTP id z3so7298115plg.8
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 18 Mar 2022 09:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=znROU7eNXp+O39Q6S0RGE0WXNfRi8GXOnJAPViDb0XU=;
        b=5lvaZejd7nnUXFVUQbZzDKHqJZl+xpx/UKViNJ7SYnJJekzC2+QCD0oOFVSq5M6G9E
         BqpQyWnQew0YBVl5aJ3mPr+Eieya57+U0Do0IXK35eejNtRtBH28BQUkM4PoXZ92YVFt
         pwA7a3N90wPay/xRLc8DVzh7JHaKXNwaqBMK7B8BS7FalFuACCE+8qylckYDR4Rw9943
         ivC70/BxSEHPKmkoL2LB29PyIeyoKXNN2AOZmlxlrI6SymdwJ2J5ey5kAztyOd18Bm5/
         satMTxgwT1nVlk0YhPBp/VAnGPG5+7pKWqAnA3rDWUPX2EV7poVDwha98v+LSkr+M1mP
         Da6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=znROU7eNXp+O39Q6S0RGE0WXNfRi8GXOnJAPViDb0XU=;
        b=SkAFbOp0hOyX+uH0KX5gecEgvyG7vp35CE1SBWX0fJmU1K99ZUxm3ln7vRCQq94sfw
         r0zXST62a47vNb7pWd8HFDq2jRS4yO8w6EbjHc5eHiM5tzQQIgAhQvy1g+nTTuwWs6PK
         LEAj8gqyMbMTgdf9iqxTKCVkOFTD3/bdtImi+rAGnnUFWSDBKJ2A1OSeoZ4vLSqtYgFS
         o0mZulVJPSIw0Eu2zePuY87mHxBqYK8inoxbnfdtDSz6H9XMFBvJbUrZ+tgVpAT5e+Mw
         E9q9jRc0hXOgoccLSdxX8MwZiftcmye/ebYrP24Zlh2Aa+qvcxDzaPMZcgcg9G/QHNRL
         tbtg==
X-Gm-Message-State: AOAM531YlUqRRYmQDGLBGeaJN8a6gyzwZHyQ9I9gGVprCGYsYnaOLsO2
	JVADDa9hzBmz1e2ONkQ64V3XqEe5QnUaVNVDp6I=
X-Google-Smtp-Source: ABdhPJyMXT5zYW7UGhEpiVnTQHr7oVF5Mb82+2jCRpNs4QqyKhU4oGkaqC5Mg9uvVsAYdx87ZTyW+Q==
X-Received: by 2002:a17:90b:3807:b0:1bf:6c59:c6ff with SMTP id mq7-20020a17090b380700b001bf6c59c6ffmr11780231pjb.211.1647619765369;
        Fri, 18 Mar 2022 09:09:25 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id z11-20020a056a001d8b00b004f74f8268cbsm8549495pfw.85.2022.03.18.09.09.25
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Mar 2022 09:09:25 -0700 (PDT)
Message-ID: <6234aeb5.1c69fb81.47150.8748@mx.google.com>
Date: Fri, 18 Mar 2022 09:09:25 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v4.4.302-cip68-55-g24773c542fdd
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
Subject: cip-gitlab/ci/pavel/linux-test build: 181 builds: 73 failed, 108 passed (v4.4.302-cip68-55-g24773c542fdd) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip-gitlab/ci/pavel/linux-test build: 181 builds: 73 failed, 108 passed (v4=
.4.302-cip68-55-g24773c542fdd)

Full Build Summary: https://kernelci.org/build/cip-gitlab/branch/ci%2Fpavel=
%2Flinux-test/kernel/v4.4.302-cip68-55-g24773c542fdd/

Tree: cip-gitlab
Branch: ci/pavel/linux-test
Git Describe: v4.4.302-cip68-55-g24773c542fdd
Git Commit: 24773c542fdde7f383002754ec02b1656e9dc31c
Git URL: https://gitlab.com/cip-project/cip-kernel/linux-cip.git
Built: 6 unique architectures

Build Failures Detected:

arm64:
    defconfig: (gcc-10) FAIL
    defconfig+arm64-chromebook: (gcc-10) FAIL

arm:
    at91_dt_defconfig: (gcc-10) FAIL
    axm55xx_defconfig: (gcc-10) FAIL
    bcm2835_defconfig: (gcc-10) FAIL
    bcm_defconfig: (gcc-10) FAIL
    cns3420vb_defconfig: (gcc-10) FAIL
    colibri_pxa300_defconfig: (gcc-10) FAIL
    corgi_defconfig: (gcc-10) FAIL
    ebsa110_defconfig: (gcc-10) FAIL
    ezx_defconfig: (gcc-10) FAIL
    hisi_defconfig: (gcc-10) FAIL
    imx_v4_v5_defconfig: (gcc-10) FAIL
    imx_v6_v7_defconfig: (gcc-10) FAIL
    keystone_defconfig: (gcc-10) FAIL
    lpc32xx_defconfig: (gcc-10) FAIL
    multi_v7_defconfig: (gcc-10) FAIL
    mvebu_v7_defconfig: (gcc-10) FAIL
    netx_defconfig: (gcc-10) FAIL
    nhk8815_defconfig: (gcc-10) FAIL
    omap1_defconfig: (gcc-10) FAIL
    omap2plus_defconfig: (gcc-10) FAIL
    raumfeld_defconfig: (gcc-10) FAIL
    rpc_defconfig: (gcc-10) FAIL
    sama5_defconfig: (gcc-10) FAIL
    shmobile_defconfig: (gcc-10) FAIL
    socfpga_defconfig: (gcc-10) FAIL
    spear13xx_defconfig: (gcc-10) FAIL
    spitz_defconfig: (gcc-10) FAIL
    sunxi_defconfig: (gcc-10) FAIL
    tegra_defconfig: (gcc-10) FAIL
    u8500_defconfig: (gcc-10) FAIL
    vt8500_v6_v7_defconfig: (gcc-10) FAIL
    zx_defconfig: (gcc-10) FAIL

i386:
    i386_defconfig: (gcc-10) FAIL

mips:
    bcm47xx_defconfig: (gcc-10) FAIL
    bigsur_defconfig: (gcc-10) FAIL
    bmips_be_defconfig: (gcc-10) FAIL
    bmips_stb_defconfig: (gcc-10) FAIL
    cavium_octeon_defconfig: (gcc-10) FAIL
    ci20_defconfig: (gcc-10) FAIL
    db1xxx_defconfig: (gcc-10) FAIL
    decstation_defconfig: (gcc-10) FAIL
    fuloong2e_defconfig: (gcc-10) FAIL
    gpr_defconfig: (gcc-10) FAIL
    ip22_defconfig: (gcc-10) FAIL
    ip27_defconfig: (gcc-10) FAIL
    ip28_defconfig: (gcc-10) FAIL
    ip32_defconfig: (gcc-10) FAIL
    jazz_defconfig: (gcc-10) FAIL
    lemote2f_defconfig: (gcc-10) FAIL
    loongson3_defconfig: (gcc-10) FAIL
    malta_defconfig: (gcc-10) FAIL
    malta_kvm_defconfig: (gcc-10) FAIL
    malta_kvm_guest_defconfig: (gcc-10) FAIL
    malta_qemu_32r6_defconfig: (gcc-10) FAIL
    maltaaprp_defconfig: (gcc-10) FAIL
    maltasmvp_defconfig: (gcc-10) FAIL
    maltasmvp_eva_defconfig: (gcc-10) FAIL
    maltaup_defconfig: (gcc-10) FAIL
    maltaup_xpa_defconfig: (gcc-10) FAIL
    markeins_defconfig: (gcc-10) FAIL
    mips_paravirt_defconfig: (gcc-10) FAIL
    mtx1_defconfig: (gcc-10) FAIL
    nlm_xlp_defconfig: (gcc-10) FAIL
    nlm_xlr_defconfig: (gcc-10) FAIL
    pistachio_defconfig: (gcc-10) FAIL
    rm200_defconfig: (gcc-10) FAIL
    sb1250_swarm_defconfig: (gcc-10) FAIL
    tb0219_defconfig: (gcc-10) FAIL
    tb0287_defconfig: (gcc-10) FAIL

x86_64:
    x86_64_defconfig: (gcc-10) FAIL
    x86_64_defconfig+x86-chromebook: (gcc-10) FAIL

---
For more info write to <info@kernelci.org>

