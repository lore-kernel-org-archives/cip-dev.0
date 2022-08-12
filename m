Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A2DEC19F2D
	for <webhook@archiver.kernel.org>; Fri, 12 Aug 2022 15:04:29 +0000 (UTC)
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com
 [209.85.216.44])
 by mx.groups.io with SMTP id smtpd.web11.255.1660316661476430950
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 12 Aug 2022 08:04:21 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=Dlb9IUuD;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.44,
 mailfrom: bot@kernelci.org)
Received: by mail-pj1-f44.google.com with SMTP id
 q9-20020a17090a2dc900b001f58bcaca95so8588874pjm.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 12 Aug 2022 08:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc;
        bh=4Qkx19tljD5tpKJ5rsqvyPe0SkzAJCdhqYW5Mv/ziGs=;
        b=Dlb9IUuDEKTb4h/bwVSpYjR1JV0zKk89c18r59E5WuiqKVEhCVdMkY0hYemVkW+5wJ
         wCo5Da9z27lMybmt0NuCOYBKWLkWqDtGilY65b+C3BignC8daSrkfIS69km+eRC3NB1k
         FJ0gkKBUPtUkf9Vqu3E5KxqFdks/2VGCbnhlcQTErcvDqrVCMy1aIntYEzAv7H8f1iBX
         siIpRGVZ1TIDlGN6VxkjS7HD7tmwyx8g6iAEcNYXxPsqPrwKvUXwcBLDZbjT/pBefuaF
         fKaixRe7+xuV9UAkw9i1NHqpG3rH5FfAte2ynMzmctglsYM6N1BH0V3oxLY2L+mvje5y
         dSJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=4Qkx19tljD5tpKJ5rsqvyPe0SkzAJCdhqYW5Mv/ziGs=;
        b=VadKIF2IQVTr8V64yDT1GjdjzckGVXm/raEzfGvfMp+p5bZcel5QtzP0Hzq/84qIdS
         F6PryECeHijUqB7JMDVNCZcpB4Gp/Q96CGl/zNtUjo9Rz8YOFigUZSMmYgDp/r3jJA4j
         LQ146ppOPzgh09eIrQXZOxItKE/r9n4g2fpu93rlQjDtUaNetv8PsBqiDI7Dm4cW8pZS
         6fm5sduD0Q3FZCgXctDGlqdmmY5gKCPzbko1YNxNqA8ammjedEDT3GLeubh5ZG+wSpjQ
         ZOI+Qae2boidRuNeLaD4tFsaBnJ7DZXigKUOPsAXQsGKD8dLBwlrt023v0DOISqfg77X
         DCOA==
X-Gm-Message-State: ACgBeo2BrvHKy6/Tu4Cy4nM7kO4Bt8jt0iyVNom1HtUHtABc1HOwpoq5
	Vzamp630+7ct8Xjr3iUMgtql2opYF0paI0FE
X-Google-Smtp-Source: 
 AA6agR7sKyveKLRJJZA7VPwYLl5xmpkrMPc+6QU21VN9sm7+qxfwUYC+Rxn0t95rMnCWSU/UQZn53A==
X-Received: by 2002:a17:902:d544:b0:170:874f:f6df with SMTP id
 z4-20020a170902d54400b00170874ff6dfmr4496314plf.41.1660316660451;
        Fri, 12 Aug 2022 08:04:20 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 a4-20020a1709027e4400b0016bdf0032b9sm1839159pln.110.2022.08.12.08.04.19
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Aug 2022 08:04:20 -0700 (PDT)
Message-ID: <62f66bf4.170a0220.63f78.3487@mx.google.com>
Date: Fri, 12 Aug 2022 08:04:20 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.131-cip13-35-gab58aa0904675
Subject: cip-gitlab/ci/pavel/linux-test kselftest-filesystems: 13 runs,
 2 regressions (v5.10.131-cip13-35-gab58aa0904675)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 12 Aug 2022 15:04:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9200

cip-gitlab/ci/pavel/linux-test kselftest-filesystems: 13 runs, 2 regression=
s (v5.10.131-cip13-35-gab58aa0904675)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C523NA-A20057-coral     | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

meson-g12b-a311d-khadas-vim3 | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.131-cip13-35-gab58aa0904675/plan/kselftest-filesystem=
s/

  Test:     kselftest-filesystems
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.131-cip13-35-gab58aa0904675
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      ab58aa0904675bdc00cf17ebe4f1b5aba242c1cd =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C523NA-A20057-coral     | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62f65b4d9a2cf9c09cdaf068

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.131-cip13-35-gab58aa0904675/x86_64/x86_64_defconfig+x86-chromebook/g=
cc-10/lab-collabora/kselftest-filesystems-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.131-cip13-35-gab58aa0904675/x86_64/x86_64_defconfig+x86-chromebook/g=
cc-10/lab-collabora/kselftest-filesystems-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220805.0/amd64/initrd.cpio.gz =



  * kselftest-filesystems.login: https://kernelci.org/test/case/id/62f65b4d=
9a2cf9c09cdaf069
        failing since 8 days (last pass: v5.10.131-cip13-24-ga6f4ea41fe167,=
 first fail: v4.4.302-cip70-rt40) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
meson-g12b-a311d-khadas-vim3 | arm64  | lab-baylibre  | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/62f660df1dd74d2f45daf063

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.131-cip13-35-gab58aa0904675/arm64/defconfig/gcc-10/lab-baylibre/ksel=
ftest-filesystems-meson-g12b-a311d-khadas-vim3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.131-cip13-35-gab58aa0904675/arm64/defconfig/gcc-10/lab-baylibre/ksel=
ftest-filesystems-meson-g12b-a311d-khadas-vim3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220805.0/arm64/initrd.cpio.gz =



  * kselftest-filesystems.login: https://kernelci.org/test/case/id/62f660df=
1dd74d2f45daf064
        failing since 8 days (last pass: v5.10.112-cip6, first fail: v5.10.=
131-cip13-24-ga6f4ea41fe167) =

 =20

