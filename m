Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2CABC433F5
	for <webhook@archiver.kernel.org>; Fri, 30 Sep 2022 16:44:18 +0000 (UTC)
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com
 [209.85.214.171])
 by mx.groups.io with SMTP id smtpd.web12.1179.1664556252211404412
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 30 Sep 2022 09:44:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=rXHMHg9j;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.171,
 mailfrom: bot@kernelci.org)
Received: by mail-pl1-f171.google.com with SMTP id 10so833574pli.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 30 Sep 2022 09:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=ZkkjohpNiiue/6hi0ZXII5RnHE/GECUkq0Pm3y+Hrrc=;
        b=rXHMHg9j+naima7U2+kqFpX7SV0bKlZGb8WyJejQKusQEkHataEkN7YKatsUvHXRcn
         FNcL2Uezgm00P0bnCiFCuD8NTobBbfRBhQnRhHVfFjxcxMPkAiy8s7wa5LkB12PoCg4n
         U6B8PCGsNA4E4/JNC47Wgf2XMweOe4T4j1y9aSt3oN5/QQgxhQp3bDgfem/+p5c6+yr/
         j0JeroYpG9MBk7yluOjh/JSKD+SkR0z7Ot5WbNcKR9jBev+AbJvDMaGJddnIGPo9WFQ5
         /FZuoq5Adosmk0X2VzsC9UQBCt1CuHjNPZLKV403c60qfVGb23sEcsFc8wz/KpsaXkIm
         rsPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=ZkkjohpNiiue/6hi0ZXII5RnHE/GECUkq0Pm3y+Hrrc=;
        b=uDG8eBFpUAmQZA5niC9QBskTKu0+qVWY0XDMIzn50/Q304xTeSgnC+zmQvgo3IS5cc
         vYw93J0K8OYrMj7AhPupUtrqtde/V1N9POBSAPAfhUOX+/qfeHFXu1Jx3n4ao26nj1IW
         rWGXIbFdepv86mz1ZtytzD5bRkjAeoohebTqHON9SKTZ9hePf8vXzfd6p2zbq1UcO6u6
         mfc7WF5grhXAvxUNdMAEmRpB3AYP8LeKBk+tiqGGlOe/gf8gXe4D2LhLKpjMHb5hMb5W
         jQcvrwXbQDtn7xNrXcQTHOyZscX2QbN+SEP7qn7V22tH2NhSmFEFWBlc936d8KD4FekQ
         diXw==
X-Gm-Message-State: ACrzQf3Zw+tRbAndLERpsoNzC8YI5Q3nM/WrNy5Q4b4Io0r1ugsdzq23
	wEagHDZwjgEzIdRpUFd3DnQtDXebWQ9DIZPeVQE=
X-Google-Smtp-Source: 
 AMsMyM5ZlgsIfj6Px6TFoUCjj8reblxkQkNx/GJpOXeZTehaYxNrfj3f2I2DhgkyY2xoGgTsInCDnQ==
X-Received: by 2002:a17:902:ec86:b0:177:f35c:e118 with SMTP id
 x6-20020a170902ec8600b00177f35ce118mr9488873plg.138.1664556251591;
        Fri, 30 Sep 2022 09:44:11 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 m10-20020a17090a668a00b00203ab277966sm5627980pjj.7.2022.09.30.09.44.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 09:44:10 -0700 (PDT)
Message-ID: <63371cda.170a0220.84133.9ed2@mx.google.com>
Date: Fri, 30 Sep 2022 09:44:10 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.4.302-cip70-98-g7f7838c92740f
X-Kernelci-Branch: linux-4.4.y-cip
X-Kernelci-Tree: cip
Subject: cip/linux-4.4.y-cip smc: 6 runs,
 2 regressions (v4.4.302-cip70-98-g7f7838c92740f)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 30 Sep 2022 16:44:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9601

cip/linux-4.4.y-cip smc: 6 runs, 2 regressions (v4.4.302-cip70-98-g7f7838c9=
2740f)

Regressions Summary
-------------------

platform    | arch   | lab           | compiler | defconfig                =
    | regressions
------------+--------+---------------+----------+--------------------------=
----+------------
qemu_x86_64 | x86_64 | lab-collabora | gcc-10   | x86_64_defconfig         =
    | 1          =

qemu_x86_64 | x86_64 | lab-collabora | gcc-10   | x86_64_defcon...6-chromeb=
ook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.4.y-cip/kernel=
/v4.4.302-cip70-98-g7f7838c92740f/plan/smc/

  Test:     smc
  Tree:     cip
  Branch:   linux-4.4.y-cip
  Describe: v4.4.302-cip70-98-g7f7838c92740f
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      7f7838c92740fa423a5a3f12c00ed02d92851254 =



Test Regressions
---------------- =



platform    | arch   | lab           | compiler | defconfig                =
    | regressions
------------+--------+---------------+----------+--------------------------=
----+------------
qemu_x86_64 | x86_64 | lab-collabora | gcc-10   | x86_64_defconfig         =
    | 1          =


  Details:     https://kernelci.org/test/plan/id/63370dfa2900d66a12ec4eb2

  Results:     14 PASS, 2 FAIL, 0 SKIP
  Full config: x86_64_defconfig
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip70-98-g7f7838c92740f/x86_64/x86_64_defconfig/gcc-10/lab-collabora/smc-qem=
u_x86_64.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip70-98-g7f7838c92740f/x86_64/x86_64_defconfig/gcc-10/lab-collabora/smc-qem=
u_x86_64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220919.0/x86/rootfs.cpio.gz =



  * smc.CVE-2020-0543: https://kernelci.org/test/case/id/63370dfa2900d66a12=
ec4eb4
        new failure (last pass: v4.4.302-cip70)

    2022-09-30T15:40:27.818763  [    1.957958] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3DCVE-2020-0543 RESULT=3Dfail>   =

 =



platform    | arch   | lab           | compiler | defconfig                =
    | regressions
------------+--------+---------------+----------+--------------------------=
----+------------
qemu_x86_64 | x86_64 | lab-collabora | gcc-10   | x86_64_defcon...6-chromeb=
ook | 1          =


  Details:     https://kernelci.org/test/plan/id/63370f62dea97d5290ec5070

  Results:     14 PASS, 2 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip70-98-g7f7838c92740f/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-co=
llabora/smc-qemu_x86_64.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip70-98-g7f7838c92740f/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-co=
llabora/smc-qemu_x86_64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220919.0/x86/rootfs.cpio.gz =



  * smc.CVE-2020-0543: https://kernelci.org/test/case/id/63370f62dea97d5290=
ec5072
        new failure (last pass: v4.4.302-cip69-517-g92709d8ae585)

    2022-09-30T15:46:29.924935  [    2.009686] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3DCVE-2018-12207 RESULT=3Dpass>
    2022-09-30T15:46:29.928646  [    2.013838] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3DCVE-2020-0543 RESULT=3Dfail>   =

 =20

