Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05571EB64D9
	for <webhook@archiver.kernel.org>; Thu,  6 Jul 2023 04:30:18 +0000 (UTC)
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
 by mx.groups.io with SMTP id smtpd.web11.14575.1688617810217732988
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 05 Jul 2023 21:30:10 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=qxwvNKyu;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.219.50, mailfrom: bot@kernelci.org)
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6378cec43ddso1809466d6.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 05 Jul 2023 21:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1688617809; x=1691209809;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=H0a9ry2GOWEZpV7Z1VzoyCDKEEXQcV8YAP8/Kr/jep0=;
        b=qxwvNKyu3yZaqWy/Umacaf7kHz6Kc8IMh03CEfg7kz+MrBwJqYtvrjOzJnFeQMh+al
         rtxcopnAJHRQJUhDVADwKvws6bqHn4mjFXkyMSmoXnhlJiIZ5GgWSCs0RrvlS8tttQP0
         yRYOhVsiaCxeDbyLaElFmMq6COAc2ll4yRPkXcCq02rqeziMD3pdAMnVuRhk2ZY5c8Kv
         bPENDUv2fcX+NIflJ8AYqp7YYLsErjre+QO/PBg6tW1AObmXoVFQ34N0uderiOFe5vIV
         SEFIdn1chM+Q/W2QhqVkoHJYG81KrBKZUh/2j6yzJh+wM8olDGyzuK9dZUjo1QPdK07R
         WyDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688617809; x=1691209809;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H0a9ry2GOWEZpV7Z1VzoyCDKEEXQcV8YAP8/Kr/jep0=;
        b=F5u9eGq3UMB1cWsSe+tjc1bRBwSrDV9zZYQiBiERIaN2CgjfvU9RVVbi+p2rTQ2Gmw
         3FRMQ5VSsqO5OcUs7QKFLOPyTweHXfnkUltTRNP1D/kA4T5tMj9uPFKYbY/B4rR2t68X
         kakTGV2yl4EPnG1BljFn3KL7qhAnPhrsxSx67qwD52LN4nH9mMj4IlXSbgoiGagY+inK
         xtHPEAQg2bM9B6OygRwjnGcZIbEcQMwj8pNr1crweuBtuFOYhopL1Dmttn9CTZ/6NXd+
         oyXqzzmdT3wSSGprvzH9HbWNqObR5ag54lBoG81gVXevsNQdG7H/pZcEfFD5HmlcTQi4
         KJ2g==
X-Gm-Message-State: ABy/qLalV42M/846LpamYyp8UVXhLjmqBmgN4t8j5Zm79sDB5zVtZaD4
	22HV+GlN3UuDNwqQInMN5w9wymiDUO6e8Qx7enSZPQ==
X-Google-Smtp-Source: APBJJlEUkadeWWpFP58TUNHWtYXslIjMfdZUdL1dY+0mpDISMBPPvUqlTaTUZZK5pcvOcCWBoeraiA==
X-Received: by 2002:a0c:e2d2:0:b0:636:cc82:8cb4 with SMTP id t18-20020a0ce2d2000000b00636cc828cb4mr584366qvl.33.1688617808785;
        Wed, 05 Jul 2023 21:30:08 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id bv1-20020a632e01000000b0055be951145csm365206pgb.36.2023.07.05.21.30.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 21:30:07 -0700 (PDT)
Message-ID: <64a6434f.630a0220.72647.0f44@mx.google.com>
Date: Wed, 05 Jul 2023 21:30:07 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.10.184-cip36-8-gb192df20e8c9
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-5.10.y-cip
Subject: cip/linux-5.10.y-cip ltp-fcntl-locktests: 4 runs,
 1 regressions (v5.10.184-cip36-8-gb192df20e8c9)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 06 Jul 2023 04:30:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12249

cip/linux-5.10.y-cip ltp-fcntl-locktests: 4 runs, 1 regressions (v5.10.184-=
cip36-8-gb192df20e8c9)

Regressions Summary
-------------------

platform          | arch  | lab         | compiler | defconfig | regressions
------------------+-------+-------------+----------+-----------+------------
qemu_smp8_riscv64 | riscv | lab-broonie | gcc-10   | defconfig | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.184-cip36-8-gb192df20e8c9/plan/ltp-fcntl-locktests/

  Test:     ltp-fcntl-locktests
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.184-cip36-8-gb192df20e8c9
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      b192df20e8c9dda03e005d4cb4909d846ea437bb

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform          | arch  | lab         | compiler | defconfig | regressions
------------------+-------+-------------+----------+-----------+------------
qemu_smp8_riscv64 | riscv | lab-broonie | gcc-10   | defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/64a630843a34787cbfbb2a79

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.184=
-cip36-8-gb192df20e8c9/riscv/defconfig/gcc-10/lab-broonie/ltp-fcntl-locktes=
ts-qemu_smp8_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.184=
-cip36-8-gb192df20e8c9/riscv/defconfig/gcc-10/lab-broonie/ltp-fcntl-locktes=
ts-qemu_smp8_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30623.0/riscv64/rootfs.cpio.gz =



  * ltp-fcntl-locktests.login: https://kernelci.org/test/case/id/64a630843a=
34787cbfbb2a7a
        new failure (last pass: v5.10.184-cip36) =

 =20

