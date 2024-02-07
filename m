Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2784C4829B
	for <webhook@archiver.kernel.org>; Wed,  7 Feb 2024 01:39:37 +0000 (UTC)
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
 by mx.groups.io with SMTP id smtpd.web11.10761.1707269976787557970
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 06 Feb 2024 17:39:36 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=Eh2JiQ4g;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.170, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6da4a923b1bso135281b3a.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 06 Feb 2024 17:39:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1707269976; x=1707874776; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=eDi5qpMGzXbW+YpElTylmywx8pECeioS32qKJoWD+yM=;
        b=Eh2JiQ4g35Z1co1rHjqMEMFEbJ2Ltmc/WKLRaSAetyXnlzDxzgYHrhr7MjnfFvLT6L
         TFO/CgeyBHw+ysix/0FkRvKPVH01ArupFTyxQooLmzBQxrxnvbvpN86PMXD6hepMmH6s
         w4hqcHuaxR71pY9zTCJGiwqCgyUcoiWcEkkgEts0+VktyyA6Ys2/yaznO3hpl9nJy1Vq
         e4qjMzrnZMLu4LUUVu3i9bqMzdbdQdzZcRMThBb2w472Pj/CpndqEwvhNRHKz5kES5/W
         nqCnNGfopn48XK6Ydgr6ZkRoDXwIWB62cD60zCIH7NqJYGEd4AnFMrGhBi4G5UczU7HQ
         WJXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707269976; x=1707874776;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eDi5qpMGzXbW+YpElTylmywx8pECeioS32qKJoWD+yM=;
        b=EnLL3Y/fJES8LKRqFVZqBgnIE3ck6h3WjUkse0WjIBgEKJQH80mxo19Ma1qw4CYzu7
         mwWb8qRHwwcPvUspoTjJ9xuCTruxB2RlNv5XivyCLzvXhAo464ktwRZ2f8v1/C/9m5xh
         lEmzzO16wNqNf/M6TfgPKnOqz02xPl42UszoiDyroWkCxQvT1QgX4Rd5oxamBpKAOHCl
         SigFTsgd58xX5BWBY/yV2gC2e8C46VFaXd9KKyO7fIwGNCJdwKhw2GdTizNp6UW9hg4t
         JpZJyJMSviHrW9qt+GzdUGIE9ly7PKDpT/YxnEz3bLr+wcv52/i6aOG6E4wvIr7Hk1Cp
         LMvg==
X-Gm-Message-State: AOJu0Yw6YagjYmJtrYdf9rVRqKSYdAb7Ac8YkYLx39WR1sReYQwFVTZt
	wKqIk/3awqlrBz8mJhDB25P1PNe7cKuAElRQ9ayc+H12MOJcFSTBKsktxopY6kUW0sd7SlFpt76
	f
X-Google-Smtp-Source: AGHT+IHP3fRF0CdA6hIo+6fbsViQiNpAjRpor4c/iNdpwXk6kHIF2O07jacN5fBaK/lpYAK55VA1hg==
X-Received: by 2002:a05:6a20:d805:b0:19e:9c30:c9fe with SMTP id iv5-20020a056a20d80500b0019e9c30c9femr3219044pzb.6.1707269975757;
        Tue, 06 Feb 2024 17:39:35 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUfAFgTEDfYfXXJJH/k4/STHomu7jJ6hE9twaBk26BDP7yA11ehi4GGsgPJ4183avmXhUltVNWPt2KCOsNQRHEf1An6QYTxrrCPVOJWxgkNmMy43cyTPJb8uWZ3H9GQ8UI3Upfg3hezvXjhX2l4Da/3Gw==
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id t7-20020a625f07000000b006d94291679asm174949pfb.78.2024.02.06.17.39.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 17:39:30 -0800 (PST)
Message-ID: <65c2df52.620a0220.b4a5b.0b2f@mx.google.com>
Date: Tue, 06 Feb 2024 17:39:30 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.209-cip44-50-ga624abaa85d7
Subject: cip/linux-5.10.y-cip ltp-ipc: 13 runs,
 1 regressions (v5.10.209-cip44-50-ga624abaa85d7)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 07 Feb 2024 01:39:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14857

cip/linux-5.10.y-cip ltp-ipc: 13 runs, 1 regressions (v5.10.209-cip44-50-ga=
624abaa85d7)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm64-chr=
omebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.209-cip44-50-ga624abaa85d7/plan/ltp-ipc/

  Test:     ltp-ipc
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.209-cip44-50-ga624abaa85d7
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      a624abaa85d7f3ff289eb2e257db5c4485d11d18

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm64-chr=
omebook | 1          =


  Details:     https://kernelci.org/test/plan/id/65c2d47705766881f78e1e93

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-50-ga624abaa85d7/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/ltp=
-ipc-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-50-ga624abaa85d7/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/ltp=
-ipc-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/65c2d47705766881f78e1e=
94
        failing since 125 days (last pass: v5.10.184-cip36, first fail: v5.=
10.194-cip39-1-g53e59f50ca3ff) =

 =20

