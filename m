X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
 by mx.groups.io with SMTP id smtpd.web11.33097.1649066565803030275
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 04 Apr 2022 03:02:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=7c7PTWE8;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.41, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f41.google.com with SMTP id 2so1078201pjw.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 04 Apr 2022 03:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=XEs9JVb5Ttlo5NKpCCdqxHBpvzATMJ2jIioYZRL1FIA=;
        b=7c7PTWE87MK6e9ranyG9UMDAfVhxzvqR9HxpcCRJ9uLH85QCLCwneMWWmQ93iafqWX
         Dni+iMRVnbxPYxPGtQzyzLz8X8BS484aHH2z6nkxLy94S3i5a9mB+jpszcVpFS4ZUOy6
         bx/3116HVSEFCb7MS1iwPEYcP1R0ELJFpqZmwLU+BdpbjpXebyjdTx/Bvs4rQ8XsKjR2
         LDoXaRdPrDWdvzzR1cz/rS7qjmIuQRBDX+zN6b4sGifWvGkiVJkJEBRqDi1vzX7nvIeK
         kKA7mtPYVCu1or6UNS2+WmgwCTNPIm4dPhtJqXQ62MvyO+wJjjtEIXsMcuVP+4D+qxsl
         LX0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=XEs9JVb5Ttlo5NKpCCdqxHBpvzATMJ2jIioYZRL1FIA=;
        b=jfHbpWLwr/nn9Rqb+xk4/9fDlZkNBma22BchE1ye7wUzT1UrjvaMmBZj9pM43pKFWS
         Cszory1CmjOvKdkC+OF1TG3lYv0xah0jJO/C2BTMLljjzMuX3mtpWgMMLfpu23gqlayf
         rYq0QkJfhuBgknG/lCnR4ZpIwX2Hu3L4p5kiPQv3Fq5g1cg9iqcfoX0/h2HTX5Y5zBu6
         2D+FfBE+bRp6FMPXdgqG1/EHIQ+BAJcf0kc4NCM4xf16G9SgMO6sUN9IKKAD9uI2PSdI
         wzCBJsxo7GchlGVzuL8RXG8euDuvft5QGRJ7zmF4/C0FJRrtiRGqynsnnbwZJbZOFbIk
         rH4Q==
X-Gm-Message-State: AOAM530due8Mms+DcPxBKqATVQAUs3XEVe6WrlWUyrWfBaXGT8Bkb1l9
	2iXQcMuut8YR60jO3NbX+pY3gbBsbE55z/Vv+vE=
X-Google-Smtp-Source: ABdhPJxrBuM3BXobTn4KWIW5dhmp7EnsnqngLaTSt9r8+E+rxjY2d7Mb6VocvN8+NQ2Yqy2H3nq45A==
X-Received: by 2002:a17:90a:af8f:b0:1ca:7bce:ce3b with SMTP id w15-20020a17090aaf8f00b001ca7bcece3bmr8690947pjq.224.1649066565051;
        Mon, 04 Apr 2022 03:02:45 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id j63-20020a636e42000000b003987df110edsm10027608pgc.42.2022.04.04.03.02.44
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 03:02:44 -0700 (PDT)
Message-ID: <624ac244.1c69fb81.7c30c.9ace@mx.google.com>
Date: Mon, 04 Apr 2022 03:02:44 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Kernel: v4.4-st5-1479-ga84d0db6dfc6
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test smc: 7 runs, 1 regressions (v4.4-st5-1479-ga84d0db6dfc6) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip-gitlab/ci/pavel/linux-test smc: 7 runs, 1 regressions (v4.4-st5-1479-ga=
84d0db6dfc6)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-x360-12b-n4000-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.4-st5-1479-ga84d0db6dfc6/plan/smc/

  Test:     smc
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.4-st5-1479-ga84d0db6dfc6
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      a84d0db6dfc604c5de8b5446ea27ac9a039ae378 =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-x360-12b-n4000-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/624452633ac889106dae06f4

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-1479-ga84d0db6dfc6/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/smc-hp-x360-12b-n4000-octopus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-1479-ga84d0db6dfc6/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/smc-hp-x360-12b-n4000-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220228.1/x86/rootfs.cpio.gz =



  * smc.login: https://kernelci.org/test/case/id/624452633ac889106dae06f5
        failing since 13 days (last pass: v4.19.233-cip69-1019-g2e5815777e9=
75, first fail: v4.4.302-18-ga78419826225) =

 =20

