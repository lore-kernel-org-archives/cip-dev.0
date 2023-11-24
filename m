Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5B67C636CB
	for <webhook@archiver.kernel.org>; Fri, 24 Nov 2023 12:07:16 +0000 (UTC)
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
 by mx.groups.io with SMTP id smtpd.web11.134062.1700827631011411292
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 24 Nov 2023 04:07:11 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=kPq8UgSw;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.173, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1cfa71b6029so2481895ad.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 24 Nov 2023 04:07:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1700827630; x=1701432430; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+MH6JxSHOiKF34YHJu2ph9CANOrwsiiMtSYhq/oyMQE=;
        b=kPq8UgSwDGwBpeRIVWi65oHctA0P0DBz/J2CZXD6tlLueEGk2H3zSne8R0Ir45espo
         JOYmS/wYHTFxxBUR/U0jU1dn06t70BP/U7F6q+Bd/mNyHhR54x1XxAEmH7+BFN4cmq9e
         9OQs/Koef/kNb24V6IGPEY9q7aNWHotm1//N9R6hD33y3FzMEw5YjMJ5EgQA30PXnzYa
         Q9ywReMqctl391ticZiM+AZP6xxjWvuYqyDXDs5yUis6PVM7nTtg1vcaRU/CRK538gyZ
         yMBO8vX14qY/f+Dg2fE+SVg1YBnWwL6Vmdz5CkFzinjE77P/EH5H6fgZ/PRdBx3WgdTI
         U5lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700827630; x=1701432430;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+MH6JxSHOiKF34YHJu2ph9CANOrwsiiMtSYhq/oyMQE=;
        b=NWZNaJDS0SZbpAkXnpZU2c5dQk2qk8zqiyQtjUD66JASzu96o05C1BEpA75Bi/PpKu
         X7Vwj3Hbqkc3TkzLb3zRUQYyuLX0yIim/gVVz0wcNktoKieGu3Z6OWzugJQvdJW3RmcP
         2Ij6EEe128whOfqmJIIEdDJopJ5+mYv4Q8dk8w5586hW3SJAYABgoorTCVKSzDprpcQ4
         W5eRQM1i3BJ9S9IpicKh2c4IBTuBus6t4xInqLOr3NDIUbB6hq+M4xL1z1u60Y7v0voW
         kY+8YFYzJYAydPsWqY++20CJOuw21L4OyGvamC+dRapg8FNRrQe7vOBTyBIumn1BKfjT
         S7Gg==
X-Gm-Message-State: AOJu0YyV1gXWDPN+V/5/ihpqtnTfF6dn/p5wL4KwFnrWf/6Yj3E45Zl8
	JfwnNsgVJW7WfPPRKCqGiWY9HdMDeLWYKL4vGR0=
X-Google-Smtp-Source: AGHT+IEwyhBlwmmRfl9qErrfeYkUH6gVbLPTKHSeV0RlBpaVmaLBxuwka05/tCZCU0/h+dGubuTLdQ==
X-Received: by 2002:a17:902:d50c:b0:1cf:78a6:d61 with SMTP id b12-20020a170902d50c00b001cf78a60d61mr2515722plg.9.1700827629997;
        Fri, 24 Nov 2023 04:07:09 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id y5-20020a17090322c500b001cc3098c9f8sm3030527plg.275.2023.11.24.04.07.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 04:07:09 -0800 (PST)
Message-ID: <656091ed.170a0220.7e38a.6cb3@mx.google.com>
Date: Fri, 24 Nov 2023 04:07:09 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v5.10.201-cip41-11-ga539098fe70dd
Subject: cip/linux-5.10.y-cip kselftest-lkdtm: 1 runs,
 1 regressions (v5.10.201-cip41-11-ga539098fe70dd)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 24 Nov 2023 12:07:16 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13730

cip/linux-5.10.y-cip kselftest-lkdtm: 1 runs, 1 regressions (v5.10.201-cip4=
1-11-ga539098fe70dd)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig          =
 | regressions
-------------------------+-------+---------+----------+--------------------=
-+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+kselftest=
 | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.201-cip41-11-ga539098fe70dd/plan/kselftest-lkdtm/

  Test:     kselftest-lkdtm
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


  Details:     https://kernelci.org/test/plan/id/656083311ca3fef84e7e4af2

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-11-ga539098fe70dd/arm64/defconfig+kselftest/gcc-10/lab-cip/kselftest=
-lkdtm-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-11-ga539098fe70dd/arm64/defconfig+kselftest/gcc-10/lab-cip/kselftest=
-lkdtm-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-lkdtm.login: https://kernelci.org/test/case/id/656083311ca3fe=
f84e7e4af3
        failing since 50 days (last pass: v5.10.184-cip36, first fail: v5.1=
0.194-cip39-1-g53e59f50ca3ff) =

 =20

