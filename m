X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
 by mx.groups.io with SMTP id smtpd.web08.11277.1652275472357047290
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 11 May 2022 06:24:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=RBKCapML;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.169, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f169.google.com with SMTP id x12so1782176pgj.7
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 11 May 2022 06:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=05tOQsNJatxfmrhjjfubiVSpLSkB4P1op/PjYOsjYD4=;
        b=RBKCapMLaLK1FPKV9Pw1o1HOU4mBRONQ/6Vkuymum/e0c1Jf262AfpTpwo55w/jvhE
         Cmze9vDghGLgdVITcAmEqq/xNgaCVAEjzJ13Q4rrrBkPN3qW6CTsW0Y78Dg5D7g+Z1TJ
         N3vyHq5CgIYor8c1UdRWAixi0ie1XNK2mmub4IqqMUzOEFJqZg7Z5Ix1j8Kkr3Arf5cV
         3cQhQHAKPDmbT9bdf+lI3/C9gxexczsI4YnOMihZbjv55B/jwVRY7adkGaELRjkXpeo0
         In8KwfOGYBP/94fg5pHCA+qLtEibohu3UiyeWAEfluNEJ/OMrDJTrl/qDVvTXwgxQ15Z
         J72g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=05tOQsNJatxfmrhjjfubiVSpLSkB4P1op/PjYOsjYD4=;
        b=UKCXLs9XI+DMH8jOLa7bQNYX7s4VSi1m7MyR79Zw/t2Cl512hqS32EgAEB5CxS3MDB
         P1iStKKfoxdlDkMudnY8Pn6MonEuANuBHR4GsGXdhZ7uPDkph3DoXaHp9r84Oih2oX+S
         C57Ep5XAKdRNX0i2T4iH6aFkmerERl9wj9rqFFpBSreoN+0ku6FCB2BlLkEYTZSEAljc
         64BBba57L7wJaNVgbYq7bdBOWcKtKnuZmAfZubZFOEV2ozq4URjKel58YzZCef9GMXid
         9NS6JVd0eT0GucvHO6hMA2F3vWS/DBpIJDwLL9qI9bNUGTs1kjxeh2Eao+Ub0BLMjnqN
         gf/w==
X-Gm-Message-State: AOAM5325akXnI7xKJ5iunz73yhc27rOpHSnC5G3bK7z4nb8m8pK+84xm
	kOWuOY+KOx7ycFYq4dhIan+H/u++lgrv6Yr/R6Q=
X-Google-Smtp-Source: ABdhPJw+MpPfoP6EXl4wxNJH040UVnebLG7ox6NrLUsl7rcSMXOMmq8Z3CxLRIzS1wlzZprolD613g==
X-Received: by 2002:a65:6954:0:b0:3c6:42cd:bd38 with SMTP id w20-20020a656954000000b003c642cdbd38mr20507348pgq.331.1652275471693;
        Wed, 11 May 2022 06:24:31 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id g1-20020aa79dc1000000b0050dc76281e1sm1698008pfq.187.2022.05.11.06.24.30
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 06:24:31 -0700 (PDT)
Message-ID: <627bb90f.1c69fb81.b1380.3599@mx.google.com>
Date: Wed, 11 May 2022 06:24:31 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Kernel: v4.4-st5-23-gf7cf04ab668f1
Subject: cip-gitlab/ci/pavel/linux-test ltp-mm: 3 runs, 3 regressions (v4.4-st5-23-gf7cf04ab668f1) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip-gitlab/ci/pavel/linux-test ltp-mm: 3 runs, 3 regressions (v4.4-st5-23-g=
f7cf04ab668f1)

Regressions Summary
-------------------

platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C436FA-Flip-hatch   | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =

asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =

hp-11A-G6-EE-grunt       | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.4-st5-23-gf7cf04ab668f1/plan/ltp-mm/

  Test:     ltp-mm
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.4-st5-23-gf7cf04ab668f1
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      f7cf04ab668f124b54f47c93fca7625e6eff3cfe

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  0f67c9851a9043d0ad68cef4648d103ba7908480 =



Test Regressions
---------------- =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C436FA-Flip-hatch   | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/627bb587e279f77e618f57ab

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-23-gf7cf04ab668f1/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/l=
ab-collabora/ltp-mm-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-23-gf7cf04ab668f1/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/l=
ab-collabora/ltp-mm-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220506.0/amd64/initrd.cpio.gz =



  * ltp-mm.login: https://kernelci.org/test/case/id/627bb587e279f77e618f57ac
        new failure (last pass: v5.10.109-cip5-384-g722204542e8a) =

 =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/627bb288c43db8ea038f5755

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-23-gf7cf04ab668f1/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/l=
ab-collabora/ltp-mm-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-23-gf7cf04ab668f1/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/l=
ab-collabora/ltp-mm-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220506.0/amd64/initrd.cpio.gz =



  * ltp-mm.login: https://kernelci.org/test/case/id/627bb288c43db8ea038f5756
        new failure (last pass: v5.10.109-cip5-384-g722204542e8a) =

 =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
hp-11A-G6-EE-grunt       | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/627bb30cd454a6bb358f5790

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-23-gf7cf04ab668f1/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/l=
ab-collabora/ltp-mm-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-23-gf7cf04ab668f1/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/l=
ab-collabora/ltp-mm-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220506.0/amd64/initrd.cpio.gz =



  * ltp-mm.login: https://kernelci.org/test/case/id/627bb30cd454a6bb358f5791
        new failure (last pass: v5.10.109-cip5-384-g722204542e8a) =

 =20

