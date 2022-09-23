Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B40EC6FA83
	for <webhook@archiver.kernel.org>; Fri, 23 Sep 2022 19:11:49 +0000 (UTC)
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com
 [209.85.214.169])
 by mx.groups.io with SMTP id smtpd.web12.714.1663960303163494730
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 23 Sep 2022 12:11:43 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=waxDrA55;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.169,
 mailfrom: bot@kernelci.org)
Received: by mail-pl1-f169.google.com with SMTP id x1so1015961plv.5
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 23 Sep 2022 12:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=J3SqVHcopkk/jUZyJBK7YkRml4BXt8wwUzKCCCIUMW0=;
        b=waxDrA55dSjKnqajmjXcdxdg3BwtpICBAhMtfAc6IZTF4F2SQIje1On7jiWgCPLNxY
         b2wsOkYtsr3elsZY5aXBexevA5CzPzeMY0nnTIZ3kU3778n2e97cETzSL4PK4UyJKNvl
         c68P2hFohEz4JBtzHY7p/SRDwaxFzhaMI+1vSL50PTAHF92GUhuVZglkSPCLzFbQBXkY
         oDbVL8SDBBUCn3j54DmH4XIb/RrANjGIjyPQ4m1gvHJ3LJB2jrsIbbRtUEYW6vmTAHG6
         VbaFjpvpcg3x5apUZ/zYfKBvhzHC0fRcCy9Ase7zxsbK/ggAsWee7Vl9jU9VU0FK40k+
         aCwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=J3SqVHcopkk/jUZyJBK7YkRml4BXt8wwUzKCCCIUMW0=;
        b=TgTE98O6KOgwOKBoPWuUG/GNweI/d+IPmWKYQ+Ls0OKQsyaaOgC5KUukjU7mG5u2vd
         UMaAlvKHJAe9lTXPRMLveQsX8/JCKXBWh+d03LOnp/Mh3J2aDkiHKZ/7Ug9a8MzdJJPD
         HE96nlZEa+8r7gLaLMT3vkz1mRBDrPH4kwB1pkdI2ZGGCi8nOKyuqM50ppT9GAs7hFOK
         +Cb5s001IoSQ574Rkn9Nr1ujeFH9je9HJuFvrK6u1Jhq3xjzKN50ZefQwkKmgmBW3yd5
         mvNMfLvnpZ2zkjV1/s8+251xjAmXfWYvr+S/1h7YKkvimNyMhefvZvmwM7eJ4Q0TQDYp
         3/FA==
X-Gm-Message-State: ACrzQf1SZebnIpRE1TGJf74+nKuRWMzA1UFYJYqkM2JBoQvvftrwcS4O
	mROVi14LU+5Epvvs3VDSSseuORRTkvqohHDsaXw=
X-Google-Smtp-Source: 
 AMsMyM59ez9SP9b+1sLfZpJtiFFYPKrn9+ZAxLL/y9WaMeZ6OfgQ7uvWCrFNrUBN/Kv6ZgR1OlUp0Q==
X-Received: by 2002:a17:903:120d:b0:178:ab0a:19a1 with SMTP id
 l13-20020a170903120d00b00178ab0a19a1mr9901160plh.11.1663960302408;
        Fri, 23 Sep 2022 12:11:42 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 u7-20020a17090341c700b0015e8d4eb219sm6536387ple.99.2022.09.23.12.11.40
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Sep 2022 12:11:41 -0700 (PDT)
Message-ID: <632e04ed.170a0220.faddd.d7f6@mx.google.com>
Date: Fri, 23 Sep 2022 12:11:41 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.140-cip16-261-g8fa62effa305f
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-seccomp: 6 runs,
 3 regressions (v5.10.140-cip16-261-g8fa62effa305f)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 23 Sep 2022 19:11:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9541

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-seccomp: 6 runs, 3 reg=
ressions (v5.10.140-cip16-261-g8fa62effa305f)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig          =
          | regressions
-------------------------+-------+---------+----------+--------------------=
----------+------------
beaglebone-black         | arm   | lab-cip | gcc-10   | multi_v7_defconfig+=
kselftest | 1          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm...ok+=
kselftest | 1          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+kselftest=
          | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.140-cip16-261-g8fa62effa305f/plan/kselfte=
st-seccomp/

  Test:     kselftest-seccomp
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.140-cip16-261-g8fa62effa305f
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      8fa62effa305f81a2f52692a14ee690927819830 =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig          =
          | regressions
-------------------------+-------+---------+----------+--------------------=
----------+------------
beaglebone-black         | arm   | lab-cip | gcc-10   | multi_v7_defconfig+=
kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/632e002b2998125804355643

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.140-cip16-261-g8fa62effa305f/arm/multi_v7_defconfig+ksel=
ftest/gcc-10/lab-cip/kselftest-seccomp-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.140-cip16-261-g8fa62effa305f/arm/multi_v7_defconfig+ksel=
ftest/gcc-10/lab-cip/kselftest-seccomp-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220919.0/armhf/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/632e002b2998=
125804355644
        new failure (last pass: v5.10.138-cip15-90-gd4130d0ee3c7) =

 =



platform                 | arch  | lab     | compiler | defconfig          =
          | regressions
-------------------------+-------+---------+----------+--------------------=
----------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm...ok+=
kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/632df8bff14a5eb7ca355667

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.140-cip16-261-g8fa62effa305f/arm64/defconfig+arm64-chrom=
ebook+kselftest/gcc-10/lab-cip/kselftest-seccomp-r8a774a1-hihope-rzg2m-ex.t=
xt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.140-cip16-261-g8fa62effa305f/arm64/defconfig+arm64-chrom=
ebook+kselftest/gcc-10/lab-cip/kselftest-seccomp-r8a774a1-hihope-rzg2m-ex.h=
tml
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220919.0/arm64/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/632df8bff14a=
5eb7ca355668
        new failure (last pass: v5.10.138-cip15-90-gd4130d0ee3c7) =

 =



platform                 | arch  | lab     | compiler | defconfig          =
          | regressions
-------------------------+-------+---------+----------+--------------------=
----------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+kselftest=
          | 1          =


  Details:     https://kernelci.org/test/plan/id/632dfadc369ba7970f355664

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.140-cip16-261-g8fa62effa305f/arm64/defconfig+kselftest/g=
cc-10/lab-cip/kselftest-seccomp-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.140-cip16-261-g8fa62effa305f/arm64/defconfig+kselftest/g=
cc-10/lab-cip/kselftest-seccomp-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220919.0/arm64/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/632dfadc369b=
a7970f355665
        new failure (last pass: v5.10.138-cip15-90-gd4130d0ee3c7) =

 =20

