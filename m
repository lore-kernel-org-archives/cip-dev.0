Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A125C46CA3
	for <webhook@archiver.kernel.org>; Wed,  6 Dec 2023 07:34:56 +0000 (UTC)
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
 by mx.groups.io with SMTP id smtpd.web11.26258.1701848090218242495
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 05 Dec 2023 23:34:50 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=BEtiwKmO;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.169, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1d048d38881so31259945ad.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 05 Dec 2023 23:34:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1701848089; x=1702452889; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=CIFR101NCRBfxRKOWLtGfgNr3AHnDpFSLDElq+7Ovfs=;
        b=BEtiwKmO/0ceZWreCTTvJzKltTCdjL9algt09WdeDUnGeUUA0ZVsraxlho7VMTskTF
         r4x0klXBlrXb1Vs4X4Z6bu71seybL3MmzN1WFnDNXSQ632tJolrbEphK1WBFfe4vu3et
         aZtKZuFgBlEw7H3Tj7hlMgJqz407AJUQvP03bJgOLbrrxrNe9pbN5FpmuBNkgdaU9gxt
         JQjJXDCQLfSz6kIhL5kj4aAhAcAd3Q41MTL+7fbn7uIHjbNFvhPunmD0XKpiQOzcr/aF
         h6m99RZDu6YTpbkK4WheSvpHT2CqZVDyDQpMUi0eKs1BQPwk19b9ZNI9ZPK59bG5ADBo
         8JLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701848089; x=1702452889;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CIFR101NCRBfxRKOWLtGfgNr3AHnDpFSLDElq+7Ovfs=;
        b=knbDfEk5U9vX+xd+ggm8Od6nVsF4Zurv0PBLrdg5BRw5hpexNEl71f9ztqFROCGmB6
         x76TK8eCXwtSAislqc/HMESIgPZ+VRj7SAJGgYiOVBaGeYpR7z0sxqPR+HvsPz4QYuuH
         WuBRV+Q0L6jWwfpPZZrwEHski0JtWd06tFi8q7uybiwIShGYAkLWdXRdY5bErgFx3uBv
         XR0Yerwd51kJGKcO/+RqCj3ONyWPOH19FVVV4BCdc5bdgkcc3W3a+p5NJgTd0jvHBR0O
         K3RxPqsft/kCb/mzixbvEuYPHq7Tc+D7/Lm4ry5msbMt8MG51Pf3JKO01dROdEixKDKj
         QdrA==
X-Gm-Message-State: AOJu0Yxrk2KN3YTF7tAshSse+4JLY2sS86vd9rBljhAIIij1KA6LO75n
	96BXei7nL+KNvnf7tr/HFzwGonRztQSyKI7oK2aJwQ==
X-Google-Smtp-Source: AGHT+IHWFCaX/Ic0x+xC2S+1o2tffzNb1ZYjs/dsMI+hgLBFQLVlOiZTlvX80JvVSa1WJs7bLOA0gg==
X-Received: by 2002:a17:902:778c:b0:1d0:c26d:e513 with SMTP id o12-20020a170902778c00b001d0c26de513mr292380pll.48.1701848088915;
        Tue, 05 Dec 2023 23:34:48 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id l13-20020a170903244d00b001cc3a6813f8sm6871546pls.154.2023.12.05.23.34.47
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 23:34:48 -0800 (PST)
Message-ID: <65702418.170a0220.599be.1f4d@mx.google.com>
Date: Tue, 05 Dec 2023 23:34:48 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.201-cip41-16-g3c85fba3b6e5d
Subject: cip-gitlab/ci/pavel/linux-test ltp-pty: 8 runs,
 1 regressions (v5.10.201-cip41-16-g3c85fba3b6e5d)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 06 Dec 2023 07:34:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13798

cip-gitlab/ci/pavel/linux-test ltp-pty: 8 runs, 1 regressions (v5.10.201-ci=
p41-16-g3c85fba3b6e5d)

Regressions Summary
-------------------

platform                 | arch   | lab           | compiler | defconfig   =
               | regressions
-------------------------+--------+---------------+----------+-------------=
---------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
nfig+x86-board | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.201-cip41-16-g3c85fba3b6e5d/plan/ltp-pty/

  Test:     ltp-pty
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.201-cip41-16-g3c85fba3b6e5d
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      3c85fba3b6e5da8b112e7ecd142649674648028f

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


  Details:     https://kernelci.org/test/plan/id/657014820f0d1e3982e1347a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-16-g3c85fba3b6e5d/x86_64/x86_64_defconfig+x86-board/gcc-10=
/lab-collabora/ltp-pty-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-16-g3c85fba3b6e5d/x86_64/x86_64_defconfig+x86-board/gcc-10=
/lab-collabora/ltp-pty-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/amd64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/657014820f0d1e3982e134=
7b
        new failure (last pass: v6.1.64-cip10-rt5) =

 =20

