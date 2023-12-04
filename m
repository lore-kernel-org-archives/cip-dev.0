Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9D07C46CA0
	for <webhook@archiver.kernel.org>; Mon,  4 Dec 2023 00:34:37 +0000 (UTC)
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
 by mx.groups.io with SMTP id smtpd.web10.53726.1701650072417492290
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sun, 03 Dec 2023 16:34:32 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=uQqjJ1fH;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.161.46, mailfrom: bot@kernelci.org)
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-58d54612d9cso2703616eaf.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Sun, 03 Dec 2023 16:34:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1701650071; x=1702254871; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=eJRq3oPZ3OVJHoKYKZSJF1PK6jPjsk25OO6HrIlSHVY=;
        b=uQqjJ1fHekZPgWKB0eF+Rw9SdJFOdejrTIytcgC7J1Omsvl3I0OOGSor1DxMs++3uv
         j2kWfADXlHLiNCEvdvaJgZNbgK0xnYToQ15SQumXqbfiKVWQBm7ZrYHBZbqAIRVE1PM0
         WbnlFQQvDCG2nWULFqz/Ws9Rz3390+ENIrdUumvZBnck3z7OhwdO2cImVM4Nst7PK1Ac
         dzt8SobJkKqYaMi3R6qMoJsYXk1knFwH5pRwyEI5J+HejqZKYyW3HyY/ZUxfwQPFRJ9l
         CbFXZptr5V3AbdYgd0IpCBA58510Ev/BhQQ+G8zPWCv0nW8M7/+s1LwPmIjsRrsqSN5a
         ByOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701650071; x=1702254871;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eJRq3oPZ3OVJHoKYKZSJF1PK6jPjsk25OO6HrIlSHVY=;
        b=Lorq5FLH4s1n9sMWqK5uR4nH8vO1QAZpsy9PQLiLGX6Jvg7O8fpSVKgolziJjEl4Df
         HNN6b6SqFvbns8yUWH+vwfSBGLWQmL2wnSUB+3XO+hVB7a/3VI9lw2TSfkvkY4TNX1Gw
         /LOFzrWCcCUVRVCZnFt+vyN75klshVCGqa9SxximrDY3l4GrrkDu2mHdor80kUBjHeMC
         whXPKFhRmtMF+OdDzL1+7y58Ega5M1RIY9RGGVrcpEuwmkDqu6OnHQMduGYWNoPtERyH
         nAAQIiTrVlHLNVR+CnUmOfdQCGQOIu7dhDQ14EjByog3MU0k0woB1IypEBdvSaghefLf
         xwlQ==
X-Gm-Message-State: AOJu0Yxek8qfwu6hteXYFG4gcWxAN0+pDE74VxS7/67H7b0RqdoVzrSn
	KYU1WRo0bgYyBeY3liLIX7N/188oejmqPAE41X5oEw==
X-Google-Smtp-Source: AGHT+IHt8rvwGBzFHOHx4Rs2NHgp2+/JHqaQPCjEgg8WG3EQEXpRqBIx+YvzZC+Tmz7Duc0w2V4xdw==
X-Received: by 2002:a05:6358:898:b0:16d:bbb3:69c6 with SMTP id m24-20020a056358089800b0016dbbb369c6mr2893728rwj.13.1701650070833;
        Sun, 03 Dec 2023 16:34:30 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id s16-20020a056a00179000b006c0316485f9sm2186969pfg.64.2023.12.03.16.34.29
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Dec 2023 16:34:30 -0800 (PST)
Message-ID: <656d1e96.050a0220.43db9.4403@mx.google.com>
Date: Sun, 03 Dec 2023 16:34:30 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.1.64-cip10-rt5
Subject: cip-gitlab/ci/pavel/linux-test kselftest-futex: 11 runs,
 1 regressions (v6.1.64-cip10-rt5)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 04 Dec 2023 00:34:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13785

cip-gitlab/ci/pavel/linux-test kselftest-futex: 11 runs, 1 regressions (v6.=
1.64-cip10-rt5)

Regressions Summary
-------------------

platform         | arch | lab         | compiler | defconfig          | reg=
ressions
-----------------+------+-------------+----------+--------------------+----=
--------
beaglebone-black | arm  | lab-broonie | gcc-10   | multi_v7_defconfig | 1  =
        =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v6.1.64-cip10-rt5/plan/kselftest-futex/

  Test:     kselftest-futex
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v6.1.64-cip10-rt5
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      b0295fc12bdaf65b61b93e18a316c8e20c1f2507 =



Test Regressions
---------------- =



platform         | arch | lab         | compiler | defconfig          | reg=
ressions
-----------------+------+-------------+----------+--------------------+----=
--------
beaglebone-black | arm  | lab-broonie | gcc-10   | multi_v7_defconfig | 1  =
        =


  Details:     https://kernelci.org/test/plan/id/656d1c16e468ae4702e13475

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.64-cip10-rt5/arm/multi_v7_defconfig/gcc-10/lab-broonie/kselftest-fute=
x-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.64-cip10-rt5/arm/multi_v7_defconfig/gcc-10/lab-broonie/kselftest-fute=
x-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/armhf/initrd.cpio.gz =



  * kselftest-futex.login: https://kernelci.org/test/case/id/656d1c16e468ae=
4702e13476
        new failure (last pass: v6.1.62-cip9-12-g3a5321f469b07) =

 =20

