X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
 by mx.groups.io with SMTP id smtpd.web10.5590.1648553777342347222
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 29 Mar 2022 04:36:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=zVnOOodV;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.45, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f45.google.com with SMTP id p4-20020a17090ad30400b001c7ca87c05bso1780504pju.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 29 Mar 2022 04:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=MW7905aHtvRGHmQF6YZy3q2KxYUcCKA0ZwLGl+9Q5PU=;
        b=zVnOOodV+tBeysjb6C4JCaD5RR7dcJzBj1k33gC1WFdQe50JbvsVM1Ur8HrZvs9wJc
         LIKuGrU1SFWt72+CKia1ELMBao7lde3zymH7PqpcVwhCYn1dtklUidYMT7NMWuzZAp4g
         3A2zwxLgNwTtW/jDwQUYrWJv6jsbFFBB5s7DXZWD1rV/GuptgCSu7VOUn6AlGxZeviPF
         TSL7lU2MXKf0bJHnu+5cCCbebCB4fgTaQ5xw8d2z65KCovnXLOTWDzbpsI4S1TqkSXq3
         FY8kixKhc2dxMRrPpNnMlxn96lSvgnOYws8hPRBX/s5BqbyFMA6ulBHp7GYahDSunjsG
         byEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=MW7905aHtvRGHmQF6YZy3q2KxYUcCKA0ZwLGl+9Q5PU=;
        b=iYXHEji2EBbEsMkQNuKjq2DSCrQcvYseJlPUi86B0E/VJfsAaZZa6bFj2qSCA7cLtB
         9ncB8TaAFHQpeakcI1j9uTmbuXQ1ZaE0kgJIcuUo02urb9H/8J/lkNJ379Nhq9Ow+n7X
         8y9EaJNzcYeM45ilS6rzUYk+OwOlmCaSbOvtR5qrwIVe2m7gMdqJRhEgTKtBksGHcO0V
         Wq67rwT3+jJtw9s7nTjOkvVuaTarC7oBJbkX083goxHc5R7P7UvBXzZlFf2cWfGpKXjI
         gDXw2EjXIXNu8bHo2/GRJOlH8H3jA8mvpliPx20NOeb/OUUr5l5Shy3UVNvzqHQ9k/15
         ZNqw==
X-Gm-Message-State: AOAM5325S0hKd6Fn2HnJe/J1eLado8ljFcXvYkVU3CU23VW79vPSCdhJ
	4i8G1eW0NF+0/3vtDOjPTCTD6laOJG0VZlZ1O1M=
X-Google-Smtp-Source: ABdhPJzxyBwEZbNSH80SNAsJv5K2NY9WllxRIRQcpyOB08zTTkCvsUYdUCBTz78tdOO9NSllm64TPQ==
X-Received: by 2002:a17:90b:314d:b0:1c7:b159:28b5 with SMTP id ip13-20020a17090b314d00b001c7b15928b5mr4137147pjb.110.1648553776601;
        Tue, 29 Mar 2022 04:36:16 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id cd20-20020a056a00421400b004fa7d1b35b6sm19026297pfb.80.2022.03.29.04.36.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 04:36:16 -0700 (PDT)
Message-ID: <6242ef30.1c69fb81.6db61.1c68@mx.google.com>
Date: Tue, 29 Mar 2022 04:36:16 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Kernel: v5.10.106-cip4
X-Kernelci-Report-Type: test
Subject: cip/linux-5.10.y-cip kselftest-seccomp: 3 runs, 2 regressions (v5.10.106-cip4) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip/linux-5.10.y-cip kselftest-seccomp: 3 runs, 2 regressions (v5.10.106-ci=
p4)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...ok+kselftest | 1          =

hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...ok+kselftest | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.106-cip4/plan/kselftest-seccomp/

  Test:     kselftest-seccomp
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.106-cip4
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      8bb6e30b765989a3c0924158316d689e16317cd1 =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/6242dd0f8ba61d19d5ae06b5

  Results:     83 PASS, 4 FAIL, 8 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.106=
-cip4/x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora=
/kselftest-seccomp-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.106=
-cip4/x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora=
/kselftest-seccomp-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220311.1/amd64/initrd.cpio.gz =



  * kselftest-seccomp.seccomp_seccomp_bpf_TSYNC_siblings_fail_prctl: https:=
//kernelci.org/test/case/id/6242dd0f8ba61d19d5ae06bc
        new failure (last pass: v5.10.100-cip2) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/6242e334ec89aef8b0ae06a2

  Results:     83 PASS, 4 FAIL, 8 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.106=
-cip4/x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora=
/kselftest-seccomp-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.106=
-cip4/x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora=
/kselftest-seccomp-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220311.1/amd64/initrd.cpio.gz =



  * kselftest-seccomp.seccomp_seccomp_bpf_TSYNC_siblings_fail_prctl: https:=
//kernelci.org/test/case/id/6242e334ec89aef8b0ae06a9
        new failure (last pass: v5.10.100-cip2) =

 =20

