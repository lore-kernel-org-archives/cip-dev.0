Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2448FA3741
	for <webhook@archiver.kernel.org>; Fri, 28 Oct 2022 14:51:36 +0000 (UTC)
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
 by mx.groups.io with SMTP id smtpd.web12.366.1666968689961249710
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 28 Oct 2022 07:51:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=5pumSa+H;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.178, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f178.google.com with SMTP id 128so5051688pga.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 28 Oct 2022 07:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=yXuTVnhJGgEZWpQ+rTdVkIKF62rtC3fOIUDtdWX7Z8A=;
        b=5pumSa+HyxsnZ1VVrP2hrU2Xy+k5tsYPLMt5NiO4+SI8Fbnn9SFwDeqOBEdPhTW2gQ
         BDmYtc0SiQMjO9Lb0PSQjnm9HuvgOVJV4eXrFd+W6f5qXpFEND4bRE2PUcAuK0Xw1ihZ
         k2TO808nCraL4wR0ItgaiikJm7JWyLGMY/3i4e2rdQh4pChwwwncrjynW9uaPaPaUXP4
         9Jl6UawCFwjJloO9CSfP/U5Xh/3zFCDZ0/Yyxcm+5aoMGiEmYegoUT8X3t8E80bBKi7S
         AmPlNAyd1qyveL2QkIx0Befo8vFjMaP80yTzGswuWcDVrRiq+IF7n4EZaWqqsmUQYIXL
         yfbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yXuTVnhJGgEZWpQ+rTdVkIKF62rtC3fOIUDtdWX7Z8A=;
        b=QzdGAz7ATOvibFpG5DnE4SAnY0VTZvM/wDN0JW3cQb7pdCM95yndmjWlT0VfL9UadU
         PyuhHdrQMRmYCzUm2kDZae0RFaMFLcs+gcvJsPkJrceGxEIDbhfC5+c4H8Kb9ySbvE9u
         R9Q0M2tYi/8a9BSEUlQiqsqRW+NJ4jss7kbICFoFlK1lk7gwIrdO5xzwfeg1schv3Da6
         GJ7xeqXoReRjnDV2GXNa1fiqAgOX9lRFZ8DHUGIzWF9g1nd0jfbw7S+BIN9AVm2dq9Bv
         eT+LIDN7rkDM84RfB3bPBmL2+vOmznxDrupuY+KLIA0Ynxlm2RKtUO0QvVboBPt+N8UT
         KheA==
X-Gm-Message-State: ACrzQf03KAf6tA+SZUj1zDRxaW9CyhFFFjpL0oFkKGqbKeMXKVHzIHx2
	38fqNnndkHn6TPMedf+olw+fA0rydZL/LPnO
X-Google-Smtp-Source: AMsMyM7PUJzEvG2yGdniY6Em0Y563MdEF1GOBhJDLD4bbvox+oyGKSWNla72gAzbxTuxns96NuP8zQ==
X-Received: by 2002:aa7:8210:0:b0:56b:8b4b:e5e with SMTP id k16-20020aa78210000000b0056b8b4b0e5emr32753903pfi.58.1666968689000;
        Fri, 28 Oct 2022 07:51:29 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id 196-20020a6214cd000000b00562664d5027sm2953108pfu.61.2022.10.28.07.51.28
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 07:51:28 -0700 (PDT)
Message-ID: <635bec70.620a0220.e0a72.6194@mx.google.com>
Date: Fri, 28 Oct 2022 07:51:28 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.147-cip18-468-g86403a07ae1c
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline-nfs: 29 runs,
 1 regressions (v5.10.147-cip18-468-g86403a07ae1c)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 28 Oct 2022 14:51:36 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9886

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline-nfs: 29 runs, 1 regress=
ions (v5.10.147-cip18-468-g86403a07ae1c)

Regressions Summary
-------------------

platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
rk3399-gru-kevin | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrom=
ebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.147-cip18-468-g86403a07ae1c/plan/baseline=
-nfs/

  Test:     baseline-nfs
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.147-cip18-468-g86403a07ae1c
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      86403a07ae1c0fdab3215fcaa06d157c20aee250 =



Test Regressions
---------------- =



platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
rk3399-gru-kevin | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrom=
ebook | 1          =


  Details:     https://kernelci.org/test/plan/id/635be526f80b089914e7db80

  Results:     84 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.147-cip18-468-g86403a07ae1c/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-collabora/baseline-nfs-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.147-cip18-468-g86403a07ae1c/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-collabora/baseline-nfs-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
221024.1/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.rockchip-i2s1-probed: https://kernelci.org/test/cas=
e/id/635be526f80b089914e7dba6
        failing since 233 days (last pass: v5.10.100-cip2-319-gcbff87047566=
, first fail: v5.10.100-cip2-425-g0a0d92194f39)

    2022-10-28T14:20:01.406292  <4>[   36.973700] cdn-dp fec00000.dp: Direc=
t firmware load for rockchip/dptx.bin failed with error -2
    2022-10-28T14:20:01.415603  <4>[   36.984329] cdn-dp fec00000.dp: Falli=
ng back to sysfs fallback for: rockchip/dptx.bin
    2022-10-28T14:20:01.940312  /lava-7760352/1/../bin/lava-test-case
    2022-10-28T14:20:01.973073  <8>[   37.542835] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-i2s1-probed RESULT=3Dfail>   =

 =20

