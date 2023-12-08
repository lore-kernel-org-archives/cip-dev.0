Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29F9EC4167B
	for <webhook@archiver.kernel.org>; Fri,  8 Dec 2023 13:28:34 +0000 (UTC)
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
 by mx.groups.io with SMTP id smtpd.web10.35481.1702042106447901821
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 08 Dec 2023 05:28:26 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=rDx+rguR;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.175, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-5c5f0e325a6so1427871a12.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 08 Dec 2023 05:28:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1702042105; x=1702646905; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=UV9+TcMIXGSRhNQ3gzhGKq9HuYNkebZHdSWYXNYsUqs=;
        b=rDx+rguRQScelXDl4zz8EwXJD323454Y9FxOoy1+3/R7uVz/XVpZMdDbVqu8wAniQy
         ZyFGtiu70NULxEUBCs8lgpVNkwTQtAnCmgOt+l2mepWQtbS4uBuQ9qdNUnGbPQ7xGm5T
         iOHrwb+vr+GiC3wrlghrbO3c4HnmfU+FtwwMMgZt6KQe0jKPMJ0DM3+8HswS9IZKypgZ
         mSOnXbmdMoYk4dLbDZoNOZlJ1qreM04EwjueJsyLsiVfMCHU/vc9Nr7PTMT8rqRI3kR3
         flvepgRzPJvAubb52YVSwva9bCIy1u+Nq1LlOnBoqxTkxrG1KfFMDBi4XdxmI3mIaplB
         WBCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702042105; x=1702646905;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UV9+TcMIXGSRhNQ3gzhGKq9HuYNkebZHdSWYXNYsUqs=;
        b=qcCqoXYo/efyMoVSut0XtS+MI43RyhSKIkcoBRdg8uEyYbId0s+CsKyoZssp1OH7pS
         9FQfdlMrcw5k5ypDJLTYROAC20wvjfp5Yyiwlu4Q80sAvkwzk7br10HGBNqSVOWV+F3E
         c0fPY5bfQ/VCZW0Q855KX6U9AR3aVk73E0tMkBKDUxXBhpzng/1eE3E4HpiqtvGNi8QY
         k97ZB8B1ilGEYqgfF9yQuLaUnO74xRyyWQgO9Nv443Q5vpBeuQMiCISIwBp4jZUeP4mu
         7hYFmjlE0CHM/7jMcZkst4szgXi07Eapa2cC5nQRaeji2xMAabGnh/bZdVV/yZ9nIngR
         moLw==
X-Gm-Message-State: AOJu0Yw3PW80wqFvUpEeiezdpmYGLcjG1ER7EmAagYhPO/ZnobEPPDng
	Wzh7gsl9b0PkVUazDkVllhUrsGYCx7bDDR81KFGI4Q==
X-Google-Smtp-Source: AGHT+IFQ+pE7mY6ALn5QnmhYTqO/WVYlZUxEdSQ9Q2jz4DQnpx92gUJpPQabn0iqSZCRFvKn94FYvQ==
X-Received: by 2002:a05:6a20:3942:b0:18f:ee27:aa59 with SMTP id r2-20020a056a20394200b0018fee27aa59mr8994pzg.10.1702042105048;
        Fri, 08 Dec 2023 05:28:25 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id l16-20020a170902f69000b001cfba46e407sm1658060plg.129.2023.12.08.05.28.24
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 05:28:24 -0800 (PST)
Message-ID: <657319f8.170a0220.f765.5176@mx.google.com>
Date: Fri, 08 Dec 2023 05:28:24 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-4.19.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.19.299-cip105-158-g856c181dce342
Subject: cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc ltp-pty: 6 runs,
 1 regressions (v4.19.299-cip105-158-g856c181dce342)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 08 Dec 2023 13:28:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13969

cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc ltp-pty: 6 runs, 1 regressions (=
v4.19.299-cip105-158-g856c181dce342)

Regressions Summary
-------------------

platform                 | arch   | lab           | compiler | defconfig   =
               | regressions
-------------------------+--------+---------------+----------+-------------=
---------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
nfig+x86-board | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-4.19.y-cip-rc/kernel/v4.19.299-cip105-158-g856c181dce342/plan/ltp-pt=
y/

  Test:     ltp-pty
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



platform                 | arch   | lab           | compiler | defconfig   =
               | regressions
-------------------------+--------+---------------+----------+-------------=
---------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
nfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65730f40375f961215e13477

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.299-cip105-158-g856c181dce342/x86_64/x86_64_defconfig+x8=
6-board/gcc-10/lab-collabora/ltp-pty-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.299-cip105-158-g856c181dce342/x86_64/x86_64_defconfig+x8=
6-board/gcc-10/lab-collabora/ltp-pty-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/amd64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/65730f40375f961215e134=
78
        new failure (last pass: v4.19.297-cip104-63-ge7301d2e196ae) =

 =20

