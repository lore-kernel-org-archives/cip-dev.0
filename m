Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A2BBEB64D7
	for <webhook@archiver.kernel.org>; Fri, 23 Jun 2023 13:13:55 +0000 (UTC)
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
 by mx.groups.io with SMTP id smtpd.web10.41653.1687526032733435410
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 23 Jun 2023 06:13:52 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=OMu/9410;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.177, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1b512309c86so4892265ad.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 23 Jun 2023 06:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1687526031; x=1690118031;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6MVSxGMcT3FemDOyo1EDmA72RiDKeryjTZucpOkRODM=;
        b=OMu/9410vzCMd/ZBXF+nMiV3PPGZxeut8akRFIBZpqv9f1tqG410h1oZ0f188Pfo3T
         lhyPPQSCSphGJLU01mvYWvTl6a8fTcZJCBOIioxxYm49UyOre0RTzVWnZwXTavG3c3Tm
         0jjkvzQ4phlXVK64uG9AqLrXN09lwQyuQpITMAJ04az/MQj7fmgPwWlVD5Z/+4fWMvqA
         1T+xnsN8HQiwYAi2JdwUvLq6bxFX39/iAWMuSepnVZy7S3kPJFCCssjHr9QiUGRGoGNm
         azvy34fS3Ckp3AOwsv2HAs2i1bDmccsAvwJtG2o4j/K10qkq7hPWjNTCOIFr40gnyhEA
         jECA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687526031; x=1690118031;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6MVSxGMcT3FemDOyo1EDmA72RiDKeryjTZucpOkRODM=;
        b=lRLhceypVH2HgFEj2mcOZoMgpZ5n0BOT5oApKftv+pkXkts2jSKhpxr2elGjCruyxH
         3eH+lwdqiIelkKwy32/L3t0fuWj5GsCmO0AmCjk7tx95IqLDOyKI+XkvQ0N0UKX0VDBL
         i0VSnVBhLgwrJXlh7tkCqe/oG3ExC9aqOpfQi4Zu1lX4RKLy9LHrAyHDywqnwykgZzxg
         CeBYLaKx483MhsRI0Y+TAX+6SeaQvPnYA/PxzWUbb9qTAZJWZO9fslv6gXuz6i/apaA7
         Sl4FcfWTNBOaB0KWgSKrYDr1TnvHq2rNodnR5Jgt5Rxn4Aj9/v8cdsuE0qORXhPSmXUX
         GmoA==
X-Gm-Message-State: AC+VfDwx+AjVbl0oTyWm+SPWyvQP9Iq84FgBnnyL6k4xOgxENuK/KJX1
	Ww7I76+aaBkijhH+ZsZfGfk0oQPWJQH1+vMKZEMwTw==
X-Google-Smtp-Source: ACHHUZ4pYfPqnkXRAKzj+wnHF1/kRAQOquDM0m+bRzAj21YnFCGueORHtK1EFKcJCenS7W1ImgaIiQ==
X-Received: by 2002:a17:902:f544:b0:1b6:c552:f5d9 with SMTP id h4-20020a170902f54400b001b6c552f5d9mr2812052plf.17.1687526031579;
        Fri, 23 Jun 2023 06:13:51 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id ix2-20020a170902f80200b001b3c66f806bsm7133111plb.217.2023.06.23.06.13.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 06:13:50 -0700 (PDT)
Message-ID: <64959a8e.170a0220.55f0b.f5a2@mx.google.com>
Date: Fri, 23 Jun 2023 06:13:50 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.19.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.19.287-cip100
Subject: cip/linux-4.19.y-cip kselftest-filesystems: 7 runs,
 1 regressions (v4.19.287-cip100)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 23 Jun 2023 13:13:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12140

cip/linux-4.19.y-cip kselftest-filesystems: 7 runs, 1 regressions (v4.19.28=
7-cip100)

Regressions Summary
-------------------

platform         | arch | lab         | compiler | defconfig          | reg=
ressions
-----------------+------+-------------+----------+--------------------+----=
--------
beaglebone-black | arm  | lab-broonie | gcc-10   | multi_v7_defconfig | 1  =
        =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.19.y-cip/kerne=
l/v4.19.287-cip100/plan/kselftest-filesystems/

  Test:     kselftest-filesystems
  Tree:     cip
  Branch:   linux-4.19.y-cip
  Describe: v4.19.287-cip100
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      843423b3724d762d5593ab9aaeb68ac695871b44 =



Test Regressions
---------------- =



platform         | arch | lab         | compiler | defconfig          | reg=
ressions
-----------------+------+-------------+----------+--------------------+----=
--------
beaglebone-black | arm  | lab-broonie | gcc-10   | multi_v7_defconfig | 1  =
        =


  Details:     https://kernelci.org/test/plan/id/64958fb771380d551c306137

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.287=
-cip100/arm/multi_v7_defconfig/gcc-10/lab-broonie/kselftest-filesystems-bea=
glebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.287=
-cip100/arm/multi_v7_defconfig/gcc-10/lab-broonie/kselftest-filesystems-bea=
glebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230609.0/armhf/initrd.cpio.gz =



  * kselftest-filesystems.login: https://kernelci.org/test/case/id/64958fb7=
71380d551c306138
        new failure (last pass: v4.19.284-cip99) =

 =20

