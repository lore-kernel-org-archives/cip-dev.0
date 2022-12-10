Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27FB6C04FDE
	for <webhook@archiver.kernel.org>; Sat, 10 Dec 2022 02:13:39 +0000 (UTC)
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
 by mx.groups.io with SMTP id smtpd.web11.6051.1670638409414101382
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 09 Dec 2022 18:13:29 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=1UtgSIw2;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.170, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f170.google.com with SMTP id n3so4934849pfq.10
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 09 Dec 2022 18:13:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=gMt+/zZo+xfxOPVZcMGwDkYfRb+oQ64gARxhbyau5XQ=;
        b=1UtgSIw2k9M3lONT8fz3LGefAUiiWB+GRR8/uBLgL07jP8bdm8QoM4968zhNHlx4c9
         TCF7saK0R5Lvskbu/8M63e5q9CWyQMLuE5Jc3eLivLPjWhZUibSFjYnpr/iz/HARN2pn
         s+0rtBn9vootpBhKA1ALZuJYCiUufb79dde5ypAhDeinO7ApU/txZHWxP1nQ00zQXZgz
         dTEm2V9kqCFmSzPampH668EtLEryQBoD7TeZAr4IFv70ZaAe1UV8YzaYNX5aN5QYS4sa
         XIeSaF9sa2+IZeFz8WppaxNYAXaN0F6Pail2sG2UMuGlEXnPjY9HppCVzcu6B6zbR/0I
         ELDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gMt+/zZo+xfxOPVZcMGwDkYfRb+oQ64gARxhbyau5XQ=;
        b=qW3r/zfrxS9XfYqjwnFRK6K0RDKlTdjHyGGZlQs3EKWgnh3GIuw50Oa7hQlHw63L0L
         va3+n2PvmjqALKo7BjugdwNpd5YfXxoILwSdjUJ4hiVen24xRXAO75pw7lJVBx3wXpmR
         exZ1DYEW+C9yQXQQHycT2L9H6wUqFgjo3Y7OuQqP4bwGfVu6iOFcjA6V/PSQ78ck5yvM
         krCQ3NQYQE+W1RkF3p3k5tQ3+9XXeYJBLBLXyKwFQsOWnd/Kun7TyDgnmm02cDLrYAio
         2nJ7em8bfeT9LWepFK3RMt3OcH3vNsP3sh2ucyMaiL2L3jWB9pBX26KzTX/TP6rdr2zK
         yDDg==
X-Gm-Message-State: ANoB5plzj1VCEieq69ciWP53k4WzqwUMn/brdr7AjiS5GySn9qzrgDL1
	8lLLhPk5D367PuODmKDyL/O3DXU99J9HAh/NIv8=
X-Google-Smtp-Source: AA0mqf5ectJyGmnSsZBgORYV6IVIC6QkLyY9plGDUoTtaSkNLD8gZIAPGdPAhu4F66Ny/mr5YwpGLQ==
X-Received: by 2002:a62:1a8a:0:b0:56e:9a2c:152b with SMTP id a132-20020a621a8a000000b0056e9a2c152bmr7862111pfa.24.1670638408264;
        Fri, 09 Dec 2022 18:13:28 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id g7-20020aa796a7000000b0057564323987sm1792041pfk.139.2022.12.09.18.13.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Dec 2022 18:13:27 -0800 (PST)
Message-ID: <6393eb47.a70a0220.67f3d.3d40@mx.google.com>
Date: Fri, 09 Dec 2022 18:13:27 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.19.y-cip
X-Kernelci-Kernel: v4.19.268-cip87
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip
Subject: cip/linux-4.19.y-cip ltp-timers: 8 runs,
 6 regressions (v4.19.268-cip87)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 10 Dec 2022 02:13:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10185

cip/linux-4.19.y-cip ltp-timers: 8 runs, 6 regressions (v4.19.268-cip87)

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

rk3399-gru-kevin          | arm64  | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook   | 2          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.19.y-cip/kerne=
l/v4.19.268-cip87/plan/ltp-timers/

  Test:     ltp-timers
  Tree:     cip
  Branch:   linux-4.19.y-cip
  Describe: v4.19.268-cip87
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      268e570d0a5691ceb479fa0368a6c73c5b080f89

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  e76de05a93390f5ec7fae2941d8f24d367c9b2b8 =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/6393ddb4e07f91d6e82abd02

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.268=
-cip87/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-time=
rs-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.268=
-cip87/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-time=
rs-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20221202.0/amd64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/6393ddb4e07=
f91d6e82abd07
        failing since 13 days (last pass: v4.19.259-cip82, first fail: v4.1=
9.266-cip86) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/6393ddb4e07=
f91d6e82abd07
        failing since 13 days (last pass: v4.19.259-cip82, first fail: v4.1=
9.266-cip86) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
r8a774a1-hihope-rzg2m-ex  | arm64  | lab-cip       | gcc-10   | defconfig+a=
rm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/6393e639c7da3bc79a2abd01

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.268=
-cip87/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/ltp-timers-r8a774a1-=
hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.268=
-cip87/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/ltp-timers-r8a774a1-=
hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20221202.0/arm64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/6393e639c7d=
a3bc79a2abd0c
        new failure (last pass: v4.19.259-cip82) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/6393e639c7d=
a3bc79a2abd0c
        new failure (last pass: v4.19.259-cip82) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
rk3399-gru-kevin          | arm64  | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/6393e09b87affbe93f2abd0d

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.268=
-cip87/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/ltp-timers-rk3=
399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.268=
-cip87/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/ltp-timers-rk3=
399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20221202.0/arm64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/6393e09b87a=
ffbe93f2abd12
        failing since 13 days (last pass: v4.19.259-cip82, first fail: v4.1=
9.266-cip86) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/6393e09b87a=
ffbe93f2abd12
        failing since 13 days (last pass: v4.19.259-cip82, first fail: v4.1=
9.266-cip86) =

 =20

