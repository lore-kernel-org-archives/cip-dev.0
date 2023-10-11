Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D600CD98E9
	for <webhook@archiver.kernel.org>; Wed, 11 Oct 2023 02:51:08 +0000 (UTC)
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
 by mx.groups.io with SMTP id smtpd.web11.8687.1696992660150570948
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 10 Oct 2023 19:51:00 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=c+qWc0yw;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.180, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1c9a1762b43so20860885ad.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 10 Oct 2023 19:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1696992659; x=1697597459; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=UI535XWL39c1j3cKHANFbhuizaiNl19Sx0BnnyWMEvA=;
        b=c+qWc0yw2sn1WXKcC9la/U4xdypvLRiK0ucItjjG1HXmwS8ZJwmhLGnwPm7NkPRZO/
         1IA0coaqef86XhGUpLCtAaj2pv8fjVP5+0i7mSCqlziI2qWFf9FJxDNbEhyZb8TqVEG0
         zNVEg8NhFASoj1mGnEVAGma05+0RihgINMXWw2dVwxDqQJ4jnZwPfcAM8vtv/AB0cQzw
         oPxyR0u3xfy74v94C/i99ZhAWuf1X9Fifik1sRcgTEEoMODmn4nafcDnN9WkjnMBI1IJ
         WKE/JulHmyTIY3Rz6Yf67ekA0RaLZsNK6UaVlin8GpdpyCHpltb8QwSlAlwIo1BxJ3FE
         0dzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696992659; x=1697597459;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UI535XWL39c1j3cKHANFbhuizaiNl19Sx0BnnyWMEvA=;
        b=X4zp4UddRYmm0+ScC0qPHqwK+O1/Il94xrWL7+7jG2EecO2alXkK3nxWRmuglpZPYD
         Z+IyzYFodNv/zbaNgdJBKc0mBXORinFBS72F4KzrTzl5HtBp/gNe4KE5rO6/EhZ4go4G
         jeM6Gs74eu8/pEslnffvlz/0jry8mP4+bDBcbTAvT/jj4tZGYOxsmRz0TJO2AxePKedq
         Or4ov58ZE935Nu1wB4MsAE4paFkaMpYZ1MfFid1fiA5CNPRP5WsQ/m0u4sk3lMRMO+FZ
         WJLcTeeSRf6XrvuTkq9ZRn3Mtaw56G6RnLpEboZl+OqPkja3lDKRnoW2s24pjjNyvjTK
         alVQ==
X-Gm-Message-State: AOJu0Ywtd7z+xmNc9a9Iv2G00jS58niY5nFQOjDIW8+rzb2UKDvv92/H
	JFAP6tFX+rPjWKa/ZciRzLH9j+Knanu5jnD5pULhpA==
X-Google-Smtp-Source: AGHT+IG8PwXjk3AEkEgrNyTXm1jOGTio9zqMaYqbG0bxCj5PInyvoevt5oc6XDWM4yBTuDytqNE8dg==
X-Received: by 2002:a17:902:9689:b0:1c9:c14e:bf1c with SMTP id n9-20020a170902968900b001c9c14ebf1cmr2306549plp.40.1696992658668;
        Tue, 10 Oct 2023 19:50:58 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id y7-20020a17090322c700b001c726147a46sm12561141plg.234.2023.10.10.19.50.57
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 19:50:58 -0700 (PDT)
Message-ID: <65260d92.170a0220.938bf.3f01@mx.google.com>
Date: Tue, 10 Oct 2023 19:50:58 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v4.19.295-cip103-95-ge42cfc8bb88b7
X-Kernelci-Report-Type: test
X-Kernelci-Branch: ci/iwamatsu/linux-4.19.y-cip-rc
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc ltp-timers: 9 runs,
 8 regressions (v4.19.295-cip103-95-ge42cfc8bb88b7)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 11 Oct 2023 02:51:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13386

cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc ltp-timers: 9 runs, 8 regression=
s (v4.19.295-cip103-95-ge42cfc8bb88b7)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 2          =

hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 2          =

r8a774a1-hihope-rzg2m-ex  | arm64  | lab-cip       | gcc-10   | defconfig  =
                  | 2          =

rk3399-gru-kevin          | arm64  | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook   | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-4.19.y-cip-rc/kernel/v4.19.295-cip103-95-ge42cfc8bb88b7/plan/ltp-tim=
ers/

  Test:     ltp-timers
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-4.19.y-cip-rc
  Describe: v4.19.295-cip103-95-ge42cfc8bb88b7
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      e42cfc8bb88b7ac345bd44cd4a1eb3cae3dea954

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/65260608122a040471efcf29

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.295-cip103-95-ge42cfc8bb88b7/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-collabora/ltp-timers-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.295-cip103-95-ge42cfc8bb88b7/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-collabora/ltp-timers-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/amd64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/65260608122a040471e=
fcf2a
        new failure (last pass: v4.19.287-cip100-43-g1a6518aa81690) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/65260257b6cc992ce1efcf00

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.295-cip103-95-ge42cfc8bb88b7/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-collabora/ltp-timers-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.295-cip103-95-ge42cfc8bb88b7/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-collabora/ltp-timers-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/amd64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/65260257b6c=
c992ce1efcf05
        failing since 341 days (last pass: v4.19.256-cip80-1-g68250b8eafbe0=
, first fail: v4.19.261-cip83-311-g41979a0fec1a) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/65260257b6c=
c992ce1efcf05
        failing since 341 days (last pass: v4.19.256-cip80-1-g68250b8eafbe0=
, first fail: v4.19.261-cip83-311-g41979a0fec1a) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/652602f72c8046df2fefcf31

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.295-cip103-95-ge42cfc8bb88b7/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-collabora/ltp-timers-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.295-cip103-95-ge42cfc8bb88b7/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-collabora/ltp-timers-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/amd64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/652602f72c8=
046df2fefcf36
        failing since 341 days (last pass: v4.19.256-cip80-1-g68250b8eafbe0=
, first fail: v4.19.261-cip83-311-g41979a0fec1a) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/652602f72c8=
046df2fefcf36
        failing since 341 days (last pass: v4.19.256-cip80-1-g68250b8eafbe0=
, first fail: v4.19.261-cip83-311-g41979a0fec1a) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
r8a774a1-hihope-rzg2m-ex  | arm64  | lab-cip       | gcc-10   | defconfig  =
                  | 2          =


  Details:     https://kernelci.org/test/plan/id/652604740bce526bd1efcf0e

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.295-cip103-95-ge42cfc8bb88b7/arm64/defconfig/gcc-10/lab-=
cip/ltp-timers-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.295-cip103-95-ge42cfc8bb88b7/arm64/defconfig/gcc-10/lab-=
cip/ltp-timers-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/652604740bc=
e526bd1efcf19
        failing since 104 days (last pass: v4.19.284-cip99-114-g02e97826987=
bf, first fail: v4.19.287-cip100-43-g1a6518aa81690) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/652604740bc=
e526bd1efcf19
        failing since 104 days (last pass: v4.19.284-cip99-114-g02e97826987=
bf, first fail: v4.19.287-cip100-43-g1a6518aa81690) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
rk3399-gru-kevin          | arm64  | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/6526082a1037400c39efcf3b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.295-cip103-95-ge42cfc8bb88b7/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-collabora/ltp-timers-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.295-cip103-95-ge42cfc8bb88b7/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-collabora/ltp-timers-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/6526082a1037400c39e=
fcf3c
        new failure (last pass: v4.19.287-cip100-43-g1a6518aa81690) =

 =20

