Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24E89C48292
	for <webhook@archiver.kernel.org>; Thu,  1 Feb 2024 22:20:44 +0000 (UTC)
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
 by mx.groups.io with SMTP id smtpd.web11.9125.1706826037788774325
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 01 Feb 2024 14:20:37 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=HCg9g3s9;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.172, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-5d42e7ab8a9so1189558a12.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 01 Feb 2024 14:20:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1706826036; x=1707430836; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3epeNoLiVeVO+UFTQKpCUnXQo2i3cJ777+L3kAdJZvg=;
        b=HCg9g3s9rVi2pQEPvXe7/vPH+EPYYYtOxhK68gN9P9qFdgrhO691HKqcay7CxeX3ip
         bfCfrqcS0vEKE/U6pT9P1R+D+EzR/EZvvURHjtfsBsQ3X1D0J6NXX8Om7FzGvvQtK28A
         YbL+nWBiRv7hXlmWer1EV+VrdYK5PMS5D29gZrDpQZeIoGr9oAJDFAvnc7D8rQf89BO1
         fE9/ugLWSDAbaecgq1UO2xSJQ0V8t1tO947DBlF93yg6+2cxJeX0QP3DuSv6KEiMqEeW
         Tx8gSlVrqIiBJodDlv3OTHriO3E3GoBxVDcDzlNNrRqSafsWcDzMvFQ5F1ouRZS8P8VY
         pHAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706826036; x=1707430836;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3epeNoLiVeVO+UFTQKpCUnXQo2i3cJ777+L3kAdJZvg=;
        b=uPTq7NkX2IC7dUHgNsR7cloWtQUyKqMNQLnh9rxVRiV4pQOxaaqAWKpQY9Onsm9WXx
         zMaP0JyiR9dwG1N1Cdq/KPncSWcPK1p2PDygEtugegxWv/D6WHposOcx1J0TJB/gnDCM
         xga+bzcXwuSoJXyHgXb2E17b7BjKf9zv215PUa7cENC4yPhHDvkYs3nLgwkQhFvVy8EJ
         2vm/Hg407fIL/dQEjQAYm0ycUAHimMZjyKCPQ56rMcIE+syNq2K1ElfotHlS4gjpLzUF
         +AjJIGe5ipah/n/jdoBnc9N1IYeHyd0NupQCebW276onfiwgSqkclc7Lhb8kYSbG4EuL
         mvzA==
X-Gm-Message-State: AOJu0Yy4FTS3ScMyw2RX3ebSZ9MOR3VKQ4u4MvJlU03hHhyr/w0jlD/C
	tE2cYf+Qk+6zIjDP1KlBN9lzJk7/QGB7+hPL/n5EFgCAdo8quld6NIxC81fUbG+LpFx2xKeNQ+/
	8
X-Google-Smtp-Source: AGHT+IFrvbaN1OV4h+Zho1w5QZTGjnfvJ9M1Y4dR3OrQIl8khLlAb/pPkVpiQ7H7oZyPPfJnMkNoLg==
X-Received: by 2002:a05:6a20:9f4e:b0:19e:3a9f:f925 with SMTP id ml14-20020a056a209f4e00b0019e3a9ff925mr5199981pzb.14.1706826036696;
        Thu, 01 Feb 2024 14:20:36 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUhM3SaixxVHh+MvGcd6Inu9UEThZtXMasMMHYzx9l5502VZ4dZ6O73rk4e5h55lsp3WQ0VhhMnJ8BtkxmDefpUaEw+nYCZQFA5FZ/rHXPpVth0L2CvGmXlgLUyCgrGHVI81QyyhLwXsKtBoCSC3ADlZw==
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id h20-20020a056a00219400b006ddcadb1e2csm247604pfi.29.2024.02.01.14.20.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 14:20:34 -0800 (PST)
Message-ID: <65bc1932.050a0220.451cd.1b60@mx.google.com>
Date: Thu, 01 Feb 2024 14:20:34 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Kernel: v5.10.208-cip43-4-g1c63c70fb18b8
X-Kernelci-Report-Type: test
Subject: cip/linux-5.10.y-cip ltp-pty: 13 runs,
 2 regressions (v5.10.208-cip43-4-g1c63c70fb18b8)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 01 Feb 2024 22:20:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14595

cip/linux-5.10.y-cip ltp-pty: 13 runs, 2 regressions (v5.10.208-cip43-4-g1c=
63c70fb18b8)

Regressions Summary
-------------------

platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip       | gcc-10   | defconfig    =
              | 1          =

rk3399-gru-kevin         | arm64 | lab-collabora | gcc-10   | defconfig+arm=
64-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.208-cip43-4-g1c63c70fb18b8/plan/ltp-pty/

  Test:     ltp-pty
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.208-cip43-4-g1c63c70fb18b8
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      1c63c70fb18b87b5bcfe5d7ddf0096c92a1557ed

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip       | gcc-10   | defconfig    =
              | 1          =


  Details:     https://kernelci.org/test/plan/id/65bc0bfb18677bde6600a0c1

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.208=
-cip43-4-g1c63c70fb18b8/arm64/defconfig/gcc-10/lab-cip/ltp-pty-r8a774a1-hih=
ope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.208=
-cip43-4-g1c63c70fb18b8/arm64/defconfig/gcc-10/lab-cip/ltp-pty-r8a774a1-hih=
ope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/65bc0bfb18677bde6600a0=
c2
        failing since 83 days (last pass: v5.10.184-cip36, first fail: v5.1=
0.200-cip40) =

 =



platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
rk3399-gru-kevin         | arm64 | lab-collabora | gcc-10   | defconfig+arm=
64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/65bc0efa1bdb5a00d700a043

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.208=
-cip43-4-g1c63c70fb18b8/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabo=
ra/ltp-pty-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.208=
-cip43-4-g1c63c70fb18b8/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabo=
ra/ltp-pty-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/65bc0efa1bdb5a00d700a0=
44
        new failure (last pass: v5.10.194-cip39-1-g53e59f50ca3ff) =

 =20

