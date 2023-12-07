Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9918C46CA7
	for <webhook@archiver.kernel.org>; Thu,  7 Dec 2023 13:27:56 +0000 (UTC)
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
 by mx.groups.io with SMTP id smtpd.web11.83531.1701955673513153386
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 07 Dec 2023 05:27:53 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=lDGsaOuV;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.181, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1d05212a7c5so6541205ad.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 07 Dec 2023 05:27:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1701955672; x=1702560472; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=pu0IPvee9yCCDQDqnMMop5nOiYNQ7qQI6KWpOPp5nwg=;
        b=lDGsaOuVousF7P4dS81zA3k6yT5lufDSoQ5kLjLlRv+Vusi/2JZSsSGOhq28WIZxbT
         W2ymivK+AigKpgQqMx49QQ4JtEUPZGzC69hjK5PXRDNOctJaEoQ9N9oQEniObwDf+3eX
         io/zHpydgPwhIDk4+ui9JX8dLD4c3HvLWFcx2qhFz6/dVWgx7kM0gVKsrGhPkzByBnYI
         fyL4inqdYHg/Ymmp+Tip2djuN5OsBd9dHD8MPeGA9Fzu2TKT4Nl5qPfy0SzPDjxHXRTx
         7GmOpXXPWqFFqNrHh1gVgexCsqNwqOyD2d0cFnF9iLHdpLTVwrWD4AgPo/vH5pcYjIrd
         k0jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701955672; x=1702560472;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pu0IPvee9yCCDQDqnMMop5nOiYNQ7qQI6KWpOPp5nwg=;
        b=pDWN9jfNRqv88Y54BgJZ2HoXhb4OYlrVabDC+T4FKjKdPLQs4z8QzqJICtlxEUBRyI
         VDJbwO/wnJxn+oPs2+akEMrMPGSZ30Qw1rHSDeMbg+UsidIyTeRSe5b8qPuorxolxyem
         OFlqvJW5Vnip1425JGbJfAMXmEp+GQ7osLmAkNB+Q+iC6Yr1/cTy5i55zJfISDcp3JFd
         kbKB07LUrFVIZ+427HZhD6hhRQO67V+9gze3pDMvmN43T04ZElTo17y1rGdPygr2zBF+
         dGbUzYB/NnXOvd2oywthjxvkqlfHUagD8MzrmE70y/a/GXHkMVRvDu6flYVuW0608w1h
         bmww==
X-Gm-Message-State: AOJu0YwtVN642DKT32BPi0jcRQxoXTRQoOiz67U4kdOLwHrAQyUxpj2k
	6RhapjUWUzBluYGO7YrtFZ/7ZEEnecGpaD+F6giYLQ==
X-Google-Smtp-Source: AGHT+IEdTe8KdkmRfnZ09TScFX5IzWLQSES2K6UjFxGY0j9ttrVuUeBWl1+poQNyXjg4qmlJY4c7AQ==
X-Received: by 2002:a17:902:ce84:b0:1d0:6ffd:8377 with SMTP id f4-20020a170902ce8400b001d06ffd8377mr2131560plg.130.1701955672446;
        Thu, 07 Dec 2023 05:27:52 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id d12-20020a170902c18c00b001d052d1aaf2sm1384648pld.101.2023.12.07.05.27.49
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 05:27:50 -0800 (PST)
Message-ID: <6571c856.170a0220.7a874.2d0f@mx.google.com>
Date: Thu, 07 Dec 2023 05:27:50 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.201-cip41-28-g38e219eb6aa85
Subject: cip-gitlab/ci/pavel/linux-test ltp-pty: 7 runs,
 1 regressions (v5.10.201-cip41-28-g38e219eb6aa85)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 07 Dec 2023 13:27:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13837

cip-gitlab/ci/pavel/linux-test ltp-pty: 7 runs, 1 regressions (v5.10.201-ci=
p41-28-g38e219eb6aa85)

Regressions Summary
-------------------

platform          | arch  | lab           | compiler | defconfig | regressi=
ons
------------------+-------+---------------+----------+-----------+---------=
---
qemu_smp8_riscv64 | riscv | lab-collabora | gcc-10   | defconfig | 1       =
   =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.201-cip41-28-g38e219eb6aa85/plan/ltp-pty/

  Test:     ltp-pty
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.201-cip41-28-g38e219eb6aa85
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      38e219eb6aa85cc3be6dec326b24dcf8cf438d01

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform          | arch  | lab           | compiler | defconfig | regressi=
ons
------------------+-------+---------------+----------+-----------+---------=
---
qemu_smp8_riscv64 | riscv | lab-collabora | gcc-10   | defconfig | 1       =
   =


  Details:     https://kernelci.org/test/plan/id/6571b79dd5638b70e2e13476

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-28-g38e219eb6aa85/riscv/defconfig/gcc-10/lab-collabora/ltp=
-pty-qemu_smp8_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-28-g38e219eb6aa85/riscv/defconfig/gcc-10/lab-collabora/ltp=
-pty-qemu_smp8_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30623.0/riscv64/rootfs.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/6571b79dd5638b70e2e134=
77
        new failure (last pass: v5.10.201-cip41-16-g3c85fba3b6e5d) =

 =20

