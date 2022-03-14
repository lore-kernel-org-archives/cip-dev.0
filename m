X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
 by mx.groups.io with SMTP id smtpd.web09.24230.1647246416793606518
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 14 Mar 2022 01:26:56 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=J7c3Cd9C;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.176, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f176.google.com with SMTP id l8so3174213pfu.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 14 Mar 2022 01:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=/KSUKvsQtgJplLXyoHPQ7BWrdVk0Fmo6Hpv9eAndAqI=;
        b=J7c3Cd9ChXFt4cZES9nZZAgzvQjI8Nu3b6lSiGiaSRfXuc4VoD2bPIg30uSUMaDVul
         zmfs+9c/wleNyE6Uh3MMVsp7+pX2sszt8CE1zJ/WE2nQjI1Q/PuYh6BC4an0hJfhZ67U
         NRjpRt9dq+J9bfRWsEXmjSLTp3OD1drqgv8Povt4lmUPigQf7Dp4astEfl94IJgV3+J3
         o9TNr+QaFLt2YOCrjovooO6FSZPmZY/FIANI4sux9pWPn8eSbP2XuyVvQuu58GSTbkbR
         1qvHfMFpBNQPzZSiap4w6kNbVUpKQImiPV9uPA/+gj/PeskU8GfW//Z669gyfDem4WM8
         1PAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=/KSUKvsQtgJplLXyoHPQ7BWrdVk0Fmo6Hpv9eAndAqI=;
        b=mfOp7H73KxckPWdL06fmVBZcDNxy8u+J2m+dq6sic+jRYAvhHQlrJnAQAPE5sOkcqM
         eio9YviuCWMW5B7f94hvAfccOBZIM6dzqwFtAmA9JevmcM9eQ7CM4JPABKc4GzQ/WjS1
         5MUFeVveTfq0I1bsYYumzoavnY6lAZHzhYhR2SzQzN9T/XILx8LZCQKktUNAKqxLya/f
         9zgH+vYiLPLlwD28fQH97oho0uazyIydkbUdxHIuMldqCXExQHOGTl3ELetAE2DtiJA2
         dkqdj4Idmsl2ygUw803jwRpxBWVeujayH0K1H2rqwlnMyWYi0oygl2ySR/XdFnSMdaZl
         mn6g==
X-Gm-Message-State: AOAM530y8VQFkoR5oozIBtQ3ZegKbXZvwbThgwChNVkqkLYDyyts7jA3
	dLsH+DYK8JTBJhmIXFR0YH6Vyuzd2ygi1YN3TGQ=
X-Google-Smtp-Source: ABdhPJwcVI9JGn2NzFx66HGPZxFrczQ1OpymivreEEeMOmcX6B8nVoilGkZBHDSIBPVdpLmZK6QiHg==
X-Received: by 2002:aa7:909a:0:b0:4e1:6d4:5905 with SMTP id i26-20020aa7909a000000b004e106d45905mr23068131pfa.34.1647246416155;
        Mon, 14 Mar 2022 01:26:56 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id p25-20020a637419000000b0037fa57520adsm15737645pgc.27.2022.03.14.01.26.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Mar 2022 01:26:55 -0700 (PDT)
Message-ID: <622efc4f.1c69fb81.17a5a.8101@mx.google.com>
Date: Mon, 14 Mar 2022 01:26:55 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-4.19.y-cip
X-Kernelci-Kernel: v4.19.233-cip69
Subject: cip/linux-4.19.y-cip baseline-cip-nfs: 6 runs, 1 regressions (v4.19.233-cip69) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip/linux-4.19.y-cip baseline-cip-nfs: 6 runs, 1 regressions (v4.19.233-cip=
69)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig | regress=
ions
-------------------------+-------+---------+----------+-----------+--------=
----
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig | 1      =
    =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.19.y-cip/kerne=
l/v4.19.233-cip69/plan/baseline-cip-nfs/

  Test:     baseline-cip-nfs
  Tree:     cip
  Branch:   linux-4.19.y-cip
  Describe: v4.19.233-cip69
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      adce3ecbc12596b052ad50a96e765702abcbca8e =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig | regress=
ions
-------------------------+-------+---------+----------+-----------+--------=
----
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/622eef40bdfce02936c62996

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.233=
-cip69/arm64/defconfig/gcc-10/lab-cip/baseline-cip-nfs-r8a774a1-hihope-rzg2=
m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.233=
-cip69/arm64/defconfig/gcc-10/lab-cip/baseline-cip-nfs-r8a774a1-hihope-rzg2=
m-ex.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20211105/qemu=
-arm64/cip-core-image-kernelci-cip-core-buster-qemu-arm64-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/622eef40bdfce=
02936c62997
        new failure (last pass: v4.19.231-cip68) =

 =20

