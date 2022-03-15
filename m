X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
 by mx.groups.io with SMTP id smtpd.web10.4621.1647303664552078375
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 14 Mar 2022 17:21:04 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=I2LbW2QE;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.174, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f174.google.com with SMTP id 9so14902982pll.6
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 14 Mar 2022 17:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=2iGfdRei4aPbO4gRW4bDXOpJ+Zp/TgpOp7ivFoeFyL8=;
        b=I2LbW2QEHrcqH0ZTzOLEXSTQcOU0XA3P8ca7HIqN8jsA8hmgE7FPPs2Wmojazm5Hdv
         6zRBB8+SAhcyP/Dwo1G+W+NroiGtSS9ZnKZIuro6qTMQBUGCnDhMEgIAlbQmUAzdeNwR
         5i30jIs6MZCzhM1sZiPKQvXMZ7iBtWdWIxqV6nofFpAoNoRexlRpHkGmzbSUtCgtsY/F
         J9LmkbRN+PfgFSq5hNYuqkAu0OGFdxEIiR7VPPH+YxIzagny5X6RxdG1smRKy4qYwfeQ
         M7RSqXmwc0LV9A98YxxjikZ0nMJLV8OXKuwUV5r5uCNh6W2FZtTtbT18K97tHUThwnE5
         +yEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=2iGfdRei4aPbO4gRW4bDXOpJ+Zp/TgpOp7ivFoeFyL8=;
        b=HT93yJlsIIOutWRs3Pu361VfOwdnyv2r7ZRTEqsPi1JGCYFVCDCQjwMCR2BgUJmJz/
         u99iCZTSe+xkrR7GXuY0IR0IZBERzyIMewyyNe0n0rBtRewuEbNs1+oS5uVpgtHxmTaL
         pGwBL4Cb36Vp/Tls4mTLHPUU6eVnK9+iiRk1e5LI/bry7zZ8LMoBHmz5FRzwaYkVL+D3
         dt7ISrqMTs5DGKzJiN8S79QN04VDO8xyFyXHhuXKmphBg630E+9CWytAXEGCUHo4o6+a
         mDWsmvq4mKHD7RvtaUDMk0WDPiOAAGlEGCWlG138qbx5R+Kioy8RboHULOmm9rjUZcOz
         VOwQ==
X-Gm-Message-State: AOAM5319mOrqW8Z2kuu2Hd177WO3l88EGNQzLklXWd9398eUHiv05CmJ
	GuoD2RFyCDojtlE80loAlEmQ6XO18fc/L4N9A+o=
X-Google-Smtp-Source: ABdhPJz6mOu7IeHvGqDQf3QrFvShcnTNwP5hrFLUTwzjEsnNeKAs6mUbigyajDgzf+5yE+7iVhHzyw==
X-Received: by 2002:a17:902:7610:b0:151:6152:549c with SMTP id k16-20020a170902761000b001516152549cmr25679490pll.91.1647303663884;
        Mon, 14 Mar 2022 17:21:03 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id m17-20020a17090a7f9100b001b9e4d62ed0sm649092pjl.13.2022.03.14.17.21.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Mar 2022 17:21:03 -0700 (PDT)
Message-ID: <622fdbef.1c69fb81.f13fb.28f6@mx.google.com>
Date: Mon, 14 Mar 2022 17:21:03 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-5.10.y-cip-rt
X-Kernelci-Kernel: v5.10.104-cip3-rt3
Subject: cip/linux-5.10.y-cip-rt baseline-nfs: 13 runs, 1 regressions (v5.10.104-cip3-rt3) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip/linux-5.10.y-cip-rt baseline-nfs: 13 runs, 1 regressions (v5.10.104-cip=
3-rt3)

Regressions Summary
-------------------

platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
rk3399-gru-kevin | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrom=
ebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip-rt/ke=
rnel/v5.10.104-cip3-rt3/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip
  Branch:   linux-5.10.y-cip-rt
  Describe: v5.10.104-cip3-rt3
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      1105279cf875fdf297e0225252cf3e595105a831 =



Test Regressions
---------------- =



platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
rk3399-gru-kevin | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrom=
ebook | 1          =


  Details:     https://kernelci.org/test/plan/id/622fccb019f21de152c62969

  Results:     84 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
104-cip3-rt3/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline=
-nfs-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
104-cip3-rt3/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline=
-nfs-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220228.1/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.rockchip-i2s1-probed: https://kernelci.org/test/cas=
e/id/622fccb019f21de152c6298f
        new failure (last pass: v5.10.100-cip2-rt2)

    2022-03-14T23:15:51.559723  <8>[   45.482512] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-i2s0-probed RESULT=3Dpass>
    2022-03-14T23:15:52.597219  /lava-5879829/1/../bin/lava-test-case
    2022-03-14T23:15:52.631023  <8>[   46.555677] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-i2s1-probed RESULT=3Dfail>   =

 =20

