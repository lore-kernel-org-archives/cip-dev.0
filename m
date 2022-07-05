Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1279EC433EF
	for <webhook@archiver.kernel.org>; Tue,  5 Jul 2022 03:04:55 +0000 (UTC)
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com
 [209.85.216.42])
 by mx.groups.io with SMTP id smtpd.web08.80135.1656990285505459711
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 04 Jul 2022 20:04:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=2yLoeS8v;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.42,
 mailfrom: bot@kernelci.org)
Received: by mail-pj1-f42.google.com with SMTP id
 89-20020a17090a09e200b001ef7638e536so7181183pjo.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 04 Jul 2022 20:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=KD3lSETXH+bAi9XqiBw+tq4hJft/3uIMZtFdoqo1usQ=;
        b=2yLoeS8v4YqjZJQSn+YdPvbN3DK6LP3CCgG3FTfUaHCaX8OdZC6CrtjZXBpM2Nu+eb
         wkyzsTDXQFv7yaSdmm7w2MVYa1gMEdmeFmpRxa5Kmdmuafe0JmfXAjvairwrtBrpUeG4
         2MT85WwuxWshgreyqmnZKb3v9SIA8l+pLElg3rYrZgMJ0hRuhmxrzn7AxElYoSJqz0pv
         p/LPRAcR1h4QUb0iwiNXC7yJSMG9FIWUv5/UOwWlj9GAXUYHaft64C3QiwTOvMYhvk9A
         QKyEM/DccTKl8VH4KhFrfPPjOHQKSTy3zqV5yfbq4BSYrQZL/My3xeUks47W0VlFLywP
         kHBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=KD3lSETXH+bAi9XqiBw+tq4hJft/3uIMZtFdoqo1usQ=;
        b=UgOqDE4uqjHMtBwVIq4wmNQwfgJhS1LeVO4ojOPccanfFZRqDqwDD51Gy2oV01d3u3
         THBrlY4FmV7NkdVUh6YgK2FzW6VffgzGnAaYlpc1g39aMszzlL7xaLp8igZIs6Apy9CO
         FcUctREYPLMuU55C+vK897xiJ2z9wHFataq6NvIDWSsZyPnNRrkOKo7tX9+wm7l2Rp6i
         wpu/M+/kU86FQ4n9/Xh6LIMQdwtNKultk5oVX7rXrEaFF4aRGKzqW6k9hMddTuH4ix6R
         ifZWsTDwdwgIWnuRmqe9DvomNDGa41BIEq/9uDQPmGgAiJ5U57G+ieovhuDW17HGr6rq
         OMEw==
X-Gm-Message-State: AJIora/LY8EixXn3I+itkALEzlFuKKMem+OINoRoRrGOBC3pIVp8yJfE
	eGINcXvKzBTPmG9KNBs4GUiONdh6iTJSo23u
X-Google-Smtp-Source: 
 AGRyM1vF8QLouYUQ7gCwV0iTXVFzkHOFWOpno+XDjvcyCfRJ+lcFHhaK7qqUBARDaknCoeigJG9rXg==
X-Received: by 2002:a17:902:d48f:b0:16a:755f:86db with SMTP id
 c15-20020a170902d48f00b0016a755f86dbmr39423140plg.77.1656990284898;
        Mon, 04 Jul 2022 20:04:44 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 ik15-20020a170902ab0f00b0016bdea07b9esm3957672plb.190.2022.07.04.20.04.43
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 20:04:44 -0700 (PDT)
Message-ID: <62c3aa4c.1c69fb81.61f19.5705@mx.google.com>
Date: Mon, 04 Jul 2022 20:04:44 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.125-cip10-119-g603acbe1aceb
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc smc: 8 runs,
 3 regressions (v5.10.125-cip10-119-g603acbe1aceb)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 05 Jul 2022 03:04:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8662

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc smc: 8 runs, 3 regressions (v5.1=
0.125-cip10-119-g603acbe1aceb)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 2          =

qemu_arm64-virt-gicv3        | arm64  | lab-broonie   | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.125-cip10-119-g603acbe1aceb/plan/smc/

  Test:     smc
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.125-cip10-119-g603acbe1aceb
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      603acbe1acebe85cab7f594d9952a493be976262 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/62c39942aba5b91ddda39c16

  Results:     14 PASS, 2 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.125-cip10-119-g603acbe1aceb/x86_64/x86_64_defconfig+x86-=
chromebook/gcc-10/lab-collabora/smc-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.125-cip10-119-g603acbe1aceb/x86_64/x86_64_defconfig+x86-=
chromebook/gcc-10/lab-collabora/smc-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220624.0/x86/rootfs.cpio.gz =



  * smc.CVE-2018-3639: https://kernelci.org/test/case/id/62c39942aba5b91ddd=
a39c22
        new failure (last pass: v5.10.121-cip9-287-ge9094c8446fc)

    2022-07-05T01:51:51.848837  <8>[   12.644769] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3DCVE-2018-3639 RESULT=3Dfail>   =


  * smc.CVE-2018-3640: https://kernelci.org/test/case/id/62c39942aba5b91ddd=
a39c23
        new failure (last pass: v5.10.121-cip9-287-ge9094c8446fc)

    2022-07-05T01:51:51.830661  <8>[   12.626480] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3DCVE-2018-3640 RESULT=3Dfail>   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3        | arm64  | lab-broonie   | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/62c3a1377ecf3a855fa39bd5

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.125-cip10-119-g603acbe1aceb/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-broonie/smc-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.125-cip10-119-g603acbe1aceb/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-broonie/smc-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220624.0/arm64/rootfs.cpio.gz =



  * smc.login: https://kernelci.org/test/case/id/62c3a1387ecf3a855fa39bd6
        failing since 53 days (last pass: v5.10.112-cip6-88-gf3397cadb2dd6,=
 first fail: v5.10.112-cip6-289-g2969e096d186) =

 =20

