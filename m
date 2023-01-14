Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D739FC6379F
	for <webhook@archiver.kernel.org>; Sat, 14 Jan 2023 03:30:19 +0000 (UTC)
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
 by mx.groups.io with SMTP id smtpd.web10.109132.1673667018078732204
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 13 Jan 2023 19:30:18 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=UTc1BMcC;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.49, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f49.google.com with SMTP id v23so24212727pju.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 13 Jan 2023 19:30:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=iXSylLHMIgV5oIwvGiQHB1KjMFuYoiLfs/aoDSxXB1E=;
        b=UTc1BMcC61wUFb6d2k9V8ZD4yCC5g1Igv/u5v1l9c/rzBYUaMAAgSfiOPAXFjnTPI8
         gbKG+U+vmZZgqviH/CXbJzTspBqHNPMUdcnKB7JCgqEjLzs2ctPuNUY1CsqBNhOvZsX8
         A4Djfh+bRJtNf4mt8p8vFyNBVvfuYPTTbrlmLFhd3BvUgidsxft0Gqqld3ugSGF/6dSw
         mzAVH2ZTKALiQ1pQJrN/OmmVw+khRr69ugvOP3vIYbKEa4nY7aOKTK2C2Fx36zKwP3RC
         Bz13jhn659gjpiiOktMIzrpng16yE2ZsRzLzMEttOsOMU6SwmuLt6jPF0g+JqB/KKwfH
         4GWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iXSylLHMIgV5oIwvGiQHB1KjMFuYoiLfs/aoDSxXB1E=;
        b=F2PXh1kswyVe7zcxl7d2j2ennjUebzinNl5zilHYFIOnU84KFdBwhohrEBOcj8EUe5
         aQl7mbdEWQkVOYQrSlvntOjri5Dy0FqiXpH1A0nkVf7SiS4xXzFgbl2jC4sl8EbY7d2D
         TyDv5qE/ZZj7QRYJl3z+/77/Te2fRngsI9rvBWOYxFz0NbhRECFe/sRRNYXW/HEb7dxp
         EJXG+mKqkkSz5iOZ83oVjXxoepuI0AG+86YyAANPXsV0p/ZIikcsftyUbqIC9/mF4oNJ
         PjeshabqK6SAtnVs577C3k1lQ5ZbK5cqVj5HIaUcySKQgUGKcyk2RAK+JMJ+ljdE5R8s
         74Xg==
X-Gm-Message-State: AFqh2kr21vzAB4ErnrS7V8OZRe1/mVNeKqu9sbjuBYZSjwnAGo+m9M8v
	kLrRcNvhjH0oqCAwShRMVB64DepUihb+GmQuLNo=
X-Google-Smtp-Source: AMrXdXtr0CYHx5owaiUJzkhRlYJ0sb9WQLZ3GKXUaHvMjHDKSCgAu7c+RtHvr8ACsSlg3caDISfLnQ==
X-Received: by 2002:a17:90a:5903:b0:229:11ab:4ea8 with SMTP id k3-20020a17090a590300b0022911ab4ea8mr7085167pji.36.1673667017422;
        Fri, 13 Jan 2023 19:30:17 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id nh21-20020a17090b365500b0022932d12de1sm1431284pjb.46.2023.01.13.19.30.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 19:30:17 -0800 (PST)
Message-ID: <63c221c9.170a0220.ae68b.232e@mx.google.com>
Date: Fri, 13 Jan 2023 19:30:17 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.10.162-cip24
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Report-Type: test
Subject: cip/linux-5.10.y-cip kselftest-lkdtm: 5 runs,
 3 regressions (v5.10.162-cip24)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 14 Jan 2023 03:30:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10354

cip/linux-5.10.y-cip kselftest-lkdtm: 5 runs, 3 regressions (v5.10.162-cip2=
4)

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
l/v5.10.162-cip24/plan/kselftest-lkdtm/

  Test:     kselftest-lkdtm
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.162-cip24
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      7ef5f1fda52a95426084959dac09acdb3c81327b =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/63c20c66b70bcc4e851d3a45

  Results:     37 PASS, 17 FAIL, 25 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.162=
-cip24/x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabor=
a/kselftest-lkdtm-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.162=
-cip24/x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabor=
a/kselftest-lkdtm-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230109.0/amd64/initrd.cpio.gz =



  * kselftest-lkdtm.lkdtm_USERCOPY_STACK_FRAME_FROM_sh: https://kernelci.or=
g/test/case/id/63c20c66b70bcc4e851d3a4b
        failing since 199 days (last pass: v5.10.121-cip9, first fail: v5.1=
0.125-cip10) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/63c20c8e637e7d3c331d39c8

  Results:     37 PASS, 17 FAIL, 25 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.162=
-cip24/x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabor=
a/kselftest-lkdtm-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.162=
-cip24/x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabor=
a/kselftest-lkdtm-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230109.0/amd64/initrd.cpio.gz =



  * kselftest-lkdtm.lkdtm_USERCOPY_STACK_FRAME_FROM_sh: https://kernelci.or=
g/test/case/id/63c20c8e637e7d3c331d39ce
        failing since 199 days (last pass: v5.10.121-cip9, first fail: v5.1=
0.125-cip10) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/63c20c52b70bcc4e851d39ec

  Results:     36 PASS, 18 FAIL, 25 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.162=
-cip24/x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabor=
a/kselftest-lkdtm-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.162=
-cip24/x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabor=
a/kselftest-lkdtm-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230109.0/amd64/initrd.cpio.gz =



  * kselftest-lkdtm.lkdtm_USERCOPY_STACK_FRAME_FROM_sh: https://kernelci.or=
g/test/case/id/63c20c52b70bcc4e851d39f2
        failing since 199 days (last pass: v5.10.121-cip9, first fail: v5.1=
0.125-cip10) =

 =20

