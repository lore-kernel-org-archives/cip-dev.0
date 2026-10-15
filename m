Return-Path: <yoshitake.kobayashi.x25@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00782CC6B2D
	for <webhook@archiver.kernel.org>; Thu, 15 Oct 2026 02:59:48 +0000 (UTC)
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.30914.1792031426676739681
 for <cip-dev@lists.cip-project.org>;
 Wed, 14 Oct 2026 19:30:26 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci.org header.s=google header.b=caRPhwAD;
 spf=pass (domain: kernelci.org, ip: 74.125.82.179, mailfrom: bot@kernelci.org)
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-35c76e9614aso2973374eec.0
        for <cip-dev@lists.cip-project.org>; Wed, 14 Oct 2026 19:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1792031426; x=1792636226; darn=lists.cip-project.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=yN1wMfIXWs+TuyK6FFlPh/iK5aHuEurYYxlBcjquIoA=;
        b=caRPhwADIQMADt0jWwtItwUB0zW15eqUKEnK1nX8/5yHERdRLDPmv7BMpGHoQ35voM
         LnUF01BFVzDl4pX59yggZ3ymINookaK0K6E44J0ZO8nzbQeB+lNxQcX1gWatg5bjoyus
         Mu9yySYL5/14Vwr3fOGVG4pLzl2l9obB9DDNTL/zOsJfthubXwXuxS8h0gorM9eZYbap
         SXlgT+IKjd4A143uIq+fjF7TLXaG7THPdhCh/v6sfPjD8XbGqU/Wv/NMYAUBGIatT43y
         he59Ifl0FJQXWfqotY8Nfhm/+0dl3l3s9/92KiTAAHiBXrbuyr1+TFL5iQpKjTSbOOeY
         54Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792031426; x=1792636226;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yN1wMfIXWs+TuyK6FFlPh/iK5aHuEurYYxlBcjquIoA=;
        b=hKlfgYvjqvQLAmrzIJKAY1+VMPPxANCWVJmFWtTwQnjM9lcDOQFZsFy6+JQe6ndfpw
         snXEcuXDB1HUdIdWvS+YqJIinLuPwATHpD36kydmXKQubWHgFOczrLF6YIlLna2MqmEz
         4b1wOywtAUgVk3Sge3KSYmW/ZOya5XVPIllr1KgfHVmxHSoS05p2n1oST8PDXrGZge4Y
         kFAmuaKXdxWr8XGiqBBdJvHxnAfHIM6Dz34gpKOqmMfl5VnrwhdN4UVaICvQC2KAWpE+
         bzNGpNsoCBjFu7YoPkc8loY+q0iH7wHZWy8hV6cF5tNqe50Vi/Mv78yoW2M6dxMqwGEw
         Ll+Q==
X-Gm-Message-State: AFq9FYIippvlXyDn5ORYKr9KqlEmOLStUmgXuCtKJa2pG6xCq4oIiuw8
	U9aCE8WOKNHJBuNLHWHgjSetJlJl76eVw27lCBSNEoxtryG3W/ttWujD864WN9Cerco=
X-Gm-Gg: AYBFou0by+tgqsWU4rmR1maUPf8m+KWGQxWKWEpR8Gf+PpRjcMzKpS/DE8Ch438YkoQ
	Lk+MFDA+6xGKoFeXpi7z383J5wiCTmp9HzQ7pe6Bcy/hVhxBdpTlTL3ivvd0TQvselWvT2JBkuz
	7VRzNlquvCkC2DCGrx2zIF6L4IlC/9Joed9IQc3FWHH0t9bgQUUlrbXVont5dhWxDa/G0tgoQqC
	zTyvpdd7b2wF5XTw/3lVp2icytbF6jb5eBBLuX7m7m80++lE36bRsM6V9iBvATE4OXhMCL1zCnp
	A9AxCINibVcVminfNUGTA009ptFqEsmzEFtxjTc13oTCmh7d3fWTJgofHBdVX/p5lB9AFHlQi4M
	VMdjN9i++aA7OPauFptNsa3ES3Y1KsgckRTMrZgGV9ev87NOoMPpdnTpPVXxjZPjb3eIE+sJ90t
	+H/D2iCW1STMrUWPAwlMo0vV7DJhU5Qfv80Ubs+JjkfqcXuVTbY2WszHBee3WXUUM=
X-Received: by 2002:a05:7300:da18:b0:35e:43fa:eea3 with SMTP id 5a478bee46e88-35e43faf321mr3449683eec.8.1792031424416;
        Wed, 14 Oct 2026 19:30:24 -0700 (PDT)
Received: from 244668f92ec4 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-35d872762a3sm12285851eec.22.2026.10.14.19.30.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 19:30:23 -0700 (PDT)
MIME-Version: 1.0
Subject: [STATUS] cip/linux-6.1.y-cip - ae2e5e1c152300e768185f2cb1dc6725eebb186c
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: cip-dev@lists.cip-project.org
Reply-To: kernelci@lists.linux.dev
Date: Thu, 15 Oct 2026 02:30:23 -0000
Message-ID: <179203142359.339645.11329688138395917257@244668f92ec4>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 15 Oct 2026 02:59:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24465



Hello,

Status summary for cip/linux-6.1.y-cip

Dashboard:
https://d.kernelci.org/c/cip/linux-6.1.y-cip/ae2e5e1c152300e768185f2cb1dc6725eebb186c/

giturl: https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
branch: linux-6.1.y-cip
commit hash: ae2e5e1c152300e768185f2cb1dc6725eebb186c
origin: maestro
test start time: 2026-10-14 11:21:19.743000+00:00

Builds:	    4 ✅    0 ❌    0 ⚠️
Boots: 	    6 ✅    0 ❌    0 ⚠️
Tests: 	    0 ✅    0 ❌    0 ⚠️

### POSSIBLE REGRESSIONS

  No possible regressions observed.


### FIXED REGRESSIONS

  No fixed regressions observed.


### UNSTABLE TESTS

  No unstable tests observed.


Sent every day if there were changes in the past 24 hours.
Legend: ✅ PASS   ❌ FAIL  ⚠️ INCONCLUSIVE

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

