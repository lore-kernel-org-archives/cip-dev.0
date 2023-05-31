Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2B86C77B7C
	for <webhook@archiver.kernel.org>; Wed, 31 May 2023 10:25:22 +0000 (UTC)
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
 by mx.groups.io with SMTP id smtpd.web10.10745.1685528714704923793
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 31 May 2023 03:25:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=JdWe0Z3S;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.174, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-64d5b4c3ffeso3873660b3a.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 31 May 2023 03:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1685528714; x=1688120714;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=53OV3NQJpdXmKcFZrugC7LYQcpXmVXJjmSsdS5wxQnA=;
        b=JdWe0Z3SRd+dI2WI4gPlzmUCF6ems4esNFCrYg+x4kGIP5d04exsfrvnKorZOjDTNy
         UC92cj4pYy549rZyvEKWvpsav9GWg4y8se2AFZ1piWWkUySzk6uxhBOIZkGrpS0cy3Zi
         EBgJhOoNoqrPymmhez77nKCGEvJFwLjptT+wjkp3vd15gfedGvMGvu9ba35+fvuFdBG6
         BCkm3cNwMdQNg1Ilji5Xm+S3LYZhc5zreftebZz/BH6Q2szktTXp8unbEDC5RFmwsrCS
         2rWhXu5DzLweVBdruAPMt21buFbDR/WISbSJ5rs1bqjGa4p8kEW2/EsWHEk2vpHn7VoY
         UwpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685528714; x=1688120714;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=53OV3NQJpdXmKcFZrugC7LYQcpXmVXJjmSsdS5wxQnA=;
        b=lxDXw7rnKFFOWaSXMPC5uZlibIwyDnXt39rB1CFMQRwDYZPPjEetlrdgkCMrY00oOo
         egH20Lbsh/skgNCZnmCpRLV9anUSSCoHIqOukBrqCRyXx1t2iEpG1gRI88vTG/iaTLju
         GDsvz8850fK+i9tR2ivPrC1q5byOIJiziobuNr9u8oyBYitNQD7b/LWj/s0ZRyQXFGPw
         kLsZmd0sfxcWwQDRJUxVr0AMFJM43kKDMTh7LIAOX48eYBosnwDVWKmB8Rta0o8OK/Xa
         ttQg8sVynGGCLAWtZ2m7nfnYXsN0guVGp6Z2plOPjpQZrvd/HLj/n0r+B82+1DSv0Aqt
         FqtQ==
X-Gm-Message-State: AC+VfDwdzCaEvaVLXym/RFenN53Fl1/52FUTp2IeW2tebf4NBSWxcLmi
	V9gByfNXKDBldArq4Hbi4x0WtO18dBg2pXGXHBKf7Q==
X-Google-Smtp-Source: ACHHUZ43G2HgQZXqXYrdhX8TMdbhk8K6TvqBVGkzKHTqujjlZEANEUKSktid7EXxFQvW98zvxS43Yw==
X-Received: by 2002:a05:6a20:2588:b0:10c:513d:2bd9 with SMTP id k8-20020a056a20258800b0010c513d2bd9mr5096552pzd.50.1685528713856;
        Wed, 31 May 2023 03:25:13 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id d5-20020a170902cec500b001aae64e9b36sm999148plg.114.2023.05.31.03.25.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 03:25:13 -0700 (PDT)
Message-ID: <64772089.170a0220.190b3.1763@mx.google.com>
Date: Wed, 31 May 2023 03:25:13 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.4.y-st-rc
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v4.4-st20-1307-g20af3740f4fc
X-Kernelci-Report-Type: test
Subject: cip/linux-4.4.y-st-rc ltp-pty: 3 runs,
 1 regressions (v4.4-st20-1307-g20af3740f4fc)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 31 May 2023 10:25:22 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11713

cip/linux-4.4.y-st-rc ltp-pty: 3 runs, 1 regressions (v4.4-st20-1307-g20af3=
740f4fc)

Regressions Summary
-------------------

platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.4.y-st-rc/kern=
el/v4.4-st20-1307-g20af3740f4fc/plan/ltp-pty/

  Test:     ltp-pty
  Tree:     cip
  Branch:   linux-4.4.y-st-rc
  Describe: v4.4-st20-1307-g20af3740f4fc
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      20af3740f4fcb1ef7c5d829654de94824a2d493f

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  604701dc19c5499403ae5afe48103b8e2872952b =



Test Regressions
---------------- =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6477121d7c475f6ab02e8651

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-st-rc/v4.4-st2=
0-1307-g20af3740f4fc/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/ltp-pty-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-st-rc/v4.4-st2=
0-1307-g20af3740f4fc/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/ltp-pty-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230527.0/amd64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/6477121d7c475f6ab02e86=
52
        failing since 34 days (last pass: v4.4-st20-1097-g52d843097a439, fi=
rst fail: v4.4-st20-1186-g2516b357b2e3a) =

 =20

