Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F8A2C64ED8
	for <webhook@archiver.kernel.org>; Thu, 23 Feb 2023 23:17:55 +0000 (UTC)
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
 by mx.groups.io with SMTP id smtpd.web10.4799.1677194270724041191
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 23 Feb 2023 15:17:50 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=1cdfQ2hU;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.177, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f177.google.com with SMTP id i10so5963573plr.9
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 23 Feb 2023 15:17:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=LnK8TLtyuFl6Y/6AVjN9ay8bAAr/yfPFoAXMGu7fC/4=;
        b=1cdfQ2hUwj48Ab7Be/KO35sFQZMnQdZ6EsbcSdYJayjVnBDLPPHFD+SzqDV3hrvS9l
         QyyO7BEDm3knb1um7Q8efojB+V7OQumcr0FFd8N6+9IjVMoEDj7v0JHeH4ztRfMryXLu
         YbNQLYQDHVzgiZso+htU/HXCe2eZP5g4RyfnAyiL9UKHxxJ/XxDNPC5d4+CfPW9swhy7
         /965j1N00fdoq/C8vTHknWgBR0vASWMTuVH2Y8w14pQqHeQpTBd0ig1kt4tmglkjzSTw
         46Cag9jOuP/vDtL/d4WW6u/PXmSHPQbBcgV0dhXNUafXSdFsXDDYndNavm4OwBNU+uQR
         i73Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LnK8TLtyuFl6Y/6AVjN9ay8bAAr/yfPFoAXMGu7fC/4=;
        b=YZSoGSfRHtxDhuJ1GHZx0orZ8bbAV6vNQjx09EIYWelgwz6FTK63jmO0/Q8yWDuXze
         mlH6KX90vMp+rysyXWGlDxZBTKApG+uW7w3xEypiCVcyjWsCCtS4Gou4N7EI8Fv4CbXZ
         zB5hgFSCdqZENAfImooUpMVh9mZRtpIxrwErfiqwY/6oM8QAU17uCAsTTcjEwYnZksZA
         Krkxkg6QxRsS7C/7X2ixrrxd1igIffMYWWSBc3K6WIlCk+nA+pQFvwPndL032K4vNbpY
         icCKGHFtq6L/Lu7qIs9zv/NAsSqzdB1GuGaVEFSSpiv0LILThZyv/MEcY13TZbGGu9Ac
         iT3Q==
X-Gm-Message-State: AO0yUKUwp8cIh4JYGf5zdx1DKz7nx1/dHuXAgaU4hFwSXs50OHv0vrzL
	5pvU00naqDMB08VWo7cC2KGiW4m8EqsMLT+hocE=
X-Google-Smtp-Source: AK7set/e28I3fPlfleKp0nZi6Qjd6HOWfA6xfupJfTBDxgmcY1uc0fpd3xB/OraAHmPtP7oXRQF6Hw==
X-Received: by 2002:a05:6a20:4401:b0:cb:f565:1001 with SMTP id ce1-20020a056a20440100b000cbf5651001mr6659725pzb.15.1677194269805;
        Thu, 23 Feb 2023 15:17:49 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id x15-20020aa7918f000000b005a8f1d76d46sm7158824pfa.13.2023.02.23.15.17.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Feb 2023 15:17:49 -0800 (PST)
Message-ID: <63f7f41d.a70a0220.6df24.e0ac@mx.google.com>
Date: Thu, 23 Feb 2023 15:17:49 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v5.10.167-cip26-2-g1e87e7748b91
X-Kernelci-Report-Type: test
Subject: cip/linux-5.10.y-cip kselftest-lkdtm: 5 runs,
 3 regressions (v5.10.167-cip26-2-g1e87e7748b91)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 23 Feb 2023 23:17:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10802

cip/linux-5.10.y-cip kselftest-lkdtm: 5 runs, 3 regressions (v5.10.167-cip2=
6-2-g1e87e7748b91)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...ok+kselftest | 1          =

asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...ok+kselftest | 1          =

hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...ok+kselftest | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.167-cip26-2-g1e87e7748b91/plan/kselftest-lkdtm/

  Test:     kselftest-lkdtm
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.167-cip26-2-g1e87e7748b91
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      1e87e7748b91cc6ec7f9f32d6d156ee15f651805 =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/63f7e332563957034e8c8643

  Results:     37 PASS, 17 FAIL, 25 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.167=
-cip26-2-g1e87e7748b91/x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc=
-10/lab-collabora/kselftest-lkdtm-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.167=
-cip26-2-g1e87e7748b91/x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc=
-10/lab-collabora/kselftest-lkdtm-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230217.0/amd64/initrd.cpio.gz =



  * kselftest-lkdtm.lkdtm_USERCOPY_STACK_FRAME_FROM_sh: https://kernelci.or=
g/test/case/id/63f7e332563957034e8c8649
        failing since 240 days (last pass: v5.10.121-cip9, first fail: v5.1=
0.125-cip10) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/63f7e50d45aaced5398c862f

  Results:     37 PASS, 17 FAIL, 25 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.167=
-cip26-2-g1e87e7748b91/x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc=
-10/lab-collabora/kselftest-lkdtm-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.167=
-cip26-2-g1e87e7748b91/x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc=
-10/lab-collabora/kselftest-lkdtm-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230217.0/amd64/initrd.cpio.gz =



  * kselftest-lkdtm.lkdtm_USERCOPY_STACK_FRAME_FROM_sh: https://kernelci.or=
g/test/case/id/63f7e50d45aaced5398c8635
        failing since 240 days (last pass: v5.10.121-cip9, first fail: v5.1=
0.125-cip10) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/63f7e5849dd363e2de8c863d

  Results:     36 PASS, 18 FAIL, 25 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.167=
-cip26-2-g1e87e7748b91/x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc=
-10/lab-collabora/kselftest-lkdtm-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.167=
-cip26-2-g1e87e7748b91/x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc=
-10/lab-collabora/kselftest-lkdtm-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230217.0/amd64/initrd.cpio.gz =



  * kselftest-lkdtm.lkdtm_USERCOPY_STACK_FRAME_FROM_sh: https://kernelci.or=
g/test/case/id/63f7e5849dd363e2de8c8643
        failing since 240 days (last pass: v5.10.121-cip9, first fail: v5.1=
0.125-cip10) =

 =20

