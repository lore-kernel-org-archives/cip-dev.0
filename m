Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEC33C43334
	for <webhook@archiver.kernel.org>; Tue, 28 Jun 2022 00:39:31 +0000 (UTC)
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com
 [209.85.210.177])
 by mx.groups.io with SMTP id smtpd.web09.49727.1656376762920215006
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 27 Jun 2022 17:39:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=6brRSCTH;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.177,
 mailfrom: bot@kernelci.org)
Received: by mail-pf1-f177.google.com with SMTP id 65so10485566pfw.11
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 27 Jun 2022 17:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=COMk8e0SrB0g35RUZIC0tzrzWYdOl+fohlw23zHkCno=;
        b=6brRSCTHeILSn/AmcjwQIU86kZKRTwrCOIKTefZQiCKBx1dPuv7zzQR7YfWW+Dy6dQ
         2MIbHxiuVvIOXaqwi7Yb9eYDOq+k5IFR4F/dVkkx6F06zTeU7W77DiB/0duqcua6gaA0
         5OQOT/ATAczwbC0FcKuwCoerF40aTkjUlBa1vYZE8WrmE37hnus1JAnfJJ2e0bgXHYdF
         qbZc9co4au3zFZjOW5G+4ktUI20/qE6jFjenwdBDrNkoCh52tsbKqv+QfK0Lq4g+w7iR
         jx1UctrOdMeBK4EWqPx6tTsMhDYdolchEyRziQIp3TpSzaBQwKvO3KGb/+2SSiVGYxok
         O+Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=COMk8e0SrB0g35RUZIC0tzrzWYdOl+fohlw23zHkCno=;
        b=wW6wRHLImj7iSc6S1Vi3+kikDkq/MPHo3uhdp+D2nbUs9anJB8ANqZVyX3rrdTfLib
         uwGhfr1xGYArQ04V41LGa8RstgnQD/Ku3UkU4I4sP/G5EgZPtXeV04uWMdxT8gTvxuwB
         eIDKmrBpqICn8yorgfRAyvBgx8m8PLK1bFTKfnGO3E0Rxx7wiQioLOrgeoRwcd1MIU0f
         3+lqS255poffQ2uMJW7nFH1MMTnTi4DK6f4HD2ErApt3ZbFXq47XifTHKWdH8LUdRm9x
         akCnYROj10ICyM2sXa5EKxahsNrGG9HEym5dhyyKnNLBOYyORwTKtFaSMdp3w55RI8Dx
         YdDQ==
X-Gm-Message-State: AJIora+DIgemiT7ZflWCSNAhNbAu5fV6+IbnBexwZcB9i+FHwSNPHmiL
	Oh/OulvDT89kgvKJde1+EZRmTgk7rZpvCGev
X-Google-Smtp-Source: 
 AGRyM1vlVNhzcsqcuqJCtvT+efi4bB06qG94A122WlPmjNoP5OObLcG8fj+AVEnmc7NKv9QFpPusKA==
X-Received: by 2002:a63:8348:0:b0:40d:7ad2:319f with SMTP id
 h69-20020a638348000000b0040d7ad2319fmr15461512pge.137.1656376761949;
        Mon, 27 Jun 2022 17:39:21 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 j4-20020a17090276c400b0016188a4005asm7803383plt.122.2022.06.27.17.39.20
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 17:39:20 -0700 (PDT)
Message-ID: <62ba4db8.1c69fb81.1c785.acc9@mx.google.com>
Date: Mon, 27 Jun 2022 17:39:20 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.121-cip9-287-ge9094c8446fc
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-futex: 10 runs,
 1 regressions (v5.10.121-cip9-287-ge9094c8446fc)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 28 Jun 2022 00:39:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8611

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-futex: 10 runs, 1 regr=
essions (v5.10.121-cip9-287-ge9094c8446fc)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig | regress=
ions
-------------------------+-------+---------+----------+-----------+--------=
----
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig | 1      =
    =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.121-cip9-287-ge9094c8446fc/plan/kselftest=
-futex/

  Test:     kselftest-futex
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.121-cip9-287-ge9094c8446fc
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      e9094c8446fcef728d675699ced39be2dbbfb8f7 =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig | regress=
ions
-------------------------+-------+---------+----------+-----------+--------=
----
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/62ba417e3ec497bdc9a39c03

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.121-cip9-287-ge9094c8446fc/arm64/defconfig/gcc-10/lab-ci=
p/kselftest-futex-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.121-cip9-287-ge9094c8446fc/arm64/defconfig/gcc-10/lab-ci=
p/kselftest-futex-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220624.0/arm64/initrd.cpio.gz =



  * kselftest-futex.login: https://kernelci.org/test/case/id/62ba417e3ec497=
bdc9a39c04
        new failure (last pass: v5.10.121-cip9-272-g3fb28d4c623b) =

 =20

