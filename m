Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81A56C19F2D
	for <webhook@archiver.kernel.org>; Tue,  9 Aug 2022 11:21:57 +0000 (UTC)
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com
 [209.85.216.48])
 by mx.groups.io with SMTP id smtpd.web11.10666.1660044114411414891
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 09 Aug 2022 04:21:54 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=yYgVJPWH;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.48,
 mailfrom: bot@kernelci.org)
Received: by mail-pj1-f48.google.com with SMTP id
 t2-20020a17090a4e4200b001f21572f3a4so11914632pjl.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 09 Aug 2022 04:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc;
        bh=cfY/8/8RSqDdEuqSx/Oy3LftsjbKYvVmO5DjC7qpFrE=;
        b=yYgVJPWHh3iEFFzAQ/t/TONfl56ATUIYeIDEP9iinPOBIVpZI18JuZz2Zi2tX4Z5Y1
         UbMxxALhi/tZBt01/qXvgz5JSe2hnZ9MChkIZyozJI3nqFgx/AMFpNXR96quxnFV3aXe
         AH03ZVfSwZ76mQAESztDsyTS3I8DIqOB4z1voiE9bTgwZO56GdOcYcTFKh16LNFLeMR5
         +oG3j1bUcCtCGsSuvnairxNe4C98dvVE8y1HsbaTISWND5Jfp+Bd5v7zHP8wGA+5SXAM
         0xp39M6SEPVv1YS8C30pKQ7BDaO8SFBUDT67atI7wx6KNb4OLu4P7MyEPG1fLVUJFaqo
         gtug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=cfY/8/8RSqDdEuqSx/Oy3LftsjbKYvVmO5DjC7qpFrE=;
        b=ZjOL0Ec6wVgDEpvn9bCYgTYm7NqT/N9CKDND+/G+kCjePI8qS2p3HlBLpKCg4mCKkv
         rHaryGeAWzDSjY2TrrKy3S45QGJejVT5SW9mL9TpcTqITQMy2nOA3rhvk3B2N7077NAS
         2qvQt/T0BpVcbYqNATd+zNGInXVAtWgNXthLf0BrRqbp3RCp9lrnEj4rMxk8dJsrAiCk
         7DAY7A+eQ9AcExj3D4okQQQDf+UYbc+yOEttXcmM1jUOhmHL1m+njUJkLQ36IFFXKwk9
         LrVDaJBur3dx2y7aMqibRJ7HzIjQDVX71Ti1XTb245w2Rwet2dwRIbTitERiYFe6+1W8
         YXuA==
X-Gm-Message-State: ACgBeo1nIiDHfaYbD1BmxBLF/CYIMc21z2lD6SHU0eUkTDFDgMqBW7rG
	TLeIK+15wneX6ZtUmSCSadvwcAOzRPmzkxUnUJI=
X-Google-Smtp-Source: 
 AA6agR6x8nIhq/KlntO/y3H942FLDKHoN77zM1R4aFlZ8A6DA8MSXo+2O+kA44LxQIpYV/nDNJESHA==
X-Received: by 2002:a17:90b:164d:b0:1f6:a38b:91e9 with SMTP id
 il13-20020a17090b164d00b001f6a38b91e9mr18708229pjb.211.1660044113501;
        Tue, 09 Aug 2022 04:21:53 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 5-20020a620605000000b0052ad6d627a6sm10315183pfg.166.2022.08.09.04.21.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 04:21:52 -0700 (PDT)
Message-ID: <62f24350.620a0220.84837.1246@mx.google.com>
Date: Tue, 09 Aug 2022 04:21:52 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.131-cip13-38-ga8671b4cc3c74
Subject: cip/linux-5.10.y-cip kselftest-lkdtm: 4 runs,
 3 regressions (v5.10.131-cip13-38-ga8671b4cc3c74)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 09 Aug 2022 11:21:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9148

cip/linux-5.10.y-cip kselftest-lkdtm: 4 runs, 3 regressions (v5.10.131-cip1=
3-38-ga8671b4cc3c74)

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
l/v5.10.131-cip13-38-ga8671b4cc3c74/plan/kselftest-lkdtm/

  Test:     kselftest-lkdtm
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.131-cip13-38-ga8671b4cc3c74
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      a8671b4cc3c74094029e1b5523bcdc0d32eaa64a =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/62f22e4fde671695ecdaf060

  Results:     37 PASS, 17 FAIL, 25 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.131=
-cip13-38-ga8671b4cc3c74/x86_64/x86_64_defconfig+x86-chromebook+kselftest/g=
cc-10/lab-collabora/kselftest-lkdtm-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.131=
-cip13-38-ga8671b4cc3c74/x86_64/x86_64_defconfig+x86-chromebook+kselftest/g=
cc-10/lab-collabora/kselftest-lkdtm-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220805.0/amd64/initrd.cpio.gz =



  * kselftest-lkdtm.lkdtm_USERCOPY_STACK_FRAME_FROM_sh: https://kernelci.or=
g/test/case/id/62f22e4fde671695ecdaf066
        failing since 42 days (last pass: v5.10.121-cip9, first fail: v5.10=
.125-cip10) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/62f22e5e46064d90abdaf062

  Results:     37 PASS, 17 FAIL, 25 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.131=
-cip13-38-ga8671b4cc3c74/x86_64/x86_64_defconfig+x86-chromebook+kselftest/g=
cc-10/lab-collabora/kselftest-lkdtm-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.131=
-cip13-38-ga8671b4cc3c74/x86_64/x86_64_defconfig+x86-chromebook+kselftest/g=
cc-10/lab-collabora/kselftest-lkdtm-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220805.0/amd64/initrd.cpio.gz =



  * kselftest-lkdtm.lkdtm_USERCOPY_STACK_FRAME_FROM_sh: https://kernelci.or=
g/test/case/id/62f22e5e46064d90abdaf068
        failing since 42 days (last pass: v5.10.121-cip9, first fail: v5.10=
.125-cip10) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/62f22ffbd92d99bd0edaf079

  Results:     36 PASS, 18 FAIL, 25 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.131=
-cip13-38-ga8671b4cc3c74/x86_64/x86_64_defconfig+x86-chromebook+kselftest/g=
cc-10/lab-collabora/kselftest-lkdtm-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.131=
-cip13-38-ga8671b4cc3c74/x86_64/x86_64_defconfig+x86-chromebook+kselftest/g=
cc-10/lab-collabora/kselftest-lkdtm-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220805.0/amd64/initrd.cpio.gz =



  * kselftest-lkdtm.lkdtm_USERCOPY_STACK_FRAME_FROM_sh: https://kernelci.or=
g/test/case/id/62f22ffbd92d99bd0edaf07f
        failing since 42 days (last pass: v5.10.121-cip9, first fail: v5.10=
.125-cip10) =

 =20

