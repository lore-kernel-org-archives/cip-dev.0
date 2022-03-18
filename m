X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
 by mx.groups.io with SMTP id smtpd.web10.11881.1647620378291641791
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 18 Mar 2022 09:19:38 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=QH4zAMSA;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.44, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f44.google.com with SMTP id v4so7799188pjh.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 18 Mar 2022 09:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=qkEWibHhh23+8lYURuE5aMlmnF1cQwOcJzIpdLKq7G8=;
        b=QH4zAMSA6chjFtWomiYnIZFSh0W9lfhFg+BrhVgVy2fajMGJBo2ykQ3B1t/JdebCyB
         4kpDk84vbZgpZMI+tnLYIDSrmZprMLN+stSuUS5+T3GKMsLWDHPGsDg3zyt7vq/xF9aP
         SmTmEpj08Htu7KVkTzzGA3cb+nFH91gYDxYZoaRHk9pgYSNuwsFdrFCI9MIkQyKif/2n
         1Px6nwPbL83pOHFFTbGkIwowS84y1Ra6U6TlOfmmoKg7v2h9omNhNaWj5sNMsF+NmSdF
         aq1N8Crx4vqguWL5R0mMGhkV2OcZ62/wXk4TdYB/IF7S9dZdpYF/9it62dDv+HfubhaL
         i7kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=qkEWibHhh23+8lYURuE5aMlmnF1cQwOcJzIpdLKq7G8=;
        b=Ar2tzQq42j/53TDk/DlFZ2wpDcrWLOsbMud3L9yKZb8DAzDZziPkOe5UDwjWeeepbj
         q6g60H3yyjZtHJQaSwFlYyYDlF1TZIPV5Z/jUPnkIFQhcwsP/4nJQolSLs/bVBumZCOe
         QsdnoV59pq2EpPaifON8vjnKn9kUiH2iR5CFbvgG55zmrX+HDcmaNOML8lSEq1fNzQFq
         ok4W6sMjlAKf+PsrLZ92Mnahe19ayDguXhwwO97KmqMhCq94oL2WaYT+7uEZ8wua0lkq
         liWJqjjFxJEZLTciS2yjRx6+3OgMHZJTjOMOqgWonW8xiPnNO/cWfOd+MSHarcSd4BLc
         W4QQ==
X-Gm-Message-State: AOAM530CsQ9PctTR8yfIZkxBS6heunYzhhbT0CYrCwx01uFgDNhm3INY
	5OGP/gxtnfTMOYEFKEA6SxCnDsv/L6KtjPqwkrc=
X-Google-Smtp-Source: ABdhPJw+qk1IYclnTVC9Qp6bCB+K31W+Sw+VVjHoL2DylPcMDQt/PEBl0psAsJt3RpWVS1gj1Rdd0Q==
X-Received: by 2002:a17:90b:3850:b0:1c6:572e:f39a with SMTP id nl16-20020a17090b385000b001c6572ef39amr17136787pjb.233.1647620377396;
        Fri, 18 Mar 2022 09:19:37 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id j20-20020a62e914000000b004fa3bd9bef0sm5430360pfh.110.2022.03.18.09.19.36
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Mar 2022 09:19:36 -0700 (PDT)
Message-ID: <6234b118.1c69fb81.b660d.fe59@mx.google.com>
Date: Fri, 18 Mar 2022 09:19:36 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Report-Type: build
X-Kernelci-Kernel: v4.4.302-cip68-53-geecd00d15fa6c
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
Subject: cip-gitlab/ci/pavel/linux-test build: 188 builds: 68 failed, 120 passed (v4.4.302-cip68-53-geecd00d15fa6c) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip-gitlab/ci/pavel/linux-test build: 188 builds: 68 failed, 120 passed (v4=
.4.302-cip68-53-geecd00d15fa6c)

Full Build Summary: https://kernelci.org/build/cip-gitlab/branch/ci%2Fpavel=
%2Flinux-test/kernel/v4.4.302-cip68-53-geecd00d15fa6c/

Tree: cip-gitlab
Branch: ci/pavel/linux-test
Git Describe: v4.4.302-cip68-53-geecd00d15fa6c
Git Commit: eecd00d15fa6c31f7dbddf4d2ce81e23210cd92a
Git URL: https://gitlab.com/cip-project/cip-kernel/linux-cip.git
Built: 6 unique architectures

Build Failures Detected:

arm:
    at91_dt_defconfig: (gcc-10) FAIL
    bcm2835_defconfig: (gcc-10) FAIL
    bcm_defconfig: (gcc-10) FAIL
    colibri_pxa300_defconfig: (gcc-10) FAIL
    corgi_defconfig: (gcc-10) FAIL
    davinci_all_defconfig: (gcc-10) FAIL
    ebsa110_defconfig: (gcc-10) FAIL
    exynos_defconfig: (gcc-10) FAIL
    ezx_defconfig: (gcc-10) FAIL
    hisi_defconfig: (gcc-10) FAIL
    imote2_defconfig: (gcc-10) FAIL
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
    s3c2410_defconfig: (gcc-10) FAIL
    sama5_defconfig: (gcc-10) FAIL
    shmobile_defconfig: (gcc-10) FAIL
    socfpga_defconfig: (gcc-10) FAIL
    spear13xx_defconfig: (gcc-10) FAIL
    spitz_defconfig: (gcc-10) FAIL
    tegra_defconfig: (gcc-10) FAIL
    u8500_defconfig: (gcc-10) FAIL
    vt8500_v6_v7_defconfig: (gcc-10) FAIL

i386:
    i386_defconfig: (gcc-10) FAIL

mips:
    bcm47xx_defconfig: (gcc-10) FAIL
    bigsur_defconfig: (gcc-10) FAIL
    bmips_be_defconfig: (gcc-10) FAIL
    bmips_stb_defconfig: (gcc-10) FAIL
    cavium_octeon_defconfig: (gcc-10) FAIL
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
    tb0219_defconfig: (gcc-10) FAIL
    tb0287_defconfig: (gcc-10) FAIL

x86_64:
    x86_64_defconfig: (gcc-10) FAIL
    x86_64_defconfig+x86-chromebook: (gcc-10) FAIL

---
For more info write to <info@kernelci.org>

