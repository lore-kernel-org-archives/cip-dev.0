Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5FD8C636D6
	for <webhook@archiver.kernel.org>; Wed, 22 Feb 2023 20:07:48 +0000 (UTC)
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
 by mx.groups.io with SMTP id smtpd.web10.3636.1677096468233975947
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 22 Feb 2023 12:07:48 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=BfV/7iR6;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.50, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f50.google.com with SMTP id qi12-20020a17090b274c00b002341621377cso10013002pjb.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 22 Feb 2023 12:07:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=lxh38+MEeD1vFgdUs9rGCyyPuIMQ+pnwW3qdLAalw/E=;
        b=BfV/7iR60zVnWSTS5Sbt1OIKH7+HvdZvL8OJHnhWCRgK8xnG5BzckW80D/eT85eJ44
         WfQTwu14BXPKZq9ITJsLB7annP5Qu6mXsh1MYba4KBtQ4mK8Dbrqt2xujdP1mwbPA+gq
         bAt8HUTO3mn7PuC/7DtLwZac/3Lz5kEBp/zcd/N6+S6lxPnsTu9IybHgL1WvNNSLJqK6
         sD7lp13/NRdF2GvBG+nxk33+izxqIEhlMT6Y9dfZNCpz7H0P2QyznCMm1ZiGbIKH/bMe
         areW2THupazaX0LMRPfVECyOYmpyNKrWsmB3e/7t5XZO129QHehM+B+o4EMEPmNGwa7L
         FHxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lxh38+MEeD1vFgdUs9rGCyyPuIMQ+pnwW3qdLAalw/E=;
        b=hcoBsxdGl2pZ9Hl1Epd+7mIQf2qJyTFPIAQbhf1Orso+40ukXaMB9G7Rq1+hKfBd+Z
         R70EPeCN2nIb4XzQ6qZ1LgP23P/Z4IX+INDF8O7s4YcE0ix611Eme0menR6mipaxqzCo
         CZNnsqor/A2JBg3oYPNUh/bg1d2cEqY0SGMO1jocok/rn3wUMVtX7psm71W7rUWewnwL
         0qyx31qWiqGNjyU8yqMQdLELSJPFIb1JhLbyRGU5BFAafzJPjmG/ThbGjcbmYuENaTTq
         FrHE5dCIPfSWzHgI9o8En6hekY2pjpYNF8BsniLnmxe1zWluTLyxnztal+fFs7k+xQ3Y
         J5og==
X-Gm-Message-State: AO0yUKVOBaCSfbFpRA6TFNBYQNrPWrmhRopAsQmJYPzSZnuX1x91jUS+
	dpPtl3KyQwMxm33Qx6x3zmXTTQCRrIykT1/bxPuDyg==
X-Google-Smtp-Source: AK7set9a3tnAGJ1M9Pd7FoltVwoBSiLeEDuzvy2DM9H1jBuvlZW9fKrsj3WOYM16kLwuZAsLnZvqHQ==
X-Received: by 2002:a17:903:1108:b0:19c:a9b8:58ea with SMTP id n8-20020a170903110800b0019ca9b858eamr3276601plh.45.1677096467316;
        Wed, 22 Feb 2023 12:07:47 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id iy7-20020a170903130700b00196807b5189sm140975plb.292.2023.02.22.12.07.46
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Feb 2023 12:07:47 -0800 (PST)
Message-ID: <63f67613.170a0220.19bbb.0a7f@mx.google.com>
Date: Wed, 22 Feb 2023 12:07:47 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-4.19.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v4.19.272-cip91-91-gb4755c11cb57
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc ltp-timers: 5 runs,
 8 regressions (v4.19.272-cip91-91-gb4755c11cb57)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 22 Feb 2023 20:07:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10794

cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc ltp-timers: 5 runs, 8 regression=
s (v4.19.272-cip91-91-gb4755c11cb57)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 2          =

r8a774a1-hihope-rzg2m-ex  | arm64  | lab-cip       | gcc-10   | defconfig  =
                  | 2          =

r8a774a1-hihope-rzg2m-ex  | arm64  | lab-cip       | gcc-10   | defconfig+a=
rm64-chromebook   | 2          =

rk3399-gru-kevin          | arm64  | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook   | 2          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-4.19.y-cip-rc/kernel/v4.19.272-cip91-91-gb4755c11cb57/plan/ltp-timer=
s/

  Test:     ltp-timers
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-4.19.y-cip-rc
  Describe: v4.19.272-cip91-91-gb4755c11cb57
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      b4755c11cb578851c6f8f50c94fcac17e987653c

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  86f0584539eb1567f009f3e38be6940830649b92 =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/63f66bffec3997ad2e8c8645

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.272-cip91-91-gb4755c11cb57/x86_64/x86_64_defconfig+x86-c=
hromebook/gcc-10/lab-collabora/ltp-timers-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.272-cip91-91-gb4755c11cb57/x86_64/x86_64_defconfig+x86-c=
hromebook/gcc-10/lab-collabora/ltp-timers-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230217.0/amd64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/63f66bffec3=
997ad2e8c8657
        failing since 110 days (last pass: v4.19.256-cip80-1-g68250b8eafbe0=
, first fail: v4.19.261-cip83-311-g41979a0fec1a) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/63f66bffec3=
997ad2e8c8657
        failing since 110 days (last pass: v4.19.256-cip80-1-g68250b8eafbe0=
, first fail: v4.19.261-cip83-311-g41979a0fec1a) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
r8a774a1-hihope-rzg2m-ex  | arm64  | lab-cip       | gcc-10   | defconfig  =
                  | 2          =


  Details:     https://kernelci.org/test/plan/id/63f66937dba72d8db68c8637

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.272-cip91-91-gb4755c11cb57/arm64/defconfig/gcc-10/lab-ci=
p/ltp-timers-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.272-cip91-91-gb4755c11cb57/arm64/defconfig/gcc-10/lab-ci=
p/ltp-timers-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230217.0/arm64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/63f66937dba=
72d8db68c8642
        new failure (last pass: v4.19.271-cip90-81-g5d0e00d43751) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/63f66937dba=
72d8db68c8642
        new failure (last pass: v4.19.271-cip90-81-g5d0e00d43751) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
r8a774a1-hihope-rzg2m-ex  | arm64  | lab-cip       | gcc-10   | defconfig+a=
rm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/63f674dba27e45d88c8c8726

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.272-cip91-91-gb4755c11cb57/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-cip/ltp-timers-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.272-cip91-91-gb4755c11cb57/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-cip/ltp-timers-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230217.0/arm64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/63f674dba27=
e45d88c8c8731
        new failure (last pass: v4.19.271-cip90-81-g5d0e00d43751) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/63f674dba27=
e45d88c8c8731
        new failure (last pass: v4.19.271-cip90-81-g5d0e00d43751) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
rk3399-gru-kevin          | arm64  | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/63f66f7a590bbbcd048c8708

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.272-cip91-91-gb4755c11cb57/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-collabora/ltp-timers-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.272-cip91-91-gb4755c11cb57/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-collabora/ltp-timers-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230217.0/arm64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/63f66f7a590=
bbbcd048c870d
        failing since 91 days (last pass: v4.19.264-cip84-50-g1e56b70eaf66,=
 first fail: v4.19.265-cip85-36-gf1ffb3de9576) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/63f66f7a590=
bbbcd048c870d
        failing since 91 days (last pass: v4.19.264-cip84-50-g1e56b70eaf66,=
 first fail: v4.19.265-cip85-36-gf1ffb3de9576) =

 =20

