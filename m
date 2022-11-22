Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7254C43217
	for <webhook@archiver.kernel.org>; Tue, 22 Nov 2022 11:56:29 +0000 (UTC)
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
 by mx.groups.io with SMTP id smtpd.web11.17007.1669118179663039745
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 22 Nov 2022 03:56:19 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=vWMYlG8o;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.52, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f52.google.com with SMTP id b11so13076299pjp.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 22 Nov 2022 03:56:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=vDu+FRL+b+sSJk2snqU0JVO+BheFhFSJL8uUeGdUtbA=;
        b=vWMYlG8oyKmUH7WF4i1+eFNI3qKEq7UCdZ1Aj0CN5n8+F0iV0gpUlHcmJ0z9DcZnUQ
         I5hcVsw4Hq1rkZA0EoNHHCtVD1qfSV1IPESS9+qyKLv42zEnSM5RPQ7islY4w1S6DSYl
         eBWzSM4W+6PhZRjzxG1lV8IihcQ83NFNfyfUUyVJbuQawZ1v62b62Sd5JLrn7AodNm71
         S6CRglg4vk59xpetGiu0yJ4ls15sct3LdnxibIApyg3TnU+zSD3nsHpQvkhPGpVetAUg
         O27dPrqXYKHw354jjYoZTeWockVDKeIppVAl0Ze9fk3z84m7VQIHoK0OL6WP+efGe4eK
         kr5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vDu+FRL+b+sSJk2snqU0JVO+BheFhFSJL8uUeGdUtbA=;
        b=6d6PWvLEQwEQRB2Fnc2m0PNkFjmNYeNoRl40zliM6QUmJoLA+HrdGK4jGBHYnVK8T2
         wwMkQHBxVvUiRkdnlDlQdb+1t86IiFJI+UOLZFXhal9V+UKeMshJUT1htBfjZCRKKOc5
         LnOUUFRdUEYLgLQeehpOi4UhY3YT+GYhfvY1as/IsQtytNFVEB1mSMcdBgmC40ug+LXy
         TsUwBP+xHc0onkixZVAccFBZWBYQvlDQ/vS2+o45J+arh8E2YE0XGXFMXhh9f0U/PGaj
         +BgtBOo/8cqBwu88sgf0NM8jD9V6AzPaF92Lv9iByFwsIm/codIJ5cJ37XuXf8kNZbt/
         olGA==
X-Gm-Message-State: ANoB5pmdTpcT3nkflgiPfNzC2gNofgU/yMsHUUUKQa/jdgAWTB/VsyRL
	UQYiTeUZmknY73hDomMyRcHFnYcv2ncRsikjhvA=
X-Google-Smtp-Source: AA0mqf6BnqBBEDng9LHEEp/dh/WNGDZF+xNhYnJbO1RXnElArsvPcK8l0igBquR1O+cOIzouQVxXJA==
X-Received: by 2002:a17:90a:df06:b0:212:d299:4758 with SMTP id gp6-20020a17090adf0600b00212d2994758mr31038707pjb.120.1669118178744;
        Tue, 22 Nov 2022 03:56:18 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id z12-20020a170903018c00b00186616b8fbasm11931497plg.10.2022.11.22.03.56.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 03:56:18 -0800 (PST)
Message-ID: <637cb8e2.170a0220.2d069.2cc6@mx.google.com>
Date: Tue, 22 Nov 2022 03:56:18 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.4.y-cip
X-Kernelci-Kernel: v4.4.302-cip70-236-g69445bc0d4209
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip
Subject: cip/linux-4.4.y-cip ltp-pty: 3 runs,
 1 regressions (v4.4.302-cip70-236-g69445bc0d4209)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 22 Nov 2022 11:56:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10076

cip/linux-4.4.y-cip ltp-pty: 3 runs, 1 regressions (v4.4.302-cip70-236-g694=
45bc0d4209)

Regressions Summary
-------------------

platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.4.y-cip/kernel=
/v4.4.302-cip70-236-g69445bc0d4209/plan/ltp-pty/

  Test:     ltp-pty
  Tree:     cip
  Branch:   linux-4.4.y-cip
  Describe: v4.4.302-cip70-236-g69445bc0d4209
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      69445bc0d4209b0634d1f43657fd58f708cadf81

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  a15eb3cdfa3556203167572e15754f1f59ba26bf =



Test Regressions
---------------- =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/637cae87018e715c902abd17

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip70-236-g69445bc0d4209/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-c=
ollabora/ltp-pty-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip70-236-g69445bc0d4209/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-c=
ollabora/ltp-pty-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20221107.1/amd64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/637cae87018e715c902abd=
18
        failing since 130 days (last pass: v4.4.302-cip69-296-g52de9431d314=
, first fail: v4.4.302-cip69-508-gd887d54a1be6) =

 =20

