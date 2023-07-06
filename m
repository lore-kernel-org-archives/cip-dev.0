Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAE53EB64D9
	for <webhook@archiver.kernel.org>; Thu,  6 Jul 2023 04:18:07 +0000 (UTC)
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
 by mx.groups.io with SMTP id smtpd.web11.14430.1688617079426662419
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 05 Jul 2023 21:17:59 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=s1V/PL8K;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.175, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6687096c6ddso230001b3a.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 05 Jul 2023 21:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1688617078; x=1691209078;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=IK/bDCUsBdKm/csdc+aL59oBXrvnC8esD1rxKQ6wzPU=;
        b=s1V/PL8KkjOWIxomYgIeEPR5fZ0PSGL2fVv8Lkvd/O6IiOURcAyZQPgUqsve8c9yne
         jUtkk8H0UPgjgvaJWhzU6C7c2fJpCKgCorO+mJ+m6lFZ0xeKKpUS8tPPGVMq/CVd8RCg
         +w4K0jVhiuYiCeIg34Iym/VrClWC76LNHOF3Oi/ZeyDKZO2+uIaeDIeMOVfEtCHWuvjQ
         ZSfeAXKJWIegDm8zKvFp9m7t/WTmsTnT1zPCUhPXXjWWGcKiqmH7SabzADI6qJoXvkwA
         S2U4YUCOfi7ZiJYbN01pIFwkLDY6cOfbNtFRuIlbb0w/Z0zJOZjvULMBGOvgayghxfqN
         GQHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688617078; x=1691209078;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IK/bDCUsBdKm/csdc+aL59oBXrvnC8esD1rxKQ6wzPU=;
        b=f3/6P2t4XyeJv9HiCUMdqc0iOPWn43Apd9s2HcJ/77pl951qBMsuzdxuhXYjm7MuKC
         gRcSzmfz9ACvO9dmHkAPuq8X26mk9H/U1+1CT8tT1UADgf5Bvw5EnSBtYVlNa6IJ2WQn
         w9OaZ3XR2PfTBxXierO/kfEf/IEhRSe7FHvzbcmk1UD+cohWYsfmpsqJoP2wGEFOpdVb
         +lfMwylsxKpQZCgX2vY1+StUc7DJZ1yLB5kvMz94YTyc2bvY0uKpE7kCSQgnnWlaSZXC
         bcJWbmg2kyj1kVRx/lwoN4kQ6vOVQv4rFTY49WwwO6GU2Byt0iHlmdg1MMtNYTs6iXJV
         wibQ==
X-Gm-Message-State: ABy/qLaM3iFxMHLU2ABB9PjHI50a0roe8THjYCjhqMp/KsitMXBavXYm
	h7nuA2rwA88+UiraAoLNNiN/3Ku5lgfqTUk2wkb5BA==
X-Google-Smtp-Source: APBJJlGvnXyRus9tkfK2A1YdZJ8sbObKOHWGFbwAbOYN02gYGCl2nXAXBQ1NdUwo6HhanL3eTkz5ZA==
X-Received: by 2002:a05:6a00:13a5:b0:681:50fd:2b85 with SMTP id t37-20020a056a0013a500b0068150fd2b85mr652519pfg.27.1688617078408;
        Wed, 05 Jul 2023 21:17:58 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id v20-20020aa78094000000b00669c99d05fasm290484pff.150.2023.07.05.21.17.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 21:17:57 -0700 (PDT)
Message-ID: <64a64075.a70a0220.801fe.0b31@mx.google.com>
Date: Wed, 05 Jul 2023 21:17:57 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.1.31-64-g93fc2d0f5008
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-6.1.y-cip
Subject: cip/linux-6.1.y-cip baseline-nfs: 17 runs,
 1 regressions (v6.1.31-64-g93fc2d0f5008)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 06 Jul 2023 04:18:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12247

cip/linux-6.1.y-cip baseline-nfs: 17 runs, 1 regressions (v6.1.31-64-g93fc2=
d0f5008)

Regressions Summary
-------------------

platform      | arch | lab         | compiler | defconfig          | regres=
sions
--------------+------+-------------+----------+--------------------+-------=
-----
at91sam9g20ek | arm  | lab-broonie | gcc-10   | multi_v5_defconfig | 1     =
     =


  Details:  https://kernelci.org/test/job/cip/branch/linux-6.1.y-cip/kernel=
/v6.1.31-64-g93fc2d0f5008/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip
  Branch:   linux-6.1.y-cip
  Describe: v6.1.31-64-g93fc2d0f5008
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      93fc2d0f50088e8475632061960ee7cdb9756010 =



Test Regressions
---------------- =



platform      | arch | lab         | compiler | defconfig          | regres=
sions
--------------+------+-------------+----------+--------------------+-------=
-----
at91sam9g20ek | arm  | lab-broonie | gcc-10   | multi_v5_defconfig | 1     =
     =


  Details:     https://kernelci.org/test/plan/id/64a6325d31347384f6bb2a8b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v5_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.31-64=
-g93fc2d0f5008/arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline-nfs-at91s=
am9g20ek.txt
  HTML log:    https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.31-64=
-g93fc2d0f5008/arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline-nfs-at91s=
am9g20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armel/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/64a6325d31347384f=
6bb2a8c
        failing since 20 days (last pass: v6.1.31-46-g4cc1cc26e90f, first f=
ail: v6.1.31-53-g486caac40d06) =

 =20

