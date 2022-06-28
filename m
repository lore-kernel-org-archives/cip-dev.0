Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD38FC433EF
	for <webhook@archiver.kernel.org>; Tue, 28 Jun 2022 00:39:31 +0000 (UTC)
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com
 [209.85.210.178])
 by mx.groups.io with SMTP id smtpd.web08.50462.1656376766292386458
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 27 Jun 2022 17:39:26 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=cXp6Slf+;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.178,
 mailfrom: bot@kernelci.org)
Received: by mail-pf1-f178.google.com with SMTP id x138so7843035pfc.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 27 Jun 2022 17:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=+d0SHX3Wj7BoNWDgWjEmMaOvWF69CsjzKwcIA56EyQE=;
        b=cXp6Slf+UAB9+VYhw+Gffx8XEznj9CswBdXGn8oBEwbYz9IzNgMVRfCcFhRNHQ3Dtz
         WTgh+E5cPr42r9TAophXNT4InMeBWKQMXAaZm4CnF52tf4VCE6RK6qyIX1ige7O5gsu6
         3vUIi6LLNP2spVlmHmYmz6u/8yL30hjHhSvcs4zZOysxebcuGc1XC5qsBisBK+yTwWia
         Xqdoo/Qdz7aPiTv+InNU4zPh9d1LGWuF0piGY1fIgziUh2qVgGfrg3tyCnNeGS6amEbn
         KVhZjZhLeiB7qHAe9O6kqveHAtYESs1GcZhFxsBanHF1WYq1WYPTGLs2lY0AK6x3DYED
         Cjeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=+d0SHX3Wj7BoNWDgWjEmMaOvWF69CsjzKwcIA56EyQE=;
        b=UiEhAOcUOMJH/802bFik4W+jR8hLaLtV9MGgYWijllRvFT/6jPGnxvG6MxYC8JOTKH
         6LOJTl55WhAVrNMR4Kw9LXrIj33G4Fk6dUyWoOl4VBRT7vyKWfMLXD2iYeMwffyd22MI
         nFycla3yCqXDXWbMmgBkccEGjGFwQ/wYXLGhqy8iwp23nnzuogcEvZJiTRiyX4DVmcr6
         u1W7kCJz9sBG8TM0bswcerST26xTr6sVwT5dVES4bb5djGmNX2Wj+xZeNGBoOhDFU+Fx
         Glu0d7Ky8NwYNMZ0uJBKKuQbGzQDb3KezZ8oDZtKh5DIoZ2PR7CL1/KzFFhl2qyHjZ4a
         gxaw==
X-Gm-Message-State: AJIora8VUfV4DgDwDPzqfXHnkOBCCyC0eAefYbIsSuDBxlGM37ErlB8P
	uctNnu+YdWeDCdIWdorUq76+LPl0RKabednA
X-Google-Smtp-Source: 
 AGRyM1tBvu2gf0Bf2ihDqOWzPCMfSSMbS/RPlC1Aj/Cn2TFVLMbX1j8U1xleUvvin/qrRasVcTZtNA==
X-Received: by 2002:a63:1d7:0:b0:40c:fb51:51f8 with SMTP id
 206-20020a6301d7000000b0040cfb5151f8mr14726999pgb.585.1656376765707;
        Mon, 27 Jun 2022 17:39:25 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 r20-20020a170902be1400b0016b68cf6ae5sm3345342pls.226.2022.06.27.17.39.24
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 17:39:25 -0700 (PDT)
Message-ID: <62ba4dbd.1c69fb81.e3093.4d45@mx.google.com>
Date: Mon, 27 Jun 2022 17:39:25 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.121-cip9-287-ge9094c8446fc
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc smc: 9 runs,
 2 regressions (v5.10.121-cip9-287-ge9094c8446fc)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 28 Jun 2022 00:39:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8614

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc smc: 9 runs, 2 regressions (v5.1=
0.121-cip9-287-ge9094c8446fc)

Regressions Summary
-------------------

platform              | arch  | lab         | compiler | defconfig         =
         | regressions
----------------------+-------+-------------+----------+-------------------=
---------+------------
qemu_arm64-virt-gicv3 | arm64 | lab-broonie | gcc-10   | defconfig+arm64-ch=
romebook | 1          =

qemu_arm64-virt-gicv3 | arm64 | lab-broonie | gcc-10   | defconfig         =
         | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.121-cip9-287-ge9094c8446fc/plan/smc/

  Test:     smc
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.121-cip9-287-ge9094c8446fc
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      e9094c8446fcef728d675699ced39be2dbbfb8f7 =



Test Regressions
---------------- =



platform              | arch  | lab         | compiler | defconfig         =
         | regressions
----------------------+-------+-------------+----------+-------------------=
---------+------------
qemu_arm64-virt-gicv3 | arm64 | lab-broonie | gcc-10   | defconfig+arm64-ch=
romebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62ba40f589487d1a60a39be4

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.121-cip9-287-ge9094c8446fc/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-broonie/smc-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.121-cip9-287-ge9094c8446fc/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-broonie/smc-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220624.0/arm64/rootfs.cpio.gz =



  * smc.login: https://kernelci.org/test/case/id/62ba40f589487d1a60a39be5
        failing since 46 days (last pass: v5.10.112-cip6-88-gf3397cadb2dd6,=
 first fail: v5.10.112-cip6-289-g2969e096d186) =

 =



platform              | arch  | lab         | compiler | defconfig         =
         | regressions
----------------------+-------+-------------+----------+-------------------=
---------+------------
qemu_arm64-virt-gicv3 | arm64 | lab-broonie | gcc-10   | defconfig         =
         | 1          =


  Details:     https://kernelci.org/test/plan/id/62ba4271027ddb65c8a39bda

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.121-cip9-287-ge9094c8446fc/arm64/defconfig/gcc-10/lab-br=
oonie/smc-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.121-cip9-287-ge9094c8446fc/arm64/defconfig/gcc-10/lab-br=
oonie/smc-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220624.0/arm64/rootfs.cpio.gz =



  * smc.login: https://kernelci.org/test/case/id/62ba4271027ddb65c8a39bdb
        failing since 49 days (last pass: v5.10.112-cip6-88-gf3397cadb2dd6,=
 first fail: v5.10.112-cip6-218-g8253434cd56a) =

 =20

