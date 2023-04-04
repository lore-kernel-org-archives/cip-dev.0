Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68F0AC77B62
	for <webhook@archiver.kernel.org>; Tue,  4 Apr 2023 11:18:11 +0000 (UTC)
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
 by mx.groups.io with SMTP id smtpd.web11.98638.1680607090542782088
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 04 Apr 2023 04:18:10 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=Y8nFf1PY;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.42, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f42.google.com with SMTP id e15-20020a17090ac20f00b0023d1b009f52so35743452pjt.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 04 Apr 2023 04:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112; t=1680607090;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6g3TYQkYJN60XkXiGCB9WhQjCIyo1JYs+t6YK5ARLqo=;
        b=Y8nFf1PYgpazRyn3dD2s5vaBqHWSL7hVR6H2u7Q2GEA81e/YF3jpC7QwrYHf6H+eWl
         dqMynQOMr7dxg2nm8h4642xQdQk5+O7Ee/uRvTbWxvvYiw2bSYHdiYcnea+htFT0Dsj1
         rdotL40r4dMoUAqrHG+dGmic8ueqN3qbIu88DbFmR9SUKPNMM0RNNv79mnbOz/cElHxp
         e6yYWl+7cxWEZRLwvYDDah5/nb7i8go6jvlW2MgZRYelQDI2gkPS9vVVM0okXctDQ6r9
         vhqabX5lIxLSkOUM3oLTlchE6q4FivexlVaWDFhIRg7GapLqXv4IHEz7neTAhdFlJJ7g
         C2Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680607090;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6g3TYQkYJN60XkXiGCB9WhQjCIyo1JYs+t6YK5ARLqo=;
        b=FjaGLVhbPDEf8to4sUSdTCRhOQ89tcJ7VAkvlScOg3pRkVz3qnuLY2pgv1nH0sm9mL
         eVatyTOLFgoqS0PDgBphV6GvBSjgRo0cBeAkXDuDWpcX9Cj6RyEjgBmhAxHHf/DW5wVR
         2ongKkippOTxN140/Rh1qtXbTEDzb/4UUhyCT1C8903672jkHByb+u0K+u3rRWc5PdNN
         cd8XFN26bZoCvjvwfocV2Qlo3nr9ik+avzix7xv0VYF1dD0MbY3HniFTiFhstJo3Dj8A
         NcRtFBjGto4emmHnNrWTRKI/YhKfVPVrP5XqOR0rO6hObo4sdYfWuDw1oyMhvQWnpGbO
         zWPg==
X-Gm-Message-State: AAQBX9eA0sJL6wk2U6O1KkFvvDK5GndcZYxjy93GNLzQF84FxC4GJmx2
	cF17wGxG8pvVlrEYlAP8QY7aHobnzBhFYIv/88iFMg==
X-Google-Smtp-Source: AKy350YBLHnjvxGKnIuCQhL9b4Ui7r3sjmqlKfGuyZBwK7DgE5FK+GKCCQeZ6GcPApEpomPpTIvKjw==
X-Received: by 2002:a17:902:e5c7:b0:19e:29bd:8411 with SMTP id u7-20020a170902e5c700b0019e29bd8411mr2728873plf.30.1680607089741;
        Tue, 04 Apr 2023 04:18:09 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id jf19-20020a170903269300b001a065d3ea3bsm8145414plb.295.2023.04.04.04.18.09
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 04:18:09 -0700 (PDT)
Message-ID: <642c0771.170a0220.f680d.fa8a@mx.google.com>
Date: Tue, 04 Apr 2023 04:18:09 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.4.302-cip74-rt43
Subject: cip-gitlab/ci/pavel/linux-test ltp-mm: 3 runs,
 3 regressions (v4.4.302-cip74-rt43)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 04 Apr 2023 11:18:11 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11169

cip-gitlab/ci/pavel/linux-test ltp-mm: 3 runs, 3 regressions (v4.4.302-cip7=
4-rt43)

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

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.4.302-cip74-rt43/plan/ltp-mm/

  Test:     ltp-mm
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.4.302-cip74-rt43
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      22456e8b8d35c6bd1313511bfa4dd945ce7a0c1e

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  70199ce4f0c498bfc7d0d9e0440f54b97b373b26 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/642bfb44e70239562779ea04

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/ltp-mm-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/ltp-mm-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230331.0/amd64/initrd.cpio.gz =



  * ltp-mm.login: https://kernelci.org/test/case/id/642bfb44e70239562779ea05
        failing since 38 days (last pass: v5.10.167-cip26-2-g28bb49f7179b, =
first fail: v5.10.168-cip27-456-g42a59c4e5329) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C523NA-A20057-coral     | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/642bfb1c44b4e0355a79e93f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/ltp-mm-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/ltp-mm-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230331.0/amd64/initrd.cpio.gz =



  * ltp-mm.login: https://kernelci.org/test/case/id/642bfb1c44b4e0355a79e940
        failing since 12 days (last pass: v4.19.277-cip94-1098-g26d9f86d942=
d, first fail: v5.10.175-cip29-rt12) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/642c03aebf7873242379e922

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/ltp-mm-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/ltp-mm-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230331.0/amd64/initrd.cpio.gz =



  * ltp-mm.login: https://kernelci.org/test/case/id/642c03aebf7873242379e923
        failing since 12 days (last pass: v4.19.277-cip94-1098-g26d9f86d942=
d, first fail: v5.10.175-cip29-rt12) =

 =20

