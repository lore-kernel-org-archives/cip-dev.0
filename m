Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A0B1C004D4
	for <webhook@archiver.kernel.org>; Thu, 19 Jan 2023 10:29:20 +0000 (UTC)
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
 by mx.groups.io with SMTP id smtpd.web11.42476.1674124152405975865
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 19 Jan 2023 02:29:12 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=k2wm6QnQ;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.48, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f48.google.com with SMTP id dw9so1926993pjb.5
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 19 Jan 2023 02:29:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=BeXVoYaCY+jiBLftH/j7RYOaTRgcDKKWYc2TlnbMC7I=;
        b=k2wm6QnQjDsTAR7HQ/c4pPzzS4j//WxBjjYUcWZJevQybP+fiSyL9NZ61++w7fumhe
         p35T8EK5roGOB0QRw+tbJh3DwRVKqQs5fOxwLTJlwVPk3eFFJxiGgGVPzdFYLS32qbET
         2okM61LcsjyKYF4f830L46n/KIVJ6hK2yIodxn/wfiYv8lUxrGbI+zzC3v711ioIShA1
         k3E+qoXuMnenpsVr0LDma0Xo+6M0+Rtwws99qIUcYMapT3sVbIGUYznPxns15fGgsrAA
         Fkt0wtP9yAeEcrtrMnzGY0pv+Yepfmo9Zi+9uclI8ZPxj0zCHvUpCHuA/vqV0/0UVvwJ
         Uo5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BeXVoYaCY+jiBLftH/j7RYOaTRgcDKKWYc2TlnbMC7I=;
        b=m5YhSwH43G5h+tfTcjll2jEluGOlrEaCVaDDeb0oaCmHZFhSmxm1aA/BVYMj3lnYBB
         sDIf66KWg3vlcUBhdmXUv2uJlFoulfWm+JwwDxP3BsjxVS/IqrNmHQk14bcxFIxsHJDI
         t91snieyKvveoc87KJyq0TMBscbCRlfrzChrl+Y7QyQBJZc+ucg1m1wcSTjhzvKEWJk/
         0xY8R09qD2o3KgjPOJuWAKsYd3npRtWpw5z9gneBXcrLP6lvBdebz65ij0a1Uh71//UU
         3wT28N1Aet1UUYGGe8Wn1BITE/oZz3sueOLQt9Ckmp7mwT9nqKdDfXHvjocfgm1QOljh
         Zofw==
X-Gm-Message-State: AFqh2krIq4sSc/ML9QdluyR96odHpEv3U0VioEqhVbeGciDsVBUhsGgV
	WEdNm52ANPyL9WJS87U7cvgTG61e+8HhladMEoeLqw==
X-Google-Smtp-Source: AMrXdXu6S7rclRQQi9hRWxSNxXr4C8ahLsISkXY8vLoukpxgNru9hDD4NE4vxAbG102Jp5gXjzIogA==
X-Received: by 2002:a05:6a20:7d8d:b0:a9:e225:6f7b with SMTP id v13-20020a056a207d8d00b000a9e2256f7bmr13887397pzj.0.1674124151108;
        Thu, 19 Jan 2023 02:29:11 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id x4-20020a634844000000b0044046aec036sm20509461pgk.81.2023.01.19.02.29.10
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 02:29:10 -0800 (PST)
Message-ID: <63c91b76.630a0220.286e7.01e4@mx.google.com>
Date: Thu, 19 Jan 2023 02:29:10 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-4.19.y-cip-rc
X-Kernelci-Kernel: v4.19.269-cip88-479-g3f9e11225caa5
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc ltp-timers: 7 runs,
 6 regressions (v4.19.269-cip88-479-g3f9e11225caa5)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 19 Jan 2023 10:29:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10434

cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc ltp-timers: 7 runs, 6 regression=
s (v4.19.269-cip88-479-g3f9e11225caa5)

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
Flinux-4.19.y-cip-rc/kernel/v4.19.269-cip88-479-g3f9e11225caa5/plan/ltp-tim=
ers/

  Test:     ltp-timers
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-4.19.y-cip-rc
  Describe: v4.19.269-cip88-479-g3f9e11225caa5
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      3f9e11225caa53af6e56924348b7fb20ccc15806

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  cf59c1fb5f7181453b16171d75654ee9a1216dde =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/63c91390e447670b1b915ef5

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.269-cip88-479-g3f9e11225caa5/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-collabora/ltp-timers-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.269-cip88-479-g3f9e11225caa5/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-collabora/ltp-timers-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230114.0/amd64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/63c91391e44=
7670b1b915efa
        failing since 76 days (last pass: v4.19.256-cip80-1-g68250b8eafbe0,=
 first fail: v4.19.261-cip83-311-g41979a0fec1a) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/63c91391e44=
7670b1b915efa
        failing since 76 days (last pass: v4.19.256-cip80-1-g68250b8eafbe0,=
 first fail: v4.19.261-cip83-311-g41979a0fec1a) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/63c91a81ede169fad7915ec7

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.269-cip88-479-g3f9e11225caa5/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-collabora/ltp-timers-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.269-cip88-479-g3f9e11225caa5/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-collabora/ltp-timers-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230114.0/amd64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/63c91a81ede=
169fad7915ecc
        failing since 76 days (last pass: v4.19.256-cip80-1-g68250b8eafbe0,=
 first fail: v4.19.261-cip83-311-g41979a0fec1a) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/63c91a81ede=
169fad7915ecc
        failing since 76 days (last pass: v4.19.256-cip80-1-g68250b8eafbe0,=
 first fail: v4.19.261-cip83-311-g41979a0fec1a) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
rk3399-gru-kevin          | arm64  | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/63c90d1ebc9abfb7b1915fe8

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.269-cip88-479-g3f9e11225caa5/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-collabora/ltp-timers-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.269-cip88-479-g3f9e11225caa5/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-collabora/ltp-timers-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230114.0/arm64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/63c90d1ebc9=
abfb7b1915fed
        failing since 56 days (last pass: v4.19.264-cip84-50-g1e56b70eaf66,=
 first fail: v4.19.265-cip85-36-gf1ffb3de9576)

    2023-01-19T09:27:48.823263     =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/63c90d1ebc9=
abfb7b1915fed
        failing since 56 days (last pass: v4.19.264-cip84-50-g1e56b70eaf66,=
 first fail: v4.19.265-cip85-36-gf1ffb3de9576)

    2023-01-19T09:27:48.823263     =

 =20

