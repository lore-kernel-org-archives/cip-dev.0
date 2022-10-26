Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E42EBC433FE
	for <webhook@archiver.kernel.org>; Wed, 26 Oct 2022 10:47:22 +0000 (UTC)
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
 by mx.groups.io with SMTP id smtpd.web11.6153.1666781241073501413
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 26 Oct 2022 03:47:21 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=02N1mZuN;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.170, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f170.google.com with SMTP id io19so8687325plb.8
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 26 Oct 2022 03:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=b4YE9gkx6NwO7zQgesIoOPBs4J30PUTUuUJNpDN7tYs=;
        b=02N1mZuNoPJvBX3j7zxoZVlBimxTmOHBk/yHR0Pze1VUkSUQARKa9/iSznlnRqh+N4
         KPuza2XR1jgf1kUmhgFw6N4y1EKiHTSfIs/vb88h8tzWltb3lEUZClODbXhX7NKPfEXr
         9zw5MEOin2E6dRn8184Czd7upQz5EiODs9VMcD5rsSl/2ERzQ7rLZS+PY0Yutu67rbqP
         SP4Cc9btUhs3f3H8yerppB7iZ/h+4RJl3Jvnku/mE2xM3rOpauB5q5ZWu/BrR7BD8XgL
         Uv4eQTEdBjgSIMYCzWRQt392jdwn3v5nHWM4N1ZNMZN+oDGJtnC2iwCQ8sD3YXF+ecF1
         +s9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b4YE9gkx6NwO7zQgesIoOPBs4J30PUTUuUJNpDN7tYs=;
        b=k/plHxMerAvHm9Fno3z0hU45LG0SYOirU64psT4WUeMJt2iGDEEmBxkujSBYG/LR3q
         SFVh/C2Un/Tu2c9/dIHOlKqgqm8Q5ZlInZ6op0EWwfbKuMK+nukFGdbCf6mWtTEjJYnZ
         h6nvMmyMSxvsfUMwXWTOGB/nz+ELwNpXiI7y0cPGz8KzTT1ffXmdPNMhfJApwbbQX1nx
         3q5yn/0HUnE6rOt5Ge+zz/AmhfBQDGotnMsPxANUcQqHc/q1JKoPgx7VyyrEmeFY51+0
         QTuJnsLQGrBldgAMHfTjMl5eUtqK2CQSy9xCzlgg1jBv87tTIDrtSOtSNlDeNrhafxdP
         fwdw==
X-Gm-Message-State: ACrzQf2hzpTpeE20PLDHsUACQUiSXiA1Lwg5+JCRGNk8kvF0mPQ3jiV5
	6pCHBQirox9zd6cQCb1hcI/pQcq8z3ai7vgi
X-Google-Smtp-Source: AMsMyM41lo8mENe/XDYg4o+9UUOpOU96WyjiKYZOTKYwYTyiNKE+YmKkgjQocVlz6kF7rygBVjVhwQ==
X-Received: by 2002:a17:90b:4b0b:b0:213:227d:149e with SMTP id lx11-20020a17090b4b0b00b00213227d149emr3488570pjb.145.1666781240071;
        Wed, 26 Oct 2022 03:47:20 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id q17-20020aa79611000000b0056ba7cda4b5sm2867575pfg.16.2022.10.26.03.47.19
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 03:47:19 -0700 (PDT)
Message-ID: <63591037.a70a0220.3fc8b.5fed@mx.google.com>
Date: Wed, 26 Oct 2022 03:47:19 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.147-cip18-12-g7bc9523ecfb7f
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline-nfs: 41 runs,
 1 regressions (v5.10.147-cip18-12-g7bc9523ecfb7f)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 26 Oct 2022 10:47:22 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9858

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline-nfs: 41 runs, 1 regress=
ions (v5.10.147-cip18-12-g7bc9523ecfb7f)

Regressions Summary
-------------------

platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
rk3399-gru-kevin | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrom=
ebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.147-cip18-12-g7bc9523ecfb7f/plan/baseline=
-nfs/

  Test:     baseline-nfs
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.147-cip18-12-g7bc9523ecfb7f
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      7bc9523ecfb7fa7dc71764a249207893ef14174c =



Test Regressions
---------------- =



platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
rk3399-gru-kevin | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrom=
ebook | 1          =


  Details:     https://kernelci.org/test/plan/id/635907df18daafff3b5e5b4e

  Results:     84 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.147-cip18-12-g7bc9523ecfb7f/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-collabora/baseline-nfs-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.147-cip18-12-g7bc9523ecfb7f/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-collabora/baseline-nfs-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
221007.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.rockchip-i2s1-probed: https://kernelci.org/test/cas=
e/id/635907df18daafff3b5e5b74
        failing since 231 days (last pass: v5.10.100-cip2-319-gcbff87047566=
, first fail: v5.10.100-cip2-425-g0a0d92194f39)

    2022-10-26T10:11:25.697348  <4>[   37.734284] cdn-dp fec00000.dp: Direc=
t firmware load for rockchip/dptx.bin failed with error -2
    2022-10-26T10:11:25.706432  <4>[   37.744942] cdn-dp fec00000.dp: Falli=
ng back to sysfs fallback for: rockchip/dptx.bin
    2022-10-26T10:11:26.535563  /lava-7724699/1/../bin/lava-test-case
    2022-10-26T10:11:26.573386  <8>[   38.611851] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-i2s1-probed RESULT=3Dfail>   =

 =20

