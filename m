X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
 by mx.groups.io with SMTP id smtpd.web08.6462.1647928100045324416
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 21 Mar 2022 22:48:20 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=ruAeShyI;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.173, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f173.google.com with SMTP id w4so14544578ply.13
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 21 Mar 2022 22:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=8wL+rA2Vy4BMVUrxjxq2OieLBhMEdvRqiP022PWbojU=;
        b=ruAeShyI549DLepoltYOeiEXtnCvCHUzOaJnnDnbSc2FMyLr/eajpES16lHa4cLSmE
         pmNtdyQf8r2Hf62t/+HcwogRkH3w77/MPiT2jX3yyBYVVbRUE394urfv8Uh+7yi3T4wv
         nlRBeSzTJ+ll+um2gwZdTeIxcAzTZvCTE+obJzU1w5Y8ke8UwcmXbAJGl8eOGXip4ap9
         tWo1+mvTkULiv0A+Ib6X6ae+GCQcEY398TJiyAHYnUFgsJgPZ02a8AY5JE0sV4FjImw0
         1TSqlH8Q/R8N5fB5G+MgbB7zKzVXnzEvYNNmfrvXg3u1BTLhYjl7CJMgTB5fP8PBf1NG
         pjMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=8wL+rA2Vy4BMVUrxjxq2OieLBhMEdvRqiP022PWbojU=;
        b=ENzYlHS5OTgrvmk1OBRRRfZmG63WvtcL5Yj31WuG+KGZDfhPYmez2Bc+c8JrYoG/bO
         zg9haupX8Ls9GayLh2w5J9o84Vpj3z0MGAeillCGZXX3x7NNv2U8ML3agM6zaQPrmgDU
         zhV3VVDB90Lyssrr5AEFHEYpYvfrEtVxZPj1CxW6X5LKHaDf8RoAaaQ+v325G/gbX9ru
         9+E8KbBfI7IIoRKdBcZiCugnHUSe69wVTejhcvmTPK7Lvd3SVkLZ6geE+wBfErHrB2VR
         krF4dWjqWFJWNoV6Slc5yU7yqjBcO/yEPpW8gCBj9xto5ugmPDOfg6j0/P+XPse9mCpk
         JvtQ==
X-Gm-Message-State: AOAM530YDjlhgra6ousYzgRzqP7wifTIz2hXe0Nvd9FJt9pUCXXIl0Nz
	zHlCUGnZxcg5jUkZJTPk4Fm5Q0J0b1z/Jj6gecY=
X-Google-Smtp-Source: ABdhPJx2HOdbxEJvMTsfO4VgQeR6oFY3t6ceKsOjL0WDnz5ZyH2bwq9dWY1erUqSsZ/k0n4WXjPL0A==
X-Received: by 2002:a17:902:6ac7:b0:150:24d6:b2ee with SMTP id i7-20020a1709026ac700b0015024d6b2eemr16566139plt.168.1647928099339;
        Mon, 21 Mar 2022 22:48:19 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id i7-20020a628707000000b004fa6eb33b02sm13666051pfe.49.2022.03.21.22.48.18
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 22:48:19 -0700 (PDT)
Message-ID: <62396323.1c69fb81.3c09e.628d@mx.google.com>
Date: Mon, 21 Mar 2022 22:48:19 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.104-cip3-155-g4f07dbd2df49e
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-seccomp: 6 runs, 3 regressions (v5.10.104-cip3-155-g4f07dbd2df49e) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-seccomp: 6 runs, 3 reg=
ressions (v5.10.104-cip3-155-g4f07dbd2df49e)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...ok+kselftest | 1          =

asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...ok+kselftest | 1          =

hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...ok+kselftest | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.104-cip3-155-g4f07dbd2df49e/plan/kselftes=
t-seccomp/

  Test:     kselftest-seccomp
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.104-cip3-155-g4f07dbd2df49e
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      4f07dbd2df49ee61f77347287ba5837888067f02 =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/62394f7e018c303708217342

  Results:     83 PASS, 4 FAIL, 7 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.104-cip3-155-g4f07dbd2df49e/x86_64/x86_64_defconfig+x86-=
chromebook+kselftest/gcc-10/lab-collabora/kselftest-seccomp-asus-C433TA-AJ0=
005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.104-cip3-155-g4f07dbd2df49e/x86_64/x86_64_defconfig+x86-=
chromebook+kselftest/gcc-10/lab-collabora/kselftest-seccomp-asus-C433TA-AJ0=
005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220311.1/amd64/initrd.cpio.gz =



  * kselftest-seccomp.seccomp_seccomp_bpf_TSYNC_siblings_fail_prctl: https:=
//kernelci.org/test/case/id/62394f7e018c303708217349
        failing since 18 days (last pass: v5.10.83-cip1-1540-g9fb82e7fedf9,=
 first fail: v5.10.100-cip2-319-gcbff87047566) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/62395075a278e0bada2172d3

  Results:     83 PASS, 4 FAIL, 7 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.104-cip3-155-g4f07dbd2df49e/x86_64/x86_64_defconfig+x86-=
chromebook+kselftest/gcc-10/lab-collabora/kselftest-seccomp-asus-C523NA-A20=
057-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.104-cip3-155-g4f07dbd2df49e/x86_64/x86_64_defconfig+x86-=
chromebook+kselftest/gcc-10/lab-collabora/kselftest-seccomp-asus-C523NA-A20=
057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220311.1/amd64/initrd.cpio.gz =



  * kselftest-seccomp.seccomp_seccomp_bpf_TSYNC_siblings_fail_prctl: https:=
//kernelci.org/test/case/id/62395075a278e0bada2172d7
        failing since 18 days (last pass: v5.10.83-cip1-1540-g9fb82e7fedf9,=
 first fail: v5.10.100-cip2-319-gcbff87047566) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/62394f7c018c3037082172e2

  Results:     83 PASS, 4 FAIL, 7 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.104-cip3-155-g4f07dbd2df49e/x86_64/x86_64_defconfig+x86-=
chromebook+kselftest/gcc-10/lab-collabora/kselftest-seccomp-hp-11A-G6-EE-gr=
unt.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.104-cip3-155-g4f07dbd2df49e/x86_64/x86_64_defconfig+x86-=
chromebook+kselftest/gcc-10/lab-collabora/kselftest-seccomp-hp-11A-G6-EE-gr=
unt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220311.1/amd64/initrd.cpio.gz =



  * kselftest-seccomp.seccomp_seccomp_bpf_TSYNC_siblings_fail_prctl: https:=
//kernelci.org/test/case/id/62394f7c018c3037082172e8
        failing since 18 days (last pass: v5.10.83-cip1-1540-g9fb82e7fedf9,=
 first fail: v5.10.100-cip2-319-gcbff87047566) =

 =20

