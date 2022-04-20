X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
 by mx.groups.io with SMTP id smtpd.web10.8878.1650467715311940992
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 20 Apr 2022 08:15:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=KRyR8DlQ;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.51, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f51.google.com with SMTP id ll10so2211096pjb.5
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 20 Apr 2022 08:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=C+oPKZzefadlaEpL3T1IWEdCpsBJgrK8i2rL0qj8HBw=;
        b=KRyR8DlQ9MA0XZPHXTziIPpJgDWq/wMm6gSievJO85DrkyEKpA3aX/rGSma2Yx3r1h
         Ae4+9jlPvUX/9p9rwJjN5xjZn7QbnUITIPJwvocqlIoub77a8gZOX5kuIXrw2MkpvhtJ
         nD7la9l/No5nuuDQGBYSJumLcUd78z5sYUAxU07hB8Xr6dNYZpe68w8isumFUhXfC4g8
         SNq8z4FAkKnvaGWNA4Y6sRs+XRzi5SGnugXFumXl4rJTwtmy2Q92/CtOuO4N8Zu4d/e8
         LMY2fM2KgyvtaypfpUdHREmBtDjsKQsDubxR0XF7G/qYz0ZVS4kPe7BpIZFaNMyMSNfl
         qdMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=C+oPKZzefadlaEpL3T1IWEdCpsBJgrK8i2rL0qj8HBw=;
        b=QOf1dgDZtq5i8smnTd3btsJzSUJiQF1gSRP5AdkBQXBP+FTaLF6guHeUVH9THQrXKh
         XaTZraqJG5JMpn+Wb1NWAk/bS0eKTPECYdfU7wOgNHvL+B8aJk+jX03kTwAQnaXja8qK
         OAyENuWM9TSiLGt71JTiAP0uHbBejEhgLIREnGbgHRhTEcUrfgGAnVqtqhiC5wuAflLV
         uGG9JrV5x87AjxmY03QtIB4Pd+ZteY0eUo4T5hOLcjXKg72Df8cJV34IPKfhkBIrwMOa
         nk0ZcGs8887sMEbKQX972U97ZgX47x1ojRdxkmreBRm3BqKM6wOChF+4WXgqNqy/sque
         H77Q==
X-Gm-Message-State: AOAM533aioP4lqb9H48NauW0TGL02JTlw+l/YgWJIfQby4t4j1nOzuPi
	osyuDKkD/WMTfqobMgoqW7e6JOF52Van8ph7a3w=
X-Google-Smtp-Source: ABdhPJybnxXG4fOq+tyvpqJAxXcgw3AKgOtkhh3P7oZNXeqkrB55Si5VwKzluMeJu6I7tDTV4MrQug==
X-Received: by 2002:a17:90a:4f0e:b0:1d2:c449:8484 with SMTP id p14-20020a17090a4f0e00b001d2c4498484mr5034296pjh.26.1650467714544;
        Wed, 20 Apr 2022 08:15:14 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id o4-20020a625a04000000b004fdf5419e41sm20626551pfb.36.2022.04.20.08.15.14
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 08:15:14 -0700 (PDT)
Message-ID: <62602382.1c69fb81.7c8a2.09c9@mx.google.com>
Date: Wed, 20 Apr 2022 08:15:14 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-4.19.y-cip-rc
X-Kernelci-Kernel: v4.19.237-cip71-369-gd31a7c52552af
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc baseline: 103 runs, 1 regressions (v4.19.237-cip71-369-gd31a7c52552af) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc baseline: 103 runs, 1 regression=
s (v4.19.237-cip71-369-gd31a7c52552af)

Regressions Summary
-------------------

platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
rk3399-gru-kevin | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrom=
ebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-4.19.y-cip-rc/kernel/v4.19.237-cip71-369-gd31a7c52552af/plan/baselin=
e/

  Test:     baseline
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-4.19.y-cip-rc
  Describe: v4.19.237-cip71-369-gd31a7c52552af
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      d31a7c52552af48848c6ccbbf8a48c4f1cb17bdb =



Test Regressions
---------------- =



platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
rk3399-gru-kevin | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrom=
ebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62601c1dd252fa246dae0685

  Results:     83 PASS, 7 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.237-cip71-369-gd31a7c52552af/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-collabora/baseline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.237-cip71-369-gd31a7c52552af/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-collabora/baseline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220411.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-i2s1-probed: https://kernelci.org/test/case/id=
/62601c1ed252fa246dae06a7
        failing since 37 days (last pass: v4.19.229-cip67-111-g5c3c0b39cf3b=
, first fail: v4.19.231-cip68-123-g92e3e7f3d4df)

    2022-04-20T14:43:35.737983  /lava-6132779/1/../bin/lava-test-case<8>[  =
 36.936582] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Drockchip-i2s1-probed RESUL=
T=3Dfail>   =

 =20

