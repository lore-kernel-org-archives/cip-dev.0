Return-Path: <arisu.tachibana@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD369C76196
	for <webhook@archiver.kernel.org>; Thu,  6 Apr 2023 10:54:54 +0000 (UTC)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
 by mx.groups.io with SMTP id smtpd.web11.155388.1680778490484010509
 for <cip-dev@lists.cip-project.org>;
 Thu, 06 Apr 2023 03:54:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20210112.gappssmtp.com header.s=20210112 header.b=IXhK6Gl7;
 spf=pass (domain: miraclelinux.com, ip: 209.85.167.51, mailfrom: arisu.tachibana@miraclelinux.com)
Received: by mail-lf1-f51.google.com with SMTP id y15so50261946lfa.7
        for <cip-dev@lists.cip-project.org>; Thu, 06 Apr 2023 03:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20210112.gappssmtp.com; s=20210112; t=1680778489;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Q2VY67yYRXBZ9yHaitQDAklqASvY3+jFoowIuHIPpIo=;
        b=IXhK6Gl7Oy97SMtEM/AFOi4r5PbqDgOOn9DqK0bi6AJumPhg826AZtYlNURfpjDStQ
         4ilId/gqDO1Wu9Tk92aPjAMH7m2aiKqECRTChjwm16PtuWtRfqh9GkGhaE3J4S/O0coI
         g1rvuy/8wPUOl+455D/2PpD33V9NYtzQpE5z9D5wRMyqVao4BFsjWz3MF13YPeaEi3W5
         01wNxZcZeshjwSKeO66h9i1hGiLU0b1XOrq0J5F7VEk7AyT5G4zoRjPkM9zvR36K9AlI
         sy9mfc8tHqYYIZRL8kUw+THwz4y5TyWPbcRHHIaDTAIwH+aeSGtQRlVkgL9VPrhqwKTL
         UkQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680778489;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q2VY67yYRXBZ9yHaitQDAklqASvY3+jFoowIuHIPpIo=;
        b=IjVoEc7Q8LjioRi7uekmuB5QSV//W1qw2x7Vs9AWgJZEYTDcrO4+II+QnGqE+BtyPh
         H6LgGAYlJz5ijB0VEk2ilpVBTo5kf0RolgzaXaXPeUfnCH3FoptWoYJ9cX0LVToA/5sS
         sWyMMF7NEt8kJvZcPqZcKwAuD9iNIeN5gimrcIkh3r1eo4NEmuxGLno6QKIIcSjNqKht
         YyrXzm93QTIwtu6gSWWBPsn5fbJ7xobw/fft6glkvGhNJ26kPH76IJOVYScuwUSepJga
         BQcv8ASULpBVCQL1fkw5CYAEx5cZ+XWUAY2hNcwgw42XDU7k/xxoHC4SNlLESy+G1HbP
         81dQ==
X-Gm-Message-State: AAQBX9csVWuIUfbtmi47vuHtnFJv0cFhrrqLnpUHxoe3BYRCdXzhSsQC
	PnR5LIxVwDYeY+qdfHkg+cgzR9JPqp5zclIIwEfzCkZzbCGOemC5SQ==
X-Google-Smtp-Source: AKy350bj8ofQBTHPl1nLj21v5GLy6qCt6Rgw9KZFPxgXeeZpgoPZ0m+fHo9KXjwhA9b/R1zCNXP8h+aJoDWmLhasRww=
X-Received: by 2002:ac2:522c:0:b0:4ea:2dce:fa0a with SMTP id
 i12-20020ac2522c000000b004ea2dcefa0amr2981958lfl.10.1680778488387; Thu, 06
 Apr 2023 03:54:48 -0700 (PDT)
MIME-Version: 1.0
From: Arisu Tachibana <arisu.tachibana@miraclelinux.com>
Date: Thu, 6 Apr 2023 19:53:56 +0900
Message-ID: <CANgtXuPOyqXGzeoFMRTyQ63zFrFJL8nDc=DE+JEJ2E3ARF_3GQ@mail.gmail.com>
Subject: isar-cip-core distribution versions
To: cip-dev@lists.cip-project.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 06 Apr 2023 10:54:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11188

hello everyone,

the update to a recent version of isar-cip-core on KernelCI is
currently in progress by the following pull request:
https://github.com/kernelci/kernelci-core/pull/1656

While updating the pull request I noticed that in the current
isar-cip-core version,
we have changed the distribution from buster to bullseye.
Do we still need the buster version together with bullseye or we can
drop buster?
any opinion on this?

Thanks,
Arisu Tachibana

