Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A341C4167B
	for <webhook@archiver.kernel.org>; Wed, 29 Nov 2023 00:16:59 +0000 (UTC)
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
 by mx.groups.io with SMTP id smtpd.web10.15083.1701217016847058148
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 28 Nov 2023 16:16:56 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=ASvLSCRv;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.170, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6b20a48522fso5006045b3a.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 28 Nov 2023 16:16:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1701217015; x=1701821815; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Pv58wo6uZtYvXN6zC5rjqLr5nYTia8FkvrIjllFXf+w=;
        b=ASvLSCRvw4LK0kLN5qxJ4/AKfQDwPQjMArmgaRFu8gRc7KWlgGffons3zermLm8Lie
         qUh/d/jc452PtBXAtee5RxRuunvdC27MRqNEAyw30/ntBUZyP+1G33g1pQeqnyKylDFJ
         hn3Ugf8cKWhQUJRxG5d/+l40PtZT8dvc8am60rqdBJkoVRD2TK3bKoNybtctD+WUjxhk
         9Rq8mlHYlaIPhce/tyn6n4SW4YokA6/5W3KS89tZ4SklsAv0NRo/BmzJvNaNtyiQb0Zi
         ak8dlnNzylWHFH9vomzqJsh1N0cJOBsDbbMoDSOTM1IlqQSCWZ172U6I/rMct5H4b0zt
         SmzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701217015; x=1701821815;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Pv58wo6uZtYvXN6zC5rjqLr5nYTia8FkvrIjllFXf+w=;
        b=dSQeArxVAqOg3JNhhnhx1tsAj6XTNYAg+3lMPkR6PXND+otlaDKqKrKnDz1auBQHN7
         FRlnU3w3e/rv1fQOBFBz5MQ80FpuE/m9tvW1rAf7niWStVjmQvHviyzhQMKO1/Ny0bpa
         QSQc194vhTHtTdCM3vazE8uX7fJEXyVeEFB8E38OmguCiJzDQu/vB0QuGIm1vfO+pjny
         YLHym1IxhsGdQm3tBSTn/9xYek/Eg+lshC9Lj/Lbuid1LsMixA1gORBYImvG6z1+ENjO
         MlikJNB0C8j3OKnZN+e+ZK4JhBMP2y9GvKVGf8PtMz5SCH2bCLQfJKVtlydoRu5bh/DI
         gvqw==
X-Gm-Message-State: AOJu0Yw/pQDrPku7e2UKIEfl+HfrdqfuepDDa1eZEArVljEWdz01S0x0
	K0uwC+8sUy78VtKCV+/y9sGbXOAm+d94vTKBCiA=
X-Google-Smtp-Source: AGHT+IFcN+Edi1237j25aAdCR488Ba1CD3oq8GMuF/xUI5TpNhKHE8bXV9QWIqGPIyF2KZqIEYXA9g==
X-Received: by 2002:a05:6a21:99a6:b0:18c:110e:c33d with SMTP id ve38-20020a056a2199a600b0018c110ec33dmr18679153pzb.28.1701217015410;
        Tue, 28 Nov 2023 16:16:55 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id p2-20020a17090a348200b0027ceac90684sm74560pjb.18.2023.11.28.16.16.54
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 16:16:54 -0800 (PST)
Message-ID: <656682f6.170a0220.7af62.03c0@mx.google.com>
Date: Tue, 28 Nov 2023 16:16:54 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v5.10.201-cip41-197-g2d08925b44e52
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-filesystems: 11
 runs, 3 regressions (v5.10.201-cip41-197-g2d08925b44e52)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 29 Nov 2023 00:16:59 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13754

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-filesystems: 11 runs, =
3 regressions (v5.10.201-cip41-197-g2d08925b44e52)

Regressions Summary
-------------------

platform                 | arch  | lab         | compiler | defconfig      =
            | regressions
-------------------------+-------+-------------+----------+----------------=
------------+------------
beaglebone-black         | arm   | lab-broonie | gcc-10   | multi_v7_defcon=
fig         | 1          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip     | gcc-10   | defconfig+arm64=
-chromebook | 1          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip     | gcc-10   | defconfig      =
            | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.201-cip41-197-g2d08925b44e52/plan/kselfte=
st-filesystems/

  Test:     kselftest-filesystems
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.201-cip41-197-g2d08925b44e52
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      2d08925b44e52ce450bf165f843637412f9c979b =



Test Regressions
---------------- =



platform                 | arch  | lab         | compiler | defconfig      =
            | regressions
-------------------------+-------+-------------+----------+----------------=
------------+------------
beaglebone-black         | arm   | lab-broonie | gcc-10   | multi_v7_defcon=
fig         | 1          =


  Details:     https://kernelci.org/test/plan/id/65667b1c8b1d9dbe8e7e4a6d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-197-g2d08925b44e52/arm/multi_v7_defconfig/gcc-=
10/lab-broonie/kselftest-filesystems-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-197-g2d08925b44e52/arm/multi_v7_defconfig/gcc-=
10/lab-broonie/kselftest-filesystems-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/armhf/initrd.cpio.gz =



  * kselftest-filesystems.login: https://kernelci.org/test/case/id/65667b1c=
8b1d9dbe8e7e4a6e
        new failure (last pass: v5.10.200-cip40-188-g33d0b44cd71d) =

 =



platform                 | arch  | lab         | compiler | defconfig      =
            | regressions
-------------------------+-------+-------------+----------+----------------=
------------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip     | gcc-10   | defconfig+arm64=
-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/65667376da331e45687e4a73

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-197-g2d08925b44e52/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-cip/kselftest-filesystems-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-197-g2d08925b44e52/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-cip/kselftest-filesystems-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-filesystems.login: https://kernelci.org/test/case/id/65667376=
da331e45687e4a74
        failing since 160 days (last pass: v5.10.182-cip35-191-gf4efde51295=
9, first fail: v5.10.182-cip35-289-g3c0549540706) =

 =



platform                 | arch  | lab         | compiler | defconfig      =
            | regressions
-------------------------+-------+-------------+----------+----------------=
------------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip     | gcc-10   | defconfig      =
            | 1          =


  Details:     https://kernelci.org/test/plan/id/6566752da7303d051a7e4a92

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-197-g2d08925b44e52/arm64/defconfig/gcc-10/lab-=
cip/kselftest-filesystems-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-197-g2d08925b44e52/arm64/defconfig/gcc-10/lab-=
cip/kselftest-filesystems-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-filesystems.login: https://kernelci.org/test/case/id/6566752d=
a7303d051a7e4a93
        failing since 6 days (last pass: v5.10.194-cip39-915-g96fa7f16cf02,=
 first fail: v5.10.200-cip40-188-g33d0b44cd71d) =

 =20

