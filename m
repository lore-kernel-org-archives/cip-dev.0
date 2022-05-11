X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
 by mx.groups.io with SMTP id smtpd.web11.11327.1652275473383415293
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 11 May 2022 06:24:33 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=fRVkWByC;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.169, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f169.google.com with SMTP id v11so1979935pff.6
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 11 May 2022 06:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=RBoQM+72O3dmHeqxmBf+YO02/W0GUYV6O5KeePp86jk=;
        b=fRVkWByCDTcacEYWdLwTC0qqf7FDQVCn87j/8F0gSCddghRVdprwbajAxwIXVUIYog
         tx6w11m4no7KLRsac/Qa+4VxVluxYnFphHa9jAsIMUKYcvezykG1TRIRLYeVnPUHBQhF
         2aPBHJgzTk1dku90UOUt06n3v+K005cCl9cBE9su8ghSbXOR71ZnYht2GdubnO8dHVtN
         Vyas1dwQdrFcHvJl8inEcT/EYjgyoPojARICFUSXEj2/i3WrcZQ2fsk0L7MyQ8VU8dnq
         7C7GETgXdJt74LxQ7dsKKxnXTGOBlhPJP0PjGi4uvc3Ahu4eUxzl8vyKm31zDqqaHlG1
         f1xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=RBoQM+72O3dmHeqxmBf+YO02/W0GUYV6O5KeePp86jk=;
        b=KNAXrOk45INCJTDDak6IzqCg0IqrCMnvAklHyX7BJKaojluBesX38pGkRsFk2l2QGc
         SGdeIkV/TkDkYLpX5eko8R10zIq+N2DsOF/szsqXZuSfP1Qj0BDE6MPYwe+tHZ9i1y9J
         cACozU1imW3gy1WogCWJeOJvSiOkzW8G/wVHdpie+Yqz5uBwViXJtvBKx7H6SasEfT0y
         56EZO8EkL1RLWiOSUQyqEnTNEFViGMIpXSQjcd3ReHGFjUtPsRoZSQNGjR8PBS0EO6vn
         /YwlJ9o2fylfIavb+K0NM9E4OKL3C/OPpOnjwxdyaGIB2twsMyXFCtvGJpQeWfSCdJey
         Lhwg==
X-Gm-Message-State: AOAM531Xvy5PknrsK8MzhLN+lBsi5py8jXmAmFL1P5QTaKdiIvJ+Mqwh
	+WYjZS2PUkXmzlhYujUNzCcG9/UGb1NK+lQciNQ=
X-Google-Smtp-Source: ABdhPJwPqhU9L0n7xaw5QLUfX1R8Q+ltK+zJkdBvOMHhqppSWT7EPLdudwadJgPjBweWHLIo7lJdLw==
X-Received: by 2002:a63:fa41:0:b0:3c2:1941:5894 with SMTP id g1-20020a63fa41000000b003c219415894mr20787722pgk.296.1652275472809;
        Wed, 11 May 2022 06:24:32 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id cp2-20020a170902e78200b0015e8d4eb1dcsm1864161plb.38.2022.05.11.06.24.32
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 06:24:32 -0700 (PDT)
Message-ID: <627bb910.1c69fb81.ac4e2.3ba0@mx.google.com>
Date: Wed, 11 May 2022 06:24:32 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Kernel: v4.4-st5-23-gf7cf04ab668f1
Subject: cip-gitlab/ci/pavel/linux-test smc: 3 runs, 1 regressions (v4.4-st5-23-gf7cf04ab668f1) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip-gitlab/ci/pavel/linux-test smc: 3 runs, 1 regressions (v4.4-st5-23-gf7c=
f04ab668f1)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-x360-12b-n4000-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.4-st5-23-gf7cf04ab668f1/plan/smc/

  Test:     smc
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.4-st5-23-gf7cf04ab668f1
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      f7cf04ab668f124b54f47c93fca7625e6eff3cfe =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-x360-12b-n4000-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/627bb8c89547d01bb58f5724

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-23-gf7cf04ab668f1/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/l=
ab-collabora/smc-hp-x360-12b-n4000-octopus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-23-gf7cf04ab668f1/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/l=
ab-collabora/smc-hp-x360-12b-n4000-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220506.0/x86/rootfs.cpio.gz =



  * smc.login: https://kernelci.org/test/case/id/627bb8c89547d01bb58f5725
        new failure (last pass: v5.10.109-cip5-384-g722204542e8a) =

 =20

