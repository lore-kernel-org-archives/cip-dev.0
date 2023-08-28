Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0890DC83F14
	for <webhook@archiver.kernel.org>; Mon, 28 Aug 2023 01:53:16 +0000 (UTC)
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
 by mx.groups.io with SMTP id smtpd.web11.5219.1693187587276346610
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sun, 27 Aug 2023 18:53:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=H8ZiBGOT;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.51, mailfrom: bot@kernelci.org)
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-6bca3311b4fso2067022a34.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Sun, 27 Aug 2023 18:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1693187586; x=1693792386;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=7mz0RyVdeQ0f4N3mETatToGpCE6znIhu59jNNnwaKx0=;
        b=H8ZiBGOT2P7oOci5dNbbvyfg0wEraZ41OWGD7+qvzb2yUdsTmvRVfyuwcdbzvfibt9
         4gh61db7ApfoTeGLMBLH57qS9G7MMhiveS/9xjNoj7k48m/eOVrwPjNScDnw+SQ4QClc
         a+M+SihDxo/FUV2f/fPOcebbpheaA+ZihcGDdYB2iBcGkw4/2+baf2iuyndqRwiwSPeg
         VHLcAnBm3FOsFq7OKyBw5Q7WOpgof7ldjsqT6Wz0ayl7Pw4vOff03PV/0LW0BbLayUbi
         HjD8+ZffTc0Y1HTdf4aRwB2jSgp4Nb75GvSe/ehWMHnoOmFC1uTsJSFR71ZbCeH6s6/F
         pgHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693187586; x=1693792386;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7mz0RyVdeQ0f4N3mETatToGpCE6znIhu59jNNnwaKx0=;
        b=i7PZCTA8BVxrz5NtPriEvEKh2+JKT5U8kRnEti+HUFKGQpVObfxIi1ZWvFQq39QFAk
         6pdNMaa6Im74eB6nPreUEBGadfnsIBttOjZsXc+z78iyVGzfZvtwROV/jGO21GGBFPSw
         6Zey0zPKpKACeOkfBqxkQd/SiHskcmduMr7yIUg1IQCWHwIJpAI0OwueJ/DZuyTgkL/p
         ku3ztm0SS33zhMdO5cTgSOh/rYSNPXXCyANfBuY5BuE3KRF12+V25GkY8JL1AgmI4ppS
         YDIBFwtmeGsKj3Qc2EcOMNBKPXhoUeJFP1OsCjwZP9upa+kYSo52js1zegRVQmhZAGLH
         0z7g==
X-Gm-Message-State: AOJu0YxJ3Ma8W+M69FgdX3pE61Wsw9zavKdBuZabK52PHOUnSfYHQTqt
	d86KjlCdUy2konCh09F+vMMkjax/Ju+ugLvNoFY=
X-Google-Smtp-Source: AGHT+IEXiJ9bI1bDKGAmt21UjMryRMIXyBLAFeh75hUWeqlXngLLMEK1X1vfY94cPl6YSM3aveugUQ==
X-Received: by 2002:a05:6358:8aa:b0:134:fdfc:4319 with SMTP id m42-20020a05635808aa00b00134fdfc4319mr24543317rwj.20.1693187585990;
        Sun, 27 Aug 2023 18:53:05 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id v9-20020a63ac09000000b0056428865aadsm6079663pge.82.2023.08.27.18.53.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Aug 2023 18:53:05 -0700 (PDT)
Message-ID: <64ebfe01.630a0220.6313f.78ac@mx.google.com>
Date: Sun, 27 Aug 2023 18:53:05 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-6.1.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.1.46-cip4
Subject: cip/linux-6.1.y-cip baseline-nfs: 24 runs,
 2 regressions (v6.1.46-cip4)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 28 Aug 2023 01:53:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12865

cip/linux-6.1.y-cip baseline-nfs: 24 runs, 2 regressions (v6.1.46-cip4)

Regressions Summary
-------------------

platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
imx6q-udoo       | arm   | lab-broonie   | gcc-10   | imx_v6_v7_defconfig  =
      | 1          =

rk3399-gru-kevin | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrom=
ebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-6.1.y-cip/kernel=
/v6.1.46-cip4/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip
  Branch:   linux-6.1.y-cip
  Describe: v6.1.46-cip4
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      58f7d1bf36cb697e7cab922b71d04f7d925e3b1f =



Test Regressions
---------------- =



platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
imx6q-udoo       | arm   | lab-broonie   | gcc-10   | imx_v6_v7_defconfig  =
      | 1          =


  Details:     https://kernelci.org/test/plan/id/64ebeec5402009ebf5286dbd

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.46-ci=
p4/arm/imx_v6_v7_defconfig/gcc-10/lab-broonie/baseline-nfs-imx6q-udoo.txt
  HTML log:    https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.46-ci=
p4/arm/imx_v6_v7_defconfig/gcc-10/lab-broonie/baseline-nfs-imx6q-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/64ebeec5402009ebf=
5286dbe
        failing since 38 days (last pass: v6.1.31-65-ge66be31505fa, first f=
ail: v6.1.38-cip1-10-gf4eb42f19246) =

 =



platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
rk3399-gru-kevin | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrom=
ebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64ebf79b01b2377037286d7a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.46-ci=
p4/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-nfs-rk339=
9-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.46-ci=
p4/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-nfs-rk339=
9-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/64ebf79b01b237703=
7286d7b
        new failure (last pass: v6.1.45-cip3-31-gc9451d303f3d) =

 =20

