Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8F02CCA489
	for <webhook@archiver.kernel.org>; Tue, 26 Jul 2022 03:36:30 +0000 (UTC)
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com
 [209.85.216.52])
 by mx.groups.io with SMTP id smtpd.web09.2589.1658806581963255919
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 25 Jul 2022 20:36:22 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=MWXYKxNO;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.52,
 mailfrom: bot@kernelci.org)
Received: by mail-pj1-f52.google.com with SMTP id gn8so382202pjb.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 25 Jul 2022 20:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=WZ85VmsUm/HT8nxMi07215AplFQS9mCmZpAHccteaHI=;
        b=MWXYKxNOITiZ4z+6vln8wRoO8GmLfhkStRhEZ09qLXQMeSsQAIwk71wGT8fbJDOCnM
         fVZbUMpQODwajrPgxAO3v1QmG3lYgfyLX7NifShHPlcHZBL7R4xy/oGRJNr0UDp9rpZu
         Von57oDqdYNF7/vCZnYfzitmemND08QsdHT2JsjZMr3pTSkf7t8Rop0BVDkHjozAP9Li
         gIMCTCH3KrZWNwOl+txyYpL0Rcys3WGj9mIcHyQ0QtjWoebQoGt0A1rPYc+/Zof8BYX/
         YitUY/cfH1BRCaIQi4EGdUQ1F07xB0c+uQwt6lhROiLTjpqCHB9jAXi+CjaOFjwGwmTe
         Xn/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=WZ85VmsUm/HT8nxMi07215AplFQS9mCmZpAHccteaHI=;
        b=ErI+yLhyQlsC72hd7MChAqf53m73N+B5H2KKCJzXumTX6snL7RnV6FaQyqq7bp/iEH
         u2luUuwMNOpuE+sYXnNA8ieWbSC17SZAImvnIqRAYcdfR3l7VTkws//YY6qzaUom7MVH
         PzG92OOc73H2h0sPumPsZswi+fxe4Lay0dD3ghrIfD0z2BdcfltsIDHt0s4R7XkqOOZb
         AbTxvQjQrBnGdCGL4uNJpKiIIulJtT8BKnOCVpl4vd/v5gkm/gFMe+t6+573f5+O3w3z
         +Qu7xT79xD5PxHXeJgyJBZZsdwwI1ce5CcWzPo8a6DXQh0JKVDCEGacPZ0J+1eHGGmPf
         0FtQ==
X-Gm-Message-State: AJIora8VX7Vt1ty1cZ8WaNGwp/T3awNDuw/bzUFNSDm6F80j2I1XT4rn
	itSkNRWW1tunwVlUHkRso+JA3MiIIgtoeg2L
X-Google-Smtp-Source: 
 AGRyM1twn6T+2km7epXqXrzrxPcijoF71CkAhXALXYNsX6Nwu57fgVDg+OcpVBFEF+tfZZK6z7NQcQ==
X-Received: by 2002:a17:90b:1802:b0:1f2:d0c8:7eca with SMTP id
 lw2-20020a17090b180200b001f2d0c87ecamr5027411pjb.193.1658806581176;
        Mon, 25 Jul 2022 20:36:21 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 z1-20020aa79f81000000b0052ba78e7c20sm10702404pfr.97.2022.07.25.20.36.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 20:36:20 -0700 (PDT)
Message-ID: <62df6134.1c69fb81.1888b.1480@mx.google.com>
Date: Mon, 25 Jul 2022 20:36:20 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.129-cip12-12-g93db31b19404
Subject: cip/linux-5.10.y-cip kselftest-lkdtm: 5 runs,
 4 regressions (v5.10.129-cip12-12-g93db31b19404)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 26 Jul 2022 03:36:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8922

cip/linux-5.10.y-cip kselftest-lkdtm: 5 runs, 4 regressions (v5.10.129-cip1=
2-12-g93db31b19404)

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

r8a774a1-hihope-rzg2m-ex  | arm64  | lab-cip       | gcc-10   | defconfig+k=
selftest          | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.129-cip12-12-g93db31b19404/plan/kselftest-lkdtm/

  Test:     kselftest-lkdtm
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.129-cip12-12-g93db31b19404
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      93db31b194040f61924e230fdae0266bd92c54cc =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/62df4f185ac25be21ddaf061

  Results:     37 PASS, 17 FAIL, 25 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.129=
-cip12-12-g93db31b19404/x86_64/x86_64_defconfig+x86-chromebook+kselftest/gc=
c-10/lab-collabora/kselftest-lkdtm-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.129=
-cip12-12-g93db31b19404/x86_64/x86_64_defconfig+x86-chromebook+kselftest/gc=
c-10/lab-collabora/kselftest-lkdtm-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220718.0/amd64/initrd.cpio.gz =



  * kselftest-lkdtm.lkdtm_USERCOPY_STACK_FRAME_FROM_sh: https://kernelci.or=
g/test/case/id/62df4f185ac25be21ddaf067
        failing since 27 days (last pass: v5.10.121-cip9, first fail: v5.10=
.125-cip10) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/62df57d097d174b3afdaf082

  Results:     37 PASS, 17 FAIL, 25 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.129=
-cip12-12-g93db31b19404/x86_64/x86_64_defconfig+x86-chromebook+kselftest/gc=
c-10/lab-collabora/kselftest-lkdtm-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.129=
-cip12-12-g93db31b19404/x86_64/x86_64_defconfig+x86-chromebook+kselftest/gc=
c-10/lab-collabora/kselftest-lkdtm-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220718.0/amd64/initrd.cpio.gz =



  * kselftest-lkdtm.lkdtm_USERCOPY_STACK_FRAME_FROM_sh: https://kernelci.or=
g/test/case/id/62df57d097d174b3afdaf088
        failing since 27 days (last pass: v5.10.121-cip9, first fail: v5.10=
.125-cip10) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/62df55598cae9b7647daf058

  Results:     36 PASS, 18 FAIL, 25 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.129=
-cip12-12-g93db31b19404/x86_64/x86_64_defconfig+x86-chromebook+kselftest/gc=
c-10/lab-collabora/kselftest-lkdtm-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.129=
-cip12-12-g93db31b19404/x86_64/x86_64_defconfig+x86-chromebook+kselftest/gc=
c-10/lab-collabora/kselftest-lkdtm-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220718.0/amd64/initrd.cpio.gz =



  * kselftest-lkdtm.lkdtm_USERCOPY_STACK_FRAME_FROM_sh: https://kernelci.or=
g/test/case/id/62df55598cae9b7647daf05e
        failing since 27 days (last pass: v5.10.121-cip9, first fail: v5.10=
.125-cip10) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
r8a774a1-hihope-rzg2m-ex  | arm64  | lab-cip       | gcc-10   | defconfig+k=
selftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/62df5577405d8b4348daf08b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.129=
-cip12-12-g93db31b19404/arm64/defconfig+kselftest/gcc-10/lab-cip/kselftest-=
lkdtm-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.129=
-cip12-12-g93db31b19404/arm64/defconfig+kselftest/gcc-10/lab-cip/kselftest-=
lkdtm-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220718.0/arm64/initrd.cpio.gz =



  * kselftest-lkdtm.login: https://kernelci.org/test/case/id/62df5577405d8b=
4348daf08c
        new failure (last pass: v5.10.129-cip12) =

 =20

