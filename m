Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2423C7EE2E
	for <webhook@archiver.kernel.org>; Mon,  5 Jun 2023 18:37:44 +0000 (UTC)
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
 by mx.groups.io with SMTP id smtpd.web11.17019.1685990255928283384
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 05 Jun 2023 11:37:36 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=Hn2WNg5f;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.169, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-543ae674f37so869521a12.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 05 Jun 2023 11:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1685990255; x=1688582255;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=HZ/FDm+KmzQYimIjeifBQSMaQzqJSAZouWrhVzV2edk=;
        b=Hn2WNg5fUTr7Wq/0ZixxlSiAQb0NIMv/tZfxbGh0kMN5VbfGeh6D06xQBOE1roGQCF
         izfHhpQWxyh1bkOnQt4u04xv/97TrdOmVnxBWccXhJJeTArRzOpwdw6BsJT32iq+i7lj
         V/9ucUbtUumICt7aWsvHuuB3n5xwjrYNn9C6M6gpzoY8KtVrR1RWlF57gXz90a3eKyYJ
         RcDRCWKnJUSelF001g+uKkG74ljfYc8yxmDtRk7mC1OhvGQ6fbga1JH6L5J3Iqs+UkVy
         tJrS3M2glQsIMffsslKnbcdhNvSNmfMkgDZ/C5HU6xDxRFcyyZ7SyZ6iuXMcvjs2vnGb
         dFoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685990255; x=1688582255;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HZ/FDm+KmzQYimIjeifBQSMaQzqJSAZouWrhVzV2edk=;
        b=jXqgSNDaZA+G42vW8XchT1MRY4gi68BdXn79ibBhxu1+G7mGnCjNC/tC7JRFhRUeAJ
         vDSIcdx+MJlploWRrs7TWhlA5LRfI24lHqJ3nnmV7p8R6ZNaiM+2GL6t3Ma+6HYFb02x
         GPRuSbpgMpHHSVgnEtDumSvjk4cUVOb7b6tN4Uy2vM9cpROQpD3wMBJsqmBchTuKX0bA
         R5q1Xhv+ePs8/6boLyFptMn3H+rFD/1vismt6QOPXmYHy1s4W0HWTIOX15ryZHzK1NR1
         DmDxy2Cf+AleRNIxmJUbeIm0nyAuIAlI7nj4y9A8XILOWW7ybk4lN/Al7waeN0bnsy4N
         qZDw==
X-Gm-Message-State: AC+VfDzLHmMqN6Bv7RRwVDzJvpyP587WaUI1yaKWGbym7ea0sG5DzvC5
	QtWckkZ0TJ6g3q5sLK6AwYgvhQIyeBS0KVLlpYSznw==
X-Google-Smtp-Source: ACHHUZ7AdIxoDyXjlQjwEmvk1j+lp5eaeUr1W3F86m3jgSmw6H8qH4nUCy/TZ2SJB5Zj5z+jtMFaIQ==
X-Received: by 2002:a05:6a21:394c:b0:10b:d3e0:78a7 with SMTP id ac12-20020a056a21394c00b0010bd3e078a7mr2353271pzc.61.1685990254745;
        Mon, 05 Jun 2023 11:37:34 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id 7-20020aa79207000000b0064fdcc6b901sm5520261pfo.74.2023.06.05.11.37.34
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 11:37:34 -0700 (PDT)
Message-ID: <647e2b6e.a70a0220.c565a.97e1@mx.google.com>
Date: Mon, 05 Jun 2023 11:37:34 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.10.180-cip34-26-gc198172c84b6a
X-Kernelci-Report-Type: test
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/pavel/linux-test kselftest-futex: 10 runs,
 2 regressions (v5.10.180-cip34-26-gc198172c84b6a)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 05 Jun 2023 18:37:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11818

cip-gitlab/ci/pavel/linux-test kselftest-futex: 10 runs, 2 regressions (v5.=
10.180-cip34-26-gc198172c84b6a)

Regressions Summary
-------------------

platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =

mt8173-elm-hana          | arm64  | lab-collabora | gcc-10   | defconfig+ar=
m64-chromebook   | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.180-cip34-26-gc198172c84b6a/plan/kselftest-futex/

  Test:     kselftest-futex
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.180-cip34-26-gc198172c84b6a
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      c198172c84b6a9338925de15df053d71eda6a6cc =



Test Regressions
---------------- =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/647e19095f65c995e8f5deb8

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.180-cip34-26-gc198172c84b6a/x86_64/x86_64_defconfig+x86-chromebook/g=
cc-10/lab-collabora/kselftest-futex-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.180-cip34-26-gc198172c84b6a/x86_64/x86_64_defconfig+x86-chromebook/g=
cc-10/lab-collabora/kselftest-futex-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230527.0/amd64/initrd.cpio.gz =



  * kselftest-futex.login: https://kernelci.org/test/case/id/647e19095f65c9=
95e8f5deb9
        new failure (last pass: v6.1.26-1298-g61395b9756bd5) =

 =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
mt8173-elm-hana          | arm64  | lab-collabora | gcc-10   | defconfig+ar=
m64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/647e1d03f8ac233bfef5de65

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.180-cip34-26-gc198172c84b6a/arm64/defconfig+arm64-chromebook/gcc-10/=
lab-collabora/kselftest-futex-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.180-cip34-26-gc198172c84b6a/arm64/defconfig+arm64-chromebook/gcc-10/=
lab-collabora/kselftest-futex-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230527.0/arm64/initrd.cpio.gz =



  * kselftest-futex.login: https://kernelci.org/test/case/id/647e1d03f8ac23=
3bfef5de66
        new failure (last pass: v6.1.26-1298-g61395b9756bd5) =

 =20

