Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16905ECAAD4
	for <webhook@archiver.kernel.org>; Wed, 31 Aug 2022 18:51:48 +0000 (UTC)
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com
 [209.85.214.174])
 by mx.groups.io with SMTP id smtpd.web10.2756.1661971899603124225
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 31 Aug 2022 11:51:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=I5Ukfutp;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.174,
 mailfrom: bot@kernelci.org)
Received: by mail-pl1-f174.google.com with SMTP id f24so12215101plr.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 31 Aug 2022 11:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc;
        bh=kqePwVtvkY3dfST13xthdCKjjeLSRIqvkcqmv1NZdRk=;
        b=I5Ukfutpe3DojHPRVdBk3GarN1UkKw+tmJ0lcqDppAp2i6QMIZVmpGn0m+WamKMZf5
         KfFDMvAhqhHZdPxTzcHugOuSm6wbCvtLVIwPwzL4lty0H2jyXfXgzQFGY/ZVVu4Ur3p4
         21Do4xyCzZHghSBA8XgLekP4BHcqPeVfTis2wvMdhZQbCetZrF51EUuHNpyr1Xh7KqPM
         nMbETlZX1OtDdQPLOMC+sGSIMkRzQyEpd1pzqTtnwOTTllxq4U4FI+IW1EM2UvWFvjlF
         U388ZC62dJ7VnJkwV2r2vshpOdzDIKYjYLVelEwPXSrMBONiL7Wsyv8u7cPY8MEkRHSK
         jZfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=kqePwVtvkY3dfST13xthdCKjjeLSRIqvkcqmv1NZdRk=;
        b=dQMNAi+BwuUv1ZCp2s4HZyiQ11vR0LN2GpmVRVH4OORQVJCUomnKGULQ85++6lChX+
         E2DNp/u0gSK7EJnmrp10Muthz6PBKos5DkdhxCBFlYr7L/H3Pd7r04bRMkGnQF7Rnkk5
         TgASIISLKGQBuoBMGLI6zMh5LhzZZgi3R+bxHWArg/WD9lFQMgn3j/8f/WGENymkMPCE
         DZ8WaDYQT2nPDLZ9hWzvn9y2I39gFahduuYsw2Oo1sKZM98+koAUE9+8UOLh+NcOQeT4
         319qnTXENjZWQU/saf+fR6Vxv9BP4tzlfTDdPjXouYfNi93td7DBbTDaMziTA6uVSE7n
         TnTA==
X-Gm-Message-State: ACgBeo1khTUt2iVk/+IhWe9x3SKKSOOROYteK8QrvhTdtjJpi31HWHXI
	1EXlbgR5xH6jlwzVC5DMFswbQEMNTyFXY7i7zMU=
X-Google-Smtp-Source: 
 AA6agR7FV3wTHx0X2DIJj7D+C8Mnl9gRmYmf/qDSThq98oO1S/QamblUmCAoJQ+0NRGD8TwC0N3LDg==
X-Received: by 2002:a17:903:244c:b0:171:55cf:a930 with SMTP id
 l12-20020a170903244c00b0017155cfa930mr27377607pls.35.1661971898290;
        Wed, 31 Aug 2022 11:51:38 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 z1-20020a170903018100b0017515e598c5sm4235187plg.40.2022.08.31.11.51.37
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 11:51:37 -0700 (PDT)
Message-ID: <630fadb9.170a0220.4687e.8aa0@mx.google.com>
Date: Wed, 31 Aug 2022 11:51:37 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.138-cip15-90-gd4130d0ee3c7
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-lkdtm: 3 runs,
 1 regressions (v5.10.138-cip15-90-gd4130d0ee3c7)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 31 Aug 2022 18:51:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9393

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-lkdtm: 3 runs, 1 regre=
ssions (v5.10.138-cip15-90-gd4130d0ee3c7)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...ok+kselftest | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.138-cip15-90-gd4130d0ee3c7/plan/kselftest=
-lkdtm/

  Test:     kselftest-lkdtm
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.138-cip15-90-gd4130d0ee3c7
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      d4130d0ee3c72fc50c48ae861863e85537802c47 =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/630f9cd72e773832ae355642

  Results:     37 PASS, 17 FAIL, 25 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.138-cip15-90-gd4130d0ee3c7/x86_64/x86_64_defconfig+x86-c=
hromebook+kselftest/gcc-10/lab-collabora/kselftest-lkdtm-asus-C433TA-AJ0005=
-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.138-cip15-90-gd4130d0ee3c7/x86_64/x86_64_defconfig+x86-c=
hromebook+kselftest/gcc-10/lab-collabora/kselftest-lkdtm-asus-C433TA-AJ0005=
-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220826.0/amd64/initrd.cpio.gz =



  * kselftest-lkdtm.lkdtm_USERCOPY_STACK_FRAME_FROM_sh: https://kernelci.or=
g/test/case/id/630f9cd72e773832ae355653
        failing since 68 days (last pass: v5.10.118-465-g0af29783a3c9, firs=
t fail: v5.10.121-cip9-272-g3fb28d4c623b) =

 =20

