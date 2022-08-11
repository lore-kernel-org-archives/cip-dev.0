Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D970C25B0C
	for <webhook@archiver.kernel.org>; Thu, 11 Aug 2022 15:40:40 +0000 (UTC)
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com
 [209.85.215.180])
 by mx.groups.io with SMTP id smtpd.web08.8001.1660232439472768731
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 11 Aug 2022 08:40:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=rUDWphXP;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.180,
 mailfrom: bot@kernelci.org)
Received: by mail-pg1-f180.google.com with SMTP id r22so15040983pgm.5
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 11 Aug 2022 08:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc;
        bh=wfrQY0zkO/fxrpM/FBsbue0ggdhF2Mp2opTygdDkpzQ=;
        b=rUDWphXP2TnkXXALiT140v5qNEXW3o7CFPqZrd2DvbMbkeY92zwU/zAXl6iMauTHUz
         +6SoscDQINOU4w0AX+yNw4lu5Hl+CqfikBopflqAKcQCLSy3kFIGUXGV95Xs5TNoIq8c
         lzgmXTMwTCWFefdnYQXA4jHk4AEs3qWJqRHnOZ6VrO7ae9X2+0TFloASmSkCOJJrqIGK
         eSXhdd8t8P+zZEfxMd07XVnA3mhDTM+tM+vgxqbL2eZ3Bxs8BC1FfIRnXlYEhHKYYNjN
         MjUBbV03eu8vjj8aQKKcA5G4zEA0kh3BV1Mj4AYYW9CVwXm4DRf6f++snBN5EZE1tlb8
         j+DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=wfrQY0zkO/fxrpM/FBsbue0ggdhF2Mp2opTygdDkpzQ=;
        b=JS579m9ZK8y65TfX4tSnSmn28c9TgvQ3rHIqkFOt6Qrfdxzlk3vrWfyFUCztUnT02d
         SS64UNhzCIDolaYB9l9F6qFwgA9tQ6H35hZwjAFCHFIg3GJlFTGPTWGdr4e5Qo3ADaBO
         JhYJS16y/SjYfPKC4bHJX4gFbzPeecaLwHujcmYs95mnwNgH+l85G0V/YQHV8VYCyGGV
         loh0hz3903YQVyj9IibzhlsTvQhy8/pRKfOQLuH985QlgbyK7pGtxflR/UvrUCfVBMdm
         4UKBOiakimZGADI7mYDia5Ux/bYCV7s/YwZtB3BQqePls+lKrOzcBAm5sMztwvwWaAd1
         27Kg==
X-Gm-Message-State: ACgBeo2PFJkwauGBFiFawhE/YC2dwEnSWchIei28nPVcbceeFDcY/uqh
	l9C8IJOSzjr+p01M19HKyf8WkDVO5agm0v7HvII=
X-Google-Smtp-Source: 
 AA6agR5ttm0k4jP+w5hOXYfBB4NljBM2rZXti3u0uGKPC3EGE+3pn3VdXrbFNm+yAb5tgB6kw0TcEg==
X-Received: by 2002:a05:6a00:1948:b0:525:45e3:2eb7 with SMTP id
 s8-20020a056a00194800b0052545e32eb7mr32779099pfk.77.1660232437144;
        Thu, 11 Aug 2022 08:40:37 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 b10-20020a170902650a00b0016d5b7fb02esm15128470plk.60.2022.08.11.08.40.36
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Aug 2022 08:40:36 -0700 (PDT)
Message-ID: <62f522f4.170a0220.dca39.906e@mx.google.com>
Date: Thu, 11 Aug 2022 08:40:36 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.131-cip13-493-ge129308279043
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-lkdtm: 5 runs,
 2 regressions (v5.10.131-cip13-493-ge129308279043)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 11 Aug 2022 15:40:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9165

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-lkdtm: 5 runs, 2 regre=
ssions (v5.10.131-cip13-493-ge129308279043)

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


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.131-cip13-493-ge129308279043/plan/kselfte=
st-lkdtm/

  Test:     kselftest-lkdtm
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.131-cip13-493-ge129308279043
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      e12930827904334316a5d7407de3f9a7126f9892 =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/62f5118d43ef3ecacfdaf070

  Results:     37 PASS, 17 FAIL, 25 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.131-cip13-493-ge129308279043/x86_64/x86_64_defconfig+x86=
-chromebook+kselftest/gcc-10/lab-collabora/kselftest-lkdtm-asus-C433TA-AJ00=
05-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.131-cip13-493-ge129308279043/x86_64/x86_64_defconfig+x86=
-chromebook+kselftest/gcc-10/lab-collabora/kselftest-lkdtm-asus-C433TA-AJ00=
05-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220805.0/amd64/initrd.cpio.gz =



  * kselftest-lkdtm.lkdtm_USERCOPY_STACK_FRAME_FROM_sh: https://kernelci.or=
g/test/case/id/62f5118d43ef3ecacfdaf076
        failing since 47 days (last pass: v5.10.118-465-g0af29783a3c9, firs=
t fail: v5.10.121-cip9-272-g3fb28d4c623b) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/62f513536a1c90205fdaf06c

  Results:     36 PASS, 18 FAIL, 25 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.131-cip13-493-ge129308279043/x86_64/x86_64_defconfig+x86=
-chromebook+kselftest/gcc-10/lab-collabora/kselftest-lkdtm-hp-11A-G6-EE-gru=
nt.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.131-cip13-493-ge129308279043/x86_64/x86_64_defconfig+x86=
-chromebook+kselftest/gcc-10/lab-collabora/kselftest-lkdtm-hp-11A-G6-EE-gru=
nt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220805.0/amd64/initrd.cpio.gz =



  * kselftest-lkdtm.lkdtm_USERCOPY_STACK_FRAME_FROM_sh: https://kernelci.or=
g/test/case/id/62f513536a1c90205fdaf072
        failing since 47 days (last pass: v5.10.118-465-g0af29783a3c9, firs=
t fail: v5.10.121-cip9-272-g3fb28d4c623b) =

 =20

