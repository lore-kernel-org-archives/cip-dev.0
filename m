Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EF65C4332F
	for <webhook@archiver.kernel.org>; Sat, 24 Dec 2022 00:17:12 +0000 (UTC)
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
 by mx.groups.io with SMTP id smtpd.web10.86926.1671841030257146084
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 23 Dec 2022 16:17:10 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=Zd7LyMyN;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.179, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f179.google.com with SMTP id s7so6220846plk.5
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 23 Dec 2022 16:17:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=PiA1d32EY2KU7559+gPrrXa2bJIh331xAmejtiXMQv0=;
        b=Zd7LyMyNaPv4J3XTTXdbUMWR6M5iDChL/kBQ7+nLuBD2NsbC3lqRbKvohLO4aCB4kh
         SJbHWCtp9tGZSCO9XbaFM6UL6v/DHrvv4JDLpW6D3Qsj+H+3cwip6s5JL/2/z8rfTtyb
         9CMdZYkzyDmIEuo2IBr1/TLyTZjirklN/60AE7sNK+NNk3NHc5TlUm2Ff4yLnEImwJKR
         KlYhHm9sOxSNYm1w1F/OGZArQYkP9VLgue6gqvdXcgMabLp3qRuWEoeL66t0kXMRzAWQ
         56kCEHmCBiy9y32bFM0+TtSN4cGOGHS7St7Iy7sk9zc0NIW7XeFV4TsTS8wAZoYF9Fc3
         oPog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PiA1d32EY2KU7559+gPrrXa2bJIh331xAmejtiXMQv0=;
        b=wamg+PodifUZm0+FidQardH30uZYLqDFtAPCTE1hIWYf5IiGukLFRtvpkDAcMyVkCV
         V6rVbRSNXLXTQ5EoeDf/Atdw3DBnqRcZq2G/3qPVdoY0n+Z4oELsPwNw3P3xaCoF30qv
         pUZ6ewrBz068/g/rwr3MspIelQo15KeQyymScdLt0O3tT4NqXJDsMe5qqH0tPOYgb0nO
         Za2j0OxMfNjwNBnRnIncEl2bnk9fcmkJJTsGNHZOm/UbvE9y+Qjp+AphUcFmh365Jn3n
         Z/GPRptgllsqOyFK542nOKuDPfE8E1Xx0h78L6/0bk8AUVZgvv7K9oXDo/MS/bX7Gnb5
         9odA==
X-Gm-Message-State: AFqh2kpyQPfKSXTQEHpnpTrdJLuoCTEIWXpP+NHbpeOtUCQBUvTFWKFN
	kzRF8B+2WWSfqchBBIM7Hx2rWkVXjWZ++KRC+Jw=
X-Google-Smtp-Source: AMrXdXtTj0aDWuX+vx8kN6ZGRIOnXYH10crlxTAlle+GM6PlF8V67GfV/YD6P6LdUxnBeEcbM7cWhw==
X-Received: by 2002:a05:6a21:3996:b0:9d:efbf:7876 with SMTP id ad22-20020a056a21399600b0009defbf7876mr15313486pzc.43.1671841029427;
        Fri, 23 Dec 2022 16:17:09 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id h27-20020a63385b000000b0045dc85c4a5fsm2789107pgn.44.2022.12.23.16.17.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Dec 2022 16:17:09 -0800 (PST)
Message-ID: <63a64505.630a0220.61795.533a@mx.google.com>
Date: Fri, 23 Dec 2022 16:17:09 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v4.19.269-cip88
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-4.19.y-cip
X-Kernelci-Report-Type: test
Subject: cip/linux-4.19.y-cip ltp-timers: 9 runs,
 7 regressions (v4.19.269-cip88)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 24 Dec 2022 00:17:12 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10268

cip/linux-4.19.y-cip ltp-timers: 9 runs, 7 regressions (v4.19.269-cip88)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 2          =

asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 2          =

rk3399-gru-kevin          | arm64  | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook   | 2          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.19.y-cip/kerne=
l/v4.19.269-cip88/plan/ltp-timers/

  Test:     ltp-timers
  Tree:     cip
  Branch:   linux-4.19.y-cip
  Describe: v4.19.269-cip88
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      68472fb565eddeb233132b8be94440d06330ffbb

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  9547e6a3a3dce0fce39215b54f4fe314de54a5a8 =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/63a63a39208bc7c4c64eee25

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.269=
-cip88/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-time=
rs-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.269=
-cip88/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-time=
rs-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20221216.0/amd64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/63a63a39208=
bc7c4c64eee2a
        failing since 27 days (last pass: v4.19.259-cip82, first fail: v4.1=
9.266-cip86) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/63a63a39208=
bc7c4c64eee2a
        failing since 27 days (last pass: v4.19.259-cip82, first fail: v4.1=
9.266-cip86) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63a63e1017d2103e0f4eee1a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.269=
-cip88/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-time=
rs-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.269=
-cip88/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-time=
rs-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20221216.0/amd64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/63a63e1017d2103e0f4=
eee1b
        new failure (last pass: v4.19.268-cip87) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/63a63abf2bff24ba274eee2e

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.269=
-cip88/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-time=
rs-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.269=
-cip88/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-time=
rs-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20221216.0/amd64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/63a63abf2bf=
f24ba274eee33
        failing since 27 days (last pass: v4.19.259-cip82, first fail: v4.1=
9.266-cip86) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/63a63abf2bf=
f24ba274eee33
        failing since 27 days (last pass: v4.19.259-cip82, first fail: v4.1=
9.266-cip86) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
rk3399-gru-kevin          | arm64  | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/63a637abad0c882acd4eee1c

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.269=
-cip88/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/ltp-timers-rk3=
399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.269=
-cip88/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/ltp-timers-rk3=
399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20221216.0/arm64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/63a637abad0=
c882acd4eee21
        failing since 27 days (last pass: v4.19.259-cip82, first fail: v4.1=
9.266-cip86) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/63a637abad0=
c882acd4eee21
        failing since 27 days (last pass: v4.19.259-cip82, first fail: v4.1=
9.266-cip86) =

 =20

