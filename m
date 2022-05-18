X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
 by mx.groups.io with SMTP id smtpd.web10.1766.1652855032656183381
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 17 May 2022 23:23:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=PdlDQ7Q8;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.172, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f172.google.com with SMTP id d22so850907plr.9
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 17 May 2022 23:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=cCf0z1q/pGUZWmo9mI2SAmE6vwZYvhSSg46vQjzfQmw=;
        b=PdlDQ7Q8tkUKdbVRcoZcFTGd9WzBdI30FK4fLVM3JloEpMi7V45Df6GWfbvBidWF7z
         sDSAvwcZzNUxUk9tQJNB6edXb76afHyEXCnVot7Czu3RCS7U35Hpfbpx1mwAjRQr5Xgb
         lRcgZ5j5QLH+L7aWmglVF1dBe5jIVK/5uyQH8F//j1JVvnOIuXXPwobtkBYTaaG9o/LZ
         Z7gl80x18W/K6gNJ1Mj/IRrCFKMS7MM7G79MMA3nGNl0ABO4liCslGzwe4bIIQUok+Fm
         2Feo1P/VYMJ/fkYC4mpWovD6acXK3Ydp1nFN331TjKhEJ/txf5pTbaAB1OYFDNkAgzzx
         ycPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=cCf0z1q/pGUZWmo9mI2SAmE6vwZYvhSSg46vQjzfQmw=;
        b=JWqTydZDbAqESENFZV/BVTmUtIxcrfJLIIFXYMKfjFvKPJ6nWh291cQoDULWJK3z6U
         3QwftobFtrI2EXftgBpqBsQu+QJ1N9jOYwbEKNtFlbbeH1k+rcd/jqTiGb06xts2KteY
         uitiTxRq8hvQOB0yTU8kdFTG23iOLf4KQHff0vV+g5UgNsgnK7udhUJtlkmnlL/yb1gL
         PxtbTmdp6IdM+Wr0xky4MR20b3KJn33WjnAoMq77xPs8QrRpZWBhO+p3qmo3sKYJKvU9
         kxd935CHEpqVW4uVxPkY/vrMo7HvMQEK7XtoUYVTciHEsZFLPh5CAwmUj4qnPHW4LCJ2
         3Jog==
X-Gm-Message-State: AOAM531ExztJzZY7f7ZXf825edT97pMqben5Tb1teJpGRlIAvPhjbkW6
	2bQk4wVwPQ6971bUY+/scC2bW1W+6WewbrgGQwM=
X-Google-Smtp-Source: ABdhPJy+dz/h//8zgyAD4/LmrvZr9dWyOhSEAzjVbqIu0Qp/cLcCTPaZlts+EfCHXisiv/oF8y3pPg==
X-Received: by 2002:a17:90a:a096:b0:1df:58d7:5b20 with SMTP id r22-20020a17090aa09600b001df58d75b20mr14196807pjp.212.1652855032002;
        Tue, 17 May 2022 23:23:52 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id l6-20020a654c46000000b003f5e0c264bcsm658708pgr.66.2022.05.17.23.23.51
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 23:23:51 -0700 (PDT)
Message-ID: <628490f7.1c69fb81.2835.1e04@mx.google.com>
Date: Tue, 17 May 2022 23:23:51 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.4.302-cip69-296-g52de9431d314
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/pavel/linux-test ltp-ipc: 7 runs, 4 regressions (v4.4.302-cip69-296-g52de9431d314) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip-gitlab/ci/pavel/linux-test ltp-ipc: 7 runs, 4 regressions (v4.4.302-cip=
69-296-g52de9431d314)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C436FA-Flip-hatch    | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

asus-cx9400-volteer       | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

hp-x360-12b-n4000-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.4.302-cip69-296-g52de9431d314/plan/ltp-ipc/

  Test:     ltp-ipc
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.4.302-cip69-296-g52de9431d314
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      52de9431d314a28c4aa66d8f81144c9958c11168

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  17e9ae697a340242c49188ace12a60cd3bc95a53 =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C436FA-Flip-hatch    | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62841ca59e03d25ecba39bcd

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip69-296-g52de9431d314/x86_64/x86_64_defconfig+x86-chromebook/gc=
c-10/lab-collabora/ltp-ipc-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip69-296-g52de9431d314/x86_64/x86_64_defconfig+x86-chromebook/gc=
c-10/lab-collabora/ltp-ipc-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220513.0/amd64/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/62841ca59e03d25ecba39b=
ce
        failing since 6 days (last pass: v5.10.109-cip5-384-g722204542e8a, =
first fail: v4.4-st5-23-gf7cf04ab668f1) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-cx9400-volteer       | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6284185fa5a4076500a39bd7

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip69-296-g52de9431d314/x86_64/x86_64_defconfig+x86-chromebook/gc=
c-10/lab-collabora/ltp-ipc-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip69-296-g52de9431d314/x86_64/x86_64_defconfig+x86-chromebook/gc=
c-10/lab-collabora/ltp-ipc-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220513.0/amd64/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/6284185fa5a4076500a39b=
d8
        failing since 6 days (last pass: v5.10.109-cip5-384-g722204542e8a, =
first fail: v4.4-st5-23-gf7cf04ab668f1) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62841d6a0637d20df4a39bdf

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip69-296-g52de9431d314/x86_64/x86_64_defconfig+x86-chromebook/gc=
c-10/lab-collabora/ltp-ipc-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip69-296-g52de9431d314/x86_64/x86_64_defconfig+x86-chromebook/gc=
c-10/lab-collabora/ltp-ipc-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220513.0/amd64/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/62841d6a0637d20df4a39b=
e0
        failing since 6 days (last pass: v5.10.109-cip5-384-g722204542e8a, =
first fail: v4.4-st5-23-gf7cf04ab668f1) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-x360-12b-n4000-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/628418769500f90762a39c02

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip69-296-g52de9431d314/x86_64/x86_64_defconfig+x86-chromebook/gc=
c-10/lab-collabora/ltp-ipc-hp-x360-12b-n4000-octopus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip69-296-g52de9431d314/x86_64/x86_64_defconfig+x86-chromebook/gc=
c-10/lab-collabora/ltp-ipc-hp-x360-12b-n4000-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220513.0/amd64/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/628418769500f90762a39c=
03
        failing since 6 days (last pass: v5.10.109-cip5-384-g722204542e8a, =
first fail: v4.4-st5-23-gf7cf04ab668f1) =

 =20

