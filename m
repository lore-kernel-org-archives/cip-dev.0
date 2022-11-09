Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C728C4332F
	for <webhook@archiver.kernel.org>; Wed,  9 Nov 2022 11:44:00 +0000 (UTC)
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
 by mx.groups.io with SMTP id smtpd.web09.2291.1667994239799436091
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 09 Nov 2022 03:43:59 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=3PIScytF;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.174, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f174.google.com with SMTP id v3so16008134pgh.4
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 09 Nov 2022 03:43:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3Ew6HLVj+kTED33wWXAVUSIibViuEEGmDeqcviamhZ0=;
        b=3PIScytFTv2YdvKZIoeumpwZNHzzzahvTJ5c3gzcKUlwpetMx4q17WlEnM8pH5sJ7a
         JLB9QNPRD2ALRpLFh56hSGQ2GNkle9krH1fKMifMH4ZZZoaLJyNdymModPVRIXQP77XN
         NubGRA33EAxzRB5ED6uG9r5ZhNIVuyKkLjt9ENAXza/zQ1gbvRqtC0XDuO564QXgPxA4
         zD85dFfDkaNmGRTBI2PiscB+JVysBui9/ljmkaTPGfq20tJhwD1ps441pXHuFrBqATGF
         iM8JTY3EvL4QlVcSDJlL8h9YMM+z6/Zw1Zg7631l1zkfVG1N+CoLlxcfT/Zl+lKGPaPo
         qW0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3Ew6HLVj+kTED33wWXAVUSIibViuEEGmDeqcviamhZ0=;
        b=cUO3MC8lhX3euKIdWjG7Nb3BQ20YSWzMJdHuf1cJh3NuO9y24CMFQqwCKNm3sZab/x
         MsS3NFi1yue7gV5/TCLX/6ZmiQq8HC/NlW2I+2Xe0rUdZPbzMt6B6zDRr40Ivi+j3nPF
         jF9l/xRnIh160PafUJ+L2kjvLZUpC/0hJnGJkcr/s4hAdA9CS/Vi+86zwjzYzoaoERVm
         kpkY7m6okhy+HQtY3vcZ9vIylLViNf66pCTluccnQuDGloivd8oH4E9DXkCBL5pHwd36
         0zPEt3sGH1DYE+7C1mZ6SKArLrEUBG/l1MeKVnGOUB30cSqKBWcJW20fDr8QnP8bKmDl
         Uz5A==
X-Gm-Message-State: ACrzQf1iCOnmy2VK7WMdlt+2IQ/qa8qhorYGAG72iq3/x0R6YhD/Oviq
	9jPi7ROG8ruYalMGriHkLBQYJAy5Vggwdi0U
X-Google-Smtp-Source: AMsMyM5PV/9JS3/Ugq8FzlqjTdL+ec3DuRbyTahr2OK7PWJLfHa/vAQH7NnXc/wuAbs8JbC+vCK/Rw==
X-Received: by 2002:a63:eb10:0:b0:46f:9c0c:f659 with SMTP id t16-20020a63eb10000000b0046f9c0cf659mr47617521pgh.570.1667994239087;
        Wed, 09 Nov 2022 03:43:59 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id f4-20020a170902860400b001868d4600b8sm8884131plo.158.2022.11.09.03.43.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 03:43:58 -0800 (PST)
Message-ID: <636b927e.170a0220.441ca.e80e@mx.google.com>
Date: Wed, 09 Nov 2022 03:43:58 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.153-cip19
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
Subject: cip/linux-5.10.y-cip kselftest-lkdtm: 5 runs,
 3 regressions (v5.10.153-cip19)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 09 Nov 2022 11:44:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9962

cip/linux-5.10.y-cip kselftest-lkdtm: 5 runs, 3 regressions (v5.10.153-cip1=
9)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...ok+kselftest | 1          =

asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...ok+kselftest | 1          =

hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...ok+kselftest | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.153-cip19/plan/kselftest-lkdtm/

  Test:     kselftest-lkdtm
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.153-cip19
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      0f7fc281d55b27b299e8388c7d44809289ba8b99 =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/636b851610ff38c954e7db62

  Results:     37 PASS, 17 FAIL, 25 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.153=
-cip19/x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabor=
a/kselftest-lkdtm-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.153=
-cip19/x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabor=
a/kselftest-lkdtm-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221024.1/amd64/initrd.cpio.gz =



  * kselftest-lkdtm.lkdtm_USERCOPY_STACK_FRAME_FROM_sh: https://kernelci.or=
g/test/case/id/636b851610ff38c954e7db68
        failing since 134 days (last pass: v5.10.121-cip9, first fail: v5.1=
0.125-cip10) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/636b867f9e57549d86e7db4e

  Results:     37 PASS, 17 FAIL, 25 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.153=
-cip19/x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabor=
a/kselftest-lkdtm-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.153=
-cip19/x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabor=
a/kselftest-lkdtm-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221024.1/amd64/initrd.cpio.gz =



  * kselftest-lkdtm.lkdtm_USERCOPY_STACK_FRAME_FROM_sh: https://kernelci.or=
g/test/case/id/636b867f9e57549d86e7db54
        failing since 134 days (last pass: v5.10.121-cip9, first fail: v5.1=
0.125-cip10) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/636b8503c5ef404326e7db4f

  Results:     36 PASS, 18 FAIL, 25 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.153=
-cip19/x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabor=
a/kselftest-lkdtm-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.153=
-cip19/x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabor=
a/kselftest-lkdtm-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221024.1/amd64/initrd.cpio.gz =



  * kselftest-lkdtm.lkdtm_USERCOPY_STACK_FRAME_FROM_sh: https://kernelci.or=
g/test/case/id/636b8503c5ef404326e7db55
        failing since 134 days (last pass: v5.10.121-cip9, first fail: v5.1=
0.125-cip10) =

 =20

