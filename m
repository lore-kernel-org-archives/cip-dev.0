Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A104C77B7A
	for <webhook@archiver.kernel.org>; Tue,  6 Jun 2023 13:36:01 +0000 (UTC)
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
 by mx.groups.io with SMTP id smtpd.web10.79.1686058557739581139
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 06 Jun 2023 06:35:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=0ZV2Z0MI;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.172, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6513e7e5d44so3684380b3a.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 06 Jun 2023 06:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1686058557; x=1688650557;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=cj0hlt6JjZeAAohqKiP46kNx+a3T4YOXNLi8k0I7VpU=;
        b=0ZV2Z0MIOEIVfGxcbXnbrYoljKOIhbkzlhfyLxVO5qGt+amCpO/0GQy7BifU+xXMIt
         3Ww+mybDpeohiHi5QFCuOqjjFDE+hsFURSQFoqjGSRKf71rJZfQyFV66ark8k2BmwUhE
         FC/UXVhanI1qFvlzSf/Vm/sWmeGjJxYJdIT0cOMe0mr3TeQDPr7iUoq9Hc/Grs0uSl4c
         SqfuwhkHNHtXv5ZLcWuvlUQGkPJLD2dfiSQtmOx4Tz6PFAfnsDVJepUZ+QJEW5Kws/S1
         JtVDj5TMlkBNVBOzwFFzxfcjmT/jQqXFY9JOtpWjgY7mIlP7urowTFGnwRSv5WqSHTkl
         JkHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686058557; x=1688650557;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cj0hlt6JjZeAAohqKiP46kNx+a3T4YOXNLi8k0I7VpU=;
        b=VnWzNJMT2rEfhG8ublbEtAWIdp+UyLD4tcSGPtmmfpI1/jJqm3qd863NQXYki4bKBl
         6eMywbODPhKxLV0K97C8AzIUXoqRb+2ITYMzbEnmPCo6NAeWRnqZJ54/f5oIJ7Zw7BHK
         WdlYBhZRLqdtiS/Ij/BYV6GQuMmVc0AeZSAOs0MLfM717elUdW6TKKYw4o5Xi5RlciH/
         SfB0xuwUGgslMo/8iPMmrGxTQJIOPaYk0S9HD+glWm7TjfahFa8Yh33rUyWkElR9YTLh
         zmavK3kSAQflCBo1SUBkh+2fLfJnbIieapw4XN5XU7sAfgVrwu2Ax5Dyv34i3yuy7l+I
         C4HQ==
X-Gm-Message-State: AC+VfDyiLWVksgh3m9nV9yJAStrNaTVAv3G0t6vziTptaEFI5PeJJ5zd
	8HqkpQejomnN4dyIOFgjTbn9Y3izC8JNua5CYjx7BA==
X-Google-Smtp-Source: ACHHUZ6i6nOoYkbCbVjc5RGnlRO8aqHokturaDGOGbshqC1FWtfE9y8ztDPVz7Rk8XDrw5jWvWPzMg==
X-Received: by 2002:a05:6a21:6802:b0:10a:9f45:e3f with SMTP id wr2-20020a056a21680200b0010a9f450e3fmr1387520pzb.12.1686058556763;
        Tue, 06 Jun 2023 06:35:56 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id t8-20020aa79388000000b0065cfd5cbef3sm2923497pfe.15.2023.06.06.06.35.55
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 06:35:56 -0700 (PDT)
Message-ID: <647f363c.a70a0220.60883.5dda@mx.google.com>
Date: Tue, 06 Jun 2023 06:35:56 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.1.26-1320-g1ddf4b637f785
X-Kernelci-Report-Type: test
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/pavel/linux-test ltp-timers: 14 runs,
 4 regressions (v6.1.26-1320-g1ddf4b637f785)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 06 Jun 2023 13:36:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11887

cip-gitlab/ci/pavel/linux-test ltp-timers: 14 runs, 4 regressions (v6.1.26-=
1320-g1ddf4b637f785)

Regressions Summary
-------------------

platform     | arch   | lab           | compiler | defconfig               =
     | regressions
-------------+--------+---------------+----------+-------------------------=
-----+------------
qemu_riscv64 | riscv  | lab-broonie   | gcc-10   | defconfig               =
     | 2          =

qemu_x86_64  | x86_64 | lab-collabora | gcc-10   | x86_64_defcon...6-chrome=
book | 2          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v6.1.26-1320-g1ddf4b637f785/plan/ltp-timers/

  Test:     ltp-timers
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v6.1.26-1320-g1ddf4b637f785
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      1ddf4b637f7858373296265fe09135a077008de6

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  604701dc19c5499403ae5afe48103b8e2872952b =



Test Regressions
---------------- =



platform     | arch   | lab           | compiler | defconfig               =
     | regressions
-------------+--------+---------------+----------+-------------------------=
-----+------------
qemu_riscv64 | riscv  | lab-broonie   | gcc-10   | defconfig               =
     | 2          =


  Details:     https://kernelci.org/test/plan/id/647f238ca6f3f6fb07f5de26

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1320-g1ddf4b637f785/riscv/defconfig/gcc-10/lab-broonie/ltp-timers-=
qemu_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1320-g1ddf4b637f785/riscv/defconfig/gcc-10/lab-broonie/ltp-timers-=
qemu_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30527.0/riscv64/rootfs.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/647f238ca6f=
3f6fb07f5de39
        failing since 0 day (last pass: v6.1.26-1298-g61395b9756bd5, first =
fail: v5.10.180-cip34-26-gc198172c84b6a) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/647f238ca6f=
3f6fb07f5de39
        failing since 0 day (last pass: v6.1.26-1298-g61395b9756bd5, first =
fail: v5.10.180-cip34-26-gc198172c84b6a) =

 =



platform     | arch   | lab           | compiler | defconfig               =
     | regressions
-------------+--------+---------------+----------+-------------------------=
-----+------------
qemu_x86_64  | x86_64 | lab-collabora | gcc-10   | x86_64_defcon...6-chrome=
book | 2          =


  Details:     https://kernelci.org/test/plan/id/647f247331ce609210f5de27

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1320-g1ddf4b637f785/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/ltp-timers-qemu_x86_64.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1320-g1ddf4b637f785/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/ltp-timers-qemu_x86_64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230527.0/amd64/rootfs.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/647f247331c=
e609210f5de2c
        new failure (last pass: v6.1.26-1321-g3152fb7c8d2d6)

    2023-06-06T12:19:43.776643  =

   =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/647f247331c=
e609210f5de2c
        new failure (last pass: v6.1.26-1321-g3152fb7c8d2d6)

    2023-06-06T12:19:43.776643  =

   =

 =20

