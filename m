Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0830CC48298
	for <webhook@archiver.kernel.org>; Mon,  5 Feb 2024 13:14:07 +0000 (UTC)
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
 by mx.groups.io with SMTP id smtpd.web11.62097.1707138837209644885
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 05 Feb 2024 05:13:58 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=VPbXkLXq;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.181, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-53fa455cd94so3232892a12.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 05 Feb 2024 05:13:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1707138836; x=1707743636; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=HLWr7ArcY0I3I1u+iN3XKFEDTqcNSpyNmYFjgxwv3ik=;
        b=VPbXkLXqg63YMWlvMUm+7BlaIMjuDlNE8Yo9mw5/eMKnCQWuikY+r1+9eGt+iaUDrs
         QLoRkNJI9oRtF5WlivwoWMfFORDUy/U2L6Aal/X5/P16UHJ0BPVAsTdysLpi6xDGUlBF
         mNK0XFAm0xXwPegyOOoWcKTKpQVjk4tSCfHiM3d3DWdUJd11pohaCoRiW3gpttd9/t/Y
         skSO/oH8yhCiP06ekZoHw3R1iJKU0QVtLCaTKPosuEoIJziGUsEfM0ZabWwmOzgfB4ni
         l6BBgErwbi/BIWAiKkoM3ufQkSlTDL5PSik5pMjqmsgdwM5U4rx9e7CfQlqr6Isyhtqo
         GvsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707138836; x=1707743636;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HLWr7ArcY0I3I1u+iN3XKFEDTqcNSpyNmYFjgxwv3ik=;
        b=c7UHa/ZwQtFrsle9SL8YvBkLNkeHD3ibjJFRVZNqZkD66wYOxb++eFPAi+Unbtuz6D
         5N1/CDZtii5WCu6m3tH2IX5tT9q70mH1JpBGhPhh8Wfjd3HyIgWKkDQQprsi6HQXUj71
         Q0xsDc1pm4sB0MiZEA9ksOGChD7LK23fZWKl6IYlmWg5qFQZXkb0cG3RWoxeoQdCYOAv
         skYqbUPV+VOHJWb/LYEggjxOltAzuJbEQb/K1KqTaW4tIrsYv9UAp17UNKnEk5Dl7oMR
         Z7KDE4YMGC73kkp22y1onUo7+vmKHBMs5BnkBpTiSIlJAL4sndsVd2DsYBdMlkGMDZrt
         7c6A==
X-Gm-Message-State: AOJu0Yy7dtYJcxZKGdSkoSHTIA7bkyskKFPNYIiUDmj7nGoxR3usy780
	H12ziUyISwxkJ63KdiXThekumR6ISTbcLvYkXHmRXwgQX9IHPglKKAqdE2/wKhuK+ag0b4Q5yAo
	f
X-Google-Smtp-Source: AGHT+IFmFiesvl3AOhFKZzKVii3Wur5ExuNKuzbe6xk3XFF/0QllnW3/hOO8sDv1rSthjRj8GLJv2Q==
X-Received: by 2002:a17:90b:3892:b0:295:f3a0:2651 with SMTP id mu18-20020a17090b389200b00295f3a02651mr13931081pjb.17.1707138836112;
        Mon, 05 Feb 2024 05:13:56 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id li7-20020a170903294700b001d71729ec9csm6256021plb.188.2024.02.05.05.13.54
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 05:13:55 -0800 (PST)
Message-ID: <65c0df13.170a0220.e3bad.3b58@mx.google.com>
Date: Mon, 05 Feb 2024 05:13:55 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Kernel: v6.1.75-cip14-6-ga817aa655908
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test baseline: 125 runs,
 6 regressions (v6.1.75-cip14-6-ga817aa655908)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 05 Feb 2024 13:14:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14720

cip-gitlab/ci/pavel/linux-test baseline: 125 runs, 6 regressions (v6.1.75-c=
ip14-6-ga817aa655908)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =

hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =

lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =

