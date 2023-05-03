Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFA1FC77B75
	for <webhook@archiver.kernel.org>; Wed,  3 May 2023 15:52:30 +0000 (UTC)
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
 by mx.groups.io with SMTP id smtpd.web10.23643.1683129147673290481
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 03 May 2023 08:52:27 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=J5tlFjw5;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.171, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-64359d9c531so335409b3a.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 03 May 2023 08:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1683129146; x=1685721146;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zK6UmXBQLwQUi75TvEZLoowKLQ8Y47CvC6AUbYV/g+Q=;
        b=J5tlFjw5ek4/XZIfzqXtQQt9dj9w2Lz3ghTzvqc7HBqKdI86jR5g82V85m5P7TB6WR
         v+EOC8xOAg1gfFOmXn0dUa1C97CalnL4GuSLTCSnIZ6PsTT7QrO5YOi7bvKFpybbLEUL
         Sz6wp3HwukSvVFQVZPLOgUCmeLfjApVFW5mhmVn2en8tD43faQdatJg/1awLdqEF0Wo+
         SJugmpoPSbKyGvAD4kI4Eg4W/UNtgeQ8ZWevNLXbtnf1LD1+ZFkxM5yxMC0H+apG3TpI
         Xnad0ZZuUNbrQLLyWalHxeQt1qFfdHSlLpetRYxRo9MlG3MlwHYS+NoDJDzSUC2wVr9o
         mYpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683129146; x=1685721146;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zK6UmXBQLwQUi75TvEZLoowKLQ8Y47CvC6AUbYV/g+Q=;
        b=gk6XX+hzLR3qedGNTYQQJpQ8ddGFaHcT6lUrH4H5UMV4bTtGElYYBS8KIfLQJl0oOV
         IbAFbzPIPif+6ZNQpoyO5fOEXZ6/fdv3SgsHUIKyybStc/mG7JmsOU8VyqrL1PwZ586x
         4Q6qb1GNrXzyadZEi6Bqni6WRCWr3ctBdfsRyowFcV/9+OvmQv6uq6znb6/UqL6ldcIf
         d1sOluRnVrtKSTkhcFwoWlNPGQBtYfW+vM8KHYH9QaKCs2/7cH2nHvaLEC14n99RmTjE
         YUjPZGPlxjzuwQ5OeRjzpXzQarNNgx58jGTlKNT9qeS/SsYFIC7YR2aIMBc+p0tdMcE/
         4szA==
X-Gm-Message-State: AC+VfDyNiRaELH2vaU14Iwy/TZZ/xyx94Exr/jK+zF9WrnIhLTAOr4Us
	itSq1AqIShae4sQ+3nhc5OM7jsf0xJIru7L6oBjSnA==
X-Google-Smtp-Source: ACHHUZ71nEsBAeoZLvOM7rHyVA8+FihjrM/kee417W4KvP9ej4QzXdkzLQ/+M277dJC7IIwpDpC1WA==
X-Received: by 2002:a05:6a20:2d09:b0:f1:628:dcf3 with SMTP id g9-20020a056a202d0900b000f10628dcf3mr22142983pzl.27.1683129146474;
        Wed, 03 May 2023 08:52:26 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id b17-20020a62a111000000b00640f1e4a811sm14912518pff.22.2023.05.03.08.52.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 08:52:25 -0700 (PDT)
Message-ID: <64528339.620a0220.51d0a.e7e6@mx.google.com>
Date: Wed, 03 May 2023 08:52:25 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.4.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v4.4.302-cip72-372-ga3bc58e64f55
X-Kernelci-Report-Type: test
Subject: cip/linux-4.4.y-cip ltp-fcntl-locktests: 3 runs,
 1 regressions (v4.4.302-cip72-372-ga3bc58e64f55)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 03 May 2023 15:52:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11405

cip/linux-4.4.y-cip ltp-fcntl-locktests: 3 runs, 1 regressions (v4.4.302-ci=
p72-372-ga3bc58e64f55)

Regressions Summary
-------------------

platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.4.y-cip/kernel=
/v4.4.302-cip72-372-ga3bc58e64f55/plan/ltp-fcntl-locktests/

  Test:     ltp-fcntl-locktests
  Tree:     cip
  Branch:   linux-4.4.y-cip
  Describe: v4.4.302-cip72-372-ga3bc58e64f55
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      a3bc58e64f55aa72a4c70a5e27ee369c025756dd

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  ec58cf9bfb5588e6f831ee55aa6b10ebd790a826 =



Test Regressions
---------------- =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6452755936e6bc638b2e860e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip72-372-ga3bc58e64f55/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-co=
llabora/ltp-fcntl-locktests-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip72-372-ga3bc58e64f55/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-co=
llabora/ltp-fcntl-locktests-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230421.0/amd64/initrd.cpio.gz =



  * ltp-fcntl-locktests.login: https://kernelci.org/test/case/id/6452755936=
e6bc638b2e860f
        failing since 92 days (last pass: v4.4.302-cip71-590-g22fc523bf881,=
 first fail: v4.4.302-cip72) =

 =20

