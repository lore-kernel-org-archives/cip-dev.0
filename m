X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
 by mx.groups.io with SMTP id smtpd.web09.12008.1650054989619706381
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 15 Apr 2022 13:36:29 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=HDxSg1Cb;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.179, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f179.google.com with SMTP id q12so8457661pgj.13
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 15 Apr 2022 13:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=gzmr4VmbotR4BwE4rGvz0KGZWZkC+Mj69X2Hrs3l1MM=;
        b=HDxSg1CbFD+8OoXBms6Q/juYuF/aJ4i3+ux4nFj6ByUgjU+ekxIrPDmh/cO+moZRXM
         MCdxXeylJrpCA0hu/wu7FAu+5PNGnbppx0T9BbpumezN5hOS0AydZ9U0ii5CHs5YD0ih
         XgmcQNavJuco2YSbdDt1nnRF5EvbmKX+dsWB02Z0iADB8QlVioYx7xLVFeU1t/YZ4kAR
         WSuh90S+uyKTy0yqH4nQoxY0xD60l1muIpSeNXI2Uv65bVLWoQYJ/gOXVppU2xRVSsM0
         /s5dG8paO1yhGu5l59ZjJXyRSzokjRwejRi9rp3b40y1MoSxZuA7D95cA58YJFqngBIj
         4QZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=gzmr4VmbotR4BwE4rGvz0KGZWZkC+Mj69X2Hrs3l1MM=;
        b=LET6g0GIphs/xLqQL0+bnJTupKxTMXN2XxVMEv8Y/S2mbIGIRl4s/oWScoOvrGhLxn
         PlKijC/1o/X6yBhJKSMGyCrwIZSi2gMiUEHU8ux5IC9RntTP0bPj/AGV6sCP2bDniuh7
         xYXTVAwdgKf/Qu2RIlU6qBOjh/W1OjYpSXoausW0ETK3rHKICVjR0ulUf4rS5btw1iIS
         8PJq46RD+KMhS+JWKHmMzf36T0TZBxBHfqJuOBbJ+l6SRCx792rsjolBMi53/bFLjmtz
         EGLtIW0++n95Xrvr5m94WTgBtym08fIuTrKwpasLUHpI9u7FMOAGiJ82disATmUOgJxv
         TH0w==
X-Gm-Message-State: AOAM533+UIYGAC+zNUJ2FHZE33OUWqFY8/krzqVMANt1FoO/THvLPHmU
	aaKpLE4CohxObBIRUIxhimSxLx/uBbjm+jrU
X-Google-Smtp-Source: ABdhPJx4flyBFrOPS/zKk2NfACBd3rUO50mwfxnu2yPfzC/B8RpmL/o9awnnSCbVqwZlcXvReNaN7w==
X-Received: by 2002:a65:6a07:0:b0:39d:8c35:426b with SMTP id m7-20020a656a07000000b0039d8c35426bmr580738pgu.171.1650054988832;
        Fri, 15 Apr 2022 13:36:28 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id x6-20020a17090aa38600b001ca2f87d271sm5511077pjp.15.2022.04.15.13.36.28
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Apr 2022 13:36:28 -0700 (PDT)
Message-ID: <6259d74c.1c69fb81.c0d37.eee9@mx.google.com>
Date: Fri, 15 Apr 2022 13:36:28 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-4.19.y-cip-rc
X-Kernelci-Kernel: v4.19.237-cip71-337-g1c3cfbe23f3d7
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc baseline-nfs: 17 runs, 1 regressions (v4.19.237-cip71-337-g1c3cfbe23f3d7) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc baseline-nfs: 17 runs, 1 regress=
ions (v4.19.237-cip71-337-g1c3cfbe23f3d7)

Regressions Summary
-------------------

platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
rk3399-gru-kevin | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrom=
ebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-4.19.y-cip-rc/kernel/v4.19.237-cip71-337-g1c3cfbe23f3d7/plan/baselin=
e-nfs/

  Test:     baseline-nfs
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-4.19.y-cip-rc
  Describe: v4.19.237-cip71-337-g1c3cfbe23f3d7
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      1c3cfbe23f3d794216220a2a9fad32c5894a0f7c =



Test Regressions
---------------- =



platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
rk3399-gru-kevin | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrom=
ebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6259d22562a05e2136ae067c

  Results:     82 PASS, 6 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.237-cip71-337-g1c3cfbe23f3d7/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-collabora/baseline-nfs-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.237-cip71-337-g1c3cfbe23f3d7/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-collabora/baseline-nfs-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220401.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.rockchip-i2s1-probed: https://kernelci.org/test/cas=
e/id/6259d22562a05e2136ae069e
        failing since 33 days (last pass: v4.19.229-cip67-111-g5c3c0b39cf3b=
, first fail: v4.19.231-cip68-123-g92e3e7f3d4df)

    2022-04-15T20:14:09.573418  <8>[   36.359088] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-i2s0-probed RESULT=3Dpass>
    2022-04-15T20:14:10.596735  /lava-6100506/1/../bin/lava-test-case
    2022-04-15T20:14:10.616253  <8>[   37.402487] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-i2s1-probed RESULT=3Dfail>   =

 =20

