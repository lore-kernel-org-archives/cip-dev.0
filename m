Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE6F4CCA473
	for <webhook@archiver.kernel.org>; Fri, 24 Jun 2022 17:14:18 +0000 (UTC)
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com
 [209.85.214.174])
 by mx.groups.io with SMTP id smtpd.web11.10415.1656090852551472334
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 24 Jun 2022 10:14:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=xcHb1GuB;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.174,
 mailfrom: bot@kernelci.org)
Received: by mail-pl1-f174.google.com with SMTP id l6so2620167plg.11
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 24 Jun 2022 10:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=uF8FVgNZzPUzTVG6iL4IrCGuKk0wJza2jFJSvZcMRz0=;
        b=xcHb1GuBCkKZC5TciFjpqgqp/WGplUWlxxhH2uJmNXUivASXXDyTfcmV9RTKHfQ+o+
         v4HAxXrXSRAKIhpKO81qaEadeUJynZpiTqwpv8DcOLGjZSNMoYsb/exJqR0cBgn1Ri6c
         QLB9zEZNksU6tfFxXT0RqAj2qUEslG5gEeVVIaA5DgZrLV+AhKypqKKBf+A21ydvgdPE
         r36ACkwOKZeKvvEb8SbulWxAE666bgAqVQ6kewnJAHrVuDr4F7CmKDiq+XkiUR9YGp+0
         oOpZ8gzn3GOAZnRDDiyzAeJJ9KE0l5TbOgcx4iLLppjDJ+kevgV9+S4vAwS1drLEF9rR
         FOfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=uF8FVgNZzPUzTVG6iL4IrCGuKk0wJza2jFJSvZcMRz0=;
        b=tmS8dmTL6Blr4q7SI3n/1hoXL/e47JGnveV89ZrjHjvAEDkbmnHAeYCrw3es6HKJsH
         SLQTJAB1BYqlAz5YzMzU9qwzuw71NpYlCw1umB8fcyfzW+3BnH/748P60/EKDSdKp8oY
         334tSHhWSgaCrBBnlA1AmXFLwo7K3Hl3WmR7rsLNDXSjhm56a0b8igLhCD6cB5sSuZxH
         JziSN1iHYF9VgMMuKJkJ7LkIgJfwu9crqdtkX1qWt5nS6NYMadWi8QMVjYo51O7l8W/P
         4hZpJXFws1HmZ+olbmz18HUy1aJ8rmgIpBM2Tyc3RGbetj3Jvmzg1N8bUJBfcGhlzhiX
         Sd0Q==
X-Gm-Message-State: AJIora9BDvHbXNbKmwjZglkAZW6hD6L+Sa1FdH8290XLTtrHsNHaj2kT
	JbkJSmWqFtlZP+FrUrieZD1UgDb+uPDgXEy4dto=
X-Google-Smtp-Source: 
 AGRyM1uEfr5rjqo5n8Or5zJe+7irHoSMd07CeMZlG+R5acInp1DiW8JeCg7g9a9TMC4WGYLrpgysng==
X-Received: by 2002:a17:902:b689:b0:167:8b69:d1a7 with SMTP id
 c9-20020a170902b68900b001678b69d1a7mr92989pls.156.1656090851919;
        Fri, 24 Jun 2022 10:14:11 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 jh19-20020a170903329300b0015e8d4eb2c0sm2051623plb.266.2022.06.24.10.14.05
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jun 2022 10:14:06 -0700 (PDT)
Message-ID: <62b5f0de.1c69fb81.9bc5a.301c@mx.google.com>
Date: Fri, 24 Jun 2022 10:14:06 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.121-cip9-272-g3fb28d4c623b
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-lkdtm: 7 runs,
 2 regressions (v5.10.121-cip9-272-g3fb28d4c623b)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 24 Jun 2022 17:14:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8596

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-lkdtm: 7 runs, 2 regre=
ssions (v5.10.121-cip9-272-g3fb28d4c623b)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...ok+kselftest | 1          =

hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...ok+kselftest | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.121-cip9-272-g3fb28d4c623b/plan/kselftest=
-lkdtm/

  Test:     kselftest-lkdtm
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.121-cip9-272-g3fb28d4c623b
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      3fb28d4c623b354373a844dd48f16cb4f005388e =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/62b5dd35ce7a5befe0a39bcd

  Results:     37 PASS, 17 FAIL, 25 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.121-cip9-272-g3fb28d4c623b/x86_64/x86_64_defconfig+x86-c=
hromebook+kselftest/gcc-10/lab-collabora/kselftest-lkdtm-asus-C433TA-AJ0005=
-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.121-cip9-272-g3fb28d4c623b/x86_64/x86_64_defconfig+x86-c=
hromebook+kselftest/gcc-10/lab-collabora/kselftest-lkdtm-asus-C433TA-AJ0005=
-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220610.0/amd64/initrd.cpio.gz =



  * kselftest-lkdtm.lkdtm_USERCOPY_STACK_FRAME_FROM_sh: https://kernelci.or=
g/test/case/id/62b5dd35ce7a5befe0a39bd3
        new failure (last pass: v5.10.118-465-g0af29783a3c9) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/62b5dd330cbb9f056aa39bfd

  Results:     36 PASS, 18 FAIL, 25 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.121-cip9-272-g3fb28d4c623b/x86_64/x86_64_defconfig+x86-c=
hromebook+kselftest/gcc-10/lab-collabora/kselftest-lkdtm-hp-11A-G6-EE-grunt=
.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.121-cip9-272-g3fb28d4c623b/x86_64/x86_64_defconfig+x86-c=
hromebook+kselftest/gcc-10/lab-collabora/kselftest-lkdtm-hp-11A-G6-EE-grunt=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220610.0/amd64/initrd.cpio.gz =



  * kselftest-lkdtm.lkdtm_USERCOPY_STACK_FRAME_FROM_sh: https://kernelci.or=
g/test/case/id/62b5dd330cbb9f056aa39c03
        new failure (last pass: v5.10.118-465-g0af29783a3c9) =

 =20

