Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E12EBC77B60
	for <webhook@archiver.kernel.org>; Wed, 22 Mar 2023 13:57:23 +0000 (UTC)
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
 by mx.groups.io with SMTP id smtpd.web11.43294.1679493435198920279
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 22 Mar 2023 06:57:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=UVxat6lS;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.172, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f172.google.com with SMTP id kc4so4737206plb.10
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 22 Mar 2023 06:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112; t=1679493434;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=y6P7ymcUBPtpESpci38ktW24/G7oZzxizqg5VedIdtI=;
        b=UVxat6lSAiyDNhBEP5Rc0RwNhxEvfNyRD7SwgjvvrbSgFK0WdRlp4PNYQ+DPFvuYTM
         8ikoNaDf4JovRxoaFcuPk2d8WvVCG6gO9BnP/XnMPDPsKFQd5efeckAyXTgf9vBA4CPj
         3f5DrNjSfOKK6p+biuwnCbsb7417C0b3OHMmXkr1Vke1Y5WoAFiV85dvAxV9jyk/NY9+
         BfUswMvtuLvLTPjwUSuchwwkMzMNglfyt+zzNgDHaCA4K1eIXm4Dm8c2bM37xeAaCEEp
         jPYfB20SBXaMpYzhWuBIz3w6lnXoSrmZtC85SuX+1CEJ7X7iJNU4xMX4Fbtss89J9v8U
         kPtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679493434;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y6P7ymcUBPtpESpci38ktW24/G7oZzxizqg5VedIdtI=;
        b=XFtnwo/Y6uKYw1KDKo1ONSQY+lPye9wCUgyuIgGGxPjh8u4/mZ1yBOa9SrUqn5X//Z
         jk0NZycfHJrIYpJzR939XJazNUCJL6yiyvYsAtMFs5A1CdlkDgQZNZeNvh3kc+9u1uya
         638G1vdBGDWJ3Nng1jrW7B47LAXnHAa5+AordZfgejeH71SNsoT8k7tqriS2BlCv2h/Q
         xHESuROSW9Nhn/ljysKj1yQPFijdRNz7AbDNoomzNFnJM2zZjao1PHrWWTmM2Ypck346
         m6QBV5AyJC48bDVdnbU9QTz+PKmHZCT55POi7Kdi9rX4Tbt5GtEf+FlEvqW20vYt6SJw
         I+Xg==
X-Gm-Message-State: AO0yUKXM6rHgV7QX1CYdkovM3lOoWbA20iomtJZushQ+p76UtQ4sybbq
	MpT1nUgLYVnpq36Vjf/NAt6kmSTvryOQR2rphUud2Q==
X-Google-Smtp-Source: AK7set/N1IPu4SwLQPlPjEHqqprHESfcBPlghvBqtkcr2sDPrW8Y2t25WiaRaEGFZAsMcaTy0K7xlA==
X-Received: by 2002:a17:90a:734b:b0:23d:35c9:bf1c with SMTP id j11-20020a17090a734b00b0023d35c9bf1cmr3708936pjs.16.1679493434444;
        Wed, 22 Mar 2023 06:57:14 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id x5-20020a1709028ec500b001a04d37a4acsm10673133plo.9.2023.03.22.06.57.13
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 06:57:14 -0700 (PDT)
Message-ID: <641b093a.170a0220.95f38.2fe5@mx.google.com>
Date: Wed, 22 Mar 2023 06:57:14 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.175-cip29-rt12
Subject: cip-gitlab/ci/pavel/linux-test ltp-pty: 8 runs,
 1 regressions (v5.10.175-cip29-rt12)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 22 Mar 2023 13:57:23 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11089

cip-gitlab/ci/pavel/linux-test ltp-pty: 8 runs, 1 regressions (v5.10.175-ci=
p29-rt12)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.175-cip29-rt12/plan/ltp-pty/

  Test:     ltp-pty
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.175-cip29-rt12
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      0a6a8df2de5a8e8f024b47926cff286c6ec0e31f

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  f3463a347c37b44bafdf4e882cfb932f6888905d =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/641af9711265ca6ee69c95a7

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.175-cip29-rt12/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/ltp-pty-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.175-cip29-rt12/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/ltp-pty-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230317.0/amd64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/641af9711265ca6ee69c95=
a8
        new failure (last pass: v4.19.277-cip94-1098-g26d9f86d942d) =

 =20

