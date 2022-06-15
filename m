Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57DB2C433EF
	for <webhook@archiver.kernel.org>; Wed, 15 Jun 2022 09:35:04 +0000 (UTC)
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com
 [209.85.214.180])
 by mx.groups.io with SMTP id smtpd.web12.2592.1655285699492565477
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 15 Jun 2022 02:34:59 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=vuWV2iph;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.180,
 mailfrom: bot@kernelci.org)
Received: by mail-pl1-f180.google.com with SMTP id o6so9949833plg.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 15 Jun 2022 02:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=SCBRgzjA/Tj52CRI7PbX/S2VyTSFujCcl3osqpKXnng=;
        b=vuWV2iph4fCZ9USXuUvtwtFY4Z3FwGzNPuFVyJ173dH449J1FhSkFMhlVp+0y/FUBu
         LspFWPCYdJio+u56Eb+JXxqR2L8FgF/0AZLYWBvNH3GVGwTH9kjb0f1C2RVbPBky7tQX
         fX8pDdBCCBg+iewE0JBI2oHY4i+e2o5KBi28kH4xdiICFnapGj2BhQFwoWViRenWAe9o
         s5p9SERTfGv1bGp426DA6GarnATZHuHE8uDxCc69iemXcTtcZOZOOGXAtTrn+G8w+DzY
         PBgPcd59OmwL8rK0GXYcy0loX+wVCEKSOdXuL5I6O61SU5cQdlLvBxLGdS1KuM4Ga4wl
         mgrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=SCBRgzjA/Tj52CRI7PbX/S2VyTSFujCcl3osqpKXnng=;
        b=39QwdoCDKMPNAUrMBGqkT3yUk/EgK8pT4ULLh+pTiE8KHP0uPsP+2S9gfDwsEKjnRm
         P+oXThNU6FnoBz3Fm/GbBQYtE7kOUTFT5OoI68Zfk2uxEf35W73EtICg4dUpw77AOgpj
         jaHcSY+T6sP7ejIOwLsbPnt5gjlN4Q75C3sWLgCCcGduIeDxkstQnDJ1RjCs2uoDbpwW
         aClcdirIq8tS+JYLFvVgOf8wksNgWpMH/rJ843Wodkrk5obdxaKcyCDPECPR5pxPgoO+
         W1D/CRv0UxKo0jAYCr1DUmDiR+p/5B5rrtt1Hyg9ZXPDT6XA8U0mPcbqNWfhg3aMCiG2
         nSeg==
X-Gm-Message-State: AJIora8zj7rNqcRGghnng1puiCKvy+w9npJqI6WddZq9PcOrlQjapgnG
	rPscC+WlaUUUqZFayB9sot1+VWVXLK2VOPZsjAw=
X-Google-Smtp-Source: 
 AGRyM1tY90MJ7EMGgmYnieuQefsQrjmttXV67xroF2fkhXOb+CSmgsuB+BeHzP5v5C7sNc9Qhf23aQ==
X-Received: by 2002:a17:90a:1c1:b0:1e0:788a:ba35 with SMTP id
 1-20020a17090a01c100b001e0788aba35mr9231359pjd.13.1655285698835;
        Wed, 15 Jun 2022 02:34:58 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 o123-20020a62cd81000000b0051e6b11e595sm1504778pfg.116.2022.06.15.02.34.58
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 02:34:58 -0700 (PDT)
Message-ID: <62a9a7c2.1c69fb81.a9701.21b6@mx.google.com>
Date: Wed, 15 Jun 2022 02:34:58 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.4-st5-312-g3a12bf5207d81
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/pavel/linux-test smc: 4 runs,
 3 regressions (v4.4-st5-312-g3a12bf5207d81)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 15 Jun 2022 09:35:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8564

cip-gitlab/ci/pavel/linux-test smc: 4 runs, 3 regressions (v4.4-st5-312-g3a=
12bf5207d81)

Regressions Summary
-------------------

platform              | arch  | lab         | compiler | defconfig         =
         | regressions
----------------------+-------+-------------+----------+-------------------=
---------+------------
qemu_arm-virt-gicv3   | arm   | lab-broonie | gcc-10   | multi_v7_defconfig=
         | 1          =

qemu_arm64-virt-gicv3 | arm64 | lab-broonie | gcc-10   | defconfig         =
         | 1          =

qemu_arm64-virt-gicv3 | arm64 | lab-broonie | gcc-10   | defconfig+arm64-ch=
romebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.4-st5-312-g3a12bf5207d81/plan/smc/

  Test:     smc
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.4-st5-312-g3a12bf5207d81
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      3a12bf5207d810922b696a4c99c88e2841af6212 =



Test Regressions
---------------- =



platform              | arch  | lab         | compiler | defconfig         =
         | regressions
----------------------+-------+-------------+----------+-------------------=
---------+------------
qemu_arm-virt-gicv3   | arm   | lab-broonie | gcc-10   | multi_v7_defconfig=
         | 1          =


  Details:     https://kernelci.org/test/plan/id/62a7599a1f8b245898a39bcf

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-312-g3a12bf5207d81/arm/multi_v7_defconfig/gcc-10/lab-broonie/smc-=
qemu_arm-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-312-g3a12bf5207d81/arm/multi_v7_defconfig/gcc-10/lab-broonie/smc-=
qemu_arm-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220610.1/armel/rootfs.cpio.gz =



  * smc.login: https://kernelci.org/test/case/id/62a7599a1f8b245898a39bd0
        failing since 15 days (last pass: v5.10.112-cip6, first fail: v4.4-=
st5-297-gc0d53c2a5c03d) =

 =



platform              | arch  | lab         | compiler | defconfig         =
         | regressions
----------------------+-------+-------------+----------+-------------------=
---------+------------
qemu_arm64-virt-gicv3 | arm64 | lab-broonie | gcc-10   | defconfig         =
         | 1          =


  Details:     https://kernelci.org/test/plan/id/62a7559e54b83ec7bca39c6a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-312-g3a12bf5207d81/arm64/defconfig/gcc-10/lab-broonie/smc-qemu_ar=
m64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-312-g3a12bf5207d81/arm64/defconfig/gcc-10/lab-broonie/smc-qemu_ar=
m64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220610.1/arm64/rootfs.cpio.gz =



  * smc.login: https://kernelci.org/test/case/id/62a7559e54b83ec7bca39c6b
        failing since 33 days (last pass: v4.19.233-516-ge5e741fbfc87, firs=
t fail: v5.10.109-cip5-384-g722204542e8a) =

 =



platform              | arch  | lab         | compiler | defconfig         =
         | regressions
----------------------+-------+-------------+----------+-------------------=
---------+------------
qemu_arm64-virt-gicv3 | arm64 | lab-broonie | gcc-10   | defconfig+arm64-ch=
romebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62a758823429ed340ea39bd8

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-312-g3a12bf5207d81/arm64/defconfig+arm64-chromebook/gcc-10/lab-br=
oonie/smc-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-312-g3a12bf5207d81/arm64/defconfig+arm64-chromebook/gcc-10/lab-br=
oonie/smc-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220610.1/arm64/rootfs.cpio.gz =



  * smc.login: https://kernelci.org/test/case/id/62a758823429ed340ea39bd9
        failing since 33 days (last pass: v4.19.233-516-ge5e741fbfc87, firs=
t fail: v5.10.109-cip5-384-g722204542e8a) =

 =20

