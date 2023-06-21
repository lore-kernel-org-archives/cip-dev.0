Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 619A5EB64DD
	for <webhook@archiver.kernel.org>; Wed, 21 Jun 2023 20:03:39 +0000 (UTC)
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
 by mx.groups.io with SMTP id smtpd.web11.84.1687377810493504324
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 21 Jun 2023 13:03:30 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=CvT/tsa4;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.169, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1b5452b77b4so40083005ad.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 21 Jun 2023 13:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1687377809; x=1689969809;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=PjS+mNAa4rWJaweAMgDxP1HH8LxlQ9VpYwdLQfB5qsU=;
        b=CvT/tsa42SBQjeYfjuY9ctsSL1hzMEovqZGSp4WR6pSiAFUsB3dkyiXpPwx/CaXzTK
         lAyQrdU1Qm7RZjDyPhh4tWwFYDw7cOzwzSY2zwg9Vdzh9I20Zt0AGc4Ot69pcB5EMh90
         Zs6ysE/86K7JKGsFiH1N4ZQHhKh8ibk+07cw1kbsf8Nh1HGgVQcsam05Z++wxbWq8QRk
         k6QCutwKRZSJ7q4APqUF43rPgZAXYwSRswhXRLj91tUqYdQejoa2bS/ucoOxo68V7c3n
         ghUSzxzfm4IonYog9+hNFuEVMDd7iUkzHRz+8DLj32t2vUTQTwz+J9OQDs2S3jPScX8S
         /y6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687377809; x=1689969809;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PjS+mNAa4rWJaweAMgDxP1HH8LxlQ9VpYwdLQfB5qsU=;
        b=XuUQTDhDUOuhJB86VBtc19LuOsHgSTqSiwIIePJRDjQpjDo4jd9sRWPShlmP5O5Zq4
         7uiHNVkTV9Iwmtz+7fL1u6HKS6ecP3AGPpKiP2NcCLA3NyyGWnFrYqeG7rnJLhJZz7Lp
         YEX1y0K0s5KcsWPlWuHYskqFQkekAlyajuiSRBiUqlXBPrLNNj+D2X2CcFZST/Q71a7p
         /s9TgBFNB8uHOVWYBrCjchlUxdxsxMul/5DlqpJJ3Lig1XZbxIf/zTpNRfVhPyhgHeYF
         aRyKZ1UZSBYT73qphulf2Uo/X6X8KSyKQ+/Wo3i2GYPQX/XTYgeyCv+0AZSRs2Dw+tb+
         5RnA==
X-Gm-Message-State: AC+VfDwgfmW3/qXOK7NUjbyAwkw0dLAVLUhoTd7gmupTQqb/7TyOP023
	QuN3Awt1stkL/v/1HbI6/OnxgJPMKcLluu9/bYOe0A==
X-Google-Smtp-Source: ACHHUZ6+tlKdgYjmC3ZpQyTaB7pf94dedKkkjrlYF8wDdpnhZX6HYCe0U/J4rCkvtdqLy+ONUwQvSA==
X-Received: by 2002:a17:902:ecc4:b0:1ab:2034:26da with SMTP id a4-20020a170902ecc400b001ab203426damr19247293plh.51.1687377809492;
        Wed, 21 Jun 2023 13:03:29 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id u5-20020a170902e5c500b001b3d0aff88fsm3876198plf.109.2023.06.21.13.03.26
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 13:03:27 -0700 (PDT)
Message-ID: <6493578f.170a0220.ae052.9455@mx.google.com>
Date: Wed, 21 Jun 2023 13:03:27 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.182-cip35-289-g3c0549540706
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-mm: 6 runs,
 1 regressions (v5.10.182-cip35-289-g3c0549540706)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 21 Jun 2023 20:03:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12099

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-mm: 6 runs, 1 regressions (v=
5.10.182-cip35-289-g3c0549540706)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.182-cip35-289-g3c0549540706/plan/ltp-mm/

  Test:     ltp-mm
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.182-cip35-289-g3c0549540706
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      3c0549540706be602c1cc58f7ebdcae39509baa7

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  97c2fdb137a68e1eefed07c900db1a862edcdbf8 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64934b58c1a95813be306158

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.182-cip35-289-g3c0549540706/x86_64/x86_64_defconfig+x86-=
chromebook/gcc-10/lab-collabora/ltp-mm-hp-x360-12b-ca0010nr-n4020-octopus.t=
xt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.182-cip35-289-g3c0549540706/x86_64/x86_64_defconfig+x86-=
chromebook/gcc-10/lab-collabora/ltp-mm-hp-x360-12b-ca0010nr-n4020-octopus.h=
tml
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230609.0/amd64/initrd.cpio.gz =



  * ltp-mm.login: https://kernelci.org/test/case/id/64934b58c1a95813be306159
        new failure (last pass: v5.10.182-cip35-191-gf4efde512959) =

 =20