r8a7743-iwg20d-q7            | arm    | lab-cip       | gcc-10   | shmobile=
_defconfig         | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v6.1.75-cip14-6-ga817aa655908/plan/baseline/

  Test:     baseline
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v6.1.75-cip14-6-ga817aa655908
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      a817aa655908e54b6999ed3d0663c3f370d059ec =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65c0d5a21f2e9eff2d00a04c

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.75-cip14-6-ga817aa655908/x86_64/x86_64_defconfig+x86-board/gcc-10/lab=
-collabora/baseline-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.75-cip14-6-ga817aa655908/x86_64/x86_64_defconfig+x86-board/gcc-10/lab=
-collabora/baseline-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65c0d5a21f2e9eff2d00a055
        failing since 17 days (last pass: v4.19.299-cip105-1134-gc868d5e4ad=
aa, first fail: v6.1.72-cip13-30-g79e2886a5da69)

    2024-02-05T12:33:19.677561  + set<8>[   11.337943] <LAVA_SIGNAL_ENDRUN =
0_dmesg 12703439_1.4.2.3.1>

    2024-02-05T12:33:19.677646   +x

    2024-02-05T12:33:19.781905  / # #

    2024-02-05T12:33:19.882468  export SHELL=3D/bin/sh

    2024-02-05T12:33:19.882660  #

    2024-02-05T12:33:19.983223  / # export SHELL=3D/bin/sh. /lava-12703439/=
environment

    2024-02-05T12:33:19.983379  =


    2024-02-05T12:33:20.083901  / # . /lava-12703439/environment/lava-12703=
439/bin/lava-test-runner /lava-12703439/1

    2024-02-05T12:33:20.084126  =


    2024-02-05T12:33:20.088949  / # /lava-12703439/bin/lava-test-runner /la=
va-12703439/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65c0d56b79d0edb66d00a055

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.75-cip14-6-ga817aa655908/x86_64/x86_64_defconfig+x86-board/gcc-10/lab=
-collabora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.75-cip14-6-ga817aa655908/x86_64/x86_64_defconfig+x86-board/gcc-10/lab=
-collabora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65c0d56b79d0edb66d00a05e
        failing since 17 days (last pass: v4.19.299-cip105-1134-gc868d5e4ad=
aa, first fail: v6.1.72-cip13-30-g79e2886a5da69)

    2024-02-05T12:33:14.099443  + set +x

    2024-02-05T12:33:14.105800  <8>[   10.836902] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 12703413_1.4.2.3.1>

    2024-02-05T12:33:14.209924  / # #

    2024-02-05T12:33:14.310530  export SHELL=3D/bin/sh

    2024-02-05T12:33:14.310708  #

    2024-02-05T12:33:14.411251  / # export SHELL=3D/bin/sh. /lava-12703413/=
environment

    2024-02-05T12:33:14.411432  =


    2024-02-05T12:33:14.511988  / # . /lava-12703413/environment/lava-12703=
413/bin/lava-test-runner /lava-12703413/1

    2024-02-05T12:33:14.512267  =


    2024-02-05T12:33:14.517285  / # /lava-12703413/bin/lava-test-runner /la=
va-12703413/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65c0d5893e925aa9a500a050

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.75-cip14-6-ga817aa655908/x86_64/x86_64_defconfig+x86-board/gcc-10/lab=
-collabora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.75-cip14-6-ga817aa655908/x86_64/x86_64_defconfig+x86-board/gcc-10/lab=
-collabora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65c0d5893e925aa9a500a059
        failing since 17 days (last pass: v4.19.299-cip105-1134-gc868d5e4ad=
aa, first fail: v6.1.72-cip13-30-g79e2886a5da69)

    2024-02-05T12:32:49.748450  <8>[   10.390091] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 12703480_1.4.2.3.1>

    2024-02-05T12:32:49.751981  + set +x

    2024-02-05T12:32:49.853245  /#

    2024-02-05T12:32:49.953990   # #export SHELL=3D/bin/sh

    2024-02-05T12:32:49.954216  =


    2024-02-05T12:32:50.054745  / # export SHELL=3D/bin/sh. /lava-12703480/=
