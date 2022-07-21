Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F4D0CCA48A
	for <webhook@archiver.kernel.org>; Thu, 21 Jul 2022 10:54:04 +0000 (UTC)
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com
 [209.85.216.48])
 by mx.groups.io with SMTP id smtpd.web10.4909.1658400840652486098
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 21 Jul 2022 03:54:00 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=RHc+sCDH;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.48,
 mailfrom: bot@kernelci.org)
Received: by mail-pj1-f48.google.com with SMTP id ku18so1252504pjb.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 21 Jul 2022 03:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=lOHmVNR1i2sOq5zEIoCVgyhH4ccvxqsssG+X6znXv5c=;
        b=RHc+sCDH8YNdWgP9pGSuNugWSzaVHvf49MiBIYiTtplaxoSsq8qXExLFjihs8h7W+0
         CW6rb9CP6JUEhWa+vVXOKQZXEK1z6FDPpn+BsV6Grnu1AhgoX8VaUwVQroMj7OQ/J3DI
         aspKkCbotGumNYp2ebm0DOQi1AsWAkjfYZgNCtEEu4EOsfWIOUcPr3N9cXyfBxbGseHA
         GzIhPgDZWuqz6frKi2FPN96GAqPWKH97+pQuViV4T58E+yj6Y9B4+Ssqyw8uH0/KjXmt
         AN2F7zd+lRljpn1BODfJyFIGLgTrSQyOjhYy3Q5pPYLqu8b/3nQr4CocZZtzXeVRumqd
         1YYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=lOHmVNR1i2sOq5zEIoCVgyhH4ccvxqsssG+X6znXv5c=;
        b=wtrcV0lhJ48o98Uk4uto80QKGlFKK7N9ZB7fMUMxA9kVzc62HCmv4Hh+uc9YP3gaQY
         0Tqnv1259NAMeo52ueGJzVpt9hF4IUGEbdKZVP2rwyiBbBXrcSCKeR2DLxdQKG1JGCrW
         VamgdTrAUbE3dZtvRwMYijBODmGBzvKaG8sN9HLsbC1EiQs0zqLgiTz+0MDRE0skGcP0
         Ciin/J7bfxHRLZixrglqhNzUXy5w/6STgjvBMEN1+QeV4aTB8Qx4iDH4GDMUm00xkH3u
         aUjSChM95CtSWbKigImt8GagHfA01Bxx47myzHvyp/wiAoxZ2LtoLAwNywHeBUQ4rcFV
         +NIw==
X-Gm-Message-State: AJIora8yy//mQ0joJHQHTzbX8kxKtvKFN+kfHAMpctsCuu5bQAXNurBB
	9U889XJT+L8c8gqv2AjRIGYuIzMPAb7exJCCK3Q=
X-Google-Smtp-Source: 
 AGRyM1vYDE7u41XR9NMHBMfHx94ny/muHpZ96j04QszbJ9tx4V5Fg5h0y7zqR7Uq9Swt4h9F0QDYOg==
X-Received: by 2002:a17:902:aa0b:b0:16b:c4a6:1dc9 with SMTP id
 be11-20020a170902aa0b00b0016bc4a61dc9mr43435808plb.83.1658400839941;
        Thu, 21 Jul 2022 03:53:59 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 36-20020a630e64000000b0040df0c9a1aasm1199473pgo.14.2022.07.21.03.53.58
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 03:53:59 -0700 (PDT)
Message-ID: <62d93047.1c69fb81.204c9.1c73@mx.google.com>
Date: Thu, 21 Jul 2022 03:53:59 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.129-cip12-12-ge4e007863cc76
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc smc: 9 runs,
 3 regressions (v5.10.129-cip12-12-ge4e007863cc76)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 21 Jul 2022 10:54:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8880

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc smc: 9 runs, 3 regressions (v5.1=
0.129-cip12-12-ge4e007863cc76)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 2          =

qemu_arm64-virt-gicv3        | arm64  | lab-broonie   | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.129-cip12-12-ge4e007863cc76/plan/smc/

  Test:     smc
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.129-cip12-12-ge4e007863cc76
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      e4e007863cc767efd75ca69c0b98e5daab0c20ff =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/62d9187b7c643e1719daf0cd

  Results:     14 PASS, 2 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.129-cip12-12-ge4e007863cc76/x86_64/x86_64_defconfig+x86-=
chromebook/gcc-10/lab-collabora/smc-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.129-cip12-12-ge4e007863cc76/x86_64/x86_64_defconfig+x86-=
chromebook/gcc-10/lab-collabora/smc-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220716.0/x86/rootfs.cpio.gz =



  * smc.CVE-2018-3639: https://kernelci.org/test/case/id/62d9187b7c643e1719=
daf0d9
        failing since 16 days (last pass: v5.10.121-cip9-287-ge9094c8446fc,=
 first fail: v5.10.125-cip10-119-g603acbe1aceb)

    2022-07-21T09:12:04.967665  <8>[   13.052097] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3DCVE-2018-3639 RESULT=3Dfail>   =


  * smc.CVE-2018-3640: https://kernelci.org/test/case/id/62d9187b7c643e1719=
daf0da
        failing since 16 days (last pass: v5.10.121-cip9-287-ge9094c8446fc,=
 first fail: v5.10.125-cip10-119-g603acbe1aceb)

    2022-07-21T09:12:04.949819  <8>[   13.034129] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3DCVE-2018-3640 RESULT=3Dfail>   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3        | arm64  | lab-broonie   | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/62d91e47a75c989310daf057

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.129-cip12-12-ge4e007863cc76/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-broonie/smc-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.129-cip12-12-ge4e007863cc76/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-broonie/smc-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220716.0/arm64/rootfs.cpio.gz =



  * smc.login: https://kernelci.org/test/case/id/62d91e47a75c989310daf058
        failing since 69 days (last pass: v5.10.112-cip6-88-gf3397cadb2dd6,=
 first fail: v5.10.112-cip6-289-g2969e096d186) =

 =20

