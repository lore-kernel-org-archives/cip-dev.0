Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB0EFC3F6B0
	for <webhook@archiver.kernel.org>; Fri, 12 Aug 2022 11:22:15 +0000 (UTC)
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com
 [209.85.210.171])
 by mx.groups.io with SMTP id smtpd.web09.9525.1660303322758547734
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 12 Aug 2022 04:22:02 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=f1DnLXmJ;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.171,
 mailfrom: bot@kernelci.org)
Received: by mail-pf1-f171.google.com with SMTP id h28so675984pfq.11
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 12 Aug 2022 04:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc;
        bh=wSgSJ2LzD1DJMb5aviw5bL/S4xhp/4AZzYZwEYL4rHI=;
        b=f1DnLXmJAKdOdNs4GELw2KkAvKxNozT9dQxWso438b3oGc2S9jkZ5c2aIa/9c8SDdT
         n9v4iuGFt+3FWzOhjdrnDg4gtPyxByvP+AQCWI3u2gAZyK06nRyzpY0nHjaM8jSWIYwP
         6pHMUBJGQlxcR3CPmUUrdmE5sC4aa7Hj5dxS/Nvabmad82ntr8YoFzVku8We/owepNkD
         zKqG6jWf/ZQ6NgTqGwuO/euAoeHFIS4CMA+Nmp4nPv1gVqIJ/U/5FanjZ8IQ/BEGf7PH
         jWQ7UeDoPbuEoZvlHurp5u4zti5fUoWXoFJdvgVlinAy8Sr/6wMH5ARMtDGBwlMephqK
         G4Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=wSgSJ2LzD1DJMb5aviw5bL/S4xhp/4AZzYZwEYL4rHI=;
        b=RevB+hu5B1MJGrjS0Ngmv1A+SqcTw1OdztsvnHmrl8VCfk5JiAxW4NV7fxnm9+db6a
         iAHC+YAcmCBcd15fux3vfOdQhZJJ69LPuVbSP9jCnAnK56dxF/CFX3zeIfdawbchG1Zh
         uSG2s2HB4FP8nbnPE7DM0M9+YFuL4lvmJJhF1Rdgkk4uPPpoXRR0wNpinCLNsTycLu8S
         N42O0GOCRnPodaliJ0QwzMypu6W8buA/sCD9y3/LlJMKny7wGcXeFLDf6U+AcF2BdQPC
         xgC4VxJJgM5PSspVdFvYRrc+uuJ7ujDlnm44UltlQRwcLUevXfJk/SS9CP8F5y63xXK9
         Zgxg==
X-Gm-Message-State: ACgBeo3CY1RIwxRxftiQDZYcwyX0LGFbSc2MTuZ4K1KiACnU+iatzd+Y
	/HaWXzm9/i6ahVKIwPZbtE6T+/gLT+mH3zZa
X-Google-Smtp-Source: 
 AA6agR4ZFzIvM9cmgDoQSZDJyBoyKjUWY/oG/6HrNBdTmQSyQMfPx7Wwva02S81pmdMvAiKxLxJYtw==
X-Received: by 2002:a63:8ac9:0:b0:41b:bd60:672b with SMTP id
 y192-20020a638ac9000000b0041bbd60672bmr2761772pgd.70.1660303322020;
        Fri, 12 Aug 2022 04:22:02 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 h3-20020a170902f54300b0016bc947c5b7sm1474368plf.38.2022.08.12.04.22.01
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Aug 2022 04:22:01 -0700 (PDT)
Message-ID: <62f637d9.170a0220.8364f.272b@mx.google.com>
Date: Fri, 12 Aug 2022 04:22:01 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.4-st20-96-g74ff989472f09
Subject: cip-gitlab/ci/pavel/linux-test ltp-mm: 4 runs,
 4 regressions (v4.4-st20-96-g74ff989472f09)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 12 Aug 2022 11:22:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9192

cip-gitlab/ci/pavel/linux-test ltp-mm: 4 runs, 4 regressions (v4.4-st20-96-=
g74ff989472f09)

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
nux-test/kernel/v4.4-st20-96-g74ff989472f09/plan/ltp-mm/

  Test:     ltp-mm
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.4-st20-96-g74ff989472f09
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      74ff989472f092eb06514e780a28645e8310d183

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  7e71b2c4b9a136602d9774c13097f5e06f6f04a9 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62f6257bb2eac34d69daf07d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-96-g74ff989472f09/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/ltp-mm-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-96-g74ff989472f09/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/ltp-mm-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220805.0/amd64/initrd.cpio.gz =



  * ltp-mm.login: https://kernelci.org/test/case/id/62f6257bb2eac34d69daf07e
        failing since 8 days (last pass: v5.10.131-cip13-24-ga6f4ea41fe167,=
 first fail: v4.4.302-cip70-rt40) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C523NA-A20057-coral     | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62f621d3f64cd1bc9ddaf06a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-96-g74ff989472f09/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/ltp-mm-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-96-g74ff989472f09/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/ltp-mm-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220805.0/amd64/initrd.cpio.gz =



  * ltp-mm.login: https://kernelci.org/test/case/id/62f621d3f64cd1bc9ddaf06b
        failing since 8 days (last pass: v5.10.131-cip13-24-ga6f4ea41fe167,=
 first fail: v4.4.302-cip70-rt40) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-11A-G6-EE-grunt           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62f621ce6d473a5c31daf0b8

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-96-g74ff989472f09/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/ltp-mm-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-96-g74ff989472f09/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/ltp-mm-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220805.0/amd64/initrd.cpio.gz =



  * ltp-mm.login: https://kernelci.org/test/case/id/62f621ce6d473a5c31daf0b9
        failing since 8 days (last pass: v5.10.131-cip13-24-ga6f4ea41fe167,=
 first fail: v4.4.302-cip70-rt40) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62f625790fc6f95e25daf056

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-96-g74ff989472f09/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/ltp-mm-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-96-g74ff989472f09/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/ltp-mm-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220805.0/amd64/initrd.cpio.gz =



  * ltp-mm.login: https://kernelci.org/test/case/id/62f625790fc6f95e25daf057
        failing since 8 days (last pass: v5.10.131-cip13-24-ga6f4ea41fe167,=
 first fail: v4.4.302-cip70-rt40) =

 =20

