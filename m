Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41053C3F6B0
	for <webhook@archiver.kernel.org>; Tue, 26 Jul 2022 15:24:34 +0000 (UTC)
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com
 [209.85.210.171])
 by mx.groups.io with SMTP id smtpd.web10.8107.1658849064856688141
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 26 Jul 2022 08:24:24 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=cW53dZSd;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.171,
 mailfrom: bot@kernelci.org)
Received: by mail-pf1-f171.google.com with SMTP id 70so13550446pfx.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 26 Jul 2022 08:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=sNEhLDrPTJK+BCnR3bfmdAp02U4GokOaGtGW+a0d3SU=;
        b=cW53dZSd+vz+yYk0MoXjt1tGe4N7P1fDWLb/Fxwx0v/gey3c4h3+Bnvl1ShG2ckPlP
         kxjNUnwnr06kkbz7nnr1q4raH5rE/Ngaqs2QnUYHF9mNCWmBzkdMU/8/U2q61xPoprQQ
         G/CzFgRiEdIUPjXWLj/h4swl+gL+Cfgu+UlcbPwt0VaCxAM1yICM5Bzlr2L9FSaQQxBG
         ZBoqipPSCX/ZIgtSzyestGctHOZJ5K6O/fzGHNcWAF+LdlkzRq9YYGT7K84cnqG8aXZO
         CRaacJ3/CH/N7P0hx0zPm0biyDhNVOFS/2NTFlZPRHwf/nvrmih7tNu/NtvHxNuMBI0r
         S5iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=sNEhLDrPTJK+BCnR3bfmdAp02U4GokOaGtGW+a0d3SU=;
        b=EyGfKByDfodQ4tZTdMG61craZNwa6eQ+dGMidPrpbEgrA4pdniwKHXw4UeTbVHUCRK
         1QlsOYHG0Xk1SSSiAb4wa8aja1MbCD/SS5pIrgPWA2BNWMVy0NLBaTxBXxhm+UXOtB3+
         JbITzR7UBVLe3ki8thq4ZFisaqJOIgQIhmew5lzrweE9exKLtYVcEuEimBofhSZgtMZy
         1xJHYBG9WI7ns6yCODvIWkqFd92Yyr5w2YlfskjkktBkyVGNfDvrBkvPyYiaGI2Ly3iG
         i3nJ3sGt9uB2uBHhI2a43a+kAfDleSVJqU/KmwCtE9nH9hMqfwKEAuXsSoIQ9GqsEzFO
         FBXA==
X-Gm-Message-State: AJIora+xr87Xt/7IL6Buvi5gjdENnH4k4rPJ7/Tt/aeMxxbf3WvxgBNk
	0gaMf/yFQ8Ao6jZqg34YDkkH0VfEU0zZcrkQ
X-Google-Smtp-Source: 
 AGRyM1u92HpIjkg53XE1MN8ygDJ381Ii9gYlm9rWh2I21gsRBNQ+L+vULP/cGTD+YOVQmm4waltfLw==
X-Received: by 2002:a05:6a00:815:b0:52a:dea8:269b with SMTP id
 m21-20020a056a00081500b0052adea8269bmr17918293pfk.66.1658849064222;
        Tue, 26 Jul 2022 08:24:24 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 d2-20020a170902654200b0016cf8f0bdd5sm11648894pln.108.2022.07.26.08.24.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 08:24:24 -0700 (PDT)
Message-ID: <62e00728.1c69fb81.4ea74.281c@mx.google.com>
Date: Tue, 26 Jul 2022 08:24:24 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.129-cip12-36-g21d9d56f4de5a
Subject: cip/linux-5.10.y-cip kselftest-lkdtm: 6 runs,
 3 regressions (v5.10.129-cip12-36-g21d9d56f4de5a)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 26 Jul 2022 15:24:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8937

cip/linux-5.10.y-cip kselftest-lkdtm: 6 runs, 3 regressions (v5.10.129-cip1=
2-36-g21d9d56f4de5a)

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
l/v5.10.129-cip12-36-g21d9d56f4de5a/plan/kselftest-lkdtm/

  Test:     kselftest-lkdtm
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.129-cip12-36-g21d9d56f4de5a
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      21d9d56f4de5acd415b12aecf82f754e9e6065fb =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/62dff27c5bd7d57f46daf05c

  Results:     37 PASS, 17 FAIL, 25 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.129=
-cip12-36-g21d9d56f4de5a/x86_64/x86_64_defconfig+x86-chromebook+kselftest/g=
cc-10/lab-collabora/kselftest-lkdtm-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.129=
-cip12-36-g21d9d56f4de5a/x86_64/x86_64_defconfig+x86-chromebook+kselftest/g=
cc-10/lab-collabora/kselftest-lkdtm-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220718.0/amd64/initrd.cpio.gz =



  * kselftest-lkdtm.lkdtm_USERCOPY_STACK_FRAME_FROM_sh: https://kernelci.or=
g/test/case/id/62dff27c5bd7d57f46daf062
        failing since 28 days (last pass: v5.10.121-cip9, first fail: v5.10=
.125-cip10) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/62dff8c2394b40305fdaf057

  Results:     37 PASS, 17 FAIL, 25 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.129=
-cip12-36-g21d9d56f4de5a/x86_64/x86_64_defconfig+x86-chromebook+kselftest/g=
cc-10/lab-collabora/kselftest-lkdtm-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.129=
-cip12-36-g21d9d56f4de5a/x86_64/x86_64_defconfig+x86-chromebook+kselftest/g=
cc-10/lab-collabora/kselftest-lkdtm-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220718.0/amd64/initrd.cpio.gz =



  * kselftest-lkdtm.lkdtm_USERCOPY_STACK_FRAME_FROM_sh: https://kernelci.or=
g/test/case/id/62dff8c2394b40305fdaf05d
        failing since 28 days (last pass: v5.10.121-cip9, first fail: v5.10=
.125-cip10) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/62dffec149f8741792daf067

  Results:     36 PASS, 18 FAIL, 25 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.129=
-cip12-36-g21d9d56f4de5a/x86_64/x86_64_defconfig+x86-chromebook+kselftest/g=
cc-10/lab-collabora/kselftest-lkdtm-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.129=
-cip12-36-g21d9d56f4de5a/x86_64/x86_64_defconfig+x86-chromebook+kselftest/g=
cc-10/lab-collabora/kselftest-lkdtm-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220718.0/amd64/initrd.cpio.gz =



  * kselftest-lkdtm.lkdtm_USERCOPY_STACK_FRAME_FROM_sh: https://kernelci.or=
g/test/case/id/62dffec149f8741792daf06d
        failing since 28 days (last pass: v5.10.121-cip9, first fail: v5.10=
.125-cip10) =

 =20

