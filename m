Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C55FEC8300C
	for <webhook@archiver.kernel.org>; Wed,  7 Jun 2023 15:24:25 +0000 (UTC)
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
 by mx.groups.io with SMTP id smtpd.web11.1043.1686151463563683167
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 07 Jun 2023 08:24:23 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=TkLWdmxh;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.161.53, mailfrom: bot@kernelci.org)
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-559b0ddcd4aso2220009eaf.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 07 Jun 2023 08:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1686151462; x=1688743462;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=eGsCBUqjEf4WIB0VWNNT7S5LAtC6/jqhivCxQGPt0Ps=;
        b=TkLWdmxheXCMyrxxXH2narLYzlkBLUg+FQhHwPxGb2bexlMI6EygMS5MJx2uUDbm08
         s8kezZBtxGMAYA+njGrmrOsqn7oseQ08M1mW9w53FYiT5YCgFTlVWi9Y6Rn+8K0iigJZ
         zX2i8vqhPdFL8afQEju7xKZqoS7UF9iN3DZwYgZ2nS85e1H2WM3MNG612yRp/XqosmWq
         2GKQCwFMZNSGVcbA5RvNZQaG5shGxuOiphWbI7i7l1tsEsz8r3NYCgzFjXaA6t4puIPz
         EzxTPsPmyFatzK07sTFXtRtqONyXbEaHVPTU+owSor+VAs/oUWwTFxkuKaQYneFYoZvg
         TDhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686151462; x=1688743462;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eGsCBUqjEf4WIB0VWNNT7S5LAtC6/jqhivCxQGPt0Ps=;
        b=Sb1QDFoWRLah+L2xud+Sel/H0CRq7Vvpz0tcWXlfvglsUIU6bAcAFBISwCSfyh/9dj
         XfQga1ezg2iYJVfxI8dV89rym8iSUyBtrI7u+AMRHxuENzu2Zl84gnRG82DVbokw0DUI
         TpQJEsphBaKU367hwJv2NMpa4p+Il4s1jT6IUZWabjL/H3kKlxnORB4mx1nffhzC/jW+
         f4YyUTIZbWdNk+OctpHpMcEOZKLlLBk2hdAuJacox5CTcLox8kIzY3X3JJv7iREpS2QB
         SU8MEPEDkXxYjTEj9ZnT7EHYRMr7JkZ/JesDY2T0gmSLAKp9L98KHDYmaoeCe4/nw7oV
         qnaw==
X-Gm-Message-State: AC+VfDyxKTWyqAWtMnH/WVS5wikeH5Kz6Zn7ML6q0h5mDqiSclrCfwJD
	n3DIUurF8NSDTI/Apjd9OU6gbenS4o2yXd9AjoIl4g==
X-Google-Smtp-Source: ACHHUZ5e9Ws60Rvv8XrQ3ouAkO3hqkBJecq4VS2aeQA+1RYgrhCDEyw6udzhJsvAo4MTpYmBDIR7PA==
X-Received: by 2002:a54:4715:0:b0:39c:429f:972e with SMTP id k21-20020a544715000000b0039c429f972emr5519743oik.6.1686151462251;
        Wed, 07 Jun 2023 08:24:22 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id ce21-20020a17090aff1500b002564dc3cb60sm1523852pjb.9.2023.06.07.08.24.21
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 08:24:21 -0700 (PDT)
Message-ID: <6480a125.170a0220.537c2.2e6b@mx.google.com>
Date: Wed, 07 Jun 2023 08:24:21 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.4.302-cip74-rt43-218-g246f4be89a77
Subject: cip-gitlab/ci/pavel/linux-test ltp-mm: 4 runs,
 4 regressions (v4.4.302-cip74-rt43-218-g246f4be89a77)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 07 Jun 2023 15:24:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11922

cip-gitlab/ci/pavel/linux-test ltp-mm: 4 runs, 4 regressions (v4.4.302-cip7=
4-rt43-218-g246f4be89a77)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

asus-C523NA-A20057-coral     | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-11A-G6-EE-grunt           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.4.302-cip74-rt43-218-g246f4be89a77/plan/ltp-mm/

  Test:     ltp-mm
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.4.302-cip74-rt43-218-g246f4be89a77
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      246f4be89a7760f90649094cbfabcccfce7dafd1

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  604701dc19c5499403ae5afe48103b8e2872952b =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/648091bc08562f963c306144

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43-218-g246f4be89a77/x86_64/x86_64_defconfig+x86-chromebo=
ok/gcc-10/lab-collabora/ltp-mm-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43-218-g246f4be89a77/x86_64/x86_64_defconfig+x86-chromebo=
ok/gcc-10/lab-collabora/ltp-mm-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230527.0/amd64/initrd.cpio.gz =



  * ltp-mm.login: https://kernelci.org/test/case/id/648091bc08562f963c306145
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C523NA-A20057-coral     | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6480989fd0f8e118f730616c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43-218-g246f4be89a77/x86_64/x86_64_defconfig+x86-chromebo=
ok/gcc-10/lab-collabora/ltp-mm-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43-218-g246f4be89a77/x86_64/x86_64_defconfig+x86-chromebo=
ok/gcc-10/lab-collabora/ltp-mm-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230527.0/amd64/initrd.cpio.gz =



  * ltp-mm.login: https://kernelci.org/test/case/id/6480989fd0f8e118f730616d
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-11A-G6-EE-grunt           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/648092ebaec2b989c7306152

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43-218-g246f4be89a77/x86_64/x86_64_defconfig+x86-chromebo=
ok/gcc-10/lab-collabora/ltp-mm-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43-218-g246f4be89a77/x86_64/x86_64_defconfig+x86-chromebo=
ok/gcc-10/lab-collabora/ltp-mm-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230527.0/amd64/initrd.cpio.gz =



  * ltp-mm.login: https://kernelci.org/test/case/id/648092ebaec2b989c7306153
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64809519613c7f4b90306143

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43-218-g246f4be89a77/x86_64/x86_64_defconfig+x86-chromebo=
ok/gcc-10/lab-collabora/ltp-mm-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43-218-g246f4be89a77/x86_64/x86_64_defconfig+x86-chromebo=
ok/gcc-10/lab-collabora/ltp-mm-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230527.0/amd64/initrd.cpio.gz =



  * ltp-mm.login: https://kernelci.org/test/case/id/64809519613c7f4b90306144
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785) =

 =20

