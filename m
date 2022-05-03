X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
 by mx.groups.io with SMTP id smtpd.web08.9009.1651568980515388243
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 03 May 2022 02:09:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=Y68j0eyy;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.178, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f178.google.com with SMTP id d25so1385104pfo.10
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 03 May 2022 02:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=gtXeYa6CDzdUyg2BQK2spBkONvSr8NDiP8+8wPUnoHE=;
        b=Y68j0eyyCt1WsprVPvXwNsGqAL6ZYuRiK34HA5+zjbCLrfCET/RMGk0ihZYMkPk7cm
         Xp/PnZyUg6iHrgzWrDFGXibEPOx+SnuT8d0HmUr0T3/WUvj8JqG0tVSJeRK7JnxjkJXw
         Q1QtfQ6QtcRPU5iYlIXovioT62SIvDFd1gUHn2Rea7v6CPyrN20L2uZt5KnImDWtXoJK
         dYOcxbBSR1EpcEzqvU2XWAh3M+veDaSn35nmN8pkDcVWk0Qk/49RwFMFcFmzla52S84v
         +TkoV4jCVMCO+EgZAfLZvz2ihXrJy4WMWF6rvX48PCd8+absHGPaSrkeWp/osA4Xbpg3
         RXKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=gtXeYa6CDzdUyg2BQK2spBkONvSr8NDiP8+8wPUnoHE=;
        b=EXFpp/KthFTyIhiW96UzH1b2AT/lIuHtBT9O+lx0iITV3WiEGsfKzqMOui6naIn7zF
         BhtWSg0q1YItvrHO1XTqv3j4upOR8O2k7KIQo42Us9Xm9PNrU7/wn2pfbn2YhjvcPObi
         Mrs0HFSGyTzN3AT5b3t7obavvJqKh4jbu7dQ0hQ3EqW9JkIHWe141mvDZnYPCg6N3bud
         TlyVyTiVpf8Ow1rPKcAVbq5rTDYRcJOXwTGOZAcyM6tNh9illFaEhZUT7m9hqeTbctyn
         T3QpPvcorwSlKal4bHCs3mi0qmkeys6gBKhSLzhL0H3P1apN2Aug6KGg9jobZqafHeGO
         QutQ==
X-Gm-Message-State: AOAM533lPJza1uWT1D2AN3wYfzkq54JdLPtN/BQHezKsLBdek7Pvcy+L
	Whgklna0cm2Ozs8NbMmRf5s4e6hhBTym9SKIf0M=
X-Google-Smtp-Source: ABdhPJw+tV4WUUR4/JWb7ucpLmQkEyAMAPiN9IuEpxf9uoZKEbWc1afB8mG+rpyGYlvGkRvZ8IuoNA==
X-Received: by 2002:aa7:8757:0:b0:50d:48a9:f021 with SMTP id g23-20020aa78757000000b0050d48a9f021mr14901026pfo.24.1651568979809;
        Tue, 03 May 2022 02:09:39 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id b8-20020a1709027e0800b0015e8d4eb20fsm5960406plm.89.2022.05.03.02.09.39
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 May 2022 02:09:39 -0700 (PDT)
Message-ID: <6270f153.1c69fb81.766ed.e930@mx.google.com>
Date: Tue, 03 May 2022 02:09:39 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Kernel: v4.19.239-cip72-68-g407458469172
X-Kernelci-Report-Type: test
X-Kernelci-Branch: ci/iwamatsu/linux-4.19.y-cip-rc
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc baseline: 70 runs, 1 regressions (v4.19.239-cip72-68-g407458469172) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc baseline: 70 runs, 1 regressions=
 (v4.19.239-cip72-68-g407458469172)

Regressions Summary
-------------------

platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
rk3399-gru-kevin | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrom=
ebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-4.19.y-cip-rc/kernel/v4.19.239-cip72-68-g407458469172/plan/baseline/

  Test:     baseline
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-4.19.y-cip-rc
  Describe: v4.19.239-cip72-68-g407458469172
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      407458469172586fd84d64c08783b95a5d8b4cb1 =



Test Regressions
---------------- =



platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
rk3399-gru-kevin | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrom=
ebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6270ed2d38c97b6310dc7b3d

  Results:     83 PASS, 7 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.239-cip72-68-g407458469172/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-collabora/baseline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.239-cip72-68-g407458469172/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-collabora/baseline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220428.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-i2s1-probed: https://kernelci.org/test/case/id=
/6270ed2d38c97b6310dc7b63
        failing since 50 days (last pass: v4.19.229-cip67-111-g5c3c0b39cf3b=
, first fail: v4.19.231-cip68-123-g92e3e7f3d4df)

    2022-05-03T08:51:40.760622  <8>[   35.782188] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-i2s0-probed RESULT=3Dpass>
    2022-05-03T08:51:41.776138  /lava-6247178/1/../bin/lava-test-case
    2022-05-03T08:51:41.784658  <8>[   36.806657] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-i2s1-probed RESULT=3Dfail>   =

 =20

