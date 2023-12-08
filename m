Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11A4FC10F09
	for <webhook@archiver.kernel.org>; Fri,  8 Dec 2023 17:49:16 +0000 (UTC)
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
 by mx.groups.io with SMTP id smtpd.web10.42740.1702057746197510738
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 08 Dec 2023 09:49:06 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=GKoA9AiC;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.181, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6ceb27ec331so1732862b3a.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 08 Dec 2023 09:49:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1702057745; x=1702662545; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zp/HYD+8KHuxX72mrlCZxv7ccMDs9WRUQiQnIc7ZVLs=;
        b=GKoA9AiC5uiNxf9TRSBUzAi2dzq5NMCfcaWrmHwZCv6K3oGIqOcKb575WBz74UA180
         6Y0GfAqzvtfYqWBFRkmUre/RZP+sS+rg5KGm1gPr7lF8VWTyGm4BLICcozf/I8mEEjHu
         FAoXDlGJ4aGcz848MLzgt2qAFLzcH+2WVX9Y5yWwRcl9DuaWxP+bkg1K3XoxMz6tnfwI
         USupyKbocXbb3JyxZud/XhI9dOnu1xr6obzx/bKWsPMW2LISDW5i+I7fhnBwKm0I7zuk
         6oYErXuT4Qgji+ro+/9lhkjy1zEdWjo3k+qI9DD3IIs/NXmq0mEFc1BIv4n6HNBN1nBv
         UCYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702057745; x=1702662545;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zp/HYD+8KHuxX72mrlCZxv7ccMDs9WRUQiQnIc7ZVLs=;
        b=ZQd2WeH/1ZrIWNZvqp0txHjK8zfg3jLqGpNWv9SS954vLLMLEqa1k1fz9P+6ZvSEBL
         mPOtAK8iFACh7xidiEitXRrp9HFGmgtvgoPJKocSK8YQ/D/EQiX+4aomnsdzdMXFiBnT
         n0e3hZFsEf0bGe60NsIC8k9KvMBlET6OMMFdSG0YP/klQd83mZU0LknL2ZtU1UBHgeR8
         8l0e1t5APjkJ1GVXSsLeXbS3lr8WXkssIZna3h5oy55wvJDIYq2K/kJDLTevDDpUGAfe
         wlEvu8I2j8Gmx06Dml6W8SvPTWha/C1CEHJgW9gbJYaDgK1sS3w0eEXm9ZPLc5X2N005
         X6pw==
X-Gm-Message-State: AOJu0YwblRL95H+v1o8dVYjcl5A0muZlbPAsVLkqkXiNd8RF7yALR/yi
	1jbh9eLZrZN//0AGnd5GhcuGCSGjjLUVQeY/pSqddw==
X-Google-Smtp-Source: AGHT+IFVmmClVo58nwb0YXwdTYM96LSk+/2XUipsC9Jmyc/Z3tOUkoOMn4HxzXspmhXzya0f4ooXdA==
X-Received: by 2002:a05:6a00:1584:b0:6cd:fada:31a7 with SMTP id u4-20020a056a00158400b006cdfada31a7mr462391pfk.7.1702057745053;
        Fri, 08 Dec 2023 09:49:05 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id o137-20020a62cd8f000000b006cbb3512266sm1932263pfg.1.2023.12.08.09.49.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 09:49:04 -0800 (PST)
Message-ID: <65735710.620a0220.c3dcf.6cea@mx.google.com>
Date: Fri, 08 Dec 2023 09:49:04 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.201-cip41-46-g596f4c151d286
Subject: cip/linux-5.10.y-cip ltp-pty: 6 runs,
 1 regressions (v5.10.201-cip41-46-g596f4c151d286)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 08 Dec 2023 17:49:16 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13982

cip/linux-5.10.y-cip ltp-pty: 6 runs, 1 regressions (v5.10.201-cip41-46-g59=
6f4c151d286)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig | regress=
ions
-------------------------+-------+---------+----------+-----------+--------=
----
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig | 1      =
    =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.201-cip41-46-g596f4c151d286/plan/ltp-pty/

  Test:     ltp-pty
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.201-cip41-46-g596f4c151d286
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      596f4c151d286c71a3612a2120ab33f4ac885d2e

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig | regress=
ions
-------------------------+-------+---------+----------+-----------+--------=
----
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/6573486e96f96f98c1e13475

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-46-g596f4c151d286/arm64/defconfig/gcc-10/lab-cip/ltp-pty-r8a774a1-hi=
hope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-46-g596f4c151d286/arm64/defconfig/gcc-10/lab-cip/ltp-pty-r8a774a1-hi=
hope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/6573486e96f96f98c1e134=
76
        failing since 28 days (last pass: v5.10.184-cip36, first fail: v5.1=
0.200-cip40) =

 =20

