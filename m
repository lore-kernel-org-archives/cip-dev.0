Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D55F6C433FE
	for <webhook@archiver.kernel.org>; Tue, 22 Nov 2022 11:56:19 +0000 (UTC)
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
 by mx.groups.io with SMTP id smtpd.web10.16709.1669118178763423860
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 22 Nov 2022 03:56:18 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=iSMfJ+ZU;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.43, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f43.google.com with SMTP id v3-20020a17090ac90300b00218441ac0f6so1402255pjt.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 22 Nov 2022 03:56:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=AOM1ib+rSo2/qAoVMhHjY/d+grC/arDF27rm7HwOs0g=;
        b=iSMfJ+ZUaZYlXqXeDBr9wj9XZDUbWEphqOvvEfTrHXHAJvCRRKLlxstXcciWo5N9YB
         GynkwW2rFE8aQ/ObilK/xWRflNckcWnckBvSCGbHXlpg5oZN9tveey4RrZxpC/rTCbc2
         w+g7bt5mVxX2Y04P6hoCNrVuihSG9z5VTnr4eKjK/CPAacD/6VYCI44+4SzwX5VUisXQ
         AnChoUiOx+EBXUgH7QvKEvyRaCQlrbCqoImxK7lIRYc3/Bo4yIQenRZcRgqDFP2rLiil
         UwsleFzKwpUQMlUwJwiGkRC4OkYfqlKgoR1K00+puFqE2lyf+hd3+i9DH8QSIYnPc6bT
         jTPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AOM1ib+rSo2/qAoVMhHjY/d+grC/arDF27rm7HwOs0g=;
        b=PyxFxTRabYDAmwEodIA09djo//qDyDq+1LZlvY3db+DlBlGZYvHK5LzqN4Byo6nXrK
         Q9HoMNSfUH6xKciSouH3Rs6KsxUX3+v33TR+6c722g4sYeUSKAVBLbRT6O5trItgSKXX
         5gEZCtvknm+p0SG4oIu+IM0rcwSANcHG1nFR4eEKSjpLcXTRR3daiACYmjmmPJlr+byl
         wNCcG3ffdPuIVHpqu6Ll99QendilBfIGpoKT4msjsy576FqJpHmRfpbu4uUT1S1tSqM1
         8r2AjyBcdQ9qPqsddeA5jr2uowR2sZl5ksj8Dv0LdiewKRWT57i7Jd2JZmzeLcGRriNp
         nKjA==
X-Gm-Message-State: ANoB5pkMYDJJnB4C5fP4IILZ6Xffiz51E9txWtfsa5fQq/SDiYyQ6xox
	zQb64l17S0F/P773ehPL8TGb3BVgD7QFWtvH8cU=
X-Google-Smtp-Source: AA0mqf5+Bazhq9e7G41elU8SR5tgAwqWAqjRJW4N/378TeOkNtilH1S6F/hmDBm8QGrH0RbXYG0ICw==
X-Received: by 2002:a17:90a:8b03:b0:213:16d2:4d4c with SMTP id y3-20020a17090a8b0300b0021316d24d4cmr25725602pjn.70.1669118177816;
        Tue, 22 Nov 2022 03:56:17 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id h15-20020a170902f54f00b00188fdae6e0esm9994038plf.44.2022.11.22.03.56.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 03:56:17 -0800 (PST)
Message-ID: <637cb8e1.170a0220.b6f60.eb45@mx.google.com>
Date: Tue, 22 Nov 2022 03:56:17 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.4.y-cip
X-Kernelci-Kernel: v4.4.302-cip70-236-g69445bc0d4209
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip
Subject: cip/linux-4.4.y-cip ltp-fcntl-locktests: 3 runs,
 1 regressions (v4.4.302-cip70-236-g69445bc0d4209)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 22 Nov 2022 11:56:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10074

cip/linux-4.4.y-cip ltp-fcntl-locktests: 3 runs, 1 regressions (v4.4.302-ci=
p70-236-g69445bc0d4209)

Regressions Summary
-------------------

platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.4.y-cip/kernel=
/v4.4.302-cip70-236-g69445bc0d4209/plan/ltp-fcntl-locktests/

  Test:     ltp-fcntl-locktests
  Tree:     cip
  Branch:   linux-4.4.y-cip
  Describe: v4.4.302-cip70-236-g69445bc0d4209
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      69445bc0d4209b0634d1f43657fd58f708cadf81

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  a15eb3cdfa3556203167572e15754f1f59ba26bf =



Test Regressions
---------------- =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/637cb0b821916fd92e2abd24

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip70-236-g69445bc0d4209/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-c=
ollabora/ltp-fcntl-locktests-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip70-236-g69445bc0d4209/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-c=
ollabora/ltp-fcntl-locktests-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20221107.1/amd64/initrd.cpio.gz =



  * ltp-fcntl-locktests.login: https://kernelci.org/test/case/id/637cb0b821=
916fd92e2abd25
        new failure (last pass: v4.4.302-cip70-98-g7f7838c92740f) =

 =20

