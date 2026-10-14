Return-Path: <yoshitake.kobayashi.x25@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 004EBCC6B1A
	for <webhook@archiver.kernel.org>; Wed, 14 Oct 2026 08:26:29 +0000 (UTC)
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.4903.1791945390545187804
 for <cip-dev@lists.cip-project.org>;
 Tue, 13 Oct 2026 19:36:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci.org header.s=google header.b=MQrLvTiA;
 spf=pass (domain: kernelci.org, ip: 209.85.160.170, mailfrom: bot@kernelci.org)
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-533930955a4so33737491cf.3
        for <cip-dev@lists.cip-project.org>; Tue, 13 Oct 2026 19:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1791945389; x=1792550189; darn=lists.cip-project.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=1A2R1Un51ic6oqrctQLul5binydaZn1WOt8sPDZWmE8=;
        b=MQrLvTiAMgCG6xSi48xP804dq7zZvjOZymqjT7hyuLVT/06FkIkw9G3m03oGgpSIPV
         hpv6veiGjP6hn3GqnyRptcTMAQatVZ7mBGAwPTC+OVpVyRGb+KBEOOJa7L/J7PJKTubq
         gxbQnQwNr09JCV8DO6ROVtAui0owvNWZwNDTY4jsZAwQp3J6HUQomjZ+x3aWPus2p62U
         EEYsKbkeCQxgv+0rg8/0QzO7b+tYe27CJjyIW4bHP1EA7XUyZbAGNHTgqk/+e4qC5T4+
         /f+hwKm0qt7M1VIE1Srvl3h9gVEHA48t1BfCi7YzpwRSHRcfBm7ZumM0nUOBA9r8BJIY
         fOCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791945389; x=1792550189;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1A2R1Un51ic6oqrctQLul5binydaZn1WOt8sPDZWmE8=;
        b=Y4hyK0RiBj04tfm+pY0zMgZS3VOND1c/30cpj/KtQN/8cURnkEhxW4t9bZxt8ZdVB0
         cBQIFy4fzpbyL05l6P27pNLgUds4zQyNPms3m/MIaEYH+HTkW4LfdvPN1X8h5l7/esgL
         XJ+ulzSueQMHW8ymnOjU1DgM9F9Ve/XWW7b8bAWjUuE+zMcVhZy07PEHii7LH7ALWTCK
         B+nm3Xi0Bd3U9IITaSJGMfak51Avr7sohvK31/h1J9U8WKa4i0Ez94yzSQRN7YOoIi2L
         LNbNlVDX0+9soL8pA7iom5KlRDdFb/GerdxZR0OIzgExCvaDeLDboGF2aDX+UD5qE7MW
         ueLg==
X-Gm-Message-State: AFq9FYK4A58fGXjti8UziGkzg3QR8Xd38Rjk4Da07Xs6iQ2KhoC/j1dR
	8OFkuY20igntU1lOlLncQUoAZQySBWcKUKgDAXHX85nHMpcvXbHgcZYR44VuA0bFEgZ3p3diNv6
	zuqui
X-Gm-Gg: AYBFou29txR3NLi0MihM9NZTBx+ShUtEPnWTRPRAwo3ctjFWnrs9pxVwMbBN0eLl5e2
	KmOI1FIdWdswgg//6uitxyYwYgLthw/RIkeHca54xuebUYUKTObI9GA6P6/zjezBlU1Llskg1PZ
	GeTgWxrnoy14ej189SNJmzxvAO83pCLT9zuhxzjVR8cwVm9n+43f2DlGzgP4nXsrDFDzadsZZ3A
	ZTjxJJbqsoAlMi4rESDD4rTg1MYsutF/7DjIQKPIZgHnF1/rdnP7iyqsork7Fds7Paw/pcYNI/o
	lofDhuxRrAYJdmQuksNzS88Wv2dtI4VO+lXtM5y9OBcIn694jEXotXgvPU1m/QOaa+KkGiVgZ4z
	55JpHdarHVi3E+O6NbPPOSfbQe8q+fwZI905I6qOjyZslYIwsFHYXH06U1Fvq3QLmLlMLwiOdfR
	+6k+4ye96f1yGVK6Eq7cf9qyt37LdQ2dclXXU+2ciHclP8W/lwT/RzuUZtIOdTwNc=
X-Received: by 2002:a05:701b:2717:b0:16d:dd5c:4261 with SMTP id a92af1059eb24-16ddd5c42a5mr18795782c88.46.1791945006167;
        Tue, 13 Oct 2026 19:30:06 -0700 (PDT)
Received: from 244668f92ec4 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-169a620bdafsm55076757c88.23.2026.10.13.19.30.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 19:30:05 -0700 (PDT)
MIME-Version: 1.0
Subject: [STATUS] cip/linux-5.10.y-cip - 0102f22d463079b2be8a559a220000399c41fbe0
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: cip-dev@lists.cip-project.org
Reply-To: kernelci@lists.linux.dev
Date: Wed, 14 Oct 2026 02:30:05 -0000
Message-ID: <179194500497.288311.7084278902179533376@244668f92ec4>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 14 Oct 2026 08:26:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24456



Hello,

Status summary for cip/linux-5.10.y-cip

Dashboard:
https://d.kernelci.org/c/cip/linux-5.10.y-cip/0102f22d463079b2be8a559a220000399c41fbe0/

giturl: https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
branch: linux-5.10.y-cip
commit hash: 0102f22d463079b2be8a559a220000399c41fbe0
origin: maestro
test start time: 2026-10-13 05:10:25.935000+00:00

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

