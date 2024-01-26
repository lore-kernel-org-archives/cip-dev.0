Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BD03C47422
	for <webhook@archiver.kernel.org>; Fri, 26 Jan 2024 06:48:40 +0000 (UTC)
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
 by mx.groups.io with SMTP id smtpd.web11.10190.1706251711285967056
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 25 Jan 2024 22:48:31 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=Zy5TdIbX;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.181, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-5d3907ff128so30686a12.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 25 Jan 2024 22:48:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1706251710; x=1706856510; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=JNHD+3z25x3Yy/MYa/15U00Na0XAPZfDaLJkbBIFeyU=;
        b=Zy5TdIbXPWRY66QQbrHEZBNXvQof26KYWZnDwNIVImBR9wun5i27nSPKh0ZhrONcz/
         eYtRZP1DVKfWS2L6L4eg77GHoJERoT7Tz1KJRiVzsZ4d/iUSglNIU7yYYXtjFqPTMATm
         4rjS//PXNSriOqDPqS1Cr7sILspvr2z9oSKsiJlN0eNHKPW775txE2wj8FA/7QcCQU0v
         GNle1miPm8Vfnh4QqLWbcSoTy7tlvTRegcELjAyhj6saqncOWwz8EaLT4Vu/wh6HSfT7
         VPcUdS+D2subG/RWWIPA2SlvvOAwF6/0qKDg6vpJm0sFAvkSq+KrwmaDFbQvJ5chDwut
         MURg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706251710; x=1706856510;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JNHD+3z25x3Yy/MYa/15U00Na0XAPZfDaLJkbBIFeyU=;
        b=g8jlnWMUTnWXlfxkAwSj9e2axnMopk/aRRG6g6jpXqDGZx3lHSfcWjJamC4VK31aMC
         rX2lBXlGHXf7bKkA25EPqKF9jXl+8eeThzoJ4uZCDr/5R64Tl2MB156nysKH3p8keYAQ
         0wh4woWy5mccddqERUUmIdO9HrOgXLrzfrA6/maKnFqjx7pL+Tv3HABIUJUGBR5S0HfR
         Tf9NejkQxJzcrTb7S+3xSo0nNPI5el/SCNVTb+EbH4VhZ5CwZZqBkC/XipyBgz5aNDFW
         ji7AynDvqw6D4c9kMYMpgSmqL9KIpd+YvdrcspX2RLdK/qKQTgBV5HS7gE0zzJAX9xou
         Hj3w==
X-Gm-Message-State: AOJu0YyNtzhnEOgYqCQklRoCwjVNwR8+a679B81g7Lx4qQeNj+qJdDZU
	Un4qnXvuDrx7cIQCTrvakLIilc8fjAjGCe5KPZ+j+UBsx0BogUxJgE6vXeUiPK9MoO7zj+knTuR
	Ux2o=
X-Google-Smtp-Source: AGHT+IGNyiIZtaMC2KI5gk/r5NPy3pAtcvL8J7mVW6OPQeJqCuki1KUNCak+JIVT3FTVjtj7sInhWQ==
X-Received: by 2002:a05:6a20:2593:b0:19a:49fc:5d98 with SMTP id k19-20020a056a20259300b0019a49fc5d98mr1064776pzd.68.1706251710057;
        Thu, 25 Jan 2024 22:48:30 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id b11-20020a056a000ccb00b006daca8ecb85sm511034pfv.139.2024.01.25.22.48.29
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 22:48:29 -0800 (PST)
Message-ID: <65b355bd.050a0220.35abf.152e@mx.google.com>
Date: Thu, 25 Jan 2024 22:48:29 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-4.19.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v4.19.304-cip106-176-g770d0422c72e9
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc ltp-timers: 11 runs,
 1 regressions (v4.19.304-cip106-176-g770d0422c72e9)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 26 Jan 2024 06:48:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14466

cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc ltp-timers: 11 runs, 1 regressio=
ns (v4.19.304-cip106-176-g770d0422c72e9)

Regressions Summary
-------------------

platform                 | arch   | lab           | compiler | defconfig   =
               | regressions
-------------------------+--------+---------------+----------+-------------=
---------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
nfig+x86-board | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-4.19.y-cip-rc/kernel/v4.19.304-cip106-176-g770d0422c72e9/plan/ltp-ti=
mers/

  Test:     ltp-timers
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-4.19.y-cip-rc
  Describe: v4.19.304-cip106-176-g770d0422c72e9
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      770d0422c72e9acab17684ec2bbff7bc9a09b1a4

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


  Details:     https://kernelci.org/test/plan/id/65b3487ff438009aec52a40c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.304-cip106-176-g770d0422c72e9/x86_64/x86_64_defconfig+x8=
6-board/gcc-10/lab-collabora/ltp-timers-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.304-cip106-176-g770d0422c72e9/x86_64/x86_64_defconfig+x8=
6-board/gcc-10/lab-collabora/ltp-timers-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/amd64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/65b3487ff438009aec5=
2a40d
        failing since 17 days (last pass: v4.19.299-cip105-158-g856c181dce3=
42, first fail: v4.19.299-cip105-289-gad0914f265af) =

 =20

