Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8C5AC25B6F
	for <webhook@archiver.kernel.org>; Fri, 27 Oct 2023 13:38:36 +0000 (UTC)
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
 by mx.groups.io with SMTP id smtpd.web10.7141.1698413910774909164
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 27 Oct 2023 06:38:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=WQG28WpQ;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.177, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6b201a93c9cso1983066b3a.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 27 Oct 2023 06:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1698413910; x=1699018710; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=vcgkBqbP4HSDsCbW+IXLxxN6YTmUcIEv0dYfHwr+OsU=;
        b=WQG28WpQ4uYtZFkrTODgHyfrCsc3BCixl2J3UUxL8HvGnX+Bmn2PV7YGN1fres3CQ/
         x3bZZ4q5rzEw+6MqTZXsAvCHUItIEkdcv1s3O8qosNOWPmSU18TmZr0VO4k5sPTE11iw
         qA0SSPRGHmFKskuXaPkOVPokRkaH+qsKsudJ4VWxy+UVkgd1nzZbWhWoOie8yZsbfynW
         IKHJF4mZevrB9AAR2sVBKrEYXT+nT6hKAdmytNsdam17uB1t8XxZBiCZx1c09gdnMldC
         tYLFwP8zEZtM3gG7CrIEWoItXgjrwhjHE1LCpc+YOjuCxeunP9GkNPRysCeEbxa8nc74
         Qn/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698413910; x=1699018710;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vcgkBqbP4HSDsCbW+IXLxxN6YTmUcIEv0dYfHwr+OsU=;
        b=kPw0PEmstnoVzFPX2zxSbKL+m6JSJ/EMa8i/tXoKCYvB6L+QuikbAX/jFDImFjbKGi
         vsmzVEnmo8NUXpBuKGZMWcJBmH7gUuwXsZQDeh0N1iN5ozy/iRktsjk5gtaVkb4VEWYp
         dscv6NoUmLazuwADKN9R0Pjc4qPNxgFqn637ZoVQPha7igFGO7ZLLJSf1QrEKhmHhi0+
         YSRTTtN2WfR0YAhQWSMP+TIUSyPZvzpNPjE43+BiH9TX6GMfPaX8U2Bc980gIHTR5L7m
         9arzw2Hu+lllkCVKRhmgz0mcUeiw6i4cT/B984IkLZ+KTvihs2U46zAEkcLAJSXq6Z6J
         akDA==
X-Gm-Message-State: AOJu0YzL6swK+FHsRMS5ZezN7X3STxo/P3dFmBpSzMazWV2h3lERu7uW
	sR+C6pqssnwV0fzw+YcYAiLFWbHfoRRldfF+Of0=
X-Google-Smtp-Source: AGHT+IGGdEPz2TbnhCJVJ6+dqIXBpq1mcqKV+rfI2k5XgAIjYteCio9R4GF0rnEN3ypd10y45eFC/Q==
X-Received: by 2002:a05:6a20:734f:b0:157:e4c6:766a with SMTP id v15-20020a056a20734f00b00157e4c6766amr3308439pzc.41.1698413909500;
        Fri, 27 Oct 2023 06:38:29 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id f22-20020a633816000000b005af7ee01ab4sm1110380pga.6.2023.10.27.06.38.28
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 06:38:28 -0700 (PDT)
Message-ID: <653bbd54.630a0220.1b04a.2e21@mx.google.com>
Date: Fri, 27 Oct 2023 06:38:28 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.1.58-cip7-132-gb38ea1474c159
X-Kernelci-Report-Type: test
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/pavel/linux-test ltp-ipc: 16 runs,
 1 regressions (v6.1.58-cip7-132-gb38ea1474c159)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 27 Oct 2023 13:38:36 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13478

cip-gitlab/ci/pavel/linux-test ltp-ipc: 16 runs, 1 regressions (v6.1.58-cip=
7-132-gb38ea1474c159)

Regressions Summary
-------------------

platform         | arch | lab     | compiler | defconfig           | regres=
sions
-----------------+------+---------+----------+---------------------+-------=
-----
beaglebone-black | arm  | lab-cip | gcc-10   | omap2plus_defconfig | 1     =
     =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v6.1.58-cip7-132-gb38ea1474c159/plan/ltp-ipc/

  Test:     ltp-ipc
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v6.1.58-cip7-132-gb38ea1474c159
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      b38ea1474c1591eafe6d4659c33713917887c7a2

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform         | arch | lab     | compiler | defconfig           | regres=
sions
-----------------+------+---------+----------+---------------------+-------=
-----
beaglebone-black | arm  | lab-cip | gcc-10   | omap2plus_defconfig | 1     =
     =


  Details:     https://kernelci.org/test/plan/id/653baa4ed0b62edfa6efcf21

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.58-cip7-132-gb38ea1474c159/arm/omap2plus_defconfig/gcc-10/lab-cip/ltp=
-ipc-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.58-cip7-132-gb38ea1474c159/arm/omap2plus_defconfig/gcc-10/lab-cip/ltp=
-ipc-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/armhf/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/653baa4ed0b62edfa6efcf=
22
        new failure (last pass: v4.4-st20-3596-g73e7f2b880d98) =

 =20

