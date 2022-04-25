X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
 by mx.groups.io with SMTP id smtpd.web12.33291.1650909206597873203
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 25 Apr 2022 10:53:26 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=0YmOBprq;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.169, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f169.google.com with SMTP id 15so5652047pgf.4
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 25 Apr 2022 10:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=90KQMUdlDF6ovYgPChJ4SkFnDYnsb1sWoYa0Z3mwMqg=;
        b=0YmOBprqoBZrzqoqsKJUjPVWE/4tJvREkXgaR1Yqpvfz3gQ7Pyd4tsje4vpU95Zngt
         m0lCUVqTR8Ey+U2b+14Nz0is3/9rHB2fe8YzHWEhmrtDBB5hQh520iEBSa1QrbYkokI5
         OX5pD/UB5ttmBA6YMnxpUILttn8ItJXEN3nlWtxoq/bLm24lBBRJCS3F2uSV2ctjeXWu
         29GWTxduQbj2Gyq9ppmmfJXgUCwANi8l9KX9Nf8TatexbpMcZz9iDFNsea/1ENknmcsS
         u9wD3QAaN8c2pKWpcwMaRPIMYgkUTuHZI3yjp5f/3WLbt62VL2r4AG3YS1boFkEcWQKG
         Dipg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=90KQMUdlDF6ovYgPChJ4SkFnDYnsb1sWoYa0Z3mwMqg=;
        b=KgN9F2VNR70CU86ZkP+5y97+jR81/00ReGj62NQjWEm5aeKakdo8rhMSEDaxXqT1Tt
         aas2bkk8FSZPRTBQXVJsKAxKKOj/pKg2ApixgG96kcVpoaIesykfcJzkU/dtngVXoYuP
         K1eZiVQfVwuI2A+5H/Q2GJe9pNs53u+raOGKjUH5N5B7i2BoG0uJ+O0hgk8ytl7Ym7SD
         VChUPyKXxNK36yPi768ar7FTdNoelxfKy587oms2sVu4JKEIkYIIZgB+eSD9GuQsyaE7
         mmm/HhHYz8vu2gYuIhtd3diWgJ34umCPynkWMDuWaCHTacbuvibZDlpKx6i34dYLOUPv
         OC/w==
X-Gm-Message-State: AOAM533L+GYwV1id2py4gfKk/RS9ZmdWsyDwpt2GGb4QY2Npxstj7l+a
	mJ6KWf4eHUIEzaQZmYbaqMS2qfOiKzBOp1PaRW8=
X-Google-Smtp-Source: ABdhPJy7hduk/T7ceZbd2/FDX+G1NI/2j4FxgVVXOMmfJtGiTuUvivJaFzIZmxSNytLhJRvZfpopkQ==
X-Received: by 2002:a62:a50a:0:b0:506:cef:44f5 with SMTP id v10-20020a62a50a000000b005060cef44f5mr20006957pfm.22.1650909205844;
        Mon, 25 Apr 2022 10:53:25 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id h127-20020a628385000000b0050d26859380sm7972998pfe.107.2022.04.25.10.53.25
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 10:53:25 -0700 (PDT)
Message-ID: <6266e015.1c69fb81.2cac2.1b36@mx.google.com>
Date: Mon, 25 Apr 2022 10:53:25 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Kernel: v5.10.109-cip5-899-g234e7e7d5bd3
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-seccomp: 2 runs, 1 regressions (v5.10.109-cip5-899-g234e7e7d5bd3) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-seccomp: 2 runs, 1 reg=
ressions (v5.10.109-cip5-899-g234e7e7d5bd3)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...ok+kselftest | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.109-cip5-899-g234e7e7d5bd3/plan/kselftest=
-seccomp/

  Test:     kselftest-seccomp
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.109-cip5-899-g234e7e7d5bd3
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      234e7e7d5bd36004288823dfb36ce5e3d2f6e940 =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/6266d1db585adcb797ff94db

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.109-cip5-899-g234e7e7d5bd3/x86_64/x86_64_defconfig+x86-c=
hromebook+kselftest/gcc-10/lab-collabora/kselftest-seccomp-asus-C433TA-AJ00=
05-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.109-cip5-899-g234e7e7d5bd3/x86_64/x86_64_defconfig+x86-c=
hromebook+kselftest/gcc-10/lab-collabora/kselftest-seccomp-asus-C433TA-AJ00=
05-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220422.0/amd64/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/6266d1db585a=
dcb797ff94dc
        new failure (last pass: v5.10.109-cip5-24-g4e205e4287c50) =

 =20

