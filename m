Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D95E2C0015E
	for <webhook@archiver.kernel.org>; Fri, 14 Jul 2023 15:56:04 +0000 (UTC)
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
 by mx.groups.io with SMTP id smtpd.web11.2652.1689350156261199842
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 14 Jul 2023 08:55:56 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=cHA7NTTW;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.174, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-66869feb7d1so1431455b3a.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 14 Jul 2023 08:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1689350155; x=1691942155;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=4kvVGg1HXfU4gF7ywB64YuaDRBNZFxaqtdQxW7M5W9s=;
        b=cHA7NTTWPbNc+d8QqH0dwtoshZ+DvXt+yHArrGA0+5+RvBScVlj636sf+M5JMBjIRc
         n/Ge3dARsiM1JRr4h0VbOQ67+Ibp+mndk7VbyT5cw6WWhaL+hWSc28NGcgeyqNCkLDVC
         q0qdfpu286B5HMvJd+27kbL14sjfAhV+kdUQpcYQIejDraVvF4surT7543+vz4JyctGT
         Dpows0JJQOPC4vNNTH5lYqGOtOk/8g3Rb0DiCZGBVg7Zuuj1Lwc3H7AHCgwh+5Kv+gCC
         dc3pdRDbigln8TGAgMb22Y8FoYDAjF63pQ3Px1j67FRcVi4f4yki/eQIAfMNp0bPcpMu
         MjJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689350155; x=1691942155;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4kvVGg1HXfU4gF7ywB64YuaDRBNZFxaqtdQxW7M5W9s=;
        b=RP+l7/upIoO8FCpS1aGJtC10c59B/XzbvePpWZHpMr0GbNC+F2UAaoBBBMY1B4tRk3
         fRyOdXhk98s9LLlkD4m5Em42SBWW7IYIJrlljZT+AgnUuO09gWG9rXeThXz46RgyCpsk
         YnbiR2bW6MuVbiXSao8fayVDWobqldoMDnFd2OZms1xCiLdE+L6tirbaPCkbKpjzH1/O
         7QcP7gMZvadg2JRBrwVV6jymhEAi7Bmn5BTPoWgOwC1BoQN0fjyitXISi0nGoVafQXEO
         s6/K+u9/l2wzTkIQVKDqZsIz2SDP+Ht3b/5tiuvECP3unUs5orpLS7nvaoerT1DPBzdU
         0psw==
X-Gm-Message-State: ABy/qLaKIpfJd8w8dgNcdMB6Hf5hxbvRUorRRvofkdGGGk9/FfT16XTX
	gpo/h8eL8nNifnVjHs9ELo7CfthiqLGHLN/EdVMF/g==
X-Google-Smtp-Source: APBJJlENnQV0F7F7RiMXBRxivafy8ZJUJpvqrFjmlyUZ00t0x6AWg7yv+olBj94QADlSK9kmnAqxPw==
X-Received: by 2002:a05:6a00:1142:b0:682:f529:6d69 with SMTP id b2-20020a056a00114200b00682f5296d69mr4958703pfm.7.1689350155065;
        Fri, 14 Jul 2023 08:55:55 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id g13-20020a62e30d000000b0064398fe3451sm7323471pfh.217.2023.07.14.08.55.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 08:55:54 -0700 (PDT)
Message-ID: <64b1700a.620a0220.b3e77.fa6f@mx.google.com>
Date: Fri, 14 Jul 2023 08:55:54 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-4.19.y-cip
X-Kernelci-Kernel: v4.19.288-cip101
X-Kernelci-Report-Type: test
Subject: cip/linux-4.19.y-cip baseline-nfs: 26 runs,
 2 regressions (v4.19.288-cip101)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 14 Jul 2023 15:56:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12350

cip/linux-4.19.y-cip baseline-nfs: 26 runs, 2 regressions (v4.19.288-cip101)

Regressions Summary
-------------------

platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
rk3399-gru-kevin | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrom=
ebook | 2          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.19.y-cip/kerne=
l/v4.19.288-cip101/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip
  Branch:   linux-4.19.y-cip
  Describe: v4.19.288-cip101
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      9c3f27ca919fea575a3a1c378bd95bcbf2c33ca7 =



Test Regressions
---------------- =



platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
rk3399-gru-kevin | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrom=
ebook | 2          =


  Details:     https://kernelci.org/test/plan/id/64b1691edbbf3785188ace5c

  Results:     77 PASS, 5 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.288=
-cip101/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-nfs-=
rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.288=
-cip101/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-nfs-=
rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test=
/case/id/64b1691edbbf3785188ace62
        failing since 114 days (last pass: v4.19.276-cip93, first fail: v4.=
19.277-cip94)

    2023-07-14T15:26:01.402628  [   40.320758] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>

    2023-07-14T15:26:02.441557  /lava-11088635/1/../bin/lava-test-case

    2023-07-14T15:26:02.470405  [   41.389748] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drockchip-usb2phy1-probed RESULT=3Dfail>
   =


  * baseline-nfs.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test=
/case/id/64b1691edbbf3785188ace63
        failing since 114 days (last pass: v4.19.276-cip93, first fail: v4.=
19.277-cip94)

    2023-07-14T15:26:01.371918  /lava-11088635/1/../bin/lava-test-case
   =

 =20

