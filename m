Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38F58C77B60
	for <webhook@archiver.kernel.org>; Wed, 22 Mar 2023 14:26:24 +0000 (UTC)
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
 by mx.groups.io with SMTP id smtpd.web11.44142.1679495175690664701
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 22 Mar 2023 07:26:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=pL0CvpHL;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.182, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f182.google.com with SMTP id le6so19408822plb.12
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 22 Mar 2023 07:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112; t=1679495175;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=4c4cmpJrx3a8nI/rf/Khs1qTzb1l0Zgf5i6++SooQI8=;
        b=pL0CvpHL9Sbnc3txupf/7hAcDwsyD+Tofh1XUOoAqWrMHtXUkxhBl4XR7np4mPUp/F
         wC6Mg3K7wMvjnrfm0vIZu8NkDYSKhqYt65cgSsSpQl/KUYhtkoJvpQx2YGj/t6wQLZGt
         MSOEG1at8tYcGJmdRLuXNlQIPhja6fabEDwlXMOjVxy+j7qUcolCVDhOHbw+VM+otGD0
         sscC18e8RVE277hhO9QNfvaHaH/sLdZydiDSiyNXkoVk0eJPTOc2mxhjya/8qDWMQ7+/
         fEvdcW2WXzXcVza2mf0wZcfbJshj/j2NRALwcChX7nhshyrnGKOET6X36ZwmwvO8TnMP
         bpRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679495175;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4c4cmpJrx3a8nI/rf/Khs1qTzb1l0Zgf5i6++SooQI8=;
        b=pjWB5JRJDWJwPmhH+JcGm+l8o+gveT2jQWQnz3XjsMcdZQeLYUBw6RnrnX9QFSI7Qs
         b6ySV1ejYb1vyHF/RbB362mUsoubKXhpTq0Ot03HxTFZd2dWtG+oEtLIty1cPfGRE+ae
         Cb2qqksK58MkTDlvqB4E+SrC3C/tmhC05E14wUfMdebDUAvhriQmCDQOx9dpKq7afkyH
         OjzJHX+f9xDYuZcoGJ/QPbb2QgVOGJI6QuP80ABmRBJFnNBCRi7mS5IMByB/B97mN9l8
         9UcZfrTQitk1CRkt2JmY+hGFecI3kkzsGIcRisTEENWfYMA/T2piQsiGeycTjVKpwoit
         RIKg==
X-Gm-Message-State: AO0yUKU88puoaIK7XyqYe4jYhLocBx7nzni7t4CAWvGK2c314xM0hSPg
	5sTH+yYN9SMCyfHy/wXhs+I/yYMzkOC8RCn/Md4Q7w==
X-Google-Smtp-Source: AK7set8IZKznvndBU68ea1SZbu3uLwaFM74mk/Zt9IEg1zulnmU/rRy1NY0yVXedMbR485Enh+hSlQ==
X-Received: by 2002:a17:90b:1d12:b0:233:f394:d83 with SMTP id on18-20020a17090b1d1200b00233f3940d83mr3272147pjb.48.1679495174941;
        Wed, 22 Mar 2023 07:26:14 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id s16-20020a17090a1c1000b0023d0e743ff6sm13244779pjs.3.2023.03.22.07.26.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 07:26:14 -0700 (PDT)
Message-ID: <641b1006.170a0220.2874a.8ba6@mx.google.com>
Date: Wed, 22 Mar 2023 07:26:14 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip-rt
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.175-cip29-rt12
Subject: cip/linux-5.10.y-cip-rt ltp-ipc: 18 runs,
 5 regressions (v5.10.175-cip29-rt12)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 22 Mar 2023 14:26:24 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11092

cip/linux-5.10.y-cip-rt ltp-ipc: 18 runs, 5 regressions (v5.10.175-cip29-rt=
12)

Regressions Summary
-------------------

platform               | arch   | lab           | compiler | defconfig     =
               | regressions
-----------------------+--------+---------------+----------+---------------=
---------------+------------
asus-C436FA-Flip-hatch | x86_64 | lab-collabora | gcc-10   | defconfig+x86-=
chromebook     | 1          =

asus-C436FA-Flip-hatch | x86_64 | lab-collabora | gcc-10   | x86_64_defcon.=
..k+preempt_rt | 1          =

asus-cx9400-volteer    | x86_64 | lab-collabora | gcc-10   | defconfig+x86-=
chromebook     | 1          =

