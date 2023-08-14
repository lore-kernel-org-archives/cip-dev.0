Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F7FDC41513
	for <webhook@archiver.kernel.org>; Mon, 14 Aug 2023 11:12:03 +0000 (UTC)
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
 by mx.groups.io with SMTP id smtpd.web10.105134.1692011514853106254
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 14 Aug 2023 04:11:54 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=yAq9beyv;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.41, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-26b4c6a5e61so929088a91.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 14 Aug 2023 04:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1692011513; x=1692616313;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=EKmXp+wQOse1NxnuGCYEW0CecIkKIITCH8MqpggXOzo=;
        b=yAq9beyv6WqweIMkl0HfLXtfINcjJl1WM456Ki3/EfC7WP2IXCBWNc2sN3u8amCmEB
         8qzAcW4RI/+BfKnlSnxXq5lg7W5z0Q0uXnvbpVmzimrk53tSPiOz6HO7rrFzepVfiayj
         8dqkZsZadi/dUybSvfV7Mds3bRExgC580S5XMvgnwWRjhAXR6ft1vqIV0b3j3yinq4a2
         Z1EVpXyPVywrtZUkQzMY/a3YG2JDpa/55CuNooblAUbozInIvoVifD8oquy0ARP9+Uy0
         CUuoqw8aK61EWroRbPJ8nzNXv933zRygANlqwsil6OUh6K5kC3869dup+5+4lz7jqy1p
         uQJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692011513; x=1692616313;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EKmXp+wQOse1NxnuGCYEW0CecIkKIITCH8MqpggXOzo=;
        b=iMh6EmD8bMopri3IOD0o2mq3pXP5L5faRrtwU0rhn+jyrqWrfPmw83yibh7MMX12J+
         SQmBdyGag4CQTpWndbZn7aCALUAxXjGsJlcDOwxqrxBG1GfceaaIjD9+iRxLzb5BEnKN
         ysKsnGEkU23vLOlkd8/GLLQTIzSaunb88uUZm9jTM80qTj9m/knsxSVUsPutnxrxz3pS
         YZXi2ho0XD6XSL3ljdQMAAkyA8s9et4Ko9CXs9DTJVi6vlENmR3E4abqZPlFep3omkBO
         CWQnWw48/gwIzTgc4NWfNCQ++pRONzziWRJFLjgXuCT5dYT7XpIsTuK1lFlaS2yF2woU
         lrFg==
X-Gm-Message-State: AOJu0YzZyCrl5rus/TTHFCZzp7SuKmjjrYF/Tah2ZBl18B3Zgo5A48ic
	U1HlNmsVzxjZCymMkqytlFFrbLEp5UzZpo7keokOOU0o
X-Google-Smtp-Source: AGHT+IEqeXGbxHJvSrtxzq6k1ME+J+lJ76NqD+/OXpcZ27ruyaRPs2y2Zo/YuM+rZOLlOwcu/EpBmw==
X-Received: by 2002:a17:90a:2f86:b0:25b:c8b7:9e5b with SMTP id t6-20020a17090a2f8600b0025bc8b79e5bmr8329388pjd.31.1692011513424;
        Mon, 14 Aug 2023 04:11:53 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id 26-20020a17090a191a00b002680dfd368dsm8327800pjg.51.2023.08.14.04.11.52
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 04:11:52 -0700 (PDT)
Message-ID: <64da0bf8.170a0220.f8226.e115@mx.google.com>
Date: Mon, 14 Aug 2023 04:11:52 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.19.288-cip101-1117-g1f3468542aa9e
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
Subject: cip-gitlab/ci/pavel/linux-test kselftest-filesystems: 1 runs,
 1 regressions (v4.19.288-cip101-1117-g1f3468542aa9e)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 14 Aug 2023 11:12:03 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12636

cip-gitlab/ci/pavel/linux-test kselftest-filesystems: 1 runs, 1 regressions=
 (v4.19.288-cip101-1117-g1f3468542aa9e)

Regressions Summary
-------------------

platform               | arch   | lab           | compiler | defconfig     =
               | regressions
-----------------------+--------+---------------+----------+---------------=
---------------+------------
asus-C436FA-Flip-hatch | x86_64 | lab-collabora | gcc-10   | x86_64_defcon.=
..6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.19.288-cip101-1117-g1f3468542aa9e/plan/kselftest-filesys=
tems/

  Test:     kselftest-filesystems
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.19.288-cip101-1117-g1f3468542aa9e
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      1f3468542aa9e444da3a41472888366e97d515e2 =



Test Regressions
---------------- =



platform               | arch   | lab           | compiler | defconfig     =
               | regressions
-----------------------+--------+---------------+----------+---------------=
---------------+------------
asus-C436FA-Flip-hatch | x86_64 | lab-collabora | gcc-10   | x86_64_defcon.=
..6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64d9ff67d45093cd5035b253

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.288-cip101-1117-g1f3468542aa9e/x86_64/x86_64_defconfig+x86-chromeboo=
k/gcc-10/lab-collabora/kselftest-filesystems-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.288-cip101-1117-g1f3468542aa9e/x86_64/x86_64_defconfig+x86-chromeboo=
k/gcc-10/lab-collabora/kselftest-filesystems-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/amd64/initrd.cpio.gz =



  * kselftest-filesystems.login: https://kernelci.org/test/case/id/64d9ff67=
d45093cd5035b254
        new failure (last pass: v5.10.186-cip37-12-g2710acbceb75) =

 =20

