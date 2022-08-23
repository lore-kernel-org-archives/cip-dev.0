Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F309C32793
	for <webhook@archiver.kernel.org>; Tue, 23 Aug 2022 05:33:49 +0000 (UTC)
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com
 [209.85.210.177])
 by mx.groups.io with SMTP id smtpd.web08.28329.1661232825661267119
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 22 Aug 2022 22:33:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=l4quhTWj;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.177,
 mailfrom: bot@kernelci.org)
Received: by mail-pf1-f177.google.com with SMTP id y127so9482916pfy.5
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 22 Aug 2022 22:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc;
        bh=Z6tllBZEYsvgNFq4jHf29+KKSOVsltXv8dXm2B1smXc=;
        b=l4quhTWjMa3J6kls2qz4bdg6BBUqEcy5ij/7NIuDwtufWx9emqVgpa2/gYgQ+YDgWT
         6OCxEPLrIEPZ/1MYNIaTqhoqgoXXbtKsUbawfw205nnBMpNyEYZolA/7bu/W1Waookwt
         HukQTvDU6w0JIA0kX8RAIG4fDMx0wJUw4t98C5dlXzMaPYTv4cvpa4+piybtEOMeYioc
         DavyDmh2iyIlEkLwGk1HpHT3q1J61A9aPmBQY/4t1+QhParwEwofZTSn89U2oR7K2BE2
         hLtZdtqG4djaNQ/fay0CubqIdY8ridH1LRIDpgegshu3VHRn2akUAjU9ikyFlg7g2MqT
         tKOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=Z6tllBZEYsvgNFq4jHf29+KKSOVsltXv8dXm2B1smXc=;
        b=UiqEE3G/cMMI1uh4FHWMiOeH7SCWG366dYGqfVeWsXB2LKttMQyZhGXa+vngO/i6eQ
         ieA2pQRM+bEgGq/X/UB/DDuHkUAiu0h1KxvKzx//roHDpzar9Mf5pz4yPuKJ7LvpfXGO
         myzaCBSw0Fz0WfJcoT0ztiNNxKGzXX3+PTPXKWnlEhOzCdw9d0MW6z+RQeF74j65HYZF
         QDCBKcc9hwfykBFkhy3VyHvLikt9UvaVRN3MB5ypRxvJQViadDbSxDFThOcao9djNZXb
         cwlWE4S5MyJY+nKGC9AgFdGRTrkBFnu29BQzrB8ZFzvz0CrUkae1AK7cIfgMdw+cDb5K
         giTA==
X-Gm-Message-State: ACgBeo1GUYvSF2YfVvEkweVSh5c9f5BE6cZ+iCcYs+mTd7PyA4dhor2o
	3QJrpB6yzjfuqkUqSDCfEmw3pFuF0pEMmrKA
X-Google-Smtp-Source: 
 AA6agR4pZXYGrAxn6otcLRI5bQZ3Au+xXNQpuXQfH1m1lLphPP4yA9d1UpMspsSRUYNeFy+SgNFzNg==
X-Received: by 2002:a63:b24e:0:b0:42a:b42b:3826 with SMTP id
 t14-20020a63b24e000000b0042ab42b3826mr6836801pgo.605.1661232824861;
        Mon, 22 Aug 2022 22:33:44 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 d9-20020a170902cec900b00170953de050sm9514437plg.50.2022.08.22.22.33.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 22:33:44 -0700 (PDT)
Message-ID: <630466b8.170a0220.bd2d5.1e59@mx.google.com>
Date: Mon, 22 Aug 2022 22:33:44 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.136-cip14
Subject: cip/linux-5.10.y-cip kselftest-lkdtm: 6 runs,
 2 regressions (v5.10.136-cip14)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 23 Aug 2022 05:33:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9311

cip/linux-5.10.y-cip kselftest-lkdtm: 6 runs, 2 regressions (v5.10.136-cip1=
4)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...ok+kselftest | 1          =

hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...ok+kselftest | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.136-cip14/plan/kselftest-lkdtm/

  Test:     kselftest-lkdtm
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.136-cip14
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      cf2009ac91c8812c08044a33e89c1a53727345bb =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/630450e57058edca7c355653

  Results:     37 PASS, 17 FAIL, 25 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.136=
-cip14/x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabor=
a/kselftest-lkdtm-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.136=
-cip14/x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabor=
a/kselftest-lkdtm-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220812.0/amd64/initrd.cpio.gz =



  * kselftest-lkdtm.lkdtm_USERCOPY_STACK_FRAME_FROM_sh: https://kernelci.or=
g/test/case/id/630450e57058edca7c355659
        failing since 56 days (last pass: v5.10.121-cip9, first fail: v5.10=
.125-cip10) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/630450c5273dda6dd235565d

  Results:     36 PASS, 18 FAIL, 25 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.136=
-cip14/x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabor=
a/kselftest-lkdtm-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.136=
-cip14/x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabor=
a/kselftest-lkdtm-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220812.0/amd64/initrd.cpio.gz =



  * kselftest-lkdtm.lkdtm_USERCOPY_STACK_FRAME_FROM_sh: https://kernelci.or=
g/test/case/id/630450c5273dda6dd2355663
        failing since 56 days (last pass: v5.10.121-cip9, first fail: v5.10=
.125-cip10) =

 =20

