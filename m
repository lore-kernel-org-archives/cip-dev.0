Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 369A9C46CA3
	for <webhook@archiver.kernel.org>; Fri,  8 Dec 2023 13:28:34 +0000 (UTC)
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
 by mx.groups.io with SMTP id smtpd.web10.35482.1702042106566777938
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 08 Dec 2023 05:28:26 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=BKIBQS2r;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.169, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6cb55001124so1361835b3a.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 08 Dec 2023 05:28:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1702042105; x=1702646905; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=kU9N1SQXXmOvUFCqcuujN4GZiM9WzaKE4JbPL/kSVX4=;
        b=BKIBQS2r42WHinYFr/Kf3+7cHqpCctMJkar8oqBwzcMTDIxaHLUoQYjO6CKoVXhmAD
         yOgrMzRjzMwzwgU6nnqWHqcYZ90r8OlXbxZcDsTS2NV5+leW3RHFqv8WvV8goewKReB6
         GOUxW2RiA2oWsVCVAOvs37++IdtBDDza2+7nQJiaQf5gT56GZCBF47TqZKBr3hAW4vtO
         w+IuXfBNPipnZAeo/2sTXI2JZx/miLBJXmthcnLDiicCmO7CIHJAnrUim3taK1BHeS9J
         T1Xzco3bs2mvyr7et9MT4e1iE/gnENJJYLFOqD6Rq5fRQ4SzDe0hLdYoVFXukhQXGIo+
         DB6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702042105; x=1702646905;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kU9N1SQXXmOvUFCqcuujN4GZiM9WzaKE4JbPL/kSVX4=;
        b=UYwMe3XTbhDlwMbVBLjLUbM+UNWhA8nVuO5SfWOXEwjXuqxR5uYYvP0F1C+o+5SIVr
         8JORjhY2La/vEl59aSHyZa95YjvSs3gfYY2NCtFnlGPpjJEzX/eIG4HVntb6qY1jp73q
         3Sp8JcnHLt6goGjRWuZzbua2Dyj0WbdxE69VZxXPjlPeKeyyvZ9SYrA2NluXMZlVh1ZS
         u2keXf4h7+paCsHmi+5AqXscs/FgwMCndQbEVhwsEjkBj1fAEd5ng8t/DpGfwEVYJxYL
         5ssx5rhFNEQwsNpTd+teebt9qvjKsHnsELgQjsInVB85ADGjBI/O4w7hTbgyahjfZ32E
         vShg==
X-Gm-Message-State: AOJu0YxnUNKt1rK+OKYRU64Imlu3JbrxPECO8G8STjEoAk/87gc/Gib+
	7E4aQ0veralLxdBLoYT+3PxXUxeApiqDytbX37CJSg==
X-Google-Smtp-Source: AGHT+IEVHx+sCXj6kvMXejIXIAQZ2/a7+VAbdU8ykJxZbIZspLDELWvZ8d4f63XOJRTy41m42fK48g==
X-Received: by 2002:a05:6a20:7f83:b0:18b:594a:284c with SMTP id d3-20020a056a207f8300b0018b594a284cmr1127908pzj.15.1702042105439;
        Fri, 08 Dec 2023 05:28:25 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id k189-20020a6324c6000000b005bcea1bf43bsm1500602pgk.12.2023.12.08.05.28.24
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 05:28:24 -0800 (PST)
Message-ID: <657319f8.630a0220.4da19.4969@mx.google.com>
Date: Fri, 08 Dec 2023 05:28:24 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-4.19.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.19.299-cip105-158-g856c181dce342
Subject: cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc ltp-timers: 9 runs,
 2 regressions (v4.19.299-cip105-158-g856c181dce342)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 08 Dec 2023 13:28:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13970

cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc ltp-timers: 9 runs, 2 regression=
s (v4.19.299-cip105-158-g856c181dce342)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm64-chr=
omebook | 2          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-4.19.y-cip-rc/kernel/v4.19.299-cip105-158-g856c181dce342/plan/ltp-ti=
mers/

  Test:     ltp-timers
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-4.19.y-cip-rc
  Describe: v4.19.299-cip105-158-g856c181dce342
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      856c181dce342f36a06ba6a8062830cca0f733a8

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
omebook | 2          =


  Details:     https://kernelci.org/test/plan/id/6573153a78c1de0b1be134c1

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.299-cip105-158-g856c181dce342/arm64/defconfig+arm64-chro=
mebook/gcc-10/lab-cip/ltp-timers-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.299-cip105-158-g856c181dce342/arm64/defconfig+arm64-chro=
mebook/gcc-10/lab-cip/ltp-timers-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/6573153a78c=
1de0b1be134c6
        new failure (last pass: v4.19.297-cip104-63-ge7301d2e196ae) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/6573153a78c=
1de0b1be134c6
        new failure (last pass: v4.19.297-cip104-63-ge7301d2e196ae) =

 =20

