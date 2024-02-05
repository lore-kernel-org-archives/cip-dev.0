Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ABFDC4829A
	for <webhook@archiver.kernel.org>; Mon,  5 Feb 2024 18:21:28 +0000 (UTC)
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
 by mx.groups.io with SMTP id smtpd.web11.1328.1707157282101188121
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 05 Feb 2024 10:21:22 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=fjXvZdWX;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.161.54, mailfrom: bot@kernelci.org)
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-59a45d8ec91so1842929eaf.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 05 Feb 2024 10:21:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1707157281; x=1707762081; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wsWNNCZPcsOY1jt2X9aJPmNuSMPOfMpWMNfWXklmVdY=;
        b=fjXvZdWXiS2LSHU5qQUX0qSvL3gSdTnKe4teDOVsrIUMy10LLv+n+kIBd5aWb6UKlY
         PS8+4D0urhOR/vKm20meXFO4ySCQl5MSOtPc31Q41m5cetkBjk5T1HxLbi5NTTpEZnL3
         nmjCGbucqAavqcfSsnKGq5xIhQRRGH3z64ikwtGr/dCw5ezA798WKQ/ktxwq90JJ77dt
         EaCP9WbETkIXFCLCye5FpQ91cj4HXT/hTWyTQfjFhlfuELYDGyrLGmFID8efPxkee6m9
         /v+U3kVDufK2iF28Tb9TRANjONNuRWDxStPIqZn+rOr0/8tFCJN1U4w29UdwZkcmcYus
         BuqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707157281; x=1707762081;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wsWNNCZPcsOY1jt2X9aJPmNuSMPOfMpWMNfWXklmVdY=;
        b=QA6yIs2lzbtXJEXmA9Bs/4E2rnNJzVp3Ui9jFjnfpoLXCJEWaHgfkYaTlZNoofuFbN
         gl2gSytYwzeTtq6iP2s9yOA1EGZO67Y5Ff+KKYaY6xDJlFNKScTJDR95rqmpSuVS/Ny0
         CFjxfXoQ2CujFQipj4v4vDWji/O6gloHWeVQTtWvwJBs6Bc/Qb2ly1Ljg3dfWpRLh7Cw
         M9zj2VPm9P0ipUXCGtuNXeJRODVhMOsGSIb7rfGtP4SKfObMW0P6toacz4Digr5QBkBj
         FGfuTm+4j1IBUGQMji0elIKvY3KColZ/zmElqdv2ZvRbNOgx7DBpDKFFwz7ues6EW4fW
         Farw==
X-Gm-Message-State: AOJu0YyEIZn7m65e7odscy90nXqEC5EMqU7IMGYnw0JIRNX9R/U4ObCA
	RlcSY6BNI+VQsj7ZQYRHiRazk9xv+OA9N4/nhtDhLuLc4+CWnnjSeIx2hUKxi7qj+HlxUIYX7Hh
	L
X-Google-Smtp-Source: AGHT+IFBsUyONN0pELrNwM3rW5JoVd8Y+fdYmVLEqF05zNBVCTrCrvf0u+TgeEwOxd4RC6cWHlKApQ==
X-Received: by 2002:a05:6358:885:b0:178:c57d:8f3 with SMTP id m5-20020a056358088500b00178c57d08f3mr656177rwj.1.1707157280344;
        Mon, 05 Feb 2024 10:21:20 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVe6mQD79Bvgf+pH0DwcBDsk6Wa8pa+8AYdPWCbKzrRr9T/Rotc5GeVVJ5Qk32a+jGZAXZcQ/oOFeSJIMKOZ4LUy+E40V/QmpjMbxIk7Kw1qsPgB7iaCT5zz3mryf6ea4VT1Bn7ovXv3guDvEN7q+ZzXg==
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id z68-20020a633347000000b005db76738ae2sm307660pgz.58.2024.02.05.10.21.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 10:21:18 -0800 (PST)
Message-ID: <65c1271e.630a0220.c285b.21ea@mx.google.com>
Date: Mon, 05 Feb 2024 10:21:18 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Kernel: v5.10.209-cip44
X-Kernelci-Report-Type: test
Subject: cip/linux-5.10.y-cip ltp-ipc: 18 runs, 2 regressions (v5.10.209-cip44)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 05 Feb 2024 18:21:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14750

cip/linux-5.10.y-cip ltp-ipc: 18 runs, 2 regressions (v5.10.209-cip44)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm64-chr=
omebook | 1          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig          =
        | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.209-cip44/plan/ltp-ipc/

  Test:     ltp-ipc
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.209-cip44
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      2fa4c25ee66abaa707e8d165c790bb96e883cca4

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


  Details:     https://kernelci.org/test/plan/id/65c117474dcbcac93b00a049

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/ltp-ipc-r8a774a1-hih=
ope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/ltp-ipc-r8a774a1-hih=
ope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/65c117474dcbcac93b00a0=
4a
        failing since 124 days (last pass: v5.10.184-cip36, first fail: v5.=
10.194-cip39-1-g53e59f50ca3ff) =

 =



platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig          =
        | 1          =


  Details:     https://kernelci.org/test/plan/id/65c11afe4d9069645300a080

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44/arm64/defconfig/gcc-10/lab-cip/ltp-ipc-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44/arm64/defconfig/gcc-10/lab-cip/ltp-ipc-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/65c11afe4d9069645300a0=
81
        failing since 124 days (last pass: v5.10.184-cip36, first fail: v5.=
10.194-cip39-1-g53e59f50ca3ff) =

 =20

