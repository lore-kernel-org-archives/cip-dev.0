X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
 by mx.groups.io with SMTP id smtpd.web11.7451.1647501244922630591
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 17 Mar 2022 00:14:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=c493A6uP;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.181, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f181.google.com with SMTP id o26so2007287pgb.8
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 17 Mar 2022 00:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=U/gyukkkhznRthawoChUsGe2Yc/E17cpC10oth0rrjY=;
        b=c493A6uP7vdSAfUnR2i9QELOqkfsx6OBTm9ueKeW87Pt+zTPTG0fXP47XpXiV2S2fd
         i9RGOPv5lQkGG76+Hu3Ylxk27sNkDAdrG43yz2XX/VkknCj42u/FbOOkD6Tox/zbml1v
         maG6ZYDpYnfp5zlddsQECehZWw76W7UEnTF7l+7cAZo3Cvz+gkhoTtIdtSpZFGvuwOnP
         DGPV/0E4UFNAirOM4l9F5av5so54PrUl9Sct0Hoc+HqS/FEi/oOsynwgl7rRD55neU+O
         02GgOHpgK0zGz0iUWzvtl0ySx3EEuCgESOGqKfKeWkCI+6zK8/21FTXuDqzxS1M7LDDp
         VTOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=U/gyukkkhznRthawoChUsGe2Yc/E17cpC10oth0rrjY=;
        b=7B8ioeMjRXEkK4wpb7Rx8PAJQgxqHJE342+COTIfrjLhij5QDiRr2BLmSmct6smK7y
         80FkmTLkPWY1JX+BeZ2c5C92f8Wwsg/F9HuqnSLtzFDs7KvQ2/PHV/FIXmKVuzwxiL/B
         VSoeNdE15OxjJErkovKneotJIsctWz3FMESiicV/bb2FSjGVJi3DM04P/ugeHcj7j6S9
         y9dJYHM1eKMkbEChRHb3zCgZ8AFX4sQ2AtNBK6HtOfu3qNt2ps9YEFVe+g/41nYcED8n
         3gUoaZ74TQbagrJyKjAAuDJG76T6nUdS0Ei85y77N2MCXEyZZyMMuVpnBP/BXtHVsYmg
         wAFA==
X-Gm-Message-State: AOAM533+H96yCm+f1I2LSQnfvhz5TfSK+5WrRKj6n+m+6OppyLSSDBSu
	bmZW6HCDQ6F+vJYQNTRu3YhI/2YgwfEnvP8vR2I=
X-Google-Smtp-Source: ABdhPJylp66WUQ5VMgKYtIb7f/zdThGQNwrZ41YDdGBR9JrmXTKAsa30OqsxUMLH8q0Pg7RPHnBJBA==
X-Received: by 2002:a05:6a00:2352:b0:4f7:752d:dd09 with SMTP id j18-20020a056a00235200b004f7752ddd09mr3101601pfj.22.1647501244220;
        Thu, 17 Mar 2022 00:14:04 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id b9-20020a056a000cc900b004f7ac2189e2sm5891768pfv.191.2022.03.17.00.14.03
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 00:14:03 -0700 (PDT)
Message-ID: <6232dfbb.1c69fb81.f69d8.fd9b@mx.google.com>
Date: Thu, 17 Mar 2022 00:14:03 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Kernel: v4.4.302-cip68-19-gcfdd1ea3a7ba
Subject: cip-gitlab/ci/pavel/linux-test ltp-ipc: 6 runs, 4 regressions (v4.4.302-cip68-19-gcfdd1ea3a7ba) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip-gitlab/ci/pavel/linux-test ltp-ipc: 6 runs, 4 regressions (v4.4.302-cip=
68-19-gcfdd1ea3a7ba)

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
nux-test/kernel/v4.4.302-cip68-19-gcfdd1ea3a7ba/plan/ltp-ipc/

  Test:     ltp-ipc
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.4.302-cip68-19-gcfdd1ea3a7ba
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      cfdd1ea3a7bab80ea3e513f28e7aa423fedf5d61

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  67eccca54eb68a1bc91cf1f140fc43fa8085d8ed =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C436FA-Flip-hatch    | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6232d2983b956a1c95b7391d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip68-19-gcfdd1ea3a7ba/x86_64/x86_64_defconfig+x86-chromebook/gcc=
-10/lab-collabora/ltp-ipc-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip68-19-gcfdd1ea3a7ba/x86_64/x86_64_defconfig+x86-chromebook/gcc=
-10/lab-collabora/ltp-ipc-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220228.1/amd64/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/6232d2983b956a1c95b739=
1e
        failing since 2 days (last pass: v5.10.100-cip2-319-g7182f5032311, =
first fail: v4.19.233-cip69-1019-g2e5815777e975) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-cx9400-volteer       | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6232d0d8b24fcff7a6b73934

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip68-19-gcfdd1ea3a7ba/x86_64/x86_64_defconfig+x86-chromebook/gcc=
-10/lab-collabora/ltp-ipc-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip68-19-gcfdd1ea3a7ba/x86_64/x86_64_defconfig+x86-chromebook/gcc=
-10/lab-collabora/ltp-ipc-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220228.1/amd64/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/6232d0d8b24fcff7a6b739=
35
        failing since 2 days (last pass: v5.10.100-cip2-319-g7182f5032311, =
first fail: v4.19.233-cip69-1019-g2e5815777e975) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6232d0ebb24fcff7a6b73976

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip68-19-gcfdd1ea3a7ba/x86_64/x86_64_defconfig+x86-chromebook/gcc=
-10/lab-collabora/ltp-ipc-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip68-19-gcfdd1ea3a7ba/x86_64/x86_64_defconfig+x86-chromebook/gcc=
-10/lab-collabora/ltp-ipc-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220228.1/amd64/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/6232d0ebb24fcff7a6b739=
77
        failing since 0 day (last pass: v4.19.233-cip69-1019-g2e5815777e975=
, first fail: v4.4.302-18-ga78419826225) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-x360-12b-n4000-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6232daa659c334c8acb7395b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip68-19-gcfdd1ea3a7ba/x86_64/x86_64_defconfig+x86-chromebook/gcc=
-10/lab-collabora/ltp-ipc-hp-x360-12b-n4000-octopus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip68-19-gcfdd1ea3a7ba/x86_64/x86_64_defconfig+x86-chromebook/gcc=
-10/lab-collabora/ltp-ipc-hp-x360-12b-n4000-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220228.1/amd64/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/6232daa659c334c8acb739=
5c
        failing since 0 day (last pass: v4.19.233-cip69-1019-g2e5815777e975=
, first fail: v4.4.302-18-ga78419826225) =

 =20

