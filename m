Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2650CC38159
	for <webhook@archiver.kernel.org>; Thu, 19 Jan 2023 00:28:57 +0000 (UTC)
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
 by mx.groups.io with SMTP id smtpd.web10.33963.1674088128557899818
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 18 Jan 2023 16:28:48 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=OuJq1tWV;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.170, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f170.google.com with SMTP id p24so743594plw.11
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 18 Jan 2023 16:28:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ijesg+9FD8IHdrYZsMIy2CjKpbV4OZEAfMmD4n+2+Nw=;
        b=OuJq1tWVPFw6vR3NXIvNzC3g62LkzvIkGYALjEm6XJfZT2WaVPhX7X9Nga6N96PSWO
         fvPqZX/d9wNNF+sZbR5i4Um1gTZy1IarguIkWzvXS9IY8vrvKLTftk0Tetnd451m3ZFD
         Psxvbugk3J7CHVc3CbF9qt1YHRSye41RR5vbA4uU5oFuODqEYtfdhTM9KW8NTwjDcB0Z
         OaOWBHglRk+HC5J7TNO47EUQJPAYn2Boa0qiCsasO3n12mfRGYoPRagWtv15qjEROfRm
         N9s+J86mYflyPIcgSH3ybq3A7VmFcZPnAH0ER/kKElQVP9LNFp57nC7EiHmPMdQqA9YW
         /uag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ijesg+9FD8IHdrYZsMIy2CjKpbV4OZEAfMmD4n+2+Nw=;
        b=wuFC8R4o51faDSls2Fcau4aEnKS+C7t7QwmUMP+p3DQIdl/OCWVi0hYTrHDz1lZs5k
         THjIvbnq1H4otqTEDN2g1cNdebaVFbzTaP4Op+oEt3hsjTrz5Gu0BQDKYZnh+xS5RXOG
         agjK3fSUTa4UmYz3Q3oV1E8jiHOnMWCyF1gM9kufn+isfgGWmRa/eym56hbvKMoyEjI/
         yTwwDshgKwfpoqSYIgRbrHlHC3jRr0/WsHutayGxmAn47RHMPz+oUv1GRcGl47yVxlSS
         L8PJe4UZcFOD1JLybCSuNJzOr6dLMn+aT1kFZR09axjgpf88smSyoJKk5oubjV0Pzdp/
         /0bA==
X-Gm-Message-State: AFqh2kq6CB78DEBhY33cZ3EcH01sJVkdiywkkVa+WkYnk1Xxja1oT2pH
	bdpxFD/JeHDxypps5pxV6rzv3VWRamkF0OxzxEHStA==
X-Google-Smtp-Source: AMrXdXtdlIBMahquItA3c1wC/8Qj4vpbzVx7wnYTycDKqskRovpCXU1KTRS5YGJNu+AklLBw4xgspg==
X-Received: by 2002:a17:90b:1206:b0:229:188a:c0e7 with SMTP id gl6-20020a17090b120600b00229188ac0e7mr8843718pjb.49.1674088127839;
        Wed, 18 Jan 2023 16:28:47 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id p13-20020a17090a348d00b0021900ba8eeesm1885811pjb.2.2023.01.18.16.28.47
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 16:28:47 -0800 (PST)
Message-ID: <63c88ebf.170a0220.258d5.381f@mx.google.com>
Date: Wed, 18 Jan 2023 16:28:47 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Kernel: v4.19.269-rt119-858-g4aae57dbf650
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test ltp-ipc: 7 runs,
 2 regressions (v4.19.269-rt119-858-g4aae57dbf650)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 19 Jan 2023 00:28:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10418

cip-gitlab/ci/pavel/linux-test ltp-ipc: 7 runs, 2 regressions (v4.19.269-rt=
119-858-g4aae57dbf650)

Regressions Summary
-------------------

platform               | arch   | lab           | compiler | defconfig     =
               | regressions
-----------------------+--------+---------------+----------+---------------=
---------------+------------
asus-C436FA-Flip-hatch | x86_64 | lab-collabora | gcc-10   | x86_64_defcon.=
..6-chromebook | 1          =

asus-cx9400-volteer    | x86_64 | lab-collabora | gcc-10   | x86_64_defcon.=
..6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.19.269-rt119-858-g4aae57dbf650/plan/ltp-ipc/

  Test:     ltp-ipc
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.19.269-rt119-858-g4aae57dbf650
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      4aae57dbf650bb88d187f251ebdbd3984020b619

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  cf59c1fb5f7181453b16171d75654ee9a1216dde =



Test Regressions
---------------- =



platform               | arch   | lab           | compiler | defconfig     =
               | regressions
-----------------------+--------+---------------+----------+---------------=
---------------+------------
asus-C436FA-Flip-hatch | x86_64 | lab-collabora | gcc-10   | x86_64_defcon.=
..6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63c87a8f943618118a915ebf

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-858-g4aae57dbf650/x86_64/x86_64_defconfig+x86-chromebook/g=
cc-10/lab-collabora/ltp-ipc-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-858-g4aae57dbf650/x86_64/x86_64_defconfig+x86-chromebook/g=
cc-10/lab-collabora/ltp-ipc-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230114.0/amd64/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/63c87a8f943618118a915e=
c0
        failing since 0 day (last pass: v5.10.158-cip22-435-g2c52868ae1cbc,=
 first fail: v4.19.269-rt119-1495-gc851fb1e222f) =

 =



platform               | arch   | lab           | compiler | defconfig     =
               | regressions
-----------------------+--------+---------------+----------+---------------=
---------------+------------
asus-cx9400-volteer    | x86_64 | lab-collabora | gcc-10   | x86_64_defcon.=
..6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63c87a91ce49e1718f915edb

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-858-g4aae57dbf650/x86_64/x86_64_defconfig+x86-chromebook/g=
cc-10/lab-collabora/ltp-ipc-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-858-g4aae57dbf650/x86_64/x86_64_defconfig+x86-chromebook/g=
cc-10/lab-collabora/ltp-ipc-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230114.0/amd64/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/63c87a91ce49e1718f915e=
dc
        failing since 0 day (last pass: v5.10.158-cip22-435-g2c52868ae1cbc,=
 first fail: v4.19.269-rt119-1495-gc851fb1e222f) =

 =20

