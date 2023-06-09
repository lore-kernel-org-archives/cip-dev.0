Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3213BC7EE2E
	for <webhook@archiver.kernel.org>; Fri,  9 Jun 2023 16:20:00 +0000 (UTC)
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
 by mx.groups.io with SMTP id smtpd.web10.17653.1686327599300335519
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 09 Jun 2023 09:19:59 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=x6QFZQZJ;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.181, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1b021cddb74so7559845ad.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 09 Jun 2023 09:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1686327598; x=1688919598;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=esmT7Wm/q4qw/RtQRU4ZZ3FPOQwtIeTsFdW9Ys5IkAI=;
        b=x6QFZQZJGva5dGYH1NwNnJlClFPxUxqxOf2eXqJlssGsIzYwECSDOY4ztFh7WEyrZc
         Y9o448z4yCRG5q64tqUqzk792rRhLMjyxSjwi0b7yKbI1Ld5SUZpBkvwQwr/QGTZmMCW
         X0x9DX1cUuck1KeK0Xb9v34wdHu/lg+G97YtN7nau5HH+cr6hQPJk+WdMR1pTZJH+4Ul
         WOJ8zkDZ/U5kKdE3TUFa2lJv8vye1pDNHfCRIcC4KlZ2M+9QY//BJtYlitJA7UCXKN38
         jEB6WxO+2GL2gjiLdXaALPB6ZPN3mpBm7aK9tenXYMC97QzHwr081gKbvX1MWta+MJkS
         f1Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686327598; x=1688919598;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=esmT7Wm/q4qw/RtQRU4ZZ3FPOQwtIeTsFdW9Ys5IkAI=;
        b=awtLJb6L/wH3cnPyBt2cVc44ZrezZoXNmZstbjiR391FwfJRdeWF0ybNKX2zkjqmTg
         CR9ulkrC1d5gHpEoBiZ7avhK/HdgsNMVBQL7PzKfOyRP1lg5MInMUF5f+fxvGsLpblNv
         4tCI2r08oKNaA9aaR9Ejb1gH6URLOmdr8k9qGrlTAOqH9uwNMbpTcV2enkITlv13S9t6
         Es1JFQnuL0ig3KwhmBrm7e73WyJpf9xwzk4YPHty4WFe6hwtVVLDQ3EEKHHRM2zr9xk2
         +KTq/F+mwjA1MXLA4sDPgxIld3Mdk/3hZu3umwnX051L8w6MHB6qtBseLcshPNxIVxPq
         kqfQ==
X-Gm-Message-State: AC+VfDx9Rfpu99bNHsY0KIHcx2i7NzHcg/9rJ9N3fJQz4J6qWb8Rdf/I
	rxUELG1MDqLjYbPDZaI0sjA4kE8gQwXoOjQIbahWVA==
X-Google-Smtp-Source: ACHHUZ6zT7XC1I/bR0hznIv3ZbEXnCWSXG8DHwKaH1qKu0cX4B8SGTWbJ6KpD8NBAx4lq8JCIraJ9A==
X-Received: by 2002:a17:902:c649:b0:1a6:46f2:4365 with SMTP id s9-20020a170902c64900b001a646f24365mr1166289pls.30.1686327598113;
        Fri, 09 Jun 2023 09:19:58 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id g7-20020a1709026b4700b001ab2b415bdbsm3469212plt.45.2023.06.09.09.19.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 09:19:57 -0700 (PDT)
Message-ID: <6483512d.170a0220.46dc1.7014@mx.google.com>
Date: Fri, 09 Jun 2023 09:19:57 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.19.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.19.284-cip99
Subject: cip/linux-4.19.y-cip ltp-mm: 5 runs, 2 regressions (v4.19.284-cip99)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 09 Jun 2023 16:20:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11946

cip/linux-4.19.y-cip ltp-mm: 5 runs, 2 regressions (v4.19.284-cip99)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig          =
        | 1          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm64-chr=
omebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.19.y-cip/kerne=
l/v4.19.284-cip99/plan/ltp-mm/

  Test:     ltp-mm
  Tree:     cip
  Branch:   linux-4.19.y-cip
  Describe: v4.19.284-cip99
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      a13de4c6b84ab64a5cb3ef5e852b1620686d0309

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  604701dc19c5499403ae5afe48103b8e2872952b =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig          =
        | 1          =


  Details:     https://kernelci.org/test/plan/id/648349f913ca029c4c30614b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.284=
-cip99/arm64/defconfig/gcc-10/lab-cip/ltp-mm-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.284=
-cip99/arm64/defconfig/gcc-10/lab-cip/ltp-mm-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230527.0/arm64/initrd.cpio.gz =



  * ltp-mm.login: https://kernelci.org/test/case/id/648349f913ca029c4c30614c
        failing since 510 days (last pass: v4.19.222-cip64, first fail: v4.=
19.225-cip65) =

 =



platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm64-chr=
omebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64834e887004e71ef83061aa

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.284=
-cip99/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/ltp-mm-r8a774a1-hiho=
pe-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.284=
-cip99/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/ltp-mm-r8a774a1-hiho=
pe-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230527.0/arm64/initrd.cpio.gz =



  * ltp-mm.login: https://kernelci.org/test/case/id/64834e887004e71ef83061ab
        failing since 510 days (last pass: v4.19.222-cip64, first fail: v4.=
19.225-cip65) =

 =20

