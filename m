Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 321EFC4332F
	for <webhook@archiver.kernel.org>; Wed,  4 Jan 2023 13:22:13 +0000 (UTC)
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
 by mx.groups.io with SMTP id smtpd.web11.11765.1672838523552268368
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 04 Jan 2023 05:22:03 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=v481BlBm;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.169, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f169.google.com with SMTP id c6so2631776pls.4
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 04 Jan 2023 05:22:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=75YuooMwNkEmehx4ias4PiHGKDfvKm/4pne013GK6vk=;
        b=v481BlBmooSw5QzS0dy8e0dBakZyKYCH9koUZs35Ddj0oMEkg0iJRQqxvlTzA/tcgU
         QPoDUPwxEGVOCjFhDJOedw7cjoum+yvEawWKwPf8wEK+vYgJ3oiewSzanSVYWlgLLFJt
         4NNDHYQle/Y7bsYm22l2on7znMbDaQ2sIcaE3ndOz42PWxJ6eQYOdjIbWfsV8Gl1IolQ
         qGqb38X7QB+GbvAozvc87B+GNphLdsbv3t8F8Ttfq4tAwls5xyi/nHO/XRcSj5/ICH8k
         eBF8/1vbu5wGlAmJYyo6s640Nx8Bxcl2UqxQpoWCY5P0UZ+mP35OJ6AO2Lf5LHUdUxSF
         H1kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=75YuooMwNkEmehx4ias4PiHGKDfvKm/4pne013GK6vk=;
        b=KGoo7UwMkROsUHnGiPz+ocveNoyu+kFZmcoM36UQn25QApcKq6mOECp8wqIbO2g/Wq
         oh47Qx5VnwwCh88wmcXb81E1EG7yBeN77JqG6CbRctR/h4PaPYqdzSiqg/Co06laZgam
         2Ue/OqY2G11q36viHjQD7fofvmi9DI4zuFeCw7sSN3e0yJM1zj+azuIlMHDlWzB3RqX5
         YFsDLQ0RwRETFiElUdbHmmbh1owcMUGvH9OM2lUreiM9osz0MSSvg8UXdQcRan4CvFOx
         AYxQny56/RdsaAwZgtlAwZ8Z3XHP1RyCFD9Z6x0RwnNmMfUh5gnGKLJnmRuIhe0d/lzL
         RHAg==
X-Gm-Message-State: AFqh2kopFhdyx9qzUlIgTVXW9RA9TZpu1ClZBMYJCTG1wCtGQR/RAlv3
	fgmm2jL5qXol9ptt2pydsH4q/KKJhcfNWeqB9bg=
X-Google-Smtp-Source: AMrXdXt/XA/Oj3WH0SiuEBYTR2KjRNp2TP49b2keR0an1paBKxe+KPmxoW1VoKiTv7peVwtJ115hww==
X-Received: by 2002:a05:6a20:c19f:b0:ad:600c:54b1 with SMTP id bg31-20020a056a20c19f00b000ad600c54b1mr61929541pzb.59.1672838522876;
        Wed, 04 Jan 2023 05:22:02 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id i189-20020a636dc6000000b00476b165ff8bsm20617625pgc.57.2023.01.04.05.22.02
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 05:22:02 -0800 (PST)
Message-ID: <63b57d7a.630a0220.bb56a.0808@mx.google.com>
Date: Wed, 04 Jan 2023 05:22:02 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.10.161-cip23-65-gca8c192cb189
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-pty: 9 runs,
 1 regressions (v5.10.161-cip23-65-gca8c192cb189)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 04 Jan 2023 13:22:13 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10310

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-pty: 9 runs, 1 regressions (=
v5.10.161-cip23-65-gca8c192cb189)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm64-chr=
omebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.161-cip23-65-gca8c192cb189/plan/ltp-pty/

  Test:     ltp-pty
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.161-cip23-65-gca8c192cb189
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      ca8c192cb189c6be84da2274a96e73320a638b43

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  8048a7cf905e36645b6b0f0fb8c5031a5ed1c97f =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm64-chr=
omebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63b578e2951ebbc0504eee9d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.161-cip23-65-gca8c192cb189/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-cip/ltp-pty-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.161-cip23-65-gca8c192cb189/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-cip/ltp-pty-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20221230.0/arm64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/63b578e2951ebbc0504eee=
9e
        new failure (last pass: v5.10.158-cip22-142-g79bb6f9db05d) =

 =20

