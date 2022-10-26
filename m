Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 546C1C433FE
	for <webhook@archiver.kernel.org>; Wed, 26 Oct 2022 18:26:55 +0000 (UTC)
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
 by mx.groups.io with SMTP id smtpd.web11.11259.1666808810704516636
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 26 Oct 2022 11:26:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=pxxkgyu5;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.47, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f47.google.com with SMTP id m6-20020a17090a5a4600b00212f8dffec9so2972591pji.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 26 Oct 2022 11:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=QADvK55RifnCJWKVsWzgg4Q94D7ldyA15O/9sDXf/WE=;
        b=pxxkgyu5MAiUmXz3b7wN9lVJsiA5zzXKcEQsm7GV9l1SGGbTzCVaw6USZswr47iO+D
         1ONo9rv7KOT+lPA9LC0kAbQHW3WQksNSKI9CgzJqPf/rSClv6o5WXoc+CuSyWsWX6rlM
         KQaVVtUvMXmmTv5IMeAves9ktUY/GdIedp4s6J65hZoWx67Wfa9ULEvi3xNjPB4bOWT9
         NAqMaES7bSlvgtaR8WMgHMOTkBpXcbO3qO2BtQp1x6/+c5DhtLTf8uGWiFKnZaMtx0Fx
         CIsPwRCIuQmCzjmH41HFcAFWDMZt3/PB2u2RtbXjDvIXab1G/GeOI0FCVqPdehsCD6SX
         JClw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QADvK55RifnCJWKVsWzgg4Q94D7ldyA15O/9sDXf/WE=;
        b=CVBPr5VuApB2bs6KoIN/EXQPAYR8MGHroS6qXfXhyVtVfLeg76oKRnxQ8pu5zlDiBF
         YAZR3Zqjigqf0liHDb5hxNxKFAGXpIjT/iBUuknplZas5/1cXVwOQ/MVmimquLFTNTPS
         OiwNSZcikZaXNSVfijX8exmewAY9KW8HyOxfPtgZxqh3Oi8zHwnC0ly0+gkG7m4u+vSQ
         tYBcHAA+xvqZbfJyX1UHtdRVeN7N4gVjSBgsOYYVSIlyP31yTYEanrVcO9Vup1Jhm8UM
         9s9P2y2uutVnS/So/8uD7ZUcErpHXMRmF4qWRMVd5rQFU7RaJGc8rnY0CLmtlt6BDIjS
         kBcw==
X-Gm-Message-State: ACrzQf2WIh596U+s/OVnRhNCQpNiQOPnFPWFO3auOUBGUhcHdF71jGH1
	g1S0anePLauZyiZsbh/Fk/mWq1sk7Y9fcN5p
X-Google-Smtp-Source: AMsMyM4Wmz8T2uC9jHjs8KJ5MhmfMvXAVxlud25MtpFmrR2FlD7dGb1Is5kWiaCZ1Iolf9ZZHNN2IQ==
X-Received: by 2002:a17:90a:7805:b0:20d:4fd9:9a0e with SMTP id w5-20020a17090a780500b0020d4fd99a0emr5663582pjk.169.1666808809993;
        Wed, 26 Oct 2022 11:26:49 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id d28-20020aa797bc000000b0056bad6ff1b8sm3289725pfq.101.2022.10.26.11.26.49
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 11:26:49 -0700 (PDT)
Message-ID: <63597be9.a70a0220.3b396.7507@mx.google.com>
Date: Wed, 26 Oct 2022 11:26:49 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.147-cip18-451-g87ba4bc77ca06
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline-nfs: 27 runs,
 1 regressions (v5.10.147-cip18-451-g87ba4bc77ca06)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 26 Oct 2022 18:26:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9870

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline-nfs: 27 runs, 1 regress=
ions (v5.10.147-cip18-451-g87ba4bc77ca06)

Regressions Summary
-------------------

platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
rk3399-gru-kevin | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrom=
ebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.147-cip18-451-g87ba4bc77ca06/plan/baselin=
e-nfs/

  Test:     baseline-nfs
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.147-cip18-451-g87ba4bc77ca06
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      87ba4bc77ca0665b0965e4fd545904bc2f92617b =



Test Regressions
---------------- =



platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
rk3399-gru-kevin | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrom=
ebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63597363ff990ac683e7db5c

  Results:     84 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.147-cip18-451-g87ba4bc77ca06/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-collabora/baseline-nfs-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.147-cip18-451-g87ba4bc77ca06/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-collabora/baseline-nfs-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
221024.1/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.rockchip-i2s1-probed: https://kernelci.org/test/cas=
e/id/63597363ff990ac683e7db80
        failing since 231 days (last pass: v5.10.100-cip2-319-gcbff87047566=
, first fail: v5.10.100-cip2-425-g0a0d92194f39)

    2022-10-26T17:50:13.718376  [   97.949589] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drockchip-i2s0-probed RESULT=3Dpass>
    2022-10-26T17:50:14.751778  /lava-7729517/1/../bin/lava-test-case   =

 =20

