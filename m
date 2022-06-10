Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52995C433EF
	for <webhook@archiver.kernel.org>; Fri, 10 Jun 2022 12:20:39 +0000 (UTC)
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com
 [209.85.214.176])
 by mx.groups.io with SMTP id smtpd.web08.26384.1654863632099052735
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 10 Jun 2022 05:20:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=se2pkLZ3;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.176,
 mailfrom: bot@kernelci.org)
Received: by mail-pl1-f176.google.com with SMTP id f8so3601901plo.9
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 10 Jun 2022 05:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=LlVOAInCpYlDbRoE7Lwqww0qGXGhLrXLJixwrLAez9k=;
        b=se2pkLZ31EebzL8Ds/2HjPv5lvO2o1f7t3qY3KM51OtDjbJO8bqo2hacJ7cy5OGXZP
         RyMvWmfI7X8WVHZ9tKegtUPkUof8KgzJO41N62hOEqmBQzqE8/+BV6bf6TmPJXl2w0pM
         bL1iGr0gndCgyNpCOaNR5WUQy/uEt/WhX3fOuBrA/tHV9qmtDikiqUm0vl6CSNz7ONlY
         aI+78Tt4mL2ZgeXWZI2IzNskao9QzbHM1uFhXNQ7oSc0AsK895MI+wyIKkb4puQQmPer
         QsUeTHz7UFUVyynEtK1HjsnEWGi/VR21U8yZ61Iya5qWvVokBowkTGLcGKXsv0t1wvCe
         MD7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=LlVOAInCpYlDbRoE7Lwqww0qGXGhLrXLJixwrLAez9k=;
        b=2TI5urD81lw/PIe4hJJW3BFcgPDQx1rzwBC1Ho0/dSGFbKMzIh3ia7ePQMcRchGgxV
         If6aktsURSgOAyPNacmXf0rFifO6HwYLq3ID6ur8G7SE00g85GE+LtZw83CzRkhggyQx
         n6jM4JDvNF7EK8ByX4VrnJUYnT7CFXFWwKpXHEDdwvXH54IxljR7owqhmWBVjGUyocHV
         XMgb2UZnMTMYgpH7olBtGzWElw94goQSSeQ5W4r4OLL5GauTNUWtrRPu5KeoxXE+SzfG
         MNXJEK+g8PogDHVYQAyGryaN5V/YnN7nBWK/B4DKdEIrAUMjGTBvkeW99BMz+pXNr7o+
         KAtg==
X-Gm-Message-State: AOAM530uPyRbOuUJiRFkyqQiUfeDEf6JVDjKSk2cWc4O9HzC7jF8Ec2N
	9gO4RDcJTtedOzaAwZ4uU9dl9kcxZzBn5jTAJ8Q=
X-Google-Smtp-Source: 
 ABdhPJyj9rhWLUF3BSNlC9wiF5wrLKOuVgSMAcie35AhCcN6tOeoszqgRzDhjqaA13wksghKcFonNA==
X-Received: by 2002:a17:90b:1e4f:b0:1e8:4e3c:e212 with SMTP id
 pi15-20020a17090b1e4f00b001e84e3ce212mr8558996pjb.25.1654863631436;
        Fri, 10 Jun 2022 05:20:31 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 u1-20020a1709026e0100b0015eb200cc00sm18693427plk.138.2022.06.10.05.20.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jun 2022 05:20:30 -0700 (PDT)
Message-ID: <62a3370e.1c69fb81.14bfb.46ba@mx.google.com>
Date: Fri, 10 Jun 2022 05:20:30 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.19.246-cip75
X-Kernelci-Branch: linux-4.19.y-cip
X-Kernelci-Tree: cip
Subject: cip/linux-4.19.y-cip ltp-mm: 3 runs, 2 regressions (v4.19.246-cip75)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 10 Jun 2022 12:20:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8540

cip/linux-4.19.y-cip ltp-mm: 3 runs, 2 regressions (v4.19.246-cip75)

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
l/v4.19.246-cip75/plan/ltp-mm/

  Test:     ltp-mm
  Tree:     cip
  Branch:   linux-4.19.y-cip
  Describe: v4.19.246-cip75
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      38ce181ac6ca9f3decdd389cbfd0a38fecdb28c7

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  aa0d8ff94a7df8b63b81f185b261bc9f24bf36fc =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig          =
        | 1          =


  Details:     https://kernelci.org/test/plan/id/62a32f9c2b790927f1a39c03

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.246=
-cip75/arm64/defconfig/gcc-10/lab-cip/ltp-mm-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.246=
-cip75/arm64/defconfig/gcc-10/lab-cip/ltp-mm-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220603.0/arm64/initrd.cpio.gz =



  * ltp-mm.login: https://kernelci.org/test/case/id/62a32f9c2b790927f1a39c04
        failing since 146 days (last pass: v4.19.222-cip64, first fail: v4.=
19.225-cip65) =

 =



platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm64-chr=
omebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62a3328271cbd81e5fa39be5

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.246=
-cip75/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/ltp-mm-r8a774a1-hiho=
pe-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.246=
-cip75/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/ltp-mm-r8a774a1-hiho=
pe-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220603.0/arm64/initrd.cpio.gz =



  * ltp-mm.login: https://kernelci.org/test/case/id/62a3328271cbd81e5fa39be6
        failing since 146 days (last pass: v4.19.222-cip64, first fail: v4.=
19.225-cip65) =

 =20

