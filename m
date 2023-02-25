Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B5ABC64ED8
	for <webhook@archiver.kernel.org>; Sat, 25 Feb 2023 00:32:04 +0000 (UTC)
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
 by mx.groups.io with SMTP id smtpd.web11.34726.1677285118629146942
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 24 Feb 2023 16:31:58 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=FfPsjR3h;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.182, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f182.google.com with SMTP id d10so541767pgt.12
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 24 Feb 2023 16:31:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=nBH0k2OOGONiY+o7WdI+zRD5Eebx62xpUsb3Ke5NNE0=;
        b=FfPsjR3hFKmqWUYYRUeoZ9VEfV1NBb8i7h+JtuDBYRPQcEgiukw5qu/rAaVh+hpqR4
         bG1xv1Fk7XpEYGNB6K4sjONYcKC9/2lI0avGUnLp+VDrTb8zw3CtV7Z03W9tVvMWlQP1
         RfJn/dXFED0cPBjZ0PuUYstEks6sSWcz8x3pldhS0uAkak/f5YTpuJ6JkAZEIIoD6p+H
         BKYblfc0LzKHnpJvopN4ILrvsD8WKeB1hmXiVmbnJMcsC4Wcze2SMsrsTAlsQ/tIxF/A
         3uyBJch0V8IRQhxCxpU83jzq9BGShfQsXL455ZXAzEHRRLlArGxpsSAjWeIWGjhEMo28
         S+Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nBH0k2OOGONiY+o7WdI+zRD5Eebx62xpUsb3Ke5NNE0=;
        b=j5JTjm8XGOG3/cNad2/wtJuQRMRS3P0x0sME8p7wbi8zkYHXWr/WwVT7tUyyRp1iAR
         cbYpWgnL62UV3TAN7uTNv/9Q15aNhrUPEvAyxv1bZEOnE0vpnDVzHNW/wbBjQr++9h2U
         rb19QxOTiDUCu2quIh1R9YMWeVA1DtKJwcBK3jWZXdkT4l3DAwkHp0hEsF+z5NxtVrNz
         3BQ6ew0tECR27XmDftDmG/eQCkWttQTs7gG7X0wXEAkeDFXGzPRnIpqIStvdug1jXHfu
         LzuB17gusggnEA/+aJnmryLY3tGVSWdDiNlJnFdS/5b5pEJcqr3HH3S90404IoRhHS+2
         tT6w==
X-Gm-Message-State: AO0yUKW3+eUs2fJ6vHQNMtkqdnAJFG48FK85UJyLaSIK8LMwDlYJVNC+
	ArlwYDC+pS6Z5/VP7BC1C43o0EubrYSvm6lREpr2Qw==
X-Google-Smtp-Source: AK7set+qMPviFZfUI37XaDdYtgJ2jPc5XNrG0TjarzQJ7ZoFkFoI2r8pnDvuTROrrJrUbxTecIEhtQ==
X-Received: by 2002:a62:1e81:0:b0:5aa:3ce6:3763 with SMTP id e123-20020a621e81000000b005aa3ce63763mr14456055pfe.10.1677285117890;
        Fri, 24 Feb 2023 16:31:57 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id u24-20020a62ed18000000b005d663989ccfsm112032pfh.200.2023.02.24.16.31.56
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 16:31:56 -0800 (PST)
Message-ID: <63f956fc.620a0220.27c1c.06ae@mx.google.com>
Date: Fri, 24 Feb 2023 16:31:56 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v5.10.168-cip27-456-g42a59c4e5329
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test ltp-mm: 6 runs,
 2 regressions (v5.10.168-cip27-456-g42a59c4e5329)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 25 Feb 2023 00:32:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10835

cip-gitlab/ci/pavel/linux-test ltp-mm: 6 runs, 2 regressions (v5.10.168-cip=
27-456-g42a59c4e5329)

Regressions Summary
-------------------

platform               | arch   | lab           | compiler | defconfig     =
               | regressions
-----------------------+--------+---------------+----------+---------------=
---------------+------------
asus-C436FA-Flip-hatch | x86_64 | lab-collabora | gcc-10   | x86_64_defcon.=
..6-chromebook | 1          =

hp-11A-G6-EE-grunt     | x86_64 | lab-collabora | gcc-10   | x86_64_defcon.=
..6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.168-cip27-456-g42a59c4e5329/plan/ltp-mm/

  Test:     ltp-mm
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.168-cip27-456-g42a59c4e5329
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      42a59c4e5329312aec627def5fefeaf40a482f9c

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  86f0584539eb1567f009f3e38be6940830649b92 =



Test Regressions
---------------- =



platform               | arch   | lab           | compiler | defconfig     =
               | regressions
-----------------------+--------+---------------+----------+---------------=
---------------+------------
asus-C436FA-Flip-hatch | x86_64 | lab-collabora | gcc-10   | x86_64_defcon.=
..6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63f949ed947559aeb48c8658

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.168-cip27-456-g42a59c4e5329/x86_64/x86_64_defconfig+x86-chromebook/g=
cc-10/lab-collabora/ltp-mm-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.168-cip27-456-g42a59c4e5329/x86_64/x86_64_defconfig+x86-chromebook/g=
cc-10/lab-collabora/ltp-mm-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230217.0/amd64/initrd.cpio.gz =



  * ltp-mm.login: https://kernelci.org/test/case/id/63f949ed947559aeb48c8659
        new failure (last pass: v5.10.167-cip26-2-g28bb49f7179b) =

 =



platform               | arch   | lab           | compiler | defconfig     =
               | regressions
-----------------------+--------+---------------+----------+---------------=
---------------+------------
hp-11A-G6-EE-grunt     | x86_64 | lab-collabora | gcc-10   | x86_64_defcon.=
..6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63f94992d8993fc6a98c8641

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.168-cip27-456-g42a59c4e5329/x86_64/x86_64_defconfig+x86-chromebook/g=
cc-10/lab-collabora/ltp-mm-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.168-cip27-456-g42a59c4e5329/x86_64/x86_64_defconfig+x86-chromebook/g=
cc-10/lab-collabora/ltp-mm-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230217.0/amd64/initrd.cpio.gz =



  * ltp-mm.login: https://kernelci.org/test/case/id/63f94992d8993fc6a98c8642
        new failure (last pass: v5.10.167-cip26-2-g28bb49f7179b) =

 =20

