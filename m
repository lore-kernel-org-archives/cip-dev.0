Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D5FEC433EF
	for <webhook@archiver.kernel.org>; Sat,  2 Jul 2022 21:12:59 +0000 (UTC)
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com
 [209.85.215.173])
 by mx.groups.io with SMTP id smtpd.web12.54590.1656796369785288859
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sat, 02 Jul 2022 14:12:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=idTnc3k/;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.173,
 mailfrom: bot@kernelci.org)
Received: by mail-pg1-f173.google.com with SMTP id 145so5484199pga.12
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sat, 02 Jul 2022 14:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=h2jF9Oj9eLxkJjVHTxKkIVS4kF8EPOMmjlNB6L86aDw=;
        b=idTnc3k/OfPqOMKxgTchRBo2Zf2WPefAKEXdpksjjK+FF5j9AJl+0Sv7jRagsqBadH
         Uw50lAVVYVGEqfv7dDe4+mGsuMxjA1sU+smSKpyMEdSNua6bM60xXS43PY8mvNNicW8B
         n/0xqpswpVI9+3eNCNEKMnefXlJ/fWWkdT1d25TpgCk5+0Bt5NibTZRUgwmePDkGhJe7
         uVPMyHVz+5t7rQMtCyWb+1UUDd0yziWtQdV7Gf27tSaUhDUGs2u7kOlnAYfxDy3F8vd6
         NU65GRFMD/JpTh79e9Rycwbe1rbDWMxcf4cg8dhGZh3oMHCpBYZqUPKEZStajrArQvyc
         LgTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=h2jF9Oj9eLxkJjVHTxKkIVS4kF8EPOMmjlNB6L86aDw=;
        b=pLwosxfduutxfIV00a3FPHQpQA1OTrFSbT8NuTaWInH20NCWeRsmWK4ufvUWD/dbbZ
         1prZVA9oBbBbjBPfS6xUsoZ6TnCq3yNy6kmB+vFnHFvFzKCwPFCts+/LP1eC1jUCGsvR
         OiYbsw/w1QxBqJqJwBe3nrrbQWIYxOyLpGf0qSvV05/2jMFsJc+5RW4yc01zv1GO/OKK
         MEqDx2fmy2F1iulbLBp+iSZZb/Wt1uB0ANA9qfhRgZvDMaHAewbcM03a7f3HlHxJISKN
         4woTSLoPfX0XBimoxcX4dohwSDV0t7Q5Gy5dbLQ8o0tzSSQuoWQhoIInFds4NV+52ltV
         5wVg==
X-Gm-Message-State: AJIora8cey8LHP9a4YhnWjEQibvKibG4QJfRqKRwZY/e6mVRJZh3lPON
	EBNf4PBxknzXk9ZY3uoUPPeNk1xQMtvEL5vc
X-Google-Smtp-Source: 
 AGRyM1u5B4lHqXPXgF39P1BmoyzBp/xODzmi6Bba3E021o+MkQUKtk7/0TUAf+eaOy6USSwd2MrgPg==
X-Received: by 2002:aa7:900a:0:b0:525:1e54:e64e with SMTP id
 m10-20020aa7900a000000b005251e54e64emr27729614pfo.35.1656796369044;
        Sat, 02 Jul 2022 14:12:49 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 o11-20020a634e4b000000b004118fd18476sm7119616pgl.60.2022.07.02.14.12.48
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Jul 2022 14:12:48 -0700 (PDT)
Message-ID: <62c0b4d0.1c69fb81.88b21.a47f@mx.google.com>
Date: Sat, 02 Jul 2022 14:12:48 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.125-cip10-118-gb03e159be974
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-timers: 5 runs,
 2 regressions (v5.10.125-cip10-118-gb03e159be974)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 02 Jul 2022 21:12:59 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8640

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-timers: 5 runs, 2 regression=
s (v5.10.125-cip10-118-gb03e159be974)

Regressions Summary
-------------------

platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip       | gcc-10   | defconfig+arm=
64-chromebook | 1          =

rk3399-gru-kevin         | arm64 | lab-collabora | gcc-10   | defconfig+arm=
64-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.125-cip10-118-gb03e159be974/plan/ltp-time=
rs/

  Test:     ltp-timers
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.125-cip10-118-gb03e159be974
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      b03e159be9746a2cba92777632dfc469e7cdecf3

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  e98f9465925434349d0aa6eb71e81b5464e76df4 =



Test Regressions
---------------- =



platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip       | gcc-10   | defconfig+arm=
64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62c0a438b8a0136232a39bcd

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.125-cip10-118-gb03e159be974/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-cip/ltp-timers-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.125-cip10-118-gb03e159be974/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-cip/ltp-timers-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220610.0/arm64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/62c0a438b8a0136232a=
39bce
        new failure (last pass: v5.10.121-cip9-287-ge9094c8446fc) =

 =



platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
rk3399-gru-kevin         | arm64 | lab-collabora | gcc-10   | defconfig+arm=
64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62c0a88e9b7e7b6f10a39bcf

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.125-cip10-118-gb03e159be974/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-collabora/ltp-timers-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.125-cip10-118-gb03e159be974/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-collabora/ltp-timers-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220610.0/arm64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/62c0a88e9b7e7b6f10a=
39bd0
        new failure (last pass: v5.10.121-cip9-287-ge9094c8446fc) =

 =20

