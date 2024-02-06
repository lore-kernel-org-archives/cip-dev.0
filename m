Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71D3EC48297
	for <webhook@archiver.kernel.org>; Tue,  6 Feb 2024 23:41:07 +0000 (UTC)
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
 by mx.groups.io with SMTP id smtpd.web11.8407.1707262866602204895
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 06 Feb 2024 15:41:06 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=SkjCv8XO;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.167.178, mailfrom: bot@kernelci.org)
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3be6ff4f660so56925b6e.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 06 Feb 2024 15:41:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1707262865; x=1707867665; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=u9N9zQdv5kwwPi2MFcKeX0PGQqLpooNSEP+YuoGkxhQ=;
        b=SkjCv8XOniiFzUeW2XN90Ow9ovy8vgDaOd8WGS2cFnR0JPzIukiRJ/Kk83X2nMNeZb
         jDCok6isSUIVVvOoXq3DLiF17iPn9dwVHtrInkjSmcPowYPfsDaPY0HdsK+UWAhJQawu
         4QUp717Xzeadepsqusqtf7Vz1A371PYo/QJ5iN5bMBw+p8moJQ9wZ++AssVstdX6xJfh
         5YXsFUo7LMA/Psc+mAxhkkO3UkzDoZmW8rzYhuhp+1jpgBvfRiZBqKU4zdABvW81Rp00
         Sd65fD3l9710sPyTKNJv7wMYlsW2d5FhvwStSelOORh3abUjYPcBf74ebyqJB9eXzY/U
         zXnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707262865; x=1707867665;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u9N9zQdv5kwwPi2MFcKeX0PGQqLpooNSEP+YuoGkxhQ=;
        b=hA0aYfvoF4KPd/8DGmpIaIWWRe758x96y1BfVhZwNnw6IYyYAtMnKji8eTJqntGiDF
         JLoIzWdtEZr/BO3/KL3kh8l2e/vDlAk4uLehQSkJt9V8k/uNNiktW6eHbeX3SZPQEjxw
         03Q62kj/0MZmy5vXkSnzErfz2TO0eJRRAhoy8gT3dSjoB6dYHlvc9854F3FVYXWNz1F1
         G9i1Y/TLfl8r224oV8pMG3D3RlCFv310YtS9dUTksEWDhwHgqF+E9MTpwVrn9TLhBWjK
         Z3wZ9oXNjlsymRMy2B5xpDiqNjK9Y4bGgbkayuFuQPgLMbSzFksLcs2XgnmBIFJROqRn
         c45Q==
X-Gm-Message-State: AOJu0YyYdP/V2BXg5y8kKCkiUM63tX416hTGWfJaB2Q7BoAW9dgKeXqy
	9hjK4Fcm2PSj35kdEDAJ3ocjcgkKjxo3esG1u/W5XlgXPInqGX7zeb0hZLEpAjgwYz1tgLVZkLZ
	2
X-Google-Smtp-Source: AGHT+IHxUUP6vA1zHrCQsqLQLQvjtvhh/ZNy7qNm156it1glud/mYqhxg5z+VJ/j0JkX/2Gc+bunJg==
X-Received: by 2002:a05:6358:4b46:b0:178:7c7a:d441 with SMTP id ks6-20020a0563584b4600b001787c7ad441mr1052008rwc.31.1707262864741;
        Tue, 06 Feb 2024 15:41:04 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWUQRvlcOG0Yi5s0w7fuuEO5VfvFrpOrJIqcYSXU1G9aqW/IMHPGWSBhL1QdpzVFr9LT7MsXB+JquqQsm7PydX1uar3Bae1v+xqB43MK1f8nDz0KAWHOXeLGtAOxv5wnYV5mEwiv7nu3QrbTX21XtlsbQ==
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id e23-20020a656797000000b005cf9e59477esm28732pgr.26.2024.02.06.15.41.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 15:41:04 -0800 (PST)
Message-ID: <65c2c390.650a0220.f38c3.01bb@mx.google.com>
Date: Tue, 06 Feb 2024 15:41:04 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-4.19.y-cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.19.304-cip106-2-g5723c66be3b0
Subject: cip/linux-4.19.y-cip ltp-pty: 6 runs,
 1 regressions (v4.19.304-cip106-2-g5723c66be3b0)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 06 Feb 2024 23:41:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14843

cip/linux-4.19.y-cip ltp-pty: 6 runs, 1 regressions (v4.19.304-cip106-2-g57=
23c66be3b0)

Regressions Summary
-------------------

platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
rk3399-gru-kevin | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrom=
ebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.19.y-cip/kerne=
l/v4.19.304-cip106-2-g5723c66be3b0/plan/ltp-pty/

  Test:     ltp-pty
  Tree:     cip
  Branch:   linux-4.19.y-cip
  Describe: v4.19.304-cip106-2-g5723c66be3b0
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      5723c66be3b09629fae4fec9711e11f0d020e81a

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
rk3399-gru-kevin | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrom=
ebook | 1          =


  Details:     https://kernelci.org/test/plan/id/65c2bbd09991ab737d8e1f11

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.304=
-cip106-2-g5723c66be3b0/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabo=
ra/ltp-pty-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.304=
-cip106-2-g5723c66be3b0/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabo=
ra/ltp-pty-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/65c2bbd09991ab737d8e1f=
12
        new failure (last pass: v4.19.304-cip106) =

 =20

