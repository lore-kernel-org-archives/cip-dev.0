Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43A00C3F6B0
	for <webhook@archiver.kernel.org>; Tue, 26 Jul 2022 15:29:14 +0000 (UTC)
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com
 [209.85.214.177])
 by mx.groups.io with SMTP id smtpd.web10.8174.1658849349948034063
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 26 Jul 2022 08:29:10 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=ubthqNeU;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.177,
 mailfrom: bot@kernelci.org)
Received: by mail-pl1-f177.google.com with SMTP id c6so9560211plc.5
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 26 Jul 2022 08:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=zRaeRpssHGEJ3ZNYUu1/i94m3jkTrPpKQv9e/J9Wae4=;
        b=ubthqNeU4ice4bs3vvHsQ5KI7wR0C3+hGmaRqoWkGCDoqD26GHpxWsVHOBMO+R7ZTO
         /M20Yi318hlSlivkOLTT29OQxc0nD+bY88LJtFphN8hYI0D6NX12IUPw2D5yA6orZKmi
         p+YYWT7vRce9ZPtDQ/DCpWwS8gDeYoUAO9dd6Ca9aNcLJhSswtGT6dTdFWRHHqjlEtIR
         2vgSKmoqFWNzXsPphuBJvh/wUtqpJZdSIOmaQe6Kp8AobePCg9iSSenEfdQcf5GQU720
         FzlX0tvi3xhVgRm3UmLmmFdMtXN/9lsHFcYgrF5J8FBHl9CdLXP1uNBkQn+St8rTfFNu
         bUSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=zRaeRpssHGEJ3ZNYUu1/i94m3jkTrPpKQv9e/J9Wae4=;
        b=zfMW/LR0iaJ85N+mFjJLjMYzw4BbVqjEELjEv9lJnPFb4/oSb93tUOhVTfcUDRMjw9
         ftMSexd+i5evpfhZG4X+w3sI1TPKu0RvJetzwPMHXZOKgHZ1m03uC/l0eNi64t1QcFGF
         8k+DhaZU5K0amMi7DxhXUB3B2QAtROPMR9d2rxhWRtBSRc04dsVVI7HE8n2HQjibF+zd
         /A/l+PF385kgqoK5CX1R5BtU2niJ1XqG/+ibnKNu8VT9PufDk65jU+L57uNPfAvtF0m7
         KsO1UCdLrkC9vewe4QS8McXhzc1vfPGJmuv9Qj4k3+sHE1EsEYznDOLfjaYYp0vU4IwR
         OizQ==
X-Gm-Message-State: AJIora/LFIfpVV/sH9VQzsB3bxYh174L8XrW5LJAXNoc/vJNT8GUcXvk
	RiGgjdxE2aw8bROh9rjCvwQ+QBw6iG0iFSS2
X-Google-Smtp-Source: 
 AGRyM1tIi/ZVzuaoA7Njfx1AsslZ/TNwHIvwx7U8EKs1w8FcmyLPzNj8IAN8P35VcldF6R6hF0CJAA==
X-Received: by 2002:a17:903:11c5:b0:16c:ece7:f687 with SMTP id
 q5-20020a17090311c500b0016cece7f687mr17146286plh.165.1658849349217;
        Tue, 26 Jul 2022 08:29:09 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 b17-20020a170903229100b0016bef6f6903sm11960641plh.72.2022.07.26.08.29.08
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 08:29:08 -0700 (PDT)
Message-ID: <62e00844.1c69fb81.4eee9.2ac4@mx.google.com>
Date: Tue, 26 Jul 2022 08:29:08 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.4-st5-586-geb97410e0086c
Subject: cip-gitlab/ci/pavel/linux-test baseline-cip-nfs: 3 runs,
 2 regressions (v4.4-st5-586-geb97410e0086c)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 26 Jul 2022 15:29:14 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8940

cip-gitlab/ci/pavel/linux-test baseline-cip-nfs: 3 runs, 2 regressions (v4.=
4-st5-586-geb97410e0086c)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig           | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.4-st5-586-geb97410e0086c/plan/baseline-cip-nfs/

  Test:     baseline-cip-nfs
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.4-st5-586-geb97410e0086c
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      eb97410e0086c865c804bdc822e061764810486c =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/62e000f6e5c4dfcffbdaf06e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-586-geb97410e0086c/arm/multi_v7_defconfig/gcc-10/lab-broonie/base=
line-cip-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-586-geb97410e0086c/arm/multi_v7_defconfig/gcc-10/lab-broonie/base=
line-cip-nfs-beaglebone-black.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20211105/qemu=
-arm/cip-core-image-kernelci-cip-core-buster-qemu-arm-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/62e000f6e5c4d=
fcffbdaf06f
        failing since 76 days (last pass: v5.10.109-cip5-384-g722204542e8a,=
 first fail: v4.4-st5-260-gb0fe64f485ff) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62e0021fe51f9c8e34daf05b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-586-geb97410e0086c/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/baseline-cip-nfs-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-586-geb97410e0086c/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/baseline-cip-nfs-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20211105/qemu=
-amd64/cip-core-image-kernelci-cip-core-buster-qemu-amd64-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/62e0021fe51f9=
c8e34daf05c
        new failure (last pass: v5.10.129-cip12-36-g21d9d56f4de5a) =

 =20

