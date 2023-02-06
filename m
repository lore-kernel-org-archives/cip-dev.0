Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F0E2C05027
	for <webhook@archiver.kernel.org>; Mon,  6 Feb 2023 12:24:44 +0000 (UTC)
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
 by mx.groups.io with SMTP id smtpd.web10.51851.1675686277448969390
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 06 Feb 2023 04:24:37 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=pDQEcIUd;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.174, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f174.google.com with SMTP id b5so11923130plz.5
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 06 Feb 2023 04:24:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=TEg8NwCBcbDeh5QyOa8IFAiAmIRyrP/SVNoTzAGue1Y=;
        b=pDQEcIUdmC+9n4AfovA954JE/GL4m0IBAVLUzDZdyoEX3sLVn9exdeGvJvRO8+TftK
         0sB2ghP6WwlKZacxOwtYsXNAuVrUkdXm3b3KEcaJNHwl7+B1ysuux2KwahFoxyXM1ybO
         RF4YU9OMSGIMoquEiDTEONO2UF9CiOAGPC+hCL8pmwwi5Saq4FjCKyFbKjD/kkpT9Ogg
         J98KAvsWpNboDBDiOw1nYryNbqa0NCRsvgcPaZpM4mVRSNoXKTSHfD3OfTmZ9bXCFXEo
         iV3WMQ1o8DnElJF0WxLeevCOsUYeUVGKgQsgKQFhCq6ZaKg5qA0WIEj8r+dB7RCTJxxS
         yRGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TEg8NwCBcbDeh5QyOa8IFAiAmIRyrP/SVNoTzAGue1Y=;
        b=iTxJD3l1dTgs2T/eqiCOJum7MTeB2OXgTT1EfqsDMVP0sD125p16HMM2UgIA7Gdb2I
         JVHapVi5AhapYDjdyKUiX3A1LJqsiyr5VpxJm+7/Is4IEu3G6GtcVHvcssiF4qK4hl1z
         FgGmfNl7eWbUcVfTPjthcslNkz89X7yXDxv3oSyqHC3FSRj4kV4h+PbNG/47Kay90Yvn
         h/nETZEUEUCyBescRpYYn6FQfulAleTypVO6oXYxfh0EyXWtond0OmDk1nyUIw6VD0ym
         UTCOnpykpj/1JCYynjCJ8u/bCP5aap1ZAOtBaOzZy9LG6MXqmidFLo6RF3H05kDtC8b5
         hXzA==
X-Gm-Message-State: AO0yUKV0sSqJatWJRoAgOjoAa+9jW0AV5BY+dOJgbXZL2dK+OXeByRmL
	r/I8nP0pZGFNIxkQSSM9aa8Shc1OdJlUbgOyMos=
X-Google-Smtp-Source: AK7set8kUEsTv/Kl82RsVkKnTXnNwAwTX4G1DDoWDRNS7boe45m/UOqZA9tdPQ4jSjzGbHsK0Xax+w==
X-Received: by 2002:a17:902:f14c:b0:199:1da6:b8e0 with SMTP id d12-20020a170902f14c00b001991da6b8e0mr1658768plb.6.1675686276414;
        Mon, 06 Feb 2023 04:24:36 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id jj20-20020a170903049400b001991582601esm2118907plb.39.2023.02.06.04.24.35
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 04:24:35 -0800 (PST)
Message-ID: <63e0f183.170a0220.67c28.2f8b@mx.google.com>
Date: Mon, 06 Feb 2023 04:24:35 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-4.19.y-cip-rc
X-Kernelci-Kernel: v4.19.271-cip90-81-g5d0e00d43751
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc ltp-timers: 9 runs,
 6 regressions (v4.19.271-cip90-81-g5d0e00d43751)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 06 Feb 2023 12:24:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10601

cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc ltp-timers: 9 runs, 6 regression=
s (v4.19.271-cip90-81-g5d0e00d43751)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 2          =

asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 2          =

rk3399-gru-kevin          | arm64  | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook   | 2          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-4.19.y-cip-rc/kernel/v4.19.271-cip90-81-g5d0e00d43751/plan/ltp-timer=
s/

  Test:     ltp-timers
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-4.19.y-cip-rc
  Describe: v4.19.271-cip90-81-g5d0e00d43751
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      5d0e00d43751ec5f81c621ca2b1747e2e34d4528

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  dd2d61ac1a1e09797a6165f478abd4a9f4f43035 =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/63e0e4afce5f258157915ecc

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.271-cip90-81-g5d0e00d43751/x86_64/x86_64_defconfig+x86-c=
hromebook/gcc-10/lab-collabora/ltp-timers-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.271-cip90-81-g5d0e00d43751/x86_64/x86_64_defconfig+x86-c=
hromebook/gcc-10/lab-collabora/ltp-timers-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230127.0/amd64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/63e0e4afce5=
f258157915ed1
        failing since 94 days (last pass: v4.19.256-cip80-1-g68250b8eafbe0,=
 first fail: v4.19.261-cip83-311-g41979a0fec1a) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/63e0e4afce5=
f258157915ed1
        failing since 94 days (last pass: v4.19.256-cip80-1-g68250b8eafbe0,=
 first fail: v4.19.261-cip83-311-g41979a0fec1a) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/63e0e59eeec1139080915ec6

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.271-cip90-81-g5d0e00d43751/x86_64/x86_64_defconfig+x86-c=
hromebook/gcc-10/lab-collabora/ltp-timers-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.271-cip90-81-g5d0e00d43751/x86_64/x86_64_defconfig+x86-c=
hromebook/gcc-10/lab-collabora/ltp-timers-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230127.0/amd64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/63e0e59eeec=
1139080915ecb
        failing since 94 days (last pass: v4.19.256-cip80-1-g68250b8eafbe0,=
 first fail: v4.19.261-cip83-311-g41979a0fec1a) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/63e0e59eeec=
1139080915ecb
        failing since 94 days (last pass: v4.19.256-cip80-1-g68250b8eafbe0,=
 first fail: v4.19.261-cip83-311-g41979a0fec1a) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
rk3399-gru-kevin          | arm64  | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/63e0e5a264e4d2c44e915ebd

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.271-cip90-81-g5d0e00d43751/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-collabora/ltp-timers-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.271-cip90-81-g5d0e00d43751/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-collabora/ltp-timers-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230127.0/arm64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/63e0e5a264e=
4d2c44e915ec2
        failing since 75 days (last pass: v4.19.264-cip84-50-g1e56b70eaf66,=
 first fail: v4.19.265-cip85-36-gf1ffb3de9576) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/63e0e5a264e=
4d2c44e915ec2
        failing since 75 days (last pass: v4.19.264-cip84-50-g1e56b70eaf66,=
 first fail: v4.19.265-cip85-36-gf1ffb3de9576) =

 =20

