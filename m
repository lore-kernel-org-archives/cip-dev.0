Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E855AC761A6
	for <webhook@archiver.kernel.org>; Wed,  5 Apr 2023 14:09:48 +0000 (UTC)
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
 by mx.groups.io with SMTP id smtpd.web11.131089.1680703785738837720
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 05 Apr 2023 07:09:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=Ysvdha9c;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.176, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f176.google.com with SMTP id c18so34500649ple.11
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 05 Apr 2023 07:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112; t=1680703785;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=yIU8l7FQ/mhFHPrJRg2n+iVelcMxYG7CYItHkkPM29s=;
        b=Ysvdha9czLuMae1oQXoG/n/0Vn/n852XqMzp74Yts+KTyaAo66RMQGaKP3QXP0J4Xs
         8DEK0kAjwepxSnxHZ5KkKFUeH7DLtFCw21Ty1bkQqCC008Jzm19hkkxJXULdrKhzdXGe
         ciIl9POo/Kdl8qGKz/3StOpnepZqO0MeDOPguUNP1Dn8fLRWYQG+eVL4SKMdMClbfvGN
         njjbetSUarFEV3aYOnaYdNd4/EQjIKmFfQG9QVJG5oDNC4PT2B/5OiNJdlDuFR5bY4mN
         dh3dzZZMrteFJ/f091FLW6VOyIpHBh+TnpSSGJf2SWL+X8UPuuMbCAQgMy4qGLmUNJ7q
         VBIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680703785;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yIU8l7FQ/mhFHPrJRg2n+iVelcMxYG7CYItHkkPM29s=;
        b=vakj0ozqyUEsvActkQEvtuQz5vdRK6EFh6V/mGMp928/G1EgrJaWzL4Y38/DhzxAR7
         D8oreA4iJpflivk0XxHY3KkCc0zcTQOMiDb8HXA0ac5pYdAE2HYI7SzWjsVWUniVKrXF
         PnD1stiaQbDMV9DGnTI22tTymnh23HmExhdR22QR5tOpzl630ej/Bsb13+Wdr6wKoKMR
         VqVBKcP/6lOwgqTmM9Z0J/rSfdpFF7FXSgArSud/ykXh3l2dFcd5SjnSSq7IR/Q7y7tC
         Aemo1ob07YnlG5bxua7gzYjTsSIS0exFUT6DKBX5IcaTuLPaGuBZ6z29mFqQSblAChsa
         mtqw==
X-Gm-Message-State: AAQBX9eRdfO5jzPw13mhoJWgVJUY6DdTzKKqu/hpxFO7Ioa8AcXW8UcT
	Bazx2wRAoyK7ilnGt47uFcuE+Mo5ijSoUmEpUmrpoQ==
X-Google-Smtp-Source: AKy350buNaowz1FezKz5fbD4y7l9jsEy12iIDhpe7TsXT/9Ksge5UvseeS1xrj1FRoTWdpFK2EeJLw==
X-Received: by 2002:a17:90b:685:b0:23f:58a2:7d6d with SMTP id m5-20020a17090b068500b0023f58a27d6dmr7035722pjz.6.1680703784885;
        Wed, 05 Apr 2023 07:09:44 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id oj5-20020a17090b4d8500b0023cfdbb6496sm1475978pjb.1.2023.04.05.07.09.44
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 07:09:44 -0700 (PDT)
Message-ID: <642d8128.170a0220.db953.2e2e@mx.google.com>
Date: Wed, 05 Apr 2023 07:09:44 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-4.19.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.19.279-cip95-86-g16c082d0be46
Subject: cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc ltp-timers: 6 runs,
 6 regressions (v4.19.279-cip95-86-g16c082d0be46)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 05 Apr 2023 14:09:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11185

cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc ltp-timers: 6 runs, 6 regression=
s (v4.19.279-cip95-86-g16c082d0be46)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 2          =

r8a774a1-hihope-rzg2m-ex  | arm64  | lab-cip       | gcc-10   | defconfig+a=
rm64-chromebook   | 2          =

r8a774a1-hihope-rzg2m-ex  | arm64  | lab-cip       | gcc-10   | defconfig  =
                  | 2          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-4.19.y-cip-rc/kernel/v4.19.279-cip95-86-g16c082d0be46/plan/ltp-timer=
s/

  Test:     ltp-timers
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-4.19.y-cip-rc
  Describe: v4.19.279-cip95-86-g16c082d0be46
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      16c082d0be46e1e0049aa4aa2c022b53c67690ad

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  70199ce4f0c498bfc7d0d9e0440f54b97b373b26 =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/642d75b45df152187d79e92a

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.279-cip95-86-g16c082d0be46/x86_64/x86_64_defconfig+x86-c=
hromebook/gcc-10/lab-collabora/ltp-timers-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.279-cip95-86-g16c082d0be46/x86_64/x86_64_defconfig+x86-c=
hromebook/gcc-10/lab-collabora/ltp-timers-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230331.0/amd64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/642d75b45df=
152187d79e92f
        failing since 152 days (last pass: v4.19.256-cip80-1-g68250b8eafbe0=
, first fail: v4.19.261-cip83-311-g41979a0fec1a) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/642d75b45df=
152187d79e92f
        failing since 152 days (last pass: v4.19.256-cip80-1-g68250b8eafbe0=
, first fail: v4.19.261-cip83-311-g41979a0fec1a) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
r8a774a1-hihope-rzg2m-ex  | arm64  | lab-cip       | gcc-10   | defconfig+a=
rm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/642d7304c3b9bd153879efbf

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.279-cip95-86-g16c082d0be46/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-cip/ltp-timers-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.279-cip95-86-g16c082d0be46/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-cip/ltp-timers-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230331.0/arm64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/642d7304c3b=
9bd153879efca
        failing since 22 days (last pass: v4.19.273-cip92-277-g507c8d80b9e2=
0, first fail: v4.19.276-cip93-5-g2eb2a953ab59) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/642d7304c3b=
9bd153879efca
        failing since 22 days (last pass: v4.19.273-cip92-277-g507c8d80b9e2=
0, first fail: v4.19.276-cip93-5-g2eb2a953ab59) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
r8a774a1-hihope-rzg2m-ex  | arm64  | lab-cip       | gcc-10   | defconfig  =
                  | 2          =


  Details:     https://kernelci.org/test/plan/id/642d75d4101bba7b7279e96b

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.279-cip95-86-g16c082d0be46/arm64/defconfig/gcc-10/lab-ci=
p/ltp-timers-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.279-cip95-86-g16c082d0be46/arm64/defconfig/gcc-10/lab-ci=
p/ltp-timers-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230331.0/arm64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/642d75d4101=
bba7b7279e976
        new failure (last pass: v4.19.276-cip93-5-g2eb2a953ab59) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/642d75d4101=
bba7b7279e976
        new failure (last pass: v4.19.276-cip93-5-g2eb2a953ab59) =

 =20

