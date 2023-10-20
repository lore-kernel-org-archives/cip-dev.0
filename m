Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A312C001DF
	for <webhook@archiver.kernel.org>; Fri, 20 Oct 2023 16:42:40 +0000 (UTC)
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
 by mx.groups.io with SMTP id smtpd.web10.59227.1697820153571987279
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 20 Oct 2023 09:42:33 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=trrq0Zv1;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.167.180, mailfrom: bot@kernelci.org)
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3b2e22f1937so602213b6e.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 20 Oct 2023 09:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1697820152; x=1698424952; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=sC3s9kdfZhhsE39mVXA9UfXlqvBcntP4OUNRigWDlKQ=;
        b=trrq0Zv17Bf1ohd5aawe45utF0tYXk7+Q+d4rYly9ihgSjh7XFQpQsuT3xE9EyW9eg
         0C2u+bil+7nqfHLfw+3bTvnLyWrvTmAClxZyv+Obusv3attT+0s45/JjFmXvaThaf5S1
         iT3IO7TCKowQH8aHc5kc90gkK3LbC4ypoHxT9q0c6SPZjXrU22Vt+10hvLloOCdyEOrq
         RMnH9jWQsZqmy8pGxEtMlQLwSMyCOyl2fv8ZjeabeDBo+626DZOrlLpIqNaCUVGzWTgq
         k3d7Pl+l3XdIRdbCVk2qv3Pevq4vxAq+c8iGKJT8JpvjAsTB6IqkNJ7OJo8aiBJJz6g/
         qLVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697820152; x=1698424952;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sC3s9kdfZhhsE39mVXA9UfXlqvBcntP4OUNRigWDlKQ=;
        b=AaHZmqrQLdsBr6U6lrKojL9JbnQybuawsjIcuB2SxM5peKStY+GXLMRbV0gpeyQZP1
         TcdopKLHHtabO1X/zSDUOc9NdB61LwEZdVog4i2t0ULa4l5VsmR3s4MQESSGJVor4fhx
         k4CsHPhfSud+hz+MMGkTITAoNAAieOr65DiKWKdlR4XBX5/+M+oUTeRfYD9Cqp3KpTho
         NvpyOru/QYdawfMNZp/XZQsGxuV9PpnXlIJhYvEKs4CApKCdeT7ygr1yMPp0GpiyuhbU
         cK6qS9qJn8I+f4vLR8KQiU9uPD4uXlR0jOHPGSsSDPGDK+dkbS8W+QkIk6AiDTaBVHYK
         A+Pg==
X-Gm-Message-State: AOJu0YwLqq2QeCEXgUApcyavDwK+tH+cmcPhT/ag8XlOFIXOirMPYjZB
	qQq57ehsEegqd7lhOvIEUyO4/2oZi35sAsntPdTwGg==
X-Google-Smtp-Source: AGHT+IEL36ZVSPXfKF1P6IiiiJ18XIHKE8J62wQIgSb5xNisLxyq7OW8ExfNkt7f4AgSby7aY6JuFA==
X-Received: by 2002:a05:6358:3402:b0:143:3a49:e30d with SMTP id h2-20020a056358340200b001433a49e30dmr2110478rwd.12.1697820152216;
        Fri, 20 Oct 2023 09:42:32 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id t3-20020a6564c3000000b005ac384b71cbsm1453167pgv.60.2023.10.20.09.42.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 09:42:31 -0700 (PDT)
Message-ID: <6532adf7.650a0220.69958.4e4e@mx.google.com>
Date: Fri, 20 Oct 2023 09:42:31 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v4.4-st20-2644-g8c47415283df
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-4.4.y-st-rt
X-Kernelci-Tree: cip
Subject: cip/linux-4.4.y-st-rt baseline-nfs: 29 runs,
 1 regressions (v4.4-st20-2644-g8c47415283df)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 20 Oct 2023 16:42:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13420

cip/linux-4.4.y-st-rt baseline-nfs: 29 runs, 1 regressions (v4.4-st20-2644-=
g8c47415283df)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
lenovo-TPad-C13-Yoga-zork | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.4.y-st-rt/kern=
el/v4.4-st20-2644-g8c47415283df/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip
  Branch:   linux-4.4.y-st-rt
  Describe: v4.4-st20-2644-g8c47415283df
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      8c47415283df04754646683dad0467834ca64d7e =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
lenovo-TPad-C13-Yoga-zork | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6532a7460edd63a2b2efcef6

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-st-rt/v4.4-st2=
0-2644-g8c47415283df/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-nfs-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-st-rt/v4.4-st2=
0-2644-g8c47415283df/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-nfs-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/6532a7460edd63a2b=
2efcef7
        failing since 135 days (last pass: v4.4-st20-1684-gd04aea87b5a3, fi=
rst fail: v4.4-st20-2172-gb3363b986efb) =

 =20

