Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DFE0C636CC
	for <webhook@archiver.kernel.org>; Tue, 31 Jan 2023 14:11:34 +0000 (UTC)
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
 by mx.groups.io with SMTP id smtpd.web10.12859.1675174286106518670
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 31 Jan 2023 06:11:26 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=DpsecWYB;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.180, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f180.google.com with SMTP id b5so7934079plz.5
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 31 Jan 2023 06:11:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2WcmGC5/mUFhyja8wXf1LluOAV2CCbhWO1w4SimTaBg=;
        b=DpsecWYBtynHxPHdShBaeEtNTbCiDoHoWY9KC18+KoSSFtQMnAuuNbKEH66xV+HKzX
         tSAsnoOh6qv7yUCdoQHCxGDBDsG6G9V5NFoC9KGkRRbtvjji12rqI4dUn0P1H7zIOBi5
         Dz2db5KHh7iteMLZbCkN5PjmRplxSQDCmPFxTE5mJ0YXUFy20f4GBsU1bQX6gBdNh7Uw
         zPAarpe1WwPWnAXmmVBMr1f4qJhIklwFnFItYWwy3psYQqxp4Ou25vOXjQolXjKDsbwh
         UblStQdjxTwjmy3XayhrViWsGtvjZn063LQVXQ8p5sOWNbpJ6ttSTB2usVgoB5ETCvhI
         aenw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2WcmGC5/mUFhyja8wXf1LluOAV2CCbhWO1w4SimTaBg=;
        b=EYUhy7TYI3pyijjlYqMJBxupRB4/Q95gJPwlbOoV5NdCLFaNuVq4UFZbKj7nqRYYB8
         skp67slvhaz/0uSoaH0MAJI/winThyNRBz9zP4f+4nRz8VlTNrPMFs3ZcKfrSGJrJZgk
         HO3ICcJ6ro52TLhgz1mmaZ9KpG7MblpJYp44FUepbylac3mqq4hNES3nTtG12dBxkCFr
         8ROrPoKQzbZT0ew8jzkJsQ+GB7xXzdgsWXDrE+FMQp3MHgxmEJrIZpZD3ZbNQv9+cSGr
         oCmc77Qy9s0aeA0SvhorhqLjvZ6QHE1v0Z87QEhxK7YBD2l1ut1YM/NYTSdVl/B0Wyn7
         rBFw==
X-Gm-Message-State: AFqh2krgYP4DA3dRtCE0T1M7EURdIiVUyxysyqFX1jZq9Pj5OwOS7CHQ
	wcuc3pp5jDZOFdmZoU2bRONa7PcJt2bJK+QIxYrUww==
X-Google-Smtp-Source: AMrXdXswKuulB2dRcK7xT6HGp0GnZ/ounTKgxdqnvA+T+5GlcPDy3kZ4e8yfLtKr/oUV1cXs2TY5Ow==
X-Received: by 2002:a05:6a20:9588:b0:b6:204c:d606 with SMTP id iu8-20020a056a20958800b000b6204cd606mr54940904pzb.62.1675174285356;
        Tue, 31 Jan 2023 06:11:25 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id s8-20020a63af48000000b0046b1dabf9a8sm8437183pgo.70.2023.01.31.06.11.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 06:11:25 -0800 (PST)
Message-ID: <63d9218d.630a0220.e0c9a.d114@mx.google.com>
Date: Tue, 31 Jan 2023 06:11:25 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Kernel: v5.10.165-cip25
X-Kernelci-Report-Type: test
Subject: cip/linux-5.10.y-cip kselftest-futex: 8 runs,
 1 regressions (v5.10.165-cip25)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 31 Jan 2023 14:11:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10537

cip/linux-5.10.y-cip kselftest-futex: 8 runs, 1 regressions (v5.10.165-cip2=
5)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig | regress=
ions
-------------------------+-------+---------+----------+-----------+--------=
----
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig | 1      =
    =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.165-cip25/plan/kselftest-futex/

  Test:     kselftest-futex
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.165-cip25
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      52aae1dc6afe62fedb14c89fd4feca1d8bb13416 =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig | regress=
ions
-------------------------+-------+---------+----------+-----------+--------=
----
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/63d919070280ec6da3915eba

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.165=
-cip25/arm64/defconfig/gcc-10/lab-cip/kselftest-futex-r8a774a1-hihope-rzg2m=
-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.165=
-cip25/arm64/defconfig/gcc-10/lab-cip/kselftest-futex-r8a774a1-hihope-rzg2m=
-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230127.0/arm64/initrd.cpio.gz =



  * kselftest-futex.login: https://kernelci.org/test/case/id/63d919070280ec=
6da3915ebb
        new failure (last pass: v5.10.162-cip24) =

 =20

