Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E550AC4167B
	for <webhook@archiver.kernel.org>; Fri,  8 Dec 2023 17:49:05 +0000 (UTC)
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
 by mx.groups.io with SMTP id smtpd.web10.42735.1702057743871617378
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 08 Dec 2023 09:49:03 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=w6bSz0df;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.51, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-28a281bcb3cso893775a91.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 08 Dec 2023 09:49:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1702057743; x=1702662543; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=9XADX0MDcpatmtWLgCyHhdpRu6BPDAaJTbPrIk69qIs=;
        b=w6bSz0dftnscGgOHOLlDfwdcCFk/Oeagx2x+GaYaYT7HQwI7iY61u/2nMAIBP/Nu/f
         hGUMzqVC6m1IVOcD8LSkK5bVhR2Ux14t4AOPW7seRRD/a+4m2Sgg79wVZwj/zXAkp2k0
         5V8rPLpM7xkaWk1ABplLOG1egaaLyufWF1X8pXsj0MnRD0DZRTHwA83fkyF4HCjq6gQX
         kX/zyXdsVLLvDKWG8IHofyFY3P85bDRhkXW18tsj/7j6Myxv8ewPdfihfGVsu4vfyjKw
         8r/bANOo4zONaOsUXad2GJAIKQWceKFCZ3h9Wypj8JY7vjH5If5uucbPn1vJ6ivO5VdR
         to0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702057743; x=1702662543;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9XADX0MDcpatmtWLgCyHhdpRu6BPDAaJTbPrIk69qIs=;
        b=iSauaQ7LRp+8upnqHA2HMGvz2446+P+/Ens+hsz/gFz7KnO1Q2YGlUg23DGWgXndV7
         nHMZjAZj6SKYvRWocVo3pXC1S6h09faOKf86eUFIylzsOgYExI7Ttll0d7x6vucpR5Ka
         F6enJa24Rmciit4Wx9Hwe1lKw3cyDupCRg6ySHc/VZ+evRamyQCiYAS2MUPBfZbjOOT6
         KhMLiUWErLc/YKC4tKOtCT8ELv4s4IaHQQXssdGXMLdHr2+BjyeHvRG8WJ0NPv7wz3r1
         Z0CRNXAXwI2VS7TSNbrVnYlfqqJIQmT7rEUNiohZh0i3CE0j0b70gMt9wYTh8pxdZPtZ
         gPqw==
X-Gm-Message-State: AOJu0YznE53enygiTeCydjs4Wn56Msye3z52AbnqUz9B9vFP6L/GVjer
	/gg8iEfjpovA5pkZdtffNYhBakYID7+uYnJWGxPtfg==
X-Google-Smtp-Source: AGHT+IGZ6hsysUo3sZ/h6Lgs4On/hKOTrwkwYJDMMMm9JdllaaSGLCPu63xQlyhVDcaQKKDY+d6ynw==
X-Received: by 2002:a17:90a:ec83:b0:286:6cd8:ef17 with SMTP id f3-20020a17090aec8300b002866cd8ef17mr1616859pjy.47.1702057742822;
        Fri, 08 Dec 2023 09:49:02 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id x12-20020a17090a970c00b0028649b84907sm3535205pjo.16.2023.12.08.09.49.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 09:49:02 -0800 (PST)
Message-ID: <6573570e.170a0220.d936f.a4a9@mx.google.com>
Date: Fri, 08 Dec 2023 09:49:02 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.201-cip41-46-g596f4c151d286
Subject: cip/linux-5.10.y-cip kselftest-futex: 6 runs,
 1 regressions (v5.10.201-cip41-46-g596f4c151d286)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 08 Dec 2023 17:49:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13979

cip/linux-5.10.y-cip kselftest-futex: 6 runs, 1 regressions (v5.10.201-cip4=
1-46-g596f4c151d286)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig | regress=
ions
-------------------------+-------+---------+----------+-----------+--------=
----
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig | 1      =
    =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.201-cip41-46-g596f4c151d286/plan/kselftest-futex/

  Test:     kselftest-futex
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.201-cip41-46-g596f4c151d286
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      596f4c151d286c71a3612a2120ab33f4ac885d2e =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig | regress=
ions
-------------------------+-------+---------+----------+-----------+--------=
----
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/657347a08d3794bd55e135a5

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-46-g596f4c151d286/arm64/defconfig/gcc-10/lab-cip/kselftest-futex-r8a=
774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-46-g596f4c151d286/arm64/defconfig/gcc-10/lab-cip/kselftest-futex-r8a=
774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-futex.login: https://kernelci.org/test/case/id/657347a08d3794=
bd55e135a6
        failing since 14 days (last pass: v5.10.200-cip40, first fail: v5.1=
0.201-cip41-11-ga539098fe70dd) =

 =20

