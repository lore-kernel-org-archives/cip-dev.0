Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36849CE79AC
	for <webhook@archiver.kernel.org>; Tue, 19 Sep 2023 23:42:06 +0000 (UTC)
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
 by mx.groups.io with SMTP id smtpd.web11.25558.1695166924972463922
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 19 Sep 2023 16:42:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=Ik+ERJvq;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.180, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1c4194f769fso45447835ad.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 19 Sep 2023 16:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1695166924; x=1695771724; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=V1A1P3fD28L3ZUZh3UNW5YyJ0pcNzJokVYQS/IKg3I4=;
        b=Ik+ERJvqj2uRwthT2+1T0S48Qux/O+S1Ib8XqY+12OMsdx6MNXQKPORtcjkn3TmTe5
         TuGrBZe+jBLcgmBgDUk6j31p4ktJOJepQkHSJiPo6DehaNjSGhyTMUOnsbp1Y22T+Luz
         x/guDIvzaMGyn3UqgTdPOFcIFB3uuZF11e/2xPbRC56zMebeTGG3ZnDL5OV8UT5kuqTZ
         kHZpZO+wKPE/z3AhiRhdz+NdfRjF/akghn/PtFwOwy/mEOfHdK8gEfVtu5ygZXGC0LDp
         zowffQEOTBbUZDiVouc0NicGhGhbFJiT/cBFwL3gsuJSkvh9Hc9qaB2JvICuZOApzLGO
         0FbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695166924; x=1695771724;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V1A1P3fD28L3ZUZh3UNW5YyJ0pcNzJokVYQS/IKg3I4=;
        b=pl4SHMHe66HTfvNY/nyGC/R930znFPgVEeDbxb51oV1od+kc4yyAjiNF45CKkLFuMu
         ucUlVf2saRR+iiNUnHB5ljZhSYJ++H4GXd7oI/M/4Rzf3nAhJ3vaZKmc09ARKPTBRU+T
         DXPL9iVfbJQJ1jUfhlgH163O7CM+5GrT14yxQTyxgGFIFuii5Kkx7IDMJu6n/GpJhGpw
         ILNoyGdMCPy3pgmxDLlElFpuvjG3eqjk67kmWr9W5CMOj3Ye4w6XTUthc7XYJ+1wxq80
         5Nyx2Yjv8gqVDP4Ry/9Ywkx0CQjKDc0vvjlKM7apJdnv1rcbaIaBNnxUr1S87Gz3gCG6
         psoA==
X-Gm-Message-State: AOJu0YxY1947kVpp0im53gjYyU204tIV5li4I8XwE07Z8opxCFQK77Q1
	/W8tsYP5MJt5WH0zPFhTo1C/uon3oqlimXlRPtYvjQ==
X-Google-Smtp-Source: AGHT+IHFL+W8iJV9i7cOVlkuocV9HNz0hAGRUbr32/ANSE0kB3ZCpo0rSErdAqh0CXgNp0U5nTDE3g==
X-Received: by 2002:a17:902:b901:b0:1bf:c59:c944 with SMTP id bf1-20020a170902b90100b001bf0c59c944mr841520plb.22.1695166923977;
        Tue, 19 Sep 2023 16:42:03 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id d18-20020a170902ced200b001bba669a7eesm10496444plg.52.2023.09.19.16.42.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 16:42:03 -0700 (PDT)
Message-ID: <650a31cb.170a0220.2ef9.685d@mx.google.com>
Date: Tue, 19 Sep 2023 16:42:03 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip-rt
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v5.10.194-cip39-rt16
X-Kernelci-Report-Type: test
Subject: cip/linux-5.10.y-cip-rt ltp-mm: 2 runs,
 1 regressions (v5.10.194-cip39-rt16)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 19 Sep 2023 23:42:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13170

cip/linux-5.10.y-cip-rt ltp-mm: 2 runs, 1 regressions (v5.10.194-cip39-rt16)

Regressions Summary
-------------------

platform           | arch   | lab           | compiler | defconfig         =
           | regressions
-------------------+--------+---------------+----------+-------------------=
-----------+------------
hp-11A-G6-EE-grunt | x86_64 | lab-collabora | gcc-10   | x86_64_defcon...k+=
preempt_rt | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip-rt/ke=
rnel/v5.10.194-cip39-rt16/plan/ltp-mm/

  Test:     ltp-mm
  Tree:     cip
  Branch:   linux-5.10.y-cip-rt
  Describe: v5.10.194-cip39-rt16
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      7aa1fa8ed3b5d0130443043c96b985082bf55241

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform           | arch   | lab           | compiler | defconfig         =
           | regressions
-------------------+--------+---------------+----------+-------------------=
-----------+------------
hp-11A-G6-EE-grunt | x86_64 | lab-collabora | gcc-10   | x86_64_defcon...k+=
preempt_rt | 1          =


  Details:     https://kernelci.org/test/plan/id/650a256ad4a13f120b8a0a42

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+preempt_rt
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
194-cip39-rt16/x86_64/x86_64_defconfig+x86-chromebook+preempt_rt/gcc-10/lab=
-collabora/ltp-mm-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
194-cip39-rt16/x86_64/x86_64_defconfig+x86-chromebook+preempt_rt/gcc-10/lab=
-collabora/ltp-mm-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/amd64/initrd.cpio.gz =



  * ltp-mm.login: https://kernelci.org/test/case/id/650a256ad4a13f120b8a0a43
        failing since 124 days (last pass: v5.10.175-cip29-rt12, first fail=
: v5.10.179-cip32-rt13) =

 =20

