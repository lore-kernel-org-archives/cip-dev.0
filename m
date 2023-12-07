Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D901FC4167B
	for <webhook@archiver.kernel.org>; Thu,  7 Dec 2023 07:46:54 +0000 (UTC)
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
 by mx.groups.io with SMTP id smtpd.web10.78991.1701935208831167431
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 06 Dec 2023 23:46:48 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=QDTyJEV/;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.173, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-5bdbe2de25fso479790a12.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 06 Dec 2023 23:46:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1701935207; x=1702540007; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=nT0PIR6Y9oc1PhtrMPd58t/jOm+d0LFA0FoGloK98io=;
        b=QDTyJEV/3T1dieubmGMSWvLF3ZuhcsU68OwhfaONypc/dalvTkvnB1fXDhvu2HpRrH
         CGQ7/2TsV4qVXZ5zLsSq8VFA49NZfPWnwXJC6DrXeKTw6hkiMC+mtP39ffa+fzqoZt/O
         Z/YJu0nS/CSeQITbQHI6FLQC0bKKJnpPRo/4A8Ize0Dv7HIarSCgr1albgwqWrfvr3CD
         x05qd7jvePYZS32nAloB8kYYCssT5sxKGA7fIYpIhPFqTZI3Y/0jmodz2koWThzzF0iD
         L32DHWaLWNn8nXOwhUHwTUAxy7CUiW/qQWyyOd5JgT02YxVy0Y2V9+g5oHjrZSR0Hz17
         qsXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701935207; x=1702540007;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nT0PIR6Y9oc1PhtrMPd58t/jOm+d0LFA0FoGloK98io=;
        b=gDRJMS+3sw3hzzTPqNfbhDv3RgvcSyRvb6ljlhiNQ9bO4rsbvhxWsa1Zyoy7Ag+1cZ
         claxii1djWm6TREjFycSZSbhhO0Q9KagqSoHRmasyAWUJvrcdDIdbibLN4POmVOSJ5yR
         b2SnHZ9KSSSJTRWGLcXXdClIMeJtrCPtXTpb6EgcuRY2S7lhi4aEoyqvWLD5V2E2Huur
         fPLKgd1FnfjD63TLN2Lr2zwJdnCePqp6KkP6rZZ5x5nIyiunRSZaoo1U5rST610Sk01J
         AdRuxp/mY1nSMoycUG5oGvwMhw2xc7fQKIwwcba/4axrimYDZvRuEiS+ebYc4pvoUni/
         mIaQ==
X-Gm-Message-State: AOJu0YwBc9SWQk5OIkcXibQAzu025vkjM/Qu1ehcvDN6m/YvGAiSZ9mM
	OwJIymknaKqj84CjpngH6hUcUYDC3keIdtL+vl9aqA==
X-Google-Smtp-Source: AGHT+IHrz7OmDLf6jAzFFP+by9HvUhjOnRypyXD3u0hFYKa13lWpXRQ3fYif+jmR6McKonU1TXlHNQ==
X-Received: by 2002:a05:6a20:a127:b0:18c:4b78:37a8 with SMTP id q39-20020a056a20a12700b0018c4b7837a8mr1981677pzk.45.1701935207541;
        Wed, 06 Dec 2023 23:46:47 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id fn22-20020a056a002fd600b006ce5da5956csm671296pfb.24.2023.12.06.23.46.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 23:46:46 -0800 (PST)
Message-ID: <65717866.050a0220.68345.1b07@mx.google.com>
Date: Wed, 06 Dec 2023 23:46:46 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.4.y-st-rc
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.4-st20-1987-g9e48fc479c400
Subject: cip/linux-4.4.y-st-rc ltp-pty: 3 runs,
 1 regressions (v4.4-st20-1987-g9e48fc479c400)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 07 Dec 2023 07:46:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13810

cip/linux-4.4.y-st-rc ltp-pty: 3 runs, 1 regressions (v4.4-st20-1987-g9e48f=
c479c400)

Regressions Summary
-------------------

platform                 | arch   | lab           | compiler | defconfig   =
               | regressions
-------------------------+--------+---------------+----------+-------------=
---------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
nfig+x86-board | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.4.y-st-rc/kern=
el/v4.4-st20-1987-g9e48fc479c400/plan/ltp-pty/

  Test:     ltp-pty
  Tree:     cip
  Branch:   linux-4.4.y-st-rc
  Describe: v4.4-st20-1987-g9e48fc479c400
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      9e48fc479c40013a21ec5c14b702b67ac153fb38

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


  Details:     https://kernelci.org/test/plan/id/65716ae5f82a973185e134b9

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-st-rc/v4.4-st2=
0-1987-g9e48fc479c400/x86_64/x86_64_defconfig+x86-board/gcc-10/lab-collabor=
a/ltp-pty-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-st-rc/v4.4-st2=
0-1987-g9e48fc479c400/x86_64/x86_64_defconfig+x86-board/gcc-10/lab-collabor=
a/ltp-pty-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/amd64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/65716ae5f82a973185e134=
ba
        new failure (last pass: v4.4-st20-1872-g0dd3085de20bc) =

 =20

