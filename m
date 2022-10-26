Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6CA2C433FE
	for <webhook@archiver.kernel.org>; Wed, 26 Oct 2022 10:08:12 +0000 (UTC)
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
 by mx.groups.io with SMTP id smtpd.web11.5882.1666778888477043317
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 26 Oct 2022 03:08:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=4rXgp+5r;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.170, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f170.google.com with SMTP id g62so10767824pfb.10
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 26 Oct 2022 03:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=fh6ps2zwjrsUeQXZm6H2jh7ItVVK3W67v/lXyCJEfac=;
        b=4rXgp+5rzGWPaQDOtzjJr5ynKon0yC/MjsXSLpI9739sRrgl5mRFopNSRWEfKv9q9O
         pl+HiaZc7xoANQkJ4kHO5RnD5gBook+qmpLl0ROm4y2L2EqVPSMAaai1ZdJGiZIQAKRP
         2S52t69TBMMmLJ+g36RnhEsPIEtEQG/Bq0wZ+WlC27EHZWYru3ZKpoU/ivrPVtpEY6kC
         jLX0jI0oeHPeEQMgcJXQoYHJ9rlPNFB3gucG5Y/S1Kkz+H82PtuFTIw/3nFhEWbJcrrd
         3tCBuCLxJgKNUkigUonSarjRvPFVkpCsb3FW19FNv5fWLAUHV9SbiHX9rfZFcjMxAsSM
         uI5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fh6ps2zwjrsUeQXZm6H2jh7ItVVK3W67v/lXyCJEfac=;
        b=SWnJ/4u1QDNKfW4/uYwNimDCboctcsuJdQpjOsjelLT9rQdqqGSLrZD14xk3ReRbH/
         1+VGUB10sh9oQTrqIuznd/l7EaR3QsNHADne9YOi/xW5SVy1NJ0uarp+o3/IGfhhzSXZ
         yjffEQofxmqmQPpJCqHg29MxFOwFOsKGz7HssEov6MMbujLXX5TxMWZtv8TuKa/YWsJe
         Aw0rM08zyFtqhbwZKyRpSJucdYjI8S8zBf0K+H1Uu0+aQDLwgJ0Dp6Asq7rM+GFwP+/2
         22EU+Z8P977ZpyozOjD/WbDUMKkbxbuTskVFq6hm9gwG96oPr6Px6+mQxwfj4jaqRNqw
         rEUw==
X-Gm-Message-State: ACrzQf2hiPiJtQ/dnd43FLst4DAx1NIprbIp4kIn6Ui+V+tpotH2XmWv
	GRTOFHySrmYoyNa27+veciwWAMOWlohXlS46
X-Google-Smtp-Source: AMsMyM6iAJr02uERBbKgUZuI1rnn9DwxduQR4jMoEmZNDvzJX7tpgs4s1Mrg76G+Gk8ISCoAEeCRAA==
X-Received: by 2002:aa7:8d57:0:b0:562:b63c:c2ba with SMTP id s23-20020aa78d57000000b00562b63cc2bamr43605752pfe.29.1666778887798;
        Wed, 26 Oct 2022 03:08:07 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id cp9-20020a170902e78900b001755ac7dd0asm2552905plb.290.2022.10.26.03.08.07
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 03:08:07 -0700 (PDT)
Message-ID: <63590707.170a0220.ab8d9.56a4@mx.google.com>
Date: Wed, 26 Oct 2022 03:08:07 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.147-cip18-11-ge6d27ea102c3b
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/pavel/linux-test smc: 10 runs,
 2 regressions (v5.10.147-cip18-11-ge6d27ea102c3b)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 26 Oct 2022 10:08:12 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9855

cip-gitlab/ci/pavel/linux-test smc: 10 runs, 2 regressions (v5.10.147-cip18=
-11-ge6d27ea102c3b)

Regressions Summary
-------------------

platform              | arch  | lab         | compiler | defconfig         =
         | regressions
----------------------+-------+-------------+----------+-------------------=
---------+------------
qemu_arm64-virt-gicv3 | arm64 | lab-broonie | gcc-10   | defconfig         =
         | 1          =

qemu_arm64-virt-gicv3 | arm64 | lab-broonie | gcc-10   | defconfig+arm64-ch=
romebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.147-cip18-11-ge6d27ea102c3b/plan/smc/

  Test:     smc
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.147-cip18-11-ge6d27ea102c3b
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      e6d27ea102c3bf928bd8f3a0815361cca9797bfb =



Test Regressions
---------------- =



platform              | arch  | lab         | compiler | defconfig         =
         | regressions
----------------------+-------+-------------+----------+-------------------=
---------+------------
qemu_arm64-virt-gicv3 | arm64 | lab-broonie | gcc-10   | defconfig         =
         | 1          =


  Details:     https://kernelci.org/test/plan/id/6358fb31de40af122b5e5b5c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.147-cip18-11-ge6d27ea102c3b/arm64/defconfig/gcc-10/lab-broonie/smc-q=
emu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.147-cip18-11-ge6d27ea102c3b/arm64/defconfig/gcc-10/lab-broonie/smc-q=
emu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20221007.0/arm64/rootfs.cpio.gz =



  * smc.login: https://kernelci.org/test/case/id/6358fb31de40af122b5e5b5d
        failing since 168 days (last pass: v4.19.233-516-ge5e741fbfc87, fir=
st fail: v5.10.109-cip5-384-g722204542e8a) =

 =



platform              | arch  | lab         | compiler | defconfig         =
         | regressions
----------------------+-------+-------------+----------+-------------------=
---------+------------
qemu_arm64-virt-gicv3 | arm64 | lab-broonie | gcc-10   | defconfig+arm64-ch=
romebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6358fb59fbe1b654ff5e5b3a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.147-cip18-11-ge6d27ea102c3b/arm64/defconfig+arm64-chromebook/gcc-10/=
lab-broonie/smc-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.147-cip18-11-ge6d27ea102c3b/arm64/defconfig+arm64-chromebook/gcc-10/=
lab-broonie/smc-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20221007.0/arm64/rootfs.cpio.gz =



  * smc.login: https://kernelci.org/test/case/id/6358fb59fbe1b654ff5e5b3b
        failing since 168 days (last pass: v4.19.233-516-ge5e741fbfc87, fir=
st fail: v5.10.109-cip5-384-g722204542e8a) =

 =20

