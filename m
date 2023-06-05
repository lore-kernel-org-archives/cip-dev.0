Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D771BC7EE2A
	for <webhook@archiver.kernel.org>; Mon,  5 Jun 2023 12:00:12 +0000 (UTC)
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
 by mx.groups.io with SMTP id smtpd.web11.5686.1685966404307216029
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 05 Jun 2023 05:00:04 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=C8Yod9og;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.174, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-53f70f7c2d2so2410124a12.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 05 Jun 2023 05:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1685966403; x=1688558403;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=87WNj0zm6WX/uPVRrvmjlrn0CKdgHEEHZYQKwa0JXwI=;
        b=C8Yod9ogQnxKfoOKWEzXE6Vot/STu20D3qbCDwLwKENeVoZcdkliXTTyvmsg4N37DI
         HaAG42nmZbYzEDbmD9AlrNr2bPgZtRJLz10XoXZHP7MDwtq35o62UHtWt9nKlhP15axA
         sUhgsLobIrt0YB8Q4aIHuQVbuLRzDApvCUVPX9mT2TthjfJtKJaZBawmkeERwunw0m2Q
         bACy6bsdOGyyBLodK2ZwjYVUZD16V7+rPu5MEHFc/TrONKuaaAsTGB9+EH2uBMSf2imd
         YZScP+9340uO/3kTDzCnJu28fjETC3GHU5bVkFQqZsFBddJu9SvDCJ8Gw3jf3KS0UYHz
         kK0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685966403; x=1688558403;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=87WNj0zm6WX/uPVRrvmjlrn0CKdgHEEHZYQKwa0JXwI=;
        b=j2ElVMDZ552mUEZYVjoELN7oJE4aSQW9syD+Yx1++kGr73HqNZG9cwqPyLiwenpvhy
         UbWybtF0JGw0JKooPPnxwhHoo2jQ38SJifYW2gciHgNbKdhRmPTjcnyg/wEsgPwAlkKu
         YHjVDVypXzPqQeEAvavgRfskVzMvIW2a79C8oODW+SxBckw4d4+ocPBZdYx97YgpeFru
         im1lc0+1040O9FCIf1ACBxWx4qLnkpG6QNcOiCjbq/b80qtJXfP9vR1bvSi6YIBEwINP
         BtBgGZepMyscBO7BZyBKoYHVvd2t2CcvUx/JThuzCYK8YfuChObzMJ4ZDrii6MJRfSvH
         rEpg==
X-Gm-Message-State: AC+VfDy23ORZMWYvoB0Qpvza8S2VQ6uHZvzlwnlCwCdaBESLkHVxtkP9
	DZmSQk8tb2mEdTuuJ1Y4x+q8lMJ9Tit9GuAEQ1AzMg==
X-Google-Smtp-Source: ACHHUZ5xNjK0THNJLAeIG++KL3mGHITuPNK1W+Bp8pb9OV26KKh3DPdLEzMypSUzaZv+8XLVwdSTJw==
X-Received: by 2002:a17:902:c2c4:b0:1af:c599:6a88 with SMTP id c4-20020a170902c2c400b001afc5996a88mr2180650pla.49.1685966403244;
        Mon, 05 Jun 2023 05:00:03 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id f3-20020a170902ce8300b001ae365072ccsm6424124plg.122.2023.06.05.05.00.02
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 05:00:02 -0700 (PDT)
Message-ID: <647dce42.170a0220.9c4da.a684@mx.google.com>
Date: Mon, 05 Jun 2023 05:00:02 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.1.26-1298-g61395b9756bd5
X-Kernelci-Report-Type: test
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/pavel/linux-test kselftest-futex: 7 runs,
 1 regressions (v6.1.26-1298-g61395b9756bd5)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 05 Jun 2023 12:00:12 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11808

cip-gitlab/ci/pavel/linux-test kselftest-futex: 7 runs, 1 regressions (v6.1=
.26-1298-g61395b9756bd5)

Regressions Summary
-------------------

platform         | arch | lab     | compiler | defconfig          | regress=
ions
-----------------+------+---------+----------+--------------------+--------=
----
beaglebone-black | arm  | lab-cip | gcc-10   | multi_v7_defconfig | 1      =
    =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v6.1.26-1298-g61395b9756bd5/plan/kselftest-futex/

  Test:     kselftest-futex
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v6.1.26-1298-g61395b9756bd5
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      61395b9756bd5614e204ba22b9c75fd47c24a999 =



Test Regressions
---------------- =



platform         | arch | lab     | compiler | defconfig          | regress=
ions
-----------------+------+---------+----------+--------------------+--------=
----
beaglebone-black | arm  | lab-cip | gcc-10   | multi_v7_defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/647dcc085e9f130460f5de57

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1298-g61395b9756bd5/arm/multi_v7_defconfig/gcc-10/lab-cip/kselftes=
t-futex-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1298-g61395b9756bd5/arm/multi_v7_defconfig/gcc-10/lab-cip/kselftes=
t-futex-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230527.0/armhf/initrd.cpio.gz =



  * kselftest-futex.login: https://kernelci.org/test/case/id/647dcc085e9f13=
0460f5de58
        new failure (last pass: v6.1.26-1302-g2631206dd75c2) =

 =20

