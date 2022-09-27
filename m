Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35332C6FA92
	for <webhook@archiver.kernel.org>; Tue, 27 Sep 2022 09:39:43 +0000 (UTC)
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com
 [209.85.216.48])
 by mx.groups.io with SMTP id smtpd.web12.9029.1664271574529915632
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 27 Sep 2022 02:39:34 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=MJ6RGYOx;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.48,
 mailfrom: bot@kernelci.org)
Received: by mail-pj1-f48.google.com with SMTP id
 g1-20020a17090a708100b00203c1c66ae3so9568195pjk.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 27 Sep 2022 02:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=Ss/lUAL5FVaYLAFCxuAJDjGcPUsPs9OmJ+MRnnUYLHI=;
        b=MJ6RGYOxm0iQSoUgjZv6k2LcsC3xdI4qwVVhs8jA1LDRw3LAJnyibuFfkO7/NpAXuu
         xCITnASTil9fT9cjV7vuVmUwCuLmLFIawoRzb1N7JZQYoGc5qpN2iXhphkNFdwigMkH+
         OjTAmzldI+cLiVUe1WLU7o3/l4jtBx8Shmy4/tHNilOIS1PE1mUtSyoef+SFYBxgpsEo
         6XcAsGz+pG+e95oZaNbrhOyj0IFVyVlSEM+UXgUs3/BuKdIJO93+1XRZWGR9nsZAtt78
         fFcEQr1X4flfUkpOOyqBs6YtdsTfR2CaynCM54IoAy+ZveVaV23UxCx2fACG54J6Gj6L
         +w8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=Ss/lUAL5FVaYLAFCxuAJDjGcPUsPs9OmJ+MRnnUYLHI=;
        b=TYZRpv4mX09EL2jPyJLuka/puMaslhNU+C2gEYmC/+1u+1qsgE/a6FkojRmN0npAQp
         2ggwWJz+JO7/3YC/xv+K9iyCWCNLga5R7R1AbF7+Ir6r+t61JFQ4bYj1k9SG0H1cmn0v
         RjlCUscPNE+sBdm8jdMQdyRfnvdJqT9kGDYvjplthMghpnuCY83Rw9FlA12+0Rc4wMqc
         pZcUZ/80+DgfJkCXSJqq2zK7JH0OhFyqKmvLUonWrbCF5RwFDmoXKnShvizE2/6HRo/T
         rf0ne1a70P9twxoRxWmK++Ro2CQmACveaCO9nRed/y0oLCYgw/4Cl8jAhNXizQOBRzdw
         Occw==
X-Gm-Message-State: ACrzQf0FyT3I1dhZ8u51FOWUtPupLBrsfRLaNPtt1YWx1nu/o5RGBB2Q
	LKW4aHNguyGTICN0FHiEe15dIIC7mvqHkEmK
X-Google-Smtp-Source: 
 AMsMyM4Os3XeYGmi4P13p224dz1oUMph7b1CeCow/5lU2tT7cED3mz4HnRj9NcmsZYjQtnkMsTowCA==
X-Received: by 2002:a17:90b:33c5:b0:202:fa60:3769 with SMTP id
 lk5-20020a17090b33c500b00202fa603769mr3585357pjb.60.1664271573801;
        Tue, 27 Sep 2022 02:39:33 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 o196-20020a62cdcd000000b0054ad9c6b70fsm1201464pfg.8.2022.09.27.02.39.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 02:39:33 -0700 (PDT)
Message-ID: <6332c4d5.620a0220.89bdf.1ddc@mx.google.com>
Date: Tue, 27 Sep 2022 02:39:33 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.145-cip17
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
Subject: cip/linux-5.10.y-cip kselftest-lkdtm: 6 runs,
 2 regressions (v5.10.145-cip17)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 27 Sep 2022 09:39:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9553

cip/linux-5.10.y-cip kselftest-lkdtm: 6 runs, 2 regressions (v5.10.145-cip1=
7)

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
l/v5.10.145-cip17/plan/kselftest-lkdtm/

  Test:     kselftest-lkdtm
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.145-cip17
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      93a53e86925ce8c2e0608e173e2c7b952ee61cdd =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/6332bb957d5fed786bec4ece

  Results:     37 PASS, 17 FAIL, 25 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.145=
-cip17/x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabor=
a/kselftest-lkdtm-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.145=
-cip17/x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabor=
a/kselftest-lkdtm-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220919.0/amd64/initrd.cpio.gz =



  * kselftest-lkdtm.lkdtm_USERCOPY_STACK_FRAME_FROM_sh: https://kernelci.or=
g/test/case/id/6332bb957d5fed786bec4ed4
        failing since 91 days (last pass: v5.10.121-cip9, first fail: v5.10=
.125-cip10) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/6332bd04b684075f08ec4ea7

  Results:     36 PASS, 18 FAIL, 25 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.145=
-cip17/x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabor=
a/kselftest-lkdtm-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.145=
-cip17/x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabor=
a/kselftest-lkdtm-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220919.0/amd64/initrd.cpio.gz =



  * kselftest-lkdtm.lkdtm_USERCOPY_STACK_FRAME_FROM_sh: https://kernelci.or=
g/test/case/id/6332bd04b684075f08ec4ead
        failing since 91 days (last pass: v5.10.121-cip9, first fail: v5.10=
.125-cip10) =

 =20

