Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04F2BC61DA4
	for <webhook@archiver.kernel.org>; Mon, 13 Mar 2023 13:36:15 +0000 (UTC)
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
 by mx.groups.io with SMTP id smtpd.web10.19523.1678714571211412696
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 13 Mar 2023 06:36:11 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=MD2DX3Qj;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.53, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f53.google.com with SMTP id cp7-20020a17090afb8700b0023756229427so16958438pjb.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 13 Mar 2023 06:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112; t=1678714570;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=jcahdYovinIhMdbggAzgeXwOeJNuJOidDdSthUYp/mQ=;
        b=MD2DX3Qj9X7qIJ+NuvL7pLtLYE+Woy8gVls1EU3FvYnmslvLAYd75UacEcjQIk5ybn
         pfMiwHRy49TpQXYpbNnO0wlYpVMHoyvHD6bWbbm9+B83CieszJP0KO0trToQejSo+VEp
         xAR/OKLkq4SbzutNEu/ROR18ZWx3DAELhIkxVZftbVhXPaZpCwIe5qCCUsLsa6JKSzoe
         fjbNJuZJU4SIikUgO4JROzjiYHqb8bJW4JU7NEeG6cdqMa+1fqwxTqtVJABjYVgkLZ0I
         SAgjivtn+YsbsM4NnpRbEpDonm2/eckBYAeoQuPv9dkU+4z378p+NLSUTY0M1lgcftSI
         W82w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678714570;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jcahdYovinIhMdbggAzgeXwOeJNuJOidDdSthUYp/mQ=;
        b=piMd8W7jzPAhEkWvklvXTnYCwMneupsB5fUI+qWokcWeZlyY+zJGWQ7UsvZSmPr5BL
         qASRtb1wRjFCyhoT+TDowPJOG/oWPEzueq55RZ+0SM7q6hUBDhoKIJ1YlaG8fIzCRVEw
         D2qjpzLnxuqrzo3ffwNhJFAj6MQ1Ix1PwegPb9K+qcsKHg8KPZstOZUzDqpH8+Xm6G8I
         M4oTpfjYloE67NYL5HXaDiy/YKEFWS/Kz9lZKQGO+F8lCGs9BRPwrScB9AM+2L/R8XM2
         61WkG9kqn6UIOXnILnuZqQxTl/d8xahTgdzEb+3v4hxxCkDNEt5XLPhRQYZ1TIEiPaVg
         ctoA==
X-Gm-Message-State: AO0yUKWBeJy081BzF2XUHu2bk4qCUQANC38WYklopHyENvXdSdOqbB6i
	G7rAhOQP/wVrwf967nZFSmJdL2fzbrbk7WaDwhDNT2me
X-Google-Smtp-Source: AK7set+BCMlLoSeqE+eCeG+R72qf2yEkFlpJL4RyB5M1/YeomYuFCI6FebuamIxk6OR25dkXeJhvnQ==
X-Received: by 2002:a17:902:dad0:b0:19e:baa1:26bd with SMTP id q16-20020a170902dad000b0019ebaa126bdmr32016600plx.13.1678714570319;
        Mon, 13 Mar 2023 06:36:10 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id ks7-20020a170903084700b0019f1264c7d7sm4795930plb.103.2023.03.13.06.36.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 06:36:10 -0700 (PDT)
Message-ID: <640f26ca.170a0220.2c335.7a71@mx.google.com>
Date: Mon, 13 Mar 2023 06:36:10 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.4.y-st
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v4.4-st20-939-g5ff13a6decb9
X-Kernelci-Report-Type: test
Subject: cip/linux-4.4.y-st baseline-nfs: 24 runs,
 2 regressions (v4.4-st20-939-g5ff13a6decb9)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 13 Mar 2023 13:36:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11013

cip/linux-4.4.y-st baseline-nfs: 24 runs, 2 regressions (v4.4-st20-939-g5ff=
13a6decb9)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
imx6q-udoo                | arm    | lab-broonie   | gcc-10   | imx_v6_v7_d=
efconfig          | 1          =

lenovo-TPad-C13-Yoga-zork | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.4.y-st/kernel/=
v4.4-st20-939-g5ff13a6decb9/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip
  Branch:   linux-4.4.y-st
  Describe: v4.4-st20-939-g5ff13a6decb9
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      5ff13a6decb9b0e64a7efe5e840b90b27be9150b =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
imx6q-udoo                | arm    | lab-broonie   | gcc-10   | imx_v6_v7_d=
efconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/640f208acf60b0898b8c8644

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-st/v4.4-st20-9=
39-g5ff13a6decb9/arm/imx_v6_v7_defconfig/gcc-10/lab-broonie/baseline-nfs-im=
x6q-udoo.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-st/v4.4-st20-9=
39-g5ff13a6decb9/arm/imx_v6_v7_defconfig/gcc-10/lab-broonie/baseline-nfs-im=
x6q-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230303.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/640f208acf60b0898=
b8c8645
        new failure (last pass: v4.4-st20-822-g5fd63c0469e9) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
lenovo-TPad-C13-Yoga-zork | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/640f1c03beb6e7e7458c8638

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-st/v4.4-st20-9=
39-g5ff13a6decb9/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-nfs-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-st/v4.4-st20-9=
39-g5ff13a6decb9/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabor=
a/baseline-nfs-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230303.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/640f1c03beb6e7e74=
58c8639
        new failure (last pass: v4.4-st20-821-g39bdf0444b23) =

 =20

