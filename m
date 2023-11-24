Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACCEDC61DF7
	for <webhook@archiver.kernel.org>; Fri, 24 Nov 2023 00:19:02 +0000 (UTC)
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
 by mx.groups.io with SMTP id smtpd.web11.122236.1700785133938991458
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 23 Nov 2023 16:18:54 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=YzQDY4V7;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.178, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6c115026985so1359989b3a.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 23 Nov 2023 16:18:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1700785132; x=1701389932; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=IElkbc16QjboY2UuNrw8Ug8rRv5AD7ZgPwQYyiAFPaU=;
        b=YzQDY4V7MMfqy8ttu/oeU0QPhGhrtni52fJg3dPrBHW8pD/mImeuxYtYxYI1ZNIqbk
         V5NsxqbgGB+bACFPjVQyImDzFov5WfJqJtWX4g4rQPIc8PQxevufupqzTC2/ZQm3+9lL
         j4GqjjDAnWWpzwbtqiz/9Gn8ZITBA9Rc3qJEbQmVwmpcSDA5nOsoJ4RiOc9l4wNeFQ9g
         Xxx+4uPjSq7IDAY8dsFZTJXA0rz9WC3+9OCRN3UDatvBlj4Mk5mO9iZ4wiwJw8NJN2VV
         lq+Tk9xnEUncuU09eEZ77R77r7ALS1JEG5I6B70XaY0u2yopDxGyR8bfDUsfn1cVWBM7
         q68w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700785132; x=1701389932;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IElkbc16QjboY2UuNrw8Ug8rRv5AD7ZgPwQYyiAFPaU=;
        b=rlzqJ22d83BHSFCGXaegx4Vk3cRP9JGgJhuAJqH0+KYeMsag+A3W4lnkN1oIInMK2W
         8HrcNFmI/FdDCSgYW4EafGD0I7vWyH1bdOIla+R1hFtS5+oGJ15sGbhjAOAmOyhu1QsV
         5PS+inIijrSQEhtiZHR0d28zlSItOgSxftCrw4003ektwCawQmEyn/nFKy2GWi8orW5q
         prMzvoMOpScVvJ5isncLd7YC+yM3NiXvVM0ppP8T07OiWRsFesI2yf+MwxtEK6klXX9A
         /+6UsGH7RWC4Hy12TJptjIAnEfEXhX7wK0bo6eIxt9Q9eA73HWPMqQeOo519vZwks9Kg
         2q9g==
X-Gm-Message-State: AOJu0YyESMJhMsZG/acTPCe+PlVEtruOuDkgOfCL1n5dPGA5J5KYwfXC
	LgqyaZEbrE9nImigCUJaa+vb/PccQHPUjV3L48k=
X-Google-Smtp-Source: AGHT+IHh/BAlwcJLGREY77OVosCG0UazFw3pg1bytdDNH1CA0K0GWib4Ryvzq2nqMcuiyxk2vY1LqA==
X-Received: by 2002:a05:6a00:44cd:b0:6c3:6148:570f with SMTP id cv13-20020a056a0044cd00b006c36148570fmr1329239pfb.33.1700785132375;
        Thu, 23 Nov 2023 16:18:52 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id n7-20020a634007000000b005c2185be2basm1935215pga.54.2023.11.23.16.18.51
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 16:18:51 -0800 (PST)
Message-ID: <655febeb.630a0220.f3733.5189@mx.google.com>
Date: Thu, 23 Nov 2023 16:18:51 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v5.10.201-rt98-828-g27523c64bc5dd
Subject: cip-gitlab/ci/pavel/linux-test kselftest-futex: 9 runs,
 1 regressions (v5.10.201-rt98-828-g27523c64bc5dd)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 24 Nov 2023 00:19:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13694

cip-gitlab/ci/pavel/linux-test kselftest-futex: 9 runs, 1 regressions (v5.1=
0.201-rt98-828-g27523c64bc5dd)

Regressions Summary
-------------------

platform         | arch | lab     | compiler | defconfig          | regress=
ions
-----------------+------+---------+----------+--------------------+--------=
----
beaglebone-black | arm  | lab-cip | gcc-10   | multi_v7_defconfig | 1      =
    =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.201-rt98-828-g27523c64bc5dd/plan/kselftest-futex/

  Test:     kselftest-futex
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.201-rt98-828-g27523c64bc5dd
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      27523c64bc5dd6f1af1b227b80017fea69e616b6 =



Test Regressions
---------------- =



platform         | arch | lab     | compiler | defconfig          | regress=
ions
-----------------+------+---------+----------+--------------------+--------=
----
beaglebone-black | arm  | lab-cip | gcc-10   | multi_v7_defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/655fe2669bef40efda7e4a89

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-rt98-828-g27523c64bc5dd/arm/multi_v7_defconfig/gcc-10/lab-cip/ks=
elftest-futex-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-rt98-828-g27523c64bc5dd/arm/multi_v7_defconfig/gcc-10/lab-cip/ks=
elftest-futex-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/armhf/initrd.cpio.gz =



  * kselftest-futex.login: https://kernelci.org/test/case/id/655fe2669bef40=
efda7e4a8a
        new failure (last pass: v5.10.200-cip40-513-g195b5d2b5c744) =

 =20

