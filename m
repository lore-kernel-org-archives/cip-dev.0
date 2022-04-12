X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
 by mx.groups.io with SMTP id smtpd.web11.5563.1649726080055334979
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 11 Apr 2022 18:14:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=cu/vQrbj;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.170, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f170.google.com with SMTP id q3so4133778plg.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 11 Apr 2022 18:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=pi2RFzZ8PGNiehlLnzeA6BCqohkN1OuEYX3TfALciJc=;
        b=cu/vQrbja/SyBGyeXvy8wOT4WaEeq/cWGQXkFbGt+FhPxinof22UDqs161oL+IIgql
         nQxjcsM04f2PTa9UNyCJIhOkRriQkLID/ZNjU2DyvONRDcwCcF2Z17wDYX6ETDuYympI
         zWgJK1wLVk3lxq972/U38WbN/D752KNEwSHY+RXJVOyj/P6npkttlb1ZyhkOzU+A7erR
         A8+szjO5vbyjiT4gWid3lvtlwm6ciHVmEFgfgbLH4NK6h2xmR4fPsAZbNYyVfpQp3PbB
         YJCauY8MmiUv0gdDjHt98Mr1RVGZiIvyu544W3OQvyd6m7/9/iUTkmMNqCyYjtHY2m+n
         UuCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=pi2RFzZ8PGNiehlLnzeA6BCqohkN1OuEYX3TfALciJc=;
        b=yWSr/oPU13xQOmV8TCWZ5pn/cgRe9AOO3Od6vUkvoZOYhNmsirZpeR02dpgkn0EOT1
         3BDRi1/5kWjaaFO9RsrB+b2HqhJy+d4CiT72WvrF6Q+zZ8NSPyFFSVysJcnRjKS0W8rv
         UEtO2ue2T7XswxBQZAb5NRDS1SvbH+EacRHdPApJmZDpSgiTXztwXGMYc7daXTytg9FB
         plaJK2qeOl5acIC2AqzkA2PPaoIoPLcunqPL+Pb3i4x6Y8nl2y55vfZfiEe+cCyqR7Q0
         VT+sM9ykrXXpU9/dMt8XFyfUTTGb00IwDuozDBg3QoGEk76qP1GvyWOG/T6if/dWwz8y
         Xlew==
X-Gm-Message-State: AOAM530Tq8EUKVHyB8liO4JPGMp2oeJPGfRfhry3YZ8HgSKai04sWxI/
	2rWylrnrLNLD9VtUeUNvwMSZ113Wgksm2LMu
X-Google-Smtp-Source: ABdhPJyNjH0jgoYEUZR9J2OWFWzf/rb0o1FexS9wS2Qoty14XJT2nsdsS605T5I7pC9NzP72INUMWA==
X-Received: by 2002:a17:902:aa85:b0:155:ceb9:3710 with SMTP id d5-20020a170902aa8500b00155ceb93710mr985990plr.59.1649726079230;
        Mon, 11 Apr 2022 18:14:39 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id m15-20020a638c0f000000b003827bfe1f5csm849073pgd.7.2022.04.11.18.14.37
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 18:14:38 -0700 (PDT)
Message-ID: <6254d27e.1c69fb81.b5e13.30b6@mx.google.com>
Date: Mon, 11 Apr 2022 18:14:38 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Kernel: v4.4-st5-2498-g49524d978f8eb
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test smc: 8 runs, 2 regressions (v4.4-st5-2498-g49524d978f8eb) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip-gitlab/ci/pavel/linux-test smc: 8 runs, 2 regressions (v4.4-st5-2498-g4=
9524d978f8eb)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-x360-12b-n4000-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

qemu_arm-virt-gicv3       | arm    | lab-broonie   | gcc-10   | multi_v7_de=
fconfig           | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.4-st5-2498-g49524d978f8eb/plan/smc/

  Test:     smc
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.4-st5-2498-g49524d978f8eb
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      49524d978f8eb9de24ce93fcca8d5a39522876c3 =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-x360-12b-n4000-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6254c5b1a881238b11ae06c6

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-2498-g49524d978f8eb/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/smc-hp-x360-12b-n4000-octopus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-2498-g49524d978f8eb/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/smc-hp-x360-12b-n4000-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220401.0/x86/rootfs.cpio.gz =



  * smc.login: https://kernelci.org/test/case/id/6254c5b1a881238b11ae06c7
        new failure (last pass: v5.10.106-cip4-69-g05f5682c2c593) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
qemu_arm-virt-gicv3       | arm    | lab-broonie   | gcc-10   | multi_v7_de=
fconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6254c9e6232911d971ae06de

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-2498-g49524d978f8eb/arm/multi_v7_defconfig/gcc-10/lab-broonie/smc=
-qemu_arm-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-2498-g49524d978f8eb/arm/multi_v7_defconfig/gcc-10/lab-broonie/smc=
-qemu_arm-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220401.0/armel/rootfs.cpio.gz =



  * smc.login: https://kernelci.org/test/case/id/6254c9e6232911d971ae06df
        new failure (last pass: v5.10.106-cip4-69-g05f5682c2c593) =

 =20

