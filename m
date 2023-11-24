Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3F18C63707
	for <webhook@archiver.kernel.org>; Fri, 24 Nov 2023 12:07:16 +0000 (UTC)
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
 by mx.groups.io with SMTP id smtpd.web11.134064.1700827632996462571
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 24 Nov 2023 04:07:13 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=Vt7J8o63;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.178, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6cb66f23eddso1553579b3a.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 24 Nov 2023 04:07:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1700827632; x=1701432432; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=uesPpJL3x/PK1ZMkUXIwSEUZx6fGYGAVhIABLiEBcMw=;
        b=Vt7J8o63KagTUK92NCYXCcj9ktz1LB5QPLXING0k3AZP8zuDABXr32UcsTWtye6nEp
         c6fJxmnO5II9NWSMnW1D1QKQ7vbEmuM5mvmhPDNS7jN4QoAdQsRZYpeZwHz+OHCLPejN
         epZNyg+yvhGc2K0IlWp125qQdepEbugBm5YtaJ7TVmB4Da4l5BTDHqxTaM+Lj2oCdnb5
         qnBzwvlnsv96+Me8S/nPhkcPE+wZqKsb93Fn1636iixYaiIOHVdnWYkwpX9gpsEoICjX
         /yjgWheWs4esvVC/L0jYXXnWT7BvYg08Y/3rDmhB3k8xqw9MQm9Umc0objhPYrCUXlo+
         19XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700827632; x=1701432432;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uesPpJL3x/PK1ZMkUXIwSEUZx6fGYGAVhIABLiEBcMw=;
        b=cu+CdeR85rym61LAgAziKhazbfee5U1BmRngRJqO4/pP+cbB0D/CHQjr+Xsax9XFz6
         cqqY2/bO0NumBVGge+jJ2o3waD51Y6Nte8sRiwaKG1mRqPgVZS45R0bwS7by/KcRlbky
         Ygr1Mw+LFFtCc1hYQLHcawFVaqJkJIJyNAPz92f8RZtPyZaOM06axGD/V7u17c03lypj
         j8/52WbsZJlL3o7DTj4WYIf4w5JDQ2jT1nYJxJbrZhvIPjpB43hsd2FEXwuJAV+j5st9
         yJ7HDKRl9ukKersUGqaCWmKjYM+pQVESQWxay3hcQXUmmUffoAxc7AH2xEThc6d1fhEB
         Bkcw==
X-Gm-Message-State: AOJu0YzhXv55mJH9ACqG20cGyLorlhpJfnCm1KmTyLg5IWO2krPSnUaH
	Dp4WcCJtA1wVnL5lieqFGXp4G+0kZVfMqDiid1U=
X-Google-Smtp-Source: AGHT+IEGU7SxMGHdn8SoDb1t+GIWg1dC84t/XmMNhd7yqkD2RWBH3LfEU0oRZq7Bx/RqbQNXZWvDkg==
X-Received: by 2002:a05:6a21:2d87:b0:187:71f7:bb26 with SMTP id ty7-20020a056a212d8700b0018771f7bb26mr2966851pzb.54.1700827631875;
        Fri, 24 Nov 2023 04:07:11 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id b22-20020a056a0002d600b0068620bee456sm2738809pft.209.2023.11.24.04.07.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 04:07:09 -0800 (PST)
Message-ID: <656091ed.050a0220.b18b2.66e2@mx.google.com>
Date: Fri, 24 Nov 2023 04:07:09 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v5.10.201-cip41-11-ga539098fe70dd
Subject: cip/linux-5.10.y-cip kselftest-seccomp: 2 runs,
 1 regressions (v5.10.201-cip41-11-ga539098fe70dd)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 24 Nov 2023 12:07:16 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13732

cip/linux-5.10.y-cip kselftest-seccomp: 2 runs, 1 regressions (v5.10.201-ci=
p41-11-ga539098fe70dd)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig          =
 | regressions
-------------------------+-------+---------+----------+--------------------=
-+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+kselftest=
 | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.201-cip41-11-ga539098fe70dd/plan/kselftest-seccomp/

  Test:     kselftest-seccomp
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.201-cip41-11-ga539098fe70dd
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      a539098fe70dd29de0ce67ad5a39c40867ba5b2c =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig          =
 | regressions
-------------------------+-------+---------+----------+--------------------=
-+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+kselftest=
 | 1          =


  Details:     https://kernelci.org/test/plan/id/6560820d64649dac127e4b14

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-11-ga539098fe70dd/arm64/defconfig+kselftest/gcc-10/lab-cip/kselftest=
-seccomp-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-11-ga539098fe70dd/arm64/defconfig+kselftest/gcc-10/lab-cip/kselftest=
-seccomp-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/6560820d6464=
9dac127e4b15
        failing since 50 days (last pass: v5.10.184-cip36, first fail: v5.1=
0.194-cip39-1-g53e59f50ca3ff) =

 =20

