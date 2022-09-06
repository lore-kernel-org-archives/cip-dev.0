Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B00EECAAA1
	for <webhook@archiver.kernel.org>; Tue,  6 Sep 2022 01:39:26 +0000 (UTC)
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com
 [209.85.210.178])
 by mx.groups.io with SMTP id smtpd.web11.32446.1662428357688461448
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 05 Sep 2022 18:39:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=Epr6EHYw;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.178,
 mailfrom: bot@kernelci.org)
Received: by mail-pf1-f178.google.com with SMTP id z187so9896143pfb.12
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 05 Sep 2022 18:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=aRoYRrUdhEHLUxiy1sxeBjgAkVhuMd7jEAls51zJuFg=;
        b=Epr6EHYwYpnFShu72Zf6i4qdQCm1Q+XF3d3LzzTfRYrjsAuh7QNrJ/o5mkrcl2zZ0W
         s1mKrioSlhPxz8EJTHgi65CJBzmYPYasrUg2wiZnfXEw/uO7ixwfy7K3Kl3V3rX4TNkP
         5Vb2kxh5OOCFcaghnKv8JQoExTPQOXbY5LVoXdLnhUaChrUqmntMKqFJm0eF2E7yKFUT
         8Ps6HBCcOAFLY35BR/tpw2Nzu3102izWNrnBhrHBA2gTRiaN3O81IszVd93RyUpvpL20
         Ot99OJYWLmTYGs+EJNNU6Ftd/M0z/nfUFQJaRMIyG6KFmiNnTeoBl1IJv/gYLTjaMkIL
         Y2eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=aRoYRrUdhEHLUxiy1sxeBjgAkVhuMd7jEAls51zJuFg=;
        b=Rp7Tk2T6fZkP0dUiO+i/PoJ3QxAM1qu5aoQN8TIjQfX412IV6saDyiryB5xOWS9EfK
         O0XsoGaF2zth6uoyKYW9JE6kzBvtnb7ELYnrsThz4Y37Z9aFXS5XSH/ZRWzoPp+kV/UC
         lRnSUii9AiShAg4l+G9wXvoSvLavFYrVDfmQN/eFwvfc1SeDKXVNtjf7+Ct4mrWG1f9Y
         FLdPZV0vBoI577gmE3YNjIW8hfLJWbEsHjNbEmJnhBvDV/b/jnXYzwNf7RAF5E3ZhCOF
         4ywly4jL3w0aNjXv9OMBiCtEu0cOGG0hgUGv3f3H1kn6YxQ+IIzYn/CAREiBMBBcLFma
         5pew==
X-Gm-Message-State: ACgBeo0y9cBCKd1MB8j3hzk9SkzfFJPjEFPDyBXncQx/ZlgEPugAtiLW
	zChJb2qKlSvtExE9JkICWHLpfG7KlU0BokUWlPA=
X-Google-Smtp-Source: 
 AA6agR5c2+qi9a36YRPRzxHvocHUrSTmBZIYjSCkBrxNmLnC5bqwIwsJHpLtgyWa7yNyIOUcgLlYOQ==
X-Received: by 2002:a63:e513:0:b0:42b:d733:602d with SMTP id
 r19-20020a63e513000000b0042bd733602dmr35559537pgh.549.1662428356880;
        Mon, 05 Sep 2022 18:39:16 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 z17-20020a170903019100b001768517f99esm6105439plg.244.2022.09.05.18.39.16
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 18:39:16 -0700 (PDT)
Message-ID: <6316a4c4.170a0220.b1418.8ae1@mx.google.com>
Date: Mon, 05 Sep 2022 18:39:16 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.138-cip15-10-g52cbd8ad1543e
Subject: cip-gitlab/ci/pavel/linux-test ltp-timers: 10 runs,
 1 regressions (v5.10.138-cip15-10-g52cbd8ad1543e)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 06 Sep 2022 01:39:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9464

cip-gitlab/ci/pavel/linux-test ltp-timers: 10 runs, 1 regressions (v5.10.13=
8-cip15-10-g52cbd8ad1543e)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.138-cip15-10-g52cbd8ad1543e/plan/ltp-timers/

  Test:     ltp-timers
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.138-cip15-10-g52cbd8ad1543e
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      52cbd8ad1543e12ef69b428c8535df3b2e60fa86

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  48cfd7a9977e6268b4aa2600608cebad7e0e42b8 =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/631699f27b489f05c4355673

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.138-cip15-10-g52cbd8ad1543e/x86_64/x86_64_defconfig+x86-chromebook/g=
cc-10/lab-collabora/ltp-timers-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.138-cip15-10-g52cbd8ad1543e/x86_64/x86_64_defconfig+x86-chromebook/g=
cc-10/lab-collabora/ltp-timers-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220826.0/amd64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/631699f27b489f05c43=
55674
        new failure (last pass: v5.10.131-cip13-84-g5fcbe4a63ab4d) =

 =20

