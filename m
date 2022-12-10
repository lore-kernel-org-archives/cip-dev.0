Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67734C2D0CB
	for <webhook@archiver.kernel.org>; Sat, 10 Dec 2022 02:19:39 +0000 (UTC)
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
 by mx.groups.io with SMTP id smtpd.web11.6172.1670638769744251241
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 09 Dec 2022 18:19:29 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=Vkczzmzj;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.48, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f48.google.com with SMTP id n65-20020a17090a2cc700b0021bc5ef7a14so6836009pjd.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 09 Dec 2022 18:19:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=z1Qo3NgB6W51+hYDLOyZHo8+ZAaZuPKP6nu++5lESjI=;
        b=VkczzmzjpQCWvVLOAFdC34vvZ+AB5BtFavm42l4XHGu35Q01i6aMjr1JMTrPdMEevu
         sUa1/VoRrfWAL7uR1KtzAzTKVJo8eYogp3791waZuMf1dypPlH9Vh6S/JIoN4EC1nFCA
         TZy4zkrQbPxD1lURgGvfLSpBFnJKFFfjrMgahRIdEgfRUTF/wGaRYHolus5ByH+NtqPV
         pjhAuHNsZMqbuibCkdhOosHAHHQpgyUaTMHhjUACdkhXwDiD9mKMd/5D2o2Kzqu1j9Hu
         20/xCyLeEChj55WcK45fb6rT3r4T4I5PvmL/JFOV12A/MbEUz0LVKE06qWAtMuEAG7ai
         4tdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z1Qo3NgB6W51+hYDLOyZHo8+ZAaZuPKP6nu++5lESjI=;
        b=1J7/ajeOxooBl+uLodXn6T7q4Ab3G/uyUNnu1sGhF3kXkS5RnBE/hjW2ssWFyUcV8S
         niV8sA/j/URunHdpe7WX8Lkg6Hi/n0ccfG9NO1WfC84cL7kDWaDp/yCSk8hIT3CAnAL2
         7BC+k4q1gh40ZggPr79JYsgIBy0AfummCwa87lDQ336QXfXDjYiSmQdwz/kCS0VLTbnT
         fcbLfAW8XG2pV09tal/6pEysy4SolIIvFRbuG+Ovw7r2AumqGiZNZzItJoRwDCyrRflH
         2+I5Sbn/zE+HWFEi0g9xQU1UgFHTsnNhc0m/fGlgm7T+e2nP3NVa+VH8fWkqAke61bwM
         SMrw==
X-Gm-Message-State: ANoB5pl788HbzAKxzn/fiTUOFrretKxBy+ZZkCwVdHR8MQCuZH+EaIWj
	Oe0rXDdBA0W5j9Eh3/g2aYZLCXzD6uOFds7fgws=
X-Google-Smtp-Source: AA0mqf4BKA3XbQfFxIJjmbmC+InwwlkFBXMOmAltbjiztLSPoNtuB5zBcykKPT1eqeswcuyAGwvzcw==
X-Received: by 2002:a17:903:515:b0:189:bcf7:1ec0 with SMTP id jn21-20020a170903051500b00189bcf71ec0mr7690223plb.30.1670638768920;
        Fri, 09 Dec 2022 18:19:28 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id h17-20020a170902f7d100b0018703bf42desm1929528plw.159.2022.12.09.18.19.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Dec 2022 18:19:28 -0800 (PST)
Message-ID: <6393ecb0.170a0220.5843c.4be0@mx.google.com>
Date: Fri, 09 Dec 2022 18:19:28 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Kernel: v5.10.158-cip22
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip
Subject: cip/linux-5.10.y-cip kselftest-lkdtm: 6 runs,
 2 regressions (v5.10.158-cip22)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 10 Dec 2022 02:19:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10188

cip/linux-5.10.y-cip kselftest-lkdtm: 6 runs, 2 regressions (v5.10.158-cip2=
2)

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


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.158-cip22/plan/kselftest-lkdtm/

  Test:     kselftest-lkdtm
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.158-cip22
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      f37e570b7c4ab8bcfacf36780a9e204878f2c181 =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/6393dee0b089654e1a2abd06

  Results:     37 PASS, 17 FAIL, 25 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.158=
-cip22/x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabor=
a/kselftest-lkdtm-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.158=
-cip22/x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabor=
a/kselftest-lkdtm-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221202.0/amd64/initrd.cpio.gz =



  * kselftest-lkdtm.lkdtm_USERCOPY_STACK_FRAME_FROM_sh: https://kernelci.or=
g/test/case/id/6393dee0b089654e1a2abd0c
        failing since 164 days (last pass: v5.10.121-cip9, first fail: v5.1=
0.125-cip10) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/6393e71004bca0ec472abcfb

  Results:     37 PASS, 17 FAIL, 25 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.158=
-cip22/x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabor=
a/kselftest-lkdtm-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.158=
-cip22/x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabor=
a/kselftest-lkdtm-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221202.0/amd64/initrd.cpio.gz =



  * kselftest-lkdtm.lkdtm_USERCOPY_STACK_FRAME_FROM_sh: https://kernelci.or=
g/test/case/id/6393e71004bca0ec472abd01
        failing since 164 days (last pass: v5.10.121-cip9, first fail: v5.1=
0.125-cip10) =

 =20

