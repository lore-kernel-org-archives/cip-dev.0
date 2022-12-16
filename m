Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82269C4332F
	for <webhook@archiver.kernel.org>; Fri, 16 Dec 2022 20:40:41 +0000 (UTC)
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
 by mx.groups.io with SMTP id smtpd.web11.5795.1671223235356227976
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 16 Dec 2022 12:40:35 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=dlXuAs0L;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.53, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f53.google.com with SMTP id u5so3590095pjy.5
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 16 Dec 2022 12:40:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=NHUicqq4Tw6d4bItQw7kEM6JOZV9vvMoh7DkTlz8IRI=;
        b=dlXuAs0LV0xQw0ZBOcQZ5uiotj1AxKm5Oy6xOl6h24TZMzOX4uxCeq0Q7ApKj0irDv
         s8hDCY8mFeYWfE3xwMOvM3HDKWxUf4fvSfFBjROurbYmV4nQCEUq3X2IghPZ+J1hhnKi
         zYnhNJUbZ7aNJMSMiDC4M9oG00A1XoE8ZgLVyZGLl7Eb2FelIGvuDVFCRVM4EtXD1bR/
         hPnD8FblEiD4e/7dk9ZPdRBFGMjZOkGyJYq8YKYwGAWBnIMdEvPEA1mLJn0I8afOqfKl
         VKSBRs2eRrIZZlct7p/W0Lg7HlY93j7Td8jxBGGplyecaTETxo+kXFPE0/0Z9z7U0H8m
         pvWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NHUicqq4Tw6d4bItQw7kEM6JOZV9vvMoh7DkTlz8IRI=;
        b=0/VzdvbQOko/BtOO6HX1Kz712kqZDXMThKV/9qhTrzNdcTGcRFd8flF73NClK8kX9d
         l2tid3ObD9Yhda+BihoiTPntz4WRR8VEU9dlleSNTLBm6u90KHnWuiIM/Q7rR0J9h4Gt
         SXnv6i9zTMgRMqlYXvhCStc5Rae9hdHuzmmG4HkbZx1AC4gD+XoSM48VHxnGi+aHu4Tn
         huPMii86XLLjlbH4aA0yDz21zFyTYN28Dd3xaw2MPBBp1+kgoxWwJay61IkyjF0B1Z5s
         N7GQUPkJWvMCEXzNdycg3+G4qMo1Wpg7BSKT0884hDdlHeFJ008fUqNvTvVmC1Qbpuqw
         YDpA==
X-Gm-Message-State: ANoB5pk42tn1431nWtveJS/Q0jPl/YJCclZZg1Nka/qEtmZlOoHc+6zA
	3qSjZsylgBNLeKm5xuRYxSa+eqSfCNFJIjgYyOY=
X-Google-Smtp-Source: AA0mqf41UyI9vof3RL3KwKITFsl7bk1ynuXV3flA+2yiORiaTPOIjdjzumxrVnHeuvStKb4nSFUpCA==
X-Received: by 2002:a05:6a20:d396:b0:9d:efbf:8171 with SMTP id iq22-20020a056a20d39600b0009defbf8171mr44415019pzb.58.1671223234589;
        Fri, 16 Dec 2022 12:40:34 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id e13-20020a17090a7c4d00b00218e8a0d7f0sm5163489pjl.22.2022.12.16.12.40.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Dec 2022 12:40:34 -0800 (PST)
Message-ID: <639cd7c2.170a0220.a5d89.a39f@mx.google.com>
Date: Fri, 16 Dec 2022 12:40:34 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Kernel: v5.10.158-cip22-7-g92462fd9830b
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip
Subject: cip/linux-5.10.y-cip baseline-nfs: 36 runs,
 4 regressions (v5.10.158-cip22-7-g92462fd9830b)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 16 Dec 2022 20:40:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10240

cip/linux-5.10.y-cip baseline-nfs: 36 runs, 4 regressions (v5.10.158-cip22-=
7-g92462fd9830b)

Regressions Summary
-------------------

platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
cubietruck                   | arm   | lab-baylibre  | gcc-10   | sunxi_def=
config            | 1          =

meson-g12b-a311d-khadas-vim3 | arm64 | lab-baylibre  | gcc-10   | defconfig=
                  | 1          =

meson-gxl-s905x-libretech-cc | arm64 | lab-broonie   | gcc-10   | defconfig=
                  | 1          =

rk3399-gru-kevin             | arm64 | lab-collabora | gcc-10   | defconfig=
+arm64-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.158-cip22-7-g92462fd9830b/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.158-cip22-7-g92462fd9830b
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      92462fd9830b23227198482fe4bee42316a5694d =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
cubietruck                   | arm   | lab-baylibre  | gcc-10   | sunxi_def=
config            | 1          =


  Details:     https://kernelci.org/test/plan/id/639ccb464184a986d12abd54

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: sunxi_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.158=
-cip22-7-g92462fd9830b/arm/sunxi_defconfig/gcc-10/lab-baylibre/baseline-nfs=
-cubietruck.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.158=
-cip22-7-g92462fd9830b/arm/sunxi_defconfig/gcc-10/lab-baylibre/baseline-nfs=
-cubietruck.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
221209.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/639ccb464184a986d=
12abd55
        new failure (last pass: v5.10.158-cip22) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-baylibre  | gcc-10   | defconfig=
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/639cd26207d1fcef122abdb7

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.158=
-cip22-7-g92462fd9830b/arm64/defconfig/gcc-10/lab-baylibre/baseline-nfs-mes=
on-g12b-a311d-khadas-vim3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.158=
-cip22-7-g92462fd9830b/arm64/defconfig/gcc-10/lab-baylibre/baseline-nfs-mes=
on-g12b-a311d-khadas-vim3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
221209.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/639cd26207d1fcef1=
22abdb8
        new failure (last pass: v5.10.158-cip22) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie   | gcc-10   | defconfig=
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/639cd195ec3681e1c22abd0a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.158=
-cip22-7-g92462fd9830b/arm64/defconfig/gcc-10/lab-broonie/baseline-nfs-meso=
n-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.158=
-cip22-7-g92462fd9830b/arm64/defconfig/gcc-10/lab-broonie/baseline-nfs-meso=
n-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
221209.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/639cd195ec3681e1c=
22abd0b
        new failure (last pass: v5.10.158-cip22) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
rk3399-gru-kevin             | arm64 | lab-collabora | gcc-10   | defconfig=
+arm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/639cce02734fd065dd2abd4e

  Results:     84 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.158=
-cip22-7-g92462fd9830b/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabor=
a/baseline-nfs-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.158=
-cip22-7-g92462fd9830b/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabor=
a/baseline-nfs-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
221209.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.rockchip-i2s1-probed: https://kernelci.org/test/cas=
e/id/639cce02734fd065dd2abd70
        failing since 262 days (last pass: v5.10.83-cip1-178-g2cf1d12aab81,=
 first fail: v5.10.106-cip4)

    2022-12-16T19:58:48.611555  /lava-8392592/1/../bin/lava-test-case
    2022-12-16T19:58:48.640325  <8>[   97.164378] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-i2s1-probed RESULT=3Dfail>   =

 =20