environment

    2024-02-05T12:32:50.054927  =


    2024-02-05T12:32:50.155443  / # . /lava-12703480/environment/lava-12703=
480/bin/lava-test-runner /lava-12703480/1

    2024-02-05T12:32:50.155768  =


    2024-02-05T12:32:50.160563  / # /lava-12703480/bin/lava-test-runner /la=
va-12703480/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65c0d5a0e962fa638700a064

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.75-cip14-6-ga817aa655908/x86_64/x86_64_defconfig+x86-board/gcc-10/lab=
-collabora/baseline-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.75-cip14-6-ga817aa655908/x86_64/x86_64_defconfig+x86-board/gcc-10/lab=
-collabora/baseline-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65c0d5a0e962fa638700a06d
        failing since 17 days (last pass: v4.19.299-cip105-1134-gc868d5e4ad=
aa, first fail: v6.1.72-cip13-30-g79e2886a5da69)

    2024-02-05T12:33:18.898109  + set +x<8>[   10.787939] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 12703428_1.4.2.3.1>

    2024-02-05T12:33:18.898192  =


    2024-02-05T12:33:19.002114  / # #

    2024-02-05T12:33:19.102630  export SHELL=3D/bin/sh

    2024-02-05T12:33:19.102824  #

    2024-02-05T12:33:19.203281  / # export SHELL=3D/bin/sh. /lava-12703428/=
environment

    2024-02-05T12:33:19.203446  =


    2024-02-05T12:33:19.303984  / # . /lava-12703428/environment/lava-12703=
428/bin/lava-test-runner /lava-12703428/1

    2024-02-05T12:33:19.305193  =


    2024-02-05T12:33:19.310323  / # /lava-12703428/bin/lava-test-runner /la=
va-12703428/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65c0d57a335deb05a900a046

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.75-cip14-6-ga817aa655908/x86_64/x86_64_defconfig+x86-board/gcc-10/lab=
-collabora/baseline-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.75-cip14-6-ga817aa655908/x86_64/x86_64_defconfig+x86-board/gcc-10/lab=
-collabora/baseline-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65c0d57a335deb05a900a04f
        failing since 17 days (last pass: v4.19.299-cip105-1134-gc868d5e4ad=
aa, first fail: v6.1.72-cip13-30-g79e2886a5da69)

    2024-02-05T12:32:46.030127  <8>[   11.561108] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 12703472_1.4.2.3.1>

    2024-02-05T12:32:46.138216  / # #

    2024-02-05T12:32:46.240891  export SHELL=3D/bin/sh

    2024-02-05T12:32:46.241847  #

    2024-02-05T12:32:46.343457  / # export SHELL=3D/bin/sh. /lava-12703472/=
environment

    2024-02-05T12:32:46.344265  =


    2024-02-05T12:32:46.445873  / # . /lava-12703472/environment/lava-12703=
472/bin/lava-test-runner /lava-12703472/1

    2024-02-05T12:32:46.447537  =


    2024-02-05T12:32:46.452114  / # /lava-12703472/bin/lava-test-runner /la=
va-12703472/1

    2024-02-05T12:32:46.458750  + export 'TESTRUN_ID=3D1_bootrr'
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
r8a7743-iwg20d-q7            | arm    | lab-cip       | gcc-10   | shmobile=
_defconfig         | 1          =


  Details:     https://kernelci.org/test/plan/id/65c0d5883203898f1d00a05a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: shmobile_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.75-cip14-6-ga817aa655908/arm/shmobile_defconfig/gcc-10/lab-cip/baseli=
ne-r8a7743-iwg20d-q7.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.75-cip14-6-ga817aa655908/arm/shmobile_defconfig/gcc-10/lab-cip/baseli=
ne-r8a7743-iwg20d-q7.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65c0d5883203898f1d00a=
05b
        failing since 1 day (last pass: v6.1.72-cip13-32-gf60d2e8cb51c, fir=
st fail: v6.1.75-cip14-132-g6e54756fbd6c2) =

 =20

