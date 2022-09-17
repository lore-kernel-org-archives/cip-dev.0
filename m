Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81866ECAAD3
	for <webhook@archiver.kernel.org>; Sat, 17 Sep 2022 16:45:45 +0000 (UTC)
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com
 [209.85.210.171])
 by mx.groups.io with SMTP id smtpd.web09.429.1663433135702127166
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sat, 17 Sep 2022 09:45:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=U2Li+nat;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.171,
 mailfrom: bot@kernelci.org)
Received: by mail-pf1-f171.google.com with SMTP id e68so24152240pfe.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sat, 17 Sep 2022 09:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=kx4eehK/GoTyni6bI3EyHjOO6cqO+ng4YAjEfK/pLnE=;
        b=U2Li+natrqXwzikIxgc7Q7w5hk6M1z0IN9NX25MxYHW2hnoWnKT9yGna5knwcKGb4K
         3d6YIn+Nh4A8SMS+v1mpE4DnvqRTk3nVjnd+acFJmo2v4hWzfqPrmvaswMvGYustmOz1
         85XCE2/qxnSWtsDWoCCXqljnDRAyCzPpbgFNX/TKJXcLrnB4abBh9Kne3fz+9jxNT9it
         TYdnMjUY2/tlmc6qhwcXCXFMpLQRFUtl85eLkueHMDXzOct/l9N2nUR/x5mCs+j6dvJt
         pmIGIbNJ3nT8jm1/4mNWihRhrab9Zl7U1WjhuGsLR8X13OUCWe8MrGjphtvdp1DXSS1l
         67FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=kx4eehK/GoTyni6bI3EyHjOO6cqO+ng4YAjEfK/pLnE=;
        b=t+xMFR71szfAnhNiwTuIDAP0PlHWxe498U71nBEUPYMkqPzIgV6pFNPxFps7ZFzJmt
         mrTs92RP9V4BsXHXeKhRhL73L4M6CqirFU+lQqdqIlPLDm31NkY0VMWI5AxX/KWkHEUJ
         FUgXa0kg1DoPhDa3W8dhGNjDKV+Dy5UkO9cUPY22itZa2YoSBawNa2nc2s/nNzaV9lrc
         U2d59P/bKk41ou5o29cjRhUuZ6FDYowDZLcIVMNRrrHYsyUDBCtg1ESMY6EEDCspKJWr
         JqhddiD7gydPWLIUUvoOq7twaPAjmnJd31A8310ckOjgkbMzV5qovMEe+WgpI21SOOmO
         GMoQ==
X-Gm-Message-State: ACrzQf1o3vuZNiSSRYLRaNxesY+11QpUgL5s73oS+2ugXeYk3oGWOmv5
	/kN554weCOPzkePvagbqenLa9OdNZmWO98hLSVw=
X-Google-Smtp-Source: 
 AMsMyM7wbEJauO2xym2xOrxTLvp3JvxmYTSFT3RQi8Tg0653g/V3h+mIy16zk5SMCyiRRd6B2RgoIQ==
X-Received: by 2002:a05:6a00:21c2:b0:52b:ff44:666a with SMTP id
 t2-20020a056a0021c200b0052bff44666amr10384577pfj.83.1663433134946;
        Sat, 17 Sep 2022 09:45:34 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 g2-20020a170902d1c200b001781a7c28b9sm16233495plb.240.2022.09.17.09.45.33
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Sep 2022 09:45:33 -0700 (PDT)
Message-ID: <6325f9ad.170a0220.7c3fb.da47@mx.google.com>
Date: Sat, 17 Sep 2022 09:45:33 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.4-st20-229-gb433f12afe250
Subject: cip-gitlab/ci/pavel/linux-test ltp-timers: 9 runs,
 5 regressions (v4.4-st20-229-gb433f12afe250)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 17 Sep 2022 16:45:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9508

cip-gitlab/ci/pavel/linux-test ltp-timers: 9 runs, 5 regressions (v4.4-st20=
-229-gb433f12afe250)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

asus-C436FA-Flip-hatch    | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

rk3288-veyron-jaq         | arm    | lab-collabora | gcc-10   | multi_v7_de=
fconfig           | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.4-st20-229-gb433f12afe250/plan/ltp-timers/

  Test:     ltp-timers
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.4-st20-229-gb433f12afe250
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      b433f12afe2506afd30066f5b2b826129a20bc03

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  48cfd7a9977e6268b4aa2600608cebad7e0e42b8 =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6325eb6f79ee4ef09a355653

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-229-gb433f12afe250/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/ltp-timers-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-229-gb433f12afe250/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/ltp-timers-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220826.0/amd64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/6325eb6f79ee4ef09a3=
55654
        failing since 11 days (last pass: v5.10.131-cip13-84-g5fcbe4a63ab4d=
, first fail: v5.10.138-cip15-10-g52cbd8ad1543e) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C436FA-Flip-hatch    | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6325ec7d823e7de34f355679

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-229-gb433f12afe250/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/ltp-timers-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-229-gb433f12afe250/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/ltp-timers-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220826.0/amd64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/6325ec7d823e7de34f3=
5567a
        new failure (last pass: v5.10.138-cip15-10-g52cbd8ad1543e) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6325ebf17df780f379355670

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-229-gb433f12afe250/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/ltp-timers-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-229-gb433f12afe250/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/ltp-timers-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220826.0/amd64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/6325ebf17df780f3793=
55671
        new failure (last pass: v5.10.138-cip15-10-g52cbd8ad1543e) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6325eb8c3383c7751735566a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-229-gb433f12afe250/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/ltp-timers-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-229-gb433f12afe250/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/ltp-timers-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220826.0/amd64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/6325eb8c3383c775173=
5566b
        new failure (last pass: v5.10.138-cip15-10-g52cbd8ad1543e) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
rk3288-veyron-jaq         | arm    | lab-collabora | gcc-10   | multi_v7_de=
fconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6325ed9da9cc5a7bc5355651

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-229-gb433f12afe250/arm/multi_v7_defconfig/gcc-10/lab-collabora/l=
tp-timers-rk3288-veyron-jaq.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-229-gb433f12afe250/arm/multi_v7_defconfig/gcc-10/lab-collabora/l=
tp-timers-rk3288-veyron-jaq.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220826.0/armhf/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/6325ed9da9cc5a7bc53=
55652
        new failure (last pass: v5.10.138-cip15-10-g52cbd8ad1543e) =

 =20

