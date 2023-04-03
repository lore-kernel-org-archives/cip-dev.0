Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1511EC77B60
	for <webhook@archiver.kernel.org>; Mon,  3 Apr 2023 12:52:15 +0000 (UTC)
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
 by mx.groups.io with SMTP id smtpd.web10.69144.1680526327718378639
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 03 Apr 2023 05:52:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=mdCJJIPP;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.51, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f51.google.com with SMTP id mp3-20020a17090b190300b0023fcc8ce113so32407802pjb.4
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 03 Apr 2023 05:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112; t=1680526327;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/wc/BYhlFKEl/dR+3dk0eGTxuLxEVTcjw6PuNJ2DA4s=;
        b=mdCJJIPPOW+1aq9zO78jFn0+zbyLiXL8U1Crk7YYOAeIvJ4fILAlfldldqLSarsnae
         aLEyiGYNd5lgzpWF03zbyNdssxyhBzM+rwibKmHf1mji3WgVXd9Q+zl2MtxmJl85nppB
         R2OnWy4gv1IIYKwRDs31/9yqOHQys8grfiwSqyhnzSKGxDPkip/GTtKFGAWAceeW9s44
         UIk7bRTl21PhG81kDiXQQ6y3OSIfYjA97mXz2BQYNh+gWEgRx2IxT45uXojcXKgb/9WD
         KZyhZg37ciXpzq417rZ4y2QqxvaOVO92DD7ChXYBEyz5lFY/o6E9mELgjzfXZo1WdzEs
         29NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680526327;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/wc/BYhlFKEl/dR+3dk0eGTxuLxEVTcjw6PuNJ2DA4s=;
        b=Ttv74611/rrQ7f4HHBcM8JneY0d8wI3SwCz6QRPSA53qbCItKniA4CkTk9GsxsbfST
         4Nf/FM347YmPLx9jIDkXLGHRXyTsL4bogrjaxM8D6KRs0CmkZ5NxiIZb1ydo/noy4RX3
         HeBOxPeq66+rtVuROlR1VuQBx5sx9v7tDWDlA7pASFo1/I67HzEL2A1+Z3Q64HDSJ3Ts
         yB2MW0Ry8lgBvGojTUDKlwxWE0ZIrfNm5l9uRMFmS6CQ92ZzXdCFkQTbKWvd1dKiX0de
         He20+A52J+kiUA26GH79XDk9wE6CHAczaN/sZpJwJIzI/IrWXvLjhqUat+8E3pcY9RLT
         ZGZg==
X-Gm-Message-State: AAQBX9dDYp3KYVTex1QFhI0XlVXgY9wFwUAmYzOdtdtM9ngraGAZHOj/
	apx/8LRtGYmptHuvSf/1tVt296u1hiqMg+q+S+8=
X-Google-Smtp-Source: AKy350YTAejHnUUqeHXt+jAbUVPqMhwVKMOw89HuC8Ug6pW5/l3tPsvfRnMR9NzLHvS1/ek4lh+jmg==
X-Received: by 2002:a17:90b:4f90:b0:23d:35d9:d05b with SMTP id qe16-20020a17090b4f9000b0023d35d9d05bmr40946330pjb.14.1680526326872;
        Mon, 03 Apr 2023 05:52:06 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id f12-20020a170902ab8c00b001a1c74554f3sm6513137plr.185.2023.04.03.05.52.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 05:52:06 -0700 (PDT)
Message-ID: <642acbf6.170a0220.80cb1.c3ca@mx.google.com>
Date: Mon, 03 Apr 2023 05:52:06 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-4.4.y-st
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.4-st20-1098-g8d34bf42efd9b
Subject: cip/linux-4.4.y-st ltp-fcntl-locktests: 3 runs,
 1 regressions (v4.4-st20-1098-g8d34bf42efd9b)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 03 Apr 2023 12:52:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11154

cip/linux-4.4.y-st ltp-fcntl-locktests: 3 runs, 1 regressions (v4.4-st20-10=
98-g8d34bf42efd9b)

Regressions Summary
-------------------

platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.4.y-st/kernel/=
v4.4-st20-1098-g8d34bf42efd9b/plan/ltp-fcntl-locktests/

  Test:     ltp-fcntl-locktests
  Tree:     cip
  Branch:   linux-4.4.y-st
  Describe: v4.4-st20-1098-g8d34bf42efd9b
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      8d34bf42efd9bbd9f2b159d4e40217ea530ba3ff

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  f41e8a2fa6f048d456ec2b136db9af50c7e42de8 =



Test Regressions
---------------- =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/642abe4aabdf42bf9b62f774

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-st/v4.4-st20-1=
098-g8d34bf42efd9b/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/ltp-fcntl-locktests-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-st/v4.4-st20-1=
098-g8d34bf42efd9b/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/ltp-fcntl-locktests-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230324.0/amd64/initrd.cpio.gz =



  * ltp-fcntl-locktests.login: https://kernelci.org/test/case/id/642abe4aab=
df42bf9b62f775
        failing since 68 days (last pass: v4.4-st20-234-g4e6ec7162c8e, firs=
t fail: v4.4-st20-821-g39bdf0444b23) =

 =20

