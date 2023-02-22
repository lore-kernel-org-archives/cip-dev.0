Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7366C64ED6
	for <webhook@archiver.kernel.org>; Wed, 22 Feb 2023 20:07:48 +0000 (UTC)
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
 by mx.groups.io with SMTP id smtpd.web11.3575.1677096467194476663
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 22 Feb 2023 12:07:47 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=PNRavmx2;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.46, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f46.google.com with SMTP id oe18-20020a17090b395200b00236a0d55d3aso10010065pjb.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 22 Feb 2023 12:07:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=QA0TvgOVQSQrVYwkPYIu6wyS5jfgvYhcNlOqeo0xTrE=;
        b=PNRavmx2vIkfiMMaH7WFxA+RmjYK12TuKoIFPlCANhMEgc4+nTI3UE9ZpNsJWmx4JY
         38iUE+Qqmqa27RpDPn6aq27z1Nj13O6Q2L2QTjbRcwLrTYex3i61R3YekCf69iGM7YfT
         8wLCgl0B6l4DdMXxefzIRXaG+79yU0ZCbZ43scnKfFpD+BcoZM9IykyEsGG5k8xho2LQ
         USuCrn7VNxvysxCAuMvMpmNdVh4Vdllx16G+Xub70cehVgTZqRVTOujgSNWV6aw53N1Z
         at7UjPCGeU27wO2IoFOSucbUHEwG2kSSJZqkpd5XoCwgHfa0MqNvdFNh3EDYwzFW4mkD
         S3UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QA0TvgOVQSQrVYwkPYIu6wyS5jfgvYhcNlOqeo0xTrE=;
        b=x2hFrTq1Kvh0IcwS7nI6+hdTjwR+tkvIDVv03k3SoGL0w1uuEt3CA1gj9Y4mAMWZY9
         V8EsXMZva9DpylHxbZLx1ES0SPGE1F71lclQik44Dp22pDuA27c+0nZAQWXlz2KaPXC/
         mKnTHUVcnXxVPo1OwkoiycX7R7GEMrkas0NwsGKMyqG6M/I4D7Dpz8KGCDZFXZqU4QX0
         k/LT9Ez4bti9Wkdrk4qWviCALmjs9xvDgvdek9JiKgtvlphhZpv7/DAfPfyLYECW1GwY
         pob3tnJrMEjTGFXVGk5+UuYIfOJeaOcWDtKF5LkmVgP6g7nSgchQLNFuMP3FfI0/sDIX
         vZqQ==
X-Gm-Message-State: AO0yUKUZit7bZ4a2aeXuNzs/9EEMvUg6pgpoI/rwq/au1SESVZZEy2Au
	c5SU8HxflCWgGOLJ2xBwn0KL6r3c7mYtf9Yj2az27w==
X-Google-Smtp-Source: AK7set+Qz7fDjvMHbEd8vc3fvqrx9VursMlAgDCjabhbRUowpA9cK9wQNJ9ZBcR3Qk4bEupVR2O/pQ==
X-Received: by 2002:a17:902:ce87:b0:19b:e31:b329 with SMTP id f7-20020a170902ce8700b0019b0e31b329mr12540468plg.33.1677096466376;
        Wed, 22 Feb 2023 12:07:46 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id c20-20020a170902c1d400b00196217f1219sm2909958plc.70.2023.02.22.12.07.45
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Feb 2023 12:07:46 -0800 (PST)
Message-ID: <63f67612.170a0220.46c7c.6730@mx.google.com>
Date: Wed, 22 Feb 2023 12:07:46 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-4.19.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v4.19.272-cip91-91-gb4755c11cb57
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc ltp-ipc: 7 runs,
 1 regressions (v4.19.272-cip91-91-gb4755c11cb57)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 22 Feb 2023 20:07:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10793

cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc ltp-ipc: 7 runs, 1 regressions (=
v4.19.272-cip91-91-gb4755c11cb57)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig | regress=
ions
-------------------------+-------+---------+----------+-----------+--------=
----
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig | 1      =
    =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-4.19.y-cip-rc/kernel/v4.19.272-cip91-91-gb4755c11cb57/plan/ltp-ipc/

  Test:     ltp-ipc
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-4.19.y-cip-rc
  Describe: v4.19.272-cip91-91-gb4755c11cb57
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      b4755c11cb578851c6f8f50c94fcac17e987653c

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  86f0584539eb1567f009f3e38be6940830649b92 =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig | regress=
ions
-------------------------+-------+---------+----------+-----------+--------=
----
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/63f66ab3d02d10a8ca8c8727

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.272-cip91-91-gb4755c11cb57/arm64/defconfig/gcc-10/lab-ci=
p/ltp-ipc-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.272-cip91-91-gb4755c11cb57/arm64/defconfig/gcc-10/lab-ci=
p/ltp-ipc-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230217.0/arm64/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/63f66ab3d02d10a8ca8c87=
28
        new failure (last pass: v4.19.271-cip90-81-g5d0e00d43751) =

 =20

