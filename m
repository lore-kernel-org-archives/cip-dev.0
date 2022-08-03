Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1437DC19F2C
	for <webhook@archiver.kernel.org>; Wed,  3 Aug 2022 17:55:30 +0000 (UTC)
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com
 [209.85.214.170])
 by mx.groups.io with SMTP id smtpd.web08.965.1659549328376270076
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 03 Aug 2022 10:55:28 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=Ws96/TU9;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.170,
 mailfrom: bot@kernelci.org)
Received: by mail-pl1-f170.google.com with SMTP id w10so17116337plq.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 03 Aug 2022 10:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=dBAi1YOZXod40N0x2cfB/GSazNtxqLM9l/+7maPc8to=;
        b=Ws96/TU9VQ74pltp6XLcXPiBrkawO+be+in7EvxQVPzFVYqZZYKeowe18cHMflqnqM
         fM0nAjMqp+aFUSbDWACATAVEX27i6bF3dtEfSKa2jIxZQq8FYJYnlH/vCSHgaRYdbjDp
         xFyl/XEctZRaXjvoPJJfCVwrP8G+NA2CBJOOGJw7ALgpe9WEFe1dVwCswLuFqz0iTp7v
         KcPN1fko0GlgaVZcpJyJSO87pf3knDRzUydBhM3H+zffj0SPMME4D9BzlMS4J0gxeRw1
         zK+LqkQGKM1rDumzN8+iV3pkmAP4YmzqZ9yb9fOuHwp6VhOTdwAbD/z+PQwiXyifRNR7
         kkkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=dBAi1YOZXod40N0x2cfB/GSazNtxqLM9l/+7maPc8to=;
        b=OvjkqxcN31nzY5fuclObt02Y4RhIuthecwNFotc0oS7GGTBj5h2CxY7rNVP8gcvEnT
         dIwTdIj92bwlTGZOtTsLHYidoz7VFFXJ24T+Yv6ndNJDlhoNaVNgH42MlwJqizTADyeg
         +dLL9p8K/2g4Y+FwHXx9NhuDpvYHz7jpeGlPpGCcfb1DwLj5TRCet2xwNTXbFSvir+oP
         V/kDjhzR4EIQVGaJamMbJJV4qBwI5TTl1pvCRz0jCtQjyDqVknm/6prQzxF/Hryi5ico
         HpQ8qxeDCqVKQP+jPfyiG2mPrllW6088bgsc6Qn9//FX/rfkiILZkWqlkR4Xf7lfrQ3d
         rh7Q==
X-Gm-Message-State: ACgBeo3Sz1kPAoW5vsqPbG/wpt5qd0+kxOemwLr7G0TA7ow0bUP4bk/C
	pJLNgPzxMVqi0bQBCXPwM48W7eg8etiBwRYhD1k=
X-Google-Smtp-Source: 
 AA6agR7rlNOEJYj/J37QTHshxGu329T9TzzTZKAr/fx4FnIjNBPWUHkYn/e7QEgBvWox/LV5SpKUcg==
X-Received: by 2002:a17:902:e5c6:b0:16e:f3b6:ddb5 with SMTP id
 u6-20020a170902e5c600b0016ef3b6ddb5mr13940756plf.122.1659549327616;
        Wed, 03 Aug 2022 10:55:27 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 a143-20020a621a95000000b00517c84fd24asm9962202pfa.172.2022.08.03.10.55.27
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Aug 2022 10:55:27 -0700 (PDT)
Message-ID: <62eab68f.620a0220.2daf3.f2d5@mx.google.com>
Date: Wed, 03 Aug 2022 10:55:27 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.4-st20-74-gc99f2b257bde3
Subject: cip-gitlab/ci/pavel/linux-test ltp-fcntl-locktests: 3 runs,
 3 regressions (v4.4-st20-74-gc99f2b257bde3)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 03 Aug 2022 17:55:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9094

cip-gitlab/ci/pavel/linux-test ltp-fcntl-locktests: 3 runs, 3 regressions (=
v4.4-st20-74-gc99f2b257bde3)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.4-st20-74-gc99f2b257bde3/plan/ltp-fcntl-locktests/

  Test:     ltp-fcntl-locktests
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.4-st20-74-gc99f2b257bde3
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      c99f2b257bde3cd60a833056aab624ad5fab3812

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  bda92ad659a52d38ac810099f69adff626b064c6 =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62eaa315b0643174eedaf18a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-74-gc99f2b257bde3/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/ltp-fcntl-locktests-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-74-gc99f2b257bde3/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/ltp-fcntl-locktests-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220716.0/amd64/initrd.cpio.gz =



  * ltp-fcntl-locktests.login: https://kernelci.org/test/case/id/62eaa315b0=
643174eedaf18b
        failing since 0 day (last pass: v5.10.131-cip13-24-ga6f4ea41fe167, =
first fail: v4.4.302-cip70-rt40) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62eaa9d81ffe221a82daf07d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-74-gc99f2b257bde3/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/ltp-fcntl-locktests-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-74-gc99f2b257bde3/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/ltp-fcntl-locktests-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220716.0/amd64/initrd.cpio.gz =



  * ltp-fcntl-locktests.login: https://kernelci.org/test/case/id/62eaa9d81f=
fe221a82daf07e
        failing since 0 day (last pass: v5.10.131-cip13-24-ga6f4ea41fe167, =
first fail: v4.4.302-cip70-rt40) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62eab4de2bb108393ddaf077

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-74-gc99f2b257bde3/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/ltp-fcntl-locktests-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-74-gc99f2b257bde3/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/ltp-fcntl-locktests-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220716.0/amd64/initrd.cpio.gz =



  * ltp-fcntl-locktests.login: https://kernelci.org/test/case/id/62eab4de2b=
b108393ddaf078
        failing since 0 day (last pass: v5.10.131-cip13-24-ga6f4ea41fe167, =
first fail: v4.4.302-cip70-rt40) =

 =20

