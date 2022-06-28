Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDF0CC43334
	for <webhook@archiver.kernel.org>; Tue, 28 Jun 2022 04:28:12 +0000 (UTC)
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com
 [209.85.214.169])
 by mx.groups.io with SMTP id smtpd.web08.52226.1656390491830006291
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 27 Jun 2022 21:28:11 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=lg+9iAQ4;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.169,
 mailfrom: bot@kernelci.org)
Received: by mail-pl1-f169.google.com with SMTP id q18so9957273pld.13
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 27 Jun 2022 21:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=QT4vaTxMtaewUYjzOHAcdwYk94u8YAmKMFD2XMgLPvQ=;
        b=lg+9iAQ4a9h0QWh8ZQLUdC1ZthdVrufXKpj4kIDvcyUBwQdh0DIAq8QPXgjlQ2cdzZ
         lr4Kb/bcM65gc+LKZG/6eiza6+TIZawCExzIXU14RRZ3Mdo2e+Yn0ar/4tDKNgBXNkbn
         vSzFVUevmlanMrChwQoPlZhqM1sJ3/fU5Ejnm8tJKxxpmRfdHwYR5RpAxlq8inHQ/MMV
         NaANshv2nciJL0u8orizDNCdB7f82E+KwrzcpTU0UvUc9MAyMDsoNxbhQvuzx0gYgXGV
         nO1aI2N98+gem3Jv3C6uNi9ZmjlvUwRy0pKKCIv/mHGFC04OKG54QSADeYaM5elowFHp
         4iQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=QT4vaTxMtaewUYjzOHAcdwYk94u8YAmKMFD2XMgLPvQ=;
        b=YMIinyMz6qiSk6LU4hBbj9YAdx4wvKEfJOzehlK4HMLh9JQ6qOsuk7HGNRsxDmqS4a
         VBjhVEGl2aKE7gGT4qsoCLJac3FItw+TOO6Jj+cA8igvWlBF0zn0gvhTqU2exeT8ZX12
         +eYjOrcEaZ/4UxD10BpzKXu0/KbwbfUamG76hUJpvlUMUxmfpuMYwdA5OyUcnBCGphu/
         TwLs/zOn6LR9ZMA0pz9kXhDzoI62EIEFHCklkZPr4EjsLJ+cQkwxlYv9J5+RO9obw0qX
         IJQCUjkED/uMxpbnZTGrfq241rVdCPUqUldiblOe3xKPKsmVvxbZYVKPsLPdZMl+Fpuq
         3HHw==
X-Gm-Message-State: AJIora+5LayEpRDe5ssVtwrl7ctfzSd7MZW3CbQdNGoq18EpXmHXbCVB
	pA8Zi7thXJ9j7GD5t9zJYIgW9zbm3pzNnbFG
X-Google-Smtp-Source: 
 AGRyM1v77q9m3ktCgl/d3HUmDtMYPZmoMTh+a1VQmAgKT/W2oQESS286iCgdYItesGQUVLtqcHdWIA==
X-Received: by 2002:a17:902:db0a:b0:16b:917e:5c36 with SMTP id
 m10-20020a170902db0a00b0016b917e5c36mr361876plx.100.1656390491140;
        Mon, 27 Jun 2022 21:28:11 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 c9-20020a170902c2c900b0016a091e993dsm8108071pla.42.2022.06.27.21.28.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 21:28:10 -0700 (PDT)
Message-ID: <62ba835a.1c69fb81.60c1a.b9ce@mx.google.com>
Date: Mon, 27 Jun 2022 21:28:10 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.19.249-cip76
X-Kernelci-Branch: linux-4.19.y-cip
X-Kernelci-Tree: cip
Subject: cip/linux-4.19.y-cip smc: 8 runs, 2 regressions (v4.19.249-cip76)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 28 Jun 2022 04:28:12 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8619

cip/linux-4.19.y-cip smc: 8 runs, 2 regressions (v4.19.249-cip76)

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


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.19.y-cip/kerne=
l/v4.19.249-cip76/plan/smc/

  Test:     smc
  Tree:     cip
  Branch:   linux-4.19.y-cip
  Describe: v4.19.249-cip76
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      c293ac909598851c30308172c5f11a445c7c2d1f =



Test Regressions
---------------- =



platform              | arch  | lab         | compiler | defconfig         =
         | regressions
----------------------+-------+-------------+----------+-------------------=
---------+------------
qemu_arm64-virt-gicv3 | arm64 | lab-broonie | gcc-10   | defconfig+arm64-ch=
romebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62ba7541f74c3b64d5a39bd7

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.249=
-cip76/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/smc-qemu_arm64-v=
irt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.249=
-cip76/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/smc-qemu_arm64-v=
irt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220624.0/arm64/rootfs.cpio.gz =



  * smc.login: https://kernelci.org/test/case/id/62ba7541f74c3b64d5a39bd8
        failing since 17 days (last pass: v4.19.237-cip71, first fail: v4.1=
9.246-cip75) =

 =



platform              | arch  | lab         | compiler | defconfig         =
         | regressions
----------------------+-------+-------------+----------+-------------------=
---------+------------
qemu_arm64-virt-gicv3 | arm64 | lab-broonie | gcc-10   | defconfig         =
         | 1          =


  Details:     https://kernelci.org/test/plan/id/62ba7569e07db73b1ba39bec

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.249=
-cip76/arm64/defconfig/gcc-10/lab-broonie/smc-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.249=
-cip76/arm64/defconfig/gcc-10/lab-broonie/smc-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220624.0/arm64/rootfs.cpio.gz =



  * smc.login: https://kernelci.org/test/case/id/62ba7569e07db73b1ba39bed
        failing since 28 days (last pass: v4.19.237-cip71, first fail: v4.1=
9.245-cip74) =

 =20

