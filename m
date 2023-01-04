Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A142C46467
	for <webhook@archiver.kernel.org>; Wed,  4 Jan 2023 13:22:03 +0000 (UTC)
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
 by mx.groups.io with SMTP id smtpd.web10.11792.1672838520603635676
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 04 Jan 2023 05:22:01 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=kha3rmcH;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.178, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f178.google.com with SMTP id g16so26181809plq.12
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 04 Jan 2023 05:22:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=95s2nl9HCOETUP/s2L170kGM3vIPToir9snf9p1ryMc=;
        b=kha3rmcH+A/M/ULY6p4VxbGpd7fHyp2iewqRhcQEf+qZUqR0iNpMrSdctZBHmYGTBK
         MhLKNC6DygwP+yAuRu289W2vaTtw6Dq1PtlNCvlRjOIlMtnC90bFjF98qHjB/WJCh69l
         tAoI+2W1sHEOwHRjMwnBw0hWJOCWfqhvhOAm7AN03NxfDGMKE/kfitlSEDNvJO1Ogf02
         Amz3HGWtv0UACqH+Ug3FhDuPt6dcoZfv+KU+Ypi7bMrafSsMLlQIOGp9WS758YIiPmQA
         2OKTltFZE/mg/HMOIHJCRzE0ruGdQ1qy949boJ/dtXebGJ12xExCCZStrfzEmiLkT9BZ
         3VEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=95s2nl9HCOETUP/s2L170kGM3vIPToir9snf9p1ryMc=;
        b=xrgrpveTcVeqU5BdDlczD337HDWnlZybVoCqz6u+dNsNf4FjZP7Rxnmb05wdhAUXaO
         jDFbHEb7egdJAA6WpeOweeCGMzs4RjaHGYm8ONrlVe5VPAPlq2619NCsBS7wXBZ1ebOI
         si5zyrVVaOOypPZN8ZI/axPUsliRtw3tAZsY5BNF1stMm75mLZHRicsb2NSBtchPSMhH
         0diw34boiCRAATcl9ZUesIOTygRB8cDE13tu13y2qjPhtlFAlo9rCUsDjP9QUzNewy09
         aCMW//oeOxIU4zkFJOrgMC/c1+SC9FfxgH6yaRAmmjLm5DddKyblmFNNdzKq7V3I8gwv
         btJA==
X-Gm-Message-State: AFqh2koUiVJ0NSc+FKudEtO4BOhHHBBh6Y03CcQ36D430RLhOoH7EWZj
	tLfkTKBKy59Ax95fKcdRldOh2coRg8wI/UmbT2E=
X-Google-Smtp-Source: AMrXdXthMHqxz47Qp2pJhdC8/SpCjrTEvoMBE95wSZqU83JR1GSW4cekO/vLuChbt1NmAP4Y0HDThA==
X-Received: by 2002:a05:6a21:1518:b0:af:c2b6:2f8e with SMTP id nq24-20020a056a21151800b000afc2b62f8emr60137440pzb.24.1672838520883;
        Wed, 04 Jan 2023 05:22:00 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id n20-20020a170902d0d400b00186c3afb49esm8909092pln.209.2023.01.04.05.22.00
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 05:22:00 -0800 (PST)
Message-ID: <63b57d78.170a0220.2eaf3.c569@mx.google.com>
Date: Wed, 04 Jan 2023 05:22:00 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.10.161-cip23-65-gca8c192cb189
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-lib: 13 runs,
 3 regressions (v5.10.161-cip23-65-gca8c192cb189)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 04 Jan 2023 13:22:03 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10304

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-lib: 13 runs, 3 regres=
sions (v5.10.161-cip23-65-gca8c192cb189)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig          =
          | regressions
-------------------------+-------+---------+----------+--------------------=
----------+------------
beaglebone-black         | arm   | lab-cip | gcc-10   | multi_v7_defconfig+=
kselftest | 1          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+kselftest=
          | 1          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm...ok+=
kselftest | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.161-cip23-65-gca8c192cb189/plan/kselftest=
-lib/

  Test:     kselftest-lib
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.161-cip23-65-gca8c192cb189
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      ca8c192cb189c6be84da2274a96e73320a638b43 =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig          =
          | regressions
-------------------------+-------+---------+----------+--------------------=
----------+------------
beaglebone-black         | arm   | lab-cip | gcc-10   | multi_v7_defconfig+=
kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/63b57bc5b04998e2484eee4b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.161-cip23-65-gca8c192cb189/arm/multi_v7_defconfig+kselft=
est/gcc-10/lab-cip/kselftest-lib-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.161-cip23-65-gca8c192cb189/arm/multi_v7_defconfig+kselft=
est/gcc-10/lab-cip/kselftest-lib-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221230.0/armhf/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/63b57bc5b04998e2=
484eee4c
        new failure (last pass: v5.10.158-cip22-142-g79bb6f9db05d) =

 =



platform                 | arch  | lab     | compiler | defconfig          =
          | regressions
-------------------------+-------+---------+----------+--------------------=
----------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+kselftest=
          | 1          =


  Details:     https://kernelci.org/test/plan/id/63b5706356994fb5c24eee21

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.161-cip23-65-gca8c192cb189/arm64/defconfig+kselftest/gcc=
-10/lab-cip/kselftest-lib-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.161-cip23-65-gca8c192cb189/arm64/defconfig+kselftest/gcc=
-10/lab-cip/kselftest-lib-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221230.0/arm64/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/63b5706356994fb5=
c24eee22
        new failure (last pass: v5.10.158-cip22-142-g79bb6f9db05d) =

 =



platform                 | arch  | lab     | compiler | defconfig          =
          | regressions
-------------------------+-------+---------+----------+--------------------=
----------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm...ok+=
kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/63b57ae68847bbf5f44eee2a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.161-cip23-65-gca8c192cb189/arm64/defconfig+arm64-chromeb=
ook+kselftest/gcc-10/lab-cip/kselftest-lib-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.161-cip23-65-gca8c192cb189/arm64/defconfig+arm64-chromeb=
ook+kselftest/gcc-10/lab-cip/kselftest-lib-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221230.0/arm64/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/63b57ae68847bbf5=
f44eee2b
        new failure (last pass: v5.10.158-cip22-142-g79bb6f9db05d) =

 =20

