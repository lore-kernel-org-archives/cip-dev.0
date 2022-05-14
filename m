X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
 by mx.groups.io with SMTP id smtpd.web09.3823.1652514670699580511
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sat, 14 May 2022 00:51:10 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=HS3+JSaz;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.41, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f41.google.com with SMTP id cq17-20020a17090af99100b001dc0386cd8fso9740870pjb.5
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Sat, 14 May 2022 00:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=UfkBrsVmWNpgw+JgMX75Ro3yJriK8+rNZho02E4wkLA=;
        b=HS3+JSazvRlCTsJ4FffWfhW+B7ktLM60gQRHj0ClZrZGrw8biTkeGFzYWkaOsKtoqE
         vmLqEfSvTg88YbEPlbEm78KCAZW366PxTRMVlXhyYJI3dRzxmpEXBvM0qojXPQSRnOr7
         +dEoWX8+AYpcmwtCZX2T+vxw5L92+sNAuHVWoyEomMw5WaHLxOcrsNtFVGa/0e4NRG/Q
         uvh+GoAl+f2vm9Oc4HiAZ8fKBuDBsxsVT1yKA8K8zMTbiZS+18JNTB9LqO3STwLym+mK
         ZbGtZLd2nAV1P37jYYCK9nNyIvWeFWXeLxEpCGcQ0Puab7Bpca2ziHWiMCkfRsAmk/An
         U9XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=UfkBrsVmWNpgw+JgMX75Ro3yJriK8+rNZho02E4wkLA=;
        b=IG8UYwa138J7Ycc/ndrVmryOuSBaOz6/W0ObQAjzcpE1tYZSG4gGmLTz3ZvxoPeUC7
         BZGmFbvU/2svIttzO/CS/AwAU1HKtWCBPRgPmtWmJvOM8f8dwjxH4OSKoa3a3IIjx9yn
         f5536NILYhVv1DkzvV2PECbhbFC2y0TsebDEkD+wIVgEoOabi7jL30SG96tSBLZEbWWK
         EQ9Zy2AD3P0qoaSjLjhDsmdC2feoB5ZUrBH+MT7ayx113f2MUSSEuWcJZDdPOovPjoFQ
         7DzXgqv0IHXpUYC+E9bsZzSLQuswu4CcpqZuHvH2zPJXxOrHvDKjUkJNc9VzxqI5I3LU
         1+rQ==
X-Gm-Message-State: AOAM533VzkPROwtdPLxlOqyoDGADDZVUmBE52uSs77dV+pgHSt+AJ8KS
	RcUQXPU/3BjhnWUh0Z8i+x6fHgDqlvzTQdHo/f4=
X-Google-Smtp-Source: ABdhPJwQZvwnU38roGGXv0G3a3Tx+iE2mgHb2UJr2VHEDrca859RLx7sNABAbOKDUGrFS4VZEuvNpw==
X-Received: by 2002:a17:903:41cb:b0:15e:b1f4:352f with SMTP id u11-20020a17090341cb00b0015eb1f4352fmr8072388ple.56.1652514669927;
        Sat, 14 May 2022 00:51:09 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id l9-20020a17090aaa8900b001dd11e4b927sm4704272pjq.39.2022.05.14.00.51.08
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 May 2022 00:51:08 -0700 (PDT)
Message-ID: <627f5f6c.1c69fb81.b184f.c0e0@mx.google.com>
Date: Sat, 14 May 2022 00:51:08 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Kernel: v4.4.302-cip69-50-gba851b77071ca
Subject: cip-gitlab/ci/pavel/linux-test kselftest-filesystems: 5 runs, 4 regressions (v4.4.302-cip69-50-gba851b77071ca) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip-gitlab/ci/pavel/linux-test kselftest-filesystems: 5 runs, 4 regressions=
 (v4.4.302-cip69-50-gba851b77071ca)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C436FA-Flip-hatch    | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

hp-x360-12b-n4000-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.4.302-cip69-50-gba851b77071ca/plan/kselftest-filesystems/

  Test:     kselftest-filesystems
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.4.302-cip69-50-gba851b77071ca
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      ba851b77071ca2f6d6a35b5758aa276c8af6306d =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C436FA-Flip-hatch    | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/627f514fa3fcf719358f571a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip69-50-gba851b77071ca/x86_64/x86_64_defconfig+x86-chromebook/gc=
c-10/lab-collabora/kselftest-filesystems-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip69-50-gba851b77071ca/x86_64/x86_64_defconfig+x86-chromebook/gc=
c-10/lab-collabora/kselftest-filesystems-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220506.0/amd64/initrd.cpio.gz =



  * kselftest-filesystems.login: https://kernelci.org/test/case/id/627f514f=
a3fcf719358f571b
        failing since 2 days (last pass: v5.10.109-cip5-384-g722204542e8a, =
first fail: v4.4-st5-23-gf7cf04ab668f1) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/627f50ba4ff8d74f668f574a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip69-50-gba851b77071ca/x86_64/x86_64_defconfig+x86-chromebook/gc=
c-10/lab-collabora/kselftest-filesystems-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip69-50-gba851b77071ca/x86_64/x86_64_defconfig+x86-chromebook/gc=
c-10/lab-collabora/kselftest-filesystems-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220506.0/amd64/initrd.cpio.gz =



  * kselftest-filesystems.login: https://kernelci.org/test/case/id/627f50ba=
4ff8d74f668f574b
        failing since 2 days (last pass: v5.10.109-cip5-384-g722204542e8a, =
first fail: v4.4-st5-23-gf7cf04ab668f1) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/627f50b54ff8d74f668f5740

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip69-50-gba851b77071ca/x86_64/x86_64_defconfig+x86-chromebook/gc=
c-10/lab-collabora/kselftest-filesystems-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip69-50-gba851b77071ca/x86_64/x86_64_defconfig+x86-chromebook/gc=
c-10/lab-collabora/kselftest-filesystems-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220506.0/amd64/initrd.cpio.gz =



  * kselftest-filesystems.login: https://kernelci.org/test/case/id/627f50b5=
4ff8d74f668f5741
        failing since 2 days (last pass: v5.10.109-cip5-384-g722204542e8a, =
first fail: v4.4-st5-23-gf7cf04ab668f1) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-x360-12b-n4000-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/627f546f21c4a729f48f572c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip69-50-gba851b77071ca/x86_64/x86_64_defconfig+x86-chromebook/gc=
c-10/lab-collabora/kselftest-filesystems-hp-x360-12b-n4000-octopus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip69-50-gba851b77071ca/x86_64/x86_64_defconfig+x86-chromebook/gc=
c-10/lab-collabora/kselftest-filesystems-hp-x360-12b-n4000-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220506.0/amd64/initrd.cpio.gz =



  * kselftest-filesystems.login: https://kernelci.org/test/case/id/627f546f=
21c4a729f48f572d
        failing since 2 days (last pass: v5.10.109-cip5-384-g722204542e8a, =
first fail: v4.4-st5-23-gf7cf04ab668f1) =

 =20

