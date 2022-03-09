X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
 by mx.groups.io with SMTP id smtpd.web08.1454.1646793367248845708
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 08 Mar 2022 18:36:07 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=ALZct8g/;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.176, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f176.google.com with SMTP id w4so733757ply.13
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 08 Mar 2022 18:36:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=+ziAgFOR1QzNedhikyuyDWs5omR+ihkXK1rY6G7wdIw=;
        b=ALZct8g/BlRDzlRz5R2UPW0akmmu+vuMAzuVVPLp7JIOEaBVPengzCv6Ix3FdTudKp
         7Ewy+ZU2ZLYQOtbsm4Xs5rM9DkvbSMygRN5X6X6LwQ2eWtLu2XJlwjS8OTRYkJEpQVlB
         OfKUGZpI8Oa+yNgZ8tvCzYV8lJaelRGMkf8+TzKjNHngTi7JFkEk8ERpL3WP5Y4wOK1h
         cePyBgG3L/5Ro3JelIBr/3ajf/Dlhb34A13E4iXhItsp8uSX1S8u4Vl5CPzoCnGEgPy8
         MIgnhy+muC0GxJ01+qDv+EMreqnI4LqYQDP16S9PK2b3UWzOHqsEqm+ldfbxr5nM+xVJ
         IdbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=+ziAgFOR1QzNedhikyuyDWs5omR+ihkXK1rY6G7wdIw=;
        b=U36gOuGpvY0+JDxm8MH4M0JQ8Wg2XJ1q956gJcLx/ZHzyISI0pgi+GTgQ1VNjeqFNf
         At8qjUxC4mlSy1fQ1hrMeQ9lqUFMQyugC4EWrQQHboW+vTHCoQ2LRgcOzOgaeAgKB2kr
         A+M3BAOaxW0AejPfI6ykIUqc0spWN0k4W8P7dTY1IrYgnxJWzAPmTBQAc7G0GlU5sM7j
         YM1bIRq+oPNsU9z5hJlZovXz4ytLLDOUkad42+drEscav2TxweILXxjsd6jroFQ7bmxP
         wGnN57HnmN0i5xklDAnCqTLHks7Z7v4kzj6HpxVSjFCIlJejOIy5nC1xdjqAqgxBMmAF
         LRuA==
X-Gm-Message-State: AOAM531IJWQ6SJ68TUKcxndMIX1Q9tR54PfsgidbmfrNPRqYHTJmzMlk
	0kUMNxsLzmw+Ud5QAH60TfBsVxNuOtfewDU1U3s=
X-Google-Smtp-Source: ABdhPJxn9tkWY2y/4yzmC38mIU7JsspuZiJY+mZ0+8e6fOeENaz6Qw6Mr9EZGPcSRZtl4yoQmcU/7g==
X-Received: by 2002:a17:902:f652:b0:150:1af4:85e7 with SMTP id m18-20020a170902f65200b001501af485e7mr20425569plg.105.1646793366579;
        Tue, 08 Mar 2022 18:36:06 -0800 (PST)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id f20-20020a056a00229400b004f74434eae4sm456023pfe.153.2022.03.08.18.36.05
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 18:36:06 -0800 (PST)
Message-ID: <62281296.1c69fb81.c9758.201b@mx.google.com>
Date: Tue, 08 Mar 2022 18:36:06 -0800 (PST)
MIME-Version: 1.0
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Kernel: v5.10.100-cip2-425-g0a0d92194f39
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline-nfs: 18 runs, 1 regressions (v5.10.100-cip2-425-g0a0d92194f39) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline-nfs: 18 runs, 1 regress=
ions (v5.10.100-cip2-425-g0a0d92194f39)

Regressions Summary
-------------------

platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
rk3399-gru-kevin | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrom=
ebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.100-cip2-425-g0a0d92194f39/plan/baseline-=
nfs/

  Test:     baseline-nfs
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.100-cip2-425-g0a0d92194f39
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      0a0d92194f399a5095878cd6edf9060eb4244d81 =



Test Regressions
---------------- =



platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
rk3399-gru-kevin | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrom=
ebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6228042f5d38c36013c6297d

  Results:     84 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.100-cip2-425-g0a0d92194f39/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-collabora/baseline-nfs-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.100-cip2-425-g0a0d92194f39/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-collabora/baseline-nfs-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220228.1/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.rockchip-i2s1-probed: https://kernelci.org/test/cas=
e/id/6228042f5d38c36013c629a3
        new failure (last pass: v5.10.100-cip2-319-gcbff87047566)

    2022-03-09T01:34:17.495236  /lava-5842545/1/../bin/lava-test-case
    2022-03-09T01:34:17.526791  <8>[   96.110809] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-i2s1-probed RESULT=3Dfail>   =

 =20

