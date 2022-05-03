X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
 by mx.groups.io with SMTP id smtpd.web08.9008.1651568980403417170
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 03 May 2022 02:09:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=Y/7H74Iu;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.176, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f176.google.com with SMTP id k1so5855343pll.4
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 03 May 2022 02:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=uOpb1XfUGYPpQSvV/jCDBrZG3uTGQk4TMwjj5evodx4=;
        b=Y/7H74Iu/zUHNhNY1GODlx1esDCIVctSjpxhAoarQgZ6WtMxHzlabhLU14WWwAqkh4
         hOSNsdgkekNzpiCr+Mm0pArW2jS79n8s7l4j1FnZftw0uwue7UclMIK+VJmauokoi3JO
         2U9DbgJjfTybt6rYidm6137zpRggp09gnwZDh0XH8VqM3wGU77xZQnoHIyWGQpaUbIa1
         kUZhe46PsYPX5tx4CnrJq8HBCCzamTXx3xIrwyoTi3xdAIXXQb71dnSp++aaPfw6gerq
         5TzcZobE1x30lt6Tz6bL/z5Ze6kwzHtJJmow/7V3KCV1lLm2AOWwrJZuhqW5NKUo9x4g
         w0+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=uOpb1XfUGYPpQSvV/jCDBrZG3uTGQk4TMwjj5evodx4=;
        b=1qqA/lahQcQfer9srJbQRJDJyKPnx6HBFwX2OyZugiYb1qeLynOKnNmZTJX6lmOARD
         2Z1K9Edj/5ZrklU8CBiEtI1WhyEW3c4qiTCv5fUdXQm2L2JqYwh8JpedB7pwMTnNJ6iD
         npOnJn8yK7xpg6iKxt88ElIzaNKFg7+qb5SyKn1OCzeK4ZYHETfqhWRL4fxGWvlWGQIT
         Alj6to6RI2J8+Ozh/A66gOoOTAlqRA6wBMevBb72ALhHIR9+iLR1kOmA76s14ki+7/Hu
         QW7aCV5a+u/T0PAfNDP2pStqMsPn+QMlJVVP0pmApVBqYtiAeA/Mo/au91Nhzoztol50
         gUkQ==
X-Gm-Message-State: AOAM531fdSvmSgwkSrj6Klflh19mLnnJkyhijQyzHXOe5WPDtZx0PQWI
	eTZj5XscbkNBXH5eFHoVAP6TLYyMa5a2aVKPL24=
X-Google-Smtp-Source: ABdhPJylRpaUBWwyYmSO4/SqcqHpzfQVdnxfbewexi7c7yJmKHI187fYQOS4hxDs3zUuJ6mKBxXIyQ==
X-Received: by 2002:a17:90b:1d92:b0:1dc:3f14:f8d0 with SMTP id pf18-20020a17090b1d9200b001dc3f14f8d0mr3684989pjb.7.1651568979681;
        Tue, 03 May 2022 02:09:39 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id k13-20020a170902ba8d00b0015e8d4eb285sm5861185pls.207.2022.05.03.02.09.39
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 May 2022 02:09:39 -0700 (PDT)
Message-ID: <6270f153.1c69fb81.aadec.e6ff@mx.google.com>
Date: Tue, 03 May 2022 02:09:39 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Kernel: v4.19.239-cip72-68-g407458469172
X-Kernelci-Report-Type: test
X-Kernelci-Branch: ci/iwamatsu/linux-4.19.y-cip-rc
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc baseline-nfs: 11 runs, 1 regressions (v4.19.239-cip72-68-g407458469172) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc baseline-nfs: 11 runs, 1 regress=
ions (v4.19.239-cip72-68-g407458469172)

Regressions Summary
-------------------

platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
rk3399-gru-kevin | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrom=
ebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-4.19.y-cip-rc/kernel/v4.19.239-cip72-68-g407458469172/plan/baseline-=
nfs/

  Test:     baseline-nfs
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


  Details:     https://kernelci.org/test/plan/id/6270eca50d6e8b4053dc7b52

  Results:     82 PASS, 6 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.239-cip72-68-g407458469172/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-collabora/baseline-nfs-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.239-cip72-68-g407458469172/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-collabora/baseline-nfs-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220428.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.rockchip-i2s1-probed: https://kernelci.org/test/cas=
e/id/6270eca50d6e8b4053dc7b78
        failing since 50 days (last pass: v4.19.229-cip67-111-g5c3c0b39cf3b=
, first fail: v4.19.231-cip68-123-g92e3e7f3d4df)

    2022-05-03T08:49:20.744635  <8>[   36.689523] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-i2s0-probed RESULT=3Dpass>
    2022-05-03T08:49:21.770790  /lava-6247175/1/../bin/lava-test-case
    2022-05-03T08:49:21.794383  <8>[   37.739149] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-i2s1-probed RESULT=3Dfail>   =

 =20