asus-cx9400-volteer    | x86_64 | lab-collabora | gcc-10   | x86_64_defcon.=
..k+preempt_rt | 1          =

qemu_riscv64           | riscv  | lab-collabora | gcc-10   | defconfig     =
               | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip-rt/ke=
rnel/v5.10.175-cip29-rt12/plan/ltp-ipc/

  Test:     ltp-ipc
  Tree:     cip
  Branch:   linux-5.10.y-cip-rt
  Describe: v5.10.175-cip29-rt12
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      0a6a8df2de5a8e8f024b47926cff286c6ec0e31f

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  f3463a347c37b44bafdf4e882cfb932f6888905d =



Test Regressions
---------------- =



platform               | arch   | lab           | compiler | defconfig     =
               | regressions
-----------------------+--------+---------------+----------+---------------=
---------------+------------
asus-C436FA-Flip-hatch | x86_64 | lab-collabora | gcc-10   | defconfig+x86-=
chromebook     | 1          =


  Details:     https://kernelci.org/test/plan/id/641afdcf8b2a1833839c95da

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
175-cip29-rt12/x86_64/defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-ipc=
-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
175-cip29-rt12/x86_64/defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-ipc=
-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230317.0/amd64/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/641afdcf8b2a1833839c95=
db
        new failure (last pass: v5.10.162-cip24-rt10) =

 =



platform               | arch   | lab           | compiler | defconfig     =
               | regressions
-----------------------+--------+---------------+----------+---------------=
---------------+------------
asus-C436FA-Flip-hatch | x86_64 | lab-collabora | gcc-10   | x86_64_defcon.=
..k+preempt_rt | 1          =


  Details:     https://kernelci.org/test/plan/id/641afc52e1527573ed9c9527

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+preempt_rt
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
175-cip29-rt12/x86_64/x86_64_defconfig+x86-chromebook+preempt_rt/gcc-10/lab=
-collabora/ltp-ipc-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
175-cip29-rt12/x86_64/x86_64_defconfig+x86-chromebook+preempt_rt/gcc-10/lab=
-collabora/ltp-ipc-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230317.0/amd64/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/641afc52e1527573ed9c95=
28
        new failure (last pass: v5.10.162-cip24-rt10) =

 =



platform               | arch   | lab           | compiler | defconfig     =
               | regressions
-----------------------+--------+---------------+----------+---------------=
---------------+------------
asus-cx9400-volteer    | x86_64 | lab-collabora | gcc-10   | defconfig+x86-=
chromebook     | 1          =


  Details:     https://kernelci.org/test/plan/id/641afd6a5ff8c5068a9c951c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
175-cip29-rt12/x86_64/defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-ipc=
-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
175-cip29-rt12/x86_64/defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-ipc=
-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230317.0/amd64/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/641afd6a5ff8c5068a9c95=
1d
        new failure (last pass: v5.10.162-cip24-rt10) =

 =



platform               | arch   | lab           | compiler | defconfig     =
               | regressions
-----------------------+--------+---------------+----------+---------------=
---------------+------------
asus-cx9400-volteer    | x86_64 | lab-collabora | gcc-10   | x86_64_defcon.=
..k+preempt_rt | 1          =


  Details:     https://kernelci.org/test/plan/id/641afb293da1da38929c9515

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+preempt_rt
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
175-cip29-rt12/x86_64/x86_64_defconfig+x86-chromebook+preempt_rt/gcc-10/lab=
-collabora/ltp-ipc-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
175-cip29-rt12/x86_64/x86_64_defconfig+x86-chromebook+preempt_rt/gcc-10/lab=
-collabora/ltp-ipc-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230317.0/amd64/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/641afb293da1da38929c95=
16
        new failure (last pass: v5.10.162-cip24-rt10) =

 =



platform               | arch   | lab           | compiler | defconfig     =
               | regressions
-----------------------+--------+---------------+----------+---------------=
---------------+------------
qemu_riscv64           | riscv  | lab-collabora | gcc-10   | defconfig     =
               | 1          =


  Details:     https://kernelci.org/test/plan/id/641affdb30d79cb2079c9559

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
175-cip29-rt12/riscv/defconfig/gcc-10/lab-collabora/ltp-ipc-qemu_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
175-cip29-rt12/riscv/defconfig/gcc-10/lab-collabora/ltp-ipc-qemu_riscv64.ht=
ml
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30317.0/riscv64/rootfs.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/641affdb30d79cb2079c95=
5a
        new failure (last pass: v5.10.162-cip24-rt10) =

 =20

