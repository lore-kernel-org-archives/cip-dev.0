Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C074ECDFA1
	for <webhook@archiver.kernel.org>; Wed, 26 Oct 2022 18:56:55 +0000 (UTC)
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
 by mx.groups.io with SMTP id smtpd.web11.11650.1666810612350493347
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 26 Oct 2022 11:56:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=uQE1b/8O;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.169, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f169.google.com with SMTP id p3so14129899pld.10
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 26 Oct 2022 11:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=KoalL4oFjG94kWEmC8A+gTy6YHjPOEcddIJ3qxA3upY=;
        b=uQE1b/8O0PLzGWDA7F8Tpv3bvBhBR9nn+n492sx4l4YyX08h+Vf/14+XzhBC3X9SlO
         DN95Taqp+CjmUMMBoTwfhffTPop1JhlSjwWjaxsDcsa0omGmeBYC1pbJtvgwlG3WeCuF
         +bx5dpTtoO6/ZDOid1XJVCmbbWjmNuF0wzDKsqYwA6PIu5BKDarh2DVz1fryrKaQX5bV
         6Bbzi4yvKk/3AwXURcF6UtyG0Tc3lcZiXlJiZzny9UmlpLZO4apfAKILVN3rwcZAzaLH
         d5mPPeXeAgRzqJw0gJHa+EakLejgGscVd1pV4SZOkn1A8b15f3cC4P+M6Nin7eHisht3
         oGcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KoalL4oFjG94kWEmC8A+gTy6YHjPOEcddIJ3qxA3upY=;
        b=1AMzyjmly4a0CLVSCS4L0QDA3JUeANZzYzrvdBXjfPwkCFzfcIIRiHKjriouhNQszb
         +G0P4wJrdb9vE1EMj6hwbzILi2k8UsXsPDnqpqUxLpKvemxYjXev3trub4AMTpMYs+Tu
         mn6M90WepVq1mkSNNz4xT/1vE+FkOOWZHyFySsNav6PCZ4YZ+RFQXVetDPQKZEyUatIS
         xkqQcjcnSCaGsKLftErcLhnuLsNbSHkgb3YOCSoSt4hpx3shBpoJnRShdQsmvU7O1HS8
         5Xo67CE/J1qhzwOhAnjGz69QpT7fjOxasfmpHPkSUcaK/ZwHP6Atj0bY6BrSzgkhyiHT
         BgFA==
X-Gm-Message-State: ACrzQf2gjoxudVJoxWIormrQ4OqXxRrLrjJVQepQxisu3YvBfzfoqTmu
	9y0khUgO9d1OP76FIY628xhNRKDQ+ohvzXbY
X-Google-Smtp-Source: AMsMyM5DW41LYeGhmEgyQAy6Gvgu9hEZzh/h4Ct07p2CRcLCYeQu3kx6dM6mYRoMeRuV8abKn4drgw==
X-Received: by 2002:a17:90b:1c82:b0:1ee:eb41:b141 with SMTP id oo2-20020a17090b1c8200b001eeeb41b141mr5938154pjb.143.1666810611516;
        Wed, 26 Oct 2022 11:56:51 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id z1-20020a170903018100b0017dd8c8009esm3271296plg.4.2022.10.26.11.56.50
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 11:56:51 -0700 (PDT)
Message-ID: <635982f3.170a0220.63ae6.6f78@mx.google.com>
Date: Wed, 26 Oct 2022 11:56:51 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.147-cip18-451-g87ba4bc77ca06
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-lkdtm: 4 runs,
 1 regressions (v5.10.147-cip18-451-g87ba4bc77ca06)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 26 Oct 2022 18:56:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9871

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-lkdtm: 4 runs, 1 regre=
ssions (v5.10.147-cip18-451-g87ba4bc77ca06)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...ok+kselftest | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.147-cip18-451-g87ba4bc77ca06/plan/kselfte=
st-lkdtm/

  Test:     kselftest-lkdtm
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.147-cip18-451-g87ba4bc77ca06
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      87ba4bc77ca0665b0965e4fd545904bc2f92617b =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/635976f37b9c480183e7db68

  Results:     37 PASS, 17 FAIL, 25 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.147-cip18-451-g87ba4bc77ca06/x86_64/x86_64_defconfig+x86=
-chromebook+kselftest/gcc-10/lab-collabora/kselftest-lkdtm-asus-C433TA-AJ00=
05-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.147-cip18-451-g87ba4bc77ca06/x86_64/x86_64_defconfig+x86=
-chromebook+kselftest/gcc-10/lab-collabora/kselftest-lkdtm-asus-C433TA-AJ00=
05-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221024.1/amd64/initrd.cpio.gz =



  * kselftest-lkdtm.lkdtm_USERCOPY_STACK_FRAME_FROM_sh: https://kernelci.or=
g/test/case/id/635976f37b9c480183e7db6e
        failing since 124 days (last pass: v5.10.118-465-g0af29783a3c9, fir=
st fail: v5.10.121-cip9-272-g3fb28d4c623b) =

 =20

